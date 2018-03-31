/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "halls_of_lightning.h"

class instance_halls_of_lightning : public InstanceMapScript
{
public:
    instance_halls_of_lightning() : InstanceMapScript("instance_halls_of_lightning", 602) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_halls_of_lightning_InstanceMapScript(pMap);
    }

    struct instance_halls_of_lightning_InstanceMapScript : public InstanceScript
    {
        instance_halls_of_lightning_InstanceMapScript(Map* pMap) : InstanceScript(pMap) { Initialize(); };

        uint32 m_auiEncounter[MAX_ENCOUNTER];

        uint64 m_uiGeneralBjarngrimGUID;
        uint64 m_uiIonarGUID;
        uint64 m_uiLokenGUID;
        uint64 m_uiVolkhanGUID;

        uint64 m_uiBjarngrimDoorGUID;
        uint64 m_uiVolkhanDoorGUID;
        uint64 m_uiIonarDoorGUID;
        uint64 m_uiLokenDoorGUID;
        uint64 m_uiLokenGlobeGUID;

        bool volkhanAchievement;
        bool bjarngrimAchievement;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            m_uiGeneralBjarngrimGUID = 0;
            m_uiVolkhanGUID       = 0;
            m_uiIonarGUID           = 0;
            m_uiLokenGUID           = 0;

            m_uiBjarngrimDoorGUID   = 0;
            m_uiVolkhanDoorGUID   = 0;
            m_uiIonarDoorGUID       = 0;
            m_uiLokenDoorGUID       = 0;
            m_uiLokenGlobeGUID     = 0;

            volkhanAchievement = false;
            bjarngrimAchievement = false;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (m_auiEncounter[i] == IN_PROGRESS)
                    return true;
            }
            return false;
        }

        void OnCreatureCreate(Creature* pCreature)
        {
            switch(pCreature->GetEntry())
            {
                case NPC_BJARNGRIM:
                    m_uiGeneralBjarngrimGUID = pCreature->GetGUID();
                    break;
                case NPC_VOLKHAN:
                    m_uiVolkhanGUID = pCreature->GetGUID();
                    break;
                case NPC_IONAR:
                    m_uiIonarGUID = pCreature->GetGUID();
                    break;
                case NPC_LOKEN:
                    m_uiLokenGUID = pCreature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* pGo)
        {
            switch(pGo->GetEntry())
            {
                case GO_BJARNGRIM_DOOR:
                    m_uiBjarngrimDoorGUID = pGo->GetGUID();
                    if (m_auiEncounter[TYPE_BJARNGRIM] == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_VOLKHAN_DOOR:
                    m_uiVolkhanDoorGUID = pGo->GetGUID();
                    if (m_auiEncounter[TYPE_VOLKHAN] == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_IONAR_DOOR:
                    m_uiIonarDoorGUID = pGo->GetGUID();
                    if (m_auiEncounter[TYPE_IONAR] == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_LOKEN_DOOR:
                    m_uiLokenDoorGUID = pGo->GetGUID();
                    if (m_auiEncounter[TYPE_LOKEN] == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_LOKEN_THRONE:
                    m_uiLokenGlobeGUID = pGo->GetGUID();
                    break;
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                case 7321: //Shatter Resistant (2042)
                    return volkhanAchievement;
                case 6835: // Lightning Struck (1834)
                    return bjarngrimAchievement;
            }
            return false;
        }

        void SetData(uint32 uiType, uint32 uiData)
        {
            m_auiEncounter[uiType] = uiData;
            if( uiType == TYPE_LOKEN_INTRO )
                SaveToDB();

            // Achievements
            if (uiType == DATA_BJARNGRIM_ACHIEVEMENT)
                bjarngrimAchievement = (bool)uiData;
            else if (uiType == DATA_VOLKHAN_ACHIEVEMENT)
                volkhanAchievement = (bool)uiData;

            if( uiData != DONE )
                return;

            switch(uiType)
            {
                case TYPE_BJARNGRIM:
                    HandleGameObject(m_uiBjarngrimDoorGUID, true);
                    break;
                case TYPE_VOLKHAN:
                    HandleGameObject(m_uiVolkhanDoorGUID, true);
                    break;
                case TYPE_IONAR:
                    HandleGameObject(m_uiIonarDoorGUID, true);
                    break;
                case TYPE_LOKEN:
                    HandleGameObject(m_uiLokenDoorGUID, true);
                    //Appears to be type 5 GO with animation. Need to figure out how this work, code below only placeholder
                    if (GameObject* pGlobe = instance->GetGameObject(m_uiLokenGlobeGUID))
                        pGlobe->SetGoState(GO_STATE_ACTIVE);

                    break;
            }

            SaveToDB();
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "H L " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' 
                << m_auiEncounter[2] << ' ' << m_auiEncounter[3] << ' ' << m_auiEncounter[4];

            OUT_SAVE_INST_DATA_COMPLETE;
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
            uint32 data0, data1, data2, data3, data4;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3 >> data4;

            if (dataHead1 == 'H' && dataHead2 == 'L')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                m_auiEncounter[3] = data3;
                m_auiEncounter[4] = data4;

                for (uint8 i = 0; i < TYPE_LOKEN_INTRO; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;

                OUT_LOAD_INST_DATA_COMPLETE;

            }
            else
                OUT_LOAD_INST_DATA_FAIL;
        }

        uint32 GetData(uint32 uiType) const
        {
            return m_auiEncounter[uiType];
        }

        uint64 GetData64(uint32 uiData) const
        {
            switch(uiData)
            {
                case TYPE_BJARNGRIM:
                    return m_uiGeneralBjarngrimGUID;
                case TYPE_VOLKHAN:
                    return m_uiVolkhanGUID;
                case TYPE_IONAR:
                    return m_uiIonarGUID;
                case TYPE_LOKEN:
                    return m_uiLokenGUID;
            }
            return 0;
        }
    };
};

void AddSC_instance_halls_of_lightning()
{
    new instance_halls_of_lightning();
}
