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
#include "Common.h"
#include "GroupMgr.h"
#include "Log.h"
#include "Player.h"
#include "SharedDefines.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"
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
}

VoiceChatMgr::~VoiceChatMgr()
{
    // Ensure proper cleanup
    SocketDisconnected();

    // Clear any remaining channels
    DeleteAllChannels();

    // Stop the voice service if it's running
    if (!_voiceService.stopped())
        _voiceService.stop();
}

void VoiceChatMgr::ActivateVoiceSocketThread()
{
    std::thread t(VoiceSocketThreadHelper);
    t.detach();
}

void VoiceChatMgr::VoiceSocketThread()
{
    LOG_INFO("voice-chat", "Voice socket thread started");

    uint32 realCurrTime = 0;
    uint32 realPrevTime = getMSTime();

    // Keep trying to connect/reconnect while voice chat is enabled
    while (_enabled)
    {
        try
        {
            realCurrTime = getMSTime();

            uint32 diff = getMSTimeDiff(realPrevTime, realCurrTime);
            // Only attempt connection when we need to connect or reconnect
            if (!NeedConnect(diff) && !NeedReconnect(diff))
            {
                std::this_thread::sleep_for(std::chrono::seconds(1));
                continue;
            }

            if (_state == VOICECHAT_NOT_CONNECTED)
                LOG_INFO("voice-chat", "Voice socket thread attempting initial connection...");
            else
                LOG_INFO("voice-chat", "Voice socket thread attempting reconnection (attempt {})...", _curReconnectAttempts + 1);

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
                HandleConnectionFailure();
                continue;
            }

            // Create and connect socket
            tcp::socket socket(ioContext);
            boost::system::error_code connectError;
            boost::asio::connect(socket, endpoints, connectError);

            if (connectError)
            {
                LOG_ERROR("voice-chat", "Failed to connect to voice server: {}", connectError.message());
                HandleConnectionFailure();
                continue;
            }

            LOG_INFO("voice-chat", "Successfully connected to voice server");

            // Create voice chat session
            auto voiceChatSocket = std::make_shared<VoiceChatSocket>(std::move(socket));

            if (voiceChatSocket && voiceChatSocket->IsOpen())
            {
                // Request the socket to be used by VoiceChatMgr
                if (RequestNewSocket(voiceChatSocket.get()))
                {
                    LOG_INFO("voice-chat", "Socket requested successfully, starting socket operations");
                    voiceChatSocket->Start();

                    // Run the IO context - this will block until disconnection
                    ioContext.run();

                    LOG_WARN("voice-chat", "Voice server connection lost");
                }
                else
                    LOG_ERROR("voice-chat", "Failed to request new socket");
            }
            else
                LOG_ERROR("voice-chat", "Failed to create voice chat session or socket is not open");

            // Connection lost, clean up and prepare for reconnect
            if (_enabled) // Only set reconnecting state if still enabled
            {
                LOG_INFO("voice-chat", "Preparing for reconnection...");
                HandleConnectionLoss();
            }
        }
        catch (boost::system::system_error const& e)
        {
            LOG_ERROR("voice-chat", "Boost system error in voice chat thread: {}", e.what());
            if (_enabled)
                HandleConnectionFailure();
        }
        catch (std::exception const& e)
        {
            LOG_ERROR("voice-chat", "Exception in voice chat thread: {}", e.what());
            if (_enabled)
                HandleConnectionFailure();
        }
        catch (...)
        {
            LOG_ERROR("voice-chat", "Unknown exception in voice chat thread");
            if (_enabled)
                HandleConnectionFailure();
        }

        // Small delay before next iteration
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }

    LOG_INFO("voice-chat", "Voice socket thread exiting");
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

void VoiceChatMgr::Init()
{
    LoadConfigs();

    _nextPingTimer = 5 * SECOND * IN_MILLISECONDS;
    _lastPongElapsed = 0;
    _lastUpdateTimer = 0;
    _curReconnectAttempts = 0;

    if (_enabled)
    {
        _state = VOICECHAT_NOT_CONNECTED;
        _nextConnectTimer = 0;

        // Auto-start the voice chat connection thread
        LOG_INFO("voice-chat", "Voice chat is enabled, starting connection thread");
        ActivateVoiceSocketThread();
    }
    else
    {
        _state = VOICECHAT_DISCONNECTED;
        LOG_INFO("voice-chat", "Voice chat is disabled");
    }
}

void VoiceChatMgr::Update(uint32 diff)
{
    if (!_enabled)
        return;

    LOG_DEBUG("voice-chat", "VoiceChatMgr::Update state: {}", _state);

    _eventEmitter(this);

    auto currentSocket = _socket.lock();

    if (currentSocket)
        currentSocket->Update();

    // Process received packets
    std::deque<std::unique_ptr<VoiceChatServerPacket>> recvQueueCopy;
    {
        std::lock_guard<std::mutex> guard(_recvQueueLock);
        std::swap(recvQueueCopy, _recvQueue);
    }

    while (currentSocket && currentSocket->IsOpen() && !recvQueueCopy.empty())
    {
        auto const packet = std::move(recvQueueCopy.front());
        recvQueueCopy.pop_front();

        try
        {
            LOG_DEBUG("voice-chat", "Processing packet from server, opcode: {}", packet->GetOpcode());
            HandleVoiceChatServerPacket(*packet);
        }
        catch (ByteBufferException const&)
        {
            LOG_ERROR("voice-chat", "ByteBufferException processing packet");
            ProcessByteBufferException(*packet);
        }
    }

    if (_state == VOICECHAT_DISCONNECTED)
        return;

    if (diff < _lastUpdateTimer)
    {
        _lastUpdateTimer -= diff;
        return;
    }
    else
        _lastUpdateTimer = 1 * SECOND * IN_MILLISECONDS;

    // Handle new socket assignment
    if (!_requestSocket.expired())
    {
        auto newSocket = _requestSocket.lock();
        if (newSocket && newSocket->IsOpen())
        {
            LOG_INFO("voice-chat", "Assigning new socket from request");
            _socket = newSocket;
            _requestSocket.reset();
            currentSocket = newSocket;
        }
        else
        {
            LOG_ERROR("voice-chat", "Request socket is invalid or closed");
            _requestSocket.reset();
            if (_state == VOICECHAT_CONNECTED)
            {
                SocketDisconnected();
                SendVoiceChatServiceDisconnect();
            }
            _state = VOICECHAT_RECONNECTING;
            _nextConnectTimer = 10 * SECOND * IN_MILLISECONDS;
            return;
        }
    }

    // Check connection state
    if (!currentSocket)
    {
        if (_state == VOICECHAT_CONNECTED)
        {
            LOG_ERROR("voice-chat", "No socket but connected state, disconnecting");
            SocketDisconnected();
            SendVoiceChatServiceDisconnect();
            _state = VOICECHAT_RECONNECTING;
            _nextConnectTimer = 10 * SECOND * IN_MILLISECONDS;
        }
        return;
    }

    if (!currentSocket->IsOpen())
    {
        if (_state == VOICECHAT_CONNECTED)
        {
            LOG_ERROR("voice-chat", "Socket not open but connected state, disconnecting");
            SocketDisconnected();
            SendVoiceChatServiceDisconnect();
            _state = VOICECHAT_RECONNECTING;
        }
        return;
    }

    // Socket is open and valid - handle state transitions
    if (_state == VOICECHAT_NOT_CONNECTED || _state == VOICECHAT_RECONNECTING)
    {
        bool wasReconnecting = (_state == VOICECHAT_RECONNECTING);

        if (_state == VOICECHAT_NOT_CONNECTED)
            LOG_INFO("voice-chat", "Connected to {}:{}", currentSocket->GetRemoteIpAddress().to_string(), currentSocket->GetRemotePort());
        if (_state == VOICECHAT_RECONNECTING)
            LOG_INFO("voice-chat", "Reconnected to {}:{}", currentSocket->GetRemoteIpAddress().to_string(), currentSocket->GetRemotePort());

        // Update state first
        _state = VOICECHAT_CONNECTED;
        _curReconnectAttempts = 0;
        _lastPongElapsed = 0;

        // Send status to all clients
        SendVoiceChatStatus(true);

        // Restore/recreate channels
        RestoreVoiceChatChannels();
        if (wasReconnecting)
            SendVoiceChatServiceReconnected();
    }
    else if (_state == VOICECHAT_CONNECTED)
    {
        // Handle ping/pong logic
        if (diff >= _nextPingTimer)
        {
            LOG_DEBUG("voice-chat", "Sending ping");
            _nextPingTimer = 5 * SECOND * IN_MILLISECONDS;
            VoiceChatServerPacket data(VOICECHAT_CMSG_PING, 4);
            data << uint32(0);
            currentSocket->SendPacket(data);
        }

        _nextPingTimer -= diff;

        if (_lastPongElapsed >= 15 * SECOND * IN_MILLISECONDS)
        {
            LOG_ERROR("voice-chat", "Ping timeout! Last pong was {} seconds ago", _lastPongElapsed);
            SocketDisconnected();
            SendVoiceChatServiceDisconnect();
            _state = VOICECHAT_RECONNECTING;
            _nextConnectTimer = 5 * SECOND * IN_MILLISECONDS;
        }

        _lastPongElapsed += diff;
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
            _lastPongElapsed = 0;
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
                                    VoiceChatChannelTypes(request->Type), channelId, group->GetGroupId());
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
    LOG_WARN("voice-chat", "VoiceChatServerSocket disconnected - cleaning up");

    // Clear socket references
    _socket.reset();
    _requestSocket.reset();

    _requests.clear();

    // Don't delete channels here - let reconnection handle restoration
    _curReconnectAttempts = 0;
}

bool VoiceChatMgr::NeedConnect(uint32 diff)
{
    auto currentSocket = _socket.lock();
    auto currentRequestSocket = _requestSocket.lock();

    return _enabled && !currentSocket && !currentRequestSocket && _state == VOICECHAT_NOT_CONNECTED &&
           diff >= _nextConnectTimer;
}

bool VoiceChatMgr::NeedReconnect(uint32 diff)
{
    auto currentSocket = _socket.lock();
    auto currentRequestSocket = _requestSocket.lock();

    return _enabled && !currentSocket && !currentRequestSocket && _state == VOICECHAT_RECONNECTING &&
           diff >= _nextConnectTimer;
}

int32 VoiceChatMgr::GetReconnectAttempts() const
{
    if (_maxConnectAttempts < 0 || (_maxConnectAttempts > 0 && _curReconnectAttempts < _maxConnectAttempts))
        return _maxConnectAttempts;

    return 0;
}

bool VoiceChatMgr::RequestNewSocket(VoiceChatSocket* socket)
{
    if (!socket || !socket->IsOpen())
    {
        LOG_ERROR("voice-chat", "Attempted to request invalid or closed socket");
        return false;
    }

    // Check if we already have a request socket
    if (!_requestSocket.expired())
    {
        LOG_WARN("voice-chat", "Request socket already exists, rejecting new request");
        return false;
    }

    // Store as weak_ptr
    _requestSocket = socket->shared_from_this();
    LOG_INFO("voice-chat", "New socket requested successfully");
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

    LOG_ERROR("voice-chat", "Dumping error-causing voice server packet:");
    packet.hexlike();

    LOG_ERROR("voice-chat", "Disconnecting voice server [address {}] for badly formatted packet.", GetVoiceServerConnectAddressString());

    _eventEmitter += [](VoiceChatMgr* mgr) { mgr->SocketDisconnected(); };
}

// enabled and connected to voice server
bool VoiceChatMgr::CanUseVoiceChat()
{
    auto currentSocket = _socket.lock();

    return (_enabled && currentSocket && currentSocket->IsOpen());
}

// enabled and is connected or trying to connect to voice server
bool VoiceChatMgr::CanSeeVoiceChat()
{
    return (_enabled && _state != VOICECHAT_DISCONNECTED);
}

void VoiceChatMgr::CreateVoiceChatChannel(VoiceChatChannelTypes type, uint32 groupId, std::string const& name, TeamId team)
{
    auto currentSocket = _socket.lock();

    if (!currentSocket || !currentSocket->IsOpen() || _state != VOICECHAT_CONNECTED)
    {
        LOG_ERROR("voice-chat", "Cannot create voice channel - invalid socket state");
        return;
    }

    if (type == VOICECHAT_CHANNEL_NONE)
        return;

    if (!groupId && name.empty())
        return;

    TeamId newTeam = GetCustomChannelTeam(team);

    if (IsVoiceChatChannelBeingCreated(type, groupId, name, newTeam))
        return;

    try
    {
        LOG_INFO("voice-chat", "CreateVoiceChannel type: {}, name: {}, team: {}, group: {}", type, name.c_str(), newTeam, groupId);
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
        currentSocket->SendPacket(data);
    }
    catch (const std::exception& e)
    {
        LOG_ERROR("voice-chat", "Exception sending packet: {}", e.what());
    }
}

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
        auto cMgr = ChannelMgr(channel->GetTeam());
        if (Channel* chn = cMgr.GetChannel(channel->GetChannelName(), nullptr, false))
        {
            if (chn->IsVoiceEnabled())
                chn->ToggleVoice();
        }
    }

    _voiceChatChannels.erase(channel->GetChannelId());
    delete channel;

    auto currentSocket = _socket.lock();

    // Only send delete packet if we're connected
    if (currentSocket && currentSocket->IsOpen() && _state == VOICECHAT_CONNECTED)
    {
        try
        {
            VoiceChatServerPacket data(VOICECHAT_CMSG_DELETE_CHANNEL, 5);
            data << type;
            data << id;
            currentSocket->SendPacket(data);
            LOG_DEBUG("voice-chat", "Sent delete channel packet for channel {}", id);
        }
        catch (const std::exception& e)
        {
            LOG_ERROR("voice-chat", "Exception sending delete channel packet: {}", e.what());
        }
    }
    else
        LOG_DEBUG("voice-chat", "Skipping delete channel packet - not connected to voice server");
}

// check if channel request has already been created
bool VoiceChatMgr::IsVoiceChatChannelBeingCreated(VoiceChatChannelTypes type, uint32 groupId, std::string const& name, TeamId team)
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

VoiceChatChannel* VoiceChatMgr::GetGroupVoiceChatChannel(uint32 groupId)
{
    for (auto& channel : _voiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_GROUP && chn->GetGroupId() == groupId)
            return chn;
    }

    return nullptr;
}

VoiceChatChannel* VoiceChatMgr::GetRaidVoiceChatChannel(uint32 groupId)
{
    for (auto& channel : _voiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_RAID && chn->GetGroupId() == groupId)
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
    LOG_INFO("voice-chat", "Restoring voice chat channels after connection");

    std::vector<std::pair<VoiceChatChannelTypes, uint32>> groupChannels;
    std::vector<std::pair<VoiceChatChannelTypes, uint32>> raidChannels;
    std::vector<std::tuple<std::string, TeamId>> customChannels;
    std::vector<std::tuple<uint32, TeamId>> bgChannels;

    // Collect existing channel info before clearing
    for (auto& channel : _voiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (!chn) continue;

        switch (chn->GetType())
        {
        case VOICECHAT_CHANNEL_GROUP:
            groupChannels.emplace_back(VOICECHAT_CHANNEL_GROUP, chn->GetGroupId());
            break;
        case VOICECHAT_CHANNEL_RAID:
            raidChannels.emplace_back(VOICECHAT_CHANNEL_RAID, chn->GetGroupId());
            break;
        case VOICECHAT_CHANNEL_CUSTOM:
            customChannels.emplace_back(chn->GetChannelName(), chn->GetTeam());
            break;
        case VOICECHAT_CHANNEL_BG:
            bgChannels.emplace_back(chn->GetGroupId(), chn->GetTeam());
            break;
        default:
            break;
        }
    }

    DeleteAllChannels();

    // Recreate channels from active players
    ChatHandler(nullptr).DoForAllValidSessions([this](Player* player)
        {
            WorldSession const* sess = player->GetSession();
            if (!sess->IsVoiceChatEnabled())
                return;

            if (Group* grp = player->GetGroup())
            {
                if (!grp->isBGGroup() && !grp->isBFGroup())
                {
                    if (grp->isRaidGroup())
                        CreateRaidVoiceChatChannel(grp->GetGroupId());
                    else
                        CreateGroupVoiceChatChannel(grp->GetGroupId());
                }
                else
                    CreateBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId());
            }

            if (Group* grp = player->GetOriginalGroup())
            {
                if (!grp->isBGGroup() && !grp->isBFGroup())
                {
                    if (grp->isRaidGroup())
                        CreateRaidVoiceChatChannel(grp->GetGroupId());
                    else
                        CreateGroupVoiceChatChannel(grp->GetGroupId());
                }
            }
        });

    // Recreate custom channels that still have active users
    for (auto& customChannel : customChannels)
    {
        std::string channelName = std::get<0>(customChannel);
        TeamId team = std::get<1>(customChannel);

        // Check if channel still has users
        bool hasUsers = false;
        ChatHandler(nullptr).DoForAllValidSessions([&](Player* player)
            {
                if (!hasUsers && player->GetSession()->IsVoiceChatEnabled())
                {
                    auto cMgr = ChannelMgr(player->GetTeamId());
                    Channel* channel = cMgr.GetChannel(channelName, nullptr, false);
                    if (channel && channel->IsOn(player->GetGUID()) && channel->IsVoiceEnabled())
                        hasUsers = true;
                }
            });

        if (hasUsers)
        {
            CreateCustomVoiceChatChannel(channelName, team);
        }
    }

    LOG_INFO("voice-chat", "Voice chat channels restoration completed");
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
    auto currentSocket = _socket.lock();

    if (!currentSocket || !currentSocket->IsOpen() || _state != VOICECHAT_CONNECTED)
    {
        LOG_ERROR("voice-chat", "Cannot enable channel slot - invalid socket state");
        return;
    }

    try
    {
        LOG_INFO("voice-chat", "Channel {} activate slot {}", (int)channelId, (int)slotId);

        VoiceChatServerPacket data(VOICECHAT_CMSG_ADD_MEMBER, 5);
        data << channelId;
        data << slotId;
        currentSocket->SendPacket(data);
    }
    catch (const std::exception& e)
    {
        LOG_ERROR("voice-chat", "Exception sending packet: {}", e.what());
    }
}

void VoiceChatMgr::DisableChannelSlot(uint16 channelId, uint8 slotId)
{
    auto currentSocket = _socket.lock();

    if (!currentSocket || !currentSocket->IsOpen() || _state != VOICECHAT_CONNECTED)
    {
        LOG_ERROR("voice-chat", "Cannot disable channel voice slot - invalid socket state");
        return;
    }

    try
    {
        LOG_INFO("voice-chat", "Channel {} deactivate slot {}", (int)channelId, (int)slotId);

        VoiceChatServerPacket data(VOICECHAT_CMSG_REMOVE_MEMBER, 5);
        data << channelId;
        data << slotId;
        currentSocket->SendPacket(data);
    }
    catch (const std::exception& e)
    {
        LOG_ERROR("voice-chat", "Exception sending packet: {}", e.what());
    }
}

void VoiceChatMgr::VoiceChannelSlot(uint16 channelId, uint8 slotId)
{
    auto currentSocket = _socket.lock();

    if (!currentSocket || !currentSocket->IsOpen() || _state != VOICECHAT_CONNECTED)
    {
        LOG_ERROR("voice-chat", "Cannot voice channel slot - invalid socket state");
        return;
    }

    try
    {
        LOG_ERROR("voice-chat", "Channel {} voice slot {}", (int)channelId, (int)slotId);

        VoiceChatServerPacket data(VOICECHAT_CMSG_VOICE_MEMBER, 5);
        data << channelId;
        data << slotId;
        currentSocket->SendPacket(data);
    }
    catch (const std::exception& e)
    {
        LOG_ERROR("voice-chat", "Exception sending packet: {}", e.what());
    }
}

void VoiceChatMgr::DevoiceChannelSlot(uint16 channelId, uint8 slotId)
{
    auto currentSocket = _socket.lock();

    if (!currentSocket || !currentSocket->IsOpen() || _state != VOICECHAT_CONNECTED)
    {
        LOG_ERROR("voice-chat", "Cannot devoice channel slot - invalid socket state");
        return;
    }

    try
    {
        LOG_INFO("voice-chat", "Channel {} devoice slot {}", (int)channelId, (int)slotId);

        VoiceChatServerPacket data(VOICECHAT_CMSG_DEVOICE_MEMBER, 5);
        data << channelId;
        data << slotId;
        currentSocket->SendPacket(data);
    }
    catch (const std::exception& e)
    {
        LOG_ERROR("voice-chat", "Exception sending packet: {}", e.what());
    }
}

void VoiceChatMgr::MuteChannelSlot(uint16 channelId, uint8 slotId)
{
    auto currentSocket = _socket.lock();

    if (!currentSocket || !currentSocket->IsOpen() || _state != VOICECHAT_CONNECTED)
    {
        LOG_ERROR("voice-chat", "Cannot mute channel voice slot - invalid socket state");
        return;
    }

    try
    {
        LOG_INFO("voice-chat", "Channel {} mute slot {}", (int)channelId, (int)slotId);

        VoiceChatServerPacket data(VOICECHAT_CMSG_MUTE_MEMBER, 5);
        data << channelId;
        data << slotId;
        currentSocket->SendPacket(data);
    }
    catch (const std::exception& e)
    {
        LOG_ERROR("voice-chat", "Exception sending packet: {}", e.what());
    }
}

void VoiceChatMgr::UnmuteChannelSlot(uint16 channelId, uint8 slotId)
{
    auto currentSocket = _socket.lock();

    if (!currentSocket || !currentSocket->IsOpen() || _state != VOICECHAT_CONNECTED)
    {
        LOG_ERROR("voice-chat", "Cannot unmute channel voice slot - invalid socket state");
        return;
    }

    try
    {
        LOG_INFO("voice-chat", "Channel {} unmute slot {}", (int)channelId, (int)slotId);

        VoiceChatServerPacket data(VOICECHAT_CMSG_UNMUTE_MEMBER, 5);
        data << channelId;
        data << slotId;
        currentSocket->SendPacket(data);
    }
    catch (const std::exception& e)
    {
        LOG_ERROR("voice-chat", "Exception sending packet: {}", e.what());
    }
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
                    AddToRaidVoiceChatChannel(player->GetGUID(), group->GetGroupId());
                else
                    AddToGroupVoiceChatChannel(player->GetGUID(), group->GetGroupId());
            }
            else
                AddToBattlegroundVoiceChatChannel(player->GetGUID());
        }
        if (Group* group = player->GetOriginalGroup())
        {
            if (group->isRaidGroup())
                AddToRaidVoiceChatChannel(player->GetGUID(), group->GetGroupId());
            else
                AddToGroupVoiceChatChannel(player->GetGUID(), group->GetGroupId());
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
                    if (VoiceChatChannel* voiceChannel = GetRaidVoiceChatChannel(group->GetGroupId()))
                        voiceChannel->SendAvailableVoiceChatChannel(session);
                }
                else
                {
                    if (VoiceChatChannel* voiceChannel = GetGroupVoiceChatChannel(group->GetGroupId()))
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
                if (VoiceChatChannel* voiceChannel = GetRaidVoiceChatChannel(group->GetGroupId()))
                    voiceChannel->SendAvailableVoiceChatChannel(session);
            }
            else
            {
                if (VoiceChatChannel* voiceChannel = GetGroupVoiceChatChannel(group->GetGroupId()))
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
    if (!_enabled)
        return;

    LOG_INFO("voice-chat", "Disabling voice chat");

    _enabled = false;
    _state = VOICECHAT_DISCONNECTED;

    SendVoiceChatServiceDisconnect();

    SocketDisconnected();

    DeleteAllChannels();

    SendVoiceChatStatus(false);

    LOG_INFO("voice-chat", "Voice chat disabled");
}

void VoiceChatMgr::EnableVoiceChat()
{
    if (_enabled)
        return;

    LOG_INFO("voice-chat", "Enabling voice chat");

    _enabled = true;
    _state = VOICECHAT_NOT_CONNECTED;
    _nextConnectTimer = 0;
    _curReconnectAttempts = 0;

    // Start the socket thread
    ActivateVoiceSocketThread();

    SendVoiceChatStatus(true);
    LOG_INFO("voice-chat", "Voice chat enabled, connection thread started");
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

void VoiceChatMgr::HandleConnectionFailure()
{
    _curReconnectAttempts++;

    if (_maxConnectAttempts > 0 && _curReconnectAttempts >= _maxConnectAttempts)
    {
        LOG_ERROR("voice-chat", "Max reconnection attempts ({}) reached, disabling voice chat", _maxConnectAttempts);
        DisableVoiceChat();
        return;
    }

    _state = (_state == VOICECHAT_NOT_CONNECTED) ? VOICECHAT_NOT_CONNECTED : VOICECHAT_RECONNECTING;
    _nextConnectTimer = 10 * SECOND * IN_MILLISECONDS;
}

void VoiceChatMgr::HandleConnectionLoss()
{
    // Notify users about disconnection
    SendVoiceChatServiceDisconnect();

    _state = VOICECHAT_RECONNECTING;
    _nextConnectTimer = 5 * SECOND * IN_MILLISECONDS;
    _curReconnectAttempts++;

    if (_maxConnectAttempts > 0 && _curReconnectAttempts >= _maxConnectAttempts)
    {
        LOG_ERROR("voice-chat", "Max reconnection attempts reached after connection loss, disabling voice chat");
        DisableVoiceChat();
    }
}
