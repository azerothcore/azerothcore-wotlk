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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "molten_core.h"

enum Spells
{
    SPELL_ARCANE_EXPLOSION              = 19712,
    SPELL_SHAZZRAH_CURSE                = 19713,
    SPELL_MAGIC_GROUNDING               = 19714,
    SPELL_COUNTERSPELL                  = 19715,
    SPELL_SHAZZRAH_GATE_DUMMY           = 23138, // Teleports to and attacks a random target. About every 45 seconds Shazzrah will blink to random target causing a wipe of the threat list (source: wowwwiki)
    SPELL_SHAZZRAH_GATE                 = 23139,
};

enum Events
{
    EVENT_ARCANE_EXPLOSION              = 1,
    EVENT_SHAZZRAH_CURSE,
    EVENT_MAGIC_GROUNDING,
    EVENT_COUNTERSPELL,
    EVENT_SHAZZRAH_GATE,
};

class boss_shazzrah : public CreatureScript
{
public:
    boss_shazzrah() : CreatureScript("boss_shazzrah") { }

    struct boss_shazzrahAI : public BossAI
    {
        boss_shazzrahAI(Creature* creature) : BossAI(creature, DATA_SHAZZRAH) {}

        void EnterCombat(Unit* /*target*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_ARCANE_EXPLOSION, urand(2000, 4000));
            events.ScheduleEvent(EVENT_SHAZZRAH_CURSE, urand(7000, 11000));
            events.ScheduleEvent(EVENT_MAGIC_GROUNDING, urand(14000, 19000));
            events.ScheduleEvent(EVENT_COUNTERSPELL, urand(9000, 10000));
            events.ScheduleEvent(EVENT_SHAZZRAH_GATE, 30000);
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_ARCANE_EXPLOSION:
                {
                    DoCastVictim(SPELL_ARCANE_EXPLOSION);
                    events.RepeatEvent(urand(4000, 5000));
                    break;
                }
                case EVENT_SHAZZRAH_CURSE:
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, -SPELL_SHAZZRAH_CURSE))
                    {
                        DoCast(target, SPELL_SHAZZRAH_CURSE);
                    }
                    events.RepeatEvent(urand(23000, 26000));
                    break;
                }
                case EVENT_MAGIC_GROUNDING:
                {
                    DoCastSelf(SPELL_MAGIC_GROUNDING);
                    events.RepeatEvent(urand(7000, 9000));
                    break;
                }
                case EVENT_COUNTERSPELL:
                {
                    DoCastAOE(SPELL_COUNTERSPELL);
                    events.RepeatEvent(urand(15000, 18000));
                    break;
                }
                case EVENT_SHAZZRAH_GATE:
                {
                    DoCastAOE(SPELL_SHAZZRAH_GATE_DUMMY);
                    events.RescheduleEvent(EVENT_ARCANE_EXPLOSION, urand(3000, 6000));
                    events.RepeatEvent(45000);
                    break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_shazzrahAI>(creature);
    }
};

// 23138 - Gate of Shazzrah
class spell_shazzrah_gate_dummy : public SpellScriptLoader
{
public:
    spell_shazzrah_gate_dummy() : SpellScriptLoader("spell_shazzrah_gate_dummy") {}

    class spell_shazzrah_gate_dummy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_shazzrah_gate_dummy_SpellScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_SHAZZRAH_GATE });
        }

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            Unit* caster = GetCaster();
            if (!targets.empty())
            {
                targets.remove_if([caster](WorldObject const* target) -> bool
                {
                    Player const* plrTarget = target->ToPlayer();
                    // Should not target non player targets
                    if (!plrTarget)
                    {
                        return true;
                    }

                    // Should skip current victim
                    if (caster->GetVictim() == plrTarget)
                    {
                        return true;
                    }

                    // Should not target enemies within melee range
                    if (plrTarget->IsWithinMeleeRange(caster))
                    {
                        return true;
                    }

                    return false;
                });
            }

            if (!targets.empty())
            {
                Acore::Containers::RandomResize(targets, 1);
            }
        }

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            Unit* target = GetHitUnit();

            if (caster && target)
            {
                target->CastSpell(caster, SPELL_SHAZZRAH_GATE, true);
                caster->CastSpell(nullptr, SPELL_ARCANE_EXPLOSION);

                if (Creature* creatureCaster = caster->ToCreature())
                {
                    creatureCaster->getThreatMgr().ResetAllThreat();
                    creatureCaster->getThreatMgr().addThreat(target, 1);
                    creatureCaster->AI()->AttackStart(target); // Attack the target which caster will teleport to.
                }
            }
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_shazzrah_gate_dummy_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnEffectHitTarget += SpellEffectFn(spell_shazzrah_gate_dummy_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_shazzrah_gate_dummy_SpellScript();
    }
};

void AddSC_boss_shazzrah()
{
    new boss_shazzrah();

    // Spells
    new spell_shazzrah_gate_dummy();
}
