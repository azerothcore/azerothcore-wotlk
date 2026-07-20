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

#include "Channel.h"

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
}

VoiceChannel::VoiceChannel(uint16 channelId, VoiceChatChannelType type, InternalSession const* owner)
    : _channelId(channelId), _type(type), _owner(owner), _maxMembers(GetMaxMembersForType(type))
{
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

bool VoiceChannel::AddMember(uint8 userId)
{
    if (!userId)
        return false;

    if (_members.size() >= _maxMembers && _members.find(userId) == _members.end())
        return false;

    // (re)adding a member resets its state
    _members[userId] = VoiceChannelMember();
    return true;
}

void VoiceChannel::RemoveMember(uint8 userId)
{
    _members.erase(userId);
}
