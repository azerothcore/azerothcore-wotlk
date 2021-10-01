/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "molten_core.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_ARCANE_EXPLOSION      = 19712,
    SPELL_SHAZZRAH_CURSE        = 19713,
    SPELL_MAGIC_GROUNDING       = 19714,
    SPELL_COUNTERSPELL          = 19715,
    SPELL_SHAZZRAH_GATE_DUMMY   = 23138, // Teleports to and attacks a random target.
    SPELL_SHAZZRAH_GATE         = 23139,
};

enum Events
{
    EVENT_ARCANE_EXPLOSION              = 1,
    EVENT_ARCANE_EXPLOSION_TRIGGERED,
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

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ARCANE_EXPLOSION:
                    {
                        DoCastVictim(SPELL_ARCANE_EXPLOSION);
                        events.RepeatEvent(urand(4000, 5000));
                        break;
                    }
                        // Triggered subsequent to using "Gate of Shazzrah".
                    case EVENT_ARCANE_EXPLOSION_TRIGGERED:
                    {
                        DoCastVictim(SPELL_ARCANE_EXPLOSION);
                        break;
                    }
                    case EVENT_SHAZZRAH_CURSE:
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true, -SPELL_SHAZZRAH_CURSE))
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
                        DoCastVictim(SPELL_COUNTERSPELL);
                        events.RepeatEvent(urand(15000, 18000));
                        break;
                    }
                    case EVENT_SHAZZRAH_GATE:
                    {
                        DoResetThreat();
                        DoCastAOE(SPELL_SHAZZRAH_GATE_DUMMY);
                        events.ScheduleEvent(EVENT_ARCANE_EXPLOSION_TRIGGERED, 2000);
                        events.RescheduleEvent(EVENT_ARCANE_EXPLOSION, urand(3000, 6000));
                        events.RepeatEvent(45000);
                        break;
                    }
                }
            }

            DoMeleeAttackIfReady();
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
    spell_shazzrah_gate_dummy() : SpellScriptLoader("spell_shazzrah_gate_dummy") { }

    class spell_shazzrah_gate_dummy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_shazzrah_gate_dummy_SpellScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_SHAZZRAH_GATE });
        }

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            if (!targets.empty())
            {
                WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
                targets.clear();
                targets.push_back(target);
            }
        }

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
            {
                target->CastSpell(GetCaster(), SPELL_SHAZZRAH_GATE, true);
                if (Creature* creature = GetCaster()->ToCreature())
                {
                    creature->AI()->AttackStart(target); // Attack the target which caster will teleport to.
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
    new spell_shazzrah_gate_dummy();
}
