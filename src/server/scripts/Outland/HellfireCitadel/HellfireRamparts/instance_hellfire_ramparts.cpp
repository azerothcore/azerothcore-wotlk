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

#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "hellfire_ramparts.h"

class instance_hellfire_ramparts : public InstanceMapScript
{
public:
    instance_hellfire_ramparts() : InstanceMapScript("instance_hellfire_ramparts", 543) { }

    struct instance_hellfire_ramparts_InstanceMapScript : public InstanceScript
    {
        instance_hellfire_ramparts_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetBossNumber(MAX_ENCOUNTERS);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_FEL_IRON_CHEST_NORMAL:
                case GO_FEL_IRON_CHECT_HEROIC:
                    felIronChestGUID = go->GetGUID();
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (type == DATA_VAZRUDEN && state == DONE)
                if (GameObject* chest = instance->GetGameObject(felIronChestGUID))
                    chest->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
            return true;
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "H R " << GetBossSaveData();
            return saveStream.str();
        }

        void Load(const char* strIn) override
        {
            if (!strIn)
                return;

            char dataHead1, dataHead2;
            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'H' && dataHead2 == 'R')
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

    protected:
        ObjectGuid felIronChestGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_hellfire_ramparts_InstanceMapScript(map);
    }
};

void AddSC_instance_hellfire_ramparts()
{
    new instance_hellfire_ramparts();
}
