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
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Transmogrification.h"
#include "Tokenize.h"
#include "DatabaseEnv.h"

using namespace Acore::ChatCommands;

class transmog_commandscript : public CommandScript
{
public:
    transmog_commandscript() : CommandScript("transmog_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable addCollectionTable =
        {
            { "set", HandleAddTransmogItemSet,    SEC_MODERATOR, Console::Yes },
            { "",    HandleAddTransmogItem,       SEC_MODERATOR, Console::Yes },
        };

        static ChatCommandTable transmogTable =
        {
            { "add",      addCollectionTable                                        },
            { "",         HandleDisableTransMogVisual,   SEC_PLAYER,    Console::No },
            { "sync",     HandleSyncTransMogCommand,     SEC_PLAYER,    Console::No },
            { "portable", HandleTransmogPortableCommand, SEC_PLAYER,    Console::No },
        };

        static ChatCommandTable commandTable =
        {
            { "transmog", transmogTable },
        };

        return commandTable;
    }

    static bool HandleSyncTransMogCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        uint32 accountId = player->GetSession()->GetAccountId();
        handler->SendSysMessage(LANG_CMD_TRANSMOG_BEGIN_SYNC);
        
        for (uint32 itemId : sTransmogrification->collectionCache[accountId])
            handler->PSendSysMessage("TRANSMOG_SYNC:{}", itemId);
        
        handler->SendSysMessage(LANG_CMD_TRANSMOG_COMPLETE_SYNC);
        return true;
    }

    static bool HandleDisableTransMogVisual(ChatHandler* handler, bool hide)
    {
        Player* player = handler->GetPlayer();

        if (hide)
        {
            player->UpdatePlayerSetting("mod-transmog", SETTING_HIDE_TRANSMOG, 0);
            handler->SendSysMessage(LANG_CMD_TRANSMOG_SHOW);
        }
        else
        {
            player->UpdatePlayerSetting("mod-transmog", SETTING_HIDE_TRANSMOG, 1);
            handler->SendSysMessage(LANG_CMD_TRANSMOG_HIDE);
        }

        player->UpdateObjectVisibility();
        return true;
    }

    static bool HandleAddTransmogItem(ChatHandler* handler, Optional<PlayerIdentifier> player, ItemTemplate const* itemTemplate)
    {
        if (!sTransmogrification->GetUseCollectionSystem())
            return true;

        if (!sObjectMgr->GetItemTemplate(itemTemplate->ItemId))
        {
            handler->PSendSysMessage(LANG_COMMAND_ITEMIDINVALID, itemTemplate->ItemId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            return false;
        }

        Player* target = player->GetConnectedPlayer();
        bool isNotConsole = handler->GetSession();
        bool suitableForTransmog;

        if (target)
        {
            suitableForTransmog = sTransmogrification->SuitableForTransmogrification(target, itemTemplate);
        }
        else
        {
            suitableForTransmog = sTransmogrification->SuitableForTransmogrification(player->GetGUID(), itemTemplate);
        }

        if (!sTransmogrification->GetTrackUnusableItems() && !suitableForTransmog)
        {
            handler->SendSysMessage(LANG_CMD_TRANSMOG_ADD_UNSUITABLE);
            handler->SetSentErrorMessage(true);
            return true;
        }

        if (itemTemplate->Class != ITEM_CLASS_ARMOR && itemTemplate->Class != ITEM_CLASS_WEAPON)
        {
            handler->SendSysMessage(LANG_CMD_TRANSMOG_ADD_FORBIDDEN);
            handler->SetSentErrorMessage(true);
            return true;
        }

        auto guid = player->GetGUID();
        uint32 accountId = sCharacterCache->GetCharacterAccountIdByGuid(guid);
        uint32 itemId = itemTemplate->ItemId;

        std::stringstream tempStream;
        tempStream << std::hex << ItemQualityColors[itemTemplate->Quality];
        std::string itemQuality = tempStream.str();
        std::string itemName = itemTemplate->Name1;

        if (target) {
            // get locale item name
            int loc_idex = target->GetSession()->GetSessionDbLocaleIndex();
            if (ItemLocale const* il = sObjectMgr->GetItemLocale(itemId))
                ObjectMgr::GetLocaleString(il->Name, loc_idex, itemName);
        }

        std::string playerName = player->GetName();
        std::string nameLink = handler->playerLink(playerName);

        if (sTransmogrification->AddCollectedAppearance(accountId, itemId))
        {
            // Notify target of new item in appearance collection
            if (target && !(target->GetPlayerSetting("mod-transmog", SETTING_HIDE_TRANSMOG).value) && !sTransmogrification->CanNeverTransmog(itemTemplate))
                ChatHandler(target->GetSession()).PSendSysMessage(R"(|c{}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r has been added to your appearance collection.)", itemQuality.c_str(), itemId, itemName.c_str());

            // Feedback of successful command execution to GM
            if (isNotConsole && target != handler->GetPlayer())
                handler->PSendSysMessage(R"(|c{}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r has been added to the appearance collection of Player {}.)", itemQuality.c_str(), itemId, itemName.c_str(), nameLink);

            CharacterDatabase.Execute("INSERT INTO custom_unlocked_appearances (account_id, item_template_id) VALUES ({}, {})", accountId, itemId);
        }
        else
        {
            // Feedback of failed command execution to GM
            if (isNotConsole)
            {
                handler->PSendSysMessage(R"(Player {} already has item |c{}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r in the appearance collection.)", nameLink, itemQuality.c_str(), itemId, itemName.c_str());
                handler->SetSentErrorMessage(true);
            }
        }

        return true;
    }

    static bool HandleAddTransmogItemSet(ChatHandler* handler, Optional<PlayerIdentifier> player, Variant<Hyperlink<itemset>, uint32> itemSetId)
    {
        if (!sTransmogrification->GetUseCollectionSystem())
            return true;

        if (!*itemSetId)
        {
            handler->PSendSysMessage(LANG_NO_ITEMS_FROM_ITEMSET_FOUND, uint32(itemSetId));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            return false;
        }

        Player* target = player->GetConnectedPlayer();
        ItemSetEntry const* set = sItemSetStore.LookupEntry(uint32(itemSetId));
        bool isNotConsole = handler->GetSession();

        if (!set)
        {
            handler->PSendSysMessage(LANG_NO_ITEMS_FROM_ITEMSET_FOUND, uint32(itemSetId));
            handler->SetSentErrorMessage(true);
            return false;
        }

        auto guid = player->GetGUID();
        CharacterCacheEntry const* playerData = sCharacterCache->GetCharacterCacheByGuid(guid);
        if (!playerData)
            return false;

        bool added = false;
        uint32 error = 0;
        uint32 itemId;
        uint32 accountId = playerData->AccountId;

        for (uint32 i = 0; i < MAX_ITEM_SET_ITEMS; ++i)
        {
            itemId = set->itemId[i];
            if (itemId)
            {
                ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId);
                if (itemTemplate)
                {
                    if (!sTransmogrification->GetTrackUnusableItems() && (
                            (target && !sTransmogrification->SuitableForTransmogrification(target, itemTemplate)) ||
                            !sTransmogrification->SuitableForTransmogrification(guid, itemTemplate)
                            ))
                    {
                        error = LANG_CMD_TRANSMOG_ADD_UNSUITABLE;
                        continue;
                    }
                    if (itemTemplate->Class != ITEM_CLASS_ARMOR && itemTemplate->Class != ITEM_CLASS_WEAPON)
                    {
                        error = LANG_CMD_TRANSMOG_ADD_FORBIDDEN;
                        continue;
                    }

                    if (sTransmogrification->AddCollectedAppearance(accountId, itemId))
                    {
                        CharacterDatabase.Execute("INSERT INTO custom_unlocked_appearances (account_id, item_template_id) VALUES ({}, {})", accountId, itemId);
                        added = true;
                    }
                }
            }
        }

        if (!added && error > 0)
        {
            handler->SendSysMessage(error);
            handler->SetSentErrorMessage(true);
            return true;
        }

        int locale = handler->GetSessionDbcLocale();
        std::string setName = set->name[locale];
        std::string nameLink = handler->playerLink(player->GetName());

        // Feedback of command execution to GM
        if (isNotConsole)
        {
            // Failed command execution
            if (!added)
            {
                handler->PSendSysMessage("Player {} already has ItemSet |cffffffff|Hitemset:{}|h[{} {}]|h|r in the appearance collection.", nameLink, uint32(itemSetId), setName.c_str(), localeNames[locale]);
                handler->SetSentErrorMessage(true);
                return true;
            }

            // Successful command execution
            if (target != handler->GetPlayer())
            {
                handler->PSendSysMessage("ItemSet |cffffffff|Hitemset:{}|h[{} {}]|h|r has been added to the appearance collection of Player {}.", uint32(itemSetId), setName.c_str(), localeNames[locale], nameLink);
            }
        }

        // Notify target of new item in appearance collection
        if (target && !(target->GetPlayerSetting("mod-transmog", SETTING_HIDE_TRANSMOG).value))
        {
            ChatHandler(target->GetSession()).PSendSysMessage("ItemSet |cffffffff|Hitemset:%d|h[{} {}]|h|r has been added to your appearance collection.", uint32(itemSetId), setName.c_str(), localeNames[locale]);
        }

        return true;
    }

    static bool HandleTransmogPortableCommand(ChatHandler* handler)
    {
        if (!sTransmogrification->IsPortableNPCEnabled)
        {
            handler->GetPlayer()->SendSystemMessage("The portable transmogrification NPC is disabled.");
            handler->SetSentErrorMessage(true);
            return true;
        }

        if (Player* player = PlayerIdentifier::FromSelf(handler)->GetConnectedPlayer())
        {

            if (sTransmogrification->IsTransmogPlusEnabled)
                if (sTransmogrification->IsPlusFeatureEligible(player->GetGUID(), PLUS_FEATURE_PET))
                {
                    player->CastSpell((Unit*)nullptr, sTransmogrification->PetSpellId, true);
                    return true;
                }

            if (player->GetSession()->GetSecurity() < SEC_MODERATOR)
                return true;

            player->CastSpell((Unit*)nullptr, sTransmogrification->PetSpellId, true);
        }

        return true;
    };
};

void AddSC_transmog_commandscript()
{
    new transmog_commandscript();
}
