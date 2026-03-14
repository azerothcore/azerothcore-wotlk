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

    SPELL_SUMMON_WHELP              = 17646,
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

struct sOnyxMove
{
    uint8 CurrId, DestId;
    uint32 spellId;
    float x, y, z, o;
};

static sOnyxMove OnyxiaMoveData[] =
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
public:
    boss_onyxia(Creature* pCreature) : BossAI(pCreature, DATA_ONYXIA)
    {
        Initialize();
    }

    void Initialize()
    {
        CurrentWP = 0;
        whelpSpam = false;
        whelpCount = 0;
        whelpSpamTimer = 0;
        bManyWhelpsAvailable = false;
    }

    void SetPhase(uint8 ph)
    {
        events.Reset();
        Phase = ph;
        switch (ph)
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
        }
    }

    void Reset() override
    {
        Initialize();
        SetPhase(PHASE_NONE);
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
            case -1:
                if (bManyWhelpsAvailable)
                {
                    instance->SetData(DATA_WHELP_SUMMONED, 1);
                }
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

        me->SummonCreature(NPC_ONYXIAN_LAIR_GUARD, -167.837936f, -200.549332f, -66.343231f, 5.598287f, TEMPSUMMON_MANUAL_DESPAWN);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->HealthBelowPctDamaged(65, damage) && Phase == PHASE_GROUNDED)
        {
            SetPhase(PHASE_AIRPHASE);
        }
        else if (me->HealthBelowPctDamaged(40, damage) && Phase == PHASE_AIRPHASE)
        {
            me->InterruptNonMeleeSpells(false);
            SetPhase(PHASE_LANDED);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);

        if (summon->GetEntry() != NPC_ONYXIAN_WHELP && summon->GetEntry() != NPC_ONYXIAN_LAIR_GUARD)
        {
            return;
        }

        if (summon->GetEntry() == NPC_ONYXIAN_LAIR_GUARD && Phase < PHASE_AIRPHASE)
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

        if (id < 9)
        {
            if (id > 0 && Phase == PHASE_AIRPHASE)
            {
                me->SetFacingTo(OnyxiaMoveData[id].o);
                me->SetSpeed(MOVE_RUN, 1.6f, false);
                CurrentWP = id;
                events.ScheduleEvent(EVENT_SPELL_FIREBALL_FIRST, 1s);
            }
        }
        else
        {
            switch (id)
            {
                case 10:
                    me->SetFacingTo(OnyxiaMoveData[0].o);
                    events.ScheduleEvent(EVENT_LIFTOFF, 0ms);
                    break;
                case 11:
                    me->SetFacingTo(OnyxiaMoveData[1].o);
                    events.ScheduleEvent(EVENT_FLY_S_TO_N, 0ms);
                    break;
                case 12:
                    me->SetFacingTo(OnyxiaMoveData[1].o);
                    events.ScheduleEvent(EVENT_LAND, 0ms);
                    break;
                case 13:
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run, false);
                    events.ScheduleEvent(EVENT_PHASE_3_ATTACK, 0ms);
                    break;
            }
        }
    }

    void HandleWhelpSpam(const uint32 diff)
    {
        if (whelpSpam)
        {
            if (whelpCount < 40)
            {
                whelpSpamTimer -= diff;
                if (whelpSpamTimer <= 0)
                {
                    float angle = rand_norm() * 2 * M_PI;
                    float dist  = rand_norm() * 4.0f;
                    me->CastSpell(-33.18f + cos(angle) * dist, -258.80f + std::sin(angle) * dist, -89.0f, 17646, true);
                    me->CastSpell(-32.535f + cos(angle) * dist, -170.190f + std::sin(angle) * dist, -89.0f, 17646, true);
                    whelpCount += 2;
                    whelpSpamTimer += 600;
                }
            }
            else
            {
                whelpSpam      = false;
                whelpCount     = 0;
                whelpSpamTimer = 0;
            }
        }
    }

    bool CheckInRoom() override
    {
        if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 95.0f)
        {
            Talk(SAY_EVADE);
            EnterEvadeMode();
            return false;
        }

        return true;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() || !CheckInRoom())
        {
            return;
        }

        events.Update(diff);
        HandleWhelpSpam(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        DoMeleeAttackIfReady();

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
                me->GetMotionMaster()->MovePoint(10, OnyxiaMoveData[0].x, OnyxiaMoveData[0].y, OnyxiaMoveData[0].z);
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
                me->SetOrientation(OnyxiaMoveData[0].o);
                me->SendMovementFlagUpdate();
                me->GetMotionMaster()->MoveTakeoff(11, OnyxiaMoveData[1].x + 1.0f, OnyxiaMoveData[1].y, OnyxiaMoveData[1].z, 12.0f);
                bManyWhelpsAvailable = true;

                events.RescheduleEvent(EVENT_END_MANY_WHELPS_TIME, 10s);
                break;
            }
            case EVENT_END_MANY_WHELPS_TIME:
                bManyWhelpsAvailable = false;
                break;
            case EVENT_FLY_S_TO_N:
            {
                me->SetSpeed(MOVE_RUN, 2.95f, false);
                me->GetMotionMaster()->MovePoint(5, OnyxiaMoveData[5].x, OnyxiaMoveData[5].y, OnyxiaMoveData[5].z);

                whelpSpam = true;
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
                whelpSpam = true;
                events.Repeat(90s);
                break;
            }
            case EVENT_LAND:
            {
                Talk(SAY_PHASE_3_TRANS);
                me->SendMeleeAttackStop(me->GetVictim());
                me->GetMotionMaster()->MoveLand(13, OnyxiaMoveData[0].x + 1.0f, OnyxiaMoveData[0].y, OnyxiaMoveData[0].z, 12.0f);
                DoResetThreatList();
                break;
            }
            case EVENT_SPELL_FIREBALL_FIRST:
            {
                if (Unit* v = SelectTarget(SelectTargetMethod::Random, 0, 200.0f, true))
                {
                    me->SetFacingToObject(v);
                    DoCast(v, SPELL_FIREBALL);
                }

                events.ScheduleEvent(EVENT_SPELL_FIREBALL_SECOND, 4s);
                break;
            }
            case EVENT_SPELL_FIREBALL_SECOND:
            {
                if (Unit* v = SelectTarget(SelectTargetMethod::Random, 0, 200.0f, true))
                {
                    me->SetFacingToObject(v);
                    DoCast(v, SPELL_FIREBALL);
                }

                uint8 rand = urand(0, 99);
                if (rand < 33)
                {
                    events.ScheduleEvent(EVENT_PHASE_2_STEP_CW, 4s);
                }
                else if (rand < 66)
                {
                    events.ScheduleEvent(EVENT_PHASE_2_STEP_ACW, 4s);
                }
                else
                {
                    events.ScheduleEvent(EVENT_PHASE_2_STEP_ACROSS, 4s);
                }
                break;
            }
            case EVENT_PHASE_2_STEP_CW:
            {
                uint8 newWP = CurrentWP + 1;
                if (newWP > 8)
                {
                    newWP = 1;
                }
                me->GetMotionMaster()->MovePoint(newWP, OnyxiaMoveData[newWP].x, OnyxiaMoveData[newWP].y, OnyxiaMoveData[newWP].z);
                break;
            }
            case EVENT_PHASE_2_STEP_ACW:
            {
                uint8 newWP = CurrentWP - 1;
                if (newWP < 1)
                {
                    newWP = 8;
                }
                me->GetMotionMaster()->MovePoint(newWP, OnyxiaMoveData[newWP].x, OnyxiaMoveData[newWP].y, OnyxiaMoveData[newWP].z);
                break;
            }
            case EVENT_PHASE_2_STEP_ACROSS:
            {
                Talk(EMOTE_BREATH);
                me->SetFacingTo(OnyxiaMoveData[CurrentWP].o);
                DoCastAOE(OnyxiaMoveData[CurrentWP].spellId);
                events.ScheduleEvent(EVENT_SPELL_BREATH, 8250ms);
                break;
            }
            case EVENT_SPELL_BREATH:
            {
                uint8 newWP = OnyxiaMoveData[CurrentWP].DestId;
                me->SetSpeed(MOVE_RUN, 2.95f, false);
                me->GetMotionMaster()->MovePoint(newWP, OnyxiaMoveData[newWP].x, OnyxiaMoveData[newWP].y, OnyxiaMoveData[newWP].z);
                break;
            }
            case EVENT_START_PHASE_3:
            {
                me->SetSpeed(MOVE_RUN, 2.95f, false);
                me->GetMotionMaster()->MovePoint(12, OnyxiaMoveData[1].x, OnyxiaMoveData[1].y, OnyxiaMoveData[1].z);
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
                if (Creature* trigger = me->SummonCreature(12758, *me, TEMPSUMMON_TIMED_DESPAWN, 1000))
                {
                    trigger->CastSpell(trigger, 17731, false);
                }
                break;
            }
            case EVENT_SUMMON_WHELP:
            {
                float angle = rand_norm() * 2 * M_PI;
                float dist  = rand_norm() * 4.0f;
                me->CastSpell(-33.18f + cos(angle) * dist, -258.80f + std::sin(angle) * dist, -89.0f, 17646, true);
                me->CastSpell(-32.535f + cos(angle) * dist, -170.190f + std::sin(angle) * dist, -89.0f, 17646, true);
                events.Repeat(30s);
                break;
            }
        }
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spell) override
    {
        if (target->IsPlayer() && spell->DurationEntry && spell->DurationEntry->ID == 328 && spell->Effects[EFFECT_1].TargetA.GetTarget() == 1 && (spell->Effects[EFFECT_1].Amplitude == 50 || spell->Effects[EFFECT_1].Amplitude == 215)) // Deep Breath
        {
            instance->SetData(DATA_DEEP_BREATH_FAILED, 1);
        }
    }

private:
    uint8 Phase;
    int8  CurrentWP;

    bool  whelpSpam;
    uint8 whelpCount;
    int32 whelpSpamTimer;
    bool  bManyWhelpsAvailable;
};

struct npc_onyxian_lair_guard : public ScriptedAI
{
public:
    npc_onyxian_lair_guard(Creature* creature) : ScriptedAI(creature) {}

    EventMap events;

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
        }

        if (!me->HasUnitState(UNIT_STATE_CASTING) && me->isAttackReady())
        {
            if (me->HasUnitFlag(UNIT_FLAG_DISARMED))
            {
                if (me->HasAura(SPELL_OLG_IGNITEWEAPON))
                {
                    me->RemoveAura(SPELL_OLG_IGNITEWEAPON);
                }
            }
        }

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_onyxia()
{
    RegisterOnyxiasLairCreatureAI(boss_onyxia);
    RegisterOnyxiasLairCreatureAI(npc_onyxian_lair_guard);
}
