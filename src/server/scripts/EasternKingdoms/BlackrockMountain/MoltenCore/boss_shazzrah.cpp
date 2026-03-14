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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
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

        void JustEngagedWith(Unit* /*target*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_ARCANE_EXPLOSION, 2s, 4s);
            events.ScheduleEvent(EVENT_SHAZZRAH_CURSE, 7s,11s);
            events.ScheduleEvent(EVENT_MAGIC_GROUNDING, 14s, 19s);
            events.ScheduleEvent(EVENT_COUNTERSPELL, 9s, 10s);
            events.ScheduleEvent(EVENT_SHAZZRAH_GATE, 30s);
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_ARCANE_EXPLOSION:
                {
                    DoCastVictim(SPELL_ARCANE_EXPLOSION);
                    events.Repeat(4s, 5s);
                    break;
                }
                case EVENT_SHAZZRAH_CURSE:
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true, -SPELL_SHAZZRAH_CURSE))
                    {
                        DoCast(target, SPELL_SHAZZRAH_CURSE);
                    }
                    events.Repeat(23s, 26s);
                    break;
                }
                case EVENT_MAGIC_GROUNDING:
                {
                    DoCastSelf(SPELL_MAGIC_GROUNDING);
                    events.Repeat(7s, 9s);
                    break;
                }
                case EVENT_COUNTERSPELL:
                {
                    DoCastAOE(SPELL_COUNTERSPELL);
                    events.Repeat(15s, 18s);
                    break;
                }
                case EVENT_SHAZZRAH_GATE:
                {
                    DoCastAOE(SPELL_SHAZZRAH_GATE_DUMMY);
                    events.RescheduleEvent(EVENT_ARCANE_EXPLOSION, 3s, 6s);
                    events.Repeat(45s);
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
class spell_shazzrah_gate_dummy : public SpellScript
{
    PrepareSpellScript(spell_shazzrah_gate_dummy);

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
                creatureCaster->GetThreatMgr().ResetAllThreat();
                creatureCaster->GetThreatMgr().AddThreat(target, 1);
                creatureCaster->AI()->AttackStart(target); // Attack the target which caster will teleport to.
            }
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_shazzrah_gate_dummy::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_shazzrah_gate_dummy::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_shazzrah()
{
    new boss_shazzrah();

    // Spells
    RegisterSpellScript(spell_shazzrah_gate_dummy);
}
