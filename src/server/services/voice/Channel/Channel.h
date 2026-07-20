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

#ifndef __Voice_Channel_H__
#define __Voice_Channel_H__

#include "Define.h"
#include "VoiceChatSharedDefines.h"
#include <boost/asio/ip/udp.hpp>
#include <map>

class InternalSession;

struct VoiceChannelMember
{
    // UDP endpoint the game client announced itself from (via the initial
    // header-only datagram). Voice frames are relayed to this endpoint.
    boost::asio::ip::udp::endpoint Endpoint;
    bool HasEndpoint = false;
    // may receive voice frames
    bool Voiced = false;
    // may not send voice frames
    bool Muted = false;
};

class VoiceChannel
{
public:
    VoiceChannel(uint16 channelId, VoiceChatChannelType type, InternalSession const* owner);

    uint16 GetChannelId() const { return _channelId; }
    VoiceChatChannelType GetType() const { return _type; }
    InternalSession const* GetOwner() const { return _owner; }
    uint32 GetMaxMembers() const { return _maxMembers; }

    // returns nullptr if the member does not exist
    VoiceChannelMember* GetMember(uint8 userId);
    VoiceChannelMember const* GetMember(uint8 userId) const;

    bool AddMember(uint8 userId);
    void RemoveMember(uint8 userId);

    std::map<uint8, VoiceChannelMember> const& GetMembers() const { return _members; }

private:
    uint16 _channelId;
    VoiceChatChannelType _type;
    // identifies the worldserver connection this channel belongs to, only
    // ever used for comparison - never dereference it
    InternalSession const* _owner;
    uint32 _maxMembers;
    std::map<uint8, VoiceChannelMember> _members;
};

#endif
