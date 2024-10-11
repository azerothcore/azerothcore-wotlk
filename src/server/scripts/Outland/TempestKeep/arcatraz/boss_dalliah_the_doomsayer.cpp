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
#include "arcatraz.h"

enum Say
{
    // Dalliah the Doomsayer
    SAY_AGGRO                       = 1,
    SAY_SLAY                        = 2,
    SAY_WHIRLWIND                   = 3,
    SAY_HEAL                        = 4,
    SAY_DEATH                       = 5,
    SAY_SOCCOTHRATES_DEATH          = 7,

    // Wrath-Scryer Soccothrates
    SAY_AGGRO_DALLIAH_FIRST         = 0,
    SAY_DALLIAH_25_PERCENT          = 5
};

enum Spells
{
    SPELL_GIFT_OF_THE_DOOMSAYER     = 36173,
    SPELL_WHIRLWIND                 = 36142,
    SPELL_HEAL                      = 36144,
    SPELL_SHADOW_WAVE               = 39016
};

struct boss_dalliah_the_doomsayer : public BossAI
{
    boss_dalliah_the_doomsayer(Creature* creature) : BossAI(creature, DATA_DALLIAH) { }

    void Reset() override
    {
        _Reset();

        ScheduleHealthCheckEvent(25, [&]
        {
            if (Creature* soccothrates = instance->GetCreature(DATA_SOCCOTHRATES))
            {
                soccothrates->AI()->Talk(SAY_DALLIAH_25_PERCENT);
            }
        });
    }

    void InitializeAI() override
    {
        BossAI::InitializeAI();
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);

        if (Creature* soccothrates = instance->GetCreature(DATA_SOCCOTHRATES))
        {
            if (soccothrates->IsAlive() && !soccothrates->IsInCombat())
            {
                soccothrates->AI()->Talk(SAY_RIVAL_DIED, 6s);
            }
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        if (Creature* soccothrates = instance->GetCreature(DATA_SOCCOTHRATES))
        {
            if (soccothrates->IsAlive() && !soccothrates->IsInCombat())
            {
                soccothrates->AI()->Talk(SAY_AGGRO_DALLIAH_FIRST, 6s);
            }
        }

        scheduler.Schedule(8s, 12s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_GIFT_OF_THE_DOOMSAYER);
            context.Repeat(17s, 35s);
        }).Schedule(20s, 30s, [this](TaskContext context)
        {
            Talk(SAY_WHIRLWIND);
            DoCastAOE(SPELL_WHIRLWIND);
            context.Repeat();

            scheduler.Schedule(7s, [this](TaskContext)
            {
                Talk(SAY_HEAL);
                DoCastSelf(SPELL_HEAL);
            });
        });

        if (IsHeroic())
        {
            scheduler.Schedule(11s, 30s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SHADOW_WAVE);
                context.Repeat();
            });
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }
};

void AddSC_boss_dalliah_the_doomsayer()
{
    RegisterArcatrazCreatureAI(boss_dalliah_the_doomsayer);
}
