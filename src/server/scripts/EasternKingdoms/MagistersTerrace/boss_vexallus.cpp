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
#include "magisters_terrace.h"

enum Yells
{
    SAY_AGGRO                       = 0,    // Combat start
    SAY_ENERGY                      = 1,    // Pure energy spawn
    SAY_OVERLOAD                    = 2,    // Final phase
    SAY_KILL                        = 3,    // Player kill
    EMOTE_DISCHARGE_ENERGY          = 4,    // Energy discharge warning
    EMOTE_OVERLOAD                  = 5     // Overload emote
};

enum Spells
{
    SPELL_ENERGY_FEEDBACK_CHANNEL   = 44328, // Pure energy channel
    SPELL_ENERGY_FEEDBACK           = 44335, // Pure energy death effect
    SPELL_CHAIN_LIGHTNING           = 44318, // Basic attack
    SPELL_OVERLOAD                  = 44352, // Enrage ability
    SPELL_ARCANE_SHOCK              = 44319, // Basic attack
    SPELL_SUMMON_PURE_ENERGY_N      = 44322, // Normal mode summon
    SPELL_SUMMON_PURE_ENERGY_H1     = 46154, // Heroic mode summon 1
    SPELL_SUMMON_PURE_ENERGY_H2     = 46159  // Heroic mode summon 2
};

struct boss_vexallus : public BossAI
{
    boss_vexallus(Creature* creature) : BossAI(creature, DATA_VEXALLUS), _energyCooldown(false), _energyCount(0) { }

    void Reset() override
    {
        _Reset();
        _energyCooldown = false;
        _energyCount = 0;

        ScheduleHealthCheckEvent({ 85, 70, 55, 40, 25 }, [&]
        {
            scheduler.Schedule(1s, [this](TaskContext context)
            {
                if (!_energyCooldown)
                {
                    Talk(SAY_ENERGY);
                    Talk(EMOTE_DISCHARGE_ENERGY);
                    if (IsHeroic())
                    {
                        DoCastSelf(SPELL_SUMMON_PURE_ENERGY_H1);
                        DoCastSelf(SPELL_SUMMON_PURE_ENERGY_H2);
                    }
                    else
                        DoCastSelf(SPELL_SUMMON_PURE_ENERGY_N);

                    _energyCooldown = true;
                    ++_energyCount;

                    me->m_Events.AddEventAtOffset([&]
                    {
                        _energyCooldown = false;
                    }, 5s);
                }
                else
                    context.Repeat(5s);

            });
        });

        ScheduleHealthCheckEvent(20, [&]
        {
            scheduler.Schedule(1s, [this](TaskContext context)
            {
                if (_energyCount == 5 && !_energyCooldown)
                {
                    scheduler.CancelAll();
                    Talk(SAY_OVERLOAD);
                    Talk(EMOTE_OVERLOAD);
                    DoCastSelf(SPELL_OVERLOAD, true);
                }
                else
                    context.Repeat(5s);
            });
        });
    }

    void JustDied(Unit*) override
    {
        _JustDied();
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ENERGY_FEEDBACK);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_KILL);
    }

    void JustEngagedWith(Unit*) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        ScheduleTimedEvent(5s, [&]
        {
            DoCastRandomTarget(SPELL_CHAIN_LIGHTNING);
        }, 8s);

        ScheduleTimedEvent(5s, [&]
        {
            DoCastRandomTarget(SPELL_ARCANE_SHOCK);
        }, 5s);
    }

    void JustSummoned(Creature* summon) override
    {
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
        {
            summon->SetReactState(REACT_PASSIVE);
            summon->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f);
            summon->CastSpell(target, SPELL_ENERGY_FEEDBACK_CHANNEL, false);
        }

        summons.Summon(summon);
    }

    void SummonedCreatureDies(Creature* summon, Unit* killer) override
    {
        summons.Despawn(summon);
        summon->DespawnOrUnsummon(1);
        if (killer)
            killer->CastSpell(killer, SPELL_ENERGY_FEEDBACK, true, 0, 0, summon->GetGUID());
    }

private:
    bool _energyCooldown;
    uint8 _energyCount;
};

void AddSC_boss_vexallus()
{
    RegisterMagistersTerraceCreatureAI(boss_vexallus);
}
