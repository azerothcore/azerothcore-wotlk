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

#include "CreatureAI.h"
#include "DisableMgr.h"
#include "GameEventMgr.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GitRevision.h"
#include "GossipDef.h"
#include "Group.h"
#include "MapMgr.h"
#include "Player.h"
#include "PoolMgr.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "WorldSession.h"

/*********************************************************/
/***                    QUEST SYSTEM                   ***/
/*********************************************************/

void Player::PrepareQuestMenu(ObjectGuid guid)
{
    QuestRelationBounds objectQR;
    QuestRelationBounds objectQIR;

    // pets also can have quests
    Creature* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, guid);
    if (creature)
    {
        objectQR  = sObjectMgr->GetCreatureQuestRelationBounds(creature->GetEntry());
        objectQIR = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(creature->GetEntry());
    }
    else
    {
        //we should obtain map pointer from GetMap() in 99% of cases. Special case
        //only for quests which cast teleport spells on player
        Map* _map = IsInWorld() ? GetMap() : sMapMgr->FindMap(GetMapId(), GetInstanceId());
        ASSERT(_map);
        GameObject* pGameObject = _map->GetGameObject(guid);
        if (pGameObject)
        {
            objectQR  = sObjectMgr->GetGOQuestRelationBounds(pGameObject->GetEntry());
            objectQIR = sObjectMgr->GetGOQuestInvolvedRelationBounds(pGameObject->GetEntry());
        }
        else
            return;
    }

    QuestMenu& qm = PlayerTalkClass->GetQuestMenu();
    qm.ClearMenu();

    for (QuestRelations::const_iterator i = objectQIR.first; i != objectQIR.second; ++i)
    {
        uint32 quest_id = i->second;
        QuestStatus status = GetQuestStatus(quest_id);
        if (status == QUEST_STATUS_COMPLETE)
            qm.AddMenuItem(quest_id, 4);
        else if (status == QUEST_STATUS_INCOMPLETE)
            qm.AddMenuItem(quest_id, 4);
        //else if (status == QUEST_STATUS_AVAILABLE)
        //    qm.AddMenuItem(quest_id, 2);
    }

    for (QuestRelations::const_iterator i = objectQR.first; i != objectQR.second; ++i)
    {
        uint32 quest_id = i->second;
        Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
        if (!quest)
            continue;

        if (!CanTakeQuest(quest, false))
            continue;

        if (quest->IsAutoComplete() && (!quest->IsRepeatable() || quest->IsDaily() || quest->IsWeekly() || quest->IsMonthly()))
            qm.AddMenuItem(quest_id, 0);
        else if (quest->IsAutoComplete())
            qm.AddMenuItem(quest_id, 4);
        else if (GetQuestStatus(quest_id) == QUEST_STATUS_NONE)
            qm.AddMenuItem(quest_id, 2);
    }
}

bool Player::HasQuest(uint32 questId) const
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (questid == questId)
        {
            return true;
        }
    }

    return false;
}

void Player::SendPreparedQuest(ObjectGuid guid)
{
    QuestMenu& questMenu = PlayerTalkClass->GetQuestMenu();
    if (questMenu.Empty())
        return;

    // single element case
    if (questMenu.GetMenuItemCount() == 1)
    {
        QuestMenuItem const& qmi0 = questMenu.GetItem(0);
        uint32 questId = qmi0.QuestId;

        // Auto open -- maybe also should verify there is no greeting
        if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
        {
            if (qmi0.QuestIcon == 4)
                PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, CanRewardQuest(quest, false), true);
                // Send completable on repeatable and autoCompletable quest if player don't have quest
                /// @todo verify if check for !quest->IsDaily() is really correct (possibly not)
            else
            {
                Object* object = ObjectAccessor::GetObjectByTypeMask(*this, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT | TYPEMASK_ITEM);
                if (!object || (!object->hasQuest(questId) && !object->hasInvolvedQuest(questId)))
                {
                    PlayerTalkClass->SendCloseGossip();
                    return;
                }

                if (quest->IsAutoAccept() && CanAddQuest(quest, true) && CanTakeQuest(quest, true))
                    AddQuestAndCheckCompletion(quest, object);

                if (quest->IsAutoComplete() || !quest->GetQuestMethod())
                    PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, CanCompleteRepeatableQuest(quest), true);
                else
                    PlayerTalkClass->SendQuestGiverQuestDetails(quest, guid, true);
            }
        }
    }
    // multiple entries
    else
    {
        QEmote qe;
        qe._Delay = 0;
        qe._Emote = 0;
        std::string title = "";

        // need pet case for some quests
        Creature* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, guid);
        if (creature)
        {
            uint32 textid = GetGossipTextId(creature);
            GossipText const* gossiptext = sObjectMgr->GetGossipText(textid);
            if (!gossiptext)
            {
                qe._Delay = 0;                              //TEXTEMOTE_MESSAGE;              //zyg: player emote
                qe._Emote = 0;                              //TEXTEMOTE_HELLO;                //zyg: NPC emote
                title = "";
            }
            else
            {
                qe = gossiptext->Options[0].Emotes[0];

                if (!gossiptext->Options[0].Text_0.empty())
                {
                    title = gossiptext->Options[0].Text_0;

                    int loc_idx = GetSession()->GetSessionDbLocaleIndex();
                    if (loc_idx >= 0)
                        if (NpcTextLocale const* npcTextLocale = sObjectMgr->GetNpcTextLocale(textid))
                            ObjectMgr::GetLocaleString(npcTextLocale->Text_0[0], loc_idx, title);
                }
                else
                {
                    title = gossiptext->Options[0].Text_1;

                    int loc_idx = GetSession()->GetSessionDbLocaleIndex();
                    if (loc_idx >= 0)
                        if (NpcTextLocale const* npcTextLocale = sObjectMgr->GetNpcTextLocale(textid))
                            ObjectMgr::GetLocaleString(npcTextLocale->Text_1[0], loc_idx, title);
                }
            }
        }

        PlayerTalkClass->SendQuestGiverQuestList(qe, title, guid);
    }
}

bool Player::IsActiveQuest(uint32 quest_id) const
{
    return m_QuestStatus.find(quest_id) != m_QuestStatus.end();
}

Quest const* Player::GetNextQuest(ObjectGuid guid, Quest const* quest)
{
    QuestRelationBounds objectQR;

    Creature* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, guid);
    if (creature)
        objectQR  = sObjectMgr->GetCreatureQuestRelationBounds(creature->GetEntry());
    else
    {
        //we should obtain map pointer from GetMap() in 99% of cases. Special case
        //only for quests which cast teleport spells on player
        Map* _map = IsInWorld() ? GetMap() : sMapMgr->FindMap(GetMapId(), GetInstanceId());
        ASSERT(_map);
        GameObject* pGameObject = _map->GetGameObject(guid);
        if (pGameObject)
            objectQR  = sObjectMgr->GetGOQuestRelationBounds(pGameObject->GetEntry());
        else
            return nullptr;
    }

    uint32 nextQuestID = quest->GetNextQuestInChain();
    for (QuestRelations::const_iterator itr = objectQR.first; itr != objectQR.second; ++itr)
    {
        if (itr->second == nextQuestID)
            return sObjectMgr->GetQuestTemplate(nextQuestID);
    }

    return nullptr;
}

bool Player::CanSeeStartQuest(Quest const* quest)
{
    if (!DisableMgr::IsDisabledFor(DISABLE_TYPE_QUEST, quest->GetQuestId(), this) && SatisfyQuestClass(quest, false) && SatisfyQuestRace(quest, false) &&
        SatisfyQuestSkill(quest, false) && SatisfyQuestExclusiveGroup(quest, false) && SatisfyQuestReputation(quest, false) &&
        SatisfyQuestPreviousQuest(quest, false) && SatisfyQuestNextChain(quest, false) &&
        SatisfyQuestPrevChain(quest, false) && SatisfyQuestDay(quest, false) && SatisfyQuestWeek(quest, false) &&
        SatisfyQuestMonth(quest, false) && SatisfyQuestSeasonal(quest, false))
    {
        return GetLevel() + sWorld->getIntConfig(CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF) >= quest->GetMinLevel();
    }

    return false;
}

bool Player::CanTakeQuest(Quest const* quest, bool msg)
{
    return !DisableMgr::IsDisabledFor(DISABLE_TYPE_QUEST, quest->GetQuestId(), this)
           && SatisfyQuestStatus(quest, msg) && SatisfyQuestExclusiveGroup(quest, msg)
           && SatisfyQuestClass(quest, msg) && SatisfyQuestRace(quest, msg) && SatisfyQuestLevel(quest, msg)
           && SatisfyQuestSkill(quest, msg) && SatisfyQuestReputation(quest, msg)
           && SatisfyQuestPreviousQuest(quest, msg) && SatisfyQuestTimed(quest, msg)
           && SatisfyQuestNextChain(quest, msg) && SatisfyQuestPrevChain(quest, msg)
           && SatisfyQuestDay(quest, msg) && SatisfyQuestWeek(quest, msg)
           && SatisfyQuestMonth(quest, msg) && SatisfyQuestSeasonal(quest, msg)
           && SatisfyQuestConditions(quest, msg);
}

bool Player::CanAddQuest(Quest const* quest, bool msg)
{
    if (!SatisfyQuestLog(msg))
        return false;

    uint32 srcitem = quest->GetSrcItemId();
    if (srcitem > 0)
    {
        uint32 count = quest->GetSrcItemCount();
        ItemPosCountVec dest;
        InventoryResult msg2 = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, srcitem, count);

        // player already have max number (in most case 1) source item, no additional item needed and quest can be added.
        if (msg2 == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
            return true;
        else if (msg2 != EQUIP_ERR_OK)
        {
            SendEquipError(msg2, nullptr, nullptr, srcitem);
            return false;
        }
    }
    return true;
}

bool Player::CanCompleteQuest(uint32 quest_id, const QuestStatusData* q_savedStatus)
{
    if (quest_id)
    {
        Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
        if (!qInfo)
            return false;

        // Xinef: take seasonals into account
        if(!qInfo->IsRepeatable() && !qInfo->IsSeasonal() && IsQuestRewarded(quest_id))
            return false;                                   // not allow re-complete quest

        // auto complete quest
        if ((qInfo->IsAutoComplete() || !qInfo->GetQuestMethod()) && CanTakeQuest(qInfo, false))
            return true;

        QuestStatusData q_status;
        if (q_savedStatus)
            q_status = *q_savedStatus;
        else
        {
            QuestStatusMap::const_iterator itr = m_QuestStatus.find(quest_id);
            if (itr == m_QuestStatus.end())
                return false;

            q_status = itr->second;
        }

        if (q_status.Status == QUEST_STATUS_INCOMPLETE)
        {
            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
            {
                for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
                {
                    if (qInfo->RequiredItemCount[i] != 0 && q_status.ItemCount[i] < qInfo->RequiredItemCount[i])
                        return false;
                }
            }

            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL | QUEST_SPECIAL_FLAGS_CAST | QUEST_SPECIAL_FLAGS_SPEAKTO))
            {
                for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
                {
                    if (qInfo->RequiredNpcOrGo[i] == 0)
                        continue;

                    if (qInfo->RequiredNpcOrGoCount[i] != 0 && q_status.CreatureOrGOCount[i] < qInfo->RequiredNpcOrGoCount[i])
                        return false;
                }
            }

            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_PLAYER_KILL))
                if (qInfo->GetPlayersSlain() != 0 && q_status.PlayerCount < qInfo->GetPlayersSlain())
                    return false;

            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT) && !q_status.Explored)
                return false;

            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED) && q_status.Timer == 0)
                return false;

            if (qInfo->GetRewOrReqMoney() < 0)
            {
                if (!HasEnoughMoney(-qInfo->GetRewOrReqMoney()))
                    return false;
            }

            uint32 repFacId = qInfo->GetRepObjectiveFaction();
            if (repFacId && GetReputationMgr().GetReputation(repFacId) < qInfo->GetRepObjectiveValue())
                return false;

            return true;
        }
    }
    return false;
}

bool Player::CanCompleteRepeatableQuest(Quest const* quest)
{
    // Solve problem that player don't have the quest and try complete it.
    // if repeatable she must be able to complete event if player don't have it.
    // Seem that all repeatable quest are DELIVER Flag so, no need to add more.
    if (!CanTakeQuest(quest, false))
        return false;

    if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
        for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
            if (quest->RequiredItemId[i] && quest->RequiredItemCount[i] && !HasItemCount(quest->RequiredItemId[i], quest->RequiredItemCount[i]))
                return false;

    if (!CanRewardQuest(quest, false))
        return false;

    return true;
}

bool Player::CanRewardQuest(Quest const* quest, bool msg)
{
    // not auto complete quest and not completed quest (only cheating case, then ignore without message)
    if (!quest->IsDFQuest() && !quest->IsAutoComplete() && quest->GetQuestMethod() && GetQuestStatus(quest->GetQuestId()) != QUEST_STATUS_COMPLETE)
        return false;

    // daily quest can't be rewarded (25 daily quest already completed)
    if (!SatisfyQuestDay(quest, true) || !SatisfyQuestWeek(quest, true) || !SatisfyQuestMonth(quest, true) || !SatisfyQuestSeasonal(quest, true))
        return false;

    // rewarded and not repeatable quest (only cheating case, then ignore without message)
    if (GetQuestRewardStatus(quest->GetQuestId()))
        return false;

    // prevent receive reward with quest items in bank
    if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
    {
        for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
        {
            if (quest->RequiredItemCount[i] != 0 &&
                GetItemCount(quest->RequiredItemId[i]) < quest->RequiredItemCount[i])
            {
                if (msg)
                    SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, nullptr, nullptr, quest->RequiredItemId[i]);
                return false;
            }
        }
    }

    // prevent receive reward with low money and GetRewOrReqMoney() < 0
    if (quest->GetRewOrReqMoney() < 0 && !HasEnoughMoney(-quest->GetRewOrReqMoney()))
        return false;

    return true;
}

void Player::AddQuestAndCheckCompletion(Quest const* quest, Object* questGiver)
{
    AddQuest(quest, questGiver);

    if (CanCompleteQuest(quest->GetQuestId()))
        CompleteQuest(quest->GetQuestId());

    if (!questGiver)
        return;

    switch (questGiver->GetTypeId())
    {
        case TYPEID_UNIT:
            sScriptMgr->OnQuestAccept(this, questGiver->ToCreature(), quest);
            questGiver->ToCreature()->AI()->sQuestAccept(this, quest);
            break;
        case TYPEID_ITEM:
        case TYPEID_CONTAINER:
        {
            Item* item = (Item*)questGiver;
            sScriptMgr->OnQuestAccept(this, item, quest);

            // destroy not required for quest finish quest starting item
            bool destroyItem = true;
            for (int i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
            {
                if (quest->RequiredItemId[i] == item->GetEntry() && item->GetTemplate()->MaxCount > 0)
                {
                    destroyItem = false;
                    break;
                }
            }

            if (destroyItem)
                DestroyItem(item->GetBagSlot(), item->GetSlot(), true);

            break;
        }
        case TYPEID_GAMEOBJECT:
            sScriptMgr->OnQuestAccept(this, questGiver->ToGameObject(), quest);
            questGiver->ToGameObject()->AI()->QuestAccept(this, quest);
            break;
        default:
            break;
    }
}

bool Player::CanRewardQuest(Quest const* quest, uint32 reward, bool msg)
{
    // prevent receive reward with quest items in bank or for not completed quest
    if (!CanRewardQuest(quest, msg))
        return false;

    ItemPosCountVec dest;
    if (quest->GetRewChoiceItemsCount() > 0)
    {
        if (quest->RewardChoiceItemId[reward])
        {
            InventoryResult res = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, quest->RewardChoiceItemId[reward], quest->RewardChoiceItemCount[reward]);
            if (res != EQUIP_ERR_OK)
            {
                SendEquipError(res, nullptr, nullptr, quest->RewardChoiceItemId[reward]);
                return false;
            }
        }
    }

    if (quest->GetRewItemsCount() > 0)
    {
        for (uint32 i = 0; i < quest->GetRewItemsCount(); ++i)
        {
            if (quest->RewardItemId[i])
            {
                InventoryResult res = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, quest->RewardItemId[i], quest->RewardItemIdCount[i]);
                if (res != EQUIP_ERR_OK)
                {
                    SendEquipError(res, nullptr, nullptr, quest->RewardItemId[i]);
                    return false;
                }
            }
        }
    }

    return true;
}

void Player::AddQuest(Quest const* quest, Object* questGiver)
{
    uint16 log_slot = FindQuestSlot(0);

    if (log_slot >= MAX_QUEST_LOG_SIZE) // Player does not have any free slot in the quest log
        return;

    uint32 quest_id = quest->GetQuestId();

    // if not exist then created with set uState == NEW and rewarded=false
    QuestStatusData& questStatusData = m_QuestStatus[quest_id];

    // check for repeatable quests status reset
    questStatusData.Status = QUEST_STATUS_INCOMPLETE;
    questStatusData.Explored = false;

    if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
    {
        for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
            questStatusData.ItemCount[i] = 0;
    }

    if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL | QUEST_SPECIAL_FLAGS_CAST | QUEST_SPECIAL_FLAGS_SPEAKTO))
    {
        for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
            questStatusData.CreatureOrGOCount[i] = 0;
    }

    if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_PLAYER_KILL))
        questStatusData.PlayerCount = 0;

    GiveQuestSourceItem(quest);
    AdjustQuestReqItemCount(quest, questStatusData);

    if (quest->GetRepObjectiveFaction())
        if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(quest->GetRepObjectiveFaction()))
            GetReputationMgr().SetVisible(factionEntry);

    if (quest->GetRepObjectiveFaction2())
        if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(quest->GetRepObjectiveFaction2()))
            GetReputationMgr().SetVisible(factionEntry);

    uint32 qtime = 0;
    if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
    {
        uint32 timeAllowed = quest->GetTimeAllowed();

        // shared timed quest
        if (questGiver && questGiver->GetTypeId() == TYPEID_PLAYER)
            timeAllowed = questGiver->ToPlayer()->getQuestStatusMap()[quest_id].Timer / IN_MILLISECONDS;

        AddTimedQuest(quest_id);
        questStatusData.Timer = timeAllowed * IN_MILLISECONDS;
        qtime = static_cast<uint32>(GameTime::GetGameTime().count()) + timeAllowed;
    }
    else
        questStatusData.Timer = 0;

    if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
    {
        pvpInfo.IsHostile = true;
        UpdatePvPState();
    }

    SetQuestSlot(log_slot, quest_id, qtime);

    m_QuestStatusSave[quest_id] = true;

    StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_QUEST, quest_id);

    SendQuestUpdate(quest_id);

    // check if Quest Tracker is enabled
    if (sWorld->getBoolConfig(CONFIG_QUEST_ENABLE_QUEST_TRACKER))
    {
        // prepare Quest Tracker datas
        auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_QUEST_TRACK);
        stmt->SetData(0, quest_id);
        stmt->SetData(1, GetGUID().GetCounter());
        stmt->SetData(2, GitRevision::GetHash());
        stmt->SetData(3, GitRevision::GetDate());

        // add to Quest Tracker
        CharacterDatabase.Execute(stmt);
    }

    // Xinef: area auras may change on quest accept!
    UpdateZoneDependentAuras(GetZoneId());
    UpdateAreaDependentAuras(GetAreaId());
}

void Player::CompleteQuest(uint32 quest_id)
{
    if (!quest_id)
    {
        return;
    }

    if (!sScriptMgr->OnBeforePlayerQuestComplete(this, quest_id))
    {
        return;
    }

    SetQuestStatus(quest_id, QUEST_STATUS_COMPLETE);

    auto log_slot = FindQuestSlot(quest_id);
    if (log_slot < MAX_QUEST_LOG_SIZE)
    {
        SetQuestSlotState(log_slot, QUEST_STATE_COMPLETE);
    }

    Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
    if (qInfo && qInfo->HasFlag(QUEST_FLAGS_TRACKING))
    {
        RewardQuest(qInfo, 0, this, false);
    }

    // Xinef: area auras may change on quest completion!
    UpdateZoneDependentAuras(GetZoneId());
    UpdateAreaDependentAuras(GetAreaId());
    AdditionalSavingAddMask(ADDITIONAL_SAVING_INVENTORY_AND_GOLD | ADDITIONAL_SAVING_QUEST_STATUS);

    // check if Quest Tracker is enabled
    if (sWorld->getBoolConfig(CONFIG_QUEST_ENABLE_QUEST_TRACKER))
    {
        // prepare Quest Tracker datas
        auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_COMPLETE_TIME);
        stmt->SetData(0, quest_id);
        stmt->SetData(1, GetGUID().GetCounter());

        // add to Quest Tracker
        CharacterDatabase.Execute(stmt);
    }
}

void Player::IncompleteQuest(uint32 quest_id)
{
    if (quest_id)
    {
        SetQuestStatus(quest_id, QUEST_STATUS_INCOMPLETE);

        uint16 log_slot = FindQuestSlot(quest_id);
        if (log_slot < MAX_QUEST_LOG_SIZE)
            RemoveQuestSlotState(log_slot, QUEST_STATE_COMPLETE);

        // Xinef: area auras may change on quest completion!
        UpdateZoneDependentAuras(GetZoneId());
        UpdateAreaDependentAuras(GetAreaId());
        AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);
    }
}

void Player::RewardQuest(Quest const* quest, uint32 reward, Object* questGiver, bool announce, bool isLFGReward)
{
    //this THING should be here to protect code from quest, which cast on player far teleport as a reward
    //should work fine, cause far teleport will be executed in Player::Update()
    SetMustDelayTeleport(true);

    uint32 quest_id = quest->GetQuestId();

    for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
    {
        if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->RequiredItemId[i]))
        {
            if (quest->RequiredItemCount[i] > 0 && itemTemplate->Bonding == BIND_QUEST_ITEM && !quest->IsRepeatable() && !HasQuestForItem(quest->RequiredItemId[i], quest_id, true))
                DestroyItemCount(quest->RequiredItemId[i], 9999, true);
            else
                DestroyItemCount(quest->RequiredItemId[i], quest->RequiredItemCount[i], true);
        }
    }
    for (uint8 i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
    {
        if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->ItemDrop[i]))
        {
            if (quest->ItemDropQuantity[i] > 0 && itemTemplate->Bonding == BIND_QUEST_ITEM && !quest->IsRepeatable() && !HasQuestForItem(quest->ItemDrop[i], quest_id))
                DestroyItemCount(quest->ItemDrop[i], 9999, true);
            else
                DestroyItemCount(quest->ItemDrop[i], quest->ItemDropQuantity[i], true);
        }
    }

    RemoveTimedQuest(quest_id);

    std::vector<std::pair<uint32, uint32>> problematicItems;

    if (quest->GetRewChoiceItemsCount())
    {
        if (uint32 itemId = quest->RewardChoiceItemId[reward])
        {
            ItemPosCountVec dest;
            if (CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, quest->RewardChoiceItemCount[reward]) == EQUIP_ERR_OK)
            {
                Item* item = StoreNewItem(dest, itemId, true);
                SendNewItem(item, quest->RewardChoiceItemCount[reward], true, false, false, false);

                sScriptMgr->OnQuestRewardItem(this, item, quest->RewardChoiceItemCount[reward]);
            }
            else
            {
                problematicItems.emplace_back(itemId, quest->RewardChoiceItemCount[reward]);
            }
        }
    }

    if (quest->GetRewItemsCount())
    {
        for (uint32 i = 0; i < quest->GetRewItemsCount(); ++i)
        {
            if (uint32 itemId = quest->RewardItemId[i])
            {
                ItemPosCountVec dest;
                if (CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, quest->RewardItemIdCount[i]) == EQUIP_ERR_OK)
                {
                    Item* item = StoreNewItem(dest, itemId, true);
                    SendNewItem(item, quest->RewardItemIdCount[i], true, false, false, false);

                    sScriptMgr->OnQuestRewardItem(this, item, quest->RewardItemIdCount[i]);
                }
                else
                    problematicItems.emplace_back(itemId, quest->RewardItemIdCount[i]);
            }
        }
    }

    // Xinef: send items that couldn't be added properly by mail
    if (!problematicItems.empty())
    {
        SendItemRetrievalMail(problematicItems);
    }

    RewardReputation(quest);

    uint16 log_slot = FindQuestSlot(quest_id);
    if (log_slot < MAX_QUEST_LOG_SIZE)
        SetQuestSlot(log_slot, 0);

    bool rewarded = IsQuestRewarded(quest_id) && !quest->IsDFQuest();

    // Not give XP in case already completed once repeatable quest
    uint32 XP = rewarded ? 0 : uint32(quest->XPValue(GetLevel()) * GetQuestRate(quest->IsDFQuest()));

    // handle SPELL_AURA_MOD_XP_QUEST_PCT auras
    Unit::AuraEffectList const& ModXPPctAuras = GetAuraEffectsByType(SPELL_AURA_MOD_XP_QUEST_PCT);
    for (Unit::AuraEffectList::const_iterator i = ModXPPctAuras.begin(); i != ModXPPctAuras.end(); ++i)
        AddPct(XP, (*i)->GetAmount());

    sScriptMgr->OnQuestComputeXP(this, quest, XP);
    int32 moneyRew = 0;
    if (GetLevel() >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL) || sScriptMgr->ShouldBeRewardedWithMoneyInsteadOfExp(this))
    {
        moneyRew = quest->GetRewMoneyMaxLevel();
    }
    else
    {
        sScriptMgr->OnGivePlayerXP(this, XP, nullptr, isLFGReward ? PlayerXPSource::XPSOURCE_QUEST_DF : PlayerXPSource::XPSOURCE_QUEST);
        GiveXP(XP, nullptr, isLFGReward);
    }

    // Give player extra money if GetRewOrReqMoney > 0 and get ReqMoney if negative
    if (int32 rewOrReqMoney = quest->GetRewOrReqMoney(GetLevel()))
    {
        moneyRew += rewOrReqMoney;
    }

    if (moneyRew)
    {
        ModifyMoney(moneyRew);

        if (moneyRew > 0)
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_MONEY_FROM_QUEST_REWARD, uint32(moneyRew));
    }

    // honor reward
    if (uint32 honor = quest->CalculateHonorGain(GetLevel()))
        RewardHonor(nullptr, 0, honor);

    // title reward
    if (quest->GetCharTitleId())
    {
        if (CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(quest->GetCharTitleId()))
            SetTitle(titleEntry);
    }

    if (quest->GetBonusTalents())
    {
        m_questRewardTalentCount += quest->GetBonusTalents();
        InitTalentForLevel();
    }

    if (quest->GetRewArenaPoints())
        ModifyArenaPoints(quest->GetRewArenaPoints());

    // Send reward mail
    if (uint32 mail_template_id = quest->GetRewMailTemplateId())
    {
        //- TODO: Poor design of mail system
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        if (quest->GetRewMailSenderEntry() != 0)
            MailDraft(mail_template_id).SendMailTo(trans, this, quest->GetRewMailSenderEntry(), MAIL_CHECK_MASK_HAS_BODY, quest->GetRewMailDelaySecs());
        else
            MailDraft(mail_template_id).SendMailTo(trans, this, questGiver, MAIL_CHECK_MASK_HAS_BODY, quest->GetRewMailDelaySecs());
        CharacterDatabase.CommitTransaction(trans);
    }

    if (quest->IsDaily() || quest->IsDFQuest())
    {
        SetDailyQuestStatus(quest_id);
        if (quest->IsDaily())
        {
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST, quest_id);
            UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST_DAILY, quest_id);
        }
    }
    else if (quest->IsWeekly())
        SetWeeklyQuestStatus(quest_id);
    else if (quest->IsMonthly())
        SetMonthlyQuestStatus(quest_id);
    else if (quest->IsSeasonal())
        SetSeasonalQuestStatus(quest_id);

    RemoveActiveQuest(quest_id, false);
    m_RewardedQuests.insert(quest_id);
    m_RewardedQuestsSave[quest_id] = true;

    if (announce)
        SendQuestReward(quest, XP);

    // cast spells after mark quest complete (some spells have quest completed state requirements in spell_area data)
    if (quest->GetRewSpellCast() > 0)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(quest->GetRewSpellCast());
        if (questGiver->isType(TYPEMASK_UNIT) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL) && !spellInfo->HasEffect(SPELL_EFFECT_CREATE_ITEM) && !spellInfo->IsSelfCast())
        {
            if (Creature* creature = GetMap()->GetCreature(questGiver->GetGUID()))
                creature->CastSpell(this, quest->GetRewSpellCast(), true);
        }
        else
            CastSpell(this, quest->GetRewSpellCast(), true);
    }
    else if (quest->GetRewSpell() > 0)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(quest->GetRewSpell());
        if (questGiver->isType(TYPEMASK_UNIT) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL) && !spellInfo->HasEffect(SPELL_EFFECT_CREATE_ITEM) && !spellInfo->IsSelfCast())
        {
            if (Creature* creature = GetMap()->GetCreature(questGiver->GetGUID()))
                creature->CastSpell(this, quest->GetRewSpell(), true);
        }
        else
            CastSpell(this, quest->GetRewSpell(), true);
    }

    if (quest->GetZoneOrSort() > 0)
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUESTS_IN_ZONE, quest->GetZoneOrSort());
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST_COUNT);
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST, quest->GetQuestId());

    // pussywizard: replaced partial save with full save
    SaveToDB(false, false);

    if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
    {
        pvpInfo.IsHostile = pvpInfo.IsInHostileArea || HasPvPForcingQuest();
        UpdatePvPState();
    }

    SendQuestUpdate(quest_id);

    SendQuestGiverStatusMultiple();

    //lets remove flag for delayed teleports
    SetMustDelayTeleport(false);

    // Xinef: area auras may change on quest completion!
    UpdateZoneDependentAuras(GetZoneId());
    UpdateAreaDependentAuras(GetAreaId());

    sScriptMgr->OnPlayerCompleteQuest(this, quest);
}

void Player::FailQuest(uint32 questId)
{
    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        QuestStatus qStatus = GetQuestStatus(questId);
        // xinef: if quest is marked as failed, dont do it again
        if ((qStatus != QUEST_STATUS_INCOMPLETE) && (!quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED)))
            return;

        SetQuestStatus(questId, QUEST_STATUS_FAILED);

        uint16 log_slot = FindQuestSlot(questId);

        if (log_slot < MAX_QUEST_LOG_SIZE)
        {
            SetQuestSlotTimer(log_slot, 1);
            SetQuestSlotState(log_slot, QUEST_STATE_FAIL);
        }

        if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
        {
            QuestStatusData& q_status = m_QuestStatus[questId];

            RemoveTimedQuest(questId);
            q_status.Timer = 0;

            SendQuestTimerFailed(questId);
        }
        else
            SendQuestFailed(questId);

        // Destroy quest items on quest failure.
        for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
            if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->RequiredItemId[i]))
                if (quest->RequiredItemCount[i] > 0 && itemTemplate->Bonding == BIND_QUEST_ITEM)
                    DestroyItemCount(quest->RequiredItemId[i], quest->RequiredItemCount[i], true);

        for (uint8 i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
            if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->ItemDrop[i]))
                if (quest->ItemDropQuantity[i] > 0 && itemTemplate->Bonding == BIND_QUEST_ITEM)
                    DestroyItemCount(quest->ItemDrop[i], quest->ItemDropQuantity[i], true);
    }
}

void Player::AbandonQuest(uint32 questId)
{
    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        // It will Destroy quest items on quests abandons.
        for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
            if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->RequiredItemId[i]))
                if (quest->RequiredItemCount[i] > 0 && itemTemplate->Bonding == BIND_QUEST_ITEM)
                    DestroyItemCount(quest->RequiredItemId[i], quest->RequiredItemCount[i], true);

        for (uint8 i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
            if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->ItemDrop[i]))
                if (quest->ItemDropQuantity[i] > 0 && itemTemplate->Bonding == BIND_QUEST_ITEM)
                    DestroyItemCount(quest->ItemDrop[i], quest->ItemDropQuantity[i], true);
    }
}

bool Player::SatisfyQuestSkill(Quest const* qInfo, bool msg) const
{
    uint32 skill = qInfo->GetRequiredSkill();

    // skip 0 case RequiredSkill
    if (skill == 0)
        return true;

    // check skill value
    if (GetBaseSkillValue(skill) < qInfo->GetRequiredSkillValue())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

        return false;
    }

    return true;
}

bool Player::SatisfyQuestLevel(Quest const* qInfo, bool msg) const
{
    if (GetLevel() < qInfo->GetMinLevel())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_QUEST_FAILED_LOW_LEVEL);
        return false;
    }
    else if (qInfo->GetMaxLevel() > 0 && GetLevel() > qInfo->GetMaxLevel())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ); // There doesn't seem to be a specific response for too high player level
        return false;
    }
    return true;
}

bool Player::SatisfyQuestLog(bool msg)
{
    // exist free slot
    if (FindQuestSlot(0) < MAX_QUEST_LOG_SIZE)
        return true;

    if (msg)
    {
        WorldPacket data(SMSG_QUESTLOG_FULL, 0);
        GetSession()->SendPacket(&data);
        LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTLOG_FULL");
    }
    return false;
}

bool Player::SatisfyQuestPreviousQuest(Quest const* qInfo, bool msg) const
{
    // No previous quest (might be first quest in a series)
    if (qInfo->prevQuests.empty())
        return true;

    for (Quest::PrevQuests::const_iterator iter = qInfo->prevQuests.begin(); iter != qInfo->prevQuests.end(); ++iter)
    {
        uint32 prevId = std::abs(*iter);

        Quest const* qPrevInfo = sObjectMgr->GetQuestTemplate(prevId);

        if (qPrevInfo)
        {
            // If any of the positive previous quests completed, return true
            if (*iter > 0 && IsQuestRewarded(prevId) && (!qPrevInfo->IsSeasonal() || !SatisfyQuestSeasonal(qPrevInfo, false)))
            {
                // skip one-from-all exclusive group
                if (qPrevInfo->GetExclusiveGroup() >= 0)
                    return true;

                // each-from-all exclusive group (< 0)
                // can be start if only all quests in prev quest exclusive group completed and rewarded
                ObjectMgr::ExclusiveQuestGroupsBounds range(sObjectMgr->mExclusiveQuestGroups.equal_range(qPrevInfo->GetExclusiveGroup()));

                for (; range.first != range.second; ++range.first)
                {
                    uint32 exclude_Id = range.first->second;

                    // skip checked quest id, only state of other quests in group is interesting
                    if (exclude_Id == prevId)
                        continue;

                    // alternative quest from group also must be completed and rewarded(reported)

                    Quest const* qExcludeInfo = sObjectMgr->GetQuestTemplate(exclude_Id);
                    if (!IsQuestRewarded(exclude_Id) || (qExcludeInfo->IsSeasonal() && SatisfyQuestSeasonal(qExcludeInfo, false)))
                    {
                        if (msg)
                            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
                        return false;
                    }
                }
                return true;
            }

            // If any of the negative previous quests active, return true
            if (*iter < 0 && GetQuestStatus(prevId) != QUEST_STATUS_NONE)
            {
                // skip one-from-all exclusive group
                if (qPrevInfo->GetExclusiveGroup() >= 0)
                    return true;

                // each-from-all exclusive group (< 0)
                // can be start if only all quests in prev quest exclusive group active
                ObjectMgr::ExclusiveQuestGroupsBounds range(sObjectMgr->mExclusiveQuestGroups.equal_range(qPrevInfo->GetExclusiveGroup()));

                for (; range.first != range.second; ++range.first)
                {
                    uint32 exclude_Id = range.first->second;

                    // skip checked quest id, only state of other quests in group is interesting
                    if (exclude_Id == prevId)
                        continue;

                    // alternative quest from group also must be active
                    if (GetQuestStatus(exclude_Id) != QUEST_STATUS_NONE)
                    {
                        if (msg)
                            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
                        return false;
                    }
                }
                return true;
            }
        }
    }

    // Has only positive prev. quests in non-rewarded state
    // and negative prev. quests in non-active state
    if (msg)
        SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

    return false;
}

bool Player::SatisfyQuestClass(Quest const* qInfo, bool msg) const
{
    uint32 reqClass = qInfo->GetRequiredClasses();

    if (reqClass == 0)
        return true;

    if ((reqClass & getClassMask()) == 0)
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

        return false;
    }

    return true;
}

bool Player::SatisfyQuestRace(Quest const* qInfo, bool msg) const
{
    uint32 reqraces = qInfo->GetAllowableRaces();
    if (reqraces == 0)
        return true;
    if ((reqraces & getRaceMask()) == 0)
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_QUEST_FAILED_WRONG_RACE);
        return false;
    }
    return true;
}

bool Player::SatisfyQuestReputation(Quest const* qInfo, bool msg) const
{
    uint32 fIdMin = qInfo->GetRequiredMinRepFaction();      //Min required rep
    if (fIdMin && GetReputationMgr().GetReputation(fIdMin) < qInfo->GetRequiredMinRepValue())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }

    uint32 fIdMax = qInfo->GetRequiredMaxRepFaction();      //Max required rep
    if (fIdMax && GetReputationMgr().GetReputation(fIdMax) >= qInfo->GetRequiredMaxRepValue())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }

    // ReputationObjective2 does not seem to be an objective requirement but a requirement
    // to be able to accept the quest
    uint32 fIdObj = qInfo->GetRepObjectiveFaction2();
    if (fIdObj && GetReputationMgr().GetReputation(fIdObj) >= qInfo->GetRepObjectiveValue2())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }

    return true;
}

bool Player::SatisfyQuestStatus(Quest const* qInfo, bool msg) const
{
    if (GetQuestStatus(qInfo->GetQuestId()) != QUEST_STATUS_NONE)
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_QUEST_ALREADY_ON);
        return false;
    }
    return true;
}

bool Player::SatisfyQuestConditions(Quest const* qInfo, bool msg)
{
    ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_QUEST_AVAILABLE, qInfo->GetQuestId());
    if (!sConditionMgr->IsObjectMeetToConditions(this, conditions))
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        LOG_DEBUG("condition", "Player::SatisfyQuestConditions: conditions not met for quest {}", qInfo->GetQuestId());
        return false;
    }
    return true;
}

bool Player::SatisfyQuestTimed(Quest const* qInfo, bool msg) const
{
    if (!m_timedquests.empty() && qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_QUEST_ONLY_ONE_TIMED);
        return false;
    }
    return true;
}

bool Player::SatisfyQuestExclusiveGroup(Quest const* qInfo, bool msg) const
{
    // non positive exclusive group, if > 0 then can be start if any other quest in exclusive group already started/completed
    if (qInfo->GetExclusiveGroup() <= 0)
        return true;

    ObjectMgr::ExclusiveQuestGroupsBounds range(sObjectMgr->mExclusiveQuestGroups.equal_range(qInfo->GetExclusiveGroup()));

    for (; range.first != range.second; ++range.first)
    {
        uint32 exclude_Id = range.first->second;

        // skip checked quest id, only state of other quests in group is interesting
        if (exclude_Id == qInfo->GetQuestId())
            continue;

        // not allow have daily quest if daily quest from exclusive group already recently completed
        Quest const* Nquest = sObjectMgr->GetQuestTemplate(exclude_Id);
        if (!SatisfyQuestDay(Nquest, false) || !SatisfyQuestWeek(Nquest, false) || !SatisfyQuestSeasonal(Nquest, false))
        {
            if (msg)
                SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

            return false;
        }

        // alternative quest already started or completed - but don't check rewarded states if both are repeatable
        if (GetQuestStatus(exclude_Id) != QUEST_STATUS_NONE || (!(qInfo->IsRepeatable() && Nquest->IsRepeatable()) && !Nquest->IsSeasonal() && IsQuestRewarded(exclude_Id))) // pussywizard: added !Nquest->IsSeasonal() because seasonal quests are considered rewarded only if finished this year, this is checked above in SatisfyQuestSeasonal
        {
            if (msg)
                SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
            return false;
        }
    }
    return true;
}

bool Player::SatisfyQuestNextChain(Quest const* qInfo, bool msg) const
{
    uint32 nextQuest = qInfo->GetNextQuestInChain();
    if (!nextQuest)
        return true;

    // next quest in chain already started or completed
    if (GetQuestStatus(nextQuest) != QUEST_STATUS_NONE) // GetQuestStatus returns QUEST_STATUS_COMPLETED for rewarded quests
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }

    // check for all quests further up the chain
    // only necessary if there are quest chains with more than one quest that can be skipped
    //return SatisfyQuestNextChain(qInfo->GetNextQuestInChain(), msg);
    return true;
}

bool Player::SatisfyQuestPrevChain(Quest const* qInfo, bool msg) const
{
    // No previous quest in chain
    if (qInfo->prevChainQuests.empty())
        return true;

    for (Quest::PrevChainQuests::const_iterator iter = qInfo->prevChainQuests.begin(); iter != qInfo->prevChainQuests.end(); ++iter)
    {
        QuestStatusMap::const_iterator itr = m_QuestStatus.find(*iter);

        // If any of the previous quests in chain active, return false
        if (itr != m_QuestStatus.end() && itr->second.Status != QUEST_STATUS_NONE)
        {
            if (msg)
                SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
            return false;
        }

        // check for all quests further down the chain
        // only necessary if there are quest chains with more than one quest that can be skipped
        //if (!SatisfyQuestPrevChain(prevId, msg))
        //    return false;
    }

    // No previous quest in chain active
    return true;
}

bool Player::SatisfyQuestDay(Quest const* qInfo, bool msg) const
{
    if (!qInfo->IsDaily() && !qInfo->IsDFQuest())
        return true;

    if (qInfo->IsDFQuest())
    {
        if (!m_DFQuests.empty())
            return false;

        return true;
    }

    bool have_slot = false;
    for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
    {
        uint32 id = GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx);
        if (qInfo->GetQuestId() == id)
            return false;

        if (!id)
            have_slot = true;
    }

    if (!have_slot)
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DAILY_QUESTS_REMAINING);
        return false;
    }

    return true;
}

bool Player::SatisfyQuestWeek(Quest const* qInfo, bool /*msg*/) const
{
    if (!qInfo->IsWeekly() || m_weeklyquests.empty())
        return true;

    // if not found in cooldown list
    return m_weeklyquests.find(qInfo->GetQuestId()) == m_weeklyquests.end();
}

bool Player::SatisfyQuestSeasonal(Quest const* qInfo, bool /*msg*/) const
{
    if (!qInfo->IsSeasonal() || m_seasonalquests.empty())
        return true;

    // cppcheck-suppress mismatchingContainers
    Player::SeasonalEventQuestMap::iterator itr = ((Player*)this)->m_seasonalquests.find(qInfo->GetEventIdForQuest());

    if (itr == m_seasonalquests.end() || itr->second.empty())
        return true;

    // if not found in cooldown list
    return itr->second.find(qInfo->GetQuestId()) == itr->second.end();
}

bool Player::SatisfyQuestMonth(Quest const* qInfo, bool /*msg*/) const
{
    if (!qInfo->IsMonthly() || m_monthlyquests.empty())
        return true;

    // if not found in cooldown list
    return m_monthlyquests.find(qInfo->GetQuestId()) == m_monthlyquests.end();
}

bool Player::GiveQuestSourceItem(Quest const* quest)
{
    uint32 srcitem = quest->GetSrcItemId();
    if (srcitem > 0)
    {
        uint32 count = quest->GetSrcItemCount();
        if (count <= 0)
            count = 1;

        ItemPosCountVec dest;
        InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, srcitem, count);
        if (msg == EQUIP_ERR_OK)
        {
            Item* item = StoreNewItem(dest, srcitem, true);
            SendNewItem(item, count, true, false);
            return true;
        }
            // player already have max amount required item, just report success
        else if (msg == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
            return true;
        else
            SendEquipError(msg, nullptr, nullptr, srcitem);
        return false;
    }

    return true;
}

bool Player::TakeQuestSourceItem(uint32 questId, bool msg)
{
    Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
    if (quest)
    {
        uint32 srcItemId = quest->GetSrcItemId();
        ItemTemplate const* item = sObjectMgr->GetItemTemplate(srcItemId);

        if (srcItemId > 0)
        {
            uint32 count = quest->GetSrcItemCount();
            if (count <= 0)
                count = 1;

            // exist two cases when destroy source quest item not possible:
            // a) non un-equippable item (equipped non-empty bag, for example)
            // b) when quest is started from an item and item also is needed in
            // the end as RequiredItemId
            InventoryResult res = CanUnequipItems(srcItemId, count);
            if (res != EQUIP_ERR_OK)
            {
                if (msg)
                    SendEquipError(res, nullptr, nullptr, srcItemId);
                return false;
            }

            bool destroyItem = true;
            for (uint8 n = 0; n < QUEST_ITEM_OBJECTIVES_COUNT; ++n)
                if (item->StartQuest == questId && srcItemId == quest->RequiredItemId[n])
                    destroyItem = false;

            if (destroyItem)
                DestroyItemCount(srcItemId, count, true, true);
        }
    }

    return true;
}

bool Player::GetQuestRewardStatus(uint32 quest_id) const
{
    Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
    if (qInfo)
    {
        if (qInfo->IsSeasonal())
            return !SatisfyQuestSeasonal(qInfo, false);

        // for repeatable quests: rewarded field is set after first reward only to prevent getting XP more than once
        if (!qInfo->IsRepeatable())
            return IsQuestRewarded(quest_id);
    }
    return false;
}

QuestStatus Player::GetQuestStatus(uint32 quest_id) const
{
    if (quest_id)
    {
        QuestStatusMap::const_iterator itr = m_QuestStatus.find(quest_id);

        if (itr != m_QuestStatus.end())
        {
            return itr->second.Status;
        }

        if (Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id))
        {
            if (qInfo->IsSeasonal())
            {
                return SatisfyQuestSeasonal(qInfo, false) ? QUEST_STATUS_NONE : QUEST_STATUS_REWARDED;
            }

            if (!qInfo->IsRepeatable() && IsQuestRewarded(quest_id))
            {
                return QUEST_STATUS_REWARDED;
            }
        }
    }

    return QUEST_STATUS_NONE;
}

bool Player::CanShareQuest(uint32 quest_id) const
{
    Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
    if (qInfo && qInfo->HasFlag(QUEST_FLAGS_SHARABLE))
    {
        QuestStatusMap::const_iterator itr = m_QuestStatus.find(quest_id);
        if (itr != m_QuestStatus.end())
        {
            // in pool and not currently available (wintergrasp weekly, dalaran weekly) - can't share
            if (sPoolMgr->IsPartOfAPool<Quest>(quest_id) && !sPoolMgr->IsSpawnedObject<Quest>(quest_id))
            {
                SendPushToPartyResponse(this, QUEST_PARTY_MSG_CANT_BE_SHARED_TODAY);
                return false;
            }

            return true;
        }
    }
    return false;
}

void Player::SetQuestStatus(uint32 questId, QuestStatus status, bool update /*= true*/)
{
    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        m_QuestStatus[questId].Status = status;

        if (quest->GetQuestMethod() && !quest->IsAutoComplete())
        {
            m_QuestStatusSave[questId] = true;
        }
    }

    if (update)
        SendQuestUpdate(questId);
}

void Player::RemoveActiveQuest(uint32 questId, bool update /*= true*/)
{
    QuestStatusMap::iterator itr = m_QuestStatus.find(questId);
    if (itr != m_QuestStatus.end())
    {
        m_QuestStatus.erase(itr);
        m_QuestStatusSave[questId] = false;
    }

    if (update)
        SendQuestUpdate(questId);

    // Xinef: area auras may change on quest remove!
    UpdateZoneDependentAuras(GetZoneId());
    UpdateAreaDependentAuras(GetAreaId());
    AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);
}

void Player::RemoveRewardedQuest(uint32 questId, bool update /*= true*/)
{
    RewardedQuestSet::iterator rewItr = m_RewardedQuests.find(questId);
    if (rewItr != m_RewardedQuests.end())
    {
        m_RewardedQuests.erase(rewItr);
        m_RewardedQuestsSave[questId] = false;
    }

    if (update)
        SendQuestUpdate(questId);
}

void Player::SendQuestUpdate(uint32 questId)
{
    uint32 zone = 0, area = 0;
    // xinef: fixup
    uint32 oldSpellId = 0;

    SpellAreaForQuestMapBounds saBounds = sSpellMgr->GetSpellAreaForQuestMapBounds(questId);
    if (saBounds.first != saBounds.second)
    {
        GetZoneAndAreaId(zone, area);

        for (SpellAreaForAreaMap::const_iterator itr = saBounds.first; itr != saBounds.second; ++itr)
        {
            // xinef: spell was already casted, skip different areas with same spell
            if (itr->second->spellId == oldSpellId)
                continue;
            if (itr->second->autocast && itr->second->IsFitToRequirements(this, zone, area))
                if (!HasAura(itr->second->spellId))
                {
                    CastSpell(this, itr->second->spellId, true);
                    oldSpellId = itr->second->spellId;
                }
        }
    }

    saBounds = sSpellMgr->GetSpellAreaForQuestEndMapBounds(questId);

    // xinef: fixup
    uint32 skipSpellId = 0;
    oldSpellId = 0;
    if (saBounds.first != saBounds.second)
    {
        if (!zone || !area)
            GetZoneAndAreaId(zone, area);

        for (SpellAreaForAreaMap::const_iterator itr = saBounds.first; itr != saBounds.second; ++itr)
        {
            // xinef: skip spell for which condition is already fulfilled
            if (itr->second->spellId == skipSpellId)
                continue;
            skipSpellId = 0;

            // xinef: spells are sorted, if no condition is fulfilled remove aura
            if (oldSpellId && oldSpellId != itr->second->spellId)
            {
                RemoveAurasDueToSpell(oldSpellId);
                oldSpellId = 0;
            }

            if (!itr->second->IsFitToRequirements(this, zone, area))
            {
                //RemoveAurasDueToSpell(itr->second->spellId);
                oldSpellId = itr->second->spellId;
            }
            else
            {
                skipSpellId = itr->second->spellId;
                oldSpellId = 0;
            }
        }

        // xinef: check if we have something to remove yet
        if (oldSpellId)
            RemoveAurasDueToSpell(oldSpellId);
    }

    UpdateForQuestWorldObjects();
}

QuestGiverStatus Player::GetQuestDialogStatus(Object* questgiver)
{
    QuestRelationBounds qr;
    QuestRelationBounds qir;

    sScriptMgr->GetDialogStatus(this, questgiver);

    switch (questgiver->GetTypeId())
    {
        case TYPEID_GAMEOBJECT:
        {
            QuestGiverStatus questStatus = QuestGiverStatus(sScriptMgr->GetDialogStatus(this, questgiver->ToGameObject()));
            if (questStatus != DIALOG_STATUS_SCRIPTED_NO_STATUS)
                return questStatus;
            qr = sObjectMgr->GetGOQuestRelationBounds(questgiver->GetEntry());
            qir = sObjectMgr->GetGOQuestInvolvedRelationBounds(questgiver->GetEntry());
            break;
        }
        case TYPEID_UNIT:
        {
            QuestGiverStatus questStatus = QuestGiverStatus(sScriptMgr->GetDialogStatus(this, questgiver->ToCreature()));
            if (questStatus != DIALOG_STATUS_SCRIPTED_NO_STATUS)
                return questStatus;
            qr = sObjectMgr->GetCreatureQuestRelationBounds(questgiver->GetEntry());
            qir = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(questgiver->GetEntry());
            break;
        }
        default:
            // it's impossible, but check
            //LOG_ERROR("entities.player.quest", "GetQuestDialogStatus called for unexpected type {}", questgiver->GetTypeId());
            return DIALOG_STATUS_NONE;
    }

    QuestGiverStatus result = DIALOG_STATUS_NONE;

    for (QuestRelations::const_iterator i = qir.first; i != qir.second; ++i)
    {
        QuestGiverStatus result2 = DIALOG_STATUS_NONE;
        uint32 questId = i->second;
        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            continue;

        ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_QUEST_AVAILABLE, quest->GetQuestId());
        if (!sConditionMgr->IsObjectMeetToConditions(this, conditions))
            continue;

        QuestStatus status = GetQuestStatus(questId);
        if (status == QUEST_STATUS_COMPLETE && !GetQuestRewardStatus(questId))
        {
            result2 = DIALOG_STATUS_REWARD;
        }
        else if (status == QUEST_STATUS_INCOMPLETE)
        {
            result2 = DIALOG_STATUS_INCOMPLETE;
        }

        if (quest->IsAutoComplete() && CanTakeQuest(quest, false) && quest->IsRepeatable() && !quest->IsDailyOrWeekly())
        {
            result2 = DIALOG_STATUS_REWARD_REP;
        }

        if (result2 > result)
        {
            result = result2;
        }
    }

    for (QuestRelations::const_iterator i = qr.first; i != qr.second; ++i)
    {
        QuestGiverStatus result2 = DIALOG_STATUS_NONE;
        uint32 questId = i->second;
        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            continue;

        ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_QUEST_AVAILABLE, quest->GetQuestId());
        if (!sConditionMgr->IsObjectMeetToConditions(this, conditions))
            continue;

        QuestStatus status = GetQuestStatus(questId);
        if (status == QUEST_STATUS_NONE)
        {
            if (CanSeeStartQuest(quest))
            {
                if (SatisfyQuestLevel(quest, false))
                {
                    bool isNotLowLevelQuest = GetLevel() <= (GetQuestLevel(quest) + sWorld->getIntConfig(CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF));

                    if (quest->IsRepeatable())
                    {
                        if (quest->IsDaily())
                        {
                            if (isNotLowLevelQuest)
                            {
                                result2 = DIALOG_STATUS_AVAILABLE_REP;
                            }
                            else
                            {
                                result2 = DIALOG_STATUS_LOW_LEVEL_AVAILABLE_REP;
                            }
                        }
                        else if (quest->IsWeekly() || quest->IsMonthly())
                        {
                            if (isNotLowLevelQuest)
                            {
                                result2 = DIALOG_STATUS_AVAILABLE;
                            }
                            else
                            {
                                result2 = DIALOG_STATUS_LOW_LEVEL_AVAILABLE;
                            }
                        }
                        else if (quest->IsAutoComplete())
                        {
                            if (isNotLowLevelQuest)
                            {
                                result2 = DIALOG_STATUS_REWARD_REP;
                            }
                            else
                            {
                                result2 = DIALOG_STATUS_LOW_LEVEL_REWARD_REP;
                            }
                        }
                        else
                        {
                            if (isNotLowLevelQuest)
                            {
                                result2 = DIALOG_STATUS_REWARD_REP;
                            }
                            else
                            {
                                result2 = DIALOG_STATUS_LOW_LEVEL_REWARD_REP;
                            }
                        }
                    }
                    else
                    {
                        result2 = isNotLowLevelQuest ? DIALOG_STATUS_AVAILABLE : DIALOG_STATUS_LOW_LEVEL_AVAILABLE;
                    }
                }
                else
                {
                    result2 = DIALOG_STATUS_UNAVAILABLE;
                }
            }
        }

        if (result2 > result)
            result = result2;
    }

    return result;
}

// not used in Trinity, but used in scripting code
uint16 Player::GetReqKillOrCastCurrentCount(uint32 quest_id, int32 entry)
{
    Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
    if (!qInfo)
        return 0;

    for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
        if (qInfo->RequiredNpcOrGo[j] == entry)
            return m_QuestStatus[quest_id].CreatureOrGOCount[j];

    return 0;
}

void Player::AdjustQuestReqItemCount(Quest const* quest, QuestStatusData& questStatusData)
{
    if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
    {
        for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
        {
            uint32 reqitemcount = quest->RequiredItemCount[i];
            if (reqitemcount != 0)
            {
                uint32 curitemcount = GetItemCount(quest->RequiredItemId[i], true);

                questStatusData.ItemCount[i] = std::min(curitemcount, reqitemcount);
                m_QuestStatusSave[quest->GetQuestId()] = true;
            }
        }
    }
}

uint16 Player::FindQuestSlot(uint32 quest_id) const
{
    for (uint16 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
        if (GetQuestSlotQuestId(i) == quest_id)
            return i;

    return MAX_QUEST_LOG_SIZE;
}

void Player::AreaExploredOrEventHappens(uint32 questId)
{
    if (questId)
    {
        uint16 log_slot = FindQuestSlot(questId);
        QuestStatusData* q_status = nullptr;
        if (log_slot < MAX_QUEST_LOG_SIZE)
        {
            q_status = &m_QuestStatus[questId];

            // xinef: added failed check
            if (!q_status->Explored && q_status->Status != QUEST_STATUS_FAILED)
            {
                q_status->Explored = true;
                m_QuestStatusSave[questId] = true;

                SendQuestComplete(questId);
            }
        }
        if (CanCompleteQuest(questId, q_status))
            CompleteQuest(questId);
        else
            AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);
    }
}

//not used in Trinityd, function for external script library
void Player::GroupEventHappens(uint32 questId, WorldObject const* pEventObject)
{
    if (Group* group = GetGroup())
    {
        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* player = itr->GetSource();

            // for any leave or dead (with not released body) group member at appropriate distance
            if (player && player->IsAtGroupRewardDistance(pEventObject) && !player->GetCorpse())
                player->AreaExploredOrEventHappens(questId);
        }
    }
    else
        AreaExploredOrEventHappens(questId);
}

void Player::ItemAddedQuestCheck(uint32 entry, uint32 count)
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (questid == 0)
            continue;

        QuestStatusData& q_status = m_QuestStatus[questid];

        if (q_status.Status != QUEST_STATUS_INCOMPLETE)
            continue;

        Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
        if (!qInfo || !qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
            continue;

        for (uint8 j = 0; j < QUEST_ITEM_OBJECTIVES_COUNT; ++j)
        {
            uint32 reqitem = qInfo->RequiredItemId[j];
            if (reqitem == entry)
            {
                uint32 reqitemcount = qInfo->RequiredItemCount[j];
                uint16 curitemcount = q_status.ItemCount[j];
                if (curitemcount < reqitemcount)
                {
                    q_status.ItemCount[j] = std::min<uint16>(q_status.ItemCount[j] + count, reqitemcount);
                    m_QuestStatusSave[questid] = true;
                }
                if (CanCompleteQuest(questid))
                    CompleteQuest(questid);
                else
                    AdditionalSavingAddMask(ADDITIONAL_SAVING_INVENTORY_AND_GOLD | ADDITIONAL_SAVING_QUEST_STATUS);
            }
        }
    }
    UpdateForQuestWorldObjects();
}

void Player::ItemRemovedQuestCheck(uint32 entry, uint32 count)
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
        if (!qInfo)
            continue;

        if (!qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
            continue;

        for (uint8 j = 0; j < QUEST_ITEM_OBJECTIVES_COUNT; ++j)
        {
            uint32 reqitem = qInfo->RequiredItemId[j];
            if (reqitem == entry)
            {
                QuestStatusData& q_status = m_QuestStatus[questid];
                uint32 reqitemcount = qInfo->RequiredItemCount[j];
                uint16 curitemcount = q_status.ItemCount[j];

                if (q_status.ItemCount[j] >= reqitemcount) // we may have more than what the status shows
                    curitemcount = GetItemCount(entry, false);

                uint16 newItemCount = (count > curitemcount) ? 0 : curitemcount - count;
                newItemCount = std::min<uint16>(newItemCount, reqitemcount);
                if (newItemCount != q_status.ItemCount[j])
                {
                    q_status.ItemCount[j] = newItemCount;
                    m_QuestStatusSave[questid] = true;
                    IncompleteQuest(questid);
                }
            }
        }
    }
    UpdateForQuestWorldObjects();
}

void Player::KilledMonster(CreatureTemplate const* cInfo, ObjectGuid guid)
{
    ASSERT(cInfo);

    if (cInfo->Entry)
        KilledMonsterCredit(cInfo->Entry, guid);

    for (uint8 i = 0; i < MAX_KILL_CREDIT; ++i)
        if (cInfo->KillCredit[i])
            KilledMonsterCredit(cInfo->KillCredit[i]);
}

void Player::KilledMonsterCredit(uint32 entry, ObjectGuid guid)
{
    uint16 addkillcount = 1;
    uint32 real_entry = entry;
    if (guid)
    {
        Creature* killed = GetMap()->GetCreature(guid);
        if (killed && killed->GetEntry())
            real_entry = killed->GetEntry();
    }

    StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_CREATURE, real_entry);   // MUST BE CALLED FIRST
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, real_entry, addkillcount, guid ? GetMap()->GetCreature(guid) : nullptr);

    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
        if (!qInfo)
            continue;
        // just if !ingroup || !noraidgroup || raidgroup
        // xinef: or is pvp quest, and player in BG/BF group
        QuestStatusData& q_status = m_QuestStatus[questid];
        if (q_status.Status == QUEST_STATUS_INCOMPLETE && (!GetGroup() || !GetGroup()->isRaidGroup() || qInfo->IsAllowedInRaid(GetMap()->GetDifficulty()) ||
                                                           (qInfo->IsPVPQuest() && (GetGroup()->isBFGroup() || GetGroup()->isBGGroup()))))
        {
            if (!sScriptMgr->PassedQuestKilledMonsterCredit(this, qInfo, entry, real_entry, guid))
                continue;

            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL) /*&& !qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_CAST)*/)
            {
                for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
                {
                    // skip GO activate objective or none
                    if (qInfo->RequiredNpcOrGo[j] <= 0)
                        continue;

                    uint32 reqkill = qInfo->RequiredNpcOrGo[j];

                    if (reqkill == real_entry)
                    {
                        uint32 reqkillcount = qInfo->RequiredNpcOrGoCount[j];
                        uint16 curkillcount = q_status.CreatureOrGOCount[j];
                        if (curkillcount < reqkillcount)
                        {
                            q_status.CreatureOrGOCount[j] = curkillcount + addkillcount;

                            m_QuestStatusSave[questid] = true;

                            SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curkillcount, addkillcount);
                        }
                        if (CanCompleteQuest(questid))
                            CompleteQuest(questid);
                        else
                            AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);

                        // same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
                        break;
                    }
                }
            }
        }
    }
}

void Player::KilledPlayerCredit(uint16 count)
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
        {
            continue;
        }

        Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
        if (!qInfo)
        {
            continue;
        }

        // just if !ingroup || !noraidgroup || raidgroup
        QuestStatusData& q_status = m_QuestStatus[questid];
        if (q_status.Status == QUEST_STATUS_INCOMPLETE && (!GetGroup() || !GetGroup()->isRaidGroup() || qInfo->IsAllowedInRaid(GetMap()->GetDifficulty())))
        {
            // Xinef: PvP Killing quest require player to be in same zone as quest zone (only 2 quests so no doubt, can be extended to conditions in cata ;s)
            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_PLAYER_KILL) && (qInfo->GetZoneOrSort() >= 0 && GetZoneId() == uint32(qInfo->GetZoneOrSort())))
            {
                KilledPlayerCreditForQuest(count, qInfo);
                break; // there is only one quest per zone
            }
        }
    }
}

void Player::KilledPlayerCreditForQuest(uint16 count, Quest const* quest)
{
    uint32 const questId = quest->GetQuestId();

    auto it = m_QuestStatus.find(questId);
    if (it == m_QuestStatus.end())
    {
        return;
    }

    QuestStatusData& questStatus = it->second;

    uint16 curKill = questStatus.PlayerCount;
    uint32 reqKill = quest->GetPlayersSlain();

    if (curKill < reqKill)
    {
        count = std::min<uint16>(reqKill - curKill, count);
        questStatus.PlayerCount = curKill + count;

        m_QuestStatusSave[quest->GetQuestId()] = true;

        SendQuestUpdateAddPlayer(quest, curKill, count);
    }

    if (CanCompleteQuest(questId))
    {
        CompleteQuest(questId);
    }
}

void Player::KillCreditGO(uint32 entry, ObjectGuid guid)
{
    uint16 addCastCount = 1;
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
        if (!qInfo)
            continue;

        QuestStatusData& q_status = m_QuestStatus[questid];

        if (q_status.Status == QUEST_STATUS_INCOMPLETE)
        {
            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_CAST) /*&& !qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL)*/)
            {
                for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
                {
                    uint32 reqTarget = 0;

                    // GO activate objective
                    if (qInfo->RequiredNpcOrGo[j] < 0)
                        // checked at quest_template loading
                        reqTarget = - qInfo->RequiredNpcOrGo[j];

                    // other not this creature/GO related objectives
                    if (reqTarget != entry)
                        continue;

                    uint32 reqCastCount = qInfo->RequiredNpcOrGoCount[j];
                    uint16 curCastCount = q_status.CreatureOrGOCount[j];
                    if (curCastCount < reqCastCount)
                    {
                        q_status.CreatureOrGOCount[j] = curCastCount + addCastCount;

                        m_QuestStatusSave[questid] = true;

                        SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curCastCount, addCastCount);
                    }

                    if (CanCompleteQuest(questid))
                        CompleteQuest(questid);
                    else
                        AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);

                    // same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
                    break;
                }
            }
        }
    }
}

void Player::TalkedToCreature(uint32 entry, ObjectGuid guid)
{
    uint16 addTalkCount = 1;
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
        if (!qInfo)
            continue;

        QuestStatusData& q_status = m_QuestStatus[questid];

        if (q_status.Status == QUEST_STATUS_INCOMPLETE)
        {
            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL | QUEST_SPECIAL_FLAGS_CAST | QUEST_SPECIAL_FLAGS_SPEAKTO))
            {
                for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
                {
                    // skip Gameobject objectives
                    if (qInfo->RequiredNpcOrGo[j] < 0)
                        continue;

                    uint32 reqTarget = 0;

                    if (qInfo->RequiredNpcOrGo[j] > 0)    // creature activate objectives
                        // checked at quest_template loading
                        reqTarget = qInfo->RequiredNpcOrGo[j];
                    else
                        continue;

                    if (reqTarget == entry)
                    {
                        uint32 reqTalkCount = qInfo->RequiredNpcOrGoCount[j];
                        uint16 curTalkCount = q_status.CreatureOrGOCount[j];
                        if (curTalkCount < reqTalkCount)
                        {
                            q_status.CreatureOrGOCount[j] = curTalkCount + addTalkCount;

                            m_QuestStatusSave[questid] = true;

                            SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curTalkCount, addTalkCount);
                        }
                        if (CanCompleteQuest(questid))
                            CompleteQuest(questid);
                        else
                            AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);

                        // same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
                        continue;
                    }
                }
            }
        }
    }
}

void Player::MoneyChanged(uint32 count)
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        if (Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid))
        {
            int32 rewOrReqMoney = qInfo->GetRewOrReqMoney();
            if (rewOrReqMoney < 0)
            {
                QuestStatusData& q_status = m_QuestStatus[questid];

                if (q_status.Status == QUEST_STATUS_INCOMPLETE)
                {
                    if (int32(count) >= -rewOrReqMoney)
                    {
                        if (CanCompleteQuest(questid))
                        {
                            CompleteQuest(questid);
                        }
                    }
                }
                else if (q_status.Status == QUEST_STATUS_COMPLETE)
                {
                    if (int32(count) < -rewOrReqMoney)
                    {
                        IncompleteQuest(questid);
                    }
                }
            }
        }
    }
}

void Player::ReputationChanged(FactionEntry const* factionEntry)
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        if (uint32 questid = GetQuestSlotQuestId(i))
        {
            if (Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid))
            {
                if (qInfo->GetRepObjectiveFaction() == factionEntry->ID)
                {
                    QuestStatusData& q_status = m_QuestStatus[questid];
                    if (q_status.Status == QUEST_STATUS_INCOMPLETE)
                    {
                        if (GetReputationMgr().GetReputation(factionEntry) >= qInfo->GetRepObjectiveValue())
                            if (CanCompleteQuest(questid))
                                CompleteQuest(questid);
                    }
                    else if (q_status.Status == QUEST_STATUS_COMPLETE)
                    {
                        if (GetReputationMgr().GetReputation(factionEntry) < qInfo->GetRepObjectiveValue())
                            IncompleteQuest(questid);
                    }
                }
            }
        }
    }
}

void Player::ReputationChanged2(FactionEntry const* factionEntry)
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        if (uint32 questid = GetQuestSlotQuestId(i))
        {
            if (Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid))
            {
                if (qInfo->GetRepObjectiveFaction2() == factionEntry->ID)
                {
                    QuestStatusData& q_status = m_QuestStatus[questid];
                    if (q_status.Status == QUEST_STATUS_INCOMPLETE)
                    {
                        if (GetReputationMgr().GetReputation(factionEntry) >= qInfo->GetRepObjectiveValue2())
                            if (CanCompleteQuest(questid))
                                CompleteQuest(questid);
                    }
                    else if (q_status.Status == QUEST_STATUS_COMPLETE)
                    {
                        if (GetReputationMgr().GetReputation(factionEntry) < qInfo->GetRepObjectiveValue2())
                            IncompleteQuest(questid);
                    }
                }
            }
        }
    }
}

bool Player::HasQuestForItem(uint32 itemid, uint32 excludeQuestId /* 0 */, bool turnIn /* false */, bool* showInLoot /*= nullptr*/) const
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (questid == 0 || questid == excludeQuestId)
            continue;

        QuestStatusMap::const_iterator qs_itr = m_QuestStatus.find(questid);
        if (qs_itr == m_QuestStatus.end())
            continue;

        QuestStatusData const& q_status = qs_itr->second;

        if ((q_status.Status == QUEST_STATUS_INCOMPLETE) || (turnIn && q_status.Status == QUEST_STATUS_COMPLETE))
        {
            Quest const* qinfo = sObjectMgr->GetQuestTemplate(questid);
            if (!qinfo)
                continue;

            // hide quest if player is in raid-group and quest is no raid quest
            if (GetGroup() && GetGroup()->isRaidGroup() && !qinfo->IsAllowedInRaid(GetMap()->GetDifficulty()))
            {
                if (!InBattleground() && !GetGroup()->isBFGroup()) //there are two ways.. we can make every bg-quest a raidquest, or add this code here.. i don't know if this can be exploited by other quests, but i think all other quests depend on a specific area.. but keep this in mind, if something strange happens later
                {
                    continue;
                }
            }

            // There should be no mixed ReqItem/ReqSource drop
            // This part for ReqItem drop
            for (uint8 j = 0; j < QUEST_ITEM_OBJECTIVES_COUNT; ++j)
            {
                if (itemid == qinfo->RequiredItemId[j] && q_status.ItemCount[j] < qinfo->RequiredItemCount[j])
                {
                    if (showInLoot)
                    {
                        if (GetItemCount(itemid, true) < qinfo->RequiredItemCount[j])
                        {
                            return true;
                        }

                        *showInLoot = false;
                    }
                    else
                    {
                        return true;
                    }
                }

                if (turnIn && q_status.ItemCount[j] >= qinfo->RequiredItemCount[j])
                {
                    return true;
                }
            }
            // This part - for ReqSource
            for (uint8 j = 0; j < QUEST_SOURCE_ITEM_IDS_COUNT; ++j)
            {
                // examined item is a source item
                if (qinfo->ItemDrop[j] == itemid)
                {
                    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(itemid);
                    uint32 ownedCount = GetItemCount(itemid, true);
                    // 'unique' item
                    if ((pProto->MaxCount && int32(ownedCount) < pProto->MaxCount) || (turnIn && int32(ownedCount) >= pProto->MaxCount))
                        return true;

                    // allows custom amount drop when not 0
                    if (qinfo->ItemDropQuantity[j])
                    {
                        if ((ownedCount < qinfo->ItemDropQuantity[j]) || (turnIn && ownedCount >= qinfo->ItemDropQuantity[j]))
                            return true;
                    }
                    else if (ownedCount < pProto->GetMaxStackSize())
                        return true;
                }
            }
        }
    }
    return false;
}

void Player::SendQuestComplete(uint32 quest_id)
{
    if (quest_id)
    {
        WorldPacket data(SMSG_QUESTUPDATE_COMPLETE, 4);
        data << uint32(quest_id);
        GetSession()->SendPacket(&data);
        LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTUPDATE_COMPLETE quest = {}", quest_id);
    }
}

void Player::SendQuestReward(Quest const* quest, uint32 XP)
{
    uint32 questid = quest->GetQuestId();
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTGIVER_QUEST_COMPLETE quest = {}", questid);
    sGameEventMgr->HandleQuestComplete(questid);
    WorldPacket data(SMSG_QUESTGIVER_QUEST_COMPLETE, (4 + 4 + 4 + 4 + 4));
    data << uint32(questid);

    if (!IsMaxLevel())
    {
        data << uint32(XP);
        data << uint32(quest->GetRewOrReqMoney(GetLevel()));
    }
    else
    {
        data << uint32(0);
        data << uint32(quest->GetRewOrReqMoney(GetLevel()) + quest->GetRewMoneyMaxLevel());
    }

    data << uint32(10 * quest->CalculateHonorGain(GetQuestLevel(quest)));
    data << uint32(quest->GetBonusTalents());              // bonus talents
    data << uint32(quest->GetRewArenaPoints());
    GetSession()->SendPacket(&data);
}

void Player::SendQuestFailed(uint32 questId, InventoryResult reason)
{
    if (questId)
    {
        WorldPacket data(SMSG_QUESTGIVER_QUEST_FAILED, 4 + 4);
        data << uint32(questId);
        data << uint32(reason);                             // failed reason (valid reasons: 4, 16, 50, 17, 74, other values show default message)
        GetSession()->SendPacket(&data);
        LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTGIVER_QUEST_FAILED");
    }
}

void Player::SendQuestTimerFailed(uint32 quest_id)
{
    if (quest_id)
    {
        WorldPacket data(SMSG_QUESTUPDATE_FAILEDTIMER, 4);
        data << uint32(quest_id);
        GetSession()->SendPacket(&data);
        LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTUPDATE_FAILEDTIMER");
    }
}

void Player::SendCanTakeQuestResponse(uint32 msg) const
{
    WorldPacket data(SMSG_QUESTGIVER_QUEST_INVALID, 4);
    data << uint32(msg);
    GetSession()->SendPacket(&data);
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTGIVER_QUEST_INVALID");
}

void Player::SendQuestConfirmAccept(const Quest* quest, Player* pReceiver)
{
    if (pReceiver)
    {
        //load locale from db
        std::string strTitle = quest->GetTitle();

        int loc_idx = pReceiver->GetSession()->GetSessionDbLocaleIndex();
        if (loc_idx >= 0)
            if (const QuestLocale* pLocale = sObjectMgr->GetQuestLocale(quest->GetQuestId()))
                ObjectMgr::GetLocaleString(pLocale->Title, loc_idx, strTitle);

        WorldPacket data(SMSG_QUEST_CONFIRM_ACCEPT, (4 + quest->GetTitle().size() + 8));
        data << uint32(quest->GetQuestId());
        data << quest->GetTitle();
        data << GetGUID();
        pReceiver->GetSession()->SendPacket(&data);

        LOG_DEBUG("network", "WORLD: Sent SMSG_QUEST_CONFIRM_ACCEPT");
    }
}

void Player::SendPushToPartyResponse(Player const* player, uint8 msg) const
{
    if (player)
    {
        WorldPacket data(MSG_QUEST_PUSH_RESULT, (8 + 1));
        data << player->GetGUID();
        data << uint8(msg);                                 // valid values: 0-8
        GetSession()->SendPacket(&data);
        LOG_DEBUG("network", "WORLD: Sent MSG_QUEST_PUSH_RESULT");
    }
}

void Player::SendQuestUpdateAddItem(Quest const* /*quest*/, uint32 /*item_idx*/, uint16 /*count*/)
{
    WorldPacket data(SMSG_QUESTUPDATE_ADD_ITEM, 0);
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTUPDATE_ADD_ITEM");
    //data << quest->RequiredItemId[item_idx];
    //data << count;
    GetSession()->SendPacket(&data);
}

void Player::SendQuestUpdateAddCreatureOrGo(Quest const* quest, ObjectGuid guid, uint32 creatureOrGO_idx, uint16 old_count, uint16 add_count)
{
    ASSERT(old_count + add_count < 65536 && "mob/GO count store in 16 bits 2^16 = 65536 (0..65536)");

    int32 entry = quest->RequiredNpcOrGo[ creatureOrGO_idx ];
    if (entry < 0)
        // client expected gameobject template id in form (id|0x80000000)
        entry = (-entry) | 0x80000000;

    WorldPacket data(SMSG_QUESTUPDATE_ADD_KILL, (4 * 4 + 8));
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTUPDATE_ADD_KILL");
    data << uint32(quest->GetQuestId());
    data << uint32(entry);
    data << uint32(old_count + add_count);
    data << uint32(quest->RequiredNpcOrGoCount[ creatureOrGO_idx ]);
    data << guid;
    GetSession()->SendPacket(&data);

    uint16 log_slot = FindQuestSlot(quest->GetQuestId());
    if (log_slot < MAX_QUEST_LOG_SIZE)
        SetQuestSlotCounter(log_slot, creatureOrGO_idx, GetQuestSlotCounter(log_slot, creatureOrGO_idx) + add_count);
}

void Player::SendQuestUpdateAddPlayer(Quest const* quest, uint16 old_count, uint16 add_count)
{
    ASSERT(old_count + add_count < 65536 && "player count store in 16 bits");

    WorldPacket data(SMSG_QUESTUPDATE_ADD_PVP_KILL, (3 * 4));
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTUPDATE_ADD_PVP_KILL");
    data << uint32(quest->GetQuestId());
    data << uint32(old_count + add_count);
    data << uint32(quest->GetPlayersSlain());
    GetSession()->SendPacket(&data);

    uint16 log_slot = FindQuestSlot(quest->GetQuestId());
    if (log_slot < MAX_QUEST_LOG_SIZE)
        SetQuestSlotCounter(log_slot, QUEST_PVP_KILL_SLOT, GetQuestSlotCounter(log_slot, QUEST_PVP_KILL_SLOT) + add_count);
}

bool Player::HasPvPForcingQuest() const
{
    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questId = GetQuestSlotQuestId(i);
        if (questId == 0)
            continue;

        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            continue;

        if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
            return true;
    }

    return false;
}
