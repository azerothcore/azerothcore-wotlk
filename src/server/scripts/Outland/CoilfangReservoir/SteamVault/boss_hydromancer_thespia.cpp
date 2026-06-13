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
#include "steam_vault.h"

enum HydromancerThespia
{
    SAY_SUMMON                  = 0, // Unused or Unknown Use
    SAY_AGGRO                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEAD                    = 3,
    SAY_SPELL                   = 4,

    SPELL_LIGHTNING_CLOUD       = 25033,
    SPELL_LUNG_BURST            = 31481,
    SPELL_ENVELOPING_WINDS      = 31718
};

struct boss_hydromancer_thespia : public BossAI
{
    boss_hydromancer_thespia(Creature* creature) : BossAI(creature, DATA_HYDROMANCER_THESPIA) { }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEAD);

        instance->DoForAllMinions(DATA_HYDROMANCER_THESPIA, [&](Creature* creature) {
            creature->DespawnOrUnsummon();
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _JustEngagedWith();

        scheduler.Schedule(9800ms, [this](TaskContext context)
        {
            Talk(SAY_SPELL);
            DoCastRandomTarget(SPELL_LIGHTNING_CLOUD);
            context.Repeat(12100ms, 14500ms);
        }).Schedule(13300ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_LUNG_BURST);
            context.Repeat(21800ms, 25400ms);
        }).Schedule(14500ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_ENVELOPING_WINDS);
            context.Repeat(30s, 40s);
        });
    }
};

void AddSC_boss_hydromancer_thespia()
{
    RegisterSteamvaultCreatureAI(boss_hydromancer_thespia);
}
