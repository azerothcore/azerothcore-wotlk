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
#include "karazhan.h"

enum Spells
{
    SPELL_SNEAK                 = 22766,
    SPELL_ACIDIC_FANG           = 29901,
    SPELL_HYAKISS_WEB           = 29896,

    SPELL_DIVE                  = 29903,
    SPELL_SONIC_BURST           = 29904,
    SPELL_WING_BUFFET           = 29905,
    SPELL_FEAR                  = 29321,

    SPELL_RAVAGE                = 29906
};

struct boss_servant_quarters : public BossAI
{
    boss_servant_quarters(Creature* creature) : BossAI(creature, DATA_SERVANT_QUARTERS) { }

    void Reset() override
    {
        _scheduler.CancelAll();

        if (me->GetEntry() == NPC_HYAKISS_THE_LURKER)
        {
            DoCastSelf(SPELL_SNEAK, true);
        }
    }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        me->setActive(true);
        if (me->GetEntry() == NPC_HYAKISS_THE_LURKER)
        {
            _scheduler.Schedule(5s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_ACIDIC_FANG);
                context.Repeat(12s, 18s);
            }).Schedule(9s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_HYAKISS_WEB, 0, 30.0f);
                context.Repeat(15s);
            });
        }
        else if (me->GetEntry() == NPC_SHADIKITH_THE_GLIDER)
        {
            _scheduler.Schedule(4s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_SONIC_BURST);
                context.Repeat(12s, 18s);
            }).Schedule(7s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_WING_BUFFET);
                context.Repeat(12s, 18s);
            }).Schedule(10s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, RangeSelector(me, 40.0f, false, true)))
                {
                    me->CastSpell(target, SPELL_DIVE);
                }
                context.Repeat(20s);
            });
        }
        else // if (me->GetEntry() == NPC_ROKAD_THE_RAVAGER)
        {
            _scheduler.Schedule(3s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_RAVAGE);
                context.Repeat(10500ms);
            });
        }
    }

    void JustDied(Unit* /*who*/) override
    {
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == POINT_MOTION_TYPE && point == EVENT_CHARGE)
        {
            _scheduler.Schedule(1ms, [this](TaskContext /*context*/)
            {
                DoCastVictim(SPELL_FEAR);
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }

    private:
        TaskScheduler _scheduler;
};

void AddSC_boss_servant_quarters()
{
    RegisterKarazhanCreatureAI(boss_servant_quarters);
}
