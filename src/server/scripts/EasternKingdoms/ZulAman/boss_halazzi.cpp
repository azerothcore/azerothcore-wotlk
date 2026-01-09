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
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "zulaman.h"

enum Spells
{
    SPELL_DUAL_WIELD            = 29651,
    SPELL_SABER_LASH            = 43267,
    SPELL_FRENZY                = 43139,
    SPELL_FLAMESHOCK            = 43303,
    SPELL_EARTHSHOCK            = 43305,
    SPELL_SUMMON_LYNX           = 43143,
    SPELL_SUMMON_TOTEM          = 43302,
    SPELL_BERSERK               = 45078,
    SPELL_LYNX_FRENZY           = 43290, // Used by Spirit Lynx
    SPELL_SHRED_ARMOR           = 43243, // Used by Spirit Lynx
    SPELL_TRANSFORM_DUMMY       = 43615, // Used by Spirit Lynx

    SPELL_TRANSFIGURE           = 44054,
    SPELL_TRANSFORM_TO_LYNX_75  = 43145,
    SPELL_TRANSFORM_TO_LYNX_50  = 43271,
    SPELL_TRANSFORM_TO_LYNX_25  = 43272
};

enum UniqueEvents
{
    EVENT_BERSERK                = 1
};

enum Hal_CreatureIds
{
    NPC_HALAZZI_TROLL            = 24144, // dummy creature - used to update model, stats
    NPC_TOTEM                    = 24224
};

enum PhaseHalazzi
{
    PHASE_NONE                   = 0,
    PHASE_LYNX                   = 1,
    PHASE_HUMAN                  = 2,
    PHASE_MERGE                  = 3,
    PHASE_ENRAGE                 = 4
};

enum Yells
{
    SAY_AGGRO                    = 0,
    SAY_KILL                     = 1,
    SAY_SABER                    = 2,
    SAY_SPLIT                    = 3,
    SAY_MERGE                    = 4,
    SAY_DEATH                    = 5
};

enum Groups
{
    GROUP_LYNX                   = 0,
    GROUP_HUMAN                  = 1,
    GROUP_MERGE                  = 3,
    GROUP_SPLIT                  = 4
};

enum Actions
{
    ACTION_MERGE                 = 0
};

struct boss_halazzi : public BossAI
{
    boss_halazzi(Creature* creature) : BossAI(creature, DATA_HALAZZI)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        me->UpdateEntry(NPC_HALAZZI);
        BossAI::Reset();
        _transformCount = 0;
        _phase = PHASE_NONE;
        SetInvincibility(true);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        ScheduleUniqueTimedEvent(10min, [&]
        {
            DoCastSelf(SPELL_BERSERK, true);
        }, EVENT_BERSERK);
        EnterPhase(PHASE_LYNX);
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask) override
    {
        BossAI::DamageTaken(attacker, damage, damagetype, damageSchoolMask);

        if (_phase == PHASE_LYNX)
        {
            uint32 _healthCheckPercentage = 25 * (3 - _transformCount);
            if (me->HealthBelowPctDamaged(_healthCheckPercentage, damage))
                EnterPhase(PHASE_HUMAN);
        }
        else if (_phase == PHASE_HUMAN)
        {
            if (me->HealthBelowPctDamaged(20, damage))
                EnterPhase(PHASE_MERGE);
        }
    }

    void SpellHit(Unit*, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_TRANSFORM_DUMMY)
            me->UpdateEntry(NPC_HALAZZI_TROLL);
    }

    void JustSummoned(Creature* summon) override
    {
        BossAI::JustSummoned(summon);

        if (summon->GetEntry() == NPC_TOTEM)
            summon->Attack(me->GetVictim(), false);
    }

    void AttackStart(Unit* who) override
    {
        if (_phase != PHASE_MERGE)
            BossAI::AttackStart(who);
    }

    void EnterPhase(PhaseHalazzi nextPhase)
    {
        _phase = nextPhase;

        switch (nextPhase)
        {
            case PHASE_LYNX:
            {
                summons.DespawnAll();

                if (_transformCount)
                {
                    me->UpdateEntry(NPC_HALAZZI);
                    switch (_transformCount)
                    {
                        case 1:
                            DoCastSelf(SPELL_TRANSFORM_TO_LYNX_75, true);
                            break;
                        case 2:
                            DoCastSelf(SPELL_TRANSFORM_TO_LYNX_50, true);
                            break;
                        case 3:
                            DoCastSelf(SPELL_TRANSFORM_TO_LYNX_25, true);
                            break;
                        default:
                            break;
                    }
                }

                me->ResumeChasingVictim();

                scheduler.CancelGroup(GROUP_MERGE);
                scheduler.Schedule(5s, 15s, GROUP_LYNX, [this](TaskContext context)
                {
                    Talk(SAY_SABER);
                    DoCastVictim(SPELL_SABER_LASH, true);
                    context.Repeat();
                }).Schedule(20s, 35s, GROUP_LYNX, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_FRENZY);
                    context.Repeat();
                });
                break;
            }
            case PHASE_HUMAN:
                Talk(SAY_SPLIT);
                DoCastSelf(SPELL_TRANSFIGURE, true);
                scheduler.Schedule(3s, GROUP_SPLIT, [this](TaskContext /*context*/)
                {
                    DoCastSelf(SPELL_SUMMON_LYNX, true);
                });
                _phase = PHASE_HUMAN;

                scheduler.CancelGroup(GROUP_MERGE);
                scheduler.CancelGroup(GROUP_LYNX);
                scheduler.Schedule(10s, GROUP_HUMAN, [this](TaskContext context)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        if (target->IsNonMeleeSpellCast(false))
                            DoCast(target, SPELL_EARTHSHOCK);
                        else
                            DoCast(target, SPELL_FLAMESHOCK);
                    }
                    context.Repeat(10s, 15s);
                }).Schedule(12s, GROUP_HUMAN, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_SUMMON_TOTEM);
                    context.Repeat(20s);
                });
                break;
            case PHASE_MERGE:
                if (Creature* lynx = instance->GetCreature(DATA_SPIRIT_LYNX))
                {
                    Talk(SAY_MERGE);
                    scheduler.CancelGroup(GROUP_HUMAN);
                    lynx->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    lynx->GetMotionMaster()->Clear();
                    lynx->GetMotionMaster()->MoveFollow(me, 0, 0);
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveFollow(lynx, 0, 0);
                    ++_transformCount;
                    scheduler.Schedule(2s, GROUP_MERGE, [this, lynx](TaskContext context)
                    {
                        if (lynx)
                        {
                            if (me->IsWithinDistInMap(lynx, 6.0f))
                            {
                                EnterPhase(PHASE_LYNX);

                                // Enrage phase
                                if (_transformCount == 3)
                                {
                                    _phase = PHASE_ENRAGE;
                                    SetInvincibility(false);
                                    scheduler.Schedule(12s, GROUP_LYNX, [this](TaskContext context)
                                    {
                                        DoCastSelf(SPELL_SUMMON_TOTEM);
                                        context.Repeat(20s);
                                    });
                                }
                            }
                            else
                                context.Repeat(2s);
                        }
                    });
                }
                break;
            default:
                break;
        }
    }

    void KilledUnit(Unit* victim) override
    {
        BossAI::KilledUnit(victim);
        if (victim->IsPlayer())
            Talk(SAY_KILL);
    }

    void DoAction(int32 actionId) override
    {
        if (actionId == ACTION_MERGE)
            EnterPhase(PHASE_MERGE);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }
private:
    uint8 _transformCount;
    PhaseHalazzi _phase;
};

void AddSC_boss_halazzi()
{
    RegisterZulAmanCreatureAI(boss_halazzi);
}
