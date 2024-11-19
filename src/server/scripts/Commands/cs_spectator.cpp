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

#include "ArenaSpectator.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"

using namespace Acore::ChatCommands;

class spectator_commandscript : public CommandScript
{
public:
    spectator_commandscript() : CommandScript("spectator_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable spectatorCommandTable =
        {
            { "version",  HandleSpectatorVersionCommand,  SEC_PLAYER, Console::No },
            { "reset",    HandleSpectatorResetCommand,    SEC_PLAYER, Console::No },
            { "spectate", HandleSpectatorSpectateCommand, SEC_PLAYER, Console::No },
            { "watch",    HandleSpectatorWatchCommand,    SEC_PLAYER, Console::No },
            { "leave",    HandleSpectatorLeaveCommand,    SEC_PLAYER, Console::No },
            { "",         HandleSpectatorCommand,         SEC_PLAYER, Console::No }
        };
        static ChatCommandTable commandTable =
        {
            { "spect", spectatorCommandTable }
        };
        return commandTable;
    }

    static bool HandleSpectatorCommand(ChatHandler* handler)
    {
        handler->PSendSysMessage("Incorrect syntax.");
        handler->PSendSysMessage("Command has subcommands:");
        handler->PSendSysMessage("   spectate");
        handler->PSendSysMessage("   leave");
        return true;
    }

    static bool HandleSpectatorVersionCommand(ChatHandler* handler, uint16 version)
    {
        if (version < SPECTATOR_ADDON_VERSION)
            ArenaSpectator::SendCommand(handler->GetSession()->GetPlayer(), "%sOUTDATED", SPECTATOR_ADDON_PREFIX);
        return true;
    }

    static bool HandleSpectatorResetCommand(ChatHandler* handler)
    {
        Player* p = handler->GetSession()->GetPlayer();
        if (!p->IsSpectator())
            return true;
        ArenaSpectator::HandleResetCommand(p);
        return true;
    }

    static bool HandleSpectatorLeaveCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player->IsSpectator() || !player->FindMap() || !player->FindMap()->IsBattleArena())
        {
            handler->SendSysMessage("You are not a spectator.");
            return true;
        }

        //player->SetIsSpectator(false);
        player->TeleportToEntryPoint();
        return true;
    }

    static bool HandleSpectatorSpectateCommand(ChatHandler* handler, std::string const& name)
    {
        if (!ArenaSpectator::HandleSpectatorSpectateCommand(handler, name))
            return false;

        return true;
    }

    static bool HandleSpectatorWatchCommand(ChatHandler* handler, std::string const& name)
    {
        if (!ArenaSpectator::HandleSpectatorWatchCommand(handler, name))
            return false;

        return true;
    }
};

void AddSC_spectator_commandscript()
{
    new spectator_commandscript();
}
