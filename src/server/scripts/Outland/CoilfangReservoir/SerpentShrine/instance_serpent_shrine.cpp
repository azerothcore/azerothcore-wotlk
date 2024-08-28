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
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "TemporarySummon.h"
#include "serpent_shrine.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

DoorData const doorData[] =
{
    { GO_LADY_VASHJ_BRIDGE_CONSOLE, DATA_BRIDGE_EMERGED, DOOR_TYPE_PASSAGE },
    { GO_COILFANG_BRIDGE1,          DATA_BRIDGE_EMERGED, DOOR_TYPE_PASSAGE },
    { GO_COILFANG_BRIDGE2,          DATA_BRIDGE_EMERGED, DOOR_TYPE_PASSAGE },
    { GO_COILFANG_BRIDGE3,          DATA_BRIDGE_EMERGED, DOOR_TYPE_PASSAGE }
};

ObjectData const creatureData[] =
{
    { NPC_LEOTHERAS_THE_BLIND,    DATA_LEOTHERAS_THE_BLIND    },
    { NPC_FATHOM_LORD_KARATHRESS, DATA_FATHOM_LORD_KARATHRESS },
    { NPC_LADY_VASHJ,             DATA_LADY_VASHJ             },
    { NPC_SEER_OLUM,              DATA_SEER_OLUM              },
    { 0,                          0                           }
};

ObjectData const gameObjectData[] =
{
    { GO_STRANGE_POOL, DATA_STRANGE_POOL },
    { 0,               0                 }
};

MinionData const minionData[] =
{
    { NPC_FATHOM_GUARD_SHARKKIS,  DATA_FATHOM_LORD_KARATHRESS },
    { NPC_FATHOM_GUARD_TIDALVESS, DATA_FATHOM_LORD_KARATHRESS },
    { NPC_FATHOM_GUARD_CARIBDIS,  DATA_FATHOM_LORD_KARATHRESS },
    { 0,                          0,                          }
};

BossBoundaryData const boundaries =
{
    { DATA_FATHOM_LORD_KARATHRESS, new RectangleBoundary(456.86f, 571.56f, -602.07f, -449.59f) },
    { DATA_MOROGRIM_TIDEWALKER,    new RectangleBoundary(304.32f, 457.59f, -786.5f, -661.3f) },
    { DATA_LADY_VASHJ,             new CircleBoundary(Position(29.99f, -922.409f), 83.65f) }
};

class instance_serpent_shrine : public InstanceMapScript
{
public:
    instance_serpent_shrine() : InstanceMapScript("instance_serpent_shrine", 548) { }

    struct instance_serpentshrine_cavern_InstanceMapScript : public InstanceScript
    {
        instance_serpentshrine_cavern_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, gameObjectData);
            LoadMinionData(minionData);
            LoadBossBoundaries(boundaries);

            _aliveKeepersCount = 0;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (type == DATA_LADY_VASHJ)
                for (uint8 i = 0; i < 4; ++i)
                    if (GameObject* gobject = instance->GetGameObject(_shieldGeneratorGUID[i]))
                        gobject->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);

            return true;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_SHIELD_GENERATOR1:
                case GO_SHIELD_GENERATOR2:
                case GO_SHIELD_GENERATOR3:
                case GO_SHIELD_GENERATOR4:
                    _shieldGeneratorGUID[go->GetEntry() - GO_SHIELD_GENERATOR1] = go->GetGUID();
                    break;
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_COILFANG_SHATTERER:
                case NPC_COILFANG_PRIESTESS:
                    if (creature->GetPositionX() > 190.0f)
                        --_aliveKeepersCount;
                    break;
                case NPC_CYCLONE_KARATHRESS:
                    creature->GetMotionMaster()->MoveRandom(50.0f);
                    break;
                case NPC_ENCHANTED_ELEMENTAL:
                case NPC_COILFANG_ELITE:
                case NPC_COILFANG_STRIDER:
                case NPC_TAINTED_ELEMENTAL:
                    if (Creature* vashj = GetCreature(DATA_LADY_VASHJ))
                        vashj->AI()->JustSummoned(creature);
                    break;
                case NPC_SEER_OLUM:
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                    break;
                default:
                    break;
            }
            InstanceScript::OnCreatureCreate(creature);
        }

        void SetData(uint32 type, uint32  /*data*/) override
        {
            switch (type)
            {
                case DATA_PLATFORM_KEEPER_RESPAWNED:
                    if (_aliveKeepersCount < MAX_KEEPER_COUNT)
                    {
                        ++_aliveKeepersCount;
                    }
                    break;
                case DATA_PLATFORM_KEEPER_DIED:
                    if (_aliveKeepersCount > MIN_KEEPER_COUNT)
                    {
                        --_aliveKeepersCount;
                    }
                    break;
                case DATA_BRIDGE_ACTIVATED:
                    SetBossState(DATA_BRIDGE_EMERGED, NOT_STARTED);
                    SetBossState(DATA_BRIDGE_EMERGED, DONE);
                    break;
                case DATA_ACTIVATE_SHIELD:
                    if (Creature* vashj = GetCreature(DATA_LADY_VASHJ))
                    {
                        for (auto const& shieldGuid : _shieldGeneratorGUID)
                        {
                            if (GameObject* gobject = instance->GetGameObject(shieldGuid))
                            {
                                gobject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                vashj->SummonTrigger(gobject->GetPositionX(), gobject->GetPositionY(), gobject->GetPositionZ(), 0.0f, 0);
                            }
                        }
                    }
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_ALIVE_KEEPERS)
                return _aliveKeepersCount;

            return 0;
        }

    private:
        ObjectGuid _shieldGeneratorGUID[4];
        int32 _aliveKeepersCount;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_serpentshrine_cavern_InstanceMapScript(map);
    }
};

class spell_serpentshrine_cavern_serpentshrine_parasite : public AuraScript
{
    PrepareAuraScript(spell_serpentshrine_cavern_serpentshrine_parasite);

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTarget()->GetInstanceScript())
            GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SERPENTSHRINE_PARASITE, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_serpentshrine_cavern_serpentshrine_parasite::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_serpentshrine_cavern_serpentshrine_parasite_trigger_aura : public AuraScript
{
    PrepareAuraScript(spell_serpentshrine_cavern_serpentshrine_parasite_trigger_aura);

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTarget()->GetInstanceScript() && GetTarget()->GetInstanceScript()->IsEncounterInProgress())
            GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SERPENTSHRINE_PARASITE, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_serpentshrine_cavern_serpentshrine_parasite_trigger_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_serpentshrine_cavern_serpentshrine_parasite_trigger : public SpellScript
{
    PrepareSpellScript(spell_serpentshrine_cavern_serpentshrine_parasite_trigger);

    void HandleApplyAura(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Creature* target = GetHitCreature())
            target->DespawnOrUnsummon(1);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_serpentshrine_cavern_serpentshrine_parasite_trigger::HandleApplyAura, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

class spell_serpentshrine_cavern_infection : public AuraScript
{
    PrepareAuraScript(spell_serpentshrine_cavern_infection);

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
        AfterEffectRemove += AuraEffectRemoveFn(spell_serpentshrine_cavern_infection::HandleEffectRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_serpentshrine_cavern_coilfang_water : public AuraScript
{
    PrepareAuraScript(spell_serpentshrine_cavern_coilfang_water);

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
        AfterEffectApply += AuraEffectApplyFn(spell_serpentshrine_cavern_coilfang_water::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_serpentshrine_cavern_coilfang_water::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);

        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_serpentshrine_cavern_coilfang_water::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_serpentshrine_cavern_coilfang_water::HandlePeriodic, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

struct npc_rancid_mushroom : public ScriptedAI
{
    npc_rancid_mushroom(Creature* creature) : ScriptedAI(creature) { }

    enum Spells : uint32
    {
        SPELL_GROW        = 31698,
        SPELL_SPORE_CLOUD = 38652
    };

    void InitializeAI() override
    {
        scheduler.Schedule(1150ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_GROW);
            context.Repeat(1200ms, 3400ms);
        })
        .Schedule(22950ms, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_SPORE_CLOUD);
            me->KillSelf();
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

class spell_rancid_spore_cloud : public AuraScript
{
    PrepareAuraScript(spell_rancid_spore_cloud);

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        GetCaster()->CastSpell((Unit*)nullptr, GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_rancid_spore_cloud::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_instance_serpentshrine_cavern()
{
    new instance_serpent_shrine();
    RegisterSpellScript(spell_serpentshrine_cavern_serpentshrine_parasite);
    RegisterSpellAndAuraScriptPair(spell_serpentshrine_cavern_serpentshrine_parasite_trigger, spell_serpentshrine_cavern_serpentshrine_parasite_trigger_aura);
    RegisterSpellScript(spell_serpentshrine_cavern_infection);
    RegisterSpellScript(spell_serpentshrine_cavern_coilfang_water);
    RegisterSerpentShrineAI(npc_rancid_mushroom);
    RegisterSpellScript(spell_rancid_spore_cloud);
}
