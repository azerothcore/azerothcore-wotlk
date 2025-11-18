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

#include "CommandScript.h"
#include "PlayerCommand.h"

using namespace Acore::ChatCommands;

class player_commandscript : public CommandScript
{
public:
    player_commandscript() : CommandScript("player_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable playerCommandTable =
        {
            { "learn",   HandlePlayerLearnCommand,   SEC_GAMEMASTER, Console::Yes },
            { "unlearn", HandlePlayerUnLearnCommand, SEC_GAMEMASTER, Console::Yes }
        };

        static ChatCommandTable commandTable =
        {
            { "player", playerCommandTable }
        };
        return commandTable;
    }

    static bool HandlePlayerLearnCommand(ChatHandler* handler, Optional<PlayerIdentifier> player, SpellInfo const* spell, Optional<EXACT_SEQUENCE("all")> allRanks)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        if (!player || !player->IsConnected())
            return false;

        Player* targetPlayer = player->GetConnectedPlayer();
        return Acore::PlayerCommand::HandleLearnSpellCommand(handler, targetPlayer, spell, allRanks);
    }

    static bool HandlePlayerUnLearnCommand(ChatHandler* handler, Optional<PlayerIdentifier> player, SpellInfo const* spell, Optional<EXACT_SEQUENCE("all")> allRanks)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        if (!player || !player->IsConnected())
            return false;

        Player* targetPlayer = player->GetConnectedPlayer();
        return Acore::PlayerCommand::HandleUnlearnSpellCommand(handler, targetPlayer, spell, allRanks);
    }
};

void AddSC_player_commandscript()
{
    new player_commandscript();
}
