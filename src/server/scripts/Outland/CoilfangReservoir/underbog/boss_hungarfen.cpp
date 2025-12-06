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
#include "TaskScheduler.h"
#include "the_underbog.h"

enum Spells
{
    // Hungarfen
    SPELL_SPAWN_MUSHROOMS   = 31692,
    SPELL_DESPAWN_MUSHROOMS = 34874,
    SPELL_FOUL_SPORES       = 31673,
    SPELL_ACID_GEYSER       = 38739,

    // Underbog Mushroom
    SPELL_SHRINK            = 31691,
    SPELL_GROW              = 31698,
    SPELL_SPORE_CLOUD       = 34168
};

enum Misc
{
    MAX_GROW_REPEAT         = 9,
    EMOTE_ROARS             = 0
};

struct boss_hungarfen : public BossAI
{
    boss_hungarfen(Creature* creature) : BossAI(creature, DATA_HUNGARFEN) { }

    void Reset() override
    {
        _Reset();
        _scheduler.CancelAll();
        DoCastAOE(SPELL_DESPAWN_MUSHROOMS, true);

        ScheduleHealthCheckEvent(20, [&] {
            me->AddUnitState(UNIT_STATE_ROOT);
            Talk(EMOTE_ROARS);
            DoCastSelf(SPELL_FOUL_SPORES);
            _scheduler.DelayAll(11s);
            _scheduler.Schedule(11s, [this](TaskContext /*context*/)
            {
                me->ClearUnitState(UNIT_STATE_ROOT);
            });
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        _scheduler.Schedule(IsHeroic() ? randtime(2400ms, 3600ms) : 10s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0, true))
                {
                    target->CastSpell(target, SPELL_SPAWN_MUSHROOMS, true);
                }

                context.Repeat();
            });

        if (IsHeroic())
        {
            _scheduler.Schedule(6s, [this](TaskContext context)
                {
                    DoCastAOE(SPELL_ACID_GEYSER);
                    context.Repeat(8500ms, 11s);
                });
        }
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

struct npc_underbog_mushroom : public ScriptedAI
{
    npc_underbog_mushroom(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        DoCastSelf(SPELL_SHRINK, true);

        _scheduler.Schedule(2s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_GROW, true);

                if (context.GetRepeatCounter() == MAX_GROW_REPEAT)
                {
                    DoCastSelf(SPELL_SPORE_CLOUD);

                    context.Schedule(4s, [this](TaskContext /*context*/)
                        {
                            me->RemoveAurasDueToSpell(SPELL_GROW);
                            me->DespawnOrUnsummon(2s);
                        });
                }
                else
                    context.Repeat();
            });
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

protected:
    TaskScheduler _scheduler;
};

class spell_spore_cloud : public AuraScript
{
    PrepareAuraScript(spell_spore_cloud);

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();

        if (Unit* caster = GetCaster())
        {
            if (InstanceScript* instance = caster->GetInstanceScript())
            {
                if (Creature* hungarfen = instance->GetCreature(DATA_HUNGARFEN))
                    caster->CastSpell((Unit*)nullptr, GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true, nullptr, nullptr, hungarfen->GetGUID());
            }
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_spore_cloud::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_despawn_underbog_mushrooms : public SpellScript
{
    PrepareSpellScript(spell_despawn_underbog_mushrooms);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (Creature* cTarget = target->ToCreature())
                if (cTarget->GetEntry() == NPC_UNDERBOG_MUSHROOM)
                    cTarget->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_despawn_underbog_mushrooms::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_hungarfen()
{
    RegisterUnderbogCreatureAI(boss_hungarfen);
    RegisterUnderbogCreatureAI(npc_underbog_mushroom);
    RegisterSpellScript(spell_spore_cloud);
    RegisterSpellScript(spell_despawn_underbog_mushrooms);
}
