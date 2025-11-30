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
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldStateDefines.h"

/*######
## npc_lady_sylvanas_windrunner
######*/

enum Sylvanas
{
    QUEST_JOURNEY_TO_UNDERCITY      = 9180,

    EMOTE_LAMENT_END                = 0,
    SAY_LAMENT_END                  = 1,
    EMOTE_LAMENT                    = 2,

    // Ambassador Sunsorrow
    SAY_SUNSORROW_WHISPER           = 0,

    SOUND_CREDIT                    = 10896,

    NPC_HIGHBORNE_LAMENTER          = 21628,
    NPC_HIGHBORNE_BUNNY             = 21641,
    NPC_AMBASSADOR_SUNSORROW        = 16287,

    SPELL_HIGHBORNE_AURA            = 37090,
    SPELL_SYLVANAS_CAST             = 36568,
    //SPELL_RIBBON_OF_SOULS         = 34432, the real one to use might be 37099
    SPELL_RIBBON_OF_SOULS           = 37099,

    // Combat spells
    SPELL_BLACK_ARROW               = 59712,
    SPELL_FADE                      = 20672,
    SPELL_FADE_BLINK                = 29211,
    SPELL_MULTI_SHOT                = 59713,
    SPELL_SHOT                      = 59710,
    SPELL_SUMMON_SKELETON           = 59711,

    // Events
    EVENT_FADE                      = 1,
    EVENT_SUMMON_SKELETON           = 2,
    EVENT_BLACK_ARROW               = 3,
    EVENT_SHOOT                     = 4,
    EVENT_MULTI_SHOT                = 5,
    EVENT_LAMENT_OF_THE_HIGHBORN    = 6,
    EVENT_SUNSORROW_WHISPER         = 7,

    GUID_EVENT_INVOKER              = 1,
};

float HighborneLoc[4][3] =
{
    {1285.41f, 312.47f, 0.51f},
    {1286.96f, 310.40f, 1.00f},
    {1289.66f, 309.66f, 1.52f},
    {1292.51f, 310.50f, 1.99f},
};

#define HIGHBORNE_LOC_Y             -61.00f
#define HIGHBORNE_LOC_Y_NEW         -55.50f

class npc_lady_sylvanas_windrunner : public CreatureScript
{
public:
    npc_lady_sylvanas_windrunner() : CreatureScript("npc_lady_sylvanas_windrunner") { }

    bool OnQuestReward(Player* player, Creature* creature, const Quest* _Quest, uint32 /*slot*/) override
    {
        if (_Quest->GetQuestId() == QUEST_JOURNEY_TO_UNDERCITY)
            creature->AI()->SetGUID(player->GetGUID(), GUID_EVENT_INVOKER);

        return true;
    }

    struct npc_lady_sylvanas_windrunnerAI : public ScriptedAI
    {
        npc_lady_sylvanas_windrunnerAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void Reset() override
        {
            LamentEvent = false;
            playerGUID.Clear();
            _events.Reset();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _events.ScheduleEvent(EVENT_FADE, 30s);
            _events.ScheduleEvent(EVENT_SUMMON_SKELETON, 20s);
            _events.ScheduleEvent(EVENT_BLACK_ARROW, 15s);
            _events.ScheduleEvent(EVENT_SHOOT, 8s);
            _events.ScheduleEvent(EVENT_MULTI_SHOT, 10s);
        }

        void SetGUID(ObjectGuid const& guid, int32 type) override
        {
            if (type == GUID_EVENT_INVOKER)
            {
                Talk(EMOTE_LAMENT);
                DoPlayMusic(SOUND_CREDIT, true);
                DoCast(me, SPELL_SYLVANAS_CAST, false);
                playerGUID = guid;
                LamentEvent = true;

                for (uint8 i = 0; i < 4; ++i)
                    me->SummonCreature(NPC_HIGHBORNE_LAMENTER, HighborneLoc[i][0], HighborneLoc[i][1], HIGHBORNE_LOC_Y, HighborneLoc[i][2], TEMPSUMMON_TIMED_DESPAWN, 160000);

                _events.ScheduleEvent(EVENT_LAMENT_OF_THE_HIGHBORN, 2s);
                _events.ScheduleEvent(EVENT_SUNSORROW_WHISPER, 10s);
            }
        }

        void JustSummoned(Creature* summoned) override
        {
            if (summoned->GetEntry() == NPC_HIGHBORNE_BUNNY)
            {
                summoned->SetDisableGravity(true);
                float speed = summoned->GetDistance(summoned->GetPositionX(), summoned->GetPositionY(), me->GetPositionZ() + 15.0f) / (1000.0f * 0.001f);
                summoned->GetMotionMaster()->MovePoint(0, summoned->GetPositionX(), summoned->GetPositionY(), me->GetPositionZ() + 15.0f, FORCED_MOVEMENT_NONE, speed);
                summoned->CastSpell(summoned, SPELL_RIBBON_OF_SOULS, false);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && !LamentEvent)
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_FADE:
                        DoCast(me, SPELL_FADE);
                        // add a blink to simulate a stealthed movement and reappearing elsewhere
                        DoCast(me, SPELL_FADE_BLINK);
                        // if the victim is out of melee range she cast multi shot
                        if (Unit* victim = me->GetVictim())
                            if (me->GetDistance(victim) > 10.0f)
                                DoCast(victim, SPELL_MULTI_SHOT);
                        _events.ScheduleEvent(EVENT_FADE, 30s,  35s);
                        break;
                    case EVENT_SUMMON_SKELETON:
                        DoCast(me, SPELL_SUMMON_SKELETON);
                        _events.ScheduleEvent(EVENT_SUMMON_SKELETON, 20s, 30s);
                        break;
                    case EVENT_BLACK_ARROW:
                        if (Unit* victim = me->GetVictim())
                            DoCast(victim, SPELL_BLACK_ARROW);
                        _events.ScheduleEvent(EVENT_BLACK_ARROW, 15s, 20s);
                        break;
                    case EVENT_SHOOT:
                        if (Unit* victim = me->GetVictim())
                            DoCast(victim, SPELL_SHOT);
                        _events.ScheduleEvent(EVENT_SHOOT, 8s, 10s);
                        break;
                    case EVENT_MULTI_SHOT:
                        if (Unit* victim = me->GetVictim())
                            DoCast(victim, SPELL_MULTI_SHOT);
                        _events.ScheduleEvent(EVENT_MULTI_SHOT, 10s, 13s);
                        break;
                    case EVENT_LAMENT_OF_THE_HIGHBORN:
                        if (!me->HasAura(SPELL_SYLVANAS_CAST))
                        {
                            Talk(SAY_LAMENT_END);
                            Talk(EMOTE_LAMENT_END);
                            LamentEvent = false;
                            me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
                            Reset();
                        }
                        else
                        {
                            DoSummon(NPC_HIGHBORNE_BUNNY, me, 10.0f, 3000, TEMPSUMMON_TIMED_DESPAWN);
                            _events.ScheduleEvent(EVENT_LAMENT_OF_THE_HIGHBORN, 2s);
                        }
                        break;
                    case EVENT_SUNSORROW_WHISPER:
                        if (Creature* ambassador = me->FindNearestCreature(NPC_AMBASSADOR_SUNSORROW, 20.0f))
                            if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                                ambassador->AI()->Talk(SAY_SUNSORROW_WHISPER, player);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
        bool LamentEvent;
        ObjectGuid playerGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_lady_sylvanas_windrunnerAI(creature);
    }
};

/*######
## npc_highborne_lamenter
######*/

class npc_highborne_lamenter : public CreatureScript
{
public:
    npc_highborne_lamenter() : CreatureScript("npc_highborne_lamenter") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_highborne_lamenterAI(creature);
    }

    struct npc_highborne_lamenterAI : public ScriptedAI
    {
        npc_highborne_lamenterAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 EventMoveTimer;
        uint32 EventCastTimer;
        bool EventMove;
        bool EventCast;

        void Reset() override
        {
            EventMoveTimer = 10000;
            EventCastTimer = 17500;
            EventMove = true;
            EventCast = true;
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            if (EventMove)
            {
                if (EventMoveTimer <= diff)
                {
                    me->SetDisableGravity(true);
                    me->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), HIGHBORNE_LOC_Y_NEW, FORCED_MOVEMENT_NONE, me->GetDistance(me->GetPositionX(), me->GetPositionY(), HIGHBORNE_LOC_Y_NEW) / (5000 * 0.001f));
                    EventMove = false;
                }
                else EventMoveTimer -= diff;
            }
            if (EventCast)
            {
                if (EventCastTimer <= diff)
                {
                    DoCast(me, SPELL_HIGHBORNE_AURA);
                    EventCast = false;
                }
                else EventCastTimer -= diff;
            }
        }
    };
};

/*######
## npc_parqual_fintallas
######*/

enum ParqualFintallas
{
    SPELL_MARK_OF_SHAME             = 6767,
    QUEST_ID_TEST_OF_LORE           = 6628,
    GOSSIP_MENU_ID_TEST_OF_LORE     = 4764,
    GOSSIP_TEXTID_PARQUAL_FINTALLAS = 5821,
    GOSSIP_TEXTID_TEST_OF_LORE      = 5822,
};

class npc_parqual_fintallas : public CreatureScript
{
public:
    npc_parqual_fintallas() : CreatureScript("npc_parqual_fintallas") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            CloseGossipMenuFor(player);
            creature->CastSpell(player, SPELL_MARK_OF_SHAME, false);
        }
        if (action == GOSSIP_ACTION_INFO_DEF + 2)
        {
            CloseGossipMenuFor(player);
            player->AreaExploredOrEventHappens(6628);
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
        }

        if (player->GetQuestStatus(QUEST_ID_TEST_OF_LORE) == QUEST_STATUS_INCOMPLETE && !player->HasAura(SPELL_MARK_OF_SHAME))
        {
            AddGossipItemFor(player, GOSSIP_MENU_ID_TEST_OF_LORE, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            AddGossipItemFor(player, GOSSIP_MENU_ID_TEST_OF_LORE, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            AddGossipItemFor(player, GOSSIP_MENU_ID_TEST_OF_LORE, 3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            SendGossipMenuFor(player, GOSSIP_TEXTID_TEST_OF_LORE, creature->GetGUID());
        }
        else
        {
            SendGossipMenuFor(player, GOSSIP_TEXTID_PARQUAL_FINTALLAS, creature->GetGUID());
        }

        return true;
    }
};

/*######
## ALLIANCE
#######*/

enum WrynnMisc
{
    // Creatures
    NPC_WRYNN = 32401,

    // Texts
    WRYNN_SAY_PREP_1 = 0,
    WRYNN_SAY_PREP_2 = 1,
    WRYNN_SAY_PREP_3 = 2,
    WRYNN_SAY_PREP_4 = 3,
    WRYNN_SAY_PREP_5 = 4,
    WRYNN_SAY_PREP_6 = 5,
    WRYNN_SAY_SEWERS_1 = 6,
    WRYNN_SAY_SEWERS_2 = 7,
    WRYNN_SAY_SEWERS_3 = 8,
    WRYNN_SAY_SEWERS_4 = 9,
    WRYNN_SAY_APO_1 = 10,
    WRYNN_SAY_APO_2 = 11,
    WRYNN_SAY_APO_3 = 12,
    WRYNN_SAY_APO_4 = 13,
    WRYNN_SAY_APO_5 = 14,
    WRYNN_SAY_APO_6 = 15,
    WRYNN_SAY_APO_7 = 16,
    WRYNN_SAY_APO_8 = 17,
    WRYNN_SAY_APO_9 = 18,
    WRYNN_SAY_APO_10 = 19,
    WRYNN_SAY_APO_11 = 20,
    WRYNN_SAY_APO_12 = 21,
    WRYNN_SAY_THRONE_1 = 22,
    WRYNN_SAY_THRONE_2 = 23,
    WRYNN_SAY_THRONE_3 = 24,
    WRYNN_SAY_THRONE_4 = 25,
    WRYNN_SAY_THRONE_5 = 26,
    WRYNN_SAY_THRONE_6 = 27,
    WRYNN_SAY_THRONE_7 = 28,
    WRYNN_SAY_THRONE_8 = 29,
    WRYNN_SAY_THRONE_9 = 30,

    // Spells
    SPELL_WHIRLWIND = 41056,
    SPELL_WRYNN_BUFF = 60964,
    SPELL_HEROIC_LEAP = 57793,

    // Events
    EVENT_WHIRLWIND = 1,
    EVENT_HEROIC_LEAP = 2,
    EVENT_AGGRO_JAINA = 3,
    EVENT_WRYNN_BUFF = 4
};

enum JainaMisc
{
    // Creatures
    NPC_JAINA = 32402,

    // Texts
    JAINA_SAY_SEWERS_1 = 0,
    JAINA_SAY_APO_1 = 1,
    JAINA_SAY_THRONE_1 = 2,
    JAINA_SAY_THRONE_2 = 3,
    JAINA_SAY_THRONE_3 = 4,

    // Spells
    SPELL_FIREBALL = 20692,
    SPELL_BLIZZARD = 20680,
    SPELL_ELEMENTALS = 20681,
    SPELL_DEEPFREEZE = 61224,
    SPELL_JAINA_BUFF = 61011,

    // Events
    EVENT_FIREBALL = 1,
    EVENT_BLIZZARD = 2,
    EVENT_ELEMENTAL = 3
};

/*######
## HORDE
#######*/

enum ThrallMisc
{
    // Creatures
    NPC_THRALL = 32518,

    // Gossips
    GOSSIP_THRALL = 60193,

    // Texts
    THRALL_SAY_THRONE_A_1 = 0,
    THRALL_SAY_THRONE_A_2 = 1,

    THRALL_SAY_PREP_1 = 2,
    THRALL_SAY_PREP_2 = 3,
    THRALL_SAY_PREP_3 = 4,
    THRALL_SAY_PREP_4 = 5,
    THRALL_SAY_PREP_5 = 6,
    THRALL_SAY_PREP_6 = 7,
    THRALL_SAY_PREP_7 = 8,
    THRALL_SAY_PREP_8 = 9,
    THRALL_SAY_COURTYARD_1 = 10,
    THRALL_SAY_COURTYARD_2 = 11,
    THRALL_SAY_COURTYARD_3 = 12,
    THRALL_SAY_COURTYARD_4 = 13,
    THRALL_SAY_COURTYARD_5 = 14,
    THRALL_SAY_ELEVATOR_1 = 15,
    THRALL_SAY_ELEVATOR_2 = 16,
    THRALL_SAY_ELEVATOR_3 = 17,
    THRALL_SAY_SANCTUM_1 = 18,
    THRALL_SAY_SANCTUM_2 = 19,
    THRALL_SAY_SANCTUM_3 = 20,
    THRALL_SAY_SANCTUM_4 = 21,
    THRALL_SAY_SANCTUM_5 = 22,
    THRALL_SAY_SANCTUM_6 = 23,
    THRALL_SAY_SANCTUM_7 = 24,
    THRALL_SAY_THRONE_1 = 25,
    THRALL_SAY_THRONE_2 = 26,
    THRALL_SAY_THRONE_3 = 27,
    THRALL_SAY_THRONE_4 = 28,
    THRALL_SAY_THRONE_5 = 29,
    THRALL_SAY_THRONE_6 = 30,
    THRALL_SAY_THRONE_7 = 31,
    THRALL_SAY_THRONE_8 = 32,
    THRALL_SAY_THRONE_9 = 33,
    THRALL_SAY_THRONE_10 = 34,
    THRALL_SAY_THRONE_11 = 35,

    // Sounds
    SOUND_THRALL_1 = 16212,
    SOUND_THRALL_2 = 16214,

    // Spells
    SPELL_THRALL_BUFF = 64670,
    SPELL_TIDAL_WAVE = 59635,
    SPELL_TIDAL_WAVE_SUMMON = 59627,
    SPELL_TIDAY_FURY = 59631,
    SPELL_TIDAY_FURY_EFFECT = 59629,
    SPELL_CALL_OF_AIR = 59898,
    SPELL_CYCLONE_FALL = 59892,
    SPELL_CALL_OF_EARTH = 60207,
    SPELL_PORTAL_COLLAPSE = 60285,
    SPELL_TELEPORT_SPAWN_VISUAL = 60427,
    SPELL_SUMMONED_DEMON = 7741,
    SPELL_DEEP_FREEZE = 60511,
    SPELL_GREATER_MASS_TELEPORT = 60516,
    SPELL_WATER_REVENANT_ENTRANCE = 55760,
    SPELL_TELEPORT_OG = 60699,

    // Combatspells
    SPELL_CHAIN_LIGHTNING = 59517,
    SPELL_LAVA_BURST = 59519,
    SPELL_THUNDER = 59507,
    SPELL_HEROIC_VANGUARD = 59506,

    // Events
    EVENT_CHAIN_LIGHTNING = 1,
    EVENT_LAVA_BURST = 2,
    EVENT_THUNDER = 3,
    EVENT_AGGRO_SYLVANAS = 4,
    EVENT_THRALL_BUFF = 5,

    // Creatures
    NPC_WARSONG_BATTLEGUARD = 31739,
    NPC_VORTEX = 31782,
    NPC_TIDAL_WAVE = 31765,
    NPC_WHIRLWIND = 31688,
    NPC_CAVE_DUMMY = 32200,
    NPC_SLINGER_TRIGGER = 31577,
    NPC_OVERLORD_SAURFANG = 32315,
    NPC_DISTANT_VOICE = 32277,
    NPC_PLAGUE_TRIGGER = 31576,
    NPC_BLIGHT_ABBERATION = 31844,

    // Gameobjects
    GO_BLOCKED_PASSAGE = 194935,
    GO_HORDE_BANNER = 194004,
    GO_PORTAL_ORGRIMMAR = 193427,

    // Mounts
    MODEL_WHITE_WULF = 14575
};

enum SlyvanasMisc
{
    // Creatures
    NPC_SYLVANAS = 32365,

    // Texts
    SYLVANAS_SAY_COURTYARD_1 = 0,
    SYLVANAS_SAY_ELEVATOR_1 = 1,
    SYLVANAS_SAY_SANCTUM_1 = 2,
    SYLVANAS_SAY_SANCTUM_2 = 3,
    SYLVANAS_SAY_SANCTUM_3 = 4,
    SYLVANAS_SAY_SANCTUM_4 = 5,
    SYLVANAS_SAY_SANCTUM_5 = 6,
    SYLVANAS_SAY_THRONE_1 = 7,

    // Spells
    SPELL_SYLVANAS_BUFF = 59756,
    SPELL_SHRIEK_OF_HIGHBORN = 59514,
    SPELL_LEAP_TO_PLATFORM = 56347,

    // Events
    EVENT_SHRIEK_OF_HIGHBORN = 1,
    EVENT_SYLVANAS_BUFF = 6,

    // Mounts
    MODEL_SKELETON_MOUNT = 10721
};

enum SaurfangMisc
{
    // Texts
    SAY_SAURFANG_ARRIVAL_1 = 0,
    SAY_SAURFANG_ARRIVAL_2 = 1,
    SAY_SAURFANG_ARRIVAL_3 = 2
};

/*######
## ENEMY
#######*/

enum BlightWormMisc
{
    // Creatures
    NPC_BLIGHTWORM = 32483,

    // Spells
    SPELL_INGEST = 61123,
    SPELL_INGEST_TRIGGER = 61124,
    SPELL_BLIGHT_BREATH = 61125,

    // Events
    EVENT_INFEST = 1,
    EVENT_BLIGHT_BREATH = 2
};

enum PutressMisc
{
    // Creatures
    NPC_PUTRESS = 31530,

    NPC_EXPERIMENT = 32519,
    NPC_GENERATOR = 36212,

    // Spells
    SPELL_BLIGHT_EMPOWERMENT = 59449,
    SPELL_BLIGHT_OVERLOAD = 61181,
    SPELL_BLIGHT_BARREL = 59460,
    SPELL_UNHOLY_FRENZY = 60300,
    SPELL_PUTRESS_CASTING_STATE = 59447,

    // Texts
    PUTRESS_SAY_1 = 0,
    PUTRESS_SAY_2 = 1,
    PUTRESS_SAY_3 = 2,
    PUTRESS_SAY_4 = 3,
    PUTRESS_SAY_5 = 4,
    PUTRESS_SAY_6 = 5,
    PUTRESS_SAY_7 = 6,
    PUTRESS_SAY_8 = 7,

    // Sounds
    SOUND_PUTRESS = 16920,
};

enum KhanokMisc
{
    // Creatures
    NPC_KHANOK = 32511
};

enum ValimathrasMisc
{
    // Creatures
    NPC_VARIMATHRAS = 31565,
    NPC_VARIMATHRAS_PORTAL = 31811,

    // Texts
    SAY_VALIMATHRAS_INTRO_0 = 0,
    SAY_VALIMATHRAS_INTRO_1 = 1,
    SAY_VALIMATHRAS_INTRO_2 = 2,
    SAY_VALIMATHRAS_INNER_SANKTUM_0 = 3,
    SAY_VALIMATHRAS_INNER_SANKTUM_1 = 4,
    SAY_CLOSE_DOOR = 5,
    SAY_THRONE_1 = 6,
    SAY_THRONE_2 = 7,
    SAY_THRONE_3 = 8,
    SAY_THRONE_4 = 9,
    SAY_THRONE_5 = 10,
    SAY_THRONE_6 = 11,
    SAY_VALIMATHRAS_ATTACK = 12,

    // Spells
    SPELL_VALIMATHRAS_PORTAL = 68424,
    SPELL_CARION_SWARM = 59434,
    SPELL_DRAIN_LIFE = 17238,
    SPELL_MIGHT_OF_VARIMATHRAS = 59424,
    SPELL_SHADOW_BOLT_VOLLEY = 20741,
    SPELL_AURA_OF_VARIMATHRAS = 60289,
    SPELL_LEGION_PORTAL = 59680,
    SPELL_OPENING_LEGION_PORTALS = 60224,
};

enum TrashMisc
{
    // Creatures
    NPC_DREADLORD = 32391,
    NPC_GUARDIAN = 32390,
    NPC_CHEMIST = 32395,
    NPC_BETRAYER = 32394,
    NPC_FELBEAST = 32392,
    NPC_DOCTOR = 32397,
    NPC_COLLABORATOR = 32396,
    NPC_SW_SOLDIER = 32387,
    NPC_HORDE_SOLDIER = 32510,
    NPC_HORDE_GUARD = 31739,

    // Horde
    NPC_TREACHEROUS_GUARDIAN_H = 31532,
    NPC_DREADLORD_H = 31531,
    NPC_FELBEAST_H = 31528,
    NPC_MARAUDER_H = 31527,
    NPC_BETRAYER_H = 31529,
    NPC_CHEMIST_H = 31482,
    NPC_COLLABORATOR_H = 31524,
    NPC_DOCTOR_H = 31516,
    NPC_DOOMGUARD_PILLARGER = 32159,
    NPC_BLIGHT_SLINGER = 31526,
    NPC_BLIGHT_SPREADER = 31831,
    NPC_FELGUARD_MORADEUR = 32393,
    NPC_LEGION_OVERLORD = 32271,
    NPC_LEGION_INVADER = 32269,
    NPC_LEGION_DREADWHISPER = 32270,

    // Texts
    SAY_BURN_UC = 0,
    SAY_PUTRESS_ANGER = 1,
    SAY_FOR_THE_HORDE = 2
};

enum QuestMisc
{
    QUEST_BATTLE_A = 13377,
    QUEST_BATTLE_H = 13267,

    SPELL_PHASING_HORDE = 59062,

    NPC_VOICE = 32277,

    VOICE_SAY_THRONE = 0,

    WAVE_MAXCOUNT = 12,
    GENERATOR_MAXCOUNT = 5,
    ALLIANCE_FORCE_MAXCOUNT = 6,
    HORDE_FORCE_MAXCOUNT = 6,
    WAVE_COURTYARD_FIGHT = 9,

    ZONE_TIRISFAL = 85,
    ZONE_UNDERCITY = 1497
};

struct LocationXYZO {
    float x, y, z, o;
};

static LocationXYZO AllianceSpawn[] =
{
    { 1603.97f, 718.02f, 65.10f, 0  }, // guardian // sewers
    { 1604.78f, 657.22f, 40.80f, 0  }, // wave 1
    { 1632.13f, 649.19f, 30.67f, 0  }, // wave 2
    { 1683.66f, 590.37f, -8.59f, 0  }, // wave 3
    { 1665.51f, 543.32f, -13.23f, 0 }, // wave 4
    { 1684.25f, 542.06f, -11.99f, 0 },
    { 1680.86f, 596.73f, -6.37f, 0  },
    { 1676.41f, 558.28f, -18.46f, 0 }, // Blightworm
    { 1685.16f, 620.41f, 5.74f, 0   }, // soldiers
    { 0.0f, 0.0f, 0.0f, 0           }, // trash wave
    { 1500.03f, 409.59f, -62.18f, 0 }, // guardians
    { 1444.25f, 453.86f, -70.48f, 0 }, // dreadlords
    { 1432.43f, 403.20f, -85.26f, 0 }, // putress
    { 1456.51f, 417.55f, -84.95f, 0 }, // experiment
    { 1415.38f, 377.54f, -84.95f, 0 }, // experiment
    { 1422.69f, 446.36f, -76.22f, 0 }, // experiment
    { 1386.19f, 412.01f, -77.17f, 0 }, // experiment
    { 1300.75f, 347.39f, -65.02f, 0 }, // thrall
    { 1296.79f, 348.37f, -65.02f, 0 }, // sylvanas
    { 1293.46f, 351.19f, -65.02f, 0 }, // horde soldier 32510
    { 1293.79f, 347.75f, -65.02f, 0 },
    { 1296.24f, 345.34f, -65.02f, 0 },
    { 1300.41f, 344.47f, -65.02f, 0 },
    { 1303.96f, 345.26f, -65.02f, 0 },
    { 1305.43f, 348.06f, -65.02f, 0 },
    { 1306.92f, 390.59f, -64.33f, 4.472f }, // aliance soldiers
    { 1311.03f, 390.10f, -64.19f, 4.472f },
    { 1315.31f, 388.98f, -64.18f, 4.472f },
    { 1316.38f, 392.82f, -63.32f, 4.472f },
    { 1311.93f, 394.38f, -63.25f, 4.472f },
    { 1307.92f, 395.53f, -63.24f, 4.472f },
};

static LocationXYZO AllianceWP[] =
{
    { 1737.06f, 734.176f, 48.8f, 0      }, // Jaina sewers UNUSED
    { 1682.92f, 730.89f, 76.84f, 0      }, // UNUSED
    { 1662.18f, 540.67f, -11.64f, 0.60f }, // soldiers
    { 1676.45f, 544.81f, -16.45f, 2.23f },
    { 1687.14f, 555.37f, -16.62f, 2.35f },
    { 1666.22f, 477.69f, -11.89f, 2.14f },
    { 1594.92f, 422.44f, -46.38f, 0     }, // jaina balcony
    { 1423.19f, 412.73f, -84.60f, 0     }, // jaina putress
    { 1311.93f, 394.38f, -63.25f, 0     }, // jaina throne room wait
    { 1300.75f, 347.39f, -65.02f, 0     }, // jaina throne room
};

static LocationXYZO HordeSpawn[] =
{
    { 1581.94f, 383.22f, -62.22f, 0 } // Khanok
};

static LocationXYZO ThrallSpawn[] =
{
    // Vortex
    { 1880.0001f, 237.8242f, 59.472f, 3.060f  },
    // NPC_DOCTOR_H
    { 1808.29f, 264.223f, 65.3997f, 5.41411f  },
    { 1792.05f, 282.213f, 70.3996f, 5.46674f  },
    { 1798.03f, 197.815f, 70.3997f, 0.550926f },
    // NPC_CHEMIST_H
    { 1806.59f, 266.874f, 65.3997f, 5.528f    },
    { 1808.18f, 211.038f, 65.3996f, 0.799897f },
    { 1803.01f, 213.037f, 65.3996f, 0.496734f },
    { 1803.01f, 213.037f, 65.3996f, 0.496734f },
    { 1809.58f, 197.105f, 70.3999f, 0.593338f },
    { 1816.2f, 196.655f, 70.3999f, 0.820318f  },
    { 1791.75f, 197.267f, 70.3999f, 0.584698f },
    { 1814.45f, 279.218f, 70.3998f, 5.52878f  },
    { 1793.98f, 280.346f, 70.3996f, 5.50522f  },
    // NPC_TREACHEROUS_GUARDIAN_H
    { 1806.31f, 213.05f, 65.3998f, 0.52893f   },
    { 1813.54f, 197.01f, 70.3999f, 0.807745f  },
    { 1789.15f, 197.6f, 70.3999f, 0.367921f   },
    { 1804.79f, 263.79f, 65.3998f, 5.49265f   },
    { 1818.12f, 280.6f, 70.3997f, 5.59475f    },
    { 1790.19f, 279.868f, 70.3997f, 5.77539f  },
    // NPC_BLIGHT_SLINGER
    { 1827.64f, 196.716f, 70.3996f, 1.61907f  },
    { 1778.47f, 195.17f, 70.3996f, 0.989177f  },
    { 1826.86f, 280.42f, 70.3997f, 4.69234f   },
    { 1779.52f, 280.479f, 70.3996f, 5.37171f  },
    // NPC_VARIMATHRAS
    { 1810.926f, 236.826f, 62.753f, 0.148f    },
    // NPC_VARIMATHRAS_PORTAL
    { 1805.194f, 235.725f, 65.173f, 0.334f    },
    // NPC_TREACHEROUS_GUARDIAN_H
    { 1753.151f, 238.632f, 61.372f, 0.049f    },
    // NPC_DOCTOR_H
    { 1785.647f, 212.416f, 59.686f, 1.663f    },
    // NPC_CHEMIST_H
    { 1784.802f, 265.842f, 59.458f, 4.722f    },
    // NPC_BLIGHT_ABBERATION
    { 1805.753f, 285.499f, 70.399f, 4.691f    },
    // NPC_WARSONG_BATTLEGUARD
    { 1835.734f, 261.468f, 59.901f, 3.720f    },
    { 1821.705f, 256.014f, 60.016f, 3.512f    },
    { 1837.801f, 216.490f, 60.105f, 2.381f    },
    { 1826.564f, 227.173f, 60.198f, 2.381f    },
    { 1804.952f, 199.451f, 70.399f, 1.478f    },
    { 1805.011f, 211.147f, 65.399f, 1.607f    },
    { 1805.447f, 277.378f, 70.400f, 4.627f    },
    { 1805.389f, 265.287f, 65.399f, 4.718f    },
    // GO_HORDE_BANNER
    { 1750.697f, 232.644f, 64.748f, 6.151f    },
    { 1750.706f, 245.729f, 65.585f, 0.009f    },
    { 1737.508f, 239.323f, 62.641f, 0.054f    },
    { 1634.253f, 226.927f, 62.592f, 0.983f    },
    { 1628.978f, 231.074f, 62.592f, 0.411f    },
    { 1589.801f, 236.328f, 60.149f, 0.157f    },
    { 1589.135f, 243.569f, 60.149f, 5.887f    },
    // NPC_WARSONG_BATTLEGUARD
    { 1590.156f, 243.612f, 60.151f, 5.159f    },
    { 1631.783f, 249.797f, 62.591f, 5.523f    },
    // NPC_CAVE_BUNNY
    { 1543.961548f, 240.997314f,  52.765247f, 4.885232f  },
    { 1543.961548f, 240.997314f,  45.870247f, 4.885232f  },
    { 1543.961548f, 240.997314f,  32.318245f, 4.885232f  },
    { 1543.961548f, 240.997314f,  18.325245f, 4.885232f  },
    { 1543.961548f, 240.997314f,   4.570244f, 4.885232f   },
    { 1543.961548f, 240.997314f,  -7.679757f, 4.885232f  },
    { 1543.961548f, 240.997314f, -20.867758f, 4.885232f },
    { 1543.961548f, 240.997314f, -33.817757f, 4.885232f },
    { 1543.961548f, 240.997314f, -41.360523f, 4.885232f },
    // Jumppoint Thrall
    { 1542.196f, 241.254f, -41.360f, 3.276f   },
    // Jumppoint Sylvanas
    { 1543.511f, 236.552f, -41.360f, 3.050f   },
    // NPC_WARSONG_BATTLEGUARD
    { 1527.904f, 206.368f, -43.058f, 1.179f   },
    { 1534.110f, 216.822f, -43.058f, 4.569f   },
    // Undercity Top Trashpackspawn
    { 1585.577f, 240.465f, -52.150f, 3.193f   },
    // Undercity Buttom Trashpackspawn Left
    { 1528.291f, 269.948f, -62.178f, 0.672f   },
    // Undercity Buttom Trashpackspawn Right
    { 1618.600f, 302.468f, -62.177f, 0.466f   },
    // NPC_BLIGHT_ABBERATION Jump Location
    { 1805.845f, 251.430f, 60.587f, 4.722f    },
    // Valimathras Inner Sanctum Spawn
    { 1596.689f, 422.276f, -46.387f, 4.720f   },
    // Valimathras Inner Sanctum Portal Spawn
    { 1596.665f, 425.150f, -43.357f, 4.704f   },
    // NPC_KHANOK - Inner Sunktum Spawn Left
    { 1544.917f, 367.955f, -62.182f, 0.243f   },
    // NPC_KHANOK - Inner Sunktum Spawn Right
    { 1643.633f, 368.598f, -62.156f, 2.873f   },
    // NPC_KHANOK - Inner Sunktum Spawn Top
    { 1591.325f, 397.874f, -4.130f, 6.191f    },
    // NPC_KHANOK - Inner Sunktum Middle
    { 1573.400f, 398.450f, -65.862f, 5.618f   },
    // NPC_WARSONG_BATTLEGUARD - NPC_KHANOK WinSpawn
    { 1590.502f, 375.876f, -62.177f, 3.237f   },
    // Valimathras Room Preparation
    // Stones
    { 1437.063f, 403.759f, -57.818f, 5.517f       },
    { 1442.303f, 392.866f, -58.111f, 5.450552f    },
    { 1447.207f, 397.880f, -58.102f, 5.403430f    },
    // Valimathras
    { 1290.323f, 315.996f, -57.320f, 1.322530f    },
    // Valimathras Portals
    { 1326.634f, 58.580f, -60.661907f, 4.008590f  },
    { 1341.374f, 310.516f, -60.661415f, 2.838340f },
    { 1304.504f, 276.763f, -60.661442f, 1.833025f },
    { 1258.071f, 289.268f, -60.661636f, 0.741321f },
    { 1245.688f, 336.614f, -60.661243f, 5.983858f },
    { 1280.382f, 371.556f, -60.661404f, 4.931426f },
    // Valimathras Trashspawn
    { 1325.059f, 332.652f, -65.027f, 2.186f       },
    { 1270.474f, 350.982f, -65.027f, 0.034f       },
    { 1805.753f, 285.499f, 70.399f, 4.691f       }
};

#define GOSSIP_WRYNN      "Reporting for duty, your majesty! Let the assault begin!"
#define GOSSIP_THRALL     "I am ready, Warchief."

/*######
## ALLIANCE
#######*/

/*######
## npc_varian_wrynn
######*/

class npc_varian_wrynn : public CreatureScript
{
public:
    npc_varian_wrynn() : CreatureScript("npc_varian_wrynn") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                CloseGossipMenuFor(player);

                if (auto ai = CAST_AI(npc_varian_wrynn::npc_varian_wrynnAI, creature->AI()))
                {
                    ai->Start(true, player->GetGUID());
                    if (Creature* jaina = GetClosestCreatureWithEntry(creature, NPC_JAINA, 50.0f))
                        ai->jainaGUID = jaina->GetGUID();
                    else
                        ai->jainaGUID.Clear();
                    ai->SetDespawnAtEnd(false);
                    ai->SetDespawnAtFar(false);
                }

                break;
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_BATTLE_A) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_WRYNN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    struct npc_varian_wrynnAI : public npc_escortAI
    {
        npc_varian_wrynnAI(Creature* creature) : npc_escortAI(creature)
        {
            allianceGuardsGUID.clear();
        }

        bool bStepping;
        bool summoned;

        uint32 step;
        uint32 phaseTimer;

        uint32 whirlwindTimer;

        ObjectGuid jainaGUID;
        ObjectGuid putressGUID;
        ObjectGuid blightWormGUID;
        ObjectGuid khanokGUID;
        ObjectGuid thrallGUID;
        ObjectGuid sylvanasGUID;

        ObjectGuid generatorGUID[GENERATOR_MAXCOUNT];
        ObjectGuid allianceForcesGUID[ALLIANCE_FORCE_MAXCOUNT];
        ObjectGuid hordeForcesGUID[HORDE_FORCE_MAXCOUNT];
        GuidVector allianceGuardsGUID;

        EventMap _events;

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            me->SetLootRecipient(nullptr);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                AddEscortState(STATE_ESCORT_RETURNING);
                ReturnToLastPoint();
            }
            else
            {
                me->GetMotionMaster()->MoveTargetedHome();
                Reset();
            }
        }

        void Reset() override
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
            {
                me->SetCorpseDelay(1);
                me->SetRespawnTime(1);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);

                bStepping = false;
                step = 0;
                phaseTimer = 0;
                jainaGUID.Clear();
                _events.ScheduleEvent(EVENT_WHIRLWIND, 5s);
                _events.ScheduleEvent(EVENT_HEROIC_LEAP, 10s);
                _events.ScheduleEvent(EVENT_AGGRO_JAINA, 2s);
                _events.ScheduleEvent(EVENT_WRYNN_BUFF, 2s);
                me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);

                if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                {
                    putress->DespawnOrUnsummon();
                    putressGUID.Clear();
                }

                if (Creature* blightWorm = ObjectAccessor::GetCreature(*me, blightWormGUID))
                {
                    blightWorm->DespawnOrUnsummon();
                    blightWormGUID.Clear();
                }

                if (Creature* khanok = ObjectAccessor::GetCreature(*me, khanokGUID))
                {
                    khanok->DespawnOrUnsummon();
                    khanokGUID.Clear();
                }

                if (Creature* thrall = ObjectAccessor::GetCreature(*me, thrallGUID))
                {
                    thrall->DespawnOrUnsummon();
                    thrallGUID.Clear();
                }

                if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasGUID))
                {
                    sylvanas->DespawnOrUnsummon();
                    sylvanasGUID.Clear();
                }

                for (uint8 i = 0; i < GENERATOR_MAXCOUNT; ++i)
                {
                    if (Creature* temp = ObjectAccessor::GetCreature(*me, generatorGUID[i]))
                    {
                        generatorGUID[i].Clear();
                        temp->DespawnOrUnsummon();
                    }
                }

                for (uint8 i = 0; i < ALLIANCE_FORCE_MAXCOUNT; ++i)
                {
                    if (Creature* temp = ObjectAccessor::GetCreature(*me, allianceForcesGUID[i]))
                    {
                        allianceForcesGUID[i].Clear();
                        temp->DespawnOrUnsummon();
                    }
                }

                for (ObjectGuid const& guid : allianceGuardsGUID)
                    if (Creature* temp = ObjectAccessor::GetCreature(*me, guid))
                        temp->DespawnOrUnsummon();

                allianceGuardsGUID.clear();

                for (uint8 i = 0; i < HORDE_FORCE_MAXCOUNT; ++i)
                {
                    if (Creature* temp = ObjectAccessor::GetCreature(*me, hordeForcesGUID[i]))
                    {
                        hordeForcesGUID[i].Clear();
                        temp->DespawnOrUnsummon();
                    }
                }
            }
        }

        void JustSummoned(Creature* summonedCreature) override
        {
            switch (summonedCreature->GetEntry())
            {
                case NPC_GENERATOR:
                    summonedCreature->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    summonedCreature->ApplySpellImmune(0, IMMUNITY_ID, SPELL_WRYNN_BUFF, true);
                    summonedCreature->ApplySpellImmune(0, IMMUNITY_ID, SPELL_THRALL_BUFF, true);
                    summonedCreature->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);
                    break;
                default:
                    break;
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
        {
            switch (summon->GetEntry())
            {
                case NPC_BLIGHTWORM:
                    UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_SEWERS_FIGHT_A, 0);
                    UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_SEWERS_DONE_A, 1);
                    bStepping = true;
                    break;
                case NPC_PUTRESS:
                    UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_APOTHECARIUM_FIGHT_A, 0);
                    UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_APOTHECARIUM_DONE_A, 1);
                    bStepping = true;
                    break;
                default:
                    break;
            }
        }

        void UpdateWorldState(Map* map, uint32 id, uint32 state)
        {
            Map::PlayerList const& players = map->GetPlayers();

            if (!players.IsEmpty())
            {
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    if (Player* player = itr->GetSource())
                        player->SendUpdateWorldState(id, state);
                }
            }
        }

        void SetHoldState(bool bOnHold)
        {
            SetEscortPaused(bOnHold);
        }

        void JumpToNextStep(uint32 uiTimer)
        {
            phaseTimer = uiTimer;
            ++step;
        }

        void SpawnWave(uint32 waveId)
        {
            switch (waveId)
            {
                case 0:
                    me->SummonCreature(NPC_GUARDIAN, AllianceSpawn[0].x, AllianceSpawn[0].y, AllianceSpawn[0].z, TEMPSUMMON_DEAD_DESPAWN);
                    break;
                case 1:
                    for (uint8 i = 0; i < WAVE_MAXCOUNT; ++i)
                    {
                        switch (urand(0, 12))
                        {
                            case 0:
                                me->SummonCreature(NPC_DREADLORD, AllianceSpawn[1].x + rand32() % 5, AllianceSpawn[1].y + rand32() % 5, AllianceSpawn[1].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                            case 2:
                            case 3:
                                me->SummonCreature(NPC_DOCTOR, AllianceSpawn[1].x + rand32() % 5, AllianceSpawn[1].y + rand32() % 5, AllianceSpawn[1].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 4:
                            case 5:
                            case 6:
                                me->SummonCreature(NPC_FELBEAST, AllianceSpawn[1].x + rand32() % 5, AllianceSpawn[1].y + rand32() % 5, AllianceSpawn[1].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 7:
                            case 8:
                            case 9:
                                me->SummonCreature(NPC_BETRAYER, AllianceSpawn[1].x + rand32() % 5, AllianceSpawn[1].y + rand32() % 5, AllianceSpawn[1].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 10:
                            case 11:
                            case 12:
                                me->SummonCreature(NPC_COLLABORATOR, AllianceSpawn[1].x + rand32() % 5, AllianceSpawn[1].y + rand32() % 5, AllianceSpawn[1].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                case 2:
                    for (uint8 i = 0; i < WAVE_MAXCOUNT; ++i)
                    {
                        switch (urand(0, 3))
                        {
                            case 0:
                                me->SummonCreature(NPC_COLLABORATOR, AllianceSpawn[2].x - rand32() % 5, AllianceSpawn[2].y - rand32() % 5, AllianceSpawn[2].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_DOCTOR, AllianceSpawn[2].x - rand32() % 5, AllianceSpawn[2].y - rand32() % 5, AllianceSpawn[2].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 2:
                                me->SummonCreature(NPC_FELBEAST, AllianceSpawn[2].x - rand32() % 5, AllianceSpawn[2].y - rand32() % 5, AllianceSpawn[2].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 3:
                                me->SummonCreature(NPC_BETRAYER, AllianceSpawn[2].x - rand32() % 5, AllianceSpawn[2].y - rand32() % 5, AllianceSpawn[2].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                case 3:
                    for (uint8 i = 0; i < WAVE_MAXCOUNT; ++i)
                    {
                        switch (urand(0, 4))
                        {
                            case 0:
                                me->SummonCreature(NPC_GUARDIAN, AllianceSpawn[3].x - rand32() % 5, AllianceSpawn[3].y - rand32() % 5, AllianceSpawn[3].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                            case 2:
                                me->SummonCreature(NPC_CHEMIST, AllianceSpawn[3].x - rand32() % 5, AllianceSpawn[3].y - rand32() % 5, AllianceSpawn[3].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 3:
                            case 4:
                                me->SummonCreature(NPC_DOCTOR, AllianceSpawn[3].x - rand32() % 5, AllianceSpawn[3].y - rand32() % 5, AllianceSpawn[3].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                case 4:
                    for (uint8 i = 0; i < WAVE_MAXCOUNT; ++i)
                    {
                        switch (urand(0, 5))
                        {
                            case 0:
                                if (Unit* temp = me->SummonCreature(NPC_DOCTOR, AllianceSpawn[4].x - rand32() % 5, AllianceSpawn[4].y - rand32() % 5, AllianceSpawn[4].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                                break;
                            case 1:
                                if (Unit* temp = me->SummonCreature(NPC_CHEMIST, AllianceSpawn[4].x - rand32() % 5, AllianceSpawn[4].y - rand32() % 5, AllianceSpawn[4].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                                break;
                            case 2:
                                if (Unit* temp = me->SummonCreature(NPC_BETRAYER, AllianceSpawn[4].x - rand32() % 5, AllianceSpawn[4].y - rand32() % 5, AllianceSpawn[4].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                                break;
                            case 3:
                                if (Unit* temp = me->SummonCreature(NPC_DOCTOR, AllianceSpawn[5].x - rand32() % 5, AllianceSpawn[5].y - rand32() % 5, AllianceSpawn[5].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                                break;
                            case 4:
                                if (Unit* temp = me->SummonCreature(NPC_CHEMIST, AllianceSpawn[5].x - rand32() % 5, AllianceSpawn[5].y - rand32() % 5, AllianceSpawn[5].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                                break;
                            case 5:
                                if (Unit* temp = me->SummonCreature(NPC_BETRAYER, AllianceSpawn[5].x - rand32() % 5, AllianceSpawn[5].y - rand32() % 5, AllianceSpawn[5].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                                break;
                        }
                    }
                    break;
                case 5:
                    for (uint8 i = 0; i < WAVE_MAXCOUNT; ++i)
                        if (Unit* temp = me->SummonCreature(NPC_GUARDIAN, AllianceSpawn[6].x - rand32() % 5, AllianceSpawn[6].y - rand32() % 5, AllianceSpawn[6].z, TEMPSUMMON_DEAD_DESPAWN))
                            temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                    break;
                case 6:
                    if (Unit* temp = me->SummonCreature(NPC_BLIGHTWORM, AllianceSpawn[7].x, AllianceSpawn[7].y, AllianceSpawn[7].z, TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        blightWormGUID = temp->GetGUID();
                        temp->AddThreat(me, 100.0f);
                        me->AddThreat(temp, 100.0f);
                        if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                        {
                            temp->AddThreat(jaina, 100.0f);
                            jaina->AddThreat(temp, 100.0f);
                        }
                    }
                    if (Unit* temp = me->SummonCreature(NPC_KHANOK, HordeSpawn[0].x, HordeSpawn[0].y, HordeSpawn[0].z, TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        khanokGUID = temp->GetGUID();
                        if (Creature* khanok = ObjectAccessor::GetCreature(*me, khanokGUID))
                            khanok->setDeathState(DeathState::JustDied);
                    }
                    if (Unit* temp = me->SummonCreature(NPC_PUTRESS, AllianceSpawn[12].x, AllianceSpawn[12].y, AllianceSpawn[12].z, TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        putressGUID = temp->GetGUID();
                        temp->CastSpell(temp, SPELL_PUTRESS_CASTING_STATE);
                    }
                    for (uint8 i = 0; i < GENERATOR_MAXCOUNT; ++i)
                    {
                        switch (i)
                        {
                            case 0:
                                if (Unit* temp = me->SummonCreature(NPC_GENERATOR, 1433.142212f, 402.493835f, -80.515945f, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    generatorGUID[i] = temp->GetGUID();
                                    if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                        temp->CastSpell(putress, SPELL_BLIGHT_EMPOWERMENT);
                                }
                                break;
                            case 1:
                                if (Unit* temp = me->SummonCreature(NPC_GENERATOR, 1428.677979f, 399.753418f, -79.141609f, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    generatorGUID[i] = temp->GetGUID();
                                    if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                        temp->CastSpell(putress, SPELL_BLIGHT_EMPOWERMENT, false, 0, 0, generatorGUID[0]);
                                }
                                break;
                            case 2:
                                if (Unit* temp = me->SummonCreature(NPC_GENERATOR, 1425.163330f, 402.268951f, -79.299744f, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    generatorGUID[i] = temp->GetGUID();
                                    if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                        temp->CastSpell(putress, SPELL_BLIGHT_EMPOWERMENT, false, 0, 0, generatorGUID[0]);
                                }
                                break;
                            case 3:
                                if (Unit* temp = me->SummonCreature(NPC_GENERATOR, 1427.323242f, 406.853088f, -78.195641f, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    generatorGUID[i] = temp->GetGUID();
                                    if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                        temp->CastSpell(putress, SPELL_BLIGHT_EMPOWERMENT, false, 0, 0, generatorGUID[0]);
                                }
                                break;
                            case 4:
                                if (Unit* temp = me->SummonCreature(NPC_GENERATOR, 1432.465210f, 407.460022f, -81.689384f, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    generatorGUID[i] = temp->GetGUID();
                                    if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                        temp->CastSpell(putress, SPELL_BLIGHT_EMPOWERMENT, false, 0, 0, generatorGUID[0]);
                                }
                                break;
                        }
                    }
                    break;
                case 7:
                    if (Unit* temp = me->SummonCreature(NPC_SW_SOLDIER, AllianceSpawn[8].x, AllianceSpawn[8].y, AllianceSpawn[8].z, 0, TEMPSUMMON_TIMED_DESPAWN, 90000))
                    {
                        allianceGuardsGUID.push_back(temp->GetGUID());
                        temp->GetMotionMaster()->MoveWaypoint(NPC_SW_SOLDIER * 10, false);
                    }
                    if (Unit* temp = me->SummonCreature(NPC_SW_SOLDIER, AllianceSpawn[8].x, AllianceSpawn[8].y, AllianceSpawn[8].z, 0, TEMPSUMMON_TIMED_DESPAWN, 90000))
                    {
                        allianceGuardsGUID.push_back(temp->GetGUID());
                        temp->GetMotionMaster()->MoveWaypoint((NPC_SW_SOLDIER * 10) + 1, false);
                    }
                    if (Unit* temp = me->SummonCreature(NPC_SW_SOLDIER, AllianceSpawn[8].x, AllianceSpawn[8].y, AllianceSpawn[8].z, 0, TEMPSUMMON_TIMED_DESPAWN, 90000))
                    {
                        allianceGuardsGUID.push_back(temp->GetGUID());
                        temp->GetMotionMaster()->MoveWaypoint((NPC_SW_SOLDIER * 10) + 2, false);
                    }
                    if (Unit* temp = me->SummonCreature(NPC_SW_SOLDIER, AllianceSpawn[8].x, AllianceSpawn[8].y, AllianceSpawn[8].z, 0, TEMPSUMMON_TIMED_DESPAWN, 90000))
                    {
                        allianceGuardsGUID.push_back(temp->GetGUID());
                        temp->GetMotionMaster()->MoveWaypoint((NPC_SW_SOLDIER * 10) + 3, false);
                    }
                    break;
                case 8:
                    break;
                case 9:
                    for (uint8 i = 0; i < WAVE_MAXCOUNT; ++i)
                        me->SummonCreature(NPC_GUARDIAN, AllianceSpawn[10].x + rand32() % 13, AllianceSpawn[10].y + rand32() % 13, AllianceSpawn[10].z, TEMPSUMMON_DEAD_DESPAWN);
                    break;
                case 10:
                    if (Unit* temp = me->SummonCreature(NPC_DREADLORD, AllianceSpawn[11].x, AllianceSpawn[11].y, AllianceSpawn[11].z, TEMPSUMMON_DEAD_DESPAWN))
                    {
                        temp->GetMotionMaster()->MoveWaypoint(NPC_DREADLORD * 10, false);
                        temp->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                        temp->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
                    }
                    break;
                case 11:
                    for (uint8 i = 0; i < WAVE_MAXCOUNT; ++i)
                    {
                        switch (urand(0, 3))
                        {
                            case 0:
                                if (Unit* temp = me->SummonCreature(NPC_EXPERIMENT, AllianceSpawn[13].x + rand32() % 5, AllianceSpawn[13].y + rand32() % 5, AllianceSpawn[13].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                                break;
                            case 1:
                                if (Unit* temp = me->SummonCreature(NPC_EXPERIMENT, AllianceSpawn[14].x + rand32() % 5, AllianceSpawn[14].y + rand32() % 5, AllianceSpawn[14].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                                break;
                            case 2:
                                if (Unit* temp = me->SummonCreature(NPC_EXPERIMENT, AllianceSpawn[15].x + rand32() % 5, AllianceSpawn[15].y + rand32() % 5, AllianceSpawn[15].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                                break;
                            case 3:
                                if (Unit* temp = me->SummonCreature(NPC_EXPERIMENT, AllianceSpawn[16].x + rand32() % 5, AllianceSpawn[16].y + rand32() % 5, AllianceSpawn[16].z, TEMPSUMMON_DEAD_DESPAWN))
                                    temp->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                                break;
                        }
                    }
                    break;
                case 12:
                    if (Creature* temp = me->SummonCreature(NPC_THRALL, AllianceSpawn[17].x, AllianceSpawn[17].y, AllianceSpawn[17].z, TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        thrallGUID = temp->GetGUID();
                        temp->SetReactState(REACT_PASSIVE);
                        temp->SetImmuneToAll(true);
                        temp->CastSpell(temp, SPELL_THRALL_BUFF);
                        temp->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                    }
                    if (Creature* temp = me->SummonCreature(NPC_SYLVANAS, AllianceSpawn[18].x, AllianceSpawn[18].y, AllianceSpawn[18].z, TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        sylvanasGUID = temp->GetGUID();
                        temp->SetReactState(REACT_PASSIVE);
                        temp->SetImmuneToAll(true);
                        temp->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                    }
                    for (uint8 i = 0; i < HORDE_FORCE_MAXCOUNT; ++i)
                    {
                        if (Creature* temp = me->SummonCreature(NPC_HORDE_SOLDIER, AllianceSpawn[i + 19].x, AllianceSpawn[i + 19].y, AllianceSpawn[i + 19].z, TEMPSUMMON_MANUAL_DESPAWN))
                        {
                            hordeForcesGUID[i] = temp->GetGUID();
                            temp->SetReactState(REACT_PASSIVE);
                            temp->SetImmuneToAll(true);
                            temp->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                        }
                    }
                    break;
                case 13:
                    for (uint8 i = 0; i < ALLIANCE_FORCE_MAXCOUNT; ++i)
                    {
                        if (Unit* temp = me->SummonCreature(NPC_SW_SOLDIER, AllianceSpawn[i + 25].x, AllianceSpawn[i + 25].y, AllianceSpawn[i + 25].z, AllianceSpawn[i + 25].o, TEMPSUMMON_MANUAL_DESPAWN))
                        {
                            allianceForcesGUID[i] = temp->GetGUID();
                            temp->SetImmuneToAll(true);
                            temp->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                        }
                    }
                    break;
            }
        }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 0:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 2:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 38:
                    if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                    {
                        jaina->GetMotionMaster()->Clear();
                        jaina->SetImmuneToNPC(false);
                        jaina->SetReactState(REACT_AGGRESSIVE);
                    }
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 45:
                    SetHoldState(true);
                    bStepping = true;
                    if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                    {
                        jaina->GetMotionMaster()->Clear();
                        jaina->GetMotionMaster()->MovePoint(0, AllianceWP[6].x, AllianceWP[6].y, AllianceWP[6].z);
                    }
                    break;
                case 46:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 48:
                    if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                        putress->AI()->Talk(PUTRESS_SAY_2);
                    if (Player* player = GetPlayerForEscort())
                        player->PlayDirectSound(SOUND_PUTRESS, player);
                    break;
                case 50:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 63:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 65:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 66:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 87:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 88:
                    SetHoldState(true);
                    bStepping = true;
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (bStepping)
            {
                if (phaseTimer <= diff)
                {
                    switch (step)
                    {
                        //Preparation
                        case 0:
                            me->setActive(true);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_MANHUNT_COUNTDOWN_A, 1);
                            Talk(WRYNN_SAY_PREP_1);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 1:
                            Talk(WRYNN_SAY_PREP_2);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 2:
                            Talk(WRYNN_SAY_PREP_3);
                            JumpToNextStep(20 * IN_MILLISECONDS);
                            break;
                        case 3:
                            Talk(WRYNN_SAY_PREP_4);
                            JumpToNextStep(20 * IN_MILLISECONDS);
                            break;
                        case 4:
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_MANHUNT_COUNTDOWN_A, 0);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_MANHUNT_STARTS_A, 1);
                            Talk(WRYNN_SAY_PREP_5);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 5:
                            DoCast(me, SPELL_WRYNN_BUFF);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 6:
                            Talk(WRYNN_SAY_PREP_6);
                            JumpToNextStep(1 * IN_MILLISECONDS);
                            break;
                        case 7:
                            SetEscortPaused(false);
                            JumpToNextStep(1.5 * IN_MILLISECONDS);
                            break;
                        case 8:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                            {
                                jaina->GetMotionMaster()->MoveWaypoint(NPC_JAINA * 10, false);
                                jaina->setActive(true);
                            }
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        //Sewers
                        case 9:
                            Talk(WRYNN_SAY_SEWERS_1);
                            SpawnWave(0);
                            SpawnWave(1);
                            SpawnWave(2);
                            SpawnWave(3);
                            JumpToNextStep(9500);
                            break;
                        case 10:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                                jaina->AI()->Talk(JAINA_SAY_SEWERS_1);
                            JumpToNextStep(2 * IN_MILLISECONDS);
                            break;
                        case 11:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                                jaina->AI()->DoCast(SPELL_JAINA_BUFF);
                            JumpToNextStep(1 * IN_MILLISECONDS);
                            break;
                        case 12:
                            SetEscortPaused(false);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_MANHUNT_STARTS_A, 0);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_SEWERS_FIGHT_A, 1);
                            JumpToNextStep(1 * IN_MILLISECONDS);
                            break;
                        case 13:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                            {
                                jaina->GetMotionMaster()->MoveFollow(me, 5, PET_FOLLOW_ANGLE);
                                jaina->SetReactState(REACT_AGGRESSIVE);
                                jaina->SetFaction(FACTION_ESCORT_N_NEUTRAL_ACTIVE);
                            }
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 14:
                            Talk(WRYNN_SAY_SEWERS_2);
                            JumpToNextStep(3.5 * IN_MILLISECONDS);
                            break;
                        case 15:
                            SpawnWave(4);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 16:
                            SpawnWave(5);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 17:
                            SpawnWave(4);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 18:
                            SpawnWave(4);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 19:
                            SpawnWave(5);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 20:
                            SpawnWave(6);
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 21:
                            Talk(WRYNN_SAY_SEWERS_3);
                            SpawnWave(7);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 22:
                            Talk(WRYNN_SAY_SEWERS_4);
                            me->SetWalk(true);
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                            {
                                jaina->GetMotionMaster()->Clear();
                                jaina->GetMotionMaster()->MoveFollow(me, 1, 0);
                            }
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 23:
                            bStepping = false;
                            SetEscortPaused(false);
                            JumpToNextStep(0);
                            break;
                        //Apothecarium
                        case 24:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                                jaina->AI()->Talk(JAINA_SAY_APO_1);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 25:
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 26:
                            me->SetStandState(UNIT_STAND_STATE_KNEEL);
                            me->SetTarget(khanokGUID);
                            JumpToNextStep(1 * IN_MILLISECONDS);
                            break;
                        case 27:
                            Talk(WRYNN_SAY_APO_1);
                            JumpToNextStep(12 * IN_MILLISECONDS);
                            break;
                        case 28:
                            Talk(WRYNN_SAY_APO_2);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 29:
                            Talk(WRYNN_SAY_APO_3);
                            JumpToNextStep(1.5 * IN_MILLISECONDS);
                            break;
                        case 30:
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_APOTHECARIUM_FIGHT_A, 1);
                            if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                putress->AI()->Talk(PUTRESS_SAY_1);
                            if (Player* player = GetPlayerForEscort())
                                player->PlayDirectSound(SOUND_PUTRESS, player);
                            SpawnWave(9);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 31:
                            me->SetWalk(false);
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                                jaina->GetMotionMaster()->MoveFollow(me, 1, 0);
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 32:
                            Talk(WRYNN_SAY_APO_4);
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 33:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 34:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 35:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 36:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 37:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 38:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 39:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 40:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 41:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 42:
                            SpawnWave(10);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 43:
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 44:
                            Talk(WRYNN_SAY_APO_5);
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                            {
                                jaina->GetMotionMaster()->Clear();
                                jaina->GetMotionMaster()->MovePoint(0, AllianceWP[7].x, AllianceWP[7].y, AllianceWP[7].z, FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
                            }
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 45:
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 46:
                            Talk(WRYNN_SAY_APO_6);
                            JumpToNextStep(4 * IN_MILLISECONDS);
                            break;
                        case 47:
                            if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                putress->AI()->Talk(PUTRESS_SAY_3);
                            SpawnWave(11);
                            JumpToNextStep(7.5 * IN_MILLISECONDS);
                            break;
                        case 48:
                            if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                putress->AI()->Talk(PUTRESS_SAY_4);
                            JumpToNextStep(7.5 * IN_MILLISECONDS);
                            break;
                        case 49:
                            if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                putress->AI()->Talk(PUTRESS_SAY_5);
                            SpawnWave(11);
                            JumpToNextStep(7.5 * IN_MILLISECONDS);
                            break;
                        case 50:
                            if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                putress->AI()->Talk(PUTRESS_SAY_6);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 51:
                            if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                                putress->AI()->Talk(PUTRESS_SAY_7);
                            SpawnWave(11);
                            JumpToNextStep(7.5 * IN_MILLISECONDS);
                            break;
                        case 52:
                            if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                            {
                                putress->AI()->Talk(PUTRESS_SAY_8);
                                putress->AI()->DoCast(SPELL_BLIGHT_OVERLOAD);
                            }
                            JumpToNextStep(0.5 * IN_MILLISECONDS);
                            break;
                        case 53:
                            if (Creature* putress = ObjectAccessor::GetCreature(*me, putressGUID))
                            {
                                putress->SetImmuneToAll(false);
                                putress->AddThreat(me, 100.0f);
                                me->AddThreat(putress, 100.0f);
                                putress->RemoveAura(SPELL_PUTRESS_CASTING_STATE);
                            }
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 54:
                            Talk(WRYNN_SAY_APO_7);
                            me->SetWalk(true);
                            JumpToNextStep(4 * IN_MILLISECONDS);
                            break;
                        case 55:
                            if (ObjectAccessor::GetCreature(*me, putressGUID))
                                me->SetTarget(putressGUID);
                            Talk(WRYNN_SAY_APO_8);
                            JumpToNextStep(4 * IN_MILLISECONDS);
                            break;
                        case 56:
                            Talk(WRYNN_SAY_APO_9);
                            me->RemoveStandFlags(UNIT_STAND_STATE_KNEEL);
                            me->SetStandFlags(UNIT_STAND_STATE_STAND);
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 57:
                            JumpToNextStep(4 * IN_MILLISECONDS);
                            break;
                        case 58:
                            Talk(WRYNN_SAY_APO_10);
                            JumpToNextStep(7.5 * IN_MILLISECONDS);
                            break;
                        case 59:
                            Talk(WRYNN_SAY_APO_11);
                            JumpToNextStep(7.5 * IN_MILLISECONDS);
                            break;
                        case 60:
                            Talk(WRYNN_SAY_APO_12);
                            SpawnWave(12); // thrall sylvanas horde soldiers
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 61:
                            if (Creature* thrall = ObjectAccessor::GetCreature(*me, thrallGUID))
                                thrall->AI()->Talk(THRALL_SAY_THRONE_A_1);
                            if (Player* player = GetPlayerForEscort())
                                player->PlayDirectSound(SOUND_THRALL_1, player);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 62:
                            if (Creature* thrall = ObjectAccessor::GetCreature(*me, thrallGUID))
                                thrall->AI()->Talk(THRALL_SAY_THRONE_A_2);
                            if (Player* player = GetPlayerForEscort())
                                player->PlayDirectSound(SOUND_THRALL_2, player);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 63:
                            Talk(WRYNN_SAY_THRONE_1);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 64:
                            Talk(WRYNN_SAY_THRONE_2);
                            JumpToNextStep(1.5 * IN_MILLISECONDS);
                            break;
                        case 65:
                            me->SetWalk(false);
                            SetEscortPaused(false);
                            JumpToNextStep(0.25 * IN_MILLISECONDS);
                            break;
                        case 66:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                                jaina->AI()->Talk(JAINA_SAY_THRONE_1);
                            me->SetImmuneToNPC(true);
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 67:
                            Talk(WRYNN_SAY_THRONE_3);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 68:
                            Talk(WRYNN_SAY_THRONE_4);
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                            {
                                jaina->GetMotionMaster()->MovePoint(0, AllianceWP[8].x, AllianceWP[8].y, AllianceWP[8].z);
                                jaina->SetImmuneToAll(true);
                            }
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 69:
                            Talk(WRYNN_SAY_THRONE_5);
                            SpawnWave(13); //alliance soldiers
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 70:
                            Talk(WRYNN_SAY_THRONE_6);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 71:
                            Talk(WRYNN_SAY_THRONE_7);
                            JumpToNextStep(16.5 * IN_MILLISECONDS);
                            break;
                        case 72:
                            Talk(WRYNN_SAY_THRONE_8);
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 73:
                            Talk(WRYNN_SAY_THRONE_9);
                            me->SetImmuneToAll(false);
                            if (Creature* thrall = ObjectAccessor::GetCreature(*me, thrallGUID))
                            {
                                thrall->SetReactState(REACT_AGGRESSIVE);
                                thrall->SetImmuneToNPC(false);
                                thrall->SetImmuneToPC(true);
                                thrall->AddThreat(me, 100.0f);
                                me->AddThreat(thrall, 100.0f);
                                thrall->AI()->AttackStart(me);
                            }
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasGUID))
                            {
                                sylvanas->SetReactState(REACT_AGGRESSIVE);
                                sylvanas->SetImmuneToNPC(false);
                                sylvanas->SetImmuneToPC(true);
                                sylvanas->AddThreat(me, 100.0f);
                                sylvanas->AI()->AttackStart(me);
                                me->AddThreat(sylvanas, 100.0f);
                            }
                            for (uint8 i = 0; i < HORDE_FORCE_MAXCOUNT; ++i)
                            {
                                if (Creature* temp = ObjectAccessor::GetCreature(*me, hordeForcesGUID[i]))
                                {
                                    temp->SetReactState(REACT_AGGRESSIVE);
                                    temp->SetImmuneToNPC(false);
                                    temp->SetImmuneToPC(true);
                                }
                            }
                            for (uint8 i = 0; i < ALLIANCE_FORCE_MAXCOUNT; ++i)
                            {
                                if (Creature* temp = ObjectAccessor::GetCreature(*me, allianceForcesGUID[i]))
                                {
                                    if (Creature* temp2 = ObjectAccessor::GetCreature(*me, hordeForcesGUID[i]))
                                    {
                                        temp->SetReactState(REACT_AGGRESSIVE);
                                        temp2->SetReactState(REACT_AGGRESSIVE);
                                        temp->SetImmuneToAll(false);
                                        temp2->SetImmuneToAll(false);
                                        temp->AddThreat(temp2, 100.0f);
                                        temp->AI()->AttackStart(temp2);
                                        temp2->AddThreat(temp, 100.0f);
                                    }
                                }
                            }
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 74:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                            {
                                jaina->GetMotionMaster()->MovePoint(0, AllianceWP[9].x, AllianceWP[9].y, AllianceWP[9].z);
                                jaina->AI()->Talk(JAINA_SAY_THRONE_2);
                            }
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 75:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                            {
                                jaina->AI()->DoCastAOE(SPELL_DEEPFREEZE);
                                jaina->AI()->Talk(JAINA_SAY_THRONE_3);
                            }
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 76:
                            std::list<Creature*> HelperList;
                            me->GetCreatureListWithEntryInGrid(HelperList, NPC_SW_SOLDIER, 100.0f);
                            me->GetCreatureListWithEntryInGrid(HelperList, NPC_HORDE_SOLDIER, 100.0f);
                            me->GetCreatureListWithEntryInGrid(HelperList, NPC_JAINA, 100.0f);
                            me->GetCreatureListWithEntryInGrid(HelperList, NPC_SYLVANAS, 100.0f);
                            me->GetCreatureListWithEntryInGrid(HelperList, NPC_THRALL, 100.0f);
                            if (!HelperList.empty())
                                for (std::list<Creature*>::iterator itr = HelperList.begin(); itr != HelperList.end(); itr++)
                                    (*itr)->DespawnOrUnsummon();
                            if (Map* map = me->GetMap())
                            {
                                Map::PlayerList const& PlayerList = map->GetPlayers();
                                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                {
                                    if (Player* player = i->GetSource())
                                    {
                                        if (me->IsInRange(player, 0.0f, 50.0f))
                                        {
                                            if (player->GetTeamId() == TEAM_ALLIANCE)
                                            {
                                                player->RemoveAura(SPELL_WRYNN_BUFF);
                                                player->RemoveAura(SPELL_JAINA_BUFF);
                                                player->CompleteQuest(QUEST_BATTLE_A);
                                                player->NearTeleportTo(-8445.213867f, 337.384277f, 121.746056f, 5.401534f, false);
                                            }
                                        }
                                    }
                                }
                            }
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_MANHUNT_STARTS_A, 0);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_SEWERS_DONE_A, 0);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_APOTHECARIUM_DONE_A, 0);
                            me->DespawnOrUnsummon();
                            break;
                    }
                }
                else phaseTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_WHIRLWIND:
                        DoCast(me, SPELL_WHIRLWIND);
                        _events.ScheduleEvent(EVENT_WHIRLWIND, 20s);
                        break;
                    case EVENT_HEROIC_LEAP:
                        DoCastVictim(SPELL_HEROIC_LEAP);
                        _events.ScheduleEvent(EVENT_HEROIC_LEAP, 15s, 30s);
                        break;
                    case EVENT_AGGRO_JAINA:
                        if (me->GetVictim())
                        {
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, jainaGUID))
                            {
                                jaina->AI()->AttackStart(me->GetVictim());
                            }
                        }
                        DoCast(me, SPELL_THUNDER);
                        _events.ScheduleEvent(EVENT_AGGRO_JAINA, 2s);
                        break;
                    case EVENT_WRYNN_BUFF:
                        DoCast(me, SPELL_WRYNN_BUFF);
                        _events.ScheduleEvent(EVENT_WRYNN_BUFF, 10s);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_varian_wrynnAI(creature);
    }
};

/*######
## npc_jaina_proudmoore
######*/

class npc_jaina_proudmoore_bfu : public CreatureScript
{
public:
    npc_jaina_proudmoore_bfu() : CreatureScript("npc_jaina_proudmoore_bfu") { }

    struct npc_jaina_proudmoore_bfuAI : public ScriptedAI
    {
        npc_jaina_proudmoore_bfuAI(Creature* creature) : ScriptedAI(creature)
        {
            Reset();
        }

        void Reset() override
        {
            me->SetCorpseDelay(1);
            me->SetRespawnTime(1);
            _events.ScheduleEvent(EVENT_FIREBALL, 1s);
            _events.ScheduleEvent(EVENT_BLIZZARD, 8s);
            _events.ScheduleEvent(EVENT_ELEMENTAL, 30s);
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_THRALL_BUFF, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->GetVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_FIREBALL:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                            DoCast(target, SPELL_FIREBALL);
                        _events.ScheduleEvent(EVENT_FIREBALL, 3s);
                        break;
                    case EVENT_BLIZZARD:
                        DoCast(SPELL_BLIZZARD);
                        _events.ScheduleEvent(EVENT_BLIZZARD, 15s);
                        break;
                    case EVENT_ELEMENTAL:
                        DoCast(SPELL_ELEMENTALS);
                        _events.ScheduleEvent(EVENT_ELEMENTAL, 90s);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_jaina_proudmoore_bfuAI(creature);
    }
};

/*######
## ENEMY
#######*/

/*######
## boss_blight_worm
######*/

class boss_blight_worm : public CreatureScript
{
public:
    boss_blight_worm() : CreatureScript("boss_blight_worm") { }

    struct boss_blight_wormAI : public ScriptedAI
    {
        boss_blight_wormAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetCombatMovement(false);
        }

        void Reset() override
        {
            _events.ScheduleEvent(EVENT_INFEST, 2s);
            _events.ScheduleEvent(EVENT_BLIGHT_BREATH, 750ms);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_INFEST:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0, true))
                            DoCast(target, SPELL_INGEST);
                        _events.ScheduleEvent(EVENT_INFEST, 20s);
                        break;
                    case EVENT_BLIGHT_BREATH:
                        DoCast(SPELL_BLIGHT_BREATH);
                        _events.ScheduleEvent(EVENT_BLIGHT_BREATH, 15s);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_blight_wormAI(creature);
    }
};

/*######
## Spells
######*/

// - 61123 - Ingest
class spell_blight_worm_ingest : public SpellScript
{
    PrepareSpellScript(spell_blight_worm_ingest);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_INGEST });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (Unit* caster = GetCaster())
                target->CastSpell(caster, SPELL_INGEST_TRIGGER, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_blight_worm_ingest::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## HORDE
#######*/

/*######
## npc_thrall_bfu
######*/

class npc_thrall_bfu : public CreatureScript
{
public:
    npc_thrall_bfu() : CreatureScript("npc_thrall_bfu") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                {
                    CloseGossipMenuFor(player);

                    if (auto thrall_ai = CAST_AI(npc_thrall_bfu::npc_thrall_bfuAI, creature->AI()))
                    {
                        if (Creature* sylvannas = GetClosestCreatureWithEntry(creature, NPC_SYLVANAS, 50.0f))
                        {
                            thrall_ai->sylvanasfollowGUID = sylvannas->GetGUID();
                            creature->SetWalk(false);
                            thrall_ai->Start(true, player->GetGUID());
                            thrall_ai->SetDespawnAtEnd(false);
                            thrall_ai->SetDespawnAtFar(false);
                        }
                        else
                            thrall_ai->sylvanasfollowGUID.Clear();
                    }
                    break;
                }
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_BATTLE_H) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_THRALL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnQuestReward(Player* player, Creature* /*creature*/, Quest const* quest, uint32 /*item*/) override
    {
        if (quest->GetQuestId() == QUEST_BATTLE_H)
        {
            player->RemoveAura(SPELL_THRALL_BUFF);
            player->RemoveAura(SPELL_SYLVANAS_BUFF);
            player->CastSpell(player, SPELL_TELEPORT_OG, true);
        }

        return true;
    }

    struct npc_thrall_bfuAI : public npc_escortAI
    {
        npc_thrall_bfuAI(Creature* creature) : npc_escortAI(creature)
        {
            hordeGuardsGUID.clear();
        }

        bool bStepping;
        bool EnableAttack;

        uint32 step;
        uint32 phaseTimer;

        ObjectGuid sylvanasfollowGUID;
        ObjectGuid allianceForcesGUID[ALLIANCE_FORCE_MAXCOUNT];
        ObjectGuid ValimathrasGUID;
        ObjectGuid ValimathrasPortalGUID;
        ObjectGuid WrynnGUID;
        ObjectGuid JainaGUID;
        ObjectGuid SaurfangGUID;
        GuidVector hordeGuardsGUID;

        EventMap _events;

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->RemoveAura(SPELL_HEROIC_VANGUARD);
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            me->SetLootRecipient(nullptr);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                AddEscortState(STATE_ESCORT_RETURNING);
                ReturnToLastPoint();
            }
            else
            {
                me->GetMotionMaster()->MoveTargetedHome();
                Reset();
            }
        }

        void Reset() override
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->Mount(MODEL_WHITE_WULF);
                me->SetCorpseDelay(1);
                me->SetRespawnTime(1);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);

                bStepping = false;
                EnableAttack = false;
                step = 0;
                phaseTimer = 0;
                sylvanasfollowGUID.Clear();
                _events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, 3s);
                _events.ScheduleEvent(EVENT_LAVA_BURST, 5s);
                _events.ScheduleEvent(EVENT_THUNDER, 8s);
                _events.ScheduleEvent(EVENT_AGGRO_SYLVANAS, 2s);
                _events.ScheduleEvent(EVENT_THRALL_BUFF, 2s);

                if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                {
                    valimathras->DespawnOrUnsummon();
                    ValimathrasGUID.Clear();
                }

                if (Creature* valimathrasportal = ObjectAccessor::GetCreature(*me, ValimathrasPortalGUID))
                {
                    valimathrasportal->DespawnOrUnsummon();
                    ValimathrasPortalGUID.Clear();
                }

                if (Creature* wrynn = ObjectAccessor::GetCreature(*me, WrynnGUID))
                {
                    wrynn->DespawnOrUnsummon();
                    WrynnGUID.Clear();
                }

                if (Creature* jaina = ObjectAccessor::GetCreature(*me, JainaGUID))
                {
                    jaina->DespawnOrUnsummon();
                    JainaGUID.Clear();
                }

                if (Creature* saurfang = ObjectAccessor::GetCreature(*me, SaurfangGUID))
                {
                    saurfang->DespawnOrUnsummon();
                    SaurfangGUID.Clear();
                }

                for (ObjectGuid const& guid : hordeGuardsGUID)
                    if (Creature* temp = ObjectAccessor::GetCreature(*me, guid))
                        temp->DespawnOrUnsummon();

                hordeGuardsGUID.clear();
            }
        }

        void JustSummoned(Creature* summoned) override
        {
            switch (summoned->GetEntry())
            {
                case NPC_BLIGHT_ABBERATION:
                    summoned->SetHomePosition(me->GetPosition());
                    summoned->AddThreat(me, 100.0f);
                    break;
                case NPC_WARSONG_BATTLEGUARD:
                    summoned->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);
                    summoned->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                    break;
                case NPC_VARIMATHRAS_PORTAL:
                    summoned->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    summoned->ApplySpellImmune(0, IMMUNITY_ID, SPELL_THRALL_BUFF, true);
                    summoned->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);
                    break;
                case NPC_CAVE_DUMMY:
                    summoned->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    summoned->ApplySpellImmune(0, IMMUNITY_ID, SPELL_THRALL_BUFF, true);
                    summoned->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);
                    summoned->AddAura(SPELL_CYCLONE_FALL, summoned);
                    break;
                case NPC_TREACHEROUS_GUARDIAN_H:
                case NPC_DOCTOR_H:
                case NPC_CHEMIST_H:
                    summoned->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                    summoned->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
                    summoned->ApplySpellImmune(0, IMMUNITY_ID, SPELL_THRALL_BUFF, true);
                    summoned->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);
                    if (!EnableAttack)
                        summoned->SetFaction(FACTION_FRIENDLY);
                    summoned->AddThreat(me, 100.0f);
                    me->AddThreat(summoned, 100.0f);
                    summoned->AI()->AttackStart(me);
                    break;
                case NPC_LEGION_INVADER:
                case NPC_LEGION_DREADWHISPER:
                case NPC_FELGUARD_MORADEUR:
                case NPC_DREADLORD:
                case NPC_BETRAYER_H:
                case NPC_FELBEAST_H:
                    summoned->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                    summoned->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
                    summoned->AddThreat(me, 100.0f);
                    me->AddThreat(summoned, 100.0f);
                    summoned->AI()->AttackStart(me);
                    break;
                case NPC_KHANOK:
                    summoned->SetHomePosition(me->GetPosition());
                    summoned->AddThreat(me, 100.0f);
                    summoned->AI()->AttackStart(me);
                default:
                    break;
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
        {
            switch (summon->GetEntry())
            {
                case NPC_BLIGHT_ABBERATION:
                    UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_COURTYARD_FIGHT_H, 0);
                    UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_COURTYARD_DONE_H, 1);
                    bStepping = true;
                    break;
                case NPC_KHANOK:
                    {
                        UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_INNER_SANCTUM_FIGHT_H, 0);
                        UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_INNER_SANCTUM_DONE_H, 1);
                        FollowThrall();
                        SetEscortPaused(false);
                        std::list<Creature*> SanktumList;
                        me->GetCreatureListWithEntryInGrid(SanktumList, NPC_FELGUARD_MORADEUR, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(SanktumList, NPC_DREADLORD, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(SanktumList, NPC_TREACHEROUS_GUARDIAN_H, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(SanktumList, NPC_DOCTOR_H, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(SanktumList, NPC_CHEMIST_H, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(SanktumList, NPC_BETRAYER_H, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(SanktumList, NPC_FELBEAST_H, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(SanktumList, NPC_DOOMGUARD_PILLARGER, 1000.0f);
                        if (!SanktumList.empty())
                            for (std::list<Creature*>::iterator itr = SanktumList.begin(); itr != SanktumList.end(); itr++)
                                (*itr)->DespawnOrUnsummon();
                        break;
                    }
                case NPC_VARIMATHRAS:
                    {
                        UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_ROYAL_QUARTER_FIGHT_H, 0);
                        UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_ROYAL_QUARTER_DONE_H, 1);
                        std::list<Creature*> ThroneList;
                        me->GetCreatureListWithEntryInGrid(ThroneList, NPC_LEGION_OVERLORD, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(ThroneList, NPC_LEGION_INVADER, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(ThroneList, NPC_LEGION_DREADWHISPER, 1000.0f);
                        me->GetCreatureListWithEntryInGrid(ThroneList, NPC_VARIMATHRAS_PORTAL, 1000.0f);
                        if (!ThroneList.empty())
                            for (std::list<Creature*>::iterator itr = ThroneList.begin(); itr != ThroneList.end(); itr++)
                                (*itr)->DespawnOrUnsummon();
                        SetEscortPaused(false);
                        me->SetWalk(true);
                        break;
                    }
                default:
                    break;
            }
        }

        void UpdateWorldState(Map* map, uint32 id, uint32 state)
        {
            Map::PlayerList const& players = map->GetPlayers();

            if (!players.IsEmpty())
            {
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    if (Player* player = itr->GetSource())
                        player->SendUpdateWorldState(id, state);
                }
            }
        }

        void SetHoldState(bool bOnHold)
        {
            SetEscortPaused(bOnHold);
        }

        void JumpToNextStep(uint32 uiTimer)
        {
            phaseTimer = uiTimer;
            ++step;
        }

        void FollowThrall()
        {
            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
            {
                sylvanas->GetMotionMaster()->Clear();
                sylvanas->SetImmuneToAll(false);
                sylvanas->SetReactState(REACT_AGGRESSIVE);
                sylvanas->SetFaction(FACTION_ESCORT_N_NEUTRAL_ACTIVE);
                sylvanas->GetMotionMaster()->MoveFollow(me, 1, M_PI * 0.1f);
            }
        }

        void ActivateValimathrasPortal()
        {
            if (Creature* portal = me->FindNearestCreature(NPC_VARIMATHRAS_PORTAL, 500.0f))
            {
                portal->SummonCreature(NPC_LEGION_OVERLORD, ThrallSpawn[81].x + rand32() % 5, ThrallSpawn[81].y + rand32() % 5, ThrallSpawn[81].z, TEMPSUMMON_DEAD_DESPAWN);
                portal->DespawnOrUnsummon();
            }
        }

        void SpawnWave(uint32 waveId)
        {
            switch (waveId)
            {
                case 0: // Vortex
                    if (Creature* whirlwind1 = me->SummonCreature(NPC_VORTEX, ThrallSpawn[0].x, ThrallSpawn[0].y, ThrallSpawn[0].z, ThrallSpawn[0].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 30 * IN_MILLISECONDS))
                        whirlwind1->GetMotionMaster()->MoveWaypoint(NPC_WHIRLWIND * 10, false);
                    if (Creature* whirlwind2 = me->SummonCreature(NPC_VORTEX, ThrallSpawn[0].x, ThrallSpawn[0].y, ThrallSpawn[0].z, ThrallSpawn[0].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 30 * IN_MILLISECONDS))
                        whirlwind2->GetMotionMaster()->MoveWaypoint(NPC_WHIRLWIND * 100, false);
                    break;
                case 1:
                    // BATTLING_COURTYARD Initial Spawn
                    for (uint8 i = 0; i < 3; ++i)
                        me->SummonCreature(NPC_DOCTOR_H, ThrallSpawn[i + 1].x, ThrallSpawn[i + 1].y, ThrallSpawn[i + 1].z, ThrallSpawn[i + 1].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS);
                    for (uint8 i = 0; i < 9; ++i)
                        me->SummonCreature(NPC_CHEMIST_H, ThrallSpawn[i + 4].x, ThrallSpawn[i + 4].y, ThrallSpawn[i + 4].z, ThrallSpawn[i + 4].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS);
                    for (uint8 i = 0; i < 6; ++i)
                        me->SummonCreature(NPC_TREACHEROUS_GUARDIAN_H, ThrallSpawn[i + 13].x, ThrallSpawn[i + 13].y, ThrallSpawn[i + 14].z, ThrallSpawn[i + 14].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS);
                    for (uint8 i = 0; i < 4; ++i)
                        me->SummonCreature(NPC_BLIGHT_SLINGER, ThrallSpawn[i + 19].x, ThrallSpawn[i + 19].y, ThrallSpawn[i + 19].z, ThrallSpawn[i + 19].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 900 * IN_MILLISECONDS);
                    break;
                case 2:
                    // Valimathras
                    if (Unit* temp = me->SummonCreature(NPC_VARIMATHRAS, ThrallSpawn[23].x, ThrallSpawn[23].y, ThrallSpawn[23].z, ThrallSpawn[23].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 900 * IN_MILLISECONDS))
                    {
                        ValimathrasGUID = temp->GetGUID();
                        temp->SetImmuneToAll(true);
                    }
                    break;
                case 3:
                    if (Unit* temp = me->SummonCreature(NPC_VARIMATHRAS_PORTAL, ThrallSpawn[24].x, ThrallSpawn[24].y, ThrallSpawn[24].z, ThrallSpawn[24].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 900 * IN_MILLISECONDS))
                        ValimathrasPortalGUID = temp->GetGUID();
                    break;
                case 4:
                    // COURTYARD_FIGHT Spawns
                    for (uint8 i = 0; i < WAVE_COURTYARD_FIGHT; ++i)
                    {
                        switch (urand(0, 2))
                        {
                            case 0:
                                me->SummonCreature(NPC_TREACHEROUS_GUARDIAN_H, ThrallSpawn[25].x + rand32() % 5, ThrallSpawn[25].y + rand32() % 5, ThrallSpawn[25].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_DOCTOR_H, ThrallSpawn[26].x + rand32() % 5, ThrallSpawn[26].y + rand32() % 5, ThrallSpawn[26].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 2:
                                me->SummonCreature(NPC_CHEMIST_H, ThrallSpawn[27].x + rand32() % 5, ThrallSpawn[27].y + rand32() % 5, ThrallSpawn[27].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                case 5:
                    // Bossspawn 1
                    if (Creature* temp = me->SummonCreature(NPC_BLIGHT_ABBERATION, ThrallSpawn[28].x, ThrallSpawn[28].y, ThrallSpawn[28].z, ThrallSpawn[28].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 900 * IN_MILLISECONDS))
                    {
                        me->AddThreat(temp, 100.0f);
                        me->AI()->AttackStart(temp);
                    }
                    break;
                case 6:
                    // COURTYARD_DONE Spawn
                    if (Unit* temp = me->SummonCreature(NPC_WARSONG_BATTLEGUARD, ThrallSpawn[29].x, ThrallSpawn[29].y, ThrallSpawn[29].z, ThrallSpawn[29].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS))
                    {
                        hordeGuardsGUID.push_back(temp->GetGUID());
                        temp->GetMotionMaster()->MovePoint(0, ThrallSpawn[30].x, ThrallSpawn[30].y, ThrallSpawn[30].z);
                    }
                    if (Unit* temp = me->SummonCreature(NPC_WARSONG_BATTLEGUARD, ThrallSpawn[31].x, ThrallSpawn[31].y, ThrallSpawn[31].z, ThrallSpawn[31].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS))
                    {
                        hordeGuardsGUID.push_back(temp->GetGUID());
                        temp->GetMotionMaster()->MovePoint(0, ThrallSpawn[32].x, ThrallSpawn[32].y, ThrallSpawn[32].z);
                    }
                    if (Unit* temp = me->SummonCreature(NPC_WARSONG_BATTLEGUARD, ThrallSpawn[33].x, ThrallSpawn[33].y, ThrallSpawn[33].z, ThrallSpawn[33].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS))
                    {
                        hordeGuardsGUID.push_back(temp->GetGUID());
                        temp->GetMotionMaster()->MovePoint(0, ThrallSpawn[34].x, ThrallSpawn[34].y, ThrallSpawn[34].z);
                    }
                    if (Unit* temp = me->SummonCreature(NPC_WARSONG_BATTLEGUARD, ThrallSpawn[35].x, ThrallSpawn[35].y, ThrallSpawn[35].z, ThrallSpawn[35].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS))
                    {
                        hordeGuardsGUID.push_back(temp->GetGUID());
                        temp->GetMotionMaster()->MovePoint(0, ThrallSpawn[36].x, ThrallSpawn[36].y, ThrallSpawn[36].z);
                    }
                    for (uint8 i = 0; i < 2; ++i)
                        if (Unit* temp = me->SummonCreature(NPC_WARSONG_BATTLEGUARD, ThrallSpawn[i + 44].x, ThrallSpawn[i + 44].y, ThrallSpawn[i + 44].z, ThrallSpawn[i + 44].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS))
                            hordeGuardsGUID.push_back(temp->GetGUID());
                    break;
                case 7:
                    for (uint8 i = 0; i < 9; ++i)
                        me->SummonCreature(NPC_CAVE_DUMMY, ThrallSpawn[i + 46].x, ThrallSpawn[i + 46].y, ThrallSpawn[i + 46].z, ThrallSpawn[i + 46].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600 * IN_MILLISECONDS);
                    break;
                case 8:
                    for (uint8 i = 0; i < 2; ++i)
                        if (Unit* temp = me->SummonCreature(NPC_WARSONG_BATTLEGUARD, ThrallSpawn[i + 57].x, ThrallSpawn[i + 57].y, ThrallSpawn[i + 57].z, ThrallSpawn[i + 57].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS))
                            hordeGuardsGUID.push_back(temp->GetGUID());
                    break;
                case 9:
                    // Top of Undercity - Attacktrashpack
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        switch (urand(0, 2))
                        {
                            case 0:
                                me->SummonCreature(NPC_TREACHEROUS_GUARDIAN_H, ThrallSpawn[59].x + rand32() % 2, ThrallSpawn[59].y + rand32() % 2, ThrallSpawn[59].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_DOCTOR_H, ThrallSpawn[59].x + rand32() % 2, ThrallSpawn[59].y + rand32() % 2, ThrallSpawn[59].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 2:
                                me->SummonCreature(NPC_CHEMIST_H, ThrallSpawn[59].x + rand32() % 2, ThrallSpawn[59].y + rand32() % 2, ThrallSpawn[59].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                case 10:
                    // Top of Undercity - Attacktrashpack
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        switch (urand(0, 1))
                        {
                            case 0:
                                me->SummonCreature(NPC_TREACHEROUS_GUARDIAN_H, ThrallSpawn[60].x + rand32() % 5, ThrallSpawn[60].y + rand32() % 5, ThrallSpawn[60].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_FELGUARD_MORADEUR, ThrallSpawn[60].x + rand32() % 5, ThrallSpawn[60].y + rand32() % 5, ThrallSpawn[60].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                case 11:
                    // Bottom of Undercity - Attacktrashpack
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        switch (urand(0, 1))
                        {
                            case 0:
                                me->SummonCreature(NPC_FELGUARD_MORADEUR, ThrallSpawn[61].x + rand32() % 5, ThrallSpawn[61].y + rand32() % 5, ThrallSpawn[61].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_DREADLORD, ThrallSpawn[61].x + rand32() % 5, ThrallSpawn[61].y + rand32() % 5, ThrallSpawn[61].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                case 12:
                    // Valimathras 2
                    if (Unit* temp = me->SummonCreature(NPC_VARIMATHRAS, ThrallSpawn[63].x, ThrallSpawn[63].y, ThrallSpawn[63].z, ThrallSpawn[63].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300 * IN_MILLISECONDS))
                    {
                        ValimathrasGUID = temp->GetGUID();
                        temp->SetImmuneToAll(true);
                    }
                    break;
                case 13:
                    if (Unit* temp = me->SummonCreature(NPC_VARIMATHRAS_PORTAL, ThrallSpawn[64].x, ThrallSpawn[64].y, ThrallSpawn[64].z, ThrallSpawn[64].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 900 * IN_MILLISECONDS))
                        ValimathrasPortalGUID = temp->GetGUID();
                    break;
                // NPC_KHANOK - Inner Sunktum Spawn Left
                case 14:
                    for (uint8 i = 0; i < 4; ++i)
                    {
                        switch (urand(0, 6))
                        {
                            case 0:
                                me->SummonCreature(NPC_FELGUARD_MORADEUR, ThrallSpawn[65].x + rand32() % 5, ThrallSpawn[65].y + rand32() % 5, ThrallSpawn[65].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_DREADLORD, ThrallSpawn[65].x + rand32() % 5, ThrallSpawn[65].y + rand32() % 5, ThrallSpawn[65].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 2:
                                me->SummonCreature(NPC_TREACHEROUS_GUARDIAN_H, ThrallSpawn[65].x + rand32() % 5, ThrallSpawn[65].y + rand32() % 5, ThrallSpawn[65].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 3:
                                me->SummonCreature(NPC_DOCTOR_H, ThrallSpawn[65].x + rand32() % 5, ThrallSpawn[65].y + rand32() % 5, ThrallSpawn[65].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 4:
                                me->SummonCreature(NPC_CHEMIST_H, ThrallSpawn[65].x + rand32() % 5, ThrallSpawn[65].y + rand32() % 5, ThrallSpawn[65].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 5:
                                me->SummonCreature(NPC_BETRAYER_H, ThrallSpawn[65].x + rand32() % 5, ThrallSpawn[65].y + rand32() % 5, ThrallSpawn[65].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 6:
                                me->SummonCreature(NPC_FELBEAST_H, ThrallSpawn[65].x + rand32() % 5, ThrallSpawn[65].y + rand32() % 5, ThrallSpawn[65].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                // NPC_KHANOK - Inner Sunktum Spawn Right
                case 15:
                    for (uint8 i = 0; i < 4; ++i)
                    {
                        switch (urand(0, 6))
                        {
                            case 0:
                                me->SummonCreature(NPC_FELGUARD_MORADEUR, ThrallSpawn[66].x + rand32() % 5, ThrallSpawn[66].y + rand32() % 5, ThrallSpawn[66].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_DREADLORD, ThrallSpawn[66].x + rand32() % 5, ThrallSpawn[66].y + rand32() % 5, ThrallSpawn[66].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 2:
                                me->SummonCreature(NPC_TREACHEROUS_GUARDIAN_H, ThrallSpawn[66].x + rand32() % 5, ThrallSpawn[66].y + rand32() % 5, ThrallSpawn[66].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 3:
                                me->SummonCreature(NPC_DOCTOR_H, ThrallSpawn[66].x + rand32() % 5, ThrallSpawn[66].y + rand32() % 5, ThrallSpawn[66].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 4:
                                me->SummonCreature(NPC_CHEMIST_H, ThrallSpawn[66].x + rand32() % 5, ThrallSpawn[66].y + rand32() % 5, ThrallSpawn[66].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 5:
                                me->SummonCreature(NPC_BETRAYER_H, ThrallSpawn[66].x + rand32() % 5, ThrallSpawn[66].y + rand32() % 5, ThrallSpawn[66].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 6:
                                me->SummonCreature(NPC_FELBEAST_H, ThrallSpawn[66].x + rand32() % 5, ThrallSpawn[66].y + rand32() % 5, ThrallSpawn[66].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                // NPC_KHANOK - Inner Sunktum Spawn Top
                case 16:
                    me->SummonCreature(NPC_DOOMGUARD_PILLARGER, ThrallSpawn[67].x + rand32() % 15, ThrallSpawn[67].y + rand32() % 15, ThrallSpawn[67].z + rand32() % 5, TEMPSUMMON_DEAD_DESPAWN);
                    break;
                // NPC_KHANOK - Inner Sunktum Spawn Middle
                case 17:
                    if (Creature* temp = me->SummonCreature(NPC_KHANOK, ThrallSpawn[68].x, ThrallSpawn[68].y, ThrallSpawn[68].z, TEMPSUMMON_DEAD_DESPAWN))
                    {
                        me->AddThreat(temp, 100.0f);
                        me->AI()->AttackStart(temp);
                    }
                    break;
                case 18:
                    if (Creature* temp = me->SummonCreature(NPC_WARSONG_BATTLEGUARD, ThrallSpawn[69].x, ThrallSpawn[69].y, ThrallSpawn[69].z, ThrallSpawn[69].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 240 * IN_MILLISECONDS))
                    {
                        hordeGuardsGUID.push_back(temp->GetGUID());
                        temp->AI()->Talk(SAY_FOR_THE_HORDE);
                        temp->GetMotionMaster()->MoveWaypoint(NPC_WARSONG_BATTLEGUARD * 100, false);
                    }
                    break;
                // Valimathras Room Preparation
                case 19:
                    for (uint8 i = 0; i < 3; ++i)
                        me->SummonGameObject(GO_BLOCKED_PASSAGE, ThrallSpawn[i + 70].x, ThrallSpawn[i + 70].y, ThrallSpawn[70].z, ThrallSpawn[i + 70].o, 0.0f, 0.0f, 0.0f, 0.0f, 120 * IN_MILLISECONDS);
                    // Valimathras BossSpawn
                    if (Creature* temp = me->SummonCreature(NPC_VARIMATHRAS, ThrallSpawn[73].x, ThrallSpawn[73].y, ThrallSpawn[73].z, ThrallSpawn[73].o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 1200 * IN_MILLISECONDS))
                    {
                        ValimathrasGUID = temp->GetGUID();
                        temp->SetImmuneToAll(true);
                        temp->CastSpell(me, SPELL_AURA_OF_VARIMATHRAS);
                        temp->CastSpell(me, SPELL_OPENING_LEGION_PORTALS);
                        temp->AI()->Talk(SAY_CLOSE_DOOR);
                    }
                    for (uint8 i = 0; i < 6; ++i)
                    {
                        if (Unit* temp = me->SummonCreature(NPC_VARIMATHRAS_PORTAL, ThrallSpawn[i + 74].x, ThrallSpawn[i + 74].y, ThrallSpawn[i + 74].z, TEMPSUMMON_MANUAL_DESPAWN))
                            temp->CastSpell(me, SPELL_VALIMATHRAS_PORTAL);
                    }
                    break;
                case 20:
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        switch (urand(0, 1))
                        {
                            case 0:
                                me->SummonCreature(NPC_LEGION_INVADER, ThrallSpawn[80].x + rand32() % 5, ThrallSpawn[80].y + rand32() % 5, ThrallSpawn[80].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_LEGION_DREADWHISPER, ThrallSpawn[81].x + rand32() % 5, ThrallSpawn[81].y + rand32() % 5, ThrallSpawn[81].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
                case 21:
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        switch (urand(0, 1))
                        {
                            case 0:
                                me->SummonCreature(NPC_LEGION_INVADER, ThrallSpawn[81].x + rand32() % 5, ThrallSpawn[81].y + rand32() % 5, ThrallSpawn[81].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                            case 1:
                                me->SummonCreature(NPC_LEGION_DREADWHISPER, ThrallSpawn[80].x + rand32() % 5, ThrallSpawn[80].y + rand32() % 5, ThrallSpawn[80].z, TEMPSUMMON_DEAD_DESPAWN);
                                break;
                        }
                    }
                    break;
            }
        }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 1:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 2:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 11:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 13:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 14:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 34:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 36:
                    Talk(THRALL_SAY_SANCTUM_1);
                    UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_ROYAL_QUARTER_FIGHT_H, 1);
                    break;
                case 46:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 57:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 61:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 65:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 66:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 75:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 81:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 104:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 109:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 113:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 117:
                    SetHoldState(true);
                    bStepping = true;
                    break;
                case 118:
                    Talk(THRALL_SAY_THRONE_8);
                    break;
                case 120:
                    SetHoldState(true);
                    bStepping = true;
                    break;
            }
        }

        bool CanAIAttack(Unit const* victim) const override
        {
            return victim->GetEntry() != NPC_BLIGHT_SLINGER;
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (bStepping)
            {
                if (phaseTimer <= diff)
                {
                    switch (step)
                    {
                        //Preparation
                        case 0:
                            me->setActive(true);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 1:
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_COUNTDOWN_H, 1);
                            Talk(THRALL_SAY_PREP_1);
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 2:
                            Talk(THRALL_SAY_PREP_2);
                            JumpToNextStep(14 * IN_MILLISECONDS);
                            break;
                        case 3:
                            if (Creature* guard = me->FindNearestCreature(NPC_HORDE_GUARD, 100.0f))
                                guard->AI()->Talk(SAY_BURN_UC);
                            JumpToNextStep(19 * IN_MILLISECONDS);
                            break;
                        case 4:
                            if (Creature* guard = me->FindNearestCreature(NPC_HORDE_GUARD, 100.0f))
                                guard->AI()->Talk(SAY_PUTRESS_ANGER);
                            JumpToNextStep(25 * IN_MILLISECONDS);
                            break;
                        case 5:
                            Talk(THRALL_SAY_PREP_3);
                            JumpToNextStep(14 * IN_MILLISECONDS);
                            break;
                        case 6:
                            Talk(THRALL_SAY_PREP_4);
                            JumpToNextStep(14 * IN_MILLISECONDS);
                            break;
                        case 7:
                            Talk(THRALL_SAY_PREP_5);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 8:
                            Talk(THRALL_SAY_PREP_6);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 9:
                            Talk(THRALL_SAY_PREP_7);
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 10:
                            DoCast(me, SPELL_THRALL_BUFF);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        // Start Event
                        case 11:
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_COUNTDOWN_H, 0);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_START_H, 1);
                            Talk(THRALL_SAY_PREP_8);
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0);
                            me->SetWalk(false);
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                            {
                                sylvanas->GetMotionMaster()->MoveWaypoint(NPC_SYLVANAS * 100, false);
                                sylvanas->setActive(true);
                            }
                            break;
                        case 12:
                            me->Dismount();
                            JumpToNextStep(1 * IN_MILLISECONDS);
                            break;
                        case 13:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->Dismount();
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 14:
                            Talk(THRALL_SAY_COURTYARD_1);
                            JumpToNextStep(4 * IN_MILLISECONDS);
                            break;
                        case 15:
                            me->CastSpell(me, SPELL_CALL_OF_AIR);
                            SpawnWave(0);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 16:
                            {
                                std::list<Creature*> PlagueList;
                                me->GetCreatureListWithEntryInGrid(PlagueList, NPC_PLAGUE_TRIGGER, 50.0f);
                                if (!PlagueList.empty())
                                    for (std::list<Creature*>::iterator itr = PlagueList.begin(); itr != PlagueList.end(); itr++)
                                        (*itr)->DespawnOrUnsummon();
                                SetEscortPaused(false);
                                me->SetWalk(true);
                                if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                    sylvanas->GetMotionMaster()->MoveWaypoint(NPC_SYLVANAS * 1000, false);
                                JumpToNextStep(3 * IN_MILLISECONDS);
                                break;
                            }
                        case 17:
                            bStepping = false;
                            JumpToNextStep(0);
                            break;
                        case 18:
                            SpawnWave(1);
                            Talk(THRALL_SAY_COURTYARD_2);
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 19:
                            {
                                SpawnWave(2);
                                JumpToNextStep(3 * IN_MILLISECONDS);
                                break;
                            }
                        case 20:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_VALIMATHRAS_INTRO_0);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 21:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_VALIMATHRAS_INTRO_1);
                            JumpToNextStep(9 * IN_MILLISECONDS);
                            break;
                        case 22:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_VALIMATHRAS_INTRO_2);
                            JumpToNextStep(7 * IN_MILLISECONDS);
                            break;
                        case 23:
                            SpawnWave(3);
                            JumpToNextStep(1 * IN_MILLISECONDS);
                            break;
                        case 24:
                            if (Creature* valimathrasportal = ObjectAccessor::GetCreature(*me, ValimathrasPortalGUID))
                                valimathrasportal->CastSpell(valimathrasportal, SPELL_VALIMATHRAS_PORTAL);
                            JumpToNextStep(12 * IN_MILLISECONDS);
                            break;
                        case 25:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                            {
                                valimathras->GetMotionMaster()->MovePoint(0, 1804.559f, 235.504f, 62.753f);
                                valimathras->DespawnOrUnsummon(3s);
                            }
                            if (Creature* valimathrasportal = ObjectAccessor::GetCreature(*me, ValimathrasPortalGUID))
                                valimathrasportal->DespawnOrUnsummon(6s);
                            JumpToNextStep(1 * IN_MILLISECONDS);
                            break;
                        case 26:
                            {
                                Talk(THRALL_SAY_COURTYARD_3);
                                me->CastSpell(me, SPELL_TIDAL_WAVE_SUMMON);
                                std::list<Creature*> HelperList;
                                me->GetCreatureListWithEntryInGrid(HelperList, NPC_SLINGER_TRIGGER, 1000.0f);
                                if (!HelperList.empty())
                                    for (std::list<Creature*>::iterator itr = HelperList.begin(); itr != HelperList.end(); itr++)
                                        (*itr)->DespawnOrUnsummon();
                                JumpToNextStep(5 * IN_MILLISECONDS);
                                break;
                            }
                        // Start COURTYARD_FIGHT
                        case 27:
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            me->SetWalk(false);
                            Talk(THRALL_SAY_COURTYARD_4);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_START_H, 0);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_COURTYARD_FIGHT_H, 1);
                            JumpToNextStep(0);
                            break;
                        case 28:
                            {
                                EnableAttack = true;
                                DoCast(me, SPELL_HEROIC_VANGUARD, true);
                                std::list<Creature*> HostileEndList;
                                me->GetCreatureListWithEntryInGrid(HostileEndList, NPC_TREACHEROUS_GUARDIAN_H, 1000.0f);
                                me->GetCreatureListWithEntryInGrid(HostileEndList, NPC_DOCTOR_H, 1000.0f);
                                me->GetCreatureListWithEntryInGrid(HostileEndList, NPC_CHEMIST_H, 1000.0f);
                                if (!HostileEndList.empty())
                                    for (std::list<Creature*>::iterator itr = HostileEndList.begin(); itr != HostileEndList.end(); itr++) (*itr)->SetFaction(FACTION_MONSTER);
                                SpawnWave(4);
                                JumpToNextStep(10 * IN_MILLISECONDS);
                                break;
                            }
                        case 29:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 30:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 31:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 32:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 33:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 34:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 35:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 36:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 37:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 38:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 39:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 40:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 41:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 42:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 43:
                            SpawnWave(4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 44:
                            SpawnWave(4);
                            JumpToNextStep(2 * IN_MILLISECONDS);
                            break;
                        case 45:
                            SpawnWave(5);
                            bStepping = false;
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        // End COURTYARD_FIGHT
                        case 46:
                            {
                                FollowThrall();
                                std::list<Creature*> HostileList;
                                me->GetCreatureListWithEntryInGrid(HostileList, NPC_TREACHEROUS_GUARDIAN_H, 1000.0f);
                                me->GetCreatureListWithEntryInGrid(HostileList, NPC_DOCTOR_H, 1000.0f);
                                me->GetCreatureListWithEntryInGrid(HostileList, NPC_CHEMIST_H, 1000.0f);
                                me->GetCreatureListWithEntryInGrid(HostileList, NPC_BLIGHT_SLINGER, 1000.0f);
                                for (auto& creature : HostileList)
                                    creature->DespawnOrUnsummon();
                                for (uint8 i = 0; i < 7; ++i)
                                    me->SummonGameObject(GO_HORDE_BANNER, ThrallSpawn[i + 37].x, ThrallSpawn[i + 37].y, ThrallSpawn[i + 37].z, ThrallSpawn[i + 37].o, 0.0f, 0.0f, 0.0f, 0.0f, 120 * IN_MILLISECONDS);
                                SpawnWave(6);
                                SetEscortPaused(false);
                                bStepping = false;
                                me->SetWalk(true);
                                JumpToNextStep(0 * IN_MILLISECONDS);
                                break;
                            }
                        case 47:
                            Talk(THRALL_SAY_COURTYARD_5);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 48:
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        // Elevator Event
                        case 49:
                            Talk(THRALL_SAY_ELEVATOR_1);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 50:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->AI()->Talk(SYLVANAS_SAY_ELEVATOR_1);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 51:
                            Talk(THRALL_SAY_ELEVATOR_2);
                            DoCast(me, SPELL_CALL_OF_AIR);
                            SpawnWave(7);
                            JumpToNextStep(16 * IN_MILLISECONDS);
                            break;
                        case 52:
                            Talk(THRALL_SAY_ELEVATOR_3);
                            JumpToNextStep(4 * IN_MILLISECONDS);
                            break;
                        case 53:
                            SpawnWave(8);
                            me->GetMotionMaster()->MoveJump(ThrallSpawn[55].x, ThrallSpawn[55].y, ThrallSpawn[55].z, 40.0f, 40.0f, 0);
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->GetMotionMaster()->MoveJump(ThrallSpawn[56].x, ThrallSpawn[56].y, ThrallSpawn[56].z, 40.0f, 40.0f, 0);
                            JumpToNextStep(4 * IN_MILLISECONDS);
                            break;
                        case 54:
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            me->SetWalk(true);
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        // Top of Undercity Discussion
                        case 55:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->AI()->Talk(SYLVANAS_SAY_SANCTUM_1);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 56:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->AI()->Talk(SYLVANAS_SAY_SANCTUM_2);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 57:
                            Talk(THRALL_SAY_SANCTUM_2);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 58:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->AI()->Talk(SYLVANAS_SAY_SANCTUM_3);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        // Top of Undercity - Fight
                        case 59:
                            SpawnWave(9);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 60:
                            SpawnWave(9);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 61:
                            SpawnWave(9);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 62:
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            me->SetWalk(true);
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        case 63:
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 64:
                            SpawnWave(10);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 65:
                            SpawnWave(10);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 66:
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            me->SetWalk(true);
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        case 67:
                            SpawnWave(11);
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 68:
                            SpawnWave(11);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 69:
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            me->SetWalk(true);
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        // KHANOK - Valimathtas Intro
                        case 70:
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 71:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->AI()->Talk(SYLVANAS_SAY_SANCTUM_4);
                            SpawnWave(12);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 72:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_VALIMATHRAS_INNER_SANKTUM_0);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 73:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_VALIMATHRAS_INNER_SANKTUM_1);
                            SpawnWave(13);
                            JumpToNextStep(2 * IN_MILLISECONDS);
                            break;
                        case 74:
                            if (Creature* valimathrasportal = ObjectAccessor::GetCreature(*me, ValimathrasPortalGUID))
                                valimathrasportal->CastSpell(valimathrasportal, SPELL_VALIMATHRAS_PORTAL);
                            JumpToNextStep(4 * IN_MILLISECONDS);
                            break;
                        case 75:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                            {
                                valimathras->GetMotionMaster()->MovePoint(0, 1596.642f, 429.811f, -46.3429f);
                                valimathras->DespawnOrUnsummon(3s);
                            }
                            if (Creature* valimathrasportal = ObjectAccessor::GetCreature(*me, ValimathrasPortalGUID))
                                valimathrasportal->DespawnOrUnsummon(3s);
                            JumpToNextStep(2 * IN_MILLISECONDS);
                            break;
                        // KHANOK - Trashspawn
                        case 76:
                            SpawnWave(14);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 77:
                            SpawnWave(15);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 78:
                            SpawnWave(16);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 79:
                            SpawnWave(14);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 80:
                            SpawnWave(15);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 81:
                            SpawnWave(16);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 82:
                            SpawnWave(14);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 83:
                            SpawnWave(15);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 84:
                            SpawnWave(16);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 85:
                            SpawnWave(14);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 86:
                            SpawnWave(15);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 87:
                            SpawnWave(16);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 88:
                            SpawnWave(14);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 89:
                            SpawnWave(15);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 90:
                            SpawnWave(16);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 91:
                            SpawnWave(14);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 92:
                            SpawnWave(15);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 93:
                            SpawnWave(16);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 94:
                            // Spawn Boss 2 KHANOK
                            SpawnWave(17);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 95:
                            SpawnWave(14);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 96:
                            SpawnWave(15);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 97:
                            SpawnWave(16);
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            bStepping = false;
                            break;
                        case 98:
                            // KHANOK - Won
                            Talk(THRALL_SAY_SANCTUM_3);
                            JumpToNextStep(7 * IN_MILLISECONDS);
                            break;
                        case 99:
                            SpawnWave(18);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 100:
                            SpawnWave(18);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 101:
                            SpawnWave(18);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 102:
                            SpawnWave(18);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 103:
                            SpawnWave(18);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 104:
                            SpawnWave(18);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 105:
                            SpawnWave(18);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 106:
                            SpawnWave(18);
                            JumpToNextStep(0.35 * IN_MILLISECONDS);
                            break;
                        case 107:
                            SpawnWave(18);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 108:
                            Talk(THRALL_SAY_SANCTUM_4);
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            me->SetWalk(true);
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        case 109:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->AI()->Talk(SYLVANAS_SAY_SANCTUM_5);
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 110:
                            SpawnWave(19);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 111:
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            me->SetWalk(false);
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        case 112:
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 113:
                            Talk(THRALL_SAY_SANCTUM_5);
                            JumpToNextStep(12 * IN_MILLISECONDS);
                            break;
                        case 114:
                            Talk(THRALL_SAY_SANCTUM_6);
                            DoCast(me, SPELL_CALL_OF_EARTH);
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 115:
                            {
                                std::list<GameObject*> SaronitList;
                                GetGameObjectListWithEntryInGrid(SaronitList, me, GO_BLOCKED_PASSAGE, 80.0f);
                                for (std::list<GameObject*>::const_iterator itr = SaronitList.begin(); itr != SaronitList.end(); ++itr)
                                    if (GameObject* saronit = (*itr))
                                        saronit->UseDoorOrButton();
                                JumpToNextStep(5 * IN_MILLISECONDS);
                                break;
                            }
                        case 116:
                            Talk(THRALL_SAY_SANCTUM_7);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_ROYAL_QUARTER_FIGHT_H, 1);
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        // Valimathras Intro
                        case 117:
                            Talk(THRALL_SAY_THRONE_1);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 118:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                            {
                                valimathras->AI()->Talk(SAY_THRONE_1);
                                valimathras->CastSpell(me, SPELL_OPENING_LEGION_PORTALS);
                            }
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 119:
                            SpawnWave(20);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 120:
                            SpawnWave(21);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 121:
                            ActivateValimathrasPortal();
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_THRONE_2);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 122:
                            SpawnWave(20);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 123:
                            SpawnWave(21);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 124:
                            ActivateValimathrasPortal();
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_THRONE_3);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 125:
                            SpawnWave(20);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 126:
                            SpawnWave(21);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 127:
                            ActivateValimathrasPortal();
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_THRONE_4);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 128:
                            SpawnWave(20);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 129:
                            SpawnWave(21);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 130:
                            ActivateValimathrasPortal();
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_THRONE_5);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 131:
                            SpawnWave(20);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 132:
                            SpawnWave(21);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 133:
                            ActivateValimathrasPortal();
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                                valimathras->AI()->Talk(SAY_THRONE_6);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 134:
                            SpawnWave(20);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 135:
                            SpawnWave(21);
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 136:
                            ActivateValimathrasPortal();
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        // Valimathras Fight
                        case 137:
                            if (Creature* valimathras = ObjectAccessor::GetCreature(*me, ValimathrasGUID))
                            {
                                valimathras->SetImmuneToAll(false);
                                valimathras->RemoveAura(SPELL_AURA_OF_VARIMATHRAS);
                                valimathras->RemoveAura(SPELL_OPENING_LEGION_PORTALS);
                                valimathras->AI()->Talk(SAY_VALIMATHRAS_ATTACK);
                                valimathras->SetHomePosition(me->GetPosition());
                                valimathras->AddThreat(me, 100.0f);
                                me->AddThreat(valimathras, 100.0f);
                                valimathras->AI()->AttackStart(me);
                                me->AI()->AttackStart(valimathras);
                            }
                            bStepping = false;
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        // Valimathras Won
                        case 138:
                            Talk(THRALL_SAY_THRONE_2);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 139:
                            Talk(THRALL_SAY_THRONE_3);
                            JumpToNextStep(2 * IN_MILLISECONDS);
                            break;
                        case 140:
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        case 141:
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 142:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                me->SetFacingToObject(sylvanas);
                            Talk(THRALL_SAY_THRONE_4);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 143:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                            {
                                sylvanas->GetMotionMaster()->MovePoint(0, 1289.48f, 314.33f, -57.32f);
                                sylvanas->CastSpell(sylvanas, SPELL_LEAP_TO_PLATFORM);
                            }
                            JumpToNextStep(10 * IN_MILLISECONDS);
                            break;
                        case 144:
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                            {
                                sylvanas->AI()->Talk(SYLVANAS_SAY_THRONE_1);
                                me->SetFacingToObject(sylvanas);
                                sylvanas->SetFacingToObject(me);
                                me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                            }
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 145:
                            Talk(THRALL_SAY_THRONE_5);
                            FollowThrall();
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        case 146:
                            Talk(THRALL_SAY_THRONE_6);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        case 147:
                            for (uint8 i = 0; i < ALLIANCE_FORCE_MAXCOUNT; ++i)
                            {
                                if (Creature* temp = me->SummonCreature(NPC_SW_SOLDIER, AllianceSpawn[i + 25].x, AllianceSpawn[i + 25].y, AllianceSpawn[i + 25].z, AllianceSpawn[i + 25].o, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    allianceForcesGUID[i] = temp->GetGUID();
                                    temp->SetImmuneToAll(true);
                                    temp->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SYLVANAS_BUFF, true);
                                    temp->SetReactState(REACT_PASSIVE);
                                    temp->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                                }
                            }
                            if (Creature* wrynn = me->SummonCreature(NPC_WRYNN, 1308.862f, 381.809f, -66.044243f, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                WrynnGUID = wrynn->GetGUID();
                                wrynn->SetImmuneToAll(true);
                                wrynn->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                                wrynn->SetReactState(REACT_PASSIVE);
                                wrynn->GetMotionMaster()->MovePoint(0, 1302.543f, 359.472f, -67.295f);
                            }
                            if (Creature* jaina = me->SummonCreature(NPC_JAINA, 1308.862f, 381.809f, -66.044243f, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                JainaGUID = jaina->GetGUID();
                                jaina->SetImmuneToAll(true);
                                jaina->SetReactState(REACT_PASSIVE);
                            }
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        // Wrynn Intro
                        case 148:
                            if (Creature* wrynn = ObjectAccessor::GetCreature(*me, WrynnGUID))
                                wrynn->AI()->Talk(WRYNN_SAY_THRONE_5);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 149:
                            if (Creature* wrynn = ObjectAccessor::GetCreature(*me, WrynnGUID))
                                wrynn->AI()->Talk(WRYNN_SAY_THRONE_6);
                            JumpToNextStep(15 * IN_MILLISECONDS);
                            break;
                        case 150:
                            if (Creature* wrynn = ObjectAccessor::GetCreature(*me, WrynnGUID))
                                wrynn->AI()->Talk(WRYNN_SAY_THRONE_7);
                            JumpToNextStep(16.5 * IN_MILLISECONDS);
                            break;
                        case 151:
                            if (Creature* wrynn = ObjectAccessor::GetCreature(*me, WrynnGUID))
                                wrynn->AI()->Talk(WRYNN_SAY_THRONE_8);
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        // Wrynn Fight
                        case 152:
                            me->SetImmuneToAll(false);
                            if (Creature* wrynn = ObjectAccessor::GetCreature(*me, WrynnGUID))
                            {
                                wrynn->SetImmuneToNPC(false);
                                wrynn->SetImmuneToPC(true);
                                wrynn->SetReactState(REACT_AGGRESSIVE);
                                wrynn->AddThreat(me, 100.0f);
                                me->AddThreat(wrynn, 100.0f);
                                wrynn->AI()->AttackStart(me);
                            }

                            for (uint8 i = 0; i < ALLIANCE_FORCE_MAXCOUNT; ++i)
                            {
                                if (Creature* temp = ObjectAccessor::GetCreature(*me, allianceForcesGUID[i]))
                                {
                                    temp->SetImmuneToAll(false);
                                    temp->SetReactState(REACT_AGGRESSIVE);
                                    temp->AddThreat(me, 100.0f);
                                    temp->AI()->AttackStart(me);
                                }
                            }
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 153:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, JainaGUID))
                            {
                                jaina->GetMotionMaster()->MovePoint(0, AllianceWP[9].x, AllianceWP[9].y, AllianceWP[9].z);
                                jaina->AI()->Talk(JAINA_SAY_THRONE_2);
                            }
                            JumpToNextStep(8 * IN_MILLISECONDS);
                            break;
                        case 154:
                            if (Creature* jaina = ObjectAccessor::GetCreature(*me, JainaGUID))
                            {
                                jaina->AI()->DoCastAOE(SPELL_DEEPFREEZE);
                                jaina->AI()->Talk(JAINA_SAY_THRONE_3);
                            }
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 155:
                            {
                                std::list<Creature*> HelperList;
                                me->GetCreatureListWithEntryInGrid(HelperList, NPC_SW_SOLDIER, 100.0f);
                                me->GetCreatureListWithEntryInGrid(HelperList, NPC_JAINA, 100.0f);
                                me->GetCreatureListWithEntryInGrid(HelperList, NPC_WRYNN, 100.0f);
                                if (!HelperList.empty())
                                    for (std::list<Creature*>::iterator itr = HelperList.begin(); itr != HelperList.end(); itr++)
                                        (*itr)->DespawnOrUnsummon();
                                JumpToNextStep(8 * IN_MILLISECONDS);
                                break;
                            }
                        case 156:
                            Talk(THRALL_SAY_THRONE_7);
                            SetEscortPaused(false);
                            bStepping = false;
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                        case 157:
                            Talk(THRALL_SAY_THRONE_9);
                            me->SetStandState(UNIT_STAND_STATE_SIT);
                            JumpToNextStep(3 * IN_MILLISECONDS);
                            break;
                        // Ending
                        case 158:
                            if (Creature* saurfang = me->SummonCreature(NPC_OVERLORD_SAURFANG, 1297.574f, 347.154f, -65.027f, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                SaurfangGUID = saurfang->GetGUID();
                                saurfang->SetWalk(true);
                                saurfang->GetMotionMaster()->MovePoint(0, 1300.862f, 353.670f, -66.187f);
                            }
                            JumpToNextStep(7 * IN_MILLISECONDS);
                            break;
                        case 159:
                            if (Creature* saurfang = ObjectAccessor::GetCreature(*me, SaurfangGUID))
                            {
                                saurfang->AI()->Talk(SAY_SAURFANG_ARRIVAL_1);
                                saurfang->SetStandState(UNIT_STAND_STATE_SIT);
                            }
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 160:
                            if (Creature* saurfang = ObjectAccessor::GetCreature(*me, SaurfangGUID))
                                saurfang->AI()->Talk(SAY_SAURFANG_ARRIVAL_2);
                            JumpToNextStep(6 * IN_MILLISECONDS);
                            break;
                        case 161:
                            if (Creature* saurfang = ObjectAccessor::GetCreature(*me, SaurfangGUID))
                                saurfang->AI()->Talk(SAY_SAURFANG_ARRIVAL_3);
                            if (Map* map = me->GetMap())
                            {
                                Map::PlayerList const& PlayerList = map->GetPlayers();
                                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                {
                                    if (Player* player = i->GetSource())
                                    {
                                        if (me->IsInRange(player, 0.0f, 50.0f))
                                        {
                                            if (player->GetTeamId() == TEAM_HORDE)
                                            {
                                                player->RemoveAura(SPELL_SYLVANAS_BUFF);
                                                player->RemoveAura(SPELL_THRALL_BUFF);
                                                player->CompleteQuest(QUEST_BATTLE_H);
                                                player->CastSpell(player, SPELL_PHASING_HORDE);
                                            }
                                        }
                                    }
                                }
                            }
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 162:
                            Talk(THRALL_SAY_THRONE_10);
                            JumpToNextStep(5 * IN_MILLISECONDS);
                            break;
                        case 163:
                            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                            me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                            Talk(THRALL_SAY_THRONE_11);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_ROYAL_QUARTER_FIGHT_H, 0);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_INNER_SANCTUM_FIGHT_H, 0);
                            UpdateWorldState(me->GetMap(), WORLD_STATE_BATTLE_FOR_UNDERCITY_COURTYARD_FIGHT_H, 0);
                            std::list<Creature*> HelperList;
                            me->GetCreatureListWithEntryInGrid(HelperList, NPC_SYLVANAS, 100.0f);
                            me->GetCreatureListWithEntryInGrid(HelperList, NPC_OVERLORD_SAURFANG, 100.0f);
                            if (!HelperList.empty())
                                for (std::list<Creature*>::iterator itr = HelperList.begin(); itr != HelperList.end(); itr++)
                                    (*itr)->DespawnOrUnsummon(120s);
                            me->DespawnOrUnsummon(120s);
                            bStepping = false;
                            JumpToNextStep(0 * IN_MILLISECONDS);
                            break;
                    }
                }
                else phaseTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CHAIN_LIGHTNING:
                        DoCastVictim(SPELL_CHAIN_LIGHTNING);
                        _events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, 5s, 8s);
                        break;
                    case EVENT_LAVA_BURST:
                        DoCastVictim(SPELL_LAVA_BURST);
                        _events.ScheduleEvent(EVENT_LAVA_BURST, 3s, 5s);
                        break;
                    case EVENT_THUNDER:
                        DoCast(me, SPELL_THUNDER);
                        _events.ScheduleEvent(EVENT_THUNDER, 15s);
                        break;
                    case EVENT_AGGRO_SYLVANAS:
                        if (me->GetVictim())
                            if (Creature* sylvanas = ObjectAccessor::GetCreature(*me, sylvanasfollowGUID))
                                sylvanas->AI()->AttackStart(me->GetVictim());
                        _events.ScheduleEvent(EVENT_AGGRO_SYLVANAS, 2s);
                        break;
                    case EVENT_THRALL_BUFF:
                        DoCast(me, SPELL_THRALL_BUFF);
                        _events.ScheduleEvent(EVENT_THRALL_BUFF, 10s);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_thrall_bfuAI(creature);
    }
};

/*######
## npc_lady_sylvanas_windrunner_bfu
######*/

class npc_lady_sylvanas_windrunner_bfu : public CreatureScript
{
public:
    npc_lady_sylvanas_windrunner_bfu() : CreatureScript("npc_lady_sylvanas_windrunner_bfu") { }

    struct npc_lady_sylvanas_windrunner_bfuAI : public ScriptedAI
    {
        npc_lady_sylvanas_windrunner_bfuAI(Creature* creature) : ScriptedAI(creature)
        {
            Reset();
        }

        void InitializeAI() override
        {
            me->Mount(MODEL_SKELETON_MOUNT);
        }

        void JustRespawned() override
        {
            me->Mount(MODEL_SKELETON_MOUNT);
        }

        void Reset() override
        {
            me->SetCorpseDelay(1);
            me->SetRespawnTime(1);
            _events.ScheduleEvent(EVENT_BLACK_ARROW, 15s);
            _events.ScheduleEvent(EVENT_SHOOT, 5s);
            _events.ScheduleEvent(EVENT_MULTI_SHOT, 6s);
            _events.ScheduleEvent(EVENT_SHRIEK_OF_HIGHBORN, 3s);
            _events.ScheduleEvent(EVENT_SYLVANAS_BUFF, 1s);
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_WRYNN_BUFF, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_INCREASE_SPEED, true);
        }

        bool CanAIAttack(Unit const* victim) const override
        {
            return victim->GetEntry() != NPC_BLIGHT_SLINGER;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->GetVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_BLACK_ARROW:
                        if (Unit* victim = me->GetVictim())
                            DoCast(victim, SPELL_BLACK_ARROW);
                        _events.ScheduleEvent(EVENT_BLACK_ARROW,6s, 9s);
                        break;
                    case EVENT_SHOOT:
                        if (Unit* victim = me->GetVictim())
                            DoCast(victim, SPELL_SHOT);
                        _events.ScheduleEvent(EVENT_SHOOT, 5s, 10s);
                        break;
                    case EVENT_MULTI_SHOT:
                        if (Unit* victim = me->GetVictim())
                            DoCast(victim, SPELL_MULTI_SHOT);
                        _events.ScheduleEvent(EVENT_MULTI_SHOT, 10s, 13s);
                        break;
                    case EVENT_SHRIEK_OF_HIGHBORN:
                        DoCastVictim(SPELL_SHRIEK_OF_HIGHBORN);
                        _events.ScheduleEvent(EVENT_SHRIEK_OF_HIGHBORN, 3s);
                        break;
                    case EVENT_SYLVANAS_BUFF:
                        DoCast(me, SPELL_SYLVANAS_BUFF, true);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_lady_sylvanas_windrunner_bfuAI(creature);
    }
};

/*######
## AddSC
######*/

void AddSC_undercity()
{
    new npc_lady_sylvanas_windrunner();
    new npc_highborne_lamenter();
    new npc_parqual_fintallas();

    new npc_varian_wrynn();
    new npc_thrall_bfu();
    new npc_jaina_proudmoore_bfu();
    new npc_lady_sylvanas_windrunner_bfu();
    new boss_blight_worm();
    RegisterSpellScript(spell_blight_worm_ingest);
}
