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
#include "serpent_shrine.h"

enum Spells
{
    SPELL_WATER_BOLT            = 37138,
    SPELL_WHIRL                 = 37660,
    SPELL_GEYSER                = 37478,
    SPELL_SPOUT_VISUAL          = 37431,
    SPELL_SPOUT_PERIODIC        = 37430,
    SPELL_LURKER_SPAWN_TRIGGER  = 54587, // Needed for achievement

    SPELL_CLEAR_ALL_DEBUFFS     = 34098,
    SPELL_SUBMERGE_VISUAL       = 28819,
};

enum Misc
{
    EMOTE_TAKE_BREATH           = 0,
    ACTION_START_EVENT          = 1,
    MAX_SUMMONS                 = 9,

    NPC_COILFANG_GUARDIAN       = 21873,
    NPC_COILFANG_AMBUSHER       = 21865,
};

enum Groups
{
    GROUP_WHIRL                 = 1,
    GROUP_GEYSER                = 2
};

const Position positions[MAX_SUMMONS] =
{
    {2.8553810f, -459.823914f, -19.182686f, 0.0f},
    {12.400000f, -466.042267f, -19.182686f, 0.0f},
    {51.366653f, -460.836060f, -19.182686f, 0.0f},
    {62.597980f, -457.433044f, -19.182686f, 0.0f},
    {77.607452f, -384.302765f, -19.182686f, 0.0f},
    {63.897900f, -378.984924f, -19.182686f, 0.0f},
    {34.447250f, -387.333618f, -19.182686f, 0.0f},
    {14.388216f, -423.468018f, -19.625271f, 0.0f},
    {42.471519f, -445.115295f, -19.769423f, 0.0f}
};

struct boss_the_lurker_below : public BossAI
{
    boss_the_lurker_below(Creature* creature) : BossAI(creature, DATA_THE_LURKER_BELOW)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        me->SetReactState(REACT_PASSIVE);
        me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
        me->SetVisible(false);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_START_EVENT)
        {
            me->SetReactState(REACT_AGGRESSIVE);
            me->setAttackTimer(BASE_ATTACK, 6000);
            me->SetVisible(true);
            me->UpdateObjectVisibility(true);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->SetInCombatWithZone();
        }
    }

    void AttackStart(Unit* who) override
    {
        if (who && me->GetReactState() == REACT_AGGRESSIVE)
        {
            me->Attack(who, true);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        SchedulerPhaseOne(38800ms, 91000ms);
    }

    void SchedulerPhaseOne(std::chrono::milliseconds spoutTimer, std::chrono::milliseconds p2Timer)
    {
        scheduler.Schedule(10900ms, GROUP_GEYSER, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_GEYSER);
            context.Repeat(10200ms, 54900ms);
        }).Schedule(18150ms, GROUP_WHIRL, [this](TaskContext context)
        {
            DoCastSelf(SPELL_WHIRL);
            context.Repeat(34150ms, 68550ms);
        }).Schedule(spoutTimer, [this](TaskContext context)
        {
            Talk(EMOTE_TAKE_BREATH);
            me->CastSpell(me, SPELL_SPOUT_VISUAL, TRIGGERED_IGNORE_SET_FACING);
            me->SetReactState(REACT_PASSIVE);
            me->SetFacingToObject(me->GetVictim());
            me->SetTarget();
            scheduler.RescheduleGroup(GROUP_GEYSER, 25s);
            scheduler.RescheduleGroup(GROUP_WHIRL, 18s);
            scheduler.Schedule(3s, [this](TaskContext)
            {
                me->InterruptNonMeleeSpells(false);
                DoCastSelf(SPELL_SPOUT_PERIODIC, true);
            });
            context.Repeat(60s);
        }).Schedule(p2Timer, [this](TaskContext)
        {
            //phase2
            scheduler.CancelAll();
            DoCastSelf(SPELL_SUBMERGE_VISUAL, true);
            DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
            me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            for (uint8 i = 0; i < MAX_SUMMONS; ++i)
            {
                //needs sniffed spell probably
                me->SummonCreature(i < 6 ? NPC_COILFANG_AMBUSHER : NPC_COILFANG_GUARDIAN, positions[i].GetPositionX(), positions[i].GetPositionY(), positions[i].GetPositionZ(), positions[i].GetAngle(me), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
            }
            SchedulerPhaseTwo();
        });
    }

    void SchedulerPhaseTwo()
    {
        scheduler.Schedule(60s, [this](TaskContext)
        {
            me->setAttackTimer(BASE_ATTACK, 6000);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            scheduler.CancelAll();
            SchedulerPhaseOne(10000ms, 90750ms);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->getStandState() != UNIT_STAND_STATE_STAND || !me->isAttackReady() || me->GetReactState() != REACT_AGGRESSIVE)
            return;

        Unit* target = nullptr;
        if (me->IsWithinMeleeRange(me->GetVictim()))
        {
            target = me->GetVictim();
        }
        else
        {
            ThreatContainer::StorageType const& t_list = me->GetThreatMgr().GetThreatList();
            for (ThreatReference const* ref : t_list)
            {
                if (Unit* threatTarget = ObjectAccessor::GetUnit(*me, ref->getUnitGuid()))
                {
                    if (me->IsWithinMeleeRange(threatTarget))
                    {
                        target = threatTarget;
                        break;
                    }
                }
            }
        }
        if (target)
        {
            me->AttackerStateUpdate(target);
        }
        else if ((target = SelectTarget(SelectTargetMethod::Random, 0)))
        {
            me->CastSpell(target, SPELL_WATER_BOLT, false);
        }
        me->resetAttackTimer();
    }
};

class go_strange_pool : public GameObjectScript
{
public:
    go_strange_pool() : GameObjectScript("go_strange_pool") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
            if (roll_chance_i(instance->GetBossState(DATA_THE_LURKER_BELOW) != DONE ? 25 : 0) && !instance->IsEncounterInProgress())
            {
                player->CastSpell(player, SPELL_LURKER_SPAWN_TRIGGER, true);
                if (Creature* lurker = ObjectAccessor::GetCreature(*go, instance->GetGuidData(NPC_THE_LURKER_BELOW)))
                    lurker->AI()->DoAction(ACTION_START_EVENT);
                return true;
            }

        return false;
    }
};

class spell_lurker_below_spout : public SpellScriptLoader
{
public:
    spell_lurker_below_spout() : SpellScriptLoader("spell_lurker_below_spout") { }

    class spell_lurker_below_spout_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_lurker_below_spout_AuraScript);

        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            SetDuration(13000);
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* creature = GetUnitOwner()->ToCreature())
            {
                creature->resetAttackTimer();
                creature->SetReactState(REACT_AGGRESSIVE);
                if (Unit* target = creature->GetVictim())
                    creature->SetTarget(target->GetGUID());
            }
        }

        void OnPeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            GetUnitOwner()->SetFacingTo(Position::NormalizeOrientation(GetUnitOwner()->GetOrientation() + 0.1f));
            GetUnitOwner()->CastSpell(GetUnitOwner(), aurEff->GetAmount(), true);
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_lurker_below_spout_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_lurker_below_spout_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_lurker_below_spout_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_lurker_below_spout_AuraScript();
    }
};

class HasInLineCheck
{
public:
    HasInLineCheck(Unit* caster) : _caster(caster) { }

    bool operator()(WorldObject* unit)
    {
        return !_caster->HasInLine(unit, 5.0f) || (unit->GetTypeId() == TYPEID_UNIT && unit->ToUnit()->IsUnderWater());
    }

private:
    Unit* _caster;
};

class spell_lurker_below_spout_cone : public SpellScriptLoader
{
public:
    spell_lurker_below_spout_cone() : SpellScriptLoader("spell_lurker_below_spout_cone") { }

    class spell_lurker_below_spout_cone_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_lurker_below_spout_cone_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if(HasInLineCheck(GetCaster()));
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_lurker_below_spout_cone_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_CONE_ENEMY_24);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_lurker_below_spout_cone_SpellScript();
    }
};

void AddSC_boss_the_lurker_below()
{
    RegisterSerpentShrineAI(boss_the_lurker_below);
    new go_strange_pool();
    new spell_lurker_below_spout();
    new spell_lurker_below_spout_cone();
}
