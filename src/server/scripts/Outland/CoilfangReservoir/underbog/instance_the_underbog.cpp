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
#include "Map.h"
#include "the_underbog.h"

ObjectData const creatureData[] =
{
    { NPC_HUNGARFEN, DATA_HUNGARFEN },
    { NPC_GHAZAN,    DATA_GHAZAN    },
    { 0,             0              }
};

class instance_the_underbog : public InstanceMapScript
{
public:
    instance_the_underbog() : InstanceMapScript(TheUnderbogScriptName, MAP_COILFANG_THE_UNDERBOG) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_the_underbog_InstanceMapScript(map);
    }

    struct instance_the_underbog_InstanceMapScript : public InstanceScript
    {
        instance_the_underbog_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetBossNumber(MAX_ENCOUNTERS);
            LoadObjectData(creatureData, nullptr);
        }
    };
};

void AddSC_instance_the_underbog()
{
    new instance_the_underbog();
}
