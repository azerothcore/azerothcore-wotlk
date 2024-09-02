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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "GameTime.h"
#include "MapMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "ulduar.h"

enum SpellData
{
    SPELL_BERSERK                                   = 64238,

    // PHASE 1:
    SPELL_NAPALM_SHELL_25                           = 65026,
    SPELL_NAPALM_SHELL_10                           = 63666,

    SPELL_PLASMA_BLAST_25                           = 64529,
    SPELL_PLASMA_BLAST_10                           = 62997,

    SPELL_SHOCK_BLAST                               = 63631,

    SPELL_PROXIMITY_MINES                           = 63027,
    NPC_PROXIMITY_MINE                              = 34362,
    SPELL_MINE_EXPLOSION_25                         = 63009,
    SPELL_MINE_EXPLOSION_10                         = 66351,
    SPELL_SUMMON_PROXIMITY_MINE                     = 65347,

    // PHASE 2:
    SPELL_HEAT_WAVE                                 = 64533,

    SPELL_ROCKET_STRIKE_AURA                        = 64064,
    NPC_ROCKET_VISUAL                               = 34050,
    NPC_ROCKET_STRIKE_N                             = 34047,

    SPELL_RAPID_BURST                               = 63382,
    SPELL_RAPID_BURST_DAMAGE_25_1                   = 64531,
    SPELL_RAPID_BURST_DAMAGE_25_2                   = 64532,
    SPELL_RAPID_BURST_DAMAGE_10_1                   = 63387,
    SPELL_RAPID_BURST_DAMAGE_10_2                   = 64019,
    SPELL_SUMMON_BURST_TARGET                       = 64840,

    SPELL_SPINNING_UP                               = 63414,

    // PHASE 3:
    SPELL_PLASMA_BALL_25                            = 64535,
    SPELL_PLASMA_BALL_10                            = 63689,

    SPELL_MAGNETIC_CORE                             = 64436,
    SPELL_SPINNING                                  = 64438,

    SPELL_SUMMON_BOMB_BOT                           = 63811,
    SPELL_BB_EXPLODE                                = 63801,

    SPELL_BEAM_GREEN                                = 63295,
    SPELL_BEAM_YELLOW                               = 63292,
    SPELL_BEAM_BLUE                                 = 63294,

    // PHASE 4:
    SPELL_HAND_PULSE_10_R                           = 64352,
    SPELL_HAND_PULSE_25_R                           = 64537,
    SPELL_HAND_PULSE_10_L                           = 64348,
    SPELL_HAND_PULSE_25_L                           = 64536,

    SPELL_SELF_REPAIR                               = 64383,
    SPELL_SLEEP_VISUAL_1                            = 64393,
    SPELL_SLEEP_VISUAL_2                            = 64394,
};

enum NPCs
{
    //NPC_MIMIRON                                   = 33350,
    NPC_LEVIATHAN_MKII                              = 33432,
    NPC_LEVIATHAN_MKII_CANNON                       = 34071,
    NPC_VX001                                       = 33651,
    NPC_AERIAL_COMMAND_UNIT                         = 33670,
    NPC_COMPUTER                                    = 34143,
    NPC_BOMB_BOT                                    = 33836,
    NPC_BOT_SUMMON_TRIGGER                          = 33856,
    NPC_ASSAULT_BOT                                 = 34057,
    NPC_JUNK_BOT                                    = 33855,
    NPC_MAGNETIC_CORE                               = 34068,
};

enum GOs
{
    //GO_MIMIRON_ELEVATOR                           = 194749,
    GO_DOOR_1                                       = 194776,
    GO_DOOR_2                                       = 194774,
    GO_DOOR_3                                       = 194775,
    GO_BUTTON                                       = 194739,
    // pads: 194740-48
};

enum HardMode
{
    SPELL_EMERGENCY_MODE                            = 64582,
    SPELL_SELF_DESTRUCT                             = 64610,

    SPELL_SUMMON_FLAMES_INITIAL                     = 64563,
    NPC_FLAMES_INITIAL                              = 34363,
    SPELL_SUMMON_FLAMES_SPREAD                      = 64564,
    NPC_FLAMES_SPREAD                               = 34121,
    SPELL_FLAMES_AURA                               = 64561,

    SPELL_VX001_FROST_BOMB                          = 64623,
    SPELL_FROST_BOMB_VISUAL_AURA                    = 64624,
    SPELL_SUMMON_FROST_BOMB                         = 64627,
    NPC_FROST_BOMB                                  = 34149,
    SPELL_FROST_BOMB_EXPLOSION_10                   = 64626,
    SPELL_FROST_BOMB_EXPLOSION_25                   = 65333,

    SPELL_FLAME_SUPPRESSANT_10yd                    = 65192,
    SPELL_FLAME_SUPPRESSANT_50000yd                 = 64570,

    SPELL_WATER_SPRAY                               = 64619,
    SPELL_DEAFENING_SIREN                           = 64616,
    NPC_EMERGENCY_FIRE_BOT                          = 34147,

    SPELL_ENTER_VEHICLE_0                           = 63112,
    SPELL_ENTER_VEHICLE_1                           = 63313,
    SPELL_ENTER_VEHICLE_2                           = 63314,
    SPELL_ENTER_VEHICLE_4                           = 63316,
};

enum EVENTS
{
    // Mimiron:
    EVENT_SIT_LMK2                                  = 1,
    EVENT_SIT_LMK2_INTERVAL                         = 2,
    EVENT_LMK2_RETREAT_INTERVAL                     = 7,
    EVENT_ELEVATOR_INTERVAL_1                       = 8,
    EVENT_ELEVATOR_INTERVAL_2                       = 9,
    EVENT_SITTING_ON_VX001                          = 10,
    EVENT_ENTER_VX001                               = 11,
    EVENT_EMOTE_VX001                               = 12,
    EVENT_VX001_START_FIGHT                         = 13,
    EVENT_ELEVATOR_INTERVAL_0                       = 14,
    EVENT_GET_OUT_VX001                             = 21,
    EVENT_SAY_VX001_DEAD                            = 22,
    EVENT_ENTER_ACU                                 = 23,
    EVENT_SAY_ACU_ACTIVATE                          = 24,
    EVENT_ACU_START_ATTACK                          = 25,
    EVENT_VX001_EMOTESTATE_DEATH                    = 26,
    EVENT_SAY_ACU_DEAD                              = 31,
    EVENT_LEVIATHAN_COME_CLOSER                     = 32,
    EVENT_VX001_EMOTE_JUMP                          = 33,
    EVENT_LEVIATHAN_RIDE_MIDDLE                     = 34,
    EVENT_JOIN_TOGETHER                             = 342,
    EVENT_JOIN_ACU                                  = 35,
    EVENT_START_PHASE4                              = 36,
    EVENT_FINISH                                    = 50,
    EVENT_STAND_UP_FRIENDLY                         = 51,
    EVENT_SAY_VOLTRON_DEAD                          = 52,
    EVENT_DISAPPEAR                                 = 53,
    EVENT_BERSERK                                   = 54,
    EVENT_BERSERK_2                                 = 55,

    // Leviathan:
    EVENT_SPELL_NAPALM_SHELL                        = 3,
    EVENT_SPELL_PLASMA_BLAST                        = 4,
    EVENT_SPELL_SHOCK_BLAST                         = 5,
    EVENT_PROXIMITY_MINES_1                         = 6,

    // VX001:
    EVENT_SPELL_HEAT_WAVE                           = 15,
    EVENT_SPELL_ROCKET_STRIKE                       = 16,
    EVENT_REINSTALL_ROCKETS                         = 17,
    EVENT_SPELL_RAPID_BURST                         = 18,
    EVENT_SPELL_RAPID_BURST_INTERVAL                = 19,
    EVENT_SPELL_SPINNING_UP                         = 20,
    EVENT_HAND_PULSE                                = 37,

    // ACU:
    EVENT_SPELL_PLASMA_BALL                         = 27,
    EVENT_SUMMON_BOMB_BOT                           = 28,
    EVENT_BOMB_BOT_CHASE                            = 29,
    EVENT_BOMB_BOT_RELOCATE                         = 30,
    EVENT_SUMMON_ASSAULT_BOT                        = 40,
    EVENT_SUMMON_JUNK_BOT                           = 41,
    EVENT_MAGNETIC_CORE_PULL_DOWN                   = 42,
    EVENT_MAGNETIC_CORE_FREE                        = 43,
    EVENT_MAGNETIC_CORE_REMOVE_IMMOBILIZE           = 44,

    // Hard mode:
    EVENT_COMPUTER_SAY_INITIATED                    = 60,
    EVENT_COMPUTER_SAY_MINUTES                      = 61,
    EVENT_MIMIRON_SAY_HARDMODE                      = 62,
    EVENT_SPAWN_FLAMES_INITIAL                      = 63,
    EVENT_FLAMES_SPREAD                             = 64,
    EVENT_FLAME_SUPPRESSION_50000                   = 65,
    EVENT_FLAME_SUPPRESSION_10                      = 66,
    EVENT_FROST_BOMB                                = 67,
    EVENT_SUMMON_EMERGENCY_FIRE_BOTS                = 68,
    EVENT_EMERGENCY_BOT_CHECK                       = 69,
    EVENT_EMERGENCY_BOT_ATTACK                      = 70,
};

#define SPELL_NAPALM_SHELL                          RAID_MODE(SPELL_NAPALM_SHELL_10, SPELL_NAPALM_SHELL_25)
#define SPELL_PLASMA_BLAST                          RAID_MODE(SPELL_PLASMA_BLAST_10, SPELL_PLASMA_BLAST_25)
#define SPELL_MINE_EXPLOSION                        RAID_MODE(SPELL_MINE_EXPLOSION_10, SPELL_MINE_EXPLOSION_25)
#define SPELL_PLASMA_BALL                           RAID_MODE(SPELL_PLASMA_BALL_10, SPELL_PLASMA_BALL_25)
#define SPELL_HAND_PULSE_R                          RAID_MODE(SPELL_HAND_PULSE_10_R, SPELL_HAND_PULSE_25_R)
#define SPELL_HAND_PULSE_L                          RAID_MODE(SPELL_HAND_PULSE_10_L, SPELL_HAND_PULSE_25_L)
#define SPELL_FROST_BOMB_EXPLOSION                  RAID_MODE(SPELL_FROST_BOMB_EXPLOSION_10, SPELL_FROST_BOMB_EXPLOSION_25)

enum Texts
{
    // Mimiron
    SAY_AGGRO                                       = 0, // Unused
    SAY_HARDMODE_ON                                 = 1,
    SAY_MKII_ACTIVATE                               = 2,
    SAY_MKII_SLAY                                   = 3,
    SAY_MKII_DEATH                                  = 4,
    SAY_VX001_ACTIVATE                              = 5,
    SAY_VX001_SLAY                                  = 6,
    SAY_VX001_DEATH                                 = 7,
    SAY_AERIAL_ACTIVATE                             = 8,
    SAY_AERIAL_SLAY                                 = 9,
    SAY_AERIAL_DEATH                                = 10,
    SAY_V07TRON_ACTIVATE                            = 11,
    SAY_V07TRON_SLAY                                = 12,
    SAY_V07TRON_DEATH                               = 13,
    SAY_BERSERK                                     = 14,

    // MK II
    EMOTE_PLASMA_BLAST                              = 0,

    // Computer (Hardmode countdown)
    TALK_COMPUTER_INITIATED                         = 0,
    TALK_COMPUTER_TERMINATED                        = 1,
    TALK_COMPUTER_TEN                               = 2,
    TALK_COMPUTER_NINE                              = 3,
    TALK_COMPUTER_EIGHT                             = 4,
    TALK_COMPUTER_SEVEN                             = 5,
    TALK_COMPUTER_SIX                               = 6,
    TALK_COMPUTER_FIVE                              = 7,
    TALK_COMPUTER_FOUR                              = 8,
    TALK_COMPUTER_THREE                             = 9,
    TALK_COMPUTER_TWO                               = 10,
    TALK_COMPUTER_ONE                               = 11,
    TALK_COMPUTER_ZERO                              = 12,
};

#define GetMimiron() ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(TYPE_MIMIRON))
#define GetLMK2() ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_MIMIRON_LEVIATHAN_MKII))
#define GetVX001() ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_MIMIRON_VX001))
#define GetACU() ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_MIMIRON_ACU))

class boss_mimiron : public CreatureScript
{
public:
    boss_mimiron() : CreatureScript("boss_mimiron") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_mimironAI>(pCreature);
    }

    struct boss_mimironAI : public ScriptedAI
    {
        boss_mimironAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = me->GetInstanceScript();
            if (!me->IsAlive())
                if (pInstance)
                    pInstance->SetData(TYPE_MIMIRON, DONE);
            bIsEvading = false;
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        bool bIsEvading;
        bool hardmode;
        bool berserk;
        bool bAchievProximityMine;
        bool bAchievBombBot;
        bool bAchievRocketStrike;
        uint32 allowedFlameSpreadTime;
        bool changeAllowedFlameSpreadTime;
        uint8 minutesTalkNum;
        uint32 outofCombatTimer;

        void Reset() override
        {
            hardmode = false;
            berserk = false;
            bAchievProximityMine = false;
            bAchievBombBot = false;
            bAchievRocketStrike = false;
            allowedFlameSpreadTime = 0;
            outofCombatTimer = 0;
            changeAllowedFlameSpreadTime = false;
            ResetGameObjects();
            events.Reset();
            summons.DespawnAll();
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            if (pInstance && pInstance->GetData(TYPE_MIMIRON) != DONE)
                pInstance->SetData(TYPE_MIMIRON, NOT_STARTED);
        }

        void AttackStart(Unit* who) override
        {
            if (who)
                me->Attack(who, true); // skip following
        }

        void JustReachedHome() override
        {
            me->setActive(false);
            ScriptedAI::JustReachedHome();
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            me->setActive(true);
            DoZoneInCombat();
            me->RemoveAllAuras();
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            events.Reset();

            if (Creature* c = GetLMK2())
            {
                if (c->IsInEvadeMode())
                {
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    return;
                }
                if (!c->IsAlive())
                    c->Respawn();

                me->EnterVehicle(c, 1);
            }
            else
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }
            CloseDoorAndButton();

            if (!hardmode)
            {
                Talk(SAY_MKII_ACTIVATE);
                events.ScheduleEvent(EVENT_SIT_LMK2, 6s);
                events.ScheduleEvent(EVENT_BERSERK, 15min);
            }
            else
            {
                events.ScheduleEvent(EVENT_MIMIRON_SAY_HARDMODE, 7s);
                events.ScheduleEvent(EVENT_BERSERK, Is25ManRaid() ? 10min : 8min);

                events.ScheduleEvent(EVENT_COMPUTER_SAY_INITIATED, 0ms);
                events.ScheduleEvent(EVENT_COMPUTER_SAY_MINUTES, 3s);
                minutesTalkNum = Is25ManRaid() ? TALK_COMPUTER_TEN : TALK_COMPUTER_EIGHT;
                for (uint32 i = 0; i < uint32(TALK_COMPUTER_ZERO - minutesTalkNum - 1); ++i)
                    events.ScheduleEvent(EVENT_COMPUTER_SAY_MINUTES, (i + 1)*MINUTE * IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_COMPUTER_SAY_MINUTES, (TALK_COMPUTER_ZERO - minutesTalkNum)*MINUTE * IN_MILLISECONDS + 6000);
            }

            // ensure LMK2 is at proper position
            if (pInstance)
                if (Creature* LMK2 = GetLMK2())
                {
                    LMK2->UpdatePosition(LMK2->GetHomePosition(), true);
                    LMK2->StopMovingOnCurrentPos();
                }

            if (pInstance && pInstance->GetData(TYPE_MIMIRON) != DONE)
                pInstance->SetData(TYPE_MIMIRON, IN_PROGRESS);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->IsInCombat())
            {
                outofCombatTimer += diff;
                if (outofCombatTimer >= 10000)
                {
                    outofCombatTimer = 0;
                    if (Creature* c = GetLMK2())
                        me->CastSpell(c, RAND(SPELL_ENTER_VEHICLE_0, SPELL_ENTER_VEHICLE_1, SPELL_ENTER_VEHICLE_2, SPELL_ENTER_VEHICLE_4), true);
                }
                return;
            }

            Position p = me->GetHomePosition();
            if (me->GetExactDist(&p) > 80.0f || !SelectTargetFromPlayerList(150.0f))
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }

            events.Update(diff);

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_COMPUTER_SAY_INITIATED:
                    if( Creature* computer = me->SummonCreature(NPC_COMPUTER, 2746.7f, 2569.44f, 410.39f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 1000) )
                        computer->AI()->Talk(TALK_COMPUTER_INITIATED);
                    break;
                case EVENT_COMPUTER_SAY_MINUTES:
                    if( Creature* computer = me->SummonCreature(NPC_COMPUTER, 2746.7f, 2569.44f, 410.39f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 1000) )
                        computer->AI()->Talk(minutesTalkNum++);
                    break;
                case EVENT_MIMIRON_SAY_HARDMODE:
                    Talk(SAY_HARDMODE_ON);
                    events.ScheduleEvent(EVENT_SPAWN_FLAMES_INITIAL, 0ms);
                    events.ScheduleEvent(EVENT_SIT_LMK2, 4s);
                    break;
                case EVENT_SPAWN_FLAMES_INITIAL:
                    {
                        if (changeAllowedFlameSpreadTime)
                            allowedFlameSpreadTime = GameTime::GetGameTime().count();

                        std::vector<Player*> pg;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if( Player* plr = itr->GetSource() )
                                if( plr->IsAlive() && plr->GetExactDist2d(me) < 150.0f && !plr->IsGameMaster() )
                                    pg.push_back(plr);

                        for( uint8 i = 0; i < 3; ++i )
                            if( !pg.empty() )
                            {
                                uint8 index = urand(0, pg.size() - 1);
                                Player* player = pg[index];
                                float angle = rand_norm() * 2 * M_PI;
                                float z = 364.35f;
                                if (!player->IsWithinLOS(player->GetPositionX() + cos(angle) * 5.0f, player->GetPositionY() + std::sin(angle) * 5.0f, z))
                                {
                                    angle = player->GetAngle(2744.65f, 2569.46f);
                                }
                                me->CastSpell(player->GetPositionX() + cos(angle) * 5.0f, player->GetPositionY() + std::sin(angle) * 5.0f, z, SPELL_SUMMON_FLAMES_INITIAL, true);
                                pg.erase(pg.begin() + index);
                            }

                        events.Repeat(30s);
                    }
                    break;
                case EVENT_BERSERK:
                    berserk = true;
                    Talk(SAY_BERSERK);
                    if( hardmode )
                        me->SummonCreature(33576, 2744.78f, 2569.47f, 364.32f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 120000);
                    events.ScheduleEvent(EVENT_BERSERK_2, 0ms);
                    break;
                case EVENT_BERSERK_2:
                    {
                        Creature* VX001 = nullptr;
                        Creature* LMK2 = nullptr;
                        Creature* ACU = nullptr;
                        if ((VX001 = GetVX001()))
                            VX001->CastSpell(VX001, SPELL_BERSERK, true);
                        if ((LMK2 = GetLMK2()))
                            LMK2->CastSpell(LMK2, SPELL_BERSERK, true);
                        if ((ACU = GetACU()))
                            ACU->CastSpell(ACU, SPELL_BERSERK, true);
                        events.Repeat(30s);
                    }
                    break;
                case EVENT_SIT_LMK2:
                    if(Creature* LMK2 = GetLMK2())
                    {
                        me->EnterVehicle(LMK2, 6);
                        events.ScheduleEvent(EVENT_SIT_LMK2_INTERVAL, 2s);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_SIT_LMK2_INTERVAL:
                    if (Creature* LMK2 = GetLMK2())
                    {
                        if (hardmode)
                        {
                            LMK2->CastSpell(LMK2, SPELL_EMERGENCY_MODE, true);
                            if( Vehicle* veh = LMK2->GetVehicleKit() )
                                if( Unit* cannon = veh->GetPassenger(3) )
                                    cannon->CastSpell(cannon, SPELL_EMERGENCY_MODE, true);
                        }
                        LMK2->AI()->SetData(1, 1);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_LMK2_RETREAT_INTERVAL:
                    if (Creature* LMK2 = GetLMK2())
                    {
                        me->EnterVehicle(LMK2, 1);
                        Talk(SAY_MKII_DEATH);
                        LMK2->SetFacingTo(3.58f);
                        events.ScheduleEvent(EVENT_ELEVATOR_INTERVAL_0, 6s);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_ELEVATOR_INTERVAL_0:
                    if( GameObject* elevator = me->FindNearestGameObject(GO_MIMIRON_ELEVATOR, 100.0f) )
                    {
                        elevator->SetLootState(GO_READY);
                        elevator->UseDoorOrButton(0, false);
                        elevator->EnableCollision(false);
                    }
                    events.ScheduleEvent(EVENT_ELEVATOR_INTERVAL_1, 6s);
                    break;
                case EVENT_ELEVATOR_INTERVAL_1:
                    if(me->SummonCreature(NPC_VX001, 2744.65f, 2569.46f, 364.40f, 3.14f, TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        if( GameObject* elevator = me->FindNearestGameObject(GO_MIMIRON_ELEVATOR, 100.0f) )
                        {
                            elevator->SetLootState(GO_READY);
                            elevator->UseDoorOrButton(0, true);
                            elevator->EnableCollision(false);
                        }
                        events.ScheduleEvent(EVENT_ELEVATOR_INTERVAL_2, 18s);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_ELEVATOR_INTERVAL_2:
                    if (Creature* VX001 = GetVX001())
                    {
                        me->EnterVehicle(VX001, 0);
                        events.ScheduleEvent(EVENT_SITTING_ON_VX001, 4s);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_SITTING_ON_VX001:
                    Talk(SAY_VX001_ACTIVATE);
                    events.ScheduleEvent(EVENT_ENTER_VX001, 5s);
                    break;
                case EVENT_ENTER_VX001:
                    if( Creature* VX001 = GetVX001() )
                    {
                        me->EnterVehicle(VX001, 1);
                        events.ScheduleEvent(EVENT_EMOTE_VX001, 2s);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_EMOTE_VX001:
                    if( Creature* VX001 = GetVX001() )
                    {
                        VX001->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                        events.ScheduleEvent(EVENT_VX001_START_FIGHT, 1750ms);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_VX001_START_FIGHT:
                    if( Creature* VX001 = GetVX001() )
                    {
                        if( hardmode )
                            VX001->CastSpell(VX001, SPELL_EMERGENCY_MODE, true);
                        VX001->AI()->SetData(1, 2);
                        me->SetInCombatWithZone();
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_VX001_EMOTESTATE_DEATH:
                    if( Creature* VX001 = GetVX001() )
                    {
                        VX001->HandleEmoteCommand(EMOTE_STATE_DROWNED);
                        VX001->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DROWNED);
                        events.ScheduleEvent(EVENT_GET_OUT_VX001, 2500ms);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_GET_OUT_VX001:
                    if( Creature* VX001 = GetVX001() )
                        if( Creature* ACU = me->SummonCreature(NPC_AERIAL_COMMAND_UNIT, 2743.91f, 2568.78f, 391.34f, M_PI, TEMPSUMMON_MANUAL_DESPAWN) )
                        {
                            me->EnterVehicle(VX001, 4);
                            float speed = ACU->GetDistance(2737.75f, 2574.22f, 381.34f) / 2.0f;
                            ACU->MonsterMoveWithSpeed(2737.75f, 2574.22f, 381.34f, speed);
                            ACU->SetPosition(2737.75f, 2574.22f, 381.34f, M_PI);
                            events.ScheduleEvent(EVENT_SAY_VX001_DEAD, 2s);
                            break;
                        }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_SAY_VX001_DEAD:
                    changeAllowedFlameSpreadTime = true;
                    Talk(SAY_VX001_DEATH);
                    events.ScheduleEvent(EVENT_ENTER_ACU, 7s);
                    break;
                case EVENT_ENTER_ACU:
                    if( Creature* ACU = GetACU() )
                    {
                        me->EnterVehicle(ACU, 0);
                        events.ScheduleEvent(EVENT_SAY_ACU_ACTIVATE, 6s);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_SAY_ACU_ACTIVATE:
                    Talk(SAY_AERIAL_ACTIVATE);
                    events.ScheduleEvent(EVENT_ACU_START_ATTACK, 4s);
                    break;
                case EVENT_ACU_START_ATTACK:
                    if( Creature* ACU = GetACU() )
                    {
                        if( hardmode )
                            ACU->CastSpell(ACU, SPELL_EMERGENCY_MODE, true);
                        ACU->AI()->SetData(1, 3);
                        me->SetInCombatWithZone();
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_SAY_ACU_DEAD:
                    Talk(SAY_AERIAL_DEATH);
                    events.ScheduleEvent(EVENT_LEVIATHAN_COME_CLOSER, 5s);
                    break;
                case EVENT_LEVIATHAN_COME_CLOSER:
                    if (Creature* LMK2 = GetLMK2())
                    {
                        LMK2->GetMotionMaster()->MoveCharge(2755.77f, 2574.95f, 364.31f, 21.0f);
                        events.ScheduleEvent(EVENT_VX001_EMOTE_JUMP, 4s);
                        break;
                    }
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_VX001_EMOTE_JUMP:
                    {
                        Creature* LMK2 = GetLMK2();
                        Creature* VX001 = GetVX001();
                        if( !VX001 || !LMK2 )
                        {
                            EnterEvadeMode(EVADE_REASON_OTHER);
                            return;
                        }

                        VX001->SendMeleeAttackStop();
                        VX001->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_CUSTOM_SPELL_02);
                        VX001->HandleEmoteCommand(EMOTE_ONESHOT_CUSTOM_SPELL_02);
                        events.ScheduleEvent(EVENT_LEVIATHAN_RIDE_MIDDLE, 4800ms);
                    }
                    break;
                case EVENT_LEVIATHAN_RIDE_MIDDLE:
                    {
                        Creature* VX001 = GetVX001();
                        Creature* LMK2 = GetLMK2();
                        if( !VX001 || !LMK2 )
                        {
                            EnterEvadeMode(EVADE_REASON_OTHER);
                            return;
                        }

                        LMK2->GetMotionMaster()->MoveCharge(2744.65f, 2569.46f, 364.31f, 21.0f);
                        VX001->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_CUSTOM_SPELL_01);
                        VX001->HandleEmoteCommand(EMOTE_STATE_CUSTOM_SPELL_01);
                        VX001->EnterVehicle(LMK2, 3);
                        events.ScheduleEvent(EVENT_JOIN_TOGETHER, 3s);
                    }
                    break;
                case EVENT_JOIN_TOGETHER:
                    {
                        Creature* ACU = GetACU();
                        Creature* VX001 = GetVX001();
                        if( !VX001 || !ACU )
                        {
                            EnterEvadeMode(EVADE_REASON_OTHER);
                            return;
                        }

                        ACU->SetDisableGravity(false);
                        ACU->EnterVehicle(VX001, 3);
                        me->EnterVehicle(VX001, 1);
                        Talk(SAY_V07TRON_ACTIVATE);
                        events.ScheduleEvent(EVENT_START_PHASE4, 10s);
                    }
                    break;
                case EVENT_START_PHASE4:
                    {
                        Creature* VX001 = GetVX001();
                        Creature* LMK2 = GetLMK2();
                        Creature* ACU = GetACU();
                        if( !VX001 || !LMK2 || !ACU )
                        {
                            EnterEvadeMode(EVADE_REASON_OTHER);
                            return;
                        }

                        LMK2->AI()->SetData(1, 4);
                        VX001->AI()->SetData(1, 4);
                        ACU->AI()->SetData(1, 4);
                        LMK2->CastSpell(LMK2, SPELL_SELF_REPAIR, true); //LMK2->SetHealth( LMK2->GetMaxHealth()/2 );
                        VX001->CastSpell(VX001, SPELL_SELF_REPAIR, true); //VX001->SetHealth( VX001->GetMaxHealth()/2 );
                        ACU->CastSpell(ACU, SPELL_SELF_REPAIR, true); //ACU->SetHealth( ACU->GetMaxHealth()/2 );
                        if( hardmode )
                        {
                            LMK2->CastSpell(LMK2, SPELL_EMERGENCY_MODE, true);
                            VX001->CastSpell(VX001, SPELL_EMERGENCY_MODE, true);
                            ACU->CastSpell(ACU, SPELL_EMERGENCY_MODE, true);
                        }
                        me->SetInCombatWithZone();
                    }
                    break;
                case EVENT_FINISH:
                    {
                        Creature* LMK2 = GetLMK2();
                        Creature* VX001 = GetVX001();
                        Creature* ACU = GetACU();

                        if (!VX001 || !LMK2 || !ACU)
                            return;

                        LMK2->GetMotionMaster()->Clear();
                        LMK2->StopMoving();
                        LMK2->InterruptNonMeleeSpells(false);
                        LMK2->AttackStop();
                        LMK2->AI()->SetData(1, 0);
                        LMK2->DespawnOrUnsummon(7000);
                        LMK2->SetReactState(REACT_PASSIVE);
                        VX001->InterruptNonMeleeSpells(false);
                        VX001->AttackStop();
                        VX001->AI()->SetData(1, 0);
                        VX001->DespawnOrUnsummon(7000);
                        VX001->SetReactState(REACT_PASSIVE);
                        ACU->InterruptNonMeleeSpells(false);
                        ACU->AttackStop();
                        ACU->AI()->SetData(1, 0);
                        ACU->DespawnOrUnsummon(7000);
                        ACU->SetReactState(REACT_PASSIVE);

                        Position exitPos = me->GetPosition();
                        me->_ExitVehicle(&exitPos);
                        me->AttackStop();
                        me->GetMotionMaster()->Clear();
                        summons.DoAction(1337); // despawn summons of summons
                        summons.DespawnEntry(NPC_FLAMES_INITIAL);
                        summons.DespawnEntry(33576);

                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

                        float angle = VX001->GetOrientation();
                        float v_x = me->GetPositionX() + cos(angle) * 10.0f;
                        float v_y = me->GetPositionY() + std::sin(angle) * 10.0f;
                        me->GetMotionMaster()->MoveJump(v_x, v_y, 364.32f, 7.0f, 7.0f);

                        DoCastSelf(SPELL_SLEEP_VISUAL_1);

                        if( pInstance )
                            for( uint16 i = 0; i < 3; ++i )
                                if( ObjectGuid guid = pInstance->GetGuidData(DATA_GO_MIMIRON_DOOR_1 + i) )
                                    if( GameObject* door = ObjectAccessor::GetGameObject(*me, guid) )
                                        if( door->GetGoState() != GO_STATE_ACTIVE )
                                        {
                                            door->SetLootState(GO_READY);
                                            door->UseDoorOrButton(0, false);
                                        }

                        if (pInstance)
                            pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, NPC_LEVIATHAN_MKII, 1, me);

                        if (hardmode)
                            if( Creature* computer = me->SummonCreature(NPC_COMPUTER, 2746.7f, 2569.44f, 410.39f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 1000) )
                                computer->AI()->Talk(TALK_COMPUTER_TERMINATED);

                        events.Reset();
                        events.ScheduleEvent(EVENT_STAND_UP_FRIENDLY, 6s);
                    }
                    break;
                case EVENT_STAND_UP_FRIENDLY:
                    me->RemoveAurasDueToSpell(SPELL_SLEEP_VISUAL_1);
                    DoCastSelf(SPELL_SLEEP_VISUAL_2);
                    me->SetFaction(FACTION_FRIENDLY);
                    events.ScheduleEvent(EVENT_SAY_VOLTRON_DEAD, 4s);
                    break;
                case EVENT_SAY_VOLTRON_DEAD:
                    Talk(SAY_V07TRON_DEATH);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    if (pInstance)
                        pInstance->SetData(TYPE_MIMIRON, DONE);
                    // spawn chest
                    if (uint32 chestId = (hardmode ? RAID_MODE(GO_MIMIRON_CHEST_HARD, GO_MIMIRON_CHEST_HERO_HARD) : RAID_MODE(GO_MIMIRON_CHEST, GO_MIMIRON_CHEST_HERO)))
                    {
                        if (GameObject* go = me->SummonGameObject(chestId, 2744.65f, 2569.46f, 364.397f, 0, 0, 0, 0, 0, 0))
                        {
                            go->ReplaceAllGameObjectFlags((GameObjectFlags)0);
                            go->SetLootRecipient(me->GetMap());
                        }
                    }
                    events.ScheduleEvent(EVENT_DISAPPEAR, 9s);
                    break;
                case EVENT_DISAPPEAR:
                    DoCastSelf(SPELL_TELEPORT);
                    summons.DespawnAll();
                    break;
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_TELEPORT)
            {
                me->DespawnOrUnsummon();
                pInstance->SetData(EVENT_KEEPER_TELEPORTED, DONE);
            }
        }

        void MoveInLineOfSight(Unit*  /*mover*/) override {}

        void EnterEvadeMode(EvadeReason why) override
        {
            if (bIsEvading)
                return;
            bIsEvading = true;

            if (Creature* c = GetLMK2())
            {
                c->AI()->EnterEvadeMode(why);
            }
            if (Creature* c = GetVX001())
            {
                c->AI()->EnterEvadeMode(why);
                c->DespawnOrUnsummon();
            }
            if (Creature* c = GetACU())
            {
                c->AI()->EnterEvadeMode(why);
                c->DespawnOrUnsummon();
            }

            summons.DoAction(1337); // despawn summons of summons

            me->RemoveAllAuras();
            me->ExitVehicle();
            ScriptedAI::EnterEvadeMode(why);

            bIsEvading = false;
        }

        void JustSummoned(Creature* s) override
        {
            summons.Summon(s);
        }

        void SummonedCreatureDespawn(Creature* s) override
        {
            summons.Despawn(s);
        }

        void ResetGameObjects()
        {
            if( pInstance )
                for( uint16 i = 0; i < 3; ++i )
                    if( ObjectGuid guid = pInstance->GetGuidData(DATA_GO_MIMIRON_DOOR_1 + i) )
                        if( GameObject* door = ObjectAccessor::GetGameObject(*me, guid) )
                            if( door->GetGoState() != GO_STATE_ACTIVE )
                            {
                                door->SetLootState(GO_READY);
                                door->UseDoorOrButton(0, false);
                            }

            if( GameObject* elevator = me->FindNearestGameObject(GO_MIMIRON_ELEVATOR, 200.0f) )
            {
                if( elevator->GetGoState() != GO_STATE_ACTIVE )
                {
                    elevator->SetLootState(GO_READY);
                    elevator->SetByteValue(GAMEOBJECT_BYTES_1, 0, GO_STATE_ACTIVE);
                }
                elevator->EnableCollision(false);
            }

            if( GameObject* button = me->FindNearestGameObject(GO_BUTTON, 200.0f) )
                if( button->GetGoState() != GO_STATE_READY )
                {
                    button->SetLootState(GO_READY);
                    button->UseDoorOrButton(0, false);
                    button->RemoveGameObjectFlag(GO_FLAG_IN_USE);
                }
        }

        void CloseDoorAndButton()
        {
            if( pInstance )
                for( uint16 i = 0; i < 3; ++i )
                    if( ObjectGuid guid = pInstance->GetGuidData(DATA_GO_MIMIRON_DOOR_1 + i) )
                        if( GameObject* door = ObjectAccessor::GetGameObject(*me, guid) )
                            if( door->GetGoState() != GO_STATE_READY )
                            {
                                door->SetLootState(GO_READY);
                                door->UseDoorOrButton(0, false);
                            }

            if( GameObject* button = me->FindNearestGameObject(GO_BUTTON, 200.0f) )
                if( button->GetGoState() != GO_STATE_ACTIVE )
                {
                    button->SetLootState(GO_READY);
                    button->UseDoorOrButton(0, false);
                }
        }

        void SetData(uint32  /*id*/, uint32 value) override
        {
            switch (value) // end of phase 1-3, 4-6 for voltron
            {
                case 1:
                    events.ScheduleEvent(EVENT_LMK2_RETREAT_INTERVAL, 5s);
                    break;
                case 2:
                    events.ScheduleEvent(EVENT_VX001_EMOTESTATE_DEATH, 2500ms);
                    break;
                case 3:
                    events.ScheduleEvent(EVENT_SAY_ACU_DEAD, 5s);
                    break;
                case 4:
                case 5:
                case 6:
                    {
                        Creature* LMK2 = GetLMK2();
                        Creature* VX001 = GetVX001();
                        Creature* ACU = GetACU();
                        if (!LMK2 || !VX001 || !ACU)
                        {
                            EnterEvadeMode(EVADE_REASON_OTHER);
                            return;
                        }

                        Spell* s1 = LMK2->GetCurrentSpell(CURRENT_GENERIC_SPELL);
                        Spell* s2 = VX001->GetCurrentSpell(CURRENT_GENERIC_SPELL);
                        Spell* s3 = ACU->GetCurrentSpell(CURRENT_GENERIC_SPELL);
                        if (s1 && s2 && s3 && s1->GetSpellInfo()->Id == SPELL_SELF_REPAIR && s2->GetSpellInfo()->Id == SPELL_SELF_REPAIR && s3->GetSpellInfo()->Id == SPELL_SELF_REPAIR)
                            events.ScheduleEvent(EVENT_FINISH, 0ms);
                    }
                    break;
                case 7:
                    hardmode = true;
                    break;
                case 11:
                    bAchievProximityMine = true;
                    break;
                case 12:
                    bAchievBombBot = true;
                    break;
                case 13:
                    bAchievRocketStrike = true;
                    break;
            }
        }

        uint32 GetData(uint32 id) const override
        {
            switch (id)
            {
                case 1:
                    return (hardmode ? 1 : 0);
                case 2:
                    return (berserk ? 1 : 0);
                case 10:
                    return allowedFlameSpreadTime;
                case 11:
                    return (bAchievProximityMine ? 1 : 0);
                case 12:
                    return (bAchievBombBot ? 1 : 0);
                case 13:
                    return (bAchievRocketStrike ? 1 : 0);
            }
            return 0;
        }
    };
};

class npc_ulduar_leviathan_mkii : public CreatureScript
{
public:
    npc_ulduar_leviathan_mkii() : CreatureScript("npc_ulduar_leviathan_mkii") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_leviathan_mkiiAI>(pCreature);
    }

    struct npc_ulduar_leviathan_mkiiAI : public ScriptedAI
    {
        npc_ulduar_leviathan_mkiiAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            bIsEvading = false;
        }

        InstanceScript* pInstance;
        EventMap events;
        bool bIsEvading;
        uint8 Phase;

        void Reset() override
        {
            Phase = 0;
            if (Unit* c = GetS3())
                c->ExitVehicle(); // this should never happen!
            if (Creature* c = me->SummonCreature(NPC_LEVIATHAN_MKII_CANNON, *me, TEMPSUMMON_MANUAL_DESPAWN))
                c->EnterVehicle(me, 3);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);

            events.Reset();
        }

        void SetData(uint32 id, uint32 value) override
        {
            if (id == 1) // setting phase to start fighting
            {
                switch (value)
                {
                    case 0:
                        Phase = 0;
                        events.Reset();
                        break;
                    case 1:
                        Phase = 1;
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        if (Unit* target = SelectTargetFromPlayerList(75.0f))
                            AttackStart(target);
                        DoZoneInCombat();
                        events.Reset();
                        events.ScheduleEvent(EVENT_SPELL_NAPALM_SHELL, 3s);
                        events.ScheduleEvent(EVENT_SPELL_PLASMA_BLAST, 10s);
                        events.ScheduleEvent(EVENT_SPELL_SHOCK_BLAST, 20s);
                        events.ScheduleEvent(EVENT_PROXIMITY_MINES_1, 6s);
                        if (Creature* c = GetMimiron())
                            if (c->AI()->GetData(1))
                                events.ScheduleEvent(EVENT_FLAME_SUPPRESSION_50000, 60s);
                        break;
                    case 4:
                        me->SetReactState(REACT_AGGRESSIVE);
                        DoResetThreatList();
                        Phase = 4;
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        if (Unit* target = SelectTargetFromPlayerList(75.0f))
                            AttackStart(target);
                        DoZoneInCombat();
                        events.Reset();
                        events.ScheduleEvent(EVENT_SPELL_SHOCK_BLAST, 20s);
                        events.ScheduleEvent(EVENT_PROXIMITY_MINES_1, 6s);
                        break;
                }
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() || me->GetHealth() < 15000)
            {
                damage = 0;
                if (me->GetReactState() == REACT_PASSIVE)
                    return;
                me->SetReactState(REACT_PASSIVE);
                if (Phase == 1)
                {
                    if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                    {
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->GetMotionMaster()->Clear();
                        me->AttackStop();
                        me->SetReactState(REACT_PASSIVE);
                        SetData(1, 0);
                        me->InterruptNonMeleeSpells(false);
                        me->RemoveAllAurasExceptType(SPELL_AURA_CONTROL_VEHICLE);
                        if (Unit* cannon = GetS3())
                            cannon->ExitVehicle();
                        me->GetMotionMaster()->MoveCharge(2795.076f, 2598.616f, 364.32f, 21.0f);
                        if (Creature* c = GetMimiron())
                            c->AI()->SetData(0, 1);
                    }
                }
                else if (Phase == 4)
                {
                    if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                    {
                        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        me->InterruptNonMeleeSpells(false);
                        me->RemoveAllAurasExceptType(SPELL_AURA_CONTROL_VEHICLE);
                        me->CastSpell(me, SPELL_SELF_REPAIR, false);
                        if (Creature* c = GetMimiron())
                        {
                            if (c->AI()->GetData(1))
                                me->CastSpell(me, SPELL_EMERGENCY_MODE, true);
                            if (c->AI()->GetData(2))
                                me->CastSpell(me, SPELL_BERSERK, true);
                            c->AI()->SetData(0, 4);
                        }
                    }
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (!me->HasUnitState(UNIT_STATE_CASTING))
                DoMeleeAttackIfReady();

            Unit* cannon = GetS3();
            if (!cannon || cannon->HasUnitState(UNIT_STATE_CASTING) || me->HasUnitState(UNIT_STATE_CASTING) || me->HasAuraType(SPELL_AURA_MOD_SILENCE))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_NAPALM_SHELL:
                    {
                        Player* pTarget = nullptr;
                        std::vector<Player*> pList;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if (Player* plr = itr->GetSource())
                                if( plr->IsAlive() && plr->GetDistance2d(me) > 15.0f )
                                    pList.push_back(plr);

                        if (!pList.empty())
                            pTarget = pList[urand(0, pList.size() - 1)];
                        else
                            pTarget = (Player*)SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true);

                        if( pTarget )
                            cannon->CastSpell(pTarget, SPELL_NAPALM_SHELL, false);

                        events.Repeat(14s);
                    }
                    break;
                case EVENT_SPELL_PLASMA_BLAST:
                    if (Unit* victim = me->GetVictim())
                    {
                        Talk(EMOTE_PLASMA_BLAST);
                        cannon->CastSpell(victim, SPELL_PLASMA_BLAST, false);
                    }
                    events.Repeat(22s);
                    break;
                case EVENT_SPELL_SHOCK_BLAST:
                    me->CastSpell(me->GetVictim(), SPELL_SHOCK_BLAST, false);
                    events.Repeat(30s);
                    events.ScheduleEvent(EVENT_PROXIMITY_MINES_1, 8s);
                    break;
                case EVENT_PROXIMITY_MINES_1:
                    for (uint8 i = 0; i < 10; ++i)
                    {
                        me->CastSpell(me, SPELL_SUMMON_PROXIMITY_MINE, true);
                    }
                    break;
                case EVENT_FLAME_SUPPRESSION_50000:
                    me->CastSpell(me, SPELL_FLAME_SUPPRESSANT_50000yd, false);
                    break;
            }
        }

        void MoveInLineOfSight(Unit* /*mover*/) override {}

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                if (Creature* c = GetMimiron())
                {
                    if (Phase == 1)
                    {
                        c->AI()->Talk(SAY_MKII_SLAY);
                    }
                    else
                    {
                        c->AI()->Talk(SAY_V07TRON_SLAY);
                    }
                }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (bIsEvading)
                return;
            bIsEvading = true;

            me->RemoveAllAuras();
            me->ExitVehicle();
            ScriptedAI::EnterEvadeMode();

            if (Creature* mimiron = GetMimiron())
                mimiron->AI()->EnterEvadeMode(why);

            bIsEvading = false;
        }

        void PassengerBoarded(Unit* p, int8  /*seat*/, bool apply) override
        {
            if (p->GetEntry() == NPC_LEVIATHAN_MKII_CANNON && !apply)
            {
                Unit::Kill(p, p);
                p->ToCreature()->DespawnOrUnsummon(6000);
            }
        }

        Unit* GetS3()
        {
            if (Vehicle* vk = me->GetVehicleKit())
                if (Unit* cannon = vk->GetPassenger(3))
                    return cannon;

            return 0;
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            if( spell->Id == SPELL_SELF_REPAIR )
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_AGGRESSIVE);
            }
        }
    };
};

class npc_ulduar_vx001 : public CreatureScript
{
public:
    npc_ulduar_vx001() : CreatureScript("npc_ulduar_vx001") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_vx001AI>(pCreature);
    }

    struct npc_ulduar_vx001AI : public ScriptedAI
    {
        npc_ulduar_vx001AI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            bIsEvading = false;
        }

        InstanceScript* pInstance;
        EventMap events;
        bool bIsEvading;
        uint8 Phase;
        bool fighting;
        bool leftarm;
        uint32 spinningUpOrientation;
        uint16 spinningUpTimer;

        void Reset() override
        {
            Phase = 0;
            fighting = false;
            leftarm = false;
            spinningUpTimer = 0;
            me->SetRegeneratingHealth(false);
            events.Reset();
        }

        void AttackStart(Unit* /*who*/) override {}

        void SetData(uint32 id, uint32 value) override
        {
            if (id == 1) // setting phase to start fighting
            {
                switch (value)
                {
                    case 0:
                        Phase = 0;
                        fighting = false;
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        events.Reset();
                        break;
                    case 2:
                        Phase = 2;
                        fighting = true;
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_SPELL_CAST_OMNI);
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        events.Reset();
                        events.ScheduleEvent(EVENT_SPELL_HEAT_WAVE, 10s);
                        events.ScheduleEvent(EVENT_SPELL_ROCKET_STRIKE, 16s);
                        events.ScheduleEvent(EVENT_SPELL_RAPID_BURST, 0ms);
                        events.ScheduleEvent(EVENT_SPELL_SPINNING_UP, 30s);
                        events.ScheduleEvent(EVENT_REINSTALL_ROCKETS, 3s);
                        if (Creature* c = GetMimiron())
                            if (c->AI()->GetData(1))
                            {
                                events.ScheduleEvent(EVENT_FLAME_SUPPRESSION_10, 7s);
                                events.ScheduleEvent(EVENT_FROST_BOMB, 1s);
                            }
                        break;
                    case 4:
                        Phase = 4;
                        fighting = true;
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        events.Reset();
                        events.ScheduleEvent(EVENT_REINSTALL_ROCKETS, 3s);
                        events.ScheduleEvent(EVENT_SPELL_ROCKET_STRIKE, 16s);
                        events.ScheduleEvent(EVENT_HAND_PULSE, 1ms);
                        events.ScheduleEvent(EVENT_SPELL_SPINNING_UP, 30s);
                        if (Creature* c = GetMimiron())
                            if (c->AI()->GetData(1))
                                events.ScheduleEvent(EVENT_FROST_BOMB, 1s);
                        break;
                }
            }
        }

        uint32 GetData(uint32  /*id*/) const override
        {
            return spinningUpOrientation;
        }

        void DoAction(int32 action) override
        {
            if (action == 1337)
                if( Vehicle* vk = me->GetVehicleKit() )
                    for (uint8 i = 0; i < 2; ++i)
                        if (Unit* r = vk->GetPassenger(5 + i))
                            if (r->GetTypeId() == TYPEID_UNIT)
                                r->ToCreature()->DespawnOrUnsummon(1);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() || me->GetHealth() < 15000)
            {
                damage = 0;
                if (me->GetReactState() == REACT_PASSIVE)
                    return;
                me->SetReactState(REACT_PASSIVE);
                if (Phase == 2)
                {
                    if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                    {
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        SetData(1, 0);
                        me->InterruptNonMeleeSpells(false);
                        me->RemoveAllAurasExceptType(SPELL_AURA_CONTROL_VEHICLE);
                        me->SendMeleeAttackStop();
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_CUSTOM_SPELL_06);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_CUSTOM_SPELL_06);
                        if (Creature* c = GetMimiron())
                            c->AI()->SetData(0, 2);
                    }
                }
                else if (Phase == 4)
                {
                    if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                    {
                        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        me->InterruptNonMeleeSpells(false);
                        me->RemoveAllAurasExceptType(SPELL_AURA_CONTROL_VEHICLE);
                        me->CastSpell(me, SPELL_SELF_REPAIR, false);
                        if (Creature* c = GetMimiron())
                        {
                            if (c->AI()->GetData(1))
                                me->CastSpell(me, SPELL_EMERGENCY_MODE, true);
                            if (c->AI()->GetData(2))
                                me->CastSpell(me, SPELL_BERSERK, true);
                            c->AI()->SetData(0, 5);
                        }
                    }
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!fighting)
                return;

            events.Update(diff);

            if (spinningUpTimer) // executed about a second after starting casting to ensure players can see the correct direction
            {
                if (spinningUpTimer <= diff)
                {
                    float angle = (spinningUpOrientation * 2 * M_PI) / 100.0f;
                    me->SetFacingTo(angle);

                    spinningUpTimer = 0;
                }
                else
                    spinningUpTimer -= diff;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_HEAT_WAVE:
                    me->CastSpell(me, SPELL_HEAT_WAVE, true);
                    events.Repeat(10s);
                    break;
                case EVENT_SPELL_ROCKET_STRIKE:
                    if( Vehicle* vk = me->GetVehicleKit() )
                    {
                        for( int i = 0; i < (Phase / 2); ++i )
                        {
                            uint8 index = (Phase == 2 ? rand() % 2 : i);
                            if( Unit* r = vk->GetPassenger(5 + index) )
                                if (Player* temp = SelectTargetFromPlayerList(100.0f))
                                {
                                    if( Creature* trigger = me->SummonCreature(NPC_ROCKET_STRIKE_N, temp->GetPositionX(), temp->GetPositionY(), temp->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 6000) )
                                        trigger->CastSpell(trigger, SPELL_ROCKET_STRIKE_AURA, true);
                                    Position exitPos = r->GetPosition();
                                    exitPos.m_positionX += cos(me->GetOrientation()) * 2.35f;
                                    exitPos.m_positionY += std::sin(me->GetOrientation()) * 2.35f;
                                    exitPos.m_positionZ += 2.0f * Phase;
                                    r->_ExitVehicle(&exitPos);
                                    me->RemoveAurasByType(SPELL_AURA_CONTROL_VEHICLE, r->GetGUID());
                                    if (r->GetTypeId() == TYPEID_UNIT)
                                        r->ToCreature()->AI()->SetData(0, 0);
                                }
                        }
                        events.Repeat(20s);
                        events.ScheduleEvent(EVENT_REINSTALL_ROCKETS, 10s);
                    }
                    break;
                case EVENT_REINSTALL_ROCKETS:
                    if (Vehicle* vk = me->GetVehicleKit())
                    {
                        for (uint8 i = 5; i <= 6; ++i)
                            if (!vk->GetPassenger(i))
                                if (TempSummon* accessory = me->SummonCreature(NPC_ROCKET_VISUAL, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 4.0f, me->GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN))
                                    if (!me->HandleSpellClick(accessory, i))
                                        accessory->UnSummon();
                    }
                    break;
                case EVENT_SPELL_RAPID_BURST:
                    if (Player* p = SelectTargetFromPlayerList(80.0f))
                    {
                        me->CastSpell(p, SPELL_RAPID_BURST, true);
                        me->SetFacingToObject(p);
                    }
                    events.Repeat(3200ms);
                    break;
                case EVENT_HAND_PULSE:
                    if (Player* p = SelectTargetFromPlayerList(80.0f))
                    {
                        me->SetFacingToObject(p);
                        if (Unit* vb = me->GetVehicleBase())
                        {
                            vb->SendMeleeAttackStop();
                            vb->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);

                            if( !leftarm )
                            {
                                vb->HandleEmoteCommand(EMOTE_ONESHOT_CUSTOM_SPELL_03);
                                me->CastSpell(p, SPELL_HAND_PULSE_R, false);
                            }
                            else
                            {
                                vb->HandleEmoteCommand(EMOTE_ONESHOT_CUSTOM_SPELL_04);
                                me->CastSpell(p, SPELL_HAND_PULSE_L, false);
                            }
                        }

                        leftarm = !leftarm;
                    }
                    events.Repeat(1750ms);
                    break;
                case EVENT_SPELL_SPINNING_UP:
                    events.Repeat(45s);
                    if (Player* p = SelectTargetFromPlayerList(80.0f))
                    {
                        float angle = me->GetAngle(p);

                        spinningUpOrientation = (uint32)((angle * 100.0f) / (2 * M_PI));
                        spinningUpTimer = 1500;
                        me->SetFacingTo(angle);
                        me->CastSpell(p, SPELL_SPINNING_UP, true);
                        if (Unit* vehicle = me->GetVehicleBase())
                        {
                            vehicle->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_CUSTOM_SPELL_01);
                            vehicle->HandleEmoteCommand(EMOTE_STATE_CUSTOM_SPELL_01);
                        }
                        events.RescheduleEvent((Phase == 2 ? EVENT_SPELL_RAPID_BURST : EVENT_HAND_PULSE), 14s + 500ms);
                    }
                    break;
                case EVENT_FLAME_SUPPRESSION_10:
                    me->CastSpell(me, SPELL_FLAME_SUPPRESSANT_10yd, false);
                    events.Repeat(10s);
                    break;
                case EVENT_FROST_BOMB:
                    me->CastCustomSpell(SPELL_VX001_FROST_BOMB, SPELLVALUE_MAX_TARGETS, 1, (Unit*)nullptr, false);
                    events.Repeat(45s);
                    break;
            }
        }

        void MoveInLineOfSight(Unit* /*mover*/) override {}

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                if (Creature* c = GetMimiron())
                {
                    if (Phase == 2)
                    {
                        c->AI()->Talk(SAY_VX001_SLAY);
                    }
                    else
                    {
                        c->AI()->Talk(SAY_V07TRON_SLAY);
                    }
                }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (bIsEvading)
                return;
            bIsEvading = true;

            me->RemoveAllAuras();
            me->ExitVehicle();
            _EnterEvadeMode();
            Reset();
            if (Creature* mimiron = GetMimiron())
                mimiron->AI()->EnterEvadeMode(why);

            bIsEvading = false;
        }

        void PassengerBoarded(Unit* p, int8  /*seat*/, bool apply) override
        {
            if (p->GetEntry() == NPC_ROCKET_VISUAL && !apply)
                p->ToCreature()->DespawnOrUnsummon(8000);
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            if( spell->Id == SPELL_SELF_REPAIR )
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_AGGRESSIVE);
            }
        }
    };
};

class npc_ulduar_aerial_command_unit : public CreatureScript
{
public:
    npc_ulduar_aerial_command_unit() : CreatureScript("npc_ulduar_aerial_command_unit") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_aerial_command_unitAI>(pCreature);
    }

    struct npc_ulduar_aerial_command_unitAI : public ScriptedAI
    {
        npc_ulduar_aerial_command_unitAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = me->GetInstanceScript();
            bIsEvading = false;
            immobilized = false;
            me->SetDisableGravity(true);
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        bool bIsEvading;
        uint8 Phase;
        bool immobilized;

        void Reset() override
        {
            Phase = 0;
            events.Reset();
            summons.DespawnAll();
        }

        void AttackStart(Unit* who) override
        {
            if (who)
                me->Attack(who, true); // skip following
        }

        void SetData(uint32 id, uint32 value) override
        {
            if (id == 1) // setting phase to start fighting
            {
                switch (value)
                {
                    case 0:
                        Phase = 0;
                        events.Reset();
                        immobilized = false;
                        break;
                    case 3:
                        Phase = 3;
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        if (Unit* target = SelectTargetFromPlayerList(75.0f))
                            AttackStart(target);
                        DoZoneInCombat();
                        events.Reset();
                        events.ScheduleEvent(EVENT_SPELL_PLASMA_BALL, 0ms);
                        events.ScheduleEvent(EVENT_SUMMON_BOMB_BOT, 15s);
                        events.ScheduleEvent(EVENT_SUMMON_ASSAULT_BOT, 1s);
                        events.ScheduleEvent(EVENT_SUMMON_JUNK_BOT, 10s);
                        if (Creature* c = GetMimiron())
                            if (c->AI()->GetData(1))
                                events.ScheduleEvent(EVENT_SUMMON_EMERGENCY_FIRE_BOTS, 0ms);
                        break;
                    case 4:
                        me->SetReactState(REACT_AGGRESSIVE);
                        DoResetThreatList();
                        Phase = 4;
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        if (Unit* target = SelectTargetFromPlayerList(75.0f))
                            AttackStart(target);
                        DoZoneInCombat();
                        events.Reset();
                        events.ScheduleEvent(EVENT_SPELL_PLASMA_BALL, 0ms);
                }
            }
            else if (id == 2 && !immobilized && Phase == 3) // magnetic core
            {
                immobilized = true;
                events.ScheduleEvent(EVENT_MAGNETIC_CORE_PULL_DOWN, 2s);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == 1337)
                summons.DespawnAll();
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() || me->GetHealth() < 15000)
            {
                damage = 0;
                if (me->GetReactState() == REACT_PASSIVE)
                    return;
                me->SetReactState(REACT_PASSIVE);
                if (Phase == 3)
                {
                    if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                    {
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->GetMotionMaster()->Clear();
                        me->StopMoving();
                        me->AttackStop();
                        me->SetReactState(REACT_PASSIVE);
                        SetData(1, 0);
                        me->InterruptNonMeleeSpells(false);
                        me->RemoveAllAurasExceptType(SPELL_AURA_CONTROL_VEHICLE);

                        me->MonsterMoveWithSpeed(2744.65f, 2569.46f, 381.34f, me->GetDistance(2744.65f, 2569.46f, 381.34f));
                        me->UpdatePosition(2744.65f, 2569.46f, 381.34f, M_PI, false);

                        if (Creature* c = GetMimiron())
                            c->AI()->SetData(0, 3);
                    }
                }
                else if (Phase == 4)
                {
                    if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                    {
                        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        me->InterruptNonMeleeSpells(false);
                        me->RemoveAllAurasExceptType(SPELL_AURA_CONTROL_VEHICLE);
                        me->CastSpell(me, SPELL_SELF_REPAIR, false);
                        if (Creature* c = GetMimiron())
                        {
                            if (c->AI()->GetData(1))
                                me->CastSpell(me, SPELL_EMERGENCY_MODE, true);
                            if (c->AI()->GetData(2))
                                me->CastSpell(me, SPELL_BERSERK, true);
                            c->AI()->SetData(0, 6);
                        }
                    }
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            // following :D
            if( Phase == 3 && !immobilized )
                if( Unit* victim = me->GetVictim() )
                    if( me->GetExactDist2d(victim) > 25.0f )
                    {
                        float angle = victim->GetAngle(me->GetPositionX(), me->GetPositionY());
                        me->SetOrientation( me->GetAngle(victim->GetPositionX(), victim->GetPositionY()) );
                        float x = victim->GetPositionX() + 15.0f * cos(angle);
                        float y = victim->GetPositionY() + 15.0f * std::sin(angle);

                        // check if there's magnetic core in line of movement
                        Creature* mc = nullptr;
                        std::list<Creature*> cl;
                        me->GetCreaturesWithEntryInRange(cl, me->GetExactDist2d(victim), NPC_MAGNETIC_CORE);
                        for( std::list<Creature*>::iterator itr = cl.begin(); itr != cl.end(); ++itr )
                        {
                            if ((*itr)->IsInBetween(me, victim, 4.0f) && (*itr)->GetExactDist2d(victim) >= 10.0f) // don't come very close just because there's a magnetic core
                            {
                                x = (*itr)->GetPositionX();
                                y = (*itr)->GetPositionY();
                                mc = (*itr);
                                break;
                            }
                        }

                        float speed = me->GetExactDist(x, y, 381.34f);
                        me->MonsterMoveWithSpeed(x, y, 381.34f, speed);
                        me->UpdatePosition(x, y, 381.34f, me->GetAngle(victim), false);
                        if (mc)
                        {
                            mc->AI()->SetData(0, 0);
                            SetData(2, 1);
                        }
                    }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_PLASMA_BALL:
                    if( !immobilized )
                    {
                        if (Phase == 3)
                        {
                            if( Unit* victim = me->GetVictim() )
                                me->CastSpell(victim, SPELL_PLASMA_BALL, false);
                        }
                        else
                        {
                            if (Unit* victim = SelectTarget(SelectTargetMethod::Random, 0, 27.5f, true))
                            {
                                me->SetFacingToObject(victim);
                                me->CastSpell(victim, SPELL_PLASMA_BALL, false);
                            }
                        }
                    }
                    events.Repeat(3s);
                    break;
                case EVENT_SUMMON_BOMB_BOT:
                    if( !immobilized )
                        me->CastSpell(me, SPELL_SUMMON_BOMB_BOT, false);
                    events.Repeat(15s);
                    break;
                case EVENT_SUMMON_ASSAULT_BOT:
                    if( GameObject* pad = me->FindNearestGameObject(RAND(194742, 194746, 194745), 200.0f) )
                        if (Creature* trigger = me->SummonCreature(NPC_BOT_SUMMON_TRIGGER, *pad, TEMPSUMMON_TIMED_DESPAWN, 15000))
                            trigger->AI()->DoAction(2);
                    events.Repeat(30s);
                    break;
                case EVENT_SUMMON_JUNK_BOT:
                    if( GameObject* pad = me->FindNearestGameObject(RAND(194741, 194744, 194747), 200.0f) )
                        if (Creature* trigger = me->SummonCreature(NPC_BOT_SUMMON_TRIGGER, *pad, TEMPSUMMON_TIMED_DESPAWN, 15000))
                            trigger->AI()->DoAction(1);
                    events.Repeat(10s);
                    break;
                case EVENT_SUMMON_EMERGENCY_FIRE_BOTS:
                    {
                        uint32 ids[3] = {194740, 194743, 194748};
                        for( uint8 i = 0; i < 3; ++i )
                            if( GameObject* pad = me->FindNearestGameObject(ids[i], 200.0f) )
                                if (Creature* trigger = me->SummonCreature(NPC_BOT_SUMMON_TRIGGER, *pad, TEMPSUMMON_MANUAL_DESPAWN))
                                    trigger->AI()->DoAction(3);
                        events.Repeat(45s);
                    }
                    break;
                case EVENT_MAGNETIC_CORE_PULL_DOWN:
                    me->CastSpell(me, SPELL_MAGNETIC_CORE, true);
                    me->CastSpell(me, SPELL_SPINNING, true);
                    me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), 365.34f, me->GetExactDist(me->GetPositionX(), me->GetPositionY(), 365.34f));
                    me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), 365.34f, me->GetOrientation(), false);
                    events.ScheduleEvent(EVENT_MAGNETIC_CORE_FREE, 20s);
                    break;
                case EVENT_MAGNETIC_CORE_FREE:
                    me->RemoveAura(SPELL_SPINNING);
                    me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), 381.34f, me->GetDistance(me->GetPositionX(), me->GetPositionY(), 381.34f));
                    me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), 381.34f, me->GetOrientation(), false);
                    events.ScheduleEvent(EVENT_MAGNETIC_CORE_REMOVE_IMMOBILIZE, 1s);
                    break;
                case EVENT_MAGNETIC_CORE_REMOVE_IMMOBILIZE:
                    immobilized = false;
                    break;
            }
        }

        void MoveInLineOfSight(Unit* /*mover*/) override {}

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                if (Creature* c = GetMimiron())
                {
                    if (Phase == 3)
                    {
                        c->AI()->Talk(SAY_AERIAL_SLAY);
                    }
                    else
                    {
                        c->AI()->Talk(SAY_V07TRON_SLAY);
                    }
                }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (bIsEvading)
                return;
            bIsEvading = true;

            me->RemoveAllAuras();
            me->ExitVehicle();
            _EnterEvadeMode();
            Reset();
            if (Creature* mimiron = GetMimiron())
                mimiron->AI()->EnterEvadeMode(why);

            bIsEvading = false;
        }

        void JustSummoned(Creature* s) override
        {
            summons.Summon(s);
            if (s->GetEntry() == NPC_BOMB_BOT)
                s->m_positionZ = 364.34f;
        }

        void SummonedCreatureDespawn(Creature* s) override
        {
            summons.Despawn(s);
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            if( spell->Id == SPELL_SELF_REPAIR )
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_AGGRESSIVE);
            }
        }
    };
};

class npc_ulduar_proximity_mine : public CreatureScript
{
public:
    npc_ulduar_proximity_mine() : CreatureScript("npc_ulduar_proximity_mine") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_proximity_mineAI>(pCreature);
    }

    struct npc_ulduar_proximity_mineAI : public ScriptedAI
    {
        npc_ulduar_proximity_mineAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            exploded = false;
            timer = 2500;
            timer2 = 35000;
        }

        bool exploded;
        uint16 timer;
        uint16 timer2;

        void AttackStart(Unit* /*who*/) override {}
        void MoveInLineOfSight(Unit* /*who*/) override {}
        bool CanAIAttack(Unit const*  /*target*/) const override { return false; }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (target && spell && target->IsPlayer() && spell->Id == SPELL_MINE_EXPLOSION)
                if (InstanceScript* pInstance = me->GetInstanceScript())
                    if (Creature* c = GetMimiron())
                        c->AI()->SetData(0, 11);
        }

        // MoveInLineOfSight is checked every few yards, can't use it
        void UpdateAI(uint32 diff) override
        {
            if (timer2 <= diff)
            {
                timer2 = 35000;
                if (!exploded)
                {
                    exploded = true;
                    me->CastSpell(me, SPELL_MINE_EXPLOSION, false);
                }
            }
            else
                timer2 -= diff;

            if (timer <= diff)
            {
                timer = 500;
                if (!exploded && SelectTargetFromPlayerList(1.9f))
                {
                    exploded = true;
                    me->CastSpell(me, SPELL_MINE_EXPLOSION, false);
                }
            }
            else
                timer -= diff;
        }
    };
};

class npc_ulduar_mimiron_rocket : public CreatureScript
{
public:
    npc_ulduar_mimiron_rocket() : CreatureScript("npc_ulduar_mimiron_rocket") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_mimiron_rocketAI>(pCreature);
    }

    struct npc_ulduar_mimiron_rocketAI : public NullCreatureAI
    {
        npc_ulduar_mimiron_rocketAI(Creature* pCreature) : NullCreatureAI(pCreature) {}

        void InitializeAI() override
        {
            if (!me->isDead())
                Reset();
        }

        void Reset() override
        {
            me->SetCanFly(true);
            me->AddUnitMovementFlag(MOVEMENTFLAG_FLYING);
            me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
        }

        void SetData(uint32  /*id*/, uint32  /*value*/) override
        {
            me->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 100.0f, false, true);
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (!me->GetVehicle())
            {
                me->SetSpeed(MOVE_RUN, me->GetSpeedRate(MOVE_RUN) + 0.4f, false);
                me->SetSpeed(MOVE_FLIGHT, me->GetSpeedRate(MOVE_RUN), false);
            }
        }
    };
};

class npc_ulduar_magnetic_core : public CreatureScript
{
public:
    npc_ulduar_magnetic_core() : CreatureScript("npc_ulduar_magnetic_core") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_magnetic_coreAI>(pCreature);
    }

    struct npc_ulduar_magnetic_coreAI : public NullCreatureAI
    {
        npc_ulduar_magnetic_coreAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            if (Creature* c = GetACU())
                if (c->GetExactDist2d(me) <= 10.0f)
                {
                    me->SendMonsterMove(c->GetPositionX(), c->GetPositionY(), 364.313f, 1);
                    me->UpdatePosition(c->GetPositionX(), c->GetPositionY(), 364.313f, me->GetOrientation(), true);
                    me->StopMovingOnCurrentPos();
                    c->AI()->SetData(2, 1);
                    despawnTimer = 20000;
                    return;
                }
            despawnTimer = 60000;
        }

        InstanceScript* pInstance;
        uint16 despawnTimer;

        void SetData(uint32  /*id*/, uint32  /*value*/) override
        {
            despawnTimer = 20000;
        }

        void UpdateAI(uint32 diff) override
        {
            if (despawnTimer <= diff)
            {
                despawnTimer = 60000;
                me->DespawnOrUnsummon(1);
            }
            else
                despawnTimer -= diff;
        }
    };
};

class npc_ulduar_bot_summon_trigger : public CreatureScript
{
public:
    npc_ulduar_bot_summon_trigger() : CreatureScript("npc_ulduar_bot_summon_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_bot_summon_triggerAI>(pCreature);
    }

    struct npc_ulduar_bot_summon_triggerAI : public NullCreatureAI
    {
        npc_ulduar_bot_summon_triggerAI(Creature* pCreature) : NullCreatureAI(pCreature) { }

        uint32 timer;
        uint8 option;

        void Reset() override
        {
            timer = 8000;
            option = 0;
        }

        void DoAction(int32 param) override
        {
            switch( param )
            {
                case 1:
                    me->CastSpell(me, SPELL_BEAM_GREEN, true);
                    option = 1;
                    break;
                case 2:
                    me->CastSpell(me, SPELL_BEAM_YELLOW, true);
                    option = 2;
                    break;
                case 3:
                    me->CastSpell(me, SPELL_BEAM_BLUE, true);
                    option = 3;
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if( timer <= diff )
            {
                uint32 option_npcid[3] = {NPC_JUNK_BOT, NPC_ASSAULT_BOT, NPC_EMERGENCY_FIRE_BOT};
                InstanceScript* pInstance = me->GetInstanceScript();
                if (Creature* ACU = GetACU()) // ACU summons for easy removing
                    if( Creature* bot = ACU->SummonCreature( option_npcid[option - 1], *me, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 25000 ) )
                    {
                        if( option < 3 )
                            bot->SetInCombatWithZone();
                        if (Creature* m = GetMimiron())
                            if (m->AI()->GetData(1)) // hardmode
                                bot->CastSpell(bot, SPELL_EMERGENCY_MODE, true);
                    }

                me->DespawnOrUnsummon(500);
                timer = 99999;
            }
            else
                timer -= diff;
        }
    };
};

class spell_mimiron_rapid_burst_aura : public AuraScript
{
    PrepareAuraScript(spell_mimiron_rapid_burst_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_RAPID_BURST_DAMAGE_10_1,
                SPELL_RAPID_BURST_DAMAGE_10_2,
                SPELL_RAPID_BURST_DAMAGE_25_1,
                SPELL_RAPID_BURST_DAMAGE_25_2
            });
    }

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if (Unit* caster = GetCaster())
        {
            uint32 id = (caster->GetMap()->Is25ManRaid() ? ((aurEff->GetTickNumber() % 2) ? SPELL_RAPID_BURST_DAMAGE_25_2 : SPELL_RAPID_BURST_DAMAGE_25_1) : ((aurEff->GetTickNumber() % 2) ? SPELL_RAPID_BURST_DAMAGE_10_2 : SPELL_RAPID_BURST_DAMAGE_10_1));
            caster->CastSpell((Unit*)nullptr, id, true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mimiron_rapid_burst_aura::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
    }
};

enum p3wx2LaserBarrage
{
    SPELL_P3WX2_LASER_BARRAGE_1 = 63297,
    SPELL_P3WX2_LASER_BARRAGE_2 = 64042
};

class spell_mimiron_p3wx2_laser_barrage_aura : public AuraScript
{
    PrepareAuraScript(spell_mimiron_p3wx2_laser_barrage_aura);

    bool Load() override
    {
        _lastMSTime = GameTime::GetGameTimeMS().count();
        _lastOrientation = -1.0f;
        return true;
    }

    void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (caster->GetTypeId() != TYPEID_UNIT)
                return;
            uint32 diff = getMSTimeDiff(_lastMSTime, GameTime::GetGameTimeMS().count());
            if (_lastOrientation == -1.0f)
            {
                _lastOrientation = (caster->ToCreature()->AI()->GetData(0) * 2 * M_PI) / 100.0f;
                diff = 0;
            }
            float new_o = Position::NormalizeOrientation(_lastOrientation - (M_PI / 60) * (diff / 250.0f));
            _lastMSTime = GameTime::GetGameTimeMS().count();
            _lastOrientation = new_o;
            caster->SetFacingTo(new_o);

            caster->CastSpell((Unit*)nullptr, SPELL_P3WX2_LASER_BARRAGE_1, true);
            caster->CastSpell((Unit*)nullptr, SPELL_P3WX2_LASER_BARRAGE_2, true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mimiron_p3wx2_laser_barrage_aura::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }

private:
    uint32 _lastMSTime;
    float _lastOrientation;
};

class go_ulduar_do_not_push_this_button : public GameObjectScript
{
public:
    go_ulduar_do_not_push_this_button() : GameObjectScript("go_ulduar_do_not_push_this_button") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if(!player || !go)
            return true;

        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if(instance->GetData(TYPE_MIMIRON) != NOT_STARTED)
                return false;

            if (Creature* c = ObjectAccessor::GetCreature(*go, instance->GetGuidData(TYPE_MIMIRON)))
            {
                c->AI()->SetData(0, 7);
                c->AI()->AttackStart(player);
            }
        }

        return false;
    }
};

class npc_ulduar_flames_initial : public CreatureScript
{
public:
    npc_ulduar_flames_initial() : CreatureScript("npc_ulduar_flames_initial") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_flames_initialAI>(pCreature);
    }

    struct npc_ulduar_flames_initialAI : public NullCreatureAI
    {
        npc_ulduar_flames_initialAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            CreateTime = GameTime::GetGameTime().count();
            events.Reset();
            events.ScheduleEvent(EVENT_FLAMES_SPREAD, 5750ms);
            if( Creature* flame = me->SummonCreature(NPC_FLAMES_SPREAD, me->GetPositionX(), me->GetPositionY(), 364.32f, 0.0f) )
            {
                FlameList.push_back(flame->GetGUID());
                flame->CastSpell(flame, SPELL_FLAMES_AURA, true);
            }
        }

        GuidList FlameList;
        EventMap events;
        uint32 CreateTime;

        void DoAction(int32 action) override
        {
            if (action == 1337)
                RemoveAll();
        }

        void SpreadFlame(float x, float y)
        {
            if( Creature* flame = me->SummonCreature(NPC_FLAMES_SPREAD, x, y, 364.32f, 0.0f) )
            {
                FlameList.push_back(flame->GetGUID());
                if (Creature* c = me->FindNearestCreature(NPC_FLAMES_SPREAD, 10.0f))
                    if (c->GetExactDist2d(flame->GetPositionX(), flame->GetPositionY()) <= 4.0f)
                        return;
                flame->CastSpell(flame, SPELL_FLAMES_AURA, true);
            }
        }

        void RemoveFlame(ObjectGuid guid)
        {
            FlameList.remove(guid);
        }

        void RemoveAll()
        {
            for (ObjectGuid const& guid : FlameList)
                if (Creature* c = ObjectAccessor::GetCreature(*me, guid))
                    c->DespawnOrUnsummon();
            FlameList.clear();
            me->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 diff) override
        {
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (pInstance->GetData(TYPE_MIMIRON) != IN_PROGRESS)
                {
                    RemoveAll();
                    return;
                }

            events.Update(diff);

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_FLAMES_SPREAD:
                    {
                        if( FlameList.empty() )
                        {
                            me->DespawnOrUnsummon();
                            return;
                        }

                        if (InstanceScript* pInstance = me->GetInstanceScript())
                            if (Creature* mimiron = GetMimiron())
                                if (CreateTime < mimiron->AI()->GetData(10))
                                {
                                    break;
                                }

                        Creature* last = ObjectAccessor::GetCreature(*me, FlameList.back());
                        if( last )
                        {
                            float prevdist = 100.0f;
                            Player* target = nullptr;

                            Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                if( Player* plr = itr->GetSource() )
                                    if( plr->IsAlive() && plr->GetExactDist2d(last) < prevdist && !plr->IsGameMaster() )
                                    {
                                        target = plr;
                                        prevdist = plr->GetExactDist2d(last);
                                    }

                            if (target && prevdist >= 4.0f) // no need to spread when player is standing in fire, check distance
                            {
                                float angle = last->GetAngle(target->GetPositionX(), target->GetPositionY()) - M_PI / 8 + rand_norm() * 2 * M_PI / 8;
                                SpreadFlame(last->GetPositionX() + 7.0f * cos(angle), last->GetPositionY() + 7.0f * std::sin(angle));
                            }
                        }

                        events.Repeat(5750ms);
                    }
                    break;
            }
        }
    };
};

class npc_ulduar_flames_spread : public CreatureScript
{
public:
    npc_ulduar_flames_spread() : CreatureScript("npc_ulduar_flames_spread") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_flames_spreadAI>(pCreature);
    }

    struct npc_ulduar_flames_spreadAI : public NullCreatureAI
    {
        npc_ulduar_flames_spreadAI(Creature* pCreature) : NullCreatureAI(pCreature) {}

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            switch( spell->Id )
            {
                case SPELL_FROST_BOMB_EXPLOSION_10:
                case SPELL_FROST_BOMB_EXPLOSION_25:
                case SPELL_FLAME_SUPPRESSANT_10yd:
                case SPELL_FLAME_SUPPRESSANT_50000yd:
                case SPELL_WATER_SPRAY:
                    {
                        if (me->IsSummon())
                            if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                                if (Creature* c = summoner->ToCreature())
                                    if (c->AI())
                                        CAST_AI(npc_ulduar_flames_initial::npc_ulduar_flames_initialAI, c->AI())->RemoveFlame(me->GetGUID());

                        me->RemoveAllAuras();
                        me->DespawnOrUnsummon(2500);
                    }
                    break;
                case SPELL_VX001_FROST_BOMB:
                    me->CastSpell(me, SPELL_SUMMON_FROST_BOMB, true);
                    break;
            }
        }
    };
};

class npc_ulduar_emergency_fire_bot : public CreatureScript
{
public:
    npc_ulduar_emergency_fire_bot() : CreatureScript("npc_ulduar_emergency_fire_bot") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_emergency_fire_botAI>(pCreature);
    }

    struct npc_ulduar_emergency_fire_botAI : public ScriptedAI
    {
        npc_ulduar_emergency_fire_botAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            events.Reset();
            events.ScheduleEvent(EVENT_EMERGENCY_BOT_CHECK, 1s);
        }

        EventMap events;

        void MoveInLineOfSight(Unit*) override {}
        void AttackStart(Unit*) override {}

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == 1)
                events.ScheduleEvent(EVENT_EMERGENCY_BOT_ATTACK, 0ms);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_EMERGENCY_BOT_CHECK:
                    events.Repeat(15s);
                    if (Creature* flame = me->FindNearestCreature(NPC_FLAMES_SPREAD, 150.0f, true))
                    {
                        me->SetOrientation(me->GetAngle(flame->GetPositionX(), flame->GetPositionY()));
                        float dist = me->GetExactDist2d(flame);
                        if (dist <= 5.0f)
                            events.ScheduleEvent(EVENT_EMERGENCY_BOT_ATTACK, 0ms);
                        else
                            me->GetMotionMaster()->MovePoint(1, me->GetPositionX() + (dist - 5.0f)*cos(me->GetOrientation()), me->GetPositionY() + (dist - 5.0f)*sin(me->GetOrientation()), 364.32f);
                    }
                    break;
                case EVENT_EMERGENCY_BOT_ATTACK:
                    me->CastSpell((Unit*)nullptr, SPELL_WATER_SPRAY, false);
                    events.RescheduleEvent(EVENT_EMERGENCY_BOT_CHECK, 5s);
                    break;
            }
        }
    };
};

class npc_ulduar_rocket_strike_trigger : public CreatureScript
{
public:
    npc_ulduar_rocket_strike_trigger() : CreatureScript("npc_ulduar_rocket_strike_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_rocket_strike_triggerAI>(pCreature);
    }

    struct npc_ulduar_rocket_strike_triggerAI : public NullCreatureAI
    {
        npc_ulduar_rocket_strike_triggerAI(Creature* pCreature) : NullCreatureAI(pCreature) {}

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (!target || !spell)
                return;
            if (spell->Id == 63041)
            {
                if (target->GetEntry() == NPC_ASSAULT_BOT)
                    me->CastSpell(me, 65040, true); // achievement Not-So-Friendly Fire
                else if (target->IsPlayer())
                    if (InstanceScript* pInstance = me->GetInstanceScript())
                        if (Creature* c = GetMimiron())
                            c->AI()->SetData(0, 13);
            }
        }
    };
};

class achievement_mimiron_firefighter : public AchievementCriteriaScript
{
public:
    achievement_mimiron_firefighter() : AchievementCriteriaScript("achievement_mimiron_firefighter") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_MIMIRON && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(1);
    }
};

class achievement_mimiron_set_up_us_the_bomb_11 : public AchievementCriteriaScript
{
public:
    achievement_mimiron_set_up_us_the_bomb_11() : AchievementCriteriaScript("achievement_mimiron_set_up_us_the_bomb_11") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_MIMIRON && target->GetTypeId() == TYPEID_UNIT && !target->ToCreature()->AI()->GetData(11);
    }
};

class achievement_mimiron_set_up_us_the_bomb_12 : public AchievementCriteriaScript
{
public:
    achievement_mimiron_set_up_us_the_bomb_12() : AchievementCriteriaScript("achievement_mimiron_set_up_us_the_bomb_12") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_MIMIRON && target->GetTypeId() == TYPEID_UNIT && !target->ToCreature()->AI()->GetData(12);
    }
};

class achievement_mimiron_set_up_us_the_bomb_13 : public AchievementCriteriaScript
{
public:
    achievement_mimiron_set_up_us_the_bomb_13() : AchievementCriteriaScript("achievement_mimiron_set_up_us_the_bomb_13") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_MIMIRON && target->GetTypeId() == TYPEID_UNIT && !target->ToCreature()->AI()->GetData(13);
    }
};

void AddSC_boss_mimiron()
{
    new boss_mimiron();
    new npc_ulduar_leviathan_mkii();
    new npc_ulduar_vx001();
    new npc_ulduar_aerial_command_unit();

    new npc_ulduar_proximity_mine();
    new npc_ulduar_mimiron_rocket();
    new npc_ulduar_magnetic_core();
    new npc_ulduar_bot_summon_trigger();
    RegisterSpellScript(spell_mimiron_rapid_burst_aura);
    RegisterSpellScript(spell_mimiron_p3wx2_laser_barrage_aura);
    new go_ulduar_do_not_push_this_button();
    new npc_ulduar_flames_initial();
    new npc_ulduar_flames_spread();
    new npc_ulduar_emergency_fire_bot();
    new npc_ulduar_rocket_strike_trigger();

    new achievement_mimiron_firefighter();
    new achievement_mimiron_set_up_us_the_bomb_11();
    new achievement_mimiron_set_up_us_the_bomb_12();
    new achievement_mimiron_set_up_us_the_bomb_13();
}
