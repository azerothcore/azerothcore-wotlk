/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "halls_of_stone.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"
#include "Player.h"

#define GOSSIP_ITEM_1       "Brann, it would be our honor!"
#define GOSSIP_ITEM_2       "Let's move Brann, enough of the history lessons!"
#define GOSSIP_ITEM_3       "We dont have time for this right now, we have to keep going."
#define GOSSIP_ITEM_4       "We're with you Brann! Open it!"
#define TEXT_ID_START       13100
#define YELL_AGGRO          "You be dead soon enough!"

enum NPCs
{
    NPC_DARK_RUNE_PROTECTOR         = 27983,
    NPC_DARK_RUNE_STORMCALLER       = 27984,
    NPC_IRON_GOLEM_CUSTODIAN        = 27985,
    NPC_DARK_MATTER_TRIGGER         = 28237,
    NPC_SEARING_GAZE_TRIGGER        = 28265,
};

enum Misc
{
    // BRANN EVENT
    SPELL_GLARE_OF_THE_TRIBUNAL     = 50988,
    SPELL_GLARE_OF_THE_TRIBUNAL_H   = 59870,
    SPELL_DARK_MATTER_VISUAL        = 51001,
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

    // ACTIONS
    ACTION_START_EVENT              = 0,
    ACTION_START_TRIBUNAL           = 1,
    ACTION_GO_TO_SJONNIR            = 2,
    ACTION_START_SJONNIR_FIGHT      = 3,
    ACTION_SJONNIR_DEAD             = 4,
    ACTION_ENTEREVADEMODE           = 5,
    ACTION_WIPE_START               = 6,
    ACTION_OPEN_DOOR                = 7,

    // QUESTS
    QUEST_HALLS_OF_STONE            = 13207,
};

enum events
{
    // BRANN
    EVENT_KADDRAK_HEAD          = 1,
    EVENT_MARNAK_HEAD           = 2,
    EVENT_ABEDNEUM_HEAD         = 3,
    EVENT_SUMMON_MONSTERS       = 4,
    EVENT_TRIBUNAL_END          = 5,
    EVENT_GO_TO_SJONNIR         = 6,
    EVENT_END                   = 7,
    EVENT_KADDRAK_VISUAL        = 8,
    EVENT_MARNAK_VISUAL         = 9,
    EVENT_ABEDNEUM_VISUAL       = 10,
    EVENT_KADDRAK_SWITCH_EYE    = 11,

    // DARK RUNE PROTECTOR
    EVENT_DRP_CHARGE            = 15,
    EVENT_DRP_CLEAVE            = 16,

    // DARK RUNE STORMCALLER
    EVENT_DRS_LIGHTNING_BOLD    = 20,
    EVENT_DRS_SHADOW_WORD_PAIN  = 21,

    // IRON GOLEM CUSTODIAN
    EVENT_IGC_CRUSH             = 30,
    EVENT_IGC_GROUND_SMASH      = 31,
};

struct Yells
{
    uint32 sound;
    const char* text;
    uint32 creature, timer;
};

static Yells Conversation[]=
{
    {14259, "Time to get some answers! Let's get this show on the road!", NPC_BRANN, 0},
    {14247, "Take a moment and relish this with me. Soon... all will be revealed. Okay then, let's do this!", NPC_BRANN, 5000},
    {14248, "Now keep an eye out! I'll have this licked in two shakes of a--", NPC_BRANN, 17000},
    {13765, "Warning: life form pattern not recognized. Archival processing terminated. Continued interference will result in targeted response.", NPC_ABEDNEUM, 20500},
    {14249, "Oh, that doesn't sound good. We might have a complication or two...", NPC_BRANN, 32000},
    {13756, "Security breach in progress. Analysis of historical archives transferred to lower-priority queue. Countermeasures engaged.", NPC_KADDRAK, 37000},
    {14250, "Ah, you want to play hardball, eh? That's just my game!", NPC_BRANN, 49000},
    {14251, "Couple more minutes and I'll--", NPC_BRANN, 100000},
    {13761, "Threat index threshold exceeded. Celestial archive aborted. Security level heightened.", NPC_MARNAK, 105000},
    {14252, "Heightened? What's the good news?", NPC_BRANN, 116000},
    {14253, "So that was the problem? Now I'm makin' progress...", NPC_BRANN, 195000},
    {13767, "Critical threat index. Void analysis diverted. Initiating sanitization protocol.", NPC_ABEDNEUM, 205000},
    {14254, "Hang on! Nobody's gonna' be sanitized as long as I have a say in it!", NPC_BRANN, 215000},
    {14255, "Ha! The old magic fingers finally won through! Now let's get down to--", NPC_BRANN, 295000},
    {13768, "Alert: security fail-safes deactivated. Beginning memory purge and... ", NPC_ABEDNEUM, 303000},
    //The fight is completed at this point.
    {14256, "Purge? No no no no no.. where did I-- Aha, this should do the trick...", NPC_BRANN, 310000},
    {13769, "System online. Life form pattern recognized. Welcome, Branbronzan. Query?", NPC_ABEDNEUM, 321000},
    {14263, "Query? What do you think I'm here for, tea and biscuits? Spill the beans already!", NPC_BRANN, 329000},
    {14264, "Tell me how the dwarves came to be, and start at the beginning!", NPC_BRANN, 336000},
    {13770, "Accessing prehistoric data... retrieved. In the beginning the earthen were created to--", NPC_ABEDNEUM, 342000},
    {14265, "Right, right... I know the earthen were made from stone to shape the deep regions o' the world. But what about the anomalies? Matrix non-stabilizin' and what-not?", NPC_BRANN, 348000},
    {13771, "Accessing... In the early stages of it's development cycle, Azeroth suffered infection by parasitic necrophotic symbiotes.", NPC_ABEDNEUM, 360000},
    {14266, "Necrowhatinthe-- Speak bloody Common, will ye?", NPC_BRANN, 373500},
    {13772, "Designation: Old Gods. Old Gods rendered all systems, including earthen, defenseless in order to facilitate assimilation. This matrix destabilization has been termed the Curse of Flesh. Effects of destabilization increased over time.", NPC_ABEDNEUM, 380000},
    {14267, "Old Gods, huh? So they zapped the earthen with this Curse of Flesh... and then what?", NPC_BRANN, 399500},
    {13757, "Accessing... Creators arrived to extirpate symbiotic infection. Assessment revealed that Old God infestation had grown malignant. Excising parasites would result in loss of host--", NPC_KADDRAK, 406000},
    {14268, "If they killed the Old Gods, Azeroth would've been destroyed...", NPC_BRANN, 424000},
    {13758, "Correct. Creators neutralized parasitic threat and contained it within the host. Forge of Wills and other systems were instituted to create new earthen. Safeguards were implemented, and protectors were appointed.", NPC_KADDRAK, 429000},
    {14269, "What protectors?", NPC_BRANN, 449000},
    {13759, "Designations: Aesir and Vanir. Or in the common nomenclature, storm and earth giants. Sentinel Loken designated supreme. Dragon Aspects appointed to monitor evolution on Azeroth.", NPC_KADDRAK, 452000},
    {14270, "Aesir and Vanir... Okay, so the Forge o' Wills started makin' new earthen... but what happened to the old ones?", NPC_BRANN, 471000},
    {13762, "Additional background is relevant to your query: following global combat between Aesir and Vanir--", NPC_MARNAK, 482000},
    {14271, "Hold everything! The Aesir and Vanir went to war? Why?", NPC_BRANN, 489000},
    {13763, "Unknown. Data suggests that impetus for global combat originated with prime designate Loken, who neutralized all remaining Aesir and Vanir, affecting termination of conflict. Prime designate Loken then initiated stasis of several seed races, including earthen, giants and vrykul, at designated holding facilities.", NPC_MARNAK, 494000},
    {14272, "This Loken sounds like a nasty character. Glad we don't have to worry about the likes o' him anymore. So... if I'm understandin' ye right, the original earthen eventually woke up from this stasis, and by that time the destabili-whatever had turned 'em into proper dwarves. Or at least... dwarf ancestors.", NPC_BRANN, 519000},
    {13764, "Essentially that is correct.", NPC_MARNAK, 543000},
    {14273, "Well, now... that's a lot to digest. I'm gonna need some time to take all this in. Thank ye.", NPC_BRANN, 549000},
    {13773, "Acknowledged, Branbronzan. Session terminated.", NPC_ABEDNEUM, 559000},
    {0, "I think it's time to see what's behind the door near the entrance. I'm going to sneak over there, nice and quiet. Meet me at the door and I'll get us in.", NPC_BRANN, 574000},
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
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                break;
            case 2:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                break;
            case 3:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
                break;
            case 4:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
                break;
            case 5:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                break;
            default: break;
            }

        }
        SendGossipMenuFor(player, TEXT_ID_START, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *creature, uint32  /*sender*/, uint32 action) override
    {
        if (action)
        {
            switch (action)
            {
            case GOSSIP_ACTION_INFO_DEF+1:
                creature->AI()->DoAction(ACTION_START_EVENT);
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
                creature->AI()->DoAction(ACTION_WIPE_START);
                CloseGossipMenuFor(player);
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
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

        brann_bronzebeardAI(Creature *c) : npc_escortAI(c), summons(me)
        {
            AbedneumGUID = MarnakGUID = KaddrakGUID = 0;
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint64 AbedneumGUID;
        uint64 MarnakGUID;
        uint64 KaddrakGUID;
        uint8 WaveNum;

        bool TalkEvent;
        uint32 SpeechCount, SpeechPause;

        void DespawnHeads()
        {
            Creature *cr;
            if ((cr = GetAbedneum())) cr->DespawnOrUnsummon();
            if ((cr = GetMarnak())) cr->DespawnOrUnsummon();
            if ((cr = GetKaddrak())) cr->DespawnOrUnsummon();
            SwitchHeadVisaul(0x7, false);
        }

        void SwitchHeadVisaul(uint8 headMask, bool activate)
        {
            if (!pInstance)
                return;

            GameObject *go = nullptr;
            if (headMask & 0x1) // Kaddrak
                if ((go = me->GetMap()->GetGameObject(pInstance->GetData64(GO_KADDRAK))))
                    activate ? go->SendCustomAnim(0) : go->SetGoState(GO_STATE_READY);

            if (headMask & 0x2) // Marnak
                if ((go = me->GetMap()->GetGameObject(pInstance->GetData64(GO_MARNAK))))
                    activate ? go->SendCustomAnim(0) : go->SetGoState(GO_STATE_READY);

            if (headMask & 0x4) // Abedneum
                if ((go = me->GetMap()->GetGameObject(pInstance->GetData64(GO_ABEDNEUM))))
                    activate ? go->SendCustomAnim(0) : go->SetGoState(GO_STATE_READY);
        }

        void ResetEvent()
        {
            if (GameObject *tribunal = ObjectAccessor::GetGameObject(*me, pInstance->GetData64(GO_TRIBUNAL_CONSOLE)))
                tribunal->SetGoState(GO_STATE_READY);

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

        void MoveInLineOfSight(Unit*  /*pWho*/) override { }
        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask) override
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

            me->setFaction(35);
            me->SetReactState(REACT_PASSIVE);
            me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);

            if(pInstance)
            {
                pInstance->SetData(BRANN_BRONZEBEARD, 1);
                pInstance->SetData(DATA_BRANN_ACHIEVEMENT, true);

                if (pInstance->GetData(BOSS_TRIBUNAL_OF_AGES) == DONE)
                    pInstance->SetData(BRANN_BRONZEBEARD, (pInstance->GetData(BOSS_SJONNIR) == DONE) ? 5 : 4);
            }
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_START_EVENT:
                    Start(false, true, 0, 0, true, false);
                    break;
                case ACTION_START_TRIBUNAL:
                {
                    Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                        if (!PlayerList.isEmpty())
                            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            {
                                me->setFaction(i->GetSource()->getFaction());
                                break;
                            }

                    SetEscortPaused(false);
                    InitializeEvent();
                    me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
                    break;
                }
                case ACTION_GO_TO_SJONNIR:
                    SetEscortPaused(false);
                    ResetEvent();
                    me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
                    break;
                case ACTION_START_SJONNIR_FIGHT:
                    me->setFaction(35);
                    me->MonsterYell("Don't worry! Ol' Brann's got yer back! Keep that metal monstrosity busy, and I'll see if I can't sweet talk this machine into helping ye!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(14274);
                    SetEscortPaused(false);
                    break;
                case ACTION_SJONNIR_DEAD:
                    me->MonsterYell("Loken? That's downright bothersome... We might've neutralized the iron dwarves, but I'd lay odds there's another machine somewhere else churnin' out a whole mess o' these iron vrykul!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(14278);
                    events.ScheduleEvent(EVENT_END, 14000);
                    break;
                case ACTION_ENTEREVADEMODE:
                    RemoveEscortState(0x7); // all states
                    me->SetHomePosition(1077.41f, 474.16f, 207.8f, 2.70526f);
                    me->UpdatePosition(1077.41f, 474.16f, 207.9f, 2.70526f, true);
                    me->StopMovingOnCurrentPos();
                    Reset();
                    break;
                case ACTION_WIPE_START:
                    Start(false, true, 0, 0, true, false);
                    SetNextWaypoint(20, false);
                    ResetEvent();
                    me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
                    break;
                case ACTION_OPEN_DOOR:
                    if (GameObject *door = ObjectAccessor::GetGameObject(*me, pInstance->GetData64(GO_SJONNIR_DOOR)))
                        door->SetGoState(GO_STATE_ACTIVE);
                    SetEscortPaused(false);
                    me->RemoveAura(58506);
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
            switch (events.GetEvent())
            {
                case EVENT_KADDRAK_VISUAL:
                {
                    SwitchHeadVisaul(0x1, true);
                    events.PopEvent();
                    break;
                }
                case EVENT_MARNAK_VISUAL:
                {
                    SwitchHeadVisaul(0x2, true);
                    events.PopEvent();
                    break;
                }
                case EVENT_ABEDNEUM_VISUAL:
                {
                    SwitchHeadVisaul(0x4, true);
                    events.PopEvent();
                    break;
                }
                case EVENT_KADDRAK_HEAD: // First
                {
                    if (Creature *kaddrak = GetKaddrak())
                    {
                        if (Player *plr = SelectTargetFromPlayerList(100.0f))
                            kaddrak->CastSpell(plr, DUNGEON_MODE(SPELL_GLARE_OF_THE_TRIBUNAL, SPELL_GLARE_OF_THE_TRIBUNAL_H), true);
                    }

                    events.RescheduleEvent(EVENT_KADDRAK_SWITCH_EYE, 1500);
                    events.RepeatEvent(2000+urand(0,2000));
                    break;
                }
                case EVENT_KADDRAK_SWITCH_EYE:
                {
                    if (Creature *kaddrak = GetKaddrak())
                    {
                        if (urand(0,1))
                            kaddrak->UpdatePosition(927.9f, 330.9f, 219.4f, 2.4f, true);
                        else
                            kaddrak->UpdatePosition(923.7f, 326.9f, 219.5f, 2.1f, true);

                        kaddrak->StopMovingOnCurrentPos();
                    }

                    events.PopEvent();
                    break;
                }
                case EVENT_MARNAK_HEAD: // Second
                {
                    if (Creature *marnak = GetMarnak())
                    {
                        if (Creature *cr = me->SummonCreature(NPC_DARK_MATTER_TRIGGER, marnak->GetPositionX(), marnak->GetPositionY(), marnak->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 7000))
                        {
                            cr->CastSpell(cr, SPELL_DARK_MATTER_VISUAL, true);
                            if (Player *plr = SelectTargetFromPlayerList(100.0f))
                            {
                                float speed = me->GetDistance(plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ()) / (4000.0f * 0.001f);
                                cr->MonsterMoveWithSpeed(plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ(), speed);
                            }
                        }
                    }
                    events.RepeatEvent(20000);
                    break;
                }
                case EVENT_ABEDNEUM_HEAD: // Third
                {
                    if (GetAbedneum())
                    {
                        Player *plr = SelectTargetFromPlayerList(100.0f);
                        if (!plr)
                            break;

                        if (Creature *cr = me->SummonCreature(NPC_SEARING_GAZE_TRIGGER, plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
                        {
                            // summon another abedneum to create double beam, despawn just after trigger despawn
                            me->SummonCreature(NPC_ABEDNEUM, 897.0f, 326.9f, 223.5f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 12000);
                            cr->CastSpell(cr, DUNGEON_MODE(SPELL_SEARING_GAZE, SPELL_SEARING_GAZE_H), true);
                        }
                    }
                    events.RepeatEvent(30000);
                    break;
                }
                case EVENT_SUMMON_MONSTERS:
                {
                    uint32 Time = 45000 - (2500*WaveNum);
                    SummonCreatures(NPC_DARK_RUNE_PROTECTOR, 3);
                    if (WaveNum > 2)
                        SummonCreatures(NPC_DARK_RUNE_STORMCALLER, 2);
                    if (WaveNum > 5)
                        SummonCreatures(NPC_IRON_GOLEM_CUSTODIAN, 1);

                    WaveNum++;
                    events.RepeatEvent(Time);
                    break;
                }
                case EVENT_TRIBUNAL_END:
                {
                    // Has to be here!
                    events.Reset();
                    //DespawnHeads();
                    summons.DespawnAll();

                    if (pInstance)
                    {
                        pInstance->SetData(BOSS_TRIBUNAL_OF_AGES, DONE);
                        pInstance->SetData(BRANN_BRONZEBEARD, 3);
                        me->CastSpell(me, 59046, true); // credit
                    }

                    me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);


                    // Spawn Chest and quest credit
                    if (Player *plr = SelectTargetFromPlayerList(200.0f))
                    {
                        if (GameObject* go = plr->SummonGameObject((IsHeroic() ? GO_TRIBUNAL_CHEST_H : GO_TRIBUNAL_CHEST), 880.406f, 345.164f, 203.706f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0))
                        {
                            plr->RemoveGameObject(go, false);
                            go->SetLootMode(1);
                            go->SetUInt32Value(GAMEOBJECT_FLAGS, 0);
                        }

                        plr->GroupEventHappens(QUEST_HALLS_OF_STONE, me);
                    }

                    events.ScheduleEvent(EVENT_GO_TO_SJONNIR, 279000);
                    break;
                }
                case EVENT_GO_TO_SJONNIR:
                {

                    if (GameObject *door = ObjectAccessor::GetGameObject(*me, pInstance->GetData64(GO_SJONNIR_DOOR)))
                        door->SetGoState(GO_STATE_ACTIVE);
                    SetEscortPaused(false);
                    ResetEvent();
                    me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
                    break;
                }
                case EVENT_END:
                {
                    events.Reset();
                    if (pInstance)
                        pInstance->SetData(BRANN_BRONZEBEARD, 6);

                    me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                    me->MonsterYell("I'll use the forge to make batches o' earthen to stand guard... But our greatest challenge still remains: find and stop Loken!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(14279);
                    break;
                }
            }

            if (TalkEvent)
            {
                SpeechPause += diff;
                if (SpeechPause >= Conversation[SpeechCount].timer)
                {
                    Creature* cs = nullptr;
                    switch (Conversation[SpeechCount].creature)
                    {
                        case NPC_BRANN:     cs = me; break;
                        case NPC_ABEDNEUM:  cs = GetAbedneum(); break;
                        case NPC_KADDRAK:   cs = GetKaddrak(); break;
                        case NPC_MARNAK:    cs = GetMarnak(); break;
                    }

                    if (cs)
                    {
                        cs->MonsterYell(Conversation[SpeechCount].text, LANG_UNIVERSAL, 0);
                        cs->PlayDirectSound(Conversation[SpeechCount].sound);
                    }

                    if (SpeechCount < 38)
                        SpeechPause = Conversation[SpeechCount++].timer;
                    else
                        TalkEvent = false;
                }
            }
        }
        
        void SummonCreatures(uint32 entry, uint8 count)
        {
            for (int i = 0; i < count; ++i)
            {
                Creature* cr = me->SummonCreature(entry, 946.5971f+urand(0,6), 383.5330f+urand(0,6), 205.9943f, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN,20000);
                if(cr)
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
            if(pInstance)
            {
                if (Creature *brann = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_BRANN)))
                {
                    brann->setDeathState(JUST_DIED);
                    brann->Respawn();
                    brann->AI()->DoAction(5);
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
    events.ScheduleEvent(EVENT_SUMMON_MONSTERS, 21000);
    events.ScheduleEvent(EVENT_KADDRAK_HEAD, 20000);
    events.ScheduleEvent(EVENT_MARNAK_HEAD, 105000);
    events.ScheduleEvent(EVENT_ABEDNEUM_HEAD, 205000);
    events.ScheduleEvent(EVENT_TRIBUNAL_END, 315000);

    // Viusals
    events.ScheduleEvent(EVENT_KADDRAK_VISUAL, 20000);
    events.ScheduleEvent(EVENT_MARNAK_VISUAL, 105000);
    events.ScheduleEvent(EVENT_ABEDNEUM_VISUAL, 205000);
}

void brann_bronzebeard::brann_bronzebeardAI::WaypointReached(uint32 id)
{
    switch (id)
    {
        // Stop before stairs and ask to start
        case 9:
            SetEscortPaused(true);
            me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            if (pInstance)
                pInstance->SetData(BRANN_BRONZEBEARD, 2);

            break;
        // In front of Console
        case 11:
            SetEscortPaused(true);
            if(pInstance)
            {
                pInstance->SetData(BOSS_TRIBUNAL_OF_AGES, IN_PROGRESS);
                if (GameObject *tribunal = ObjectAccessor::GetGameObject(*me, pInstance->GetData64(GO_TRIBUNAL_CONSOLE)))
                    tribunal->SetGoState(GO_STATE_ACTIVE);
            }
            break;
        // Before Sjonnir's door
        case 27:
            SetEscortPaused(true);
            if(pInstance)
            {
                pInstance->SetData(BRANN_BRONZEBEARD, 5);
                me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                if (Creature *cr = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_SJONNIR)))
                    cr->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetOrientation(3.132660f);
                DoCast(me, 58506, false);
            }
            break;
        case 28:
            SetEscortPaused(true);
            break;
        case 29:
            SetEscortPaused(true);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
            if (pInstance)
                if (GameObject *console = ObjectAccessor::GetGameObject(*me, pInstance->GetData64(GO_SJONNIR_CONSOLE)))
                    console->SetGoState(GO_STATE_ACTIVE);

            break;
    }
}

class dark_rune_protectors : public CreatureScript
{
public:
    dark_rune_protectors() : CreatureScript("dark_rune_protectors") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new dark_rune_protectorsAI (creature);
    }

    struct dark_rune_protectorsAI : public ScriptedAI
    {
        dark_rune_protectorsAI(Creature *c) : ScriptedAI(c) { }

        EventMap events;
        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit *)
        {
            events.ScheduleEvent(EVENT_DRP_CHARGE, 10000);
            events.ScheduleEvent(EVENT_DRP_CLEAVE, 7000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_DRP_CHARGE:
                {
                    if (Unit *tgt = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(tgt, SPELL_DRP_CHARGE, false);

                    events.RepeatEvent(10000);
                    break;
                }
                case EVENT_DRP_CLEAVE:
                {
                    me->CastSpell(me->GetVictim(), SPELL_DRP_CLEAVE, false);
                    events.RepeatEvent(7000);
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

    CreatureAI* GetAI(Creature* creature) const
    {
        return new dark_rune_stormcallerAI (creature);
    }

    struct dark_rune_stormcallerAI : public ScriptedAI
    {
        dark_rune_stormcallerAI(Creature *c) : ScriptedAI(c) { }

        EventMap events;
        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit *)
        {
            events.ScheduleEvent(EVENT_DRS_LIGHTNING_BOLD, 5000);
            events.ScheduleEvent(EVENT_DRS_SHADOW_WORD_PAIN, 12000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_DRS_LIGHTNING_BOLD:
                {
                    me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_DRS_LIGHTING_BOLT_H : SPELL_DRS_LIGHTING_BOLT, false);
                    events.RepeatEvent(5000);
                    break;
                }
                case EVENT_DRS_SHADOW_WORD_PAIN:
                {
                    me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_DRS_SHADOW_WORD_PAIN_H : SPELL_DRS_SHADOW_WORD_PAIN, false);
                    events.RepeatEvent(12000);
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

    CreatureAI* GetAI(Creature* creature) const
    {
        return new iron_golem_custodianAI (creature);
    }

    struct iron_golem_custodianAI : public ScriptedAI
    {
        iron_golem_custodianAI(Creature *c) : ScriptedAI(c) { }
        EventMap events;
        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit *)
        {
            events.ScheduleEvent(EVENT_IGC_CRUSH, 6000);
            events.ScheduleEvent(EVENT_IGC_GROUND_SMASH, 4000);
        }
        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_IGC_CRUSH:
                {
                    me->CastSpell(me->GetVictim(), SPELL_IGC_CRUSH_ARMOR, false);
                    events.RepeatEvent(6000);
                    break;
                }
                case EVENT_IGC_GROUND_SMASH:
                {
                    me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_IGC_GROUND_SMASH_H : SPELL_IGC_GROUND_SMASH, false);
                    events.RepeatEvent(5000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_hos_dark_matter : public SpellScriptLoader
{
    public:
        spell_hos_dark_matter() : SpellScriptLoader("spell_hos_dark_matter") { }

        class spell_hos_dark_matter_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hos_dark_matter_AuraScript);

            void HandleEffectRemove(AuraEffect const * /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit *caster = GetCaster())
                    caster->CastSpell(caster, caster->GetMap()->IsHeroic() ? SPELL_DARK_MATTER_H : SPELL_DARK_MATTER, true);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_hos_dark_matter_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript *GetAuraScript() const
        {
            return new spell_hos_dark_matter_AuraScript();
        }
};

void AddSC_brann_bronzebeard()
{
    new brann_bronzebeard();
    new dark_rune_protectors();
    new dark_rune_stormcaller();
    new iron_golem_custodian();
    new spell_hos_dark_matter();
}
