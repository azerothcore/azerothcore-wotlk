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

#ifndef __Voice_Channel_H__
#define __Voice_Channel_H__

#include "Define.h"
#include "UdpSocket.h"
#include "VoiceChatSharedDefines.h"
#include "VoiceWorldLink.h"
#include <boost/asio/ip/address.hpp>
#include <boost/asio/ip/udp.hpp>
#include <chrono>
#include <map>
#include <string>

// IPv4 clients compare equal whether seen as plain IPv4 or as IPv4-mapped IPv6
inline boost::asio::ip::address NormalizeVoiceClientAddress(boost::asio::ip::address const& address)
{
    if (address.is_v6() && address.to_v6().is_v4_mapped())
        return boost::asio::ip::make_address_v4(boost::asio::ip::v4_mapped, address.to_v6());

    return address;
}

struct VoiceChannelMember
{
    // IP the worldserver saw the player's game client connect from. Only UDP
    // traffic from this address may claim the slot.
    boost::asio::ip::address ClientAddress;
    // UDP endpoint the game client announced itself from (via the initial
    // header-only datagram). Voice frames are relayed to this endpoint.
    boost::asio::ip::udp::endpoint Endpoint;
    bool HasEndpoint = false;
    // may receive voice frames
    bool Voiced = false;
    // may not send voice frames
    bool Muted = false;
    // voice frames the member may still send right now (rate limit), refilled over time
    float PacketBudget = 0.0f;
    std::chrono::steady_clock::time_point PacketBudgetTime;
    // character in this slot as announced by the worldserver, only used to
    // identify the speaker (e.g. in logs)
    uint64 CharacterGuid = 0;
    std::string CharacterName;
    uint32 AccountId = 0;
};

class VoiceChannel
{
public:
    VoiceChannel(VoiceWorldLink const& world, uint16 channelId, VoiceChatChannelType type,
        VoiceChatSessionKey const& sessionKey);

    // the worldserver the channel belongs to, channelId is only unique together with it
    VoiceWorldLink const& GetWorld() const { return _world; }
    uint16 GetChannelId() const { return _channelId; }
    VoiceChatChannelType GetType() const { return _type; }
    uint32 GetMaxMembers() const { return _maxMembers; }

    // whether a game client signed the datagram with this channel's session key
    bool HasValidSignature(UdpSocketPacket const& packet) const;

    // returns nullptr if the member does not exist
    VoiceChannelMember* GetMember(uint8 userId);
    VoiceChannelMember const* GetMember(uint8 userId) const;

    // (re)adds a member, member carries its client address and character, its state is reset
    bool AddMember(uint8 userId, VoiceChannelMember const& member);
    void RemoveMember(uint8 userId);

    std::map<uint8, VoiceChannelMember> const& GetMembers() const { return _members; }

private:
    VoiceWorldLink _world;
    uint16 _channelId;
    VoiceChatChannelType _type;
    VoiceChatSessionKey _sessionKey;
    uint32 _maxMembers;
    std::map<uint8, VoiceChannelMember> _members;
};

#endif
