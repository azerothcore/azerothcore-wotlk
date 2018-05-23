/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "Log.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "World.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "GossipDef.h"
#include "QuestDef.h"
#include "ObjectAccessor.h"
#include "Group.h"
#include "Battleground.h"
#include "BattlegroundAV.h"
#include "ScriptMgr.h"
#include "GameObjectAI.h"
#ifdef ELUNA
#include "LuaEngine.h"
#endif

void WorldSession::HandleQuestgiverStatusQueryOpcode(WorldPacket & recvData)
{
    uint64 guid;
    recvData >> guid;
    uint32 questStatus = DIALOG_STATUS_NONE;

    Object* questGiver = ObjectAccessor::GetObjectByTypeMask(*_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);
    if (!questGiver)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDetail("Error in CMSG_QUESTGIVER_STATUS_QUERY, called for not found questgiver (Typeid: %u GUID: %u)", GuidHigh2TypeId(GUID_HIPART(guid)), GUID_LOPART(guid));
#endif
        return;
    }

    switch (questGiver->GetTypeId())
    {
        case TYPEID_UNIT:
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_STATUS_QUERY for npc, guid = %u", uint32(GUID_LOPART(guid)));
#endif
            if (!questGiver->ToCreature()->IsHostileTo(_player)) // do not show quest status to enemies
                questStatus = _player->GetQuestDialogStatus(questGiver);
            break;
        }
        case TYPEID_GAMEOBJECT:
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_STATUS_QUERY for GameObject guid = %u", uint32(GUID_LOPART(guid)));
#endif
            questStatus = _player->GetQuestDialogStatus(questGiver);
            break;
        }
        default:
            sLog->outError("QuestGiver called for unexpected type %u", questGiver->GetTypeId());
            break;
    }

    // inform client about status of quest
    _player->PlayerTalkClass->SendQuestGiverStatus(uint8(questStatus), guid);
}

void WorldSession::HandleQuestgiverHelloOpcode(WorldPacket & recvData)
{
    uint64 guid;
    recvData >> guid;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_HELLO npc = %u", GUID_LOPART(guid));
#endif

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_NONE);
    if (!creature)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: HandleQuestgiverHelloOpcode - Unit (GUID: %u) not found or you can't interact with him.", GUID_LOPART(guid));
#endif
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);
    // Stop the npc if moving
    //if (!creature->GetTransport()) // pussywizard: reverted with new spline (old: without this check, npc would stay in place and the transport would continue moving, so the npc falls off. NPCs on transports don't have waypoints, so stopmoving is not needed)
        creature->StopMoving();

#ifdef ELUNA
        if (sEluna->OnGossipHello(_player, creature))
            return;
#endif

    if (sScriptMgr->OnGossipHello(_player, creature))
        return;

    _player->PrepareGossipMenu(creature, creature->GetCreatureTemplate()->GossipMenuId, true);
    _player->SendPreparedGossip(creature);

    creature->AI()->sGossipHello(_player);
}

void WorldSession::HandleQuestgiverAcceptQuestOpcode(WorldPacket & recvData)
{
    uint64 guid;
    uint32 questId;
    uint32 unk1;
    recvData >> guid >> questId >> unk1;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_ACCEPT_QUEST npc = %u, quest = %u, unk1 = %u", uint32(GUID_LOPART(guid)), questId, unk1);
#endif

    Object* object = ObjectAccessor::GetObjectByTypeMask(*_player, guid, TYPEMASK_UNIT|TYPEMASK_GAMEOBJECT|TYPEMASK_ITEM|TYPEMASK_PLAYER);

    // no or incorrect quest giver
    if (!object || object == _player || (object->GetTypeId() != TYPEID_PLAYER && !object->hasQuest(questId)) ||
        (object->GetTypeId() == TYPEID_PLAYER && !object->ToPlayer()->CanShareQuest(questId)))
    {
        _player->PlayerTalkClass->SendCloseGossip();
        _player->SetDivider(0);
        return;
    }

    // some kind of WPE protection
    if (!_player->CanInteractWithQuestGiver(object))
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        // pussywizard: exploit fix, can't share quests that give items to be sold
        if (object->GetTypeId() == TYPEID_PLAYER)
            if (uint32 itemId = quest->GetSrcItemId())
                if (const ItemTemplate* srcItem = sObjectMgr->GetItemTemplate(itemId))
                    if (srcItem->SellPrice > 0)
                        return;

        // prevent cheating
        if (!GetPlayer()->CanTakeQuest(quest, true))
        {
            _player->PlayerTalkClass->SendCloseGossip();
            _player->SetDivider(0);
            return;
        }

        if (_player->GetDivider() != 0)
        {
            Player* player = ObjectAccessor::GetPlayer(*_player, _player->GetDivider());
            if (player)
            {
                player->SendPushToPartyResponse(_player, QUEST_PARTY_MSG_ACCEPT_QUEST);
                _player->SetDivider(0);
            }
        }

        if (_player->CanAddQuest(quest, true))
        {
            _player->AddQuestAndCheckCompletion(quest, object);

            if (quest->HasFlag(QUEST_FLAGS_PARTY_ACCEPT))
            {
                if (Group* group = _player->GetGroup())
                {
                    for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
                    {
                        Player* itrPlayer = itr->GetSource();
                        if (!itrPlayer || itrPlayer == _player || !itrPlayer->IsAtGroupRewardDistance(_player) || itrPlayer->HasPendingBind()) // xinef: check range
                            continue;

                        if (itrPlayer->CanTakeQuest(quest, false))
                        {
                            itrPlayer->SetDivider(_player->GetGUID());

                            // need confirmation that any gossip window will close
                            itrPlayer->PlayerTalkClass->SendCloseGossip();

                            _player->SendQuestConfirmAccept(quest, itrPlayer);
                        }
                    }
                }
            }

            _player->PlayerTalkClass->SendCloseGossip();

            if (quest->GetSrcSpell() > 0)
                _player->CastSpell(_player, quest->GetSrcSpell(), true);

            return;
        }
    }

    _player->PlayerTalkClass->SendCloseGossip();
}

void WorldSession::HandleQuestgiverQueryQuestOpcode(WorldPacket & recvData)
{
    uint64 guid;
    uint32 questId;
    uint8 unk1;
    recvData >> guid >> questId >> unk1;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_QUERY_QUEST npc = %u, quest = %u, unk1 = %u", uint32(GUID_LOPART(guid)), questId, unk1);
#endif

    // Verify that the guid is valid and is a questgiver or involved in the requested quest
    Object* object = ObjectAccessor::GetObjectByTypeMask(*_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT | TYPEMASK_ITEM);
    if (!object || (!object->hasQuest(questId) && !object->hasInvolvedQuest(questId)))
    {
        _player->PlayerTalkClass->SendCloseGossip();
        return;
    }

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        // not sure here what should happen to quests with QUEST_FLAGS_AUTOCOMPLETE
        // if this breaks them, add && object->GetTypeId() == TYPEID_ITEM to this check
        // item-started quests never have that flag
        if (!_player->CanTakeQuest(quest, true))
            return;

        if (quest->IsAutoAccept() && _player->CanAddQuest(quest, true))
            _player->AddQuestAndCheckCompletion(quest, object);

        if (quest->HasFlag(QUEST_FLAGS_AUTOCOMPLETE))
            _player->PlayerTalkClass->SendQuestGiverRequestItems(quest, object->GetGUID(), _player->CanCompleteQuest(quest->GetQuestId()), true);
        else
            _player->PlayerTalkClass->SendQuestGiverQuestDetails(quest, object->GetGUID(), true);
    }
}

void WorldSession::HandleQuestQueryOpcode(WorldPacket & recvData)
{
    if (!_player)
        return;

    uint32 questId;
    recvData >> questId;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUEST_QUERY quest = %u", questId);
#endif

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
        _player->PlayerTalkClass->SendQuestQueryResponse(quest);
}

void WorldSession::HandleQuestgiverChooseRewardOpcode(WorldPacket & recvData)
{
    uint32 questId, reward;
    uint64 guid;
    recvData >> guid >> questId >> reward;

    if (reward >= QUEST_REWARD_CHOICES_COUNT)
    {
        sLog->outError("Error in CMSG_QUESTGIVER_CHOOSE_REWARD: player %s (guid %d) tried to get invalid reward (%u) (probably packet hacking)", _player->GetName().c_str(), _player->GetGUIDLow(), reward);
        return;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_CHOOSE_REWARD npc = %u, quest = %u, reward = %u", uint32(GUID_LOPART(guid)), questId, reward);
#endif

    Object* object = ObjectAccessor::GetObjectByTypeMask(*_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);
    if (!object || !object->hasInvolvedQuest(questId))
        return;

    // some kind of WPE protection
    if (!_player->CanInteractWithQuestGiver(object))
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        if ((!_player->CanSeeStartQuest(quest) &&  _player->GetQuestStatus(questId) == QUEST_STATUS_NONE) ||
            (_player->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE && !quest->IsAutoComplete()))
        {
            sLog->outError("HACK ALERT: Player %s (guid: %u) is trying to complete quest (id: %u) but he has no right to do it!",
                           _player->GetName().c_str(), _player->GetGUIDLow(), questId);
            return;
        }
        if (_player->CanRewardQuest(quest, reward, true))
        {
            _player->RewardQuest(quest, reward, object);

            switch (object->GetTypeId())
            {
                case TYPEID_UNIT:
                {
                    Creature* questgiver = object->ToCreature();
                    if (!sScriptMgr->OnQuestReward(_player, questgiver, quest, reward))
                    {
                        // Send next quest
                        if (Quest const* nextQuest = _player->GetNextQuest(guid, quest))
                        {
                            if (_player->CanAddQuest(nextQuest, false) && _player->CanTakeQuest(nextQuest, false))
                            {
                                if (nextQuest->IsAutoAccept())
                                    _player->AddQuestAndCheckCompletion(nextQuest, object);
                                _player->PlayerTalkClass->SendQuestGiverQuestDetails(nextQuest, guid, true);
                            }
                        }

                        questgiver->AI()->sQuestReward(_player, quest, reward);
                    }
                    break;
                }
                case TYPEID_GAMEOBJECT:
                {
                    GameObject* questGiver = object->ToGameObject();
                    if (!sScriptMgr->OnQuestReward(_player, questGiver, quest, reward))
                    {
                        // Send next quest
                        if (Quest const* nextQuest = _player->GetNextQuest(guid, quest))
                        {
                            if (_player->CanAddQuest(nextQuest, false) && _player->CanTakeQuest(quest, false))
                            {
                                if (nextQuest->IsAutoAccept())
                                    _player->AddQuestAndCheckCompletion(nextQuest, object);
                                _player->PlayerTalkClass->SendQuestGiverQuestDetails(nextQuest, guid, true);
                            }
                        }

                        questGiver->AI()->QuestReward(_player, quest, reward);
                    }
                    break;
                }
                default:
                    break;
            }
        }
        else
            _player->PlayerTalkClass->SendQuestGiverOfferReward(quest, guid, true);
    }
}

void WorldSession::HandleQuestgiverRequestRewardOpcode(WorldPacket & recvData)
{
    uint32 questId;
    uint64 guid;
    recvData >> guid >> questId;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_REQUEST_REWARD npc = %u, quest = %u", uint32(GUID_LOPART(guid)), questId);
#endif

    Object* object = ObjectAccessor::GetObjectByTypeMask(*_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);
    if (!object || !object->hasInvolvedQuest(questId))
        return;

    // some kind of WPE protection
    if (!_player->CanInteractWithQuestGiver(object))
        return;

    if (_player->CanCompleteQuest(questId))
        _player->CompleteQuest(questId);

    if (_player->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE)
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
        _player->PlayerTalkClass->SendQuestGiverOfferReward(quest, guid, true);
}

void WorldSession::HandleQuestgiverCancel(WorldPacket& /*recvData*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_CANCEL");
#endif

    _player->PlayerTalkClass->SendCloseGossip();
}

void WorldSession::HandleQuestLogSwapQuest(WorldPacket& recvData)
{
    uint8 slot1, slot2;
    recvData >> slot1 >> slot2;

    if (slot1 == slot2 || slot1 >= MAX_QUEST_LOG_SIZE || slot2 >= MAX_QUEST_LOG_SIZE)
        return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTLOG_SWAP_QUEST slot 1 = %u, slot 2 = %u", slot1, slot2);
#endif

    GetPlayer()->SwapQuestSlot(slot1, slot2);
}

void WorldSession::HandleQuestLogRemoveQuest(WorldPacket& recvData)
{
    uint8 slot;
    recvData >> slot;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTLOG_REMOVE_QUEST slot = %u", slot);
#endif

    if (slot < MAX_QUEST_LOG_SIZE)
    {
        if (uint32 questId = _player->GetQuestSlotQuestId(slot))
        {
            if (!_player->TakeQuestSourceItem(questId, true))
                return;                                     // can't un-equip some items, reject quest cancel

            if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
            {
                if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
                    _player->RemoveTimedQuest(questId);

                if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
                {
                    _player->pvpInfo.IsHostile = _player->pvpInfo.IsInHostileArea || _player->HasPvPForcingQuest();
                    _player->UpdatePvPState();
                }
            }

            _player->TakeQuestSourceItem(questId, true); // remove quest src item from player
            _player->RemoveActiveQuest(questId);
            _player->RemoveTimedAchievement(ACHIEVEMENT_TIMED_TYPE_QUEST, questId);
#ifdef ELUNA
            sEluna->OnQuestAbandon(_player, questId);
#endif
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDetail("Player %u abandoned quest %u", _player->GetGUIDLow(), questId);
#endif
        }

        _player->SetQuestSlot(slot, 0);

        _player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_QUEST_ABANDONED, 1);
    }
}

void WorldSession::HandleQuestConfirmAccept(WorldPacket& recvData)
{
    uint32 questId;
    recvData >> questId;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUEST_CONFIRM_ACCEPT quest = %u", questId);
#endif

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        if (!quest->HasFlag(QUEST_FLAGS_PARTY_ACCEPT))
            return;

        Player* originalPlayer = ObjectAccessor::GetPlayer(*_player, _player->GetDivider());
        if (!originalPlayer)
            return;

        if (!_player->IsInSameRaidWith(originalPlayer) || !_player->IsAtGroupRewardDistance(originalPlayer))
            return;

        if (!_player->CanTakeQuest(quest, true) || _player->HasPendingBind())
            return;

        // pussywizard: exploit fix, can't share quests that give items to be sold
        if (uint32 itemId = quest->GetSrcItemId())
            if (const ItemTemplate* srcItem = sObjectMgr->GetItemTemplate(itemId))
                if (srcItem->SellPrice > 0)
                    return;

        if (_player->CanAddQuest(quest, true))
            _player->AddQuestAndCheckCompletion(quest, NULL); // NULL, this prevent DB script from duplicate running

        _player->SetDivider(0);
    }
}

void WorldSession::HandleQuestgiverCompleteQuest(WorldPacket& recvData)
{
    uint32 questId;
    uint64 guid;

    recvData >> guid >> questId;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_COMPLETE_QUEST npc = %u, quest = %u", uint32(GUID_LOPART(guid)), questId);
#endif

    Object* object = ObjectAccessor::GetObjectByTypeMask(*_player, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);
    if (!object || !object->hasInvolvedQuest(questId))
        return;

    // some kind of WPE protection
    if (!_player->CanInteractWithQuestGiver(object))
        return;

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        if (!_player->CanSeeStartQuest(quest) && _player->GetQuestStatus(questId) == QUEST_STATUS_NONE)
        {
            sLog->outError("Possible hacking attempt: Player %s [guid: %u] tried to complete quest [entry: %u] without being in possession of the quest!",
                          _player->GetName().c_str(), _player->GetGUIDLow(), questId);
            return;
        }

        if (Battleground* bg = _player->GetBattleground())
            if (bg->GetBgTypeID() == BATTLEGROUND_AV)
                bg->ToBattlegroundAV()->HandleQuestComplete(questId, _player);

        if (_player->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE)
        {
            if (quest->IsRepeatable())
                _player->PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, _player->CanCompleteRepeatableQuest(quest), false);
            else
                _player->PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, _player->CanRewardQuest(quest, false), false);
        }
        else
        {
            if (quest->GetReqItemsCount())                  // some items required
                _player->PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, _player->CanRewardQuest(quest, false), false);
            else                                            // no items required
                _player->PlayerTalkClass->SendQuestGiverOfferReward(quest, guid, true);
        }
    }
}

void WorldSession::HandleQuestgiverQuestAutoLaunch(WorldPacket& /*recvPacket*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_QUEST_AUTOLAUNCH");
#endif
}

void WorldSession::HandlePushQuestToParty(WorldPacket& recvPacket)
{
    uint32 questId;
    recvPacket >> questId;

    if (!_player->CanShareQuest(questId))
        return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_PUSHQUESTTOPARTY quest = %u", questId);
#endif

    if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
    {
        if (Group* group = _player->GetGroup())
        {
            for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player* player = itr->GetSource();

                if (!player || player == _player || !player->IsInMap(_player))         // skip self
                    continue;

                if (!player->SatisfyQuestStatus(quest, false))
                {
                    _player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_HAVE_QUEST);
                    continue;
                }

                if (player->GetQuestStatus(questId) == QUEST_STATUS_COMPLETE)
                {
                    _player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_FINISH_QUEST);
                    continue;
                }

                if (!player->CanTakeQuest(quest, false))
                {
                    _player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_CANT_TAKE_QUEST);
                    continue;
                }

                if (!player->SatisfyQuestLog(false))
                {
                    _player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_LOG_FULL);
                    continue;
                }

                if (player->GetDivider() != 0)
                {
                    _player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_BUSY);
                    continue;
                }

                _player->SendPushToPartyResponse(player, QUEST_PARTY_MSG_SHARING_QUEST);

                if (quest->IsAutoAccept() && player->CanAddQuest(quest, true) && player->CanTakeQuest(quest, true))
                    player->AddQuestAndCheckCompletion(quest, _player);

                if ((quest->IsAutoComplete() && quest->IsRepeatable() && !quest->IsDailyOrWeekly()) || quest->HasFlag(QUEST_FLAGS_AUTOCOMPLETE))
                    player->PlayerTalkClass->SendQuestGiverRequestItems(quest, _player->GetGUID(), player->CanCompleteRepeatableQuest(quest), true);
                else
                {
                    player->SetDivider(_player->GetGUID());
                    player->PlayerTalkClass->SendQuestGiverQuestDetails(quest, player->GetGUID(), true);
                }
            }
        }
    }
}

void WorldSession::HandleQuestPushResult(WorldPacket& recvPacket)
{
    uint64 guid;
    uint32 questId;
    uint8 msg;
    recvPacket >> guid >> questId >> msg;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received MSG_QUEST_PUSH_RESULT");
#endif

    if (_player->GetDivider() && _player->GetDivider() == guid)
    {
        if (Player* player = ObjectAccessor::GetPlayer(*_player, _player->GetDivider()))
        {
            WorldPacket data(MSG_QUEST_PUSH_RESULT, 8 + 4 + 1);
            data << uint64(_player->GetGUID());
            data << uint8(msg);                             // valid values: 0-8
            player->GetSession()->SendPacket(&data);
            _player->SetDivider(0);
        }
    }
}

void WorldSession::HandleQuestgiverStatusMultipleQuery(WorldPacket& /*recvPacket*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_QUESTGIVER_STATUS_MULTIPLE_QUERY");
#endif

    uint32 count = 0;

    WorldPacket data(SMSG_QUESTGIVER_STATUS_MULTIPLE, 4);
    data << uint32(count);                                  // placeholder

    for (Player::ClientGUIDs::const_iterator itr = _player->m_clientGUIDs.begin(); itr != _player->m_clientGUIDs.end(); ++itr)
    {
        uint32 questStatus = DIALOG_STATUS_NONE;

        if (IS_CRE_OR_VEH_OR_PET_GUID(*itr))
        {
            // need also pet quests case support
            Creature* questgiver = ObjectAccessor::GetCreatureOrPetOrVehicle(*GetPlayer(), *itr);
            if (!questgiver || questgiver->IsHostileTo(_player))
                continue;
            if (!questgiver->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER))
                continue;

            questStatus = _player->GetQuestDialogStatus(questgiver);

            data << uint64(questgiver->GetGUID());
            data << uint8(questStatus);
            ++count;
        }
        else if (IS_GAMEOBJECT_GUID(*itr))
        {
            GameObject* questgiver = GetPlayer()->GetMap()->GetGameObject(*itr);
            if (!questgiver || questgiver->GetGoType() != GAMEOBJECT_TYPE_QUESTGIVER)
                continue;

            questStatus = _player->GetQuestDialogStatus(questgiver);

            data << uint64(questgiver->GetGUID());
            data << uint8(questStatus);
            ++count;
        }
    }

    data.put<uint32>(0, count);                             // write real count
    SendPacket(&data);
}

void WorldSession::HandleQueryQuestsCompleted(WorldPacket & /*recvData*/)
{
    size_t rew_count = _player->GetRewardedQuestCount();

    WorldPacket data(SMSG_QUERY_QUESTS_COMPLETED_RESPONSE, 4 + 4 * rew_count);
    data << uint32(rew_count);

    const RewardedQuestSet &rewQuests = _player->getRewardedQuests();
    for (RewardedQuestSet::const_iterator itr = rewQuests.begin(); itr != rewQuests.end(); ++itr)
        data << uint32(*itr);

    SendPacket(&data);
}
