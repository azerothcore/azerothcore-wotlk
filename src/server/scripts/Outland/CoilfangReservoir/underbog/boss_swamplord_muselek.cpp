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
#include "TaskScheduler.h"
#include "the_underbog.h"

enum Spells
{
    SPELL_SHOOT               = 22907,
    SPELL_KNOCKAWAY           = 18813,
    SPELL_RAPTOR_STRIKE       = 31566,
    SPELL_MULTISHOT           = 34974,
    SPELL_THROW_FREEZING_TRAP = 31946,
    SPELL_AIMED_SHOT          = 31623,
    SPELL_HUNTERS_MARK        = 31615,
};

enum Text
{
    SAY_AGGRO       = 1,
    SAY_KILL        = 2,
    SAY_JUST_DIED   = 3
};

enum Misc
{
    RANGED_GROUP = 1,
    RANGE_CHECK  = 2
};

struct boss_swamplord_muselek : public BossAI
{
    boss_swamplord_muselek(Creature* creature) : BossAI(creature, DATA_MUSELEK)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        _canChase = true;
    }

    void AttackStart(Unit* victim) override
    {
        if (victim && me->Attack(victim, true) && me->IsWithinMeleeRange(victim))
        {
            me->GetMotionMaster()->MoveChase(victim);
        }
        else
        {
            me->GetMotionMaster()->MoveIdle();
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_JUST_DIED);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_KILL);
    }

    bool CanShootVictim()
    {
        Unit* victim = me->GetVictim();

        if (!victim || !me->IsWithinLOSInMap(victim) || !me->IsWithinRange(victim, 30.f) || me->IsWithinRange(victim, 10.f))
        {
            _canChase = true;
            return false;
        }

        return true;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(3s, [this](TaskContext context)
        {
            if (CanShootVictim())
            {
                me->LoadEquipment(1, true);
                DoCastVictim(SPELL_SHOOT);
                me->GetMotionMaster()->Clear();
                me->StopMoving();
                _canChase = false;
            }
            else if (_canChase)
            {
                me->GetMotionMaster()->MoveChase(me->GetVictim());
            }

            context.Repeat();
        }).Schedule(15s, 30s, [this](TaskContext context)
        {
            if (me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
            {
                DoCastVictim(SPELL_KNOCKAWAY);
            }

            context.Repeat();
        }).Schedule(10s, 15s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_MULTISHOT);
            context.Repeat(20s, 30s);
        }).Schedule(30s, 40s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, false, true))
            {
                _markTarget = target->GetGUID();
                _canChase = false;
                DoCastVictim(SPELL_THROW_FREEZING_TRAP);

                scheduler.Schedule(3s, [this, target](TaskContext)
                {
                    if (target && me->GetVictim())
                    {
                        if (me->IsWithinMeleeRange(me->GetVictim()))
                        {
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MoveForwards(me->GetVictim(), 10.0f);
                            _canChase = false;
                        }

                        me->m_Events.AddEventAtOffset([this]()
                        {
                            if (Unit* marktarget = ObjectAccessor::GetUnit(*me, _markTarget))
                            {
                                DoCast(marktarget, SPELL_HUNTERS_MARK);
                            }
                        }, 3s);
                    }
                });

                scheduler.Schedule(5s, [this, target](TaskContext)
                {
                    if (target)
                    {
                        me->m_Events.AddEventAtOffset([this]()
                        {
                            if (Unit* marktarget = ObjectAccessor::GetUnit(*me, _markTarget))
                            {
                                scheduler.DelayAll(5s);
                                DoCast(marktarget, SPELL_AIMED_SHOT);
                                _canChase = true;
                            }
                        }, 3s);
                    }
                });
            }

            context.Repeat(12s, 16s);
        });
    }

private:
    ObjectGuid _markTarget;
    bool _canChase;
};

void AddSC_boss_swamplord_muselek()
{
    RegisterUnderbogCreatureAI(boss_swamplord_muselek);
}
