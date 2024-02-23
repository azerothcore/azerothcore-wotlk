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

#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "sethekk_halls.h"

DoorData const doorData[] =
{
    { GO_IKISS_DOOR, DATA_IKISS, DOOR_TYPE_PASSAGE },
    { 0,                      0, DOOR_TYPE_ROOM    }  // END
};

ObjectData const gameObjectData[] =
{
    { GO_THE_TALON_KINGS_COFFER, DATA_GO_TALON_KING_COFFER },
    { 0,                         0                         }
};

class instance_sethekk_halls : public InstanceMapScript
{
public:
    instance_sethekk_halls() : InstanceMapScript("instance_sethekk_halls", 556) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_sethekk_halls_InstanceMapScript(map);
    }

    struct instance_sethekk_halls_InstanceMapScript : public InstanceScript
    {
        instance_sethekk_halls_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeaders);
            SetBossNumber(EncounterCount);
            LoadDoorData(doorData);
            LoadObjectData(nullptr, gameObjectData);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->GetEntry() == NPC_ANZU || creature->GetEntry() == NPC_VOICE_OF_THE_RAVEN_GOD)
                if (GetBossState(DATA_ANZU) == DONE)
                    creature->DespawnOrUnsummon(1);
        }
    };
};

void AddSC_instance_sethekk_halls()
{
    new instance_sethekk_halls();
}
