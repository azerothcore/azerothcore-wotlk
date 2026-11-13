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

#ifndef _VOICE_WORLD_LINK_H_
#define _VOICE_WORLD_LINK_H_

#include "ByteBuffer.h"
#include "Define.h"
#include <memory>
#include <string>

class InternalSession;

// A worldserver connection. Several worldservers (realms) may share one voiceserver,
// each numbering its voice channels on its own, so a channel id is only unique
// together with the worldserver it belongs to. Scripts may keep a link to answer
// at any later time, from any thread. It stays safe to use after the connection
// closed, sending fails then.
class VoiceWorldLink
{
public:
    VoiceWorldLink() = default;
    VoiceWorldLink(std::weak_ptr<InternalSession> session, uint32 id) : _session(std::move(session)), _id(id) { }

    // unique per worldserver connection and never reused while the voiceserver runs.
    // A worldserver that reconnects gets a new id and creates its channels again
    [[nodiscard]] uint32 GetId() const { return _id; }

    // queues a message for the worldserver part of the module, which receives it
    // through VoiceChatScript::OnVoiceServerModuleMessage. Returns false if the
    // connection is gone or the message does not fit an internal packet.
    bool SendModuleMessage(std::string const& tag, ByteBuffer const& data) const;

    [[nodiscard]] bool IsConnected() const;

private:
    std::weak_ptr<InternalSession> _session;
    uint32 _id = 0;
};

#endif
