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

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "halls_of_stone.h"

#define GOSSIP_ITEM_1       "Brann, it would be our honor!"
#define GOSSIP_ITEM_2       "Let's move Brann, enough of the history lessons!"
#define GOSSIP_ITEM_3       "There will be plenty of time for this later Brann, we need to get moving!"
#define GOSSIP_ITEM_4       "We're with you Brann! Open it!"
#define TEXT_ID_START           13100
#define TEXT_ID_TRIBUNAL_START  13101
#define TEXT_ID_TRIBUNAL_END    14176
#define TEXT_ID_SJONNIR_DOOR    13883
#define TEXT_ID_SJONNIR_END     13308

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
    SPELL_GLARE_OF_THE_TRIBUNAL_H   = 59870,
    SPELL_DARK_MATTER_VISUAL        = 51000,
    SPELL_DARK_MATTER_VISUAL_CHANNEL= 51001,
    SPELL_DARK_MATTER               = 51012,
    SPELL_DARK_MATTER_H             = 59868,
    SPELL_SEARING_GAZE              = 51136,
    SPELL_SEARING_GAZE_H            = 59867,

    // DARK RUNE PROTECTOR
    SPELL_DRP_CHARGE                = 22120,
    SPELL_DRP_CLEAVE                = 42724,

    // DARK RUNE STORMCALLER
    SPELL_DRS_LIGHTING_BOLT         = 12167,
    SPELL_DRS_LIGHTING_BOLT_H       = 59863,
    SPELL_DRS_SHADOW_WORD_PAIN      = 15654,
    SPELL_DRS_SHADOW_WORD_PAIN_H    = 59864,

    // IRON GOLEM CUSTODIAN
    SPELL_IGC_CRUSH_ARMOR           = 33661,
    SPELL_IGC_GROUND_SMASH          = 12734,
    SPELL_IGC_GROUND_SMASH_H        = 59865,

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

    // DARK RUNE PROTECTOR
    EVENT_DRP_CHARGE = 13,
    EVENT_DRP_CLEAVE = 14,

    // DARK RUNE STORMCALLER
    EVENT_DRS_LIGHTNING_BOLD = 15,
    EVENT_DRS_SHADOW_WORD_PAIN = 16,

    // IRON GOLEM CUSTODIAN
    EVENT_IGC_CRUSH = 17,
    EVENT_IGC_GROUND_SMASH = 18,

    EVENT_TRIBUNAL_END = 19,
    EVENT_BREEN_WAITING = 20,
    EVENT_TALK_FACE_CHANGE = 21,
    EVENT_SKY_ROOM_FLOOR_CHANGE = 22,

    //BRANN AND SJONNIR
    EVENT_GO_TO_SJONNIR = 23,
    EVENT_DOOR_OPEN = 24,
    EVENT_RESUME_ESCORT = 25,
    EVENT_SJONNIR_END_BRANN_YELL = 26,
    EVENT_SJONNIR_END_BRANN_LAST_YELL = 27,
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

class brann_bronzebeard : public CreatureScript
{
public:
    brann_bronzebeard() : CreatureScript("brann_bronzebeard") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        InstanceScript* pInstance = (creature->GetInstanceScript());

        player->TalkedToCreature(creature->GetEntry(), creature->GetGUID());
        player->PrepareGossipMenu(creature, 0, true);
        if (pInstance)
        {
            uint32 brann = pInstance->GetData(BRANN_BRONZEBEARD);
            switch (brann)
            {
                case 1:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    SendGossipMenuFor(player, TEXT_ID_START, creature->GetGUID());
                    break;
                case 2:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                    SendGossipMenuFor(player, TEXT_ID_TRIBUNAL_START, creature->GetGUID());
                    break;
                case 3:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    SendGossipMenuFor(player, TEXT_ID_TRIBUNAL_END, creature->GetGUID());
                    break;
                case 4:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                    SendGossipMenuFor(player, TEXT_ID_SJONNIR_DOOR, creature->GetGUID());
                    break;
                case 5:
                    SendGossipMenuFor(player, TEXT_ID_SJONNIR_END, creature->GetGUID());
                    break;
                default:
                    break;
            }
        }
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*sender*/, uint32 action) override
    {
        if (action)
        {
            switch (action)
            {
                case GOSSIP_ACTION_INFO_DEF+1:
                    creature->AI()->DoAction(ACTION_START_ESCORT_EVENT);
                    CloseGossipMenuFor(player);
                    break;
                case GOSSIP_ACTION_INFO_DEF+2:
                    creature->AI()->DoAction(ACTION_START_TRIBUNAL);
                    CloseGossipMenuFor(player);
                    break;
                case GOSSIP_ACTION_INFO_DEF+3:
                    creature->AI()->DoAction(ACTION_GO_TO_SJONNIR);
                    CloseGossipMenuFor(player);
                    break;
                case GOSSIP_ACTION_INFO_DEF+4:
                    creature->AI()->DoAction(ACTION_OPEN_DOOR);
                    CloseGossipMenuFor(player);
                    break;
            }
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new brann_bronzebeardAI (creature);
    }

    struct brann_bronzebeardAI : public npc_escortAI
    {
        brann_bronzebeardAI(Creature* c) : npc_escortAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        ObjectGuid AbedneumGUID;
        ObjectGuid MarnakGUID;
        ObjectGuid KaddrakGUID;
        ObjectGuid darkMatterTargetGUID;

        uint8 WaveNum;

        bool TalkEvent;
        uint32 SpeechCount, SpeechPause;
        bool canExecuteEvents = true;

        void DespawnHeads()
        {
            Creature* cr;
            if ((cr = GetAbedneum())) cr->DespawnOrUnsummon();
            if ((cr = GetMarnak())) cr->DespawnOrUnsummon();
            if ((cr = GetKaddrak())) cr->DespawnOrUnsummon();

            SwitchHeadVisaul(0x7, false);
        }

        void SwitchHeadVisaul(uint8 headMask, bool activate)
        {
            if (!pInstance)
                return;

            GameObject* go = nullptr;
            if (headMask & 0x1) // Kaddrak
                if ((go = me->GetMap()->GetGameObject(pInstance->GetGuidData(GO_KADDRAK))))
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
                if ((go = me->GetMap()->GetGameObject(pInstance->GetGuidData(GO_MARNAK))))
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
                if ((go = me->GetMap()->GetGameObject(pInstance->GetGuidData(GO_ABEDNEUM))))
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

        void ResetEvent()
        {
            if (GameObject* tribunal = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(GO_TRIBUNAL_CONSOLE)))
                tribunal->SetGoState(GO_STATE_READY);

            if (GameObject* tribunalSkyFloor = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(GO_SKY_FLOOR)))
                tribunalSkyFloor->SetGoState(GO_STATE_READY);

            events.Reset();
            summons.DespawnAll();
            DespawnHeads();

            WaveNum = 0;
            SpeechCount = 0;
            SpeechPause = 0;
            TalkEvent = false;
        }

        void WaypointReached(uint32 id) override;
        void InitializeEvent();

        Creature* GetAbedneum() { return ObjectAccessor::GetCreature(*me, AbedneumGUID); }
        Creature* GetMarnak() { return ObjectAccessor::GetCreature(*me, MarnakGUID); }
        Creature* GetKaddrak() { return ObjectAccessor::GetCreature(*me, KaddrakGUID); }

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

            me->SetFaction(FACTION_FRIENDLY);
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

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_START_ESCORT_EVENT:
                    Start(false, true, ObjectGuid::Empty, 0, true, false);
                    Talk(SAY_BRANN_ESCORT_START);
                    me->SetFaction(FACTION_ESCORTEE_N_NEUTRAL_PASSIVE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetRegeneratingHealth(false);
                    break;
                case ACTION_START_TRIBUNAL:
                {
                    me->SetReactState(REACT_PASSIVE);
                    Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
                    if (!PlayerList.IsEmpty())
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                        {
                            me->SetFaction(i->GetSource()->GetFaction());
                            break;
                        }

                    SetEscortPaused(false);
                    InitializeEvent();
                    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    break;
                }
                case ACTION_TRIBUNAL_WIPE_START:
                    SetNextWaypoint(1, false);
                    SetEscortPaused(false);
                    ResetEvent();
                    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    break;
                case ACTION_GO_TO_SJONNIR:
                    Talk(SAY_BRANN_ENTRANCE_MEET);
                    me->SetFaction(FACTION_FRIENDLY);
                    me->SetReactState(REACT_PASSIVE);
                    me->SetRegeneratingHealth(true);
                    SetEscortPaused(false);
                    ResetEvent();
                    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    DoCast(me, 58506, false);
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);
                    me->SendMovementFlagUpdate();
                    break;
                case ACTION_START_SJONNIR_FIGHT:
                    me->SetFaction(FACTION_FRIENDLY);
                    SetEscortPaused(false);
                    break;
                case ACTION_SJONNIR_DEAD:
                    if (pInstance)
                        pInstance->SetData(BRANN_BRONZEBEARD, 5);
                    SetEscortPaused(false);
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                    me->SetOrientation(3.132660f);
                    me->SendMovementFlagUpdate();
                    events.ScheduleEvent(EVENT_SJONNIR_END_BRANN_YELL, 10000ms);
                    events.ScheduleEvent(EVENT_SJONNIR_END_BRANN_LAST_YELL, 22000ms);
                    break;
                case ACTION_SJONNIR_WIPE_START:
                    Reset();
                    SetNextWaypoint(33, true);
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);
                    me->StopMovingOnCurrentPos();
                    DoCast(me, 58506, false);
                    if (GameObject* door = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(GO_SJONNIR_DOOR)))
                        door->SetGoState(GO_STATE_READY);
                    break;
                case ACTION_OPEN_DOOR:
                    Start(false, true, ObjectGuid::Empty, 0, true, false);
                    SetNextWaypoint(34, false);
                    SetEscortPaused(false);
                    me->RemoveAura(58506);
                    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    me->SetWalk(true);
                    me->SetSpeed(MOVE_WALK, 1.0f);
                    break;
            }
        }

        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() == NPC_ABEDNEUM || cr->GetEntry() == NPC_KADDRAK || cr->GetEntry() == NPC_MARNAK)
                cr->SetCanFly(true);
            else
                summons.Summon(cr);
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
                                kaddrak->CastSpell(plr, DUNGEON_MODE(SPELL_GLARE_OF_THE_TRIBUNAL, SPELL_GLARE_OF_THE_TRIBUNAL_H), true);
                        }

                        events.RescheduleEvent(EVENT_KADDRAK_SWITCH_EYE, 1000ms);
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

                                events.RescheduleEvent(EVENT_DARK_MATTER_START, 5000ms);
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

                                float speed = 10.0f;
                                float tooFarAwaySpeed = me->GetDistance(plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ()) / (5000.0f * 0.001f);
                                if (speed < tooFarAwaySpeed)
                                    speed = tooFarAwaySpeed;

                                darkMatterTarget->MonsterMoveWithSpeed(plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ(), speed);

                                if (darkMatterTarget->GetDistance(plr) < 15.0f)
                                {
                                    events.RescheduleEvent(EVENT_DARK_MATTER_END, 3000ms);
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
                            darkMatterTarget->CastSpell(darkMatterTarget, darkMatterTarget->GetMap()->IsHeroic() ? SPELL_DARK_MATTER_H : SPELL_DARK_MATTER, true);
                            darkMatterTarget->DespawnOrUnsummon(500);
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
                                cr->CastSpell(cr, DUNGEON_MODE(SPELL_SEARING_GAZE, SPELL_SEARING_GAZE_H), true);
                            }
                        }
                        events.Repeat(15s);
                        break;
                    }
                    case EVENT_SUMMON_MONSTERS:
                    {
                        if (!canExecuteEvents)
                            return;
                        uint32 Time = 40000 - (2500 * WaveNum);
                        SummonCreatures(NPC_DARK_RUNE_PROTECTOR, 3, 0);
                        if (WaveNum > 2)
                            events.ScheduleEvent(EVENT_SUMMON_STORMCALLER, urand(10 - WaveNum, 15 - WaveNum) * 1000);
                        if (WaveNum > 5)
                            events.ScheduleEvent(EVENT_SUMMON_CUSTODIAN, urand(10 - WaveNum, 15 - WaveNum) * 1000);

                        WaveNum++;
                        events.RepeatEvent(Time);
                        break;
                    }
                    case EVENT_SUMMON_STORMCALLER:
                    {
                        if (!canExecuteEvents)
                            return;

                        SummonCreatures(NPC_DARK_RUNE_STORMCALLER, 2, 1);

                        break;
                    }
                    case EVENT_SUMMON_CUSTODIAN:
                    {
                        if (!canExecuteEvents)
                            return;

                        SummonCreatures(NPC_IRON_GOLEM_CUSTODIAN, 1, 1);

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
                            me->CastSpell(me, 59046, true); // credit
                        }

                        me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
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

        void SummonCreatures(uint32 entry, uint8 count, uint8 pos)
        {
            Creature* cr;
            for (int i = 0; i < count; ++i)
            {
                if (pos == 0)
                    cr = me->SummonCreature(entry, 943.088f + urand(0, 5), 401.378f + urand(0, 5), 206.078f, 3.8f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);     //left
                else
                    cr = me->SummonCreature(entry, 964.302f + urand(0, 4), 378.942f + urand(0, 4), 206.078f, 3.85f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);    //right

                if (cr)
                {
                    cr->AI()->AttackStart(me);
                    cr->AddThreat(me, 100.0f);
                    cr->SetInCombatWithZone();
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
    if ((cr = me->SummonCreature(NPC_KADDRAK, 923.7f, 326.9f, 219.5f, 2.1f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
    {
        cr->SetInCombatWithZone();
        KaddrakGUID = cr->GetGUID();
    }
    if ((cr = me->SummonCreature(NPC_MARNAK, 895.974f, 363.571f, 219.337f, 5.5f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
    {
        cr->SetInCombatWithZone();
        MarnakGUID = cr->GetGUID();
    }
    if ((cr = me->SummonCreature(NPC_ABEDNEUM, 892.25f, 331.25f, 223.86f, 0.6f, TEMPSUMMON_TIMED_DESPAWN, 580000)))
    {
        cr->SetInCombatWithZone();
        AbedneumGUID = cr->GetGUID();
    }

    TalkEvent = true;

    events.Reset();

    // Viusals
    events.ScheduleEvent(EVENT_KADDRAK_VISUAL, 30s);
    events.ScheduleEvent(EVENT_MARNAK_VISUAL, 105s);
    events.ScheduleEvent(EVENT_ABEDNEUM_VISUAL, 207s);

    // Fight
    events.ScheduleEvent(EVENT_SUMMON_MONSTERS, 47s);
    events.ScheduleEvent(EVENT_KADDRAK_HEAD, 47s);
    events.ScheduleEvent(EVENT_MARNAK_HEAD, 115s);
    events.ScheduleEvent(EVENT_ABEDNEUM_HEAD, 217s);
    events.ScheduleEvent(EVENT_TRIBUNAL_END, 310s);
}

void brann_bronzebeard::brann_bronzebeardAI::WaypointReached(uint32 id)
{
    switch (id)
    {
        // Stop before stairs and ask to start
        case 14:
            SetEscortPaused(true);
            if (pInstance)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                Talk(SAY_BRANN_EVENT_INTRO_1);
                me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                pInstance->SetData(BRANN_BRONZEBEARD, 2);
            }
            break;
        // In front of Console
        case 16:
            SetEscortPaused(true);
            if (pInstance)
            {
                pInstance->SetData(BOSS_TRIBUNAL_OF_AGES, IN_PROGRESS);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
                if (GameObject* tribunal = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(GO_TRIBUNAL_CONSOLE)))
                    tribunal->SetGoState(GO_STATE_ACTIVE);
            }
            break;
        //Tribunal end, stand in the middle of the sky room
        case 17:
            SetEscortPaused(true);
            me->SetOrientation(3.91672f);
            me->SendMovementFlagUpdate();
            break;
        //Run to the skyroom door and then teleport before Sjonnir's door
        case 18:
            SetEscortPaused(true);
            SetNextWaypoint(33, false);
            if (pInstance)
            {
                pInstance->SetData(BRANN_BRONZEBEARD, 4);
                me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(NPC_SJONNIR)))
                    cr->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetOrientation(3.132660f);
                DoCast(me, 58506, false);
                me->SendMovementFlagUpdate();
                me->SetHomePosition(1199.8f, 667.138f, 196.242f, 3.12967f);
                me->Relocate(1199.8f, 667.138f, 196.242f, 3.12967f);
            }
            break;
        // Before Sjonnir's door
        case 33:
            SetEscortPaused(true);
            break;
        //Walk to the door, run after opening it
        case 34:
            SetEscortPaused(true);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
            me->SendMovementFlagUpdate();
            events.ScheduleEvent(EVENT_DOOR_OPEN, 1500);
            me->SetWalk(false);
            me->SetSpeed(MOVE_RUN, 1.0f, false);
            events.ScheduleEvent(EVENT_RESUME_ESCORT, 3500);
            break;
        //Brann stops in front of Sjonnir and awaits the start of the battle.
        case 36:
            SetEscortPaused(true);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);
            me->SendMovementFlagUpdate();
            Talk(SAY_BRANN_FRONT_OF_SJONNIR);
            break;
        //Brann steps back and uses the Sjonnir console.
        case 38:
            SetEscortPaused(true);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
            if (pInstance)
            {
                if (GameObject* console = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(GO_SJONNIR_CONSOLE)))
                    console->SetGoState(GO_STATE_ACTIVE);
            }
            break;
        //After Sjonnir's death, Brann steps away from the console and talk.
        case 39:
            SetEscortPaused(true);
            break;
        //Brann steps back and uses the Sjonnir console.
        case 40:
            SetEscortPaused(true);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
            break;
    }
}

class dark_rune_protectors : public CreatureScript
{
public:
    dark_rune_protectors() : CreatureScript("dark_rune_protectors") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new dark_rune_protectorsAI (creature);
    }

    struct dark_rune_protectorsAI : public ScriptedAI
    {
        dark_rune_protectorsAI(Creature* c) : ScriptedAI(c) { }

        EventMap events;
        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit*) override
        {
            events.ScheduleEvent(EVENT_DRP_CHARGE, 10s);
            events.ScheduleEvent(EVENT_DRP_CLEAVE, 7s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_DRP_CHARGE:
                    {
                        if (Unit* tgt = SelectTarget(SelectTargetMethod::Random, 0))
                            me->CastSpell(tgt, SPELL_DRP_CHARGE, false);

                        events.Repeat(10s);
                        break;
                    }
                case EVENT_DRP_CLEAVE:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_DRP_CLEAVE, false);
                        events.Repeat(7s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class dark_rune_stormcaller : public CreatureScript
{
public:
    dark_rune_stormcaller() : CreatureScript("dark_rune_stormcaller") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new dark_rune_stormcallerAI (creature);
    }

    struct dark_rune_stormcallerAI : public ScriptedAI
    {
        dark_rune_stormcallerAI(Creature* c) : ScriptedAI(c) { }

        EventMap events;
        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit*) override
        {
            events.ScheduleEvent(EVENT_DRS_LIGHTNING_BOLD, 5s);
            events.ScheduleEvent(EVENT_DRS_SHADOW_WORD_PAIN, 12s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_DRS_LIGHTNING_BOLD:
                    {
                        me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_DRS_LIGHTING_BOLT_H : SPELL_DRS_LIGHTING_BOLT, false);
                        events.Repeat(5s);
                        break;
                    }
                case EVENT_DRS_SHADOW_WORD_PAIN:
                    {
                        me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_DRS_SHADOW_WORD_PAIN_H : SPELL_DRS_SHADOW_WORD_PAIN, false);
                        events.Repeat(12s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class iron_golem_custodian : public CreatureScript
{
public:
    iron_golem_custodian() : CreatureScript("iron_golem_custodian") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new iron_golem_custodianAI (creature);
    }

    struct iron_golem_custodianAI : public ScriptedAI
    {
        iron_golem_custodianAI(Creature* c) : ScriptedAI(c) { }
        EventMap events;
        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit*) override
        {
            events.ScheduleEvent(EVENT_IGC_CRUSH, 6s);
            events.ScheduleEvent(EVENT_IGC_GROUND_SMASH, 4s);
        }
        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_IGC_CRUSH:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_IGC_CRUSH_ARMOR, false);
                        events.Repeat(6s);
                        break;
                    }
                case EVENT_IGC_GROUND_SMASH:
                    {
                        me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_IGC_GROUND_SMASH_H : SPELL_IGC_GROUND_SMASH, false);
                        events.Repeat(5s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_hos_dark_matter : public AuraScript
{
    PrepareAuraScript(spell_hos_dark_matter);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DARK_MATTER_H, SPELL_DARK_MATTER });
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, caster->GetMap()->IsHeroic() ? SPELL_DARK_MATTER_H : SPELL_DARK_MATTER, true);
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
    new dark_rune_protectors();
    new dark_rune_stormcaller();
    new iron_golem_custodian();
    RegisterSpellScript(spell_hos_dark_matter);
    RegisterSpellScript(spell_hos_dark_matter_size);
}
