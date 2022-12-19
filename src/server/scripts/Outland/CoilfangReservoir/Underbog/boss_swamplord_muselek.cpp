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
#include "SpellScript.h"
#include "TaskScheduler.h"
#include "the_underbog.h"

enum Spells
{
    SPELL_SHOOT               = 22907,
    SPELL_KNOCKAWAY           = 18813,
    SPELL_RAPTOR_STRIKE       = 31566,
    SPELL_MULTISHOT           = 34974,
    SPELL_THROW_FREEZING_TRAP = 31946
};

enum Misc
{
    RANGED_GROUP = 1,
    RANGE_CHECK  = 2
};

struct boss_swamplord_muselek : public ScriptedAI
{
    boss_swamplord_muselek(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _scheduler.CancelAll();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
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

    void EnterCombat(Unit*) override
    {
        _scheduler.Schedule(3s, [this](TaskContext context)
        {
            if (me->GetVictim() && !me->IsWithinRange(me->GetVictim(), 10.0f) && me->IsWithinLOSInMap(me->GetVictim()))
            {
                me->LoadEquipment(1, true);
                DoCastVictim(SPELL_SHOOT);
                me->GetMotionMaster()->Clear();
            }
            else
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
            me->InterruptNonMeleeSpells(false);
            DoCastVictim(SPELL_MULTISHOT);
            context.Repeat(20s, 30s);
        }).Schedule(4s, 8s, [this](TaskContext context)
        {
            me->InterruptNonMeleeSpells(false);
            DoCastRandomTarget(SPELL_THROW_FREEZING_TRAP);
            context.Repeat(12s, 16s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update();

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
};

void AddSC_boss_swamplord_muselek()
{
    RegisterUnderbogCreatureAI(boss_swamplord_muselek);
}
