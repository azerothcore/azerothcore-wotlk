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
#include "blood_furnace.h"

enum Says
{
    SAY_AGGRO               = 0,
    SAY_KILL                = 1,
    SAY_DIE                 = 2
};

enum Spells
{
    SPELL_EXPLODING_BEAKER  = 30925,
    SPELL_DOMINATION        = 30923
};

struct boss_the_maker : public BossAI
{
    boss_the_maker(Creature* creature) : BossAI(creature, DATA_THE_MAKER)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        if (instance)
        {
            instance->SetData(DATA_THE_MAKER, NOT_STARTED);
            instance->HandleGameObject(instance->GetGuidData(DATA_DOOR2), true);
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _JustEngagedWith();
        instance->SetData(DATA_THE_MAKER, IN_PROGRESS);
        instance->HandleGameObject(instance->GetGuidData(DATA_DOOR2), false);
        scheduler.Schedule(6s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_EXPLODING_BEAKER);
            context.Repeat(7s, 11s);
        }).Schedule(2min, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_DOMINATION);
            context.Repeat(2min);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->GetTypeId() == TYPEID_PLAYER && urand(0, 1))
        {
            Talk(SAY_KILL);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DIE);
        _JustDied();
        instance->SetData(DATA_THE_MAKER, DONE);
        instance->HandleGameObject(instance->GetGuidData(DATA_DOOR2), true);
        instance->HandleGameObject(instance->GetGuidData(DATA_DOOR3), true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_the_maker()
{
    RegisterBloodFurnaceCreatureAI(boss_the_maker);
}
