/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "Chat.h"
#include "Cell.h"
#include "CellImpl.h"
#include "CreatureTextMgr.h"
#include "DatabaseEnv.h"
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
#include "SmartScript.h"
#include "SpellMgr.h"
#include "Vehicle.h"

class AcoreStringTextBuilder
{
public:
    AcoreStringTextBuilder(WorldObject* obj, ChatMsg msgtype, int32 id, uint32 language, WorldObject* target)
        : _source(obj), _msgType(msgtype), _textId(id), _language(language), _target(target)
    {
    }

    size_t operator()(WorldPacket* data, LocaleConstant locale) const
    {
        std::string text = sObjectMgr->GetAcoreString(_textId, locale);
        return ChatHandler::BuildChatPacket(*data, _msgType, Language(_language), _source, _target, text, 0, "", locale);
    }

    WorldObject* _source;
    ChatMsg _msgType;
    int32 _textId;
    uint32 _language;
    WorldObject* _target;
};

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
    meOrigGUID = 0;
    goOrigGUID = 0;
    mLastInvoker = 0;
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
    mLastInvoker = 0;
    mCounterList.clear();

    // Xinef: Fix Combat Movement
    RestoreMaxCombatDist();
    RestoreCasterMaxDist();
}

void SmartScript::ProcessEventsFor(SMART_EVENT e, Unit* unit, uint32 var0, uint32 var1, bool bvar, const SpellInfo* spell, GameObject* gob)
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

void SmartScript::ProcessAction(SmartScriptHolder& e, Unit* unit, uint32 var0, uint32 var1, bool bvar, const SpellInfo* spell, GameObject* gob)
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

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    if (Unit* tempInvoker = GetLastInvoker())
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: Invoker: %s (guidlow: %u)", tempInvoker->GetName().c_str(), tempInvoker->GetGUIDLow());
#endif

    switch (e.GetActionType())
    {
    case SMART_ACTION_TALK:
    {
        ObjectList* targets = GetTargets(e, unit);
        Creature* talker = e.target.type == 0 ? me : nullptr; // xinef: tc retardness fix
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
            sLog->outErrorDb("SmartScript::ProcessAction: SMART_ACTION_TALK: EntryOrGuid %d SourceType %u EventType %u TargetType %u using non-existent Text id %u for talker %u, ignored.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetTargetType(), e.action.talk.textGroupID,talker->GetEntry());
            break;
        }

        mTalkerEntry = talker->GetEntry();
        mLastTextID = e.action.talk.textGroupID;
        mTextTimer = e.action.talk.duration;
        mUseTextTimer = true;
        sCreatureTextMgr->SendChat(talker, uint8(e.action.talk.textGroupID), talkTarget);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_TALK: talker: %s (GuidLow: %u), textId: %u", talker->GetName().c_str(), talker->GetGUIDLow(), mLastTextID);
#endif
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
                    sCreatureTextMgr->SendChat((*itr)->ToCreature(), uint8(e.action.talk.textGroupID), IsPlayer(GetLastInvoker()) ? GetLastInvoker() : 0);
                else if (IsPlayer(*itr) && me)
                {
                    Unit* templastInvoker = GetLastInvoker();
                    sCreatureTextMgr->SendChat(me, uint8(e.action.talk.textGroupID), IsPlayer(templastInvoker) ? templastInvoker : 0, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, (*itr)->ToPlayer());
                }
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SIMPLE_TALK: talker: %s (GuidLow: %u), textGroupId: %u",
                    (*itr)->GetName().c_str(), (*itr)->GetGUIDLow(), uint8(e.action.talk.textGroupID));
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_PLAY_EMOTE: target: %s (GuidLow: %u), emote: %u",
                        (*itr)->GetName().c_str(), (*itr)->GetGUIDLow(), e.action.emote.emote);
#endif
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
            for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
            {
                if (IsUnit(*itr))
                {
                    (*itr)->SendPlaySound(e.action.sound.sound, e.action.sound.onlySelf > 0);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SOUND: target: %s (GuidLow: %u), sound: %u, onlyself: %u",
                        (*itr)->GetName().c_str(), (*itr)->GetGUIDLow(), e.action.sound.sound, e.action.sound.onlySelf);
#endif
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

        for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
        {
            if (IsUnit(*itr))
            {
                uint32 sound = temp[urand(0, count - 1)];
                (*itr)->SendPlaySound(sound, e.action.randomSound.onlySelf > 0);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_SOUND: target: %s (GuidLow: %u), sound: %u, onlyself: %u",
                    (*itr)->GetName().c_str(), (*itr)->GetGUIDLow(), sound, e.action.randomSound.onlySelf);
#endif
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
                Map::PlayerList const &players = me->GetMap()->GetPlayers();
                targets = new ObjectList();

                if (!players.isEmpty())
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_MUSIC: target: %s (GuidLow: %u), sound: %u, onlySelf: %u, type: %u",
                        (*itr)->GetName().c_str(), (*itr)->GetGUIDLow(), e.action.music.sound, e.action.music.onlySelf, e.action.music.type);
#endif
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
                Map::PlayerList const &players = me->GetMap()->GetPlayers();
                targets = new ObjectList();

                if (!players.isEmpty())
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_MUSIC: target: %s (GuidLow: %u), sound: %u, onlyself: %u, type: %u",
                    (*itr)->GetName().c_str(), (*itr)->GetGUIDLow(), sound, e.action.randomMusic.onlySelf, e.action.randomMusic.type);
#endif
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
                        (*itr)->ToCreature()->setFaction(e.action.faction.factionID);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SET_FACTION: Creature entry %u, GuidLow %u set faction to %u",
                            (*itr)->GetEntry(), (*itr)->GetGUIDLow(), e.action.faction.factionID);
#endif
                    }
                    else
                    {
                        if (CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate((*itr)->ToCreature()->GetEntry()))
                        {
                            if ((*itr)->ToCreature()->getFaction() != ci->faction)
                            {
                                (*itr)->ToCreature()->setFaction(ci->faction);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SET_FACTION: Creature entry %u, GuidLow %u set faction to %u",
                                    (*itr)->GetEntry(), (*itr)->GetGUIDLow(), ci->faction);
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry %u, GuidLow %u set displayid to %u",
                            (*itr)->GetEntry(), (*itr)->GetGUIDLow(), displayId);
#endif
                    }
                }
                //if no param1, then use value from param2 (modelId)
                else
                {
                    (*itr)->ToCreature()->SetDisplayId(e.action.morphOrMount.model);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry %u, GuidLow %u set displayid to %u",
                        (*itr)->GetEntry(), (*itr)->GetGUIDLow(), e.action.morphOrMount.model);
#endif
                }
            }
            else
            {
                (*itr)->ToCreature()->DeMorph();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: Creature entry %u, GuidLow %u demorphs.",
                    (*itr)->GetEntry(), (*itr)->GetGUIDLow());
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_FAIL_QUEST: Player guidLow %u fails quest %u",
                    (*itr)->GetGUIDLow(), e.action.quest.quest);
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                                sLog->outDebug(
                                        LOG_FILTER_DATABASE_AI,
                                        "SmartScript::ProcessAction:: SMART_ACTION_OFFER_QUEST: Player guidLow %u - offering quest %u",
                                        (*itr)->GetGUIDLow(),
                                        e.action.questOffer.questID);
#endif
                            }
                    }
                    else
                    {
                        (*itr)->ToPlayer()->AddQuestAndCheckCompletion(q, nullptr);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                        sLog->outDebug(
                                LOG_FILTER_DATABASE_AI,
                                "SmartScript::ProcessAction:: SMART_ACTION_OFFER_QUEST: Player guidLow %u - quest %u added",
                                     (*itr)->GetGUIDLow(),
                                     e.action.questOffer.questID);
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_RANDOM_EMOTE: Creature guidLow %u handle random emote %u",
                    (*itr)->GetGUIDLow(), emote);
#endif
            }
        }

        delete targets;
        break;
    }
    case SMART_ACTION_THREAT_ALL_PCT:
    {
        if (!me)
            break;

        ThreatContainer::StorageType threatList = me->getThreatManager().getThreatList();
        for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
        {
            if (Unit* target = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
            {
                me->getThreatManager().modifyThreatPercent(target, e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_THREAT_ALL_PCT: Creature guidLow %u modify threat for unit %u, value %i",
                    me->GetGUIDLow(), target->GetGUIDLow(), e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
#endif
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
                me->getThreatManager().modifyThreatPercent((*itr)->ToUnit(), e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_THREAT_SINGLE_PCT: Creature guidLow %u modify threat for unit %u, value %i",
                    me->GetGUIDLow(), (*itr)->GetGUIDLow(), e.action.threatPCT.threatINC ? (int32)e.action.threatPCT.threatINC : -(int32)e.action.threatPCT.threatDEC);
#endif
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
                    player->GroupEventHappens(e.action.quest.quest, me);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS: Player guidLow %u credited quest %u",
                        (*itr)->GetGUIDLow(), e.action.quest.quest);
#endif
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
            acore::Containers::RandomResizeList(*targets, e.action.cast.targetsLimit);

        for (ObjectList::const_iterator itr = targets->begin(); itr != targets->end(); ++itr)
        {
            if (go)
            {
                // Xinef: may be NULL!
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

                    if ((spellInfo && (currentPower < spellInfo->CalcPowerCost(me, spellInfo->GetSchoolMask()))) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED))
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
            acore::Containers::RandomResizeList(*targets, e.action.cast.targetsLimit);

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
                (*itr)->ToUnit()->AddAura(e.action.cast.spell, (*itr)->ToUnit());
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_ADD_AURA: Adding aura %u to unit %u",
                    e.action.cast.spell, (*itr)->GetGUIDLow());
#endif
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
                // Activate
                // xinef: wtf is this shit?
                (*itr)->ToGameObject()->SetLootState(GO_READY);
                (*itr)->ToGameObject()->UseDoorOrButton(0, !!e.action.activateObject.alternative, unit);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_ACTIVATE_GOBJECT. Gameobject %u (entry: %u) activated",
                    (*itr)->GetGUIDLow(), (*itr)->GetEntry());
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_RESET_GOBJECT. Gameobject %u (entry: %u) reset",
                    (*itr)->GetGUIDLow(), (*itr)->GetEntry());
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SET_EMOTE_STATE. Unit %u set emotestate to %u",
                    (*itr)->GetGUIDLow(), e.action.emote.emote);
#endif
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
                    (*itr)->ToUnit()->SetFlag(UNIT_FIELD_FLAGS, e.action.unitFlag.flag);
                    //TC_LOG_DEBUG(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SET_UNIT_FLAG. Unit %u added flag %u to UNIT_FIELD_FLAGS",
                    //(*itr)->GetGUIDLow(), e.action.unitFlag.flag);
                }
                else
                {
                    (*itr)->ToUnit()->SetFlag(UNIT_FIELD_FLAGS_2, e.action.unitFlag.flag);
                    //TC_LOG_DEBUG(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SET_UNIT_FLAG. Unit %u added flag %u to UNIT_FIELD_FLAGS_2",
                    //(*itr)->GetGUIDLow(), e.action.unitFlag.flag);
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
                    (*itr)->ToUnit()->RemoveFlag(UNIT_FIELD_FLAGS, e.action.unitFlag.flag);
                    //TC_LOG_DEBUG(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_REMOVE_UNIT_FLAG. Unit %u removed flag %u to UNIT_FIELD_FLAGS",
                    //(*itr)->GetGUIDLow(), e.action.unitFlag.flag);
                }
                else
                {
                    (*itr)->ToUnit()->RemoveFlag(UNIT_FIELD_FLAGS_2, e.action.unitFlag.flag);
                    //TC_LOG_DEBUG(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_REMOVE_UNIT_FLAG. Unit %u removed flag %u to UNIT_FIELD_FLAGS_2",
                    //(*itr)->GetGUIDLow(), e.action.unitFlag.flag);
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_AUTO_ATTACK: Creature: %u bool on = %u",
            me->GetGUIDLow(), e.action.autoAttack.attack);
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_ALLOW_COMBAT_MOVEMENT: Creature %u bool on = %u",
            me->GetGUIDLow(), e.action.combatMove.move);
#endif
        break;
    }
    case SMART_ACTION_SET_EVENT_PHASE:
    {
        if (!GetBaseObject())
            break;

        SetPhase(e.action.setEventPhase.phase);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SET_EVENT_PHASE: Creature %u set event phase %u",
            GetBaseObject()->GetGUIDLow(), e.action.setEventPhase.phase);
#endif
        break;
    }
    case SMART_ACTION_INC_EVENT_PHASE:
    {
        if (!GetBaseObject())
            break;

        IncPhase(e.action.incEventPhase.inc);
        DecPhase(e.action.incEventPhase.dec);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_INC_EVENT_PHASE: Creature %u inc event phase by %u, "
            "decrease by %u", GetBaseObject()->GetGUIDLow(), e.action.incEventPhase.inc, e.action.incEventPhase.dec);
#endif
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
            AcoreStringTextBuilder builder(me, CHAT_MSG_MONSTER_EMOTE, LANG_FLEE, LANG_UNIVERSAL, nullptr);
            sCreatureTextMgr->SendChatPacket(me, builder, CHAT_MSG_MONSTER_EMOTE);
        }
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_FLEE_FOR_ASSIST: Creature %u DoFleeToGetAssistance", me->GetGUIDLow());
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_CALL_GROUPEVENTHAPPENS: Player %u, group credit for quest %u",
                    (*itr)->GetGUIDLow(), e.action.quest.quest);
#endif
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

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_REMOVEAURASFROMSPELL: Unit %u, spell %u",
                (*itr)->GetGUIDLow(), e.action.removeAura.spell);
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_FOLLOW: Creature %u following target %u",
                    me->GetGUIDLow(), (*itr)->GetGUIDLow());
#endif
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_RANDOM_PHASE: Creature %u sets event phase to %u",
            GetBaseObject()->GetGUIDLow(), phase);
#endif
        break;
    }
    case SMART_ACTION_RANDOM_PHASE_RANGE:
    {
        if (!GetBaseObject())
            break;

        uint32 phase = urand(e.action.randomPhaseRange.phaseMin, e.action.randomPhaseRange.phaseMax);
        SetPhase(phase);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_RANDOM_PHASE_RANGE: Creature %u sets event phase to %u",
            GetBaseObject()->GetGUIDLow(), phase);
#endif
        break;
    }
    case SMART_ACTION_CALL_KILLEDMONSTER:
    {
        if (trigger && IsPlayer(unit))
        {
            unit->ToPlayer()->RewardPlayerAndGroupAtEvent(e.action.killedMonster.creature, unit);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_CALL_KILLEDMONSTER: (trigger == true) Player %u, Killcredit: %u",
                unit->GetGUIDLow(), e.action.killedMonster.creature);
#endif
        }
        else if (e.target.type == SMART_TARGET_NONE || e.target.type == SMART_TARGET_SELF) // Loot recipient and his group members
        {
            if (!me)
                break;

            if (Player* player = me->GetLootRecipient())
            {
                player->RewardPlayerAndGroupAtEvent(e.action.killedMonster.creature, player);
                //TC_LOG_DEBUG(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_CALL_KILLEDMONSTER: Player %u, Killcredit: %u",
                //    player->GetGUIDLow(), e.action.killedMonster.creature);
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_CALL_KILLEDMONSTER: Player %u, Killcredit: %u",
                    (*itr)->GetGUIDLow(), e.action.killedMonster.creature);
#endif
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
            sLog->outErrorDb("SmartScript: Event %u attempt to set instance data without instance script. EntryOrGuid %d", e.GetEventType(), e.entryOrGuid);
            break;
        }

        instance->SetData(e.action.setInstanceData.field, e.action.setInstanceData.data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_SET_INST_DATA: Field: %u, data: %u",
            e.action.setInstanceData.field, e.action.setInstanceData.data);
#endif
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
            sLog->outErrorDb("SmartScript: Event %u attempt to set instance data without instance script. EntryOrGuid %d", e.GetEventType(), e.entryOrGuid);
            break;
        }

        ObjectList* targets = GetTargets(e, unit);
        if (!targets)
            break;

        instance->SetData64(e.action.setInstanceData64.field, targets->front()->GetGUID());
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_SET_INST_DATA64: Field: %u, data: %lu",
            e.action.setInstanceData64.field, targets->front()->GetGUID());
#endif
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
                (*itr)->ToCreature()->UpdateEntry(e.action.updateTemplate.creature, NULL, e.action.updateTemplate.updateLevel != 0);

        delete targets;
        break;
    }
    case SMART_ACTION_DIE:
    {
        if (me && !me->isDead())
        {
            Unit::Kill(me, me);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_DIE: Creature %u", me->GetGUIDLow());
#endif
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
            if (IsCreature(*itr))
            {
                (*itr)->ToCreature()->CallForHelp((float)e.action.callHelp.range);
                if (e.action.callHelp.withEmote)
                {
                    AcoreStringTextBuilder builder(*itr, CHAT_MSG_MONSTER_EMOTE, LANG_CALL_FOR_HELP, LANG_UNIVERSAL, nullptr);
                    sCreatureTextMgr->SendChatPacket(*itr, builder, CHAT_MSG_MONSTER_EMOTE);
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction: SMART_ACTION_SET_SHEATH: Creature %u, State: %u",
                me->GetGUIDLow(), e.action.setSheath.sheath);
#endif
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
            if (IsCreature(*itr))
                (*itr)->ToCreature()->DespawnOrUnsummon(e.action.forceDespawn.delay + 1);
            else if (IsGameObject(*itr))
                (*itr)->ToGameObject()->Delete();
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
        if (Unit* target = acore::Containers::SelectRandomContainerElement(*targets)->ToUnit())
            me->AI()->AttackStart(target);

        delete targets;
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
                    me->GetRandomPoint(me->GetPosition(), range, randomPoint);
                else
                    me->GetRandomPoint(srcPos, range, randomPoint);
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
                    if (e.action.summonCreature.attackInvoker == 2) // pussywizard: proper attackInvoker implementation, but not spoiling tc shitness
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
                        ai->GetScript()->StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset);
                    else
                        sLog->outError("SmartScript: Action target for SMART_ACTION_SET_COUNTER is not using SmartAI, skipping");
                }
                else if (IsGameObject(*itr))
                {
                    if (SmartGameObjectAI* ai = CAST_AI(SmartGameObjectAI, (*itr)->ToGameObject()->AI()))
                        ai->GetScript()->StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset);
                    else
                        sLog->outError("SmartScript: Action target for SMART_ACTION_SET_COUNTER is not using SmartGameObjectAI, skipping");
                }
            }

            delete targets;
        }
        else
            StoreCounter(e.action.setCounter.counterId, e.action.setCounter.value, e.action.setCounter.reset);

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
                Position randomPoint;
                Position srcPos = { e.target.x, e.target.y, e.target.z, e.target.o };
                me->GetRandomPoint(srcPos, range, randomPoint);
                me->GetMotionMaster()->MovePoint(
                    e.action.MoveToPos.pointId,
                    randomPoint.m_positionX,
                    randomPoint.m_positionY,
                    randomPoint.m_positionZ,
                    true,
                    true,
                    e.action.MoveToPos.controlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE
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
                target = acore::Containers::SelectRandomContainerElement(*targets);
                delete targets;
            }
        }

        if (!target)
        {
            G3D::Vector3 dest(e.target.x, e.target.y, e.target.z);
            if (e.action.MoveToPos.transport)
                if (TransportBase* trans = me->GetDirectTransport())
                    trans->CalculatePassengerPosition(dest.x, dest.y, dest.z);

            me->GetMotionMaster()->MovePoint(e.action.MoveToPos.pointId, dest.x, dest.y, dest.z, true, true, e.action.MoveToPos.controlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE);
        }
        else // Xinef: we can use dest.x, dest.y, dest.z to make offset
        {
            float x, y, z;
            target->GetPosition(x, y, z);
            if (e.action.MoveToPos.ContactDistance > 0)
                target->GetContactPoint(me, x, y, z, e.action.MoveToPos.ContactDistance);
            me->GetMotionMaster()->MovePoint(e.action.MoveToPos.pointId, x + e.target.x, y + e.target.y, z + e.target.z, e.action.MoveToPos.controlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE);
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
                target->GetMotionMaster()->MovePoint(e.action.MoveToPos.pointId, e.target.x, e.target.y, e.target.z, true, true, e.action.MoveToPos.controlled ? MOTION_SLOT_CONTROLLED : MOTION_SLOT_ACTIVE);
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
                        sLog->outError("SmartScript: SMART_ACTION_EQUIP uses non-existent equipment info id %u for creature %u", equipId, npc->GetEntry());
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
        ProcessEventsFor((SMART_EVENT)SMART_EVENT_TIMED_EVENT_TRIGGERED, NULL, e.action.timeEvent.id);

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
                    meOrigGUID = me ? me->GetGUID() : 0;
                if (!goOrigGUID)
                    goOrigGUID = go ? go->GetGUID() : 0;
                go = nullptr;
                me = (*itr)->ToCreature();
                break;
            }
            else if (IsGameObject(*itr))
            {
                if (!meOrigGUID)
                    meOrigGUID = me ? me->GetGUID() : 0;
                if (!goOrigGUID)
                    goOrigGUID = go ? go->GetGUID() : 0;
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
            sLog->outErrorDb("SmartScript: Entry %d SourceType %u Event %u Action %u is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
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
                (*itr)->ToUnit()->SetUInt32Value(UNIT_NPC_FLAGS, e.action.unitFlag.flag);

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
                (*itr)->ToUnit()->SetFlag(UNIT_NPC_FLAGS, e.action.unitFlag.flag);

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
                (*itr)->ToUnit()->RemoveFlag(UNIT_NPC_FLAGS, e.action.unitFlag.flag);

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
                //else
                //    TC_LOG_DEBUG(LOG_FILTER_DATABASE_AI, "Spell %u not casted because it has flag SMARTCAST_AURA_NOT_PRESENT and the target (Guid: " UI64FMTD " Entry: %u Type: %u) already has the aura", e.action.cast.spell, (*it)->GetGUID(), (*it)->GetEntry(), uint32((*it)->GetTypeId()));
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
            sLog->outErrorDb("SmartScript: Entry %d SourceType %u Event %u Action %u is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
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
        uint32 id = urand(e.action.randTimedActionList.entry1, e.action.randTimedActionList.entry2);
        if (e.GetTargetType() == SMART_TARGET_NONE)
        {
            sLog->outErrorDb("SmartScript: Entry %d SourceType %u Event %u Action %u is using TARGET_NONE(0) for Script9 target. Please correct target_type in database.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
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
                (*itr)->ToUnit()->SetUInt32Value(UNIT_DYNAMIC_FLAGS, e.action.unitFlag.flag);

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
                (*itr)->ToUnit()->SetFlag(UNIT_DYNAMIC_FLAGS, e.action.unitFlag.flag);

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
                (*itr)->ToUnit()->RemoveFlag(UNIT_DYNAMIC_FLAGS, e.action.unitFlag.flag);

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
                Position randomPoint;
                Position srcPos = { e.target.x, e.target.y, e.target.z, e.target.o };
                me->GetRandomPoint(srcPos, range, randomPoint);
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
            if (WorldObject* target = acore::Containers::SelectRandomContainerElement(*targets))
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
                    sLog->outErrorDb("SmartScript: Action target for SMART_ACTION_SEND_TARGET_TO_TARGET is not using SmartAI, skipping");
            }
            else if (IsGameObject(*itr))
            {
                if (SmartGameObjectAI* ai = CAST_AI(SmartGameObjectAI, (*itr)->ToGameObject()->AI()))
                    ai->GetScript()->StoreTargetList(new ObjectList(*storedTargets), e.action.sendTargetToTarget.id);   // store a copy of target list
                else
                    sLog->outErrorDb("SmartScript: Action target for SMART_ACTION_SEND_TARGET_TO_TARGET is not using SmartGameObjectAI, skipping");
            }
        }

        delete targets;
        break;
    }
    case SMART_ACTION_SEND_GOSSIP_MENU:
    {
        if (!GetBaseObject())
            break;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::ProcessAction:: SMART_ACTION_SEND_GOSSIP_MENU: gossipMenuId %d, gossipNpcTextId %d",
            e.action.sendGossipMenu.gossipMenuId, e.action.sendGossipMenu.gossipNpcTextId);
#endif
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
            sLog->outError("SmartScript::ProcessAction: At case SMART_ACTION_GAME_EVENT_STOP, inactive event (id: %u)", eventId);
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
            sLog->outError("SmartScript::ProcessAction: At case SMART_ACTION_GAME_EVENT_START, already activated event (id: %u)", eventId);
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
                me->AddThreat((*itr)->ToUnit(), (float)e.action.threatPCT.threatINC - (float)e.action.threatPCT.threatDEC);

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
        ProcessEventsFor((SMART_EVENT)SMART_EVENT_TIMED_EVENT_TRIGGERED, NULL, eventId);
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
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(e.action.castCustom.spell);
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
    default:
        sLog->outErrorDb("SmartScript::ProcessAction: Entry %d SourceType %u, Event %u, Unhandled Action type %u", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
        break;
    }

    if (e.link && e.link != e.event_id)
    {
        SmartScriptHolder linked = FindLinkedEvent(e.link);
        if (linked.GetActionType() && linked.GetEventType() == SMART_EVENT_LINK)
            ProcessEvent(linked, unit, var0, var1, bvar, spell, gob);
        else
            sLog->outErrorDb("SmartScript::ProcessAction: Entry %d SourceType %u, Event %u, Link Event %u not found or invalid, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.link);
    }
}

void SmartScript::ProcessTimedAction(SmartScriptHolder& e, uint32 const& min, uint32 const& max, Unit* unit, uint32 var0, uint32 var1, bool bvar, const SpellInfo* spell, GameObject* gob)
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
        sLog->outErrorDb("SmartScript::InstallTemplate: Entry %d SourceType %u AI Template can not be set more then once, skipped.", e.entryOrGuid, e.GetScriptType());
        return;
    }
    mTemplate = (SMARTAI_TEMPLATE)e.action.installTtemplate.id;
    switch ((SMARTAI_TEMPLATE)e.action.installTtemplate.id)
    {
    case SMARTAI_TEMPLATE_CASTER:
    {
        AddEvent(SMART_EVENT_UPDATE_IC, 0, 0, 0, e.action.installTtemplate.param2, e.action.installTtemplate.param3, 0, SMART_ACTION_CAST, e.action.installTtemplate.param1, e.target.raw.param1, 0, 0, 0, 0, SMART_TARGET_VICTIM, 0, 0, 0, 0, 1);
        AddEvent(SMART_EVENT_RANGE, 0, e.action.installTtemplate.param4, 300, 0, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
        AddEvent(SMART_EVENT_RANGE, 0, 0, e.action.installTtemplate.param4>10?e.action.installTtemplate.param4-10:0, 0, 0, 0, SMART_ACTION_ALLOW_COMBAT_MOVEMENT, 0, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 1);
        AddEvent(SMART_EVENT_MANA_PCT, 0, e.action.installTtemplate.param5-15>100?100:e.action.installTtemplate.param5+15, 100, 1000, 1000, 0, SMART_ACTION_SET_EVENT_PHASE, 1, 0, 0, 0, 0, 0, SMART_TARGET_NONE, 0, 0, 0, 0, 0);
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

ObjectList* SmartScript::GetTargets(SmartScriptHolder const& e, Unit* invoker /*= NULL*/)
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
                if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_TOPAGGRO, 1, PowerUsersSelector(me, Powers(e.target.hostilRandom.powerType - 1), (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly)))
                    l->push_back(u);
            }
            else if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_TOPAGGRO, 1, (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly))
                l->push_back(u);
        }
        break;
    case SMART_TARGET_HOSTILE_LAST_AGGRO:
        if (me)
        {
            if (e.target.hostilRandom.powerType)
            {
                if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_BOTTOMAGGRO, 0, PowerUsersSelector(me, Powers(e.target.hostilRandom.powerType - 1), (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly)))
                    l->push_back(u);
            }
            else if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_BOTTOMAGGRO, 0, (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly))
                l->push_back(u);
        }
        break;
    case SMART_TARGET_HOSTILE_RANDOM:
        if (me)
        {
            if (e.target.hostilRandom.powerType)
            {
                if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_RANDOM, 0, PowerUsersSelector(me, Powers(e.target.hostilRandom.powerType - 1), (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly)))
                    l->push_back(u);
            }
            else if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_RANDOM, 0, (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly))
                l->push_back(u);
        }
        break;
    case SMART_TARGET_HOSTILE_RANDOM_NOT_TOP:
        if (me)
        {
            if (e.target.hostilRandom.powerType)
            {
                if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_RANDOM, 1, PowerUsersSelector(me, Powers(e.target.hostilRandom.powerType - 1), (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly)))
                    l->push_back(u);
            }
            else if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_RANDOM, 1, (float)e.target.hostilRandom.maxDist, e.target.hostilRandom.playerOnly))
                l->push_back(u);
        }
        break;
    case SMART_TARGET_FARTHEST:
        if (me)
        {
            if (Unit* u = me->AI()->SelectTarget(SELECT_TARGET_FARTHEST, 0, FarthestTargetSelector(me, e.target.farthest.maxDist, e.target.farthest.playerOnly, e.target.farthest.isInLos)))
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
        Creature* target = nullptr;
        if (!scriptTrigger && !baseObject)
        {
            sLog->outError("SMART_TARGET_CREATURE_GUID can not be used without invoker");
            break;
        }

        // xinef: my addition
        if (e.target.unitGUID.getFromHashMap)
        {
            if ((target = ObjectAccessor::GetCreature(scriptTrigger ? *scriptTrigger : *GetBaseObject(), MAKE_NEW_GUID(e.target.unitGUID.dbGuid, e.target.unitGUID.entry, HIGHGUID_UNIT))))
                l->push_back(target);
        }
        else
        {
            target = FindCreatureNear(scriptTrigger ? scriptTrigger : GetBaseObject(), e.target.unitGUID.dbGuid);
            if (target && (!e.target.unitGUID.entry || target->GetEntry() == e.target.unitGUID.entry))
                l->push_back(target);
        }
        break;
    }
    case SMART_TARGET_GAMEOBJECT_GUID:
    {
        GameObject* target = nullptr;
        if (!scriptTrigger && !GetBaseObject())
        {
            sLog->outError("SMART_TARGET_GAMEOBJECT_GUID can not be used without invoker");
            break;
        }

        // xinef: my addition
        if (e.target.goGUID.getFromHashMap)
        {
            if ((target = ObjectAccessor::GetGameObject(scriptTrigger ? *scriptTrigger : *GetBaseObject(), MAKE_NEW_GUID(e.target.goGUID.dbGuid, e.target.goGUID.entry, HIGHGUID_GAMEOBJECT))))
                l->push_back(target);
        }
        else
        {
            target = FindGameObjectNear(scriptTrigger ? scriptTrigger : GetBaseObject(), e.target.goGUID.dbGuid);
            if (target && (!e.target.goGUID.entry || target->GetEntry() == e.target.goGUID.entry))
                l->push_back(target);
        }
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
                acore::Containers::RandomResizeList(*l, e.target.playerRange.maxCount);
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

        // xinef: return l, retardness... what if list is empty? will return empty list instead of null pointer
        break;
    }
    case SMART_TARGET_CLOSEST_CREATURE:
    {
        Creature* target = GetClosestCreatureWithEntry(GetBaseObject(), e.target.closest.entry, (float)(e.target.closest.dist ? e.target.closest.dist : 100), !e.target.closest.dead);
        if (target)
            l->push_back(target);
        break;
    }
    case SMART_TARGET_CLOSEST_GAMEOBJECT:
    {
        GameObject* target = GetClosestGameObjectWithEntry(GetBaseObject(), e.target.closest.entry, (float)(e.target.closest.dist ? e.target.closest.dist : 100));
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
    {
        if (me)
        {
            if (Unit* owner = ObjectAccessor::GetUnit(*me, me->GetCharmerOrOwnerGUID()))
                l->push_back(owner);
            // Xinef: dont add same unit twice
            else if (me->IsSummon() && me->ToTempSummon()->GetSummoner())
                l->push_back(me->ToTempSummon()->GetSummoner());
        }
        else if (go)
        {
            if (Unit* owner = ObjectAccessor::GetUnit(*go, go->GetOwnerGUID()))
                l->push_back(owner);
        }

        // xinef: Get owner of owner
        if (e.target.owner.useCharmerOrOwner && !l->empty())
        {
            Unit* owner = l->front()->ToUnit();
            l->clear();

            if (Unit* base = ObjectAccessor::GetUnit(*owner, owner->GetCharmerOrOwnerGUID()))
                l->push_back(base);
        }
        break;
    }
    case SMART_TARGET_THREAT_LIST:
    {
        if (me)
        {
            ThreatContainer::StorageType threatList = me->getThreatManager().getThreatList();
            for (ThreatContainer::StorageType::const_iterator i = threatList.begin(); i != threatList.end(); ++i)
                if (Unit* temp = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                    // Xinef: added distance check
                    if (e.target.hostilRandom.maxDist == 0 || me->IsWithinCombatRange(temp, (float)e.target.hostilRandom.maxDist))
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
            acore::Containers::RandomResizeList(*l, e.target.o);

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
            acore::Containers::RandomResizeList(*l, e.target.roleSelection.resize);

        delete units;
        break;
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
        acore::AllWorldObjectsInRange u_check(obj, dist);
        acore::WorldObjectListSearcher<acore::AllWorldObjectsInRange> searcher(obj, *targets, u_check);
        obj->VisitNearbyObject(dist, searcher);
    }
    return targets;
}

void SmartScript::ProcessEvent(SmartScriptHolder& e, Unit* unit, uint32 var0, uint32 var1, bool bvar, const SpellInfo* spell, GameObject* gob)
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
        ProcessTimedAction(e, e.event.friendlyCC.repeatMin, e.event.friendlyCC.repeatMax, acore::Containers::SelectRandomContainerElement(pList));
        break;
    }
    case SMART_EVENT_FRIENDLY_MISSING_BUFF:
    {
        std::list<Creature*> pList;
        DoFindFriendlyMissingBuff(pList, (float)e.event.missingBuff.radius, e.event.missingBuff.spell);

        if (pList.empty())
            return;

        ProcessTimedAction(e, e.event.missingBuff.repeatMin, e.event.missingBuff.repeatMax, acore::Containers::SelectRandomContainerElement(pList));
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
        ProcessTimedAction(e, e.event.aura.repeatMin, e.event.aura.repeatMax);
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
    case SMART_EVENT_QUEST_OBJ_COPLETETION:
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
        // Xinef: added no report use distinction for gameobjects
    case SMART_EVENT_GOSSIP_HELLO:
        if (e.event.gossipHello.noReportUse && var0)
            return;
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
            //if friendly event&&who is not hostile OR hostile event&&who is hostile
            if ((e.event.los.noHostile && !me->IsHostileTo(unit)) ||
                (!e.event.los.noHostile && me->IsHostileTo(unit)))
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
            //if friendly event&&who is not hostile OR hostile event&&who is hostile
            if ((e.event.los.noHostile && !me->IsHostileTo(unit)) ||
                (!e.event.los.noHostile && me->IsHostileTo(unit)))
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript: Gossip Select:  menu %u action %u", var0, var1); //little help for scripters
#endif
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
        ProcessAction(e, NULL, var0);
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
        ProcessAction(e, NULL, var0);
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
            units->remove_if([](WorldObject* unit) { return unit->GetTypeId() != TYPEID_PLAYER; });

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
            units->remove_if([](WorldObject* unit) { return unit->GetTypeId() != TYPEID_PLAYER; });

            if (units->size() < e.event.nearPlayerNegation.minCount)
                ProcessAction(e, unit);
        }
        RecalcTimer(e, e.event.nearPlayerNegation.checkTimer, e.event.nearPlayerNegation.checkTimer);
        break;
    }
    default:
        sLog->outErrorDb("SmartScript::ProcessEvent: Unhandled Event type %u", e.GetEventType());
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
        // Xinef: wtf is this bullshit? cooldown should be processed AFTER action is done, not before...
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

    if (e.GetEventType() == SMART_EVENT_UPDATE_OOC && (me && me->IsInCombat()))//can be used with me=NULL (go script)
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
            ProcessEventsFor(SMART_EVENT_TEXT_OVER, NULL, textID, entry);
        }
        else mTextTimer -= diff;
    }
}

void SmartScript::FillScript(SmartAIEventList e, WorldObject* obj, AreaTrigger const* at)
{
    (void)at; // ensure that the variable is referenced even if extra logs are disabled in order to pass compiler checks

    if (e.empty())
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        if (obj)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript: EventMap for Entry %u is empty but is using SmartScript.", obj->GetEntry());

        if (at)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript: EventMap for AreaTrigger %u is empty but is using SmartScript.", at->entry);
#endif
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
        e = sSmartScriptMgr->GetScript(-((int32)me->GetDBTableGUIDLow()), mScriptType);
        if (e.empty())
            e = sSmartScriptMgr->GetScript((int32)me->GetEntry(), mScriptType);
        FillScript(e, me, nullptr);
    }
    else if (go)
    {
        e = sSmartScriptMgr->GetScript(-((int32)go->GetDBTableGUIDLow()), mScriptType);
        if (e.empty())
            e = sSmartScriptMgr->GetScript((int32)go->GetEntry(), mScriptType);
        FillScript(e, go, nullptr);
    }
    else if (trigger)
    {
        e = sSmartScriptMgr->GetScript((int32)trigger->entry, mScriptType);
        FillScript(e, NULL, trigger);
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::OnInitialize: source is Creature %u", me->GetEntry());
#endif
            break;
        case TYPEID_GAMEOBJECT:
            mScriptType = SMART_SCRIPT_TYPE_GAMEOBJECT;
            go = obj->ToGameObject();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::OnInitialize: source is GameObject %u", go->GetEntry());
#endif
            break;
        default:
            sLog->outError("SmartScript::OnInitialize: Unhandled TypeID !WARNING!");
            return;
        }
    }
    else if (at)
    {
        mScriptType = SMART_SCRIPT_TYPE_AREATRIGGER;
        trigger = at;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartScript::OnInitialize: source is AreaTrigger %u", trigger->entry);
#endif
    }
    else
    {
        sLog->outError("SmartScript::OnInitialize: !WARNING! Initialized objects are NULL.");
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
            if (const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(i->action.cast.spell))
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

void SmartScript::SetGUID(uint64 guid, int32 id)
{
}

uint64 SmartScript::GetGUID(int32 id)
{
return 0;
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

uint32 SmartScript::DoChat(int8 id, uint64 whisperGuid)
{
return 0;
}*/
// SmartScript end

Unit* SmartScript::DoSelectLowestHpFriendly(float range, uint32 MinHPDiff)
{
    if (!me)
        return nullptr;

    Unit* unit = nullptr;

    acore::MostHPMissingInRange u_check(me, range, MinHPDiff);
    acore::UnitLastSearcher<acore::MostHPMissingInRange> searcher(me, unit, u_check);
    me->VisitNearbyObject(range, searcher);
    return unit;
}

void SmartScript::DoFindFriendlyCC(std::list<Creature*>& _list, float range)
{
    if (!me)
        return;

    acore::FriendlyCCedInRange u_check(me, range);
    acore::CreatureListSearcher<acore::FriendlyCCedInRange> searcher(me, _list, u_check);
    me->VisitNearbyObject(range, searcher);
}

void SmartScript::DoFindFriendlyMissingBuff(std::list<Creature*>& list, float range, uint32 spellid)
{
    if (!me)
        return;

    acore::FriendlyMissingBuffInRange u_check(me, range, spellid);
    acore::CreatureListSearcher<acore::FriendlyMissingBuffInRange> searcher(me, list, u_check);
    me->VisitNearbyObject(range, searcher);
}

Unit* SmartScript::DoFindClosestFriendlyInRange(float range, bool playerOnly)
{
    if (!me)
        return nullptr;

    Unit* unit = nullptr;
    acore::AnyFriendlyNotSelfUnitInObjectRangeCheck u_check(me, me, range, playerOnly);
    acore::UnitLastSearcher<acore::AnyFriendlyNotSelfUnitInObjectRangeCheck> searcher(me, unit, u_check);
    me->VisitNearbyObject(range, searcher);
    return unit;
}

void SmartScript::SetScript9(SmartScriptHolder& e, uint32 entry)
{
    //do NOT clear mTimedActionList if it's being iterated because it will invalidate the iterator and delete
    // any SmartScriptHolder contained like the "e" parameter passed to this function
    if (isProcessingTimedActionList)
    {
        sLog->outError("Entry %d SourceType %u Event %u Action %u is trying to overwrite timed action list from a timed action, this is not allowed!.", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
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
