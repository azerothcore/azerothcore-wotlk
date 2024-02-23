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

#include "CreatureGroups.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "TaskScheduler.h"
#include "temple_of_ahnqiraj.h"

ObjectData const creatureData[] =
{
    { NPC_VEM,          DATA_VEM          },
    { NPC_KRI,          DATA_KRI          },
    { NPC_YAUJ,         DATA_YAUJ         },
    { NPC_SARTURA,      DATA_SARTURA      },
    { NPC_CTHUN,        DATA_CTHUN        },
    { NPC_EYE_OF_CTHUN, DATA_EYE_OF_CTHUN },
    { NPC_OURO,         DATA_OURO         },
    { NPC_OURO_SPAWNER, DATA_OURO_SPAWNER },
    { NPC_MASTERS_EYE,  DATA_MASTERS_EYE  },
    { NPC_VEKLOR,       DATA_VEKLOR       },
    { NPC_VEKNILASH,    DATA_VEKNILASH    },
    { NPC_VISCIDUS,     DATA_VISCIDUS     },
    { 0,                0                 }
};

DoorData const doorData[] =
{
    { AQ40_DOOR_SKERAM,      DATA_SKERAM,        DOOR_TYPE_PASSAGE },
    { AQ40_DOOR_TE_ENTRANCE, DATA_TWIN_EMPERORS, DOOR_TYPE_ROOM },
    { AQ40_DOOR_TE_EXIT,     DATA_TWIN_EMPERORS, DOOR_TYPE_PASSAGE },
    { 0,                     0,                  DOOR_TYPE_ROOM}
};

class instance_temple_of_ahnqiraj : public InstanceMapScript
{
public:
    instance_temple_of_ahnqiraj() : InstanceMapScript("instance_temple_of_ahnqiraj", 531) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_temple_of_ahnqiraj_InstanceMapScript(map);
    }

    struct instance_temple_of_ahnqiraj_InstanceMapScript : public InstanceScript
    {
        instance_temple_of_ahnqiraj_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_BOSS_NUMBER);
            LoadObjectData(creatureData, nullptr);
            LoadDoorData(doorData);
        }

        void Initialize() override
        {
            BugTrioDeathCount = 0;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_OURO_SPAWNER:
                    if (GetBossState(DATA_OURO) != DONE)
                        creature->Respawn();
                    break;
                case NPC_MASTERS_EYE:
                    if (GetBossState(DATA_TWIN_EMPERORS) != DONE)
                        creature->Respawn(true);
                    break;
                case NPC_CTHUN:
                    if (!creature->IsAlive())
                    {
                        for (ObjectGuid const& guid : CThunGraspGUIDs)
                        {
                            if (GameObject* cthunGrasp = instance->GetGameObject(guid))
                            {
                                cthunGrasp->DespawnOrUnsummon(1s);
                            }
                        }
                    }
                    break;
                default:
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_CTHUN_GRASP:
                    CThunGraspGUIDs.push_back(go->GetGUID());
                    if (Creature* CThun = GetCreature(DATA_CTHUN))
                    {
                        if (!CThun->IsAlive())
                        {
                            go->DespawnOrUnsummon(1s);
                        }
                    }
                    break;
                default:
                    break;
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        void OnUnitDeath(Unit* unit) override
        {
            switch (unit->GetEntry())
            {
                case NPC_QIRAJI_SLAYER:
                case NPC_QIRAJI_MINDSLAYER:
                    if (Creature* creature = unit->ToCreature())
                    {
                        if (CreatureGroup* formation = creature->GetFormation())
                        {
                            scheduler.Schedule(100ms, [formation](TaskContext /*context*/)
                            {
                                if (!formation->IsAnyMemberAlive(true))
                                {
                                    if (Creature* leader = formation->GetLeader())
                                    {
                                        if (leader->IsAlive())
                                        {
                                            leader->AI()->SetData(0, 1);
                                        }
                                    }
                                }
                            });
                        }
                    }
                    break;
                case NPC_CTHUN:
                    for (ObjectGuid const& guid : CThunGraspGUIDs)
                    {
                        if (GameObject* cthunGrasp = instance->GetGameObject(guid))
                        {
                            cthunGrasp->DespawnOrUnsummon(1s);
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_BUG_TRIO_DEATH:
                    return BugTrioDeathCount;
            }
            return 0;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_BUG_TRIO_DEATH:
                    if (data != 0)
                        ++BugTrioDeathCount;
                    else
                        BugTrioDeathCount = 0;
                    break;
                default:
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_OURO:
                    if (state == FAIL)
                    {
                        if (Creature* ouroSpawner = GetCreature(DATA_OURO_SPAWNER))
                            ouroSpawner->Respawn();
                    }
                    break;
                default:
                    break;
            }

            return true;
        }

    private:
        GuidVector CThunGraspGUIDs;
        uint32 BugTrioDeathCount;
    };
};

void AddSC_instance_temple_of_ahnqiraj()
{
    new instance_temple_of_ahnqiraj();
}
