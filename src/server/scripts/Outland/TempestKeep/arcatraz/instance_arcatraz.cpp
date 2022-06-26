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
#include "ScriptMgr.h"
#include "arcatraz.h"

DoorData const doorData[] =
{
    { GO_CONTAINMENT_CORE_SECURITY_FIELD_ALPHA, DATA_SOCCOTHRATES,  DOOR_TYPE_PASSAGE },
    { GO_CONTAINMENT_CORE_SECURITY_FIELD_BETA,  DATA_DALLIAH,       DOOR_TYPE_PASSAGE },
    { 0,                                        0,                  DOOR_TYPE_ROOM } // END
};

class instance_arcatraz : public InstanceMapScript
{
public:
    instance_arcatraz() : InstanceMapScript("instance_arcatraz", 552) { }

    struct instance_arcatraz_InstanceMapScript : public InstanceScript
    {
        instance_arcatraz_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_ENCOUTER);
            LoadDoorData(doorData);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_DALLIAH:
                    DalliahGUID = creature->GetGUID();
                    break;
                case NPC_SOCCOTHRATES:
                    SoccothratesGUID = creature->GetGUID();
                    break;
                case NPC_MELLICHAR:
                    MellicharGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_CONTAINMENT_CORE_SECURITY_FIELD_ALPHA:
                case GO_CONTAINMENT_CORE_SECURITY_FIELD_BETA:
                    AddDoor(go, true);
                    break;
                case GO_STASIS_POD_ALPHA:
                    StasisPodGUIDs[0] = go->GetGUID();
                    break;
                case GO_STASIS_POD_BETA:
                    StasisPodGUIDs[1] = go->GetGUID();
                    break;
                case GO_STASIS_POD_DELTA:
                    StasisPodGUIDs[2] = go->GetGUID();
                    break;
                case GO_STASIS_POD_GAMMA:
                    StasisPodGUIDs[3] = go->GetGUID();
                    break;
                case GO_STASIS_POD_OMEGA:
                    StasisPodGUIDs[4] = go->GetGUID();
                    break;
                case GO_WARDENS_SHIELD:
                    WardensShieldGUID = go->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_CONTAINMENT_CORE_SECURITY_FIELD_ALPHA:
                case GO_CONTAINMENT_CORE_SECURITY_FIELD_BETA:
                    AddDoor(go, false);
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_WARDEN_1:
                case DATA_WARDEN_2:
                case DATA_WARDEN_3:
                case DATA_WARDEN_4:
                case DATA_WARDEN_5:
                    if (data < FAIL)
                        HandleGameObject(StasisPodGUIDs[type - DATA_WARDEN_1], data == IN_PROGRESS);
                    if (Creature* warden = instance->GetCreature(MellicharGUID))
                        warden->AI()->SetData(type, data);
                    break;
            }
        }

        uint32 GetData(uint32  /*type*/) const override
        {
            return 0;
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                case DATA_DALLIAH:
                    return DalliahGUID;
                case DATA_SOCCOTHRATES:
                    return SoccothratesGUID;
                case DATA_WARDENS_SHIELD:
                    return WardensShieldGUID;
            }

            return ObjectGuid::Empty;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (type == DATA_WARDEN_MELLICHAR && state == NOT_STARTED)
            {
                SetData(DATA_WARDEN_1, NOT_STARTED);
                SetData(DATA_WARDEN_2, NOT_STARTED);
                SetData(DATA_WARDEN_3, NOT_STARTED);
                SetData(DATA_WARDEN_4, NOT_STARTED);
                SetData(DATA_WARDEN_5, NOT_STARTED);
                HandleGameObject(WardensShieldGUID, true);
            }

            return true;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "A Z " << GetBossSaveData();

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

            if (dataHead1 == 'A' && dataHead2 == 'Z')
            {
                for (uint32 i = 0; i < MAX_ENCOUTER; ++i)
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

    protected:
        ObjectGuid DalliahGUID;
        ObjectGuid SoccothratesGUID;
        ObjectGuid StasisPodGUIDs[5];
        ObjectGuid MellicharGUID;
        ObjectGuid WardensShieldGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_arcatraz_InstanceMapScript(map);
    }
};

void AddSC_instance_arcatraz()
{
    new instance_arcatraz();
}
