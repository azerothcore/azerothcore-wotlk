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
#include "steam_vault.h"

enum MekgineerSteamrigger
{
    SAY_MECHANICS               = 0,
    SAY_AGGRO                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEATH                   = 3,

    SPELL_SUPER_SHRINK_RAY      = 31485,
    SPELL_SAW_BLADE             = 31486,
    SPELL_ELECTRIFIED_NET       = 35107,
    SPELL_ENRAGE                = 26662,

    SPELL_SUMMON_MECHANICS_1    = 31528,
    SPELL_SUMMON_MECHANICS_2    = 31529,
    SPELL_SUMMON_MECHANICS_3    = 31530,

    NPC_STREAMRIGGER_MECHANIC   = 17951
};

struct boss_mekgineer_steamrigger : public BossAI
{
    boss_mekgineer_steamrigger(Creature* creature) : BossAI(creature, DATA_MEKGINEER_STEAMRIGGER)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();
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

        scheduler.Schedule(26550ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SUPER_SHRINK_RAY);
            context.Repeat(35100ms, 54100ms);
        }).Schedule(6050ms, 17650ms, [this](TaskContext context)
        {
            if (DoCastRandomTarget(SPELL_SAW_BLADE, 1) != SPELL_CAST_OK)
            {
                DoCastVictim(SPELL_SAW_BLADE);
            }

            context.Repeat(6050ms, 17650ms);
        }).Schedule(14400ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_ELECTRIFIED_NET);
            context.Repeat(21800ms, 34200ms);
        }).Schedule(5min, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_ENRAGE, true);
        });

        if (!IsHeroic())
        {
            ScheduleHealthCheckEvent({ 75, 50, 25 }, [&] {
                Talk(SAY_MECHANICS);

                for (auto const& spell : { SPELL_SUMMON_MECHANICS_1, SPELL_SUMMON_MECHANICS_2, SPELL_SUMMON_MECHANICS_3 })
                {
                    DoCastAOE(spell, true);
                }
            });
        }
        else
        {
            scheduler.Schedule(15600ms, [this](TaskContext context)
            {
                if (roll_chance_i(15))
                {
                    Talk(SAY_MECHANICS);
                }

                DoCastAOE(RAND(SPELL_SUMMON_MECHANICS_1, SPELL_SUMMON_MECHANICS_2, SPELL_SUMMON_MECHANICS_3), true);
                context.Repeat(15600ms, 25400ms);
            });
        }
    }

    void JustSummoned(Creature* creature) override
    {
        if (creature->GetEntry() == NPC_STREAMRIGGER_MECHANIC)
        {
            creature->GetMotionMaster()->MoveFollow(me, 5.0f, 0.0f);
        }
    }
};

void AddSC_boss_mekgineer_steamrigger()
{
    RegisterSteamvaultCreatureAI(boss_mekgineer_steamrigger);
}
