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
#include "Diagnostics.h"
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

#include <system_error>

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

namespace
{
    uint64 GuidValue(ObjectGuid const& guid)
    {
        return guid.GetRawValue();
    }

    uint64 PlayerGuid(Player const* player)
    {
        return player ? GuidValue(player->GetGUID()) : 0;
    }

    uint32 PlayerTeam(Player const* player)
    {
        return player ? uint32(player->GetTeamId()) : uint32(TEAM_NEUTRAL);
    }

    void AddPlayerArgs(BattlefieldDiagnosticTrace& trace, Player const* player)
    {
        trace.Arg("playerGuid", PlayerGuid(player));
        trace.Arg("team", PlayerTeam(player));
        trace.Arg("level", player ? uint32(player->GetLevel()) : 0u);
    }
}

BattlefieldDiagnosticTrace::BattlefieldDiagnosticTrace(DiagnosticWriter writer, StringLiteralView name) noexcept :
    _guard(std::in_place, std::move(writer), name)
{
}

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

bool Battlefield::SetDiagnosticsEnabled(std::string_view name, bool enable)
{
    if (!enable)
    {
        _diagnosticWriter.reset();
        return true;
    }

    try
    {
        _diagnosticWriter.emplace(sDiagnostics->GetWriter(name));
        return true;
    }
    catch (std::system_error const& error)
    {
        LOG_ERROR("bg.battlefield", "Battlefield diagnostics '{}' disabled: {}", name, error.what());
        _diagnosticWriter.reset();
        return false;
    }
}

BattlefieldDiagnosticTrace Battlefield::Trace(StringLiteralView name) const
{
    if (!_diagnosticWriter)
        return {};

    return BattlefieldDiagnosticTrace(*_diagnosticWriter, name);
}

void Battlefield::RemovePlayerFromTracking(ObjectGuid playerGuid)
{
    uint32 removedInvites = 0;
    uint32 removedQueues = 0;
    uint32 removedKicks = 0;
    uint32 removedZones = 0;
    for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
    {
        removedInvites += uint32(InvitedPlayers[i].erase(playerGuid));
        removedQueues += uint32(PlayersInQueue[i].erase(playerGuid));
        removedKicks += uint32(PlayersWillBeKick[i].erase(playerGuid));
        removedZones += uint32(Players[i].erase(playerGuid));
    }

    if (removedInvites || removedQueues || removedKicks || removedZones)
    {
        auto trace = Trace("Battlefield::RemovePlayerFromTracking");
        trace.Arg("playerGuid", GuidValue(playerGuid));
        trace.Arg("removedInvites", removedInvites);
        trace.Arg("removedQueues", removedQueues);
        trace.Arg("removedKicks", removedKicks);
        trace.Arg("removedZones", removedZones);
    }
}

void Battlefield::HandlePlayerEnterZone(Player* player, uint32 /*zone*/)
{
    auto trace = Trace("Battlefield::HandlePlayerEnterZone");
    AddPlayerArgs(trace, player);
    trace.Arg("warTime", IsWarTime());
    trace.Arg("timer", Timer);
    trace.Arg("startGroupingTimer", StartGroupingTimer);

    RemovePlayerFromTracking(player->GetGUID());

    // Allow scripts to adjust the player's effective team or appearance before
    // any team-based battlefield containers (such as player lists or queues) are updated.
    sScriptMgr->OnBattlefieldPlayerEnterZone(this, player);
    trace.Arg("teamAfterEnterHook", uint32(player->GetTeamId()));

    TryRejoinAfterLogout(player); // relog: auto-rejoin, skip invite below

    // Xinef: do not invite players on taxi
    if (!player->IsInFlight())
    {
        // If battle is started,
        // If not full of players > invite player to join the war
        // If full of players > announce to player that BF is full and kick him after a few second if he doesn't leave
        if (IsWarTime())
        {
            bool const hasVacancy = HasWarVacancy(player->GetTeamId());
            trace.Arg("hasWarVacancy", hasVacancy);
            trace.Arg("warCount", GetPlayersInWarCount(player->GetTeamId()));
            trace.Arg("maxPlayer", MaxPlayer);

            if (hasVacancy)
                InvitePlayerToWar(player);
            else
            {
                /// @todo: Send a packet to announce it to player
                PlayersWillBeKick[player->GetTeamId()][player->GetGUID()] = GameTime::GetGameTime().count() + (player->IsGameMaster() ? 30 * MINUTE : 10);
                trace.Arg("queuedKick", true);
                InvitePlayerToQueue(player);
            }
        }
        else
        {
            // If time left is < 15 minutes invite player to join queue
            if (Timer <= StartGroupingTimer)
            {
                trace.Arg("preBattleQueueInvite", true);
                InvitePlayerToQueue(player);
            }
        }
    }
    else
        trace.Arg("inFlight", true);

    Players[player->GetTeamId()].insert(player->GetGUID());
    trace.Arg("zoneCountAfter", GetPlayersInZoneCount(player->GetTeamId()));
    OnPlayerEnterZone(player);
}

void Battlefield::HandlePlayerLeaveZone(Player* player, uint32 /*zone*/)
{
    auto trace = Trace("Battlefield::HandlePlayerLeaveZone");
    AddPlayerArgs(trace, player);
    trace.Arg("warTime", IsWarTime());

    // Logout still runs full leave-war cleanup, but marks the player for grace-window auto-rejoin.
    bool const isLogout = player->GetSession() && player->GetSession()->PlayerLogout();
    trace.Arg("logout", isLogout);

    if (IsWarTime())
    {
        // If the player is participating to the battle
        if (PlayersInWar[player->GetTeamId()].erase(player->GetGUID()))
        {
            trace.Arg("removedFromWar", true);
            if (isLogout)
            {
                LogoutGracePlayers[player->GetTeamId()][player->GetGUID()] =
                    GameTime::GetGameTime().count() + LOGOUT_GRACE_SECONDS;
                trace.Arg("logoutGraceUntil", uint64(LogoutGracePlayers[player->GetTeamId()][player->GetGUID()]));
            }
            else
                player->GetSession()->SendBfLeaveMessage(BattleId);

            if (Group* group = player->GetGroup()) // Remove the player from the raid group
                if (group->isBFGroup())
                {
                    trace.Arg("removedFromBfGroupGuid", GuidValue(group->GetGUID()));
                    group->RemoveMember(player->GetGUID());
                }

            OnPlayerLeaveWar(player);
            sScriptMgr->OnBattlefieldPlayerLeaveWar(this, player);
        }
    }

    for (BfCapturePoint* cp : CapturePoints)
        cp->HandlePlayerLeave(player);

    RemovePlayerFromTracking(player->GetGUID());
    SendRemoveWorldStates(player);
    RemovePlayerFromResurrectQueue(player->GetGUID());
    OnPlayerLeaveZone(player);
}

bool Battlefield::Update(uint32 diff)
{
    if (Timer <= diff)
    {
        auto trace = Trace("Battlefield::UpdateTimerExpired");
        trace.Arg("diff", diff);
        trace.Arg("timer", Timer);
        trace.Arg("warTime", IsWarTime());

        uint32 sessionLimit = sWorld->getIntConfig(CONFIG_WINTERGRASP_SKIP_BATTLE_SESSION_COUNT);
        bool tooManySessions = sessionLimit && !IsWarTime()
            && sWorldSessionMgr->GetActiveSessionCount() > sessionLimit;
        trace.Arg("enabled", IsEnabled());
        trace.Arg("sessionLimit", sessionLimit);
        trace.Arg("activeSessions", uint32(sWorldSessionMgr->GetActiveSessionCount()));
        trace.Arg("tooManySessions", tooManySessions);

        if (!IsEnabled() || tooManySessions)
        {
            trace.Arg("action", "endDisabledOrOverloaded");
            Active = true;
            EndBattle(false);
            return false;
        }
        // Battlefield ends on time
        if (IsWarTime())
        {
            trace.Arg("action", "endByTimer");
            EndBattle(true);
        }
        else // Time to start a new battle!
        {
            trace.Arg("action", "startBattle");
            StartBattle();
        }
    }
    else
        Timer -= diff;

    if (!IsEnabled())
        return false;

    // Invite players a few minutes before the battle's beginning
    if (!IsWarTime() && !StartGrouping && Timer <= StartGroupingTimer)
    {
        auto trace = Trace("Battlefield::StartGrouping");
        trace.Arg("timer", Timer);
        trace.Arg("startGroupingTimer", StartGroupingTimer);
        trace.Arg("allianceZone", GetPlayersInZoneCount(TEAM_ALLIANCE));
        trace.Arg("hordeZone", GetPlayersInZoneCount(TEAM_HORDE));

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
    auto trace = Trace("Battlefield::InvitePlayersInZoneToQueue");
    trace.Arg("allianceZone", GetPlayersInZoneCount(TEAM_ALLIANCE));
    trace.Arg("hordeZone", GetPlayersInZoneCount(TEAM_HORDE));

    ForEachPlayerInZone([this](Player* player) { InvitePlayerToQueue(player); });
}

void Battlefield::InvitePlayerToQueue(Player* player)
{
    auto trace = Trace("Battlefield::InvitePlayerToQueue");
    AddPlayerArgs(trace, player);
    trace.Arg("queueBefore", uint32(PlayersInQueue[player->GetTeamId()].size()));
    trace.Arg("otherQueue", uint32(PlayersInQueue[GetOtherTeam(player->GetTeamId())].size()));
    trace.Arg("minPlayer", MinPlayer);

    if (PlayersInQueue[player->GetTeamId()].count(player->GetGUID()))
    {
        trace.Arg("result", "alreadyQueued");
        return;
    }

    if (PlayersInQueue[player->GetTeamId()].size() <= MinPlayer || PlayersInQueue[GetOtherTeam(player->GetTeamId())].size() >= MinPlayer)
    {
        trace.Arg("result", "sentInvite");
        player->GetSession()->SendBfInvitePlayerToQueue(BattleId);
    }
    else
        trace.Arg("result", "balanceGate");
}

void Battlefield::InvitePlayersInQueueToWar()
{
    auto trace = Trace("Battlefield::InvitePlayersInQueueToWar");
    trace.Arg("allianceQueue", uint32(PlayersInQueue[TEAM_ALLIANCE].size()));
    trace.Arg("hordeQueue", uint32(PlayersInQueue[TEAM_HORDE].size()));

    for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
    {
        GuidUnorderedSet copy(PlayersInQueue[team]);
        trace.Arg("team", uint32(team));
        trace.Arg("copiedQueue", uint32(copy.size()));
        for (ObjectGuid const& guid : copy)
            if (Player* player = ObjectAccessor::FindPlayer(guid))
            {
                bool const hasVacancy = HasWarVacancy(player->GetTeamId());
                if (hasVacancy)
                    InvitePlayerToWar(player);
            }
        PlayersInQueue[team].clear();
        trace.Arg("queueAfterClear", uint32(PlayersInQueue[team].size()));
    }
}

void Battlefield::InvitePlayersInZoneToWar()
{
    auto trace = Trace("Battlefield::InvitePlayersInZoneToWar");
    trace.Arg("allianceZone", GetPlayersInZoneCount(TEAM_ALLIANCE));
    trace.Arg("hordeZone", GetPlayersInZoneCount(TEAM_HORDE));
    trace.Arg("allianceWar", GetPlayersInWarCount(TEAM_ALLIANCE));
    trace.Arg("hordeWar", GetPlayersInWarCount(TEAM_HORDE));

    ForEachPlayerInZone([this](Player* player)
    {
        if (IsPlayerInWarOrInvited(player))
            return;

        bool const hasVacancy = HasWarVacancy(player->GetTeamId());

        if (hasVacancy)
            InvitePlayerToWar(player);
        else if (!PlayersWillBeKick[player->GetTeamId()].count(player->GetGUID())) // Battlefield is full of players
        {
            PlayersWillBeKick[player->GetTeamId()][player->GetGUID()] = GameTime::GetGameTime().count() + 10;
            auto playerTrace = Trace("Battlefield::InvitePlayersInZoneToWar::QueuedKick");
            AddPlayerArgs(playerTrace, player);
            playerTrace.Arg("result", "queuedKick");
        }
    });
}

void Battlefield::InvitePlayerToWar(Player* player)
{
    auto trace = Trace("Battlefield::InvitePlayerToWar");
    AddPlayerArgs(trace, player);

    if (!player)
    {
        trace.Arg("result", "nullPlayer");
        return;
    }

    trace.Arg("warCount", GetPlayersInWarCount(player->GetTeamId()));
    trace.Arg("maxPlayer", MaxPlayer);

    if (player->IsGameMaster())
    {
        trace.Arg("result", "gameMaster");
        return;
    }

    /// @todo : needed ?
    if (player->IsInFlight())
    {
        trace.Arg("result", "inFlight");
        return;
    }

    if (player->InBattleground())
    {
        PlayersInQueue[player->GetTeamId()].erase(player->GetGUID());
        trace.Arg("result", "inBattlegroundRemovedFromQueue");
        return;
    }

    // If the player does not match minimal level requirements for the battlefield, kick him
    if (player->GetLevel() < MinLevel)
    {
        if (!PlayersWillBeKick[player->GetTeamId()].count(player->GetGUID()))
            PlayersWillBeKick[player->GetTeamId()][player->GetGUID()] = GameTime::GetGameTime().count() + 10;
        trace.Arg("result", "levelTooLowQueuedKick");
        trace.Arg("minLevel", MinLevel);
        return;
    }

    // Check if player is not already in war
    if (IsPlayerInWarOrInvited(player))
    {
        trace.Arg("result", "alreadyInWarOrInvited");
        return;
    }

    sScriptMgr->OnBattlefieldBeforeInvitePlayerToWar(this, player);
    trace.Arg("teamAfterBeforeInviteHook", uint32(player->GetTeamId()));

    PlayersWillBeKick[player->GetTeamId()].erase(player->GetGUID());
    InvitedPlayers[player->GetTeamId()][player->GetGUID()] = GameTime::GetGameTime().count() + TimeForAcceptInvite;
    trace.Arg("inviteExpiresAt", uint64(InvitedPlayers[player->GetTeamId()][player->GetGUID()]));
    trace.Arg("invitedCount", uint32(InvitedPlayers[player->GetTeamId()].size()));
    trace.Arg("result", "sentInvite");
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
        {
            auto playerTrace = Trace("Battlefield::KickAfkPlayers::Kick");
            AddPlayerArgs(playerTrace, player);
            player->TeleportTo(KickPosition);
        }
    });
}

void Battlefield::KickPlayerFromBattlefield(ObjectGuid guid)
{
    auto trace = Trace("Battlefield::KickPlayerFromBattlefield");
    trace.Arg("playerGuid", GuidValue(guid));

    if (Player* player = ObjectAccessor::FindPlayer(guid))
    {
        AddPlayerArgs(trace, player);
        trace.Arg("zone", player->GetZoneId());
        trace.Arg("trackedInWar", bool(PlayersInWar[player->GetTeamId()].count(guid)));

        if (player->GetZoneId() == GetZoneId() && !player->IsGameMaster()
            && !PlayersInWar[player->GetTeamId()].count(guid))
        {
            player->TeleportTo(KickPosition);
            // Eagerly drop zone tracking: the teleport's zone change does not
            // propagate until the next Player::Update, so callers iterating
            // Players[team] in the same tick would otherwise still see them.
            for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
                Players[i].erase(guid);
            trace.Arg("result", "teleported");
        }
        else
            trace.Arg("result", "ignored");
    }
    else
        trace.Arg("result", "playerNotFound");
}

void Battlefield::StartBattle()
{
    auto trace = Trace("Battlefield::StartBattle");
    trace.Arg("active", Active);
    trace.Arg("allianceZone", GetPlayersInZoneCount(TEAM_ALLIANCE));
    trace.Arg("hordeZone", GetPlayersInZoneCount(TEAM_HORDE));
    trace.Arg("allianceQueue", uint32(PlayersInQueue[TEAM_ALLIANCE].size()));
    trace.Arg("hordeQueue", uint32(PlayersInQueue[TEAM_HORDE].size()));

    if (Active)
    {
        trace.Arg("result", "alreadyActive");
        return;
    }

    for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
    {
        PlayersInWar[team].clear();
        Groups[team].clear();
        LogoutGracePlayers[team].clear();
    }

    Timer = BattleTime;
    Active = true;
    trace.Arg("battleTime", BattleTime);

    // Schedule war-only periodic timers
    _scheduler.Schedule(1s, BATTLEFIELD_TIMER_GROUP_WAR, [this](TaskContext context)
    {
        KickAfkPlayers();
        context.Repeat(20s);
    });

    _scheduler.Schedule(1s, BATTLEFIELD_TIMER_GROUP_WAR, [this](TaskContext context)
    {
        time_t const now = GameTime::GetGameTime().count();

        // Send eject so the 3.3.5 client closes its popup (it does not on its
        // own when the timer hits zero), then drop the entry and teleport.
        for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
        {
            std::vector<ObjectGuid> expired;
            for (auto const& [guid, expireAt] : InvitedPlayers[team])
                if (expireAt <= now)
                    expired.push_back(guid);

            for (ObjectGuid const& guid : expired)
            {
                if (Player* player = ObjectAccessor::FindPlayer(guid))
                    player->GetSession()->SendBfLeaveMessage(BattleId, BF_LEAVE_REASON_EXITED);
                InvitedPlayers[team].erase(guid);
                KickPlayerFromBattlefield(guid);
            }
        }

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
    trace.Arg("allianceInvited", uint32(InvitedPlayers[TEAM_ALLIANCE].size()));
    trace.Arg("hordeInvited", uint32(InvitedPlayers[TEAM_HORDE].size()));
}

void Battlefield::EndBattle(bool endByTimer)
{
    auto trace = Trace("Battlefield::EndBattle");
    trace.Arg("active", Active);
    trace.Arg("endByTimer", endByTimer);
    trace.Arg("defenderBefore", uint32(GetDefenderTeam()));
    trace.Arg("allianceWar", uint32(PlayersInWar[TEAM_ALLIANCE].size()));
    trace.Arg("hordeWar", uint32(PlayersInWar[TEAM_HORDE].size()));

    if (!Active)
    {
        trace.Arg("result", "notActive");
        return;
    }

    Active = false;

    _scheduler.CancelGroup(BATTLEFIELD_TIMER_GROUP_WAR);

    StartGrouping = false;

    if (!endByTimer)
        SetDefenderTeam(GetAttackerTeam());
    trace.Arg("defenderAfter", uint32(GetDefenderTeam()));

    if (GetDefenderTeam() == TEAM_ALLIANCE)
        DoPlaySoundToAll(BF_ALLIANCE_WINS);
    else
        DoPlaySoundToAll(BF_HORDE_WINS);

    // Hook runs BEFORE OnBattleEnd so subscribers can read PlayersInWar
    // while it is still populated (OnBattleEnd hands out rewards and then
    // clears the set).
    sScriptMgr->OnBattlefieldWarEnd(this, endByTimer);
    OnBattleEnd(endByTimer);

    for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
    {
        for (ObjectGuid const& guid : Groups[team])
            if (Group* group = sGroupMgr->GetGroupByGUID(guid.GetCounter()))
                group->Disband();
        Groups[team].clear();
    }

    // Reset battlefield timer
    Timer = NoWarBattleTime;
    SendInitWorldStatesToAll();
    SendUpdateWorldStates();
    trace.Arg("nextTimer", Timer);
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
    auto trace = Trace("Battlefield::PlayerAcceptInviteToQueue");
    AddPlayerArgs(trace, player);
    trace.Arg("queueBefore", uint32(PlayersInQueue[player->GetTeamId()].size()));

    // Add player in queue
    PlayersInQueue[player->GetTeamId()].insert(player->GetGUID());
    trace.Arg("queueAfter", uint32(PlayersInQueue[player->GetTeamId()].size()));
    // Send notification
    player->GetSession()->SendBfQueueInviteResponse(BattleId, ZoneId);
}

// Called in WorldSession::HandleBfExitRequest
void Battlefield::AskToLeaveQueue(Player* player)
{
    auto trace = Trace("Battlefield::AskToLeaveQueue");
    AddPlayerArgs(trace, player);
    trace.Arg("queueBefore", uint32(PlayersInQueue[player->GetTeamId()].size()));

    // Remove player from queue
    PlayersInQueue[player->GetTeamId()].erase(player->GetGUID());
    trace.Arg("queueAfter", uint32(PlayersInQueue[player->GetTeamId()].size()));
    // Send notification
    player->GetSession()->SendBfLeaveMessage(BattleId, BF_LEAVE_REASON_CLOSE);
}

// Called in WorldSession::HandleHearthAndResurrect
void Battlefield::PlayerAskToLeave(Player* player)
{
    auto trace = Trace("Battlefield::PlayerAskToLeave");
    AddPlayerArgs(trace, player);

    // Player leaving Wintergrasp, teleport to homebind position.
    player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, player->GetOrientation());
}

// Called in WorldSession::HandleBfEntryInviteResponse
void Battlefield::PlayerAcceptInviteToWar(Player* player)
{
    auto trace = Trace("Battlefield::PlayerAcceptInviteToWar");
    AddPlayerArgs(trace, player);
    trace.Arg("warTime", IsWarTime());

    if (!IsWarTime())
    {
        trace.Arg("result", "notWarTime");
        return;
    }

    // Reject unknown / expired invites; the kick task only sweeps every 5s.
    TeamId const invitedTeam = player->GetTeamId();
    auto itr = InvitedPlayers[invitedTeam].find(player->GetGUID());
    trace.Arg("invitedTeam", uint32(invitedTeam));
    trace.Arg("inviteFound", itr != InvitedPlayers[invitedTeam].end());
    if (itr == InvitedPlayers[invitedTeam].end()
        || itr->second <= GameTime::GetGameTime().count())
    {
        trace.Arg("result", "inviteMissingOrExpired");
        return;
    }
    trace.Arg("inviteExpiresAt", uint64(itr->second));

    sScriptMgr->OnBattlefieldPlayerJoinWar(this, player);
    trace.Arg("teamAfterJoinHook", uint32(player->GetTeamId()));

    if (AddOrSetPlayerToCorrectBfGroup(player))
    {
        player->GetSession()->SendBfEntered(BattleId);
        PlayersInWar[player->GetTeamId()].insert(player->GetGUID());
        // Use pre-hook team: JoinWar may have just reassigned GetTeamId().
        InvitedPlayers[invitedTeam].erase(player->GetGUID());

        if (player->isAFK())
            player->ToggleAFK();

        OnPlayerJoinWar(player);
        trace.Arg("result", "joined");
        trace.Arg("warCount", GetPlayersInWarCount(player->GetTeamId()));
    }
    else
        trace.Arg("result", "groupRejected");
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
    auto trace = Trace("Battlefield::AddOrSetPlayerToCorrectBfGroup");
    AddPlayerArgs(trace, player);

    if (!player->IsInWorld())
    {
        trace.Arg("result", "notInWorld");
        return false;
    }

    if (player->GetGroup() && (player->GetGroup()->isBGGroup() || player->GetGroup()->isBFGroup()))
    {
        LOG_INFO("misc", "Battlefield::AddOrSetPlayerToCorrectBfGroup - player is already in {} group!", (player->GetGroup()->isBGGroup() ? "BG" : "BF"));
        trace.Arg("result", "alreadyInBgOrBfGroup");
        trace.Arg("groupGuid", GuidValue(player->GetGroup()->GetGUID()));
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
        trace.Arg("groupAction", "created");
        trace.Arg("groupGuid", GuidValue(group->GetGUID()));
    }
    else if (group->IsMember(player->GetGUID()))
    {
        uint8 subgroup = group->GetMemberGroup(player->GetGUID());
        player->SetBattlegroundOrBattlefieldRaid(group, subgroup);
        trace.Arg("groupAction", "reboundExistingMember");
        trace.Arg("groupGuid", GuidValue(group->GetGUID()));
        trace.Arg("subgroup", uint32(subgroup));
    }
    else
    {
        group->AddMember(player);
        trace.Arg("groupAction", "addedToExisting");
        trace.Arg("groupGuid", GuidValue(group->GetGUID()));
    }

    trace.Arg("result", "ok");
    return true;
}

void Battlefield::TryRejoinAfterLogout(Player* player)
{
    auto trace = Trace("Battlefield::TryRejoinAfterLogout");
    AddPlayerArgs(trace, player);

    ObjectGuid const guid = player->GetGUID();
    time_t const now = GameTime::GetGameTime().count();

    // Consume the marker and honor its grace window (check both teams; team may have changed).
    bool pending = false;
    for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
        if (auto itr = LogoutGracePlayers[team].find(guid); itr != LogoutGracePlayers[team].end())
        {
            pending = itr->second > now;
            trace.Arg("markerTeam", uint32(team));
            trace.Arg("markerExpiresAt", uint64(itr->second));
            LogoutGracePlayers[team].erase(itr);
        }
    trace.Arg("pending", pending);
    trace.Arg("warTime", IsWarTime());
    trace.Arg("hasVacancy", HasWarVacancy(player->GetTeamId()));

    // Vacancy gate mirrors HandlePlayerEnterZone (full team -> queue path). Pre-hook:
    // we can't abort after JoinWar, which may already have mutated module state.
    if (!pending || !IsWarTime() || !HasWarVacancy(player->GetTeamId()))
    {
        trace.Arg("result", "notEligible");
        return;
    }

    if (Group* current = player->GetGroup())
        if (current->isBGGroup() || current->isBFGroup())
        {
            trace.Arg("result", "alreadyInBgOrBfGroup");
            trace.Arg("groupGuid", GuidValue(current->GetGUID()));
            return;
        }

    // Rejoin via the normal join path: firing JoinWar lets modules rebuild
    // per-session (Player*-keyed) state and pick the team before the raid bind.
    sScriptMgr->OnBattlefieldPlayerJoinWar(this, player);
    trace.Arg("teamAfterJoinHook", uint32(player->GetTeamId()));

    if (AddOrSetPlayerToCorrectBfGroup(player))
    {
        player->GetSession()->SendBfEntered(BattleId);
        PlayersInWar[player->GetTeamId()].insert(guid);
        OnPlayerJoinWar(player);
        trace.Arg("result", "joined");
        trace.Arg("warCount", GetPlayersInWarCount(player->GetTeamId()));
    }
    else
        trace.Arg("result", "groupRejected");
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

void Battlefield::AddPlayerToResurrectQueue(ObjectGuid /*npcGuid*/, ObjectGuid playerGuid)
{
    Player* player = ObjectAccessor::FindPlayer(playerGuid);
    if (!player)
        return;

    player->CastSpell(player, SPELL_WAITING_FOR_RESURRECT, true);
}

void Battlefield::RemovePlayerFromResurrectQueue(ObjectGuid playerGuid)
{
    Player* player = ObjectAccessor::FindPlayer(playerGuid);
    if (!player)
        return;

    player->RemoveAurasDueToSpell(SPELL_WAITING_FOR_RESURRECT);
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

void BfGraveyard::GiveControlTo(TeamId team)
{
    auto trace = Bf->Trace("Battlefield::BfGraveyard::GiveControlTo");
    trace.Arg("graveyardId", GraveyardId);
    trace.Arg("teamBefore", uint32(ControlTeam));
    trace.Arg("teamAfter", uint32(team));

    ControlTeam = team;
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
    return ActivePlayers.insert(player->GetGUID()).second;
}

GuidUnorderedSet::iterator BfCapturePoint::HandlePlayerLeave(Player* player)
{
    if (GameObject* go = GetCapturePointGo(player))
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldState1, 0);

    GuidUnorderedSet::iterator current = ActivePlayers.find(player->GetGUID());

    if (current == ActivePlayers.end())
        return current; // return end()

    return ActivePlayers.erase(current);
}

void BfCapturePoint::SendChangePhase()
{
    GameObject* capturePoint = GetCapturePointGo();
    if (!capturePoint)
        return;

    for (ObjectGuid const& guid : ActivePlayers)  // send to all players present in the area
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

    // Single pass over the existing set: drop leavers, count survivors per team.
    uint32 counts[PVP_TEAMS_COUNT] = { 0, 0 };
    for (auto itr = ActivePlayers.begin(); itr != ActivePlayers.end();)
    {
        Player* player = ObjectAccessor::FindPlayer(*itr);
        if (player && capturePoint->IsWithinDistInMap(player, radius) && player->IsOutdoorPvPActive())
        {
            ++counts[player->GetTeamId()];
            ++itr;
            continue;
        }

        itr = (player ? HandlePlayerLeave(player) : ActivePlayers.erase(itr));
    }

    std::list<Player*> players;
    Acore::AnyPlayerInObjectRangeCheck checker(capturePoint, radius);
    Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(capturePoint, players, checker);
    Cell::VisitObjects(capturePoint, searcher, radius);

    for (Player* player : players)
        if (player->IsOutdoorPvPActive())
            if (ActivePlayers.insert(player->GetGUID()).second)
            {
                HandlePlayerEnter(player);
                ++counts[player->GetTeamId()];
            }

    // get the difference of numbers
    float factDiff = ((float)counts[TEAM_ALLIANCE] - (float)counts[TEAM_HORDE]) * diff / BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL;
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
        auto trace = Bf->Trace("Battlefield::BfCapturePoint::Update");
        trace.Arg("capturePointGuid", CapturePoint.GetRawValue());
        trace.Arg("entry", CapturePointEntry);
        trace.Arg("diff", diff);
        trace.Arg("alliancePlayers", counts[TEAM_ALLIANCE]);
        trace.Arg("hordePlayers", counts[TEAM_HORDE]);
        trace.Arg("activePlayers", uint32(ActivePlayers.size()));
        trace.Arg("challenger", uint32(challengerId));
        trace.Arg("valueBefore", double(oldValue));
        trace.Arg("teamBefore", uint32(oldTeam));
        trace.Arg("stateBefore", uint32(OldState));
        trace.Arg("factDiff", double(factDiff));
        trace.Arg("valueAfter", double(Value));
        trace.Arg("teamAfter", uint32(Team));
        trace.Arg("stateAfter", uint32(State));
        if (oldTeam != Team)
        {
            trace.Arg("result", "teamChanged");
            ChangeTeam(oldTeam);
        }
        else
            trace.Arg("result", "stateChanged");
        return true;
    }

    return false;
}

void BfCapturePoint::SendUpdateWorldState(uint32 field, uint32 value)
{
    for (ObjectGuid const& guid : ActivePlayers)  // send to all players present in the area
        if (Player* player = ObjectAccessor::FindPlayer(guid))
            player->SendUpdateWorldState(field, value);
}

void BfCapturePoint::SendObjectiveComplete(uint32 id, ObjectGuid guid)
{
    TeamId winner;
    switch (State)
    {
        case BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE:
            winner = TEAM_ALLIANCE;
            break;
        case BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE:
            winner = TEAM_HORDE;
            break;
        default:
            return;
    }

    // Credit only players on the controlling team. Team is read from the
    // player at iteration time, not at insert time, so players whose
    // GetTeamId() changed mid-stay get credit on their current side.
    for (ObjectGuid const& playerGuid : ActivePlayers)
        if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
            if (player->GetTeamId() == winner)
                player->KilledMonsterCredit(id, guid);
}

bool BfCapturePoint::IsInsideObjective(Player* player) const
{
    return ActivePlayers.find(player->GetGUID()) != ActivePlayers.end();
}
