/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AreaDefines.h"
#include "ArenaSpectator.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "CellImpl.h"
#include "Chat.h"
#include "Corpse.h"
#include "GameGraveyard.h"
#include "GameTime.h"
#include "InstanceSaveMgr.h"
#include "Log.h"
#include "MapMgr.h"
#include "MathUtil.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "Transport.h"
#include "Vehicle.h"
#include "WaypointMovementGenerator.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#define MOVEMENT_PACKET_TIME_DELAY 0

void WorldSession::HandleMoveWorldportAckOpcode(WorldPacket& /*recvData*/)
{
    LOG_DEBUG("network", "WORLD: got MSG_MOVE_WORLDPORT_ACK.");
    HandleMoveWorldportAck();
}

void WorldSession::HandleMoveWorldportAck()
{
    // ignore unexpected far teleports
    if (!GetPlayer()->IsBeingTeleportedFar())
        return;

    GetPlayer()->SetSemaphoreTeleportFar(0);

    // get the teleport destination
    WorldLocation const& loc = GetPlayer()->GetTeleportDest();

    // possible errors in the coordinate validity check
    if (!MapMgr::IsValidMapCoord(loc))
    {
        KickPlayer("!MapMgr::IsValidMapCoord(loc)");
        return;
    }

    // get the destination map entry, not the current one, this will fix homebind and reset greeting
    MapEntry const* mEntry = sMapStore.LookupEntry(loc.GetMapId());
    InstanceTemplate const* mInstance = sObjectMgr->GetInstanceTemplate(loc.GetMapId());

    Map* oldMap = GetPlayer()->GetMap();
    if (GetPlayer()->IsInWorld())
    {
        LOG_ERROR("network.opcode", "Player (Name {}) is still in world when teleported from map {} to new map {}", GetPlayer()->GetName(), oldMap->GetId(), loc.GetMapId());
        oldMap->RemovePlayerFromMap(GetPlayer(), false);
    }

    // reset instance validity, except if going to an instance inside an instance
    if (!GetPlayer()->m_InstanceValid && !mInstance)
    {
        GetPlayer()->m_InstanceValid = true;
        // pussywizard: m_InstanceValid can be false only by leaving a group in an instance => so remove temp binds that could not be removed because player was still on the map!
        if (!sInstanceSaveMgr->PlayerIsPermBoundToInstance(GetPlayer()->GetGUID(), oldMap->GetId(), oldMap->GetDifficulty()))
            sInstanceSaveMgr->PlayerUnbindInstance(GetPlayer()->GetGUID(), oldMap->GetId(), oldMap->GetDifficulty(), true);
    }

    // relocate the player to the teleport destination
    Map* newMap = sMapMgr->CreateMap(loc.GetMapId(), GetPlayer());
    // the CanEnter checks are done in TeleporTo but conditions may change
    // while the player is in transit, for example the map may get full
    if (!newMap || newMap->CannotEnter(GetPlayer(), false))
    {
        LOG_ERROR("network.opcode", "Map {} could not be created for player {}, porting player to homebind", loc.GetMapId(), GetPlayer()->GetGUID().ToString());
        GetPlayer()->TeleportTo(GetPlayer()->m_homebindMapId, GetPlayer()->m_homebindX, GetPlayer()->m_homebindY, GetPlayer()->m_homebindZ, GetPlayer()->GetOrientation());
        return;
    }

    float z = loc.GetPositionZ() + GetPlayer()->GetHoverHeight();
    GetPlayer()->Relocate(loc.GetPositionX(), loc.GetPositionY(), z, loc.GetOrientation());

    GetPlayer()->ResetMap();
    GetPlayer()->SetMap(newMap);

    GetPlayer()->UpdatePositionData();

    GetPlayer()->SendInitialPacketsBeforeAddToMap();

    if (GetPlayer()->GetPendingFlightChange() <= GetPlayer()->GetMapChangeOrderCounter())
    {
        if (!GetPlayer()->HasIncreaseMountedFlightSpeedAura() && !GetPlayer()->HasFlyAura())
            GetPlayer()->m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_CAN_FLY);
    }

    if (!GetPlayer()->GetMap()->AddPlayerToMap(GetPlayer()))
    {
        LOG_ERROR("network.opcode", "WORLD: failed to teleport player {} ({}) to map {} because of unknown reason!",
            GetPlayer()->GetName(), GetPlayer()->GetGUID().ToString(), loc.GetMapId());
        GetPlayer()->ResetMap();
        GetPlayer()->SetMap(oldMap);
        GetPlayer()->TeleportTo(GetPlayer()->m_homebindMapId, GetPlayer()->m_homebindX, GetPlayer()->m_homebindY, GetPlayer()->m_homebindZ, GetPlayer()->GetOrientation());
        return;
    }

    oldMap->AfterPlayerUnlinkFromMap();

    // pussywizard: transport teleport couldn't teleport us to the same map (some other teleport pending, reqs not met, etc.), but we still have transport set until player moves! clear it if map differs (crashfix)
    if (Transport* t = _player->GetTransport())
        if (!t->IsInMap(_player))
        {
            t->RemovePassenger(_player);
            _player->m_transport = nullptr;
            _player->m_movementInfo.transport.Reset();
            _player->m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
        }

    if (!_player->getHostileRefMgr().IsEmpty())
        _player->getHostileRefMgr().deleteReferences(true); // pussywizard: multithreading crashfix

    CellCoord pair(Acore::ComputeCellCoord(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY()));
    Cell cell(pair);
    if (!GridCoord(cell.GridX(), cell.GridY()).IsCoordValid())
    {
        KickPlayer("!GridCoord(cell.GridX(), cell.GridY()).IsCoordValid()");
        return;
    }
    newMap->LoadGrid(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY());

    // pussywizard: player supposed to enter bg map
    if (_player->InBattleground())
    {
        // but landed on another map, cleanup data
        if (!mEntry->IsBattlegroundOrArena())
            _player->SetBattlegroundId(0, BATTLEGROUND_TYPE_NONE, PLAYER_MAX_BATTLEGROUND_QUEUES, false, false, TEAM_NEUTRAL);
        // everything ok
        else if (Battleground* bg = _player->GetBattleground())
        {
            if (_player->IsInvitedForBattlegroundInstance()) // GMs are not invited, so they are not added to participants
                bg->AddPlayer(_player);
        }
    }

    // pussywizard: arena spectator stuff
    {
        if (newMap->IsBattleArena() && ((BattlegroundMap*)newMap)->GetBG() && _player->HasPendingSpectatorForBG(((BattlegroundMap*)newMap)->GetInstanceId()))
        {
            _player->ClearReceivedSpectatorResetFor();
            _player->SetIsSpectator(true);
            ArenaSpectator::SendCommand(_player, "%sENABLE", SPECTATOR_ADDON_PREFIX);
            ((BattlegroundMap*)newMap)->GetBG()->AddSpectator(_player);
            ArenaSpectator::HandleResetCommand(_player);
        }
        else
            _player->SetIsSpectator(false);

        GetPlayer()->SetPendingSpectatorForBG(0);

        if (uint32 inviteInstanceId = _player->GetPendingSpectatorInviteInstanceId())
        {
            if (Battleground* tbg = sBattlegroundMgr->GetBattleground(inviteInstanceId, BATTLEGROUND_TYPE_NONE))
                tbg->RemoveToBeTeleported(_player->GetGUID());
            _player->SetPendingSpectatorInviteInstanceId(0);
        }
    }

    // xinef: do this again, player can be teleported inside bg->AddPlayer(_player)!!!!
    CellCoord pair2(Acore::ComputeCellCoord(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY()));
    Cell cell2(pair2);
    if (!GridCoord(cell2.GridX(), cell2.GridY()).IsCoordValid())
    {
        KickPlayer("!GridCoord(cell2.GridX(), cell2.GridY()).IsCoordValid()");
        return;
    }
    newMap->LoadGrid(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY());

    GetPlayer()->SendInitialPacketsAfterAddToMap();

    // flight fast teleport case
    if (GetPlayer()->IsInFlight())
    {
        if (!GetPlayer()->InBattleground())
        {
            // short preparations to continue flight
            MovementGenerator* movementGenerator = GetPlayer()->GetMotionMaster()->top();
            movementGenerator->Initialize(GetPlayer());
            return;
        }

        // battleground state prepare, stop flight
        GetPlayer()->GetMotionMaster()->MovementExpired();
        GetPlayer()->CleanupAfterTaxiFlight();
    }

    // resurrect character at enter into instance where his corpse exist after add to map
    Corpse* corpse = GetPlayer()->GetMap()->GetCorpseByPlayer(GetPlayer()->GetGUID());
    if (corpse && corpse->GetType() != CORPSE_BONES)
    {
        if (mEntry->IsDungeon())
        {
            GetPlayer()->ResurrectPlayer(0.5f);
            GetPlayer()->SpawnCorpseBones();
        }
    }

    if (!corpse && mEntry->IsDungeon())
    {
        // resurrect character upon entering instance when the corpse is not available anymore
        if (GetPlayer()->GetCorpseLocation().GetMapId() == mEntry->MapID)
        {
            GetPlayer()->ResurrectPlayer(0.5f);
            GetPlayer()->RemoveCorpse();
        }
    }

    bool allowMount = !mEntry->IsDungeon() || mEntry->IsBattlegroundOrArena();
    if (mInstance)
    {
        Difficulty diff = GetPlayer()->GetDifficulty(mEntry->IsRaid());
        if (MapDifficulty const* mapDiff = GetMapDifficultyData(mEntry->MapID, diff))
            if (mapDiff->resetTime)
                if (time_t timeReset = sInstanceSaveMgr->GetResetTimeFor(mEntry->MapID, diff))
                {
                    uint32 timeleft = uint32(timeReset - GameTime::GetGameTime().count());
                    GetPlayer()->SendInstanceResetWarning(mEntry->MapID, diff, timeleft, true);
                }
        allowMount = mInstance->AllowMount;
    }

    // mount allow check
    if (!allowMount)
        _player->RemoveAurasByType(SPELL_AURA_MOUNTED);

    // update zone immediately, otherwise leave channel will cause crash in mtmap
    uint32 newzone, newarea;
    GetPlayer()->GetZoneAndAreaId(newzone, newarea);
    GetPlayer()->UpdateZone(newzone, newarea);

    // honorless target
    if (GetPlayer()->pvpInfo.IsHostile)
        GetPlayer()->CastSpell(GetPlayer(), 2479, true);

    // in friendly area
    else if (GetPlayer()->IsPvP() && !GetPlayer()->HasPlayerFlag(PLAYER_FLAGS_IN_PVP))
        GetPlayer()->UpdatePvP(false, false);

    // resummon pet
    GetPlayer()->ResummonPetTemporaryUnSummonedIfAny();

    //lets process all delayed operations on successful teleport
    GetPlayer()->ProcessDelayedOperations();
}

void WorldSession::HandleMoveTeleportAck(WorldPacket& recvData)
{
    LOG_DEBUG("network", "MSG_MOVE_TELEPORT_ACK");

    ObjectGuid guid;
    recvData >> guid.ReadAsPacked();

    uint32 flags, time;
    recvData >> flags >> time; // unused
    LOG_DEBUG("network.opcode", "Guid {}", guid.ToString());
    LOG_DEBUG("network.opcode", "Flags {}, time {}", flags, time / IN_MILLISECONDS);

    Player* plMover = _player->m_mover->ToPlayer();

    if (!plMover || !plMover->IsBeingTeleportedNear())
        return;

    if (guid != plMover->GetGUID())
        return;

    plMover->SetSemaphoreTeleportNear(0);

    uint32 old_zone = plMover->GetZoneId();

    WorldLocation const& dest = plMover->GetTeleportDest();
    Position oldPos(*plMover);

    plMover->UpdatePosition(dest, true);

    plMover->SetFallInformation(GameTime::GetGameTime().count(), dest.GetPositionZ());

    // xinef: teleport pets if they are not unsummoned
    if (Pet* pet = plMover->GetPet())
    {
        if (!pet->IsWithinDist3d(plMover, plMover->GetMap()->GetVisibilityRange() - 5.0f))
            pet->NearTeleportTo(plMover->GetPositionX(), plMover->GetPositionY(), plMover->GetPositionZ(), pet->GetOrientation());
    }

    if (oldPos.GetExactDist2d(plMover) > 100.0f)
    {
        uint32 newzone, newarea;
        plMover->GetZoneAndAreaId(newzone, newarea);
        plMover->UpdateZone(newzone, newarea);

        // new zone
        if (old_zone != newzone)
        {
            // honorless target
            if (plMover->pvpInfo.IsHostile)
                plMover->CastSpell(plMover, 2479, true);

            // in friendly area
            else if (plMover->IsPvP() && !plMover->HasPlayerFlag(PLAYER_FLAGS_IN_PVP))
                plMover->UpdatePvP(false, false);
        }
    }

    // resummon pet
    GetPlayer()->ResummonPetTemporaryUnSummonedIfAny();

    //lets process all delayed operations on successful teleport
    GetPlayer()->ProcessDelayedOperations();

    plMover->GetMotionMaster()->ReinitializeMovement();

    // pussywizard: client forgets about losing control, resend it
    if (plMover->HasUnitState(UNIT_STATE_FLEEING | UNIT_STATE_CONFUSED) || plMover->IsCharmed()) // only in such cases SetClientControl(self, false) is sent
        plMover->SetClientControl(plMover, false, true);
}

void WorldSession::HandleMovementOpcodes(WorldPacket& recvData)
{
    uint16 opcode = recvData.GetOpcode();

    Unit* mover = _player->m_mover;

    ASSERT(mover);                      // there must always be a mover

    Player* plrMover = mover->ToPlayer();

    // ignore, waiting processing in WorldSession::HandleMoveWorldportAckOpcode and WorldSession::HandleMoveTeleportAck
    if (plrMover && plrMover->IsBeingTeleported())
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    /* extract packet */
    ObjectGuid guid;
    recvData >> guid.ReadAsPacked();

    // prevent tampered movement data
    if (!guid || guid != mover->GetGUID())
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    // pussywizard: typical check for incomming movement packets | prevent tampered movement data
    if (!mover || !(mover->IsInWorld()) || mover->IsDuringRemoveFromWorld() || guid != mover->GetGUID())
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    if (!ProcessMovementInfo(movementInfo, mover, plrMover, recvData))
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    if (opcode == CMSG_MOVE_FALL_RESET || opcode == CMSG_MOVE_CHNG_TRANSPORT)
        return;

    /* process position-change */
    WorldPacket data(opcode, recvData.size());
    WriteMovementInfo(&data, &movementInfo);
    mover->SendMessageToSet(&data, _player);
}

void WorldSession::SynchronizeMovement(MovementInfo& movementInfo)
{
    int64 movementTime = (int64)movementInfo.time + _timeSyncClockDelta;
    if (_timeSyncClockDelta == 0 || movementTime < 0 || movementTime > 0xFFFFFFFF)
    {
        LOG_INFO("misc", "The computed movement time using clockDelta is erronous. Using fallback instead");
        movementInfo.time = getMSTime();
    }
    else
    {
        movementInfo.time = (uint32)movementTime;
    }
}

void WorldSession::HandleMoverRelocation(MovementInfo& movementInfo, Unit* mover)
{
    SynchronizeMovement(movementInfo);

    mover->UpdatePosition(movementInfo.pos);
    mover->m_movementInfo = movementInfo;

    if (mover->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
    {
        // if we boarded a transport, add us to it (generalized for both players and creatures)
        if (!mover->GetTransport())
        {
            if (Transport* transport = mover->GetMap()->GetTransport(movementInfo.transport.guid))
            {
                mover->SetTransport(transport);
                transport->AddPassenger(mover);
            }
        }
        else if (mover->GetTransport()->GetGUID() != movementInfo.transport.guid)
        {
            // Switching transports
            bool foundNewTransport = false;
            mover->GetTransport()->RemovePassenger(mover);
            if (Transport* transport = mover->GetMap()->GetTransport(movementInfo.transport.guid))
            {
                foundNewTransport = true;
                mover->SetTransport(transport);
                transport->AddPassenger(mover);
            }

            if (!foundNewTransport)
            {
                mover->SetTransport(nullptr);
                movementInfo.transport.Reset();
            }
        }

        if (!mover->GetTransport() && !mover->GetVehicle())
        {
            GameObject* go = mover->GetMap()->GetGameObject(movementInfo.transport.guid);
            if (!go || go->GetGoType() != GAMEOBJECT_TYPE_TRANSPORT)
                movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
        }
    }
    else
    {
        // if we were on a transport, leave (handles both players and creatures)
        if (Transport* transport = mover->GetTransport())
        {
            if (mover->IsPlayer())
                sScriptMgr->AnticheatSetUnderACKmount(mover->ToPlayer()); // just for safe

            transport->RemovePassenger(mover);
            mover->SetTransport(nullptr);
            movementInfo.transport.Reset();
        }
    }

    // Some vehicles allow the passenger to turn by himself
    if (Vehicle* vehicle = mover->GetVehicle())
    {
        if (VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(mover))
        {
            if (seat->m_flags & VEHICLE_SEAT_FLAG_ALLOW_TURNING && movementInfo.pos.GetOrientation() != mover->GetOrientation())
            {
                mover->SetOrientation(movementInfo.pos.GetOrientation());
                mover->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TURNING);
            }
        }
    }

    if (Player* plrMover = mover->ToPlayer()) // nothing is charmed, or player charmed
    {
        if (plrMover->IsSitState() && (movementInfo.flags & (MOVEMENTFLAG_MASK_MOVING | MOVEMENTFLAG_MASK_TURNING)))
            plrMover->SetStandState(UNIT_STAND_STATE_STAND);

        if (movementInfo.pos.GetPositionZ() < plrMover->GetMap()->GetMinHeight(movementInfo.pos.GetPositionX(), movementInfo.pos.GetPositionY()))
        {
            if (!plrMover->GetBattleground() || !plrMover->GetBattleground()->HandlePlayerUnderMap(_player))
            {
                if (plrMover->IsAlive())
                {
                    // The Oculus under map case is handled by areatrigger (5001) and should not kill the player
                    if (plrMover->GetMapId() == MAP_THE_OCULUS)
                        return;

                    plrMover->SetPlayerFlag(PLAYER_FLAGS_IS_OUT_OF_BOUNDS);
                    plrMover->EnvironmentalDamage(DAMAGE_FALL_TO_VOID, GetPlayer()->GetMaxHealth());
                    // player can be alive if GM
                    if (plrMover->IsAlive())
                        plrMover->KillPlayer();
                }
                else if (!plrMover->HasPlayerFlag(PLAYER_FLAGS_IS_OUT_OF_BOUNDS))
                {
                    GraveyardStruct const* grave = sGraveyard->GetClosestGraveyard(plrMover, plrMover->GetTeamId());
                    if (grave)
                    {
                        plrMover->TeleportTo(grave->Map, grave->x, grave->y, grave->z, plrMover->GetOrientation());
                        plrMover->Relocate(grave->x, grave->y, grave->z, plrMover->GetOrientation());
                    }
                }
            }
        }
    }
}

bool WorldSession::VerifyMovementInfo(MovementInfo const& movementInfo, Player* plrMover, Unit* mover, Opcodes opcode) const
{
    if (!movementInfo.pos.IsPositionValid())
    {
        if (plrMover)
        {
            sScriptMgr->AnticheatUpdateMovementInfo(plrMover, movementInfo);
        }

        return false;
    }

    if (!mover->movespline->Finalized())
    {
        if (!mover->movespline->isBoarding() || (opcode != CMSG_FORCE_MOVE_UNROOT_ACK && opcode != CMSG_FORCE_MOVE_ROOT_ACK))
            return false;
    }

    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (mover->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
    {
        // Xinef: skip moving packets
        if (movementInfo.HasMovementFlag(MOVEMENTFLAG_MASK_MOVING))
        {
            if (plrMover)
            {
                sScriptMgr->AnticheatUpdateMovementInfo(plrMover, movementInfo);
            }
            return false;
        }
    }

    bool jumpopcode = false;
    if (opcode == MSG_MOVE_JUMP)
    {
        jumpopcode = true;
        if (plrMover && !sScriptMgr->AnticheatHandleDoubleJump(plrMover, mover))
        {
            plrMover->GetSession()->KickPlayer();
            return false;
        }
    }

    /* start some hack detection */
    if (plrMover && !sScriptMgr->AnticheatCheckMovementInfo(plrMover, movementInfo, mover, jumpopcode))
    {
        plrMover->GetSession()->KickPlayer();
        return false;
    }

    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
    {
        // We were teleported, skip packets that were broadcast before teleport
        if (movementInfo.pos.GetExactDist2d(mover) > SIZE_OF_GRIDS)
        {
            if (plrMover)
            {
                sScriptMgr->AnticheatUpdateMovementInfo(plrMover, movementInfo);
                //LOG_INFO("anticheat", "MovementHandler:: 2 We were teleported, skip packets that were broadcast before teleport");
            }
            return false;
        }

        if (!Acore::IsValidMapCoord(movementInfo.pos.GetPositionX() + movementInfo.transport.pos.GetPositionX(), movementInfo.pos.GetPositionY() + movementInfo.transport.pos.GetPositionY(),
            movementInfo.pos.GetPositionZ() + movementInfo.transport.pos.GetPositionZ(), movementInfo.pos.GetOrientation() + movementInfo.transport.pos.GetOrientation()))
        {
            if (plrMover)
            {
                sScriptMgr->AnticheatUpdateMovementInfo(plrMover, movementInfo);
            }

            return false;
        }
    }

    // rooted mover sent packet without root or moving AND root - ignore, due to client crash possibility
    if (opcode != CMSG_FORCE_MOVE_UNROOT_ACK)
        if (mover->IsRooted() && (!movementInfo.HasMovementFlag(MOVEMENTFLAG_ROOT) || movementInfo.HasMovementFlag(MOVEMENTFLAG_MASK_MOVING)))
            return false;

    return true;
}

bool WorldSession::ProcessMovementInfo(MovementInfo& movementInfo, Unit* mover, Player* plrMover, WorldPacket& recvData)
{
    Opcodes opcode = (Opcodes)recvData.GetOpcode();
    if (!VerifyMovementInfo(movementInfo, plrMover, mover, opcode))
        return false;

    if (mover->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
    {
        movementInfo.pos.Relocate(mover->GetPositionX(), mover->GetPositionY(), mover->GetPositionZ());

        if (mover->IsCreature())
        {
            movementInfo.transport.guid = mover->m_movementInfo.transport.guid;
            movementInfo.transport.pos.Relocate(mover->m_movementInfo.transport.pos.GetPositionX(), mover->m_movementInfo.transport.pos.GetPositionY(), mover->m_movementInfo.transport.pos.GetPositionZ());
            movementInfo.transport.seat = mover->m_movementInfo.transport.seat;
        }
    }

    // fall damage generation (ignore in flight case that can be triggered also at lags in moment teleportation to another map).
    if (opcode == MSG_MOVE_FALL_LAND && plrMover && !plrMover->IsInFlight())
    {
        plrMover->HandleFall(movementInfo);

        sScriptMgr->AnticheatSetJumpingbyOpcode(plrMover, false);
    }

    // interrupt parachutes upon falling or landing in water
    if (opcode == MSG_MOVE_FALL_LAND || opcode == MSG_MOVE_START_SWIM)
    {
        mover->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_LANDING); // Parachutes

        if (plrMover)
        {
            sScriptMgr->AnticheatSetJumpingbyOpcode(plrMover, false);
        }
    }

    if (plrMover && ((movementInfo.flags & MOVEMENTFLAG_SWIMMING) != 0) != plrMover->IsInWater())
    {
        // now client not include swimming flag in case jumping under water
        plrMover->SetInWater(!plrMover->IsInWater() || plrMover->GetMap()->IsUnderWater(plrMover->GetPhaseMask(), movementInfo.pos.GetPositionX(),
            movementInfo.pos.GetPositionY(), movementInfo.pos.GetPositionZ(), plrMover->GetCollisionHeight()));
    }

    if (plrMover)//Hook for OnPlayerMove
    {
        sScriptMgr->OnPlayerMove(plrMover, movementInfo, opcode);
    }

    if (movementInfo.GetMovementFlags() & MOVEMENTFLAG_MASK_MOVING_OR_TURN)
    {
        if (mover->IsStandState())
            mover->SetStandState(UNIT_STAND_STATE_STAND);
        mover->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
    }

    HandleMoverRelocation(movementInfo, mover);

    if (plrMover && opcode != CMSG_MOVE_KNOCK_BACK_ACK)
        plrMover->UpdateFallInformationIfNeed(movementInfo, opcode);

    return true;
}

void WorldSession::HandleForceSpeedChangeAck(WorldPacket& recvData)
{
    uint32 opcode = recvData.GetOpcode();
    LOG_DEBUG("network", "WORLD: Recvd {} ({}, 0x{:X}) opcode", GetOpcodeNameForLogging(static_cast<OpcodeClient>(opcode)), opcode, opcode);

    /* extract packet */
    ObjectGuid guid;
    uint32 counter;
    MovementInfo movementInfo;
    float  newspeed;

    recvData >> guid.ReadAsPacked();
    recvData >> counter;                                   // counter or moveEvent
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);
    recvData >> newspeed;

    Unit* mover = _player->m_mover;

    // pussywizard: special check, only player mover allowed here
    if (guid != mover->GetGUID() || guid != _player->GetGUID())
    {
        recvData.rfinish(); // prevent warnings spam
        return;
    }

    // old map - async processing, ignore
    if (counter <= _player->GetMapChangeOrderCounter())
        return;

    if (!ProcessMovementInfo(movementInfo, mover, _player, recvData))
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    if (opcode == CMSG_MOVE_SET_COLLISION_HGT_ACK)
    {
        WorldPacket data(MSG_MOVE_SET_COLLISION_HGT, 18);
        WriteMovementInfo(&data, &movementInfo);
        data << newspeed; // new collision height
        mover->SendMessageToSet(&data, _player);
        return;
    }

    // client ACK send one packet for mounted/run case and need skip all except last from its
    // in other cases anti-cheat check can be fail in false case
    UnitMoveType move_type;
    UnitMoveType force_move_type;

    static char const* move_type_name[MAX_MOVE_TYPE] = {  "Walk", "Run", "RunBack", "Swim", "SwimBack", "TurnRate", "Flight", "FlightBack", "PitchRate" };

    switch (opcode)
    {
        case CMSG_FORCE_WALK_SPEED_CHANGE_ACK:          move_type = MOVE_WALK;          force_move_type = MOVE_WALK;        break;
        case CMSG_FORCE_RUN_SPEED_CHANGE_ACK:           move_type = MOVE_RUN;           force_move_type = MOVE_RUN;         break;
        case CMSG_FORCE_RUN_BACK_SPEED_CHANGE_ACK:      move_type = MOVE_RUN_BACK;      force_move_type = MOVE_RUN_BACK;    break;
        case CMSG_FORCE_SWIM_SPEED_CHANGE_ACK:          move_type = MOVE_SWIM;          force_move_type = MOVE_SWIM;        break;
        case CMSG_FORCE_SWIM_BACK_SPEED_CHANGE_ACK:     move_type = MOVE_SWIM_BACK;     force_move_type = MOVE_SWIM_BACK;   break;
        case CMSG_FORCE_TURN_RATE_CHANGE_ACK:           move_type = MOVE_TURN_RATE;     force_move_type = MOVE_TURN_RATE;   break;
        case CMSG_FORCE_FLIGHT_SPEED_CHANGE_ACK:        move_type = MOVE_FLIGHT;        force_move_type = MOVE_FLIGHT;      break;
        case CMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE_ACK:   move_type = MOVE_FLIGHT_BACK;   force_move_type = MOVE_FLIGHT_BACK; break;
        case CMSG_FORCE_PITCH_RATE_CHANGE_ACK:          move_type = MOVE_PITCH_RATE;    force_move_type = MOVE_PITCH_RATE;  break;
        default:
            LOG_ERROR("network.opcode", "WorldSession::HandleForceSpeedChangeAck: Unknown move type opcode: {}", opcode);
            return;
    }

    sScriptMgr->AnticheatSetUnderACKmount(_player);

    SpeedOpcodePair const& speedOpcodes = SetSpeed2Opc_table[move_type];
    WorldPacket data(speedOpcodes[static_cast<size_t>(SpeedOpcodeIndex::ACK_RESPONSE)], 18);
    WriteMovementInfo(&data, &movementInfo);
    data << newspeed;
    mover->SendMessageToSet(&data, _player);

    // skip all forced speed changes except last and unexpected
    // in run/mounted case used one ACK and it must be skipped.m_forced_speed_changes[MOVE_RUN} store both.
    if (_player->m_forced_speed_changes[force_move_type] > 0)
    {
        --_player->m_forced_speed_changes[force_move_type];
        if (_player->m_forced_speed_changes[force_move_type] > 0)
            return;
    }

    if (!_player->GetTransport() && std::fabs(_player->GetSpeed(move_type) - newspeed) > 0.01f)
    {
        if (_player->GetSpeed(move_type) > newspeed)         // must be greater - just correct
        {
            LOG_ERROR("network.opcode", "{}SpeedChange player {} is NOT correct (must be {} instead {}), force set to correct value",
                           move_type_name[move_type], _player->GetName(), _player->GetSpeed(move_type), newspeed);
            _player->SetSpeed(move_type, _player->GetSpeedRate(move_type), true);
        }
        else                                                // must be lesser - cheating
        {
            LOG_INFO("network.opcode", "Player {} from account id {} kicked for incorrect speed (must be {} instead {})",
                           _player->GetName(), GetAccountId(), _player->GetSpeed(move_type), newspeed);
            KickPlayer("Incorrect speed");
        }
    }
}

void WorldSession::HandleSetActiveMoverOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_SET_ACTIVE_MOVER");

    ObjectGuid guid;
    recvData >> guid;

    if (GetPlayer()->IsInWorld() && _player->m_mover && _player->m_mover->IsInWorld())
    {
        if (_player->m_mover->GetGUID() != guid)
            LOG_ERROR("network.opcode", "HandleSetActiveMoverOpcode: incorrect mover guid: mover is {} and should be {}",
                guid.ToString(), _player->m_mover->GetGUID().ToString());
    }
}

void WorldSession::HandleMoveNotActiveMover(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_MOVE_NOT_ACTIVE_MOVER");

    ObjectGuid old_mover_guid;
    recvData >> old_mover_guid.ReadAsPacked();

    // pussywizard: typical check for incomming movement packets
    if (!_player->m_mover || !_player->m_mover->IsInWorld() || _player->m_mover->IsDuringRemoveFromWorld() || old_mover_guid != _player->m_mover->GetGUID())
    {
        recvData.rfinish(); // prevent warnings spam
        return;
    }

    MovementInfo mi;
    mi.guid = old_mover_guid;
    ReadMovementInfo(recvData, &mi);

    _player->m_mover->m_movementInfo = mi;
}

void WorldSession::HandleMountSpecialAnimOpcode(WorldPacket& /*recvData*/)
{
    WorldPacket data(SMSG_MOUNTSPECIAL_ANIM, 8);
    data << GetPlayer()->GetGUID();

    GetPlayer()->SendMessageToSet(&data, false);
}

void WorldSession::HandleMoveKnockBackAck(WorldPacket& recvData)
{
    LOG_DEBUG("network", "CMSG_MOVE_KNOCK_BACK_ACK");

    Unit* mover = _player->m_mover;

    ObjectGuid guid;
    recvData >> guid.ReadAsPacked();

    // pussywizard: typical check for incomming movement packets
    if (!mover || !mover->IsInWorld() || mover->IsDuringRemoveFromWorld() || guid != mover->GetGUID())
    {
        recvData.rfinish(); // prevent warnings spam
        return;
    }

    recvData.read_skip<uint32>();                          // unk

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    mover->m_movementInfo = movementInfo;

    if (mover->IsPlayer() && static_cast<Player*>(mover)->IsFreeFlying())
        mover->SetCanFly(true);

    WorldPacket data(MSG_MOVE_KNOCK_BACK, 66);
    data << guid.WriteAsPacked();
    _player->m_mover->BuildMovementPacket(&data);
    _player->SetCanTeleport(true);
    // knockback specific info
    data << movementInfo.jump.sinAngle;
    data << movementInfo.jump.cosAngle;
    data << movementInfo.jump.xyspeed;
    data << movementInfo.jump.zspeed;

    _player->SendMessageToSet(&data, false);
}

void WorldSession::HandleSummonResponseOpcode(WorldPacket& recvData)
{
    if (!_player->IsAlive() || _player->IsInCombat())
        return;

    ObjectGuid summoner_guid;
    bool agree;
    recvData >> summoner_guid;
    recvData >> agree;

    if (agree && _player->IsSummonAsSpectator())
    {
        ChatHandler chc(this);
        if (Player* summoner = ObjectAccessor::FindPlayer(summoner_guid))
            ArenaSpectator::HandleSpectatorSpectateCommand(&chc, summoner->GetName().c_str());
        else
            chc.PSendSysMessage("Requested player not found.");

        agree = false;
    }
    _player->SetSummonAsSpectator(false);
    _player->SummonIfPossible(agree, summoner_guid);
}

void WorldSession::HandleMoveTimeSkippedOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_MOVE_TIME_SKIPPED");

    ObjectGuid guid;
    uint32 timeSkipped;
    recvData >> guid.ReadAsPacked();
    recvData >> timeSkipped;

    Unit* mover = GetPlayer()->m_mover;

    if (!mover)
    {
        LOG_ERROR("network.opcode", "WorldSession::HandleMoveTimeSkippedOpcode wrong mover state from the unit moved by the player [{}]", GetPlayer()->GetGUID().ToString());
        return;
    }

    // prevent tampered movement data
    if (guid != mover->GetGUID())
    {
        LOG_ERROR("network.opcode", "WorldSession::HandleMoveTimeSkippedOpcode wrong guid from the unit moved by the player [{}]", GetPlayer()->GetGUID().ToString());
        return;
    }

    mover->m_movementInfo.time += timeSkipped;

    WorldPacket data(MSG_MOVE_TIME_SKIPPED, recvData.size());
    data << guid.WriteAsPacked();
    data << timeSkipped;
    GetPlayer()->SendMessageToSet(&data, false);
}

void WorldSession::HandleTimeSyncResp(WorldPacket& recvData)
{
    LOG_DEBUG("network", "CMSG_TIME_SYNC_RESP");

    uint32 counter, clientTimestamp;
    recvData >> counter >> clientTimestamp;

    if (_pendingTimeSyncRequests.count(counter) == 0)
        return;

    uint32 serverTimeAtSent = _pendingTimeSyncRequests.at(counter);
    _pendingTimeSyncRequests.erase(counter);

    // time it took for the request to travel to the client, for the client to process it and reply and for response to travel back to the server.
    // we are going to make 2 assumptions:
    // 1) we assume that the request processing time equals 0.
    // 2) we assume that the packet took as much time to travel from server to client than it took to travel from client to server.
    uint32 roundTripDuration = getMSTimeDiff(serverTimeAtSent, recvData.GetReceivedTime());
    uint32 lagDelay = roundTripDuration / 2;

    // clockDelta = serverTime - clientTime
    // where
    // serverTime: time that was displayed on the clock of the SERVER at the moment when the client processed the SMSG_TIME_SYNC_REQUEST packet.
    // clientTime:  time that was displayed on the clock of the CLIENT at the moment when the client processed the SMSG_TIME_SYNC_REQUEST packet.

    // Once clockDelta has been computed, we can compute the time of an event on server clock when we know the time of that same event on the client clock,
    // using the following relation:
    // serverTime = clockDelta + clientTime

    int64 clockDelta = (int64)serverTimeAtSent + (int64)lagDelay - (int64)clientTimestamp;
    _timeSyncClockDeltaQueue.put(std::pair<int64, uint32>(clockDelta, roundTripDuration));
    ComputeNewClockDelta();
}

void WorldSession::ComputeNewClockDelta()
{
    // implementation of the technique described here: https://web.archive.org/web/20180430214420/http://www.mine-control.com/zack/timesync/timesync.html
    // to reduce the skew induced by dropped TCP packets that get resent.

    std::vector<uint32> latencies;
    std::vector<int64> clockDeltasAfterFiltering;

    for (auto& pair : _timeSyncClockDeltaQueue.content())
        latencies.push_back(pair.second);

    uint32 latencyMedian = median(latencies);
    uint32 latencyStandardDeviation = standard_deviation(latencies);

    uint32 sampleSizeAfterFiltering = 0;
    for (auto& pair : _timeSyncClockDeltaQueue.content())
    {
        if (pair.second <= latencyMedian + latencyStandardDeviation)
        {
            clockDeltasAfterFiltering.push_back(pair.first);
            sampleSizeAfterFiltering++;
        }
    }

    if (sampleSizeAfterFiltering != 0)
    {
        int64 meanClockDelta = static_cast<int64>(mean(clockDeltasAfterFiltering));
        if (std::abs(meanClockDelta - _timeSyncClockDelta) > 25)
            _timeSyncClockDelta = meanClockDelta;
    }
    else if (_timeSyncClockDelta == 0)
    {
        std::pair<int64, uint32> back = _timeSyncClockDeltaQueue.peak_back();
        _timeSyncClockDelta = back.first;
    }
}

void WorldSession::HandleMoveRootAck(WorldPacket& recvData)
{
    Opcodes opcode = (Opcodes)recvData.GetOpcode();
    LOG_DEBUG("network", "WORLD: {}", GetOpcodeNameForLogging(opcode));

    ObjectGuid guid;
    uint32 counter;
    MovementInfo movementInfo;
    recvData >> guid.ReadAsPacked();
    recvData >> counter;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    Unit* mover = _player->m_mover;

    if (mover->GetGUID() != guid)
        return;

    if (opcode == CMSG_FORCE_MOVE_UNROOT_ACK) // unroot case
    {
        if (!mover->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_ROOT))
            return;
    }
    else // root case
    {
        if (mover->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_ROOT))
            return;
    }

    // old map - async processing, ignore
    if (counter <= _player->GetMapChangeOrderCounter())
        return;

    if (!ProcessMovementInfo(movementInfo, mover, _player, recvData))
        return;

    if (_player->IsExpectingChangeTransport())
        return;

    WorldPacket data(opcode == CMSG_FORCE_MOVE_UNROOT_ACK ? MSG_MOVE_UNROOT : MSG_MOVE_ROOT);
    WriteMovementInfo(&data, &movementInfo);
    mover->SendMessageToSet(&data, _player);
}
