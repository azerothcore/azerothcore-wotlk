/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
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
    SPELL_LURKER_SPAWN_TRIGGER  = 54587 // Needed for achievement
};

enum Misc
{
    EMOTE_TAKE_BREATH           = 0,
    ACTION_START_EVENT          = 1,
    MAX_SUMMONS                 = 9,

    NPC_COILFANG_GUARDIAN       = 21873,
    NPC_COILFANG_AMBUSHER       = 21865,

    EVENT_PHASE_1               = 1,
    EVENT_PHASE_2               = 2,
    EVENT_SPELL_WHIRL           = 3,
    EVENT_SPELL_SPOUT           = 4,
    EVENT_SPELL_GEYSER          = 5,
    EVENT_SPELL_SPOUT_PERIODIC  = 6
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

class boss_the_lurker_below : public CreatureScript
{
    public:
        boss_the_lurker_below() : CreatureScript("boss_the_lurker_below") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_the_lurker_belowAI>(creature);
        }

        struct boss_the_lurker_belowAI : public BossAI
        {
            boss_the_lurker_belowAI(Creature* creature) : BossAI(creature, DATA_THE_LURKER_BELOW) { }

            void Reset() override
            {
                BossAI::Reset();
                me->SetReactState(REACT_PASSIVE);
                me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                me->SetVisible(false);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

                // Reset summons
                summons.DespawnAll();
            }

            void JustSummoned(Creature* summon) override
            {
                summon->SetInCombatWithZone();
                summons.Summon(summon);
            }

            void DoAction(int32 param) override
            {
                if (param == ACTION_START_EVENT)
                {
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->setAttackTimer(BASE_ATTACK, 6000);
                    me->SetVisible(true);
                    me->UpdateObjectVisibility(true);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->SetInCombatWithZone();
                }
            }

            void JustDied(Unit* killer) override
            {
                BossAI::JustDied(killer);
            }

            void AttackStart(Unit* who) override
            {
                if (who && me->GetReactState() == REACT_AGGRESSIVE)
                    me->Attack(who, true);
            }

            void EnterCombat(Unit* /*who*/) override
            {
                events.ScheduleEvent(EVENT_SPELL_WHIRL, 18000);
                events.ScheduleEvent(EVENT_SPELL_SPOUT, 45000);
                events.ScheduleEvent(EVENT_SPELL_GEYSER, 10000);
                events.ScheduleEvent(EVENT_PHASE_2, 125000);
            }

            void UpdateAI(uint32 diff) override
            {
                if (!UpdateVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                events.Update(diff);

                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_WHIRL:
                        me->CastSpell(me, SPELL_WHIRL, false);
                        events.ScheduleEvent(EVENT_SPELL_WHIRL, 18000);
                        break;
                    case EVENT_SPELL_GEYSER:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_GEYSER, false);
                        events.ScheduleEvent(EVENT_SPELL_GEYSER, 10000);
                        break;
                    case EVENT_SPELL_SPOUT:
                        Talk(EMOTE_TAKE_BREATH);
                        me->CastSpell(me, SPELL_SPOUT_VISUAL, TRIGGERED_IGNORE_SET_FACING);
                        me->SetReactState(REACT_PASSIVE);
                        me->SetFacingToObject(me->GetVictim());
                        me->SetTarget(0);
                        events.ScheduleEvent(EVENT_SPELL_SPOUT, 60000);
                        events.RescheduleEvent(EVENT_SPELL_WHIRL, 18000);
                        events.RescheduleEvent(EVENT_SPELL_GEYSER, 25000);
                        events.ScheduleEvent(EVENT_SPELL_SPOUT_PERIODIC, 3000);
                        break;
                    case EVENT_SPELL_SPOUT_PERIODIC:
                        me->InterruptNonMeleeSpells(false);
                        me->CastSpell(me, SPELL_SPOUT_PERIODIC, true);
                        break;
                    case EVENT_PHASE_2:
                        events.Reset();
                        events.ScheduleEvent(EVENT_PHASE_1, 60000);
                        me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        for (uint8 i = 0; i < MAX_SUMMONS; ++i)
                            me->SummonCreature(i < 6 ? NPC_COILFANG_AMBUSHER : NPC_COILFANG_GUARDIAN, positions[i].GetPositionX(), positions[i].GetPositionY(), positions[i].GetPositionZ(), positions[i].GetAngle(me), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                        break;
                    case EVENT_PHASE_1:
                        me->setAttackTimer(BASE_ATTACK, 6000);
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

                        events.Reset();
                        events.ScheduleEvent(EVENT_SPELL_SPOUT, 10000);
                        events.ScheduleEvent(EVENT_PHASE_2, 120000);
                        break;
                }

                if (me->getStandState() != UNIT_STAND_STATE_STAND || !me->isAttackReady() || me->GetReactState() != REACT_AGGRESSIVE)
                    return;

                Unit* target = nullptr;
                if (me->IsWithinMeleeRange(me->GetVictim()))
                    target = me->GetVictim();
                else
                {
                    ThreatContainer::StorageType const &t_list = me->getThreatManager().getThreatList();
                    for (ThreatContainer::StorageType::const_iterator itr = t_list.begin(); itr!= t_list.end(); ++itr)
                        if (Unit* threatTarget = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
                            if (me->IsWithinMeleeRange(threatTarget))
                            {
                                target = threatTarget;
                                break;
                            }
                }

                if (target)
                    me->AttackerStateUpdate(target);
                else if ((target = SelectTarget(SELECT_TARGET_RANDOM, 0)))
                    me->CastSpell(target, SPELL_WATER_BOLT, false);

                me->resetAttackTimer();
            }
         };
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
                    if (Creature* lurker = ObjectAccessor::GetCreature(*go, instance->GetData64(NPC_THE_LURKER_BELOW)))
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
                GetUnitOwner()->SetFacingTo(Position::NormalizeOrientation(GetUnitOwner()->GetOrientation()+0.1f));
                GetUnitOwner()->CastSpell(GetUnitOwner(), aurEff->GetAmount(), true);

            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_lurker_below_spout_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_lurker_below_spout_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_lurker_below_spout_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
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

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_lurker_below_spout_cone_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_CONE_ENEMY_24);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_lurker_below_spout_cone_SpellScript();
        }
};

void AddSC_boss_the_lurker_below()
{
    new boss_the_lurker_below();
    new go_strange_pool();
    new spell_lurker_below_spout();
    new spell_lurker_below_spout_cone();
}
