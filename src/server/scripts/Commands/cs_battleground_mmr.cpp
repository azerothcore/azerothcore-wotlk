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
#include "ScriptMgr.h"
#include "BattlegroundMMR.h"

using namespace Acore::ChatCommands;

class battleground_mmr_commandscript : public CommandScript
{
public:
    battleground_mmr_commandscript() : CommandScript("battleground_mmr_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable bgMMRCommandTable =
        {
            { "info",    HandleBGMMRInfoCommand,    SEC_PLAYER, Console::No },
            { "set",     HandleBGMMRSetCommand,     SEC_ADMINISTRATOR, Console::No },
            { "reset",   HandleBGMMRResetCommand,   SEC_ADMINISTRATOR, Console::No },
        };

        static ChatCommandTable commandTable =
        {
            { "bgmmr", bgMMRCommandTable },
        };

        return commandTable;
    }

    static bool HandleBGMMRInfoCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!sBattlegroundMMRMgr->IsEnabled())
        {
            handler->SendSysMessage("Battleground MMR system is disabled.");
            return true;
        }

        Player* target = player ? player->GetConnectedPlayer() : handler->getSelectedPlayerOrSelf();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        // Query directly from database (no cache)
        float rating = sBattlegroundMMRMgr->GetPlayerMMR(target);
        float gearScore = sBattlegroundMMRMgr->GetPlayerGearScore(target);
        float combinedScore = sBattlegroundMMRMgr->GetPlayerCombinedScore(target);
        
        handler->PSendSysMessage("Battleground MMR Info for {}:", target->GetName());
        handler->PSendSysMessage("Rating: {:.2f}", rating);
        handler->PSendSysMessage("Gear Score: {:.2f}", gearScore);
        handler->PSendSysMessage("Combined Score: {:.2f}", combinedScore);
        
        return true;
    }

    static bool HandleBGMMRSetCommand(ChatHandler* handler, Optional<PlayerIdentifier> player, float rating)
    {
        if (!sBattlegroundMMRMgr->IsEnabled())
        {
            handler->SendSysMessage("Battleground MMR system is disabled.");
            return true;
        }

        Player* target = player ? player->GetConnectedPlayer() : handler->getSelectedPlayerOrSelf();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        // Update database directly
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_BG_MMR);
        stmt->SetData(0, rating);
        stmt->SetData(1, 200.0f);  // Reset RD
        stmt->SetData(2, 0.06f);   // Reset volatility
        stmt->SetData(3, sBattlegroundMMRMgr->GetPlayerGearScore(target));
        stmt->SetData(4, 0);       // Don't change matches
        stmt->SetData(5, 0);       // Don't change wins
        stmt->SetData(6, 0);       // Don't change losses
        stmt->SetData(7, target->GetGUID().GetCounter());
        CharacterDatabase.Execute(stmt);
        
        handler->PSendSysMessage("Set {}'s Battleground MMR to {:.2f}", target->GetName(), rating);
        
        return true;
    }

    static bool HandleBGMMRResetCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!sBattlegroundMMRMgr->IsEnabled())
        {
            handler->SendSysMessage("Battleground MMR system is disabled.");
            return true;
        }

        Player* target = player ? player->GetConnectedPlayer() : handler->getSelectedPlayerOrSelf();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        float startingRating = sBattlegroundMMRMgr->GetStartingRating();
        float startingRD = sBattlegroundMMRMgr->GetStartingRD();
        float startingVolatility = sBattlegroundMMRMgr->GetStartingVolatility();
        
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_BG_MMR);
        stmt->SetData(0, startingRating);
        stmt->SetData(1, startingRD);
        stmt->SetData(2, startingVolatility);
        stmt->SetData(3, sBattlegroundMMRMgr->GetPlayerGearScore(target));
        stmt->SetData(4, 0);
        stmt->SetData(5, 0);
        stmt->SetData(6, 0);
        stmt->SetData(7, target->GetGUID().GetCounter());
        CharacterDatabase.Execute(stmt);
        
        handler->PSendSysMessage("Reset {}'s Battleground MMR to default values", target->GetName());
        
        return true;
    }
};

void AddSC_battleground_mmr_commandscript()
{
    new battleground_mmr_commandscript();
}
