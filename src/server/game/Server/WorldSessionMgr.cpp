/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Chat.h"
#include "ChatPackets.h"
#include "GameTime.h"
#include "Metric.h"
#include "Player.h"
#include "World.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"

WorldSessionMgr* WorldSessionMgr::Instance()
{
    static WorldSessionMgr instance;
    return &instance;
}

WorldSessionMgr::WorldSessionMgr()
{
    _playerLimit = 0;
    _maxActiveSessionCount = 0;
    _maxQueuedSessionCount = 0;
    _playerCount = 0;
    _maxPlayerCount = 0;
}

WorldSessionMgr::~WorldSessionMgr()
{
    ///- Empty the kicked session set
    while (!_sessions.empty())
    {
        // not remove from queue, prevent loading new sessions
        delete _sessions.begin()->second;
        _sessions.erase(_sessions.begin());
    }

    while (!_offlineSessions.empty())
    {
        delete _offlineSessions.begin()->second;
        _offlineSessions.erase(_offlineSessions.begin());
    }
}

/// Find a session by its id
WorldSession* WorldSessionMgr::FindSession(uint32 id) const
{
    SessionMap::const_iterator itr = _sessions.find(id);

    if (itr != _sessions.end())
        return itr->second;                                 // also can return nullptr for kicked session
    else
        return nullptr;
}

WorldSession* WorldSessionMgr::FindOfflineSession(uint32 id) const
{
    SessionMap::const_iterator itr = _offlineSessions.find(id);
    if (itr != _offlineSessions.end())
        return itr->second;
    else
        return nullptr;
}

WorldSession* WorldSessionMgr::FindOfflineSessionForCharacterGUID(ObjectGuid::LowType guidLow) const
{
    if (_offlineSessions.empty())
        return nullptr;

    for (SessionMap::const_iterator itr = _offlineSessions.begin(); itr != _offlineSessions.end(); ++itr)
        if (itr->second->GetGuidLow() == guidLow)
            return itr->second;

    return nullptr;
}

void WorldSessionMgr::UpdateSessions(uint32 const diff)
{
    {
        METRIC_DETAILED_NO_THRESHOLD_TIMER("world_update_time",
            METRIC_TAG("type", "Add sessions"),
            METRIC_TAG("parent_type", "Update sessions"));

        ///- Add new sessions
        WorldSession* sess = nullptr;
        while (_addSessQueue.next(sess))
        {
            AddSession_(sess);
        }
    }

    ///- Then send an update signal to remaining ones
    for (SessionMap::iterator itr = _sessions.begin(), next; itr != _sessions.end(); itr = next)
    {
        next = itr;
        ++next;

        ///- and remove not active sessions from the list
        WorldSession* pSession = itr->second;
        WorldSessionFilter updater(pSession);

        // pussywizard:
        if (pSession->HandleSocketClosed())
        {
            if (!RemoveQueuedPlayer(pSession) && sWorld->getIntConfig(CONFIG_INTERVAL_DISCONNECT_TOLERANCE))
                _disconnects[pSession->GetAccountId()] = GameTime::GetGameTime().count();
            _sessions.erase(itr);
            // there should be no offline session if current one is logged onto a character
            SessionMap::iterator iter;
            if ((iter = _offlineSessions.find(pSession->GetAccountId())) != _offlineSessions.end())
            {
                WorldSession* tmp = iter->second;
                _offlineSessions.erase(iter);
                delete tmp;
            }
            pSession->SetOfflineTime(GameTime::GetGameTime().count());
            _offlineSessions[pSession->GetAccountId()] = pSession;
            continue;
        }

        [[maybe_unused]] uint32 currentSessionId = itr->first;
        METRIC_DETAILED_TIMER("world_update_sessions_time", METRIC_TAG("account_id", std::to_string(currentSessionId)));

        if (!pSession->Update(diff, updater))
        {
            if (!RemoveQueuedPlayer(pSession) && sWorld->getIntConfig(CONFIG_INTERVAL_DISCONNECT_TOLERANCE))
                _disconnects[pSession->GetAccountId()] = GameTime::GetGameTime().count();
            _sessions.erase(itr);
            delete pSession;
        }
    }

    // pussywizard:
    if (_offlineSessions.empty())
        return;
    uint32 currTime = GameTime::GetGameTime().count();
    for (SessionMap::iterator itr = _offlineSessions.begin(), next; itr != _offlineSessions.end(); itr = next)
    {
        next = itr;
        ++next;
        WorldSession* pSession = itr->second;
        if (!pSession->GetPlayer() || pSession->GetOfflineTime() + 60 < currTime || pSession->IsKicked())
        {
            _offlineSessions.erase(itr);
            delete pSession;
        }
    }
}

/// Remove a given session
bool WorldSessionMgr::KickSession(uint32 id)
{
    ///- Find the session, kick the user, but we can't delete session at this moment to prevent iterator invalidation
    SessionMap::const_iterator itr = _sessions.find(id);

    if (itr != _sessions.end() && itr->second)
    {
        if (itr->second->PlayerLoading())
            return false;

        itr->second->KickPlayer("KickSession", false);
    }

    return true;
}

/// Kick (and save) all players
void WorldSessionMgr::KickAll()
{
    _queuedPlayer.clear();                                 // prevent send queue update packet and login queued sessions

    // session not removed at kick and will removed in next update tick
    for (SessionMap::const_iterator itr = _sessions.begin(); itr != _sessions.end(); ++itr)
        itr->second->KickPlayer("KickAll sessions");

    // pussywizard: kick offline sessions
    for (SessionMap::const_iterator itr = _offlineSessions.begin(); itr != _offlineSessions.end(); ++itr)
        itr->second->KickPlayer("KickAll offline sessions");
}

/// Kick (and save) all players with security level less `sec`
void WorldSessionMgr::KickAllLess(AccountTypes sec)
{
    // session not removed at kick and will removed in next update tick
    for (SessionMap::const_iterator itr = _sessions.begin(); itr != _sessions.end(); ++itr)
        if (itr->second->GetSecurity() < sec)
            itr->second->KickPlayer("KickAllLess");
}

void WorldSessionMgr::AddSession(WorldSession* session)
{
    _addSessQueue.add(session);
}

void WorldSessionMgr::AddQueuedPlayer(WorldSession* session)
{
    session->SetInQueue(true);
    _queuedPlayer.push_back(session);

    // The 1st SMSG_AUTH_RESPONSE needs to contain other info too.
    session->SendAuthResponse(AUTH_WAIT_QUEUE, false, GetQueuePos(session));
}

bool WorldSessionMgr::RemoveQueuedPlayer(WorldSession* session)
{
    uint32 sessions = GetActiveSessionCount();

    uint32 position = 1;
    Queue::iterator iter = _queuedPlayer.begin();

    // search to remove and count skipped positions
    bool found = false;

    for (; iter != _queuedPlayer.end(); ++iter, ++position)
    {
        if (*iter == session)
        {
            session->SetInQueue(false);
            session->ResetTimeOutTime(false);
            iter = _queuedPlayer.erase(iter);
            found = true;
            break;
        }
    }

    // if session not queued then it was an active session
    if (!found)
    {
        ASSERT(sessions > 0);
        --sessions;
    }

    // accept first in queue
    if ((!GetPlayerAmountLimit() || sessions < GetPlayerAmountLimit()) && !_queuedPlayer.empty())
    {
        WorldSession* pop_sess = _queuedPlayer.front();
        pop_sess->InitializeSession();
        _queuedPlayer.pop_front();

        // update iter to point first queued socket or end() if queue is empty now
        iter = _queuedPlayer.begin();
        position = 1;
    }

    // update queue position from iter to end()
    for (; iter != _queuedPlayer.end(); ++iter, ++position)
        (*iter)->SendAuthWaitQueue(position);

    return found;
}

int32 WorldSessionMgr::GetQueuePos(WorldSession* session)
{
    uint32 position = 1;

    for (Queue::const_iterator iter = _queuedPlayer.begin(); iter != _queuedPlayer.end(); ++iter, ++position)
        if ((*iter) == session)
            return position;

    return 0;
}

void WorldSessionMgr::AddSession_(WorldSession* session)
{
    ASSERT(session);

    // kick existing session with same account (if any)
    // if character on old session is being loaded, then return
    if (!KickSession(session->GetAccountId()))
    {
        session->KickPlayer("kick existing session with same account");
        delete session; // session not added yet in session list, so not listed in queue
        return;
    }

    SessionMap::const_iterator old = _sessions.find(session->GetAccountId());
    if (old != _sessions.end())
    {
        WorldSession* oldSession = old->second;

        if (!RemoveQueuedPlayer(oldSession) && sWorld->getIntConfig(CONFIG_INTERVAL_DISCONNECT_TOLERANCE))
            _disconnects[session->GetAccountId()] = GameTime::GetGameTime().count();

        // pussywizard:
        if (oldSession->HandleSocketClosed())
        {
            // there should be no offline session if current one is logged onto a character
            SessionMap::iterator iter;
            if ((iter = _offlineSessions.find(oldSession->GetAccountId())) != _offlineSessions.end())
            {
                WorldSession* tmp = iter->second;
                _offlineSessions.erase(iter);
                delete tmp;
            }
            oldSession->SetOfflineTime(GameTime::GetGameTime().count());
            _offlineSessions[oldSession->GetAccountId()] = oldSession;
        }
        else
        {
            delete oldSession;
        }
    }

    _sessions[session->GetAccountId()] = session;

    uint32 Sessions = GetActiveAndQueuedSessionCount();
    uint32 pLimit = GetPlayerAmountLimit();

    // don't count this session when checking player limit
    --Sessions;

    if (pLimit > 0 && Sessions >= pLimit && AccountMgr::IsPlayerAccount(session->GetSecurity()) && !session->CanSkipQueue() && !HasRecentlyDisconnected(session))
    {
        AddQueuedPlayer(session);
        UpdateMaxSessionCounters();
        return;
    }

    session->InitializeSession();

    UpdateMaxSessionCounters();
}

bool WorldSessionMgr::HasRecentlyDisconnected(WorldSession* session)
{
    if (!session)
        return false;

    if (uint32 tolerance = sWorld->getIntConfig(CONFIG_INTERVAL_DISCONNECT_TOLERANCE))
    {
        for (DisconnectMap::iterator i = _disconnects.begin(); i != _disconnects.end();)
        {
            if ((GameTime::GetGameTime().count() - i->second) < tolerance)
            {
                if (i->first == session->GetAccountId())
                    return true;
                ++i;
            }
            else
                _disconnects.erase(i++);
        }
    }
    return false;
}

void WorldSessionMgr::UpdateMaxSessionCounters()
{
    _maxActiveSessionCount = std::max(_maxActiveSessionCount, uint32(_sessions.size() - _queuedPlayer.size()));
    _maxQueuedSessionCount = std::max(_maxQueuedSessionCount, uint32(_queuedPlayer.size()));
}

/// Send a packet to all players (except self if mentioned)
void WorldSessionMgr::SendGlobalMessage(WorldPacket const* packet, WorldSession* self, TeamId teamId)
{
    SessionMap::const_iterator itr;
    for (itr = _sessions.begin(); itr != _sessions.end(); ++itr)
    {
        if (itr->second &&
            itr->second->GetPlayer() &&
            itr->second->GetPlayer()->IsInWorld() &&
            itr->second != self &&
            (teamId == TEAM_NEUTRAL || itr->second->GetPlayer()->GetTeamId() == teamId))
        {
            itr->second->SendPacket(packet);
        }
    }
}

/// Send a packet to all GMs (except self if mentioned)
void WorldSessionMgr::SendGlobalGMMessage(WorldPacket const* packet, WorldSession* self, TeamId teamId)
{
    SessionMap::iterator itr;
    for (itr = _sessions.begin(); itr != _sessions.end(); ++itr)
    {
        if (itr->second &&
            itr->second->GetPlayer() &&
            itr->second->GetPlayer()->IsInWorld() &&
            itr->second != self &&
            !AccountMgr::IsPlayerAccount(itr->second->GetSecurity()) &&
            (teamId == TEAM_NEUTRAL || itr->second->GetPlayer()->GetTeamId() == teamId))
        {
            itr->second->SendPacket(packet);
        }
    }
}

/// Send a packet to all players (or players selected team) in the zone (except self if mentioned)
bool WorldSessionMgr::SendZoneMessage(uint32 zone, WorldPacket const* packet, WorldSession* self, TeamId teamId)
{
    bool foundPlayerToSend = false;
    SessionMap::const_iterator itr;

    for (itr = _sessions.begin(); itr != _sessions.end(); ++itr)
    {
        if (itr->second &&
            itr->second->GetPlayer() &&
            itr->second->GetPlayer()->IsInWorld() &&
            itr->second->GetPlayer()->GetZoneId() == zone &&
            itr->second != self &&
            (teamId == TEAM_NEUTRAL || itr->second->GetPlayer()->GetTeamId() == teamId))
        {
            itr->second->SendPacket(packet);
            foundPlayerToSend = true;
        }
    }

    return foundPlayerToSend;
}

/// Send a server message to the user(s)
void WorldSessionMgr::SendServerMessage(ServerMessageType messageID, std::string stringParam /*= ""*/, Player* player /*= nullptr*/)
{
    WorldPackets::Chat::ChatServerMessage chatServerMessage;
    chatServerMessage.MessageID = int32(messageID);
    if (messageID <= SERVER_MSG_STRING)
        chatServerMessage.StringParam = stringParam;

    if (player)
        player->SendDirectMessage(chatServerMessage.Write());
    else
        SendGlobalMessage(chatServerMessage.Write());
}

/// Send a System Message to all players in the zone (except self if mentioned)
void WorldSessionMgr::SendZoneText(uint32 zone, std::string text, WorldSession* self, TeamId teamId)
{
    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, nullptr, nullptr, text.c_str());
    SendZoneMessage(zone, &data, self, teamId);
}

void WorldSessionMgr::DoForAllOnlinePlayers(std::function<void(Player*)> exec)
{
    std::shared_lock lock(*HashMapHolder<Player>::GetLock());
    for (auto const& it : ObjectAccessor::GetPlayers())
    {
        if (Player* player = it.second)
        {
            if (!player->IsInWorld())
            {
                continue;
            }

            exec(player);
        }
    }
}
