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

#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "zulgurub.h"

enum Says
{
    // Mar'li
    SAY_AGGRO               = 0,
    SAY_TRANSFORM           = 1,
    SAY_SPIDER_SPAWN        = 2,
    SAY_DEATH               = 3,
    SAY_TRANSFORM_BACK      = 4,

    // Spawn of Mar'li
    EMOTE_FULL_GROWN        = 0
};

enum Spells
{
    // Spider Form
    SPELL_CHARGE              = 22911,
    SPELL_ENVELOPING_WEB      = 24110,
    SPELL_CORROSIVE_POISON    = 24111,
    SPELL_POISON_SHOCK        = 24112,

    // Troll Form
    SPELL_POISON_VOLLEY       = 24099,
    SPELL_DRAIN_LIFE          = 24300,
    SPELL_ENLARGE             = 24109,
    SPELL_SPIDER_EGGS         = 24082,

    // All
    SPELL_SPIDER_FORM         = 24084,
    SPELL_TRANSFORM_BACK      = 24085,
    SPELL_THRASH              = 3391,
    SPELL_HATCH_SPIDER_EGG    = 24082,
    SPELL_HATCH_EGGS          = 24083,

    // Spawn of Mar'li
    SPELL_GROWTH              = 24086,
    SPELL_FULL_GROWN          = 24088
};

enum Phases
{
    PHASE_TROLL               = 1,
    PHASE_SPIDER              = 2
};

enum Misc
{
    GO_SPIDER_EGGS            = 179985,
};

// High Priestess Mar'li (14510)
struct boss_marli : public BossAI
{
public:
    boss_marli(Creature* creature) : BossAI(creature, DATA_MARLI) { }

    void Reset() override
    {
        if (_phase == PHASE_SPIDER)
        {
            me->RemoveAura(SPELL_SPIDER_FORM);
            me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false);
            _phase = PHASE_TROLL;
        }

        std::list<GameObject*> eggs;
        me->GetGameObjectListWithEntryInGrid(eggs, GO_SPIDER_EGGS, DEFAULT_VISIBILITY_INSTANCE);

        for (auto const& egg : eggs)
        {
            egg->Respawn();
            egg->UpdateObjectVisibility();
        }

        BossAI::Reset();
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        Talk(SAY_AGGRO);

        scheduler.Schedule(1s, [this](TaskContext)
        {
            DoCastAOE(SPELL_HATCH_EGGS);

            scheduler.Schedule(500ms, [this](TaskContext)
            {
                Talk(SAY_SPIDER_SPAWN);
            });

            // Both Forms
            scheduler.Schedule(4s, 6s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_THRASH);
                context.Repeat(10s, 20s);
            });

            _schedulePhaseTroll();
        });
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

private:
    Phases _phase = PHASE_TROLL;

    void _schedulePhaseTroll()
    {
        // only if switching back from spider form
        if (_phase == PHASE_SPIDER)
        {
            me->RemoveAura(SPELL_SPIDER_FORM);
            DoCastSelf(SPELL_TRANSFORM_BACK, true);
            Talk(SAY_TRANSFORM_BACK);
            me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false);

            scheduler.CancelGroup(PHASE_SPIDER);
        }

        _phase = PHASE_TROLL;

        scheduler.Schedule(15s, PHASE_TROLL, [this](TaskContext context)
        {
            DoCastVictim(SPELL_POISON_VOLLEY, true);
            context.Repeat(10s, 20s);
        }).Schedule(30s, PHASE_TROLL, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_DRAIN_LIFE);
            context.Repeat(20s, 50s);
        }).Schedule(30s, PHASE_TROLL, [this](TaskContext context)
        {
            DoCastSelf(SPELL_HATCH_SPIDER_EGG, true);
            context.Repeat(20s);
        }).Schedule(10s, 20s, PHASE_TROLL, [this](TaskContext context)
        {
            std::list<Creature*> targets = DoFindFriendlyMissingBuff(100.f, SPELL_ENLARGE);
            for (auto const& target : targets)
            {
                DoCast(target, SPELL_ENLARGE);
            }
            context.Repeat(20s, 40s);
        });

        // Transition to PHASE_SPIDER
        scheduler.Schedule(1min, PHASE_TROLL, [this](TaskContext)
        {
            _schedulePhaseSpider();
        });
    }

    void _schedulePhaseSpider()
    {
        scheduler.CancelGroup(PHASE_TROLL);
        _phase = PHASE_SPIDER;

        Talk(SAY_TRANSFORM);
        DoCastSelf(SPELL_SPIDER_FORM, true);
        me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, true);

        scheduler.Schedule(5s, PHASE_SPIDER, [this](TaskContext context)
        {
            DoCastAOE(SPELL_ENVELOPING_WEB);
            scheduler.Schedule(500ms, PHASE_SPIDER, [this](TaskContext)
            {
                _chargePlayer();
            });
            context.Repeat(15s, 20s);
        }).Schedule(1s, PHASE_SPIDER, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CORROSIVE_POISON);
            context.Repeat(25s, 35s);
        }).Schedule(5s, 10s, PHASE_SPIDER, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_POISON_SHOCK);
            context.Repeat(10s);
        });

        // Transition to PHASE_TROLL
        scheduler.Schedule(1min, PHASE_SPIDER, [this](TaskContext)
        {
            _schedulePhaseTroll();
        });
    }

    void _chargePlayer()
    {
        Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [this](Unit* target) -> bool
            {
                if (target->GetTypeId() != TYPEID_PLAYER || target->getPowerType() != Powers::POWER_MANA)
                    return false;
                if (me->IsWithinMeleeRange(target) || me->GetVictim() == target)
                    return false;
                return true;
            });
        if (target)
        {
            DoCast(target, SPELL_CHARGE);
            AttackStart(target);
        }
    }

};

// Spawn of Mar'li (15041)
struct npc_spawn_of_marli : public ScriptedAI
{
    npc_spawn_of_marli(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.Schedule(4s, [this](TaskContext context)
        {
            if (context.GetRepeatCounter() < 5)
            {
                DoCastSelf(SPELL_GROWTH);
                context.Repeat(4s);
            }
            else
            {
                Talk(EMOTE_FULL_GROWN);
                DoCastSelf(SPELL_FULL_GROWN);
            }
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
};

// Hatch Eggs (24083)
class spell_hatch_eggs : public SpellScript
{
    PrepareSpellScript(spell_hatch_eggs);

    void HandleObjectAreaTargetSelect(std::list<WorldObject*>& targets)
    {
        targets.sort(Acore::ObjectDistanceOrderPred(GetCaster()));
        targets.resize(GetSpellInfo()->MaxAffectedTargets);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hatch_eggs::HandleObjectAreaTargetSelect, EFFECT_0, TARGET_GAMEOBJECT_DEST_AREA);
    }
};

// Enveloping Webs (24110)
class spell_enveloping_webs : public SpellScript
{
    PrepareSpellScript(spell_enveloping_webs);

    void HandleOnHit()
    {
        Unit* caster = GetCaster();
        Unit* hitUnit = GetHitUnit();
        if (caster && hitUnit && hitUnit->GetTypeId() == TYPEID_PLAYER)
        {
            caster->GetThreatMgr().ModifyThreatByPercent(hitUnit, -100);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_enveloping_webs::HandleOnHit);
    }
};

// Mar'li Transform (24084)
class spell_marli_transform : public AuraScript
{
    PrepareAuraScript(spell_marli_transform);

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetCaster() && GetCaster()->ToCreature())
            GetCaster()->ToCreature()->LoadEquipment(0, true);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetCaster() && GetCaster()->ToCreature())
            GetCaster()->ToCreature()->LoadEquipment(1, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_marli_transform::HandleApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_marli_transform::HandleRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_marli()
{
    RegisterCreatureAI(boss_marli);
    RegisterCreatureAI(npc_spawn_of_marli);
    RegisterSpellScript(spell_hatch_eggs);
    RegisterSpellScript(spell_enveloping_webs);
    RegisterSpellScript(spell_marli_transform);
}
