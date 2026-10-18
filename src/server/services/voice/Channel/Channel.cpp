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

#include "Channel.h"
#include "HMAC.h"

namespace
{
    uint32 GetMaxMembersForType(VoiceChatChannelType const type)
    {
        switch (type)
        {
            case VoiceChatChannelType::Custom:
                return 250;
            case VoiceChatChannelType::Battleground:
                return 80;
            case VoiceChatChannelType::Group:
                return 40;
            case VoiceChatChannelType::Raid:
                return 80;
            default:
                return 0;
        }
    }

    uint32 ReadUInt32LE(uint8 const* data)
    {
        return uint32(data[0]) | (uint32(data[1]) << 8) | (uint32(data[2]) << 16) | (uint32(data[3]) << 24);
    }
}

VoiceChannel::VoiceChannel(VoiceWorldLink const& world, uint16 channelId, VoiceChatChannelType type,
    VoiceChatSessionKey const& sessionKey)
    : _world(world), _channelId(channelId), _type(type), _sessionKey(sessionKey),
    _maxMembers(GetMaxMembersForType(type))
{
}

bool VoiceChannel::HasValidSignature(UdpSocketPacket const& packet) const
{
    uint8 const* data = packet.GetData();
    std::size_t const signatureSize = sizeof(UdpSocketPacketHeader::signature);

    Acore::Crypto::HMAC_MD5::Digest const digest = Acore::Crypto::HMAC_MD5::GetDigestOf(_sessionKey,
        data + signatureSize, packet.GetDataLength() - signatureSize);

    uint32 expected = 0;
    for (std::size_t i = 0; i < digest.size(); i += sizeof(uint32))
        expected ^= ReadUInt32LE(digest.data() + i);

    return ReadUInt32LE(data) == expected;
}

VoiceChannelMember* VoiceChannel::GetMember(uint8 userId)
{
    auto itr = _members.find(userId);
    return itr != _members.end() ? &itr->second : nullptr;
}

VoiceChannelMember const* VoiceChannel::GetMember(uint8 userId) const
{
    auto itr = _members.find(userId);
    return itr != _members.end() ? &itr->second : nullptr;
}

bool VoiceChannel::AddMember(uint8 userId, VoiceChannelMember const& member)
{
    if (!userId)
        return false;

    if (_members.size() >= _maxMembers && _members.find(userId) == _members.end())
        return false;

    // (re)adding a member resets its state
    VoiceChannelMember added;
    added.ClientAddress = NormalizeVoiceClientAddress(member.ClientAddress);
    added.CharacterGuid = member.CharacterGuid;
    added.CharacterName = member.CharacterName;
    added.AccountId = member.AccountId;
    _members[userId] = std::move(added);
    return true;
}

void VoiceChannel::RemoveMember(uint8 userId)
{
    _members.erase(userId);
}
