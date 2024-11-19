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

/* ScriptData
Name: achievement_commandscript
%Complete: 100
Comment: All achievement related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"

using namespace Acore::ChatCommands;

class achievement_commandscript : public CommandScript
{
public:
    achievement_commandscript() : CommandScript("achievement_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable achievementCommandTable =
        {
            { "add",      HandleAchievementAddCommand,      SEC_GAMEMASTER,    Console::No },
            { "checkall", HandleAchievementCheckAllCommand, SEC_ADMINISTRATOR, Console::Yes }
        };
        static ChatCommandTable commandTable =
        {
            { "achievement", achievementCommandTable }
        };
        return commandTable;
    }

    static bool HandleAchievementAddCommand(ChatHandler* handler, AchievementEntry const* achievementEntry)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }
        target->CompletedAchievement(achievementEntry);

        return true;
    }

    static bool HandleAchievementCheckAllCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
        {
            player = PlayerIdentifier::FromTarget(handler);
        }

        if (!player)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        if (player->IsConnected())
        {
            if (Player* target = player->GetConnectedPlayer())
                target->CheckAllAchievementCriteria();
        }
        else
        {
            auto* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_CHECK_ACHIEVS));
            stmt->SetData(1, player->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);
        }

        return true;
    }
};

void AddSC_achievement_commandscript()
{
    new achievement_commandscript();
}
