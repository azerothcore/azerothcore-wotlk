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
#include "the_slave_pens.h"

// Grievous Wound (31956 / 38801) is intentionally omitted from Rokmar's
// rotation. The original aura ticks until the target is fully healed, which
// turns into a guaranteed kill on auto-balance / no-healer compositions.
// Cutting the cast is simpler than scripting an expiry override and matches
// the design intent of "encounter is beatable without a dedicated healer".
enum Spells
{
    SPELL_ENSNARING_MOSS    = 31948,
    SPELL_FRENZY            = 34970,
    SPELL_WATER_SPIT        = 35008
};

struct boss_rokmar_the_crackler : public BossAI
{
    explicit boss_rokmar_the_crackler(Creature* creature) : BossAI(creature, DATA_ROKMAR_THE_CRACKLER)
    {    }

    void Reset() override
    {
        _Reset();

        ScheduleHealthCheckEvent(20, [&] {
            DoCastSelf(SPELL_FRENZY);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(15300ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_ENSNARING_MOSS);
            context.Repeat(26s);
        }).Schedule(10700ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_WATER_SPIT);
            context.Repeat(19s);
        });
    }
};

void AddSC_boss_rokmar_the_crackler()
{
    RegisterTheSlavePensCreatureAI(boss_rokmar_the_crackler);
}
