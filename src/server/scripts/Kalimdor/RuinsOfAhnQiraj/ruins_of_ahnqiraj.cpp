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

#include "ruins_of_ahnqiraj.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum Spells
{
    // Hive'Zara Stinger
    SPELL_HIVEZARA_CATALYST             = 25187,
    SPELL_STINGER_CHARGE_NORMAL         = 25190,
    SPELL_STINGER_CHARGE_BUFFED         = 25191,

    // Obsidian Destroyer
    SPELL_PURGE                         = 25756,
    SPELL_DRAIN_MANA                    = 25755,
    SPELL_DRAIN_MANA_VISUAL             = 26639,
    SPELL_SUMMON_SMALL_OBSIDIAN_CHUNK   = 27627, // Server-side
};

struct npc_hivezara_stinger : public ScriptedAI
{
    npc_hivezara_stinger(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* who) override
    {
        DoCast(who ,who->HasAura(SPELL_HIVEZARA_CATALYST) ? SPELL_STINGER_CHARGE_BUFFED : SPELL_STINGER_CHARGE_NORMAL, true);

        scheduler.Schedule(5s, [this](TaskContext context)
        {
            Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 20.0f, true, false, SPELL_HIVEZARA_CATALYST);
            if (!target)
            {
                target = SelectTarget(SelectTargetMethod::Random, 0, 20.0f, true, false);
            }

            if (target)
            {
                DoCast(target, target->HasAura(SPELL_HIVEZARA_CATALYST) ? SPELL_STINGER_CHARGE_BUFFED : SPELL_STINGER_CHARGE_NORMAL, true);
            }

            context.Repeat(4500ms, 6500ms);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }
};

struct npc_obsidian_destroyer : public ScriptedAI
{
    npc_obsidian_destroyer(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        me->SetPower(POWER_MANA, 0);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(6s, [this](TaskContext context)
        {
            std::list<Unit*> targets;
            SelectTargetList(targets, 6, SelectTargetMethod::Random, 1, [&](Unit* target)
            {
                return target && target->IsPlayer() && target->GetPower(POWER_MANA) > 0;
            });

            for (Unit* target : targets)
            {
                DoCast(target, SPELL_DRAIN_MANA, true);
            }

            if (me->GetPowerPct(POWER_MANA) >= 100.f)
            {
                DoCastAOE(SPELL_PURGE, true);
            }

            context.Repeat(6s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_SUMMON_SMALL_OBSIDIAN_CHUNK, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }
};

class spell_drain_mana : public SpellScript
{
    PrepareSpellScript(spell_drain_mana);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Unit* target = GetHitUnit())
            {
                target->CastSpell(caster, SPELL_DRAIN_MANA_VISUAL, true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_drain_mana::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_ruins_of_ahnqiraj()
{
    RegisterRuinsOfAhnQirajCreatureAI(npc_hivezara_stinger);
    RegisterRuinsOfAhnQirajCreatureAI(npc_obsidian_destroyer);
    RegisterSpellScript(spell_drain_mana);
}
