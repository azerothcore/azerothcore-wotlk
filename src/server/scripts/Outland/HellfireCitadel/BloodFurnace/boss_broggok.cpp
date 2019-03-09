/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "blood_furnace.h"

enum eEnums
{
    SAY_AGGRO               = 0,

    SPELL_SLIME_SPRAY       = 30913,
    SPELL_POISON_CLOUD      = 30916,
    SPELL_POISON_BOLT       = 30917,
    SPELL_POISON            = 30914,

    EVENT_SPELL_SLIME       = 1,
    EVENT_SPELL_POISON      = 2,
    EVENT_SPELL_BOLT        = 3
};

class boss_broggok : public CreatureScript
{
    public:

        boss_broggok() : CreatureScript("boss_broggok")
        {
        }

        struct boss_broggokAI : public ScriptedAI
        {
            boss_broggokAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = creature->GetInstanceScript();
            }

            InstanceScript* instance;
            EventMap events;
            bool canAttack;

            void Reset()
            {
                events.Reset();

                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NON_ATTACKABLE);
                canAttack = false;

                if (instance)
                    instance->SetData(DATA_BROGGOK, NOT_STARTED);
            }

            void EnterCombat(Unit* /*who*/)
            {
                Talk(SAY_AGGRO);
            }

            void JustSummoned(Creature* summoned)
            {
                summoned->setFaction(16);
                summoned->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                summoned->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                summoned->CastSpell(summoned, SPELL_POISON, false, 0, 0, me->GetGUID());
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || !canAttack)
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case EVENT_SPELL_SLIME:
                        me->CastSpell(me->GetVictim(), SPELL_SLIME_SPRAY, false);
                        events.RepeatEvent(urand(7000, 12000));
                        break;
                    case EVENT_SPELL_BOLT:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_POISON_BOLT, false);
                        events.RepeatEvent(urand(6000, 11000));
                        break;
                    case EVENT_SPELL_POISON:
                        me->CastSpell(me, SPELL_POISON_CLOUD, false);
                        events.RepeatEvent(20000);
                        break;
                    
                }

                DoMeleeAttackIfReady();
            }

            void JustDied(Unit* /*killer*/)
            {
                if (instance)
                {
                    instance->HandleGameObject(instance->GetData64(DATA_DOOR4), true);
                    instance->HandleGameObject(instance->GetData64(DATA_DOOR5), true);
                    instance->SetData(DATA_BROGGOK, DONE);
                }
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_PREPARE_BROGGOK:
                        me->SetInCombatWithZone();
                        break;
                    case ACTION_ACTIVATE_BROGGOK:
                        events.ScheduleEvent(EVENT_SPELL_SLIME, 10000);
                        events.ScheduleEvent(EVENT_SPELL_POISON, 5000);
                        events.ScheduleEvent(EVENT_SPELL_BOLT, 7000);

                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NON_ATTACKABLE);
                        canAttack = true;
                        break;
                }
            }

        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_broggokAI(creature);
        }
};

class go_broggok_lever : public GameObjectScript
{
    public:
        go_broggok_lever() : GameObjectScript("go_broggok_lever") {}

        bool OnGossipHello(Player* /*player*/, GameObject* go)
        {
            if (InstanceScript* instance = go->GetInstanceScript())
                if (instance->GetData(DATA_BROGGOK) != DONE && instance->GetData(DATA_BROGGOK) != IN_PROGRESS)
                    if (Creature* broggok = ObjectAccessor::GetCreature(*go, instance->GetData64(DATA_BROGGOK)))
                    {
                        instance->SetData(DATA_BROGGOK, IN_PROGRESS);
                        broggok->AI()->DoAction(ACTION_PREPARE_BROGGOK);
                    }

            go->UseDoorOrButton();
            return false;
        }
};

// 30914, 38462 - Poison (Broggok)
class spell_broggok_poison_cloud : public SpellScriptLoader
{
    public:
        spell_broggok_poison_cloud() : SpellScriptLoader("spell_broggok_poison_cloud") { }

        class spell_broggok_poison_cloud_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_broggok_poison_cloud_AuraScript);

            bool Validate(SpellInfo const* spellInfo)
            {
                if (!sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_0].TriggerSpell))
                    return false;
                return true;
            }

            void PeriodicTick(AuraEffect const* aurEff)
            {
                PreventDefaultAction();

                uint32 triggerSpell = GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell;
                int32 mod = int32(((float(aurEff->GetTickNumber()) / aurEff->GetTotalTicks()) * 0.9f + 0.1f) * 10000 * 2 / 3);
                GetTarget()->CastCustomSpell(triggerSpell, SPELLVALUE_RADIUS_MOD, mod, (Unit*)NULL, TRIGGERED_FULL_MASK, NULL, aurEff);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_broggok_poison_cloud_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_broggok_poison_cloud_AuraScript();
        }
};

void AddSC_boss_broggok()
{
    new boss_broggok();
    new go_broggok_lever();
    new spell_broggok_poison_cloud();
}
