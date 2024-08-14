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
Name: quest_commandscript
%Complete: 100
Comment: All quest related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "CommandScript.h"
#include "GameTime.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ReputationMgr.h"

using namespace Acore::ChatCommands;

class quest_commandscript : public CommandScript
{
public:
    quest_commandscript() : CommandScript("quest_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable questCommandTable =
        {
            { "add",      HandleQuestAdd,      SEC_GAMEMASTER, Console::Yes },
            { "complete", HandleQuestComplete, SEC_GAMEMASTER, Console::Yes },
            { "remove",   HandleQuestRemove,   SEC_GAMEMASTER, Console::Yes },
            { "reward",   HandleQuestReward,   SEC_GAMEMASTER, Console::Yes },
        };
        static ChatCommandTable commandTable =
        {
            { "quest", questCommandTable },
        };
        return commandTable;
    }

    static bool HandleQuestAdd(ChatHandler* handler, Quest const* quest, Optional<PlayerIdentifier> playerTarget)
    {
        if (!playerTarget)
        {
            playerTarget = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!playerTarget)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        uint32 entry = quest->GetQuestId();

        // check item starting quest (it can work incorrectly if added without item in inventory)
        ItemTemplateContainer const* itc = sObjectMgr->GetItemTemplateStore();
        ItemTemplateContainer::const_iterator result = find_if(itc->begin(), itc->end(), Finder<uint32, ItemTemplate>(entry, &ItemTemplate::StartQuest));

        if (result != itc->end())
        {
            handler->SendErrorMessage(LANG_COMMAND_QUEST_STARTFROMITEM, entry, result->second.ItemId);
            return false;
        }

        if (Player* player = playerTarget->GetConnectedPlayer())
        {
            if (player->IsActiveQuest(entry))
            {
                handler->SendErrorMessage(LANG_COMMAND_QUEST_ACTIVE, quest->GetTitle(), entry);
                return false;
            }

            // ok, normal (creature/GO starting) quest
            if (player->CanAddQuest(quest, true))
            {
                player->AddQuestAndCheckCompletion(quest, nullptr);
            }
        }
        else
        {
            ObjectGuid::LowType guid = playerTarget->GetGUID().GetCounter();
            QueryResult result = CharacterDatabase.Query("SELECT 1 FROM character_queststatus WHERE guid = {} AND quest = {}", guid, entry);

            if (result)
            {
                handler->SendErrorMessage(LANG_COMMAND_QUEST_ACTIVE, quest->GetTitle(), entry);
                return false;
            }

            uint8 index = 0;

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CHAR_QUESTSTATUS);
            stmt->SetData(index++, guid);
            stmt->SetData(index++, entry);
            stmt->SetData(index++, 1);
            stmt->SetData(index++, false);
            stmt->SetData(index++, 0);

            for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
            {
                stmt->SetData(index++, 0);
            }

            for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
            {
                stmt->SetData(index++, 0);
            }

            stmt->SetData(index, 0);

            CharacterDatabase.Execute(stmt);
        }

        handler->PSendSysMessage(LANG_COMMAND_QUEST_ADD, quest->GetTitle(), entry);
        handler->SetSentErrorMessage(false);
        return true;
    }

    static bool HandleQuestRemove(ChatHandler* handler, Quest const* quest, Optional<PlayerIdentifier> playerTarget)
    {
        if (!playerTarget)
        {
            playerTarget = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!playerTarget)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        uint32 entry = quest->GetQuestId();

        if (!quest)
        {
            handler->SendErrorMessage(LANG_COMMAND_QUEST_NOTFOUND, entry);
            return false;
        }

        if (Player* player = playerTarget->GetConnectedPlayer())
        {
            // remove all quest entries for 'entry' from quest log
            for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
            {
                uint32 logQuest = player->GetQuestSlotQuestId(slot);
                if (logQuest == entry)
                {
                    player->SetQuestSlot(slot, 0);

                    // we ignore unequippable quest items in this case, its' still be equipped
                    player->TakeQuestSourceItem(logQuest, false);

                    if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
                    {
                        player->pvpInfo.IsHostile = player->pvpInfo.IsInHostileArea || player->HasPvPForcingQuest();
                        player->UpdatePvPState();
                    }
                }
            }

            player->RemoveRewardedQuest(entry);
            player->RemoveActiveQuest(entry, false);
        }
        else
        {
            ObjectGuid::LowType guid = playerTarget->GetGUID().GetCounter();
            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED_BY_QUEST);
            stmt->SetData(0, guid);
            stmt->SetData(1, entry);
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_BY_QUEST);
            stmt->SetData(0, guid);
            stmt->SetData(1, entry);
            trans->Append(stmt);

            for (uint32 const& requiredItem : quest->RequiredItemId)
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_INVENTORY_ITEM_BY_ENTRY_AND_OWNER);
                stmt->SetData(0, requiredItem);
                stmt->SetData(1, guid);

                PreparedQueryResult result = CharacterDatabase.Query(stmt);

                if (result)
                {
                    Field* fields = result->Fetch();

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM);
                    stmt->SetData(0, fields[0].Get<uint32>());
                    trans->Append(stmt);

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
                    stmt->SetData(0, fields[0].Get<uint32>());
                    trans->Append(stmt);
                }
            }

            CharacterDatabase.CommitTransaction(trans);
        }

        handler->PSendSysMessage(LANG_COMMAND_QUEST_REMOVED, quest->GetTitle(), entry);
        handler->SetSentErrorMessage(false);
        return true;
    }

    static bool HandleQuestComplete(ChatHandler* handler, Quest const* quest, Optional<PlayerIdentifier> playerTarget)
    {
        if (!playerTarget)
        {
            playerTarget = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!playerTarget)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        uint32 entry = quest->GetQuestId();

        if (Player* player = playerTarget->GetConnectedPlayer())
        {
            // If player doesn't have the quest
            if (player->GetQuestStatus(entry) == QUEST_STATUS_NONE)
            {
                handler->SendErrorMessage(LANG_COMMAND_QUEST_NOTFOUND, entry);
                return false;
            }

            // Add quest items for quests that require items
            for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x)
            {
                uint32 id    = quest->RequiredItemId[x];
                uint32 count = quest->RequiredItemCount[x];
                if (!id || !count)
                {
                    continue;
                }

                uint32 curItemCount = player->GetItemCount(id, true);

                ItemPosCountVec dest;
                uint8           msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, id, count - curItemCount);
                if (msg == EQUIP_ERR_OK)
                {
                    Item* item = player->StoreNewItem(dest, id, true);
                    player->SendNewItem(item, count - curItemCount, true, false);
                }
            }

            // All creature/GO slain/casted (not required, but otherwise it will display "Creature slain 0/10")
            for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
            {
                int32  creature      = quest->RequiredNpcOrGo[i];
                uint32 creatureCount = quest->RequiredNpcOrGoCount[i];

                if (creature > 0)
                {
                    if (CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(creature))
                    {
                        for (uint16 z = 0; z < creatureCount; ++z)
                        {
                            player->KilledMonster(creatureInfo, ObjectGuid::Empty);
                        }
                    }
                }
                else if (creature < 0)
                {
                    for (uint16 z = 0; z < creatureCount; ++z)
                    {
                        player->KillCreditGO(creature);
                    }
                }
            }

            // player kills
            if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_PLAYER_KILL))
            {
                if (uint32 reqPlayers = quest->GetPlayersSlain())
                {
                    player->KilledPlayerCreditForQuest(reqPlayers, quest);
                }
            }

            // If the quest requires reputation to complete
            if (uint32 repFaction = quest->GetRepObjectiveFaction())
            {
                uint32 repValue = quest->GetRepObjectiveValue();
                uint32 curRep   = player->GetReputationMgr().GetReputation(repFaction);
                if (curRep < repValue)
                {
                    if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
                    {
                        player->GetReputationMgr().SetReputation(factionEntry, static_cast<float>(repValue));
                    }
                }
            }

            // If the quest requires a SECOND reputation to complete
            if (uint32 repFaction = quest->GetRepObjectiveFaction2())
            {
                uint32 repValue2 = quest->GetRepObjectiveValue2();
                uint32 curRep    = player->GetReputationMgr().GetReputation(repFaction);
                if (curRep < repValue2)
                {
                    if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
                    {
                        player->GetReputationMgr().SetReputation(factionEntry, static_cast<float>(repValue2));
                    }
                }
            }

            // If the quest requires money
            int32 ReqOrRewMoney = quest->GetRewOrReqMoney(player->GetLevel());
            if (ReqOrRewMoney < 0)
            {
                player->ModifyMoney(-ReqOrRewMoney);
            }

            player->CompleteQuest(entry);
        }
        else
        {
            ObjectGuid::LowType guid = playerTarget->GetGUID().GetCounter();
            QueryResult result = CharacterDatabase.Query("SELECT 1 FROM character_queststatus WHERE guid = {} AND quest = {}", guid, entry);

            if (!result)
            {
                handler->SendErrorMessage(LANG_COMMAND_QUEST_NOT_FOUND_IN_LOG, quest->GetTitle(), entry);
                return false;
            }

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

            typedef std::pair<uint32, uint32> items;
            std::vector<items> questItems;

            for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x)
            {
                uint32 id    = quest->RequiredItemId[x];
                uint32 count = quest->RequiredItemCount[x];
                if (!id || !count)
                {
                    continue;
                }

                questItems.push_back(std::pair(id, count));
            }

            if (!questItems.empty())
            {
                MailSender sender(MAIL_NORMAL, guid, MAIL_STATIONERY_GM);
                // fill mail
                MailDraft draft(quest->GetTitle(), std::string());

                for (auto const& itr : questItems)
                {
                    if (Item* item = Item::CreateItem(itr.first, itr.second))
                    {
                        item->SaveToDB(trans);
                        draft.AddItem(item);
                    }
                }

                draft.SendMailTo(trans, MailReceiver(nullptr, guid), sender);
            }

            uint8 index = 0;

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CHAR_QUESTSTATUS);
            stmt->SetData(index++, guid);
            stmt->SetData(index++, entry);
            stmt->SetData(index++, 1);
            stmt->SetData(index++, quest->HasFlag(QUEST_FLAGS_EXPLORATION));
            stmt->SetData(index++, 0);

            for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
            {
                stmt->SetData(index++, quest->RequiredNpcOrGoCount[i]);
            }

            for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
            {
                // Will be updated once they loot the items from the mailbox.
                stmt->SetData(index++, 0);
            }

            stmt->SetData(index, 0);

            trans->Append(stmt);

            // If the quest requires reputation to complete, set the player rep to the required amount.
            if (uint32 repFaction = quest->GetRepObjectiveFaction())
            {
                uint32 repValue = quest->GetRepObjectiveValue();

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_REP_BY_FACTION);
                stmt->SetData(0, repFaction);
                stmt->SetData(1, guid);
                PreparedQueryResult result = CharacterDatabase.Query(stmt);

                if (result)
                {
                    Field* fields = result->Fetch();
                    uint32 curRep = fields[0].Get<uint32>();

                    if (curRep < repValue)
                    {
                        if (sFactionStore.LookupEntry(repFaction))
                        {
                            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_REP_FACTION_CHANGE);
                            stmt->SetData(0, repFaction);
                            stmt->SetData(1, repValue);
                            stmt->SetData(2, repFaction);
                            stmt->SetData(3, guid);
                            trans->Append(stmt);
                        }
                    }
                }
            }

            // If the quest requires reputation to complete, set the player rep to the required amount.
            if (uint32 repFaction = quest->GetRepObjectiveFaction2())
            {
                uint32 repValue = quest->GetRepObjectiveValue();

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_REP_BY_FACTION);
                stmt->SetData(0, repFaction);
                stmt->SetData(1, guid);
                PreparedQueryResult result = CharacterDatabase.Query(stmt);

                if (result)
                {
                    Field* fields = result->Fetch();
                    uint32 curRep = fields[0].Get<uint32>();

                    if (curRep < repValue)
                    {
                        if (sFactionStore.LookupEntry(repFaction))
                        {
                            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_REP_FACTION_CHANGE);
                            stmt->SetData(0, repFaction);
                            stmt->SetData(1, repValue);
                            stmt->SetData(2, repFaction);
                            stmt->SetData(3, guid);
                            trans->Append(stmt);
                        }
                    }
                }
            }

            CharacterDatabase.CommitTransaction(trans);
        }

        // check if Quest Tracker is enabled
        if (sWorld->getBoolConfig(CONFIG_QUEST_ENABLE_QUEST_TRACKER))
        {
            // prepare Quest Tracker datas
            auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_GM_COMPLETE);
            stmt->SetData(0, entry);
            stmt->SetData(1, playerTarget->GetGUID().GetCounter());

            // add to Quest Tracker
            CharacterDatabase.Execute(stmt);
        }

        handler->PSendSysMessage(LANG_COMMAND_QUEST_COMPLETE, quest->GetTitle(), entry);
        handler->SetSentErrorMessage(false);
        return true;
    }

    static bool HandleQuestReward(ChatHandler* handler, Quest const* quest, Optional<PlayerIdentifier> playerTarget)
    {
        if (!playerTarget)
        {
            playerTarget = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!playerTarget)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        uint32 entry = quest->GetQuestId();

        if (Player* player = playerTarget->GetConnectedPlayer())
        {
            // If player doesn't have the quest
            if (player->GetQuestStatus(entry) != QUEST_STATUS_COMPLETE)
            {
                handler->SendErrorMessage(LANG_COMMAND_QUEST_NOTFOUND, entry);
                return false;
            }

            player->RewardQuest(quest, 0, player);
        }
        else
        {
            // Achievement criteria updates correctly the next time a quest is rewarded.
            // Titles are already awarded correctly the next time they login (only one quest awards title - 11549).
            // Rewarded talent points (Death Knights) and spells (e.g Druid forms) are also granted on login.
            // No reputation gains - too troublesome to calculate them when the player is offline.

            ObjectGuid::LowType guid = playerTarget->GetGUID().GetCounter();
            uint8 charLevel = sCharacterCache->GetCharacterLevelByGuid(ObjectGuid(HighGuid::Player, guid));
            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            CharacterDatabasePreparedStatement* stmt;

            QueryResult result = CharacterDatabase.Query("SELECT 1 FROM character_queststatus WHERE guid = {} AND quest = {} AND status = 1", guid, entry);

            if (!result)
            {
                handler->SendErrorMessage(LANG_COMMAND_QUEST_NOT_COMPLETE);
                return false;
            }

            for (uint32 const& requiredItem : quest->RequiredItemId)
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_INVENTORY_ITEM_BY_ENTRY_AND_OWNER);
                stmt->SetData(0, requiredItem);
                stmt->SetData(1, guid);

                PreparedQueryResult result = CharacterDatabase.Query(stmt);

                if (result)
                {
                    Field* fields = result->Fetch();

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM);
                    stmt->SetData(0, fields[0].Get<uint32>());
                    trans->Append(stmt);

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
                    stmt->SetData(0, fields[0].Get<uint32>());
                    trans->Append(stmt);
                }
            }

            for (uint32 const& sourceItem : quest->ItemDrop)
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_INVENTORY_ITEM_BY_ENTRY_AND_OWNER);
                stmt->SetData(0, sourceItem);
                stmt->SetData(1, guid);

                PreparedQueryResult result = CharacterDatabase.Query(stmt);

                if (result)
                {
                    Field* fields = result->Fetch();

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM);
                    stmt->SetData(0, fields[0].Get<uint32>());
                    trans->Append(stmt);

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
                    stmt->SetData(0, fields[0].Get<uint32>());
                    trans->Append(stmt);
                }
            }

            typedef std::pair<uint32, uint32> items;
            std::vector<items> questRewardItems;

            if (quest->GetRewChoiceItemsCount())
            {
                for (uint32 const& itemId : quest->RewardChoiceItemId)
                {
                    uint8 index = 0;
                    questRewardItems.push_back(std::pair(itemId, quest->RewardChoiceItemCount[index++]));
                }
            }

            if (quest->GetRewItemsCount())
            {
                for (uint32 const& itemId : quest->RewardItemId)
                {
                    uint8 index = 0;
                    questRewardItems.push_back(std::pair(itemId, quest->RewardItemIdCount[index++]));
                }
            }

            if (!questRewardItems.empty())
            {
                MailSender sender(MAIL_NORMAL, guid, MAIL_STATIONERY_GM);
                // fill mail
                MailDraft draft(quest->GetTitle(), "This quest has been manually rewarded to you. This mail contains your quest rewards.");

                for (auto const& itr : questRewardItems)
                {
                    if (!itr.first || !itr.second)
                    {
                        continue;
                    }

                    // Skip invalid items.
                    if (!sObjectMgr->GetItemTemplate(itr.first))
                    {
                        continue;
                    }

                    if (Item* item = Item::CreateItem(itr.first, itr.second))
                    {
                        item->SaveToDB(trans);
                        draft.AddItem(item);
                    }
                }

                draft.SendMailTo(trans, MailReceiver(nullptr, guid), sender);
            }

            // Send quest giver mail, if any.
            if (uint32 mail_template_id = quest->GetRewMailTemplateId())
            {
                if (quest->GetRewMailSenderEntry() != 0)
                {
                    MailDraft(mail_template_id).SendMailTo(trans, MailReceiver(nullptr, guid), quest->GetRewMailSenderEntry(), MAIL_CHECK_MASK_HAS_BODY, quest->GetRewMailDelaySecs());
                }
            }

            if (quest->IsDaily() || quest->IsDFQuest())
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_DAILYQUESTSTATUS);
                stmt->SetData(0, guid);
                stmt->SetData(1, entry);
                stmt->SetData(2, GameTime::GetGameTime().count());
                trans->Append(stmt);
            }
            else if (quest->IsWeekly())
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_WEEKLYQUESTSTATUS);
                stmt->SetData(0, guid);
                stmt->SetData(1, entry);
                trans->Append(stmt);
            }
            else if (quest->IsMonthly())
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_MONTHLYQUESTSTATUS);
                stmt->SetData(0, guid);
                stmt->SetData(1, entry);
                trans->Append(stmt);
            }
            else if (quest->IsSeasonal())
            {
                // We can't know which event is the quest linked to, so we can't do anything about this.
                /* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_SEASONALQUESTSTATUS);
                stmt->SetData(0, guid);
                stmt->SetData(1, entry);
                stmt->SetData(2, event_id);
                trans->Append(stmt);*/
            }

            if (uint32 honor = quest->CalculateHonorGain(charLevel))
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_HONOR_POINTS_ACCUMULATIVE);
                stmt->SetData(0, honor);
                stmt->SetData(1, guid);
                trans->Append(stmt);
            }

            if (quest->GetRewArenaPoints())
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_ARENA_POINTS_ACCUMULATIVE);
                stmt->SetData(0, quest->GetRewArenaPoints());
                stmt->SetData(1, guid);
                trans->Append(stmt);
            }

            int32 rewMoney = 0;

            if (charLevel >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                rewMoney = quest->GetRewMoneyMaxLevel();
            }
            else
            {
                // Some experience might get lost on level up.
                uint32 xp = uint32(quest->XPValue(charLevel) * sWorld->getRate(RATE_XP_QUEST));
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_XP_ACCUMULATIVE);
                stmt->SetData(0, xp);
                stmt->SetData(1, guid);
                trans->Append(stmt);
            }

            if (int32 rewOrReqMoney = quest->GetRewOrReqMoney(charLevel))
            {
                rewMoney += rewOrReqMoney;
            }

            // Only reward money, don't subtract, let's not cause an overflow...
            if (rewMoney > 0)
            {
                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_MONEY_ACCUMULATIVE);
                stmt->SetData(0, rewMoney);
                stmt->SetData(1, guid);
                trans->Append(stmt);
            }

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_QUESTSTATUS_REWARDED);
            stmt->SetData(0, guid);
            stmt->SetData(1, entry);
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_BY_QUEST);
            stmt->SetData(0, guid);
            stmt->SetData(1, entry);
            trans->Append(stmt);

            CharacterDatabase.CommitTransaction(trans);
        }

        handler->PSendSysMessage(LANG_COMMAND_QUEST_REWARDED, quest->GetTitle(), entry);
        handler->SetSentErrorMessage(false);
        return true;
    }
};

void AddSC_quest_commandscript()
{
    new quest_commandscript();
}
