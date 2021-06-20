/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "forge_of_souls.h"
#include "Player.h"

class instance_forge_of_souls : public InstanceMapScript
{
public:
    instance_forge_of_souls() : InstanceMapScript("instance_forge_of_souls", 632) { }

    InstanceScript* GetInstanceScript(InstanceMap *map) const
    {
        return new instance_forge_of_souls_InstanceScript(map);
    }

    struct instance_forge_of_souls_InstanceScript : public InstanceScript
    {
        instance_forge_of_souls_InstanceScript(Map* map) : InstanceScript(map) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        TeamId teamIdInInstance;
        std::string str_data;
        uint64 NPC_BronjahmGUID;
        uint64 NPC_DevourerGUID;

        uint64 NPC_LeaderFirstGUID;
        uint64 NPC_LeaderSecondGUID;
        uint64 NPC_GuardFirstGUID;
        uint64 NPC_GuardSecondGUID;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            teamIdInInstance = TEAM_NEUTRAL;
            NPC_BronjahmGUID = 0;
            NPC_DevourerGUID = 0;

            NPC_LeaderFirstGUID = 0;
            NPC_LeaderSecondGUID = 0;
            NPC_GuardFirstGUID = 0;
            NPC_GuardSecondGUID = 0;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnPlayerEnter(Player* /*plr*/)
        {
            // this will happen only after crash and loading the instance from db
            if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE && (!NPC_LeaderSecondGUID || !instance->GetCreature(NPC_LeaderSecondGUID)))
            {
                Position pos = {5658.15f, 2502.564f, 708.83f, 0.885207f};
                instance->SummonCreature(NPC_SYLVANAS_PART2, pos);
            }
        }

        void OnCreatureCreate(Creature* creature)
        {
            if (teamIdInInstance == TEAM_NEUTRAL)
            {
                Map::PlayerList const &players = instance->GetPlayers();
                if (!players.isEmpty())
                    if (Player* player = players.begin()->GetSource())
                        teamIdInInstance = player->GetTeamId();
            }

            switch (creature->GetEntry())
            {
                case NPC_BRONJAHM:
                    NPC_BronjahmGUID = creature->GetGUID();
                    break;
                case NPC_DEVOURER:
                    NPC_DevourerGUID = creature->GetGUID();
                    break;
                case NPC_SYLVANAS_PART1:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART1);
                    NPC_LeaderFirstGUID = creature->GetGUID();

                    if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE)
                        creature->SetVisible(false);
                    break;
                case NPC_SYLVANAS_PART2:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART2);
                    NPC_LeaderSecondGUID = creature->GetGUID();
                    break;
                case NPC_LORALEN:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ELANDRA);
                    if (!NPC_GuardFirstGUID)
                    {
                        NPC_GuardFirstGUID = creature->GetGUID();
                        if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE)
                            creature->SetVisible(false);
                    }
                    break;
                case NPC_KALIRA:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_KORELN);
                    if (!NPC_GuardSecondGUID)
                    {
                        NPC_GuardSecondGUID = creature->GetGUID();
                        if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE)
                            creature->SetVisible(false);
                    }
                    break;
            }
        }

        void HandleOutro()
        {
            if (!NPC_LeaderSecondGUID || !instance->GetCreature(NPC_LeaderSecondGUID))
                if (Creature* leader = instance->SummonCreature(NPC_SYLVANAS_PART2, outroSpawnPoint))
                    if (Creature* boss = instance->GetCreature(NPC_DevourerGUID))
                    {
                        float angle = boss->GetAngle(leader);
                        leader->GetMotionMaster()->MovePoint(1, boss->GetPositionX()+10.0f*cos(angle), boss->GetPositionY()+10.0f*sin(angle), boss->GetPositionZ());
                    }

            for (int8 i = 0; outroPositions[i].entry[teamIdInInstance] != 0; ++i)
                if (Creature* summon = instance->SummonCreature(outroPositions[i].entry[teamIdInInstance], outroPositions[i].startPosition))
                    summon->GetMotionMaster()->MovePath(outroPositions[i].pathId, false);
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case DATA_BRONJAHM:
                    m_auiEncounter[type] = data;
                    break;
                case DATA_DEVOURER:
                    m_auiEncounter[type] = data;
                    if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE)
                        HandleOutro();
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        uint64 GetData64(uint32 type) const
        {
            switch (type)
            {
                case DATA_BRONJAHM: return NPC_BronjahmGUID;
            }

            return 0;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                case 12752: // Soul Power
                    if( Creature* c = instance->GetCreature(NPC_BronjahmGUID) )
                    {
                        std::list<Creature*> L;
                        uint8 count = 0;
                        c->GetCreaturesWithEntryInRange(L, 200.0f, 36535); // find all Corrupted Soul Fragment (36535)
                        for( std::list<Creature*>::const_iterator itr = L.begin(); itr != L.end(); ++itr )
                            if( (*itr)->IsAlive() )
                                ++count;
                        return (count >= 4);
                    }
                    break;
                case 12976:
                    if( Creature* c = instance->GetCreature(NPC_DevourerGUID) )
                        return (bool)c->AI()->GetData(1);
                    break;
            }
            return false;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "F S " << m_auiEncounter[0] << ' ' << m_auiEncounter[1];
            str_data = saveStream.str();

            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
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
            uint32 data0, data1;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1;

            if (dataHead1 == 'F' && dataHead2 == 'S')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;
            }
            else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};

void AddSC_instance_forge_of_souls()
{
    new instance_forge_of_souls();
}
