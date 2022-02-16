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
#include "Battleground.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Acore::ChatCommands;

class bg_commandscript : public CommandScript
{
public:
    bg_commandscript() : CommandScript("bg_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable bgCommandTable =
        {
            { "start",      HandleBgStartCommand,       SEC_ADMINISTRATOR,  Console::No },
            { "stop",       HandleBgStopCommand,        SEC_ADMINISTRATOR,  Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "bg", bgCommandTable }
        };

        return commandTable;
    }

    static bool HandleBgStartCommand(ChatHandler* handler, Optional<uint32> time)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
        {
            return false;
        }

        Battleground* bg = player->GetBattleground();
        if (bg)
        {
            handler->SendSysMessage("> You are not on the Battleground");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 startTime = 5;

        if (time)
        {
            startTime = *time;
        }

        bg->SetStartDelayTime(startTime);

        return true;
    };

    static bool HandleBgStopCommand(ChatHandler* handler, Optional<uint8> winner)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
        {
            return false;
        }

        Battleground* bg = player->GetBattleground();
        if (bg)
        {
            handler->SendSysMessage("> You are not on the Battleground");
            handler->SetSentErrorMessage(true);
            return false;
        }

        TeamId winnerTeam = player->GetTeamId();

        if (winner)
        {
            winnerTeam = static_cast<TeamId>(*winner);
        }

        bg->EndBattleground(winnerTeam);

        return true;
    };
};

void AddSC_bg_commandscript()
{
    new bg_commandscript();
}
