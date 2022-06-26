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
#include "drak_tharon_keep.h"

DoorData const doorData[] =
{
    { GO_NOVOS_CRYSTAL_1,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM },
    { GO_NOVOS_CRYSTAL_2,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM },
    { GO_NOVOS_CRYSTAL_3,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM },
    { GO_NOVOS_CRYSTAL_4,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM },
    { 0,                    0,                      DOOR_TYPE_ROOM }
};

class instance_drak_tharon_keep : public InstanceMapScript
{
public:
    instance_drak_tharon_keep() : InstanceMapScript("instance_drak_tharon_keep", 600) { }

    struct instance_drak_tharon_keep_InstanceScript : public InstanceScript
    {
        instance_drak_tharon_keep_InstanceScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_NOVOS_CRYSTAL_1:
                case GO_NOVOS_CRYSTAL_2:
                case GO_NOVOS_CRYSTAL_3:
                case GO_NOVOS_CRYSTAL_4:
                    AddDoor(go, true);
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_NOVOS_CRYSTAL_1:
                case GO_NOVOS_CRYSTAL_2:
                case GO_NOVOS_CRYSTAL_3:
                case GO_NOVOS_CRYSTAL_4:
                    AddDoor(go, false);
                    break;
            }
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "D K " << GetBossSaveData();
            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if( !in )
                return;

            char dataHead1, dataHead2;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;
            if (dataHead1 == 'D' && dataHead2 == 'K')
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
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_drak_tharon_keep_InstanceScript(map);
    }
};

class spell_dtk_raise_dead : public SpellScriptLoader
{
public:
    spell_dtk_raise_dead() : SpellScriptLoader("spell_dtk_raise_dead") { }

    class spell_dtk_raise_dead_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_dtk_raise_dead_AuraScript)

        bool Load() override
        {
            return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
        }

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetUnitOwner()->ToCreature()->DespawnOrUnsummon(1);
            GetUnitOwner()->SummonCreature(NPC_RISEN_DRAKKARI_WARRIOR, *GetUnitOwner());
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_dtk_raise_dead_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_dtk_raise_dead_AuraScript();
    }
};

class spell_dtk_summon_random_drakkari : public SpellScriptLoader
{
public:
    spell_dtk_summon_random_drakkari() : SpellScriptLoader("spell_dtk_summon_random_drakkari") { }

    class spell_dtk_summon_random_drakkari_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_dtk_summon_random_drakkari_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            GetCaster()->CastSpell(GetCaster(), RAND(SPELL_SUMMON_DRAKKARI_SHAMAN, SPELL_SUMMON_DRAKKARI_GUARDIAN), true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_dtk_summon_random_drakkari_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_dtk_summon_random_drakkari_SpellScript();
    }
};

void AddSC_instance_drak_tharon_keep()
{
    new instance_drak_tharon_keep();
    new spell_dtk_raise_dead();
    new spell_dtk_summon_random_drakkari();
}
