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
#include "deadmines.h"

class instance_deadmines : public InstanceMapScript
{
public:
    instance_deadmines() : InstanceMapScript("instance_deadmines", MAP_DEADMINES) { }

    struct instance_deadmines_InstanceMapScript : public InstanceScript
    {
        instance_deadmines_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        void Initialize() override
        {
            memset(&_encounters, 0, sizeof(_encounters));
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_HEAVY_DOOR_1:
                case GO_HEAVY_DOOR_2:
                case GO_DOOR_LEVER_1:
                case GO_DOOR_LEVER_2:
                case GO_DOOR_LEVER_3:
                case GO_CANNON:
                    gameobject->AllowSaveToDB(true);
                    break;
                case GO_FACTORY_DOOR:
                    gameobject->AllowSaveToDB(true);
                    // GoState (Door opened) is restored during GO creation, but we need to set LootState to prevent Lever from closing it again
                    if (_encounters[TYPE_RHAHK_ZOR] == DONE)
                        gameobject->SetLootState(GO_ACTIVATED);
                    break;
                case GO_IRON_CLAD_DOOR:
                    gameobject->AllowSaveToDB(true);
                    if (GetStoredGameObjectState(gameobject->GetSpawnId()) == GO_STATE_ACTIVE)
                    {
                        gameobject->DespawnOrUnsummon();
                    }
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_RHAHK_ZOR:
                case TYPE_CANNON:
                    _encounters[type] = data;
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "D E " << _encounters[0] << ' ' << _encounters[1];
            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if (!in)
                return;

            char dataHead1, dataHead2;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;
            if (dataHead1 == 'D' && dataHead2 == 'E')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                {
                    loadStream >> _encounters[i];
                    if (_encounters[i] == IN_PROGRESS)
                        _encounters[i] = NOT_STARTED;
                }
            }
        }

    private:
        uint32 _encounters[MAX_ENCOUNTERS];
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_deadmines_InstanceMapScript(map);
    }
};

void AddSC_instance_deadmines()
{
    new instance_deadmines();
}
