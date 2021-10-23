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

#include "AccountMgr.h"
#include "ArenaSpectator.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class spectator_commandscript : public CommandScript
{
public:
    spectator_commandscript() : CommandScript("spectator_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable spectatorCommandTable =
        {
            { "version",        SEC_PLAYER,        false, &HandleSpectatorVersionCommand,                  "" },
            { "reset",          SEC_PLAYER,        false, &HandleSpectatorResetCommand,                    "" },
            { "spectate",       SEC_PLAYER,        false, &HandleSpectatorSpectateCommand,                 "" },
            { "watch",          SEC_PLAYER,        false, &HandleSpectatorWatchCommand,                    "" },
            { "leave",          SEC_PLAYER,        false, &HandleSpectatorLeaveCommand,                    "" },
            { "",               SEC_PLAYER,        false, &HandleSpectatorCommand,                         "" }
        };
        static ChatCommandTable commandTable =
        {
            { "spect",          SEC_PLAYER,        false, nullptr,                                         "", spectatorCommandTable }
        };
        return commandTable;
    }

    static bool HandleSpectatorCommand(ChatHandler* handler, char const*  /*args*/)
    {
        handler->PSendSysMessage("Incorrect syntax.");
        handler->PSendSysMessage("Command has subcommands:");
        handler->PSendSysMessage("   spectate");
        handler->PSendSysMessage("   leave");
        return true;
    }

    static bool HandleSpectatorVersionCommand(ChatHandler* handler, char const* args)
    {
        if (atoi(args) < SPECTATOR_ADDON_VERSION)
            ArenaSpectator::SendCommand(handler->GetSession()->GetPlayer(), "%sOUTDATED", SPECTATOR_ADDON_PREFIX);
        return true;
    }

    static bool HandleSpectatorResetCommand(ChatHandler* handler, char const*  /*args*/)
    {
        Player* p = handler->GetSession()->GetPlayer();
        if (!p->IsSpectator())
            return true;
        ArenaSpectator::HandleResetCommand(p);
        return true;
    }

    static bool HandleSpectatorLeaveCommand(ChatHandler* handler, char const*  /*args*/)
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

    static bool HandleSpectatorSpectateCommand(ChatHandler* handler, char const* args)
    {
        if (!ArenaSpectator::HandleSpectatorSpectateCommand(handler, args))
            return false;

        return true;
    }

    static bool HandleSpectatorWatchCommand(ChatHandler* handler, char const* args)
    {
        if (!ArenaSpectator::HandleSpectatorWatchCommand(handler, args))
            return false;

        return true;
    }
};

void AddSC_spectator_commandscript()
{
    new spectator_commandscript();
}
