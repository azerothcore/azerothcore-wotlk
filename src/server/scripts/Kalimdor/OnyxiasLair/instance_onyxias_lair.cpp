/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "onyxias_lair.h"

class instance_onyxias_lair : public InstanceMapScript
{
public:
    instance_onyxias_lair() : InstanceMapScript("instance_onyxias_lair", 249) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_onyxias_lair_InstanceMapScript(pMap);
    }

    struct instance_onyxias_lair_InstanceMapScript : public InstanceScript
    {
        instance_onyxias_lair_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {Initialize();};

        uint64 m_uiOnyxiasGUID;
        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string str_data;
        uint16 ManyWhelpsCounter;
        std::vector<uint64> minions;
        bool bDeepBreath;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            m_uiOnyxiasGUID = 0;
            ManyWhelpsCounter = 0;
            bDeepBreath = true;
        }

        bool IsEncounterInProgress() const
        {
            for( uint8 i=0; i<MAX_ENCOUNTER; ++i )
                if( m_auiEncounter[i] == IN_PROGRESS )
                    return true;

            return false;
        }

        void OnCreatureCreate(Creature* pCreature)
        {
            switch( pCreature->GetEntry() )
            {
                case NPC_ONYXIA:
                    m_uiOnyxiasGUID = pCreature->GetGUID();
                    break;
                case NPC_ONYXIAN_WHELP:
                case NPC_ONYXIAN_LAIR_GUARD:
                    minions.push_back(pCreature->GetGUID());
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch( go->GetEntry() )
            {
                case GO_WHELP_SPAWNER:
                    go->CastSpell((Unit*)NULL, 17646);
                    if( Creature* onyxia = instance->GetCreature(m_uiOnyxiasGUID) )
                        onyxia->AI()->DoAction(-1);
                    break;
            }
        }

        void SetData(uint32 uiType, uint32 uiData)
        {
            switch(uiType)
            {
                case DATA_ONYXIA:
                    m_auiEncounter[0] = uiData;
                    ManyWhelpsCounter = 0;
                    bDeepBreath = true;
                    if( uiData == NOT_STARTED )
                    {
                        for( std::vector<uint64>::iterator itr = minions.begin(); itr != minions.end(); ++itr )
                            if( Creature* c = instance->GetCreature(*itr) )
                                c->DespawnOrUnsummon();
                        minions.clear();
                    }
                    break;
                case DATA_WHELP_SUMMONED:
                    ++ManyWhelpsCounter;
                    break;
                case DATA_DEEP_BREATH_FAILED:
                    bDeepBreath = false;
                    break;
            }

            if (uiType < MAX_ENCOUNTER && uiData == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 uiType) const
        {
            switch(uiType)
            {
                case DATA_ONYXIA:
                    return m_auiEncounter[0];
            }

            return 0;
        }

        uint64 GetData64(uint32 uiData) const
        {
            switch(uiData)
            {
                case DATA_ONYXIA:
                    return m_uiOnyxiasGUID;
            }

            return 0;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;
            std::ostringstream saveStream;
            saveStream << "O L " << m_auiEncounter[0];
            str_data = saveStream.str();
            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in)
        {
            if( !in )
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint16 data0;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0;

            if( dataHead1 == 'O' && dataHead2 == 'L' )
            {
                m_auiEncounter[0] = data0;

                for( uint8 i = 0; i < MAX_ENCOUNTER; ++i )
                    if( m_auiEncounter[i] == IN_PROGRESS )
                        m_auiEncounter[i] = NOT_STARTED;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                case ACHIEV_CRITERIA_MANY_WHELPS_10_PLAYER:
                case ACHIEV_CRITERIA_MANY_WHELPS_25_PLAYER:
                    return ManyWhelpsCounter>=50;
                case ACHIEV_CRITERIA_DEEP_BREATH_10_PLAYER:
                case ACHIEV_CRITERIA_DEEP_BREATH_25_PLAYER:
                    return bDeepBreath;
            }
            return false;
        }
    };
};

void AddSC_instance_onyxias_lair()
{
    new instance_onyxias_lair();
}