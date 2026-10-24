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

#ifndef __VOICE_CHANNELMGR_H__
#define __VOICE_CHANNELMGR_H__

#include "Channel.h"
#include "Define.h"
#include "VoiceWorldLink.h"
#include <boost/asio/ip/udp.hpp>
#include <map>
#include <mutex>
#include <utility>
#include <vector>

/*
 * Owns all voice channels of the voiceserver.
 *
 * Accessed concurrently from the internal (TCP) network thread and the
 * thread running the UDP voice socket, hence every entry point takes the
 * manager lock.
 *
 * Script hooks are called after the manager lock was released.
 *
 * Several worldservers (realms) may share the voiceserver. Each numbers its
 * voice channels on its own, so channels are kept per worldserver connection
 * and a channel id is only unique together with its VoiceWorldLink id. The
 * datagrams of the game clients only carry the channel and user id: they are
 * matched to the member with the sender's address in the channel whose session
 * key verifies their signature.
 */
class VoiceChannelMgr
{
public:
    static VoiceChannelMgr& Instance()
    {
        static VoiceChannelMgr instance;
        return instance;
    }

    // voice frames a member may send per second, more are dropped. 0 = no limit.
    // Only set at startup, before any traffic
    void SetMaxPacketsPerSecond(uint32 maxPacketsPerSecond) { _maxPacketsPerSecond = maxPacketsPerSecond; }

    // internal (TCP) side, world: the worldserver connection the request came from
    // sessionKey: the key game clients sign their voice datagrams with
    bool CreateChannel(VoiceWorldLink const& world, uint16 channelId, VoiceChatChannelType type,
        VoiceChatSessionKey const& sessionKey);
    void DeleteChannel(VoiceWorldLink const& world, uint16 channelId);
    // member: client address and character of the new member
    bool AddMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId, VoiceChannelMember const& member);
    void RemoveMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId);
    void VoiceMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId);
    void DevoiceMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId);
    void MuteMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId);
    void UnmuteMember(VoiceWorldLink const& world, uint16 channelId, uint8 userId);

    // removes every channel owned by a dropped worldserver connection
    void RemoveChannelsFor(VoiceWorldLink const& world);

    // UDP (game client) side, world receives the worldserver of the sender's channel

    // registers the endpoint a client sends voice data from (the header-only packet),
    // returns false if the member is unknown or the packet is not the member's
    bool HandleClientHandshake(UdpSocketPacket const& packet, boost::asio::ip::udp::endpoint const& endpoint,
        VoiceWorldLink& world);
    // collects the endpoints a voice frame should be relayed to,
    // returns false if the sender is not allowed to speak.
    // announced is set if the frame registered the sender's endpoint in place of a handshake
    bool GetRelayTargets(UdpSocketPacket const& packet, boost::asio::ip::udp::endpoint const& sender,
        std::vector<boost::asio::ip::udp::endpoint>& targets, bool& announced, VoiceWorldLink& world);

private:
    // channel id, VoiceWorldLink id
    using ChannelKey = std::pair<uint16, uint32>;

    // requires _lock to be held, returns nullptr if world has no such channel
    VoiceChannel* GetOwnedChannel(VoiceWorldLink const& world, uint16 channelId, char const* action);
    // requires _lock to be held: the channel a game client's datagram belongs to, the one
    // with the datagram's channel id holding its user id with address as client address
    // and whose session key verifies the signature. nullptr if there is none
    VoiceChannel* FindSenderChannel(UdpSocketPacket const& packet, boost::asio::ip::address const& address);
    // applies change to a member of a channel owned by world, reports a changed state to the scripts
    void ChangeMemberState(VoiceWorldLink const& world, uint16 channelId, uint8 userId, char const* action,
        bool logMissingMember, void (*change)(VoiceChannelMember& member));
    // requires _lock to be held, returns false if the member sent too many voice frames
    bool ConsumePacketBudget(VoiceChannelMember& member) const;

    uint32 _maxPacketsPerSecond = 0;
    std::mutex _lock;
    std::map<ChannelKey, VoiceChannel> _channels;
};

#define sVoiceChannelMgr VoiceChannelMgr::Instance()

#endif
