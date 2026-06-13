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

#ifndef __WORLDSESSIONMGR_H
#define __WORLDSESSIONMGR_H

#include "Common.h"
#include "IWorld.h"
#include "LockedQueue.h"
#include "ObjectGuid.h"
#include <list>
#include <unordered_map>

class Player;
class WorldPacket;
class WorldSession;

class WorldSessionMgr
{
public:
    static WorldSessionMgr* Instance();

    WorldSessionMgr();
    ~WorldSessionMgr();

    WorldSession* FindSession(uint32 id) const;
    WorldSession* FindOfflineSession(uint32 id) const;
    WorldSession* FindOfflineSessionForCharacterGUID(ObjectGuid::LowType guidLow) const;

    void UpdateSessions(uint32 const diff);

    bool KickSession(uint32 id);
    void KickAll();
    void KickAllLess(AccountTypes sec);
    void AddSession(WorldSession* session);

    void AddQueuedPlayer(WorldSession* session);
    bool RemoveQueuedPlayer(WorldSession* session);
    int32 GetQueuePos(WorldSession* session);
    bool HasRecentlyDisconnected(WorldSession* session);

    typedef std::unordered_map<uint32, WorldSession*> SessionMap;
    SessionMap const& GetAllSessions() const { return _sessions; }

    /// Get the number of current active sessions
    void UpdateMaxSessionCounters();
    uint32 GetActiveAndQueuedSessionCount() const { return _sessions.size(); }
    uint32 GetActiveSessionCount() const { return _sessions.size() - _queuedPlayer.size(); }
    uint32 GetQueuedSessionCount() const { return _queuedPlayer.size(); }
    /// Get the maximum number of parallel sessions on the server since last reboot
    uint32 GetMaxQueuedSessionCount() const { return _maxQueuedSessionCount; }
    uint32 GetMaxActiveSessionCount() const { return _maxActiveSessionCount; }
    /// Get number of players
    inline uint32 GetPlayerCount() const { return _playerCount; }
    inline uint32 GetMaxPlayerCount() const { return _maxPlayerCount; }
    /// Active session server limit
    void SetPlayerAmountLimit(uint32 limit) { _playerLimit = limit; }
    uint32 GetPlayerAmountLimit() const { return _playerLimit; }

    /// Increase/Decrease number of players
    inline void IncreasePlayerCount()
    {
        _playerCount++;
        _maxPlayerCount = std::max(_maxPlayerCount, _playerCount);
    }
    inline void DecreasePlayerCount() { _playerCount--; }

    void SendGlobalMessage(WorldPacket const* packet, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL);
    void SendGlobalGMMessage(WorldPacket const* packet, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL);
    void SendServerMessage(ServerMessageType messageID, std::string stringParam = "", Player* player = nullptr);

    void DoForAllOnlinePlayers(std::function<void(Player*)> exec);

private:
    LockedQueue<WorldSession*> _addSessQueue;
    void AddSession_(WorldSession* session);

    SessionMap _sessions;
    SessionMap _offlineSessions;

    typedef std::unordered_map<uint32, time_t> DisconnectMap;
    DisconnectMap _disconnects;

    typedef std::list<WorldSession*> Queue;
    Queue _queuedPlayer;

    uint32 _playerLimit;
    uint32 _maxActiveSessionCount;
    uint32 _maxQueuedSessionCount;
    uint32 _playerCount;
    uint32 _maxPlayerCount;
};

#define sWorldSessionMgr WorldSessionMgr::Instance()

#endif
