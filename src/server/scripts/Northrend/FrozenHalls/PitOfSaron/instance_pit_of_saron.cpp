/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "pit_of_saron.h"
#include "Player.h"

class instance_pit_of_saron : public InstanceMapScript
{
public:
    instance_pit_of_saron() : InstanceMapScript("instance_pit_of_saron", 658) { }

    struct instance_pit_of_saron_InstanceScript : public InstanceScript
    {
        instance_pit_of_saron_InstanceScript(Map* map) : InstanceScript(map) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        TeamId teamIdInInstance;
        uint32 InstanceProgress;
        std::string str_data;

        uint64 NPC_LeaderFirstGUID;
        uint64 NPC_LeaderSecondGUID;
        uint64 NPC_TyrannusEventGUID;
        uint64 NPC_Necrolyte1GUID;
        uint64 NPC_Necrolyte2GUID;
        uint64 NPC_GuardFirstGUID;
        uint64 NPC_GuardSecondGUID;
        uint64 NPC_SindragosaGUID;

        uint64 NPC_GarfrostGUID;
        uint64 NPC_MartinOrGorkunGUID;
        uint64 NPC_RimefangGUID;
        uint64 NPC_TyrannusGUID;

        uint64 GO_IceWallGUID;

        bool bAchievEleven;
        bool bAchievDontLookUp;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            teamIdInInstance = TEAM_NEUTRAL;
            InstanceProgress = INSTANCE_PROGRESS_NONE;

            NPC_LeaderFirstGUID = 0;
            NPC_LeaderSecondGUID = 0;
            NPC_TyrannusEventGUID = 0;
            NPC_Necrolyte1GUID = 0;
            NPC_Necrolyte2GUID = 0;
            NPC_GuardFirstGUID = 0;
            NPC_GuardSecondGUID = 0;
            NPC_SindragosaGUID = 0;

            NPC_GarfrostGUID = 0;
            NPC_MartinOrGorkunGUID = 0;
            NPC_RimefangGUID = 0;
            NPC_TyrannusGUID = 0;

            GO_IceWallGUID = 0;

            bAchievEleven = true;
            bAchievDontLookUp = true;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnPlayerEnter(Player*  /*plr*/)
        {
            instance->LoadGrid(LeaderIntroPos.GetPositionX(), LeaderIntroPos.GetPositionY());
            if (Creature* c = instance->GetCreature(GetData64(DATA_LEADER_FIRST_GUID)))
	    	c->AI()->SetData(DATA_START_INTRO, 0);
        }

        uint32 GetCreatureEntry(uint32 /*guidLow*/, CreatureData const* data)
        {
            if (teamIdInInstance == TEAM_NEUTRAL)
            {
                Map::PlayerList const &players = instance->GetPlayers();
                if (!players.isEmpty())
                    if (Player* player = players.begin()->GetSource())
                        teamIdInInstance = player->GetTeamId();
            }

            uint32 entry = data->id;
            switch (entry)
            {
                case NPC_RESCUED_ALLIANCE_SLAVE:
                    if (teamIdInInstance == TEAM_HORDE)
                        return 0;
                    break;
                case NPC_RESCUED_HORDE_SLAVE:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        return 0;
                    break;
            }

            return entry;
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
                case NPC_SYLVANAS_PART1:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART1);
                    NPC_LeaderFirstGUID = creature->GetGUID();

                    switch (InstanceProgress)
                    {
                        case INSTANCE_PROGRESS_FINISHED_INTRO:
                            creature->SetPosition(LeaderIntroPos);
                            break;
                        case INSTANCE_PROGRESS_FINISHED_KRICK_SCENE:
                        case INSTANCE_PROGRESS_AFTER_WARN_1:
                        case INSTANCE_PROGRESS_AFTER_WARN_2:
                        case INSTANCE_PROGRESS_AFTER_TUNNEL_WARN:
                        case INSTANCE_PROGRESS_TYRANNUS_INTRO:
                            creature->SetPosition(SBSLeaderEndPos);
                            break;
                    }
                    break;
                case NPC_SYLVANAS_PART2:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART2);
                    NPC_LeaderSecondGUID = creature->GetGUID();
                    break;
                case NPC_TYRANNUS_EVENT:
                    if (!NPC_TyrannusEventGUID)
                    {
                        switch (InstanceProgress)
                        {
                            case INSTANCE_PROGRESS_FINISHED_INTRO:
                                creature->SetPosition(SBSTyrannusStartPos);
                                break;
                            case INSTANCE_PROGRESS_FINISHED_KRICK_SCENE:
                                creature->SetPosition(PTSTyrannusWaitPos1);
                                break;
                            case INSTANCE_PROGRESS_AFTER_WARN_1:
                                creature->SetPosition(PTSTyrannusWaitPos2);
                                break;
                            case INSTANCE_PROGRESS_AFTER_WARN_2:
                                creature->SetPosition(PTSTyrannusWaitPos3);
                                break;
                            case INSTANCE_PROGRESS_AFTER_TUNNEL_WARN:
                            case INSTANCE_PROGRESS_TYRANNUS_INTRO:
                                creature->SetPosition(SBSTyrannusStartPos);
                                break;
                        }
                        NPC_TyrannusEventGUID = creature->GetGUID();
                        
                    }
                    break;
                case NPC_LORALEN:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ELANDRA);
                    if (!NPC_GuardFirstGUID)
                        NPC_GuardFirstGUID = creature->GetGUID();
                    break;
                case NPC_KALIRA:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_KORELN);
                    if (!NPC_GuardSecondGUID)
                        NPC_GuardSecondGUID = creature->GetGUID();
                    break;
                case NPC_HORDE_SLAVE_1:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_ALLIANCE_SLAVE_1);
                    break;
                case NPC_HORDE_SLAVE_2:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_ALLIANCE_SLAVE_2);
                    break;
                case NPC_HORDE_SLAVE_3:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_ALLIANCE_SLAVE_3);
                    break;
                case NPC_HORDE_SLAVE_4:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_ALLIANCE_SLAVE_4);
                    break;
                case NPC_GORKUN_IRONSKULL_1:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_MARTIN_VICTUS_1);
                    break;
                case NPC_GARFROST:
                    NPC_GarfrostGUID = creature->GetGUID();
                    break;
                case NPC_FREED_SLAVE_1_HORDE:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_FREED_SLAVE_1_ALLIANCE);
                    break;
                case NPC_FREED_SLAVE_2_HORDE:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_FREED_SLAVE_2_ALLIANCE);
                    break;
                case NPC_FREED_SLAVE_3_HORDE:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_FREED_SLAVE_3_ALLIANCE);
                    break;
                case NPC_GORKUN_IRONSKULL_2:
                    if (NPC_MartinOrGorkunGUID)
                        if (Creature* c = instance->GetCreature(NPC_MartinOrGorkunGUID))
                        {
                            c->AI()->DoAction(1); // despawn summons
                            c->DespawnOrUnsummon();
                        }
                    if (teamIdInInstance == TEAM_ALLIANCE)
                       creature->UpdateEntry(NPC_MARTIN_VICTUS_2);
                    NPC_MartinOrGorkunGUID = creature->GetGUID();
                    break;
                case NPC_RIMEFANG:
                    NPC_RimefangGUID = creature->GetGUID();
                    if (m_auiEncounter[2] == DONE)
                        creature->SetVisible(false);
                    break;
                case NPC_TYRANNUS:
                    if (NPC_TyrannusGUID)
                        if (Creature* c = instance->GetCreature(NPC_TyrannusGUID))
                            c->DespawnOrUnsummon();
                    NPC_TyrannusGUID = creature->GetGUID();

                    if (m_auiEncounter[2] == DONE)
                        creature->SetVisible(false);
                    break;
                case NPC_SINDRAGOSA:
                    NPC_SindragosaGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
                case GO_ICE_WALL:
                    GO_IceWallGUID = go->GetGUID();
                    if (GetData(DATA_GARFROST) == DONE && GetData(DATA_ICK) == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case DATA_INSTANCE_PROGRESS:
                    if (InstanceProgress < data)
                    {
                        InstanceProgress = data;
                        if (InstanceProgress == INSTANCE_PROGRESS_TYRANNUS_INTRO && instance->GetDifficulty() == DUNGEON_DIFFICULTY_HEROIC && bAchievDontLookUp) // achiev Don't Look Up (4525)
                            DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 72845);
                    }
                    break;
                case DATA_GARFROST:
                    m_auiEncounter[0] = data;
                    if (data == DONE)
                        instance->SummonCreature(NPC_GORKUN_IRONSKULL_1, FBSSpawnPos);
                    else // NOT_STARTED, IN_PROGRESS
                        bAchievEleven = true;
                    if (data == DONE && GetData(DATA_ICK) == DONE)
                        if (GameObject* icewall = instance->GetGameObject(GO_IceWallGUID))
                            icewall->SetGoState(GO_STATE_ACTIVE);
                    break;
                case DATA_ICK:
                    m_auiEncounter[1] = data;
                    if (data == DONE && GetData(DATA_GARFROST) == DONE)
                        if (GameObject* icewall = instance->GetGameObject(GO_IceWallGUID))
                            icewall->SetGoState(GO_STATE_ACTIVE);
                    break;
                case DATA_TYRANNUS:
                    m_auiEncounter[2] = data;
                    if (data == DONE)
                        instance->SummonCreature(NPC_SYLVANAS_PART2, TSLeaderSpawnPos);
                    break;
                case DATA_ACHIEV_ELEVEN:
                    bAchievEleven = false;
                    break;
                case DATA_ACHIEV_DONT_LOOK_UP:
                    bAchievDontLookUp = false;
                    break;
            }

            if (data == DONE || type == DATA_INSTANCE_PROGRESS)
                SaveToDB();
        }

        void SetData64(uint32 type, uint64 data)
        {
            switch(type)
            {
                case DATA_NECROLYTE_1_GUID:
                    NPC_Necrolyte1GUID = data;
                    break;
                case DATA_NECROLYTE_2_GUID:
                    NPC_Necrolyte2GUID = data;
                    break;
                case DATA_MARTIN_OR_GORKUN_GUID:
                    NPC_MartinOrGorkunGUID = data;
                    break;
            }
        }

        uint32 GetData(uint32 type) const
        {
            switch (type)
            {
                case DATA_INSTANCE_PROGRESS:
                    return InstanceProgress;
                case DATA_TEAMID_IN_INSTANCE:
                    return teamIdInInstance;
                case DATA_GARFROST:
                    return m_auiEncounter[0];
                case DATA_ICK:
                    return m_auiEncounter[1];
                case DATA_TYRANNUS:
                    return m_auiEncounter[2];
            }

            return 0;
        }

        uint64 GetData64(uint32 type) const
        {
            switch (type)
            {
                case DATA_TYRANNUS_EVENT_GUID:
                    return NPC_TyrannusEventGUID;
                case DATA_NECROLYTE_1_GUID:
                    return NPC_Necrolyte1GUID;
                case DATA_NECROLYTE_2_GUID:
                    return NPC_Necrolyte2GUID;
                case DATA_GUARD_1_GUID:
                    return NPC_GuardFirstGUID;
                case DATA_GUARD_2_GUID:
                    return NPC_GuardSecondGUID;
                case DATA_LEADER_FIRST_GUID:
                    return NPC_LeaderFirstGUID;
                case DATA_GARFROST_GUID:
                    return NPC_GarfrostGUID;
                case DATA_MARTIN_OR_GORKUN_GUID:
                    return NPC_MartinOrGorkunGUID;
                case DATA_RIMEFANG_GUID:
                    return NPC_RimefangGUID;
                case DATA_TYRANNUS_GUID:
                    return NPC_TyrannusGUID;
                case DATA_LEADER_SECOND_GUID:
                    return NPC_LeaderSecondGUID;
                case DATA_SINDRAGOSA_GUID:
                    return NPC_SindragosaGUID;
            }

            return 0;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                case 12993: // Doesn't Go to Eleven (4524)
                    return bAchievEleven;
            }
            return false;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "P S " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' ' << InstanceProgress;
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
            uint32 data0, data1, data2, data3;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3;

            if (dataHead1 == 'P' && dataHead2 == 'S')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                InstanceProgress = data3;

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;
            }
            else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_pit_of_saron_InstanceScript(map);
    }
};

void AddSC_instance_pit_of_saron()
{
    new instance_pit_of_saron();
}
