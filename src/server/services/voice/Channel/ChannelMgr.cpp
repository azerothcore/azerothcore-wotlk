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
#include "VoiceScriptMgr.h"

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

bool ChannelMgr::CreateChannel(InternalSession const* session, uint16 channelId, VoiceChatChannelType type,
    VoiceChatSessionKey const& sessionKey)
{
    if (!channelId || type >= VoiceChatChannelType::Max)
        return false;

    bool replaced = false;
    {
        std::lock_guard<std::mutex> guard(_lock);

        if (VoiceChannel* existing = GetChannel(channelId))
        {
            // the worldserver re-creates its channels after a reconnect,
            // only ever re-use ids of the same connection
            if (existing->GetOwner() != session)
            {
                LOG_ERROR("voice-chat", "Worldserver requested creation of channel {} which is owned by another connection",
                    channelId);
                return false;
            }

            _channels.erase(channelId);
            replaced = true;
        }

        _channels.emplace(std::piecewise_construct, std::forward_as_tuple(channelId),
            std::forward_as_tuple(channelId, type, sessionKey, session));
    }

    LOG_DEBUG("voice-chat", "Channel {} created, type {}", channelId, uint32(type));

    if (replaced)
        sVoiceScriptMgr->OnChannelDeleted(channelId);

    sVoiceScriptMgr->OnChannelCreated(channelId, type);
    return true;
}

void ChannelMgr::DeleteChannel(InternalSession const* session, uint16 channelId)
{
    {
        std::lock_guard<std::mutex> guard(_lock);

        if (!GetOwnedChannel(session, channelId, "delete channel"))
            return;

        _channels.erase(channelId);
    }

    LOG_DEBUG("voice-chat", "Channel {} deleted", channelId);
    sVoiceScriptMgr->OnChannelDeleted(channelId);
}

bool ChannelMgr::AddMember(InternalSession const* session, uint16 channelId, uint8 userId,
    VoiceChannelMember const& member)
{
    VoiceChannelMember added;
    {
        std::lock_guard<std::mutex> guard(_lock);

        VoiceChannel* channel = GetOwnedChannel(session, channelId, "add member");
        if (!channel)
            return false;

        if (!channel->AddMember(userId, member))
        {
            LOG_ERROR("voice-chat", "Could not add member {} ({}) to channel {} (invalid id or channel full)",
                userId, member.CharacterName, channelId);
            return false;
        }

        added = *channel->GetMember(userId);
    }

    LOG_DEBUG("voice-chat", "Channel {} member {} enabled: {} (guid {}, account {})",
        channelId, userId, added.CharacterName, added.CharacterGuid, added.AccountId);

    sVoiceScriptMgr->OnMemberAdded(channelId, userId, added);
    return true;
}

void ChannelMgr::RemoveMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    {
        std::lock_guard<std::mutex> guard(_lock);

        VoiceChannel* channel = GetOwnedChannel(session, channelId, "remove member");
        if (!channel || !channel->GetMember(userId))
            return;

        channel->RemoveMember(userId);
    }

    LOG_DEBUG("voice-chat", "Channel {} member {} removed", channelId, userId);
    sVoiceScriptMgr->OnMemberRemoved(channelId, userId);
}

void ChannelMgr::ChangeMemberState(InternalSession const* session, uint16 channelId, uint8 userId, char const* action,
    bool logMissingMember, void (*change)(VoiceChannelMember& member))
{
    bool voiced;
    bool muted;
    {
        std::lock_guard<std::mutex> guard(_lock);

        VoiceChannel* channel = GetOwnedChannel(session, channelId, action);
        if (!channel)
            return;

        VoiceChannelMember* member = channel->GetMember(userId);
        if (!member)
        {
            if (logMissingMember)
                LOG_ERROR("voice-chat", "Worldserver requested to {}: member {} not found in channel {}",
                    action, userId, channelId);
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

    sVoiceScriptMgr->OnMemberStateChanged(channelId, userId, voiced, muted);
}

void ChannelMgr::VoiceMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    ChangeMemberState(session, channelId, userId, "voice member", true,
        [](VoiceChannelMember& member) { member.Voiced = true; });
}

void ChannelMgr::DevoiceMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    ChangeMemberState(session, channelId, userId, "devoice member", false,
        [](VoiceChannelMember& member) { member.Voiced = false; });
}

void ChannelMgr::MuteMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    ChangeMemberState(session, channelId, userId, "mute member", false,
        [](VoiceChannelMember& member) { member.Muted = true; });
}

void ChannelMgr::UnmuteMember(InternalSession const* session, uint16 channelId, uint8 userId)
{
    ChangeMemberState(session, channelId, userId, "unmute member", false,
        [](VoiceChannelMember& member) { member.Muted = false; });
}

void ChannelMgr::RemoveChannelsFor(InternalSession const* session)
{
    std::vector<uint16> removed;
    {
        std::lock_guard<std::mutex> guard(_lock);

        for (auto itr = _channels.begin(); itr != _channels.end();)
        {
            if (itr->second.GetOwner() == session)
            {
                removed.push_back(itr->first);
                itr = _channels.erase(itr);
            }
            else
                ++itr;
        }
    }

    for (uint16 channelId : removed)
    {
        LOG_DEBUG("voice-chat", "Channel {} removed, worldserver connection dropped", channelId);
        sVoiceScriptMgr->OnChannelDeleted(channelId);
    }
}

bool ChannelMgr::HandleClientHandshake(UdpSocketPacket const& packet, boost::asio::ip::udp::endpoint const& endpoint)
{
    uint16 const channelId = packet.GetHeader().channelId;
    uint8 const userId = packet.GetHeader().userId;

    std::lock_guard<std::mutex> guard(_lock);

    VoiceChannel* channel = GetChannel(channelId);
    if (!channel)
        return false;

    VoiceChannelMember* member = channel->GetMember(userId);
    if (!member)
        return false;

    // the header is trivially forgeable, so only the client the worldserver
    // announced for this slot may claim it (its port may change, e.g. behind NAT)
    if (NormalizeVoiceClientAddress(endpoint.address()) != member->ClientAddress)
    {
        LOG_DEBUG("voice-chat", "Rejected handshake for channel {} member {} from {}:{}, expected address {}",
            channelId, userId, endpoint.address().to_string(), endpoint.port(), member->ClientAddress.to_string());
        return false;
    }

    // and only with the key of the session
    if (!channel->HasValidSignature(packet))
    {
        LOG_DEBUG("voice-chat", "Rejected handshake for channel {} member {} from {}:{}, wrong signature",
            channelId, userId, endpoint.address().to_string(), endpoint.port());
        return false;
    }

    if (member->HasEndpoint && member->Endpoint != endpoint)
        LOG_DEBUG("voice-chat", "Channel {} member {} re-announced from a different endpoint {}:{}",
            channelId, userId, endpoint.address().to_string(), endpoint.port());

    member->Endpoint = endpoint;
    member->HasEndpoint = true;
    return true;
}

bool ChannelMgr::GetRelayTargets(UdpSocketPacket const& packet, boost::asio::ip::udp::endpoint const& sender,
    std::vector<boost::asio::ip::udp::endpoint>& targets, bool& announced)
{
    uint16 const channelId = packet.GetHeader().channelId;
    uint8 const userId = packet.GetHeader().userId;
    announced = false;

    std::lock_guard<std::mutex> guard(_lock);

    VoiceChannel* channel = GetChannel(channelId);
    if (!channel)
        return false;

    VoiceChannelMember* member = channel->GetMember(userId);
    if (!member)
        return false;

    // the header is trivially forgeable, so only the client the worldserver
    // announced for this slot may use it, and only with the key of the session
    if (NormalizeVoiceClientAddress(sender.address()) != member->ClientAddress)
        return false;

    if (!channel->HasValidSignature(packet))
        return false;

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
