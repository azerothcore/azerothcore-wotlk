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

#include "InstanceScript.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "TemporarySummon.h"
#include "serpent_shrine.h"

DoorData const doorData[] =
{
    { GO_LADY_VASHJ_BRIDGE_CONSOLE, DATA_BRIDGE_EMERGED, DOOR_TYPE_PASSAGE, BOUNDARY_NONE },
    { GO_COILFANG_BRIDGE1,          DATA_BRIDGE_EMERGED, DOOR_TYPE_PASSAGE, BOUNDARY_NONE },
    { GO_COILFANG_BRIDGE2,          DATA_BRIDGE_EMERGED, DOOR_TYPE_PASSAGE, BOUNDARY_NONE },
    { GO_COILFANG_BRIDGE3,          DATA_BRIDGE_EMERGED, DOOR_TYPE_PASSAGE, BOUNDARY_NONE }
};

class instance_serpent_shrine : public InstanceMapScript
{
public:
    instance_serpent_shrine() : InstanceMapScript("instance_serpent_shrine", 548) { }

    struct instance_serpentshrine_cavern_InstanceMapScript : public InstanceScript
    {
        instance_serpentshrine_cavern_InstanceMapScript(Map* map) : InstanceScript(map)
        {
        }

        void Initialize() override
        {
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);

            AliveKeepersCount = 0;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (type == DATA_LADY_VASHJ)
                for (uint8 i = 0; i < 4; ++i)
                    if (GameObject* gobject = instance->GetGameObject(ShieldGeneratorGUID[i]))
                        gobject->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);

            return true;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_LADY_VASHJ_BRIDGE_CONSOLE:
                case GO_COILFANG_BRIDGE1:
                case GO_COILFANG_BRIDGE2:
                case GO_COILFANG_BRIDGE3:
                    AddDoor(go, true);
                    break;
                case GO_SHIELD_GENERATOR1:
                case GO_SHIELD_GENERATOR2:
                case GO_SHIELD_GENERATOR3:
                case GO_SHIELD_GENERATOR4:
                    ShieldGeneratorGUID[go->GetEntry() - GO_SHIELD_GENERATOR1] = go->GetGUID();
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_LADY_VASHJ_BRIDGE_CONSOLE:
                case GO_COILFANG_BRIDGE1:
                case GO_COILFANG_BRIDGE2:
                case GO_COILFANG_BRIDGE3:
                    AddDoor(go, false);
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_COILFANG_SHATTERER:
                case NPC_COILFANG_PRIESTESS:
                    if (creature->GetPositionX() > -110.0f && creature->GetPositionX() < 155.0f && creature->GetPositionY() > -610.0f && creature->GetPositionY() < -280.0f)
                        AliveKeepersCount += creature->IsAlive() ? 0 : -1; // SmartAI calls JUST_RESPAWNED in AIInit...
                    break;
                case NPC_THE_LURKER_BELOW:
                    LurkerBelowGUID = creature->GetGUID();
                    break;
                case NPC_LEOTHERAS_THE_BLIND:
                    LeotherasTheBlindGUID = creature->GetGUID();
                    break;
                case NPC_CYCLONE_KARATHRESS:
                    creature->GetMotionMaster()->MoveRandom(50.0f);
                    break;
                case NPC_LADY_VASHJ:
                    LadyVashjGUID = creature->GetGUID();
                    break;
                case NPC_ENCHANTED_ELEMENTAL:
                case NPC_COILFANG_ELITE:
                case NPC_COILFANG_STRIDER:
                case NPC_TAINTED_ELEMENTAL:
                    if (Creature* vashj = instance->GetCreature(LadyVashjGUID))
                        vashj->AI()->JustSummoned(creature);
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case NPC_THE_LURKER_BELOW:
                    return LurkerBelowGUID;
                case NPC_LEOTHERAS_THE_BLIND:
                    return LeotherasTheBlindGUID;
                case NPC_LADY_VASHJ:
                    return LadyVashjGUID;
            }

            return ObjectGuid::Empty;
        }

        void SetData(uint32 type, uint32  /*data*/) override
        {
            switch (type)
            {
                case DATA_PLATFORM_KEEPER_RESPAWNED:
                    ++AliveKeepersCount;
                    break;
                case DATA_PLATFORM_KEEPER_DIED:
                    --AliveKeepersCount;
                    break;
                case DATA_BRIDGE_ACTIVATED:
                    SetBossState(DATA_BRIDGE_EMERGED, NOT_STARTED);
                    SetBossState(DATA_BRIDGE_EMERGED, DONE);
                    break;
                case DATA_ACTIVATE_SHIELD:
                    if (Creature* vashj = instance->GetCreature(LadyVashjGUID))
                        for (uint8 i = 0; i < 4; ++i)
                            if (GameObject* gobject = instance->GetGameObject(ShieldGeneratorGUID[i]))
                            {
                                gobject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                vashj->SummonTrigger(gobject->GetPositionX(), gobject->GetPositionY(), gobject->GetPositionZ(), 0.0f, 0);
                            }
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_ALIVE_KEEPERS)
                return AliveKeepersCount;

            return 0;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "S C " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(char const* str) override
        {
            if (!str)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(str);

            char dataHead1, dataHead2;

            std::istringstream loadStream(str);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'S' && dataHead2 == 'C')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;
                    SetBossState(i, EncounterState(tmpState));
                }
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    private:
        ObjectGuid LadyVashjGUID;
        ObjectGuid ShieldGeneratorGUID[4];
        ObjectGuid LurkerBelowGUID;
        ObjectGuid LeotherasTheBlindGUID;
        int32 AliveKeepersCount;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_serpentshrine_cavern_InstanceMapScript(map);
    }
};

class spell_serpentshrine_cavern_serpentshrine_parasite : public SpellScriptLoader
{
public:
    spell_serpentshrine_cavern_serpentshrine_parasite() : SpellScriptLoader("spell_serpentshrine_cavern_serpentshrine_parasite") { }

    class spell_serpentshrine_cavern_serpentshrine_parasite_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_serpentshrine_cavern_serpentshrine_parasite_AuraScript)

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTarget()->GetInstanceScript() && GetTarget()->GetInstanceScript()->IsEncounterInProgress())
                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SERPENTSHRINE_PARASITE, true);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_serpentshrine_cavern_serpentshrine_parasite_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_serpentshrine_cavern_serpentshrine_parasite_AuraScript();
    }
};

class spell_serpentshrine_cavern_serpentshrine_parasite_trigger : public SpellScriptLoader
{
public:
    spell_serpentshrine_cavern_serpentshrine_parasite_trigger() : SpellScriptLoader("spell_serpentshrine_cavern_serpentshrine_parasite_trigger") { }

    class spell_serpentshrine_cavern_serpentshrine_parasite_trigger_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_serpentshrine_cavern_serpentshrine_parasite_trigger_AuraScript)

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTarget()->GetInstanceScript() && GetTarget()->GetInstanceScript()->IsEncounterInProgress())
                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SERPENTSHRINE_PARASITE, true);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_serpentshrine_cavern_serpentshrine_parasite_trigger_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_serpentshrine_cavern_serpentshrine_parasite_trigger_AuraScript();
    }

    class spell_serpentshrine_cavern_serpentshrine_parasite_trigger_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_serpentshrine_cavern_serpentshrine_parasite_trigger_SpellScript);

        void HandleApplyAura(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Creature* target = GetHitCreature())
                target->DespawnOrUnsummon(1);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_serpentshrine_cavern_serpentshrine_parasite_trigger_SpellScript::HandleApplyAura, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_serpentshrine_cavern_serpentshrine_parasite_trigger_SpellScript();
    }
};

class spell_serpentshrine_cavern_infection : public SpellScriptLoader
{
public:
    spell_serpentshrine_cavern_infection() : SpellScriptLoader("spell_serpentshrine_cavern_infection") { }

    class spell_serpentshrine_cavern_infection_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_serpentshrine_cavern_infection_AuraScript)

        void HandleEffectRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
        {
            if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE && GetTarget()->GetInstanceScript())
            {
                CustomSpellValues values;
                values.AddSpellMod(SPELLVALUE_MAX_TARGETS, 1);
                values.AddSpellMod(SPELLVALUE_BASE_POINT0, aurEff->GetAmount() + 500);
                values.AddSpellMod(SPELLVALUE_BASE_POINT1, aurEff->GetAmount() + 500);
                GetTarget()->CastCustomSpell(SPELL_RAMPART_INFECTION, values, GetTarget(), TRIGGERED_FULL_MASK, nullptr);
            }
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_serpentshrine_cavern_infection_AuraScript::HandleEffectRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_serpentshrine_cavern_infection_AuraScript();
    }
};

class spell_serpentshrine_cavern_coilfang_water : public SpellScriptLoader
{
public:
    spell_serpentshrine_cavern_coilfang_water() : SpellScriptLoader("spell_serpentshrine_cavern_coilfang_water") { }

    class spell_serpentshrine_cavern_coilfang_water_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_serpentshrine_cavern_coilfang_water_AuraScript)

        void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (InstanceScript* instance = GetUnitOwner()->GetInstanceScript())
                if (instance->GetBossState(DATA_THE_LURKER_BELOW) != DONE)
                    if (instance->GetData(DATA_ALIVE_KEEPERS) == 0)
                        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SCALDING_WATER, true);
        }

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetUnitOwner()->RemoveAurasDueToSpell(SPELL_SCALDING_WATER);
        }

        void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
        {
            InstanceScript* instance = GetUnitOwner()->GetInstanceScript();
            if (!instance || instance->GetBossState(DATA_THE_LURKER_BELOW) == DONE)
                return;

            isPeriodic = true;
            amplitude = 8 * IN_MILLISECONDS;
        }

        void HandlePeriodic(AuraEffect const*  /*aurEff*/)
        {
            PreventDefaultAction();
            InstanceScript* instance = GetUnitOwner()->GetInstanceScript();
            if (!instance || GetUnitOwner()->GetMapId() != 548)
            {
                SetDuration(0);
                return;
            }

            if (instance->GetBossState(DATA_THE_LURKER_BELOW) == DONE || instance->GetData(DATA_ALIVE_KEEPERS) == 0 || GetUnitOwner()->GetPositionZ() > -20.5f || !GetUnitOwner()->IsInWater())
                return;

            for (uint8 i = 0; i < 3; ++i)
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_FRENZY_WATER, true);
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_serpentshrine_cavern_coilfang_water_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_serpentshrine_cavern_coilfang_water_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);

            DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_serpentshrine_cavern_coilfang_water_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_serpentshrine_cavern_coilfang_water_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_serpentshrine_cavern_coilfang_water_AuraScript();
    }
};

void AddSC_instance_serpentshrine_cavern()
{
    new instance_serpent_shrine();
    new spell_serpentshrine_cavern_serpentshrine_parasite();
    new spell_serpentshrine_cavern_serpentshrine_parasite_trigger();
    new spell_serpentshrine_cavern_infection();
    new spell_serpentshrine_cavern_coilfang_water();
}
