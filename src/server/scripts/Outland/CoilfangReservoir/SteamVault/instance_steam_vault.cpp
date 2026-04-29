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

#include "GameObjectScript.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "steam_vault.h"

enum MainChambersAccessPanelSays
{
    SAY_FAINT_ECHO  = 0,
    SAY_LOUD_RUMBLE = 1
};

MinionData const minionData[] =
{
    { NPC_NAGA_DISTILLER,          DATA_WARLORD_KALITHRESH  },
    { NPC_THESPIA_WATER_ELEMENTAL, DATA_HYDROMANCER_THESPIA },
    { 0,                            0                       }
};

class go_main_chambers_access_panel : public GameObjectScript
{
public:
    go_main_chambers_access_panel() : GameObjectScript("go_main_chambers_access_panel") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
        {
            Creature* doorController = instance->GetCreature(DATA_DOOR_CONTROLLER);
            if (go->GetEntry() == GO_ACCESS_PANEL_HYDRO)
            {
                if (instance->GetBossState(DATA_HYDROMANCER_THESPIA) == DONE)
                {
                    go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    if (doorController && doorController->IsAIEnabled)
                    {
                        doorController->AI()->Talk(SAY_FAINT_ECHO);
                    }
                }
            }
            else
            {
                if (instance->GetBossState(DATA_MEKGINEER_STEAMRIGGER) == DONE)
                {
                    go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    if (doorController && doorController->IsAIEnabled)
                    {
                        doorController->AI()->Talk(SAY_FAINT_ECHO);
                    }
                }
            }

            if (instance->GetBossState(DATA_HYDROMANCER_THESPIA) == DONE && instance->GetBossState(DATA_MEKGINEER_STEAMRIGGER) == DONE)
            {
                if (doorController)
                {
                    if (doorController->IsAIEnabled)
                    {
                        doorController->AI()->Talk(SAY_LOUD_RUMBLE);
                    }

                    doorController->m_Events.AddEventAtOffset([instance]()
                    {
                        if (GameObject* mainGate = instance->GetGameObject(DATA_MAIN_CHAMBERS_DOOR))
                        {
                            instance->HandleGameObject(ObjectGuid::Empty, true, mainGate);
                        }
                    }, 4s);
                }
                else if (GameObject* mainGate = instance->GetGameObject(DATA_MAIN_CHAMBERS_DOOR))
                {
                    instance->HandleGameObject(ObjectGuid::Empty, true, mainGate);
                }
            }

            return true;
        }

        return false;
    }
};

ObjectData const creatureData[] =
{
    { NPC_MEKGINEER_STEAMRIGGER,    DATA_MEKGINEER_STEAMRIGGER  },
    { NPC_DOOR_CONTROLLER,          DATA_DOOR_CONTROLLER        },
    { 0,                            0                           }
};

ObjectData const objectData[] =
{
    { GO_ACCESS_PANEL_HYDRO, DATA_ACCESS_PANEL_HYDROMANCER },
    { GO_ACCESS_PANEL_MEK,   DATA_ACCESS_PANEL_MEKGINEER   },
    { GO_MAIN_CHAMBERS_DOOR, DATA_MAIN_CHAMBERS_DOOR       },
    { 0,                     0,                            }
};

class instance_steam_vault : public InstanceMapScript
{
public:
    instance_steam_vault() : InstanceMapScript("instance_steam_vault", MAP_COILFANG_THE_STEAMVAULT) { }

    struct instance_steam_vault_InstanceMapScript : public InstanceScript
    {
        instance_steam_vault_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeaders);
            SetBossNumber(EncounterCount);
            LoadObjectData(creatureData, objectData);
            LoadMinionData(minionData);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_MAIN_CHAMBERS_DOOR:
                    if (GetBossState(DATA_HYDROMANCER_THESPIA) == DONE && GetBossState(DATA_MEKGINEER_STEAMRIGGER) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_ACCESS_PANEL_HYDRO:
                    if (GetBossState(DATA_HYDROMANCER_THESPIA) == DONE)
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    else if (GetBossState(DATA_HYDROMANCER_THESPIA) == SPECIAL)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_ACCESS_PANEL_MEK:
                    if (GetBossState(DATA_MEKGINEER_STEAMRIGGER) == DONE)
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    else if (GetBossState(DATA_MEKGINEER_STEAMRIGGER) == SPECIAL)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        bool SetBossState(uint32 bossId, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(bossId, state))
            {
                return false;
            }

            if (bossId == DATA_HYDROMANCER_THESPIA && state == DONE)
            {
                if (GameObject* panel = GetGameObject(DATA_ACCESS_PANEL_HYDROMANCER))
                {
                    panel->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                }
            }
            else if (bossId == DATA_MEKGINEER_STEAMRIGGER && state == DONE)
            {
                if (GameObject* panel = GetGameObject(DATA_ACCESS_PANEL_MEKGINEER))
                {
                    panel->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                }
            }

            return true;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_steam_vault_InstanceMapScript(map);
    }
};

void AddSC_instance_steam_vault()
{
    new go_main_chambers_access_panel();
    new instance_steam_vault();
}
