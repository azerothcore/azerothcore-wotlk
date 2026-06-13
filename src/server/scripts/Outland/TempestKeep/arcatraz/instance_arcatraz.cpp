/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "arcatraz.h"

DoorData const doorData[] =
{
    { GO_CONTAINMENT_CORE_SECURITY_FIELD_ALPHA, DATA_SOCCOTHRATES,  DOOR_TYPE_PASSAGE },
    { GO_CONTAINMENT_CORE_SECURITY_FIELD_BETA,  DATA_DALLIAH,       DOOR_TYPE_PASSAGE },
    { 0,                                        0,                  DOOR_TYPE_ROOM } // END
};

ObjectData const creatureData[] =
{
    { NPC_DALLIAH,      DATA_DALLIAH          },
    { NPC_SOCCOTHRATES, DATA_SOCCOTHRATES     },
    { NPC_MELLICHAR,    DATA_WARDEN_MELLICHAR },
    { 0,                0                     }
};

class instance_arcatraz : public InstanceMapScript
{
public:
    instance_arcatraz() : InstanceMapScript("instance_arcatraz", MAP_TEMPEST_KEEP_THE_ARCATRAZ) { }

    struct instance_arcatraz_InstanceMapScript : public InstanceScript
    {
        instance_arcatraz_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUTER);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, nullptr);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_CONTAINMENT_CORE_SECURITY_FIELD_ALPHA:
                case GO_CONTAINMENT_CORE_SECURITY_FIELD_BETA:
                    AddDoor(go);
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
                    if (Creature* warden = GetCreature(DATA_WARDEN_MELLICHAR))
                        warden->AI()->SetData(type, data);
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
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

    protected:
        ObjectGuid StasisPodGUIDs[5];
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
