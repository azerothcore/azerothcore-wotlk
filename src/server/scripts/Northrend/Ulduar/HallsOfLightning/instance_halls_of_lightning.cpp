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
#include "ScriptedCreature.h"
#include "halls_of_lightning.h"

DoorData const doorData[] =
{
    { GO_BJARNGRIM_DOOR, DATA_BJARNGRIM, DOOR_TYPE_PASSAGE },
    { GO_VOLKHAN_DOOR,   DATA_VOLKHAN,   DOOR_TYPE_PASSAGE },
    { GO_IONAR_DOOR,     DATA_IONAR,     DOOR_TYPE_PASSAGE },
    { GO_LOKEN_DOOR,     DATA_LOKEN,     DOOR_TYPE_PASSAGE },
    { 0,                        0,       DOOR_TYPE_ROOM    }
};

ObjectData const gameObjectData[] =
{
    { GO_LOKEN_THRONE, DATA_LOKEN_THRONE },
    { 0,               0                 }
};

class instance_halls_of_lightning : public InstanceMapScript
{
public:
    instance_halls_of_lightning() : InstanceMapScript("instance_halls_of_lightning", MAP_HALLS_OF_LIGHTNING) { }

    struct instance_halls_of_lightning_InstanceMapScript : public InstanceScript
    {
        instance_halls_of_lightning_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
            LoadObjectData(nullptr, gameObjectData);
            volkhanAchievement = false;
            bjarngrimAchievement = false;
        };

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case 7321: //Shatter Resistant (2042)
                    return volkhanAchievement;
                case 6835: // Lightning Struck (1834)
                    return bjarngrimAchievement;
            }
            return false;
        }

        void SetData(uint32 uiType, uint32 uiData) override
        {
            if (uiType == DATA_LOKEN_INTRO)
                SaveToDB();

            // Achievements
            if (uiType == DATA_BJARNGRIM_ACHIEVEMENT)
                bjarngrimAchievement = (bool)uiData;
            else if (uiType == DATA_VOLKHAN_ACHIEVEMENT)
                volkhanAchievement = (bool)uiData;

            if (uiData != DONE)
                return;

            SaveToDB();
        }

    private:
        bool volkhanAchievement;
        bool bjarngrimAchievement;
    };

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_halls_of_lightning_InstanceMapScript(pMap);
    }
};

void AddSC_instance_halls_of_lightning()
{
    new instance_halls_of_lightning();
}
