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

#include "Chat.h"
#include "CommandScript.h"
#include "VoiceChatChannel.h"
#include "VoiceChatMgr.h"

using namespace Acore::ChatCommands;

class voicechat_commandscript : public CommandScript
{
public:
    voicechat_commandscript() : CommandScript("voicechat_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable voicechatcommandTable =
        {
            { "disconnect", HandleVoiceChatDisconnectCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "disable",    HandleVoiceChatDisableCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "enable",     HandleVoiceChatEnableCommand,     SEC_ADMINISTRATOR, Console::Yes },
            { "stats",      HandleVoiceChatStatsCommand,      SEC_ADMINISTRATOR, Console::Yes },
        };

        static ChatCommandTable commandTable =
        {
            { "voicechat", voicechatcommandTable }
        };
        return commandTable;
    }

    static bool HandleVoiceChatDisconnectCommand(ChatHandler* handler)
    {
        if (!sVoiceChatMgr.CanUseVoiceChat())
        {
            handler->PSendSysMessage("Voice Chat is disabled or Voice Chat server is not connected!");
            return false;
        }

        sVoiceChatMgr.SocketDisconnected();

        int32 reconnectAttempts = sVoiceChatMgr.GetReconnectAttempts();
        if (reconnectAttempts == 0)
            handler->PSendSysMessage("Voice Chat server disconnected!");
        else if (reconnectAttempts < 0)
            handler->PSendSysMessage("Voice Chat server disconnected, reconnect enabled (infinite attempts)");
        else if (reconnectAttempts > 0)
            handler->PSendSysMessage("Voice Chat server disconnected, reconnect enabled ({} attempts)", reconnectAttempts);
        return true;
    }

    static bool HandleVoiceChatDisableCommand(ChatHandler* handler)
    {
        if (!sVoiceChatMgr.IsEnabled())
        {
            handler->PSendSysMessage("Voice Chat is already disabled");
            return true;
        }

        sVoiceChatMgr.DisableVoiceChat();
        handler->PSendSysMessage("Voice Chat disabled!");
        return true;
    }

    static bool HandleVoiceChatEnableCommand(ChatHandler* handler)
    {
        if (sVoiceChatMgr.IsEnabled())
        {
            handler->PSendSysMessage("Voice Chat is already enabled");
            return true;
        }

        sVoiceChatMgr.EnableVoiceChat();
        handler->PSendSysMessage("Voice Chat enabled!");
        return true;
    }

    static bool HandleVoiceChatStatsCommand(ChatHandler* handler)
    {
        if (!sVoiceChatMgr.IsEnabled())
        {
            handler->PSendSysMessage("Voice Chat is disabled");
            return false;
        }

        VoiceChatStatistics stats = sVoiceChatMgr.GetStatistics();
        handler->PSendSysMessage("Voice Chat: channels: {}, active users: {}, voice chat enabled: {}, microphone enabled: {}", stats.Channels, stats.ActiveUsers, stats.TotalVoiceChatEnabled, stats.TotalVoiceMicEnabled);
        return true;
    }

};

void AddSC_voicechat_commandscript()
{
    new voicechat_commandscript();
}
