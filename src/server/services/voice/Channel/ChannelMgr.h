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

#ifndef __ChannelMgr_H__
#define __ChannelMgr_H__

#include "Channel.h"
#include "Define.h"
#include <boost/asio/ip/udp.hpp>
#include <map>
#include <mutex>
#include <vector>

class InternalSession;

/*
 * Owns all voice channels of the voiceserver.
 *
 * Accessed concurrently from the internal (TCP) network thread and the
 * thread running the UDP voice socket, hence every entry point takes the
 * manager lock.
 *
 * InternalSession pointers are only stored to identify the owning
 * worldserver connection; they are compared, never dereferenced, since the
 * session may already be destroyed when a channel is cleaned up.
 */
class ChannelMgr
{
public:
    static ChannelMgr& Instance()
    {
        static ChannelMgr instance;
        return instance;
    }

    // internal (TCP) side
    bool CreateChannel(InternalSession const* session, uint16 channelId, VoiceChatChannelType type);
    void DeleteChannel(InternalSession const* session, uint16 channelId);
    bool AddMember(InternalSession const* session, uint16 channelId, uint8 userId);
    void RemoveMember(InternalSession const* session, uint16 channelId, uint8 userId);
    void VoiceMember(InternalSession const* session, uint16 channelId, uint8 userId);
    void DevoiceMember(InternalSession const* session, uint16 channelId, uint8 userId);
    void MuteMember(InternalSession const* session, uint16 channelId, uint8 userId);
    void UnmuteMember(InternalSession const* session, uint16 channelId, uint8 userId);

    // removes every channel owned by a dropped worldserver connection
    void RemoveChannelsFor(InternalSession const* session);

    // UDP (game client) side

    // registers the endpoint a client sends voice data from, returns false if the member is unknown
    bool HandleClientHandshake(uint16 channelId, uint8 userId, boost::asio::ip::udp::endpoint const& endpoint);
    // collects the endpoints a voice frame should be relayed to,
    // returns false if the sender is not allowed to speak
    bool GetRelayTargets(uint16 channelId, uint8 userId, boost::asio::ip::udp::endpoint const& sender, std::vector<boost::asio::ip::udp::endpoint>& targets);

private:
    // requires _lock to be held, may return nullptr
    VoiceChannel* GetChannel(uint16 channelId);
    // requires _lock to be held, returns nullptr if the channel is not owned by session
    VoiceChannel* GetOwnedChannel(InternalSession const* session, uint16 channelId, char const* action);

    std::mutex _lock;
    std::map<uint16, VoiceChannel> _channels;
};

#define sChannelMgr ChannelMgr::Instance()

#endif
