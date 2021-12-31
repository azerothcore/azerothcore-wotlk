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
#include "SpellAuraEffects.h"
#include "SpellScript.h"
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

        void Reset() override
        {
            events.Reset();

            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NON_ATTACKABLE);
            canAttack = false;

            if (instance)
                instance->SetData(DATA_BROGGOK, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->SetFaction(FACTION_MONSTER_2);
            summoned->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            summoned->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            summoned->CastSpell(summoned, SPELL_POISON, false, 0, 0, me->GetGUID());
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() || !canAttack)
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_SLIME:
                    me->CastSpell(me->GetVictim(), SPELL_SLIME_SPRAY, false);
                    events.RepeatEvent(urand(7000, 12000));
                    break;
                case EVENT_SPELL_BOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
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

        void JustDied(Unit* /*killer*/) override
        {
            if (instance)
            {
                instance->HandleGameObject(instance->GetGuidData(DATA_DOOR4), true);
                instance->HandleGameObject(instance->GetGuidData(DATA_DOOR5), true);
                instance->SetData(DATA_BROGGOK, DONE);
            }
        }

        void DoAction(int32 action) override
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

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBloodFurnaceAI<boss_broggokAI>(creature);
    }
};

class go_broggok_lever : public GameObjectScript
{
public:
    go_broggok_lever() : GameObjectScript("go_broggok_lever") {}

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
            if (instance->GetData(DATA_BROGGOK) != DONE && instance->GetData(DATA_BROGGOK) != IN_PROGRESS)
                if (Creature* broggok = ObjectAccessor::GetCreature(*go, instance->GetGuidData(DATA_BROGGOK)))
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

        bool Validate(SpellInfo const* spellInfo) override
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
            GetTarget()->CastCustomSpell(triggerSpell, SPELLVALUE_RADIUS_MOD, mod, (Unit*)nullptr, TRIGGERED_FULL_MASK, nullptr, aurEff);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_broggok_poison_cloud_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
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
