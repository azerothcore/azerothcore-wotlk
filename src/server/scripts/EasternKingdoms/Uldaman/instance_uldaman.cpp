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

#include "CreatureAI.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "uldaman.h"

enum Spells
{
    SPELL_ARCHAEDAS_AWAKEN      = 10347,
    SPELL_AWAKEN_VAULT_WALKER   = 10258,
};

enum Events
{
    EVENT_SUB_BOSS_AGGRO        = 2228
};

class instance_uldaman : public InstanceMapScript
{
public:
    instance_uldaman() : InstanceMapScript("instance_uldaman", 70) { }

    struct instance_uldaman_InstanceMapScript : public InstanceScript
    {
        instance_uldaman_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            memset(&_encounters, 0, sizeof(_encounters));
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_IRONAYA_SEAL_DOOR:
                case GO_KEYSTONE:
                    if (_encounters[DATA_IRONAYA_DOORS] == DONE)
                    {
                        HandleGameObject(ObjectGuid::Empty, true, gameobject);
                        gameobject->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    }
                    break;
                case GO_TEMPLE_DOOR:
                    if (_encounters[DATA_STONE_KEEPERS] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, gameobject);
                    break;
                case GO_ANCIENT_VAULT_DOOR:
                    ancientVaultDoorGUID = gameobject->GetGUID();
                    if (_encounters[DATA_ARCHAEDAS] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, gameobject);
                    break;
                case GO_ARCHAEDAS_TEMPLE_DOOR:
                    archaedasTempleDoorGUID = gameobject->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_IRONAYA_DOORS:
                case DATA_STONE_KEEPERS:
                    _encounters[type] = data;
                    break;
                case DATA_ARCHAEDAS:
                    _encounters[type] = data;
                    HandleGameObject(ancientVaultDoorGUID, data == DONE, nullptr);
                    HandleGameObject(archaedasTempleDoorGUID, data != IN_PROGRESS, nullptr);
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 data) const override
        {
            if (data < MAX_ENCOUNTERS)
            {
                return _encounters[data];
            }
            return 0;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _encounters[DATA_IRONAYA_DOORS];
            data >> _encounters[DATA_STONE_KEEPERS];
            data >> _encounters[DATA_ARCHAEDAS];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _encounters[DATA_IRONAYA_DOORS] << ' '
                << _encounters[DATA_STONE_KEEPERS] << ' '
                << _encounters[DATA_ARCHAEDAS];
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_STONE_KEEPER:
                    if (_encounters[DATA_STONE_KEEPERS] != DONE && !creature->IsAlive())
                        creature->Respawn();
                    break;
            }
        }

    private:
        uint32 _encounters[MAX_ENCOUNTERS];
        ObjectGuid archaedasTempleDoorGUID;
        ObjectGuid ancientVaultDoorGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_uldaman_InstanceMapScript(map);
    }
};

class spell_uldaman_sub_boss_agro_keepers : public SpellScriptLoader
{
public:
    spell_uldaman_sub_boss_agro_keepers() : SpellScriptLoader("spell_uldaman_sub_boss_agro_keepers") { }

    class spell_uldaman_sub_boss_agro_keepers_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_uldaman_sub_boss_agro_keepers_SpellScript);

        void HandleSendEvent(SpellEffIndex  /*effIndex*/)
        {
            if (Creature* keeper = GetCaster()->FindNearestCreature(NPC_STONE_KEEPER, 100.0f, true))
                keeper->AI()->SetData(1, 1);
        }

        void Register() override
        {
            OnEffectLaunch += SpellEffectFn(spell_uldaman_sub_boss_agro_keepers_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_uldaman_sub_boss_agro_keepers_SpellScript();
    }
};

enum UldamanStonedEnum
{
    MAP_ULDAMAN = 70
};

class spell_uldaman_stoned : public SpellScriptLoader
{
public:
    spell_uldaman_stoned() : SpellScriptLoader("spell_uldaman_stoned") { }

    class spell_uldaman_stoned_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_uldaman_stoned_AuraScript);

        bool Load() override
        {
            return GetUnitOwner()->IsCreature() && GetUnitOwner()->GetMapId() == MAP_ULDAMAN;
        }

        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Creature* target = GetUnitOwner()->ToCreature();
            target->SetReactState(REACT_PASSIVE);
            target->SetImmuneToAll(true);
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Creature* target = GetUnitOwner()->ToCreature();
            target->SetReactState(REACT_AGGRESSIVE);
            target->SetImmuneToAll(false);
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_uldaman_stoned_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_uldaman_stoned_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_uldaman_stoned_AuraScript();
    }
};

class spell_uldaman_boss_agro_archaedas : public SpellScriptLoader
{
public:
    spell_uldaman_boss_agro_archaedas() : SpellScriptLoader("spell_uldaman_boss_agro_archaedas") { }

    class spell_uldaman_boss_agro_archaedas_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_uldaman_boss_agro_archaedas_SpellScript);

        void HandleSendEvent(SpellEffIndex  /*effIndex*/)
        {
            InstanceScript* instance = GetCaster()->GetInstanceScript();

            if (!instance || instance->GetData(DATA_ARCHAEDAS) == IN_PROGRESS || instance->GetData(DATA_ARCHAEDAS) == DONE)
                return;

            instance->SetData(DATA_ARCHAEDAS, IN_PROGRESS);
            if (Creature* archaedas = GetCaster()->FindNearestCreature(NPC_ARCHAEDAS, 100.0f, true))
                archaedas->AI()->SetData(1, 1);
        }

        void Register() override
        {
            OnEffectLaunch += SpellEffectFn(spell_uldaman_boss_agro_archaedas_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_uldaman_boss_agro_archaedas_SpellScript();
    }
};

void AddSC_instance_uldaman()
{
    new instance_uldaman();
    new spell_uldaman_sub_boss_agro_keepers();
    new spell_uldaman_stoned();
    new spell_uldaman_boss_agro_archaedas();
}
