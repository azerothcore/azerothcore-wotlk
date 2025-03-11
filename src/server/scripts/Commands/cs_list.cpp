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
Name: list_commandscript
%Complete: 100
Comment: All list related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "CommandScript.h"
#include "Creature.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "GameObject.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SpellAuraEffects.h"

using namespace Acore::ChatCommands;

class list_commandscript : public CommandScript
{
public:
    list_commandscript() : CommandScript("list_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable listAurasCommandTable =
        {
            { "",         HandleListAllAurasCommand,    SEC_MODERATOR, Console::No  },
            { "id",       HandleListAurasByIdCommand,   SEC_MODERATOR, Console::No  },
            { "name",     HandleListAurasByNameCommand, SEC_MODERATOR, Console::No  },
        };

        static ChatCommandTable listCommandTable =
        {
            { "creature", HandleListCreatureCommand,    SEC_MODERATOR, Console::Yes },
            { "item",     HandleListItemCommand,        SEC_MODERATOR, Console::Yes },
            { "object",   HandleListObjectCommand,      SEC_MODERATOR, Console::Yes },
            { "auras",    listAurasCommandTable },
        };
        static ChatCommandTable commandTable =
        {
            { "list", listCommandTable }
        };
        return commandTable;
    }

    static bool HandleListCreatureCommand(ChatHandler* handler, Variant<Hyperlink<creature_entry>, uint32> creatureId, Optional<uint32> countArg)
    {
        CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(creatureId);
        if (!cInfo)
        {
            handler->SendErrorMessage(LANG_COMMAND_INVALIDCREATUREID, uint32(creatureId));
            return false;
        }

        uint32 count = countArg.value_or(10);

        if (count == 0)
            return false;

        QueryResult result;

        uint32 creatureCount = 0;
        result = WorldDatabase.Query("SELECT COUNT(guid) FROM creature WHERE id1='{}' OR id2='{}' OR id3='{}'", uint32(creatureId), uint32(creatureId), uint32(creatureId));
        if (result)
            creatureCount = (*result)[0].Get<uint64>();

        if (handler->GetSession())
        {
            Player* player = handler->GetSession()->GetPlayer();
            result = WorldDatabase.Query("SELECT guid, position_x, position_y, position_z, map, (POW(position_x - '{}', 2) + POW(position_y - '{}', 2) + POW(position_z - '{}', 2)) AS order_ FROM creature WHERE id1='{}' OR id2='{}' OR id3='{}' ORDER BY order_ ASC LIMIT {}",
                                          player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), uint32(creatureId), uint32(creatureId), uint32(creatureId), count);
        }
        else
            result = WorldDatabase.Query("SELECT guid, position_x, position_y, position_z, map FROM creature WHERE id1='{}' OR id2='{}' OR id3='{}' LIMIT {}",
                                          uint32(creatureId), uint32(creatureId), uint32(creatureId), count);

        if (result)
        {
            do
            {
                Field* fields               = result->Fetch();
                ObjectGuid::LowType guid    = fields[0].Get<uint32>();
                float x                     = fields[1].Get<float>();
                float y                     = fields[2].Get<float>();
                float z                     = fields[3].Get<float>();
                uint16 mapId                = fields[4].Get<uint16>();
                bool liveFound = false;

                // Get map (only support base map from console)
                Map* thisMap;
                if (handler->GetSession())
                    thisMap = handler->GetSession()->GetPlayer()->GetMap();
                else
                    thisMap = sMapMgr->FindBaseNonInstanceMap(mapId);

                // If map found, try to find active version of this creature
                if (thisMap)
                {
                    auto const creBounds = thisMap->GetCreatureBySpawnIdStore().equal_range(guid);
                    if (creBounds.first != creBounds.second)
                    {
                        for (std::unordered_multimap<uint32, Creature*>::const_iterator itr = creBounds.first; itr != creBounds.second;)
                        {
                            if (handler->GetSession())
                                handler->PSendSysMessage(LANG_CREATURE_LIST_CHAT, guid, cInfo->Entry, guid, cInfo->Name, x, y, z, mapId, itr->second->GetGUID().ToString(), itr->second->IsAlive() ? "*" : " ");
                            else
                                handler->PSendSysMessage(LANG_CREATURE_LIST_CONSOLE, guid, cInfo->Name, x, y, z, mapId, itr->second->GetGUID().ToString(), itr->second->IsAlive() ? "*" : " ");
                            ++itr;
                        }
                        liveFound = true;
                    }
                }

                if (!liveFound)
                {
                    if (handler->GetSession())
                        handler->PSendSysMessage(LANG_CREATURE_LIST_CHAT, guid, cInfo->Entry, guid, cInfo->Name, x, y, z, mapId, "", "");
                    else
                        handler->PSendSysMessage(LANG_CREATURE_LIST_CONSOLE, guid, cInfo->Name, x, y, z, mapId, "", "");
                }
            }
            while (result->NextRow());
        }

        handler->PSendSysMessage(LANG_COMMAND_LISTCREATUREMESSAGE, uint32(creatureId), creatureCount);

        return true;
    }

    static bool HandleListItemCommand(ChatHandler* handler, Variant<Hyperlink<item>, uint32> itemArg, Optional<uint32> countArg)
    {
        uint32 itemId = 0;
        uint32 count = countArg.value_or(10);

        if (itemArg.holds_alternative<Hyperlink<item>>())
        {
            itemId = itemArg.get<Hyperlink<item>>()->Item->ItemId;
        }
        else
        {
            itemId = itemArg.get<uint32>();
        }

        if (!count || !itemId)
            return false;

        PreparedQueryResult result;

        // inventory case
        uint32 inventoryCount = 0;

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_INVENTORY_COUNT_ITEM);
        stmt->SetData(0, itemId);
        result = CharacterDatabase.Query(stmt);

        if (result)
            inventoryCount = (*result)[0].Get<uint64>();

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_INVENTORY_ITEM_BY_ENTRY);
        stmt->SetData(0, itemId);
        stmt->SetData(1, count);
        result = CharacterDatabase.Query(stmt);

        if (result)
        {
            do
            {
                Field* fields           = result->Fetch();
                uint32 itemGuid         = fields[0].Get<uint32>();
                uint32 itemBag          = fields[1].Get<uint32>();
                uint8 itemSlot          = fields[2].Get<uint8>();
                uint32 ownerGuid        = fields[3].Get<uint32>();
                uint32 ownerAccountId   = fields[4].Get<uint32>();
                std::string ownerName   = fields[5].Get<std::string>();

                char const* itemPos = nullptr;
                if (Player::IsEquipmentPos(itemBag, itemSlot))
                    itemPos = "[equipped]";
                else if (Player::IsInventoryPos(itemBag, itemSlot))
                    itemPos = "[in inventory]";
                else if (Player::IsBankPos(itemBag, itemSlot))
                    itemPos = "[in bank]";
                else
                    itemPos = "";

                handler->PSendSysMessage(LANG_ITEMLIST_SLOT, itemGuid, ownerName, ownerGuid, ownerAccountId, itemPos);
            }
            while (result->NextRow());

            uint32 resultCount = uint32(result->GetRowCount());

            if (count > resultCount)
                count -= resultCount;
            else
                count = 0;
        }

        // mail case
        uint32 mailCount = 0;

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAIL_COUNT_ITEM);
        stmt->SetData(0, itemId);
        result = CharacterDatabase.Query(stmt);

        if (result)
            mailCount = (*result)[0].Get<uint64>();

        if (count > 0)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAIL_ITEMS_BY_ENTRY);
            stmt->SetData(0, itemId);
            stmt->SetData(1, count);
            result = CharacterDatabase.Query(stmt);
        }
        else
            result = PreparedQueryResult(nullptr);

        if (result)
        {
            do
            {
                Field* fields                   = result->Fetch();
                ObjectGuid::LowType itemGuid    = fields[0].Get<uint32>();
                ObjectGuid::LowType itemSender  = fields[1].Get<uint32>();
                uint32 itemReceiver             = fields[2].Get<uint32>();
                uint32 itemSenderAccountId      = fields[3].Get<uint32>();
                std::string itemSenderName      = fields[4].Get<std::string>();
                uint32 itemReceiverAccount      = fields[5].Get<uint32>();
                std::string itemReceiverName    = fields[6].Get<std::string>();

                char const* itemPos = "[in mail]";

                handler->PSendSysMessage(LANG_ITEMLIST_MAIL, itemGuid, itemSenderName, itemSender, itemSenderAccountId, itemReceiverName, itemReceiver, itemReceiverAccount, itemPos);
            }
            while (result->NextRow());

            uint32 resultCount = uint32(result->GetRowCount());

            if (count > resultCount)
                count -= resultCount;
            else
                count = 0;
        }

        // auction case
        uint32 auctionCount = 0;

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_AUCTIONHOUSE_COUNT_ITEM);
        stmt->SetData(0, itemId);
        result = CharacterDatabase.Query(stmt);

        if (result)
            auctionCount = (*result)[0].Get<uint64>();

        if (count > 0)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_AUCTIONHOUSE_ITEM_BY_ENTRY);
            stmt->SetData(0, itemId);
            stmt->SetData(1, count);
            result = CharacterDatabase.Query(stmt);
        }
        else
            result = PreparedQueryResult(nullptr);

        if (result)
        {
            do
            {
                Field* fields           = result->Fetch();
                uint32 itemGuid         = fields[0].Get<uint32>();
                uint32 owner            = fields[1].Get<uint32>();
                uint32 ownerAccountId   = fields[2].Get<uint32>();
                std::string ownerName   = fields[3].Get<std::string>();

                char const* itemPos = "[in auction]";

                handler->PSendSysMessage(LANG_ITEMLIST_AUCTION, itemGuid, ownerName, owner, ownerAccountId, itemPos);
            }
            while (result->NextRow());
        }

        // guild bank case
        uint32 guildCount = 0;

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GUILD_BANK_COUNT_ITEM);
        stmt->SetData(0, itemId);
        result = CharacterDatabase.Query(stmt);

        if (result)
            guildCount = (*result)[0].Get<uint64>();

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GUILD_BANK_ITEM_BY_ENTRY);
        stmt->SetData(0, itemId);
        stmt->SetData(1, count);
        result = CharacterDatabase.Query(stmt);

        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                uint32 itemGuid = fields[0].Get<uint32>();
                uint32 guildGuid = fields[1].Get<uint32>();
                std::string guildName = fields[2].Get<std::string>();

                char const* itemPos = "[in guild bank]";

                handler->PSendSysMessage(LANG_ITEMLIST_GUILD, itemGuid, guildName, guildGuid, itemPos);
            }
            while (result->NextRow());

            uint32 resultCount = uint32(result->GetRowCount());

            if (count > resultCount)
                count -= resultCount;
            else
                count = 0;
        }

        if (inventoryCount + mailCount + auctionCount + guildCount == 0)
        {
            handler->SendErrorMessage(LANG_COMMAND_NOITEMFOUND);
            return false;
        }

        handler->PSendSysMessage(LANG_COMMAND_LISTITEMMESSAGE, itemId, inventoryCount + mailCount + auctionCount + guildCount, inventoryCount, mailCount, auctionCount, guildCount);

        return true;
    }

    static bool HandleListObjectCommand(ChatHandler* handler, Variant<Hyperlink<gameobject_entry>, uint32> gameObjectId, Optional<uint32> countArg)
    {
        GameObjectTemplate const* gInfo = sObjectMgr->GetGameObjectTemplate(gameObjectId);
        if (!gInfo)
        {
            handler->SendErrorMessage(LANG_COMMAND_LISTOBJINVALIDID, uint32(gameObjectId));
            return false;
        }

        uint32 count = countArg.value_or(10);

        if (count == 0)
            return false;

        QueryResult result;

        uint32 objectCount = 0;
        result = WorldDatabase.Query("SELECT COUNT(guid) FROM gameobject WHERE id='{}'", uint32(gameObjectId));
        if (result)
            objectCount = (*result)[0].Get<uint64>();

        if (handler->GetSession())
        {
            Player* player = handler->GetSession()->GetPlayer();
            result = WorldDatabase.Query("SELECT guid, position_x, position_y, position_z, map, id, (POW(position_x - '{}', 2) + POW(position_y - '{}', 2) + POW(position_z - '{}', 2)) AS order_ FROM gameobject WHERE id = '{}' ORDER BY order_ ASC LIMIT {}",
                                          player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), uint32(gameObjectId), count);
        }
        else
            result = WorldDatabase.Query("SELECT guid, position_x, position_y, position_z, map, id FROM gameobject WHERE id = '{}' LIMIT {}",
                                          uint32(gameObjectId), count);

        if (result)
        {
            do
            {
                Field* fields               = result->Fetch();
                ObjectGuid::LowType guid    = fields[0].Get<uint32>();
                float x                     = fields[1].Get<float>();
                float y                     = fields[2].Get<float>();
                float z                     = fields[3].Get<float>();
                uint16 mapId                = fields[4].Get<uint16>();
                uint32 entry                = fields[5].Get<uint32>();
                bool liveFound = false;

                // Get map (only support base map from console)
                Map* thisMap;
                if (handler->GetSession())
                    thisMap = handler->GetSession()->GetPlayer()->GetMap();
                else
                    thisMap = sMapMgr->FindBaseNonInstanceMap(mapId);

                // If map found, try to find active version of this object
                if (thisMap)
                {
                    auto const goBounds = thisMap->GetGameObjectBySpawnIdStore().equal_range(guid);
                    if (goBounds.first != goBounds.second)
                    {
                        for (std::unordered_multimap<uint32, GameObject*>::const_iterator itr = goBounds.first; itr != goBounds.second;)
                        {
                            if (handler->GetSession())
                                handler->PSendSysMessage(LANG_GO_LIST_CHAT, guid, entry, guid, gInfo->name, x, y, z, mapId, itr->second->GetGUID().ToString(), itr->second->isSpawned() ? "*" : " ");
                            else
                                handler->PSendSysMessage(LANG_GO_LIST_CONSOLE, guid, gInfo->name, x, y, z, mapId, itr->second->GetGUID().ToString(), itr->second->isSpawned() ? "*" : " ");
                            ++itr;
                        }
                        liveFound = true;
                    }
                }

                if (!liveFound)
                {
                    if (handler->GetSession())
                        handler->PSendSysMessage(LANG_GO_LIST_CHAT, guid, entry, guid, gInfo->name, x, y, z, mapId, "", "");
                    else
                        handler->PSendSysMessage(LANG_GO_LIST_CONSOLE, guid, gInfo->name, x, y, z, mapId, "", "");
                }
            }
            while (result->NextRow());
        }

        handler->PSendSysMessage(LANG_COMMAND_LISTOBJMESSAGE, uint32(gameObjectId), objectCount);

        return true;
    }

    static bool HandleListAllAurasCommand(ChatHandler* handler)
    {
        return ListAurasCommand(handler, {}, {});
    }

    static bool HandleListAurasByIdCommand(ChatHandler* handler, uint32 spellId)
    {
        return ListAurasCommand(handler, spellId, {});
    }

    static bool HandleListAurasByNameCommand(ChatHandler* handler, WTail namePart)
    {
        return ListAurasCommand(handler, {}, namePart);
    }

    static bool ListAurasCommand(ChatHandler* handler, Optional<uint32> spellId, std::wstring namePart)
    {
        Unit* unit = handler->getSelectedUnit();
        if (!unit)
        {
            handler->SendErrorMessage(LANG_SELECT_CHAR_OR_CREATURE);
            return false;
        }

        wstrToLower(namePart);

        std::string talentStr = handler->GetAcoreString(LANG_TALENT);
        std::string passiveStr = handler->GetAcoreString(LANG_PASSIVE);

        Unit::AuraApplicationMap const& auras = unit->GetAppliedAuras();
        handler->PSendSysMessage(LANG_COMMAND_TARGET_LISTAURAS, auras.size());
        for (auto const& [aurId, aurApp] : auras)
        {
            bool talent = GetTalentSpellCost(aurApp->GetBase()->GetId()) > 0;

            Aura const* aura = aurApp->GetBase();
            char const* name = aura->GetSpellInfo()->SpellName[handler->GetSessionDbcLocale()];

            if (!ShouldListAura(aura->GetSpellInfo(), spellId, namePart, handler->GetSessionDbcLocale()))
                continue;

            std::ostringstream ss_name;
            ss_name << "|cffffffff|Hspell:" << aura->GetId() << "|h[" << name << "]|h|r";

            handler->PSendSysMessage(LANG_COMMAND_TARGET_AURADETAIL, aura->GetId(), (handler->GetSession() ? ss_name.str() : name),
                                     aurApp->GetEffectMask(), aura->GetCharges(), aura->GetStackAmount(), aurApp->GetSlot(),
                                     aura->GetDuration(), aura->GetMaxDuration(), (aura->IsPassive() ? passiveStr : ""),
                                     (talent ? talentStr : ""), aura->GetCasterGUID().IsPlayer() ? "player" : "creature",
                                     aura->GetCasterGUID().ToString());
        }

        for (uint16 i = 0; i < TOTAL_AURAS; ++i)
        {
            Unit::AuraEffectList const& auraList = unit->GetAuraEffectsByType(AuraType(i));
            if (auraList.empty())
                continue;

            bool sizeLogged = false;

            for (AuraEffect const* effect : auraList)
            {
                if (!ShouldListAura(effect->GetSpellInfo(), spellId, namePart, handler->GetSessionDbcLocale()))
                    continue;

                if (!sizeLogged)
                {
                    sizeLogged = true;
                    handler->PSendSysMessage(LANG_COMMAND_TARGET_LISTAURATYPE, auraList.size(), i);
                }

                handler->PSendSysMessage(LANG_COMMAND_TARGET_AURASIMPLE, effect->GetId(), effect->GetEffIndex(), effect->GetAmount());
            }
        }

        return true;
    }

    static bool ShouldListAura(SpellInfo const* spellInfo, Optional<uint32> spellId, std::wstring namePart, uint8 locale)
    {
        if (spellId)
            return spellInfo->Id == spellId;

        if (!namePart.empty())
        {
            std::string name = spellInfo->SpellName[locale];
            return Utf8FitTo(name, namePart);
        }

        return true;
    }
};

void AddSC_list_commandscript()
{
    new list_commandscript();
}
