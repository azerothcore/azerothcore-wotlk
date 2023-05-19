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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "the_underbog.h"

enum Spells
{
    //Musel'ek
    SPELL_SHOOT               = 22907,
    SPELL_KNOCKAWAY           = 18813,
    SPELL_RAPTOR_STRIKE       = 31566,
    SPELL_MULTISHOT           = 34974,
    SPELL_THROW_FREEZING_TRAP = 31946,
    SPELL_AIMED_SHOT          = 31623,
    SPELL_HUNTERS_MARK        = 31615,

    //Claw
    SPELL_FERAL_CHARGE        = 39435,
    SPELL_ECHOING_ROAR        = 31429,
    SPELL_FRENZY              = 34971,
    SPELL_MAUL                = 34298
};

enum Text
{
    SAY_CLAW_FRENZY = 0,
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
        return me->GetVictim() && !me->IsWithinRange(me->GetVictim(), 10.0f) && me->IsWithinLOSInMap(me->GetVictim());
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
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, false, true))
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
                            me->GetMotionMaster()->MoveBackwards(me->GetVictim(), 10.0f);
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


struct npc_claw : public ScriptedAI
{
    npc_claw(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _scheduler.CancelAll();

        ScheduleHealthCheckEvent(20, [&] {
            me->SetFaction(942);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.Schedule(7400ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_FERAL_CHARGE);
            context.Repeat(20s);
        }).Schedule(2400ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_ECHOING_ROAR);
            context.Repeat(10600ms, 21200ms);
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_FRENZY);

            if (Creature* muselek = instance->GetCreature(DATA_MUSELEK))
            {
                muselek->AI()->Talk(SAY_CLAW_FRENZY);
            }
            context.Repeat(30500ms);
        }).Schedule(5300ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_MAUL);
            context.Repeat(11100ms, 21500ms);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        SetData(DATA_MUSELEK, DONE);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return
        
        _scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

private:
    TaskScheduler _scheduler;
};


void AddSC_boss_swamplord_muselek()
{
    RegisterUnderbogCreatureAI(boss_swamplord_muselek);
    RegisterUnderbogCreatureAI(npc_claw);
}
