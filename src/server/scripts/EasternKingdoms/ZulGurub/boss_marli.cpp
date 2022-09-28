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

#include "GameObjectAI.h"
#include "SpellScript.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
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
    // Spider form
    SPELL_CHARGE              = 22911,
    SPELL_ENVELOPING_WEB      = 24110,
    SPELL_CORROSIVE_POISON    = 24111,
    SPELL_POISON_SHOCK        = 24112,

    //Troll form
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

enum Events
{
    // Spider form
    EVENT_CHARGE_PLAYER       = 7,
    EVENT_ENVELOPING_WEB      = 8,
    EVENT_CORROSIVE_POISON    = 9,
    EVENT_POISON_SHOCK        = 10,

    // Troll form
    EVENT_POISON_VOLLEY       = 11,
    EVENT_DRAIN_LIFE          = 12,
    EVENT_ENLARGE             = 13,

    // All
    EVENT_SPAWN_START_SPIDERS = 1,
    EVENT_TRANSFORM           = 2,
    EVENT_TRANSFORM_BACK      = 3,
    EVENT_HATCH_SPIDER_EGG    = 4,
    EVENT_THRASH              = 5,
    EVENT_TALK_FIRST_SPIDERS  = 6,
};

enum Phases
{
    PHASE_ONE                 = 1,
    PHASE_TWO                 = 2,
    PHASE_THREE               = 3
};

enum Misc
{
    GO_SPIDER_EGGS            = 179985,
};

struct boss_marli : public BossAI
{
    boss_marli(Creature* creature) : BossAI(creature, DATA_MARLI) { }

    void Reset() override
    {
        if (events.IsInPhase(PHASE_THREE))
            me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false); // hack

        std::list<GameObject*> eggs;
        me->GetGameObjectListWithEntryInGrid(eggs, GO_SPIDER_EGGS, DEFAULT_VISIBILITY_INSTANCE);

        for (auto const& egg : eggs)
        {
            egg->Respawn();
            egg->UpdateObjectVisibility();
        }

        BossAI::Reset();
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    void EnterCombat(Unit* who) override
    {
        BossAI::EnterCombat(who);
        events.ScheduleEvent(EVENT_SPAWN_START_SPIDERS, 1000, 0, PHASE_ONE);
        Talk(SAY_AGGRO);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SPAWN_START_SPIDERS:
                    events.ScheduleEvent(EVENT_TALK_FIRST_SPIDERS, 500, 0, PHASE_TWO);
                    DoCastAOE(SPELL_HATCH_EGGS);
                    events.ScheduleEvent(EVENT_TRANSFORM, 60000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_POISON_VOLLEY, 15000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_HATCH_SPIDER_EGG, 30000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_DRAIN_LIFE, 30000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_THRASH, urand(4000, 6000)); // all phases
                    events.ScheduleEvent(EVENT_ENLARGE, urand(10000, 20000), 0, PHASE_TWO);
                    events.SetPhase(PHASE_TWO);
                    break;
                case EVENT_TALK_FIRST_SPIDERS:
                    Talk(SAY_SPIDER_SPAWN);
                    break;
                case EVENT_POISON_VOLLEY:
                    DoCastVictim(SPELL_POISON_VOLLEY, true);
                    events.ScheduleEvent(EVENT_POISON_VOLLEY, urand(10000, 20000), 0, PHASE_TWO);
                    break;
                case EVENT_HATCH_SPIDER_EGG:
                    DoCastSelf(SPELL_HATCH_SPIDER_EGG, true);
                    events.ScheduleEvent(EVENT_HATCH_SPIDER_EGG, 20000, 0, PHASE_TWO);
                    break;
                case EVENT_DRAIN_LIFE:
                    DoCastRandomTarget(SPELL_DRAIN_LIFE);
                    events.ScheduleEvent(EVENT_DRAIN_LIFE, urand(20000, 50000), 0, PHASE_TWO);
                    break;
                case EVENT_ENLARGE:
                {
                    std::list<Creature*> targets = DoFindFriendlyMissingBuff(100.f, SPELL_ENLARGE);
                    if (targets.size() > 0)
                        DoCast(*(targets.begin()), SPELL_ENLARGE);
                    events.ScheduleEvent(EVENT_ENLARGE, urand(20000, 40000), 0, PHASE_TWO);
                    break;
                }
                case EVENT_TRANSFORM:
                    Talk(SAY_TRANSFORM);
                    DoCastSelf(SPELL_SPIDER_FORM, true);
                    me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, true); // hack
                    events.ScheduleEvent(EVENT_ENVELOPING_WEB, 5000, 0, PHASE_THREE);
                    events.ScheduleEvent(EVENT_CHARGE_PLAYER, 6000, 0, PHASE_THREE);
                    events.ScheduleEvent(EVENT_CORROSIVE_POISON, 1000, 0, PHASE_THREE);
                    events.ScheduleEvent(EVENT_POISON_SHOCK, urand(5000, 10000), 0, PHASE_THREE);
                    events.ScheduleEvent(EVENT_TRANSFORM_BACK, 60000, 0, PHASE_THREE);
                    events.SetPhase(PHASE_THREE);
                    break;
                case EVENT_ENVELOPING_WEB:
                    DoCastAOE(SPELL_ENVELOPING_WEB);
                    events.ScheduleEvent(EVENT_CHARGE_PLAYER, 500, 0, PHASE_THREE);
                    events.ScheduleEvent(EVENT_ENVELOPING_WEB, urand(15000, 20000), 0, PHASE_THREE);
                    break;
                case EVENT_CHARGE_PLAYER:
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
                    break;
                }
                case EVENT_CORROSIVE_POISON:
                    DoCastVictim(SPELL_CORROSIVE_POISON);
                    events.ScheduleEvent(EVENT_CORROSIVE_POISON, urand(25000, 35000), 0, PHASE_THREE);
                    break;
                case EVENT_POISON_SHOCK:
                    DoCastRandomTarget(SPELL_POISON_SHOCK);
                    events.ScheduleEvent(EVENT_POISON_SHOCK, 10000, 0, PHASE_THREE);
                    break;
                case EVENT_TRANSFORM_BACK:
                    me->RemoveAura(SPELL_SPIDER_FORM);
                    DoCastSelf(SPELL_TRANSFORM_BACK, true);
                    Talk(SAY_TRANSFORM_BACK);
                    me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false); // hack
                    events.ScheduleEvent(EVENT_TRANSFORM, 60000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_POISON_VOLLEY, 15000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_HATCH_SPIDER_EGG, 30000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_DRAIN_LIFE, 30000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_ENLARGE, urand(10000, 20000), 0, PHASE_TWO);
                    events.SetPhase(PHASE_TWO);
                    break;
                case EVENT_THRASH:
                    DoCastVictim(SPELL_THRASH);
                    events.ScheduleEvent(EVENT_THRASH, urand(10000, 20000));
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};

// Spawn of Mar'li
struct npc_spawn_of_marli : public ScriptedAI
{
    npc_spawn_of_marli(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void EnterCombat(Unit* /*who*/) override
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
        //Return since we have no target
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

// 24083 - Hatch Eggs
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

// 24110 - Enveloping Webs
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

// 24084 - Mar'li Transform
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
