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
#include "SpellInfo.h"
#include "karazhan.h"

struct boss_tenris_mirkblood : public BossAI
{
    boss_tenris_mirkblood(Creature* creature) : BossAI(creature, DATA_MIRKBLOOD)
    {
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void Reset() override
    {
        _Reset();
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        // Talk(SAY_AGGRO);
        DoZoneInCombat();
    }

    void JustSummoned(Creature* summoned) override
    {
    }

    void KilledUnit(Unit* victim) override
    {
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        // Talk(SAY_DEATH);
    }
};

void AddSC_boss_tenris_mirkblood()
{
    RegisterKarazhanCreatureAI(boss_tenris_mirkblood);
}
