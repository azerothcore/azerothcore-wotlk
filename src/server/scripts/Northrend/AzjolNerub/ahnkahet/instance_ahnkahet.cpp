/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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

class instance_ahnkahet : public InstanceMapScript
{
public:
    instance_ahnkahet() : InstanceMapScript(AhnKahetScriptName, 619) { }

    struct instance_ahnkahet_InstanceScript : public InstanceScript
    {
        instance_ahnkahet_InstanceScript(Map* pMap) : InstanceScript(pMap), canSaveBossStates(false)
        {
            SetBossNumber(MAX_ENCOUNTER);
            teldaramSpheres.fill(NOT_STARTED);
        }

        void OnCreatureCreate(Creature* pCreature) override
        {
            switch (pCreature->GetEntry())
            {
                case NPC_ELDER_NADOX:
                    elderNadox_GUID = pCreature->GetGUID();
                    break;
                case NPC_PRINCE_TALDARAM:
                    princeTaldaram_GUID = pCreature->GetGUID();
                    break;
                case NPC_JEDOGA_SHADOWSEEKER:
                    jedogaShadowseeker_GUID = pCreature->GetGUID();
                    break;
                case NPC_HERALD_JOLAZJ:
                    heraldVolazj_GUID = pCreature->GetGUID();
                    break;
                case NPC_AMANITAR:
                    amanitar_GUID = pCreature->GetGUID();
                    break;
            }
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

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_TELDRAM_SPHERE1 || type == DATA_TELDRAM_SPHERE2)
            {

                teldaramSpheres[type == DATA_TELDRAM_SPHERE1 ? 0 : 1] = data;
                SaveToDB();

                if (IsAllSpheresActivated())
                {
                    HandleGameObject(taldaramPlatform_GUID, true, nullptr);

                    Creature* teldaram = instance->GetCreature(princeTaldaram_GUID);
                    if (teldaram && teldaram->IsAlive())
                    {
                        teldaram->AI()->DoAction(ACTION_REMOVE_PRISON);
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

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_ELDER_NADOX:
                    return elderNadox_GUID;
                case DATA_PRINCE_TALDARAM:
                    return princeTaldaram_GUID;
                case DATA_JEDOGA_SHADOWSEEKER:
                    return jedogaShadowseeker_GUID;
                case DATA_HERALD_VOLAZJ:
                    return heraldVolazj_GUID;
                case DATA_AMANITAR:
                    return amanitar_GUID;
            }

            return ObjectGuid::Empty;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            // Encounter states
            saveStream << "A K " << GetBossSaveData();

            // Extra data
            saveStream << teldaramSpheres[0] << ' ' << teldaramSpheres[1];

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'A' && dataHead2 == 'K')
            {
                // Encounter states
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                    {
                        tmpState = NOT_STARTED;
                    }

                    SetBossState(i, EncounterState(tmpState));
                }

                // Extra data
                loadStream >> teldaramSpheres[0] >> teldaramSpheres[1];
            }
            else
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            canSaveBossStates = true;
            OUT_LOAD_INST_DATA_COMPLETE;
        }

    private:
        ObjectGuid elderNadox_GUID;
        ObjectGuid princeTaldaram_GUID;
        ObjectGuid jedogaShadowseeker_GUID;
        ObjectGuid heraldVolazj_GUID;
        ObjectGuid amanitar_GUID;

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
