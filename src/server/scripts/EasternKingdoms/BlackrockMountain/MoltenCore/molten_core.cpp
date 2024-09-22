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

#include "molten_core.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"

enum Texts
{
    EMOTE_SMOLDERING        = 0,
    EMOTE_IGNITE            = 1,
};

enum Spells
{
    // Ancient Core Hound
    SPELL_SERRATED_BITE     = 19771,
    SPELL_PLAY_DEAD         = 19822,
    SPELL_FULL_HEALTH       = 17683,
    SPELL_FIRE_NOVA_VISUAL  = 19823,
    SPELL_PLAY_DEAD_PACIFY  = 19951,    // Server side spell

    // Lava Spawn
    SPELL_FIREBALL          = 19391,
    SPELL_SPLIT_1           = 19569,
    SPELL_SPLIT_2           = 19570,

    TALK_0                  = 0
};

// Serrated Bites timer may be wrong
class npc_mc_core_hound : public CreatureScript
{
public:
    npc_mc_core_hound() : CreatureScript("npc_mc_core_hound") {}

    struct npc_mc_core_houndAI : public CreatureAI
    {
        npc_mc_core_houndAI(Creature* creature) :
            CreatureAI(creature),
            instance(creature->GetInstanceScript()),
            serratedBiteTimer(3000)
        {
        }

        void Reset() override
        {
            serratedBiteTimer = 3000;
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            // Prevent receiving any extra damage if Hound is playing dead
            if (me->HasAura(SPELL_PLAY_DEAD))
            {
                damage = 0;
                return;
            }
            else if (me->GetHealth() <= damage)
            {
                damage = 0;
                Talk(EMOTE_SMOLDERING);
                DoCastSelf(SPELL_PLAY_DEAD);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->HasAura(SPELL_PLAY_DEAD))
            {
                return;
            }

            if (serratedBiteTimer <= diff)
            {
                DoCastVictim(SPELL_SERRATED_BITE);
                serratedBiteTimer = urand(5000, 6000);
            }
            else
            {
                serratedBiteTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* instance;
        uint32 serratedBiteTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_mc_core_houndAI>(creature);
    }
};

// 19822 Play Dead
class spell_mc_play_dead_aura : public AuraScript
{
    PrepareAuraScript(spell_mc_play_dead_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PLAY_DEAD_PACIFY, SPELL_PLAY_DEAD });
    }

    bool Load() override
    {
        return GetCaster()->IsCreature();
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Creature* creatureTarget = GetTarget()->ToCreature();
        if (!creatureTarget)
        {
            return;
        }

        creatureTarget->CastSpell(creatureTarget, SPELL_PLAY_DEAD_PACIFY, true);
        creatureTarget->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
        creatureTarget->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        //creatureTarget->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
        creatureTarget->SetReactState(REACT_PASSIVE);
        creatureTarget->SetControlled(true, UNIT_STATE_ROOT);

        creatureTarget->AttackStop();
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Creature* creatureTarget = GetTarget()->ToCreature();
        if (!creatureTarget)
        {
            return;
        }

        creatureTarget->RemoveAurasDueToSpell(SPELL_PLAY_DEAD_PACIFY);
        creatureTarget->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
        creatureTarget->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        //creatureTarget->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
        creatureTarget->SetControlled(false, UNIT_STATE_ROOT);
        creatureTarget->SetReactState(REACT_AGGRESSIVE);

        if (!creatureTarget->IsInCombat())
        {
            return;
        }

        bool shouldDie = true;
        std::list<Creature*> hounds;
        creatureTarget->GetCreaturesWithEntryInRange(hounds, 80.0f, NPC_CORE_HOUND);

        // Perform lambda based check to find if there is any nearby
        if (!hounds.empty())
        {
            // Alive hound been found within 80 yards -> cancel suicide
            if (std::find_if(hounds.begin(), hounds.end(), [creatureTarget](Creature const* hound)
            {
                return creatureTarget != hound && creatureTarget->IsWithinLOSInMap(hound) && hound->IsAlive() && hound->IsInCombat() && !hound->HasAura(SPELL_PLAY_DEAD);
            }) != hounds.end())
            {
                shouldDie = false;
            }
        }

        if (!shouldDie)
        {
            if (CreatureAI* targetAI = creatureTarget->AI())
            {
                targetAI->DoCastSelf(SPELL_FIRE_NOVA_VISUAL, true);
                targetAI->DoCastSelf(SPELL_FULL_HEALTH, true);
                targetAI->Talk(EMOTE_IGNITE);
            }
        }
        else
        {
            Unit::Kill(creatureTarget, creatureTarget);
            creatureTarget->DespawnOrUnsummon(14000);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_mc_play_dead_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_FEIGN_DEATH, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectApplyFn(spell_mc_play_dead_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_FEIGN_DEATH, AURA_EFFECT_HANDLE_REAL);
    }
};

struct npc_lava_spawn : public ScriptedAI
{
    npc_lava_spawn(Creature* creature) : ScriptedAI(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.Schedule(15s, [this](TaskContext context)
        {
            std::list<Creature*> lavaSpawns;
            me->GetCreatureListWithEntryInGrid(lavaSpawns, me->GetEntry(), 100.f);
            if (lavaSpawns.size() < 16)
            {
                Talk(TALK_0);

                DoCastSelf(SPELL_SPLIT_1, true);
                DoCastSelf(SPELL_SPLIT_2, true);

                me->DespawnOrUnsummon();
            }
            else
            {
                context.Repeat(15s);
            }
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _scheduler.Update(diff);

        DoSpellAttackIfReady(SPELL_FIREBALL);
    }

private:
    TaskScheduler _scheduler;
};

void AddSC_molten_core()
{
    // Creatures
    new npc_mc_core_hound();
    RegisterCreatureAI(npc_lava_spawn);

    // Spells
    RegisterSpellScript(spell_mc_play_dead_aura);
}
