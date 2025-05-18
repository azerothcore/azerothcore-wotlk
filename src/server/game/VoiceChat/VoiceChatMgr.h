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
#include "SharedDefines.h"
#include "VoiceChatSocket.h"
#include "VoiceChatSocketMgr.h"
#include "VoiceChatDefines.h"
#include "Opcodes.h"
#include "VoiceChatSocket.h"
#include <boost/asio/io_context.hpp>
#include "EventEmitter.h"
#include "VoiceChatChannel.h"
#include <chrono>

class VoiceChatMgr
{
public:
    static VoiceChatMgr& Instance()
    {
        static VoiceChatMgr instance;
        return instance;
    }

    VoiceChatMgr()
      : m_socket(nullptr),
        m_requestSocket(nullptr),
        new_request_id(1),
        new_session_id(std::chrono::system_clock::now().time_since_epoch().count()),
        server_address(0),
        server_port(0),
        voice_port(0),
        next_connect(std::chrono::system_clock::now()),
        next_ping(std::chrono::system_clock::now() + std::chrono::seconds(5)),
        last_pong(std::chrono::system_clock::now()),
        enabled(false),
        maxConnectAttempts(0),
        curReconnectAttempts(0),
        state(VOICECHAT_DISCONNECTED),
        lastUpdate(std::chrono::system_clock::now())
    {
    }

    // VoiceChatMgr();
    void Init(Acore::Asio::IoContext& ioContext);
    void LoadConfigs();
    void Update();
    void SocketDisconnected();
    bool RequestNewSocket(VoiceChatSocket* socket);
    void QueuePacket(std::unique_ptr<VoiceChatServerPacket> new_packet);

    void ActivateVoiceSocketThread();
    void VoiceSocketThread();

    bool NeedConnect();
    bool NeedReconnect();
    int32 GetReconnectAttempts() const;

    bool IsEnabled() const { return enabled; }
    bool CanUseVoiceChat();
    bool CanSeeVoiceChat();

    // configs
    uint32 GetVoiceServerConnectAddress() const { return server_address; }
    uint16 GetVoiceServerConnectPort() const { return server_port; }
    uint32 GetVoiceServerVoiceAddress() const { return voice_address; }
    uint16 GetVoiceServerVoicePort() const { return voice_port; }
    std::string GetVoiceServerConnectAddressString() { return server_address_string; }

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

    VoiceChatChannel* GetVoiceChatChannel(uint16 channel_id);
    VoiceChatChannel* GetGroupVoiceChatChannel(uint32 group_id);
    VoiceChatChannel* GetRaidVoiceChatChannel(uint32 group_id);
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
    void EnableChannelSlot(uint16 channel_id, uint8 slot_id);
    void DisableChannelSlot(uint16 channel_id, uint8 slot_id);
    void VoiceChannelSlot(uint16 channel_id, uint8 slot_id);
    void DevoiceChannelSlot(uint16 channel_id, uint8 slot_id);
    void MuteChannelSlot(uint16 channel_id, uint8 slot_id);
    void UnmuteChannelSlot(uint16 channel_id, uint8 slot_id);

    void JoinAvailableVoiceChatChannels(WorldSession* session);
    void SendAvailableVoiceChatChannels(WorldSession* session); // Not used currently

    // remove from all channels
    void RemoveFromVoiceChatChannels(ObjectGuid guid);

    uint64 GetNewSessionId() { return new_session_id++; }

    EventEmitter<void(VoiceChatMgr*)>& GetEventEmitter() { return m_eventEmitter; }

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

    void HandleVoiceChatServerPacket(VoiceChatServerPacket& pck);
    void ProcessByteBufferException(VoiceChatServerPacket const& packet);

    // socket to voice server
    std::shared_ptr<VoiceChatSocket> m_socket;
    std::shared_ptr<VoiceChatSocket> m_requestSocket;
    std::vector<VoiceChatChannelRequest> m_requests;
    uint32 new_request_id;
    uint64 new_session_id;

    // configs
    uint32 server_address;
    uint16 server_port;
    std::string server_address_string;

    // voice server address and udp port for client
    uint32 voice_address;
    uint16 voice_port;

    // next connect attempt
    std::chrono::system_clock::time_point next_connect;
    std::chrono::system_clock::time_point next_ping;
    std::chrono::system_clock::time_point last_pong;

    // enabled in config
    bool enabled;

    // how many attemps to reconnect
    int8 maxConnectAttempts;
    // how many reconnect attempts have been made
    uint8 curReconnectAttempts;

    // voice channels
    std::map<uint16, VoiceChatChannel*> m_VoiceChatChannels;

    // state of connection
    VoiceChatState state;

    std::chrono::system_clock::time_point lastUpdate;

    // Thread safety mechanisms
    std::mutex m_recvQueueLock;
    std::deque<std::unique_ptr<VoiceChatServerPacket>> m_recvQueue;

    std::unique_ptr<AsyncConnector<VoiceChatSocket>> _connector;

    EventEmitter<void(VoiceChatMgr*)> m_eventEmitter;
    boost::asio::io_context m_voiceService;
};

#define sVoiceChatMgr VoiceChatMgr::Instance()

#endif
