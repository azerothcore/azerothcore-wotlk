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
#include "shadow_labyrinth.h"

DoorData const doorData[] =
{
    { GO_REFECTORY_DOOR,      DATA_BLACKHEARTTHEINCITEREVENT, DOOR_TYPE_PASSAGE },
    { GO_SCREAMING_HALL_DOOR, DATA_GRANDMASTER_VORPIL,        DOOR_TYPE_PASSAGE },
    { 0,                      0,                              DOOR_TYPE_ROOM    }  // END
};

ObjectData const creatureData[] =
{
    { NPC_HELLMAW, TYPE_HELLMAW },
    { 0,           0            },
};

class instance_shadow_labyrinth : public InstanceMapScript
{
public:
    instance_shadow_labyrinth() : InstanceMapScript("instance_shadow_labyrinth", 555) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_shadow_labyrinth_InstanceMapScript(map);
    }

    struct instance_shadow_labyrinth_InstanceMapScript : public InstanceScript
    {
        instance_shadow_labyrinth_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(EncounterCount);
            SetPersistentDataCount(PersistentDataCount);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, nullptr);
        }

        uint32 _ritualistsAliveCount;

        void Initialize() override
        {
            _ritualistsAliveCount = 0;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            if (creature->GetEntry() == NPC_CABAL_RITUALIST)
            {
                if (creature->IsAlive())
                {
                    ++_ritualistsAliveCount;
                }
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            InstanceScript::OnUnitDeath(unit);

            if (unit->GetEntry() == NPC_CABAL_RITUALIST)
            {
                if (!--_ritualistsAliveCount)
                {
                    StorePersistentData(TYPE_RITUALISTS, DONE);
                    if (Creature* hellmaw = GetCreature(TYPE_HELLMAW))
                    {
                        hellmaw->AI()->DoAction(1);
                    }
                }
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == TYPE_RITUALISTS)
                return GetPersistentData(TYPE_RITUALISTS);

            return 0;
        }
    };
};

void AddSC_instance_shadow_labyrinth()
{
    new instance_shadow_labyrinth();
}
