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
#include "BattlegroundMgr.h"
#include "Channel.h"
#include "ChannelMgr.h"
#include "Chat.h"
#include "Config.h"
#include "GameTime.h"
#include "GroupMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "VoiceChatInternalHandler.h"
#include "VoiceChatPackets.h"
#include "VoiceChatSocket.h"
#include "VoiceChatSocketMgr.h"
#include "World.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"
#include "WorldSocketMgr.h"
#include <boost/asio/ip/address.hpp>

namespace
{
    constexpr uint32 SOCKET_PING_INTERVAL = 10 * IN_MILLISECONDS;
    constexpr uint32 SOCKET_NOREPLY_TIME  = 30 * IN_MILLISECONDS;
}

VoiceChatMgr::VoiceChatMgr() :
    _initialized(false),
    _enabled(false),
    _nextVoiceChannelId(0),
    _nextSessionId(1),
    _serverPort(0),
    _voiceAddress(0),
    _voicePort(0),
    _maxConnectAttempts(-1),
    _failedConnectAttempts(0),
    _wasConnected(false)
{
}

VoiceChatMgr::~VoiceChatMgr()
{
}

void VoiceChatMgr::LoadConfigs()
{
    _enabled = sWorld->getBoolConfig(CONFIG_VOICE_CHAT_ENABLED);

    _serverAddressString = sConfigMgr->GetOption<std::string>("VoiceChat.ServerAddress", "127.0.0.1");
    _serverPort = uint16(sWorld->getIntConfig(CONFIG_VOICE_CHAT_SERVER_PORT));
    _voicePort = uint16(sWorld->getIntConfig(CONFIG_VOICE_CHAT_VOICE_PORT));
    _maxConnectAttempts = int32(sWorld->getIntConfig(CONFIG_VOICE_CHAT_MAX_CONNECT_ATTEMPTS));

    std::string const voiceAddressString = sConfigMgr->GetOption<std::string>("VoiceChat.VoiceAddress", "127.0.0.1");
    try
    {
        _voiceAddress = boost::asio::ip::make_address_v4(voiceAddressString).to_uint();
    }
    catch (boost::system::system_error const&)
    {
        LOG_ERROR("voice-chat", "VoiceChat.VoiceAddress '{}' is not a valid IPv4 address, voice chat disabled", voiceAddressString);
        _voiceAddress = 0;
        _enabled = false;
        sWorld->setBoolConfig(CONFIG_VOICE_CHAT_ENABLED, false);
    }
}

void VoiceChatMgr::Init()
{
    LoadConfigs();

    internalVoiceChatOpcodeTable.Init();

    _pingTimer.SetInterval(SOCKET_PING_INTERVAL);

    if (_enabled)
    {
        sVoiceChatSocketMgr.Init(sWorldSocketMgr.GetIoContext());
        // the connector lives on the voice network thread's io context so the
        // resulting socket does all of its asio work on that single thread
        _voiceServerConnector = std::make_shared<VoiceServerConnector>(sVoiceChatSocketMgr.GetNetworkThreadIoContext());
        LOG_INFO("voice-chat", "Voice chat enabled, connecting to voiceserver at {}:{}", _serverAddressString, _serverPort);
    }
    else
        LOG_INFO("voice-chat", "Voice chat disabled");

    _initialized = true;
}

void VoiceChatMgr::Stop()
{
    if (!_initialized)
        return;

    if (_voiceServerConnector)
        _voiceServerConnector->Stop();

    if (_voiceServerSocket)
    {
        _voiceServerSocket->CloseSocket();
        _voiceServerSocket = nullptr;
    }

    {
        std::lock_guard<std::mutex> guard(_pendingSocketLock);
        if (_pendingSocket)
        {
            _pendingSocket->CloseSocket();
            _pendingSocket = nullptr;
        }
    }

    sVoiceChatSocketMgr.Stop();
}

bool VoiceChatMgr::CanUseVoiceChat() const
{
    return _enabled && _voiceServerSocket && _voiceServerSocket->IsOpen();
}

void VoiceChatMgr::Enable()
{
    if (_enabled)
        return;

    LOG_INFO("voice-chat", "Enabling voice chat");
    _enabled = true;
    _wasConnected = false;

    if (!sVoiceChatSocketMgr.IsInitialized())
        sVoiceChatSocketMgr.Init(sWorldSocketMgr.GetIoContext());

    if (!_voiceServerConnector)
        _voiceServerConnector = std::make_shared<VoiceServerConnector>(sVoiceChatSocketMgr.GetNetworkThreadIoContext());
}

void VoiceChatMgr::Disable()
{
    if (!_enabled)
        return;

    LOG_INFO("voice-chat", "Disabling voice chat");
    _enabled = false;

    DeleteAllChannels();

    SendVoiceChatServiceDisconnect();
    SendVoiceChatStatus(false);

    if (_voiceServerConnector)
        _voiceServerConnector->Stop();

    if (_voiceServerSocket)
    {
        _voiceServerSocket->CloseSocket();
        _voiceServerSocket = nullptr;
    }

    // drop a connection that was still being handed over
    {
        std::lock_guard<std::mutex> guard(_pendingSocketLock);
        if (_pendingSocket)
        {
            _pendingSocket->CloseSocket();
            _pendingSocket = nullptr;
        }
    }

    _wasConnected = false;
}

void VoiceChatMgr::DisconnectSocket()
{
    if (_voiceServerSocket)
        _voiceServerSocket->CloseSocket();
}

void VoiceChatMgr::Update(uint32 const diff)
{
    if (!_initialized)
        return;

    // handle config changes from reload
    if (_enabled != sWorld->getBoolConfig(CONFIG_VOICE_CHAT_ENABLED))
    {
        if (sWorld->getBoolConfig(CONFIG_VOICE_CHAT_ENABLED))
            Enable();
        else
            Disable();
    }

    if (!_enabled)
        return;

    UpdateVoiceServerConnection(diff);
}

// Warning: called from a network thread
void VoiceChatMgr::OfferVoiceServerSocket(std::shared_ptr<VoiceChatSocket> socket)
{
    std::lock_guard<std::mutex> guard(_pendingSocketLock);
    _pendingSocket = std::move(socket);
}

bool VoiceChatMgr::HasPendingSocket()
{
    std::lock_guard<std::mutex> guard(_pendingSocketLock);
    return _pendingSocket != nullptr;
}

// Warning: called from a network thread
void VoiceChatMgr::QueueIncomingVoiceServerPacket(std::unique_ptr<VoiceChatServerPacket> packet)
{
    _voiceServerPacketQueue.emplace_back(std::move(packet));
}

void VoiceChatMgr::UpdateVoiceServerConnection(uint32 const diff)
{
    // adopt a freshly connected socket
    {
        std::shared_ptr<VoiceChatSocket> newSocket;
        {
            std::lock_guard<std::mutex> guard(_pendingSocketLock);
            newSocket = std::move(_pendingSocket);
            _pendingSocket = nullptr;
        }

        if (newSocket && newSocket->IsOpen())
        {
            if (_voiceServerSocket)
                _voiceServerSocket->CloseSocket();

            _voiceServerSocket = std::move(newSocket);
            _failedConnectAttempts = 0;
            OnVoiceServerConnected();
        }
    }

    // give up if the voiceserver could not be reached too many times
    if (_maxConnectAttempts > 0 && _failedConnectAttempts >= uint32(_maxConnectAttempts))
    {
        LOG_ERROR("voice-chat", "Could not connect to the voiceserver after {} attempts, disabling voice chat", _failedConnectAttempts.load());
        sWorld->setBoolConfig(CONFIG_VOICE_CHAT_ENABLED, false);
        Disable();
        return;
    }

    // process incoming packets
    std::unique_ptr<VoiceChatServerPacket> packet;
    while (_voiceServerPacketQueue.next(packet))
    {
        VoiceChatInternalOpcodeHandler<VoiceChatMgr> const* opHandle = internalVoiceChatOpcodeTable[packet->GetOpcode()];
        if (!opHandle)
        {
            LOG_ERROR("voice-chat", "Received unhandled opcode {} from voiceserver", uint32(packet->GetOpcode()));
            continue;
        }

        try
        {
            (this->*opHandle->_handler)(*packet);
        }
        catch (ByteBufferException const&)
        {
            LOG_ERROR("voice-chat", "Malformed {} received from voiceserver, disconnecting", opHandle->_name);
            DisconnectSocket();
        }
    }

    // check connection status
    if (_voiceServerSocket)
    {
        // periodically fire a ping packet to check if the connection is still alive
        _pingTimer.Update(diff);
        if (_pingTimer.Passed())
        {
            VoiceChatServerPacket pkt(VoiceChatServerOpcodes::CMSG_PING, 0);
            SendPacket(pkt);
            _pingTimer.Reset();
        }

        // has it been too long since the last received packet? Drop the socket to allow a new connection
        if (GetMSTimeDiffToNow(_voiceServerSocket->GetLastPacketReceiveTime()) > SOCKET_NOREPLY_TIME)
        {
            LOG_ERROR("voice-chat", "Voiceserver did not reply in {} seconds, dropping connection", SOCKET_NOREPLY_TIME / IN_MILLISECONDS);
            _voiceServerSocket->CloseSocket();
        }

        if (!_voiceServerSocket->IsOpen())
        {
            _voiceServerSocket = nullptr;
            OnVoiceServerDisconnected();
        }
    }
    else if (_voiceServerConnector && !_voiceServerConnector->IsAttemptingConnection() && !HasPendingSocket())
    {
        try
        {
            boost::asio::ip::tcp::endpoint endpoint(boost::asio::ip::make_address(_serverAddressString), _serverPort);
            _voiceServerConnector->ConnectRepeat(endpoint);
        }
        catch (boost::system::system_error const&)
        {
            LOG_ERROR("voice-chat", "VoiceChat.ServerAddress '{}' is not a valid address, voice chat disabled", _serverAddressString);
            sWorld->setBoolConfig(CONFIG_VOICE_CHAT_ENABLED, false);
            Disable();
        }
    }
}

void VoiceChatMgr::OnVoiceServerConnected()
{
    LOG_INFO("voice-chat", "Connected to voiceserver at {}:{}", _voiceServerSocket->GetRemoteIpAddress().to_string(), _voiceServerSocket->GetRemotePort());

    bool const reconnect = _wasConnected;
    _wasConnected = true;

    SendVoiceChatStatus(true);

    RestoreVoiceChatChannels();

    if (reconnect)
        SendVoiceChatServiceReconnected();
}

void VoiceChatMgr::OnVoiceServerDisconnected()
{
    LOG_WARN("voice-chat", "Voiceserver connection lost");

    // channels stay registered and are restored once the connection is re-established
    SendVoiceChatServiceDisconnect();
}

void VoiceChatMgr::SendPacket(VoiceChatServerPacket const& packet)
{
    if (!_voiceServerSocket)
        return;

    _voiceServerSocket->SendPacket(packet);
}

void VoiceChatMgr::SendChannelSlotPacket(VoiceChatServerOpcodes opcode, uint16 channelId, uint8 slotId)
{
    if (!CanUseVoiceChat())
        return;

    VoiceChatServerPacket data(opcode, 3);
    data << channelId;
    data << slotId;
    SendPacket(data);
}

void VoiceChatMgr::EnableChannelSlot(uint16 channelId, uint8 slotId)
{
    SendChannelSlotPacket(VoiceChatServerOpcodes::CMSG_ADD_MEMBER, channelId, slotId);
}

void VoiceChatMgr::DisableChannelSlot(uint16 channelId, uint8 slotId)
{
    SendChannelSlotPacket(VoiceChatServerOpcodes::CMSG_REMOVE_MEMBER, channelId, slotId);
}

void VoiceChatMgr::VoiceChannelSlot(uint16 channelId, uint8 slotId)
{
    SendChannelSlotPacket(VoiceChatServerOpcodes::CMSG_VOICE_MEMBER, channelId, slotId);
}

void VoiceChatMgr::DevoiceChannelSlot(uint16 channelId, uint8 slotId)
{
    SendChannelSlotPacket(VoiceChatServerOpcodes::CMSG_DEVOICE_MEMBER, channelId, slotId);
}

void VoiceChatMgr::MuteChannelSlot(uint16 channelId, uint8 slotId)
{
    SendChannelSlotPacket(VoiceChatServerOpcodes::CMSG_MUTE_MEMBER, channelId, slotId);
}

void VoiceChatMgr::UnmuteChannelSlot(uint16 channelId, uint8 slotId)
{
    SendChannelSlotPacket(VoiceChatServerOpcodes::CMSG_UNMUTE_MEMBER, channelId, slotId);
}

void VoiceChatMgr::HandlePongOpcode(VoiceChatServerPacket const& /*packet*/)
{
    // nothing to do, receiving the packet already reset the socket receive timer
}

void VoiceChatMgr::HandleCreateVoiceSessionResponseOpcode(VoiceChatServerPacket const& packet)
{
    uint16 channelId;
    uint8 error;
    VoiceChatServerPacket data(packet);
    data >> channelId;
    data >> error;

    if (error == static_cast<uint8>(VoiceChatCreateSessionResult::Ok))
        return;

    LOG_ERROR("voice-chat", "Voiceserver could not create voice session {}, removing channel", channelId);

    if (Channel* channel = GetVoiceChatChannel(channelId))
        DeleteVoiceChatChannel(channel);
}

uint16 VoiceChatMgr::GetNextVoiceChannelId()
{
    // skip 0 and ids that are still in use
    do
        ++_nextVoiceChannelId;
    while (!_nextVoiceChannelId || _voiceChannels.find(_nextVoiceChannelId) != _voiceChannels.end());

    return _nextVoiceChannelId;
}

// if cross faction channels are enabled, team is always ALLIANCE
TeamId VoiceChatMgr::GetCustomChannelTeam(TeamId team)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL))
        return TEAM_ALLIANCE;

    return team;
}

void VoiceChatMgr::CreateVoiceSession(Channel* channel, std::shared_ptr<Channel> ownedChannel)
{
    if (!CanUseVoiceChat())
        return;

    uint16 const voiceId = GetNextVoiceChannelId();
    channel->SetVoiceId(voiceId);
    channel->SetVoiceSessionId(GetNewSessionId());

    _voiceChannels[voiceId] = channel;
    if (ownedChannel)
        _ownedChannels[voiceId] = std::move(ownedChannel);

    LOG_DEBUG("voice-chat", "Creating voice session {} type {}", voiceId, uint32(channel->GetVoiceType()));

    VoiceChatServerPacket data(VoiceChatServerOpcodes::CMSG_CREATE_VOICE_SESSION, 3);
    data << voiceId;
    data << static_cast<uint8>(channel->GetVoiceType());
    SendPacket(data);

    AddMembersAfterCreate(channel);
}

void VoiceChatMgr::AddMembersAfterCreate(Channel* channel)
{
    switch (channel->GetVoiceType())
    {
        case VoiceChatChannelType::Group:
        case VoiceChatChannelType::Raid:
        {
            if (Group* group = sGroupMgr->GetGroupByGUID(channel->GetVoiceGroupId()))
            {
                channel->SetVoiceMassAdding(true);
                for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                {
                    if (Player* member = itr->GetSource())
                        if (member->GetSession()->IsVoiceChatEnabled())
                            channel->AddVoiceChatMember(member->GetGUID());
                }
                channel->SetVoiceMassAdding(false);
                channel->SendVoiceRoster();
            }
            break;
        }
        case VoiceChatChannelType::Battleground:
        {
            if (Battleground* bg = sBattlegroundMgr->GetBattleground(channel->GetVoiceGroupId(), BATTLEGROUND_TYPE_NONE))
            {
                channel->SetVoiceMassAdding(true);
                for (auto const& itr : bg->GetPlayers())
                {
                    if (Player* member = ObjectAccessor::FindConnectedPlayer(itr.first))
                    {
                        if (member->GetBgTeamId() != channel->GetTeamId())
                            continue;

                        if (member->GetSession()->IsVoiceChatEnabled())
                            channel->AddVoiceChatMember(itr.first);
                    }
                }
                channel->SetVoiceMassAdding(false);
                channel->SendVoiceRoster();
            }
            break;
        }
        case VoiceChatChannelType::Custom:
        {
            channel->AddVoiceChatMembersAfterCreate();
            break;
        }
        default:
            break;
    }
}

void VoiceChatMgr::DeleteVoiceChatChannel(Channel* channel)
{
    if (!channel)
        return;

    uint16 const voiceId = channel->GetVoiceId();
    if (!voiceId)
        return;

    LOG_DEBUG("voice-chat", "Deleting voice session {} type {}", voiceId, uint32(channel->GetVoiceType()));

    channel->DisbandVoiceSession();

    // disable voice on the custom chat channel
    if (channel->GetVoiceType() == VoiceChatChannelType::Custom && channel->IsVoiceEnabled())
        channel->ToggleVoice();

    if (CanUseVoiceChat())
    {
        VoiceChatServerPacket data(VoiceChatServerOpcodes::CMSG_DELETE_VOICE_SESSION, 2);
        data << voiceId;
        SendPacket(data);
    }

    _voiceChannels.erase(voiceId);
    _ownedChannels.erase(voiceId);
}

void VoiceChatMgr::DeleteAllChannels()
{
    while (!_voiceChannels.empty())
        DeleteVoiceChatChannel(_voiceChannels.begin()->second);
}

// re-create all registered channels on the voiceserver after (re)connecting
void VoiceChatMgr::RestoreVoiceChatChannels()
{
    for (auto const& [voiceId, channel] : _voiceChannels)
    {
        LOG_DEBUG("voice-chat", "Restoring voice session {} on voiceserver", voiceId);

        VoiceChatServerPacket data(VoiceChatServerOpcodes::CMSG_CREATE_VOICE_SESSION, 3);
        data << voiceId;
        data << static_cast<uint8>(channel->GetVoiceType());
        SendPacket(data);

        for (auto const& [userId, member] : channel->GetVoiceMembers())
        {
            EnableChannelSlot(voiceId, userId);
            if (member.IsVoiced())
                VoiceChannelSlot(voiceId, userId);
            if (member.IsMuted() || member.IsForceMuted())
                MuteChannelSlot(voiceId, userId);
        }

        // let the clients re-announce themselves to the voiceserver
        channel->SendVoiceRoster(true);
    }
}

Channel* VoiceChatMgr::GetVoiceChatChannel(uint16 voiceId)
{
    auto itr = _voiceChannels.find(voiceId);
    return itr != _voiceChannels.end() ? itr->second : nullptr;
}

Channel* VoiceChatMgr::GetGroupVoiceChatChannel(uint32 groupId)
{
    for (auto const& [voiceId, channel] : _voiceChannels)
        if (channel->GetVoiceType() == VoiceChatChannelType::Group && channel->GetVoiceGroupId() == groupId)
            return channel;

    return nullptr;
}

Channel* VoiceChatMgr::GetRaidVoiceChatChannel(uint32 groupId)
{
    for (auto const& [voiceId, channel] : _voiceChannels)
        if (channel->GetVoiceType() == VoiceChatChannelType::Raid && channel->GetVoiceGroupId() == groupId)
            return channel;

    return nullptr;
}

Channel* VoiceChatMgr::GetBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team)
{
    for (auto const& [voiceId, channel] : _voiceChannels)
        if (channel->GetVoiceType() == VoiceChatChannelType::Battleground && channel->GetVoiceGroupId() == instanceId && channel->GetTeamId() == team)
            return channel;

    return nullptr;
}

Channel* VoiceChatMgr::GetCustomVoiceChatChannel(std::string const& name, TeamId team)
{
    TeamId const channelTeam = GetCustomChannelTeam(team);
    for (auto const& [voiceId, channel] : _voiceChannels)
        if (channel->GetVoiceType() == VoiceChatChannelType::Custom && channel->GetTeamId() == channelTeam && channel->GetName() == name)
            return channel;

    return nullptr;
}

void VoiceChatMgr::CreateGroupVoiceChatChannel(uint32 groupId)
{
    if (!groupId || GetGroupVoiceChatChannel(groupId))
        return;

    if (!CanUseVoiceChat())
        return;

    std::shared_ptr<Channel> channel = std::make_shared<Channel>(VoiceChatChannelType::Group, groupId);
    CreateVoiceSession(channel.get(), channel);
}

void VoiceChatMgr::CreateRaidVoiceChatChannel(uint32 groupId)
{
    if (!groupId || GetRaidVoiceChatChannel(groupId))
        return;

    if (!CanUseVoiceChat())
        return;

    std::shared_ptr<Channel> channel = std::make_shared<Channel>(VoiceChatChannelType::Raid, groupId);
    CreateVoiceSession(channel.get(), channel);
}

void VoiceChatMgr::CreateBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team)
{
    if (!instanceId || GetBattlegroundVoiceChatChannel(instanceId, team))
        return;

    if (!CanUseVoiceChat())
        return;

    // for battlegrounds the bg instance id is used as group id
    std::shared_ptr<Channel> channel = std::make_shared<Channel>(VoiceChatChannelType::Battleground, instanceId, team);
    CreateVoiceSession(channel.get(), channel);
}

void VoiceChatMgr::CreateCustomVoiceChatChannel(std::string const& name, TeamId team)
{
    if (name.empty() || GetCustomVoiceChatChannel(name, team))
        return;

    if (!CanUseVoiceChat())
        return;

    Channel* channel = sChannelMgr.GetChannel(GetCustomChannelTeam(team), name);
    if (!channel || channel->IsConstant() || channel->IsLFG())
        return;

    channel->SetVoiceType(VoiceChatChannelType::Custom);
    CreateVoiceSession(channel);
}

void VoiceChatMgr::DeleteGroupVoiceChatChannel(uint32 groupId)
{
    if (Channel* channel = GetGroupVoiceChatChannel(groupId))
        DeleteVoiceChatChannel(channel);
}

void VoiceChatMgr::DeleteRaidVoiceChatChannel(uint32 groupId)
{
    if (Channel* channel = GetRaidVoiceChatChannel(groupId))
        DeleteVoiceChatChannel(channel);
}

void VoiceChatMgr::DeleteBattlegroundVoiceChatChannel(uint32 instanceId, TeamId team)
{
    if (Channel* channel = GetBattlegroundVoiceChatChannel(instanceId, team))
        DeleteVoiceChatChannel(channel);
}

void VoiceChatMgr::DeleteCustomVoiceChatChannel(std::string const& name, TeamId team)
{
    if (Channel* channel = GetCustomVoiceChatChannel(name, team))
        DeleteVoiceChatChannel(channel);
}

void VoiceChatMgr::ConvertToRaidChannel(uint32 groupId)
{
    Channel* channel = GetGroupVoiceChatChannel(groupId);
    if (!channel)
        return;

    channel->SetVoiceType(VoiceChatChannelType::Raid);
    channel->SendVoiceRoster(true);
}

void VoiceChatMgr::AddToGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    Channel* channel = GetGroupVoiceChatChannel(groupId);
    if (!channel)
    {
        // adds all eligible group members
        CreateGroupVoiceChatChannel(groupId);
        return;
    }

    channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    Channel* channel = GetRaidVoiceChatChannel(groupId);
    if (!channel)
    {
        CreateRaidVoiceChatChannel(groupId);
        return;
    }

    channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToBattlegroundVoiceChatChannel(ObjectGuid guid)
{
    Player* player = ObjectAccessor::FindConnectedPlayer(guid);
    if (!player || !player->InBattleground())
        return;

    Channel* channel = GetBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId());
    if (!channel)
    {
        CreateBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId());
        return;
    }

    channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToCustomVoiceChatChannel(ObjectGuid guid, std::string const& name, TeamId team)
{
    if (name.empty())
        return;

    Channel* channel = GetCustomVoiceChatChannel(name, team);
    if (!channel)
    {
        // adds all eligible channel members
        CreateCustomVoiceChatChannel(name, team);
        return;
    }

    channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (Channel* channel = GetGroupVoiceChatChannel(groupId))
        channel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (Channel* channel = GetRaidVoiceChatChannel(groupId))
        channel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromBattlegroundVoiceChatChannel(ObjectGuid guid)
{
    Player* player = ObjectAccessor::FindConnectedPlayer(guid);
    if (!player || !player->InBattleground())
        return;

    if (Channel* channel = GetBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId()))
        channel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::RemoveFromVoiceChatChannels(ObjectGuid guid)
{
    for (auto const& [voiceId, channel] : _voiceChannels)
        channel->RemoveVoiceChatMember(guid);
}

void VoiceChatMgr::JoinAvailableVoiceChatChannels(WorldSession* session)
{
    if (!CanUseVoiceChat())
        return;

    Player* player = session->GetPlayer();
    if (!player)
        return;

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

    // custom channels the player is on with voice enabled
    for (auto const& [voiceId, channel] : _voiceChannels)
    {
        if (channel->GetVoiceType() != VoiceChatChannelType::Custom)
            continue;

        if (channel->GetTeamId() != GetCustomChannelTeam(player->GetTeamId()))
            continue;

        if (channel->IsOn(player->GetGUID()) && !channel->IsBanned(player->GetGUID()) && channel->IsVoiceEnabled())
            channel->AddVoiceChatMember(player->GetGUID());
    }
}

VoiceChatStatistics VoiceChatMgr::GetStatistics()
{
    VoiceChatStatistics stats { };

    stats.Channels = _voiceChannels.size();

    ChatHandler(static_cast<WorldSession*>(nullptr)).DoForAllValidSessions([&](Player* player)
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

void VoiceChatMgr::SendVoiceChatStatus(bool status)
{
    WorldPackets::VoiceChat::VoiceChatStatus voiceChatStatus;
    voiceChatStatus.Status = status;
    sWorldSessionMgr->SendGlobalMessage(voiceChatStatus.Write());
}

void VoiceChatMgr::SendVoiceChatServiceDisconnect()
{
    WorldPackets::VoiceChat::ComSatDisconnect packet;
    sWorldSessionMgr->SendGlobalMessage(packet.Write());
}

void VoiceChatMgr::SendVoiceChatServiceReconnected()
{
    WorldPackets::VoiceChat::ComSatReconnectTry packet;
    sWorldSessionMgr->SendGlobalMessage(packet.Write());
}

// Warning: called from a network thread
void VoiceServerConnector::OnConnectionSuccess(std::unique_ptr<IoContextTcpSocket> socket)
{
    std::shared_ptr<VoiceChatSocket> voiceSocket = sVoiceChatSocketMgr.OnSocketOpen(std::move(*socket));
    if (voiceSocket)
        sVoiceChatMgr->OfferVoiceServerSocket(voiceSocket);
}

// Warning: called from a network thread
void VoiceServerConnector::OnConnectionFail()
{
    sVoiceChatMgr->OnConnectAttemptFailed();
}
