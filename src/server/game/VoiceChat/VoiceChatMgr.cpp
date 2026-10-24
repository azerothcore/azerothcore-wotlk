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

#include "VoiceChatMgr.h"
#include "BattlegroundMgr.h"
#include "Channel.h"
#include "ChannelMgr.h"
#include "Chat.h"
#include "Config.h"
#include "CryptoRandom.h"
#include "GameTime.h"
#include "GroupMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "VoiceChatInternalHandler.h"
#include "VoiceChatPackets.h"
#include "VoiceChatSocket.h"
#include "VoiceChatSocketMgr.h"
#include "World.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"
#include <boost/asio/ip/address.hpp>
#include <limits>

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
    _wasConnected(false),
    _shuttingDown(false)
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
    // signed, the world config only holds unsigned integers
    _maxConnectAttempts = sConfigMgr->GetOption<int32>("VoiceChat.MaxConnectAttempts", -1);

    std::string const voiceAddressString = sConfigMgr->GetOption<std::string>("VoiceChat.VoiceAddress", "127.0.0.1");
    try
    {
        _voiceAddress = boost::asio::ip::make_address_v4(voiceAddressString).to_uint();
    }
    catch (boost::system::system_error const&)
    {
        LOG_ERROR("voice-chat", "VoiceChat.VoiceAddress '{}' is not a valid IPv4 address, voice chat disabled",
            voiceAddressString);
        _voiceAddress = 0;
        _enabled = false;
        sWorld->setBoolConfig(CONFIG_VOICE_CHAT_ENABLED, false);
    }
}

void VoiceChatMgr::Init()
{
    LoadConfigs();

    internalVoiceChatOpcodeTable.Init();

    _pingTimer.SetInterval(VOICECHAT_INTERNAL_PING_INTERVAL);

    if (_enabled)
    {
        sVoiceChatSocketMgr.Init();
        // the connector lives on the voice network thread's io context so the
        // resulting socket does all of its asio work on that single thread
        _voiceServerConnector = std::make_shared<VoiceServerConnector>(sVoiceChatSocketMgr.GetNetworkThreadIoContext());
        LOG_INFO("voice-chat", "Voice chat enabled, connecting to voiceserver at {}:{}",
            _serverAddressString, _serverPort);
    }
    else
        LOG_INFO("voice-chat", "Voice chat disabled");

    _initialized = true;
}

void VoiceChatMgr::Stop()
{
    if (!_initialized)
        return;

    // the connector's timers and socket are bound to the voice network thread's
    // io context, which sVoiceChatSocketMgr.Stop() destroys below. Drop our
    // reference now so the connector goes away with its pending handlers instead
    // of during static destruction, after its io context is already gone
    if (_voiceServerConnector)
    {
        _voiceServerConnector->Stop();
        _voiceServerConnector.reset();
    }

    if (_voiceServerSocket)
    {
        _voiceServerSocket->CloseSocket();
        _voiceServerSocket = nullptr;
    }

    {
        std::lock_guard<std::mutex> guard(_pendingSocketLock);
        // a connect may still complete on the voice network thread until it is
        // stopped below; such a socket must not be kept past its io context
        _shuttingDown = true;
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

    // pick up settings changed since they were last read, e.g. by .reload config.
    // An invalid VoiceChat.VoiceAddress leaves voice chat disabled
    LoadConfigs();
    if (!_enabled)
        return;

    LOG_INFO("voice-chat", "Enabling voice chat");
    _wasConnected = false;
    // start over, voice chat may have been disabled for reaching VoiceChat.MaxConnectAttempts
    _failedConnectAttempts = 0;

    if (!sVoiceChatSocketMgr.IsInitialized())
        sVoiceChatSocketMgr.Init();

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
        sScriptMgr->OnVoiceServerDisconnected();
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

    // always drained so the queue can not grow while voice chat is disabled
    ProcessGroupEvents();
    ReleaseEmptyCustomVoiceSessions();

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
    if (_shuttingDown)
    {
        socket->CloseSocket();
        return;
    }

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

// Warning: the group hooks below may be called from map threads
void VoiceChatMgr::QueueGroupMemberAdded(ObjectGuid guid, uint32 groupId, bool raid, bool battleground)
{
    VoiceChatGroupEvent event;
    event.Type = VoiceChatGroupEventType::MemberAdded;
    event.Id = groupId;
    event.Guid = guid;
    event.Raid = raid;
    event.Battleground = battleground;
    _groupEvents.add(event);
}

void VoiceChatMgr::QueueGroupMemberRemoved(ObjectGuid guid, uint32 groupId)
{
    VoiceChatGroupEvent event;
    event.Type = VoiceChatGroupEventType::MemberRemoved;
    event.Id = groupId;
    event.Guid = guid;
    _groupEvents.add(event);
}

void VoiceChatMgr::QueueBattlegroundMemberRemoved(ObjectGuid guid, uint32 instanceId, TeamId team)
{
    VoiceChatGroupEvent event;
    event.Type = VoiceChatGroupEventType::BattlegroundMemberRemoved;
    event.Id = instanceId;
    event.Guid = guid;
    event.Team = team;
    _groupEvents.add(event);
}

void VoiceChatMgr::QueueGroupConvertedToRaid(uint32 groupId)
{
    VoiceChatGroupEvent event;
    event.Type = VoiceChatGroupEventType::ConvertedToRaid;
    event.Id = groupId;
    _groupEvents.add(event);
}

void VoiceChatMgr::QueueGroupLeaderChanged(uint32 groupId, ObjectGuid oldLeader, ObjectGuid newLeader)
{
    VoiceChatGroupEvent event;
    event.Type = VoiceChatGroupEventType::LeaderChanged;
    event.Id = groupId;
    event.Guid = newLeader;
    event.OldLeader = oldLeader;
    _groupEvents.add(event);
}

void VoiceChatMgr::QueueBattlegroundLeaderChanged(uint32 instanceId, TeamId team, ObjectGuid oldLeader,
    ObjectGuid newLeader)
{
    VoiceChatGroupEvent event;
    event.Type = VoiceChatGroupEventType::BattlegroundLeaderChanged;
    event.Id = instanceId;
    event.Team = team;
    event.Guid = newLeader;
    event.OldLeader = oldLeader;
    _groupEvents.add(event);
}

void VoiceChatMgr::QueueGroupDisbanded(uint32 groupId)
{
    VoiceChatGroupEvent event;
    event.Type = VoiceChatGroupEventType::Disbanded;
    event.Id = groupId;
    _groupEvents.add(event);
}

void VoiceChatMgr::QueueBattlegroundRaidDisbanded(uint32 instanceId, TeamId team)
{
    VoiceChatGroupEvent event;
    event.Type = VoiceChatGroupEventType::BattlegroundRaidDisbanded;
    event.Id = instanceId;
    event.Team = team;
    _groupEvents.add(event);
}

void VoiceChatMgr::ProcessGroupEvents()
{
    VoiceChatGroupEvent event;
    while (_groupEvents.next(event))
    {
        switch (event.Type)
        {
            case VoiceChatGroupEventType::MemberAdded:
            {
                Player* player = ObjectAccessor::FindConnectedPlayer(event.Guid);
                if (!player || !player->GetSession()->IsVoiceChatEnabled())
                    break;

                if (event.Battleground)
                    AddToBattlegroundVoiceChatChannel(event.Guid);
                else if (event.Raid)
                    AddToRaidVoiceChatChannel(event.Guid, event.Id);
                else
                    AddToGroupVoiceChatChannel(event.Guid, event.Id);
                break;
            }
            case VoiceChatGroupEventType::MemberRemoved:
                RemoveFromGroupVoiceChatChannel(event.Guid, event.Id);
                RemoveFromRaidVoiceChatChannel(event.Guid, event.Id);
                break;
            case VoiceChatGroupEventType::BattlegroundMemberRemoved:
                // the player may already have left the battleground, so the
                // channel is looked up by the ids captured when queueing
                if (Channel* channel = GetBattlegroundVoiceChatChannel(event.Id, event.Team))
                    channel->RemoveVoiceChatMember(event.Guid);
                break;
            case VoiceChatGroupEventType::ConvertedToRaid:
                ConvertToRaidChannel(event.Id);
                break;
            case VoiceChatGroupEventType::LeaderChanged:
            {
                // the new leader speaks with high priority
                Channel* channel = GetGroupVoiceChatChannel(event.Id);
                if (!channel)
                    channel = GetRaidVoiceChatChannel(event.Id);

                if (channel)
                {
                    channel->SetVoiceMemberPriority(event.OldLeader, LOW_VOICE_PRIORITY);
                    channel->SetVoiceMemberPriority(event.Guid, HIGH_VOICE_PRIORITY);
                    channel->SendVoiceRoster(true);
                }
                break;
            }
            case VoiceChatGroupEventType::BattlegroundLeaderChanged:
                // the new leader of the battleground raid speaks with high priority
                if (Channel* channel = GetBattlegroundVoiceChatChannel(event.Id, event.Team))
                {
                    channel->SetVoiceMemberPriority(event.OldLeader, LOW_VOICE_PRIORITY);
                    channel->SetVoiceMemberPriority(event.Guid, HIGH_VOICE_PRIORITY);
                    channel->SendVoiceRoster(true);
                }
                break;
            case VoiceChatGroupEventType::Disbanded:
                DeleteGroupVoiceChatChannel(event.Id);
                DeleteRaidVoiceChatChannel(event.Id);
                break;
            case VoiceChatGroupEventType::BattlegroundRaidDisbanded:
                DeleteBattlegroundVoiceChatChannel(event.Id, event.Team);
                break;
        }
    }
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
        LOG_ERROR("voice-chat", "Could not connect to the voiceserver after {} attempts, disabling voice chat",
            _failedConnectAttempts.load());
        sWorld->setBoolConfig(CONFIG_VOICE_CHAT_ENABLED, false);
        Disable();
        return;
    }

    // process incoming packets
    std::unique_ptr<VoiceChatServerPacket> packet;
    while (_voiceServerPacketQueue.next(packet))
    {
        VoiceChatInternalOpcodeHandler<VoiceChatMgr> const* opHandle =
            internalVoiceChatOpcodeTable[packet->GetOpcode()];
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
        if (GetMSTimeDiffToNow(_voiceServerSocket->GetLastPacketReceiveTime()) > VOICECHAT_INTERNAL_TIMEOUT)
        {
            LOG_ERROR("voice-chat", "Voiceserver did not reply in {} seconds, dropping connection",
                VOICECHAT_INTERNAL_TIMEOUT / IN_MILLISECONDS);
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
            LOG_ERROR("voice-chat", "VoiceChat.ServerAddress '{}' is not a valid address, voice chat disabled",
                _serverAddressString);
            sWorld->setBoolConfig(CONFIG_VOICE_CHAT_ENABLED, false);
            Disable();
        }
    }
}

void VoiceChatMgr::OnVoiceServerConnected()
{
    LOG_INFO("voice-chat", "Connected to voiceserver at {}:{}", _voiceServerSocket->GetRemoteIpAddress().to_string(),
        _voiceServerSocket->GetRemotePort());

    bool const reconnect = _wasConnected;
    _wasConnected = true;

    SendVoiceChatStatus(true);

    RestoreVoiceChatChannels();

    // channels that could not be created while there was no connection (groups
    // formed or voice enabled during an outage, or everything after voice chat
    // was disabled and enabled again)
    ChatHandler(static_cast<WorldSession*>(nullptr)).DoForAllValidSessions([this](Player* player)
    {
        if (player->GetSession()->IsVoiceChatEnabled())
            JoinAvailableVoiceChatChannels(player->GetSession());
    });

    if (reconnect)
        SendVoiceChatServiceReconnected();

    sScriptMgr->OnVoiceServerConnected();
}

void VoiceChatMgr::OnVoiceServerDisconnected()
{
    LOG_WARN("voice-chat", "Voiceserver connection lost");

    // channels stay registered and are restored once the connection is re-established
    SendVoiceChatServiceDisconnect();

    sScriptMgr->OnVoiceServerDisconnected();
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

void VoiceChatMgr::EnableChannelSlot(uint16 channelId, uint8 slotId, Player const* player)
{
    if (!CanUseVoiceChat())
        return;

    WorldSession* session = player->GetSession();
    std::string const& clientAddress = session->GetRemoteAddress();
    std::string const& name = player->GetName();

    VoiceChatServerPacket data(VoiceChatServerOpcodes::CMSG_ADD_MEMBER,
        3 + clientAddress.size() + 1 + 8 + name.size() + 1 + 4);
    data << channelId;
    data << slotId;
    data << clientAddress;
    data << player->GetGUID().GetRawValue();
    data << name;
    data << session->GetAccountId();
    SendPacket(data);
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

bool VoiceChatMgr::SendModuleMessage(std::string const& tag, ByteBuffer const& data)
{
    if (!CanUseVoiceChat())
        return false;

    VoiceChatServerPacket packet;
    if (!BuildVoiceChatModuleMessage(packet, VoiceChatServerOpcodes::CMSG_MODULE_MESSAGE, tag, data))
    {
        LOG_ERROR("voice-chat", "Module message '{}' of {} bytes does not fit an internal packet", tag, data.wpos());
        return false;
    }

    SendPacket(packet);
    return true;
}

void VoiceChatMgr::HandleModuleMessageOpcode(VoiceChatServerPacket& packet)
{
    std::string tag;
    ByteBuffer message;
    ReadVoiceChatModuleMessage(packet, tag, message);

    sScriptMgr->OnVoiceServerModuleMessage(tag, message);
}

void VoiceChatMgr::HandleCreateVoiceSessionResponseOpcode(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 error;
    packet >> channelId;
    packet >> error;

    if (error == static_cast<uint8>(VoiceChatCreateSessionResult::Ok))
        return;

    LOG_ERROR("voice-chat", "Voiceserver could not create voice session {}, removing channel", channelId);

    if (Channel* channel = GetVoiceChatChannel(channelId))
        DeleteVoiceChatChannel(channel);
}

uint16 VoiceChatMgr::GetNextVoiceChannelId()
{
    // skip 0 and ids that are still in use, 0 once every id is in use
    for (uint32 tries = 0; tries <= std::numeric_limits<uint16>::max(); ++tries)
    {
        ++_nextVoiceChannelId;
        if (_nextVoiceChannelId && _voiceChannels.find(_nextVoiceChannelId) == _voiceChannels.end())
            return _nextVoiceChannelId;
    }

    return 0;
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
    if (!voiceId)
    {
        LOG_ERROR("voice-chat", "Could not create a voice session of type {}, every voice channel id is in use",
            uint32(channel->GetVoiceType()));
        return;
    }

    channel->SetVoiceId(voiceId);
    channel->SetVoiceSessionId(GetNewSessionId());
    channel->SetVoiceSessionKey(Acore::Crypto::GetRandomBytes<VOICECHAT_SESSION_KEY_SIZE>());

    _voiceChannels[voiceId] = channel;
    if (ownedChannel)
        _ownedChannels[voiceId] = std::move(ownedChannel);

    LOG_DEBUG("voice-chat", "Creating voice session {} type {}", voiceId, uint32(channel->GetVoiceType()));

    VoiceChatServerPacket data(VoiceChatServerOpcodes::CMSG_CREATE_VOICE_SESSION, 3 + VOICECHAT_SESSION_KEY_SIZE);
    data << voiceId;
    data << static_cast<uint8>(channel->GetVoiceType());
    data.append(channel->GetVoiceSessionKey());
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
            Battleground* bg = sBattlegroundMgr->GetBattleground(channel->GetVoiceGroupId(), BATTLEGROUND_TYPE_NONE);
            if (bg)
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

void VoiceChatMgr::QueueEmptyCustomVoiceSession(uint16 voiceId)
{
    // released on the next update, the caller may be iterating the channels
    _emptyCustomVoiceSessions.push_back(voiceId);
}

void VoiceChatMgr::AddCustomVoiceSessionMember(ObjectGuid guid)
{
    ++_customVoiceSessionCounts[guid];
}

void VoiceChatMgr::RemoveCustomVoiceSessionMember(ObjectGuid guid)
{
    auto itr = _customVoiceSessionCounts.find(guid);
    if (itr == _customVoiceSessionCounts.end())
        return;

    if (--itr->second == 0)
        _customVoiceSessionCounts.erase(itr);
}

uint32 VoiceChatMgr::GetCustomVoiceSessionCount(ObjectGuid guid) const
{
    auto itr = _customVoiceSessionCounts.find(guid);
    return itr != _customVoiceSessionCounts.end() ? itr->second : 0;
}

void VoiceChatMgr::ReleaseEmptyCustomVoiceSessions()
{
    if (_emptyCustomVoiceSessions.empty())
        return;

    std::vector<uint16> voiceIds;
    voiceIds.swap(_emptyCustomVoiceSessions);

    for (uint16 voiceId : voiceIds)
    {
        // skip sessions a member was added to again since
        Channel* channel = GetVoiceChatChannel(voiceId);
        if (channel && channel->GetVoiceType() == VoiceChatChannelType::Custom && channel->GetVoiceMembers().empty())
            DeleteVoiceChatChannel(channel, false);
    }
}

void VoiceChatMgr::DeleteVoiceChatChannel(Channel* channel, bool turnVoiceOff)
{
    if (!channel)
        return;

    uint16 const voiceId = channel->GetVoiceId();
    if (!voiceId)
        return;

    LOG_DEBUG("voice-chat", "Deleting voice session {} type {}", voiceId, uint32(channel->GetVoiceType()));

    channel->DisbandVoiceSession();

    // disable voice on the custom chat channel
    if (turnVoiceOff && channel->GetVoiceType() == VoiceChatChannelType::Custom && channel->IsVoiceEnabled())
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
    // custom chat channels keep voice on like those whose session was released,
    // connecting again creates their sessions for the members with voice enabled
    while (!_voiceChannels.empty())
        DeleteVoiceChatChannel(_voiceChannels.begin()->second, false);
}

// re-create all registered channels on the voiceserver after (re)connecting
void VoiceChatMgr::RestoreVoiceChatChannels()
{
    for (auto const& [voiceId, channel] : _voiceChannels)
    {
        LOG_DEBUG("voice-chat", "Restoring voice session {} on voiceserver", voiceId);

        VoiceChatServerPacket data(VoiceChatServerOpcodes::CMSG_CREATE_VOICE_SESSION, 3 + VOICECHAT_SESSION_KEY_SIZE);
        data << voiceId;
        data << static_cast<uint8>(channel->GetVoiceType());
        data.append(channel->GetVoiceSessionKey());
        SendPacket(data);

        for (auto const& [userId, member] : channel->GetVoiceMembers())
        {
            // offline members are pruned by the roster update below
            Player* player = ObjectAccessor::FindConnectedPlayer(member.Guid);
            if (!player)
                continue;

            EnableChannelSlot(voiceId, userId, player);
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
        if (channel->GetVoiceType() == VoiceChatChannelType::Battleground && channel->GetVoiceGroupId() == instanceId &&
            channel->GetTeamId() == team)
            return channel;

    return nullptr;
}

Channel* VoiceChatMgr::GetCustomVoiceChatChannel(std::string const& name, TeamId team)
{
    // the session belongs to the chat channel (whose voice type is always Custom),
    // looked up like chat does (ignoring case) rather than by walking every voice session
    Channel* channel = sChannelMgr.GetChannel(GetCustomChannelTeam(team), name);
    if (channel && channel->GetVoiceId())
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
    if (name.empty())
        return;

    if (!CanUseVoiceChat())
        return;

    // a channel that already has a voice session (voice id) never gets a second one
    Channel* channel = sChannelMgr.GetChannel(GetCustomChannelTeam(team), name);
    if (!channel || channel->GetVoiceId() || channel->IsConstant() || channel->IsLFG())
        return;

    // a session nobody can be added to would only hold a voice channel id, it is
    // created once a member that can use voice joins or enables voice chat
    if (!channel->HasVoiceChatCandidate())
        return;

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

    // a group has at most one voice channel: if the raid channel already exists,
    // its creation added every voice enabled member, so drop the party channel
    if (GetRaidVoiceChatChannel(groupId))
    {
        DeleteGroupVoiceChatChannel(groupId);
        return;
    }

    channel->SetVoiceType(VoiceChatChannelType::Raid);
    channel->SendVoiceRoster(true);
}

void VoiceChatMgr::AddToGroupVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    // the group may have become a raid since this change was queued
    if (Channel* raidChannel = GetRaidVoiceChatChannel(groupId))
    {
        raidChannel->AddVoiceChatMember(guid);
        return;
    }

    Channel* channel = GetGroupVoiceChatChannel(groupId);
    if (!channel)
    {
        // adds all eligible members the group already lists
        CreateGroupVoiceChatChannel(groupId);
        channel = GetGroupVoiceChatChannel(groupId);
        if (!channel)
            return;
    }

    // the group may not list the player yet (or not be registered at all while
    // it is being created), so always add them explicitly; no-op if already added
    channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    Channel* channel = GetRaidVoiceChatChannel(groupId);
    if (!channel && GetGroupVoiceChatChannel(groupId))
    {
        // the group's conversion to raid is still queued: apply it now instead
        // of creating a second voice channel for the same group
        ConvertToRaidChannel(groupId);
        channel = GetRaidVoiceChatChannel(groupId);
    }

    if (!channel)
    {
        CreateRaidVoiceChatChannel(groupId);
        channel = GetRaidVoiceChatChannel(groupId);
        if (!channel)
            return;
    }

    // see AddToGroupVoiceChatChannel
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
        channel = GetBattlegroundVoiceChatChannel(player->GetBattlegroundId(), player->GetBgTeamId());
        if (!channel)
            return;
    }

    // see AddToGroupVoiceChatChannel
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

    // custom channels the player is on with voice on, their voice session is
    // created again if everyone had left it
    for (Channel* channel : player->GetJoinedChannels())
    {
        if (channel->IsVoiceEnabled() && !channel->IsBanned(player->GetGUID()))
            AddToCustomVoiceChatChannel(player->GetGUID(), channel->GetName(), player->GetTeamId());
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
