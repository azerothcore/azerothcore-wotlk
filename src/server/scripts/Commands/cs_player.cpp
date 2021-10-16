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
#include "Language.h"
#include "Player.h"
#include "PlayerCommand.h"
#include "ScriptMgr.h"

class player_commandscript : public CommandScript, public PlayerCommand
{
public:
    player_commandscript() : CommandScript("player_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> playerCommandTable =
        {
            { "learn",               SEC_GAMEMASTER,  true, &HandlePlayerLearnCommand,           "" },
            { "unlearn",             SEC_GAMEMASTER,  true, &HandlePlayerUnLearnCommand,         "" }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "player",              SEC_GAMEMASTER,  true, nullptr,                             "", playerCommandTable }
        };
        return commandTable;
    }

    static bool HandlePlayerLearnCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* playerName = strtok((char*)args, " ");
        char* spellId = strtok(nullptr, " ");
        char const* all = strtok(nullptr, " ");
        Player* targetPlayer = FindPlayer(handler, playerName);
        if (!spellId || !targetPlayer)
        {
            return false;
        }

        uint32 spell = handler->extractSpellIdFromLink(spellId);

        if (!spell)
        {
            return false;
        }

        return Learn(handler, targetPlayer, spell, all);
    }

    static bool HandlePlayerUnLearnCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* playerName = strtok((char*)args, " ");
        char* spellId = strtok(nullptr, " ");
        char const* all = strtok(nullptr, " ");
        Player* targetPlayer = FindPlayer(handler, playerName);

        if (!spellId || !targetPlayer)
        {
            return false;
        }

        uint32 spell = handler->extractSpellIdFromLink(spellId);

        if (!spell)
        {
            return false;
        }

        return UnLearn(handler, targetPlayer, spell, all);
    }

private:
    static Player* FindPlayer(ChatHandler* handler, char* playerName)
    {
        if (!playerName)
            return nullptr;

        Player* targetPlayer;
        if (!handler->extractPlayerTarget(playerName, &targetPlayer))
            return nullptr;

        if (!targetPlayer)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return nullptr;
        }

        return targetPlayer;
    }
};

void AddSC_player_commandscript()
{
    new player_commandscript();
}
