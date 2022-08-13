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
#include "ruins_of_ahnqiraj.h"
#include "TaskScheduler.h"

enum Spells
{
    SPELL_PURGE                         = 25756,
    SPELL_DRAIN_MANA                    = 25755,
    SPELL_DRAIN_MANA_VISUAL             = 26639,
    SPELL_SUMMON_SMALL_OBSIDIAN_CHUNK   = 27627 // Server-side
};

struct npc_obsidian_destroyer : public ScriptedAI
{
    npc_obsidian_destroyer(Creature* creature) : ScriptedAI(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        me->SetPower(POWER_MANA, 0);
    }

    void EnterCombat(Unit* who) override
    {
        _scheduler.Schedule(5s, 9s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_PURGE, true);
            context.Repeat(8s, 11s);
        })
        .Schedule(6s, 10s, [this](TaskContext context)
        {
            std::list<Unit*> targets;
            SelectTargetList(targets, [&](Unit* target)
            {
                return target && target->IsPlayer() && target->GetPower(POWER_MANA) > 0;
            }, 6, SelectTargetMethod::Random);

            for (Unit* target : targets)
            {
                DoCast(target, SPELL_DRAIN_MANA, true);
            }

            context.Repeat(10s, 16s);
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

        _scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    TaskScheduler _scheduler;
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
    RegisterRuinsOfAhnQirajCreatureAI(npc_obsidian_destroyer);
    RegisterSpellScript(spell_drain_mana);
}
