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

#ifndef _VOICECHATMGR_H
#define _VOICECHATMGR_H

#include "AsyncConnector.h"
#include "EventEmitter.h"
#include "Opcodes.h"
#include "SharedDefines.h"
#include "VoiceChatChannel.h"
#include "VoiceChatDefines.h"
#include "VoiceChatSocket.h"
#include "VoiceChatSocketMgr.h"
#include <boost/asio/io_context.hpp>
#include <chrono>
#include <map>

class VoiceChatMgr
{
public:
    static VoiceChatMgr& Instance()
    {
        static VoiceChatMgr instance;
        return instance;
    }

    VoiceChatMgr()
      : _socket(nullptr),
        _requestSocket(nullptr),
        _newRequestId(1),
        _newSessionId(std::chrono::system_clock::now().time_since_epoch().count()),
        _serverAddress(0),
        _serverPort(0),
        _voicePort(0),
        _nextConnect(std::chrono::system_clock::now()),
        _nextPing(std::chrono::system_clock::now() + std::chrono::seconds(5)),
        _lastPong(std::chrono::system_clock::now()),
        _enabled(false),
        _maxConnectAttempts(0),
        _curReconnectAttempts(0),
        _state(VOICECHAT_DISCONNECTED),
        _lastUpdate(std::chrono::system_clock::now())
    {
    }

    // VoiceChatMgr();
    void Init(Acore::Asio::IoContext& ioContext);
    void LoadConfigs();
    void Update();
    void SocketDisconnected();
    bool RequestNewSocket(VoiceChatSocket* socket);
    void QueuePacket(std::unique_ptr<VoiceChatServerPacket> newPacket);

    void ActivateVoiceSocketThread();
    void VoiceSocketThread();

    bool NeedConnect();
    bool NeedReconnect();
    int32 GetReconnectAttempts() const;

    bool IsEnabled() const { return _enabled; }
    bool CanUseVoiceChat();
    bool CanSeeVoiceChat();

    // configs
    uint32 GetVoiceServerConnectAddress() const { return _serverAddress; }
    uint16 GetVoiceServerConnectPort() const { return _serverPort; }
    uint32 GetVoiceServerVoiceAddress() const { return _voiceAddress; }
    uint16 GetVoiceServerVoicePort() const { return _voicePort; }
    std::string GetVoiceServerConnectAddressString() { return _serverAddressString; }

    // manage voice channels
    void CreateVoiceChatChannel(VoiceChatChannelTypes type, uint32 groupId = 0, const std::string& name = "", TeamId team = TEAM_NEUTRAL);
    void DeleteVoiceChatChannel(VoiceChatChannel* channel);
    bool IsVoiceChatChannelBeingCreated(VoiceChatChannelTypes type, uint32 groupId = 0, const std::string& name = "", TeamId team = TEAM_NEUTRAL);

    void CreateGroupVoiceChatChannel(uint32 groupId);
    void CreateRaidVoiceChatChannel(uint32 groupId);
    void CreateBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team);
    void CreateCustomVoiceChatChannel(const std::string& name, TeamId team);

    void DeleteGroupVoiceChatChannel(uint32 groupId);
    void DeleteRaidVoiceChatChannel(uint32 groupId);
    void DeleteBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team);
    void DeleteCustomVoiceChatChannel(const std::string& name, TeamId team);

    void ConvertToRaidChannel(uint32 groupId);

    VoiceChatChannel* GetVoiceChatChannel(uint16 channelId);
    VoiceChatChannel* GetGroupVoiceChatChannel(uint32 groupId);
    VoiceChatChannel* GetRaidVoiceChatChannel(uint32 groupId);
    VoiceChatChannel* GetBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team);
    VoiceChatChannel* GetCustomVoiceChatChannel(const std::string& name, TeamId team);
    std::vector<VoiceChatChannel*> GetPossibleVoiceChatChannels(ObjectGuid guid);

    // restore after reconnect
    static void RestoreVoiceChatChannels();
    // delete after disconnect
    void DeleteAllChannels();

    // get proper team if cross faction channels enabled
    static TeamId GetCustomChannelTeam(TeamId team);

    // manage users
    void AddToGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId);
    void AddToRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId);
    void AddToBattlegroundVoiceChatChannel(ObjectGuid guid);
    void AddToCustomVoiceChatChannel(ObjectGuid guid, const std::string& name, TeamId team);

    void RemoveFromGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId);
    void RemoveFromRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId);
    void RemoveFromBattlegroundVoiceChatChannel(ObjectGuid guid);
    void RemoveFromCustomVoiceChatChannel(ObjectGuid guid, const std::string& name, TeamId team);

    // change user state on voice server
    void EnableChannelSlot(uint16 channelId, uint8 slotId);
    void DisableChannelSlot(uint16 channelId, uint8 slotId);
    void VoiceChannelSlot(uint16 channelId, uint8 slotId);
    void DevoiceChannelSlot(uint16 channelId, uint8 slotId);
    void MuteChannelSlot(uint16 channelId, uint8 slotId);
    void UnmuteChannelSlot(uint16 channelId, uint8 slotId);

    void JoinAvailableVoiceChatChannels(WorldSession* session);
    void SendAvailableVoiceChatChannels(WorldSession* session); // Not used currently

    // remove from all channels
    void RemoveFromVoiceChatChannels(ObjectGuid guid);

    uint64 GetNewSessionId() { return _newSessionId++; }

    EventEmitter<void(VoiceChatMgr*)>& GetEventEmitter() { return _eventEmitter; }

    // Command Handlers
    void DisableVoiceChat();
    void EnableVoiceChat();
    VoiceChatStatistics GetStatistics();

private:

    static void SendVoiceChatStatus(bool status);
    static void SendVoiceChatServiceMessage(Opcodes opcode);
    static void SendVoiceChatServiceDisconnect() { SendVoiceChatServiceMessage(SMSG_COMSAT_DISCONNECT); }
    static void SendVoiceChatServiceConnectFail() { SendVoiceChatServiceMessage(SMSG_COMSAT_CONNECT_FAIL); }
    static void SendVoiceChatServiceReconnected() { SendVoiceChatServiceMessage(SMSG_COMSAT_RECONNECT_TRY); }

    void HandleVoiceChatServerPacket(VoiceChatServerPacket& packet);
    void ProcessByteBufferException(VoiceChatServerPacket const& packet);

    // socket to voice server
    std::shared_ptr<VoiceChatSocket> _socket;
    std::shared_ptr<VoiceChatSocket> _requestSocket;
    std::vector<VoiceChatChannelRequest> _requests;
    uint32 _newRequestId;
    uint64 _newSessionId;

    // configs
    uint32 _serverAddress;
    uint16 _serverPort;
    std::string _serverAddressString;

    // voice server address and udp port for client
    uint32 _voiceAddress;
    uint16 _voicePort;

    // next connect attempt
    std::chrono::system_clock::time_point _nextConnect;
    std::chrono::system_clock::time_point _nextPing;
    std::chrono::system_clock::time_point _lastPong;

    // enabled in config
    bool _enabled;

    // how many attemps to reconnect
    int8 _maxConnectAttempts;
    // how many reconnect attempts have been made
    uint8 _curReconnectAttempts;

    // voice channels
    std::map<uint16, VoiceChatChannel*> _voiceChatChannels;

    // state of connection
    VoiceChatState _state;

    std::chrono::system_clock::time_point _lastUpdate;

    // Thread safety mechanisms
    std::mutex _recvQueueLock;
    std::deque<std::unique_ptr<VoiceChatServerPacket>> _recvQueue;

    std::unique_ptr<AsyncConnector<VoiceChatSocket>> _connector;

    EventEmitter<void(VoiceChatMgr*)> _eventEmitter;
    boost::asio::io_context _voiceService;
};

#define sVoiceChatMgr VoiceChatMgr::Instance()

#endif
