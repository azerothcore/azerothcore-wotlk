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

#include "ChannelMgr.h"
#include "Log.h"

VoiceChannel* ChannelMgr::GetChannel(uint16 channelId)
{
    auto itr = _channels.find(channelId);
    return itr != _channels.end() ? &itr->second : nullptr;
}

VoiceChannel* ChannelMgr::GetOwnedChannel(InternalSession const* session, uint16 channelId, char const* action)
{
    VoiceChannel* channel = GetChannel(channelId);
    if (!channel)
    {
        LOG_ERROR("voice-chat", "Worldserver requested to {} on nonexistent channel {}", action, channelId);
        return nullptr;
    }

    if (channel->GetOwner() != session)
    {
        LOG_ERROR("voice-chat", "Worldserver requested to {} on channel {} owned by another connection", action, channelId);
        return nullptr;
    }

    return channel;
}

bool ChannelMgr::CreateChannel(InternalSession const* session, uint16 channelId, VoiceChatChannelType type)
{
    if (!channelId || type >= VoiceChatChannelType::Max)
        return false;

    std::lock_guard<std::mutex> guard(_lock);

    if (VoiceChannel* existing = GetChannel(channelId))
    {
        // the worldserver re-creates its channels after a reconnect,
        // only ever re-use ids of the same connection
        if (existing->GetOwner() != session)
        {
            LOG_ERROR("voice-chat", "Worldserver requested creation of channel {} which is owned by another connection", channelId);
            return false;
        }

        _channels.erase(channelId);
    }

    _channels.emplace(std::piecewise_construct, std::forward_as_tuple(channelId),
        std::forward_as_tuple(channelId, type, session));

    LOG_DEBUG("voice-chat", "Channel {} created, type {}", channelId, uint32(type));
    return true;
}

void ChannelMgr::DeleteChannel(InternalSession const* session, uint16 channelId)
{
    std::lock_guard<std::mutex> guard(_lock);

    if (!GetOwnedChannel(session, channelId, "delete channel"))
        return;

    _channels.erase(channelId);
    LOG_DEBUG("voice-chat", "Channel {} deleted", channelId);
}

bool ChannelMgr::AddMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    std::lock_guard<std::mutex> guard(_lock);

    VoiceChannel* channel = GetOwnedChannel(session, channelId, "add member");
    if (!channel)
        return false;

    if (!channel->AddMember(userId))
    {
        LOG_ERROR("voice-chat", "Could not add member {} to channel {} (invalid id or channel full)", userId, channelId);
        return false;
    }

    LOG_DEBUG("voice-chat", "Channel {} member {} enabled", channelId, userId);
    return true;
}

void ChannelMgr::RemoveMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    std::lock_guard<std::mutex> guard(_lock);

    if (VoiceChannel* channel = GetOwnedChannel(session, channelId, "remove member"))
    {
        channel->RemoveMember(userId);
        LOG_DEBUG("voice-chat", "Channel {} member {} removed", channelId, userId);
    }
}

void ChannelMgr::VoiceMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    std::lock_guard<std::mutex> guard(_lock);

    if (VoiceChannel* channel = GetOwnedChannel(session, channelId, "voice member"))
    {
        if (VoiceChannelMember* member = channel->GetMember(userId))
            member->Voiced = true;
        else
            LOG_ERROR("voice-chat", "Voice member: member {} not found in channel {}", userId, channelId);
    }
}

void ChannelMgr::DevoiceMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    std::lock_guard<std::mutex> guard(_lock);

    if (VoiceChannel* channel = GetOwnedChannel(session, channelId, "devoice member"))
    {
        if (VoiceChannelMember* member = channel->GetMember(userId))
            member->Voiced = false;
    }
}

void ChannelMgr::MuteMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    std::lock_guard<std::mutex> guard(_lock);

    if (VoiceChannel* channel = GetOwnedChannel(session, channelId, "mute member"))
    {
        if (VoiceChannelMember* member = channel->GetMember(userId))
            member->Muted = true;
    }
}

void ChannelMgr::UnmuteMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    std::lock_guard<std::mutex> guard(_lock);

    if (VoiceChannel* channel = GetOwnedChannel(session, channelId, "unmute member"))
    {
        if (VoiceChannelMember* member = channel->GetMember(userId))
            member->Muted = false;
    }
}

void ChannelMgr::RemoveChannelsFor(InternalSession const* session)
{
    std::lock_guard<std::mutex> guard(_lock);

    for (auto itr = _channels.begin(); itr != _channels.end();)
    {
        if (itr->second.GetOwner() == session)
        {
            LOG_DEBUG("voice-chat", "Channel {} removed, worldserver connection dropped", itr->first);
            itr = _channels.erase(itr);
        }
        else
            ++itr;
    }
}

bool ChannelMgr::HandleClientHandshake(uint16 channelId, uint8 userId, boost::asio::ip::udp::endpoint const& endpoint)
{
    std::lock_guard<std::mutex> guard(_lock);

    VoiceChannel* channel = GetChannel(channelId);
    if (!channel)
        return false;

    VoiceChannelMember* member = channel->GetMember(userId);
    if (!member)
        return false;

    if (member->HasEndpoint && member->Endpoint != endpoint)
        LOG_DEBUG("voice-chat", "Channel {} member {} re-announced from a different endpoint {}:{}",
            channelId, userId, endpoint.address().to_string(), endpoint.port());

    member->Endpoint = endpoint;
    member->HasEndpoint = true;
    return true;
}

bool ChannelMgr::GetRelayTargets(uint16 channelId, uint8 userId, boost::asio::ip::udp::endpoint const& sender, std::vector<boost::asio::ip::udp::endpoint>& targets)
{
    std::lock_guard<std::mutex> guard(_lock);

    VoiceChannel* channel = GetChannel(channelId);
    if (!channel)
        return false;

    VoiceChannelMember* member = channel->GetMember(userId);
    if (!member)
        return false;

    // voice frames must come from the endpoint the member announced itself
    // from - the header is trivially forgeable otherwise
    if (!member->HasEndpoint || member->Endpoint != sender)
        return false;

    if (member->Muted || !member->Voiced)
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
