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

#include "SmartScript.h"
#include "Cell.h"
#include "CellImpl.h"
#include "ChatTextBuilder.h"
#include "CreatureTextMgr.h"
#include "GameEventMgr.h"
#include "GossipDef.h"
#include "GridDefines.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Language.h"
#include "MoveSplineInit.h"
#include "ObjectDefines.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SmartAI.h"
#include "SpellMgr.h"
#include "Vehicle.h"

SmartScript::SmartScript()
{
    go = nullptr;
    me = nullptr;
    trigger = nullptr;
    mEventPhase = 0;
    mPathId = 0;
    mTargetStorage = new ObjectListMap();
    mTextTimer = 0;
    mLastTextID = 0;
    mUseTextTimer = false;
    mTalkerEntry = 0;
    mTemplate = SMARTAI_TEMPLATE_BASIC;
    mScriptType = SMART_SCRIPT_TYPE_CREATURE;
    isProcessingTimedActionList = false;

    // Xinef: Fix Combat Movement
    mActualCombatDist = 0;
    mMaxCombatDist = 0;

    smartCasterActualDist = 0.0f;
    smartCasterMaxDist = 0.0f;
    smartCasterPowerType = POWER_MANA;

    _allowPhaseReset = true;
}

SmartScript::~SmartScript()
{
    for (ObjectListMap::iterator itr = mTargetStorage->begin(); itr != mTargetStorage->end(); ++itr)
        delete itr->second;

    delete mTargetStorage;
    mCounterList.clear();
}

void SmartScript::OnReset()
{
    // xinef: check if we allow phase reset
    if (AllowPhaseReset())
        SetPhase(0);

    ResetBaseObject();
    for (SmartAIEventList::iterator i = mEvents.begin(); i != mEvents.end(); ++i)
    {
        if (!((*i).event.event_flags & SMART_EVENT_FLAG_DONT_RESET))
        {
            InitTimer((*i));
            (*i).runOnce = false;
        }
    }
    ProcessEventsFor(SMART_EVENT_RESET);
    mLastInvoker.Clear();
    mCounterList.clear();

    // Xinef: Fix Combat Movement
    RestoreMaxCombatDist();
    RestoreCasterMaxDist();
}

void SmartScript::ProcessEventsFor(SMART_EVENT e, Unit* unit, uint32 var0, uint32 var1, bool bvar, SpellInfo const* spell, GameObject* gob)
{
    for (SmartAIEventList::iterator i = mEvents.begin(); i != mEvents.end(); ++i)
    {
        SMART_EVENT eventType = SMART_EVENT((*i).GetEventType());
        if (eventType == SMART_EVENT_LINK)//special handling
            continue;

        if (eventType == e/* && (!(*i).event.event_phase_mask || IsInPhase((*i).event.event_phase_mask)) && !((*i).event.event_flags & SMART_EVENT_FLAG_NOT_REPEATABLE && (*i).runOnce)*/)
        {
            ConditionList conds = sConditionMgr->GetConditionsForSmartEvent((*i).entryOrGuid, (*i).event_id, (*i).source_type);
            ConditionSourceInfo info = ConditionSourceInfo(unit, GetBaseObject(), me ? me->GetVictim() : nullptr);

            if (sConditionMgr->IsObjectMeetToConditions(info, conds))
                ProcessEvent(*i, unit, var0, var1, bvar, spell, gob);
        }
    }
}

void SmartScript::ProcessAction(SmartScriptHolder& e, Unit* unit, uint32 var0, uint32 var1, bool bvar, SpellInfo const* spell, GameObject* gob)
{
    //calc random
    if (e.GetEventType() != SMART_EVENT_LINK && e.event.event_chance < 100 && e.event.event_chance)
    {
        uint32 rnd = urand(0, 100);
        if (e.event.event_chance <= rnd)
            return;
    }
    e.runOnce = true;//used for repeat check

    if (unit)
        mLastInvoker = unit->GetGUID();

    if (Unit* tempInvoker = GetLastInvoker())
        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: Invoker: {} ({})", tempInvoker->GetName(), tempInvoker->GetGUID().ToString());

    bool isControlled = e.action.moveToPos.controlled > 0;

    switch (e.GetActionType())
    {
        case SMART_ACTION_TALK:
            {
                ObjectList* targets = GetTargets(e, unit);
                Creature* talker = e.target.type == 0 ? me : nullptr;
                Unit* talkTarget = nullptr;
                if (targets)
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (IsCreature((*itr)) && !(*itr)->ToCreature()->IsPet()) // Prevented sending text to pets.
                        {
                            if (e.action.talk.useTalkTarget)
                            {
                                talker = me;
                                talkTarget = (*itr)->ToCreature();
                            }
                            else
                                talker = (*itr)->ToCreature();
                            break;
                        }
                        else if (IsPlayer((*itr)))
                        {
                            talker = me; // xinef: added
                            talkTarget = (*itr)->ToPlayer();
                            break;
                        }
                    }

                    delete targets;
                }

                if (!talkTarget)
                    talkTarget = GetLastInvoker();

                if (!talker)
                    break;

                if (!sCreatureTextMgr->TextExist(talker->GetEntry(), uint8(e.action.talk.textGroupID)))
                {
                    LOG_ERROR("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_TALK: EntryOrGuid {} SourceType {} EventType {} TargetType {} using non-existent Text id {} for talker {}, ignored.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetTargetType(), e.action.talk.textGroupID, talker->GetEntry());
                    break;
                }

                mTalkerEntry = talker->GetEntry();
                mLastTextID = e.action.talk.textGroupID;
                mTextTimer = e.action.talk.duration;
                mUseTextTimer = true;
                sCreatureTextMgr->SendChat(talker, uint8(e.action.talk.textGroupID), talkTarget);
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_TALK: talker: {} ({}), textId: {}", talker->GetName(), talker->GetGUID().ToString(), mLastTextID);
                break;
            }
        case SMART_ACTION_SIMPLE_TALK:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (IsCreature(*itr))
                            sCreatureTextMgr->SendChat((*itr)->ToCreature(), uint8(e.action.simpleTalk.textGroupID), IsPlayer(GetLastInvoker()) ? GetLastInvoker() : 0);
                        else if (IsPlayer(*itr) && me)
                        {
                            Unit* templastInvoker = GetLastInvoker();
                            sCreatureTextMgr->SendChat(me, uint8(e.action.simpleTalk.textGroupID), IsPlayer(templastInvoker) ? templastInvoker : 0, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, (*itr)->ToPlayer());
                        }

                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SIMPLE_TALK: talker: {} ({}), textGroupId: {}",
                                       (*itr)->GetName(), (*itr)->GetGUID().ToString(), uint8(e.action.simpleTalk.textGroupID));
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_PLAY_EMOTE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (IsUnit(*itr))
                        {
                            (*itr)->ToUnit()->HandleEmoteCommand(e.action.emote.emote);
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_PLAY_EMOTE: target: {} ({}), emote: {}",
                                           (*itr)->GetName(), (*itr)->GetGUID().ToString(), e.action.emote.emote);
                        }
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_SOUND:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (auto& target : *targets)
                    {
                        if (IsUnit(target))
                        {
                            if (e.action.sound.distance == 1)
                                target->PlayDistanceSound(e.action.sound.sound, e.action.sound.onlySelf ? target->ToPlayer() : nullptr);
                            else
                                target->PlayDirectSound(e.action.sound.sound, e.action.sound.onlySelf ? target->ToPlayer() : nullptr);
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SOUND: target: {} ({}), sound: {}, onlyself: {}",
                                           target->GetName(), target->GetGUID().ToString(), e.action.sound.sound, e.action.sound.onlySelf);
                        }
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_RANDOM_SOUND:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                uint32 sounds[4];
                sounds[0] = e.action.randomSound.sound1;
                sounds[1] = e.action.randomSound.sound2;
                sounds[2] = e.action.randomSound.sound3;
                sounds[3] = e.action.randomSound.sound4;
                uint32 temp[4];
                uint32 count = 0;
                for (uint8 i = 0; i < 4; i++)
                {
                    if (sounds[i])
                    {
                        temp[count] = sounds[i];
                        ++count;
                    }
                }

                if (count == 0)
                {
                    delete targets;
                    break;
                }

                for (auto& target : *targets)
                {
                    if (IsUnit(target))
                    {
                        uint32 sound = temp[urand(0, count - 1)];
                        if (e.action.randomSound.distance == 1)
                            target->PlayDistanceSound(sound, e.action.randomSound.onlySelf ? target->ToPlayer() : nullptr);
                        else
                            target->PlayDirectSound(sound, e.action.randomSound.onlySelf ? target->ToPlayer() : nullptr);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_SOUND: target: {} ({}), sound: {}, onlyself: {}",
                                       target->GetName(), target->GetGUID().ToString(), sound, e.action.randomSound.onlySelf);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_MUSIC:
            {
                ObjectList* targets = nullptr;

                if (e.action.music.type > 0)
                {
                    if (me && me->FindMap())
                    {
                        Map::PlayerList const& players = me->GetMap()->GetPlayers();
                        targets = new ObjectList();

                        if (!players.IsEmpty())
                        {
                            for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
                                if (Player* player = i->GetSource())
                                {
                                    if (player->GetZoneId() == me->GetZoneId())
                                    {
                                        if (e.action.music.type > 1)
                                        {
                                            if (player->GetAreaId() == me->GetAreaId())
                                                targets->push_back(player);
                                        }
                                        else
                                            targets->push_back(player);
                                    }
                                }
                        }
                    }
                }
                else
                    targets = GetTargets(e, unit);

                if (targets)
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (IsUnit(*itr))
                        {
                            (*itr)->SendPlayMusic(e.action.music.sound, e.action.music.onlySelf > 0);
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_MUSIC: target: {} ({}), sound: {}, onlySelf: {}, type: {}",
                                           (*itr)->GetName(), (*itr)->GetGUID().ToString(), e.action.music.sound, e.action.music.onlySelf, e.action.music.type);
                        }
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_RANDOM_MUSIC:
            {
                ObjectList* targets = nullptr;

                if (e.action.randomMusic.type > 0)
                {
                    if (me && me->FindMap())
                    {
                        Map::PlayerList const& players = me->GetMap()->GetPlayers();
                        targets = new ObjectList();

                        if (!players.IsEmpty())
                        {
                            for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
                                if (Player* player = i->GetSource())
                                {
                                    if (player->GetZoneId() == me->GetZoneId())
                                    {
                                        if (e.action.randomMusic.type > 1)
                                        {
                                            if (player->GetAreaId() == me->GetAreaId())
                                                targets->push_back(player);
                                        }
                                        else
                                            targets->push_back(player);
                                    }
                                }
                        }
                    }
                }
                else
                    targets = GetTargets(e, unit);

                if (!targets)
                    break;

                uint32 sounds[4];
                sounds[0] = e.action.randomMusic.sound1;
                sounds[1] = e.action.randomMusic.sound2;
                sounds[2] = e.action.randomMusic.sound3;
                sounds[3] = e.action.randomMusic.sound4;
                uint32 temp[4];
                uint32 count = 0;
                for (uint8 i = 0; i < 4; i++)
                {
                    if (sounds[i])
                    {
                        temp[count] = sounds[i];
                        ++count;
                    }
                }

                if (count == 0)
                {
                    delete targets;
                    break;
                }

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                    {
                        uint32 sound = temp[urand(0, count - 1)];
                        (*itr)->SendPlayMusic(sound, e.action.randomMusic.onlySelf > 0);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_MUSIC: target: {} ({}), sound: {}, onlyself: {}, type: {}",
                                       (*itr)->GetName(), (*itr)->GetGUID().ToString(), sound, e.action.randomMusic.onlySelf, e.action.randomMusic.type);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_FACTION:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (IsCreature(*itr))
                        {
                            if (e.action.faction.factionID)
                            {
                                (*itr)->ToCreature()->SetFaction(e.action.faction.factionID);
                                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SET_FACTION: Creature entry {} ({}) set faction to {}",
                                               (*itr)->GetEntry(), (*itr)->GetGUID().ToString(), e.action.faction.factionID);
                            }
                            else
                            {
                                if (CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate((*itr)->ToCreature()->GetEntry()))
                                {
                                    if ((*itr)->ToCreature()->GetFaction() != ci->faction)
                                    {
                                        (*itr)->ToCreature()->SetFaction(ci->faction);
                                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SET_FACTION: Creature entry {} ({}) set faction to {}",
                                                       (*itr)->GetEntry(), (*itr)->GetGUID().ToString(), ci->faction);
                                    }
                                }
                            }
                        }
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsCreature(*itr))
                        continue;

                    if (e.action.morphOrMount.creature || e.action.morphOrMount.model)
                    {
                        //set model based on entry from creature_template
                        if (e.action.morphOrMount.creature)
                        {
                            if (CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(e.action.morphOrMount.creature))
                            {
                                uint32 displayId = ObjectMgr::ChooseDisplayId(ci);
                                (*itr)->ToCreature()->SetDisplayId(displayId);
                                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry {} ({}) set displayid to {}",
                                               (*itr)->GetEntry(), (*itr)->GetGUID().ToString(), displayId);
                            }
                        }
                        //if no param1, then use value from param2 (modelId)
                        else
                        {
                            (*itr)->ToCreature()->SetDisplayId(e.action.morphOrMount.model);
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry {} ({}) set displayid to {}",
                                           (*itr)->GetEntry(), (*itr)->GetGUID().ToString(), e.action.morphOrMount.model);
                        }
                    }
                    else
                    {
                        (*itr)->ToCreature()->DeMorph();
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry {} ({}) demorphs.",
                                       (*itr)->GetEntry(), (*itr)->GetGUID().ToString());
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_FAIL_QUEST:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsPlayer(*itr))
                    {
                        (*itr)->ToPlayer()->FailQuest(e.action.quest.quest);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_FAIL_QUEST: Player {} fails quest {}",
                                       (*itr)->GetGUID().ToString(), e.action.quest.quest);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_OFFER_QUEST:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (Player* pTarget = (*itr)->ToPlayer())
                    {
                        if (Quest const* q = sObjectMgr->GetQuestTemplate(e.action.questOffer.questID))
                        {
                            if (me && e.action.questOffer.directAdd == 0)
                            {
                                if (pTarget->CanTakeQuest(q, true))
                                    if (WorldSession* session = pTarget->GetSession())
                                    {
                                        PlayerMenu menu(session);
                                        menu.SendQuestGiverQuestDetails(q, me->GetGUID(), true);
                                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_OFFER_QUEST: Player {}- offering quest {}",
                                            (*itr)->GetGUID().ToString(), e.action.questOffer.questID);
                                    }
                            }
                            else
                            {
                                (*itr)->ToPlayer()->AddQuestAndCheckCompletion(q, nullptr);
                               LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_OFFER_QUEST: Player {} - quest {} added",
                                    (*itr)->GetGUID().ToString(), e.action.questOffer.questID);
                            }
                        }
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_REACT_STATE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsCreature(*itr))
                        continue;

                    (*itr)->ToCreature()->SetReactState(ReactStates(e.action.react.state));
                }

                delete targets;
                break;
            }
        case SMART_ACTION_RANDOM_EMOTE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                uint32 emotes[SMART_ACTION_PARAM_COUNT];
                emotes[0] = e.action.randomEmote.emote1;
                emotes[1] = e.action.randomEmote.emote2;
                emotes[2] = e.action.randomEmote.emote3;
                emotes[3] = e.action.randomEmote.emote4;
                emotes[4] = e.action.randomEmote.emote5;
                emotes[5] = e.action.randomEmote.emote6;
                uint32 temp[SMART_ACTION_PARAM_COUNT];
                uint32 count = 0;
                for (uint8 i = 0; i < SMART_ACTION_PARAM_COUNT; i++)
                {
                    if (emotes[i])
                    {
                        temp[count] = emotes[i];
                        ++count;
                    }
                }

                if (count == 0)
                {
                    delete targets;
                    break;
                }

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                    {
                        uint32 emote = temp[urand(0, count - 1)];
                        (*itr)->ToUnit()->HandleEmoteCommand(emote);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_EMOTE: Creature {} handle random emote {}",
                                       (*itr)->GetGUID().ToString(), emote);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_THREAT_ALL_PCT:
            {
                if (!me)
                    break;

                ThreatContainer::StorageType threatList = me->getThreatMgr().getThreatList();
                for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
                {
                    if (Unit* target = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                    {
                        me->getThreatMgr().modifyThreatPercent(target, e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_THREAT_ALL_PCT: Creature {} modify threat for unit {}, value {}",
                                       me->GetGUID().ToString(), target->GetGUID().ToString(), e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
                    }
                }
                break;
            }
        case SMART_ACTION_THREAT_SINGLE_PCT:
            {
                if (!me)
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                    {
                        me->getThreatMgr().modifyThreatPercent((*itr)->ToUnit(), e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_THREAT_SINGLE_PCT: Creature {} modify threat for unit {}, value {}",
                                       me->GetGUID().ToString(), (*itr)->GetGUID().ToString(), e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    // Special handling for vehicles
                    if (IsUnit(*itr))
                    {
                        if (Vehicle* vehicle = (*itr)->ToUnit()->GetVehicleKit())
                            for (SeatMap::iterator it = vehicle->Seats.begin(); it != vehicle->Seats.end(); ++it)
                                if (Player* player = ObjectAccessor::GetPlayer(*(*itr), it->second.Passenger.Guid))
                                    player->AreaExploredOrEventHappens(e.action.quest.quest);

                        if (Player* player = (*itr)->ToUnit()->GetCharmerOrOwnerPlayerOrPlayerItself())
                        {
                            player->GroupEventHappens(e.action.quest.quest, GetBaseObject());
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS: Player {} credited quest {}",
                                           (*itr)->GetGUID().ToString(), e.action.quest.quest);
                        }
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_CAST:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                Unit* caster = me;
                // Areatrigger Cast!
                if (e.GetScriptType() == SMART_SCRIPT_TYPE_AREATRIGGER)
                    caster = unit->SummonTrigger(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetOrientation(), 5000);

                if (e.action.cast.targetsLimit > 0 && targets->size() > e.action.cast.targetsLimit)
                    Acore::Containers::RandomResize(*targets, e.action.cast.targetsLimit);

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (go)
                    {
                        // Xinef: may be nullptr!
                        go->CastSpell((*itr)->ToUnit(), e.action.cast.spell);
                    }

                    if (!IsUnit(*itr))
                        continue;

                    if (caster && caster != me) // Areatrigger cast
                    {
                        caster->CastSpell((*itr)->ToUnit(), e.action.cast.spell, (e.action.cast.flags & SMARTCAST_TRIGGERED));
                    }
                    else if (me && (!(e.action.cast.flags & SMARTCAST_AURA_NOT_PRESENT) || !(*itr)->ToUnit()->HasAura(e.action.cast.spell)))
                    {
                        if (e.action.cast.flags & SMARTCAST_INTERRUPT_PREVIOUS)
                            me->InterruptNonMeleeSpells(false);

                        // Xinef: flag usable only if caster has max dist set
                        if ((e.action.cast.flags & SMARTCAST_COMBAT_MOVE) && GetCasterMaxDist() > 0.0f && me->GetMaxPower(GetCasterPowerType()) > 0)
                        {
                            // Xinef: check mana case only and operate movement accordingly, LoS and range is checked in targetet movement generator
                            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(e.action.cast.spell);
                            int32 currentPower = me->GetPower(GetCasterPowerType());

                            if ((spellInfo && (currentPower < spellInfo->CalcPowerCost(me, spellInfo->GetSchoolMask()) || me->IsSpellProhibited(spellInfo->GetSchoolMask()))) || me->HasUnitFlag(UNIT_FLAG_SILENCED))
                            {
                                SetCasterActualDist(0);
                                CAST_AI(SmartAI, me->AI())->SetForcedCombatMove(0);
                            }
                            else if (GetCasterActualDist() == 0.0f && me->GetPowerPct(GetCasterPowerType()) > 30.0f)
                            {
                                RestoreCasterMaxDist();
                                CAST_AI(SmartAI, me->AI())->SetForcedCombatMove(GetCasterActualDist());
                            }
                        }

                        me->CastSpell((*itr)->ToUnit(), e.action.cast.spell, (e.action.cast.flags & SMARTCAST_TRIGGERED));
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_INVOKER_CAST:
            {
                Unit* tempLastInvoker = GetLastInvoker(unit); // xinef: can be used for area triggers cast
                if (!tempLastInvoker)
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                if (e.action.cast.targetsLimit > 0 && targets->size() > e.action.cast.targetsLimit)
                    Acore::Containers::RandomResize(*targets, e.action.cast.targetsLimit);

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsUnit(*itr))
                        continue;

                    if (!(e.action.cast.flags & SMARTCAST_AURA_NOT_PRESENT) || !(*itr)->ToUnit()->HasAura(e.action.cast.spell))
                    {
                        if (e.action.cast.flags & SMARTCAST_INTERRUPT_PREVIOUS)
                            tempLastInvoker->InterruptNonMeleeSpells(false);

                        tempLastInvoker->CastSpell((*itr)->ToUnit(), e.action.cast.spell, (e.action.cast.flags & SMARTCAST_TRIGGERED));
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_ADD_AURA:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                    {
                        (*itr)->ToUnit()->AddAura(e.action.addAura.spell, (*itr)->ToUnit());
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_ADD_AURA: Adding aura {} to unit {}",
                                       e.action.addAura.spell, (*itr)->GetGUID().ToString());
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_ACTIVATE_GOBJECT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsGameObject(*itr))
                    {
                        GameObject* go = (*itr)->ToGameObject();

                        // Activate
                        if (go->GetGoType() != GAMEOBJECT_TYPE_DOOR)
                        {
                            go->SetLootState(GO_READY);
                        }

                        go->UseDoorOrButton(0, !!e.action.activateObject.alternative, unit);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_ACTIVATE_GOBJECT. Gameobject {} activated", go->GetGUID().ToString());
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_RESET_GOBJECT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsGameObject(*itr))
                    {
                        (*itr)->ToGameObject()->ResetDoorOrButton();
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_RESET_GOBJECT. Gameobject {} reset",
                                       (*itr)->GetGUID().ToString());
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_EMOTE_STATE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                    {
                        (*itr)->ToUnit()->SetUInt32Value(UNIT_NPC_EMOTESTATE, e.action.emote.emote);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SET_EMOTE_STATE. Unit {} set emotestate to {}",
                                       (*itr)->GetGUID().ToString(), e.action.emote.emote);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_UNIT_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                    {
                        if (!e.action.unitFlag.type)
                        {
                            (*itr)->ToUnit()->SetUnitFlag(UnitFlags(e.action.unitFlag.flag));
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SET_UNIT_FLAG. Unit {} added flag {} to UNIT_FIELD_FLAGS",
                            (*itr)->GetGUID().ToString(), e.action.unitFlag.flag);
                        }
                        else
                        {
                            (*itr)->ToUnit()->SetUnitFlag2(UnitFlags2(e.action.unitFlag.flag));
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SET_UNIT_FLAG. Unit {} added flag {} to UNIT_FIELD_FLAGS_2",
                            (*itr)->GetGUID().ToString(), e.action.unitFlag.flag);
                        }
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVE_UNIT_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                    {
                        if (!e.action.unitFlag.type)
                        {
                            (*itr)->ToUnit()->RemoveUnitFlag(UnitFlags(e.action.unitFlag.flag));
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_REMOVE_UNIT_FLAG. Unit {} removed flag {} to UNIT_FIELD_FLAGS",
                            (*itr)->GetGUID().ToString(), e.action.unitFlag.flag);
                        }
                        else
                        {
                            (*itr)->ToUnit()->RemoveUnitFlag2(UnitFlags2(e.action.unitFlag.flag));
                            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_REMOVE_UNIT_FLAG. Unit {} removed flag {} to UNIT_FIELD_FLAGS_2",
                            (*itr)->GetGUID().ToString(), e.action.unitFlag.flag);
                        }
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_AUTO_ATTACK:
            {
                if (!IsSmart())
                    break;

                CAST_AI(SmartAI, me->AI())->SetAutoAttack(e.action.autoAttack.attack);
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_AUTO_ATTACK: Creature: {} bool on = {}",
                               me->GetGUID().ToString(), e.action.autoAttack.attack);
                break;
            }
        case SMART_ACTION_ALLOW_COMBAT_MOVEMENT:
            {
                if (!IsSmart())
                    break;

                // Xinef: Fix Combat Movement
                bool move = e.action.combatMove.move;
                if (move && GetMaxCombatDist() && e.GetEventType() == SMART_EVENT_MANA_PCT)
                {
                    SetActualCombatDist(0);
                    CAST_AI(SmartAI, me->AI())->SetForcedCombatMove(0);
                }
                else
                    CAST_AI(SmartAI, me->AI())->SetCombatMove(move);
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_ALLOW_COMBAT_MOVEMENT: Creature {} bool on = {}",
                               me->GetGUID().ToString(), e.action.combatMove.move);
                break;
            }
        case SMART_ACTION_SET_EVENT_PHASE:
            {
                if (!GetBaseObject())
                    break;

                SetPhase(e.action.setEventPhase.phase);
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SET_EVENT_PHASE: Creature {} set event phase {}",
                               GetBaseObject()->GetGUID().ToString(), e.action.setEventPhase.phase);
                break;
            }
        case SMART_ACTION_INC_EVENT_PHASE:
            {
                if (!GetBaseObject())
                    break;

                IncPhase(e.action.incEventPhase.inc);
                DecPhase(e.action.incEventPhase.dec);
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_INC_EVENT_PHASE: Creature {} inc event phase by {}, "
                               "decrease by {}", GetBaseObject()->GetGUID().ToString(), e.action.incEventPhase.inc, e.action.incEventPhase.dec);
                break;
            }
        case SMART_ACTION_EVADE:
            {
                if (!GetBaseObject())
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature((*itr)))
                        if ((*itr)->ToCreature()->IsAIEnabled)
                            (*itr)->ToCreature()->AI()->EnterEvadeMode();

                delete targets;
                break;
            }
        case SMART_ACTION_FLEE_FOR_ASSIST:
            {
                // Xinef: do not allow to flee without control (stun, fear etc)
                if (!me || me->HasUnitState(UNIT_STATE_LOST_CONTROL) || me->GetSpeed(MOVE_RUN) < 0.1f)
                    break;

                me->DoFleeToGetAssistance();
                if (e.action.flee.withEmote)
                {
                    Acore::BroadcastTextBuilder builder(me, CHAT_MSG_MONSTER_EMOTE, BROADCAST_TEXT_FLEE_FOR_ASSIST, me->getGender());
                    sCreatureTextMgr->SendChatPacket(me, builder, CHAT_MSG_MONSTER_EMOTE);
                }
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_FLEE_FOR_ASSIST: Creature {} DoFleeToGetAssistance", me->GetGUID().ToString());
                break;
            }
        case SMART_ACTION_COMBAT_STOP:
            {
                if (!me)
                    break;

                me->CombatStop(true);
                break;
            }
        case SMART_ACTION_CALL_GROUPEVENTHAPPENS:
            {
                if (!GetBaseObject())
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit((*itr)))
                    {
                        if (Player* player = (*itr)->ToUnit()->GetCharmerOrOwnerPlayerOrPlayerItself())
                            player->GroupEventHappens(e.action.quest.quest, GetBaseObject());
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_CALL_GROUPEVENTHAPPENS: Player {}, group credit for quest {}",
                                       (*itr)->GetGUID().ToString(), e.action.quest.quest);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVEAURASFROMSPELL:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsUnit((*itr)))
                        continue;

                    if (e.action.removeAura.spell)
                    {
                        if (e.action.removeAura.charges)
                        {
                            if (Aura* aur = (*itr)->ToUnit()->GetAura(e.action.removeAura.spell))
                                aur->ModCharges(-static_cast<int32>(e.action.removeAura.charges), AURA_REMOVE_BY_EXPIRE);
                        }
                        else
                            (*itr)->ToUnit()->RemoveAurasDueToSpell(e.action.removeAura.spell);
                    }
                    else
                        (*itr)->ToUnit()->RemoveAllAuras();

                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_REMOVEAURASFROMSPELL: Unit {}, spell {}",
                                   (*itr)->GetGUID().ToString(), e.action.removeAura.spell);
                }

                delete targets;
                break;
            }
        case SMART_ACTION_FOLLOW:
            {
                if (!IsSmart())
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                {
                    CAST_AI(SmartAI, me->AI())->StopFollow(false);
                    break;
                }

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit((*itr)))
                    {
                        float angle = e.action.follow.angle > 6 ? (e.action.follow.angle * M_PI / 180.0f) : e.action.follow.angle;
                        CAST_AI(SmartAI, me->AI())->SetFollow((*itr)->ToUnit(), float(int32(e.action.follow.dist)) + 0.1f, angle, e.action.follow.credit, e.action.follow.entry, e.action.follow.creditType, e.action.follow.aliveState);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_FOLLOW: Creature {} following target {}",
                                       me->GetGUID().ToString(), (*itr)->GetGUID().ToString());
                        break;
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_RANDOM_PHASE:
            {
                if (!GetBaseObject())
                    break;

                uint32 phases[SMART_ACTION_PARAM_COUNT];
                phases[0] = e.action.randomPhase.phase1;
                phases[1] = e.action.randomPhase.phase2;
                phases[2] = e.action.randomPhase.phase3;
                phases[3] = e.action.randomPhase.phase4;
                phases[4] = e.action.randomPhase.phase5;
                phases[5] = e.action.randomPhase.phase6;
                uint32 temp[SMART_ACTION_PARAM_COUNT];
                uint32 count = 0;
                for (uint8 i = 0; i < SMART_ACTION_PARAM_COUNT; i++)
                {
                    if (phases[i] > 0)
                    {
                        temp[count] = phases[i];
                        ++count;
                    }
                }

                if (count == 0)
                    break;

                uint32 phase = temp[urand(0, count - 1)];
                SetPhase(phase);
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_RANDOM_PHASE: Creature {} sets event phase to {}",
                               GetBaseObject()->GetGUID().ToString(), phase);
                break;
            }
        case SMART_ACTION_RANDOM_PHASE_RANGE:
            {
                if (!GetBaseObject())
                    break;

                uint32 phase = urand(e.action.randomPhaseRange.phaseMin, e.action.randomPhaseRange.phaseMax);
                SetPhase(phase);
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_RANDOM_PHASE_RANGE: Creature {} sets event phase to {}",
                               GetBaseObject()->GetGUID().ToString(), phase);
                break;
            }
        case SMART_ACTION_CALL_KILLEDMONSTER:
            {
                if (trigger && IsPlayer(unit))
                {
                    unit->ToPlayer()->RewardPlayerAndGroupAtEvent(e.action.killedMonster.creature, unit);
                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_CALL_KILLEDMONSTER: (trigger == true) Player {}, Killcredit: {}",
                                   unit->GetGUID().ToString(), e.action.killedMonster.creature);
                }
                else if (e.target.type == SMART_TARGET_NONE || e.target.type == SMART_TARGET_SELF) // Loot recipient and his group members
                {
                    if (!me)
                        break;

                    if (Player* player = me->GetLootRecipient())
                    {
                        player->RewardPlayerAndGroupAtEvent(e.action.killedMonster.creature, player);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_CALL_KILLEDMONSTER: Player {}, Killcredit: {}",
                            player->GetGUID().ToString(), e.action.killedMonster.creature);
                    }
                }
                else // Specific target type
                {
                    ObjectList* targets = GetTargets(e, unit);
                    if (!targets)
                        break;

                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (!IsUnit(*itr))
                            continue;

                        Player* player = (*itr)->ToUnit()->GetCharmerOrOwnerPlayerOrPlayerItself();
                        if (!player)
                            continue;

                        player->RewardPlayerAndGroupAtEvent(e.action.killedMonster.creature, player);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_CALL_KILLEDMONSTER: Player {}, Killcredit: {}",
                                       (*itr)->GetGUID().ToString(), e.action.killedMonster.creature);
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_SET_INST_DATA:
            {
                WorldObject* obj = GetBaseObject();
                if (!obj)
                    obj = unit;

                if (!obj)
                    break;

                InstanceScript* instance = obj->GetInstanceScript();
                if (!instance)
                {
                    LOG_ERROR("scripts.ai.sai", "SmartScript: Event {} attempt to set instance data without instance script. EntryOrGuid {}", e.GetEventType(), e.entryOrGuid);
                    break;
                }

                switch (e.action.setInstanceData.type)
                {
                    case 0:
                    {
                        instance->SetData(e.action.setInstanceData.field, e.action.setInstanceData.data);
                        LOG_DEBUG("scripts.ai.sai", "SmartScript::ProcessAction: SMART_ACTION_SET_INST_DATA: Field: {}, data: {}", e.action.setInstanceData.field, e.action.setInstanceData.data);
                    } break;
                    case 1:
                    {
                        instance->SetBossState(e.action.setInstanceData.field, static_cast<EncounterState>(e.action.setInstanceData.data));
                        LOG_DEBUG("scripts.ai.sai", "SmartScript::ProcessAction: SMART_ACTION_SET_INST_DATA: SetBossState BossId: {}, State: {} ({})", e.action.setInstanceData.field, e.action.setInstanceData.data, InstanceScript::GetBossStateName(e.action.setInstanceData.data));
                    } break;
                    default:
                    {
                        break;
                    }
                }
                break;
            }
        case SMART_ACTION_SET_INST_DATA64:
            {
                WorldObject* obj = GetBaseObject();
                if (!obj)
                    obj = unit;

                if (!obj)
                    break;

                InstanceScript* instance = obj->GetInstanceScript();
                if (!instance)
                {
                    LOG_ERROR("sql.sql", "SmartScript: Event {} attempt to set instance data without instance script. EntryOrGuid {}", e.GetEventType(), e.entryOrGuid);
                    break;
                }

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                instance->SetGuidData(e.action.setInstanceData64.field, targets->front()->GetGUID());
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_SET_INST_DATA64: Field: {}, data: {}", e.action.setInstanceData64.field, targets->front()->GetGUID().GetRawValue());
                delete targets;
                break;
            }
        case SMART_ACTION_UPDATE_TEMPLATE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->UpdateEntry(e.action.updateTemplate.creature, nullptr, e.action.updateTemplate.updateLevel != 0);

                delete targets;
                break;
            }
        case SMART_ACTION_DIE:
            {
                if (me && !me->isDead())
                {
                    Unit::Kill(me, me);
                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_DIE: Creature {}", me->GetGUID().ToString());
                }
                break;
            }
        case SMART_ACTION_SET_IN_COMBAT_WITH_ZONE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                if (!me->GetMap()->IsDungeon())
                {
                    ObjectList* units = GetWorldObjectsInDist((float)e.action.combatZone.range);
                    if (!units->empty() && GetBaseObject())
                        for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                            if (IsPlayer(*itr) && !(*itr)->ToPlayer()->isDead())
                            {
                                me->SetInCombatWith((*itr)->ToPlayer());
                                (*itr)->ToPlayer()->SetInCombatWith(me);
                                me->AddThreat((*itr)->ToPlayer(), 0.0f);
                            }
                }
                else
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                        if (IsCreature(*itr))
                            (*itr)->ToCreature()->SetInCombatWithZone();
                }

                delete targets;
                break;
            }
        case SMART_ACTION_CALL_FOR_HELP:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature(*itr))
                    {
                        (*itr)->ToCreature()->CallForHelp((float)e.action.callHelp.range, e.GetEventType() == SMART_EVENT_AGGRO ? unit : nullptr);
                        if (e.action.callHelp.withEmote)
                        {
                            Acore::BroadcastTextBuilder builder(*itr, CHAT_MSG_MONSTER_EMOTE, BROADCAST_TEXT_CALL_FOR_HELP, LANG_UNIVERSAL, nullptr);
                            sCreatureTextMgr->SendChatPacket(*itr, builder, CHAT_MSG_MONSTER_EMOTE);
                        }
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_SHEATH:
            {
                if (me)
                {
                    me->SetSheath(SheathState(e.action.setSheath.sheath));
                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_SET_SHEATH: Creature {}, State: {}",
                                   me->GetGUID().ToString(), e.action.setSheath.sheath);
                }
                break;
            }
        case SMART_ACTION_FORCE_DESPAWN:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    Milliseconds despawnDelay(e.action.forceDespawn.delay);

                    // Wait at least one world update tick before despawn, so it doesn't break linked actions.
                    if (despawnDelay <= 0ms)
                    {
                        despawnDelay = 1ms;
                    }

                    Seconds forceRespawnTimer(e.action.forceDespawn.forceRespawnTimer);
                    if (Creature* creature = (*itr)->ToCreature())
                    {
                        creature->DespawnOrUnsummon(despawnDelay, forceRespawnTimer);
                    }
                    else if (GameObject* go = (*itr)->ToGameObject())
                    {
                        go->DespawnOrUnsummon(despawnDelay, forceRespawnTimer);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_INGAME_PHASE_MASK:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->SetPhaseMask(e.action.ingamePhaseMask.mask, true);
                    else if (IsGameObject(*itr))
                        (*itr)->ToGameObject()->SetPhaseMask(e.action.ingamePhaseMask.mask, true);
                }

                delete targets;
                break;
            }
        case SMART_ACTION_MOUNT_TO_ENTRY_OR_MODEL:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsUnit(*itr))
                        continue;

                    if (e.action.morphOrMount.creature || e.action.morphOrMount.model)
                    {
                        if (e.action.morphOrMount.creature > 0)
                        {
                            if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(e.action.morphOrMount.creature))
                                (*itr)->ToUnit()->Mount(ObjectMgr::ChooseDisplayId(cInfo));
                        }
                        else
                            (*itr)->ToUnit()->Mount(e.action.morphOrMount.model);
                    }
                    else
                        (*itr)->ToUnit()->Dismount();
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_INVINCIBILITY_HP_LEVEL:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature(*itr))
                    {
                        SmartAI* ai = CAST_AI(SmartAI, (*itr)->ToCreature()->AI());
                        if (!ai)
                            continue;

                        if (e.action.invincHP.percent)
                            ai->SetInvincibilityHpLevel((*itr)->ToCreature()->CountPctFromMaxHealth(e.action.invincHP.percent));
                        else
                            ai->SetInvincibilityHpLevel(e.action.invincHP.minHP);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_DATA:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->AI()->SetData(e.action.setData.field, e.action.setData.data);
                    else if (IsGameObject(*itr))
                        (*itr)->ToGameObject()->AI()->SetData(e.action.setData.field, e.action.setData.data);
                }

                delete targets;
                break;
            }
        case SMART_ACTION_MOVE_FORWARD:
            {
                if (!me)
                    break;

                float x, y, z;
                me->GetClosePoint(x, y, z, me->GetObjectSize() / 3, (float)e.action.moveRandom.distance);
                me->GetMotionMaster()->MovePoint(SMART_RANDOM_POINT, x, y, z);
                break;
            }
        case SMART_ACTION_RISE_UP:
            {
                if (!me)
                    break;

                me->GetMotionMaster()->MovePoint(SMART_RANDOM_POINT, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + (float)e.action.moveRandom.distance);
                break;
            }
        case SMART_ACTION_SET_VISIBILITY:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->SetVisible(!!e.action.visibility.state);

                delete targets;
                break;
            }
        case SMART_ACTION_SET_ACTIVE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    (*itr)->setActive(!!e.action.setActive.state);

                delete targets;
                break;
            }
        case SMART_ACTION_ATTACK_START:
            {
                if (!me)
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                // xinef: attack random target
                if (Unit* target = Acore::Containers::SelectRandomContainerElement(*targets)->ToUnit())
                    me->AI()->AttackStart(target);

                delete targets;
                break;
            }
        case SMART_ACTION_ATTACK_STOP:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                {
                    break;
                }

                for (auto const& target : *targets)
                {
                    if (Unit* unitTarget = target->ToUnit())
                    {
                        unitTarget->AttackStop();
                    }
                }
                break;
            }
        case SMART_ACTION_SUMMON_CREATURE:
            {
                ObjectList* targets = GetTargets(e, unit);
                WorldObject* summoner = GetBaseObject() ? GetBaseObject() : unit;
                if (!summoner)
                    break;

                if (e.GetTargetType() == SMART_TARGET_RANDOM_POINT)
                {
                    float range = (float)e.target.randomPoint.range;
                    Position randomPoint;
                    Position srcPos = { e.target.x, e.target.y, e.target.z, e.target.o };
                    for (uint32 i = 0; i < e.target.randomPoint.amount; i++)
                    {
                        if (e.target.randomPoint.self > 0)
                            randomPoint = me->GetRandomPoint(me->GetPosition(), range);
                        else
                            randomPoint = me->GetRandomPoint(srcPos, range);
                        if (Creature* summon = summoner->SummonCreature(e.action.summonCreature.creature, randomPoint, (TempSummonType)e.action.summonCreature.type, e.action.summonCreature.duration))
                        {
                            if (unit && e.action.summonCreature.attackInvoker)
                                summon->AI()->AttackStart(unit);
                            else if (me && e.action.summonCreature.attackScriptOwner)
                                summon->AI()->AttackStart(me);
                        }
                    }
                    break;
                }

                if (targets)
                {
                    float x, y, z, o;
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        (*itr)->GetPosition(x, y, z, o);
                        x += e.target.x;
                        y += e.target.y;
                        z += e.target.z;
                        o += e.target.o;
                        if (Creature* summon = summoner->SummonCreature(e.action.summonCreature.creature, x, y, z, o, (TempSummonType)e.action.summonCreature.type, e.action.summonCreature.duration))
                        {
                            if (e.action.summonCreature.attackInvoker == 2) // pussywizard: proper attackInvoker implementation
                                summon->AI()->AttackStart(unit);
                            else if (e.action.summonCreature.attackInvoker)
                                summon->AI()->AttackStart((*itr)->ToUnit());
                            else if (me && e.action.summonCreature.attackScriptOwner)
                                summon->AI()->AttackStart(me);
                        }
                    }

                    delete targets;
                }

                if (e.GetTargetType() != SMART_TARGET_POSITION)
                    break;

                if (Creature* summon = summoner->SummonCreature(e.action.summonCreature.creature, e.target.x, e.target.y, e.target.z, e.target.o, (TempSummonType)e.action.summonCreature.type, e.action.summonCreature.duration))
                {
                    if (unit && e.action.summonCreature.attackInvoker)
                        summon->AI()->AttackStart(unit);
                    else if (me && e.action.summonCreature.attackScriptOwner)
                        summon->AI()->AttackStart(me);
                }
                break;
            }
        case SMART_ACTION_SUMMON_GO:
            {
                if (!GetBaseObject())
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    float x, y, z, o;
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        // xinef: allow gameobjects to summon gameobjects!
                        //if(!IsUnit((*itr)))
                        //  continue;

                        (*itr)->GetPosition(x, y, z, o);
                        x += e.target.x;
                        y += e.target.y;
                        z += e.target.z;
                        o += e.target.o;
                        if (!e.action.summonGO.targetsummon)
                            GetBaseObject()->SummonGameObject(e.action.summonGO.entry, x, y, z, o, 0, 0, 0, 0, e.action.summonGO.despawnTime);
                        else
                            (*itr)->SummonGameObject(e.action.summonGO.entry, GetBaseObject()->GetPositionX(), GetBaseObject()->GetPositionY(), GetBaseObject()->GetPositionZ(), GetBaseObject()->GetOrientation(), 0, 0, 0, 0, e.action.summonGO.despawnTime);
                    }

                    delete targets;
                }

                if (e.GetTargetType() != SMART_TARGET_POSITION)
                    break;

                GetBaseObject()->SummonGameObject(e.action.summonGO.entry, e.target.x, e.target.y, e.target.z, e.target.o, 0, 0, 0, 0, e.action.summonGO.despawnTime);
                break;
            }
        case SMART_ACTION_KILL_UNIT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsUnit(*itr))
                        continue;

                    Unit::Kill((*itr)->ToUnit(), (*itr)->ToUnit());
                }

                delete targets;
                break;
            }
        case SMART_ACTION_INSTALL_AI_TEMPLATE:
            {
                InstallTemplate(e);
                break;
            }
        case SMART_ACTION_ADD_ITEM:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsPlayer(*itr))
                        continue;

                    (*itr)->ToPlayer()->AddItem(e.action.item.entry, e.action.item.count);
                }

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVE_ITEM:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsPlayer(*itr))
                        continue;

                    (*itr)->ToPlayer()->DestroyItemCount(e.action.item.entry, e.action.item.count, true);
                }

                delete targets;
                break;
            }
        case SMART_ACTION_STORE_TARGET_LIST:
            {
                ObjectList* targets = GetTargets(e, unit);
                StoreTargetList(targets, e.action.storeTargets.id);
                break;
            }
        case SMART_ACTION_TELEPORT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsPlayer(*itr))
                        (*itr)->ToPlayer()->TeleportTo(e.action.teleport.mapID, e.target.x, e.target.y, e.target.z, e.target.o);
                    else if (IsUnit(*itr))
                        (*itr)->ToUnit()->NearTeleportTo(e.target.x, e.target.y, e.target.z, e.target.o);
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_FLY:
            {
                if (!IsSmart())
                    break;

                CAST_AI(SmartAI, me->AI())->SetFly(e.action.setFly.fly);
                // Xinef: Set speed if any
                if (e.action.setFly.speed)
                    me->SetSpeed(MOVE_RUN, float(e.action.setFly.speed / 100.0f), true);

                // Xinef: this wil be executed only if state is different
                me->SetDisableGravity(e.action.setFly.disableGravity);
                break;
            }
        case SMART_ACTION_SET_RUN:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature(*itr))
                    {
                        if (IsSmart((*itr)->ToCreature()))
                            CAST_AI(SmartAI, (*itr)->ToCreature()->AI())->SetRun(e.action.setRun.run);
                        else
                            (*itr)->ToCreature()->SetWalk(e.action.setRun.run ? false : true); // Xinef: reversed
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_SWIM:
            {
                if (!IsSmart())
                    break;

                CAST_AI(SmartAI, me->AI())->SetSwim(e.action.setSwim.swim);
                break;
            }
        case SMART_ACTION_SET_COUNTER:
            {
                if (ObjectList* targets = GetTargets(e, unit))
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (IsCreature(*itr))
                        {
                            if (SmartAI* ai = CAST_AI(SmartAI, (*itr)->ToCreature()->AI()))
                                ai->GetScript()->StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset, e.action.setCounter.subtract);
                            else
                                LOG_ERROR("scripts.ai.sai", "SmartScript: Action target for SMART_ACTION_SET_COUNTER is not using SmartAI, skipping");
                        }
                        else if (IsGameObject(*itr))
                        {
                            if (SmartGameObjectAI* ai = CAST_AI(SmartGameObjectAI, (*itr)->ToGameObject()->AI()))
                                ai->GetScript()->StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset, e.action.setCounter.subtract);
                            else
                                LOG_ERROR("scripts.ai.sai", "SmartScript: Action target for SMART_ACTION_SET_COUNTER is not using SmartGameObjectAI, skipping");
                        }
                    }
                    delete targets;
                }
                else
                {
                    StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset, e.action.setCounter.subtract);
                }
                break;
            }
        case SMART_ACTION_WP_START:
            {
                if (!IsSmart())
                    break;

                bool run = e.action.wpStart.run;
                uint32 entry = e.action.wpStart.pathID;
                bool repeat = e.action.wpStart.repeat;

                // Xinef: ensure that SMART_ESCORT_TARGETS contains at least one player reference
                bool stored = false;
                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (IsPlayer(*itr))
                        {
                            stored = true;
                            StoreTargetList(targets, SMART_ESCORT_TARGETS);
                            break;
                        }
                    }
                    if (!stored)
                        delete targets;
                }
                if (e.action.wpStart.reactState <= REACT_AGGRESSIVE)
                {
                    me->SetReactState((ReactStates) e.action.wpStart.reactState);
                }
                CAST_AI(SmartAI, me->AI())->StartPath(run, entry, repeat, unit);

                uint32 quest = e.action.wpStart.quest;
                uint32 DespawnTime = e.action.wpStart.despawnTime;
                CAST_AI(SmartAI, me->AI())->mEscortQuestID = quest;
                CAST_AI(SmartAI, me->AI())->SetDespawnTime(DespawnTime);
                break;
            }
        case SMART_ACTION_WP_PAUSE:
            {
                if (!IsSmart())
                    break;

                uint32 delay = e.action.wpPause.delay;
                CAST_AI(SmartAI, me->AI())->PausePath(delay, e.GetEventType() == SMART_EVENT_WAYPOINT_REACHED ? false : true);
                break;
            }
        case SMART_ACTION_WP_STOP:
            {
                if (!IsSmart())
                    break;

                uint32 DespawnTime = e.action.wpStop.despawnTime;
                uint32 quest = e.action.wpStop.quest;
                bool fail = e.action.wpStop.fail;
                CAST_AI(SmartAI, me->AI())->StopPath(DespawnTime, quest, fail);
                break;
            }
        case SMART_ACTION_WP_RESUME:
            {
                if (!IsSmart())
                    break;

                CAST_AI(SmartAI, me->AI())->SetWPPauseTimer(0);
                break;
            }
        case SMART_ACTION_SET_ORIENTATION:
            {
                if (!me)
                    break;

                if (e.action.orientation.random > 0)
                {
                    float randomOri = frand(0.0f, 2 * M_PI);
                    me->SetFacingTo(randomOri);
                    if (e.action.orientation.quickChange)
                        me->SetOrientation(randomOri);
                    break;
                }

                if (e.GetTargetType() == SMART_TARGET_SELF)
                {
                    me->SetFacingTo((me->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && me->GetTransGUID() ? me->GetTransportHomePosition() : me->GetHomePosition()).GetOrientation());
                    if (e.action.orientation.quickChange)
                        me->SetOrientation((me->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && me->GetTransGUID() ? me->GetTransportHomePosition() : me->GetHomePosition()).GetOrientation());
                }
                else if (e.GetTargetType() == SMART_TARGET_POSITION)
                {
                    me->SetFacingTo(e.target.o);
                    if (e.action.orientation.quickChange)
                        me->SetOrientation(e.target.o);
                }
                else if (ObjectList* targets = GetTargets(e, unit))
                {
                    if (!targets->empty())
                    {
                        me->SetFacingToObject(*targets->begin());
                        if (e.action.orientation.quickChange)
                            me->SetInFront(*targets->begin());
                    }

                    delete targets;
                }

                break;
            }
        case SMART_ACTION_PLAYMOVIE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (!IsPlayer(*itr))
                        continue;

                    (*itr)->ToPlayer()->SendMovieStart(e.action.movie.entry);
                }

                delete targets;
                break;
            }
        case SMART_ACTION_MOVE_TO_POS:
            {
                if (!IsSmart())
                    break;

                WorldObject* target = nullptr;

                if (e.GetTargetType() == SMART_TARGET_RANDOM_POINT)
                {
                    if (me)
                    {
                        float range = (float)e.target.randomPoint.range;
                        Position srcPos = { e.target.x, e.target.y, e.target.z, e.target.o };
                        Position randomPoint = me->GetRandomPoint(srcPos, range);
                        me->GetMotionMaster()->MovePoint(
                            e.action.moveToPos.pointId,
                            randomPoint.m_positionX,
                            randomPoint.m_positionY,
                            randomPoint.m_positionZ,
                            true,
                            true,
                            isControlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE
                        );
                    }

                    break;
                }

                /*if (e.GetTargetType() == SMART_TARGET_CREATURE_RANGE || e.GetTargetType() == SMART_TARGET_CREATURE_GUID ||
                e.GetTargetType() == SMART_TARGET_CREATURE_DISTANCE || e.GetTargetType() == SMART_TARGET_GAMEOBJECT_RANGE ||
                e.GetTargetType() == SMART_TARGET_GAMEOBJECT_GUID || e.GetTargetType() == SMART_TARGET_GAMEOBJECT_DISTANCE ||
                e.GetTargetType() == SMART_TARGET_CLOSEST_CREATURE || e.GetTargetType() == SMART_TARGET_CLOSEST_GAMEOBJECT ||
                e.GetTargetType() == SMART_TARGET_OWNER_OR_SUMMONER || e.GetTargetType() == SMART_TARGET_ACTION_INVOKER ||
                e.GetTargetType() == SMART_TARGET_CLOSEST_ENEMY || e.GetTargetType() == SMART_TARGET_CLOSEST_FRIENDLY ||
                e.GetTargetType() == SMART_TARGET_SELF || e.GetTargetType() == SMART_TARGET_STORED) // Xinef: bieda i rozpierdol TC)*/
                {
                    if (ObjectList* targets = GetTargets(e, unit))
                    {
                        // xinef: we want to move to random element
                        target = Acore::Containers::SelectRandomContainerElement(*targets);
                        delete targets;
                    }
                }

                if (!target)
                {
                    G3D::Vector3 dest(e.target.x, e.target.y, e.target.z);
                    if (e.action.moveToPos.transport)
                        if (TransportBase* trans = me->GetDirectTransport())
                            trans->CalculatePassengerPosition(dest.x, dest.y, dest.z);

                    me->GetMotionMaster()->MovePoint(e.action.moveToPos.pointId, dest.x, dest.y, dest.z, true, true,
                        isControlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE, e.target.o);
                }
                else // Xinef: we can use dest.x, dest.y, dest.z to make offset
                {
                    float x, y, z;
                    target->GetPosition(x, y, z);
                    if (e.action.moveToPos.ContactDistance > 0)
                        target->GetContactPoint(me, x, y, z, e.action.moveToPos.ContactDistance);
                    me->GetMotionMaster()->MovePoint(e.action.moveToPos.pointId, x + e.target.x, y + e.target.y, z + e.target.z, true, true, isControlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE);
                }
                break;
            }
        case SMART_ACTION_MOVE_TO_POS_TARGET:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    return;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature(*itr))
                    {
                        Creature* target = (*itr)->ToCreature();
                        target->GetMotionMaster()->MovePoint(e.action.moveToPos.pointId, e.target.x, e.target.y, e.target.z, true, true, isControlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_RESPAWN_TARGET:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->Respawn(e.action.RespawnTarget.goRespawnTime);
                    else if (IsGameObject(*itr))
                    {
                        // Xinef: do not modify respawndelay of already spawned gameobjects QQ
                        if ((*itr)->ToGameObject()->isSpawnedByDefault())
                            (*itr)->ToGameObject()->Respawn();
                        else
                            (*itr)->ToGameObject()->SetRespawnTime(e.action.RespawnTarget.goRespawnTime);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_CLOSE_GOSSIP:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsPlayer(*itr))
                        (*itr)->ToPlayer()->PlayerTalkClass->SendCloseGossip();

                delete targets;
                break;
            }
        case SMART_ACTION_EQUIP:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (Creature* npc = (*itr)->ToCreature())
                    {
                        uint32 slot[3];
                        int8 equipId = (int8)e.action.equip.entry;
                        if (equipId)
                        {
                            EquipmentInfo const* einfo = sObjectMgr->GetEquipmentInfo(npc->GetEntry(), equipId);
                            if (!einfo)
                            {
                                LOG_ERROR("scripts.ai.sai", "SmartScript: SMART_ACTION_EQUIP uses non-existent equipment info id {} for creature {}", equipId, npc->GetEntry());
                                break;
                            }
                            npc->SetCurrentEquipmentId(equipId);
                            slot[0] = einfo->ItemEntry[0];
                            slot[1] = einfo->ItemEntry[1];
                            slot[2] = einfo->ItemEntry[2];
                        }
                        else
                        {
                            slot[0] = e.action.equip.slot1;
                            slot[1] = e.action.equip.slot2;
                            slot[2] = e.action.equip.slot3;
                        }
                        if (!e.action.equip.mask || (e.action.equip.mask & 1))
                            npc->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, slot[0]);
                        if (!e.action.equip.mask || (e.action.equip.mask & 2))
                            npc->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, slot[1]);
                        if (!e.action.equip.mask || (e.action.equip.mask & 4))
                            npc->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 2, slot[2]);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_CREATE_TIMED_EVENT:
            {
                SmartEvent ne = SmartEvent();
                ne.type = (SMART_EVENT)SMART_EVENT_UPDATE;
                ne.event_chance = e.action.timeEvent.chance;
                if (!ne.event_chance) ne.event_chance = 100;

                ne.minMaxRepeat.min = e.action.timeEvent.min;
                ne.minMaxRepeat.max = e.action.timeEvent.max;
                ne.minMaxRepeat.repeatMin = e.action.timeEvent.repeatMin;
                ne.minMaxRepeat.repeatMax = e.action.timeEvent.repeatMax;

                ne.event_flags = 0;
                if (!ne.minMaxRepeat.repeatMin && !ne.minMaxRepeat.repeatMax)
                    ne.event_flags |= SMART_EVENT_FLAG_NOT_REPEATABLE;

                SmartAction ac = SmartAction();
                ac.type = (SMART_ACTION)SMART_ACTION_TRIGGER_TIMED_EVENT;
                ac.timeEvent.id = e.action.timeEvent.id;

                SmartScriptHolder ev = SmartScriptHolder();
                ev.event = ne;
                ev.event_id = e.action.timeEvent.id;
                ev.target = e.target;
                ev.action = ac;
                InitTimer(ev);
                mStoredEvents.push_back(ev);
                break;
            }
        case SMART_ACTION_TRIGGER_TIMED_EVENT:
            ProcessEventsFor((SMART_EVENT)SMART_EVENT_TIMED_EVENT_TRIGGERED, nullptr, e.action.timeEvent.id);

            // xinef: remove this event if not repeatable
            if (e.event.event_flags & SMART_EVENT_FLAG_NOT_REPEATABLE)
                mRemIDs.push_back(e.action.timeEvent.id);
            break;
        case SMART_ACTION_REMOVE_TIMED_EVENT:
            mRemIDs.push_back(e.action.timeEvent.id);
            break;
        case SMART_ACTION_OVERRIDE_SCRIPT_BASE_OBJECT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature(*itr))
                    {
                        if (!meOrigGUID)
                            meOrigGUID = me ? me->GetGUID() : ObjectGuid::Empty;
                        if (!goOrigGUID)
                            goOrigGUID = go ? go->GetGUID() : ObjectGuid::Empty;
                        go = nullptr;
                        me = (*itr)->ToCreature();
                        break;
                    }
                    else if (IsGameObject(*itr))
                    {
                        if (!meOrigGUID)
                            meOrigGUID = me ? me->GetGUID() : ObjectGuid::Empty;
                        if (!goOrigGUID)
                            goOrigGUID = go ? go->GetGUID() : ObjectGuid::Empty;
                        go = (*itr)->ToGameObject();
                        me = nullptr;
                        break;
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_RESET_SCRIPT_BASE_OBJECT:
            ResetBaseObject();
            break;
        case SMART_ACTION_CALL_SCRIPT_RESET:
            OnReset();
            break;
        case SMART_ACTION_SET_RANGED_MOVEMENT:
            {
                if (!IsSmart())
                    break;

                float attackDistance = float(e.action.setRangedMovement.distance);
                float attackAngle = float(e.action.setRangedMovement.angle) / 180.0f * M_PI;

                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (ObjectList::iterator itr = targets->begin(); itr != targets->end(); ++itr)
                        if (Creature* target = (*itr)->ToCreature())
                            if (IsSmart(target) && target->GetVictim())
                                if (CAST_AI(SmartAI, target->AI())->CanCombatMove())
                                    target->GetMotionMaster()->MoveChase(target->GetVictim(), attackDistance, attackAngle);

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_CALL_TIMED_ACTIONLIST:
            {
                if (e.GetTargetType() == SMART_TARGET_NONE)
                {
                    LOG_ERROR("sql.sql", "SmartScript: Entry {} SourceType {} Event {} Action {} is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                    break;
                }

                if (ObjectList* targets = GetTargets(e, unit))
                {
                    for (ObjectList::iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (Creature* target = (*itr)->ToCreature())
                        {
                            if (IsSmart(target))
                                CAST_AI(SmartAI, target->AI())->SetScript9(e, e.action.timedActionList.id, GetLastInvoker());
                        }
                        else if (GameObject* goTarget = (*itr)->ToGameObject())
                        {
                            if (IsSmartGO(goTarget))
                                CAST_AI(SmartGameObjectAI, goTarget->AI())->SetScript9(e, e.action.timedActionList.id, GetLastInvoker());
                        }
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_SET_NPC_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToUnit()->SetUInt32Value(UNIT_NPC_FLAGS, e.action.flag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_ADD_NPC_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToUnit()->SetFlag(UNIT_NPC_FLAGS, e.action.flag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVE_NPC_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToUnit()->RemoveFlag(UNIT_NPC_FLAGS, e.action.flag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_CROSS_CAST:
            {
                ObjectList* casters = GetTargets(CreateSmartEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, 0, 0, 0, SMART_ACTION_NONE, 0, 0, 0, 0, 0, 0, (SMARTAI_TARGETS)e.action.crossCast.targetType, e.action.crossCast.targetParam1, e.action.crossCast.targetParam2, e.action.crossCast.targetParam3, 0, 0), unit);
                if (!casters)
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                {
                    delete casters; // casters already validated, delete now
                    break;
                }

                for (ObjectList::const_iterator itr = casters->begin(); itr != casters->end(); ++itr)
                {
                    if (!IsUnit(*itr))
                        continue;

                    bool interruptedSpell = false;

                    for (ObjectList::const_iterator it = targets->begin(); it != targets->end(); ++it)
                    {
                        if (!IsUnit(*it))
                            continue;

                        if (!(e.action.cast.flags & SMARTCAST_AURA_NOT_PRESENT) || !(*it)->ToUnit()->HasAura(e.action.cast.spell))
                        {
                            if (!interruptedSpell && e.action.cast.flags & SMARTCAST_INTERRUPT_PREVIOUS)
                            {
                                (*itr)->ToUnit()->InterruptNonMeleeSpells(false);
                                interruptedSpell = true;
                            }

                            (*itr)->ToUnit()->CastSpell((*it)->ToUnit(), e.action.cast.spell, (e.action.cast.flags & SMARTCAST_TRIGGERED));
                        }
                        else
                            LOG_DEBUG("sql.sql", "Spell {} not casted because it has flag SMARTCAST_AURA_NOT_PRESENT and the target {} already has the aura",
                                e.action.cast.spell, (*it)->GetGUID().ToString());
                    }
                }

                delete targets;
                delete casters;
                break;
            }
        case SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST:
            {
                uint32 actions[SMART_ACTION_PARAM_COUNT];
                actions[0] = e.action.randTimedActionList.entry1;
                actions[1] = e.action.randTimedActionList.entry2;
                actions[2] = e.action.randTimedActionList.entry3;
                actions[3] = e.action.randTimedActionList.entry4;
                actions[4] = e.action.randTimedActionList.entry5;
                actions[5] = e.action.randTimedActionList.entry6;
                uint32 temp[SMART_ACTION_PARAM_COUNT];
                uint32 count = 0;
                for (uint8 i = 0; i < SMART_ACTION_PARAM_COUNT; i++)
                {
                    if (actions[i] > 0)
                    {
                        temp[count] = actions[i];
                        ++count;
                    }
                }

                if (count == 0)
                    break;

                uint32 id = temp[urand(0, count - 1)];
                if (e.GetTargetType() == SMART_TARGET_NONE)
                {
                    LOG_ERROR("sql.sql", "SmartScript: Entry {} SourceType {} Event {} Action {} is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                    break;
                }

                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (ObjectList::iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (Creature* target = (*itr)->ToCreature())
                        {
                            if (IsSmart(target))
                                CAST_AI(SmartAI, target->AI())->SetScript9(e, id, GetLastInvoker());
                        }
                        else if (GameObject* goTarget = (*itr)->ToGameObject())
                        {
                            if (IsSmartGO(goTarget))
                                CAST_AI(SmartGameObjectAI, goTarget->AI())->SetScript9(e, id, GetLastInvoker());
                        }
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST:
            {
                uint32 id = urand(e.action.randRangeTimedActionList.idMin, e.action.randRangeTimedActionList.idMax);
                if (e.GetTargetType() == SMART_TARGET_NONE)
                {
                    LOG_ERROR("sql.sql", "SmartScript: Entry {} SourceType {} Event {} Action {} is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                    break;
                }

                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (ObjectList::iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (Creature* target = (*itr)->ToCreature())
                        {
                            if (IsSmart(target))
                                CAST_AI(SmartAI, target->AI())->SetScript9(e, id, GetLastInvoker());
                        }
                        else if (GameObject* goTarget = (*itr)->ToGameObject())
                        {
                            if (IsSmartGO(goTarget))
                                CAST_AI(SmartGameObjectAI, goTarget->AI())->SetScript9(e, id, GetLastInvoker());
                        }
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_ACTIVATE_TAXI:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsPlayer(*itr))
                        (*itr)->ToPlayer()->ActivateTaxiPathTo(e.action.taxi.id);

                delete targets;
                break;
            }
        case SMART_ACTION_RANDOM_MOVE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                bool foundTarget = false;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature((*itr)))
                    {
                        foundTarget = true;

                        if (e.action.moveRandom.distance)
                            (*itr)->ToCreature()->GetMotionMaster()->MoveRandom((float)e.action.moveRandom.distance);
                        else
                            (*itr)->ToCreature()->GetMotionMaster()->MoveIdle();
                    }
                }

                if (!foundTarget && me && IsCreature(me))
                {
                    if (e.action.moveRandom.distance)
                        me->GetMotionMaster()->MoveRandom((float)e.action.moveRandom.distance);
                    else
                        me->GetMotionMaster()->MoveIdle();
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_UNIT_FIELD_BYTES_1:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;
                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->SetByteFlag(UNIT_FIELD_BYTES_1, e.action.setunitByte.type, e.action.setunitByte.byte1);

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVE_UNIT_FIELD_BYTES_1:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->RemoveByteFlag(UNIT_FIELD_BYTES_1, e.action.delunitByte.type, e.action.delunitByte.byte1);

                delete targets;
                break;
            }
        case SMART_ACTION_INTERRUPT_SPELL:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->InterruptNonMeleeSpells(e.action.interruptSpellCasting.withDelayed, e.action.interruptSpellCasting.spell_id, e.action.interruptSpellCasting.withInstant);

                delete targets;
                break;
            }
        case SMART_ACTION_SEND_GO_CUSTOM_ANIM:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsGameObject(*itr))
                        (*itr)->ToGameObject()->SendCustomAnim(e.action.sendGoCustomAnim.anim);

                delete targets;
                break;
            }
        case SMART_ACTION_SET_DYNAMIC_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->ReplaceAllDynamicFlags(e.action.flag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_ADD_DYNAMIC_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->SetDynamicFlag(e.action.flag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVE_DYNAMIC_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->RemoveDynamicFlag(e.action.flag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_JUMP_TO_POS:
            {
                if (e.GetTargetType() == SMART_TARGET_RANDOM_POINT)
                {
                    if (me)
                    {
                        float range = (float)e.target.randomPoint.range;
                        Position srcPos = { e.target.x, e.target.y, e.target.z, e.target.o };
                        Position randomPoint = me->GetRandomPoint(srcPos, range);
                        me->GetMotionMaster()->MoveJump(randomPoint, (float)e.action.jump.speedxy, (float)e.action.jump.speedz);
                    }

                    break;
                }

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                // xinef: my implementation
                if (e.action.jump.selfJump)
                {
                    if (WorldObject* target = Acore::Containers::SelectRandomContainerElement(*targets))
                        if (me)
                            me->GetMotionMaster()->MoveJump(target->GetPositionX() + e.target.x, target->GetPositionY() + e.target.y, target->GetPositionZ() + e.target.z, (float)e.action.jump.speedxy, (float)e.action.jump.speedz);
                }
                else
                {
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                        if (WorldObject* obj = (*itr))
                        {
                            if (Creature* creature = obj->ToCreature())
                                creature->GetMotionMaster()->MoveJump(e.target.x, e.target.y, e.target.z, (float)e.action.jump.speedxy, (float)e.action.jump.speedz);
                        }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_GO_SET_LOOT_STATE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsGameObject(*itr))
                        (*itr)->ToGameObject()->SetLootState((LootState)e.action.setGoLootState.state);

                delete targets;
                break;
            }
        case SMART_ACTION_GO_SET_GO_STATE:
            {
                ObjectList* targets = GetTargets(e, unit);

                if (!targets)
                {
                    break;
                }

                for (auto const& target : *targets)
                {
                    if (IsGameObject(target))
                    {
                        target->ToGameObject()->SetGoState((GOState)e.action.goState.state);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SEND_TARGET_TO_TARGET:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                ObjectList* storedTargets = GetTargetList(e.action.sendTargetToTarget.id);
                if (!storedTargets)
                {
                    delete targets;
                    break;
                }

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsCreature(*itr))
                    {
                        if (SmartAI* ai = CAST_AI(SmartAI, (*itr)->ToCreature()->AI()))
                            ai->GetScript()->StoreTargetList(new ObjectList(*storedTargets), e.action.sendTargetToTarget.id);   // store a copy of target list
                        else
                            LOG_ERROR("sql.sql", "SmartScript: Action target for SMART_ACTION_SEND_TARGET_TO_TARGET is not using SmartAI, skipping");
                    }
                    else if (IsGameObject(*itr))
                    {
                        if (SmartGameObjectAI* ai = CAST_AI(SmartGameObjectAI, (*itr)->ToGameObject()->AI()))
                            ai->GetScript()->StoreTargetList(new ObjectList(*storedTargets), e.action.sendTargetToTarget.id);   // store a copy of target list
                        else
                            LOG_ERROR("sql.sql", "SmartScript: Action target for SMART_ACTION_SEND_TARGET_TO_TARGET is not using SmartGameObjectAI, skipping");
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SEND_GOSSIP_MENU:
            {
                if (!GetBaseObject())
                    break;

                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SEND_GOSSIP_MENU: gossipMenuId {}, gossipNpcTextId {}",
                               e.action.sendGossipMenu.gossipMenuId, e.action.sendGossipMenu.gossipNpcTextId);
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (Player* player = (*itr)->ToPlayer())
                    {
                        if (e.action.sendGossipMenu.gossipMenuId)
                            player->PrepareGossipMenu(GetBaseObject(), e.action.sendGossipMenu.gossipMenuId, true);
                        else
                            ClearGossipMenuFor(player);

                        SendGossipMenuFor(player, e.action.sendGossipMenu.gossipNpcTextId, GetBaseObject()->GetGUID());
                    }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_HOME_POS:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    float x, y, z, o;
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                        if (IsCreature(*itr))
                        {
                            if (e.action.setHomePos.spawnPos)
                            {
                                (*itr)->ToCreature()->GetRespawnPosition(x, y, z, &o);
                                (*itr)->ToCreature()->SetHomePosition(x, y, z, o);
                            }
                            else
                                (*itr)->ToCreature()->SetHomePosition((*itr)->GetPositionX(), (*itr)->GetPositionY(), (*itr)->GetPositionZ(), (*itr)->GetOrientation());
                        }
                    delete targets;
                }
                else if (me && e.GetTargetType() == SMART_TARGET_POSITION)
                {
                    if (e.action.setHomePos.spawnPos)
                    {
                        float x, y, z, o;
                        me->GetRespawnPosition(x, y, z, &o);
                        me->SetHomePosition(x, y, z, o);
                    }
                    else
                        me->SetHomePosition(e.target.x, e.target.y, e.target.z, e.target.o);
                }
                break;
            }
        /*{
        ObjectList* movers = GetTargets(CreateSmartEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, 0, 0, SMART_ACTION_NONE, 0, 0, 0, 0, 0, 0, (SMARTAI_TARGETS)e.action.sethome.targetType, e.action.sethome.targetParam1, e.action.sethome.targetParam2, e.action.sethome.targetParam3, 0), unit);
        if (!movers)
        break;

        if (e.GetTargetType() == SMART_TARGET_POSITION)
        {
        for (ObjectList::const_iterator itr = movers->begin(); itr != movers->end(); ++itr)
        if (IsCreature(*itr))
        (*itr)->ToCreature()->SetHomePosition(e.target.x, e.target.y, e.target.z, e.target.o);
        }
        else if (ObjectList* targets = GetTargets(e, unit))
        {
        if (WorldObject* target = targets->front())
        for (ObjectList::const_iterator itr = movers->begin(); itr != movers->end(); ++itr)
        if (IsCreature(*itr))
        (*itr)->ToCreature()->SetHomePosition(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation());

        delete targets;
        }

        delete movers;
        break;
        }*/
        case SMART_ACTION_SET_HEALTH_REGEN:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->SetRegeneratingHealth(e.action.setHealthRegen.regenHealth);

                delete targets;
                break;
            }
        case SMART_ACTION_SET_ROOT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->SetControlled(e.action.setRoot.root, UNIT_STATE_ROOT);

                delete targets;
                break;
            }
        case SMART_ACTION_SET_GO_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsGameObject(*itr))
                        (*itr)->ToGameObject()->SetUInt32Value(GAMEOBJECT_FLAGS, e.action.goFlag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_ADD_GO_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsGameObject(*itr))
                        (*itr)->ToGameObject()->SetFlag(GAMEOBJECT_FLAGS, e.action.goFlag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVE_GO_FLAG:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsGameObject(*itr))
                        (*itr)->ToGameObject()->RemoveFlag(GAMEOBJECT_FLAGS, e.action.goFlag.flag);

                delete targets;
                break;
            }
        case SMART_ACTION_SUMMON_CREATURE_GROUP:
            {
                std::list<TempSummon*> summonList;
                GetBaseObject()->SummonCreatureGroup(e.action.creatureGroup.group, &summonList);

                for (std::list<TempSummon*>::const_iterator itr = summonList.begin(); itr != summonList.end(); ++itr)
                {
                    if (unit && e.action.creatureGroup.attackInvoker)
                        (*itr)->AI()->AttackStart(unit);
                    else if (me && e.action.creatureGroup.attackScriptOwner)
                        (*itr)->AI()->AttackStart(me);
                }

                break;
            }
        case SMART_ACTION_SET_POWER:
            {
                ObjectList* targets = GetTargets(e, unit);

                if (targets)
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                        if (IsUnit(*itr))
                            (*itr)->ToUnit()->SetPower(Powers(e.action.power.powerType), e.action.power.newPower);

                delete targets;
                break;
            }
        case SMART_ACTION_ADD_POWER:
            {
                ObjectList* targets = GetTargets(e, unit);

                if (targets)
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                        if (IsUnit(*itr))
                            (*itr)->ToUnit()->SetPower(Powers(e.action.power.powerType), (*itr)->ToUnit()->GetPower(Powers(e.action.power.powerType)) + e.action.power.newPower);

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVE_POWER:
            {
                ObjectList* targets = GetTargets(e, unit);

                if (targets)
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                        if (IsUnit(*itr))
                            (*itr)->ToUnit()->SetPower(Powers(e.action.power.powerType), (*itr)->ToUnit()->GetPower(Powers(e.action.power.powerType)) - e.action.power.newPower);

                delete targets;
                break;
            }
        case SMART_ACTION_GAME_EVENT_STOP:
            {
                uint32 eventId = e.action.gameEventStop.id;
                if (!sGameEventMgr->IsActiveEvent(eventId))
                {
                    LOG_ERROR("scripts.ai.sai", "SmartScript::ProcessAction: At case SMART_ACTION_GAME_EVENT_STOP, inactive event (id: {})", eventId);
                    break;
                }
                sGameEventMgr->StopEvent(eventId, true);
                break;
            }
        case SMART_ACTION_GAME_EVENT_START:
            {
                uint32 eventId = e.action.gameEventStart.id;
                if (sGameEventMgr->IsActiveEvent(eventId))
                {
                    LOG_ERROR("scripts.ai.sai", "SmartScript::ProcessAction: At case SMART_ACTION_GAME_EVENT_START, already activated event (id: {})", eventId);
                    break;
                }
                sGameEventMgr->StartEvent(eventId, true);
                break;
            }
        case SMART_ACTION_START_CLOSEST_WAYPOINT:
            {
                uint32 waypoints[SMART_ACTION_PARAM_COUNT];
                waypoints[0] = e.action.closestWaypointFromList.wp1;
                waypoints[1] = e.action.closestWaypointFromList.wp2;
                waypoints[2] = e.action.closestWaypointFromList.wp3;
                waypoints[3] = e.action.closestWaypointFromList.wp4;
                waypoints[4] = e.action.closestWaypointFromList.wp5;
                waypoints[5] = e.action.closestWaypointFromList.wp6;
                float distanceToClosest = std::numeric_limits<float>::max();
                WayPoint* closestWp = nullptr;

                ObjectList* targets = GetTargets(e, unit);
                if (targets)
                {
                    for (ObjectList::iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    {
                        if (Creature* target = (*itr)->ToCreature())
                        {
                            if (IsSmart(target))
                            {
                                for (uint8 i = 0; i < SMART_ACTION_PARAM_COUNT; i++)
                                {
                                    if (!waypoints[i])
                                        continue;

                                    WPPath* path = sSmartWaypointMgr->GetPath(waypoints[i]);

                                    if (!path || path->empty())
                                        continue;

                                    WPPath::const_iterator itrWp = path->find(0);

                                    if (itrWp != path->end())
                                    {
                                        if (WayPoint* wp = itrWp->second)
                                        {
                                            float distToThisPath = target->GetDistance(wp->x, wp->y, wp->z);

                                            if (distToThisPath < distanceToClosest)
                                            {
                                                distanceToClosest = distToThisPath;
                                                closestWp = wp;
                                            }
                                        }
                                    }
                                }

                                if (closestWp)
                                    CAST_AI(SmartAI, target->AI())->StartPath(false, closestWp->id, true);
                            }
                        }
                    }

                    delete targets;
                }
                break;
            }
        case SMART_ACTION_SET_GO_STATE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsGameObject(*itr))
                        (*itr)->ToGameObject()->SetGoState((GOState)e.action.goState.state);

                delete targets;
                break;
            }
        case SMART_ACTION_EXIT_VEHICLE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->ExitVehicle();

                delete targets;
                break;
            }
        case SMART_ACTION_SET_UNIT_MOVEMENT_FLAGS:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                    {
                        (*itr)->ToUnit()->SetUnitMovementFlags(e.action.movementFlag.flag);
                        (*itr)->ToUnit()->SendMovementFlagUpdate();
                    }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_COMBAT_DISTANCE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->m_CombatDistance = e.action.combatDistance.dist;

                delete targets;
                break;
            }
        case SMART_ACTION_SET_CASTER_COMBAT_DIST:
            {
                if (e.action.casterDistance.reset)
                    RestoreCasterMaxDist();
                else
                    SetCasterActualDist(e.action.casterDistance.dist);

                if (me->GetVictim() && me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                    me->GetMotionMaster()->MoveChase(me->GetVictim(), GetCasterActualDist());
                break;
            }
        case SMART_ACTION_SET_SIGHT_DIST:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->m_SightDistance = e.action.sightDistance.dist;

                delete targets;
                break;
            }
        case SMART_ACTION_FLEE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->GetMotionMaster()->MoveFleeing(me, e.action.flee.withEmote);

                delete targets;
                break;
            }
        case SMART_ACTION_ADD_THREAT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        me->AddThreat((*itr)->ToUnit(), (float)e.action.threat.threatINC - (float)e.action.threat.threatDEC);

                delete targets;
                break;
            }
        case SMART_ACTION_LOAD_EQUIPMENT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsCreature(*itr))
                        (*itr)->ToCreature()->LoadEquipment(e.action.loadEquipment.id, e.action.loadEquipment.force);

                delete targets;
                break;
            }
        case SMART_ACTION_TRIGGER_RANDOM_TIMED_EVENT:
            {
                uint32 eventId = urand(e.action.randomTimedEvent.minId, e.action.randomTimedEvent.maxId);
                ProcessEventsFor((SMART_EVENT)SMART_EVENT_TIMED_EVENT_TRIGGERED, nullptr, eventId);
                break;
            }
        case SMART_ACTION_SET_HOVER:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->SetHover(e.action.setHover.state);

                delete targets;
                break;
            }
        case SMART_ACTION_ADD_IMMUNITY:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->ApplySpellImmune(e.action.immunity.id, e.action.immunity.type, e.action.immunity.value, true);

                delete targets;
                break;
            }
        case SMART_ACTION_REMOVE_IMMUNITY:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->ApplySpellImmune(e.action.immunity.id, e.action.immunity.type, e.action.immunity.value, false);

                delete targets;
                break;
            }
        case SMART_ACTION_FALL:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->GetMotionMaster()->MoveFall();

                delete targets;
                break;
            }
        case SMART_ACTION_SET_EVENT_FLAG_RESET:
            {
                SetPhaseReset(e.action.setActive.state);
                break;
            }
        case SMART_ACTION_REMOVE_ALL_GAMEOBJECTS:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->RemoveAllGameObjects();

                delete targets;
                break;
            }
        case SMART_ACTION_STOP_MOTION:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                    {
                        if (e.action.stopMotion.stopMovement)
                            (*itr)->ToUnit()->StopMoving();
                        if (e.action.stopMotion.movementExpired)
                            (*itr)->ToUnit()->GetMotionMaster()->MovementExpired();
                    }

                delete targets;
                break;
            }
        case SMART_ACTION_NO_ENVIRONMENT_UPDATE:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        (*itr)->ToUnit()->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);

                delete targets;
                break;
            }
        case SMART_ACTION_ZONE_UNDER_ATTACK:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                    if (IsUnit(*itr))
                        if (Player* player = (*itr)->ToUnit()->GetCharmerOrOwnerPlayerOrPlayerItself())
                        {
                            me->SendZoneUnderAttackMessage(player);
                            break;
                        }

                delete targets;
                break;
            }
        case SMART_ACTION_LOAD_GRID:
            {
                if (me && me->FindMap())
                    me->FindMap()->LoadGrid(e.target.x, e.target.y);
                break;
            }
        case SMART_ACTION_PLAYER_TALK:
            {
                ObjectList* targets = GetTargets(e, unit);
                char const* text = sObjectMgr->GetAcoreString(e.action.playerTalk.textId, DEFAULT_LOCALE);

                if (targets)
                    for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                        if (IsPlayer(*itr))
                            !e.action.playerTalk.flag ? (*itr)->ToPlayer()->Say(text, LANG_UNIVERSAL) : (*itr)->ToPlayer()->Yell(text, LANG_UNIVERSAL);

                delete targets;
                break;
            }
        case SMART_ACTION_CUSTOM_CAST:
            {
                if (!me)
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (IsUnit(*itr))
                    {
                        if (e.action.castCustom.flags & SMARTCAST_INTERRUPT_PREVIOUS)
                            me->InterruptNonMeleeSpells(false);

                        if (e.action.castCustom.flags & SMARTCAST_COMBAT_MOVE)
                        {
                            // If cast flag SMARTCAST_COMBAT_MOVE is set combat movement will not be allowed
                            // unless target is outside spell range, out of mana, or LOS.

                            bool _allowMove = false;
                            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(e.action.castCustom.spell); // AssertSpellInfo?
                            int32 mana = me->GetPower(POWER_MANA);

                            if (me->GetDistance((*itr)->ToUnit()) > spellInfo->GetMaxRange(true) ||
                                    me->GetDistance((*itr)->ToUnit()) < spellInfo->GetMinRange(true) ||
                                    !me->IsWithinLOSInMap((*itr)->ToUnit()) ||
                                    mana < spellInfo->CalcPowerCost(me, spellInfo->GetSchoolMask()))
                                _allowMove = true;

                            CAST_AI(SmartAI, me->AI())->SetCombatMove(_allowMove);
                        }

                        if (!(e.action.castCustom.flags & SMARTCAST_AURA_NOT_PRESENT) || !(*itr)->ToUnit()->HasAura(e.action.castCustom.spell))
                        {
                            CustomSpellValues values;
                            if (e.action.castCustom.bp1)
                                values.AddSpellMod(SPELLVALUE_BASE_POINT0, e.action.castCustom.bp1);
                            if (e.action.castCustom.bp2)
                                values.AddSpellMod(SPELLVALUE_BASE_POINT1, e.action.castCustom.bp2);
                            if (e.action.castCustom.bp3)
                                values.AddSpellMod(SPELLVALUE_BASE_POINT2, e.action.castCustom.bp3);
                            me->CastCustomSpell(e.action.castCustom.spell, values, (*itr)->ToUnit(), (e.action.castCustom.flags & SMARTCAST_TRIGGERED) ? TRIGGERED_FULL_MASK : TRIGGERED_NONE);
                        }
                    }
                }
                delete targets;
                break;
            }
        case SMART_ACTION_VORTEX_SUMMON:
            {
                if (!me)
                    break;

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                TempSummonType summon_type = (e.action.summonVortex.summonDuration > 0) ? TEMPSUMMON_TIMED_DESPAWN : TEMPSUMMON_CORPSE_DESPAWN;

                float a = static_cast<float>(e.action.summonVortex.a);
                float k = static_cast<float>(e.action.summonVortex.k) / 1000.0f;
                float r_max = static_cast<float>(e.action.summonVortex.r_max);
                float delta_phi = M_PI * static_cast<float>(e.action.summonVortex.phi_delta) / 180.0f;

                // r(phi) = a * e ^ (k * phi)
                // r(phi + delta_phi) = a * e ^ (k * (phi + delta_phi))
                // r(phi + delta_phi) = a * e ^ (k * phi) * e ^ (k * delta_phi)
                // r(phi + delta_phi) = r(phi) * e ^ (k * delta_phi)
                float factor = std::exp(k * delta_phi);

                // r(0) = a * e ^ (k * 0) = a * e ^ 0 = a * 1 = a
                float summonRadius = a;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    // Offset by orientation, should not count into radius calculation,
                    // but is needed for vortex direction (polar coordinates)
                    float phi = (*itr)->GetOrientation();

                    do
                    {
                        Position summonPosition(**itr);
                        summonPosition.RelocatePolarOffset(phi, summonRadius);

                        me->SummonCreature(e.action.summonVortex.summonEntry, summonPosition, summon_type, e.action.summonVortex.summonDuration);

                        phi += delta_phi;
                        summonRadius *= factor;
                    } while (summonRadius <= r_max);
                }

                delete targets;
                break;
            }
        case SMART_ACTION_CONE_SUMMON:
            {
                if (!me)
                    break;

                TempSummonType spawnType = (e.action.coneSummon.summonDuration > 0) ? TEMPSUMMON_TIMED_DESPAWN : TEMPSUMMON_CORPSE_DESPAWN;

                float distInARow = static_cast<float>(e.action.coneSummon.distanceBetweenSummons);
                float coneAngle = static_cast<float>(e.action.coneSummon.coneAngle) * M_PI / 180.0f;

                for (uint32 radius = 0; radius <= e.action.coneSummon.coneLength; radius += e.action.coneSummon.distanceBetweenRings)
                {
                    float deltaAngle = 0.0f;
                    if (radius > 0)
                        deltaAngle = distInARow / radius;

                    uint32 count = 1;
                    if (deltaAngle > 0)
                        count += coneAngle / deltaAngle;

                    float currentAngle = -static_cast<float>(count) * deltaAngle / 2.0f;

                    if (e.GetTargetType() == SMART_TARGET_SELF || e.GetTargetType() == SMART_TARGET_NONE)
                        currentAngle += G3D::fuzzyGt(e.target.o, 0.0f) ? (e.target.o - me->GetOrientation()) : 0.0f;
                    else if (ObjectList* targets = GetTargets(e, unit))
                    {
                        currentAngle += (me->GetAngle(targets->front()) - me->GetOrientation());
                        delete targets;
                    }

                    for (uint32 index = 0; index < count; ++index)
                    {
                        Position spawnPosition(*me);
                        spawnPosition.RelocatePolarOffset(currentAngle, radius);
                        currentAngle += deltaAngle;

                        me->SummonCreature(e.action.coneSummon.summonEntry, spawnPosition, spawnType, e.action.coneSummon.summonDuration);
                    }
                }

                break;
            }
        case SMART_ACTION_CU_ENCOUNTER_START:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                    break;

                for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
                {
                    if (Player* playerTarget = (*itr)->ToPlayer())
                    {
                        playerTarget->RemoveArenaSpellCooldowns();
                        playerTarget->RemoveAurasDueToSpell(57724); // Spell Shaman Debuff - Sated (Heroism)
                        playerTarget->RemoveAurasDueToSpell(57723); // Spell Shaman Debuff - Exhaustion (Bloodlust)
                        playerTarget->RemoveAurasDueToSpell(2825);  // Bloodlust
                        playerTarget->RemoveAurasDueToSpell(32182); // Heroism
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_DO_ACTION:
            {
                int32 const actionId = e.action.doAction.isNegative ? -e.action.doAction.actionId : e.action.doAction.actionId;
                if (!e.action.doAction.instanceTarget)
                {
                    ObjectList* targets = GetTargets(e, unit);
                    if (!targets)
                    {
                        break;
                    }

                    for (WorldObject* objTarget : *targets)
                    {
                        if (Creature const* unitTarget = objTarget->ToCreature())
                        {
                            if (unitTarget->IsAIEnabled)
                            {
                                unitTarget->AI()->DoAction(actionId);
                            }
                        }
                        else if (GameObject const* gobjTarget = objTarget->ToGameObject())
                        {
                            gobjTarget->AI()->DoAction(actionId);
                        }
                    }

                    delete targets;
                }
                else
                {
                    InstanceScript* instanceScript = nullptr;
                    if (WorldObject* baseObj = GetBaseObject())
                    {
                        instanceScript = baseObj->GetInstanceScript();
                    }
                    // Action is triggered by AreaTrigger
                    else if (trigger && IsPlayer(unit))
                    {
                        instanceScript = unit->GetInstanceScript();
                    }

                    if (instanceScript)
                    {
                        instanceScript->DoAction(actionId);
                    }
                }
                break;
            }
        case SMART_ACTION_DISABLE_EVADE:
            {
                if (!IsSmart())
                    break;

                CAST_AI(SmartAI, me->AI())->SetEvadeDisabled(e.action.disableEvade.disable != 0);
                break;
            }
        case SMART_ACTION_SET_CORPSE_DELAY:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                {
                    break;
                }

                for (auto const& target : *targets)
                {
                    if (IsCreature(target))
                    {
                        target->ToCreature()->SetCorpseDelay(e.action.corpseDelay.timer);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_HEALTH_PCT:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                {
                    break;
                }

                for (auto const& target : *targets)
                {
                    if (Unit* targetUnit = target->ToUnit())
                    {
                        targetUnit->SetHealth(targetUnit->CountPctFromMaxHealth(e.action.setHealthPct.percent));
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_SET_MOVEMENT_SPEED:
            {
                uint32 speedInteger = e.action.movementSpeed.speedInteger;
                uint32 speedFraction = e.action.movementSpeed.speedFraction;
                float speed = float(speedInteger) + float(speedFraction) / std::pow(10, std::floor(std::log10(float(speedFraction ? speedFraction : 1)) + 1));

                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                {
                    break;
                }

                for (auto const& target : *targets)
                {
                    if (IsCreature(target))
                    {
                        me->SetSpeed(UnitMoveType(e.action.movementSpeed.movementType), speed);
                    }
                }

                delete targets;
                break;
            }
        case SMART_ACTION_PLAY_CINEMATIC:
            {
                ObjectList* targets = GetTargets(e, unit);
                if (!targets)
                {
                    break;
                }

                for (auto const& target : *targets)
                {
                    if (!IsPlayer(target))
                        continue;

                    target->ToPlayer()->SendCinematicStart(e.action.cinematic.entry);
                }
                break;
            }
        default:
            LOG_ERROR("sql.sql", "SmartScript::ProcessAction: Entry {} SourceType {}, Event {}, Unhandled Action type {}", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
            break;
    }

    if (e.link && e.link != e.event_id)
    {
        SmartScriptHolder linked = FindLinkedEvent(e.link);
        if (linked.GetActionType() && linked.GetEventType() == SMART_EVENT_LINK)
            ProcessEvent(linked, unit, var0, var1, bvar, spell, gob);
        else
            LOG_ERROR("sql.sql", "SmartScript::ProcessAction: Entry {} SourceType {}, Event {}, Link Event {} not found or invalid, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.link);
    }
}

void SmartScript::ProcessTimedAction(SmartScriptHolder& e, uint32 const& min, uint32 const& max, Unit* unit, uint32 var0, uint32 var1, bool bvar, SpellInfo const* spell, GameObject* gob)
{
    // xinef: extended by selfs victim
    ConditionList const conds = sConditionMgr->GetConditionsForSmartEvent(e.entryOrGuid, e.event_id, e.source_type);
    ConditionSourceInfo info = ConditionSourceInfo(unit, GetBaseObject(), me ? me->GetVictim() : nullptr);

    if (sConditionMgr->IsObjectMeetToConditions(info, conds))
    {
        ProcessAction(e, unit, var0, var1, bvar, spell, gob);
        RecalcTimer(e, min, max);
    }
    else
        RecalcTimer(e, 5000, 5000);
}

void SmartScript::InstallTemplate(SmartScriptHolder const& e)
{
    if (!GetBaseObject())
        return;
    if (mTemplate)
    {
        LOG_ERROR("sql.sql", "SmartScript::InstallTemplate: Entry {} SourceType {} AI Template can not be set more then once, skipped.", e.entryOrGuid, e.GetScriptType());
        return;
    }
    mTemplate = (SMARTAI_TEMPLATE)e.action.installTtemplate.id;
    switch ((SMARTAI_TEMPLATE)e.action.installTtemplate.id)
    {
        case SMARTAI_TEMPLATE_CASTER:
            {
                AddEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, e.action.installTtemplate.param2, e.action.installTtemplate.param3, 0, SMART_ACTION_CAST, e.action.installTtemplate.param1, e.target.raw.param1, 0, 0, 0, 0, SMART_TARGET_VICTIM, 0, 0, 0, 0, 1);
                AddEvent(SMART_EVENT_RANGE, 0, e.action.installTtemplate.param4, 300, 0, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
                AddEvent(SMART_EVENT_RANGE, 0, 0, e.action.installTtemplate.param4 > 10 ? e.action.installTtemplate.param4 - 10 : 0, 0, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 0, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
                AddEvent(SMART_EVENT_MANA_PCT, 0, e.action.installTtemplate.param5 - 15 > 100 ? 100 : e.action.installTtemplate.param5 + 15, 100, 1000, 1000, 0, SMART_ACTION_SET_EVENT_PHASE, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                AddEvent(SMART_EVENT_MANA_PCT, 0, 0, e.action.installTtemplate.param5, 1000, 1000, 0, SMART_ACTION_SET_EVENT_PHASE, 0, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                AddEvent(SMART_EVENT_MANA_PCT, 0, 0, e.action.installTtemplate.param5, 1000, 1000, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                break;
            }
        case SMARTAI_TEMPLATE_TURRET:
            {
                AddEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, e.action.installTtemplate.param2, e.action.installTtemplate.param3, 0, SMART_ACTION_CAST, e.action.installTtemplate.param1, e.target.raw.param1, 0, 0, 0, 0, SMART_TARGET_VICTIM, 0, 0, 0, 0, 0);
                AddEvent(SMART_EVENT_JUST_CREATED, 0, 0, 0, 0, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 0, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                break;
            }
        case SMARTAI_TEMPLATE_CAGED_NPC_PART:
            {
                if (!me)
                    return;
                //store cage as id1
                AddEvent(SMART_EVENT_DATA_SET, 0, 0, 0, 0, 0, 0, SMART_ACTION_STORE_TARGET_LIST, 1, 0, 0, 0, 0, 0, SMART_TARGET_CLOSEST_GAMEOBJECT, e.action.installTtemplate.param1, 10, 0, 0, 0);

                //reset(close) cage on hostage(me) respawn
                AddEvent(SMART_EVENT_UPDATE, SMART_EVENT_FLAG_NOT_REPEATABLE, 0, 0, 0, 0, 0, SMART_ACTION_RESET_GOBJECT, 0, 0, 0, 0, 0, 0, SMART_TARGET_GAMEOBJECT_DISTANCE, e.action.installTtemplate.param1, 5, 0, 0, 0);

                AddEvent(SMART_EVENT_DATA_SET, 0, 0, 0, 0, 0, 0, SMART_ACTION_SET_RUN, e.action.installTtemplate.param3, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                AddEvent(SMART_EVENT_DATA_SET, 0, 0, 0, 0, 0, 0, SMART_ACTION_SET_EVENT_PHASE, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);

                AddEvent(SMART_EVENT_UPDATE, SMART_EVENT_FLAG_NOT_REPEATABLE, 1000, 1000, 0, 0, 0, SMART_ACTION_MOVE_FORWARD, e.action.installTtemplate.param4, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
                //phase 1: give quest credit on movepoint reached
                AddEvent(SMART_EVENT_MOVEMENTINFORM, 0, POINT_MOTION_TYPE, SMART_RANDOM_POINT, 0, 0, 0, SMART_ACTION_SET_DATA, 0, 0, 0, 0, 0, 0, SMART_TARGET_STORED, 1, 0, 0, 0, 1);
                //phase 1: despawn after time on movepoint reached
                AddEvent(SMART_EVENT_MOVEMENTINFORM, 0, POINT_MOTION_TYPE, SMART_RANDOM_POINT, 0, 0, 0, SMART_ACTION_FORCE_DESPAWN, e.action.installTtemplate.param2, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);

                if (sCreatureTextMgr->TextExist(me->GetEntry(), (uint8)e.action.installTtemplate.param5))
                    AddEvent(SMART_EVENT_MOVEMENTINFORM, 0, POINT_MOTION_TYPE, SMART_RANDOM_POINT, 0, 0, 0, SMART_ACTION_TALK, e.action.installTtemplate.param5, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
                break;
            }
        case SMARTAI_TEMPLATE_CAGED_GO_PART:
            {
                if (!go)
                    return;
                //store hostage as id1
                AddEvent(SMART_EVENT_GO_STATE_CHANGED, 0, 2, 0, 0, 0, 0, SMART_ACTION_STORE_TARGET_LIST, 1, 0, 0, 0, 0, 0, SMART_TARGET_CLOSEST_CREATURE, e.action.installTtemplate.param1, 10, 0, 0, 0);
                //store invoker as id2
                AddEvent(SMART_EVENT_GO_STATE_CHANGED, 0, 2, 0, 0, 0, 0, SMART_ACTION_STORE_TARGET_LIST, 2, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                //signal hostage
                AddEvent(SMART_EVENT_GO_STATE_CHANGED, 0, 2, 0, 0, 0, 0, SMART_ACTION_SET_DATA, 0, 0, 0, 0, 0, 0, SMART_TARGET_STORED, 1, 0, 0, 0, 0);
                //when hostage raeched end point, give credit to invoker
                if (e.action.installTtemplate.param2)
                    AddEvent(SMART_EVENT_DATA_SET, 0, 0, 0, 0, 0, 0, SMART_ACTION_CALL_KILLEDMONSTER, e.action.installTtemplate.param1, 0, 0, 0, 0, 0, SMART_TARGET_STORED, 2, 0, 0, 0, 0);
                else
                    AddEvent(SMART_EVENT_GO_STATE_CHANGED, 0, 2, 0, 0, 0, 0, SMART_ACTION_CALL_KILLEDMONSTER, e.action.installTtemplate.param1, 0, 0, 0, 0, 0, SMART_TARGET_STORED, 2, 0, 0, 0, 0);
                break;
            }
        case SMARTAI_TEMPLATE_BASIC:
        default:
            return;
    }
}

void SmartScript::AddEvent(SMART_EVENT e, uint32 event_flags, uint32 event_param1, uint32 event_param2, uint32 event_param3, uint32 event_param4, uint32 event_param5, SMART_ACTION action, uint32 action_param1, uint32 action_param2, uint32 action_param3, uint32 action_param4, uint32 action_param5, uint32 action_param6, SMARTAI_TARGETS t, uint32 target_param1, uint32 target_param2, uint32 target_param3, uint32 target_param4, uint32 phaseMask)
{
    mInstallEvents.push_back(CreateSmartEvent(e, event_flags, event_param1, event_param2, event_param3, event_param4, event_param5, action, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, t, target_param1, target_param2, target_param3, target_param4, phaseMask));
}

SmartScriptHolder SmartScript::CreateSmartEvent(SMART_EVENT e, uint32 event_flags, uint32 event_param1, uint32 event_param2, uint32 event_param3, uint32 event_param4, uint32 event_param5, SMART_ACTION action, uint32 action_param1, uint32 action_param2, uint32 action_param3, uint32 action_param4, uint32 action_param5, uint32 action_param6, SMARTAI_TARGETS t, uint32 target_param1, uint32 target_param2, uint32 target_param3, uint32 target_param4, uint32 phaseMask)
{
    SmartScriptHolder script;
    script.event.type = e;
    script.event.raw.param1 = event_param1;
    script.event.raw.param2 = event_param2;
    script.event.raw.param3 = event_param3;
    script.event.raw.param4 = event_param4;
    script.event.raw.param5 = event_param5;
    script.event.event_phase_mask = phaseMask;
    script.event.event_flags = event_flags;
    script.event.event_chance = 100;

    script.action.type = action;
    script.action.raw.param1 = action_param1;
    script.action.raw.param2 = action_param2;
    script.action.raw.param3 = action_param3;
    script.action.raw.param4 = action_param4;
    script.action.raw.param5 = action_param5;
    script.action.raw.param6 = action_param6;

    script.target.type = t;
    script.target.raw.param1 = target_param1;
    script.target.raw.param2 = target_param2;
    script.target.raw.param3 = target_param3;
    script.target.raw.param4 = target_param4;

    script.source_type = SMART_SCRIPT_TYPE_CREATURE;
    InitTimer(script);
    return script;
}

ObjectList* SmartScript::GetTargets(SmartScriptHolder const& e, Unit* invoker /*= nullptr*/)
{
    Unit* scriptTrigger = nullptr;
    if (invoker)
        scriptTrigger = invoker;
    else if (Unit* tempLastInvoker = GetLastInvoker())
        scriptTrigger = tempLastInvoker;

    WorldObject* baseObject = GetBaseObject();

    ObjectList* l = new ObjectList();
    switch (e.GetTargetType())
    {
        case SMART_TARGET_SELF:
            if (baseObject)
                l->push_back(baseObject);
            break;
        case SMART_TARGET_VICTIM:
            if (me && me->GetVictim())
                l->push_back(me->GetVictim());
            break;
        case SMART_TARGET_HOSTILE_SECOND_AGGRO:
            if (me)
            {
                if (e.target.hostilRandom.powerType)
                {
                    if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MaxThreat, 1, PowerUsersSelector(me, Powers(e.target.hostilRandom.powerType - 1), (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly)))
                        l->push_back(u);
                }
                else if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MaxThreat, 1, (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly))
                    l->push_back(u);
            }
            break;
        case SMART_TARGET_HOSTILE_LAST_AGGRO:
            if (me)
            {
                if (e.target.hostilRandom.powerType)
                {
                    if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MinThreat, 0, PowerUsersSelector(me, Powers(e.target.hostilRandom.powerType - 1), (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly)))
                        l->push_back(u);
                }
                else if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MinThreat, 0, (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly))
                    l->push_back(u);
            }
            break;
        case SMART_TARGET_HOSTILE_RANDOM:
            if (me)
            {
                if (e.target.hostilRandom.powerType)
                {
                    if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, Powers(e.target.hostilRandom.powerType - 1), (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly)))
                        l->push_back(u);
                }
                else if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::Random, 0, (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly))
                    l->push_back(u);
            }
            break;
        case SMART_TARGET_HOSTILE_RANDOM_NOT_TOP:
            if (me)
            {
                if (e.target.hostilRandom.powerType)
                {
                    if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::Random, 1, PowerUsersSelector(me, Powers(e.target.hostilRandom.powerType - 1), (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly)))
                        l->push_back(u);
                }
                else if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::Random, 1, (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly))
                    l->push_back(u);
            }
            break;
        case SMART_TARGET_FARTHEST:
            if (me)
            {
                if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MinDistance, 0, FarthestTargetSelector(me, e.target.farthest.maxDist, e.target.farthest.playerOnly, e.target.farthest.isInLos)))
                    l->push_back(u);
            }
            break;
        case SMART_TARGET_ACTION_INVOKER:
            if (scriptTrigger)
                l->push_back(scriptTrigger);
            break;
        case SMART_TARGET_ACTION_INVOKER_VEHICLE:
            if (scriptTrigger && scriptTrigger->GetVehicle() && scriptTrigger->GetVehicle()->GetBase())
                l->push_back(scriptTrigger->GetVehicle()->GetBase());
            break;
        case SMART_TARGET_INVOKER_PARTY:
            if (scriptTrigger)
            {
                if (Player* player = scriptTrigger->ToPlayer())
                {
                    if (Group* group = player->GetGroup())
                    {
                        for (GroupReference* groupRef = group->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                            if (Player* member = groupRef->GetSource())
                                if (member->IsInMap(player))
                                    l->push_back(member);
                    }
                    // We still add the player to the list if there is no group. If we do
                    // this even if there is a group (thus the else-check), it will add the
                    // same player to the list twice. We don't want that to happen.
                    else
                        l->push_back(scriptTrigger);
                }
            }
            break;
        case SMART_TARGET_CREATURE_RANGE:
            {
                // will always return a valid pointer, even if empty list
                ObjectList* units = GetWorldObjectsInDist((float)e.target.unitRange.maxDist);
                for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                {
                    if (!IsCreature(*itr))
                        continue;

                    if (me && me->GetGUID() == (*itr)->GetGUID())
                        continue;

                    // check alive state - 1 alive, 2 dead, 0 both
                    if (uint32 state = e.target.unitRange.livingState)
                    {
                        if ((*itr)->ToCreature()->IsAlive() && state == 2)
                            continue;
                        if (!(*itr)->ToCreature()->IsAlive() && state == 1)
                            continue;
                    }

                    if (((e.target.unitRange.creature && (*itr)->ToCreature()->GetEntry() == e.target.unitRange.creature) || !e.target.unitRange.creature) && baseObject->IsInRange(*itr, (float)e.target.unitRange.minDist, (float)e.target.unitRange.maxDist))
                        l->push_back(*itr);
                }

                delete units;
                break;
            }
        case SMART_TARGET_CREATURE_DISTANCE:
            {
                // will always return a valid pointer, even if empty list
                ObjectList* units = GetWorldObjectsInDist((float)e.target.unitDistance.dist);
                for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                {
                    if (!IsCreature(*itr))
                        continue;

                    if (me && me->GetGUID() == (*itr)->GetGUID())
                        continue;

                    // check alive state - 1 alive, 2 dead, 0 both
                    if (uint32 state = e.target.unitDistance.livingState)
                    {
                        if ((*itr)->ToCreature()->IsAlive() && state == 2)
                            continue;
                        if (!(*itr)->ToCreature()->IsAlive() && state == 1)
                            continue;
                    }

                    if ((e.target.unitDistance.creature && (*itr)->ToCreature()->GetEntry() == e.target.unitDistance.creature) || !e.target.unitDistance.creature)
                        l->push_back(*itr);
                }

                delete units;
                break;
            }
        case SMART_TARGET_GAMEOBJECT_DISTANCE:
            {
                // will always return a valid pointer, even if empty list
                ObjectList* units = GetWorldObjectsInDist((float)e.target.goDistance.dist);
                for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                {
                    if (!IsGameObject(*itr))
                        continue;

                    if (go && go->GetGUID() == (*itr)->GetGUID())
                        continue;

                    if ((e.target.goDistance.entry && (*itr)->ToGameObject()->GetEntry() == e.target.goDistance.entry) || !e.target.goDistance.entry)
                        l->push_back(*itr);
                }

                delete units;
                break;
            }
        case SMART_TARGET_GAMEOBJECT_RANGE:
            {
                // will always return a valid pointer, even if empty list
                ObjectList* units = GetWorldObjectsInDist((float)e.target.goRange.maxDist);
                for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                {
                    if (!IsGameObject(*itr))
                        continue;

                    if (go && go->GetGUID() == (*itr)->GetGUID())
                        continue;

                    if (((e.target.goRange.entry && IsGameObject(*itr) && (*itr)->ToGameObject()->GetEntry() == e.target.goRange.entry) || !e.target.goRange.entry) && baseObject->IsInRange((*itr), (float)e.target.goRange.minDist, (float)e.target.goRange.maxDist))
                        l->push_back(*itr);
                }

                delete units;
                break;
            }
        case SMART_TARGET_CREATURE_GUID:
            {
                if (!scriptTrigger && !baseObject)
                {
                    LOG_ERROR("scripts.ai.sai", "SMART_TARGET_CREATURE_GUID can not be used without invoker");
                    break;
                }

                Creature* target = FindCreatureNear(scriptTrigger ? scriptTrigger : GetBaseObject(), e.target.unitGUID.dbGuid);
                if (target && (!e.target.unitGUID.entry || target->GetEntry() == e.target.unitGUID.entry))
                    l->push_back(target);
                break;
            }
        case SMART_TARGET_GAMEOBJECT_GUID:
            {
                if (!scriptTrigger && !GetBaseObject())
                {
                    LOG_ERROR("scripts.ai.sai", "SMART_TARGET_GAMEOBJECT_GUID can not be used without invoker");
                    break;
                }

                GameObject* target = FindGameObjectNear(scriptTrigger ? scriptTrigger : GetBaseObject(), e.target.goGUID.dbGuid);
                if (target && (!e.target.goGUID.entry || target->GetEntry() == e.target.goGUID.entry))
                    l->push_back(target);
                break;
            }
        case SMART_TARGET_PLAYER_RANGE:
            {
                // will always return a valid pointer, even if empty list
                ObjectList* units = GetWorldObjectsInDist((float)e.target.playerRange.maxDist);
                if (!units->empty() && GetBaseObject())
                {
                    for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                        if (IsPlayer(*itr) && GetBaseObject()->IsInRange(*itr, (float)e.target.playerRange.minDist, (float)e.target.playerRange.maxDist) && (*itr)->ToPlayer()->IsAlive() && !(*itr)->ToPlayer()->IsGameMaster())
                            l->push_back(*itr);

                    // If Orientation is also set and we didnt find targets, try it with all the range
                    if (l->empty() && e.target.o > 0)
                        for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                            if (IsPlayer(*itr) && baseObject->IsInRange(*itr, 0.0f, float(e.target.playerRange.maxDist)) && (*itr)->ToPlayer()->IsAlive() && !(*itr)->ToPlayer()->IsGameMaster())
                                l->push_back(*itr);

                    if (e.target.playerRange.maxCount > 0)
                        Acore::Containers::RandomResize(*l, e.target.playerRange.maxCount);
                }

                delete units;
                break;
            }
        case SMART_TARGET_PLAYER_DISTANCE:
            {
                // will always return a valid pointer, even if empty list
                ObjectList* units = GetWorldObjectsInDist((float)e.target.playerDistance.dist);
                for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                    if (IsPlayer(*itr))
                        l->push_back(*itr);

                delete units;
                break;
            }
        case SMART_TARGET_STORED:
            {
                ObjectListMap::iterator itr = mTargetStorage->find(e.target.stored.id);
                if (itr != mTargetStorage->end())
                {
                    ObjectList* objectList = itr->second->GetObjectList();
                    l->assign(objectList->begin(), objectList->end());
                }

                // xinef: return l, what if list is empty? will return empty list instead of null pointer
                break;
            }
        case SMART_TARGET_CLOSEST_CREATURE:
            {
                Creature* target = GetClosestCreatureWithEntry(GetBaseObject(), e.target.unitClosest.entry, (float)(e.target.unitClosest.dist ? e.target.unitClosest.dist : 100), !e.target.unitClosest.dead);
                if (target)
                    l->push_back(target);
                break;
            }
        case SMART_TARGET_CLOSEST_GAMEOBJECT:
            {
                GameObject* target = GetClosestGameObjectWithEntry(GetBaseObject(), e.target.goClosest.entry, (float)(e.target.goClosest.dist ? e.target.goClosest.dist : 100), e.target.goClosest.onlySpawned);
                if (target)
                    l->push_back(target);
                break;
            }
        case SMART_TARGET_CLOSEST_PLAYER:
            {
                if (WorldObject* obj = GetBaseObject())
                {
                    Player* target = obj->SelectNearestPlayer((float)e.target.playerDistance.dist);
                    if (target)
                        l->push_back(target);
                }
                break;
            }
        case SMART_TARGET_OWNER_OR_SUMMONER:
            /*
             * Owners/Summoners should be WorldObjects. This allows to have other objects
             * such as gameobjects to execute SmartScripts using this type of target.
             * Otherwise, only Units like creatures can summon other creatures.
             */
            {
                if (me)
                {
                    if (WorldObject* owner = ObjectAccessor::GetWorldObject(*me, me->GetCharmerOrOwnerGUID()))
                    {
                        l->push_back(owner);
                    }
                    else if (me->IsSummon() && me->ToTempSummon()->GetSummonerUnit())
                    {
                        l->push_back(me->ToTempSummon()->GetSummonerUnit());
                    }
                }
                else if (go)
                {
                    if (WorldObject* owner = ObjectAccessor::GetWorldObject(*go, go->GetOwnerGUID()))
                    {
                        l->push_back(owner);
                    }
                }

                // xinef: Get owner of owner
                if (e.target.owner.useCharmerOrOwner && !l->empty())
                {
                    if (Unit* owner = l->front()->ToUnit())
                    {
                        l->clear();

                        if (Unit* base = ObjectAccessor::GetUnit(*owner, owner->GetCharmerOrOwnerGUID()))
                        {
                            l->push_back(base);
                        }
                    }
                }
                break;
            }
        case SMART_TARGET_THREAT_LIST:
            {
                if (me)
                {
                    ThreatContainer::StorageType threatList = me->getThreatMgr().getThreatList();
                    for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
                        if (Unit* temp = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                            // Xinef: added distance check
                            if (e.target.threatList.maxDist == 0 || me->IsWithinCombatRange(temp, (float)e.target.threatList.maxDist))
                                l->push_back(temp);
                }
                break;
            }
        case SMART_TARGET_CLOSEST_ENEMY:
            {
                if (me)
                    if (Unit* target = me->SelectNearestTarget(e.target.closestAttackable.maxDist, e.target.closestAttackable.playerOnly))
                        l->push_back(target);

                break;
            }
        case SMART_TARGET_CLOSEST_FRIENDLY:
            {
                if (me)
                    if (Unit* target = DoFindClosestFriendlyInRange(e.target.closestFriendly.maxDist, e.target.closestFriendly.playerOnly))
                        l->push_back(target);

                break;
            }
        case SMART_TARGET_PLAYER_WITH_AURA:
            {
                // will always return a valid pointer, even if empty list
                ObjectList* units = GetWorldObjectsInDist(e.target.z ? e.target.z : float(e.target.playerWithAura.distMax));
                for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                    if (IsPlayer(*itr) && (*itr)->ToPlayer()->IsAlive() && !(*itr)->ToPlayer()->IsGameMaster())
                        if (GetBaseObject()->IsInRange(*itr, (float)e.target.playerWithAura.distMin, (float)e.target.playerWithAura.distMax))
                            if (bool(e.target.playerWithAura.negation) != (*itr)->ToPlayer()->HasAura(e.target.playerWithAura.spellId))
                                l->push_back(*itr);

                if (e.target.o > 0)
                    Acore::Containers::RandomResize(*l, e.target.o);

                delete units;
                break;
            }
        case SMART_TARGET_ROLE_SELECTION:
            {
                // will always return a valid pointer, even if empty list
                ObjectList* units = GetWorldObjectsInDist(float(e.target.roleSelection.maxDist));
                // 1 = Tanks, 2 = Healer, 4 = Damage
                uint32 roleMask = e.target.roleSelection.roleMask;
                for (ObjectList::const_iterator itr = units->begin(); itr != units->end(); ++itr)
                    if (Player* targetPlayer = (*itr)->ToPlayer())
                        if (targetPlayer->IsAlive() && !targetPlayer->IsGameMaster())
                        {
                            if (roleMask & SMART_TARGET_ROLE_FLAG_TANKS)
                            {
                                if (targetPlayer->HasTankSpec())
                                {
                                    l->push_back(*itr);
                                    continue;
                                }
                            }
                            if (roleMask & SMART_TARGET_ROLE_FLAG_HEALERS)
                            {
                                if (targetPlayer->HasHealSpec())
                                {
                                    l->push_back(*itr);
                                    continue;
                                }
                            }
                            if (roleMask & SMART_TARGET_ROLE_FLAG_DAMAGERS)
                            {
                                if (targetPlayer->HasCasterSpec() || targetPlayer->HasMeleeSpec())
                                {
                                    l->push_back(*itr);
                                    continue;
                                }
                            }
                        }

                if (e.target.roleSelection.resize > 0)
                    Acore::Containers::RandomResize(*l, e.target.roleSelection.resize);

                delete units;
                break;
            }
        case SMART_TARGET_VEHICLE_PASSENGER:
            {
                if (me && me->IsVehicle())
                {
                    if (Unit* target = me->GetVehicleKit()->GetPassenger(e.target.vehicle.seatMask))
                    {
                        l->push_back(target);
                    }
                }
                break;
            }
        case SMART_TARGET_LOOT_RECIPIENTS:
            {
                if (me)
                {
                    if (Group* lootGroup = me->GetLootRecipientGroup())
                    {
                        for (GroupReference* it = lootGroup->GetFirstMember(); it != nullptr; it = it->next())
                        {
                            if (Player* recipient = it->GetSource())
                            {
                                l->push_back(recipient);
                            }
                        }
                    }
                    else
                    {
                        if (Player* recipient = me->GetLootRecipient())
                        {
                            l->push_back(recipient);
                        }
                    }
                }
            }
        case SMART_TARGET_NONE:
        case SMART_TARGET_POSITION:
        default:
            break;
    }

    if (l->empty())
    {
        delete l;
        l = nullptr;
    }

    return l;
}

ObjectList* SmartScript::GetWorldObjectsInDist(float dist)
{
    ObjectList* targets = new ObjectList();
    WorldObject* obj = GetBaseObject();
    if (obj)
    {
        Acore::AllWorldObjectsInRange u_check(obj, dist);
        Acore::WorldObjectListSearcher<Acore::AllWorldObjectsInRange> searcher(obj, *targets, u_check);
        Cell::VisitAllObjects(obj, searcher, dist);
    }
    return targets;
}

void SmartScript::ProcessEvent(SmartScriptHolder& e, Unit* unit, uint32 var0, uint32 var1, bool bvar, SpellInfo const* spell, GameObject* gob)
{
    if (!e.active && e.GetEventType() != SMART_EVENT_LINK)
        return;

    if ((e.event.event_phase_mask && !IsInPhase(e.event.event_phase_mask)) || ((e.event.event_flags & SMART_EVENT_FLAG_NOT_REPEATABLE) && e.runOnce))
        return;

    switch (e.GetEventType())
    {
        case SMART_EVENT_LINK://special handling
            ProcessAction(e, unit, var0, var1, bvar, spell, gob);
            break;
        //called from Update tick
        case SMART_EVENT_UPDATE:
            ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
            break;
        case SMART_EVENT_UPDATE_OOC:
            if (me && me->IsInCombat())
                return;
            ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
            break;
        case SMART_EVENT_UPDATE_IC:
            if (!me || !me->IsInCombat())
                return;
            ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
            break;
        case SMART_EVENT_HEALTH_PCT:
            {
                if (!me || !me->IsInCombat() || !me->GetMaxHealth())
                    return;
                uint32 perc = (uint32)me->GetHealthPct();
                if (perc > e.event.minMaxRepeat.max || perc < e.event.minMaxRepeat.min)
                    return;
                ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
                break;
            }
        case SMART_EVENT_TARGET_HEALTH_PCT:
            {
                if (!me || !me->IsInCombat() || !me->GetVictim() || !me->GetVictim()->GetMaxHealth())
                    return;
                uint32 perc = (uint32)me->GetVictim()->GetHealthPct();
                if (perc > e.event.minMaxRepeat.max || perc < e.event.minMaxRepeat.min)
                    return;
                ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax, me->GetVictim());
                break;
            }
        case SMART_EVENT_MANA_PCT:
            {
                if (!me || !me->IsInCombat() || !me->GetMaxPower(POWER_MANA))
                    return;
                uint32 perc = uint32(me->GetPowerPct(POWER_MANA));
                if (perc > e.event.minMaxRepeat.max || perc < e.event.minMaxRepeat.min)
                    return;
                ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
                break;
            }
        case SMART_EVENT_TARGET_MANA_PCT:
            {
                if (!me || !me->IsInCombat() || !me->GetVictim() || !me->GetVictim()->GetMaxPower(POWER_MANA))
                    return;
                uint32 perc = uint32(me->GetVictim()->GetPowerPct(POWER_MANA));
                if (perc > e.event.minMaxRepeat.max || perc < e.event.minMaxRepeat.min)
                    return;
                ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax, me->GetVictim());
                break;
            }
        case SMART_EVENT_RANGE:
            {
                if (!me || !me->IsInCombat() || !me->GetVictim())
                    return;

                if (me->IsInRange(me->GetVictim(), (float)e.event.minMaxRepeat.min, (float)e.event.minMaxRepeat.max))
                    ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax, me->GetVictim());
                else // xinef: make it predictable
                    RecalcTimer(e, 500, 500);
                break;
            }
        case SMART_EVENT_VICTIM_CASTING:
            {
                if (!me || !me->IsInCombat())
                    return;

                Unit* victim = me->GetVictim();

                if (!victim || !victim->IsNonMeleeSpellCast(false, false, true))
                    return;

                if (e.event.targetCasting.spellId > 0)
                    if (Spell* currSpell = victim->GetCurrentSpell(CURRENT_GENERIC_SPELL))
                        if (currSpell->m_spellInfo->Id != e.event.targetCasting.spellId)
                            return;

                ProcessTimedAction(e, e.event.targetCasting.repeatMin, e.event.targetCasting.repeatMax, me->GetVictim());
                break;
            }
        case SMART_EVENT_FRIENDLY_HEALTH:
            {
                if (!me || !me->IsInCombat())
                    return;

                Unit* target = DoSelectLowestHpFriendly((float)e.event.friendlyHealth.radius, e.event.friendlyHealth.hpDeficit);
                if (!target || !target->IsInCombat())
                {
                    // Xinef: if there are at least two same npcs, they will perform the same action immediately even if this is useless...
                    RecalcTimer(e, 1000, 3000);
                    return;
                }
                ProcessTimedAction(e, e.event.friendlyHealth.repeatMin, e.event.friendlyHealth.repeatMax, target);
                break;
            }
        case SMART_EVENT_FRIENDLY_IS_CC:
            {
                if (!me || !me->IsInCombat())
                    return;

                std::list<Creature*> pList;
                DoFindFriendlyCC(pList, (float)e.event.friendlyCC.radius);
                if (pList.empty())
                {
                    // Xinef: if there are at least two same npcs, they will perform the same action immediately even if this is useless...
                    RecalcTimer(e, 1000, 3000);
                    return;
                }
                ProcessTimedAction(e, e.event.friendlyCC.repeatMin, e.event.friendlyCC.repeatMax, Acore::Containers::SelectRandomContainerElement(pList));
                break;
            }
        case SMART_EVENT_FRIENDLY_MISSING_BUFF:
            {
                std::list<Creature*> pList;
                DoFindFriendlyMissingBuff(pList, (float)e.event.missingBuff.radius, e.event.missingBuff.spell);

                if (pList.empty())
                    return;

                ProcessTimedAction(e, e.event.missingBuff.repeatMin, e.event.missingBuff.repeatMax, Acore::Containers::SelectRandomContainerElement(pList));
                break;
            }
        case SMART_EVENT_HAS_AURA:
            {
                if (!me)
                    return;
                uint32 count = me->GetAuraCount(e.event.aura.spell);
                if ((!e.event.aura.count && !count) || (e.event.aura.count && count >= e.event.aura.count))
                    ProcessTimedAction(e, e.event.aura.repeatMin, e.event.aura.repeatMax);
                break;
            }
        case SMART_EVENT_TARGET_BUFFED:
            {
                if (!me || !me->GetVictim())
                    return;
                uint32 count = me->GetVictim()->GetAuraCount(e.event.aura.spell);
                if (count < e.event.aura.count)
                    return;
                ProcessTimedAction(e, e.event.aura.repeatMin, e.event.aura.repeatMax, me->GetVictim());
                break;
            }
        //no params
        case SMART_EVENT_AGGRO:
        case SMART_EVENT_DEATH:
        case SMART_EVENT_EVADE:
        case SMART_EVENT_REACHED_HOME:
        case SMART_EVENT_CHARMED:
        case SMART_EVENT_CHARMED_TARGET:
        case SMART_EVENT_CORPSE_REMOVED:
        case SMART_EVENT_AI_INIT:
        case SMART_EVENT_TRANSPORT_ADDPLAYER:
        case SMART_EVENT_TRANSPORT_REMOVE_PLAYER:
        case SMART_EVENT_QUEST_ACCEPTED:
        case SMART_EVENT_QUEST_OBJ_COMPLETION:
        case SMART_EVENT_QUEST_COMPLETION:
        case SMART_EVENT_QUEST_REWARDED:
        case SMART_EVENT_QUEST_FAIL:
        case SMART_EVENT_JUST_SUMMONED:
        case SMART_EVENT_RESET:
        case SMART_EVENT_JUST_CREATED:
        case SMART_EVENT_FOLLOW_COMPLETED:
        case SMART_EVENT_ON_SPELLCLICK:
            ProcessAction(e, unit, var0, var1, bvar, spell, gob);
            break;

        case SMART_EVENT_GOSSIP_HELLO:
            switch (e.event.gossipHello.filter)
            {
            case 0:
                // no filter set, always execute action
                break;
            case 1:
                // GossipHello only filter set, skip action if reportUse
                if (var0)
                {
                    return;
                }
                break;
            case 2:
                // reportUse only filter set, skip action if GossipHello
                if (!var0)
                {
                    return;
                }
                break;
            default:
                // Ignore any other value
                break;
            }

            ProcessAction(e, unit, var0, var1, bvar, spell, gob);
            break;
        case SMART_EVENT_IS_BEHIND_TARGET:
            {
                if (!me)
                    return;

                if (Unit* victim = me->GetVictim())
                {
                    if (!victim->HasInArc(static_cast<float>(M_PI), me))
                        ProcessTimedAction(e, e.event.behindTarget.cooldownMin, e.event.behindTarget.cooldownMax, victim);
                }
                break;
            }
        case SMART_EVENT_RECEIVE_EMOTE:
            if (e.event.emote.emote == var0)
            {
                ProcessAction(e, unit);
                RecalcTimer(e, e.event.emote.cooldownMin, e.event.emote.cooldownMax);
            }
            break;
        case SMART_EVENT_KILL:
            {
                if (!me || !unit)
                    return;
                if (e.event.kill.playerOnly && unit->GetTypeId() != TYPEID_PLAYER)
                    return;
                if (e.event.kill.creature && unit->GetEntry() != e.event.kill.creature)
                    return;
                RecalcTimer(e, e.event.kill.cooldownMin, e.event.kill.cooldownMax);
                ProcessAction(e, unit);
                break;
            }
        case SMART_EVENT_SPELLHIT_TARGET:
        case SMART_EVENT_SPELLHIT:
            {
                if (!spell)
                    return;
                if ((!e.event.spellHit.spell || spell->Id == e.event.spellHit.spell) &&
                        (!e.event.spellHit.school || (spell->SchoolMask & e.event.spellHit.school)))
                {
                    RecalcTimer(e, e.event.spellHit.cooldownMin, e.event.spellHit.cooldownMax);
                    ProcessAction(e, unit, 0, 0, bvar, spell);
                }
                break;
            }
        case SMART_EVENT_OOC_LOS:
            {
                if (!me || me->IsInCombat())
                    return;
                //can trigger if closer than fMaxAllowedRange
                float range = (float)e.event.los.maxDist;

                //if range is ok and we are actually in LOS
                if (me->IsWithinDistInMap(unit, range) && me->IsWithinLOSInMap(unit))
                {
                    SmartEvent::LOSHostilityMode hostilityMode = static_cast<SmartEvent::LOSHostilityMode>(e.event.los.hostilityMode);
                    //if friendly event&&who is not hostile OR hostile event&&who is hostile
                    if ((hostilityMode == SmartEvent::LOSHostilityMode::Any) ||
                        (hostilityMode == SmartEvent::LOSHostilityMode::NotHostile && !me->IsHostileTo(unit)) ||
                        (hostilityMode == SmartEvent::LOSHostilityMode::Hostile && me->IsHostileTo(unit)))
                    {
                        if (e.event.los.playerOnly && unit->GetTypeId() != TYPEID_PLAYER)
                            return;
                        RecalcTimer(e, e.event.los.cooldownMin, e.event.los.cooldownMax);
                        ProcessAction(e, unit);
                    }
                }
                break;
            }
        case SMART_EVENT_IC_LOS:
            {
                if (!me || !me->IsInCombat())
                    return;
                //can trigger if closer than fMaxAllowedRange
                float range = (float)e.event.los.maxDist;

                //if range is ok and we are actually in LOS
                if (me->IsWithinDistInMap(unit, range) && me->IsWithinLOSInMap(unit))
                {
                    SmartEvent::LOSHostilityMode hostilityMode = static_cast<SmartEvent::LOSHostilityMode>(e.event.los.hostilityMode);
                    //if friendly event&&who is not hostile OR hostile event&&who is hostile
                    if ((hostilityMode == SmartEvent::LOSHostilityMode::Any) ||
                        (hostilityMode == SmartEvent::LOSHostilityMode::NotHostile && !me->IsHostileTo(unit)) ||
                        (hostilityMode == SmartEvent::LOSHostilityMode::Hostile && me->IsHostileTo(unit)))
                    {
                        if (e.event.los.playerOnly && unit->GetTypeId() != TYPEID_PLAYER)
                            return;
                        RecalcTimer(e, e.event.los.cooldownMin, e.event.los.cooldownMax);
                        ProcessAction(e, unit);
                    }
                }
                break;
            }
        case SMART_EVENT_RESPAWN:
            {
                if (!GetBaseObject())
                    return;
                if (e.event.respawn.type == SMART_SCRIPT_RESPAWN_CONDITION_MAP && GetBaseObject()->GetMapId() != e.event.respawn.map)
                    return;
                if (e.event.respawn.type == SMART_SCRIPT_RESPAWN_CONDITION_AREA && GetBaseObject()->GetZoneId() != e.event.respawn.area)
                    return;
                ProcessAction(e);
                break;
            }
        case SMART_EVENT_SUMMONED_UNIT:
        case SMART_EVENT_SUMMONED_UNIT_DIES:
            {
                if (!IsCreature(unit))
                    return;
                if (e.event.summoned.creature && unit->GetEntry() != e.event.summoned.creature)
                    return;
                RecalcTimer(e, e.event.summoned.cooldownMin, e.event.summoned.cooldownMax);
                ProcessAction(e, unit);
                break;
            }
        case SMART_EVENT_RECEIVE_HEAL:
        case SMART_EVENT_DAMAGED:
        case SMART_EVENT_DAMAGED_TARGET:
            {
                if (var0 > e.event.minMaxRepeat.max || var0 < e.event.minMaxRepeat.min)
                    return;
                RecalcTimer(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
                ProcessAction(e, unit);
                break;
            }
        case SMART_EVENT_MOVEMENTINFORM:
            {
                if ((e.event.movementInform.type && var0 != e.event.movementInform.type) || (e.event.movementInform.id && var1 != e.event.movementInform.id))
                    return;
                ProcessAction(e, unit, var0, var1);
                break;
            }
        case SMART_EVENT_TRANSPORT_RELOCATE:
        case SMART_EVENT_WAYPOINT_START:
            {
                if (e.event.waypoint.pathID && var0 != e.event.waypoint.pathID)
                    return;
                ProcessAction(e, unit, var0);
                break;
            }
        case SMART_EVENT_WAYPOINT_REACHED:
        case SMART_EVENT_WAYPOINT_RESUMED:
        case SMART_EVENT_WAYPOINT_PAUSED:
        case SMART_EVENT_WAYPOINT_STOPPED:
        case SMART_EVENT_WAYPOINT_ENDED:
            {
                if (!me || (e.event.waypoint.pointID && var0 != e.event.waypoint.pointID) || (e.event.waypoint.pathID && GetPathId() != e.event.waypoint.pathID))
                    return;
                ProcessAction(e, unit);
                break;
            }
        case SMART_EVENT_SUMMON_DESPAWNED:
            {
                if (e.event.summoned.creature && e.event.summoned.creature != var0)
                    return;
                RecalcTimer(e, e.event.summoned.cooldownMin, e.event.summoned.cooldownMax);
                ProcessAction(e, unit, var0);
                break;
            }
        case SMART_EVENT_INSTANCE_PLAYER_ENTER:
            {
                if (e.event.instancePlayerEnter.team && var0 != e.event.instancePlayerEnter.team)
                    return;
                RecalcTimer(e, e.event.instancePlayerEnter.cooldownMin, e.event.instancePlayerEnter.cooldownMax);
                ProcessAction(e, unit, var0);
                break;
            }
        case SMART_EVENT_ACCEPTED_QUEST:
        case SMART_EVENT_REWARD_QUEST:
            {
                if (e.event.quest.quest && var0 != e.event.quest.quest)
                    return;
                RecalcTimer(e, e.event.quest.cooldownMin, e.event.quest.cooldownMax);
                ProcessAction(e, unit, var0);
                break;
            }
        case SMART_EVENT_TRANSPORT_ADDCREATURE:
            {
                if (e.event.transportAddCreature.creature && var0 != e.event.transportAddCreature.creature)
                    return;
                ProcessAction(e, unit, var0);
                break;
            }
        case SMART_EVENT_AREATRIGGER_ONTRIGGER:
            {
                if (e.event.areatrigger.id && var0 != e.event.areatrigger.id)
                    return;
                ProcessAction(e, unit, var0);
                break;
            }
        case SMART_EVENT_TEXT_OVER:
            {
                if (var0 != e.event.textOver.textGroupID || (e.event.textOver.creatureEntry && e.event.textOver.creatureEntry != var1))
                    return;
                ProcessAction(e, unit, var0);
                break;
            }
        case SMART_EVENT_DATA_SET:
            {
                if (e.event.dataSet.id != var0 || e.event.dataSet.value != var1)
                    return;
                RecalcTimer(e, e.event.dataSet.cooldownMin, e.event.dataSet.cooldownMax);
                ProcessAction(e, unit, var0, var1);
                break;
            }
        case SMART_EVENT_PASSENGER_REMOVED:
        case SMART_EVENT_PASSENGER_BOARDED:
            {
                if (!unit)
                    return;
                RecalcTimer(e, e.event.minMax.repeatMin, e.event.minMax.repeatMax);
                ProcessAction(e, unit);
                break;
            }
        case SMART_EVENT_TIMED_EVENT_TRIGGERED:
            {
                if (e.event.timedEvent.id == var0)
                    ProcessAction(e, unit);
                break;
            }
        case SMART_EVENT_GOSSIP_SELECT:
            {
                LOG_DEBUG("sql.sql", "SmartScript: Gossip Select:  menu {} action {}", var0, var1); //little help for scripters
                if (e.event.gossip.sender != var0 || e.event.gossip.action != var1)
                    return;
                ProcessAction(e, unit, var0, var1);
                break;
            }
        case SMART_EVENT_GAME_EVENT_START:
        case SMART_EVENT_GAME_EVENT_END:
            {
                if (e.event.gameEvent.gameEventId != var0)
                    return;
                ProcessAction(e, nullptr, var0);
                break;
            }
        case SMART_EVENT_GO_STATE_CHANGED:
            {
                if (e.event.goStateChanged.state != var0)
                    return;
                ProcessAction(e, unit, var0, var1);
                break;
            }
        case SMART_EVENT_GO_EVENT_INFORM:
            {
                if (e.event.eventInform.eventId != var0)
                    return;
                ProcessAction(e, nullptr, var0);
                break;
            }
        case SMART_EVENT_ACTION_DONE:
            {
                if (e.event.doAction.eventId != var0)
                    return;
                ProcessAction(e, unit, var0);
                break;
            }
        case SMART_EVENT_FRIENDLY_HEALTH_PCT:
            {
                if (!me || !me->IsInCombat())
                    return;

                ObjectList* _targets = nullptr;

                switch (e.GetTargetType())
                {
                    case SMART_TARGET_CREATURE_RANGE:
                    case SMART_TARGET_CREATURE_GUID:
                    case SMART_TARGET_CREATURE_DISTANCE:
                    case SMART_TARGET_CLOSEST_CREATURE:
                    case SMART_TARGET_CLOSEST_PLAYER:
                    case SMART_TARGET_PLAYER_RANGE:
                    case SMART_TARGET_PLAYER_DISTANCE:
                        _targets = GetTargets(e);
                        break;
                    default:
                        return;
                }

                if (!_targets)
                    return;

                Unit* target = nullptr;

                for (ObjectList::const_iterator itr = _targets->begin(); itr != _targets->end(); ++itr)
                {
                    if (IsUnit(*itr) && me->IsFriendlyTo((*itr)->ToUnit()) && (*itr)->ToUnit()->IsAlive() && (*itr)->ToUnit()->IsInCombat())
                    {
                        uint32 healthPct = uint32((*itr)->ToUnit()->GetHealthPct());

                        if (healthPct > e.event.friendlyHealthPct.maxHpPct || healthPct < e.event.friendlyHealthPct.minHpPct)
                            continue;

                        target = (*itr)->ToUnit();
                        break;
                    }
                }

                delete _targets;

                if (!target)
                    return;

                ProcessTimedAction(e, e.event.friendlyHealthPct.repeatMin, e.event.friendlyHealthPct.repeatMax, target);
                break;
            }
        case SMART_EVENT_DISTANCE_CREATURE:
            {
                if (!me)
                    return;

                WorldObject* creature = nullptr;

                if (e.event.distance.guid != 0)
                {
                    creature = FindCreatureNear(me, e.event.distance.guid);

                    if (!creature)
                        return;

                    if (!me->IsInRange(creature, 0, (float)e.event.distance.dist))
                        return;
                }
                else if (e.event.distance.entry != 0)
                {
                    std::list<Creature*> list;
                    me->GetCreatureListWithEntryInGrid(list, e.event.distance.entry, (float)e.event.distance.dist);

                    if (!list.empty())
                        creature = list.front();
                }

                if (creature)
                    ProcessTimedAction(e, e.event.distance.repeat, e.event.distance.repeat);

                break;
            }
        case SMART_EVENT_DISTANCE_GAMEOBJECT:
            {
                if (!me)
                    return;

                WorldObject* gameobject = nullptr;

                if (e.event.distance.guid != 0)
                {
                    gameobject = FindGameObjectNear(me, e.event.distance.guid);

                    if (!gameobject)
                        return;

                    if (!me->IsInRange(gameobject, 0, (float)e.event.distance.dist))
                        return;
                }
                else if (e.event.distance.entry != 0)
                {
                    std::list<GameObject*> list;
                    me->GetGameObjectListWithEntryInGrid(list, e.event.distance.entry, (float)e.event.distance.dist);

                    if (!list.empty())
                        gameobject = list.front();
                }

                if (gameobject)
                    ProcessTimedAction(e, e.event.distance.repeat, e.event.distance.repeat);

                break;
            }
        case SMART_EVENT_COUNTER_SET:
            if (e.event.counter.id != var0 || GetCounterValue(e.event.counter.id) != e.event.counter.value)
                return;

            ProcessTimedAction(e, e.event.counter.cooldownMin, e.event.counter.cooldownMax);
            break;
        case SMART_EVENT_NEAR_PLAYERS:
            {
                float range = (float)e.event.nearPlayer.radius;
                ObjectList* units = GetWorldObjectsInDist(range);
                if (!units->empty())
                {
                    units->remove_if([](WorldObject * unit) { return unit->GetTypeId() != TYPEID_PLAYER; });

                    if (units->size() >= e.event.nearPlayer.minCount)
                        ProcessAction(e, unit);
                }
                RecalcTimer(e, e.event.nearPlayer.checkTimer, e.event.nearPlayer.checkTimer);
                break;
            }
        case SMART_EVENT_NEAR_PLAYERS_NEGATION:
            {
                float range = (float)e.event.nearPlayerNegation.radius;
                ObjectList* units = GetWorldObjectsInDist(range);
                if (!units->empty())
                {
                    units->remove_if([](WorldObject * unit) { return unit->GetTypeId() != TYPEID_PLAYER; });

                    if (units->size() < e.event.nearPlayerNegation.minCount)
                        ProcessAction(e, unit);
                }
                RecalcTimer(e, e.event.nearPlayerNegation.checkTimer, e.event.nearPlayerNegation.checkTimer);
                break;
            }
        default:
            LOG_ERROR("sql.sql", "SmartScript::ProcessEvent: Unhandled Event type {}", e.GetEventType());
            break;
    }
}

void SmartScript::InitTimer(SmartScriptHolder& e)
{
    switch (e.GetEventType())
    {
        //set only events which have initial timers
        case SMART_EVENT_NEAR_PLAYERS:
        case SMART_EVENT_NEAR_PLAYERS_NEGATION:
            RecalcTimer(e, e.event.nearPlayer.firstTimer, e.event.nearPlayer.firstTimer);
            break;
        case SMART_EVENT_UPDATE:
        case SMART_EVENT_UPDATE_IC:
        case SMART_EVENT_UPDATE_OOC:
            RecalcTimer(e, e.event.minMaxRepeat.min, e.event.minMaxRepeat.max);
            break;
        case SMART_EVENT_OOC_LOS:
        case SMART_EVENT_IC_LOS:
        // Xinef: cooldown should be processed AFTER action is done, not before...
        //RecalcTimer(e, e.event.los.cooldownMin, e.event.los.cooldownMax);
        //break;
        case SMART_EVENT_DISTANCE_CREATURE:
        case SMART_EVENT_DISTANCE_GAMEOBJECT:
            RecalcTimer(e, e.event.distance.repeat, e.event.distance.repeat);
            break;
        default:
            e.active = true;
            break;
    }
}
void SmartScript::RecalcTimer(SmartScriptHolder& e, uint32 min, uint32 max)
{
    // min/max was checked at loading!
    e.timer = urand(uint32(min), uint32(max));
    e.active = e.timer ? false : true;
}

void SmartScript::UpdateTimer(SmartScriptHolder& e, uint32 const diff)
{
    if (e.GetEventType() == SMART_EVENT_LINK)
        return;

    if (e.event.event_phase_mask && !IsInPhase(e.event.event_phase_mask))
        return;

    if (e.GetEventType() == SMART_EVENT_UPDATE_IC && (!me || !me->IsInCombat()))
        return;

    if (e.GetEventType() == SMART_EVENT_UPDATE_OOC && (me && me->IsInCombat()))//can be used with me=nullptr (go script)
        return;

    if (e.timer < diff)
    {
        // delay spell cast event if another spell is being casted
        if (e.GetActionType() == SMART_ACTION_CAST)
        {
            if (!(e.action.cast.flags & (SMARTCAST_INTERRUPT_PREVIOUS | SMARTCAST_TRIGGERED)))
            {
                if (me && me->HasUnitState(UNIT_STATE_CASTING))
                {
                    e.timer = 1;
                    return;
                }
            }
        }

        e.active = true;//activate events with cooldown
        switch (e.GetEventType())//process ONLY timed events
        {
            case SMART_EVENT_NEAR_PLAYERS:
            case SMART_EVENT_NEAR_PLAYERS_NEGATION:
            case SMART_EVENT_UPDATE:
            case SMART_EVENT_UPDATE_OOC:
            case SMART_EVENT_UPDATE_IC:
            case SMART_EVENT_HEALTH_PCT:
            case SMART_EVENT_TARGET_HEALTH_PCT:
            case SMART_EVENT_MANA_PCT:
            case SMART_EVENT_TARGET_MANA_PCT:
            case SMART_EVENT_RANGE:
            case SMART_EVENT_VICTIM_CASTING:
            case SMART_EVENT_FRIENDLY_HEALTH:
            case SMART_EVENT_FRIENDLY_IS_CC:
            case SMART_EVENT_FRIENDLY_MISSING_BUFF:
            case SMART_EVENT_HAS_AURA:
            case SMART_EVENT_TARGET_BUFFED:
            case SMART_EVENT_IS_BEHIND_TARGET:
            case SMART_EVENT_FRIENDLY_HEALTH_PCT:
            case SMART_EVENT_DISTANCE_CREATURE:
            case SMART_EVENT_DISTANCE_GAMEOBJECT:
                {
                    ProcessEvent(e);
                    if (e.GetScriptType() == SMART_SCRIPT_TYPE_TIMED_ACTIONLIST)
                    {
                        e.enableTimed = false;//disable event if it is in an ActionList and was processed once
                        for (SmartAIEventList::iterator i = mTimedActionList.begin(); i != mTimedActionList.end(); ++i)
                        {
                            //find the first event which is not the current one and enable it
                            if (i->event_id > e.event_id)
                            {
                                i->enableTimed = true;
                                break;
                            }
                        }
                    }
                    break;
                }
        }
    }
    else
        e.timer -= diff;
}

bool SmartScript::CheckTimer(SmartScriptHolder const& e) const
{
    return e.active;
}

void SmartScript::InstallEvents()
{
    if (!mInstallEvents.empty())
    {
        for (SmartAIEventList::iterator i = mInstallEvents.begin(); i != mInstallEvents.end(); ++i)
            mEvents.push_back(*i);//must be before UpdateTimers

        mInstallEvents.clear();
    }
}

void SmartScript::OnUpdate(uint32 const diff)
{
    if ((mScriptType == SMART_SCRIPT_TYPE_CREATURE || mScriptType == SMART_SCRIPT_TYPE_GAMEOBJECT) && !GetBaseObject())
        return;

    InstallEvents();//before UpdateTimers

    for (SmartAIEventList::iterator i = mEvents.begin(); i != mEvents.end(); ++i)
        UpdateTimer(*i, diff);

    if (!mStoredEvents.empty())
    {
        SmartAIEventStoredList::iterator i, icurr;
        for (i = mStoredEvents.begin(); i != mStoredEvents.end();)
        {
            icurr = i++;
            UpdateTimer(*icurr, diff);
        }
    }

    bool needCleanup = true;
    if (!mTimedActionList.empty())
    {
        isProcessingTimedActionList = true;
        for (SmartAIEventList::iterator i = mTimedActionList.begin(); i != mTimedActionList.end(); ++i)
        {
            if ((*i).enableTimed)
            {
                UpdateTimer(*i, diff);
                needCleanup = false;
            }
        }

        isProcessingTimedActionList = false;
    }
    if (needCleanup)
        mTimedActionList.clear();

    if (!mRemIDs.empty())
    {
        for (std::list<uint32>::const_iterator i = mRemIDs.begin(); i != mRemIDs.end(); ++i)
            RemoveStoredEvent(*i);

        // xinef: clear list after cleaning...
        mRemIDs.clear();
    }
    if (mUseTextTimer && me)
    {
        if (mTextTimer < diff)
        {
            uint32 textID = mLastTextID;
            mLastTextID = 0;
            uint32 entry = mTalkerEntry;
            mTalkerEntry = 0;
            mTextTimer = 0;
            mUseTextTimer = false;
            ProcessEventsFor(SMART_EVENT_TEXT_OVER, nullptr, textID, entry);
        }
        else mTextTimer -= diff;
    }
}

void SmartScript::FillScript(SmartAIEventList e, WorldObject* obj, AreaTrigger const* at)
{
    (void)at; // ensure that the variable is referenced even if extra logs are disabled in order to pass compiler checks

    if (e.empty())
    {
        if (obj)
            LOG_DEBUG("sql.sql", "SmartScript: EventMap for Entry {} is empty but is using SmartScript.", obj->GetEntry());

        if (at)
            LOG_DEBUG("sql.sql", "SmartScript: EventMap for AreaTrigger {} is empty but is using SmartScript.", at->entry);
        return;
    }
    for (SmartAIEventList::iterator i = e.begin(); i != e.end(); ++i)
    {
#ifndef ACORE_DEBUG
        if ((*i).event.event_flags & SMART_EVENT_FLAG_DEBUG_ONLY)
            continue;
#endif

        if ((*i).event.event_flags & SMART_EVENT_FLAG_DIFFICULTY_ALL)//if has instance flag add only if in it
        {
            if (obj && obj->GetMap()->IsDungeon())
            {
                if ((1 << (obj->GetMap()->GetSpawnMode() + 1)) & (*i).event.event_flags)
                {
                    mEvents.push_back((*i));
                }
            }
            continue;
        }
        mEvents.push_back((*i));//NOTE: 'world(0)' events still get processed in ANY instance mode
    }
}

void SmartScript::GetScript()
{
    SmartAIEventList e;
    if (me)
    {
        e = sSmartScriptMgr->GetScript(-((int32)me->GetSpawnId()), mScriptType);
        if (e.empty())
            e = sSmartScriptMgr->GetScript((int32)me->GetEntry(), mScriptType);
        FillScript(e, me, nullptr);
    }
    else if (go)
    {
        e = sSmartScriptMgr->GetScript(-((int32)go->GetSpawnId()), mScriptType);
        if (e.empty())
            e = sSmartScriptMgr->GetScript((int32)go->GetEntry(), mScriptType);
        FillScript(e, go, nullptr);
    }
    else if (trigger)
    {
        e = sSmartScriptMgr->GetScript((int32)trigger->entry, mScriptType);
        FillScript(e, nullptr, trigger);
    }
}

void SmartScript::OnInitialize(WorldObject* obj, AreaTrigger const* at)
{
    if (obj)//handle object based scripts
    {
        switch (obj->GetTypeId())
        {
            case TYPEID_UNIT:
                mScriptType = SMART_SCRIPT_TYPE_CREATURE;
                me = obj->ToCreature();
                LOG_DEBUG("sql.sql", "SmartScript::OnInitialize: source is Creature {}", me->GetEntry());
                break;
            case TYPEID_GAMEOBJECT:
                mScriptType = SMART_SCRIPT_TYPE_GAMEOBJECT;
                go = obj->ToGameObject();
                LOG_DEBUG("sql.sql", "SmartScript::OnInitialize: source is GameObject {}", go->GetEntry());
                break;
            default:
                LOG_ERROR("scripts.ai.sai", "SmartScript::OnInitialize: Unhandled TypeID !WARNING!");
                return;
        }
    }
    else if (at)
    {
        mScriptType = SMART_SCRIPT_TYPE_AREATRIGGER;
        trigger = at;
        LOG_DEBUG("sql.sql", "SmartScript::OnInitialize: source is AreaTrigger {}", trigger->entry);
    }
    else
    {
        LOG_ERROR("scripts.ai.sai", "SmartScript::OnInitialize: !WARNING! Initialized objects are nullptr.");
        return;
    }

    GetScript();//load copy of script

    uint32 maxDisableDist = 0;
    uint32 minEnableDist = 0;
    for (SmartAIEventList::iterator i = mEvents.begin(); i != mEvents.end(); ++i)
    {
        InitTimer((*i));//calculate timers for first time use
        if (i->GetEventType() == SMART_EVENT_RANGE && i->GetActionType() == SMART_ACTION_ALLOW_COMBAT_MOVEMENT)
        {
            if (i->action.combatMove.move == 1 && i->event.minMaxRepeat.min > minEnableDist)
                minEnableDist = i->event.minMaxRepeat.min;
            else if (i->action.combatMove.move == 0 && (i->event.minMaxRepeat.max < maxDisableDist || maxDisableDist == 0))
                maxDisableDist = i->event.minMaxRepeat.max;
        }

        // Xinef: if smartcast combat move flag is present
        if (i->GetActionType() == SMART_ACTION_CAST && (i->action.cast.flags & SMARTCAST_COMBAT_MOVE))
        {
            if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(i->action.cast.spell))
            {
                float maxRange = spellInfo->GetMaxRange(spellInfo->IsPositive());
                float minRange = spellInfo->GetMinRange(spellInfo->IsPositive());

                if (maxRange > 0 && minRange <= maxRange)
                {
                    smartCasterMaxDist = minRange + ((maxRange - minRange) * 0.65f);
                    smartCasterPowerType = (Powers)spellInfo->PowerType;
                }
            }
        }
    }
    if (maxDisableDist > 0 && minEnableDist >= maxDisableDist)
        mMaxCombatDist = uint32(maxDisableDist + ((minEnableDist - maxDisableDist) / 2));

    ProcessEventsFor(SMART_EVENT_AI_INIT);
    InstallEvents();
    ProcessEventsFor(SMART_EVENT_JUST_CREATED);
}

void SmartScript::OnMoveInLineOfSight(Unit* who)
{
    if (!me)
        return;

    ProcessEventsFor(me->IsInCombat() ? SMART_EVENT_IC_LOS : SMART_EVENT_OOC_LOS, who);
}

/*
void SmartScript::UpdateAIWhileCharmed(const uint32 diff)
{
}

void SmartScript::DoAction(int32 param)
{
}

uint32 SmartScript::GetData(uint32 id)
{
    return 0;
}

void SmartScript::SetData(uint32 id, uint32 value)
{
}

void SmartScript::SetGUID(ObjectGuid guid, int32 id)
{
}

ObjectGuid SmartScript::GetGUID(int32 id)
{
    return ObjectGuid::Empty;
}

void SmartScript::MovepointStart(uint32 id)
{
}

void SmartScript::SetRun(bool run)
{
}

void SmartScript::SetMovePathEndAction(SMART_ACTION action)
{
}

uint32 SmartScript::DoChat(int8 id, ObjectGuid whisperGuid)
{
    return 0;
}*/
// SmartScript end

Unit* SmartScript::DoSelectLowestHpFriendly(float range, uint32 MinHPDiff)
{
    if (!me)
        return nullptr;

    Unit* unit = nullptr;

    Acore::MostHPMissingInRange u_check(me, range, MinHPDiff);
    Acore::UnitLastSearcher<Acore::MostHPMissingInRange> searcher(me, unit, u_check);
    Cell::VisitGridObjects(me, searcher, range);
    return unit;
}

void SmartScript::DoFindFriendlyCC(std::list<Creature*>& _list, float range)
{
    if (!me)
        return;

    Acore::FriendlyCCedInRange u_check(me, range);
    Acore::CreatureListSearcher<Acore::FriendlyCCedInRange> searcher(me, _list, u_check);
    Cell::VisitGridObjects(me, searcher, range);
}

void SmartScript::DoFindFriendlyMissingBuff(std::list<Creature*>& list, float range, uint32 spellid)
{
    if (!me)
        return;

    Acore::FriendlyMissingBuffInRange u_check(me, range, spellid);
    Acore::CreatureListSearcher<Acore::FriendlyMissingBuffInRange> searcher(me, list, u_check);
    Cell::VisitGridObjects(me, searcher, range);
}

Unit* SmartScript::DoFindClosestFriendlyInRange(float range, bool playerOnly)
{
    if (!me)
        return nullptr;

    Unit* unit = nullptr;
    Acore::AnyFriendlyNotSelfUnitInObjectRangeCheck u_check(me, me, range, playerOnly);
    Acore::UnitLastSearcher<Acore::AnyFriendlyNotSelfUnitInObjectRangeCheck> searcher(me, unit, u_check);
    Cell::VisitAllObjects(me, searcher, range);
    return unit;
}

void SmartScript::SetScript9(SmartScriptHolder& e, uint32 entry)
{
    //do NOT clear mTimedActionList if it's being iterated because it will invalidate the iterator and delete
    // any SmartScriptHolder contained like the "e" parameter passed to this function
    if (isProcessingTimedActionList)
    {
        LOG_ERROR("scripts.ai.sai", "Entry {} SourceType {} Event {} Action {} is trying to overwrite timed action list from a timed action, this is not allowed!.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
        return;
    }

    mTimedActionList.clear();
    mTimedActionList = sSmartScriptMgr->GetScript(entry, SMART_SCRIPT_TYPE_TIMED_ACTIONLIST);
    if (mTimedActionList.empty())
        return;
    for (SmartAIEventList::iterator i = mTimedActionList.begin(); i != mTimedActionList.end(); ++i)
    {
        i->enableTimed = i == mTimedActionList.begin();//enable processing only for the first action

        if (e.action.timedActionList.timerType == 0)
            i->event.type = SMART_EVENT_UPDATE_OOC;
        else if (e.action.timedActionList.timerType == 1)
            i->event.type = SMART_EVENT_UPDATE_IC;
        else if (e.action.timedActionList.timerType > 1)
            i->event.type = SMART_EVENT_UPDATE;

        InitTimer((*i));
    }
}

Unit* SmartScript::GetLastInvoker(Unit* invoker)
{
    // Xinef: Look for invoker only on map of base object... Prevents multithreaded crashes
    if (GetBaseObject())
        return ObjectAccessor::GetUnit(*GetBaseObject(), mLastInvoker);
    // xinef: used for area triggers invoker cast
    else if (invoker)
        return ObjectAccessor::GetUnit(*invoker, mLastInvoker);
    return nullptr;
}
