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

#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "ScriptMgr.h"
#include "CellImpl.h"
#include "CreatureTextMgr.h"
#include "GameGraveyard.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Map.h"
#include "MapMgr.h"
#include "MiscPackets.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Transport.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSessionMgr.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

Battlefield::Battlefield() :
    Timer(0),
    Enabled(true),
    Active(false),
    DefenderTeam(TEAM_NEUTRAL),
    TypeId(0),
    BattleId(0),
    ZoneId(0),
    MapId(0),
    BfMap(nullptr),
    MaxPlayer(0),
    MinPlayer(0),
    MinLevel(0),
    BattleTime(0),
    NoWarBattleTime(0),
    RestartAfterCrash(0),
    TimeForAcceptInvite(20),
    StartGroupingTimer(0),
    StartGrouping(false)
{
}

Battlefield::~Battlefield()
{
    for (BfCapturePoint* cp : CapturePoints)
        delete cp;

    for (BfGraveyard* gy : GraveyardList)
        delete gy;

    CapturePoints.clear();
}

void Battlefield::HandlePlayerEnterZone(Player* player, uint32 /*zone*/)
{
    // Allow scripts to adjust the player's effective team or appearance before
    // any team-based battlefield containers (such as player lists or queues) are updated.
    sScriptMgr->OnBattlefieldPlayerEnterZone(this, player);

    // Xinef: do not invite players on taxi
    if (!player->IsInFlight())
    {
        // If battle is started,
        // If not full of players > invite player to join the war
        // If full of players > announce to player that BF is full and kick him after a few second if he doesn't leave
        if (IsWarTime())
        {
            if (HasWarVacancy(player->GetTeamId()))
                InvitePlayerToWar(player);
            else
            {
                /// @todo: Send a packet to announce it to player
                PlayersWillBeKick[player->GetTeamId()][player->GetGUID()] = GameTime::GetGameTime().count() + (player->IsGameMaster() ? 30 * MINUTE : 10);
                InvitePlayerToQueue(player);
            }
        }
        else
        {
            // If time left is < 15 minutes invite player to join queue
            if (Timer <= StartGroupingTimer)
                InvitePlayerToQueue(player);
        }
    }

    Players[player->GetTeamId()].insert(player->GetGUID());
    OnPlayerEnterZone(player);
}

void Battlefield::HandlePlayerLeaveZone(Player* player, uint32 /*zone*/)
{
    if (IsWarTime())
    {
        // If the player is participating to the battle
        if (PlayersInWar[player->GetTeamId()].erase(player->GetGUID()))
        {
            player->GetSession()->SendBfLeaveMessage(BattleId);
            if (Group* group = player->GetGroup()) // Remove the player from the raid group
                if (group->isBFGroup())
                    group->RemoveMember(player->GetGUID());

            OnPlayerLeaveWar(player);
            sScriptMgr->OnBattlefieldPlayerLeaveWar(this, player);
        }
    }

    for (BfCapturePoint* cp : CapturePoints)
        cp->HandlePlayerLeave(player);

    for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
    {
        InvitedPlayers[i].erase(player->GetGUID());
        PlayersInQueue[i].erase(player->GetGUID());
        PlayersWillBeKick[i].erase(player->GetGUID());
        Players[i].erase(player->GetGUID());
    }
    SendRemoveWorldStates(player);
    RemovePlayerFromResurrectQueue(player->GetGUID());
    OnPlayerLeaveZone(player);
}

bool Battlefield::Update(uint32 diff)
{
    if (Timer <= diff)
    {
        uint32 sessionLimit = sWorld->getIntConfig(CONFIG_WINTERGRASP_SKIP_BATTLE_SESSION_COUNT);
        bool tooManySessions = sessionLimit && !IsWarTime()
            && sWorldSessionMgr->GetActiveSessionCount() > sessionLimit;

        if (!IsEnabled() || tooManySessions)
        {
            Active = true;
            EndBattle(false);
            return false;
        }
        // Battlefield ends on time
        if (IsWarTime())
            EndBattle(true);
        else // Time to start a new battle!
            StartBattle();
    }
    else
        Timer -= diff;

    if (!IsEnabled())
        return false;

    // Invite players a few minutes before the battle's beginning
    if (!IsWarTime() && !StartGrouping && Timer <= StartGroupingTimer)
    {
        StartGrouping = true;
        InvitePlayersInZoneToQueue();
        OnStartGrouping();
        SendUpdateWorldStates();
    }

    _scheduler.Update(diff);

    bool objectiveChanged = false;
    if (IsWarTime())
    {
        for (BfCapturePoint* cp : CapturePoints)
            if (cp->Update(diff))
                objectiveChanged = true;
    }

    return objectiveChanged;
}

void Battlefield::InvitePlayersInZoneToQueue()
{
    ForEachPlayerInZone([this](Player* player) { InvitePlayerToQueue(player); });
}

void Battlefield::InvitePlayerToQueue(Player* player)
{
    if (PlayersInQueue[player->GetTeamId()].count(player->GetGUID()))
        return;

    if (PlayersInQueue[player->GetTeamId()].size() <= MinPlayer || PlayersInQueue[GetOtherTeam(player->GetTeamId())].size() >= MinPlayer)
        player->GetSession()->SendBfInvitePlayerToQueue(BattleId);
}

void Battlefield::InvitePlayersInQueueToWar()
{
    for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
    {
        GuidUnorderedSet copy(PlayersInQueue[team]);
        for (ObjectGuid const& guid : copy)
            if (Player* player = ObjectAccessor::FindPlayer(guid))
                if (HasWarVacancy(player->GetTeamId()))
                    InvitePlayerToWar(player);
        PlayersInQueue[team].clear();
    }
}

void Battlefield::InvitePlayersInZoneToWar()
{
    ForEachPlayerInZone([this](Player* player)
    {
        if (IsPlayerInWarOrInvited(player))
            return;

        if (HasWarVacancy(player->GetTeamId()))
            InvitePlayerToWar(player);
        else if (!PlayersWillBeKick[player->GetTeamId()].count(player->GetGUID())) // Battlefield is full of players
            PlayersWillBeKick[player->GetTeamId()][player->GetGUID()] = GameTime::GetGameTime().count() + 10;
    });
}

void Battlefield::InvitePlayerToWar(Player* player)
{
    if (!player)
        return;

    /// @todo : needed ?
    if (player->IsInFlight())
        return;

    if (player->InBattleground())
    {
        PlayersInQueue[player->GetTeamId()].erase(player->GetGUID());
        return;
    }

    // If the player does not match minimal level requirements for the battlefield, kick him
    if (player->GetLevel() < MinLevel)
    {
        if (!PlayersWillBeKick[player->GetTeamId()].count(player->GetGUID()))
            PlayersWillBeKick[player->GetTeamId()][player->GetGUID()] = GameTime::GetGameTime().count() + 10;
        return;
    }

    // Check if player is not already in war
    if (IsPlayerInWarOrInvited(player))
        return;

    sScriptMgr->OnBattlefieldBeforeInvitePlayerToWar(this, player);

    PlayersWillBeKick[player->GetTeamId()].erase(player->GetGUID());
    InvitedPlayers[player->GetTeamId()][player->GetGUID()] = GameTime::GetGameTime().count() + TimeForAcceptInvite;
    player->GetSession()->SendBfInvitePlayerToWar(BattleId, ZoneId, TimeForAcceptInvite);
}

void Battlefield::InitStalker(uint32 entry, float x, float y, float z, float o)
{
    if (Creature* creature = SpawnCreature(entry, x, y, z, o, TEAM_NEUTRAL))
        StalkerGuid = creature->GetGUID();
    else
        LOG_ERROR("bg.battlefield", "Battlefield::InitStalker: could not spawn Stalker (Creature entry {}), zone messages will be unavailable", entry);
}

bool Battlefield::IsPlayerInWarOrInvited(Player* player) const
{
    TeamId teamId = player->GetTeamId();
    return PlayersInWar[teamId].count(player->GetGUID()) || InvitedPlayers[teamId].count(player->GetGUID());
}

void Battlefield::KickAfkPlayers()
{
    ForEachPlayerInWar([this](Player* player)
    {
        if (player->isAFK() && player->GetZoneId() == GetZoneId() && !player->IsGameMaster())
            player->TeleportTo(KickPosition);
    });
}

void Battlefield::KickPlayerFromBattlefield(ObjectGuid guid)
{
    if (Player* player = ObjectAccessor::FindPlayer(guid))
        if (player->GetZoneId() == GetZoneId() && !player->IsGameMaster()
            && !PlayersInWar[player->GetTeamId()].count(guid))
            player->TeleportTo(KickPosition);
}

void Battlefield::StartBattle()
{
    if (Active)
        return;

    for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
    {
        PlayersInWar[team].clear();
        Groups[team].clear();
    }

    Timer = BattleTime;
    Active = true;

    // Schedule war-only periodic timers
    _scheduler.Schedule(1s, BATTLEFIELD_TIMER_GROUP_WAR, [this](TaskContext context)
    {
        KickAfkPlayers();
        context.Repeat(20s);
    });

    _scheduler.Schedule(1s, BATTLEFIELD_TIMER_GROUP_WAR, [this](TaskContext context)
    {
        time_t now = GameTime::GetGameTime().count();
        for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
            for (PlayerTimerMap::value_type const& pair : InvitedPlayers[team])
                if (pair.second <= now)
                    KickPlayerFromBattlefield(pair.first);

        InvitePlayersInZoneToWar();
        for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
            for (PlayerTimerMap::value_type const& pair : PlayersWillBeKick[team])
                if (pair.second <= now)
                    KickPlayerFromBattlefield(pair.first);

        context.Repeat(5s);
    });

    InvitePlayersInZoneToWar();
    InvitePlayersInQueueToWar();

    DoPlaySoundToAll(BF_START);

    OnBattleStart();

    SendUpdateWorldStates();
}

void Battlefield::EndBattle(bool endByTimer)
{
    if (!Active)
        return;

    Active = false;

    _scheduler.CancelGroup(BATTLEFIELD_TIMER_GROUP_WAR);

    StartGrouping = false;

    if (!endByTimer)
        SetDefenderTeam(GetAttackerTeam());

    if (GetDefenderTeam() == TEAM_ALLIANCE)
        DoPlaySoundToAll(BF_ALLIANCE_WINS);
    else
        DoPlaySoundToAll(BF_HORDE_WINS);

    OnBattleEnd(endByTimer);
    sScriptMgr->OnBattlefieldWarEnd(this, endByTimer);

    // Reset battlefield timer
    Timer = NoWarBattleTime;
    SendInitWorldStatesToAll();
    SendUpdateWorldStates();
}

void Battlefield::DoPlaySoundToAll(uint32 soundId)
{
    BroadcastPacketToWar(WorldPackets::Misc::Playsound(soundId).Write());
}

bool Battlefield::HasPlayer(Player* player) const
{
    for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
        if (Players[i].count(player->GetGUID()))
            return true;
    return false;
}

// Called in WorldSession::HandleBfQueueInviteResponse
void Battlefield::PlayerAcceptInviteToQueue(Player* player)
{
    // Add player in queue
    PlayersInQueue[player->GetTeamId()].insert(player->GetGUID());
    // Send notification
    player->GetSession()->SendBfQueueInviteResponse(BattleId, ZoneId);
}

// Called in WorldSession::HandleBfExitRequest
void Battlefield::AskToLeaveQueue(Player* player)
{
    // Remove player from queue
    PlayersInQueue[player->GetTeamId()].erase(player->GetGUID());
    // Send notification
    player->GetSession()->SendBfLeaveMessage(BattleId, BF_LEAVE_REASON_CLOSE);
}

// Called in WorldSession::HandleHearthAndResurrect
void Battlefield::PlayerAskToLeave(Player* player)
{
    // Player leaving Wintergrasp, teleport to homebind position.
    player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, player->GetOrientation());
}

// Called in WorldSession::HandleBfEntryInviteResponse
void Battlefield::PlayerAcceptInviteToWar(Player* player)
{
    if (!IsWarTime())
        return;

    sScriptMgr->OnBattlefieldPlayerJoinWar(this, player);

    if (AddOrSetPlayerToCorrectBfGroup(player))
    {
        player->GetSession()->SendBfEntered(BattleId);
        PlayersInWar[player->GetTeamId()].insert(player->GetGUID());
        InvitedPlayers[player->GetTeamId()].erase(player->GetGUID());

        if (player->isAFK())
            player->ToggleAFK();

        OnPlayerJoinWar(player);
    }
}

void Battlefield::TeamCastSpell(TeamId team, int32 spellId)
{
    ForEachPlayerInWar(team, [spellId](Player* player)
    {
        if (spellId > 0)
            player->CastSpell(player, uint32(spellId), true);
        else
            player->RemoveAuraFromStack(uint32(-spellId));
    });
}

void Battlefield::BroadcastPacketToZone(WorldPacket const* data) const
{
    ForEachPlayerInZone([data](Player* player) { player->SendDirectMessage(data); });
}

void Battlefield::BroadcastPacketToQueue(WorldPacket const* data) const
{
    ForEachPlayerInQueue([data](Player* player) { player->SendDirectMessage(data); });
}

void Battlefield::BroadcastPacketToWar(WorldPacket const* data) const
{
    ForEachPlayerInWar([data](Player* player) { player->SendDirectMessage(data); });
}

void Battlefield::SendWarning(uint8 id, WorldObject const* target /*= nullptr*/)
{
    if (Creature* stalker = GetCreature(StalkerGuid))
        sCreatureTextMgr->SendChat(stalker, id, target);
}

void Battlefield::SendUpdateWorldState(uint32 field, uint32 value)
{
    ForEachPlayerInZone([field, value](Player* player) { player->SendUpdateWorldState(field, value); });
}

void Battlefield::RegisterZone(uint32 zoneId)
{
    sBattlefieldMgr->AddZone(zoneId, this);
}

void Battlefield::HideNpc(Creature* creature)
{
    creature->CombatStop();
    creature->SetReactState(REACT_PASSIVE);
    creature->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
    creature->SetPhaseMask(2, false); // pussywizard: false because UpdateObjectVisibility(true) is called below in SetVisible(), no need to have it here
    creature->DisappearAndDie();
    creature->SetVisible(false);
}

void Battlefield::ShowNpc(Creature* creature, bool aggressive)
{
    creature->SetPhaseMask(1, false); // pussywizard: false because UpdateObjectVisibility(true) is called below in SetVisible(), no need to have it here
    creature->SetVisible(true);
    creature->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
    if (!creature->IsAlive())
        creature->Respawn(true);
    if (aggressive)
        creature->SetReactState(REACT_AGGRESSIVE);
    else
    {
        creature->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        creature->SetReactState(REACT_PASSIVE);
    }
}

Group* Battlefield::GetFreeBfRaid(TeamId teamId)
{
    for (ObjectGuid const& guid : Groups[teamId])
        if (Group* group = sGroupMgr->GetGroupByGUID(guid.GetCounter()))
            if (!group->IsFull())
                return group;

    return nullptr;
}

Group* Battlefield::GetGroupPlayer(ObjectGuid guid, TeamId teamId)
{
    for (ObjectGuid const& groupGuid : Groups[teamId])
        if (Group* group = sGroupMgr->GetGroupByGUID(groupGuid.GetCounter()))
            if (group->IsMember(guid))
                return group;

    return nullptr;
}

bool Battlefield::AddOrSetPlayerToCorrectBfGroup(Player* player)
{
    if (!player->IsInWorld())
        return false;

    if (player->GetGroup() && (player->GetGroup()->isBGGroup() || player->GetGroup()->isBFGroup()))
    {
        LOG_INFO("misc", "Battlefield::AddOrSetPlayerToCorrectBfGroup - player is already in {} group!", (player->GetGroup()->isBGGroup() ? "BG" : "BF"));
        return false;
    }

    Group* group = GetFreeBfRaid(player->GetTeamId());
    if (!group)
    {
        group = new Group;
        group->SetBattlefieldGroup(this);
        group->Create(player);
        sGroupMgr->AddGroup(group);
        Groups[player->GetTeamId()].insert(group->GetGUID());
    }
    else if (group->IsMember(player->GetGUID()))
    {
        uint8 subgroup = group->GetMemberGroup(player->GetGUID());
        player->SetBattlegroundOrBattlefieldRaid(group, subgroup);
    }
    else
        group->AddMember(player);

    return true;
}

BfGraveyard* Battlefield::GetGraveyardById(uint32 id) const
{
    if (id < GraveyardList.size())
    {
        if (GraveyardList[id])
            return GraveyardList[id];
        else
            LOG_ERROR("bg.battlefield", "Battlefield::GetGraveyardById Id:{} not existed", id);
    }
    else
        LOG_ERROR("bg.battlefield", "Battlefield::GetGraveyardById Id:{} cant be found", id);

    return nullptr;
}

GraveyardStruct const* Battlefield::GetClosestGraveyard(Player* player)
{
    BfGraveyard* closestGY = nullptr;
    float maxdist = -1;
    for (BfGraveyard* gy : GraveyardList)
    {
        if (!gy)
            continue;

        if (gy->GetControlTeamId() != player->GetTeamId())
            continue;

        float dist = gy->GetDistance(player);
        if (dist < maxdist || maxdist < 0)
        {
            closestGY = gy;
            maxdist = dist;
        }
    }

    if (closestGY)
        return sGraveyard->GetGraveyard(closestGY->GetGraveyardId());

    return nullptr;
}

void Battlefield::AddPlayerToResurrectQueue(ObjectGuid npcGuid, ObjectGuid playerGuid)
{
    for (BfGraveyard* gy : GraveyardList)
    {
        if (!gy)
            continue;

        if (gy->HasNpc(npcGuid))
        {
            gy->AddPlayer(playerGuid);
            break;
        }
    }
}

void Battlefield::RemovePlayerFromResurrectQueue(ObjectGuid playerGuid)
{
    for (BfGraveyard* gy : GraveyardList)
    {
        if (!gy)
            continue;

        if (gy->HasPlayer(playerGuid))
        {
            gy->RemovePlayer(playerGuid);
            break;
        }
    }
}

void Battlefield::SendAreaSpiritHealerQueryOpcode(Player* player, ObjectGuid const& guid)
{
    WorldPacket data(SMSG_AREA_SPIRIT_HEALER_TIME, 12);
    Milliseconds remaining = _scheduler.GetNextGroupOccurrence(BATTLEFIELD_TIMER_GROUP_RESURRECT);
    uint32 time = static_cast<uint32>(std::clamp(remaining,
        Milliseconds::zero(), Milliseconds(RESURRECTION_INTERVAL)).count());

    data << guid << time;
    ASSERT(player);
    player->SendDirectMessage(&data);
}

BfGraveyard::BfGraveyard(Battlefield* bf) :
    ControlTeam(TEAM_NEUTRAL),
    GraveyardId(0),
    Bf(bf)
{
}

void BfGraveyard::Initialize(TeamId startControl, uint32 graveyardId)
{
    ControlTeam = startControl;
    GraveyardId = graveyardId;
}

void BfGraveyard::SetSpirit(Creature* spirit, TeamId team)
{
    if (!spirit)
    {
        LOG_ERROR("bg.battlefield", "BfGraveyard::SetSpirit: Invalid Spirit.");
        return;
    }

    SpiritGuide[team] = spirit->GetGUID();
    spirit->SetReactState(REACT_PASSIVE);
}

float BfGraveyard::GetDistance(Player* player)
{
    GraveyardStruct const* safeLoc = sGraveyard->GetGraveyard(GraveyardId);
    return player->GetDistance2d(safeLoc->x, safeLoc->y);
}

void BfGraveyard::AddPlayer(ObjectGuid playerGuid)
{
    if (!ResurrectQueue.count(playerGuid))
    {
        ResurrectQueue.insert(playerGuid);

        if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
            player->CastSpell(player, SPELL_WAITING_FOR_RESURRECT, true);
    }
}

void BfGraveyard::RemovePlayer(ObjectGuid playerGuid)
{
    ResurrectQueue.erase(ResurrectQueue.find(playerGuid));

    if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
        player->RemoveAurasDueToSpell(SPELL_WAITING_FOR_RESURRECT);
}

void BfGraveyard::Resurrect()
{
    if (ResurrectQueue.empty())
        return;

    for (ObjectGuid const& guid : ResurrectQueue)
    {
        // Get player object from his guid
        Player* player = ObjectAccessor::FindPlayer(guid);
        if (!player)
            continue;

        // Check if the player is in world and on the good graveyard
        if (player->IsInWorld())
            if (Unit* spirit = ObjectAccessor::GetCreature(*player, SpiritGuide[ControlTeam]))
                spirit->CastSpell(spirit, SPELL_SPIRIT_HEAL, true);

        // Resurrect player
        player->CastSpell(player, SPELL_RESURRECTION_VISUAL, true);
        player->ResurrectPlayer(1.0f);
        player->CastSpell(player, 6962, true);
        player->CastSpell(player, SPELL_SPIRIT_HEAL_MANA, true);

        player->SpawnCorpseBones(false);
    }

    ResurrectQueue.clear();
}

// For changing graveyard control
void BfGraveyard::GiveControlTo(TeamId team)
{
    ControlTeam = team;
    // Teleport to other graveyard, players which were on this graveyard
    RelocateDeadPlayers();
}

void BfGraveyard::RelocateDeadPlayers()
{
    GraveyardStruct const* closestGrave = nullptr;
    for (ObjectGuid const& guid : ResurrectQueue)
    {
        Player* player = ObjectAccessor::FindPlayer(guid);
        if (!player)
            continue;

        if (closestGrave)
            player->TeleportTo(player->GetMapId(), closestGrave->x, closestGrave->y, closestGrave->z, player->GetOrientation());
        else
        {
            closestGrave = Bf->GetClosestGraveyard(player);
            if (closestGrave)
                player->TeleportTo(player->GetMapId(), closestGrave->x, closestGrave->y, closestGrave->z, player->GetOrientation());
        }
    }
}

Creature* Battlefield::SpawnCreature(uint32 entry, Position pos, TeamId teamId)
{
    return SpawnCreature(entry, pos.m_positionX, pos.m_positionY, pos.m_positionZ, pos.m_orientation, teamId);
}

Creature* Battlefield::SpawnCreature(uint32 entry, float x, float y, float z, float o, TeamId teamId)
{
    Map* map = sMapMgr->CreateBaseMap(MapId);
    if (!map)
    {
        LOG_ERROR("bg.battlefield", "Battlefield::SpawnCreature: Can't create creature entry: {} map not found", entry);
        return nullptr;
    }

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(entry);
    if (!cinfo)
    {
        LOG_ERROR("sql.sql", "Battlefield::SpawnCreature: entry {} does not exist.", entry);
        return nullptr;
    }

    Creature* creature = new Creature();
    if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, PHASEMASK_NORMAL, entry, 0, x, y, z, o))
    {
        LOG_ERROR("bg.battlefield", "Battlefield::SpawnCreature: Can't create creature entry: {}", entry);
        delete creature;
        return nullptr;
    }

    // no need to set faction for neutral team
    if (teamId == TEAM_ALLIANCE || teamId == TEAM_HORDE)
        creature->SetFaction(BattlefieldFactions[teamId]);

    creature->SetHomePosition(x, y, z, o);

    // force using DB speeds -- do we really need this?
    creature->SetSpeed(MOVE_WALK, cinfo->speed_walk);
    creature->SetSpeed(MOVE_RUN, cinfo->speed_run);

    map->AddToMap(creature);
    creature->setActive(true);

    return creature;
}

GameObject* Battlefield::SpawnGameObject(uint32 entry, float x, float y, float z, float o)
{
    Map* map = sMapMgr->CreateBaseMap(MapId);
    if (!map)
        return nullptr;

    GameObject* go = sObjectMgr->IsGameObjectStaticTransport(entry) ? new StaticTransport() : new GameObject();
    G3D::Quat rotation = G3D::Quat::fromAxisAngleRotation(G3D::Vector3::unitZ(), o);
    if (!go->Create(map->GenerateLowGuid<HighGuid::GameObject>(), entry, map, PHASEMASK_NORMAL, x, y, z, o, rotation, 100, GO_STATE_READY))
    {
        LOG_ERROR("sql.sql", "Battlefield::SpawnGameObject: Gameobject template {} not found in database! Battlefield not created!", entry);
        LOG_ERROR("bg.battlefield", "Battlefield::SpawnGameObject: Cannot create gameobject template {}! Battlefield not created!", entry);
        delete go;
        return nullptr;
    }

    map->AddToMap(go);
    go->setActive(true);

    return go;
}

Creature* Battlefield::GetCreature(ObjectGuid const& guid)
{
    if (!BfMap)
        return nullptr;

    return BfMap->GetCreature(guid);
}

GameObject* Battlefield::GetGameObject(ObjectGuid const& guid)
{
    if (!BfMap)
        return nullptr;

    return BfMap->GetGameObject(guid);
}

BfCapturePoint::BfCapturePoint(Battlefield* bf) :
    MaxValue(0.0f),
    MinValue(0.0f),
    MaxSpeed(0),
    Value(0),
    Team(TEAM_NEUTRAL),
    OldState(BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL),
    State(BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL),
    NeutralValuePct(0),
    Bf(bf),
    CapturePointEntry(0)
{
}

bool BfCapturePoint::HandlePlayerEnter(Player* player)
{
    if (GameObject* go = GetCapturePointGo(player))
    {
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldState1, 1);
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldstate2, uint32(std::ceil((Value + MaxValue) / (2 * MaxValue) * 100.0f)));
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldstate3, NeutralValuePct);
    }
    return ActivePlayers[player->GetTeamId()].insert(player->GetGUID()).second;
}

GuidUnorderedSet::iterator BfCapturePoint::HandlePlayerLeave(Player* player)
{
    if (GameObject* go = GetCapturePointGo(player))
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldState1, 0);

    GuidUnorderedSet::iterator current = ActivePlayers[player->GetTeamId()].find(player->GetGUID());

    if (current == ActivePlayers[player->GetTeamId()].end())
        return current; // return end()

    current = ActivePlayers[player->GetTeamId()].erase(current);
    return current;
}

void BfCapturePoint::SendChangePhase()
{
    GameObject* capturePoint = GetCapturePointGo();
    if (!capturePoint)
        return;

    for (uint8 team = 0; team < 2; ++team)
        for (ObjectGuid const& guid : ActivePlayers[team])  // send to all players present in the area
            if (Player* player = ObjectAccessor::FindPlayer(guid))
            {
                // send this too, sometimes the slider disappears, dunno why :(
                player->SendUpdateWorldState(capturePoint->GetGOInfo()->capturePoint.worldState1, 1);
                // send these updates to only the ones in this objective
                player->SendUpdateWorldState(capturePoint->GetGOInfo()->capturePoint.worldstate2, (uint32) std::ceil((Value + MaxValue) / (2 * MaxValue) * 100.0f));
                // send this too, sometimes it resets :S
                player->SendUpdateWorldState(capturePoint->GetGOInfo()->capturePoint.worldstate3, NeutralValuePct);
            }
}

bool BfCapturePoint::SetCapturePointData(GameObject* capturePoint, TeamId team)
{
    ASSERT(capturePoint);

    //At first call using TEAM_NEUTRAL as a checker but never using it, after first call we reset the capturepoints to the new winner of the last WG war
    if (team == TEAM_NEUTRAL)
        team = Team;
    LOG_DEBUG("bg.battlefield", "Creating capture point {}", capturePoint->GetEntry());

    CapturePoint = capturePoint->GetGUID();

    // check info existence
    GameObjectTemplate const* goinfo = capturePoint->GetGOInfo();
    if (goinfo->type != GAMEOBJECT_TYPE_CAPTURE_POINT)
    {
        LOG_ERROR("bg.battlefield", "OutdoorPvP: GO {} is not capture point!", capturePoint->GetEntry());
        return false;
    }

    // get the needed values from goinfo
    MaxValue = goinfo->capturePoint.maxTime;
    MaxSpeed = MaxValue / (goinfo->capturePoint.minTime ? goinfo->capturePoint.minTime : 60);
    NeutralValuePct = goinfo->capturePoint.neutralPercent;
    MinValue = MaxValue * goinfo->capturePoint.neutralPercent / 100;
    CapturePointEntry = capturePoint->GetEntry();
    if (team == TEAM_ALLIANCE)
    {
        Value = MaxValue;
        State = BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE;
    }
    else
    {
        Value = -MaxValue;
        State = BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE;
    }

    return true;
}

bool BfCapturePoint::DelCapturePoint()
{
    if (GameObject* capturePoint = GetCapturePointGo())
    {
        capturePoint->SetRespawnTime(0);                  // not save respawn time
        capturePoint->Delete();
        CapturePoint.Clear();
    }

    return true;
}

GameObject* BfCapturePoint::GetCapturePointGo()
{
    return Bf->GetGameObject(CapturePoint);
}

GameObject* BfCapturePoint::GetCapturePointGo(WorldObject* obj)
{
    return ObjectAccessor::GetGameObject(*obj, CapturePoint);
}

bool BfCapturePoint::Update(uint32 diff)
{
    GameObject* capturePoint = GetCapturePointGo();
    if (!capturePoint)
        return false;

    float radius = capturePoint->GetGOInfo()->capturePoint.radius;

    for (uint8 team = 0; team < 2; ++team)
    {
        for (auto itr = ActivePlayers[team].begin(); itr != ActivePlayers[team].end();)
        {
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                if (!capturePoint->IsWithinDistInMap(player, radius) || !player->IsOutdoorPvPActive())
                {
                    itr = HandlePlayerLeave(player);
                    continue;
                }

            ++itr;
        }
    }

    std::list<Player*> players;
    Acore::AnyPlayerInObjectRangeCheck checker(capturePoint, radius);
    Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(capturePoint, players, checker);
    Cell::VisitObjects(capturePoint, searcher, radius);

    for (Player* player : players)
        if (player->IsOutdoorPvPActive())
            if (ActivePlayers[player->GetTeamId()].insert(player->GetGUID()).second)
                HandlePlayerEnter(player);

    // get the difference of numbers
    float factDiff = ((float) ActivePlayers[0].size() - (float) ActivePlayers[1].size()) * diff / BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL;
    if (G3D::fuzzyEq(factDiff, 0.0f))
        return false;

    TeamId challengerId = TEAM_NEUTRAL;
    float maxDiff = MaxSpeed * diff;

    if (factDiff < 0)
    {
        // horde is in majority, but it's already horde-controlled -> no change
        if (State == BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE && Value <= -MaxValue)
            return false;

        if (factDiff < -maxDiff)
            factDiff = -maxDiff;

        challengerId = TEAM_HORDE;
    }
    else
    {
        // ally is in majority, but it's already ally-controlled -> no change
        if (State == BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE && Value >= MaxValue)
            return false;

        if (factDiff > maxDiff)
            factDiff = maxDiff;

        challengerId = TEAM_ALLIANCE;
    }

    float oldValue = Value;
    TeamId oldTeam = Team;

    OldState = State;

    Value += factDiff;

    if (Value < -MinValue)                              // red
    {
        if (Value < -MaxValue)
            Value = -MaxValue;
        State = BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE;
        Team = TEAM_HORDE;
    }
    else if (Value > MinValue)                          // blue
    {
        if (Value > MaxValue)
            Value = MaxValue;
        State = BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE;
        Team = TEAM_ALLIANCE;
    }
    else if (oldValue * Value <= 0)                     // grey, go through mid point
    {
        // if challenger is ally, then n->a challenge
        if (challengerId == TEAM_ALLIANCE)
            State = BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE;
        // if challenger is horde, then n->h challenge
        else if (challengerId == TEAM_HORDE)
            State = BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE;
        Team = TEAM_NEUTRAL;
    }
    else                                                // grey, did not go through mid point
    {
        // old phase and current are on the same side, so one team challenges the other
        if (challengerId == TEAM_ALLIANCE && (OldState == BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE || OldState == BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE))
            State = BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE;
        else if (challengerId == TEAM_HORDE && (OldState == BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE || OldState == BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE))
            State = BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE;
        Team = TEAM_NEUTRAL;
    }

    if (G3D::fuzzyNe(Value, oldValue))
        SendChangePhase();

    if (OldState != State)
    {
        if (oldTeam != Team)
            ChangeTeam(oldTeam);
        return true;
    }

    return false;
}

void BfCapturePoint::SendUpdateWorldState(uint32 field, uint32 value)
{
    for (uint8 team = 0; team < 2; ++team)
        for (ObjectGuid const& guid : ActivePlayers[team])  // send to all players present in the area
            if (Player* player = ObjectAccessor::FindPlayer(guid))
                player->SendUpdateWorldState(field, value);
}

void BfCapturePoint::SendObjectiveComplete(uint32 id, ObjectGuid guid)
{
    uint8 team;
    switch (State)
    {
        case BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE:
            team = 0;
            break;
        case BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE:
            team = 1;
            break;
        default:
            return;
    }

    // send to all players present in the area
    for (ObjectGuid const& playerGuid : ActivePlayers[team])
        if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
            player->KilledMonsterCredit(id, guid);
}

bool BfCapturePoint::IsInsideObjective(Player* player) const
{
    return ActivePlayers[player->GetTeamId()].find(player->GetGUID()) != ActivePlayers[player->GetTeamId()].end();
}
