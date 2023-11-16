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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ahnkahet.h"
#include <array>

ObjectData const creatureData[] =
{
    { NPC_PRINCE_TALDARAM, DATA_PRINCE_TALDARAM },
    { 0,                   0                    }
};

class instance_ahnkahet : public InstanceMapScript
{
public:
    instance_ahnkahet() : InstanceMapScript(AhnKahetScriptName, 619) { }

    struct instance_ahnkahet_InstanceScript : public InstanceScript
    {
        instance_ahnkahet_InstanceScript(Map* pMap) : InstanceScript(pMap), canSaveBossStates(false)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadObjectData(creatureData, nullptr);
            teldaramSpheres.fill(NOT_STARTED);
        }

        void OnGameObjectCreate(GameObject* pGo) override
        {
            switch (pGo->GetEntry())
            {
                case GO_TELDARAM_PLATFORM:
                {
                    taldaramPlatform_GUID = pGo->GetGUID();
                    if (IsAllSpheresActivated() || GetBossState(DATA_PRINCE_TALDARAM) == DONE)
                    {
                        HandleGameObject(ObjectGuid::Empty, true, pGo);
                    }

                    break;
                }
                case GO_TELDARAM_SPHERE1:
                case GO_TELDARAM_SPHERE2:
                {
                    if (teldaramSpheres.at(pGo->GetEntry() == GO_TELDARAM_SPHERE1 ? 0 : 1) == DONE || GetBossState(DATA_PRINCE_TALDARAM) == DONE)
                    {
                        pGo->SetGoState(GO_STATE_ACTIVE);
                        pGo->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    }
                    else
                    {
                        pGo->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    }

                    break;
                }
                case GO_TELDARAM_DOOR:
                {
                    taldaramGate_GUID = pGo->GetGUID(); // Web gate past Prince Taldaram
                    if (GetBossState(DATA_PRINCE_TALDARAM) == DONE)
                    {
                        HandleGameObject(ObjectGuid::Empty, true, pGo);
                    }

                    break;
                }
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
            {
                return false;
            }

            if (type == DATA_PRINCE_TALDARAM && state == DONE)
            {
                HandleGameObject(taldaramGate_GUID, true);
            }

            if (canSaveBossStates)
            {
                SaveToDB();
            }

            return true;
        }

        void SetData(uint32 type, uint32 /*data*/) override
        {
            uint8 index = type == DATA_TELDRAM_SPHERE1 ? 0 : 1;
            if ((type == DATA_TELDRAM_SPHERE1 || type == DATA_TELDRAM_SPHERE2) && teldaramSpheres[index] != DONE)
            {
                teldaramSpheres[index] = DONE;
                SaveToDB();

                if (Creature* taldaram = GetCreature(DATA_PRINCE_TALDARAM))
                {
                    if (taldaram->IsAlive())
                    {
                        taldaram->AI()->Talk(SAY_SPHERE_ACTIVATED);

                        if (IsAllSpheresActivated())
                        {
                            HandleGameObject(taldaramPlatform_GUID, true, nullptr);
                            taldaram->AI()->DoAction(ACTION_REMOVE_PRISON);
                        }
                    }
                }
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_TELDRAM_SPHERE1:
                    return teldaramSpheres.at(0);
                case DATA_TELDRAM_SPHERE2:
                    return teldaramSpheres.at(1);
            }

            return 0;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> teldaramSpheres[0];
            data >> teldaramSpheres[1];

            canSaveBossStates = true;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << teldaramSpheres[0] << ' '
                << teldaramSpheres[1];
        }

    private:
        // Teldaram related
        ObjectGuid taldaramPlatform_GUID;
        ObjectGuid taldaramGate_GUID;
        std::array<uint32, 2> teldaramSpheres;  // Used to identify activation status for sphere activation
        bool canSaveBossStates;     // Indicates that it is safe to trigger SaveToDB call in SetBossState

        bool IsAllSpheresActivated() const
        {
            return teldaramSpheres.at(0) == DONE && teldaramSpheres.at(1) == DONE;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_ahnkahet_InstanceScript(map);
    }
};

// 56702 Shadow Sickle
// 59103 Shadow Sickle
class spell_shadow_sickle_periodic_damage : public AuraScript
{
    PrepareAuraScript(spell_shadow_sickle_periodic_damage);

    void HandlePeriodic(AuraEffect const*  /*aurEff*/)
    {
        GetCaster()->CastSpell(nullptr, SPELL_SHADOW_SICKLE);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadow_sickle_periodic_damage::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_instance_ahnkahet()
{
    new instance_ahnkahet;
    RegisterSpellScript(spell_shadow_sickle_periodic_damage);
}
