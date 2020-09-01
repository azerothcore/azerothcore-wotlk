/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "Log.h"
#include "Corpse.h"
#include "Player.h"
#include "SpellAuras.h"
#include "MapManager.h"
#include "Transport.h"
#include "Battleground.h"
#include "WaypointMovementGenerator.h"
#include "InstanceSaveMgr.h"
#include "ObjectMgr.h"
#include "CellImpl.h"
#include "Pet.h"
#include "ArenaSpectator.h"
#include "Chat.h"
#include "BattlegroundMgr.h"
#include "ScriptMgr.h"
#include "GameGraveyard.h"

#define MOVEMENT_PACKET_TIME_DELAY 0

void WorldSession::HandleMoveWorldportAckOpcode(WorldPacket & /*recvData*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: got MSG_MOVE_WORLDPORT_ACK.");
#endif
    HandleMoveWorldportAckOpcode();
}

void WorldSession::HandleMoveWorldportAckOpcode()
{
    // ignore unexpected far teleports
    if (!GetPlayer()->IsBeingTeleportedFar())
        return;

    GetPlayer()->SetSemaphoreTeleportFar(0);

    // get the teleport destination
    WorldLocation const& loc = GetPlayer()->GetTeleportDest();

    // possible errors in the coordinate validity check
    if (!MapManager::IsValidMapCoord(loc))
    {
        KickPlayer("!MapManager::IsValidMapCoord(loc)");
        return;
    }

    // get the destination map entry, not the current one, this will fix homebind and reset greeting
    MapEntry const* mEntry = sMapStore.LookupEntry(loc.GetMapId());
    InstanceTemplate const* mInstance = sObjectMgr->GetInstanceTemplate(loc.GetMapId());

    Map* oldMap = GetPlayer()->GetMap();
    if (GetPlayer()->IsInWorld())
    {
        sLog->outError("Player (Name %s) is still in world when teleported from map %u to new map %u", GetPlayer()->GetName().c_str(), oldMap->GetId(), loc.GetMapId());
        oldMap->RemovePlayerFromMap(GetPlayer(), false);
    }

    // reset instance validity, except if going to an instance inside an instance
    if (GetPlayer()->m_InstanceValid == false && !mInstance)
    {
        GetPlayer()->m_InstanceValid = true;
        // pussywizard: m_InstanceValid can be false only by leaving a group in an instance => so remove temp binds that could not be removed because player was still on the map!
        if (!sInstanceSaveMgr->PlayerIsPermBoundToInstance(GetPlayer()->GetGUIDLow(), oldMap->GetId(), oldMap->GetDifficulty()))
            sInstanceSaveMgr->PlayerUnbindInstance(GetPlayer()->GetGUIDLow(), oldMap->GetId(), oldMap->GetDifficulty(), true);
    }

    // relocate the player to the teleport destination
    Map* newMap = sMapMgr->CreateMap(loc.GetMapId(), GetPlayer());
    // the CanEnter checks are done in TeleporTo but conditions may change
    // while the player is in transit, for example the map may get full
    if (!newMap || !newMap->CanEnter(GetPlayer(), false))
    {
        sLog->outError("Map %d could not be created for player %d, porting player to homebind", loc.GetMapId(), GetPlayer()->GetGUIDLow());
        GetPlayer()->TeleportTo(GetPlayer()->m_homebindMapId, GetPlayer()->m_homebindX, GetPlayer()->m_homebindY, GetPlayer()->m_homebindZ, GetPlayer()->GetOrientation());
        return;
    }

    GetPlayer()->Relocate(loc.GetPositionX(), loc.GetPositionY(), loc.GetPositionZ(), loc.GetOrientation());

    GetPlayer()->ResetMap();
    GetPlayer()->SetMap(newMap);

    GetPlayer()->SendInitialPacketsBeforeAddToMap();
    if (!GetPlayer()->GetMap()->AddPlayerToMap(GetPlayer()))
    {
        sLog->outError("WORLD: failed to teleport player %s (%d) to map %d because of unknown reason!", GetPlayer()->GetName().c_str(), GetPlayer()->GetGUIDLow(), loc.GetMapId());
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

    if (!_player->getHostileRefManager().isEmpty())
        _player->getHostileRefManager().deleteReferences(); // pussywizard: multithreading crashfix

    CellCoord pair(acore::ComputeCellCoord(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY()));
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
        timeWhoCommandAllowed = time(nullptr) + sWorld->GetNextWhoListUpdateDelaySecs() + 1; // after exiting arena Subscribe will scan for a player and cached data says he is still in arena, so disallow until next update

        if (uint32 inviteInstanceId = _player->GetPendingSpectatorInviteInstanceId())
        {
            if (Battleground* tbg = sBattlegroundMgr->GetBattleground(inviteInstanceId))
                tbg->RemoveToBeTeleported(_player->GetGUID());
            _player->SetPendingSpectatorInviteInstanceId(0);
        }
    }

    // xinef: do this again, player can be teleported inside bg->AddPlayer(_player)!!!!
    CellCoord pair2(acore::ComputeCellCoord(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY()));
    Cell cell2(pair2);
    if (!GridCoord(cell2.GridX(), cell2.GridY()).IsCoordValid())
    {
        KickPlayer("!GridCoord(cell2.GridX(), cell2.GridY()).IsCoordValid()");
        return;
    }
    newMap->LoadGrid(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY());

    GetPlayer()->SendInitialPacketsAfterAddToMap();

    // resurrect character at enter into instance where his corpse exist after add to map
    Corpse* corpse = GetPlayer()->GetCorpse();
    if (corpse && corpse->GetType() != CORPSE_BONES && corpse->GetMapId() == GetPlayer()->GetMapId())
    {
        if (mEntry->IsDungeon())
        {
            GetPlayer()->ResurrectPlayer(0.5f, false);
            GetPlayer()->SpawnCorpseBones();
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
                    uint32 timeleft = uint32(timeReset - time(nullptr));
                    GetPlayer()->SendInstanceResetWarning(mEntry->MapID, diff, timeleft, true);
                }
        allowMount = mInstance->AllowMount;
    }

    // mount allow check
    if (!allowMount)
        _player->RemoveAurasByType(SPELL_AURA_MOUNTED);

    // update zone immediately, otherwise leave channel will cause crash in mtmap
    uint32 newzone, newarea;
    GetPlayer()->GetZoneAndAreaId(newzone, newarea, true);
    GetPlayer()->UpdateZone(newzone, newarea);

    // honorless target
    if (GetPlayer()->pvpInfo.IsHostile)
        GetPlayer()->CastSpell(GetPlayer(), 2479, true);

    // in friendly area
    else if (GetPlayer()->IsPvP() && !GetPlayer()->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP))
        GetPlayer()->UpdatePvP(false, false);

    // resummon pet
    GetPlayer()->ResummonPetTemporaryUnSummonedIfAny();

    //lets process all delayed operations on successful teleport
    GetPlayer()->ProcessDelayedOperations();
}

void WorldSession::HandleMoveTeleportAck(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "MSG_MOVE_TELEPORT_ACK");
#endif
    uint64 guid;

    recvData.readPackGUID(guid);

    uint32 flags, time;
    recvData >> flags >> time; // unused
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("Guid " UI64FMTD, guid);
#endif
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("Flags %u, time %u", flags, time/IN_MILLISECONDS);
#endif

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

    // xinef: teleport pets if they are not unsummoned
    if (Pet* pet = plMover->GetPet())
    {
        if (!pet->IsWithinDist3d(plMover, plMover->GetMap()->GetVisibilityRange()-5.0f))
            pet->NearTeleportTo(plMover->GetPositionX(), plMover->GetPositionY(), plMover->GetPositionZ(), pet->GetOrientation());
    }

    if (oldPos.GetExactDist2d(plMover) > 100.0f)
    {
        uint32 newzone, newarea;
        plMover->GetZoneAndAreaId(newzone, newarea, true);
        plMover->UpdateZone(newzone, newarea);

        // new zone
        if (old_zone != newzone)
        {
            // honorless target
            if (plMover->pvpInfo.IsHostile)
                plMover->CastSpell(plMover, 2479, true);

            // in friendly area
            else if (plMover->IsPvP() && !plMover->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP))
                plMover->UpdatePvP(false, false);
        }
    }

    // resummon pet
    GetPlayer()->ResummonPetTemporaryUnSummonedIfAny();

    //lets process all delayed operations on successful teleport
    GetPlayer()->ProcessDelayedOperations();

    plMover->GetMotionMaster()->ReinitializeMovement();

    // pussywizard: client forgets about losing control, resend it
    if (plMover->HasUnitState(UNIT_STATE_FLEEING|UNIT_STATE_CONFUSED) || plMover->IsCharmed()) // only in such cases SetClientControl(self, false) is sent
        plMover->SetClientControl(plMover, false, true);
}

void WorldSession::HandleMovementOpcodes(WorldPacket & recvData)
{
    uint16 opcode = recvData.GetOpcode();

    Unit* mover = _player->m_mover;

    ASSERT(mover != nullptr);                      // there must always be a mover

    Player* plrMover = mover->ToPlayer();

    // ignore, waiting processing in WorldSession::HandleMoveWorldportAckOpcode and WorldSession::HandleMoveTeleportAck
    if (plrMover && plrMover->IsBeingTeleported())
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    /* extract packet */
    uint64 guid;

    recvData.readPackGUID(guid);

    // prevent tampered movement data
    if (!guid || guid != mover->GetGUID()) {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    // pussywizard: typical check for incomming movement packets
    if (!mover || !(mover->IsInWorld()) || mover->IsDuringRemoveFromWorld() || !(mover->movespline->Finalized()))
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    if (!movementInfo.pos.IsPositionValid()) {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    recvData.rfinish();                         // prevent warnings spam

    if (movementInfo.flags & MOVEMENTFLAG_ONTRANSPORT)
    {
        // T_POS ON VEHICLES!
        if (mover->GetVehicle())
            movementInfo.transport.pos = mover->m_movementInfo.transport.pos;

        // transports size limited
        // (also received at zeppelin leave by some reason with t_* as absolute in continent coordinates, can be safely skipped)
        if (movementInfo.transport.pos.GetPositionX() > 75.0f || movementInfo.transport.pos.GetPositionY() > 75.0f || movementInfo.transport.pos.GetPositionZ() > 75.0f ||
            movementInfo.transport.pos.GetPositionX() < -75.0f || movementInfo.transport.pos.GetPositionY() < -75.0f || movementInfo.transport.pos.GetPositionZ() < -75.0f)
        {
            recvData.rfinish();                   // prevent warnings spam
            return;
        }

        if (!acore::IsValidMapCoord(movementInfo.pos.GetPositionX() + movementInfo.transport.pos.GetPositionX(), movementInfo.pos.GetPositionY() + movementInfo.transport.pos.GetPositionY(),
            movementInfo.pos.GetPositionZ() + movementInfo.transport.pos.GetPositionZ(), movementInfo.pos.GetOrientation() + movementInfo.transport.pos.GetOrientation()))
        {
            recvData.rfinish();                   // prevent warnings spam
            return;
        }

        // if we boarded a transport, add us to it
        if (plrMover)
        {
            if (!plrMover->GetTransport())
            {
                if (Transport* transport = plrMover->GetMap()->GetTransport(movementInfo.transport.guid))
                {
                    plrMover->m_transport = transport;
                    transport->AddPassenger(plrMover);
                }
            }
            else if (plrMover->GetTransport()->GetGUID() != movementInfo.transport.guid)
            {
                bool foundNewTransport = false;
                plrMover->m_transport->RemovePassenger(plrMover);
                if (Transport* transport = plrMover->GetMap()->GetTransport(movementInfo.transport.guid))
                {
                    foundNewTransport = true;
                    plrMover->m_transport = transport;
                    transport->AddPassenger(plrMover);
                }

                if (!foundNewTransport)
                {
                    plrMover->m_transport = nullptr;
                    movementInfo.transport.Reset();
                }
            }
        }

        if (!mover->GetTransport() && !mover->GetVehicle())
            movementInfo.flags &= ~MOVEMENTFLAG_ONTRANSPORT;
    }
    else if (plrMover && plrMover->GetTransport()) // if we were on a transport, leave
    {
        plrMover->m_transport->RemovePassenger(plrMover);
        plrMover->m_transport = nullptr;
        movementInfo.transport.Reset();
    }

    if (plrMover && ((movementInfo.flags & MOVEMENTFLAG_SWIMMING) != 0) != plrMover->IsInWater())
    {
        // now client not include swimming flag in case jumping under water
        plrMover->SetInWater(!plrMover->IsInWater() || plrMover->GetBaseMap()->IsUnderWater(movementInfo.pos.GetPositionX(), movementInfo.pos.GetPositionY(), movementInfo.pos.GetPositionZ()));
    }
    if (plrMover)//Hook for OnPlayerMove
        sScriptMgr->OnPlayerMove(plrMover, movementInfo, opcode);
    // Dont allow to turn on walking if charming other player
    if (mover->GetGUID() != _player->GetGUID())
        movementInfo.flags &= ~MOVEMENTFLAG_WALKING;

    uint32 mstime = World::GetGameTimeMS();
    /*----------------------*/
    if(m_clientTimeDelay == 0)
        m_clientTimeDelay = mstime > movementInfo.time ? std::min(mstime - movementInfo.time, (uint32)100) : 0;

    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (mover->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
    {
        // Xinef: skip moving packets
        if (movementInfo.HasMovementFlag(MOVEMENTFLAG_MASK_MOVING))
            return;
        movementInfo.pos.Relocate(mover->GetPositionX(), mover->GetPositionY(), mover->GetPositionZ());

        if (mover->GetTypeId() == TYPEID_UNIT)
        {
            movementInfo.transport.guid = mover->m_movementInfo.transport.guid;
            movementInfo.transport.pos.Relocate(mover->m_movementInfo.transport.pos.GetPositionX(), mover->m_movementInfo.transport.pos.GetPositionY(), mover->m_movementInfo.transport.pos.GetPositionZ());
            movementInfo.transport.seat = mover->m_movementInfo.transport.seat;
        }
    }

    /* process position-change */
    WorldPacket data(opcode, recvData.size());
    //movementInfo.time = movementInfo.time + m_clientTimeDelay + MOVEMENT_PACKET_TIME_DELAY;
    movementInfo.time = mstime; // pussywizard: set to time of relocation (server time), constant addition may smoothen movement clientside, but client sees target on different position than the real serverside position

    movementInfo.guid = mover->GetGUID();
    WriteMovementInfo(&data, &movementInfo);
    mover->SendMessageToSet(&data, _player);

    mover->m_movementInfo = movementInfo;

    // this is almost never true (pussywizard: only one packet when entering vehicle), normally use mover->IsVehicle()
    if (mover->GetVehicle())
    {
        mover->SetOrientation(movementInfo.pos.GetOrientation());
        mover->UpdatePosition(movementInfo.pos);
        return;
    }

    // pussywizard: previously always mover->UpdatePosition(movementInfo.pos);
    if (movementInfo.flags & MOVEMENTFLAG_ONTRANSPORT && mover->GetTransport())
    {
        float x, y, z, o;
        movementInfo.transport.pos.GetPosition(x, y, z, o);
        mover->GetTransport()->CalculatePassengerPosition(x, y, z, &o);
        mover->UpdatePosition(x, y, z, o);
    }
    else
        mover->UpdatePosition(movementInfo.pos);

    // fall damage generation (ignore in flight case that can be triggered also at lags in moment teleportation to another map).
    // Xinef: moved it here, previously StopMoving function called when player died relocated him to last saved coordinates (which were in air)
    if (opcode == MSG_MOVE_FALL_LAND && plrMover && !plrMover->IsInFlight() && (!plrMover->GetTransport() || plrMover->GetTransport()->IsStaticTransport()))
        plrMover->HandleFall(movementInfo);
    // Xinef: interrupt parachutes upon falling or landing in water
    if (opcode == MSG_MOVE_FALL_LAND || opcode == MSG_MOVE_START_SWIM)
        mover->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_LANDING); // Parachutes


    if (plrMover)                                            // nothing is charmed, or player charmed
    {
        if (plrMover->IsSitState() && (movementInfo.flags & (MOVEMENTFLAG_MASK_MOVING | MOVEMENTFLAG_MASK_TURNING)))
            plrMover->SetStandState(UNIT_STAND_STATE_STAND);

        plrMover->UpdateFallInformationIfNeed(movementInfo, opcode);

        if (movementInfo.pos.GetPositionZ() < plrMover->GetMap()->GetMinHeight(movementInfo.pos.GetPositionX(), movementInfo.pos.GetPositionY()))
            if (!plrMover->GetBattleground() || !plrMover->GetBattleground()->HandlePlayerUnderMap(_player))
            {
                if (plrMover->IsAlive())
                {
                    plrMover->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_IS_OUT_OF_BOUNDS);
                    plrMover->EnvironmentalDamage(DAMAGE_FALL_TO_VOID, GetPlayer()->GetMaxHealth());
                    // player can be alive if GM
                    if (plrMover->IsAlive())
                        plrMover->KillPlayer();
                }
                else if (!plrMover->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IS_OUT_OF_BOUNDS))
                {
                    GraveyardStruct const* grave = sGraveyard->GetClosestGraveyard(plrMover->GetPositionX(), plrMover->GetPositionY(), plrMover->GetPositionZ(), plrMover->GetMapId(), plrMover->GetTeamId());
                    if (grave)
                    {
                        plrMover->TeleportTo(grave->Map, grave->x, grave->y, grave->z, plrMover->GetOrientation());
                        plrMover->Relocate(grave->x, grave->y, grave->z, plrMover->GetOrientation());
                    }
                }

                plrMover->StopMovingOnCurrentPos(); // pussywizard: moving corpse can't release spirit
            }
    }
}

void WorldSession::HandleForceSpeedChangeAck(WorldPacket &recvData)
{
    uint32 opcode = recvData.GetOpcode();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd %s (%u, 0x%X) opcode", LookupOpcodeName(opcode), opcode, opcode);
#endif

    /* extract packet */
    uint64 guid;
    uint32 unk1;
    float  newspeed;

    recvData.readPackGUID(guid);

    // pussywizard: special check, only player mover allowed here
    if (guid != _player->m_mover->GetGUID() || guid != _player->GetGUID())
    {
        recvData.rfinish(); // prevent warnings spam
        return;
    }

    // continue parse packet

    recvData >> unk1;                                      // counter or moveEvent

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    recvData >> newspeed;
    /*----------------*/

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
            sLog->outError("WorldSession::HandleForceSpeedChangeAck: Unknown move type opcode: %u", opcode);
            return;
    }

    // skip all forced speed changes except last and unexpected
    // in run/mounted case used one ACK and it must be skipped.m_forced_speed_changes[MOVE_RUN} store both.
    if (_player->m_forced_speed_changes[force_move_type] > 0)
    {
        --_player->m_forced_speed_changes[force_move_type];
        if (_player->m_forced_speed_changes[force_move_type] > 0)
            return;
    }

    if (!_player->GetTransport() && fabs(_player->GetSpeed(move_type) - newspeed) > 0.01f)
    {
        if (_player->GetSpeed(move_type) > newspeed)         // must be greater - just correct
        {
            sLog->outError("%sSpeedChange player %s is NOT correct (must be %f instead %f), force set to correct value",
                move_type_name[move_type], _player->GetName().c_str(), _player->GetSpeed(move_type), newspeed);
            _player->SetSpeed(move_type, _player->GetSpeedRate(move_type), true);
        }
        else                                                // must be lesser - cheating
        {
            sLog->outBasic("Player %s from account id %u kicked for incorrect speed (must be %f instead %f)",
                _player->GetName().c_str(), GetAccountId(), _player->GetSpeed(move_type), newspeed);
            KickPlayer("Incorrect speed");
        }
    }
}

void WorldSession::HandleSetActiveMoverOpcode(WorldPacket &recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_SET_ACTIVE_MOVER");
#endif

    uint64 guid;
    recvData >> guid;

    if (GetPlayer()->IsInWorld() && _player->m_mover && _player->m_mover->IsInWorld())
    {
        if (_player->m_mover->GetGUID() != guid)
            sLog->outError("HandleSetActiveMoverOpcode: incorrect mover guid: mover is " UI64FMTD " (%s - Entry: %u) and should be " UI64FMTD, guid, GetLogNameForGuid(guid), GUID_ENPART(guid), _player->m_mover->GetGUID());
    }
}

void WorldSession::HandleMoveNotActiveMover(WorldPacket &recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_MOVE_NOT_ACTIVE_MOVER");
#endif

    uint64 old_mover_guid;
    recvData.readPackGUID(old_mover_guid);

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
    data << uint64(GetPlayer()->GetGUID());

    GetPlayer()->SendMessageToSet(&data, false);
}

void WorldSession::HandleMoveKnockBackAck(WorldPacket & recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_MOVE_KNOCK_BACK_ACK");
#endif

    uint64 guid;
    recvData.readPackGUID(guid);

    // pussywizard: typical check for incomming movement packets
    if (!_player->m_mover || !_player->m_mover->IsInWorld() || _player->m_mover->IsDuringRemoveFromWorld() || guid != _player->m_mover->GetGUID())
    {
        recvData.rfinish(); // prevent warnings spam
        return;
    }

    recvData.read_skip<uint32>();                          // unk

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    _player->m_mover->m_movementInfo = movementInfo;

    WorldPacket data(MSG_MOVE_KNOCK_BACK, 66);
    data.appendPackGUID(guid);
    _player->m_mover->BuildMovementPacket(&data);

    // knockback specific info
    data << movementInfo.jump.sinAngle;
    data << movementInfo.jump.cosAngle;
    data << movementInfo.jump.xyspeed;
    data << movementInfo.jump.zspeed;

    _player->SendMessageToSet(&data, false);
}

void WorldSession::HandleMoveHoverAck(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_MOVE_HOVER_ACK");
#endif

    uint64 guid;                                            // guid - unused
    recvData.readPackGUID(guid);

    recvData.read_skip<uint32>();                          // unk

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    recvData.read_skip<uint32>();                          // unk2
}

void WorldSession::HandleMoveWaterWalkAck(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_MOVE_WATER_WALK_ACK");
#endif

    uint64 guid;                                            // guid - unused
    recvData.readPackGUID(guid);

    recvData.read_skip<uint32>();                          // unk

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    recvData.read_skip<uint32>();                          // unk2
}

void WorldSession::HandleSummonResponseOpcode(WorldPacket& recvData)
{
    if (!_player->IsAlive() || _player->IsInCombat())
        return;

    uint64 summoner_guid;
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_MOVE_TIME_SKIPPED");
#endif
    
    uint64 guid;
    uint32 timeSkipped;
    recvData.readPackGUID(guid);
    recvData >> timeSkipped;

    Unit* mover = GetPlayer()->m_mover;

    if (!mover)
    {
        sLog->outError("WorldSession::HandleMoveTimeSkippedOpcode wrong mover state from the unit moved by the player [" UI64FMTD "]", GetPlayer()->GetGUID());
        return;
    }

    // prevent tampered movement data
    if (guid != mover->GetGUID())
    {
        sLog->outError("WorldSession::HandleMoveTimeSkippedOpcode wrong guid from the unit moved by the player [" UI64FMTD "]", GetPlayer()->GetGUID());
        return;
    }

    mover->m_movementInfo.time += timeSkipped;

    WorldPacket data(MSG_MOVE_TIME_SKIPPED, recvData.size());
    data.appendPackGUID(guid);
    data << timeSkipped;
    GetPlayer()->SendMessageToSet(&data, false);
}
