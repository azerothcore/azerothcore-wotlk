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

#ifndef SCRIPT_OBJECT_VOICE_CHAT_SCRIPT_H_
#define SCRIPT_OBJECT_VOICE_CHAT_SCRIPT_H_

#include "ScriptObject.h"
#include <string>
#include <vector>

class ByteBuffer;

enum VoiceChatHook
{
    VOICECHATHOOK_ON_VOICE_SERVER_CONNECTED,
    VOICECHATHOOK_ON_VOICE_SERVER_DISCONNECTED,
    VOICECHATHOOK_ON_VOICE_SERVER_MODULE_MESSAGE,
    VOICECHATHOOK_END
};

// Hooks for the connection to the voiceserver, all called on the world thread
class VoiceChatScript : public ScriptObject
{
protected:
    VoiceChatScript(char const* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    /**
     * @brief Called when the connection to the voiceserver was (re)established,
     * after the voice channels were restored on it
     */
    virtual void OnVoiceServerConnected() { }

    /**
     * @brief Called when the connection to the voiceserver was lost or voice chat was
     * disabled. The voiceserver drops everything of this worldserver then, state the
     * voiceserver part of a module kept for it is gone as well.
     */
    virtual void OnVoiceServerDisconnected() { }

    /**
     * @brief Called when the voiceserver part of a module sent a message, the
     * counterpart of VoiceChatMgr::SendModuleMessage
     *
     * @param tag Names the module and message, scripts ignore tags they do not know
     * @param data The message, read like a packet
     */
    virtual void OnVoiceServerModuleMessage(std::string const& /*tag*/, ByteBuffer& /*data*/) { }
};

#endif
