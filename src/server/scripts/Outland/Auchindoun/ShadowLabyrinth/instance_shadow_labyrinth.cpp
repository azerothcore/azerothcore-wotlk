/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "shadow_labyrinth.h"

class instance_shadow_labyrinth : public InstanceMapScript
{
public:
    instance_shadow_labyrinth() : InstanceMapScript("instance_shadow_labyrinth", 555) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_shadow_labyrinth_InstanceMapScript(map);
    }

    struct instance_shadow_labyrinth_InstanceMapScript : public InstanceScript
    {
        instance_shadow_labyrinth_InstanceMapScript(Map* map) : InstanceScript(map) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];

        uint64 m_uiHellmawGUID;
        uint64 m_uiRefectoryDoorGUID;
        uint64 m_uiScreamingHallDoorGUID;

        uint32 m_uiFelOverseerCount;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            m_uiHellmawGUID = 0;
            m_uiRefectoryDoorGUID = 0;
            m_uiScreamingHallDoorGUID = 0;

            m_uiFelOverseerCount = 0;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)
                    return true;

            return false;
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
                case REFECTORY_DOOR:
                    m_uiRefectoryDoorGUID = go->GetGUID();
                    if (m_auiEncounter[DATA_BLACKHEARTTHEINCITEREVENT] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case SCREAMING_HALL_DOOR:
                    m_uiScreamingHallDoorGUID = go->GetGUID();
                    if (m_auiEncounter[DATA_GRANDMASTERVORPILEVENT] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case NPC_FEL_OVERSEER:
                    if (creature->IsAlive())
                        ++m_uiFelOverseerCount;
                    break;
                case NPC_HELLMAW:
                    m_uiHellmawGUID = creature->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 uiData)
        {
            switch (type)
            {
                case TYPE_OVERSEER:
                    if (!--m_uiFelOverseerCount)
                    {
                        m_auiEncounter[type] = DONE;
                        if (Creature* cr = instance->GetCreature(m_uiHellmawGUID))
                            cr->AI()->DoAction(1);
                    }
                    break;
                
                case DATA_BLACKHEARTTHEINCITEREVENT:
                    if (uiData == DONE)
                        DoUseDoorOrButton(m_uiRefectoryDoorGUID);
                    m_auiEncounter[type] = uiData;
                    break;

                case DATA_GRANDMASTERVORPILEVENT:
                    if (uiData == DONE)
                        DoUseDoorOrButton(m_uiScreamingHallDoorGUID);
                    m_auiEncounter[type] = uiData;
                    break;

                case DATA_MURMUREVENT:
                case TYPE_HELLMAW:
                    m_auiEncounter[type] = uiData;
                    break;
            }

            if (uiData == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 type) const
        {
            if (type == TYPE_OVERSEER)
                return m_auiEncounter[0];
            return 0;
        }

        std::string GetSaveData()
        {
            std::ostringstream saveStream;
            saveStream << "S L " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' '
                    << m_auiEncounter[2] << ' ' << m_auiEncounter[3] << ' ' << m_auiEncounter[4];

            return saveStream.str();
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;
            if (dataHead1 == 'S' && dataHead2 == 'L')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    loadStream >> m_auiEncounter[i];
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;
                }
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };

};

void AddSC_instance_shadow_labyrinth()
{
    new instance_shadow_labyrinth();
}
