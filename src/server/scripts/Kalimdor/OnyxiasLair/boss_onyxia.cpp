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
#include "SpellInfo.h"
#include "onyxias_lair.h"

enum Spells
{
    SPELL_WINGBUFFET                = 18500,
    SPELL_FLAMEBREATH               = 18435,
    SPELL_CLEAVE                    = 68868,
    SPELL_TAILSWEEP                 = 68867,
    SPELL_FIREBALL                  = 18392,
    SPELL_BELLOWINGROAR             = 18431,

    SPELL_SUMMON_LAIR_GUARD         = 68968,
    SPELL_ERUPTION                  = 17731,

    SPELL_OLG_BLASTNOVA             = 68958,
    SPELL_OLG_IGNITEWEAPON          = 68959,

    SPELL_BREATH_N_TO_S             = 17086,
    SPELL_BREATH_S_TO_N             = 18351,
    SPELL_BREATH_E_TO_W             = 18576,
    SPELL_BREATH_W_TO_E             = 18609,
    SPELL_BREATH_SE_TO_NW           = 18564,
    SPELL_BREATH_NW_TO_SE           = 18584,
    SPELL_BREATH_SW_TO_NE           = 18596,
    SPELL_BREATH_NE_TO_SW           = 18617,
};

enum Events
{
    EVENT_SPELL_WINGBUFFET          = 1,
    EVENT_SPELL_FLAMEBREATH         = 2,
    EVENT_SPELL_TAILSWEEP           = 3,
    EVENT_SPELL_CLEAVE              = 4,
    EVENT_START_PHASE_2             = 5,
    EVENT_SPELL_FIREBALL_FIRST      = 6,
    EVENT_SPELL_FIREBALL_SECOND     = 7,
    EVENT_PHASE_2_STEP_CW           = 8,
    EVENT_PHASE_2_STEP_ACW          = 9,
    EVENT_PHASE_2_STEP_ACROSS       = 10,
    EVENT_SPELL_BREATH              = 11,
    EVENT_START_PHASE_3             = 12,
    EVENT_PHASE_3_ATTACK            = 13,
    EVENT_SPELL_BELLOWINGROAR       = 14,
    EVENT_WHELP_SPAM                = 15,
    EVENT_SUMMON_LAIR_GUARD         = 16,
    EVENT_SUMMON_WHELP              = 17,
    EVENT_OLG_SPELL_BLASTNOVA       = 18,
    EVENT_OLG_SPELL_IGNITEWEAPON    = 19,
    EVENT_ERUPTION                  = 20,

    EVENT_LIFTOFF                   = 31,
    EVENT_FLY_S_TO_N                = 32,
    EVENT_LAND                      = 33,
    EVENT_END_MANY_WHELPS_TIME
};

enum Phases
{
    PHASE_NONE,
    PHASE_GROUNDED, // Phase 1
    PHASE_AIRPHASE, // Phase 2 - Airphase - 60% health
    PHASE_LANDED    // Phase 3 - Landed after Airphase - 40% health
};

// Indices into OnyxiaMoveData, also used as point ids; the flight loop runs over WP_SOUTH..WP_SOUTH_EAST
enum Waypoints : uint8
{
    WP_GROUND_SOUTH     = 0,
    WP_SOUTH            = 1,
    WP_NORTH            = 5,
    WP_SOUTH_EAST       = 8
};

enum Points
{
    POINT_GROUND_SOUTH  = 10,
    POINT_TAKEOFF       = 11,
    POINT_PRE_LAND      = 12,
    POINT_LAND          = 13
};

struct OnyxiaMove
{
    uint8 CurrId, DestId;
    uint32 SpellId;
    float X, Y, Z, O;
};

static OnyxiaMove const OnyxiaMoveData[] =
{
    {0, 0, 0, -64.496f, -214.906f, -84.4f, 0.0f}, // south ground
    {1, 5, SPELL_BREATH_S_TO_N, -64.496f, -214.906f, -60.0f, 0.0f}, // south
    {2, 6, SPELL_BREATH_SW_TO_NE, -59.809f, -190.758f, -60.0f, 7 * M_PI / 4}, // south-west
    {3, 7, SPELL_BREATH_W_TO_E, -29.450f, -180.600f, -60.0f, M_PI + M_PI / 2}, // west
    {4, 8, SPELL_BREATH_NW_TO_SE, 6.895f, -180.246f, -60.0f, M_PI + M_PI / 4}, // north-west
    {5, 1, SPELL_BREATH_N_TO_S,  22.876f, -217.152f, -60.0f, M_PI}, // north
    {6, 2, SPELL_BREATH_NE_TO_SW, 10.2191f, -247.912f, -60.0f, 3 * M_PI / 4}, // north-east
    {7, 3, SPELL_BREATH_E_TO_W, -31.496f, -250.123f, -60.0f, M_PI / 2}, // east
    {8, 4, SPELL_BREATH_SE_TO_NW, -63.5156f, -240.096f, -60.0f, M_PI / 4}, // south-east
};

static_assert(std::size(OnyxiaMoveData) == WP_SOUTH_EAST + 1);

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_PHASE_2_TRANS           = 2,
    SAY_PHASE_3_TRANS           = 3,
    EMOTE_BREATH                = 4,
    SAY_EVADE                   = 5
};

struct boss_onyxia : public BossAI
{
    boss_onyxia(Creature* creature) : BossAI(creature, DATA_ONYXIA)
    {
        // The whelp spam must keep ticking through Deep Breath, so the scheduler may not pause while casting
        scheduler.ClearValidator();
        Initialize();
    }

    void Initialize()
    {
        _phase = PHASE_NONE;
        _currentWP = WP_GROUND_SOUTH;
        _manyWhelpsAvailable = false;
    }

    void SetPhase(Phases phase)
    {
        events.Reset();
        _phase = phase;
        switch (phase)
        {
            case PHASE_GROUNDED:
                events.ScheduleEvent(EVENT_SPELL_WINGBUFFET, 10s, 20s);
                events.ScheduleEvent(EVENT_SPELL_FLAMEBREATH, 10s, 20s);
                events.ScheduleEvent(EVENT_SPELL_TAILSWEEP, 15s, 20s);
                events.ScheduleEvent(EVENT_SPELL_CLEAVE, 2s, 5s);
                break;
            case PHASE_AIRPHASE:
                events.ScheduleEvent(EVENT_START_PHASE_2, 0ms);
                break;
            case PHASE_LANDED:
                events.ScheduleEvent(EVENT_START_PHASE_3, 5s);
                break;
            default:
                break;
        }
    }

    void Reset() override
    {
        Initialize();
        me->SetReactState(REACT_AGGRESSIVE);
        me->SetCanFly(false);
        me->SetDisableGravity(false);
        me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run, false);
        instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
        BossAI::Reset();
    }

    void DoAction(int32 param) override
    {
        switch (param)
        {
            case ACTION_WHELP_SUMMONED:
                if (_manyWhelpsAvailable)
                {
                    instance->SetData(DATA_WHELP_SUMMONED, 1);
                }
                break;
            default:
                break;
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);
        SetPhase(PHASE_GROUNDED);

        instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT); // just in case at reset some players already left the instance
        instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
        BossAI::JustEngagedWith(who);

        ScheduleHealthCheckEvent(65, [&]
        {
            SetPhase(PHASE_AIRPHASE);
        });
        ScheduleHealthCheckEvent(40, [&]
        {
            me->InterruptNonMeleeSpells(false);
            SetPhase(PHASE_LANDED);
        });

        me->SummonCreature(NPC_ONYXIAN_LAIR_GUARD, -167.837936f, -200.549332f, -66.343231f, 5.598287f, TEMPSUMMON_MANUAL_DESPAWN);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (why == EVADE_REASON_BOUNDARY)
        {
            Talk(SAY_EVADE);
        }

        BossAI::EnterEvadeMode(why);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);

        if (summon->GetEntry() != NPC_ONYXIAN_WHELP && summon->GetEntry() != NPC_ONYXIAN_LAIR_GUARD)
        {
            return;
        }

        if (summon->GetEntry() == NPC_ONYXIAN_LAIR_GUARD && _phase < PHASE_AIRPHASE)
        {
            return;
        }

        if (Unit* target = summon->SelectNearestTarget(300.0f))
        {
            summon->AI()->AttackStart(target);
            DoZoneInCombat(summon);
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
        {
            return;
        }

        if (id <= WP_SOUTH_EAST)
        {
            if (id >= WP_SOUTH && _phase == PHASE_AIRPHASE)
            {
                me->SetFacingTo(OnyxiaMoveData[id].O);
                me->SetSpeed(MOVE_RUN, 1.6f, false);
                _currentWP = id;
                events.ScheduleEvent(EVENT_SPELL_FIREBALL_FIRST, 1s);
            }
            return;
        }

        switch (id)
        {
            case POINT_GROUND_SOUTH:
                me->SetFacingTo(OnyxiaMoveData[WP_GROUND_SOUTH].O);
                events.ScheduleEvent(EVENT_LIFTOFF, 0ms);
                break;
            case POINT_TAKEOFF:
                me->SetFacingTo(OnyxiaMoveData[WP_SOUTH].O);
                events.ScheduleEvent(EVENT_FLY_S_TO_N, 0ms);
                break;
            case POINT_PRE_LAND:
                me->SetFacingTo(OnyxiaMoveData[WP_SOUTH].O);
                events.ScheduleEvent(EVENT_LAND, 0ms);
                break;
            case POINT_LAND:
                me->SetCanFly(false);
                me->SetDisableGravity(false);
                me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run, false);
                events.ScheduleEvent(EVENT_PHASE_3_ATTACK, 0ms);
                break;
            default:
                break;
        }
    }

    void MoveToWaypoint(uint8 wp)
    {
        OnyxiaMove const& point = OnyxiaMoveData[wp];
        me->GetMotionMaster()->MovePoint(wp, point.X, point.Y, point.Z);
    }

    // Summons one whelp at each of the two side caves
    void SummonWhelps()
    {
        float angle = rand_norm() * 2 * M_PI;
        float dist  = rand_norm() * 4.0f;
        me->CastSpell(-33.18f + std::cos(angle) * dist, -258.80f + std::sin(angle) * dist, -89.0f, SPELL_SUMMON_WHELP, true);
        me->CastSpell(-32.535f + std::cos(angle) * dist, -170.190f + std::sin(angle) * dist, -89.0f, SPELL_SUMMON_WHELP, true);
    }

    // 20 batches of two whelps, 600ms apart
    void StartWhelpSpam()
    {
        scheduler.Schedule(0ms, [this](TaskContext context)
        {
            SummonWhelps();
            if (context.GetRepeatCounter() < 19)
            {
                context.Repeat(600ms);
            }
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() || !CheckInRoom())
        {
            return;
        }

        events.Update(diff);
        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        switch (events.ExecuteEvent())
        {
            case EVENT_SPELL_WINGBUFFET:
            {
                DoCastAOE(SPELL_WINGBUFFET);
                events.Repeat(15s, 30s);
                break;
            }
            case EVENT_SPELL_FLAMEBREATH:
            {
                DoCastAOE(SPELL_FLAMEBREATH);
                events.Repeat(10s, 20s);
                break;
            }
            case EVENT_SPELL_TAILSWEEP:
            {
                DoCastAOE(SPELL_TAILSWEEP);
                events.Repeat(15s, 20s);
                break;
            }
            case EVENT_SPELL_CLEAVE:
            {
                DoCastVictim(SPELL_CLEAVE);
                events.Repeat(2s, 5s);
                break;
            }
            case EVENT_START_PHASE_2:
            {
                me->AttackStop();
                me->SetReactState(REACT_PASSIVE);
                me->StopMoving();
                DoResetThreatList();
                me->GetMotionMaster()->MovePoint(POINT_GROUND_SOUTH, OnyxiaMoveData[WP_GROUND_SOUTH].X, OnyxiaMoveData[WP_GROUND_SOUTH].Y, OnyxiaMoveData[WP_GROUND_SOUTH].Z);
                break;
            }
            case EVENT_LIFTOFF:
            {
                Talk(SAY_PHASE_2_TRANS);
                me->SendMeleeAttackStop(me->GetVictim());
                me->GetMotionMaster()->MoveIdle();
                me->DisableSpline();
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                me->SetOrientation(OnyxiaMoveData[WP_GROUND_SOUTH].O);
                me->SendMovementFlagUpdate();
                me->GetMotionMaster()->MoveTakeoff(POINT_TAKEOFF, OnyxiaMoveData[WP_SOUTH].X + 1.0f, OnyxiaMoveData[WP_SOUTH].Y, OnyxiaMoveData[WP_SOUTH].Z, 12.0f);
                _manyWhelpsAvailable = true;

                events.RescheduleEvent(EVENT_END_MANY_WHELPS_TIME, 10s);
                break;
            }
            case EVENT_END_MANY_WHELPS_TIME:
                _manyWhelpsAvailable = false;
                break;
            case EVENT_FLY_S_TO_N:
            {
                me->SetSpeed(MOVE_RUN, 2.95f, false);
                MoveToWaypoint(WP_NORTH);

                StartWhelpSpam();
                events.ScheduleEvent(EVENT_WHELP_SPAM, 90s);
                events.ScheduleEvent(EVENT_SUMMON_LAIR_GUARD, 30s);
                break;
            }
            case EVENT_SUMMON_LAIR_GUARD:
            {
                me->CastSpell(-101.654f, -214.491f, -80.70f, SPELL_SUMMON_LAIR_GUARD, true);
                events.Repeat(30s);
                break;
            }
            case EVENT_WHELP_SPAM:
            {
                StartWhelpSpam();
                events.Repeat(90s);
                break;
            }
            case EVENT_LAND:
            {
                Talk(SAY_PHASE_3_TRANS);
                me->SendMeleeAttackStop(me->GetVictim());
                me->GetMotionMaster()->MoveLand(POINT_LAND, OnyxiaMoveData[WP_GROUND_SOUTH].X + 1.0f, OnyxiaMoveData[WP_GROUND_SOUTH].Y, OnyxiaMoveData[WP_GROUND_SOUTH].Z, 12.0f);
                DoResetThreatList();
                break;
            }
            case EVENT_SPELL_FIREBALL_FIRST:
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 200.0f, true))
                {
                    me->SetFacingToObject(target);
                    DoCast(target, SPELL_FIREBALL);
                }

                events.ScheduleEvent(EVENT_SPELL_FIREBALL_SECOND, 4s);
                break;
            }
            case EVENT_SPELL_FIREBALL_SECOND:
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 200.0f, true))
                {
                    me->SetFacingToObject(target);
                    DoCast(target, SPELL_FIREBALL);
                }

                switch (urand(0, 2))
                {
                    case 0:
                        events.ScheduleEvent(EVENT_PHASE_2_STEP_CW, 4s);
                        break;
                    case 1:
                        events.ScheduleEvent(EVENT_PHASE_2_STEP_ACW, 4s);
                        break;
                    default:
                        events.ScheduleEvent(EVENT_PHASE_2_STEP_ACROSS, 4s);
                        break;
                }
                break;
            }
            case EVENT_PHASE_2_STEP_CW:
            {
                uint8 newWP = _currentWP + 1;
                if (newWP > WP_SOUTH_EAST)
                {
                    newWP = WP_SOUTH;
                }
                MoveToWaypoint(newWP);
                break;
            }
            case EVENT_PHASE_2_STEP_ACW:
            {
                uint8 newWP = _currentWP - 1;
                if (newWP < WP_SOUTH)
                {
                    newWP = WP_SOUTH_EAST;
                }
                MoveToWaypoint(newWP);
                break;
            }
            case EVENT_PHASE_2_STEP_ACROSS:
            {
                Talk(EMOTE_BREATH);
                me->SetFacingTo(OnyxiaMoveData[_currentWP].O);
                DoCastAOE(OnyxiaMoveData[_currentWP].SpellId);
                events.ScheduleEvent(EVENT_SPELL_BREATH, 8250ms);
                break;
            }
            case EVENT_SPELL_BREATH:
            {
                me->SetSpeed(MOVE_RUN, 2.95f, false);
                MoveToWaypoint(OnyxiaMoveData[_currentWP].DestId);
                break;
            }
            case EVENT_START_PHASE_3:
            {
                me->SetSpeed(MOVE_RUN, 2.95f, false);
                me->GetMotionMaster()->MovePoint(POINT_PRE_LAND, OnyxiaMoveData[WP_SOUTH].X, OnyxiaMoveData[WP_SOUTH].Y, OnyxiaMoveData[WP_SOUTH].Z);
                break;
            }
            case EVENT_PHASE_3_ATTACK:
            {
                me->SetReactState(REACT_AGGRESSIVE);

                if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 0, 0, false))
                {
                    AttackStart(target);
                }

                DoCastAOE(SPELL_BELLOWINGROAR);

                events.ScheduleEvent(EVENT_ERUPTION, 0ms);
                events.ScheduleEvent(EVENT_SPELL_WINGBUFFET, 10s, 20s);
                events.ScheduleEvent(EVENT_SPELL_FLAMEBREATH, 10s, 20s);
                events.ScheduleEvent(EVENT_SPELL_TAILSWEEP, 15s, 20s);
                events.ScheduleEvent(EVENT_SPELL_CLEAVE, 2s, 5s);
                events.ScheduleEvent(EVENT_SPELL_BELLOWINGROAR, 15s);
                events.ScheduleEvent(EVENT_SUMMON_WHELP, 10s);
                break;
            }
            case EVENT_SPELL_BELLOWINGROAR:
            {
                DoCastAOE(SPELL_BELLOWINGROAR);
                events.Repeat(22s);
                events.ScheduleEvent(EVENT_ERUPTION, 0ms);
                break;
            }
            case EVENT_ERUPTION:
            {
                if (Creature* trigger = me->SummonCreature(NPC_ONYXIA_TRIGGER, *me, TEMPSUMMON_TIMED_DESPAWN, 1000))
                {
                    trigger->CastSpell(trigger, SPELL_ERUPTION, false);
                }
                break;
            }
            case EVENT_SUMMON_WHELP:
            {
                SummonWhelps();
                events.Repeat(30s);
                break;
            }
            default:
                break;
        }

        DoMeleeAttackIfReady();
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spell) override
    {
        // Deep Breath is a chain of dozens of triggered spells with no shared id,
        // so identify a hit by the shape common to all of them
        if (target->IsPlayer() && spell->DurationEntry && spell->DurationEntry->ID == 328
            && spell->Effects[EFFECT_1].TargetA.GetTarget() == TARGET_UNIT_CASTER
            && (spell->Effects[EFFECT_1].Amplitude == 50 || spell->Effects[EFFECT_1].Amplitude == 215))
        {
            instance->SetData(DATA_DEEP_BREATH_FAILED, 1);
        }
    }

private:
    Phases _phase;
    uint8 _currentWP;
    bool _manyWhelpsAvailable;
};

struct npc_onyxian_lair_guard : public ScriptedAI
{
    npc_onyxian_lair_guard(Creature* creature) : ScriptedAI(creature) { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        events.Reset();
        events.ScheduleEvent(EVENT_OLG_SPELL_BLASTNOVA, 15s);
        events.ScheduleEvent(EVENT_OLG_SPELL_IGNITEWEAPON, 10s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        switch (events.ExecuteEvent())
        {
            case EVENT_OLG_SPELL_BLASTNOVA:
                DoCastAOE(SPELL_OLG_BLASTNOVA);
                events.Repeat(15s);
                break;
            case EVENT_OLG_SPELL_IGNITEWEAPON:
                if (me->HasUnitFlag(UNIT_FLAG_DISARMED))
                {
                    events.Repeat(5s);
                }
                else
                {
                    DoCastSelf(SPELL_OLG_IGNITEWEAPON);
                    events.Repeat(18s, 21s);
                }
                break;
            default:
                break;
        }

        if (me->HasUnitFlag(UNIT_FLAG_DISARMED))
        {
            me->RemoveAura(SPELL_OLG_IGNITEWEAPON);
        }

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_onyxia()
{
    RegisterOnyxiasLairCreatureAI(boss_onyxia);
    RegisterOnyxiasLairCreatureAI(npc_onyxian_lair_guard);
}
