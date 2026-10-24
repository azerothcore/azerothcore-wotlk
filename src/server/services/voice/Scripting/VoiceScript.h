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

#ifndef _VOICE_SCRIPT_H_
#define _VOICE_SCRIPT_H_

#include "Channel.h"
#include "Define.h"
#include "VoiceChatSharedDefines.h"
#include "VoiceWorldLink.h"
#include <boost/asio/ip/udp.hpp>
#include <span>
#include <string>
#include <vector>

namespace Acore::Asio
{
    class IoContext;
}

enum VoiceScriptHook
{
    VOICEHOOK_ON_STARTUP,
    VOICEHOOK_ON_SHUTDOWN,
    VOICEHOOK_ON_CHANNEL_CREATED,
    VOICEHOOK_ON_CHANNEL_DELETED,
    VOICEHOOK_ON_MEMBER_ADDED,
    VOICEHOOK_ON_MEMBER_REMOVED,
    VOICEHOOK_ON_MEMBER_STATE_CHANGED,
    VOICEHOOK_ON_CLIENT_HANDSHAKE,
    VOICEHOOK_ON_VOICE_PACKET,
    VOICEHOOK_ON_WORLD_MESSAGE,
    VOICEHOOK_END
};

/*
 * Base class of voiceserver scripts, the voiceserver's counterpart to the
 * worldserver script hooks. Modules keep their voiceserver code in
 * src/voiceserver/ and create their scripts (new MyScript();) from
 * Add<module>VoiceScripts(), see modules/VoiceModules.cmake.
 *
 * Threads: OnStartup and OnShutdown run on the main thread, which also runs
 * the UDP socket (OnClientHandshake, OnVoicePacket) and anything posted to
 * the io context passed to OnStartup. The channel and member hooks run on
 * the network thread of the worldserver connections. Hooks of the two groups
 * run concurrently, so scripts synchronize the state they share between them.
 * No hook is called while the voiceserver holds a lock, so scripts may call
 * back into it.
 *
 * Several worldservers may share the voiceserver, each numbering its voice
 * channels on its own: the channel and member hooks pass the worldserver a
 * channel belongs to, key channels by world.GetId() and channelId together.
 */
class VoiceScript
{
protected:
    // enabledHooks: the VoiceScriptHook values the script implements, empty enables all
    explicit VoiceScript(char const* name, std::vector<uint16> enabledHooks = {});

public:
    virtual ~VoiceScript() = default;

    VoiceScript(VoiceScript const&) = delete;
    VoiceScript& operator=(VoiceScript const&) = delete;

    [[nodiscard]] std::string const& GetName() const { return _name; }

    // Called before the voiceserver accepts connections. ioContext runs the UDP
    // socket and outlives OnShutdown, scripts may use it for timers but must
    // never block it.
    virtual void OnStartup(Acore::Asio::IoContext& /*ioContext*/) { }

    // Called once all connections are closed (also when startup failed after OnStartup)
    virtual void OnShutdown() { }

    // Called when a worldserver created a voice channel. A channel created again
    // under the same id is reported as deleted first.
    virtual void OnChannelCreated(VoiceWorldLink const& /*world*/, uint16 /*channelId*/,
        VoiceChatChannelType /*type*/) { }

    // Called when a voice channel was deleted, also when the worldserver owning it
    // disconnected. Its members are gone without an OnMemberRemoved each.
    virtual void OnChannelDeleted(VoiceWorldLink const& /*world*/, uint16 /*channelId*/) { }

    // Called when a member was added to a channel. Adding an existing slot again
    // (e.g. after a worldserver reconnect) resets it and calls this again.
    virtual void OnMemberAdded(VoiceWorldLink const& /*world*/, uint16 /*channelId*/, uint8 /*userId*/,
        VoiceChannelMember const& /*member*/) { }

    virtual void OnMemberRemoved(VoiceWorldLink const& /*world*/, uint16 /*channelId*/, uint8 /*userId*/) { }

    // Called when the state of a member changed. voiced: receives voice, muted: may not speak
    virtual void OnMemberStateChanged(VoiceWorldLink const& /*world*/, uint16 /*channelId*/, uint8 /*userId*/,
        bool /*voiced*/, bool /*muted*/) { }

    // Called when a game client announced the endpoint it sends voice from
    virtual void OnClientHandshake(VoiceWorldLink const& /*world*/, uint16 /*channelId*/, uint8 /*userId*/,
        boost::asio::ip::udp::endpoint const& /*endpoint*/) { }

    // Called for every voice frame accepted from a member that may speak, after it
    // was relayed (possibly to nobody). payload is the frame without the packet
    // header, as encoded by the game client. Runs for every frame of every
    // speaker, keep it cheap.
    virtual void OnVoicePacket(VoiceWorldLink const& /*world*/, uint16 /*channelId*/, uint8 /*userId*/,
        std::span<uint8 const> /*payload*/) { }

    // Called when the worldserver part of a module sent a message (see
    // VoiceChatMgr::SendModuleMessage). tag names the module and message, scripts
    // ignore tags they do not know. Answer through link. Runs on the network
    // thread of the worldserver connections.
    virtual void OnWorldMessage(VoiceWorldLink const& /*link*/, std::string const& /*tag*/, ByteBuffer& /*data*/) { }

private:
    std::string const _name;
};

#endif
