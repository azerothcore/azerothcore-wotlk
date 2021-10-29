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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "molten_core.h"

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
class spell_mc_play_dead : public SpellScriptLoader
{
public:
    spell_mc_play_dead() : SpellScriptLoader("spell_mc_play_dead") { }

    class spell_mc_play_dead_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mc_play_dead_AuraScript);

        bool Load() override
        {
            return GetCaster()->GetTypeId() == TYPEID_UNIT;
        }

        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Creature* creatureTarget = GetTarget()->ToCreature();
            if (!creatureTarget)
            {
                return;
            }

            creatureTarget->CastSpell(creatureTarget, SPELL_PLAY_DEAD_PACIFY, true);
            creatureTarget->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
            creatureTarget->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
            //creatureTarget->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
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
            creatureTarget->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
            creatureTarget->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
            //creatureTarget->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
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
            }
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_mc_play_dead_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_FEIGN_DEATH, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectApplyFn(spell_mc_play_dead_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_FEIGN_DEATH, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_mc_play_dead_AuraScript();
    }
};

void AddSC_molten_core()
{
    // Creatures
    new npc_mc_core_hound();

    // Spells
    new spell_mc_play_dead();
}
