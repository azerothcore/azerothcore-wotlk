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
    SAY_AGGRO                       = 0,
    SAY_ENERGY                      = 1,
    SAY_OVERLOAD                    = 2,
    SAY_KILL                        = 3,
    EMOTE_DISCHARGE_ENERGY          = 4
};

enum Spells
{
    SPELL_ENERGY_FEEDBACK_CHANNEL   = 44328,
    SPELL_ENERGY_FEEDBACK           = 44335,
    SPELL_CHAIN_LIGHTNING           = 44318,
    SPELL_OVERLOAD                  = 44352,
    SPELL_ARCANE_SHOCK              = 44319,
    SPELL_SUMMON_PURE_ENERGY_N      = 44322,
    SPELL_SUMMON_PURE_ENERGY_H1     = 46154,
    SPELL_SUMMON_PURE_ENERGY_H2     = 46159
};

enum Misc
{
    NPC_PURE_ENERGY                 = 24745
};

struct npc_pure_energy : public ScriptedAI
{
    npc_pure_energy(Creature* creature) : ScriptedAI(creature) {}

    void IsSummonedBy(WorldObject* summoner) override
    {
         if (Creature* vexallus = dynamic_cast<Creature*>(summoner))
         {
             if (Unit* target = vexallus->AI()->SelectTarget(SelectTargetMethod::Random, 0))
             {
                 AttackStart(target);
                 me->CastSpell(target, SPELL_ENERGY_FEEDBACK_CHANNEL, false);
             }
         }
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (!attacker || !attacker->IsPlayer() || !attacker->GetVictim() || attacker->GetVictim() != me)
        {
            damage = 0;
        }
    }
};

struct boss_vexallus : public BossAI
{
    boss_vexallus(Creature* creature) : BossAI(creature, DATA_VEXALLUS),
        _energyCooldown(false),
        _energyQueue(0) { }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        if (instance)
        {
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ENERGY_FEEDBACK);
        }
    }

    void Reset() override
    {
        _Reset();
        _energyCooldown = false;
        _energyQueue = 0;
        _overload = false;
        std::fill(_thresholdsPassed.begin(), _thresholdsPassed.end(), false);

        scheduler.Schedule(1s, [this](TaskContext context)
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
                    DoCastSelf(SPELL_SUMMON_PURE_ENERGY_N);

                _energyQueue--;
                _energyCooldown = true;
                scheduler.Schedule(5s, [this](TaskContext)
                {
                    _energyCooldown = false;
                });
            }

            context.Repeat(1s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_KILL);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        _overload = false;
        Talk(SAY_AGGRO);
        ScheduleTimedEvent(8s, [&]
        {
            DoCastRandomTarget(SPELL_CHAIN_LIGHTNING);
        }, 8s, 8s);

        ScheduleTimedEvent(5s, [&]
        {
            DoCastRandomTarget(SPELL_ARCANE_SHOCK);
        }, 8s, 8s);
    }

    void JustSummoned(Creature* summon) override
    {
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
        {
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

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        float currentPct = me->GetHealthPct();

        if (currentPct <= 20.0f && _overload)
        {   
            DoCastSelf(SPELL_OVERLOAD, true);
            me->RemoveUnitFlag(UNIT_FLAG_STUNNED); // This currently is a hack; SPELL_OVERLOAD applies UNIT_FLAG_STUNNED when it shouldn't
        }

        if (currentPct <= 85.0f && !_thresholdsPassed[0]) { _energyQueue++; _thresholdsPassed[0] = true; }
        if (currentPct <= 70.0f && !_thresholdsPassed[1]) { _energyQueue++; _thresholdsPassed[1] = true; }
        if (currentPct <= 55.0f && !_thresholdsPassed[2]) { _energyQueue++; _thresholdsPassed[2] = true; }
        if (currentPct <= 40.0f && !_thresholdsPassed[3]) { _energyQueue++; _thresholdsPassed[3] = true; }
        if (currentPct <= 25.0f && !_thresholdsPassed[4]) { _energyQueue++; _thresholdsPassed[4] = true; }

        events.Update(diff);
        scheduler.Update(diff);
    }

private:
    bool _energyCooldown;
    bool _overload;
    uint8 _energyQueue;
    std::array<bool, 5> _thresholdsPassed{};
};

void AddSC_boss_vexallus()
{
    RegisterMagistersTerraceCreatureAI(npc_pure_energy);
    RegisterMagistersTerraceCreatureAI(boss_vexallus);
}
