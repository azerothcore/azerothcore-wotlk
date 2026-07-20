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

#ifndef __VoiceChatMgr_H__
#define __VoiceChatMgr_H__

#include "LockedQueue.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"
#include "TcpAsyncConnector.h"
#include "Timer.h"
#include "VoiceChatDefines.h"
#include <atomic>
#include <map>
#include <memory>
#include <mutex>

class Channel;
class VoiceChatSocket;
class WorldSession;

class VoiceServerConnector : public TcpAsyncConnector
{
public:
    VoiceServerConnector(Acore::Asio::IoContext& context) :
        TcpAsyncConnector(context) { }

    void OnConnectionSuccess(std::unique_ptr<IoContextTcpSocket> socket) override;
    // Note: a connect timeout also fires OnConnectionFail through the aborted
    // connect, so only the failure hook counts attempts
    void OnConnectionFail() override;
};

/*
 * Manages the connection to the voiceserver and all voice channels.
 *
 * Except for OfferVoiceServerSocket and QueueIncomingVoiceServerPacket (both
 * called from network threads and synchronized accordingly), all methods must
 * be called from the world thread.
 */
class VoiceChatMgr
{
public:
    static VoiceChatMgr* Instance()
    {
        static VoiceChatMgr instance;
        return &instance;
    }

    VoiceChatMgr();

    void Init();
    void LoadConfigs();
    void Update(uint32 const diff);
    void Stop();

    bool IsEnabled() const { return _enabled; }
    // enabled and connected to the voiceserver
    bool CanUseVoiceChat() const;
    // enabled, the client may show the voice chat interface
    bool CanSeeVoiceChat() const { return _enabled; }

    void Enable();
    void Disable();
    // drops the current voiceserver connection (it will reconnect automatically while enabled)
    void DisconnectSocket();

    // configs, address/port of the voiceserver UDP socket as announced to game clients
    uint32 GetVoiceServerVoiceAddress() const { return _voiceAddress; }
    uint16 GetVoiceServerVoicePort() const { return _voicePort; }

    // called from the connector callback (network thread)
    void OfferVoiceServerSocket(std::shared_ptr<VoiceChatSocket> socket);
    // called from the connector callbacks (network thread)
    void OnConnectAttemptFailed() { ++_failedConnectAttempts; }
    // called from the socket read handler (network thread)
    void QueueIncomingVoiceServerPacket(std::unique_ptr<VoiceChatServerPacket> packet);

    // manage voice channels
    void CreateGroupVoiceChatChannel(uint32 groupId);
    void CreateRaidVoiceChatChannel(uint32 groupId);
    void CreateBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team);
    void CreateCustomVoiceChatChannel(std::string const& name, TeamId team);

    void DeleteGroupVoiceChatChannel(uint32 groupId);
    void DeleteRaidVoiceChatChannel(uint32 groupId);
    void DeleteBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team);
    void DeleteCustomVoiceChatChannel(std::string const& name, TeamId team);

    void ConvertToRaidChannel(uint32 groupId);

    Channel* GetVoiceChatChannel(uint16 voiceId);
    Channel* GetGroupVoiceChatChannel(uint32 groupId);
    Channel* GetRaidVoiceChatChannel(uint32 groupId);
    Channel* GetBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team);
    Channel* GetCustomVoiceChatChannel(std::string const& name, TeamId team);

    // get proper team if cross faction channels enabled
    static TeamId GetCustomChannelTeam(TeamId team);

    // manage users
    void AddToGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId);
    void AddToRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId);
    void AddToBattlegroundVoiceChatChannel(ObjectGuid guid);
    void AddToCustomVoiceChatChannel(ObjectGuid guid, std::string const& name, TeamId team);

    void RemoveFromGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId);
    void RemoveFromRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId);
    void RemoveFromBattlegroundVoiceChatChannel(ObjectGuid guid);

    // remove from all channels (on logout / voice disable)
    void RemoveFromVoiceChatChannels(ObjectGuid guid);

    // add player to all voice channels available to them (on login / voice enable)
    void JoinAvailableVoiceChatChannels(WorldSession* session);

    // change user state on the voiceserver
    void EnableChannelSlot(uint16 channelId, uint8 slotId);
    void DisableChannelSlot(uint16 channelId, uint8 slotId);
    void VoiceChannelSlot(uint16 channelId, uint8 slotId);
    void DevoiceChannelSlot(uint16 channelId, uint8 slotId);
    void MuteChannelSlot(uint16 channelId, uint8 slotId);
    void UnmuteChannelSlot(uint16 channelId, uint8 slotId);

    uint64 GetNewSessionId() { return _nextSessionId++; }

    VoiceChatStatistics GetStatistics();

    // internal packet handlers, public so the opcode table can register them
    void HandlePongOpcode(VoiceChatServerPacket const& packet);
    void HandleCreateVoiceSessionResponseOpcode(VoiceChatServerPacket const& packet);

private:
    ~VoiceChatMgr();

    uint16 GetNextVoiceChannelId();

    // registers channel, assigns ids and creates the session on the voiceserver
    void CreateVoiceSession(Channel* channel, std::shared_ptr<Channel> ownedChannel = nullptr);
    void DeleteVoiceChatChannel(Channel* channel);
    // adds eligible players after the voice session was created
    void AddMembersAfterCreate(Channel* channel);

    void SendPacket(VoiceChatServerPacket const& packet);
    void SendChannelSlotPacket(VoiceChatServerOpcodes opcode, uint16 channelId, uint8 slotId);

    void UpdateVoiceServerConnection(uint32 const diff);
    bool HasPendingSocket();
    void OnVoiceServerConnected();
    void OnVoiceServerDisconnected();
    // re-creates all registered channels on the voiceserver after a reconnect
    void RestoreVoiceChatChannels();
    void DeleteAllChannels();

    static void SendVoiceChatStatus(bool status);
    static void SendVoiceChatServiceDisconnect();
    static void SendVoiceChatServiceReconnected();

    bool _initialized;
    bool _enabled;

    uint16 _nextVoiceChannelId;
    uint64 _nextSessionId;

    // configs
    std::string _serverAddressString;
    uint16 _serverPort;
    uint32 _voiceAddress;
    uint16 _voicePort;
    // <= 0 means unlimited attempts
    int32 _maxConnectAttempts;
    std::atomic<uint32> _failedConnectAttempts;

    // all registered voice channels by voice channel id. Custom channels are
    // owned by the chat ChannelMgr (which never deletes them at runtime),
    // group/raid/bg channels are owned by _ownedChannels below.
    std::map<uint16, Channel*> _voiceChannels;
    std::map<uint16, std::shared_ptr<Channel>> _ownedChannels;

    std::shared_ptr<VoiceServerConnector> _voiceServerConnector;
    std::shared_ptr<VoiceChatSocket> _voiceServerSocket;
    bool _wasConnected;

    // socket handed over from the connector callback (network thread)
    std::mutex _pendingSocketLock;
    std::shared_ptr<VoiceChatSocket> _pendingSocket;

    LockedQueue<std::unique_ptr<VoiceChatServerPacket>> _voiceServerPacketQueue;

    IntervalTimer _pingTimer;
};

#define sVoiceChatMgr VoiceChatMgr::Instance()

#endif
