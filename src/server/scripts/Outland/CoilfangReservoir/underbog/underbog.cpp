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
#include "TaskScheduler.h"
#include "the_underbog.h"

class spell_fungal_decay : public AuraScript
{
    PrepareAuraScript(spell_fungal_decay);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        ModStackAmount(5);
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        ModStackAmount(-1);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_fungal_decay::OnApply, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_fungal_decay::PeriodicTick, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

enum UnderbatSpells
{
    SPELL_TENTACLE_LASH = 34171
};

struct npc_underbat : public ScriptedAI
{
    npc_underbat(Creature* c) : ScriptedAI(c) {}

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _scheduler.Schedule(2200ms, 6900ms, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [&](Unit* u)
            {
                return u->IsAlive() && !u->IsPet() && me->IsWithinCombatRange(u, 20.f) && !me->HasInArc(M_PI, u);
            }))
            {
                DoCast(target, SPELL_TENTACLE_LASH);
            }
            context.Repeat(5700ms, 9700ms);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

private:
    TaskScheduler _scheduler;
};

void AddSC_underbog()
{
    RegisterSpellScript(spell_fungal_decay);
    RegisterUnderbogCreatureAI(npc_underbat);
}
