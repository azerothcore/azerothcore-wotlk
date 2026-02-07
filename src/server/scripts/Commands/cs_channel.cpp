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

#include "ChannelMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Language.h"
#include "Player.h"
#include "RBAC.h"

using namespace Acore::ChatCommands;

class channel_commandscript : public CommandScript
{
public:
    channel_commandscript() : CommandScript("channel_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable channelSetCommandTable =
        {
            { "ownership", HandleChannelSetOwnershipCommand, rbac::RBAC_PERM_COMMAND_CHANNEL_SET_OWNERSHIP, Console::Yes }
        };

        static ChatCommandTable channelCommandTable =
        {
            { "set", channelSetCommandTable, rbac::RBAC_PERM_COMMAND_CHANNEL_SET }
        };

        static ChatCommandTable commandTable =
        {
            { "channel", channelCommandTable, rbac::RBAC_PERM_COMMAND_CHANNEL }
        };

        return commandTable;
    }

    static bool HandleChannelSetOwnershipCommand(ChatHandler* handler, std::string channelName, bool ownership)
    {
        uint32 flags = 0;
        if (!ownership)
            flags |= CHANNEL_RIGHT_NO_OWNERSHIP;

        ChannelMgr::SetChannelRightsFor(channelName, flags, 0, "", "", std::set<uint32>());

        handler->PSendSysMessage("Channel '%s' ownership %s.", channelName.c_str(), ownership ? "enabled" : "disabled");
        return true;
    }
};

void AddSC_channel_commandscript()
{
    new channel_commandscript();
}
