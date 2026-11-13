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

#include "Chat.h"
#include "CommandScript.h"
#include "RBAC.h"
#include "VoiceChatMgr.h"
#include "World.h"

using namespace Acore::ChatCommands;

class voicechat_commandscript : public CommandScript
{
public:
    voicechat_commandscript() : CommandScript("voicechat_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable voicechatcommandTable =
        {
            { "disconnect", HandleVoiceChatDisconnectCommand, rbac::RBAC_PERM_COMMAND_VOICECHAT_DISCONNECT,
                Console::Yes },
            { "disable",    HandleVoiceChatDisableCommand,    rbac::RBAC_PERM_COMMAND_VOICECHAT_DISABLE,
                Console::Yes },
            { "enable",     HandleVoiceChatEnableCommand,     rbac::RBAC_PERM_COMMAND_VOICECHAT_ENABLE,
                Console::Yes },
            { "stats",      HandleVoiceChatStatsCommand,      rbac::RBAC_PERM_COMMAND_VOICECHAT_STATS,
                Console::Yes },
        };

        static ChatCommandTable commandTable =
        {
            { "voicechat", voicechatcommandTable }
        };
        return commandTable;
    }

    static bool HandleVoiceChatDisconnectCommand(ChatHandler* handler)
    {
        if (!sVoiceChatMgr->CanUseVoiceChat())
        {
            handler->SendErrorMessage("Voice Chat is disabled or the voice chat server is not connected!");
            return false;
        }

        sVoiceChatMgr->DisconnectSocket();
        handler->PSendSysMessage("Voice Chat server disconnected, reconnecting automatically");
        return true;
    }

    static bool HandleVoiceChatDisableCommand(ChatHandler* handler)
    {
        if (!sVoiceChatMgr->IsEnabled())
        {
            handler->PSendSysMessage("Voice Chat is already disabled");
            return true;
        }

        // VoiceChatMgr follows the config value on its next update
        sWorld->setBoolConfig(CONFIG_VOICE_CHAT_ENABLED, false);
        handler->PSendSysMessage("Voice Chat disabled!");
        return true;
    }

    static bool HandleVoiceChatEnableCommand(ChatHandler* handler)
    {
        if (sVoiceChatMgr->IsEnabled())
        {
            handler->PSendSysMessage("Voice Chat is already enabled");
            return true;
        }

        // VoiceChatMgr follows the config value on its next update
        sWorld->setBoolConfig(CONFIG_VOICE_CHAT_ENABLED, true);
        handler->PSendSysMessage("Voice Chat enabled!");
        return true;
    }

    static bool HandleVoiceChatStatsCommand(ChatHandler* handler)
    {
        if (!sVoiceChatMgr->IsEnabled())
        {
            handler->SendErrorMessage("Voice Chat is disabled");
            return false;
        }

        if (!sVoiceChatMgr->CanUseVoiceChat())
            handler->PSendSysMessage("Voice Chat server is not connected");

        VoiceChatStatistics stats = sVoiceChatMgr->GetStatistics();
        handler->PSendSysMessage(
            "Voice Chat: channels: {}, active users: {}, voice chat enabled: {}, microphone enabled: {}",
            stats.Channels, stats.ActiveUsers, stats.TotalVoiceChatEnabled, stats.TotalVoiceMicEnabled);
        return true;
    }
};

void AddSC_voicechat_commandscript()
{
    new voicechat_commandscript();
}
