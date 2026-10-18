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

#include "ChannelMgr.h"
#include "Log.h"
#include "VoiceScriptMgr.h"
#include <algorithm>

VoiceChannel* VoiceChannelMgr::GetOwnedChannel(VoiceWorldLink const& world, uint16 channelId, char const* action)
{
    auto itr = _channels.find(ChannelKey(channelId, world.GetId()));
    if (itr == _channels.end())
    {
        LOG_ERROR("voice-chat", "Worldserver #{} requested to {} on nonexistent channel {}", world.GetId(), action,
            channelId);
        return nullptr;
    }

    return &itr->second;
}

VoiceChannel* VoiceChannelMgr::FindSenderChannel(UdpSocketPacket const& packet, boost::asio::ip::address const& address)
{
    uint16 const channelId = packet.GetHeader().channelId;
    uint8 const userId = packet.GetHeader().userId;
    boost::asio::ip::address const clientAddress = NormalizeVoiceClientAddress(address);

    // the header is trivially forgeable: only the client the worldserver announced for
    // the slot may use it, and only with the key of the session. Worldservers sharing
    // the voiceserver may all use this channel id, only the right session key verifies
    for (auto itr = _channels.lower_bound(ChannelKey(channelId, 0));
        itr != _channels.end() && itr->first.first == channelId; ++itr)
    {
        VoiceChannelMember const* member = itr->second.GetMember(userId);
        if (member && member->ClientAddress == clientAddress && itr->second.HasValidSignature(packet))
            return &itr->second;
    }

    return nullptr;
}

bool VoiceChannelMgr::CreateChannel(VoiceWorldLink const& world, uint16 channelId, VoiceChatChannelType type,
    VoiceChatSessionKey const& sessionKey)
{
    if (!channelId || type >= VoiceChatChannelType::Max)
        return false;

    bool replaced = false;
    {
        std::lock_guard<std::mutex> guard(_lock);

        // the worldserver re-creates its channels after a reconnect (as a new
        // connection), it may also create a channel again under the same id
        ChannelKey const key(channelId, world.GetId());
        replaced = _channels.erase(key) > 0;

        _channels.emplace(std::piecewise_construct, std::forward_as_tuple(key),
            std::forward_as_tuple(world, channelId, type, sessionKey));
    }

    LOG_DEBUG("voice-chat", "Channel {} of worldserver #{} created, type {}", channelId, world.GetId(), uint32(type));

    if (replaced)
        sVoiceScriptMgr->OnChannelDeleted(world, channelId);

    sVoiceScriptMgr->OnChannelCreated(world, channelId, type);
    return true;
}

void VoiceChannelMgr::DeleteChannel(VoiceWorldLink const& world, uint16 channelId)
{
    {
        std::lock_guard<std::mutex> guard(_lock);

        if (!GetOwnedChannel(world, channelId, "delete channel"))
            return;

        _channels.erase(ChannelKey(channelId, world.GetId()));
    }

    LOG_DEBUG("voice-chat", "Channel {} of worldserver #{} deleted", channelId, world.GetId());
    sVoiceScriptMgr->OnChannelDeleted(world, channelId);
}

bool VoiceChannelMgr::AddMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId,
    VoiceChannelMember const& member)
{
    VoiceChannelMember added;
    {
        std::lock_guard<std::mutex> guard(_lock);

        VoiceChannel* channel = GetOwnedChannel(world, channelId, "add member");
        if (!channel)
            return false;

        if (!channel->AddMember(userId, member))
        {
            LOG_ERROR("voice-chat",
                "Could not add member {} ({}) to channel {} of worldserver #{} (invalid id or channel full)",
                userId, member.CharacterName, channelId, world.GetId());
            return false;
        }

        added = *channel->GetMember(userId);
    }

    LOG_DEBUG("voice-chat", "Channel {} of worldserver #{} member {} enabled: {} (guid {}, account {})",
        channelId, world.GetId(), userId, added.CharacterName, added.CharacterGuid, added.AccountId);

    sVoiceScriptMgr->OnMemberAdded(world, channelId, userId, added);
    return true;
}

void VoiceChannelMgr::RemoveMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId)
{
    {
        std::lock_guard<std::mutex> guard(_lock);

        VoiceChannel* channel = GetOwnedChannel(world, channelId, "remove member");
        if (!channel || !channel->GetMember(userId))
            return;

        channel->RemoveMember(userId);
    }

    LOG_DEBUG("voice-chat", "Channel {} of worldserver #{} member {} removed", channelId, world.GetId(), userId);
    sVoiceScriptMgr->OnMemberRemoved(world, channelId, userId);
}

void VoiceChannelMgr::ChangeMemberState(VoiceWorldLink const& world, uint16 channelId, uint8 userId, char const* action,
    bool logMissingMember, void (*change)(VoiceChannelMember& member))
{
    bool voiced;
    bool muted;
    {
        std::lock_guard<std::mutex> guard(_lock);

        VoiceChannel* channel = GetOwnedChannel(world, channelId, action);
        if (!channel)
            return;

        VoiceChannelMember* member = channel->GetMember(userId);
        if (!member)
        {
            if (logMissingMember)
                LOG_ERROR("voice-chat", "Worldserver #{} requested to {}: member {} not found in channel {}",
                    world.GetId(), action, userId, channelId);
            return;
        }

        bool const wasVoiced = member->Voiced;
        bool const wasMuted = member->Muted;
        change(*member);
        voiced = member->Voiced;
        muted = member->Muted;

        if (voiced == wasVoiced && muted == wasMuted)
            return;
    }

    sVoiceScriptMgr->OnMemberStateChanged(world, channelId, userId, voiced, muted);
}

void VoiceChannelMgr::VoiceMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId)
{
    ChangeMemberState(world, channelId, userId, "voice member", true,
        [](VoiceChannelMember& member) { member.Voiced = true; });
}

void VoiceChannelMgr::DevoiceMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId)
{
    ChangeMemberState(world, channelId, userId, "devoice member", false,
        [](VoiceChannelMember& member) { member.Voiced = false; });
}

void VoiceChannelMgr::MuteMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId)
{
    ChangeMemberState(world, channelId, userId, "mute member", false,
        [](VoiceChannelMember& member) { member.Muted = true; });
}

void VoiceChannelMgr::UnmuteMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId)
{
    ChangeMemberState(world, channelId, userId, "unmute member", false,
        [](VoiceChannelMember& member) { member.Muted = false; });
}

void VoiceChannelMgr::RemoveChannelsFor(VoiceWorldLink const& world)
{
    std::vector<uint16> removed;
    {
        std::lock_guard<std::mutex> guard(_lock);

        for (auto itr = _channels.begin(); itr != _channels.end();)
        {
            if (itr->first.second == world.GetId())
            {
                removed.push_back(itr->first.first);
                itr = _channels.erase(itr);
            }
            else
                ++itr;
        }
    }

    for (uint16 channelId : removed)
    {
        LOG_DEBUG("voice-chat", "Channel {} of worldserver #{} removed, worldserver connection dropped", channelId,
            world.GetId());
        sVoiceScriptMgr->OnChannelDeleted(world, channelId);
    }
}

bool VoiceChannelMgr::HandleClientHandshake(UdpSocketPacket const& packet,
    boost::asio::ip::udp::endpoint const& endpoint, VoiceWorldLink& world)
{
    std::lock_guard<std::mutex> guard(_lock);

    VoiceChannel* channel = FindSenderChannel(packet, endpoint.address());
    if (!channel)
        return false;

    // the client's port may change, e.g. behind NAT
    VoiceChannelMember* member = channel->GetMember(packet.GetHeader().userId);
    if (member->HasEndpoint && member->Endpoint != endpoint)
        LOG_DEBUG("voice-chat", "Channel {} of worldserver #{} member {} re-announced from a different endpoint {}:{}",
            channel->GetChannelId(), channel->GetWorld().GetId(), packet.GetHeader().userId,
            endpoint.address().to_string(), endpoint.port());

    member->Endpoint = endpoint;
    member->HasEndpoint = true;
    world = channel->GetWorld();
    return true;
}

bool VoiceChannelMgr::ConsumePacketBudget(VoiceChannelMember& member) const
{
    if (!_maxPacketsPerSecond)
        return true;

    std::chrono::steady_clock::time_point const now = std::chrono::steady_clock::now();
    float const elapsed = std::chrono::duration<float>(now - member.PacketBudgetTime).count();
    member.PacketBudgetTime = now;

    // allows a burst of up to one second worth of frames
    float const maxBudget = float(_maxPacketsPerSecond);
    member.PacketBudget = std::min(maxBudget, member.PacketBudget + elapsed * maxBudget);
    if (member.PacketBudget < 1.0f)
        return false;

    member.PacketBudget -= 1.0f;
    return true;
}

bool VoiceChannelMgr::GetRelayTargets(UdpSocketPacket const& packet, boost::asio::ip::udp::endpoint const& sender,
    std::vector<boost::asio::ip::udp::endpoint>& targets, bool& announced, VoiceWorldLink& world)
{
    uint8 const userId = packet.GetHeader().userId;
    announced = false;

    std::lock_guard<std::mutex> guard(_lock);

    VoiceChannel* channel = FindSenderChannel(packet, sender.address());
    if (!channel)
        return false;

    VoiceChannelMember* member = channel->GetMember(userId);
    world = channel->GetWorld();

    // the client only announces itself when it first talks to a voiceserver and
    // after 10 seconds without sending, so a member that keeps talking is never
    // announced if it was added after its announcement (e.g. restored after a
    // voiceserver restart). Its first frame takes the place of the announcement
    if (!member->HasEndpoint)
    {
        member->Endpoint = sender;
        member->HasEndpoint = true;
        announced = true;
    }

    // voice frames must come from the endpoint the member announced itself from
    if (member->Endpoint != sender)
        return false;

    if (member->Muted || !member->Voiced)
        return false;

    // checked last, so datagrams forged with the member's address can not use up its budget
    if (!ConsumePacketBudget(*member))
        return false;

    targets.reserve(channel->GetMembers().size());
    for (auto const& [otherId, other] : channel->GetMembers())
    {
        if (otherId == userId)
            continue;

        if (!other.Voiced || !other.HasEndpoint)
            continue;

        targets.push_back(other.Endpoint);
    }

    return true;
}
