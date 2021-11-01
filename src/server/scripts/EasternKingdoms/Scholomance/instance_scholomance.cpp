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
#include "InstanceScript.h"
#include "Player.h"
#include "scholomance.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellScript.h"

class instance_scholomance : public InstanceMapScript
{
public:
    instance_scholomance() : InstanceMapScript(ScholomanceScriptName, 289) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_scholomance_InstanceMapScript(map);
    }

    struct instance_scholomance_InstanceMapScript : public InstanceScript
    {
        instance_scholomance_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            _miniBosses = 0;
            _kirtonosState = 0;
            _rasHuman      = 0;
        }

        void OnCreatureCreate(Creature* cr) override
        {
            switch (cr->GetEntry())
            {
                case NPC_DARKMASTER_GANDLING:
                    GandlingGUID = cr->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_GATE_KIRTONOS:
                    GateKirtonosGUID = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_DOWN_NORTH:
                    GandlingGatesGUID[0] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_DOWN_EAST:
                    GandlingGatesGUID[1] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_DOWN_SOUTH:
                    GandlingGatesGUID[2] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_UP_NORTH:
                    GandlingGatesGUID[3] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_UP_EAST:
                    GandlingGatesGUID[4] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_UP_SOUTH:
                    GandlingGatesGUID[5] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_ENTRANCE:
                    GandlingGatesGUID[6] = go->GetGUID();
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case GO_GATE_KIRTONOS:
                    return GateKirtonosGUID;
                case GO_GATE_GANDLING_DOWN_NORTH:
                    return GandlingGatesGUID[0];
                case GO_GATE_GANDLING_DOWN_EAST:
                    return GandlingGatesGUID[1];
                case GO_GATE_GANDLING_DOWN_SOUTH:
                    return GandlingGatesGUID[2];
                case GO_GATE_GANDLING_UP_NORTH:
                    return GandlingGatesGUID[3];
                case GO_GATE_GANDLING_UP_EAST:
                    return GandlingGatesGUID[4];
                case GO_GATE_GANDLING_UP_SOUTH:
                    return GandlingGatesGUID[5];
                case GO_GATE_GANDLING_ENTRANCE:
                    return GandlingGatesGUID[6];
                case NPC_DARKMASTER_GANDLING:
                    return GandlingGUID;
            }
            return ObjectGuid::Empty;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_KIRTONOS_THE_HERALD:
                    _kirtonosState = data;
                    break;
                case DATA_MINI_BOSSES:
                    ++_miniBosses;
                    if (_miniBosses == 6)
                    {
                        if (Creature* Gandling = instance->GetCreature(GandlingGUID))
                        {
                            Gandling->AI()->Talk(0);
                            Gandling->AI()->Reset();
                        }
                    }
                    break;
                case DATA_DARKMASTER_GANDLING:
                    switch (data)
                    {
                        case DONE:
                        case NOT_STARTED:
                        case FAIL:
                            HandleGameObject(GandlingGatesGUID[6], true);
                            break;
                        case IN_PROGRESS:
                            HandleGameObject(GandlingGatesGUID[6], false);
                            break;
                    }
                    break;
                case DATA_RAS_HUMAN:
                    _rasHuman = data;
                    break;
            }

            SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_KIRTONOS_THE_HERALD:
                    return _kirtonosState;
                case DATA_MINI_BOSSES:
                    return _miniBosses;
                case DATA_RAS_HUMAN:
                    return _rasHuman;
            }
            return 0;
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "S O " << _kirtonosState << ' ' << _miniBosses;
            return saveStream.str();
        }

        void Load(const char* str) override
        {
            if (!str)
                return;

            char dataHead1, dataHead2;
            std::istringstream loadStream(str);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'S' && dataHead2 == 'O')
            {
                loadStream >> _kirtonosState;
                loadStream >> _miniBosses;

                if (_kirtonosState == IN_PROGRESS)
                    _kirtonosState = NOT_STARTED;
            }
        }

    protected:
        ObjectGuid GateKirtonosGUID;
        ObjectGuid GateMiliciaGUID;
        ObjectGuid GateTheolenGUID;
        ObjectGuid GatePolkeltGUID;
        ObjectGuid GateRavenianGUID;
        ObjectGuid GateBarovGUID;
        ObjectGuid GateIlluciaGUID;

        ObjectGuid GandlingGatesGUID[7]; // 6 is the entrance
        ObjectGuid GandlingGUID; // boss

        uint32 _kirtonosState;
        uint32 _miniBosses;
        uint32 _rasHuman;
    };
};

class spell_scholomance_fixate : public SpellScriptLoader
{
public:
    spell_scholomance_fixate() : SpellScriptLoader("spell_scholomance_fixate") { }

    class spell_scholomance_fixate_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_scholomance_fixate_AuraScript);

        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (Unit* caster = GetCaster())
                caster->TauntApply(target);
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (Unit* caster = GetCaster())
                caster->TauntFadeOut(target);
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_scholomance_fixate_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_scholomance_fixate_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_scholomance_fixate_AuraScript();
    }
};

class spell_kormok_summon_bone_mages : SpellScriptLoader
{
public:
    spell_kormok_summon_bone_mages() : SpellScriptLoader("spell_kormok_summon_bone_mages") { }

    class spell_kormok_summon_bone_magesSpellScript : public SpellScript
    {
        PrepareSpellScript(spell_kormok_summon_bone_magesSpellScript);

        void HandleScript(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            for (uint8 i = 0; i < 2; ++i)
                GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_BONE_MAGE_FRONT_LEFT + urand(0, 3), true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_kormok_summon_bone_magesSpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_kormok_summon_bone_magesSpellScript();
    }
};

class spell_kormok_summon_bone_minions : SpellScriptLoader
{
public:
    spell_kormok_summon_bone_minions() : SpellScriptLoader("spell_kormok_summon_bone_minions") { }

    class spell_kormok_summon_bone_minionsSpellScript : public SpellScript
    {
        PrepareSpellScript(spell_kormok_summon_bone_minionsSpellScript);

        void HandleScript(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);

            for (uint32 i = 0; i < 4; ++i)
                GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_BONE_MINION1 + i, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_kormok_summon_bone_minionsSpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_kormok_summon_bone_minionsSpellScript();
    }
};

class spell_scholomance_boon_of_life : public SpellScriptLoader
{
public:
    spell_scholomance_boon_of_life() : SpellScriptLoader("spell_scholomance_boon_of_life") { }

    class spell_scholomance_boon_of_life_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_scholomance_boon_of_life_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* caster = GetCaster())
                if (Unit* target = GetTarget())
                    if (Creature* creature = target->ToCreature())
                    {
                        creature->AI()->AttackStart(caster);
                        creature->AddThreat(caster, 10000.0f);
                    }
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* target = GetTarget())
                if (Creature* creature = target->ToCreature())
                    if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_CANCEL)
                    {
                        creature->AI()->Talk(TALK_RAS_HUMAN);
                        creature->SetDisplayId(MODEL_RAS_HUMAN);
                        creature->SetHealth(target->GetMaxHealth());
                        if (InstanceScript* instance = creature->GetInstanceScript())
                            instance->SetData(DATA_RAS_HUMAN, 1);
                    }
        }

        void Register() override
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_scholomance_boon_of_life_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            AfterEffectApply += AuraEffectApplyFn(spell_scholomance_boon_of_life_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_scholomance_boon_of_life_AuraScript();
    }
};

enum OccultistEntries
{
    CASTER_ENTRY      = 10472,
    DARK_SHADE_ENTRY  = 11284
};

enum OccultistSpells
{
    BONE_ARMOR_SPELL         = 16431,
    COUNTER_SPELL            = 15122,
    DRAIN_MANA_SPELL         = 17243,
    SHADOWBOLT_VOLLEY_SPELL  = 17228
};

class npc_scholomance_occultist : public CreatureScript
{
public:
    npc_scholomance_occultist() : CreatureScript("npc_scholomance_occultist") { }

    struct npc_scholomance_occultistAI: public ScriptedAI
    {
        npc_scholomance_occultistAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = me->GetInstanceScript();
        }

        uint32 originalDisplayId;
        EventMap events;
        InstanceScript* instance;

        Unit* SelectUnitCasting()
        {
          ThreatContainer::StorageType threatlist = me->getThreatMgr().getThreatList();
          for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
          {
              if (Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
              {
                  if (unit->HasUnitState(UNIT_STATE_CASTING))
                  {
                      return unit;
                  }
              }
          }
          return nullptr;
        }

        void JustReachedHome() override
        {
            events.Reset();
            if (me->GetEntry() != CASTER_ENTRY)
            {
                me->UpdateEntry(CASTER_ENTRY, nullptr, false);
                me->SetDisplayId(originalDisplayId);
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            originalDisplayId = me->GetDisplayId();

            events.Reset();
            events.RescheduleEvent(1, urand(1000, 7000));
            events.RescheduleEvent(2, 400);
            events.RescheduleEvent(3, urand(6000, 15000));
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HealthBelowPct(30) && me->GetEntry() != DARK_SHADE_ENTRY)
            {
                events.Reset();
                me->InterruptNonMeleeSpells(false);
                me->UpdateEntry(DARK_SHADE_ENTRY, nullptr, false);
                events.RescheduleEvent(4, urand(2000, 10000));
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            switch(events.ExecuteEvent())
            {
                case 1:
                    me->CastSpell(me, BONE_ARMOR_SPELL, false);
                    events.RepeatEvent(60000);
                    break;
                case 2:
                    if (Unit* target = SelectUnitCasting())
                    {
                        me->CastSpell(target, COUNTER_SPELL, false);
                        events.RepeatEvent(urand(10000, 20000));
                    }
                    else
                    {
                        events.RepeatEvent(400);
                    }
                    break;
                case 3:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, PowerUsersSelector(me, POWER_MANA, 20.0f, false)))
                    {
                        me->CastSpell(target, DRAIN_MANA_SPELL, false);
                    }
                    events.RepeatEvent(urand(13000, 20000));
                    break;
                case 4:
                    me->CastSpell(me->GetVictim(), SHADOWBOLT_VOLLEY_SPELL, true);
                    events.RepeatEvent(urand(11000, 17000));
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScholomanceAI<npc_scholomance_occultistAI>(creature);
    }
};

void AddSC_instance_scholomance()
{
    new instance_scholomance();
    new spell_scholomance_fixate();
    new spell_kormok_summon_bone_mages();
    new spell_kormok_summon_bone_minions();
    new spell_scholomance_boon_of_life();
    new npc_scholomance_occultist();
}
