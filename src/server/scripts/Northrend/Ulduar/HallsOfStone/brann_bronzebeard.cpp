/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "halls_of_stone.h"

enum NPCs
{
    NPC_DARK_RUNE_PROTECTOR         = 27983,
    NPC_DARK_RUNE_STORMCALLER       = 27984,
    NPC_IRON_GOLEM_CUSTODIAN        = 27985,
    NPC_DARK_MATTER                 = 28235,
    NPC_DARK_MATTER_TARGET          = 28237,
    NPC_SEARING_GAZE_TRIGGER        = 28265,
};

enum Misc
{
    // BRANN EVENT
    SPELL_GLARE_OF_THE_TRIBUNAL     = 50988,
    SPELL_DARK_MATTER_VISUAL        = 51000,
    SPELL_DARK_MATTER_VISUAL_CHANNEL= 51001,
    SPELL_DARK_MATTER               = 51012,
    SPELL_SEARING_GAZE              = 51136,
    SPELL_STEALTH                   = 58506,

    // Serverside
    SPELL_TRIBUNAL_CREDIT_MARKER    = 59046,

    // QUESTS
    QUEST_HALLS_OF_STONE            = 13207,
};

enum events
{
    // BRANN AND TRIBUNAL
    EVENT_ABEDNEUM_VISUAL = 1,
    EVENT_KADDRAK_VISUAL = 2,
    EVENT_MARNAK_VISUAL = 3,
    EVENT_ABEDNEUM_HEAD = 4,
    EVENT_KADDRAK_HEAD = 5,
    EVENT_MARNAK_HEAD = 6,
    EVENT_KADDRAK_SWITCH_EYE = 7,
    EVENT_SUMMON_MONSTERS = 8,
    EVENT_SUMMON_STORMCALLER = 9,
    EVENT_SUMMON_CUSTODIAN = 10,
    EVENT_DARK_MATTER_START = 11,
    EVENT_DARK_MATTER_END = 12,

    EVENT_TRIBUNAL_END = 13,
    EVENT_BREEN_WAITING = 14,
    EVENT_TALK_FACE_CHANGE = 15,
    EVENT_SKY_ROOM_FLOOR_CHANGE = 16,

    //BRANN AND SJONNIR
    EVENT_GO_TO_SJONNIR = 17,
    EVENT_DOOR_OPEN = 18,
    EVENT_RESUME_ESCORT = 19,
    EVENT_SJONNIR_END_BRANN_YELL = 20,
    EVENT_SJONNIR_END_BRANN_LAST_YELL = 21,
};

struct Yells
{
    uint32 sound;
    const char* text;
    uint32 creature, timer;
};

static Yells Conversation[] =
{
    {14248, "Now keep an eye out! I'll have this licked in two shakes of a--", NPC_BRANN, 8000},
    {13765, "Warning: life form pattern not recognized. Archival processing terminated. Continued interference will result in targeted response.", NPC_ABEDNEUM, 13000},
    {14249, "Oh, that doesn't sound good. We might have a complication or two...", NPC_BRANN, 24000},
    {13756, "Security breach in progress. Analysis of historical archives transferred to lower-priority queue. Countermeasures engaged.", NPC_KADDRAK, 30500},
    {14250, "Ah, you want to play hardball, eh? That's just my game!", NPC_BRANN, 42000},
    {14251, "Couple more minutes and I'll--", NPC_BRANN, 102000},
    {13761, "Threat index threshold exceeded. Celestial archive aborted. Security level heightened.", NPC_MARNAK, 105000},
    {14252, "Heightened? What's the good news?", NPC_BRANN, 113000},
    {14253, "So that was the problem? Now I'm makin' progress...", NPC_BRANN, 201000},
    {13767, "Critical threat index. Void analysis diverted. Initiating sanitization protocol.", NPC_ABEDNEUM, 207500 },
    {14254, "Hang on! Nobody's gonna' be sanitized as long as I have a say in it!", NPC_BRANN, 214000},
    {14255, "Ha! The old magic fingers finally won through! Now let's get down to--", NPC_BRANN, 305000},
    {13768, "Alert: security fail-safes deactivated. Beginning memory purge and... ", NPC_ABEDNEUM, 310000},
    //The fight is completed at this point.d
    {14256, "Purge? No no no no no.. where did I-- Aha, this should do the trick...", NPC_BRANN, 316000},
    {13769, "System online. Life form pattern recognized. Welcome, Branbronzan. Query?", NPC_ABEDNEUM, 322000},
    {14263, "Query? What do you think I'm here for, tea and biscuits? Spill the beans already!", NPC_BRANN, 330000},
    {14264, "Tell me how the dwarves came to be, and start at the beginning!", NPC_BRANN, 336000},
    {13770, "Accessing prehistoric data... retrieved. In the beginning the earthen were created to--", NPC_ABEDNEUM, 341000},
    {14265, "Right, right... I know the earthen were made from stone to shape the deep regions o' the world. But what about the anomalies? Matrix non-stabilizin' and what-not?", NPC_BRANN, 348000},
    {13771, "Accessing... In the early stages of it's development cycle, Azeroth suffered infection by parasitic necrophotic symbiotes.", NPC_ABEDNEUM, 360000},
    {14266, "Necrowhatinthe-- Speak bloody Common, will ye?", NPC_BRANN, 372000},
    {13772, "Designation: Old Gods. Old Gods rendered all systems, including earthen, defenseless in order to facilitate assimilation. This matrix destabilization has been termed the Curse of Flesh. Effects of destabilization increased over time.", NPC_ABEDNEUM, 377000},
    {14267, "Old Gods, huh? So they zapped the earthen with this Curse of Flesh... and then what?", NPC_BRANN, 400000},
    {13757, "Accessing... Creators arrived to extirpate symbiotic infection. Assessment revealed that Old God infestation had grown malignant. Excising parasites would result in loss of host--", NPC_KADDRAK, 407500},
    {14268, "If they killed the Old Gods, Azeroth would've been destroyed...", NPC_BRANN, 424000},
    {13758, "Correct. Creators neutralized parasitic threat and contained it within the host. Forge of Wills and other systems were instituted to create new earthen. Safeguards were implemented, and protectors were appointed.", NPC_KADDRAK, 431000},
    {14269, "What protectors?", NPC_BRANN, 450000},
    {13759, "Designations: Aesir and Vanir. Or in the common nomenclature, storm and earth giants. Sentinel Loken designated supreme. Dragon Aspects appointed to monitor evolution on Azeroth.", NPC_KADDRAK, 453000},
    {14270, "Aesir and Vanir... Okay, so the Forge o' Wills started makin' new earthen... but what happened to the old ones?", NPC_BRANN, 472000},
    {13762, "Additional background is relevant to your query: following global combat between Aesir and Vanir--", NPC_MARNAK, 483000},
    {14271, "Hold everything! The Aesir and Vanir went to war? Why?", NPC_BRANN, 489000},
    {13763, "Unknown. Data suggests that impetus for global combat originated with prime designate Loken, who neutralized all remaining Aesir and Vanir, affecting termination of conflict. Prime designate Loken then initiated stasis of several seed races, including earthen, giants and vrykul, at designated holding facilities.", NPC_MARNAK, 495000},
    {14272, "This Loken sounds like a nasty character. Glad we don't have to worry about the likes o' him anymore. So... if I'm understandin' ye right, the original earthen eventually woke up from this stasis, and by that time the destabili-whatever had turned 'em into proper dwarves. Or at least... dwarf ancestors.", NPC_BRANN, 519000},
    {13764, "Essentially that is correct.", NPC_MARNAK, 543000},
    {14273, "Well, now... that's a lot to digest. I'm gonna need some time to take all this in. Thank ye.", NPC_BRANN, 546000},
    {13773, "Acknowledged, Branbronzan. Session terminated.", NPC_ABEDNEUM, 554000},
    //Go to Sjonnir's door
    {0, "I think it's time to see what's behind the door near the entrance. I'm going to sneak over there, nice and quiet. Meet me at the door and I'll get us in.", NPC_BRANN, 561000},
};

enum GossipIDs
{
    TRIBUNAL_BEFORE = 9669,
    TRIBUNAL_START  = 9670,
    TRIBUNAL_END    = 10206,
    SJONNIR_DOOR    = 10012,
    SJONNIR_END     = 9725,
};

struct brann_bronzebeard : public ScriptedAI
{
    brann_bronzebeard(Creature* creature) : ScriptedAI(creature), summons(me), _recentlySpoken(false)
    {
        instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        scheduler.CancelAll();
        me->m_Events.KillAllEvents(false);
        me->SetReactState(REACT_PASSIVE);
        me->SetRegeneratingHealth(false);
        me->SetGossipMenuId(TRIBUNAL_BEFORE);
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        summons.DespawnAll();

        if (instance->GetBossState(BRANN_BRONZEBEARD) == IN_PROGRESS)
        {
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }
        if (instance->GetBossState(BOSS_TRIBUNAL_OF_AGES == DONE))
        {
            me->SetGossipMenuId(SJONNIR_DOOR);
            DoCastSelf(SPELL_STEALTH);
        }
    }

    void sGossipSelect(Player* player, uint32 /*sender*/, uint32  /*action*/) override
    {
        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        switch (me->GetGossipMenuId())
        {
            case TRIBUNAL_BEFORE:
                me->AI()->DoAction(ACTION_START_ESCORT_EVENT);
                break;
            case TRIBUNAL_START:
                me->AI()->DoAction(ACTION_START_TRIBUNAL);
                break;
            case TRIBUNAL_END:
                me->AI()->DoAction(ACTION_GO_TO_SJONNIR);
                break;
            case SJONNIR_DOOR:
                me->AI()->DoAction(ACTION_OPEN_DOOR);
                break;
            default:
                break;
        }
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
        case ACTION_START_ESCORT_EVENT: // Received via gossip
            Talk(SAY_BRANN_ESCORT_START);
            me->GetMotionMaster()->MoveWaypoint(280701, false);
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetRegeneratingHealth(true);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            instance->SetBossState(BRANN_BRONZEBEARD, IN_PROGRESS);
            break;
        case ACTION_START_TRIBUNAL: // Received via gossip
        {
            // DoCastSelf 51810
            me->SetReactState(REACT_PASSIVE);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->GetMotionMaster()->MovePoint(1, 897.1759f, 331.77386f, 203.70638f);
            InitializeEvent();
            break;
        }
        case ACTION_GO_TO_SJONNIR: // Received via gossip
            me->m_Events.KillAllEvents(false);
            scheduler.CancelAll();

            Talk(SAY_BRANN_ENTRANCE_MEET);
            me->SetReactState(REACT_PASSIVE);
            me->SetRegeneratingHealth(true);

            ResetEvent();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            DoCast(me, 58506, false);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);

            me->GetMotionMaster()->MovePoint(3, 935.955f, 371.031f, 207.41751f);
            break;
        case ACTION_START_SJONNIR_FIGHT: // Received by Sjonnir
            me->GetMotionMaster()->MoveWaypoint(280702, false);
            break;
        case ACTION_SJONNIR_DEAD: // Received by Sjonnir
            me->m_Events.KillAllEvents(false);
            scheduler.CancelAll();
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            me->SetOrientation(3.132660f);
            events.ScheduleEvent(EVENT_SJONNIR_END_BRANN_YELL, 10s);
            events.ScheduleEvent(EVENT_SJONNIR_END_BRANN_LAST_YELL, 22s);
            break;
        case ACTION_SJONNIR_WIPE_START: // Received by Sjonnir
            Reset();
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);
            me->StopMovingOnCurrentPos();
            DoCast(me, 58506, false);
            break;
        case ACTION_OPEN_DOOR: // Reveived via gossip
            me->RemoveAura(58506);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            me->SetWalk(true);
            break;
        case ACTION_PLAYER_DEATH_IN_TRIBUNAL:
            Talk(3);
            _recentlySpoken = true;
            me->m_Events.AddEventAtOffset([&] {
                _recentlySpoken = false;
            }, 6s);
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE)
        {
            switch (id)
            {
            case 1:
                me->SetEmoteState(EMOTE_STATE_USE_STANDING);
                break;
            case 3:
                me->DespawnOrUnsummon(0s, 5s);
                break;
            case 4:
                me->SetEmoteState(EMOTE_STATE_USE_STANDING);
                me->SetWalk(false);
                me->m_Events.AddEventAtOffset([&] {
                    me->SetEmoteState(EMOTE_ONESHOT_NONE);
                    instance->SetBossState(BRANN_DOOR, DONE); // Opens Door to Sjonnir
                }, 3200ms);
                me->m_Events.AddEventAtOffset([&] {
                    me->GetMotionMaster()->MovePoint(5, 1256.33f, 667.028f, 189.59921);
                }, 5600ms);
                break;
            case 5:
                me->SetEmoteState(EMOTE_STATE_READY_UNARMED);
                break;
            default:
                break;
            }
        }
    }

    void PathEndReached(uint32 pathId) override
    {
        if (pathId == 280701)
        {
            instance->SetBossState(BRANN_BRONZEBEARD, DONE);
            Talk(9);
            me->SetReactState(REACT_PASSIVE);
            me->SetRegeneratingHealth(false);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }
    }

    void JustSummoned(Creature* cr) override
    {
        if (cr->GetEntry() == NPC_ABEDNEUM || cr->GetEntry() == NPC_KADDRAK || cr->GetEntry() == NPC_MARNAK)
            cr->SetCanFly(true);
        else
            summons.Summon(cr);
    }

    void InitializeEvent()
    {
        instance->SetBossState(BOSS_TRIBUNAL_OF_AGES, IN_PROGRESS);

        Creature* cr;
        if ((cr = me->SummonCreature(NPC_KADDRAK, 928.0f, 331.276f, 219.73332f, 1.8326f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
            KaddrakGUID = cr->GetGUID();

        if ((cr = me->SummonCreature(NPC_MARNAK, 891.309f, 359.38196f, 217.42168f, 4.6774f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
            MarnakGUID = cr->GetGUID();

        if ((cr = me->SummonCreature(NPC_ABEDNEUM, 896.07965f, 330.89822f, 237.91263f, 3.5779f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
            AbedneumGUID = cr->GetGUID();


    }

    void ResetEvent()
    {
        if (GameObject* tribunal = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_TRIBUNAL_CONSOLE)))
            tribunal->SetGoState(GO_STATE_READY);

        if (GameObject* tribunalSkyFloor = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_SKY_FLOOR)))
            tribunalSkyFloor->SetGoState(GO_STATE_READY);

        scheduler.CancelAll();
        me->m_Events.KillAllEvents(false);
        summons.DespawnAll();
        DespawnHeads();

        WaveNum = 0;
        SpeechCount = 0;
        SpeechPause = 0;
        TalkEvent = false;
    }

    void SwitchHeadVisaul(uint8 headMask, bool activate)
    {
        if (!instance)
            return;

        GameObject* go = nullptr;
        if (headMask & 0x1) // Kaddrak
            if ((go = me->GetMap()->GetGameObject(instance->GetGuidData(GO_KADDRAK))))
            {
                if (activate)
                {
                    go->SendCustomAnim(0);
                }
                else
                {
                    go->SendCustomAnim(1);
                    if (go->GetGoState() == GO_STATE_ACTIVE)
                        go->SetGoState(GO_STATE_READY);
                }
            }
        if (headMask & 0x2) // Marnak
            if ((go = me->GetMap()->GetGameObject(instance->GetGuidData(GO_MARNAK))))
            {
                if (activate)
                {
                    go->SendCustomAnim(0);
                }
                else
                {
                    go->SendCustomAnim(1);
                    if (go->GetGoState() == GO_STATE_ACTIVE)
                        go->SetGoState(GO_STATE_READY);
                }
            }
        if (headMask & 0x4) // Abedneum
            if ((go = me->GetMap()->GetGameObject(instance->GetGuidData(GO_ABEDNEUM))))
            {
                if (activate)
                {
                    go->SendCustomAnim(0);
                }
                else
                {
                    go->SendCustomAnim(1);
                    if (go->GetGoState() == GO_STATE_ACTIVE)
                        go->SetGoState(GO_STATE_READY);
                }
            }
    }

    Creature* GetAbedneum() { return ObjectAccessor::GetCreature(*me, AbedneumGUID); }
    Creature* GetMarnak() { return ObjectAccessor::GetCreature(*me, MarnakGUID); }
    Creature* GetKaddrak() { return ObjectAccessor::GetCreature(*me, KaddrakGUID); }

    void DespawnHeads()
    {
        Creature* cr;
        if ((cr = GetAbedneum())) cr->DespawnOrUnsummon();
        if ((cr = GetMarnak())) cr->DespawnOrUnsummon();
        if ((cr = GetKaddrak())) cr->DespawnOrUnsummon();

        SwitchHeadVisaul(0x7, false);
    }

    void SummonCreatures(uint32 entry)
    {
        switch (entry)
        {
        case NPC_DARK_RUNE_PROTECTOR:
            me->SummonCreatureGroup(0);
            break;
        case NPC_DARK_RUNE_STORMCALLER:
            me->SummonCreatureGroup(1);
            break;
        case NPC_IRON_GOLEM_CUSTODIAN:
            me->SummonCreatureGroup(2);
            break;
        }
    }

private:
    InstanceScript* instance;
    SummonList summons;
    ObjectGuid AbedneumGUID;
    ObjectGuid MarnakGUID;
    ObjectGuid KaddrakGUID;
    ObjectGuid darkMatterTargetGUID;
    bool _recentlySpoken;
    uint8 WaveNum;
    bool TalkEvent;
    uint32 SpeechCount, SpeechPause;
    bool canExecuteEvents = true;
}

class brann_bronzebeard : public CreatureScript
{
public:
    brann_bronzebeard() : CreatureScript("brann_bronzebeard") { }

    struct brann_bronzebeardAI : public npc_escortAI
    {
        brann_bronzebeardAI(Creature* c) : npc_escortAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        

        

        

        

        

        void WaypointReached(uint32 id) override;
        void InitializeEvent();

        

        bool leftEye = true;

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage && pInstance)
                pInstance->SetData(DATA_BRANN_ACHIEVEMENT, false);
        }

        void Reset() override
        {
            RemoveEscortState(0x7); // all states
            SetDespawnAtFar(false);
            SetDespawnAtEnd(false);
            ResetEvent();

            me->SetReactState(REACT_PASSIVE);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);

            if (pInstance)
            {
                pInstance->SetData(BRANN_BRONZEBEARD, 1);
                pInstance->SetData(DATA_BRANN_ACHIEVEMENT, true);

                if (pInstance->GetData(BOSS_TRIBUNAL_OF_AGES) == DONE)
                {
                    pInstance->SetData(BRANN_BRONZEBEARD, 4);
                    if (GameObject* door = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(GO_TRIBUNAL_ACCESS_DOOR)))
                        door->SetGoState(GO_STATE_ACTIVE);
                }

                if (pInstance->GetData(BOSS_SJONNIR) == DONE)
                {
                    pInstance->SetData(BRANN_BRONZEBEARD, 5);
                    if (GameObject* door = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(GO_SJONNIR_DOOR)))
                        door->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        

        void UpdateEscortAI(uint32 diff) override
        {
            events.Update(diff);

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_KADDRAK_VISUAL:
                    {
                        SwitchHeadVisaul(0x1, true);
                        break;
                    }
                    case EVENT_MARNAK_VISUAL:
                    {
                        SwitchHeadVisaul(0x2, true);
                        break;
                    }
                    case EVENT_ABEDNEUM_VISUAL:
                    {
                        SwitchHeadVisaul(0x4, true);
                        break;
                    }
                    case EVENT_KADDRAK_HEAD: // Phase 1
                    {
                        if (!canExecuteEvents)
                            return;
                        if (Creature* kaddrak = GetKaddrak())
                        {
                            if (Player* plr = SelectTargetFromPlayerList(100.0f))
                                kaddrak->CastSpell(plr, SPELL_GLARE_OF_THE_TRIBUNAL, true);
                        }

                        events.RescheduleEvent(EVENT_KADDRAK_SWITCH_EYE, 1s);
                        events.Repeat(1500ms);
                        break;
                    }
                    case EVENT_KADDRAK_SWITCH_EYE:
                    {
                        if (!canExecuteEvents)
                            return;
                        if (Creature* kaddrak = GetKaddrak())
                        {
                            if (leftEye)
                                kaddrak->UpdatePosition(927.9f, 330.9f, 219.4f, 2.4f, true);
                            else
                                kaddrak->UpdatePosition(923.7f, 326.9f, 219.5f, 2.1f, true);

                            leftEye = !leftEye;
                            kaddrak->StopMovingOnCurrentPos();
                        }

                        break;
                    }
                    case EVENT_MARNAK_HEAD: // Phase 2
                    {
                        if (!canExecuteEvents)
                            return;

                        if (Creature* marnak = GetMarnak())
                        {
                            if (Creature* cr = me->SummonCreature(NPC_DARK_MATTER_TARGET, 899.843f, 355.271f, 214.301f, 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
                            {
                                cr->SetCanFly(true);

                                //right eye
                                if (Creature* cra = me->SummonCreature(NPC_DARK_MATTER, marnak->GetPositionX(), marnak->GetPositionY(), marnak->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 5000))
                                    cra->CastSpell(cra, SPELL_DARK_MATTER_VISUAL_CHANNEL, false);

                                //left eye
                                if (Creature* crb = me->SummonCreature(NPC_DARK_MATTER, 891.543f, 359.5252f, 219.338f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 5000))
                                    crb->CastSpell(crb, SPELL_DARK_MATTER_VISUAL_CHANNEL, false);

                                darkMatterTargetGUID = cr->GetGUID();

                                events.RescheduleEvent(EVENT_DARK_MATTER_START, 5s);
                            }
                        }
                        events.Repeat(30s);
                        break;
                    }
                    case EVENT_DARK_MATTER_START:
                    {
                        if (Creature* darkMatterTarget = ObjectAccessor::GetCreature(*me, darkMatterTargetGUID))
                        {
                            darkMatterTarget->CastSpell(darkMatterTarget, SPELL_DARK_MATTER_VISUAL, false);
                            if (Player* plr = SelectTargetFromPlayerList(100.0f))
                            {
                                if (!plr)
                                    return; //no target

                                darkMatterTarget->GetMotionMaster()->MovePoint(0, plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ());

                                if (darkMatterTarget->GetDistance(plr) < 5.0f)
                                {
                                    events.RescheduleEvent(EVENT_DARK_MATTER_END, 3s);
                                }
                                else if (darkMatterTarget->GetDistance(plr) < 30.0f)
                                {
                                    events.RescheduleEvent(EVENT_DARK_MATTER_END, 3500ms);
                                }
                                else
                                {
                                    events.RescheduleEvent(EVENT_DARK_MATTER_END, 4500ms);
                                }
                            }
                        }
                        break;
                    }
                    case EVENT_DARK_MATTER_END:
                    {
                        if (Creature* darkMatterTarget = ObjectAccessor::GetCreature(*me, darkMatterTargetGUID))
                        {
                            darkMatterTarget->CastSpell(darkMatterTarget, SPELL_DARK_MATTER, true);
                            darkMatterTarget->DespawnOrUnsummon(500ms);
                        }
                        break;
                    }
                    case EVENT_ABEDNEUM_HEAD: // Phase 3
                    {
                        if (!canExecuteEvents)
                            return;
                        if (GetAbedneum())
                        {
                            Player* plr = SelectTargetFromPlayerList(100.0f);
                            if (!plr)
                                break;

                            if (Creature* cr = me->SummonCreature(NPC_SEARING_GAZE_TRIGGER, plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
                            {
                                // summon another abedneum to create double beam, despawn just after trigger despawn
                                me->SummonCreature(NPC_ABEDNEUM, 897.0f, 326.9f, 223.5f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 12000);
                                cr->CastSpell(cr, SPELL_SEARING_GAZE, true);
                            }
                        }
                        events.Repeat(15s);
                        break;
                    }
                    case EVENT_SUMMON_MONSTERS:
                    {
                        if (!canExecuteEvents)
                            return;
                        SummonCreatures(NPC_DARK_RUNE_PROTECTOR, 3, 0);
                        events.Repeat(IsHeroic() ? 23500ms : 32500ms);
                        break;
                    }
                    case EVENT_SUMMON_STORMCALLER:
                    {
                        if (!canExecuteEvents)
                            return;

                        SummonCreatures(NPC_DARK_RUNE_STORMCALLER, 2, 1);
                        events.Repeat(IsHeroic() ? 32s : 41500ms);
                        break;
                    }
                    case EVENT_SUMMON_CUSTODIAN:
                    {
                        if (!canExecuteEvents)
                            return;

                        SummonCreatures(NPC_IRON_GOLEM_CUSTODIAN, 1, 1);
                        events.Repeat(IsHeroic() ? 32s : 45s);
                        break;
                    }
                    case EVENT_TRIBUNAL_END:
                    {
                        canExecuteEvents = false;
                        // Has to be here!
                        events.Reset();
                        //DespawnHeads();
                        summons.DespawnAll();

                        // Spawn Chest and quest credit
                        if (Player* plr = SelectTargetFromPlayerList(200.0f))
                        {
                            if (GameObject* go = plr->SummonGameObject((IsHeroic() ? GO_TRIBUNAL_CHEST_H : GO_TRIBUNAL_CHEST), 880.406f, 345.164f, 203.706f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0))
                            {
                                plr->RemoveGameObject(go, false);
                                go->SetLootMode(1);
                                go->ReplaceAllGameObjectFlags((GameObjectFlags)0);
                            }

                            plr->GroupEventHappens(QUEST_HALLS_OF_STONE, me);
                        }

                        events.ScheduleEvent(EVENT_BREEN_WAITING, 11s);
                        events.ScheduleEvent(EVENT_SKY_ROOM_FLOOR_CHANGE, 92s);
                        events.ScheduleEvent(EVENT_TALK_FACE_CHANGE, 97s);          //kaddrak speaks
                        events.ScheduleEvent(EVENT_SKY_ROOM_FLOOR_CHANGE, 168s);
                        events.ScheduleEvent(EVENT_TALK_FACE_CHANGE, 173s);         //marnak speaks
                        events.ScheduleEvent(EVENT_SKY_ROOM_FLOOR_CHANGE, 239s);
                        events.ScheduleEvent(EVENT_TALK_FACE_CHANGE, 244s);         //abedneum speaks
                        events.ScheduleEvent(EVENT_GO_TO_SJONNIR, 251s);
                        events.ScheduleEvent(EVENT_SKY_ROOM_FLOOR_CHANGE, 253s);
                        break;
                    }
                    case EVENT_BREEN_WAITING:
                    {
                        SetEscortPaused(false);
                        if (pInstance)
                        {
                            pInstance->SetData(BOSS_TRIBUNAL_OF_AGES, DONE);
                            pInstance->SetData(BRANN_BRONZEBEARD, 3);
                            me->CastSpell(me, SPELL_TRIBUNAL_CREDIT_MARKER, true); // credit
                        }

                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                        me->SendMovementFlagUpdate();

                        break;
                    }
                    case EVENT_TALK_FACE_CHANGE:
                    {
                        if (pInstance)
                            pInstance->SetData(BOSS_TRIBUNAL_OF_AGES, DONE);
                        break;
                    }
                    case EVENT_SKY_ROOM_FLOOR_CHANGE:
                    {
                        if (pInstance)
                            pInstance->SetData(BOSS_TRIBUNAL_OF_AGES, SPECIAL);
                        break;
                    }
                    case EVENT_GO_TO_SJONNIR:
                    {
                        me->AI()->DoAction(ACTION_GO_TO_SJONNIR);
                        break;
                    }
                    case EVENT_DOOR_OPEN:
                    {
                        me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                        me->AddUnitMovementFlag(MOVEMENTFLAG_NONE);

                        if (pInstance)
                        {
                            if (GameObject* door = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(GO_SJONNIR_DOOR)))
                            {
                                door->SetGoState(GO_STATE_ACTIVE);
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);
                                me->SendMovementFlagUpdate();
                            }
                        }

                        break;
                    }
                    case EVENT_RESUME_ESCORT:
                    {
                        SetEscortPaused(false);
                        break;
                    }
                    case EVENT_SJONNIR_END_BRANN_YELL:
                    {
                        Talk(SAY_BRANN_VICTORY_SJONNIR_1);
                        break;
                    }
                    case EVENT_SJONNIR_END_BRANN_LAST_YELL:
                    {
                        events.Reset();
                        SetEscortPaused(false);
                        Talk(SAY_BRANN_VICTORY_SJONNIR_2);
                        break;
                    }
                }
            }

            npc_escortAI::UpdateEscortAI(diff);

            if (TalkEvent)
            {
                SpeechPause += diff;
                if (SpeechPause >= Conversation[SpeechCount].timer)
                {
                    Creature* cs = nullptr;
                    switch (Conversation[SpeechCount].creature)
                    {
                        case NPC_BRANN:
                            cs = me;
                            break;
                        case NPC_ABEDNEUM:
                            cs = GetAbedneum();
                            break;
                        case NPC_KADDRAK:
                            cs = GetKaddrak();
                            break;
                        case NPC_MARNAK:
                            cs = GetMarnak();
                            break;
                    }

                    if (cs)
                    {
                        cs->Yell(Conversation[SpeechCount].text, LANG_UNIVERSAL);
                        cs->PlayDirectSound(Conversation[SpeechCount].sound);
                    }

                    if (SpeechCount < 38)
                        SpeechPause = Conversation[SpeechCount++].timer;
                    else
                        TalkEvent = false;
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            ResetEvent();
            if (pInstance)
            {
                if (Creature* brann = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(NPC_BRANN)))
                {
                    brann->HandleEmoteCommand(EMOTE_STATE_DEAD);
                    brann->setDeathState(DeathState::JustDied);
                    brann->Respawn();
                    if (pInstance->GetData(BOSS_TRIBUNAL_OF_AGES) != DONE)
                    {
                        brann->AI()->DoAction(ACTION_TRIBUNAL_WIPE_START);
                        pInstance->SetData(BOSS_TRIBUNAL_OF_AGES, FAIL);
                    }
                    if (pInstance->GetData(BOSS_TRIBUNAL_OF_AGES) == DONE)
                    {
                        brann->AI()->DoAction(ACTION_SJONNIR_WIPE_START);
                    }
                }
                if (pInstance->GetData(BOSS_TRIBUNAL_OF_AGES) != DONE)
                    pInstance->SetData(BOSS_TRIBUNAL_OF_AGES, NOT_STARTED);
            }
        }
    };
};

void brann_bronzebeard::brann_bronzebeardAI::InitializeEvent()
{
    Creature* cr = nullptr;
    if ((cr = me->SummonCreature(NPC_KADDRAK, 928.0f, 331.276f, 219.73332f, 1.8326f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
    {
        KaddrakGUID = cr->GetGUID();
    }
    if ((cr = me->SummonCreature(NPC_MARNAK, 891.309f, 359.38196f, 217.42168f, 4.6774f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
    {
        MarnakGUID = cr->GetGUID();
    }
    if ((cr = me->SummonCreature(NPC_ABEDNEUM, 896.07965f, 330.89822f, 237.91263f, 3.5779f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
    {
        AbedneumGUID = cr->GetGUID();
    }

    TalkEvent = true;

    events.Reset();

    // Viusals
    events.ScheduleEvent(EVENT_KADDRAK_VISUAL, 30s);
    events.ScheduleEvent(EVENT_MARNAK_VISUAL, 105s);
    events.ScheduleEvent(EVENT_ABEDNEUM_VISUAL, 207s);

    events.ScheduleEvent(EVENT_SUMMON_MONSTERS, 52s);
    events.ScheduleEvent(EVENT_SUMMON_STORMCALLER, 122s);
    events.ScheduleEvent(EVENT_SUMMON_CUSTODIAN, 228s);
    events.ScheduleEvent(EVENT_KADDRAK_HEAD, 47s);
    events.ScheduleEvent(EVENT_MARNAK_HEAD, 115s);
    events.ScheduleEvent(EVENT_ABEDNEUM_HEAD, 217s);
    events.ScheduleEvent(EVENT_TRIBUNAL_END, 310s);
}

// 51774 - Taunt
class spell_taunt_brann : public SpellScript
{
    PrepareSpellScript(spell_taunt_brann);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!caster || !target)
            return;

        uint32 spellId = GetEffectValue(); // 51775
        target->CastSpell(caster, spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_taunt_brann::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_hos_dark_matter : public AuraScript
{
    PrepareAuraScript(spell_hos_dark_matter);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DARK_MATTER });
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, SPELL_DARK_MATTER, true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_hos_dark_matter::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_hos_dark_matter_size : public SpellScript
{
    PrepareSpellScript(spell_hos_dark_matter_size);

    void HandleApplyTouch()
    {
        if (Unit* target = GetHitUnit())
            target->SetObjectScale(0.35f);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_hos_dark_matter_size::HandleApplyTouch);
    }
};

void AddSC_brann_bronzebeard()
{
    new brann_bronzebeard();
    RegisterSpellScript(spell_hos_dark_matter);
    RegisterSpellScript(spell_hos_dark_matter_size);
    RegisterSpellScript(spell_taunt_brann);
}
