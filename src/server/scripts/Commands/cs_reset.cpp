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
Name: reset_commandscript
%Complete: 100
Comment: All reset related commands
Category: commandscripts
EndScriptData */

#include "AchievementMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Language.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Acore::ChatCommands;

class reset_commandscript : public CommandScript
{
public:

    reset_commandscript() : CommandScript("reset_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable resetItemsCommandTable =
        {
            { "equipped",       HandleResetItemsEquippedCommand,             SEC_ADMINISTRATOR, Console::Yes },
            { "bags",           HandleResetItemsInBagsCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "bank",           HandleResetItemsInBankCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "keyring",        HandleResetItemsKeyringCommand,             SEC_ADMINISTRATOR, Console::Yes },
            { "currency",       HandleResetItemsInCurrenciesListCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "vendor_buyback", HandleResetItemsInVendorBuyBackTabCommand,  SEC_ADMINISTRATOR, Console::Yes },
            { "all",            HandleResetItemsAllCommand,                 SEC_ADMINISTRATOR, Console::Yes },
            { "allbags",        HandleResetItemsAllAndDeleteBagsCommand,    SEC_ADMINISTRATOR, Console::Yes },
        };
        static ChatCommandTable resetCommandTable =
        {
            { "achievements",   HandleResetAchievementsCommand, SEC_CONSOLE,       Console::Yes },
            { "honor",          HandleResetHonorCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "level",          HandleResetLevelCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "spells",         HandleResetSpellsCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "stats",          HandleResetStatsCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "talents",        HandleResetTalentsCommand,      SEC_ADMINISTRATOR, Console::Yes },
            { "items",          resetItemsCommandTable                                          },
            { "all",            HandleResetAllCommand,          SEC_CONSOLE,       Console::Yes }
        };
        static ChatCommandTable commandTable =
        {
            { "reset", resetCommandTable }
        };
        return commandTable;
    }

    static bool HandleResetAchievementsCommand(ChatHandler*, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (playerTarget)
            playerTarget->ResetAchievements();
        else
            AchievementMgr::DeleteFromDB(target->GetGUID().GetCounter());

        return true;
    }

    static bool HandleResetHonorCommand(ChatHandler*, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        playerTarget->SetHonorPoints(0);
        playerTarget->SetUInt32Value(PLAYER_FIELD_KILLS, 0);
        playerTarget->SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 0);
        playerTarget->SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
        playerTarget->SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);
        playerTarget->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL);

        return true;
    }

    static bool HandleResetStatsOrLevelHelper(Player* player)
    {
        ChrClassesEntry const* classEntry = sChrClassesStore.LookupEntry(player->getClass());
        if (!classEntry)
        {
            LOG_ERROR("dbc", "Class {} not found in DBC (Wrong DBC files?)", player->getClass());
            return false;
        }

        uint8 powerType = classEntry->powerType;

        // reset m_form if no aura
        if (!player->HasAuraType(SPELL_AURA_MOD_SHAPESHIFT))
            player->SetShapeshiftForm(FORM_NONE);

        player->SetFactionForRace(player->getRace());

        player->SetUInt32Value(UNIT_FIELD_BYTES_0, ((player->getRace()) | (player->getClass() << 8) | (player->getGender() << 16) | (powerType << 24)));

        // reset only if player not in some form;
        if (player->GetShapeshiftForm() == FORM_NONE)
            player->InitDisplayIds();

        player->SetByteValue(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_PVP);

        player->ReplaceAllUnitFlags(UNIT_FLAG_PLAYER_CONTROLLED);

        //-1 is default value
        player->SetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, uint32(-1));
        return true;
    }

    static bool HandleResetLevelCommand(ChatHandler*, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (!HandleResetStatsOrLevelHelper(playerTarget))
            return false;

        uint8 oldLevel = playerTarget->GetLevel();

        // set starting level
        uint32 startLevel = !playerTarget->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT)
                            ? sWorld->getIntConfig(CONFIG_START_PLAYER_LEVEL)
                            : sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL);

        playerTarget->_ApplyAllLevelScaleItemMods(false);
        playerTarget->SetLevel(startLevel);
        playerTarget->InitRunes();
        playerTarget->InitStatsForLevel(true);
        playerTarget->InitTaxiNodesForLevel();
        playerTarget->InitGlyphsForLevel();
        playerTarget->InitTalentForLevel();
        playerTarget->SetUInt32Value(PLAYER_XP, 0);

        playerTarget->_ApplyAllLevelScaleItemMods(true);

        // reset level for pet
        if (Pet* pet = playerTarget->GetPet())
            pet->SynchronizeLevelWithOwner();

        sScriptMgr->OnPlayerLevelChanged(playerTarget, oldLevel);

        return true;
    }

    static bool HandleResetSpellsCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (target)
        {
            playerTarget->resetSpells(/* bool myClassOnly */);

            ChatHandler(playerTarget->GetSession()).SendSysMessage(LANG_RESET_SPELLS);
            if (!handler->GetSession() || handler->GetSession()->GetPlayer() != playerTarget)
                handler->PSendSysMessage(LANG_RESET_SPELLS_ONLINE, handler->GetNameLink(playerTarget).c_str());
        }
        else
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_RESET_SPELLS));
            stmt->SetData(1, playerTarget->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);

            handler->PSendSysMessage(LANG_RESET_SPELLS_OFFLINE, target->GetName());
        }

        return true;
    }

    static bool HandleResetStatsCommand(ChatHandler*, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (!HandleResetStatsOrLevelHelper(playerTarget))
            return false;

        playerTarget->InitRunes();
        playerTarget->InitStatsForLevel(true);
        playerTarget->InitTaxiNodesForLevel();
        playerTarget->InitGlyphsForLevel();
        playerTarget->InitTalentForLevel();

        return true;
    }

    static bool HandleResetTalentsCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = nullptr;

        if (target)
        {
            targetPlayer = target->GetConnectedPlayer();
        }
        else
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        if (targetPlayer)
        {
            targetPlayer->resetTalents(true);
            targetPlayer->SendTalentsInfoData(false);
            ChatHandler(targetPlayer->GetSession()).SendSysMessage(LANG_RESET_TALENTS);
            if (!handler->GetSession() || handler->GetSession()->GetPlayer() != targetPlayer)
                handler->PSendSysMessage(LANG_RESET_TALENTS_ONLINE, handler->GetNameLink(targetPlayer).c_str());

            Pet* pet = targetPlayer->GetPet();
            Pet::resetTalentsForAllPetsOf(targetPlayer, pet);
            if (pet)
                targetPlayer->SendTalentsInfoData(true);
            return true;
        }
        else
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_RESET_TALENTS | AT_LOGIN_RESET_PET_TALENTS));
            stmt->SetData(1, target->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);

            std::string nameLink = handler->playerLink(target->GetName());
            handler->PSendSysMessage(LANG_RESET_TALENTS_OFFLINE, nameLink.c_str());
            return true;
        }
    }

    static bool HandleResetAllCommand(ChatHandler* handler, std::string_view caseName)
    {
        AtLoginFlags atLogin;

        // Command specially created as single command to prevent using short case names
        if (caseName == "spells")
        {
            atLogin = AT_LOGIN_RESET_SPELLS;
            sWorld->SendWorldText(LANG_RESETALL_SPELLS);
            if (!handler->GetSession())
                handler->SendSysMessage(LANG_RESETALL_SPELLS);
        }
        else if (caseName == "talents")
        {
            atLogin = AtLoginFlags(AT_LOGIN_RESET_TALENTS | AT_LOGIN_RESET_PET_TALENTS);
            sWorld->SendWorldText(LANG_RESETALL_TALENTS);
            if (!handler->GetSession())
                handler->SendSysMessage(LANG_RESETALL_TALENTS);
        }
        else
        {
            handler->SendErrorMessage(LANG_RESETALL_UNKNOWN_CASE, caseName);
            return false;
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ALL_AT_LOGIN_FLAGS);
        stmt->SetData(0, uint16(atLogin));
        CharacterDatabase.Execute(stmt);

        sWorld->DoForAllOnlinePlayers([&] (Player* player){
            player->SetAtLoginFlag(atLogin);
        });

        return true;
    }

    static bool HandleResetItemsEquippedCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = GetPlayerFromIdentifierOrSelectedTarget(handler, target);

        if (!targetPlayer)
        {
            return false;
        }
        else
        {
            int16 deletedItemsCount = ResetItemsEquipped(targetPlayer);
            handler->PSendSysMessage(LANG_COMMAND_RESET_ITEMS_EQUIPPED, deletedItemsCount, handler->GetNameLink(targetPlayer).c_str());
        }

        return true;
    }

    static bool HandleResetItemsInBagsCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = GetPlayerFromIdentifierOrSelectedTarget(handler, target);

        if (!targetPlayer)
        {
            return false;
        }
        else
        {
            int16 deletedItemsCount = ResetItemsInBags(targetPlayer);
            handler->PSendSysMessage(LANG_COMMAND_RESET_ITEMS_BAGS, deletedItemsCount, handler->GetNameLink(targetPlayer).c_str());
        }

        return true;
    }

    static bool HandleResetItemsKeyringCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = GetPlayerFromIdentifierOrSelectedTarget(handler, target);

        if (!targetPlayer)
        {
            return false;
        }
        else
        {
            int16 deletedItemsCount = ResetItemsInKeyring(targetPlayer);
            handler->PSendSysMessage(LANG_COMMAND_RESET_ITEMS_KEYRING, deletedItemsCount, handler->GetNameLink(targetPlayer).c_str());
        }

        return true;
    }

    static bool HandleResetItemsInCurrenciesListCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = GetPlayerFromIdentifierOrSelectedTarget(handler, target);

        if (!targetPlayer)
        {
            return false;
        }
        else
        {
            int16 deletedItemsCount = ResetItemsInCurrenciesList(targetPlayer);
            handler->PSendSysMessage(LANG_COMMAND_RESET_ITEMS_CURRENCY, deletedItemsCount, handler->GetNameLink(targetPlayer).c_str());
        }

        return true;
    }

    static bool HandleResetItemsInBankCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = GetPlayerFromIdentifierOrSelectedTarget(handler, target);

        if (!targetPlayer)
        {
            return false;
        }
        else
        {
            int16 deletedItemsCount = ResetItemsInBank(targetPlayer);
            handler->PSendSysMessage(LANG_COMMAND_RESET_ITEMS_BANK, deletedItemsCount, handler->GetNameLink(targetPlayer).c_str());
        }

        return true;
    }

    static bool HandleResetItemsInVendorBuyBackTabCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = GetPlayerFromIdentifierOrSelectedTarget(handler, target);

        if (!targetPlayer)
        {
            return false;
        }
        else
        {
            int16 deletedItemsCount = ResetItemsInVendorBuyBackTab(targetPlayer);
            handler->PSendSysMessage(LANG_COMMAND_RESET_ITEMS_BUYBACK, deletedItemsCount, handler->GetNameLink(targetPlayer).c_str());
        }

        return true;
    }

    static bool HandleResetItemsAllCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = GetPlayerFromIdentifierOrSelectedTarget(handler, target);

        if (!targetPlayer)
        {
            return false;
        }
        else
        {

            // Delete all items destinations
            int16 deletedItemsEquippedCount            = ResetItemsEquipped(targetPlayer);
            int16 deletedItemsInBagsCount             = ResetItemsInBags(targetPlayer);
            int16 deletedItemsInBankCount             = ResetItemsInBank(targetPlayer);
            int16 deletedItemsInKeyringCount          = ResetItemsInKeyring(targetPlayer);
            int16 deletedItemsInCurrenciesListCount   = ResetItemsInCurrenciesList(targetPlayer);
            int16 deletedItemsInVendorBuyBackTabCount = ResetItemsInVendorBuyBackTab(targetPlayer);

            handler->PSendSysMessage(LANG_COMMAND_RESET_ITEMS_ALL, handler->GetNameLink(targetPlayer).c_str(),
                deletedItemsEquippedCount,
                deletedItemsInBagsCount,
                deletedItemsInBankCount,
                deletedItemsInKeyringCount,
                deletedItemsInCurrenciesListCount,
                deletedItemsInVendorBuyBackTabCount);
        }

        return true;
    }

    static bool HandleResetItemsAllAndDeleteBagsCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = GetPlayerFromIdentifierOrSelectedTarget(handler, target);

        if (!targetPlayer)
        {
           return false;
        }
        else
        {

            // Delete all items destinations
            int16 deletedItemsEquippedCount = ResetItemsEquipped(targetPlayer);
            int16 deletedItemsInBagsCount = ResetItemsInBags(targetPlayer);
            int16 deletedItemsInBankCount = ResetItemsInBank(targetPlayer);
            int16 deletedItemsInKeyringCount = ResetItemsInKeyring(targetPlayer);
            int16 deletedItemsInCurrenciesListCount = ResetItemsInCurrenciesList(targetPlayer);
            int16 deletedItemsInVendorBuyBackTabCount = ResetItemsInVendorBuyBackTab(targetPlayer);
            int16 deletedItemsStandardBagsCount = ResetItemsDeleteStandardBags(targetPlayer);
            int16 deletedItemsBankBagsCount = ResetItemsDeleteBankBags(targetPlayer);

            handler->PSendSysMessage(LANG_COMMAND_RESET_ITEMS_ALL_BAGS, handler->GetNameLink(targetPlayer).c_str(),
                deletedItemsEquippedCount,
                deletedItemsInBagsCount,
                deletedItemsInBankCount,
                deletedItemsInKeyringCount,
                deletedItemsInCurrenciesListCount,
                deletedItemsInVendorBuyBackTabCount,
                deletedItemsStandardBagsCount,
                deletedItemsBankBagsCount);
        }

        return true;
    }

private:
    static Player* GetPlayerFromIdentifierOrSelectedTarget(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = nullptr;

        // Check if there is an optional target player name
        // Do not use TargetOrSelf, we must be sure to select ourself
        if (!target)
        {
            // No optional target, so try to get selected target
            target = PlayerIdentifier::FromTarget(handler);

            if (!target)
            {
                // No character selected
                handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
                return targetPlayer;
            }

            targetPlayer = target->GetConnectedPlayer();
        }
        else
        {
            targetPlayer = target->GetConnectedPlayer();

            if (!targetPlayer || !target->IsConnected())
            {
                // No character selected
                handler->SendSysMessage(LANG_PLAYER_NOT_EXIST_OR_OFFLINE);
            }
        }

        return targetPlayer;
    }

    static int16 ResetItemsEquipped(Player* playerTarget)
    {
        if (!playerTarget)
        {
            return -1;
        }

        int16 count = 0;
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
        {
            Item* pItem = playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem)
            {
                playerTarget->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
                ++count;
            }
        }

        return count;
    }

    static int16 ResetItemsInBags(Player* playerTarget)
    {
        if (!playerTarget)
        {
            return -1;
        }

        int16 count = 0;
        // Default bagpack :
        for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
        {
            Item* pItem = playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem)
            {
                playerTarget->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
                ++count;
            }
        }

        // Bag slots
        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        {
            Bag* pBag = (Bag*)playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pBag)
            {
                for (uint8 j = 0; j < pBag->GetBagSize(); ++j)
                {
                    Item* pItem = pBag->GetItemByPos(j);
                    if (pItem)
                    {
                        playerTarget->DestroyItem(i, j, true);
                        ++count;
                    }
                }
            }
        }

        return count;
    }

    static int16 ResetItemsInBank(Player* playerTarget)
    {
        if (!playerTarget)
        {
            return -1;
        }

        int16 count = 0;
        // Normal bank slot
        for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; ++i)
        {
            Item* pItem = playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem)
            {
                playerTarget->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
                ++count;
            }
        }

        // Bank bagslots
        for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
        {
            Bag* pBag = (Bag*)playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pBag)
            {
                for (uint8 j = 0; j < pBag->GetBagSize(); ++j)
                {
                    Item* pItem = pBag->GetItemByPos(j);
                    if (pItem)
                    {
                        playerTarget->DestroyItem(i, j, true);
                        ++count;
                    }
                }
            }
        }

        return count;
    }

    static int16 ResetItemsInKeyring(Player* playerTarget)
    {
        if (!playerTarget)
        {
            return -1;
        }

        int16 count = 0;
        for (uint8 i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; ++i)
        {
            Item* pItem = playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem)
            {
                playerTarget->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
                ++count;
            }
        }

        return count;
    }

    static int16 ResetItemsInCurrenciesList(Player* playerTarget)
    {
        if (!playerTarget)
        {
            return -1;
        }

        int16 count = 0;
        for (uint8 i = CURRENCYTOKEN_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        {
            Item* pItem = playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem)
            {
                playerTarget->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
                ++count;
            }
        }

        return count;
    }

    static int16 ResetItemsInVendorBuyBackTab(Player* playerTarget)
    {
        if (!playerTarget)
        {
            return -1;
        }

        int16 count = 0;
        for (uint8 i = BUYBACK_SLOT_START; i < BUYBACK_SLOT_END; ++i)
        {
            Item* pItem = playerTarget->GetItemFromBuyBackSlot(i);
            if (pItem)
            {
                playerTarget->RemoveItemFromBuyBackSlot(i, true);
                ++count;
            }
        }

        return count;
    }

    static int16 ResetItemsDeleteStandardBags(Player* playerTarget)
    {
        if (!playerTarget)
        {
            return -1;
        }

        int16 count = 0;
        // Standard bag slots
        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        {
            Bag* pBag = (Bag*)playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pBag)
            {
                playerTarget->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
                ++count;
            }
        }

        return count;
    }

    static int16 ResetItemsDeleteBankBags(Player* playerTarget)
    {
        if (!playerTarget)
        {
            return -1;
        }

        int16 count = 0;
        // Bank bags
        for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
        {
            Bag* pBag = (Bag*)playerTarget->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pBag)
            {
                // prevent no empty ?
                playerTarget->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
                ++count;
            }
        }

        return count;
    }
};

void AddSC_reset_commandscript()
{
    new reset_commandscript();
}
