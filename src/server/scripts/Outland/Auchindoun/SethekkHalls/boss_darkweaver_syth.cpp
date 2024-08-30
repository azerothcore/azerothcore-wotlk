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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "sethekk_halls.h"

enum Text
{
    SAY_SUMMON                  = 0,
    SAY_AGGRO                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEATH                   = 3
};

enum Spells
{
    SPELL_FLAME_SHOCK           = 15039,
    SPELL_ARCANE_SHOCK          = 33534,
    SPELL_FROST_SHOCK           = 12548,
    SPELL_SHADOW_SHOCK          = 33620,
    SPELL_CHAIN_LIGHTNING       = 15659,
    SPELL_SUMMON_ARC_ELE        = 33538,
    SPELL_SUMMON_FIRE_ELE       = 33537,
    SPELL_SUMMON_FROST_ELE      = 33539,
    SPELL_SUMMON_SHADOW_ELE     = 33540
};

struct boss_darkweaver_syth : public BossAI
{
    boss_darkweaver_syth(Creature* creature) : BossAI(creature, DATA_DARKWEAVER_SYTH)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        ScheduleHealthCheckEvent({90, 50, 10}, [&] {
            Talk(SAY_SUMMON);
            DoCastSelf(SPELL_SUMMON_ARC_ELE);
            DoCastSelf(SPELL_SUMMON_FIRE_ELE);
            DoCastSelf(SPELL_SUMMON_FROST_ELE);
            DoCastSelf(SPELL_SUMMON_SHADOW_ELE);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        scheduler.Schedule(2s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_FLAME_SHOCK);
            context.Repeat(10s, 15s);
        }).Schedule(4s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_ARCANE_SHOCK);
            context.Repeat(10s, 15s);
        }).Schedule(6s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_FROST_SHOCK);
            context.Repeat(10s, 15s);
        }).Schedule(8s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_SHADOW_SHOCK);
            context.Repeat(10s, 15s);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_CHAIN_LIGHTNING);
            context.Repeat(10s, 15s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }
};

void AddSC_boss_darkweaver_syth()
{
    RegisterSethekkHallsCreatureAI(boss_darkweaver_syth);
}
