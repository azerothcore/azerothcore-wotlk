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

#include "VoiceChatMgr.h"
#include "AsyncConnector.h"
#include "BattlegroundMgr.h"
#include "ChannelMgr.h"
#include "Chat.h"
#include "GroupMgr.h"
#include "Log.h"
#include "Player.h"
#include "SharedDefines.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"
// #include "Chat/ChannelMgr.h"
// #include "BattleGround/BattleGroundMgr.h"
// #include "World/World.h"
// #include "Config/Config.h"

// #include "Network/AsyncConnector.hpp"
// #include <boost/thread/thread.hpp>
// #include <memory>
#include <boost/asio.hpp>
#include <thread>

using boost::asio::ip::tcp;

namespace
{
    // Helper function moved to anonymous namespace to avoid global scope pollution
    void VoiceSocketThreadHelper()
    {
        sVoiceChatMgr.VoiceSocketThread();
    }
} // namespace

void VoiceChatMgr::ActivateVoiceSocketThread()
{
    std::thread t(VoiceSocketThreadHelper);
    t.detach();
}

void VoiceChatMgr::VoiceSocketThread()
{
    try
    {
        // Create IO context and resolver
        boost::asio::io_context ioContext;
        tcp::resolver resolver(ioContext);

        // Get connection details
        std::string address = GetVoiceServerConnectAddressString();
        std::string port = std::to_string(GetVoiceServerConnectPort());

        LOG_INFO("voice-chat", "Attempting to connect to voice server at {}:{}", address, port);

        // Resolve endpoint
        boost::system::error_code resolveError;
        auto endpoints = resolver.resolve(address, port, resolveError);

        if (resolveError)
        {
            LOG_ERROR("voice-chat", "Failed to resolve voice server address: {}", resolveError.message());
            return;
        }

        // Create and connect socket
        tcp::socket socket(ioContext);
        boost::system::error_code connectError;
        boost::asio::connect(socket, endpoints, connectError);

        if (connectError)
        {
            LOG_ERROR("voice-chat", "Failed to connect to voice server: {}", connectError.message());
            return;
        }

        LOG_INFO("voice-chat", "Successfully connected to voice server");

        // Create voice chat session
        _socket = std::make_shared<VoiceChatSocket>(std::move(socket));

        // Start processing
        if (_socket)
        {
            _socket->Start();
            ioContext.run();
        }
        else
        {
            LOG_ERROR("voice-chat", "Failed to create voice chat session");
        }
    }
    catch (boost::system::system_error const& e)
    {
        LOG_ERROR("voice-chat", "Boost system error in voice chat thread: {}", e.what());
    }
    catch (std::exception const& e)
    {
        LOG_ERROR("voice-chat", "Exception in voice chat thread: {}", e.what());
    }
    catch (...)
    {
        LOG_ERROR("voice-chat", "Unknown exception in voice chat thread");
    }
}

void VoiceChatMgr::LoadConfigs()
{
    enabled = sWorld->getBoolConfig(CONFIG_VOICE_CHAT_ENABLED);

    server_address_string = sConfigMgr->GetOption<std::string>("VoiceChat.ServerAddress", "127.0.0.1");
    server_address = inet_addr(server_address_string.c_str());
    server_port = sWorld->getIntConfig(CONFIG_VOICE_CHAT_SERVER_PORT);

    std::string voice_address_string = sConfigMgr->GetOption<std::string>("VoiceChat.VoiceAddress", "127.0.0.1");
    voice_address = inet_addr(voice_address_string.c_str());
    voice_port = sWorld->getIntConfig(CONFIG_VOICE_CHAT_VOICE_PORT);

    maxConnectAttempts = sWorld->getIntConfig(CONFIG_VOICE_CHAT_MAX_CONNECT_ATTEMPTS);
}

void VoiceChatMgr::Init(Acore::Asio::IoContext& ioContext)
{
    LoadConfigs();

    next_ping = std::chrono::system_clock::now() + std::chrono::seconds(5);
    last_pong = std::chrono::system_clock::now();
    lastUpdate = std::chrono::system_clock::now();
    curReconnectAttempts = 0;

    state = enabled ? VOICECHAT_NOT_CONNECTED : VOICECHAT_DISCONNECTED;

    // Attempt an asynchronous connection to the voice server
    LOG_INFO("voice-chat", "Connecting to voice server at {}:{}", server_address_string, server_port);
    new AsyncConnector<VoiceChatSocket>(ioContext, server_address_string, server_port, false);

    // FIX: Store the connector
    _connector =
        std::make_unique<AsyncConnector<VoiceChatSocket>>(ioContext, server_address_string, server_port, false);

    // Optionally store a reference to ioContext in VoiceChatMgr if needed
}

void VoiceChatMgr::Update()
{
    if (!enabled)
        return;

    LOG_DEBUG("voice-chat", "VoiceChatMgr::Update state: {}", state);

    _eventEmitter(this);

    if (_socket)
        _socket->Update(); // yep, that's it

    std::deque<std::unique_ptr<VoiceChatServerPacket>> recvQueueCopy;
    {
        std::lock_guard<std::mutex> guard(_recvQueueLock);
        std::swap(recvQueueCopy, _recvQueue);
    }

    while (_socket && _socket->IsOpen() && !recvQueueCopy.empty())
    {
        auto const packet = std::move(recvQueueCopy.front());
        recvQueueCopy.pop_front();

        try
        {
            LOG_DEBUG("voice-chat",
                "VoiceChatMgr::Update Read Pong packet sent from server"); // Log info
                                                                           // for pong
                                                                           // packets
            HandleVoiceChatServerPacket(*packet);
        }
        catch (ByteBufferException const&)
        {
            LOG_ERROR("voice-chat",
                "VoiceChatMgr::Update EXCEPTION Read Pong packet "
                "sent from server"); // Log info for pong packets
            ProcessByteBufferException(*packet);
        }
    }

    if (state == VOICECHAT_DISCONNECTED)
        return;

    auto now = std::chrono::system_clock::now();
    if (now - lastUpdate < std::chrono::seconds(1))
        return;

    lastUpdate = now;

    if (_requestSocket)
    {
        _socket = _requestSocket;
        _requestSocket = nullptr;
        return;
    }

    // connecting / reconnecting
    if (!_socket)
    {
        if (state == VOICECHAT_CONNECTED)
        {
            LOG_ERROR("voice-chat", "No socket but connected state, disconnecting socket");
            SocketDisconnected();
            SendVoiceChatServiceDisconnect();
            state = VOICECHAT_RECONNECTING;
            next_connect = std::chrono::system_clock::now() + std::chrono::seconds(10);
            return;
        }

        if (state == VOICECHAT_RECONNECTING)
        {
            if (maxConnectAttempts >= 0 && curReconnectAttempts >= maxConnectAttempts)
            {
                if (maxConnectAttempts > 0)
                    LOG_ERROR("voice-chat", "Disconnected! Max reconnect attempts reached");
                else
                    LOG_ERROR("voice-chat", "Disconnected! Reconnecting disabled");

                DeleteAllChannels();
                SendVoiceChatStatus(false);
                SendVoiceChatServiceConnectFail();
                curReconnectAttempts = 0;
                state = VOICECHAT_DISCONNECTED;
                return;
            }
        }

        if (now > next_connect)
        {
            if (NeedConnect() || NeedReconnect())
                ActivateVoiceSocketThread();

            if (curReconnectAttempts > 0)
            {
                if (state == VOICECHAT_NOT_CONNECTED)
                    LOG_ERROR("voice-chat", "Connect failed, will try again later");
                if (state == VOICECHAT_RECONNECTING)
                    LOG_ERROR("voice-chat", "Reconnect failed, will try again later");
            }

            if (state == VOICECHAT_NOT_CONNECTED || state == VOICECHAT_RECONNECTING)
                curReconnectAttempts++;

            next_connect = now + std::chrono::seconds(10);
            return;
        }
    }
    else
    {
        if (!_socket->IsOpen())
        {
            if (state == VOICECHAT_CONNECTED)
            {
                LOG_ERROR("voice-chat", "Socket not open but connected state, disconnecting socket");
                SocketDisconnected();
                SendVoiceChatServiceDisconnect();
                state = VOICECHAT_RECONNECTING;
                return;
            }

            if (now > next_connect)
            {
                if (!_requestSocket && (state == VOICECHAT_NOT_CONNECTED || state == VOICECHAT_RECONNECTING))
                {
                    ActivateVoiceSocketThread();
                    next_connect = now + std::chrono::seconds(5);
                }
            }
            return;
        }

        // socket is open
        if (state == VOICECHAT_NOT_CONNECTED || state == VOICECHAT_RECONNECTING)
        {
            if (state == VOICECHAT_NOT_CONNECTED)
                LOG_INFO("voice-chat",
                    "Connected to {}:{}.",
                    _socket->GetRemoteIpAddress().to_string(),
                    _socket->GetRemotePort());
            if (state == VOICECHAT_RECONNECTING)
                LOG_INFO("voice-chat",
                    "Reconnected to {}:{}",
                    _socket->GetRemoteIpAddress().to_string(),
                    _socket->GetRemotePort());

            SendVoiceChatStatus(true);
            RestoreVoiceChatChannels();
            if (state == VOICECHAT_RECONNECTING)
                SendVoiceChatServiceReconnected();

            state = VOICECHAT_CONNECTED;
            curReconnectAttempts = 0;
            last_pong = now;
        }
        else
        {
            if (now >= next_ping)
            {
                LOG_DEBUG("voice-chat", "Sending ping");
                next_ping = now + std::chrono::seconds(5);
                VoiceChatServerPacket data(VOICECHAT_CMSG_PING, 4);
                data << uint32(0);
                _socket->SendPacket(data);
            }

            if (_socket && (now - last_pong) > std::chrono::seconds(10))
            {
                LOG_ERROR("voice-chat", "Ping timeout!");
                SocketDisconnected();
                // SendVoiceChatServiceDisconnect();
                state = VOICECHAT_RECONNECTING;
                // next_connect = now + std::chrono::seconds(10);
            }
        }
    }
}

void VoiceChatMgr::HandleVoiceChatServerPacket(VoiceChatServerPacket& pck)
{

    uint32 request_id;
    uint8 error;
    uint16 channel_id;

    LOG_DEBUG("voice-chat", "VoiceChatMgr::HandleVoiceChatServerPacket Received {}", pck.GetOpcode());

    switch (pck.GetOpcode())
    {
        case VOICECHAT_SMSG_PONG:
        {
            last_pong = std::chrono::system_clock::now();
            break;
        }
        case VOICECHAT_SMSG_CHANNEL_CREATED:
        {
            pck >> request_id;
            pck >> error;

            for (auto request = _requests.begin(); request != _requests.end();)
            {
                if (request->id == request_id)
                {
                    if (error == 0)
                    {
                        pck >> channel_id;
                    }
                    else
                    {
                        LOG_ERROR("voice-chat", "Error creating voice channel");
                        request = _requests.erase(request);
                        return;
                    }

                    if (request->groupid)
                    {
                        if (request->type == VOICECHAT_CHANNEL_GROUP || request->type == VOICECHAT_CHANNEL_RAID)
                        {
                            Group* grp = sGroupMgr->GetGroupByGUID(request->groupid);
                            if (grp)
                            {
                                auto* v_channel = new VoiceChatChannel(
                                    VoiceChatChannelTypes(request->type), channel_id, grp->GetId());
                                _VoiceChatChannels.insert(std::make_pair((uint32)channel_id, v_channel));
                                v_channel->AddMembersAfterCreate();
                            }
                        }
                        else if (request->type == VOICECHAT_CHANNEL_BG)
                        {
                            Battleground* bg =
                                sBattlegroundMgr->GetBattleground(request->groupid, BATTLEGROUND_TYPE_NONE);
                            if (bg)
                            {
                                // for BG use bg's instanceID as groupID
                                auto* v_channel = new VoiceChatChannel(VoiceChatChannelTypes(request->type),
                                    channel_id,
                                    request->groupid,
                                    "",
                                    request->team);
                                _VoiceChatChannels.insert(std::make_pair((uint32)channel_id, v_channel));
                                v_channel->AddMembersAfterCreate();
                            }
                        }
                    }
                    else if (request->type == VOICECHAT_CHANNEL_CUSTOM)
                    {
                        if (ChannelMgr* cMgr = ChannelMgr::forTeam(request->team))
                        {
                            Channel* chan = cMgr->GetChannel(request->channel_name, nullptr, false);
                            if (chan)
                            {
                                auto* v_channel = new VoiceChatChannel(VoiceChatChannelTypes(request->type),
                                    channel_id,
                                    0,
                                    request->channel_name,
                                    request->team);
                                _VoiceChatChannels.insert(std::make_pair((uint32)channel_id, v_channel));
                                v_channel->AddMembersAfterCreate();
                            }
                        }
                    }

                    request = _requests.erase(request);
                }
                else
                    request++;
            }
            break;
        }
        default:
        {
            LOG_ERROR("voice-chat", "received unknown opcode {}!\n", pck.GetOpcode());
            break;
        }
    }
}

void VoiceChatMgr::SocketDisconnected()
{
    // sLog->outBasic("VoiceChatMgr: VoiceChatServerSocket disconnected");
    LOG_ERROR("voice-chat", "VoiceChatServerSocket disconnected");

    // we close somewher eelse
    // if (_socket)
    // {
    //     if (_socket->IsOpen())
    //         _socket->CloseSocket();
    // }

    // _socket.reset();
    // _voiceService.stop();
    // _socket = nullptr;
    _requests.clear();

    DeleteAllChannels();

    curReconnectAttempts = 0;
}

bool VoiceChatMgr::NeedConnect()
{
    return enabled && !_socket && !_requestSocket && state == VOICECHAT_NOT_CONNECTED &&
           std::chrono::system_clock::now() > next_connect;
}

bool VoiceChatMgr::NeedReconnect()
{
    return enabled && !_socket && !_requestSocket && state == VOICECHAT_RECONNECTING &&
           std::chrono::system_clock::now() > next_connect;
}

int32 VoiceChatMgr::GetReconnectAttempts() const
{
    if (maxConnectAttempts < 0 || (maxConnectAttempts > 0 && curReconnectAttempts < maxConnectAttempts))
        return maxConnectAttempts;

    return 0;
}

bool VoiceChatMgr::RequestNewSocket(VoiceChatSocket* socket)
{
    if (_requestSocket)
        return false;

    _requestSocket = socket->shared_from_this();
    return true;
}

// Add an incoming packet to the queue
void VoiceChatMgr::QueuePacket(std::unique_ptr<VoiceChatServerPacket> new_packet)
{
    std::lock_guard<std::mutex> guard(_recvQueueLock);
    _recvQueue.push_back(std::move(new_packet));
}

void VoiceChatMgr::ProcessByteBufferException(VoiceChatServerPacket const& packet)
{
    LOG_ERROR("voice-chat",
        "VoiceChatMgr::Update ByteBufferException occured while parsing a "
        "packet (opcode: {}).",
        packet.GetOpcode());

    // if (sLog->HasLogLevelOrHigher(LOG_LVL_DEBUG))
    {
        // DEBUG_LOG("Dumping error-causing voice server packet:");
        LOG_ERROR("voice-chat", "Dumping error-causing voice server packet:");
        packet.hexlike();
    }

    LOG_ERROR("voice-chat",
        "Disconnecting voice server [address {}] for badly formatted packet.",
        GetVoiceServerConnectAddressString());
    // DETAIL_LOG("Disconnecting voice server [address {}] for badly formatted
    // packet.",
    //    );

    // Replace Messager with EventEmitter callback
    _eventEmitter += [](VoiceChatMgr* mgr) { mgr->SocketDisconnected(); };
}

//
// void VoiceChatMgr::VoiceSocketThread()
// {
//     _voiceService.stop();
//     _voiceService.restart();
//     std::unique_ptr<MaNGOS::AsyncConnector<VoiceChatServerSocket>>
//     voiceSocket; voiceSocket =
//     std::make_unique<MaNGOS::AsyncConnector<VoiceChatServerSocket>>(_voiceService,
//     sVoiceChatMgr.GetVoiceServerConnectAddressString(),
//     int32(sVoiceChatMgr.GetVoiceServerConnectPort()), false);
//     _voiceService.run();
// }
//
// enabled and connected to voice server
bool VoiceChatMgr::CanUseVoiceChat()
{
    return (enabled && _socket);
}

// enabled and is connected or trying to connect to voice server
bool VoiceChatMgr::CanSeeVoiceChat()
{
    return (enabled && state != VOICECHAT_DISCONNECTED);
}

void VoiceChatMgr::CreateVoiceChatChannel(
    VoiceChatChannelTypes type, uint32 groupId, std::string const& name, TeamId team)
{
    if (!_socket)
        return;

    if (type == VOICECHAT_CHANNEL_NONE)
        return;

    if (!groupId && name.empty())
        return;

    TeamId newTeam = GetCustomChannelTeam(team);

    if (IsVoiceChatChannelBeingCreated(type, groupId, name, newTeam))
        return;

    LOG_INFO("voice-chat",
        "CreateVoiceChannel type: {}, name: {}, team: {}, group: {}",
        type,
        name.c_str(),
        newTeam,
        groupId);
    VoiceChatChannelRequest req;
    req.id = new_request_id++;
    req.type = type;
    req.channel_name = name;
    req.team = newTeam;
    req.groupid = groupId;
    _requests.push_back(req);

    VoiceChatServerPacket data(VOICECHAT_CMSG_CREATE_CHANNEL, 5);
    data << req.type;
    data << req.id;
    _socket->SendPacket(data);
}

//
void VoiceChatMgr::DeleteVoiceChatChannel(VoiceChatChannel* channel)
{
    if (!channel)
        return;

    LOG_INFO("voice-chat", "DeleteVoiceChannel id: {} type: {}", channel->GetChannelId(), channel->GetType());

    uint8 type = channel->GetType();
    uint16 id = channel->GetChannelId();

    // disable voice in custom channel
    if (type == VOICECHAT_CHANNEL_CUSTOM)
    {
        {
            auto cMgr = ChannelMgr(channel->GetTeam());
            if (Channel* chn = cMgr.GetChannel(channel->GetChannelName(), nullptr, false))
            {
                if (chn->IsVoiceEnabled())
                    chn->ToggleVoice();
            }
        }
    }

    _VoiceChatChannels.erase(channel->GetChannelId());
    delete channel;

    if (_socket)
    {
        VoiceChatServerPacket data(VOICECHAT_CMSG_DELETE_CHANNEL, 5);
        data << type;
        data << id;
        _socket->SendPacket(data);
    }
}

// check if channel request has already been created
bool VoiceChatMgr::IsVoiceChatChannelBeingCreated(
    VoiceChatChannelTypes type, uint32 groupId, std::string const& name, TeamId team)
{
    return std::ranges::any_of(_requests,
        [&](auto const& req)
    {
        if (req.type != type)
            return false;
        if (groupId && req.groupid != groupId)
            return false;
        if (!name.empty() && req.channel_name != name)
            return false;
        if (req.team != team)
            return false;
        return true;
    });
}

void VoiceChatMgr::CreateGroupVoiceChatChannel(uint32 groupId)
{
    if (GetGroupVoiceChatChannel(groupId))
        return;

    CreateVoiceChatChannel(VOICECHAT_CHANNEL_GROUP, groupId);
}

void VoiceChatMgr::CreateRaidVoiceChatChannel(uint32 groupId)
{
    if (GetRaidVoiceChatChannel(groupId))
        return;

    CreateVoiceChatChannel(VOICECHAT_CHANNEL_RAID, groupId);
}

void VoiceChatMgr::CreateBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team)
{
    if (GetBattlegroundVoiceChatChannel(instanceId, team))
        return;

    CreateVoiceChatChannel(VOICECHAT_CHANNEL_BG, instanceId, "", team);
}

void VoiceChatMgr::CreateCustomVoiceChatChannel(std::string const& name, TeamId team)
{
    if (GetCustomVoiceChatChannel(name, team))
        return;

    CreateVoiceChatChannel(VOICECHAT_CHANNEL_CUSTOM, 0, name, team);
}

//
void VoiceChatMgr::DeleteGroupVoiceChatChannel(uint32 groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* channel = GetGroupVoiceChatChannel(groupId))
        DeleteVoiceChatChannel(channel);
}

void VoiceChatMgr::DeleteRaidVoiceChatChannel(uint32 groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* channel = GetRaidVoiceChatChannel(groupId))
        DeleteVoiceChatChannel(channel);
}

void VoiceChatMgr::DeleteBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team)
{
    if (!instanceId)
        return;

    if (VoiceChatChannel* channel = GetBattlegroundVoiceChatChannel(instanceId, team))
        DeleteVoiceChatChannel(channel);
}

void VoiceChatMgr::DeleteCustomVoiceChatChannel(std::string const& name, TeamId team)
{
    if (name.empty())
        return;

    if (VoiceChatChannel* v_channel = GetCustomVoiceChatChannel(name, team))
        DeleteVoiceChatChannel(v_channel);
}

void VoiceChatMgr::ConvertToRaidChannel(uint32 groupId)
{
    if (VoiceChatChannel* chn = GetGroupVoiceChatChannel(groupId))
        chn->ConvertToRaid();
}

VoiceChatChannel* VoiceChatMgr::GetVoiceChatChannel(uint16 channel_id)
{
    auto itr = _VoiceChatChannels.find(channel_id);
    if (itr == _VoiceChatChannels.end())
        return nullptr;

    return itr->second;
}

//
VoiceChatChannel* VoiceChatMgr::GetGroupVoiceChatChannel(uint32 group_id)
{
    for (auto& channel : _VoiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_GROUP && chn->GetGroupId() == group_id)
            return chn;
    }

    return nullptr;
}

//
VoiceChatChannel* VoiceChatMgr::GetRaidVoiceChatChannel(uint32 group_id)
{
    for (auto& channel : _VoiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_RAID && chn->GetGroupId() == group_id)
            return chn;
    }

    return nullptr;
}

VoiceChatChannel* VoiceChatMgr::GetBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team)
{
    for (auto& channel : _VoiceChatChannels)
    {
        // for BG use bg's instanceID as groupID
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_BG && chn->GetGroupId() == instanceId && chn->GetTeam() == team)
            return chn;
    }

    return nullptr;
}

VoiceChatChannel* VoiceChatMgr::GetCustomVoiceChatChannel(std::string const& name, TeamId team)
{
    for (auto& channels : _VoiceChatChannels)
    {
        VoiceChatChannel* v_chan = channels.second;
        if (v_chan->GetType() == VOICECHAT_CHANNEL_CUSTOM && v_chan->GetChannelName() == name &&
            v_chan->GetTeam() == GetCustomChannelTeam(team))
            return v_chan;
    }

    return nullptr;
}

//
// get possible voice channels after login or voice chat enable
std::vector<VoiceChatChannel*> VoiceChatMgr::GetPossibleVoiceChatChannels(ObjectGuid guid)
{
    std::vector<VoiceChatChannel*> channel_list;
    Player* plr = ObjectAccessor::FindConnectedPlayer(guid);
    if (!plr)
        return channel_list;

    for (auto& channel : _VoiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() != VOICECHAT_CHANNEL_CUSTOM)
            continue;

        if (chn->GetTeam() != GetCustomChannelTeam(plr->GetTeamId()))
            continue;

        {
            auto cMgr = ChannelMgr(plr->GetTeamId());
            Channel* chan = cMgr.GetChannel(chn->GetChannelName(), nullptr, false);
            if (chan && chan->IsOn(guid) && !chan->IsBanned(guid) && chan->IsVoiceEnabled())
                channel_list.push_back(chn);
        }
    }

    return channel_list;
}

// create group/raid/bg channels after (re)connect to voice server
void VoiceChatMgr::RestoreVoiceChatChannels()
{
    // Replace Messager with EventEmitter
    sVoiceChatMgr.GetEventEmitter() += [](VoiceChatMgr* /*world*/)
    {
        ChatHandler(nullptr).DoForAllValidSessions([](Player* player)
        {
            WorldSession const* sess = player->GetSession();
            if (sess->IsVoiceChatEnabled())
            {
                if (player)
                {
                    if (Group* grp = player->GetGroup())
                    {
                        if (!grp->isBGGroup() && !grp->isBFGroup())
                            if (grp->isRaidGroup())
                                sVoiceChatMgr.AddToRaidVoiceChatChannel(player->GetGUID(), grp->GetId());
                            else
                                sVoiceChatMgr.AddToGroupVoiceChatChannel(player->GetGUID(), grp->GetId());
                        else
                            sVoiceChatMgr.AddToBattlegroundVoiceChatChannel(player->GetGUID());
                    }
                    if (Group* grp = player->GetOriginalGroup())
                    {
                        if (!grp->isBGGroup() && !grp->isBFGroup())
                            if (grp->isRaidGroup())
                                sVoiceChatMgr.AddToRaidVoiceChatChannel(player->GetGUID(), grp->GetId());
                            else
                                sVoiceChatMgr.AddToGroupVoiceChatChannel(player->GetGUID(), grp->GetId());
                        else
                            sVoiceChatMgr.AddToBattlegroundVoiceChatChannel(player->GetGUID());
                    }
                }
            }
        });
    };
}

void VoiceChatMgr::DeleteAllChannels()
{
    for (auto& channel : _VoiceChatChannels)
        DeleteVoiceChatChannel(channel.second);
    _VoiceChatChannels.clear();
}

// if cross faction channels are enabled, team is always ALLIANCE
TeamId VoiceChatMgr::GetCustomChannelTeam(TeamId team)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL))
        return TEAM_ALLIANCE;
    else
        return team;
}

void VoiceChatMgr::AddToGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    VoiceChatChannel* v_channel = GetGroupVoiceChatChannel(groupId);
    if (!v_channel)
    {
        CreateGroupVoiceChatChannel(groupId);
        return;
    }

    v_channel->AddVoiceChatMember(guid);
}

//
void VoiceChatMgr::AddToRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    VoiceChatChannel* v_channel = GetRaidVoiceChatChannel(groupId);
    if (!v_channel)
    {
        CreateRaidVoiceChatChannel(groupId);
        return;
    }

    v_channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToBattlegroundVoiceChatChannel(ObjectGuid guid)
{
    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (!plr)
        return;

    if (!plr->InBattleground())
        return;

    // for BG use bg's instanceID as groupID
    VoiceChatChannel* v_channel = GetBattlegroundVoiceChatChannel(plr->GetBattlegroundId(), plr->GetBgTeamId());
    if (!v_channel)
    {
        CreateBattlegroundVoiceChatChannel(plr->GetBattlegroundId(), plr->GetBgTeamId());
        return;
    }

    v_channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToCustomVoiceChatChannel(ObjectGuid guid, std::string const& name, TeamId team)
{
    if (name.empty())
        return;

    VoiceChatChannel* v_channel = GetCustomVoiceChatChannel(name, team);
    if (!v_channel)
    {
        CreateCustomVoiceChatChannel(name, team);
        return;
    }

    v_channel->AddVoiceChatMember(guid);
}

//
void VoiceChatMgr::RemoveFromGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* v_channel = GetGroupVoiceChatChannel(groupId))
        v_channel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* v_channel = GetRaidVoiceChatChannel(groupId))
        v_channel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromBattlegroundVoiceChatChannel(ObjectGuid guid)
{
    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (!plr)
        return;

    if (!plr->InBattleground())
        return;

    if (VoiceChatChannel* v_channel = GetBattlegroundVoiceChatChannel(plr->GetBattlegroundId(), plr->GetBgTeamId()))
        v_channel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromCustomVoiceChatChannel(ObjectGuid guid, std::string const& name, TeamId team)
{
    if (name.empty())
        return;

    if (VoiceChatChannel* v_channel = GetCustomVoiceChatChannel(name, team))
        v_channel->RemoveVoiceChatMember(guid);
}

//
void VoiceChatMgr::EnableChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Channel enabled with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} activate slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_ADD_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    _socket->SendPacket(data);
}

//
void VoiceChatMgr::DisableChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Channel disabled with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} deactivate slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_REMOVE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    _socket->SendPacket(data);
}

//
void VoiceChatMgr::VoiceChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Slot voiced with no socket!");
        return;
    }

    LOG_ERROR("voice-chat", "Channel {} voice slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_VOICE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    _socket->SendPacket(data);
}

//
void VoiceChatMgr::DevoiceChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Slot devoiced with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} devoice slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_DEVOICE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    _socket->SendPacket(data);
}

void VoiceChatMgr::MuteChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Slot muted with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} mute slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_MUTE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    _socket->SendPacket(data);
}

void VoiceChatMgr::UnmuteChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Slot unmuted with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} unmute slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_UNMUTE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    _socket->SendPacket(data);
}

void VoiceChatMgr::JoinAvailableVoiceChatChannels(WorldSession* session)
{
    if (!CanUseVoiceChat())
        return;

    // send available voice channels
    if (Player* player = session->GetPlayer())
    {
        if (Group* grp = player->GetGroup())
        {
            if (!grp->isBGGroup() && !grp->isBFGroup())
                if (grp->isRaidGroup())
                    AddToRaidVoiceChatChannel(player->GetGUID(), grp->GetId());
                else
                    AddToGroupVoiceChatChannel(player->GetGUID(), grp->GetId());
            else
                AddToBattlegroundVoiceChatChannel(player->GetGUID());
        }
        if (Group* grp = player->GetOriginalGroup())
        {
            if (grp->isRaidGroup())
                AddToRaidVoiceChatChannel(player->GetGUID(), grp->GetId());
            else
                AddToGroupVoiceChatChannel(player->GetGUID(), grp->GetId());
        }

        std::vector<VoiceChatChannel*> channel_list = GetPossibleVoiceChatChannels(player->GetGUID());
        for (auto const& channel : channel_list)
            channel->AddVoiceChatMember(player->GetGUID());
    }
}

// Not used currently
void VoiceChatMgr::SendAvailableVoiceChatChannels(WorldSession* session)
{
    if (!CanUseVoiceChat())
        return;

    // send available voice channels
    if (Player* player = session->GetPlayer())
    {
        if (Group* grp = player->GetGroup())
        {
            if (!grp->isBGGroup() && !grp->isBFGroup())
            {
                if (grp->isRaidGroup())
                {
                    if (VoiceChatChannel* chn = GetRaidVoiceChatChannel(grp->GetId()))
                        chn->SendAvailableVoiceChatChannel(session);
                }
                else
                {
                    if (VoiceChatChannel* chn = GetGroupVoiceChatChannel(grp->GetId()))
                        chn->SendAvailableVoiceChatChannel(session);
                }
            }
            else if (VoiceChatChannel* chn =
                         GetBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId()))
            {
                chn->SendAvailableVoiceChatChannel(session);
            }
        }
        if (Group* grp = player->GetOriginalGroup())
        {
            if (grp->isRaidGroup())
            {
                if (VoiceChatChannel* chn = GetRaidVoiceChatChannel(grp->GetId()))
                    chn->SendAvailableVoiceChatChannel(session);
            }
            else
            {
                if (VoiceChatChannel* chn = GetGroupVoiceChatChannel(grp->GetId()))
                    chn->SendAvailableVoiceChatChannel(session);
            }
        }

        std::vector<VoiceChatChannel*> channel_list = GetPossibleVoiceChatChannels(player->GetGUID());
        for (auto channel : channel_list)
            channel->SendAvailableVoiceChatChannel(session);
    }
}

void VoiceChatMgr::RemoveFromVoiceChatChannels(ObjectGuid guid)
{
    for (auto const& channel : _VoiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        chn->RemoveVoiceChatMember(guid);
    }
}

//
void VoiceChatMgr::SendVoiceChatStatus(bool status)
{
    WorldPacket data(SMSG_VOICE_CHAT_STATUS, 1);
    data << uint8(status);
    sWorldSessionMgr->SendGlobalMessage(&data);
}

//
void VoiceChatMgr::SendVoiceChatServiceMessage(Opcodes opcode)
{
    WorldPacket data(opcode);
    sWorldSessionMgr->SendGlobalMessage(&data);
}

// command handlers
void VoiceChatMgr::DisableVoiceChat()
{
    if (!_voiceService.stopped() || (_socket && _socket->IsOpen()))
        SocketDisconnected();

    enabled = false;
    state = VOICECHAT_DISCONNECTED;
    SendVoiceChatStatus(false);
}

void VoiceChatMgr::EnableVoiceChat()
{
    if (enabled)
        return;

    enabled = true;
    // Init(m_ioContext);
    SendVoiceChatStatus(true);
}

VoiceChatStatistics VoiceChatMgr::GetStatistics()
{
    VoiceChatStatistics stats {};

    // amount of channels
    stats.channels = _VoiceChatChannels.size();

    // amount of active users
    stats.active_users = 0;
    stats.totalVoiceChatEnabled = 0;
    stats.totalVoiceMicEnabled = 0;
    ChatHandler(nullptr).DoForAllValidSessions([&](Player* player)
    {
        if (player->GetSession()->IsVoiceChatEnabled())
            stats.totalVoiceChatEnabled++;
        if (player->GetSession()->IsMicEnabled())
            stats.totalVoiceMicEnabled++;
        if (player->GetSession()->GetCurrentVoiceChannelId())
            stats.active_users++;
    });

    return stats;
}
