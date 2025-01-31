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

struct npc_pure_energy : public ScriptedAI
{
    explicit npc_pure_energy(Creature* creature) : ScriptedAI(creature) {}

    // Initialize on summon
    void IsSummonedBy(WorldObject* summoner) override
    {
        if (!summoner)
            return;
        if (Creature* vexallus = summoner ? summoner->ToCreature() : nullptr)
        {
            if (Unit* target = vexallus->AI()->SelectTarget(SelectTargetMethod::Random, 0))
                me->CastSpell(target, SPELL_ENERGY_FEEDBACK_CHANNEL, false);
        }
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (!attacker || !attacker->IsPlayer() || attacker->GetVictim() != me)
            damage = 0; // Only take damage from players targeting this add
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (!UpdateVictim())
            return;
    }

    void AttackStart(Unit* victim) override
    {
        if (victim)
        {
            me->Attack(victim, false);
            me->GetMotionMaster()->MoveChase(victim, 0.0f, 0.0f);
        }
    }
};

struct boss_vexallus : public BossAI
{
    // Configuration constants
    static constexpr std::array<uint8_t, 5> HEALTH_THRESHOLDS = {85, 70, 55, 40, 25}; // HP % for energy spawns
    static constexpr Seconds ENERGY_COOLDOWN = 5s;    // Time between energy spawns
    static constexpr Seconds ABILITY_TIMER = 8s;      // Basic ability cooldown
    static constexpr uint8 INITIAL_PURE_ENERGY = 5; // Starting energy count

    explicit boss_vexallus(Creature* creature)
        : BossAI(creature, DATA_VEXALLUS)
        , _energyCooldown(false)
        , _overloaded(false)
        , _energyQueue(0)
        , _pureEnergy(INITIAL_PURE_ENERGY)
        , _thresholdsPassed({})
    {
    }

    void Reset() override
    {
        _Reset();
        _energyCooldown = false;
        _energyQueue = 0;
        _overloaded = false;
        _pureEnergy = INITIAL_PURE_ENERGY;
        std::fill(_thresholdsPassed.begin(), _thresholdsPassed.end(), false);

        ScheduleEnergyCheck();
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
        ScheduleCombatAbilities();
    }

    void SummonedCreatureDies(Creature* summon, Unit* killer) override
    {
        summons.Despawn(summon);
        summon->DespawnOrUnsummon(1);
        if (killer)
            killer->CastSpell(killer, SPELL_ENERGY_FEEDBACK, true, 0, 0, summon->GetGUID());
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        DoMeleeAttackIfReady();
        CheckOverload();
        CheckHealthThresholds();

        events.Update(diff);
        scheduler.Update(diff);
    }

private:
    // Schedule periodic energy spawn checks
    void ScheduleEnergyCheck()
    {
        scheduler.Schedule(1s, [this](TaskContext context)
        {
            ProcessEnergyQueue();
            context.Repeat(1s);
        });
    }

    // Handle energy spawn logic
    void ProcessEnergyQueue()
    {
        if (!_energyCooldown && _energyQueue > 0)
        {
            Talk(SAY_ENERGY);
            Talk(EMOTE_DISCHARGE_ENERGY);

            if (IsHeroic())
            {
                DoCastSelf(SPELL_SUMMON_PURE_ENERGY_H1);
                DoCastSelf(SPELL_SUMMON_PURE_ENERGY_H2);
            }
            else
            {
                DoCastSelf(SPELL_SUMMON_PURE_ENERGY_N);
            }

            _energyQueue--;
            _pureEnergy--;
            SetEnergyCooldown();
        }
    }

    // Start energy spawn cooldown
    void SetEnergyCooldown()
    {
        _energyCooldown = true;
        scheduler.Schedule(ENERGY_COOLDOWN, [this](TaskContext)
        {
            _energyCooldown = false;
        });
    }

    // Schedule basic combat abilities
    void ScheduleCombatAbilities()
    {
        ScheduleTimedEvent(ABILITY_TIMER, [&]
        {
            DoCastRandomTarget(SPELL_CHAIN_LIGHTNING);
        }, ABILITY_TIMER, ABILITY_TIMER);

        ScheduleTimedEvent(5s, [&]
        {
            DoCastRandomTarget(SPELL_ARCANE_SHOCK);
        }, ABILITY_TIMER, ABILITY_TIMER);
    }

    // Check for final phase transition
    void CheckOverload()
    {
        if (!_overloaded && _pureEnergy == 0 && !_energyCooldown && HealthBelowPct(20))
        {
            Talk(SAY_OVERLOAD);
            Talk(EMOTE_OVERLOAD);
            DoCastSelf(SPELL_OVERLOAD, true);
            _overloaded = true;
        }
    }

    // Check health-based energy spawn triggers
    void CheckHealthThresholds()
    {
        for (size_t i = 0; i < HEALTH_THRESHOLDS.size(); ++i)
        {
            if (!_thresholdsPassed[i] && HealthBelowPct(HEALTH_THRESHOLDS[i]))
            {
                _energyQueue++;
                _thresholdsPassed[i] = true;
            }
        }
    }

    // State tracking
    bool _energyCooldown;     // Energy spawn on cooldown
    bool _overloaded;         // Final phase active
    uint8 _energyQueue;     // Pending energy spawns
    uint8 _pureEnergy;      // Remaining energy count
    std::array<bool, 5> _thresholdsPassed; // Health threshold tracking
};

void AddSC_boss_vexallus()
{
    RegisterMagistersTerraceCreatureAI(npc_pure_energy);
    RegisterMagistersTerraceCreatureAI(boss_vexallus);
}
