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

        // Read from player object cache - no DB queries!
        BattlegroundRatingData bgRating = target->GetBGRating();
        float gearScore = sBattlegroundMMRMgr->GetPlayerGearScore(target);
        float combinedScore = sBattlegroundMMRMgr->GetPlayerCombinedScore(target);
        
        handler->PSendSysMessage("Battleground MMR Info for {}:", target->GetName());
        handler->PSendSysMessage("Rating: {:.2f} (RD: {:.2f}, Volatility: {:.4f})", 
                                 bgRating.rating, bgRating.ratingDeviation, bgRating.volatility);
        handler->PSendSysMessage("Record: {} wins, {} losses ({} total matches)", 
                                 bgRating.wins, bgRating.losses, bgRating.matchesPlayed);
        handler->PSendSysMessage("Gear Score: {:.2f}", gearScore);
        handler->PSendSysMessage("Combined Score: {:.2f}", combinedScore);
        
        if (bgRating.matchesPlayed > 0)
        {
            float winRate = (static_cast<float>(bgRating.wins) / bgRating.matchesPlayed) * 100.0f;
            handler->PSendSysMessage("Win Rate: {:.1f}%", winRate);
        }
        
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

        // Update player object cache
        BattlegroundRatingData bgRating = target->GetBGRating();
        bgRating.rating = rating;
        bgRating.ratingDeviation = 200.0f;  // Reset RD
        bgRating.volatility = 0.06f;        // Reset volatility
        target->SetBGRating(bgRating);
        
        // Force save to DB immediately
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_BG_MMR);
        stmt->SetData(0, target->GetGUID().GetCounter());
        stmt->SetData(1, bgRating.rating);
        stmt->SetData(2, bgRating.ratingDeviation);
        stmt->SetData(3, bgRating.volatility);
        stmt->SetData(4, bgRating.matchesPlayed);
        stmt->SetData(5, bgRating.wins);
        stmt->SetData(6, bgRating.losses);
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

        // Reset to default values in player object
        BattlegroundRatingData bgRating;
        bgRating.rating = sBattlegroundMMRMgr->GetStartingRating();
        bgRating.ratingDeviation = sBattlegroundMMRMgr->GetStartingRD();
        bgRating.volatility = sBattlegroundMMRMgr->GetStartingVolatility();
        bgRating.matchesPlayed = 0;
        bgRating.wins = 0;
        bgRating.losses = 0;
        bgRating.loaded = true;
        target->SetBGRating(bgRating);
        
        // Delete from DB (will be recreated on first match if needed)
        CharacterDatabase.Execute("DELETE FROM character_battleground_rating WHERE guid = {}", 
                                   target->GetGUID().GetCounter());
        CharacterDatabase.Execute("DELETE FROM character_battleground_rating_history WHERE guid = {}", 
                                   target->GetGUID().GetCounter());
        
        handler->PSendSysMessage("Reset {}'s Battleground MMR to default values", target->GetName());
        
        return true;
    }
};

void AddSC_battleground_mmr_commandscript()
{
    new battleground_mmr_commandscript();
}
