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

#include "Battleground.h"
#include "BattlegroundAV.h"
#include "GameObjectAI.h"
#include "Group.h"
#include "Language.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleQuestgiverStatusQueryOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    recvData >> guid;
    uint32 questStatus = DIALOG_STATUS_NONE;

    GossipMenu& gossipMenu = m_player->PlayerTalkClass->GetGossipMenu();
    // Did we already get a gossip menu with that NPC? if so no need to status query
    if (gossipMenu.GetSenderGUID() == guid)
    {
        return;
    }

    Object* questGiver = ObjectAccessor::GetObjectByTypeMask(*m_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);
    if (!questGiver)
    {
        LOG_DEBUG("network.opcode", "Error in CMSG_QUESTGIVER_STATUS_QUERY, called for not found questgiver ({})", guid.ToString());
        return;
    }

    switch (questGiver->GetTypeId())
    {
        case TYPEID_UNIT:
            {
                LOG_DEBUG("network", "WORLD: Received CMSG_QUESTGIVER_STATUS_QUERY for npc {}", guid.ToString());
                if (!questGiver->ToCreature()->IsHostileTo(m_player)) // do not show quest status to enemies
                    questStatus = m_player->GetQuestDialogStatus(questGiver);
                break;
            }
        case TYPEID_GAMEOBJECT:
            {
                LOG_DEBUG("network", "WORLD: Received CMSG_QUESTGIVER_STATUS_QUERY for GameObject {}", guid.ToString());
                if (sWorld->getBoolConfig(CONFIG_OBJECT_QUEST_MARKERS))
                {
                    questStatus = m_player->GetQuestDialogStatus(questGiver);
                }
                break;
            }
        default:
            LOG_ERROR("network.opcode", "QuestGiver called for unexpected type {}", questGiver->GetTypeId());
            break;
    }

    // inform client about status of quest
    m_player->PlayerTalkClass->SendQuestGiverStatus(uint8(questStatus), guid);
}

void WorldSession::HandleQuestgiverHelloOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    recvData >> guid;

    LOG_DEBUG("network", "WORLD: Received CMSG_QUESTGIVER_HELLO npc {}", guid.ToString());

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_NONE);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleQuestgiverHelloOpcode - Unit ({}) not found or you can't interact with him.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    // Stop the npc if moving
    if (uint32 pause = creature->GetMovementTemplate().GetInteractionPauseTimer())
        creature->PauseMovement(pause);
    creature->SetHomePosition(creature->GetPosition());

    if (sScriptMgr->OnGossipHello(m_player, creature))
        return;

    m_player->PrepareGossipMenu(creature, creature->GetCreatureTemplate()->GossipMenuId, true);
    m_player->SendPreparedGossip(creature);

    creature->AI()->sGossipHello(m_player);
}

void WorldSession::HandleQuestgiverAcceptQuestOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    uint32 questId;
    uint32 unk1;
    recvData >> guid >> questId >> unk1;

    LOG_DEBUG("network", "WORLD: Received CMSG_QUESTGIVER_ACCEPT_QUEST npc {}, quest = {}, unk1 = {}", guid.ToString(), questId, unk1);

    Object* object = ObjectAccessor::GetObjectByTypeMask(*m_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT | TYPEMASK_ITEM | TYPEMASK_PLAYER);

    // no or incorrect quest giver
    if (!object || object == m_player || (object->GetTypeId() != TYPEID_PLAYER && !object->hasQuest(questId)) ||
            (object->GetTypeId() == TYPEID_PLAYER && !object->ToPlayer()->CanShareQuest(questId)))
    {
        m_player->PlayerTalkClass->SendCloseGossip();
        m_player->SetDivider();
        return;
    }

    // some kind of WPE protection
    if (!m_player->CanInteractWithQuestGiver(object))
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        // pussywizard: exploit fix, can't share quests that give items to be sold
        if (object->GetTypeId() == TYPEID_PLAYER)
            if (uint32 itemId = quest->GetSrcItemId())
                if (ItemTemplate const* srcItem = sObjectMgr->GetItemTemplate(itemId))
                    if (srcItem->SellPrice > 0)
                        return;

        // prevent cheating
        if (!GetPlayer()->CanTakeQuest(quest, true))
        {
            m_player->PlayerTalkClass->SendCloseGossip();
            m_player->SetDivider();
            return;
        }

        if (m_player->GetDivider())
        {
            Player* player = ObjectAccessor::GetPlayer(*m_player, m_player->GetDivider());
            if (player)
            {
                player->SendPushToPartyResponse(m_player, QUEST_PARTY_MSG_ACCEPT_QUEST);
                m_player->SetDivider();
            }
        }

        if (m_player->CanAddQuest(quest, true))
        {
            m_player->AddQuestAndCheckCompletion(quest, object);

            if (quest->HasFlag(QUEST_FLAGS_PARTY_ACCEPT))
            {
                if (Group* group = m_player->GetGroup())
                {
                    for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                    {
                        Player* itrPlayer = itr->GetSource();
                        if (!itrPlayer || itrPlayer == m_player || !itrPlayer->IsAtGroupRewardDistance(m_player) || itrPlayer->HasPendingBind()) // xinef: check range
                            continue;

                        if (itrPlayer->CanTakeQuest(quest, false))
                        {
                            itrPlayer->SetDivider(m_player->GetGUID());

                            // need confirmation that any gossip window will close
                            itrPlayer->PlayerTalkClass->SendCloseGossip();

                            m_player->SendQuestConfirmAccept(quest, itrPlayer);
                        }
                    }
                }
            }

            m_player->PlayerTalkClass->SendCloseGossip();

            if (quest->GetSrcSpell() > 0)
                m_player->CastSpell(m_player, quest->GetSrcSpell(), true);

            return;
        }
    }

    m_player->PlayerTalkClass->SendCloseGossip();
}

void WorldSession::HandleQuestgiverQueryQuestOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    uint32 questId;
    uint8 unk1;
    recvData >> guid >> questId >> unk1;
    LOG_DEBUG("network", "WORLD: Received CMSG_QUESTGIVER_QUERY_QUEST npc {}, quest = {}, unk1 = {}", guid.ToString(), questId, unk1);

    // Verify that the guid is valid and is a questgiver or involved in the requested quest
    Object* object = ObjectAccessor::GetObjectByTypeMask(*m_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT | TYPEMASK_ITEM);
    if (!object || (!object->hasQuest(questId) && !object->hasInvolvedQuest(questId)))
    {
        m_player->PlayerTalkClass->SendCloseGossip();
        return;
    }

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        // not sure here what should happen to quests with QUEST_FLAGS_AUTOCOMPLETE
        // if this breaks them, add && object->GetTypeId() == TYPEID_ITEM to this check
        // item-started quests never have that flag
        if (!m_player->CanTakeQuest(quest, true))
            return;

        if (quest->IsAutoAccept() && m_player->CanAddQuest(quest, true))
            m_player->AddQuestAndCheckCompletion(quest, object);

        if (quest->IsAutoComplete() || !quest->GetQuestMethod())
            m_player->PlayerTalkClass->SendQuestGiverRequestItems(quest, object->GetGUID(), m_player->CanCompleteQuest(quest->GetQuestId()), true);
        else
            m_player->PlayerTalkClass->SendQuestGiverQuestDetails(quest, object->GetGUID(), true);
    }
}

void WorldSession::HandleQuestQueryOpcode(WorldPacket& recvData)
{
    if (!m_player)
        return;

    uint32 questId;
    recvData >> questId;
    LOG_DEBUG("network", "WORLD: Received CMSG_QUEST_QUERY quest = {}", questId);

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
        m_player->PlayerTalkClass->SendQuestQueryResponse(quest);
}

void WorldSession::HandleQuestgiverChooseRewardOpcode(WorldPacket& recvData)
{
    uint32 questId, reward;
    ObjectGuid guid;
    recvData >> guid >> questId >> reward;

    if (reward >= QUEST_REWARD_CHOICES_COUNT)
    {
        LOG_ERROR("network.opcode", "Error in CMSG_QUESTGIVER_CHOOSE_REWARD: player {} ({}) tried to get invalid reward ({}) (probably packet hacking)",
            m_player->GetName(), m_player->GetGUID().ToString(), reward);
        return;
    }

    LOG_DEBUG("network", "WORLD: Received CMSG_QUESTGIVER_CHOOSE_REWARD npc {}, quest = {}, reward = {}", guid.ToString(), questId, reward);

    Object* object = ObjectAccessor::GetObjectByTypeMask(*m_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);
    if (!object || !object->hasInvolvedQuest(questId))
        return;

    // some kind of WPE protection
    if (!m_player->CanInteractWithQuestGiver(object))
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        if ((!m_player->CanSeeStartQuest(quest) &&  m_player->GetQuestStatus(questId) == QUEST_STATUS_NONE) ||
                (m_player->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE && !quest->IsAutoComplete() && quest->GetQuestMethod()))
        {
            LOG_ERROR("network.opcode", "HACK ALERT: Player {} ({}) is trying to complete quest (id: {}) but he has no right to do it!",
                           m_player->GetName(), m_player->GetGUID().ToString(), questId);
            return;
        }
        if (m_player->CanRewardQuest(quest, reward, true))
        {
            m_player->RewardQuest(quest, reward, object);

            // Special dialog status update (client does not query this)
            if (!quest->GetQuestMethod())
            {
                m_player->PlayerTalkClass->SendQuestGiverStatus(uint8(m_player->GetQuestDialogStatus(object)), guid);
            }

            switch (object->GetTypeId())
            {
                case TYPEID_UNIT:
                    {
                        Creature* questgiver = object->ToCreature();
                        if (!sScriptMgr->OnQuestReward(m_player, questgiver, quest, reward))
                        {
                            // Send next quest
                            if (Quest const* nextQuest = m_player->GetNextQuest(guid, quest))
                            {
                                if (m_player->CanTakeQuest(nextQuest, false))
                                {
                                    if (nextQuest->IsAutoAccept())
                                    {
                                        // QUEST_FLAGS_AUTO_ACCEPT was not used by Blizzard.
                                        if (m_player->CanAddQuest(nextQuest, false))
                                        {
                                            m_player->AddQuestAndCheckCompletion(nextQuest, object);
                                        }
                                        else
                                        {
                                            // Auto accept is set for a custom quest and there is no inventory space
                                            m_player->PlayerTalkClass->SendCloseGossip();
                                            break;
                                        }
                                    }
                                    m_player->PlayerTalkClass->SendQuestGiverQuestDetails(nextQuest, guid, true);
                                }
                            }

                            questgiver->AI()->sQuestReward(m_player, quest, reward);
                        }
                        break;
                    }
                case TYPEID_GAMEOBJECT:
                    {
                        GameObject* questGiver = object->ToGameObject();
                        if (!sScriptMgr->OnQuestReward(m_player, questGiver, quest, reward))
                        {
                            // Send next quest
                            if (Quest const* nextQuest = m_player->GetNextQuest(guid, quest))
                            {
                                if (m_player->CanAddQuest(nextQuest, false) && m_player->CanTakeQuest(nextQuest, false))
                                {
                                    if (nextQuest->IsAutoAccept())
                                        m_player->AddQuestAndCheckCompletion(nextQuest, object);
                                    m_player->PlayerTalkClass->SendQuestGiverQuestDetails(nextQuest, guid, true);
                                }
                            }

                            questGiver->AI()->QuestReward(m_player, quest, reward);
                        }
                        break;
                    }
                default:
                    break;
            }
        }
        else
            m_player->PlayerTalkClass->SendQuestGiverOfferReward(quest, guid, true);
    }
}

void WorldSession::HandleQuestgiverRequestRewardOpcode(WorldPacket& recvData)
{
    uint32 questId;
    ObjectGuid guid;
    recvData >> guid >> questId;

    LOG_DEBUG("network", "WORLD: Received CMSG_QUESTGIVER_REQUEST_REWARD npc {}, quest = {}", guid.ToString(), questId);

    Object* object = ObjectAccessor::GetObjectByTypeMask(*m_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);
    if (!object || !object->hasInvolvedQuest(questId))
        return;

    // some kind of WPE protection
    if (!m_player->CanInteractWithQuestGiver(object))
        return;

    if (m_player->CanCompleteQuest(questId))
        m_player->CompleteQuest(questId);

    if (m_player->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE)
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
        m_player->PlayerTalkClass->SendQuestGiverOfferReward(quest, guid, true);
}

void WorldSession::HandleQuestgiverCancel(WorldPacket& /*recvData*/)
{
    m_player->PlayerTalkClass->SendCloseGossip();
}

void WorldSession::HandleQuestLogSwapQuest(WorldPacket& recvData)
{
    uint8 slot1, slot2;
    recvData >> slot1 >> slot2;

    if (slot1 == slot2 || slot1 >= MAX_QUEST_LOG_SIZE || slot2 >= MAX_QUEST_LOG_SIZE)
        return;

    LOG_DEBUG("network", "WORLD: Received CMSG_QUESTLOG_SWAP_QUEST slot 1 = {}, slot 2 = {}", slot1, slot2);

    GetPlayer()->SwapQuestSlot(slot1, slot2);
}

void WorldSession::HandleQuestLogRemoveQuest(WorldPacket& recvData)
{
    uint8 slot;
    recvData >> slot;

    LOG_DEBUG("network", "WORLD: Received CMSG_QUESTLOG_REMOVE_QUEST slot = {}", slot);

    if (slot < MAX_QUEST_LOG_SIZE)
    {
        if (uint32 questId = m_player->GetQuestSlotQuestId(slot))
        {
            if (!m_player->TakeQuestSourceItem(questId, true))
                return;                                     // can't un-equip some items, reject quest cancel

            if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
            {
                if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
                    m_player->RemoveTimedQuest(questId);

                if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
                {
                    m_player->pvpInfo.IsHostile = m_player->pvpInfo.IsInHostileArea || m_player->HasPvPForcingQuest();
                    m_player->UpdatePvPState();
                }
            }

            m_player->TakeQuestSourceItem(questId, true); // remove quest src item from player
            m_player->AbandonQuest(questId); // remove all quest items player received before abandoning quest.
            m_player->RemoveActiveQuest(questId);
            m_player->RemoveTimedAchievement(ACHIEVEMENT_TIMED_TYPE_QUEST, questId);

            sScriptMgr->OnQuestAbandon(m_player, questId);

            LOG_DEBUG("network.opcode", "Player {} abandoned quest {}", m_player->GetGUID().ToString(), questId);
            // check if Quest Tracker is enabled
            if (sWorld->getBoolConfig(CONFIG_QUEST_ENABLE_QUEST_TRACKER))
            {
                // prepare Quest Tracker datas
                auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_ABANDON_TIME);
                stmt->SetData(0, questId);
                stmt->SetData(1, m_player->GetGUID().GetCounter());

                // add to Quest Tracker
                CharacterDatabase.Execute(stmt);
            }
        }

        m_player->SetQuestSlot(slot, 0);

        m_player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_QUEST_ABANDONED, 1);
    }
}

void WorldSession::HandleQuestConfirmAccept(WorldPacket& recvData)
{
    uint32 questId;
    recvData >> questId;

    LOG_DEBUG("network", "WORLD: Received CMSG_QUEST_CONFIRM_ACCEPT quest = {}", questId);

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        if (!quest->HasFlag(QUEST_FLAGS_PARTY_ACCEPT))
            return;

        Player* originalPlayer = ObjectAccessor::GetPlayer(*m_player, m_player->GetDivider());
        if (!originalPlayer)
            return;

        if (!m_player->IsInSameRaidWith(originalPlayer) || !m_player->IsAtGroupRewardDistance(originalPlayer))
            return;

        if (!m_player->CanTakeQuest(quest, true) || m_player->HasPendingBind())
            return;

        // pussywizard: exploit fix, can't share quests that give items to be sold
        if (uint32 itemId = quest->GetSrcItemId())
            if (ItemTemplate const* srcItem = sObjectMgr->GetItemTemplate(itemId))
                if (srcItem->SellPrice > 0)
                    return;

        if (m_player->CanAddQuest(quest, true))
            m_player->AddQuestAndCheckCompletion(quest, nullptr); // nullptr, this prevent DB script from duplicate running

        m_player->SetDivider();
    }
}

void WorldSession::HandleQuestgiverCompleteQuest(WorldPacket& recvData)
{
    uint32 questId;
    ObjectGuid guid;

    recvData >> guid >> questId;

    LOG_DEBUG("network", "WORLD: Received CMSG_QUESTGIVER_COMPLETE_QUEST npc {}, quest = {}", guid.ToString(), questId);

    Object* object = ObjectAccessor::GetObjectByTypeMask(*m_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);
    if (!object || !object->hasInvolvedQuest(questId))
        return;

    // some kind of WPE protection
    if (!m_player->CanInteractWithQuestGiver(object))
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        if (!m_player->CanSeeStartQuest(quest) && m_player->GetQuestStatus(questId) == QUEST_STATUS_NONE)
        {
            LOG_ERROR("network.opcode", "Possible hacking attempt: Player {} [{}] tried to complete quest [entry: {}] without being in possession of the quest!",
                           m_player->GetName(), m_player->GetGUID().ToString(), questId);
            return;
        }

        if (Battleground* bg = m_player->GetBattleground())
            if (bg->GetBgTypeID(true) == BATTLEGROUND_AV)
                bg->ToBattlegroundAV()->HandleQuestComplete(questId, m_player);

        if (m_player->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE)
        {
            if (quest->IsRepeatable())
                m_player->PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, m_player->CanCompleteRepeatableQuest(quest), false);
            else
                m_player->PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, m_player->CanRewardQuest(quest, false), false);
        }
        else
        {
            if (quest->GetReqItemsCount())                  // some items required
                m_player->PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, m_player->CanRewardQuest(quest, false), false);
            else                                            // no items required
                m_player->PlayerTalkClass->SendQuestGiverOfferReward(quest, guid, true);
        }
    }
}

void WorldSession::HandleQuestgiverQuestAutoLaunch(WorldPacket& /*recvPacket*/)
{
}

void WorldSession::HandlePushQuestToParty(WorldPacket& recvPacket)
{
    uint32 questId;
    recvPacket >> questId;

    if (!m_player->CanShareQuest(questId))
        return;

    LOG_DEBUG("network", "WORLD: Received CMSG_PUSHQUESTTOPARTY quest = {}", questId);

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        if (Group* group = m_player->GetGroup())
        {
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* player = itr->GetSource();

                if (!player || player == m_player || !player->IsInMap(m_player))         // skip self
                    continue;

                if (!player->SatisfyQuestStatus(quest, false))
                {
                    m_player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_HAVE_QUEST);
                    continue;
                }

                if (player->GetQuestStatus(questId) == QUEST_STATUS_COMPLETE)
                {
                    m_player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_FINISH_QUEST);
                    continue;
                }

                if (!player->CanTakeQuest(quest, false))
                {
                    m_player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_CANT_TAKE_QUEST);
                    continue;
                }

                if (!player->SatisfyQuestLog(false))
                {
                    m_player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_LOG_FULL);
                    continue;
                }

                // Check if Quest Share in BG is enabled
                if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_DISABLE_QUEST_SHARE_IN_BG))
                {
                    // Check if player is in BG
                    if (m_player->InBattleground())
                    {
                        m_player->GetSession()->SendNotification(LANG_BG_SHARE_QUEST_ERROR);
                        continue;
                    }
                }

                if (player->GetDivider())
                {
                    m_player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_BUSY);
                    continue;
                }

                m_player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_SHARING_QUEST);

                if (quest->IsAutoAccept() && player->CanAddQuest(quest, true) && player->CanTakeQuest(quest, true))
                    player->AddQuestAndCheckCompletion(quest, m_player);

                if (quest->IsAutoComplete() || !quest->GetQuestMethod())
                    player->PlayerTalkClass->SendQuestGiverRequestItems(quest, m_player->GetGUID(), player->CanCompleteRepeatableQuest(quest), true);
                else
                {
                    player->SetDivider(m_player->GetGUID());
                    player->PlayerTalkClass->SendQuestGiverQuestDetails(quest, player->GetGUID(), true);
                }
            }
        }
    }
}

void WorldSession::HandleQuestPushResult(WorldPacket& recvPacket)
{
    ObjectGuid guid;
    uint32 questId;
    uint8 msg;
    recvPacket >> guid >> questId >> msg;

    if (m_player->GetDivider() && m_player->GetDivider() == guid)
    {
        if (Player* player = ObjectAccessor::GetPlayer(*m_player, m_player->GetDivider()))
        {
            WorldPacket data(MSG_QUEST_PUSH_RESULT, 8 + 4 + 1);
            data << m_player->GetGUID();
            data << uint8(msg);                             // valid values: 0-8
            player->GetSession()->SendPacket(&data);
            m_player->SetDivider();
        }
    }
}

void WorldSession::HandleQuestgiverStatusMultipleQuery(WorldPacket& /*recvPacket*/)
{
    m_player->SendQuestGiverStatusMultiple();
}

void WorldSession::HandleQueryQuestsCompleted(WorldPacket& /*recvData*/)
{
    size_t rew_count = m_player->GetRewardedQuestCount();

    WorldPacket data(SMSG_QUERY_QUESTS_COMPLETED_RESPONSE, 4 + 4 * rew_count);
    data << uint32(rew_count);

    const RewardedQuestSet& rewQuests = m_player->getRewardedQuests();
    for (RewardedQuestSet::const_iterator itr = rewQuests.begin(); itr != rewQuests.end(); ++itr)
        data << uint32(*itr);

    SendPacket(&data);
}
