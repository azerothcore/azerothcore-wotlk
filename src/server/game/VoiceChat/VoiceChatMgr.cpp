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
            LOG_ERROR("voice-chat", "Failed to create voice chat session");
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
    _enabled = sWorld->getBoolConfig(CONFIG_VOICE_CHAT_ENABLED);

    _serverAddressString = sConfigMgr->GetOption<std::string>("VoiceChat.ServerAddress", "127.0.0.1");
    _serverAddress = inet_addr(_serverAddressString.c_str());
    _serverPort = sWorld->getIntConfig(CONFIG_VOICE_CHAT_SERVER_PORT);

    std::string voice_address_string = sConfigMgr->GetOption<std::string>("VoiceChat.VoiceAddress", "127.0.0.1");
    _voiceAddress = inet_addr(voice_address_string.c_str());
    _voicePort = sWorld->getIntConfig(CONFIG_VOICE_CHAT_VOICE_PORT);

    _maxConnectAttempts = sWorld->getIntConfig(CONFIG_VOICE_CHAT_MAX_CONNECT_ATTEMPTS);
}

void VoiceChatMgr::Init(Acore::Asio::IoContext& ioContext)
{
    LoadConfigs();

    _nextPing = std::chrono::system_clock::now() + std::chrono::seconds(5);
    _lastPong = std::chrono::system_clock::now();
    _lastUpdate = std::chrono::system_clock::now();
    _curReconnectAttempts = 0;

    _state = _enabled ? VOICECHAT_NOT_CONNECTED : VOICECHAT_DISCONNECTED;

    // Attempt an asynchronous connection to the voice server
    LOG_INFO("voice-chat", "Connecting to voice server at {}:{}", _serverAddressString, _serverPort);
    new AsyncConnector<VoiceChatSocket>(ioContext, _serverAddressString, _serverPort, false);

    // FIX: Store the connector
    _connector =
        std::make_unique<AsyncConnector<VoiceChatSocket>>(ioContext, _serverAddressString, _serverPort, false);

    // Optionally store a reference to ioContext in VoiceChatMgr if needed
}

void VoiceChatMgr::Update()
{
    if (!_enabled)
        return;

    LOG_DEBUG("voice-chat", "VoiceChatMgr::Update state: {}", _state);

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

    if (_state == VOICECHAT_DISCONNECTED)
        return;

    auto now = std::chrono::system_clock::now();
    if (now - _lastUpdate < std::chrono::seconds(1))
        return;

    _lastUpdate = now;

    if (_requestSocket)
    {
        _socket = _requestSocket;
        _requestSocket = nullptr;
        return;
    }

    // connecting / reconnecting
    if (!_socket)
    {
        if (_state == VOICECHAT_CONNECTED)
        {
            LOG_ERROR("voice-chat", "No socket but connected state, disconnecting socket");
            SocketDisconnected();
            SendVoiceChatServiceDisconnect();
            _state = VOICECHAT_RECONNECTING;
            _nextConnect = std::chrono::system_clock::now() + std::chrono::seconds(10);
            return;
        }

        if (_state == VOICECHAT_RECONNECTING)
        {
            if (_maxConnectAttempts >= 0 && _curReconnectAttempts >= _maxConnectAttempts)
            {
                if (_maxConnectAttempts > 0)
                    LOG_ERROR("voice-chat", "Disconnected! Max reconnect attempts reached");
                else
                    LOG_ERROR("voice-chat", "Disconnected! Reconnecting disabled");

                DeleteAllChannels();
                SendVoiceChatStatus(false);
                SendVoiceChatServiceConnectFail();
                _curReconnectAttempts = 0;
                _state = VOICECHAT_DISCONNECTED;
                return;
            }
        }

        if (now > _nextConnect)
        {
            if (NeedConnect() || NeedReconnect())
                ActivateVoiceSocketThread();

            if (_curReconnectAttempts > 0)
            {
                if (_state == VOICECHAT_NOT_CONNECTED)
                    LOG_ERROR("voice-chat", "Connect failed, will try again later");
                if (_state == VOICECHAT_RECONNECTING)
                    LOG_ERROR("voice-chat", "Reconnect failed, will try again later");
            }

            if (_state == VOICECHAT_NOT_CONNECTED || _state == VOICECHAT_RECONNECTING)
                _curReconnectAttempts++;

            _nextConnect = now + std::chrono::seconds(10);
            return;
        }
    }
    else
    {
        if (!_socket->IsOpen())
        {
            if (_state == VOICECHAT_CONNECTED)
            {
                LOG_ERROR("voice-chat", "Socket not open but connected state, disconnecting socket");
                SocketDisconnected();
                SendVoiceChatServiceDisconnect();
                _state = VOICECHAT_RECONNECTING;
                return;
            }

            if (now > _nextConnect)
            {
                if (!_requestSocket && (_state == VOICECHAT_NOT_CONNECTED || _state == VOICECHAT_RECONNECTING))
                {
                    ActivateVoiceSocketThread();
                    _nextConnect = now + std::chrono::seconds(5);
                }
            }
            return;
        }

        // socket is open
        if (_state == VOICECHAT_NOT_CONNECTED || _state == VOICECHAT_RECONNECTING)
        {
            if (_state == VOICECHAT_NOT_CONNECTED)
                LOG_INFO("voice-chat",
                    "Connected to {}:{}.",
                    _socket->GetRemoteIpAddress().to_string(),
                    _socket->GetRemotePort());
            if (_state == VOICECHAT_RECONNECTING)
                LOG_INFO("voice-chat",
                    "Reconnected to {}:{}",
                    _socket->GetRemoteIpAddress().to_string(),
                    _socket->GetRemotePort());

            SendVoiceChatStatus(true);
            RestoreVoiceChatChannels();
            if (_state == VOICECHAT_RECONNECTING)
                SendVoiceChatServiceReconnected();

            _state = VOICECHAT_CONNECTED;
            _curReconnectAttempts = 0;
            _lastPong = now;
        }
        else
        {
            if (now >= _nextPing)
            {
                LOG_DEBUG("voice-chat", "Sending ping");
                _nextPing = now + std::chrono::seconds(5);
                VoiceChatServerPacket data(VOICECHAT_CMSG_PING, 4);
                data << uint32(0);
                _socket->SendPacket(data);
            }

            if (_socket && (now - _lastPong) > std::chrono::seconds(10))
            {
                LOG_ERROR("voice-chat", "Ping timeout!");
                SocketDisconnected();
                // SendVoiceChatServiceDisconnect();
                _state = VOICECHAT_RECONNECTING;
                // next_connect = now + std::chrono::seconds(10);
            }
        }
    }
}

void VoiceChatMgr::HandleVoiceChatServerPacket(VoiceChatServerPacket& pck)
{
    uint32 requestId;
    uint8 error;
    uint16 channelId;

    LOG_DEBUG("voice-chat", "VoiceChatMgr::HandleVoiceChatServerPacket Received {}", pck.GetOpcode());

    switch (pck.GetOpcode())
    {
        case VOICECHAT_SMSG_PONG:
        {
            _lastPong = std::chrono::system_clock::now();
            break;
        }
        case VOICECHAT_SMSG_CHANNEL_CREATED:
        {
            pck >> requestId;
            pck >> error;

            for (auto request = _requests.begin(); request != _requests.end();)
            {
                if (request->Id == requestId)
                {
                    if (error == 0)
                        pck >> channelId;
                    else
                    {
                        LOG_ERROR("voice-chat", "Error creating voice channel");
                        request = _requests.erase(request);
                        return;
                    }

                    if (request->GroupId)
                    {
                        if (request->Type == VOICECHAT_CHANNEL_GROUP || request->Type == VOICECHAT_CHANNEL_RAID)
                        {
                            Group* group = sGroupMgr->GetGroupByGUID(request->GroupId);
                            if (group)
                            {
                                auto* voiceChannel = new VoiceChatChannel(
                                    VoiceChatChannelTypes(request->Type), channelId, group->GetId());
                                _voiceChatChannels.insert(std::make_pair((uint32)channelId, voiceChannel));
                                voiceChannel->AddMembersAfterCreate();
                            }
                        }
                        else if (request->Type == VOICECHAT_CHANNEL_BG)
                        {
                            Battleground* bg =
                                sBattlegroundMgr->GetBattleground(request->GroupId, BATTLEGROUND_TYPE_NONE);
                            if (bg)
                            {
                                // for BG use bg's instanceID as groupID
                                auto* voiceChannel = new VoiceChatChannel(VoiceChatChannelTypes(request->Type),
                                    channelId,
                                    request->GroupId,
                                    "",
                                    request->Team);
                                _voiceChatChannels.insert(std::make_pair((uint32)channelId, voiceChannel));
                                voiceChannel->AddMembersAfterCreate();
                            }
                        }
                    }
                    else if (request->Type == VOICECHAT_CHANNEL_CUSTOM)
                    {
                        if (ChannelMgr* cMgr = ChannelMgr::forTeam(request->Team))
                        {
                            Channel* chan = cMgr->GetChannel(request->ChannelName, nullptr, false);
                            if (chan)
                            {
                                auto* voiceChannel = new VoiceChatChannel(VoiceChatChannelTypes(request->Type),
                                    channelId,
                                    0,
                                    request->ChannelName,
                                    request->Team);
                                _voiceChatChannels.insert(std::make_pair((uint32)channelId, voiceChannel));
                                voiceChannel->AddMembersAfterCreate();
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

    _curReconnectAttempts = 0;
}

bool VoiceChatMgr::NeedConnect()
{
    return _enabled && !_socket && !_requestSocket && _state == VOICECHAT_NOT_CONNECTED &&
           std::chrono::system_clock::now() > _nextConnect;
}

bool VoiceChatMgr::NeedReconnect()
{
    return _enabled && !_socket && !_requestSocket && _state == VOICECHAT_RECONNECTING &&
           std::chrono::system_clock::now() > _nextConnect;
}

int32 VoiceChatMgr::GetReconnectAttempts() const
{
    if (_maxConnectAttempts < 0 || (_maxConnectAttempts > 0 && _curReconnectAttempts < _maxConnectAttempts))
        return _maxConnectAttempts;

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
    return (_enabled && _socket);
}

// enabled and is connected or trying to connect to voice server
bool VoiceChatMgr::CanSeeVoiceChat()
{
    return (_enabled && _state != VOICECHAT_DISCONNECTED);
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
    req.Id = _newRequestId++;
    req.Type = type;
    req.ChannelName = name;
    req.Team = newTeam;
    req.GroupId = groupId;
    _requests.push_back(req);

    VoiceChatServerPacket data(VOICECHAT_CMSG_CREATE_CHANNEL, 5);
    data << req.Type;
    data << req.Id;
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

    _voiceChatChannels.erase(channel->GetChannelId());
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
        if (req.Type != type)
            return false;
        if (groupId && req.GroupId != groupId)
            return false;
        if (!name.empty() && req.ChannelName != name)
            return false;
        if (req.Team != team)
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

    if (VoiceChatChannel* voiceChannel = GetCustomVoiceChatChannel(name, team))
        DeleteVoiceChatChannel(voiceChannel);
}

void VoiceChatMgr::ConvertToRaidChannel(uint32 groupId)
{
    if (VoiceChatChannel* chn = GetGroupVoiceChatChannel(groupId))
        chn->ConvertToRaid();
}

VoiceChatChannel* VoiceChatMgr::GetVoiceChatChannel(uint16 channelId)
{
    auto itr = _voiceChatChannels.find(channelId);
    if (itr == _voiceChatChannels.end())
        return nullptr;

    return itr->second;
}

//
VoiceChatChannel* VoiceChatMgr::GetGroupVoiceChatChannel(uint32 group_id)
{
    for (auto& channel : _voiceChatChannels)
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
    for (auto& channel : _voiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_RAID && chn->GetGroupId() == group_id)
            return chn;
    }

    return nullptr;
}

VoiceChatChannel* VoiceChatMgr::GetBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team)
{
    for (auto& channel : _voiceChatChannels)
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
    for (auto& channels : _voiceChatChannels)
    {
        VoiceChatChannel* v_chan = channels.second;
        if (v_chan->GetType() == VOICECHAT_CHANNEL_CUSTOM && v_chan->GetChannelName() == name &&
            v_chan->GetTeam() == GetCustomChannelTeam(team))
            return v_chan;
    }

    return nullptr;
}

// get possible voice channels after login or voice chat enable
std::vector<VoiceChatChannel*> VoiceChatMgr::GetPossibleVoiceChatChannels(ObjectGuid guid)
{
    std::vector<VoiceChatChannel*> channelList;
    Player* player = ObjectAccessor::FindConnectedPlayer(guid);
    if (!player)
        return channelList;

    for (auto& channels : _voiceChatChannels)
    {
        VoiceChatChannel* voiceChannel = channels.second;
        if (voiceChannel->GetType() != VOICECHAT_CHANNEL_CUSTOM)
            continue;

        if (voiceChannel->GetTeam() != GetCustomChannelTeam(player->GetTeamId()))
            continue;

        {
            auto cMgr = ChannelMgr(player->GetTeamId());
            Channel* channel = cMgr.GetChannel(voiceChannel->GetChannelName(), nullptr, false);
            if (channel && channel->IsOn(guid) && !channel->IsBanned(guid) && channel->IsVoiceEnabled())
                channelList.push_back(voiceChannel);
        }
    }

    return channelList;
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
                        {
                            if (grp->isRaidGroup())
                                sVoiceChatMgr.AddToRaidVoiceChatChannel(player->GetGUID(), grp->GetId());
                            else
                                sVoiceChatMgr.AddToGroupVoiceChatChannel(player->GetGUID(), grp->GetId());
                        }
                        else
                            sVoiceChatMgr.AddToBattlegroundVoiceChatChannel(player->GetGUID());
                    }
                    if (Group* grp = player->GetOriginalGroup())
                    {
                        if (!grp->isBGGroup() && !grp->isBFGroup())
                        {
                            if (grp->isRaidGroup())
                                sVoiceChatMgr.AddToRaidVoiceChatChannel(player->GetGUID(), grp->GetId());
                            else
                                sVoiceChatMgr.AddToGroupVoiceChatChannel(player->GetGUID(), grp->GetId());
                        }
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
    for (auto& channel : _voiceChatChannels)
        DeleteVoiceChatChannel(channel.second);
    _voiceChatChannels.clear();
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

    VoiceChatChannel* voiceChannel = GetGroupVoiceChatChannel(groupId);
    if (!voiceChannel)
    {
        CreateGroupVoiceChatChannel(groupId);
        return;
    }

    voiceChannel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    VoiceChatChannel* voiceChannel = GetRaidVoiceChatChannel(groupId);
    if (!voiceChannel)
    {
        CreateRaidVoiceChatChannel(groupId);
        return;
    }

    voiceChannel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToBattlegroundVoiceChatChannel(ObjectGuid guid)
{
    Player* player = ObjectAccessor::FindPlayer(guid);
    if (!player)
        return;

    if (!player->InBattleground())
        return;

    // for BG use bg's instanceID as groupID
    VoiceChatChannel* voiceChannel = GetBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId());
    if (!voiceChannel)
    {
        CreateBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId());
        return;
    }

    voiceChannel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToCustomVoiceChatChannel(ObjectGuid guid, std::string const& name, TeamId team)
{
    if (name.empty())
        return;

    VoiceChatChannel* voiceChannel = GetCustomVoiceChatChannel(name, team);
    if (!voiceChannel)
    {
        CreateCustomVoiceChatChannel(name, team);
        return;
    }

    voiceChannel->AddVoiceChatMember(guid);
}

//
void VoiceChatMgr::RemoveFromGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* voiceChannel = GetGroupVoiceChatChannel(groupId))
        voiceChannel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* voiceChannel = GetRaidVoiceChatChannel(groupId))
        voiceChannel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromBattlegroundVoiceChatChannel(ObjectGuid guid)
{
    Player* player = ObjectAccessor::FindPlayer(guid);
    if (!player)
        return;

    if (!player->InBattleground())
        return;

    if (VoiceChatChannel* voiceChannel = GetBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId()))
        voiceChannel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromCustomVoiceChatChannel(ObjectGuid guid, std::string const& name, TeamId team)
{
    if (name.empty())
        return;

    if (VoiceChatChannel* voiceChannel = GetCustomVoiceChatChannel(name, team))
        voiceChannel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::EnableChannelSlot(uint16 channelId, uint8 slotId)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Channel enabled with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} activate slot {}", (int)channelId, (int)slotId);

    VoiceChatServerPacket data(VOICECHAT_CMSG_ADD_MEMBER, 5);
    data << channelId;
    data << slotId;
    _socket->SendPacket(data);
}

//
void VoiceChatMgr::DisableChannelSlot(uint16 channelId, uint8 slotId)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Channel disabled with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} deactivate slot {}", (int)channelId, (int)slotId);

    VoiceChatServerPacket data(VOICECHAT_CMSG_REMOVE_MEMBER, 5);
    data << channelId;
    data << slotId;
    _socket->SendPacket(data);
}

//
void VoiceChatMgr::VoiceChannelSlot(uint16 channelId, uint8 slotId)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Slot voiced with no socket!");
        return;
    }

    LOG_ERROR("voice-chat", "Channel {} voice slot {}", (int)channelId, (int)slotId);

    VoiceChatServerPacket data(VOICECHAT_CMSG_VOICE_MEMBER, 5);
    data << channelId;
    data << slotId;
    _socket->SendPacket(data);
}

//
void VoiceChatMgr::DevoiceChannelSlot(uint16 channelId, uint8 slotId)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Slot devoiced with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} devoice slot {}", (int)channelId, (int)slotId);

    VoiceChatServerPacket data(VOICECHAT_CMSG_DEVOICE_MEMBER, 5);
    data << channelId;
    data << slotId;
    _socket->SendPacket(data);
}

void VoiceChatMgr::MuteChannelSlot(uint16 channelId, uint8 slotId)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Slot muted with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} mute slot {}", (int)channelId, (int)slotId);

    VoiceChatServerPacket data(VOICECHAT_CMSG_MUTE_MEMBER, 5);
    data << channelId;
    data << slotId;
    _socket->SendPacket(data);
}

void VoiceChatMgr::UnmuteChannelSlot(uint16 channelId, uint8 slotId)
{
    if (!_socket)
    {
        LOG_ERROR("voice-chat", "Slot unmuted with no socket!");
        return;
    }

    LOG_INFO("voice-chat", "Channel {} unmute slot {}", (int)channelId, (int)slotId);

    VoiceChatServerPacket data(VOICECHAT_CMSG_UNMUTE_MEMBER, 5);
    data << channelId;
    data << slotId;
    _socket->SendPacket(data);
}

void VoiceChatMgr::JoinAvailableVoiceChatChannels(WorldSession* session)
{
    if (!CanUseVoiceChat())
        return;

    // send available voice channels
    if (Player* player = session->GetPlayer())
    {
        if (Group* group = player->GetGroup())
        {
            if (!group->isBGGroup() && !group->isBFGroup())
            {
                if (group->isRaidGroup())
                    AddToRaidVoiceChatChannel(player->GetGUID(), group->GetId());
                else
                    AddToGroupVoiceChatChannel(player->GetGUID(), group->GetId());
            }
            else
                AddToBattlegroundVoiceChatChannel(player->GetGUID());
        }
        if (Group* group = player->GetOriginalGroup())
        {
            if (group->isRaidGroup())
                AddToRaidVoiceChatChannel(player->GetGUID(), group->GetId());
            else
                AddToGroupVoiceChatChannel(player->GetGUID(), group->GetId());
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
        if (Group* group = player->GetGroup())
        {
            if (!group->isBGGroup() && !group->isBFGroup())
            {
                if (group->isRaidGroup())
                {
                    if (VoiceChatChannel* voiceChannel = GetRaidVoiceChatChannel(group->GetId()))
                        voiceChannel->SendAvailableVoiceChatChannel(session);
                }
                else
                {
                    if (VoiceChatChannel* voiceChannel = GetGroupVoiceChatChannel(group->GetId()))
                        voiceChannel->SendAvailableVoiceChatChannel(session);
                }
            }
            else if (VoiceChatChannel* voiceChannel = GetBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId()))
                voiceChannel->SendAvailableVoiceChatChannel(session);
        }
        if (Group* group = player->GetOriginalGroup())
        {
            if (group->isRaidGroup())
            {
                if (VoiceChatChannel* voiceChannel = GetRaidVoiceChatChannel(group->GetId()))
                    voiceChannel->SendAvailableVoiceChatChannel(session);
            }
            else
            {
                if (VoiceChatChannel* voiceChannel = GetGroupVoiceChatChannel(group->GetId()))
                    voiceChannel->SendAvailableVoiceChatChannel(session);
            }
        }

        std::vector<VoiceChatChannel*> channel_list = GetPossibleVoiceChatChannels(player->GetGUID());
        for (auto channel : channel_list)
            channel->SendAvailableVoiceChatChannel(session);
    }
}

void VoiceChatMgr::RemoveFromVoiceChatChannels(ObjectGuid guid)
{
    for (auto const& channel : _voiceChatChannels)
    {
        VoiceChatChannel* voiceChannel = channel.second;
        voiceChannel->RemoveVoiceChatMember(guid);
    }
}

void VoiceChatMgr::SendVoiceChatStatus(bool status)
{
    WorldPacket data(SMSG_VOICE_CHAT_STATUS, 1);
    data << uint8(status);
    sWorldSessionMgr->SendGlobalMessage(&data);
}

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

    _enabled = false;
    _state = VOICECHAT_DISCONNECTED;
    SendVoiceChatStatus(false);
}

void VoiceChatMgr::EnableVoiceChat()
{
    if (_enabled)
        return;

    _enabled = true;
    // Init(m_ioContext);
    SendVoiceChatStatus(true);
}

VoiceChatStatistics VoiceChatMgr::GetStatistics()
{
    VoiceChatStatistics stats {};

    // amount of channels
    stats.Channels = _voiceChatChannels.size();

    // amount of active users
    stats.ActiveUsers = 0;
    stats.TotalVoiceChatEnabled = 0;
    stats.TotalVoiceMicEnabled = 0;
    ChatHandler(nullptr).DoForAllValidSessions([&](Player* player)
    {
        if (player->GetSession()->IsVoiceChatEnabled())
            stats.TotalVoiceChatEnabled++;
        if (player->GetSession()->IsMicEnabled())
            stats.TotalVoiceMicEnabled++;
        if (player->GetSession()->GetCurrentVoiceChannelId())
            stats.ActiveUsers++;
    });

    return stats;
}
