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

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

SmartScript::SmartScript()
{
    go = nullptr;
    me = nullptr;
    trigger = nullptr;
    mEventPhase = 0;
    mPathId = 0;
    mTextTimer = 0;
    mLastTextID = 0;
    mUseTextTimer = false;
    mTalkerEntry = 0;
    mTemplate = SMARTAI_TEMPLATE_BASIC;
    mScriptType = SMART_SCRIPT_TYPE_CREATURE;
    isProcessingTimedActionList = false;
    mCurrentPriority = 0;
    mEventSortingRequired = false;
    _allowPhaseReset = true;
}

SmartScript::~SmartScript()
{
}

bool SmartScript::IsSmart(Creature* c, bool silent) const
{
    if (!c)
        return false;

    bool smart = true;
    if (!dynamic_cast<SmartAI*>(c->AI()))
        smart = false;

    if (!smart && !silent)
        LOG_ERROR("sql.sql", "SmartScript: Action target Creature(entry: {}) is not using SmartAI, action skipped to prevent crash.", c ? c->GetEntry() : (me ? me->GetEntry() : 0));

    return smart;
}

bool SmartScript::IsSmart(GameObject* g, bool silent) const
{
    if (!g)
        return false;

    bool smart = true;
    if (!dynamic_cast<SmartGameObjectAI*>(g->AI()))
        smart = false;

    if (!smart && !silent)
        LOG_ERROR("sql.sql", "SmartScript: Action target GameObject(entry: {}) is not using SmartGameObjectAI, action skipped to prevent crash.", g ? g->GetEntry() : (go ? go->GetEntry() : 0));

    return smart;
}

bool SmartScript::IsSmart(bool silent) const
{
    if (me)
        return IsSmart(me, silent);
    if (go)
        return IsSmart(go, silent);

    return false;
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

        if ((*i).priority != SmartScriptHolder::DEFAULT_PRIORITY)
        {
            (*i).priority = SmartScriptHolder::DEFAULT_PRIORITY;
            mEventSortingRequired = true;
        }
    }
    ProcessEventsFor(SMART_EVENT_RESET);
    mLastInvoker.Clear();
    mCounterList.clear();
}

void SmartScript::ProcessEventsFor(SMART_EVENT e, Unit* unit, uint32 var0, uint32 var1, bool bvar, SpellInfo const* spell, GameObject* gob)
{
    for (SmartAIEventList::iterator i = mEvents.begin(); i != mEvents.end(); ++i)
    {
        SMART_EVENT eventType = SMART_EVENT((*i).GetEventType());
        if (eventType == SMART_EVENT_LINK)//special handling
            continue;

        if (eventType == e)
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
    e.runOnce = true;//used for repeat check

    //calc random
    if (e.event.event_chance < 100 && e.event.event_chance && !(e.event.event_flags & SMART_EVENT_FLAG_TEMP_IGNORE_CHANCE_ROLL))
    {
        uint32 rnd = urand(1, 100);
        if (e.event.event_chance <= rnd)
            return;
    }

    // Remove SMART_EVENT_FLAG_TEMP_IGNORE_CHANCE_ROLL flag after processing roll chances as it's not needed anymore
    e.event.event_flags &= ~SMART_EVENT_FLAG_TEMP_IGNORE_CHANCE_ROLL;

    if (unit)
        mLastInvoker = unit->GetGUID();

    if (Unit* tempInvoker = GetLastInvoker())
        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: Invoker: {} ({})", tempInvoker->GetName(), tempInvoker->GetGUID().ToString());

    bool isControlled = e.action.moveToPos.controlled > 0;

    ObjectVector targets;
    GetTargets(targets, e, unit);

    switch (e.GetActionType())
    {
        case SMART_ACTION_TALK:
        {
            Creature* talker = e.target.type == 0 ? me : nullptr;
            Unit* talkTarget = nullptr;

            for (WorldObject* target : targets)
            {
                if (IsCreature((target)) && !target->ToCreature()->IsPet()) // Prevented sending text to pets.
                {
                    if (e.action.talk.useTalkTarget)
                    {
                        talker = me;
                        talkTarget = target->ToCreature();
                    }
                    else
                        talker = target->ToCreature();
                    break;
                }
                else if (IsPlayer((target)))
                {
                    talker = me; // xinef: added
                    talkTarget = target->ToPlayer();
                    break;
                }
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
            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                    sCreatureTextMgr->SendChat(target->ToCreature(), uint8(e.action.simpleTalk.textGroupID), IsPlayer(GetLastInvoker()) ? GetLastInvoker() : 0);
                else if (IsPlayer(target) && me)
                {
                    Unit* templastInvoker = GetLastInvoker();
                    sCreatureTextMgr->SendChat(me, uint8(e.action.simpleTalk.textGroupID), IsPlayer(templastInvoker) ? templastInvoker : 0, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target->ToPlayer());
                }

                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SIMPLE_TALK: talker: {} ({}), textGroupId: {}",
                               target->GetName(), target->GetGUID().ToString(), uint8(e.action.simpleTalk.textGroupID));
            }
            break;
        }
        case SMART_ACTION_PLAY_EMOTE:
        {
            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    target->ToUnit()->HandleEmoteCommand(e.action.emote.emote);
                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_PLAY_EMOTE: target: {} ({}), emote: {}",
                                   target->GetName(), target->GetGUID().ToString(), e.action.emote.emote);
                }
            }
            break;
        }
        case SMART_ACTION_SOUND:
        {
            for (WorldObject* target : targets)
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
            break;
        }
        case SMART_ACTION_RANDOM_SOUND:
        {
            uint32 sounds[4];
            sounds[0] = e.action.randomSound.sound1;
            sounds[1] = e.action.randomSound.sound2;
            sounds[2] = e.action.randomSound.sound3;
            sounds[3] = e.action.randomSound.sound4;
            uint32 temp[4];
            uint32 count = 0;
            for (unsigned int sound : sounds)
            {
                if (sound)
                {
                    temp[count] = sound;
                    ++count;
                }
            }

            if (count == 0)
            {
                break;
            }

            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    uint32 sound = temp[urand(0, count - 1)];
                    target->PlayDirectSound(sound, e.action.randomSound.onlySelf ? target->ToPlayer() : nullptr);
                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_SOUND: target: {} ({}), sound: {}, onlyself: {}",
                              target->GetName(), target->GetGUID().ToString(), sound, e.action.randomSound.onlySelf);
                }
            }

            break;
        }
        case SMART_ACTION_MUSIC:
        {
            ObjectVector targets;

            if (e.action.music.type > 0)
            {
                if (me && me->FindMap())
                {
                    Map::PlayerList const& players = me->GetMap()->GetPlayers();

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
                                            targets.push_back(player);
                                    }
                                    else
                                        targets.push_back(player);
                                }
                            }
                    }
                }
            }
            else
                GetTargets(targets, e);

            if (!targets.empty())
            {
                for (WorldObject* target : targets)
                {
                    if (IsUnit(target))
                    {
                        target->SendPlayMusic(e.action.music.sound, e.action.music.onlySelf > 0);
                        LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_MUSIC: target: {} ({}), sound: {}, onlySelf: {}, type: {}",
                                  target->GetName(), target->GetGUID().ToString(), e.action.music.sound, e.action.music.onlySelf, e.action.music.type);
                    }
                }
            }
            break;
        }
        case SMART_ACTION_RANDOM_MUSIC:
        {
            ObjectVector targets;

            if (e.action.randomMusic.type > 0)
            {
                if (me && me->FindMap())
                {
                    Map::PlayerList const& players = me->GetMap()->GetPlayers();

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
                                            targets.push_back(player);
                                    }
                                    else
                                        targets.push_back(player);
                                }
                            }
                    }
                }
            }
            else
                GetTargets(targets, e);

            if (targets.empty())
                break;

            uint32 sounds[4];
            sounds[0] = e.action.randomMusic.sound1;
            sounds[1] = e.action.randomMusic.sound2;
            sounds[2] = e.action.randomMusic.sound3;
            sounds[3] = e.action.randomMusic.sound4;
            uint32 temp[4];
            uint32 count = 0;
            for (unsigned int sound : sounds)
            {
                if (sound)
                {
                    temp[count] = sound;
                    ++count;
                }
            }

            if (count == 0)
            {
                break;
            }

            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    uint32 sound = temp[urand(0, count - 1)];
                    target->SendPlayMusic(sound, e.action.randomMusic.onlySelf > 0);
                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_MUSIC: target: {} ({}), sound: {}, onlyself: {}, type: {}",
                                   target->GetName(), target->GetGUID().ToString(), sound, e.action.randomMusic.onlySelf, e.action.randomMusic.type);
                }
            }

            break;
        }
        case SMART_ACTION_SET_FACTION:
        {
            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                {
                    if (e.action.faction.factionID)
                    {
                        target->ToCreature()->SetFaction(e.action.faction.factionID);
                        LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_SET_FACTION: Creature entry {}, GuidLow {} set faction to {}",
                                  target->GetEntry(), target->GetGUID().ToString(), e.action.faction.factionID);
                    }
                    else
                    {
                        if (CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(target->ToCreature()->GetEntry()))
                        {
                            if (target->ToCreature()->GetFaction() != ci->faction)
                            {
                                target->ToCreature()->SetFaction(ci->faction);
                                LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_SET_FACTION: Creature entry {}, GuidLow {} set faction to {}",
                                          target->GetEntry(), target->GetGUID().ToString(), ci->faction);
                            }
                        }
                    }
                }
            }
            break;
        }
        case SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL:
        {
            for (WorldObject* target : targets)
            {
                if (!IsCreature(target))
                    continue;

                if (e.action.morphOrMount.creature || e.action.morphOrMount.model)
                {
                    //set model based on entry from creature_template
                    if (e.action.morphOrMount.creature)
                    {
                        if (CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(e.action.morphOrMount.creature))
                        {
                            CreatureModel const* model = ObjectMgr::ChooseDisplayId(ci);
                            target->ToCreature()->SetDisplayId(model->CreatureDisplayID, model->DisplayScale);
                            LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry {}, GuidLow {} set displayid to {}",
                                      target->GetEntry(), target->GetGUID().ToString(), model->CreatureDisplayID);
                        }
                    }
                        //if no param1, then use value from param2 (modelId)
                    else
                    {
                        target->ToCreature()->SetDisplayId(e.action.morphOrMount.model);
                        LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry {}, GuidLow {} set displayid to {}",
                                  target->GetEntry(), target->GetGUID().ToString(), e.action.morphOrMount.model);
                    }
                }
                else
                {
                    target->ToCreature()->DeMorph();
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry {}, GuidLow {} demorphs.",
                              target->GetEntry(), target->GetGUID().ToString());
                }
            }
            break;
        }
        case SMART_ACTION_FAIL_QUEST:
        {
            for (WorldObject* target : targets)
            {
                if (IsPlayer(target))
                {
                    target->ToPlayer()->FailQuest(e.action.quest.quest);
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_FAIL_QUEST: Player guidLow {} fails quest {}",
                              target->GetGUID().ToString(), e.action.quest.quest);
                }
            }
            break;
        }
        case SMART_ACTION_OFFER_QUEST:
        {
            for (WorldObject* target : targets)
            {
                if (Player* player = target->ToPlayer())
                {
                    if (Quest const* q = sObjectMgr->GetQuestTemplate(e.action.questOffer.questID))
                    {
                        if (me && e.action.questOffer.directAdd == 0)
                        {
                            if (player->CanTakeQuest(q, true))
                            {
                                if (WorldSession* session = player->GetSession())
                                {
                                    PlayerMenu menu(session);
                                    menu.SendQuestGiverQuestDetails(q, me->GetGUID(), true);
                                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_OFFER_QUEST: Player guidLow {} - offering quest {}",
                                              player->GetGUID().ToString(), e.action.questOffer.questID);
                                }
                            }
                        }
                        else
                        {
                            player->AddQuestAndCheckCompletion(q, nullptr);
                            LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_OFFER_QUEST: Player guidLow {} - quest {} added",
                                      player->GetGUID().ToString(), e.action.questOffer.questID);
                        }
                    }
                }
            }
            break;
        }
        case SMART_ACTION_SET_REACT_STATE:
        {
            for (WorldObject* target : targets)
            {
                if (!IsCreature(target))
                    continue;

                target->ToCreature()->SetReactState(ReactStates(e.action.react.state));
            }
            break;
        }
        case SMART_ACTION_RANDOM_EMOTE:
        {
            std::vector<uint32> emotes;
            std::copy_if(e.action.randomEmote.emotes.begin(), e.action.randomEmote.emotes.end(),
                         std::back_inserter(emotes), [](uint32 emote) { return emote != 0; });

            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    uint32 emote = Acore::Containers::SelectRandomContainerElement(emotes);
                    target->ToUnit()->HandleEmoteCommand(emote);
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_EMOTE: Creature guidLow {} handle random emote {}",
                              target->GetGUID().ToString(), emote);
                }
            }
            break;
        }
        case SMART_ACTION_THREAT_ALL_PCT:
        {
            if (!me)
                break;

            ThreatContainer::StorageType threatList = me->GetThreatMgr().GetThreatList();
            for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
            {
                if (Unit* target = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                {
                    me->GetThreatMgr().ModifyThreatByPercent(target, e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
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

            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    me->GetThreatMgr().ModifyThreatByPercent(target->ToUnit(), e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_THREAT_SINGLE_PCT: Creature guidLow {} modify threat for unit {}, value {}",
                              me->GetGUID().ToString(), target->GetGUID().ToString(), e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
                }
            }
            break;
        }
        case SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS:
        {
            for (WorldObject* target : targets)
            {
                // Special handling for vehicles
                if (IsUnit(target))
                    if (Vehicle* vehicle = target->ToUnit()->GetVehicleKit())
                        for (auto & Seat : vehicle->Seats)
                            if (Player* player = ObjectAccessor::GetPlayer(*target, Seat.second.Passenger.Guid))
                                player->AreaExploredOrEventHappens(e.action.quest.quest);

                if (IsPlayer(target))
                {
                    target->ToPlayer()->AreaExploredOrEventHappens(e.action.quest.quest);

                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS: Player guidLow {} credited quest {}",
                              target->GetGUID().ToString(), e.action.quest.quest);
                }
            }
            break;
        }
        case SMART_ACTION_CAST:
        {
            if (targets.empty())
                break;

            Unit* caster = me;
            // Areatrigger Cast!
            if (e.GetScriptType() == SMART_SCRIPT_TYPE_AREATRIGGER)
                caster = unit->SummonTrigger(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetOrientation(), 5000);

            if (e.action.cast.targetsLimit)
                Acore::Containers::RandomResize(targets, e.action.cast.targetsLimit);

            bool failedSpellCast = false, successfulSpellCast = false;

            for (WorldObject* target : targets)
            {
                // may be nullptr
                if (go)
                    go->CastSpell(target->ToUnit(), e.action.cast.spell);

                if (!IsUnit(target))
                    continue;

                if (caster && caster != me) // Areatrigger cast
                {
                    caster->CastSpell(target->ToUnit(), e.action.cast.spell, (e.action.cast.castFlags & SMARTCAST_TRIGGERED));
                }
                else if (me)
                {
                    // If target has the aura, skip
                    if ((e.action.cast.castFlags & SMARTCAST_AURA_NOT_PRESENT) && target->ToUnit()->HasAura(e.action.cast.spell))
                        continue;

                    // If the threatlist is a singleton, cancel
                    if (e.action.cast.castFlags & SMARTCAST_THREATLIST_NOT_SINGLE)
                        if (me->GetThreatMgr().GetThreatListSize() <= 1)
                            break;

                    // If target does not use mana, skip
                    if ((e.action.cast.castFlags & SMARTCAST_TARGET_POWER_MANA) && !target->ToUnit()->GetPower(POWER_MANA))
                        continue;

                    // Interrupts current spellcast
                    if (e.action.cast.castFlags & SMARTCAST_INTERRUPT_PREVIOUS)
                        me->InterruptNonMeleeSpells(false);

                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(e.action.cast.spell);
                    float distanceToTarget = me->GetDistance(target->ToUnit());
                    float spellMaxRange = me->GetSpellMaxRangeForTarget(target->ToUnit(), spellInfo);
                    float spellMinRange = me->GetSpellMinRangeForTarget(target->ToUnit(), spellInfo);
                    float meleeRange = me->GetMeleeRange(target->ToUnit());

                    bool isWithinLOSInMap = me->IsWithinLOSInMap(target->ToUnit());
                    bool isWithinMeleeRange = distanceToTarget <= meleeRange;
                    bool isRangedAttack = spellMaxRange > NOMINAL_MELEE_RANGE;
                    bool isTargetRooted = target->ToUnit()->HasUnitState(UNIT_STATE_ROOT);
                    // To prevent running back and forth when OOM, we must have more than 10% mana.
                    bool canCastSpell = me->GetPowerPct(POWER_MANA) > 10.0f && spellInfo->CalcPowerCost(me, spellInfo->GetSchoolMask()) < (int32)me->GetPower(POWER_MANA) && !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED);
                    bool isSpellIgnoreLOS = spellInfo->HasAttribute(SPELL_ATTR2_IGNORE_LINE_OF_SIGHT);

                    // If target is rooted we move out of melee range before casting, but not further than spell max range.
                    if (isWithinLOSInMap && isWithinMeleeRange && isRangedAttack && isTargetRooted && canCastSpell)
                    {
                        failedSpellCast = true; // Mark spellcast as failed so we can retry it later
                        float minDistance = std::max(meleeRange, spellMinRange) - distanceToTarget + NOMINAL_MELEE_RANGE;
                        CAST_AI(SmartAI, me->AI())->MoveAway(std::min(minDistance, spellMaxRange));
                        continue;
                    }

                    // Let us not try to cast spell if we know it is going to fail anyway. Stick to chasing and continue.
                    if (distanceToTarget > spellMaxRange && isWithinLOSInMap)
                    {
                        failedSpellCast = true;
                        CAST_AI(SmartAI, me->AI())->SetCombatMove(true, std::max(spellMaxRange - NOMINAL_MELEE_RANGE, 0.0f));
                        continue;
                    }
                    else if (distanceToTarget < spellMinRange || !(isWithinLOSInMap || isSpellIgnoreLOS))
                    {
                        failedSpellCast = true;
                        CAST_AI(SmartAI, me->AI())->SetCombatMove(true);
                        continue;
                    }

                    TriggerCastFlags triggerFlags = TRIGGERED_NONE;
                    if (e.action.cast.castFlags & SMARTCAST_TRIGGERED)
                    {
                        if (e.action.cast.triggerFlags)
                            triggerFlags = TriggerCastFlags(e.action.cast.triggerFlags);
                        else
                            triggerFlags = TRIGGERED_FULL_MASK;
                    }

                    SpellCastResult result = me->CastSpell(target->ToUnit(), e.action.cast.spell, triggerFlags);
                    bool spellCastFailed = (result != SPELL_CAST_OK && result != SPELL_FAILED_SPELL_IN_PROGRESS);

                    if (e.action.cast.castFlags & SMARTCAST_COMBAT_MOVE)
                    {
                        // If cast flag SMARTCAST_COMBAT_MOVE is set combat movement will not be allowed unless target is outside spell range, out of mana, or LOS.
                        if (result == SPELL_FAILED_OUT_OF_RANGE)
                            // if we are just out of range, we only chase until we are back in spell range.
                            CAST_AI(SmartAI, me->AI())->SetCombatMove(true, std::max(spellMaxRange - NOMINAL_MELEE_RANGE, 0.0f));
                        else
                            // if spell fail for any other reason, we chase to melee range, or stay where we are if spellcast was successful.
                            CAST_AI(SmartAI, me->AI())->SetCombatMove(spellCastFailed);
                    }

                    if (spellCastFailed)
                        failedSpellCast = true;
                    else
                        successfulSpellCast = true;

                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_CAST: Unit {} casts spell {} on target {} with castflags {}",
                              me->GetGUID().ToString(), e.action.cast.spell, target->GetGUID().ToString(), e.action.cast.castFlags);
                }
            }

            // If there is at least 1 failed cast and no successful casts at all, retry again on next loop
            if (failedSpellCast && !successfulSpellCast)
            {
                RetryLater(e, true);
                // Don't execute linked events
                return;
            }

            break;
        }
        case SMART_ACTION_SELF_CAST:
        {
            if (targets.empty())
                break;

            if (e.action.cast.targetsLimit)
                Acore::Containers::RandomResize(targets, e.action.cast.targetsLimit);

            TriggerCastFlags triggerFlags = TRIGGERED_NONE;
            if (e.action.cast.castFlags & SMARTCAST_TRIGGERED)
            {
                if (e.action.cast.triggerFlags)
                {
                    triggerFlags = TriggerCastFlags(e.action.cast.triggerFlags);
                }
                else
                {
                    triggerFlags = TRIGGERED_FULL_MASK;
                }
            }

            for (WorldObject* target : targets)
            {
                Unit* uTarget = target->ToUnit();
                if (!uTarget)
                    continue;

                if (!(e.action.cast.castFlags & SMARTCAST_AURA_NOT_PRESENT) || !uTarget->HasAura(e.action.cast.spell))
                {
                    if (e.action.cast.castFlags & SMARTCAST_INTERRUPT_PREVIOUS)
                    {
                        uTarget->InterruptNonMeleeSpells(false);
                    }

                    uTarget->CastSpell(uTarget, e.action.cast.spell, triggerFlags);
                }
            }
            break;
        }
        case SMART_ACTION_INVOKER_CAST:
        {
            // Can be used for area trigger cast
            Unit* tempLastInvoker = GetLastInvoker(unit);
            if (!tempLastInvoker)
                break;

            if (targets.empty())
                break;

            if (e.action.cast.targetsLimit)
                Acore::Containers::RandomResize(targets, e.action.cast.targetsLimit);

            for (WorldObject* target : targets)
            {
                if (!IsUnit(target))
                    continue;

                if (!(e.action.cast.castFlags & SMARTCAST_AURA_NOT_PRESENT) || !target->ToUnit()->HasAura(e.action.cast.spell))
                {
                    if (e.action.cast.castFlags & SMARTCAST_INTERRUPT_PREVIOUS)
                    {
                        tempLastInvoker->InterruptNonMeleeSpells(false);
                    }

                    TriggerCastFlags triggerFlags = TRIGGERED_NONE;
                    if (e.action.cast.castFlags & SMARTCAST_TRIGGERED)
                    {
                        if (e.action.cast.triggerFlags)
                        {
                            triggerFlags = TriggerCastFlags(e.action.cast.triggerFlags);
                        }
                        else
                        {
                            triggerFlags = TRIGGERED_FULL_MASK;
                        }
                    }

                    tempLastInvoker->CastSpell(target->ToUnit(), e.action.cast.spell, triggerFlags);
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_INVOKER_CAST: Invoker {} casts spell {} on target {} with castflags {}",
                              tempLastInvoker->GetGUID().ToString(), e.action.cast.spell, target->GetGUID().ToString(), e.action.cast.castFlags);
                }
                else
                {
                    LOG_DEBUG("scripts.ai", "Spell {} not cast because it has flag SMARTCAST_AURA_NOT_PRESENT and the target {} already has the aura",
                              e.action.cast.spell, target->GetGUID().ToString());
                }
            }
            break;
        }
        case SMART_ACTION_ADD_AURA:
        {
            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    target->ToUnit()->AddAura(e.action.cast.spell, target->ToUnit());
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_ADD_AURA: Adding aura {} to unit {}",
                              e.action.cast.spell, target->GetGUID().ToString());
                }
            }
            break;
        }
        case SMART_ACTION_ACTIVATE_GOBJECT:
        {
            for (WorldObject* target : targets)
            {
                if (IsGameObject(target))
                {
                    GameObject* go = target->ToGameObject();

                    // Activate
                    if (go->GetGoType() != GAMEOBJECT_TYPE_DOOR)
                    {
                        go->SetLootState(GO_READY);
                    }

                    go->UseDoorOrButton(0, !!e.action.activateObject.alternative, unit);
                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_ACTIVATE_GOBJECT. Gameobject {} activated", go->GetGUID().ToString());
                }
            }

            break;
        }
        case SMART_ACTION_RESET_GOBJECT:
        {
            for (WorldObject* target : targets)
            {
                if (IsGameObject(target))
                {
                    target->ToGameObject()->ResetDoorOrButton();
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_RESET_GOBJECT. Gameobject {} (entry: {}) reset",
                              target->GetGUID().ToString(), target->GetEntry());
                }
            }
            break;
        }
        case SMART_ACTION_SET_EMOTE_STATE:
        {
            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    target->ToUnit()->SetUInt32Value(UNIT_NPC_EMOTESTATE, e.action.emote.emote);
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_SET_EMOTE_STATE. Unit {} set emotestate to {}",
                              target->GetGUID().ToString(), e.action.emote.emote);
                }
            }
            break;
        }
        case SMART_ACTION_SET_UNIT_FLAG:
        {
            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    if (!e.action.unitFlag.type)
                    {
                        target->ToUnit()->SetFlag(UNIT_FIELD_FLAGS, e.action.unitFlag.flag);
                        LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_SET_UNIT_FLAG. Unit {} added flag {} to UNIT_FIELD_FLAGS",
                                  target->GetGUID().ToString(), e.action.unitFlag.flag);
                    }
                    else
                    {
                        target->ToUnit()->SetFlag(UNIT_FIELD_FLAGS_2, e.action.unitFlag.flag);
                        LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_SET_UNIT_FLAG. Unit {} added flag {} to UNIT_FIELD_FLAGS_2",
                                  target->GetGUID().ToString(), e.action.unitFlag.flag);
                    }
                }
            }
            break;
        }
        case SMART_ACTION_REMOVE_UNIT_FLAG:
        {
            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    if (!e.action.unitFlag.type)
                    {
                        target->ToUnit()->RemoveFlag(UNIT_FIELD_FLAGS, e.action.unitFlag.flag);
                        LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_REMOVE_UNIT_FLAG. Unit {} removed flag {} to UNIT_FIELD_FLAGS",
                                  target->GetGUID().ToString(), e.action.unitFlag.flag);
                    }
                    else
                    {
                        target->ToUnit()->RemoveFlag(UNIT_FIELD_FLAGS_2, e.action.unitFlag.flag);
                        LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction:: SMART_ACTION_REMOVE_UNIT_FLAG. Unit {} removed flag {} to UNIT_FIELD_FLAGS_2",
                                  target->GetGUID().ToString(), e.action.unitFlag.flag);
                    }
                }
            }
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

            bool move = e.action.combatMove.move;
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

            for (WorldObject* target : targets)
                if (IsCreature(target))
                    if (target->ToCreature()->IsAIEnabled)
                        target->ToCreature()->AI()->EnterEvadeMode();

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
            for (WorldObject* target : targets)
            {
                if (!IsUnit(target))
                    continue;

                Unit* unitTarget = target->ToUnit();
                // If invoker was pet or charm
                Player* player = unitTarget->GetCharmerOrOwnerPlayerOrPlayerItself();
                if (player && GetBaseObject())
                {
                    player->GroupEventHappens(e.action.quest.quest, GetBaseObject());
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction: SMART_ACTION_CALL_GROUPEVENTHAPPENS: Player {}, group credit for quest {}",
                        player->GetGUID().ToString(), e.action.quest.quest);
                }

                // Special handling for vehicles
                if (Vehicle* vehicle = unitTarget->GetVehicleKit())
                {
                    for (auto& Seat : vehicle->Seats)
                    {
                        if (Player* player = ObjectAccessor::GetPlayer(*unitTarget, Seat.second.Passenger.Guid))
                        {
                            player->GroupEventHappens(e.action.quest.quest, GetBaseObject());
                        }
                    }
                }
            }
            break;
        }
        case SMART_ACTION_REMOVEAURASFROMSPELL:
        {
            for (WorldObject* target : targets)
            {
                if (!IsUnit(target))
                    continue;

                if (e.action.removeAura.spell)
                {
                    if (e.action.removeAura.charges)
                    {
                        if (Aura* aur = target->ToUnit()->GetAura(e.action.removeAura.spell))
                            aur->ModCharges(-static_cast<int32>(e.action.removeAura.charges), AURA_REMOVE_BY_EXPIRE);
                    }
                    else
                        target->ToUnit()->RemoveAurasDueToSpell(e.action.removeAura.spell);
                }
                else
                    target->ToUnit()->RemoveAllAuras();

                LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction: SMART_ACTION_REMOVEAURASFROMSPELL: Unit {}, spell {}",
                          target->GetGUID().ToString(), e.action.removeAura.spell);
            }
            break;
        }
        case SMART_ACTION_FOLLOW:
        {
            if (!IsSmart())
                break;

            if (e.target.type == SMART_TARGET_NONE || e.target.type == SMART_TARGET_SELF)
            {
                CAST_AI(SmartAI, me->AI())->StopFollow(false);
                break;
            }

            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    float angle = e.action.follow.angle > 6 ? (e.action.follow.angle * M_PI / 180.0f) : e.action.follow.angle;
                    CAST_AI(SmartAI, me->AI())->SetFollow(target->ToUnit(), float(e.action.follow.dist) + 0.1f, angle, e.action.follow.credit, e.action.follow.entry, e.action.follow.creditType, e.action.follow.aliveState);
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction: SMART_ACTION_FOLLOW: Creature {} following target {}",
                              me->GetGUID().ToString(), target->GetGUID().ToString());
                    break;
                }
            }
            break;
        }
        case SMART_ACTION_RANDOM_PHASE:
        {
            if (!GetBaseObject())
                break;

            std::vector<uint32> phases;
            std::copy_if(e.action.randomPhase.phases.begin(), e.action.randomPhase.phases.end(),
                         std::back_inserter(phases), [](uint32 phase) { return phase != 0; });

            uint32 phase = Acore::Containers::SelectRandomContainerElement(phases);
            SetPhase(phase);
            LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction: SMART_ACTION_RANDOM_PHASE: Creature {} sets event phase to {}",
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
                for (WorldObject* target : targets)
                {
                    if (!IsUnit(target))
                        continue;

                    Player* player = target->ToUnit()->GetCharmerOrOwnerPlayerOrPlayerItself();
                    if (!player)
                        continue;

                    player->RewardPlayerAndGroupAtEvent(e.action.killedMonster.creature, player);
                    LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_CALL_KILLEDMONSTER: Player {}, Killcredit: {}",
                              target->GetGUID().ToString(), e.action.killedMonster.creature);
                }
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

            if (targets.empty())
                break;

            instance->SetGuidData(e.action.setInstanceData64.field, targets.front()->GetGUID());
            LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction: SMART_ACTION_SET_INST_DATA64: Field: {}, data: {}",
                      e.action.setInstanceData64.field, targets.front()->GetGUID().ToString());
            break;
        }
        case SMART_ACTION_UPDATE_TEMPLATE:
        {
            for (WorldObject* target : targets)
                if (IsCreature(target))
                    target->ToCreature()->UpdateEntry(e.action.updateTemplate.creature, target->ToCreature()->GetCreatureData(), e.action.updateTemplate.updateLevel != 0);
            break;
        }
        case SMART_ACTION_DIE:
        {
            if (e.action.die.milliseconds)
            {
                if (me && !me->isDead())
                {
                    me->m_Events.AddEventAtOffset([&]
                        {
                            // We need to check again to see if we didn't die in the process.
                            if (me && !me->isDead())
                            {
                                me->KillSelf();
                                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_DIE: Creature {}", me->GetGUID().ToString());
                            }
                        }, Milliseconds(e.action.die.milliseconds));
                }
            }
            else if (me && !me->isDead())
            {
                me->KillSelf();
                LOG_DEBUG("sql.sql", "SmartScript::ProcessAction: SMART_ACTION_DIE: Creature {}", me->GetGUID().ToString());
            }
            break;
        }
        case SMART_ACTION_SET_IN_COMBAT_WITH_ZONE:
        {
            if (targets.empty())
                break;

            if (!me->GetMap()->IsDungeon())
            {
                ObjectVector units;
                GetWorldObjectsInDist(units, static_cast<float>(e.target.unitRange.maxDist));

                if (!units.empty() && GetBaseObject())
                    for (WorldObject* unit : units)
                        if (IsPlayer(unit) && !unit->ToPlayer()->isDead())
                        {
                            me->SetInCombatWith(unit->ToPlayer());
                            unit->ToPlayer()->SetInCombatWith(me);
                            me->AddThreat(unit->ToPlayer(), 0.0f);
                        }
            }
            else
            {
                for (WorldObject* target : targets)
                {
                    if (IsCreature(target))
                    {
                        target->ToCreature()->SetInCombatWithZone();
                        LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction: SMART_ACTION_SET_IN_COMBAT_WITH_ZONE: Creature {}, target: {}",
                                  me->GetGUID().ToString(), target->GetGUID().ToString());
                    }
                }
            }

            break;
        }
        case SMART_ACTION_CALL_FOR_HELP:
        {
            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                {
                    target->ToCreature()->CallForHelp(float(e.action.callHelp.range));
                    if (e.action.callHelp.withEmote)
                    {
                        Acore::BroadcastTextBuilder builder(target, CHAT_MSG_MONSTER_EMOTE, BROADCAST_TEXT_CALL_FOR_HELP, LANG_UNIVERSAL, nullptr);
                        sCreatureTextMgr->SendChatPacket(target, builder, CHAT_MSG_MONSTER_EMOTE);
                    }
                    LOG_DEBUG("scripts.ai", "SmartScript::ProcessAction: SMART_ACTION_CALL_FOR_HELP: Creature {}, target: {}",
                              me->GetGUID().ToString(), target->GetGUID().ToString());
                }
            }
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
            for (WorldObject* target : targets)
            {
                if (e.action.forceDespawn.removeObjectFromWorld)
                {
                    if (e.action.forceDespawn.delay || e.action.forceDespawn.forceRespawnTimer)
                        LOG_ERROR("sql.sql", "SmartScript: SMART_ACTION_FORCE_DESPAWN has removeObjectFromWorld set. delay and forceRespawnTimer ignored.");

                    if (Creature* creature = target->ToCreature())
                        creature->AddObjectToRemoveList();
                    else if (GameObject* go = target->ToGameObject())
                        go->AddObjectToRemoveList();
                }
                else
                {
                    Milliseconds despawnDelay(e.action.forceDespawn.delay);

                    // Wait at least one world update tick before despawn, so it doesn't break linked actions.
                    if (despawnDelay <= 0ms)
                        despawnDelay = 1ms;

                    Seconds forceRespawnTimer(e.action.forceDespawn.forceRespawnTimer);
                    if (Creature* creature = target->ToCreature())
                        creature->DespawnOrUnsummon(despawnDelay, forceRespawnTimer);
                    else if (GameObject* go = target->ToGameObject())
                        go->DespawnOrUnsummon(despawnDelay, forceRespawnTimer);
                }
            }

            break;
        }
        case SMART_ACTION_SET_INGAME_PHASE_MASK:
        {
            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                    target->ToUnit()->SetPhaseMask(e.action.ingamePhaseMask.mask, true);
                else if (IsGameObject(target))
                    target->ToGameObject()->SetPhaseMask(e.action.ingamePhaseMask.mask, true);
            }
            break;
        }
        case SMART_ACTION_MOUNT_TO_ENTRY_OR_MODEL:
        {
            for (WorldObject* target : targets)
            {
                if (!IsUnit(target))
                    continue;

                if (e.action.morphOrMount.creature || e.action.morphOrMount.model)
                {
                    if (e.action.morphOrMount.creature > 0)
                    {
                        if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(e.action.morphOrMount.creature))
                            target->ToUnit()->Mount(ObjectMgr::ChooseDisplayId(cInfo)->CreatureDisplayID);
                    }
                    else
                        target->ToUnit()->Mount(e.action.morphOrMount.model);
                }
                else
                    target->ToUnit()->Dismount();
            }
            break;
        }
        case SMART_ACTION_SET_INVINCIBILITY_HP_LEVEL:
        {
            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                {
                    SmartAI* ai = CAST_AI(SmartAI, target->ToCreature()->AI());
                    if (!ai)
                        continue;

                    if (e.action.invincHP.percent)
                        ai->SetInvincibilityHpLevel(target->ToCreature()->CountPctFromMaxHealth(e.action.invincHP.percent));
                    else
                        ai->SetInvincibilityHpLevel(e.action.invincHP.minHP);
                }
            }
            break;
        }
        case SMART_ACTION_SET_DATA:
        {
            for (WorldObject* target : targets)
            {
                if (Creature* cTarget = target->ToCreature())
                {
                    CreatureAI* ai = cTarget->AI();
                    if (IsSmart(cTarget))
                        ENSURE_AI(SmartAI, ai)->SetData(e.action.setData.field, e.action.setData.data, me);
                    else
                        ai->SetData(e.action.setData.field, e.action.setData.data);
                }
                else if (GameObject* oTarget = target->ToGameObject())
                {
                    GameObjectAI* ai = oTarget->AI();
                    if (IsSmart(oTarget))
                        ENSURE_AI(SmartGameObjectAI, ai)->SetData(e.action.setData.field, e.action.setData.data, me);
                    else
                        ai->SetData(e.action.setData.field, e.action.setData.data);
                }
            }
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
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->SetVisible(!!e.action.visibility.state);

            break;
        }
        case SMART_ACTION_SET_ACTIVE:
        {
            for (WorldObject* target : targets)
                target->setActive(!!e.action.setActive.state);
            break;
        }
        case SMART_ACTION_ATTACK_START:
        {
            if (!me)
                break;

            if (targets.empty())
                break;

            // attack random target
            if (Unit* target = Acore::Containers::SelectRandomContainerElement(targets)->ToUnit())
                me->AI()->AttackStart(target);
            break;
        }
        case SMART_ACTION_ATTACK_STOP:
        {
            for (WorldObject* target : targets)
                if (Unit* unitTarget = target->ToUnit())
                    unitTarget->AttackStop();
            break;
        }
        case SMART_ACTION_SUMMON_CREATURE:
        {
            EnumFlag<SmartActionSummonCreatureFlags> flags(static_cast<SmartActionSummonCreatureFlags>(e.action.summonCreature.flags));
            bool preferUnit = flags.HasFlag(SmartActionSummonCreatureFlags::PreferUnit);
            WorldObject* summoner = preferUnit ? unit : Coalesce<WorldObject>(GetBaseObject(), unit);
            if (!summoner)
                break;

            bool personalSpawn = flags.HasFlag(SmartActionSummonCreatureFlags::PersonalSpawn);

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
                    if (Creature* summon = summoner->SummonCreature(e.action.summonCreature.creature, randomPoint, (TempSummonType)e.action.summonCreature.type, e.action.summonCreature.duration, 0, nullptr, personalSpawn))
                    {
                        if (unit && e.action.summonCreature.attackInvoker)
                            summon->AI()->AttackStart(unit);
                        else if (me && e.action.summonCreature.attackScriptOwner)
                            summon->AI()->AttackStart(me);
                    }
                }
                break;
            }

            float x, y, z, o;
            for (WorldObject* target : targets)
            {
                target->GetPosition(x, y, z, o);
                x += e.target.x;
                y += e.target.y;
                z += e.target.z;
                o += e.target.o;
                if (Creature* summon = summoner->SummonCreature(e.action.summonCreature.creature, x, y, z, o, (TempSummonType)e.action.summonCreature.type, e.action.summonCreature.duration, nullptr, personalSpawn))
                {
                    if (e.action.summonCreature.attackInvoker == 2) // pussywizard: proper attackInvoker implementation
                        summon->AI()->AttackStart(unit);
                    else if (e.action.summonCreature.attackInvoker)
                        summon->AI()->AttackStart(target->ToUnit());
                    else if (me && e.action.summonCreature.attackScriptOwner)
                        summon->AI()->AttackStart(me);
                }
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

            if (!targets.empty())
            {
                float x, y, z, o;
                for (WorldObject* target : targets)
                {
                    // xinef: allow gameobjects to summon gameobjects!
                    //if(!IsUnit((*itr)))
                    //  continue;

                    target->GetPosition(x, y, z, o);
                    x += e.target.x;
                    y += e.target.y;
                    z += e.target.z;
                    o += e.target.o;
                    if (!e.action.summonGO.targetsummon)
                        GetBaseObject()->SummonGameObject(e.action.summonGO.entry, x, y, z, o, 0, 0, 0, 0, e.action.summonGO.despawnTime);
                    else
                        target->SummonGameObject(e.action.summonGO.entry, GetBaseObject()->GetPositionX(), GetBaseObject()->GetPositionY(), GetBaseObject()->GetPositionZ(), GetBaseObject()->GetOrientation(), 0, 0, 0, 0, e.action.summonGO.despawnTime);
                }
            }

            if (e.GetTargetType() != SMART_TARGET_POSITION)
                break;

            GetBaseObject()->SummonGameObject(e.action.summonGO.entry, e.target.x, e.target.y, e.target.z, e.target.o, 0, 0, 0, 0, e.action.summonGO.despawnTime);
            break;
        }
        case SMART_ACTION_KILL_UNIT:
        {
            for (WorldObject* target : targets)
            {
                if (!IsUnit(target))
                    continue;

                Unit::Kill(target->ToUnit(), target->ToUnit());
            }

            break;
        }
        case SMART_ACTION_INSTALL_AI_TEMPLATE:
        {
            InstallTemplate(e);
            break;
        }
        case SMART_ACTION_ADD_ITEM:
        {
            for (WorldObject* target : targets)
            {
                if (!IsPlayer(target))
                    continue;

                target->ToPlayer()->AddItem(e.action.item.entry, e.action.item.count);
            }
            break;
        }
        case SMART_ACTION_REMOVE_ITEM:
        {
            for (WorldObject* target : targets)
            {
                if (!IsPlayer(target))
                    continue;

                target->ToPlayer()->DestroyItemCount(e.action.item.entry, e.action.item.count, true);
            }
            break;
        }
        case SMART_ACTION_STORE_TARGET_LIST:
        {
            StoreTargetList(targets, e.action.storeTargets.id);
            break;
        }
        case SMART_ACTION_TELEPORT:
        {
            for (WorldObject* target : targets)
            {
                if (IsPlayer(target))
                    target->ToPlayer()->TeleportTo(e.action.teleport.mapID, e.target.x, e.target.y, e.target.z, e.target.o);
                else if (IsCreature(target))
                    target->ToCreature()->NearTeleportTo(e.target.x, e.target.y, e.target.z, e.target.o);
            }
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
            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                {
                    if (IsSmart(target->ToCreature()))
                        CAST_AI(SmartAI, target->ToCreature()->AI())->SetRun(e.action.setRun.run);
                    else
                        target->ToCreature()->SetWalk(e.action.setRun.run ? false : true); // Xinef: reversed
                }
            }

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
            if (!targets.empty())
            {
                for (WorldObject* target : targets)
                {
                    if (IsCreature(target))
                    {
                        if (SmartAI* ai = CAST_AI(SmartAI, target->ToCreature()->AI()))
                            ai->GetScript()->StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset, e.action.setCounter.subtract);
                        else
                            LOG_ERROR("sql.sql", "SmartScript: Action target for SMART_ACTION_SET_COUNTER is not using SmartAI, skipping");
                    }
                    else if (IsGameObject(target))
                    {
                        if (SmartGameObjectAI* ai = CAST_AI(SmartGameObjectAI, target->ToGameObject()->AI()))
                            ai->GetScript()->StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset, e.action.setCounter.subtract);
                        else
                            LOG_ERROR("sql.sql", "SmartScript: Action target for SMART_ACTION_SET_COUNTER is not using SmartGameObjectAI, skipping");
                    }
                }
            }
            else
                StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset, e.action.setCounter.subtract);
            break;
        }
        case SMART_ACTION_WP_START:
        {
            if (!IsSmart())
                break;

            bool run = e.action.wpStart.run != 0;
            uint32 entry = e.action.wpStart.pathID;
            bool repeat = e.action.wpStart.repeat != 0;

            for (WorldObject* target : targets)
            {
                if (IsPlayer(target))
                {
                    StoreTargetList(targets, SMART_ESCORT_TARGETS);
                    break;
                }
            }

            me->SetReactState((ReactStates)e.action.wpStart.reactState);
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

            if (e.action.orientation.turnAngle)
            {
                float turnOri = me->GetOrientation() + (static_cast<float>(e.action.orientation.turnAngle) * M_PI / 180.0f);
                me->SetFacingTo(turnOri);
                if (e.action.orientation.quickChange)
                    me->SetOrientation(turnOri);
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
            else if (!targets.empty())
            {
                me->SetFacingToObject(*targets.begin());
                if (e.action.orientation.quickChange)
                    me->SetInFront(*targets.begin());
            }

            break;
        }
        case SMART_ACTION_PLAYMOVIE:
        {
            for (WorldObject* target : targets)
            {
                if (!IsPlayer(target))
                    continue;

                target->ToPlayer()->SendMovieStart(e.action.movie.entry);
            }
            break;
        }
        case SMART_ACTION_MOVE_TO_POS:
        {
            if (!IsSmart())
                break;

            WorldObject* target = nullptr;

            switch (e.GetTargetType())
            {
                case SMART_TARGET_POSITION:
                {
                    G3D::Vector3 dest(e.target.x, e.target.y, e.target.z);
                    if (e.action.moveToPos.transport)
                        if (TransportBase* trans = me->GetDirectTransport())
                            trans->CalculatePassengerPosition(dest.x, dest.y, dest.z);

                    me->GetMotionMaster()->MovePoint(e.action.moveToPos.pointId, dest.x, dest.y, dest.z, true, true,
                        isControlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE, e.target.o);

                    break;
                }
                case SMART_TARGET_RANDOM_POINT:
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

                    break;
                }
                // Can use target floats as offset
                default:
                {
                    // we want to move to random element
                    if (targets.empty())
                        return;
                    else
                        target = Acore::Containers::SelectRandomContainerElement(targets);

                    float x, y, z;
                    target->GetPosition(x, y, z);

                    if (e.action.moveToPos.combatReach)
                        target->GetNearPoint(me, x, y, z, target->GetCombatReach() + e.action.moveToPos.ContactDistance, 0, target->GetAngle(me));
                    else if (e.action.moveToPos.ContactDistance)
                        target->GetNearPoint(me, x, y, z, e.action.moveToPos.ContactDistance, 0, target->GetAngle(me));

                    me->GetMotionMaster()->MovePoint(e.action.moveToPos.pointId, x + e.target.x, y + e.target.y, z + e.target.z, true, true, isControlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE);

                    break;
                }
            }

            break;
        }
        case SMART_ACTION_MOVE_TO_POS_TARGET:
        {
            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                {
                    Creature* ctarget = target->ToCreature();
                    ctarget->GetMotionMaster()->MovePoint(e.action.moveToPos.pointId, e.target.x, e.target.y, e.target.z, true, true, isControlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE);
                }
            }

            break;
        }
        case SMART_ACTION_RESPAWN_TARGET:
        {
            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                    target->ToCreature()->Respawn();
                else if (IsGameObject(target))
                {
                    // do not modify respawndelay of already spawned gameobjects
                    if (target->ToGameObject()->isSpawnedByDefault())
                        target->ToGameObject()->Respawn();
                    else
                        target->ToGameObject()->SetRespawnTime(e.action.RespawnTarget.goRespawnTime);
                }
            }
            break;
        }
        case SMART_ACTION_CLOSE_GOSSIP:
        {
            for (WorldObject* target : targets)
                if (IsPlayer(target))
                    target->ToPlayer()->PlayerTalkClass->SendCloseGossip();
            break;
        }
        case SMART_ACTION_EQUIP:
        {
            for (WorldObject* target : targets)
            {
                if (Creature* npc = target->ToCreature())
                {
                    std::array<uint32, MAX_EQUIPMENT_ITEMS> slot;
                    if (int8 equipId = static_cast<int8>(e.action.equip.entry))
                    {
                        EquipmentInfo const* eInfo = sObjectMgr->GetEquipmentInfo(npc->GetEntry(), equipId);
                        if (!eInfo)
                        {
                            LOG_ERROR("sql.sql", "SmartScript: SMART_ACTION_EQUIP uses non-existent equipment info id {} for creature {}", equipId, npc->GetEntry());
                            break;
                        }

                        npc->SetCurrentEquipmentId(equipId);

                        std::copy(std::begin(eInfo->ItemEntry), std::end(eInfo->ItemEntry), std::begin(slot));
                    }
                    else
                        std::copy(std::begin(e.action.equip.slots), std::end(e.action.equip.slots), std::begin(slot));

                    for (uint32 i = 0; i < MAX_EQUIPMENT_ITEMS; ++i)
                        if (!e.action.equip.mask || (e.action.equip.mask & (1 << i)))
                            npc->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + i, slot[i]);
                }
            }
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
            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                {
                    if (!meOrigGUID)
                        meOrigGUID = me ? me->GetGUID() : ObjectGuid::Empty;
                    if (!goOrigGUID)
                        goOrigGUID = go ? go->GetGUID() : ObjectGuid::Empty;
                    go = nullptr;
                    me = target->ToCreature();
                    break;
                }
                else if (IsGameObject(target))
                {
                    if (!meOrigGUID)
                        meOrigGUID = me ? me->GetGUID() : ObjectGuid::Empty;
                    if (!goOrigGUID)
                        goOrigGUID = go ? go->GetGUID() : ObjectGuid::Empty;
                    go = target->ToGameObject();
                    me = nullptr;
                    break;
                }
            }

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
            float attackAngle = float(e.action.setRangedMovement.angle) / 180.0f * float(M_PI);

            for (WorldObject* target : targets)
                if (Creature* creature = target->ToCreature())
                    if (IsSmart(creature) && creature->GetVictim())
                        if (CAST_AI(SmartAI, creature->AI())->CanCombatMove())
                            creature->GetMotionMaster()->MoveChase(creature->GetVictim(), attackDistance, attackAngle);

            break;
        }
        case SMART_ACTION_CALL_TIMED_ACTIONLIST:
        {
            if (e.GetTargetType() == SMART_TARGET_NONE)
            {
                LOG_ERROR("sql.sql", "SmartScript: Entry {} SourceType {} Event {} Action {} is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                break;
            }

            for (WorldObject* target : targets)
            {
                if (Creature* creature = target->ToCreature())
                {
                    if (IsSmart(creature))
                        CAST_AI(SmartAI, creature->AI())->SetScript9(e, e.action.timedActionList.id, GetLastInvoker());
                }
                else if (GameObject* go = target->ToGameObject())
                {
                    if (IsSmart(go))
                        CAST_AI(SmartGameObjectAI, go->AI())->SetScript9(e, e.action.timedActionList.id, GetLastInvoker());
                }
            }
            break;
        }
        case SMART_ACTION_SET_NPC_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsCreature(target))
                    target->ToUnit()->SetUInt32Value(UNIT_NPC_FLAGS, e.action.unitFlag.flag);
            break;
        }
        case SMART_ACTION_ADD_NPC_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsCreature(target))
                    target->ToUnit()->SetFlag(UNIT_NPC_FLAGS, e.action.unitFlag.flag);
            break;
        }
        case SMART_ACTION_REMOVE_NPC_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsCreature(target))
                    target->ToUnit()->RemoveFlag(UNIT_NPC_FLAGS, e.action.unitFlag.flag);
            break;
        }
        case SMART_ACTION_CROSS_CAST:
        {
            if (targets.empty())
                break;

            ObjectVector casters;
            GetTargets(casters, CreateSmartEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, 0, 0, 0, 0, SMART_ACTION_NONE, 0, 0, 0, 0, 0, 0, (SMARTAI_TARGETS)e.action.crossCast.targetType, e.action.crossCast.targetParam1, e.action.crossCast.targetParam2, e.action.crossCast.targetParam3, 0, 0), unit);

            for (WorldObject* caster : casters)
            {
                if (!IsUnit(caster))
                    continue;

                Unit* casterUnit = caster->ToUnit();

                bool interruptedSpell = false;

                for (WorldObject* target : targets)
                {
                    if (!IsUnit(target))
                        continue;

                    if (!(e.action.crossCast.flags & SMARTCAST_AURA_NOT_PRESENT) || !target->ToUnit()->HasAura(e.action.crossCast.spell))
                    {
                        if (!interruptedSpell && e.action.crossCast.flags & SMARTCAST_INTERRUPT_PREVIOUS)
                        {
                            casterUnit->InterruptNonMeleeSpells(false);
                            interruptedSpell = true;
                        }

                        casterUnit->CastSpell(target->ToUnit(), e.action.crossCast.spell, (e.action.crossCast.flags & SMARTCAST_TRIGGERED) != 0);
                    }
                    else
                        LOG_DEBUG("scripts.ai", "Spell {} not cast because it has flag SMARTCAST_AURA_NOT_PRESENT and the target ({}) already has the aura", e.action.crossCast.spell, target->GetGUID().ToString());
                }
            }
            break;
        }
        case SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST:
        {
            std::vector<uint32> actionLists;
            std::copy_if(e.action.randTimedActionList.actionLists.begin(), e.action.randTimedActionList.actionLists.end(),
                         std::back_inserter(actionLists), [](uint32 actionList) { return actionList != 0; });

            uint32 id = Acore::Containers::SelectRandomContainerElement(actionLists);
            if (e.GetTargetType() == SMART_TARGET_NONE)
            {
                LOG_ERROR("sql.sql", "SmartScript: Entry {} SourceType {} Event {} Action {} is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                break;
            }

            for (WorldObject* target : targets)
            {
                if (Creature* creature = target->ToCreature())
                {
                    if (IsSmart(creature))
                        CAST_AI(SmartAI, creature->AI())->SetScript9(e, id, GetLastInvoker());
                }
                else if (GameObject* go = target->ToGameObject())
                {
                    if (IsSmart(go))
                        CAST_AI(SmartGameObjectAI, go->AI())->SetScript9(e, id, GetLastInvoker());
                }
            }
            break;
        }
        case SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST:
        {
            uint32 id = urand(e.action.randTimedActionList.actionLists[0], e.action.randTimedActionList.actionLists[1]);
            if (e.GetTargetType() == SMART_TARGET_NONE)
            {
                LOG_ERROR("sql.sql", "SmartScript: Entry {} SourceType {} Event {} Action {} is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                break;
            }

            for (WorldObject* target : targets)
            {
                if (Creature* creature = target->ToCreature())
                {
                    if (IsSmart(creature))
                        CAST_AI(SmartAI, creature->AI())->SetScript9(e, id, GetLastInvoker());
                }
                else if (GameObject* go = target->ToGameObject())
                {
                    if (IsSmart(go))
                        CAST_AI(SmartGameObjectAI, go->AI())->SetScript9(e, id, GetLastInvoker());
                }
            }
            break;
        }
        case SMART_ACTION_ACTIVATE_TAXI:
        {
            for (WorldObject* target : targets)
                if (IsPlayer(target))
                    target->ToPlayer()->ActivateTaxiPathTo(e.action.taxi.id);
            break;
        }
        case SMART_ACTION_RANDOM_MOVE:
        {
            bool foundTarget = false;

            for (WorldObject* target : targets)
            {
                if (IsCreature((target)))
                {
                    foundTarget = true;

                    if (e.action.moveRandom.distance)
                        target->ToCreature()->GetMotionMaster()->MoveRandom(float(e.action.moveRandom.distance));
                    else
                        target->ToCreature()->GetMotionMaster()->MoveIdle();
                }
            }

            if (!foundTarget && me && IsCreature(me) && me->IsAlive())
            {
                if (e.action.moveRandom.distance)
                    me->GetMotionMaster()->MoveRandom(float(e.action.moveRandom.distance));
                else
                    me->GetMotionMaster()->MoveIdle();
            }
            break;
        }
        case SMART_ACTION_SET_UNIT_FIELD_BYTES_1:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->SetByteFlag(UNIT_FIELD_BYTES_1, e.action.setunitByte.type, e.action.setunitByte.byte1);
            break;
        }
        case SMART_ACTION_REMOVE_UNIT_FIELD_BYTES_1:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->RemoveByteFlag(UNIT_FIELD_BYTES_1, e.action.delunitByte.type, e.action.delunitByte.byte1);
            break;
        }
        case SMART_ACTION_INTERRUPT_SPELL:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->InterruptNonMeleeSpells(e.action.interruptSpellCasting.withDelayed != 0, e.action.interruptSpellCasting.spell_id, e.action.interruptSpellCasting.withInstant != 0);
            break;
        }
        case SMART_ACTION_SEND_GO_CUSTOM_ANIM:
        {
            for (WorldObject* target : targets)
                if (IsGameObject(target))
                    target->ToGameObject()->SendCustomAnim(e.action.sendGoCustomAnim.anim);
            break;
        }
        case SMART_ACTION_SET_DYNAMIC_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->SetUInt32Value(UNIT_DYNAMIC_FLAGS, e.action.unitFlag.flag);
            break;
        }
        case SMART_ACTION_ADD_DYNAMIC_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->SetFlag(UNIT_DYNAMIC_FLAGS, e.action.unitFlag.flag);
            break;
        }
        case SMART_ACTION_REMOVE_DYNAMIC_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->RemoveFlag(UNIT_DYNAMIC_FLAGS, e.action.unitFlag.flag);
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

            if (targets.empty())
                break;

            // xinef: my implementation
            if (e.action.jump.selfJump)
            {
                if (WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets))
                    if (me)
                        me->GetMotionMaster()->MoveJump(target->GetPositionX() + e.target.x, target->GetPositionY() + e.target.y, target->GetPositionZ() + e.target.z, (float)e.action.jump.speedxy, (float)e.action.jump.speedz);
            }
            else
            {
                for (WorldObject* target : targets)
                    if (WorldObject* obj = (target))
                    {
                        if (Creature* creature = obj->ToCreature())
                            creature->GetMotionMaster()->MoveJump(e.target.x, e.target.y, e.target.z, (float)e.action.jump.speedxy, (float)e.action.jump.speedz);
                    }
            }

            break;
        }
        case SMART_ACTION_GO_SET_LOOT_STATE:
        {
            for (WorldObject* target : targets)
                if (IsGameObject(target))
                    target->ToGameObject()->SetLootState((LootState)e.action.setGoLootState.state);
            break;
        }
        case SMART_ACTION_GO_SET_GO_STATE:
        {
            for (WorldObject* target : targets)
                if (IsGameObject(target))
                    target->ToGameObject()->SetGoState((GOState)e.action.goState.state);
            break;
        }
        case SMART_ACTION_SEND_TARGET_TO_TARGET:
        {
            WorldObject* ref = GetBaseObject();

            if (!ref)
                ref = unit;

            if (!ref)
                break;

            ObjectVector const* storedTargets = GetStoredTargetVector(e.action.sendTargetToTarget.id, *ref);
            if (!storedTargets)
                break;

            for (WorldObject* target : targets)
            {
                if (IsCreature(target))
                {
                    if (SmartAI* ai = CAST_AI(SmartAI, target->ToCreature()->AI()))
                        ai->GetScript()->StoreTargetList(ObjectVector(*storedTargets), e.action.sendTargetToTarget.id);   // store a copy of target list
                    else
                        LOG_ERROR("sql.sql", "SmartScript: Action target for SMART_ACTION_SEND_TARGET_TO_TARGET is not using SmartAI, skipping");
                }
                else if (IsGameObject(target))
                {
                    if (SmartGameObjectAI* ai = CAST_AI(SmartGameObjectAI, target->ToGameObject()->AI()))
                        ai->GetScript()->StoreTargetList(ObjectVector(*storedTargets), e.action.sendTargetToTarget.id);   // store a copy of target list
                    else
                        LOG_ERROR("sql.sql", "SmartScript: Action target for SMART_ACTION_SEND_TARGET_TO_TARGET is not using SmartGameObjectAI, skipping");
                }
            }
            break;
        }
        case SMART_ACTION_SEND_GOSSIP_MENU:
        {
            if (!GetBaseObject())
                break;

            LOG_DEBUG("sql.sql", "SmartScript::ProcessAction:: SMART_ACTION_SEND_GOSSIP_MENU: gossipMenuId {}, gossipNpcTextId {}",
                      e.action.sendGossipMenu.gossipMenuId, e.action.sendGossipMenu.gossipNpcTextId);

            for (WorldObject* target : targets)
                if (Player* player = target->ToPlayer())
                {
                    if (e.action.sendGossipMenu.gossipMenuId)
                        player->PrepareGossipMenu(GetBaseObject(), e.action.sendGossipMenu.gossipMenuId, true);
                    else
                        ClearGossipMenuFor(player);

                    SendGossipMenuFor(player, e.action.sendGossipMenu.gossipNpcTextId, GetBaseObject()->GetGUID());
                }

            break;
        }
        case SMART_ACTION_SET_HOME_POS:
        {
            if (!targets.empty())
            {
                float x, y, z, o;
                for (WorldObject* target : targets)
                    if (IsCreature(target))
                    {
                        if (e.action.setHomePos.spawnPos)
                        {
                            target->ToCreature()->GetRespawnPosition(x, y, z, &o);
                            target->ToCreature()->SetHomePosition(x, y, z, o);
                        }
                        else
                            target->ToCreature()->SetHomePosition(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation());
                    }
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
        case SMART_ACTION_SET_HEALTH_REGEN:
        {
            for (WorldObject* target : targets)
                if (IsCreature(target))
                    target->ToCreature()->SetRegeneratingHealth(e.action.setHealthRegen.regenHealth);

            break;
        }
        case SMART_ACTION_SET_ROOT:
        {
            for (WorldObject* target : targets)
                if (IsCreature(target))
                    target->ToCreature()->SetControlled(e.action.setRoot.root != 0, UNIT_STATE_ROOT);
            break;
        }
        case SMART_ACTION_SET_GO_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsGameObject(target))
                    target->ToGameObject()->SetUInt32Value(GAMEOBJECT_FLAGS, e.action.goFlag.flag);
            break;
        }
        case SMART_ACTION_ADD_GO_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsGameObject(target))
                    target->ToGameObject()->SetFlag(GAMEOBJECT_FLAGS, e.action.goFlag.flag);
            break;
        }
        case SMART_ACTION_REMOVE_GO_FLAG:
        {
            for (WorldObject* target : targets)
                if (IsGameObject(target))
                    target->ToGameObject()->RemoveFlag(GAMEOBJECT_FLAGS, e.action.goFlag.flag);
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
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->SetPower(Powers(e.action.power.powerType), e.action.power.newPower);
            break;
        }
        case SMART_ACTION_ADD_POWER:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->SetPower(Powers(e.action.power.powerType), target->ToUnit()->GetPower(Powers(e.action.power.powerType)) + e.action.power.newPower);
            break;
        }
        case SMART_ACTION_REMOVE_POWER:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->SetPower(Powers(e.action.power.powerType), target->ToUnit()->GetPower(Powers(e.action.power.powerType)) - e.action.power.newPower);
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
            std::vector<uint32> waypoints;
            std::copy_if(e.action.closestWaypointFromList.wps.begin(), e.action.closestWaypointFromList.wps.end(),
                         std::back_inserter(waypoints), [](uint32 wp) { return wp != 0; });

            float distanceToClosest = std::numeric_limits<float>::max();
            WayPoint* closestWp = nullptr;

            for (WorldObject* target : targets)
            {
                if (Creature* creature = target->ToCreature())
                {
                    if (IsSmart(creature))
                    {
                        for (uint32 wp : waypoints)
                        {
                            WPPath* path = sSmartWaypointMgr->GetPath(wp);
                            if (!path || path->empty())
                                continue;

                            auto itrWp = path->find(0);
                            if (itrWp != path->end())
                            {
                                if (WayPoint* wp = itrWp->second)
                                {
                                    float distToThisPath = creature->GetDistance(wp->x, wp->y, wp->z);
                                    if (distToThisPath < distanceToClosest)
                                    {
                                        distanceToClosest = distToThisPath;
                                        closestWp = wp;
                                    }
                                }
                            }
                        }

                        if (closestWp)
                            CAST_AI(SmartAI, creature->AI())->StartPath(false, closestWp->id, true);
                    }
                }
            }
            break;
        }
        case SMART_ACTION_EXIT_VEHICLE:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->ExitVehicle();

            break;
        }
        case SMART_ACTION_SET_UNIT_MOVEMENT_FLAGS:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                {
                    target->ToUnit()->SetUnitMovementFlags(e.action.movementFlag.flag);
                    target->ToUnit()->SendMovementFlagUpdate();
                }

            break;
        }
        case SMART_ACTION_SET_COMBAT_DISTANCE:
        {
            for (WorldObject* target : targets)
                if (IsCreature(target))
                    target->ToCreature()->m_CombatDistance = e.action.combatDistance.dist;

            break;
        }
        case SMART_ACTION_SET_SIGHT_DIST:
        {
            for (WorldObject* const target : targets)
                if (IsCreature(target))
                    target->ToCreature()->m_SightDistance = e.action.sightDistance.dist;
            break;
        }
        case SMART_ACTION_FLEE:
        {
            for (WorldObject* const target : targets)
                if (IsCreature(target))
                    target->ToCreature()->GetMotionMaster()->MoveFleeing(me, e.action.flee.withEmote);
            break;
        }
        case SMART_ACTION_ADD_THREAT:
        {
            for (WorldObject* const target : targets)
                if (IsUnit(target))
                    me->AddThreat(target->ToUnit(), float(e.action.threatPCT.threatINC) - float(e.action.threatPCT.threatDEC));
            break;
        }
        case SMART_ACTION_LOAD_EQUIPMENT:
        {
            for (WorldObject* const target : targets)
                if (IsCreature(target))
                    target->ToCreature()->LoadEquipment(e.action.loadEquipment.id, e.action.loadEquipment.force != 0);
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
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->SetHover(e.action.setHover.state);
            break;
        }
        case SMART_ACTION_ADD_IMMUNITY:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->ApplySpellImmune(e.action.immunity.id, e.action.immunity.type, e.action.immunity.value, true);

            break;
        }
        case SMART_ACTION_REMOVE_IMMUNITY:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->ApplySpellImmune(e.action.immunity.id, e.action.immunity.type, e.action.immunity.value, false);
            break;
        }
        case SMART_ACTION_FALL:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->GetMotionMaster()->MoveFall();

            break;
        }
        case SMART_ACTION_SET_EVENT_FLAG_RESET:
        {
            SetPhaseReset(e.action.setActive.state);
            break;
        }
        case SMART_ACTION_REMOVE_ALL_GAMEOBJECTS:
        {
            for (WorldObject* const target : targets)
                if (IsUnit(target))
                    target->ToUnit()->RemoveAllGameObjects();
            break;
        }
        case SMART_ACTION_STOP_MOTION:
        {
            for (WorldObject* const target : targets)
            {
                if (IsUnit(target))
                {
                    if (e.action.stopMotion.stopMovement)
                        target->ToUnit()->StopMoving();
                    if (e.action.stopMotion.movementExpired)
                        target->ToUnit()->GetMotionMaster()->MovementExpired();
                }
            }
            break;
        }
        case SMART_ACTION_NO_ENVIRONMENT_UPDATE:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);

            break;
        }
        case SMART_ACTION_ZONE_UNDER_ATTACK:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    if (Player* player = target->ToUnit()->GetCharmerOrOwnerPlayerOrPlayerItself())
                    {
                        me->SendZoneUnderAttackMessage(player);
                        break;
                    }

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
            char const* text = sObjectMgr->GetAcoreString(e.action.playerTalk.textId, DEFAULT_LOCALE);

            if (!targets.empty())
                for (WorldObject* target : targets)
                    if (IsPlayer(target))
                        !e.action.playerTalk.flag ? target->ToPlayer()->Say(text, LANG_UNIVERSAL) : target->ToPlayer()->Yell(text, LANG_UNIVERSAL);

            break;
        }
        case SMART_ACTION_CUSTOM_CAST:
        {
            if (!me)
                break;

            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    if (e.action.castCustom.flags & SMARTCAST_INTERRUPT_PREVIOUS)
                    {
                        me->InterruptNonMeleeSpells(false);
                    }

                    if (e.action.castCustom.flags & SMARTCAST_COMBAT_MOVE)
                    {
                        // If cast flag SMARTCAST_COMBAT_MOVE is set combat movement will not be allowed
                        // unless target is outside spell range, out of mana, or LOS.

                        bool _allowMove = false;
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(e.action.castCustom.spell); // AssertSpellInfo?
                        int32 mana = me->GetPower(POWER_MANA);

                        if (me->GetDistance(target->ToUnit()) > spellInfo->GetMaxRange(true) ||
                            me->GetDistance(target->ToUnit()) < spellInfo->GetMinRange(true) ||
                            !me->IsWithinLOSInMap(target->ToUnit()) ||
                            mana < spellInfo->CalcPowerCost(me, spellInfo->GetSchoolMask()))
                            _allowMove = true;

                        CAST_AI(SmartAI, me->AI())->SetCombatMove(_allowMove);
                    }

                    if (!(e.action.castCustom.flags & SMARTCAST_AURA_NOT_PRESENT) || !target->ToUnit()->HasAura(e.action.castCustom.spell))
                    {
                        CustomSpellValues values;
                        if (e.action.castCustom.bp1)
                            values.AddSpellMod(SPELLVALUE_BASE_POINT0, e.action.castCustom.bp1);
                        if (e.action.castCustom.bp2)
                            values.AddSpellMod(SPELLVALUE_BASE_POINT1, e.action.castCustom.bp2);
                        if (e.action.castCustom.bp3)
                            values.AddSpellMod(SPELLVALUE_BASE_POINT2, e.action.castCustom.bp3);
                        me->CastCustomSpell(e.action.castCustom.spell, values, target->ToUnit(), (e.action.castCustom.flags & SMARTCAST_TRIGGERED) ? TRIGGERED_FULL_MASK : TRIGGERED_NONE);
                    }
                }
            }
            break;
        }
        case SMART_ACTION_VORTEX_SUMMON:
        {
            if (!me)
                break;

            if (targets.empty())
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

            for (WorldObject* target : targets)
            {
                // Offset by orientation, should not count into radius calculation,
                // but is needed for vortex direction (polar coordinates)
                float phi = target->GetOrientation();

                do
                {
                    Position summonPosition(*target);
                    summonPosition.RelocatePolarOffset(phi, summonRadius);

                    me->SummonCreature(e.action.summonVortex.summonEntry, summonPosition, summon_type, e.action.summonVortex.summonDuration);

                    phi += delta_phi;
                    summonRadius *= factor;
                } while (summonRadius <= r_max);
            }

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
                else if (!targets.empty())
                {
                    currentAngle += (me->GetAngle(targets.front()) - me->GetOrientation());
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
            for (WorldObject* target : targets)
            {
                if (Player* playerTarget = target->ToPlayer())
                {
                    playerTarget->RemoveArenaSpellCooldowns();
                    playerTarget->RemoveAurasDueToSpell(57724); // Spell Shaman Debuff - Sated (Heroism)
                    playerTarget->RemoveAurasDueToSpell(57723); // Spell Shaman Debuff - Exhaustion (Bloodlust)
                    playerTarget->RemoveAurasDueToSpell(2825);  // Bloodlust
                    playerTarget->RemoveAurasDueToSpell(32182); // Heroism
                }
            }

            break;
        }
        case SMART_ACTION_DO_ACTION:
        {
            int32 const actionId = e.action.doAction.isNegative ? -e.action.doAction.actionId : e.action.doAction.actionId;
            if (!e.action.doAction.instanceTarget)
            {
                if (targets.empty())
                    break;

                for (WorldObject* objTarget : targets)
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
            for (WorldObject* const target : targets)
            {
                if (IsCreature(target))
                    target->ToCreature()->SetCorpseDelay(e.action.corpseDelay.timer);
            }
            break;
        }
        case SMART_ACTION_SET_HEALTH_PCT:
        {
            for (WorldObject* target : targets)
                if (Unit* targetUnit = target->ToUnit())
                    targetUnit->SetHealth(targetUnit->CountPctFromMaxHealth(e.action.setHealthPct.percent));
            break;
        }
        case SMART_ACTION_SET_MOVEMENT_SPEED:
        {
            uint32 speedInteger = e.action.movementSpeed.speedInteger;
            uint32 speedFraction = e.action.movementSpeed.speedFraction;
            float speed = float(speedInteger) + float(speedFraction) / std::pow(10, std::floor(std::log10(float(speedFraction ? speedFraction : 1)) + 1));

            for (WorldObject* target : targets)
                if (IsCreature(target))
                    target->ToCreature()->SetSpeed(UnitMoveType(e.action.movementSpeed.movementType), speed);

            break;
        }
        case SMART_ACTION_PLAY_CINEMATIC:
        {
            for (WorldObject* target : targets)
            {
                if (!IsPlayer(target))
                    continue;

                target->ToPlayer()->SendCinematicStart(e.action.cinematic.entry);
            }
            break;
        }
        case SMART_ACTION_SET_GUID:
        {
            for (WorldObject* target : targets)
            {
                ObjectGuid guidToSend = me ? me->GetGUID() : go->GetGUID();

                if (e.action.setGuid.invokerGUID)
                {
                    if (Unit* invoker = GetLastInvoker())
                    {
                        guidToSend = invoker->GetGUID();
                    }
                }

                if (Creature* creature = target->ToCreature())
                {
                    creature->AI()->SetGUID(guidToSend, e.action.setGuid.index);
                }
                else if (GameObject* object = target->ToGameObject())
                {
                    object->AI()->SetGUID(guidToSend, e.action.setGuid.index);
                }
            }
            break;
        }
        case SMART_ACTION_DISABLE:
        {
            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    target->ToUnit()->SetImmuneToAll(!e.action.disable.state);
                    target->ToUnit()->SetVisible(e.action.disable.state);
                }
            }
            break;
        }
        case SMART_ACTION_SET_SCALE:
        {
            float scale = static_cast<float>(e.action.setScale.scale) / 100.0f;

            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    target->ToUnit()->SetObjectScale(scale);
                }
            }
            break;
        }
        case SMART_ACTION_SUMMON_RADIAL:
        {
            if (!me)
                break;

            TempSummonType spawnType = (e.action.radialSummon.summonDuration > 0) ? TEMPSUMMON_TIMED_DESPAWN : TEMPSUMMON_CORPSE_DESPAWN;

            float startAngle = me->GetOrientation() + (static_cast<float>(e.action.radialSummon.startAngle) * M_PI / 180.0f);
            float stepAngle = static_cast<float>(e.action.radialSummon.stepAngle) * M_PI / 180.0f;

            if (e.action.radialSummon.dist)
            {
                for (uint32 itr = 0; itr < e.action.radialSummon.repetitions; itr++)
                {
                    Position summonPos = me->GetPosition();
                    summonPos.RelocatePolarOffset(itr * stepAngle, static_cast<float>(e.action.radialSummon.dist));
                    me->SummonCreature(e.action.radialSummon.summonEntry, summonPos, spawnType, e.action.radialSummon.summonDuration);
                }
                break;
            }

            for (uint32 itr = 0; itr < e.action.radialSummon.repetitions; itr++)
            {
                float currentAngle = startAngle + (itr * stepAngle);
                me->SummonCreature(e.action.radialSummon.summonEntry, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), currentAngle, spawnType, e.action.radialSummon.summonDuration);
            }

            break;
        }
        case SMART_ACTION_PLAY_SPELL_VISUAL:
        {
            for (WorldObject* target : targets)
            {
                if (IsUnit(target))
                {
                    if (e.action.spellVisual.visualId)
                        target->ToUnit()->SendPlaySpellVisual(e.action.spellVisual.visualId);
                }
            }
            break;
        }
        case SMART_ACTION_FOLLOW_GROUP:
        {
            if (!e.action.followGroup.followState)
            {
                for (WorldObject* target : targets)
                    if (IsUnit(target))
                        target->ToCreature()->GetMotionMaster()->MoveIdle();

                break;
            }

            uint8 membCount = targets.size();
            uint8 itr = 1;
            float dist = float(e.action.followGroup.dist / 100);
            switch (e.action.followGroup.followType)
            {
                case FOLLOW_TYPE_CIRCLE:
                {
                    float angle = (membCount > 4 ? (M_PI * 2)/membCount : (M_PI / 2)); // 90 degrees is the maximum angle
                    for (WorldObject* target : targets)
                    {
                        if (IsCreature(target))
                        {
                            target->ToCreature()->GetMotionMaster()->MoveFollow(me, dist, angle * itr);
                            itr++;
                        }
                    }
                    break;
                }
                case FOLLOW_TYPE_SEMI_CIRCLE_BEHIND:
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsCreature(target))
                        {
                            target->ToCreature()->GetMotionMaster()->MoveFollow(me, dist, (M_PI / 2.0f) + (M_PI / membCount) * (itr - 1));
                            itr++;
                        }
                    }
                    break;
                }
                case FOLLOW_TYPE_SEMI_CIRCLE_FRONT:
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsCreature(target))
                        {
                            target->ToCreature()->GetMotionMaster()->MoveFollow(me, dist, (M_PI + (M_PI / 2.0f) + (M_PI / membCount) * (itr - 1)));
                            itr++;
                        }
                    }
                    break;
                }
                case FOLLOW_TYPE_LINE:
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsCreature(target))
                        {
                            target->ToCreature()->GetMotionMaster()->MoveFollow(me, dist * (((itr - 1) / 2) + 1), itr % 2 ? 0.f : M_PI);
                            itr++;
                        }
                    }
                    break;
                }
                case FOLLOW_TYPE_COLUMN:
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsCreature(target))
                        {
                            target->ToCreature()->GetMotionMaster()->MoveFollow(me, dist * (((itr - 1) / 2) + 1), itr % 2 ? (M_PI / 2) : (M_PI * 1.5f));
                            itr++;
                        }
                    }
                    break;
                }
                case FOLLOW_TYPE_ANGULAR:
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsCreature(target))
                        {
                            target->ToCreature()->GetMotionMaster()->MoveFollow(me, dist * (((itr - 1) / 2) + 1), itr % 2 ? M_PI - (M_PI / 4) : M_PI + (M_PI / 4));
                            itr++;
                        }
                    }
                    break;
                }
                default:
                    break;
            }

            break;
        }
        case SMART_ACTION_SET_ORIENTATION_TARGET:
        {
            switch (e.action.orientationTarget.type)
            {
                case 0: // Reset
                {
                    for (WorldObject* target : targets)
                        target->ToCreature()->SetFacingTo((target->ToCreature()->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && target->ToCreature()->GetTransGUID() ? target->ToCreature()->GetTransportHomePosition() : target->ToCreature()->GetHomePosition()).GetOrientation());

                    break;
                }
                case 1: // Target target.o
                {
                    for (WorldObject* target : targets)
                        target->ToCreature()->SetFacingTo(e.target.o);

                    break;
                }
                case 2: // Target source
                {
                    for (WorldObject* target : targets)
                        target->ToCreature()->SetFacingToObject(me);

                    break;
                }
                case 3: // Target parameters
                {
                    ObjectVector facingTargets;
                    GetTargets(facingTargets, CreateSmartEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, 0, 0, 0, 0, SMART_ACTION_NONE, 0, 0, 0, 0, 0, 0, (SMARTAI_TARGETS)e.action.orientationTarget.targetType, e.action.orientationTarget.targetParam1, e.action.orientationTarget.targetParam2, e.action.orientationTarget.targetParam3, e.action.orientationTarget.targetParam4, 0), unit);

                    for (WorldObject* facingTarget : facingTargets)
                        for (WorldObject* target : targets)
                            target->ToCreature()->SetFacingToObject(facingTarget);

                    break;
                }
                default:
                    break;
            }
            break;
        }
        case SMART_ACTION_WAYPOINT_DATA_START:
        {
            if (e.action.wpData.pathId)
            {
                for (WorldObject* target : targets)
                {
                    if (IsCreature(target))
                    {
                        target->ToCreature()->LoadPath(e.action.wpData.pathId);
                        target->ToCreature()->GetMotionMaster()->MovePath(e.action.wpData.pathId, e.action.wpData.repeat);
                    }
                }
            }

            break;
        }
        case SMART_ACTION_WAYPOINT_DATA_RANDOM:
        {
            if (e.action.wpDataRandom.pathId1 && e.action.wpDataRandom.pathId2)
            {
                for (WorldObject* target : targets)
                {
                    if (IsCreature(target))
                    {
                        uint32 path = urand(e.action.wpDataRandom.pathId1, e.action.wpDataRandom.pathId2);
                        target->ToCreature()->LoadPath(path);
                        target->ToCreature()->GetMotionMaster()->MovePath(path, e.action.wpDataRandom.repeat);
                    }
                }
            }

            break;
        }
        case SMART_ACTION_MOVEMENT_STOP:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->StopMoving();

            break;
        }
        case SMART_ACTION_MOVEMENT_PAUSE:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->PauseMovement(e.action.move.timer);

            break;
        }
        case SMART_ACTION_MOVEMENT_RESUME:
        {
            for (WorldObject* target : targets)
                if (IsUnit(target))
                    target->ToUnit()->ResumeMovement(e.action.move.timer);

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
    if (mTemplate != SMARTAI_TEMPLATE_BASIC)
    {
        LOG_ERROR("sql.sql", "SmartScript::InstallTemplate: Entry {} SourceType {} AI Template can not be set more then once, skipped.", e.entryOrGuid, e.GetScriptType());
        return;
    }
    mTemplate = (SMARTAI_TEMPLATE)e.action.installTtemplate.id;
    switch ((SMARTAI_TEMPLATE)e.action.installTtemplate.id)
    {
        case SMARTAI_TEMPLATE_CASTER:
            {
                AddEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, e.action.installTtemplate.param2, e.action.installTtemplate.param3, 0, 0, SMART_ACTION_CAST, e.action.installTtemplate.param1, e.target.raw.param1, 0, 0, 0, 0, SMART_TARGET_VICTIM, 0, 0, 0, 0, 1);
                AddEvent(SMART_EVENT_RANGE, 0, e.action.installTtemplate.param4, 300, 0, 0, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
                AddEvent(SMART_EVENT_RANGE, 0, 0, e.action.installTtemplate.param4 > 10 ? e.action.installTtemplate.param4 - 10 : 0, 0, 0, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 0, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
                AddEvent(SMART_EVENT_MANA_PCT, 0, e.action.installTtemplate.param5 - 15 > 100 ? 100 : e.action.installTtemplate.param5 + 15, 100, 1000, 1000, 0, 0, SMART_ACTION_SET_EVENT_PHASE, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                AddEvent(SMART_EVENT_MANA_PCT, 0, 0, e.action.installTtemplate.param5, 1000, 1000, 0, 0, SMART_ACTION_SET_EVENT_PHASE, 0, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                AddEvent(SMART_EVENT_MANA_PCT, 0, 0, e.action.installTtemplate.param5, 1000, 1000, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                break;
            }
        case SMARTAI_TEMPLATE_TURRET:
            {
                AddEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, e.action.installTtemplate.param2, e.action.installTtemplate.param3, 0, 0, SMART_ACTION_CAST, e.action.installTtemplate.param1, e.target.raw.param1, 0, 0, 0, 0, SMART_TARGET_VICTIM, 0, 0, 0, 0, 0);
                AddEvent(SMART_EVENT_JUST_CREATED, 0, 0, 0, 0, 0, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 0, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                break;
            }
        case SMARTAI_TEMPLATE_CAGED_NPC_PART:
            {
                if (!me)
                    return;
                //store cage as id1
                AddEvent(SMART_EVENT_DATA_SET, 0, 0, 0, 0, 0, 0, 0, SMART_ACTION_STORE_TARGET_LIST, 1, 0, 0, 0, 0, 0, SMART_TARGET_CLOSEST_GAMEOBJECT, e.action.installTtemplate.param1, 10, 0, 0, 0);

                //reset(close) cage on hostage(me) respawn
                AddEvent(SMART_EVENT_UPDATE, SMART_EVENT_FLAG_NOT_REPEATABLE, 0, 0, 0, 0, 0, 0, SMART_ACTION_RESET_GOBJECT, 0, 0, 0, 0, 0, 0, SMART_TARGET_GAMEOBJECT_DISTANCE, e.action.installTtemplate.param1, 5, 0, 0, 0);

                AddEvent(SMART_EVENT_DATA_SET, 0, 0, 0, 0, 0, 0, 0, SMART_ACTION_SET_RUN, e.action.installTtemplate.param3, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                AddEvent(SMART_EVENT_DATA_SET, 0, 0, 0, 0, 0, 0, 0, SMART_ACTION_SET_EVENT_PHASE, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);

                AddEvent(SMART_EVENT_UPDATE, SMART_EVENT_FLAG_NOT_REPEATABLE, 1000, 1000, 0, 0, 0, 0, SMART_ACTION_MOVE_FORWARD, e.action.installTtemplate.param4, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
                //phase 1: give quest credit on movepoint reached
                AddEvent(SMART_EVENT_MOVEMENTINFORM, 0, POINT_MOTION_TYPE, SMART_RANDOM_POINT, 0, 0, 0, 0, SMART_ACTION_SET_DATA, 0, 0, 0, 0, 0, 0, SMART_TARGET_STORED, 1, 0, 0, 0, 1);
                //phase 1: despawn after time on movepoint reached
                AddEvent(SMART_EVENT_MOVEMENTINFORM, 0, POINT_MOTION_TYPE, SMART_RANDOM_POINT, 0, 0, 0, 0, SMART_ACTION_FORCE_DESPAWN, e.action.installTtemplate.param2, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);

                if (sCreatureTextMgr->TextExist(me->GetEntry(), (uint8)e.action.installTtemplate.param5))
                    AddEvent(SMART_EVENT_MOVEMENTINFORM, 0, POINT_MOTION_TYPE, SMART_RANDOM_POINT, 0, 0, 0, 0, SMART_ACTION_TALK, e.action.installTtemplate.param5, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
                break;
            }
        case SMARTAI_TEMPLATE_CAGED_GO_PART:
            {
                if (!go)
                    return;
                //store hostage as id1
                AddEvent(SMART_EVENT_GO_STATE_CHANGED, 0, 2, 0, 0, 0, 0, 0, SMART_ACTION_STORE_TARGET_LIST, 1, 0, 0, 0, 0, 0, SMART_TARGET_CLOSEST_CREATURE, e.action.installTtemplate.param1, 10, 0, 0, 0);
                //store invoker as id2
                AddEvent(SMART_EVENT_GO_STATE_CHANGED, 0, 2, 0, 0, 0, 0, 0, SMART_ACTION_STORE_TARGET_LIST, 2, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
                //signal hostage
                AddEvent(SMART_EVENT_GO_STATE_CHANGED, 0, 2, 0, 0, 0, 0, 0, SMART_ACTION_SET_DATA, 0, 0, 0, 0, 0, 0, SMART_TARGET_STORED, 1, 0, 0, 0, 0);
                //when hostage raeched end point, give credit to invoker
                if (e.action.installTtemplate.param2)
                    AddEvent(SMART_EVENT_DATA_SET, 0, 0, 0, 0, 0, 0, 0, SMART_ACTION_CALL_KILLEDMONSTER, e.action.installTtemplate.param1, 0, 0, 0, 0, 0, SMART_TARGET_STORED, 2, 0, 0, 0, 0);
                else
                    AddEvent(SMART_EVENT_GO_STATE_CHANGED, 0, 2, 0, 0, 0, 0, 0, SMART_ACTION_CALL_KILLEDMONSTER, e.action.installTtemplate.param1, 0, 0, 0, 0, 0, SMART_TARGET_STORED, 2, 0, 0, 0, 0);
                break;
            }
        case SMARTAI_TEMPLATE_BASIC:
        default:
            return;
    }
}

void SmartScript::AddEvent(SMART_EVENT e, uint32 event_flags, uint32 event_param1, uint32 event_param2, uint32 event_param3, uint32 event_param4, uint32 event_param5, uint32 event_param6, SMART_ACTION action, uint32 action_param1, uint32 action_param2, uint32 action_param3, uint32 action_param4, uint32 action_param5, uint32 action_param6, SMARTAI_TARGETS t, uint32 target_param1, uint32 target_param2, uint32 target_param3, uint32 target_param4, uint32 phaseMask)
{
    mInstallEvents.push_back(CreateSmartEvent(e, event_flags, event_param1, event_param2, event_param3, event_param4, event_param5, event_param6, action, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, t, target_param1, target_param2, target_param3, target_param4, phaseMask));
}

SmartScriptHolder SmartScript::CreateSmartEvent(SMART_EVENT e, uint32 event_flags, uint32 event_param1, uint32 event_param2, uint32 event_param3, uint32 event_param4, uint32 event_param5, uint32 event_param6, SMART_ACTION action, uint32 action_param1, uint32 action_param2, uint32 action_param3, uint32 action_param4, uint32 action_param5, uint32 action_param6, SMARTAI_TARGETS t, uint32 target_param1, uint32 target_param2, uint32 target_param3, uint32 target_param4, uint32 phaseMask)
{
    SmartScriptHolder script;
    script.event.type = e;
    script.event.raw.param1 = event_param1;
    script.event.raw.param2 = event_param2;
    script.event.raw.param3 = event_param3;
    script.event.raw.param4 = event_param4;
    script.event.raw.param5 = event_param5;
    script.event.raw.param6 = event_param6;
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

void SmartScript::GetTargets(ObjectVector& targets, SmartScriptHolder const& e, Unit* invoker /*= nullptr*/) const
{
    Unit* scriptTrigger = nullptr;
    if (invoker)
        scriptTrigger = invoker;
    else if (Unit* tempLastInvoker = GetLastInvoker())
        scriptTrigger = tempLastInvoker;

    WorldObject* baseObject = GetBaseObject();

    switch (e.GetTargetType())
    {
        case SMART_TARGET_SELF:
            if (baseObject)
                targets.push_back(baseObject);
            break;
        case SMART_TARGET_VICTIM:
            if (me)
                if (Unit* victim = me->GetVictim())
                    targets.push_back(victim);
            break;
        case SMART_TARGET_HOSTILE_SECOND_AGGRO:
            if (me)
            {
                if (e.target.hostileRandom.powerType)
                {
                    if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MaxThreat, 1, PowerUsersSelector(me, Powers(e.target.hostileRandom.powerType - 1), (float)e.target.hostileRandom.maxDist, e.target.hostileRandom.playerOnly)))
                        targets.push_back(u);
                }
                else if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MaxThreat, 1, (float)e.target.hostileRandom.maxDist, e.target.hostileRandom.playerOnly, true, -e.target.hostileRandom.aura))
                    targets.push_back(u);
            }
            break;
        case SMART_TARGET_HOSTILE_LAST_AGGRO:
            if (me)
            {
                if (e.target.hostileRandom.powerType)
                {
                    if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MinThreat, 0, PowerUsersSelector(me, Powers(e.target.hostileRandom.powerType - 1), (float)e.target.hostileRandom.maxDist, e.target.hostileRandom.playerOnly)))
                        targets.push_back(u);
                }
                else if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MinThreat, 0, (float)e.target.hostileRandom.maxDist, e.target.hostileRandom.playerOnly, true, -e.target.hostileRandom.aura))
                    targets.push_back(u);
            }
            break;
        case SMART_TARGET_HOSTILE_RANDOM:
            if (me)
            {
                if (e.target.hostileRandom.powerType)
                {
                    if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, Powers(e.target.hostileRandom.powerType - 1), (float)e.target.hostileRandom.maxDist, e.target.hostileRandom.playerOnly)))
                        targets.push_back(u);
                }
                else if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::Random, 0, (float)e.target.hostileRandom.maxDist, e.target.hostileRandom.playerOnly, true, -e.target.hostileRandom.aura))
                    targets.push_back(u);
            }
            break;
        case SMART_TARGET_HOSTILE_RANDOM_NOT_TOP:
            if (me)
            {
                if (e.target.hostileRandom.powerType)
                {
                    if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::Random, 1, PowerUsersSelector(me, Powers(e.target.hostileRandom.powerType - 1), (float)e.target.hostileRandom.maxDist, e.target.hostileRandom.playerOnly)))
                        targets.push_back(u);
                }
                else if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::Random, 1, (float)e.target.hostileRandom.maxDist, e.target.hostileRandom.playerOnly, true, -e.target.hostileRandom.aura))
                    targets.push_back(u);
            }
            break;
        case SMART_TARGET_FARTHEST:
            if (me)
            {
                if (Unit* u = me->AI()->SelectTarget(SelectTargetMethod::MinDistance, 0, FarthestTargetSelector(me, e.target.farthest.maxDist, e.target.farthest.playerOnly, e.target.farthest.isInLos, e.target.farthest.minDist)))
                    targets.push_back(u);
            }
            break;
        case SMART_TARGET_ACTION_INVOKER:
            if (scriptTrigger)
                targets.push_back(scriptTrigger);
            break;
        case SMART_TARGET_ACTION_INVOKER_VEHICLE:
            if (scriptTrigger && scriptTrigger->GetVehicle() && scriptTrigger->GetVehicle()->GetBase())
                targets.push_back(scriptTrigger->GetVehicle()->GetBase());
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
                                    targets.push_back(member);
                    }
                    // We still add the player to the list if there is no group. If we do
                    // this even if there is a group (thus the else-check), it will add the
                    // same player to the list twice. We don't want that to happen.
                    else
                        targets.push_back(scriptTrigger);
                }
            }
            break;
        case SMART_TARGET_CREATURE_RANGE:
        {
            WorldObject* ref = baseObject;
            if (!ref)
                ref = scriptTrigger;

            if (!ref)
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_CREATURE_RANGE: Entry {} SourceType {} Event {} Action {} Target {} is missing base object or invoker",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                break;
            }

            ObjectVector units;
            GetWorldObjectsInDist(units, static_cast<float>(e.target.unitRange.maxDist));

            for (WorldObject* unit : units)
            {
                if (!IsCreature(unit))
                    continue;

                if (me && me->GetGUID() == unit->GetGUID())
                    continue;

                // check alive state - 1 alive, 2 dead, 0 both
                if (uint32 state = e.target.unitRange.livingState)
                {
                    if (unit->ToCreature()->IsAlive() && state == 2)
                        continue;
                    if (!unit->ToCreature()->IsAlive() && state == 1)
                        continue;
                }

                if (((e.target.unitRange.creature && unit->ToCreature()->GetEntry() == e.target.unitRange.creature) || !e.target.unitRange.creature) && ref->IsInRange(unit, (float)e.target.unitRange.minDist, (float)e.target.unitRange.maxDist))
                    targets.push_back(unit);
            }

            break;
        }
        case SMART_TARGET_CREATURE_DISTANCE:
        {
            ObjectVector units;
            GetWorldObjectsInDist(units, static_cast<float>(e.target.unitDistance.dist));

            for (WorldObject* unit : units)
            {
                if (!IsCreature(unit))
                    continue;

                if (me && me->GetGUID() == unit->GetGUID())
                    continue;

                // check alive state - 1 alive, 2 dead, 0 both
                if (uint32 state = e.target.unitDistance.livingState)
                {
                    if (unit->ToCreature()->IsAlive() && state == 2)
                        continue;
                    if (!unit->ToCreature()->IsAlive() && state == 1)
                        continue;
                }

                if ((e.target.unitDistance.creature && unit->ToCreature()->GetEntry() == e.target.unitDistance.creature) || !e.target.unitDistance.creature)
                    targets.push_back(unit);
            }

            break;
        }
        case SMART_TARGET_GAMEOBJECT_DISTANCE:
        {
            ObjectVector units;
            GetWorldObjectsInDist(units, static_cast<float>(e.target.goDistance.dist));

            for (WorldObject* unit : units)
            {
                if (!IsGameObject(unit))
                    continue;

                if (go && go->GetGUID() == unit->GetGUID())
                    continue;

                if ((e.target.goDistance.entry && unit->ToGameObject()->GetEntry() == e.target.goDistance.entry) || !e.target.goDistance.entry)
                    targets.push_back(unit);
            }

            break;
        }
        case SMART_TARGET_GAMEOBJECT_RANGE:
        {

            WorldObject* ref = baseObject;
            if (!ref)
                ref = scriptTrigger;

            if (!ref)
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_GAMEOBJECT_RANGE: Entry: {} SourceType {} Event {} Action {} Target {} is missing base object or invoker.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                break;
            }

            ObjectVector units;
            GetWorldObjectsInDist(units, static_cast<float>(e.target.goRange.maxDist));

            for (WorldObject* unit : units)
            {
                if (!IsGameObject(unit))
                    continue;

                if (go && go->GetGUID() == unit->GetGUID())
                    continue;

                if (((e.target.goRange.entry && IsGameObject(unit) && unit->ToGameObject()->GetEntry() == e.target.goRange.entry) || !e.target.goRange.entry) && ref->IsInRange((unit), (float)e.target.goRange.minDist, (float)e.target.goRange.maxDist))
                    targets.push_back(unit);
            }

            break;
        }
        case SMART_TARGET_CREATURE_GUID:
        {
            if (!scriptTrigger && !baseObject)
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_CREATURE_GUID: Entry {} SourceType {} Event {} Action {} Target {} is missing base object or invoker.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                break;
            }

            Creature* target = FindCreatureNear(scriptTrigger ? scriptTrigger : GetBaseObject(), e.target.unitGUID.dbGuid);
            if (target && (!e.target.unitGUID.entry || target->GetEntry() == e.target.unitGUID.entry))
                targets.push_back(target);
            break;
        }
        case SMART_TARGET_GAMEOBJECT_GUID:
        {
            if (!scriptTrigger && !GetBaseObject())
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_GAMEOBJECT_GUID: Entry {} SourceType {} Event {} Action {} Target {} is missing base object or invoker.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                break;
            }

            GameObject* target = FindGameObjectNear(scriptTrigger ? scriptTrigger : GetBaseObject(), e.target.goGUID.dbGuid);
            if (target && (!e.target.goGUID.entry || target->GetEntry() == e.target.goGUID.entry))
                targets.push_back(target);
            break;
        }
        case SMART_TARGET_PLAYER_RANGE:
        {
            ObjectVector units;
            GetWorldObjectsInDist(units, static_cast<float>(e.target.playerRange.maxDist));

            if (!units.empty() && baseObject)
                for (WorldObject* unit : units)
                    if (IsPlayer(unit) && baseObject->IsInRange(unit, float(e.target.playerRange.minDist), float(e.target.playerRange.maxDist)))
                        targets.push_back(unit);
            if (e.target.playerRange.maxCount)
                Acore::Containers::RandomResize(targets, e.target.playerRange.maxCount);
            break;
        }
        case SMART_TARGET_PLAYER_DISTANCE:
        {
            ObjectVector units;
            GetWorldObjectsInDist(units, static_cast<float>(e.target.playerDistance.dist));

            for (WorldObject* unit : units)
                if (IsPlayer(unit))
                    targets.push_back(unit);
            break;
        }
        case SMART_TARGET_STORED:
        {
            WorldObject* ref = baseObject;
            if (!ref)
                ref = scriptTrigger;

            if (!ref)
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_STORED: Entry {} SourceType {} Event {} Action {} Target {} is missing base object or invoker.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                break;
            }

            if (ObjectVector const* stored = GetStoredTargetVector(e.target.stored.id, *ref))
                targets.assign(stored->begin(), stored->end());
            break;
        }
        case SMART_TARGET_CLOSEST_CREATURE:
        {
            WorldObject* ref = baseObject;

            if (!ref)
                ref = scriptTrigger;

            if (!ref)
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_CLOSEST_CREATURE: Entry {} SourceType {} Event {} Action {} Target {} is missing base object or invoker.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                break;
            }

            Creature* target = GetClosestCreatureWithEntry(ref, e.target.unitClosest.entry, (float)(e.target.unitClosest.dist ? e.target.unitClosest.dist : 100), !e.target.unitClosest.dead);
            if (target)
                targets.push_back(target);
            break;
        }
        case SMART_TARGET_CLOSEST_GAMEOBJECT:
        {
            WorldObject* ref = baseObject;

            if (!ref)
                ref = scriptTrigger;

            if (!ref)
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_CLOSEST_GAMEOBJECT: Entry {} SourceType {} Event {} Action {} Target {} is missing base object or invoker.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                break;
            }

            GameObject* target = GetClosestGameObjectWithEntry(ref, e.target.goClosest.entry, (float)(e.target.goClosest.dist ? e.target.goClosest.dist : 100), e.target.goClosest.onlySpawned);
            if (target)
                targets.push_back(target);
            break;
        }
        case SMART_TARGET_CLOSEST_PLAYER:
        {
            WorldObject* ref = baseObject;

            if (!ref)
                ref = scriptTrigger;

            if (!ref)
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_CLOSEST_PLAYER: Entry {} SourceType {} Event {} Action {} Target {} is missing base object or invoker.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                break;
            }

            if (Player* target = ref->SelectNearestPlayer((float)e.target.playerDistance.dist))
                targets.push_back(target);
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
                    targets.push_back(owner);
                }
                else if (me->IsSummon() && me->ToTempSummon()->GetSummonerUnit())
                {
                    targets.push_back(me->ToTempSummon()->GetSummonerUnit());
                }
            }
            else if (go)
            {
                if (WorldObject* owner = ObjectAccessor::GetWorldObject(*go, go->GetOwnerGUID()))
                {
                    targets.push_back(owner);
                }
            }

            // xinef: Get owner of owner
            if (e.target.owner.useCharmerOrOwner && !targets.empty())
            {
                if (WorldObject* owner = targets.front())
                {
                    targets.clear();

                    if (owner->ToCreature())
                    {
                        if (Unit* base = ObjectAccessor::GetUnit(*owner, owner->ToCreature()->GetCharmerOrOwnerGUID()))
                        {
                            targets.push_back(base);
                        }
                    }
                    else
                    {
                        if (Unit* base = ObjectAccessor::GetUnit(*owner, owner->ToGameObject()->GetOwnerGUID()))
                        {
                            targets.push_back(base);
                        }
                    }
                }
            }
            break;
        }
        case SMART_TARGET_THREAT_LIST:
        {
            if (me)
            {
                ThreatContainer::StorageType threatList = me->GetThreatMgr().GetThreatList();
                for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
                    if (Unit* temp = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                        // Xinef: added distance check
                        if (e.target.threatList.maxDist == 0 || me->IsWithinCombatRange(temp, (float)e.target.threatList.maxDist))
                            targets.push_back(temp);
            }
            break;
        }
        case SMART_TARGET_CLOSEST_ENEMY:
        {
            if (me)
                if (Unit* target = me->SelectNearestTarget(e.target.closestAttackable.maxDist, e.target.closestAttackable.playerOnly))
                    targets.push_back(target);

            break;
        }
        case SMART_TARGET_CLOSEST_FRIENDLY:
        {
            if (me)
                if (Unit* target = DoFindClosestFriendlyInRange(e.target.closestFriendly.maxDist, e.target.closestFriendly.playerOnly))
                    targets.push_back(target);

            break;
        }
        case SMART_TARGET_PLAYER_WITH_AURA:
        {
            ObjectVector units;
            GetWorldObjectsInDist(units, static_cast<float>(e.target.playerDistance.dist));

            for (WorldObject* unit : units)
                if (IsPlayer(unit) && unit->ToPlayer()->IsAlive() && !unit->ToPlayer()->IsGameMaster())
                    if (GetBaseObject()->IsInRange(unit, (float)e.target.playerWithAura.distMin, (float)e.target.playerWithAura.distMax))
                        if (bool(e.target.playerWithAura.negation) != unit->ToPlayer()->HasAura(e.target.playerWithAura.spellId))
                            targets.push_back(unit);

            if (e.target.o > 0)
                Acore::Containers::RandomResize(targets, e.target.o);

            break;
        }
        case SMART_TARGET_ROLE_SELECTION:
        {
            ObjectVector units;
            GetWorldObjectsInDist(units, static_cast<float>(e.target.playerDistance.dist));
            // 1 = Tanks, 2 = Healer, 4 = Damage
            uint32 roleMask = e.target.roleSelection.roleMask;
            for (WorldObject* unit : units)
                if (Player* targetPlayer = unit->ToPlayer())
                    if (targetPlayer->IsAlive() && !targetPlayer->IsGameMaster())
                    {
                        if (roleMask & SMART_TARGET_ROLE_FLAG_TANKS)
                        {
                            if (targetPlayer->HasTankSpec())
                            {
                                targets.push_back(unit);
                                continue;
                            }
                        }
                        if (roleMask & SMART_TARGET_ROLE_FLAG_HEALERS)
                        {
                            if (targetPlayer->HasHealSpec())
                            {
                                targets.push_back(unit);
                                continue;
                            }
                        }
                        if (roleMask & SMART_TARGET_ROLE_FLAG_DAMAGERS)
                        {
                            if (targetPlayer->HasCasterSpec() || targetPlayer->HasMeleeSpec())
                            {
                                targets.push_back(unit);
                                continue;
                            }
                        }
                    }

            if (e.target.roleSelection.resize > 0)
                Acore::Containers::RandomResize(targets, e.target.roleSelection.resize);

            break;
        }
        case SMART_TARGET_VEHICLE_PASSENGER:
        {
            if (me && me->IsVehicle())
            {
                if (Unit* target = me->GetVehicleKit()->GetPassenger(e.target.vehicle.seatMask))
                {
                    targets.push_back(target);
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
                            targets.push_back(recipient);
                        }
                    }
                }
                else
                {
                    if (Player* recipient = me->GetLootRecipient())
                    {
                        targets.push_back(recipient);
                    }
                }
            }
            break;
        }
        case SMART_TARGET_SUMMONED_CREATURES:
        {
            if (me)
            {
                for (ObjectGuid const& guid : _summonList)
                {
                    if (!e.target.summonedCreatures.entry || guid.GetEntry() == e.target.summonedCreatures.entry)
                    {
                        if (Creature* creature = me->GetMap()->GetCreature(guid))
                        {
                            targets.push_back(creature);
                        }
                    }
                }
            }
            break;
        }
        case SMART_TARGET_INSTANCE_STORAGE:
        {
            if (InstanceScript* instance = GetBaseObject()->GetInstanceScript())
            {
                if (e.target.instanceStorage.type == 1)
                {
                    if (Creature* creature = instance->GetCreature(e.target.instanceStorage.index))
                    {
                        targets.push_back(creature);
                    }
                }
                else if (e.target.instanceStorage.type == 2)
                {
                    if (GameObject* go = instance->GetGameObject(e.target.instanceStorage.index))
                    {
                        targets.push_back(go);
                    }
                }
            }
            else
            {
                LOG_ERROR("scripts.ai.sai", "SMART_TARGET_INSTANCE_STORAGE: Entry {} SourceType {} Event {} Action {} Target {} called outside an instance map.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
            }

            break;
        }
        case SMART_TARGET_NONE:
        case SMART_TARGET_POSITION:
        default:
            break;
    }
}

void SmartScript::GetWorldObjectsInDist(ObjectVector& targets, float dist) const
{
    WorldObject* obj = GetBaseObject();
    if (!obj)
        return;

    Acore::AllWorldObjectsInRange u_check(obj, dist);
    Acore::WorldObjectListSearcher<Acore::AllWorldObjectsInRange> searcher(obj, targets, u_check);
    Cell::VisitAllObjects(obj, searcher, dist);
}

void SmartScript::ProcessEvent(SmartScriptHolder& e, Unit* unit, uint32 var0, uint32 var1, bool bvar, SpellInfo const* spell, GameObject* gob)
{
    if (!e.active && e.GetEventType() != SMART_EVENT_LINK)
        return;

    if ((e.event.event_phase_mask && !IsInPhase(e.event.event_phase_mask)) || ((e.event.event_flags & SMART_EVENT_FLAG_NOT_REPEATABLE) && e.runOnce))
        return;

    if (!(e.event.event_flags & SMART_EVENT_FLAG_WHILE_CHARMED) && IsCharmedCreature(me))
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
            if (me && me->IsEngaged())
                return;
            ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
            break;
        case SMART_EVENT_UPDATE_IC:
            if (!me || !me->IsEngaged())
                return;
            ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
            break;
        case SMART_EVENT_HEALTH_PCT:
            {
                if (!me || !me->IsEngaged() || !me->GetMaxHealth())
                    return;
                uint32 perc = (uint32)me->GetHealthPct();
                if (perc > e.event.minMaxRepeat.max || perc < e.event.minMaxRepeat.min)
                    return;
                ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
                break;
            }
        case SMART_EVENT_TARGET_HEALTH_PCT:
            {
                if (!me || !me->IsEngaged() || !me->GetVictim() || !me->GetVictim()->GetMaxHealth())
                    return;
                uint32 perc = (uint32)me->GetVictim()->GetHealthPct();
                if (perc > e.event.minMaxRepeat.max || perc < e.event.minMaxRepeat.min)
                    return;
                ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax, me->GetVictim());
                break;
            }
        case SMART_EVENT_MANA_PCT:
            {
                if (!me || !me->IsEngaged() || !me->GetMaxPower(POWER_MANA))
                    return;
                uint32 perc = uint32(me->GetPowerPct(POWER_MANA));
                if (perc > e.event.minMaxRepeat.max || perc < e.event.minMaxRepeat.min)
                    return;
                ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
                break;
            }
        case SMART_EVENT_TARGET_MANA_PCT:
            {
                if (!me || !me->IsEngaged() || !me->GetVictim() || !me->GetVictim()->GetMaxPower(POWER_MANA))
                    return;
                uint32 perc = uint32(me->GetVictim()->GetPowerPct(POWER_MANA));
                if (perc > e.event.minMaxRepeat.max || perc < e.event.minMaxRepeat.min)
                    return;
                ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax, me->GetVictim());
                break;
            }
        case SMART_EVENT_RANGE:
            {
                if (!me || !me->IsEngaged() || !me->GetVictim())
                    return;

                if (me->IsInRange(me->GetVictim(), (float)e.event.minMaxRepeat.rangeMin, (float)e.event.minMaxRepeat.rangeMax))
                    ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax, me->GetVictim());
                else
                    RecalcTimer(e, 1200, 1200); // make it predictable

                break;
            }
        case SMART_EVENT_VICTIM_CASTING:
            {
                if (!me || !me->IsEngaged())
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
                if (!me || !me->IsEngaged())
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
                if (!me || !me->IsEngaged())
                    return;

                std::vector<Creature*> creatures;
                DoFindFriendlyCC(creatures, float(e.event.friendlyCC.radius));
                if (creatures.empty())
                {
                    // Xinef: if there are at least two same npcs, they will perform the same action immediately even if this is useless...
                    RecalcTimer(e, 1000, 3000);
                    return;
                }
                ProcessTimedAction(e, e.event.friendlyCC.repeatMin, e.event.friendlyCC.repeatMax, Acore::Containers::SelectRandomContainerElement(creatures));
                break;
            }
        case SMART_EVENT_FRIENDLY_MISSING_BUFF:
        {
            if (e.event.missingBuff.onlyInCombat && !me->IsEngaged())
            {
                return;
            }

            std::vector<Creature*> creatures;
            DoFindFriendlyMissingBuff(creatures, float(e.event.missingBuff.radius), e.event.missingBuff.spell);

            if (creatures.empty())
                return;

            ProcessTimedAction(e, e.event.missingBuff.repeatMin, e.event.missingBuff.repeatMax, Acore::Containers::SelectRandomContainerElement(creatures));
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
        case SMART_EVENT_CHARMED:
            {
                if (bvar == (e.event.charm.onRemove != 1))
                    ProcessAction(e, unit, var0, var1, bvar, spell, gob);
                break;
            }
        //no params
        case SMART_EVENT_AGGRO:
        case SMART_EVENT_DEATH:
        case SMART_EVENT_EVADE:
        case SMART_EVENT_REACHED_HOME:
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
                    if (e.event.minMaxRepeat.rangeMax && (me->IsInRange(victim, (float)e.event.minMaxRepeat.rangeMin, (float)e.event.minMaxRepeat.rangeMax)))
                        if (!victim->HasInArc(static_cast<float>(M_PI), me))
                            ProcessTimedAction(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax, victim);
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
                if (!me || me->IsEngaged())
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
                if (!me || !me->IsEngaged())
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
        case SMART_EVENT_SUMMONED_UNIT_EVADE:
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
        case SMART_EVENT_EVENT_PHASE_CHANGE:
            {
                if (!IsInPhase(e.event.eventPhaseChange.phasemask))
                {
                    return;
                }

                ProcessAction(e, GetLastInvoker());
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
                if (!me || !me->IsEngaged())
                    return;

                Unit* unitTarget = nullptr;
                switch (e.GetTargetType())
                {
                    case SMART_TARGET_CREATURE_RANGE:
                    case SMART_TARGET_CREATURE_GUID:
                    case SMART_TARGET_CREATURE_DISTANCE:
                    case SMART_TARGET_CLOSEST_CREATURE:
                    case SMART_TARGET_CLOSEST_PLAYER:
                    case SMART_TARGET_PLAYER_RANGE:
                    case SMART_TARGET_PLAYER_DISTANCE:
                    {
                        ObjectVector targets;
                        GetTargets(targets, e);
                        for (WorldObject* target : targets)
                        {
                            if (IsUnit(target) && me->IsFriendlyTo(target->ToUnit()) && target->ToUnit()->IsAlive() && target->ToUnit()->IsInCombat())
                            {
                                uint32 healthPct = uint32(target->ToUnit()->GetHealthPct());
                                if (healthPct > e.event.friendlyHealthPct.hpPct)
                                {
                                    continue;
                                }

                                unitTarget = target->ToUnit();
                                break;
                            }
                        }

                        break;
                    }
                    case SMART_TARGET_SELF:
                    case SMART_TARGET_ACTION_INVOKER:
                        unitTarget = DoSelectLowestHpPercentFriendly((float)e.event.friendlyHealthPct.radius, 0, e.event.friendlyHealthPct.hpPct);
                        break;
                    default:
                        return;
                }

                if (!unitTarget)
                    return;

                ProcessTimedAction(e, e.event.friendlyHealthPct.repeatMin, e.event.friendlyHealthPct.repeatMax, unitTarget);
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
            uint32 playerCount = 0;
            ObjectVector targets;
            GetWorldObjectsInDist(targets, static_cast<float>(e.event.nearPlayer.radius));

            if (!targets.empty())
            {
                for (WorldObject* target : targets)
                {
                    if (IsPlayer(target))
                        playerCount++;
                }
                    if (playerCount >= e.event.nearPlayer.minCount)
                        ProcessAction(e, unit);
            }
            RecalcTimer(e, e.event.nearPlayer.repeatMin, e.event.nearPlayer.repeatMax);
            break;
        }
        case SMART_EVENT_NEAR_PLAYERS_NEGATION:
        {
            uint32 playerCount = 0;
            ObjectVector targets;
            GetWorldObjectsInDist(targets, static_cast<float>(e.event.nearPlayerNegation.radius));

            if (!targets.empty())
            {
                for (WorldObject* target : targets)
                {
                    if (IsPlayer(target))
                        playerCount++;
                }

                if (playerCount < e.event.nearPlayerNegation.maxCount)
                    ProcessAction(e, unit);
            }
            RecalcTimer(e, e.event.nearPlayerNegation.repeatMin, e.event.nearPlayerNegation.repeatMax);
            break;
        }
        case SMART_EVENT_NEAR_UNIT:
        {
            uint32 unitCount = 0;
            ObjectVector targets;
            GetWorldObjectsInDist(targets, static_cast<float>(e.event.nearUnit.range));

            if (!targets.empty())
            {
                if (e.event.nearUnit.type)
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsGameObject(target) && target->GetEntry() == e.event.nearUnit.entry)
                            unitCount++;
                    }
                }
                else
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsCreature(target) && target->GetEntry() == e.event.nearUnit.entry)
                            unitCount++;
                    }
                }

                if (unitCount >= e.event.nearUnit.count)
                    ProcessAction(e, unit);
            }
            RecalcTimer(e, e.event.nearUnit.timer, e.event.nearUnit.timer);
            break;
        }
        case SMART_EVENT_NEAR_UNIT_NEGATION:
        {
            uint32 unitCount = 0;
            ObjectVector targets;
            GetWorldObjectsInDist(targets, static_cast<float>(e.event.nearUnitNegation.range));

            if (!targets.empty())
            {
                if (e.event.nearUnitNegation.type)
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsGameObject(target) && target->GetEntry() == e.event.nearUnitNegation.entry)
                            unitCount++;
                    }
                }
                else
                {
                    for (WorldObject* target : targets)
                    {
                        if (IsCreature(target) && target->GetEntry() == e.event.nearUnitNegation.entry)
                            unitCount++;
                    }
                }

                if (unitCount < e.event.nearUnitNegation.count)
                    ProcessAction(e, unit);
            }
            RecalcTimer(e, e.event.nearUnitNegation.timer, e.event.nearUnitNegation.timer);
            break;
        }
        case SMART_EVENT_AREA_CASTING:
        {
            if (!me || !me->IsEngaged())
                return;

            ThreatContainer::StorageType threatList = me->GetThreatMgr().GetThreatList();
            for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
            {
                if (Unit* target = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                {
                    if (!target || !IsPlayer(target) || !target->IsNonMeleeSpellCast(false, false, true))
                        continue;

                    if (!(me->IsInRange(target, (float)e.event.minMaxRepeat.rangeMin, (float)e.event.minMaxRepeat.rangeMax)))
                        continue;

                    ProcessAction(e, target);
                    RecalcTimer(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
                    return;
                }

                // If no targets are found and it's off cooldown, check again in 1200ms
                RecalcTimer(e, 1200, 1200);
                break;
            }

            break;
        }
        case SMART_EVENT_AREA_RANGE:
        {
            if (!me || !me->IsEngaged())
                return;

            ThreatContainer::StorageType threatList = me->GetThreatMgr().GetThreatList();
            for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
            {
                if (Unit* target = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                {
                    if (!(me->IsInRange(target, (float)e.event.minMaxRepeat.rangeMin, (float)e.event.minMaxRepeat.rangeMax)))
                        continue;

                    ProcessAction(e, target);
                    RecalcTimer(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax);
                    return;
                }
            }

            // If no targets are found and it's off cooldown, check again
            RecalcTimer(e, 1200, 1200);
            break;
        }
        case SMART_EVENT_WAYPOINT_DATA_REACHED:
        case SMART_EVENT_WAYPOINT_DATA_ENDED:
        {
            if (!me || (e.event.wpData.pointId && var0 != e.event.wpData.pointId) || (e.event.wpData.pathId && me->GetWaypointPath() != e.event.wpData.pathId))
                return;
            ProcessAction(e, unit);
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
        case SMART_EVENT_RANGE:
        case SMART_EVENT_AREA_RANGE:
        case SMART_EVENT_AREA_CASTING:
        case SMART_EVENT_IS_BEHIND_TARGET:
        case SMART_EVENT_FRIENDLY_HEALTH_PCT:
            RecalcTimer(e, e.event.minMaxRepeat.min, e.event.minMaxRepeat.max);
            break;
        case SMART_EVENT_DISTANCE_CREATURE:
        case SMART_EVENT_DISTANCE_GAMEOBJECT:
            RecalcTimer(e, e.event.distance.repeat, e.event.distance.repeat);
            break;
        case SMART_EVENT_NEAR_UNIT:
        case SMART_EVENT_NEAR_UNIT_NEGATION:
            RecalcTimer(e, e.event.nearUnit.timer, e.event.nearUnit.timer);
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

    if (e.GetEventType() == SMART_EVENT_UPDATE_IC && (!me || !me->IsEngaged()))
        return;

    if (e.GetEventType() == SMART_EVENT_UPDATE_OOC && (me && me->IsEngaged()))//can be used with me=nullptr (go script)
        return;

    if (e.timer < diff)
    {
        // delay spell cast for another AI tick if another spell is being cast
        if (e.GetActionType() == SMART_ACTION_CAST)
        {
            if (!(e.action.cast.castFlags & SMARTCAST_INTERRUPT_PREVIOUS))
            {
                if (me && me->HasUnitState(UNIT_STATE_CASTING))
                {
                    RaisePriority(e);
                    return;
                }
            }
        }

        // Delay flee for assist event if casting
        if (e.GetActionType() == SMART_ACTION_FLEE_FOR_ASSIST && me && me->HasUnitState(UNIT_STATE_CASTING))
        {
            e.timer = 1200;
            return;
        } // @TODO: Can't these be handled by the action themselves instead? Less expensive

        e.active = true;//activate events with cooldown
        switch (e.GetEventType())//process ONLY timed events
        {
            case SMART_EVENT_NEAR_PLAYERS:
            case SMART_EVENT_NEAR_PLAYERS_NEGATION:
            case SMART_EVENT_NEAR_UNIT:
            case SMART_EVENT_NEAR_UNIT_NEGATION:
            case SMART_EVENT_UPDATE:
            case SMART_EVENT_UPDATE_OOC:
            case SMART_EVENT_UPDATE_IC:
            case SMART_EVENT_HEALTH_PCT:
            case SMART_EVENT_TARGET_HEALTH_PCT:
            case SMART_EVENT_MANA_PCT:
            case SMART_EVENT_TARGET_MANA_PCT:
            case SMART_EVENT_RANGE:
            case SMART_EVENT_AREA_RANGE:
            case SMART_EVENT_VICTIM_CASTING:
            case SMART_EVENT_AREA_CASTING:
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

        if (e.priority != SmartScriptHolder::DEFAULT_PRIORITY)
        {
            // Reset priority to default one only if the event hasn't been rescheduled again to next loop
            if (e.timer > 1)
            {
                // Re-sort events if this was moved to the top of the queue
                mEventSortingRequired = true;
                // Reset priority to default one
                e.priority = SmartScriptHolder::DEFAULT_PRIORITY;
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

    if (mEventSortingRequired)
    {
        SortEvents(mEvents);
        mEventSortingRequired = false;
    }

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

void SmartScript::SortEvents(SmartAIEventList& events)
{
    std::sort(events.begin(), events.end());
}

void SmartScript::RaisePriority(SmartScriptHolder& e)
{
    e.timer = 1200;
    // Change priority only if it's set to default, otherwise keep the current order of events
    if (e.priority == SmartScriptHolder::DEFAULT_PRIORITY)
    {
        e.priority = mCurrentPriority++;
        mEventSortingRequired = true;
    }
}

void SmartScript::RetryLater(SmartScriptHolder& e, bool ignoreChanceRoll)
{
    RaisePriority(e);

    // This allows to retry the action later without rolling again the chance roll (which might fail and end up not executing the action)
    if (ignoreChanceRoll)
        e.event.event_flags |= SMART_EVENT_FLAG_TEMP_IGNORE_CHANCE_ROLL;

    e.runOnce = false;
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

        if (CreatureTemplate const* cInfo = me->GetCreatureTemplate())
        {
            if (cInfo->HasFlagsExtra(CREATURE_FLAG_DONT_OVERRIDE_ENTRY_SAI))
            {
                e = sSmartScriptMgr->GetScript((int32)me->GetEntry(), mScriptType);
                FillScript(e, me, nullptr);
            }
        }
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

    for (SmartScriptHolder& event : mEvents)
        InitTimer(event);//calculate timers for first time use

    ProcessEventsFor(SMART_EVENT_AI_INIT);
    InstallEvents();
    ProcessEventsFor(SMART_EVENT_JUST_CREATED);
}

void SmartScript::OnMoveInLineOfSight(Unit* who)
{
    if (!me)
        return;

    ProcessEventsFor(me->IsEngaged() ? SMART_EVENT_IC_LOS : SMART_EVENT_OOC_LOS, who);
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

Unit* SmartScript::DoSelectLowestHpFriendly(float range, uint32 MinHPDiff) const
{
    if (!me)
        return nullptr;

    Unit* unit = nullptr;

    Acore::MostHPMissingInRange u_check(me, range, MinHPDiff);
    Acore::UnitLastSearcher<Acore::MostHPMissingInRange> searcher(me, unit, u_check);
    Cell::VisitGridObjects(me, searcher, range);
    return unit;
}

Unit* SmartScript::DoSelectLowestHpPercentFriendly(float range, uint32 minHpPct, uint32 maxHpPct) const
{
    if (!me)
    {
        return nullptr;
    }

    Unit* unit = nullptr;
    Acore::MostHPPercentMissingInRange u_check(me, range, minHpPct, maxHpPct);
    Acore::UnitLastSearcher<Acore::MostHPPercentMissingInRange> searcher(me, unit, u_check);
    Cell::VisitGridObjects(me, searcher, range);
    return unit;
}

void SmartScript::DoFindFriendlyCC(std::vector<Creature*>& creatures, float range) const
{
    if (!me)
        return;

    Acore::FriendlyCCedInRange u_check(me, range);
    Acore::CreatureListSearcher<Acore::FriendlyCCedInRange> searcher(me, creatures, u_check);
    Cell::VisitGridObjects(me, searcher, range);
}

void SmartScript::DoFindFriendlyMissingBuff(std::vector<Creature*>& creatures, float range, uint32 spellid) const
{
    if (!me)
        return;

    Acore::FriendlyMissingBuffInRange u_check(me, range, spellid);
    Acore::CreatureListSearcher<Acore::FriendlyMissingBuffInRange> searcher(me, creatures, u_check);
    Cell::VisitGridObjects(me, searcher, range);
}

Unit* SmartScript::DoFindClosestFriendlyInRange(float range, bool playerOnly) const
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

    // Do NOT allow to start a new actionlist if a previous one is already running, unless explicitly allowed. We need to always finish the current actionlist
    if (!e.action.timedActionList.allowOverride && !mTimedActionList.empty())
    {
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

Unit* SmartScript::GetLastInvoker(Unit* invoker) const
{
    // Xinef: Look for invoker only on map of base object... Prevents multithreaded crashes
    if (GetBaseObject())
        return ObjectAccessor::GetUnit(*GetBaseObject(), mLastInvoker);
    // xinef: used for area triggers invoker cast
    else if (invoker)
        return ObjectAccessor::GetUnit(*invoker, mLastInvoker);
    return nullptr;
}

bool SmartScript::IsUnit(WorldObject* obj)
{
    return obj && (obj->GetTypeId() == TYPEID_UNIT || obj->GetTypeId() == TYPEID_PLAYER);
}

bool SmartScript::IsPlayer(WorldObject* obj)
{
    return obj && obj->GetTypeId() == TYPEID_PLAYER;
}

bool SmartScript::IsCreature(WorldObject* obj)
{
    return obj && obj->GetTypeId() == TYPEID_UNIT;
}

bool SmartScript::IsCharmedCreature(WorldObject* obj)
{
    if (!obj)
        return false;

    if (Creature* creatureObj = obj->ToCreature())
        return creatureObj->IsCharmed();

    return false;
}

bool SmartScript::IsGameObject(WorldObject* obj)
{
    return obj && obj->GetTypeId() == TYPEID_GAMEOBJECT;
}

void SmartScript::IncPhase(uint32 p)
{
    // protect phase from overflowing
    SetPhase(std::min<uint32>(SMART_EVENT_PHASE_12, mEventPhase + p));
}

void SmartScript::DecPhase(uint32 p)
{
    if (p >= mEventPhase)
    {
        SetPhase(0);
    }
    else
    {
        SetPhase(mEventPhase - p);
    }
}

void SmartScript::SetPhase(uint32 p)
{
    uint32 oldPhase = mEventPhase;

    mEventPhase = p;

    if (oldPhase != mEventPhase)
    {
        ProcessEventsFor(SMART_EVENT_EVENT_PHASE_CHANGE);
    }
}

bool SmartScript::IsInPhase(uint32 p) const
{
    if (mEventPhase == 0)
    {
        return false;
    }

    return ((1 << (mEventPhase - 1)) & p) != 0;
}

void SmartScript::AddCreatureSummon(ObjectGuid const& guid)
{
    _summonList.insert(guid);
}

void SmartScript::RemoveCreatureSummon(ObjectGuid const& guid)
{
    _summonList.erase(guid);
}
