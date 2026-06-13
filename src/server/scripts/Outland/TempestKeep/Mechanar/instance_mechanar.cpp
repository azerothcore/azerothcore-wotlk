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
#include "mechanar.h"

static DoorData const doorData[] =
{
    { GO_DOOR_MOARG_1,          DATA_GATEWATCHER_IRON_HAND,     DOOR_TYPE_PASSAGE },
    { GO_DOOR_MOARG_2,          DATA_GATEWATCHER_GYROKILL,      DOOR_TYPE_PASSAGE },
    { GO_DOOR_NETHERMANCER,     DATA_NETHERMANCER_SEPRETHREA,   DOOR_TYPE_ROOM },
    { 0,                        0,                              DOOR_TYPE_ROOM }
};

class instance_mechanar : public InstanceMapScript
{
public:
    instance_mechanar(): InstanceMapScript("instance_mechanar", MAP_TEMPEST_KEEP_THE_MECHANAR) { }

    struct instance_mechanar_InstanceMapScript : public InstanceScript
    {
        instance_mechanar_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            SetPersistentDataCount(MAX_DATA_INDEXES);
            LoadDoorData(doorData);

        }

        void OnGameObjectCreate(GameObject* gameObject) override
        {
            switch (gameObject->GetEntry())
            {
                case GO_DOOR_MOARG_1:
                case GO_DOOR_MOARG_2:
                case GO_DOOR_NETHERMANCER:
                    AddDoor(gameObject);
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* gameObject) override
        {
            switch (gameObject->GetEntry())
            {
                case GO_DOOR_MOARG_1:
                case GO_DOOR_MOARG_2:
                case GO_DOOR_NETHERMANCER:
                    RemoveDoor(gameObject);
                    break;
                default:
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->GetEntry() == NPC_PATHALEON_THE_CALCULATOR)
                _pathaleonGUID = creature->GetGUID();
        }

    private:
        ObjectGuid _pathaleonGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_mechanar_InstanceMapScript(map);
    }
};

void AddSC_instance_mechanar()
{
    new instance_mechanar();
}
