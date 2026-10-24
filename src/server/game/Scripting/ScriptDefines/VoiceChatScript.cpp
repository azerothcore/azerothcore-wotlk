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

#include "VoiceChatScript.h"
#include "ByteBuffer.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnVoiceServerConnected()
{
    CALL_ENABLED_HOOKS(VoiceChatScript, VOICECHATHOOK_ON_VOICE_SERVER_CONNECTED, script->OnVoiceServerConnected());
}

void ScriptMgr::OnVoiceServerDisconnected()
{
    CALL_ENABLED_HOOKS(VoiceChatScript, VOICECHATHOOK_ON_VOICE_SERVER_DISCONNECTED,
        script->OnVoiceServerDisconnected());
}

void ScriptMgr::OnVoiceServerModuleMessage(std::string const& tag, ByteBuffer& data)
{
    // every script reads the message from the start
    auto const& scripts = ScriptRegistry<VoiceChatScript>::EnabledHooks[VOICECHATHOOK_ON_VOICE_SERVER_MODULE_MESSAGE];
    for (auto const& script : scripts)
    {
        data.rpos(0);
        script->OnVoiceServerModuleMessage(tag, data);
    }
}

VoiceChatScript::VoiceChatScript(char const* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, VOICECHATHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < VOICECHATHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<VoiceChatScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<VoiceChatScript>;
