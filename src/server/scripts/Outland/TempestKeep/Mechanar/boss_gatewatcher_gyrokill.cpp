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
#include "mechanar.h"

enum Say
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_SAW_BLADE                   = 2,
    SAY_DEATH                       = 3
};

enum Spells
{
    SPELL_STREAM_OF_MACHINE_FLUID   = 35311,
    SPELL_SAW_BLADE                 = 35318,
    SPELL_SHADOW_POWER              = 35322
};

struct boss_gatewatcher_gyrokill : public BossAI
{
    boss_gatewatcher_gyrokill(Creature* creature) : BossAI(creature, DATA_GATEWATCHER_GYROKILL) { }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(10s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_STREAM_OF_MACHINE_FLUID);
            context.Repeat(12s, 14s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_SAW_BLADE, 0, 50.0f);
            Talk(SAY_SAW_BLADE);
            context.Repeat(25s);
        }).Schedule(30s, [this](TaskContext context)
        {
            me->CastSpell(me, SPELL_SHADOW_POWER, false);
            context.Repeat(25s);
        });

        Talk(SAY_AGGRO);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }
};

void AddSC_boss_gatewatcher_gyrokill()
{
    RegisterMechanarCreatureAI(boss_gatewatcher_gyrokill);
}
