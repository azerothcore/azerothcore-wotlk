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
#include "mana_tombs.h"

enum Spells
{
    SPELL_EARTHQUAKE        = 33919,
    SPELL_CRYSTAL_PRISON    = 32361,
    SPELL_ARCING_SMASH      = 8374
};

struct boss_tavarok : public BossAI
{
    boss_tavarok(Creature* creature) : BossAI(creature, DATA_TAVAROK)
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

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        scheduler.Schedule(10s, 14200ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_EARTHQUAKE);
            context.Repeat(20s, 31s);
        }).Schedule(12s, 22s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_CRYSTAL_PRISON);
            context.Repeat(15s, 22s);
        }).Schedule(5900ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ARCING_SMASH);
            context.Repeat(8s, 12s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
    }

    void KilledUnit(Unit* /*victim*/) override {}
};

void AddSC_boss_tavarok()
{
    RegisterManaTombsCreatureAI(boss_tavarok);
}
