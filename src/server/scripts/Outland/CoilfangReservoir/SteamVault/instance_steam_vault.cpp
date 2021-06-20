/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "steam_vault.h"

class go_main_chambers_access_panel : public GameObjectScript
{
public:
    go_main_chambers_access_panel() : GameObjectScript("go_main_chambers_access_panel") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        InstanceScript* instance = go->GetInstanceScript();
        if (!instance)
            return false;

        if (go->GetEntry() == GO_ACCESS_PANEL_HYDRO)
            if (instance->GetData(TYPE_HYDROMANCER_THESPIA) == DONE)
            {
                go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                instance->SetData(TYPE_HYDROMANCER_THESPIA, SPECIAL);
            }

        if (go->GetEntry() == GO_ACCESS_PANEL_MEK)
            if (instance->GetData(TYPE_MEKGINEER_STEAMRIGGER) == DONE)
            {
                go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                instance->SetData(TYPE_MEKGINEER_STEAMRIGGER, SPECIAL);
            }

        return true;
    }

};

class instance_steam_vault : public InstanceMapScript
{
    public:
        instance_steam_vault() : InstanceMapScript("instance_steam_vault", 545) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_steam_vault_InstanceMapScript(map);
        }

        struct instance_steam_vault_InstanceMapScript : public InstanceScript
        {
            instance_steam_vault_InstanceMapScript(Map* map) : InstanceScript(map) {}

            uint32 m_auiEncounter[MAX_ENCOUNTER];

            uint64 MekgineerGUID;
            uint64 MainChambersDoor;
            uint64 AccessPanelHydro;
            uint64 AccessPanelMek;

            void Initialize()
            {
                memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

                MekgineerGUID = 0;
                MainChambersDoor = 0;
                AccessPanelHydro = 0;
                AccessPanelMek = 0;
            }

            bool IsEncounterInProgress() const
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                     if (m_auiEncounter[i] == IN_PROGRESS)
                         return true;

                return false;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_MEKGINEER_STEAMRIGGER: MekgineerGUID = creature->GetGUID(); break;
                }
            }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_MAIN_CHAMBERS_DOOR:
                        MainChambersDoor = go->GetGUID();
                        if (GetData(TYPE_HYDROMANCER_THESPIA) == SPECIAL && GetData(TYPE_MEKGINEER_STEAMRIGGER) == SPECIAL)
                            HandleGameObject(0, true, go);
                        break;
                    case GO_ACCESS_PANEL_HYDRO:
                        AccessPanelHydro = go->GetGUID();
                        if (GetData(TYPE_HYDROMANCER_THESPIA) == DONE)
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        else if (GetData(TYPE_HYDROMANCER_THESPIA) == SPECIAL)
                            HandleGameObject(0, true, go);
                        break;
                    case GO_ACCESS_PANEL_MEK:
                        AccessPanelMek = go->GetGUID();
                        if (GetData(TYPE_MEKGINEER_STEAMRIGGER) == DONE)
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        else if (GetData(TYPE_MEKGINEER_STEAMRIGGER) == SPECIAL)
                            HandleGameObject(0, true, go);
                        break;
                }
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case TYPE_HYDROMANCER_THESPIA:
                        if (data == SPECIAL)
                        {
                            if (GetData(TYPE_MEKGINEER_STEAMRIGGER) == SPECIAL)
                                HandleGameObject(MainChambersDoor, true);
                        }
                        else if (data == DONE)
                        {
                            if (GameObject* panel = instance->GetGameObject(AccessPanelHydro))
                                panel->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        }

                        m_auiEncounter[type] = data;
                        break;
                    case TYPE_MEKGINEER_STEAMRIGGER:
                        if (data == SPECIAL)
                        {
                            if (GetData(TYPE_HYDROMANCER_THESPIA) == SPECIAL)
                                HandleGameObject(MainChambersDoor, true);
                        }
                        else if (data == DONE)
                        {
                            if (GameObject* panel = instance->GetGameObject(AccessPanelMek))
                                panel->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        }

                        m_auiEncounter[type] = data;
                        break;
                    case TYPE_WARLORD_KALITHRESH:
                        m_auiEncounter[type] = data;
                        break;
                }

                if (data == DONE || data == SPECIAL)
                    SaveToDB();
            }

            uint32 GetData(uint32 type) const
            {
                switch (type)
                {
                    case TYPE_HYDROMANCER_THESPIA:
                    case TYPE_MEKGINEER_STEAMRIGGER:
                    case TYPE_WARLORD_KALITHRESH:
                        return m_auiEncounter[type];
                }
                return 0;
            }

            uint64 GetData64(uint32 data) const
            {
                if (data == TYPE_MEKGINEER_STEAMRIGGER)
                    return MekgineerGUID;
                return 0;
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream stream;
                stream << "S V " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2];

                OUT_SAVE_INST_DATA_COMPLETE;
                return stream.str();
            }

            void Load(const char* strIn)
            {
                if (!strIn)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                char dataHead1, dataHead2;
                std::istringstream loadStream(strIn);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'S' && dataHead2 == 'V')
                    for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    {
                        loadStream >> m_auiEncounter[i];
                        if (m_auiEncounter[i] == IN_PROGRESS)
                            m_auiEncounter[i] = NOT_STARTED;
                    }

                OUT_LOAD_INST_DATA_COMPLETE;
            }
        };
};

void AddSC_instance_steam_vault()
{
    new go_main_chambers_access_panel();
    new instance_steam_vault();
}
