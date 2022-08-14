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
#include "temple_of_ahnqiraj.h"
#include "TaskScheduler.h"

enum Spells
{
    SPELL_SHOCK_BLAST                   = 26458,
    SPELL_DRAIN_MANA                    = 25671,
    SPELL_DRAIN_MANA_VISUAL             = 26639
};

struct npc_obsidian_eradicator : public ScriptedAI
{
    npc_obsidian_eradicator(Creature* creature) : ScriptedAI(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        me->SetPower(POWER_MANA, 0);
    }

    void EnterCombat(Unit* who) override
    {
        std::list<Unit*> targets;
        SelectTargetList(targets, [&](Unit* target)
        {
            return target && target->IsPlayer() && target->GetPower(POWER_MANA) > 0;
        }, 10, SelectTargetMethod::Random);

        _scheduler.Schedule(3500ms, [this, targets](TaskContext context)
        {
            for (Unit* target : targets)
            {
                DoCast(target, SPELL_DRAIN_MANA, true);
            }

            if (me->GetPowerPct(POWER_MANA) >= 100.f)
            {
                DoCastAOE(SPELL_SHOCK_BLAST, true);
            }

            context.Repeat(3500ms);
        });
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

void AddSC_temple_of_ahnqiraj()
{
    RegisterTempleOfAhnQirajCreatureAI(npc_obsidian_eradicator);
    RegisterSpellScript(spell_drain_mana);
}
