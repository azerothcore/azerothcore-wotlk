/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "trial_of_the_champion.h"
#include "Vehicle.h"
#include "Player.h"
#include "Group.h"

const Position SpawnPosition = {746.67f, 684.08f, 412.5f, 4.65f};
#define CLEANUP_CHECK_INTERVAL  5000

class Group;

class instance_trial_of_the_champion : public InstanceMapScript
{
public:
    instance_trial_of_the_champion() : InstanceMapScript("instance_trial_of_the_champion", 650) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_trial_of_the_champion_InstanceMapScript(pMap);
    }

    struct instance_trial_of_the_champion_InstanceMapScript : public InstanceScript
    {
        instance_trial_of_the_champion_InstanceMapScript(Map* pMap) : InstanceScript(pMap) { Initialize(); }

        bool CLEANED;
        TeamId TeamIdInInstance;
        uint32 InstanceProgress;
        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string str_data;

        std::list<uint64> VehicleList;
        EventMap events;
        uint8 Counter;
        uint8 temp1, temp2;
        bool shortver;
        bool bAchievIveHadWorse;

        uint64 NPC_AnnouncerGUID;
        uint64 NPC_TirionGUID;
        uint64 NPC_GrandChampionGUID[3];
        uint64 NPC_GrandChampionMinionsGUID[3][3];
        uint64 NPC_ArgentChampionGUID;
        uint64 NPC_ArgentSoldierGUID[3][3];
        uint64 NPC_MemoryEntry;
        uint64 NPC_BlackKnightVehicleGUID;
        uint64 NPC_BlackKnightGUID;
        uint64 GO_MainGateGUID;
        uint64 GO_EnterGateGUID;

        void Initialize()
        {
            TeamIdInInstance = TEAM_NEUTRAL;
            InstanceProgress = 0;
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            VehicleList.clear();
            CLEANED = false;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0);
            Counter = 0;
            temp1 = 0;
            temp2 = 0;
            shortver = false;
            bAchievIveHadWorse = true;

            NPC_AnnouncerGUID = 0;
            NPC_TirionGUID = 0;
            memset(&NPC_GrandChampionGUID, 0, sizeof(NPC_GrandChampionGUID));
            memset(&NPC_GrandChampionMinionsGUID, 0, sizeof(NPC_GrandChampionMinionsGUID));
            memset(&NPC_ArgentSoldierGUID, 0, sizeof(NPC_ArgentSoldierGUID));
            NPC_ArgentChampionGUID = 0;
            NPC_MemoryEntry = 0;
            NPC_BlackKnightVehicleGUID = 0;
            NPC_BlackKnightGUID = 0;
            GO_MainGateGUID = 0;
            GO_EnterGateGUID = 0;
        }

        bool IsEncounterInProgress() const
        {
            for( uint8 i = 0; i < MAX_ENCOUNTER; ++i )
                if( m_auiEncounter[i] == IN_PROGRESS )
                    return true;

            return false;
        }

        void OnCreatureCreate(Creature* creature)
        {
            if (TeamIdInInstance == TEAM_NEUTRAL)
            {
                Map::PlayerList const &players = instance->GetPlayers();
                if( !players.isEmpty() )
                    if( Player* pPlayer = players.begin()->GetSource() )
                        TeamIdInInstance = pPlayer->GetTeamId();
            }

            switch( creature->GetEntry() )
            {
                // Grand Champions:
                case NPC_MOKRA:
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_JACOB);
                    break;
                case NPC_ERESSEA:
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_AMBROSE);
                    break;
                case NPC_RUNOK:
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_COLOSOS);
                    break;
                case NPC_ZULTORE:
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_JAELYNE);
                    break;
                case NPC_VISCERI:
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_LANA);
                    break;

                // Grand Champion Minions:
                case NPC_ORGRIMMAR_MINION: 
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_STORMWIND_MINION);
                    break;
                case NPC_SILVERMOON_MINION: 
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_GNOMEREGAN_MINION);
                    break;
                case NPC_THUNDER_BLUFF_MINION: 
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_EXODAR_MINION);
                    break;
                case NPC_SENJIN_MINION: 
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_DARNASSUS_MINION);
                    break;
                case NPC_UNDERCITY_MINION: 
                    if( TeamIdInInstance == TEAM_HORDE )
                        creature->UpdateEntry(NPC_IRONFORGE_MINION);
                    break;

                // Argent Champion:
                case NPC_EADRIC:
                case NPC_PALETRESS:
                    NPC_ArgentChampionGUID = creature->GetGUID();
                    break;

                // Coliseum Announcer:
                case NPC_JAEREN:
                    NPC_AnnouncerGUID = creature->GetGUID();
                    //if( TeamIdInInstance == TEAM_ALLIANCE )
                    //  creature->UpdateEntry(NPC_ARELAS);
                    creature->SetReactState(REACT_PASSIVE);
                    break;

                // Highlord Tirion Fordring
                case NPC_TIRION:
                    NPC_TirionGUID = creature->GetGUID();
                    break;

                // Beginning vehicles:
                case VEHICLE_ARGENT_WARHORSE:
                case VEHICLE_ARGENT_BATTLEWORG:
                    if( InstanceProgress < INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED && m_auiEncounter[0] == NOT_STARTED )
                    {
                        creature->DespawnOrUnsummon();
                        creature->SetRespawnTime(3);
                        VehicleList.push_back(creature->GetGUID());
                    }
                    else
                        creature->DespawnOrUnsummon();
                    break;
            }
            if (creature->GetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID))
                if (const CreatureAddon* ca = creature->GetCreatureAddon())
                    if (ca->mount != creature->GetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID))
                        creature->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, ca->mount);
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch( go->GetEntry() )
            {
                case GO_MAIN_GATE:
                    GO_MainGateGUID = go->GetGUID();
                    HandleGameObject(GO_MainGateGUID, false, go);
                    break;
                case GO_SOUTH_PORTCULLIS:
                case GO_EAST_PORTCULLIS:
                    HandleGameObject(go->GetGUID(), false, go);
                    break;
                case GO_NORTH_PORTCULLIS:
                    HandleGameObject(go->GetGUID(), true, go);
                    GO_EnterGateGUID = go->GetGUID();
                    break;
            }
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;
            std::ostringstream saveStream;
            saveStream << "T C " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' ' << InstanceProgress;
            str_data = saveStream.str();
            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in)
        {
            CLEANED = false;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0);

            if( !in )
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint16 data0, data1, data2, data3;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3;

            if( dataHead1 == 'T' && dataHead2 == 'C' )
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                InstanceProgress = data3;
                if( InstanceProgress == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED )
                    InstanceProgress = INSTANCE_PROGRESS_INITIAL;

                for( uint8 i = 0; i < MAX_ENCOUNTER; ++i )
                    if( m_auiEncounter[i] == IN_PROGRESS )
                        m_auiEncounter[i] = NOT_STARTED;

            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        // EVENT STUFF BELOW:

        void OnPlayerEnter(Player *)
        {
            if( DoNeedCleanup(true) )
                InstanceCleanup();

            events.RescheduleEvent(EVENT_CHECK_PLAYERS, CLEANUP_CHECK_INTERVAL);
        }

        bool DoNeedCleanup(bool /*enter*/)
        {
            uint8 aliveCount = 0;
            Map::PlayerList const &pl = instance->GetPlayers();
            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                if( Player* plr = itr->GetSource() )
                    if( plr->IsAlive() && !plr->IsGameMaster() )
                        ++aliveCount;

            bool need = aliveCount==0;
            if( !need && CLEANED )
                CLEANED = false;
            return need;
        }

        void InstanceCleanup()
        {
            if( CLEANED )
                return;

            switch( InstanceProgress )
            {
                case INSTANCE_PROGRESS_INITIAL:
                case INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3:
                    // revert to INSTANCE_PROGRESS_INITIAL
                    {
                        for( std::list<uint64>::const_iterator itr = VehicleList.begin(); itr != VehicleList.end(); ++itr )
                            if( Creature* veh = instance->GetCreature(*itr) )
                            {
                                veh->DespawnOrUnsummon();
                                veh->SetRespawnTime(3);
                            }
                        for( uint8 i=0; i<3; ++i )
                        {
                            for( uint8 j=0; j<3; ++j )
                            {
                                if( Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[i][j]) )
                                    c->DespawnOrUnsummon();
                                NPC_GrandChampionMinionsGUID[i][j] = 0;
                            }
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]) )
                                c->DespawnOrUnsummon();
                            NPC_GrandChampionGUID[i] = 0;
                        }
                        if( Creature* c = instance->GetCreature(NPC_AnnouncerGUID) )
                        {
                            c->DespawnOrUnsummon();
                            c->SetHomePosition(748.309f, 619.488f, 411.172f, 4.71239f);
                            c->SetPosition(748.309f, 619.488f, 411.172f, 4.71239f);
                            c->SetRespawnTime(3);
                            c->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        }
                        InstanceProgress = INSTANCE_PROGRESS_INITIAL;
                    }
                    break;
                case INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED:
                    {
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                        {
                            announcer->DespawnOrUnsummon();
                            announcer->SetHomePosition(735.81f, 661.92f, 412.39f, 4.714f);
                            announcer->SetPosition(735.81f, 661.92f, 412.39f, 4.714f);
                            announcer->SetRespawnTime(3);
                            announcer->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

                            for( uint8 i=0; i<3; ++i )
                                if( Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]) )
                                {
                                    uint32 entry = c->GetEntry();
                                    c->DespawnOrUnsummon();
                                    switch( i )
                                    {
                                        case 0:
                                            if( Creature* pBoss = announcer->SummonCreature(entry, 736.695f, 650.02f, 412.4f, 3*M_PI/2) )
                                            {
                                                NPC_GrandChampionGUID[0] = pBoss->GetGUID();
                                                pBoss->AI()->SetData(0, 2);
                                            }
                                            break;
                                        case 1:
                                            if( Creature* pBoss = announcer->SummonCreature(entry, 756.32f, 650.05f, 412.4f, 3*M_PI/2) )
                                            {
                                                NPC_GrandChampionGUID[1] = pBoss->GetGUID();
                                                pBoss->AI()->SetData(1, 2);
                                            }
                                            break;
                                        case 2:
                                            if( Creature* pBoss = announcer->SummonCreature(entry, 746.5f, 650.65f, 411.7f, 3*M_PI/2) )
                                            {
                                                NPC_GrandChampionGUID[2] = pBoss->GetGUID();
                                                pBoss->AI()->SetData(2, 2);
                                            }
                                            break;
                                    }
                                }
                        }
                    }
                    break;
                case INSTANCE_PROGRESS_CHAMPIONS_DEAD:
                case INSTANCE_PROGRESS_ARGENT_SOLDIERS_DIED:
                    // revert to INSTANCE_PROGRESS_CHAMPIONS_DEAD
                    {
                        for( uint8 i=0; i<3; ++i )
                            for( uint8 j=0; j<3; ++j )
                            {
                                if( Creature* c = instance->GetCreature(NPC_ArgentSoldierGUID[i][j]) )
                                    c->DespawnOrUnsummon();
                                NPC_ArgentSoldierGUID[i][j] = 0;
                            }
                        if( Creature* c = instance->GetCreature(NPC_ArgentChampionGUID) )
                        {
                            c->AI()->DoAction(-1); // paletress despawn memory
                            c->DespawnOrUnsummon();
                        }
                        NPC_ArgentChampionGUID = 0;
                        if( Creature* c = instance->GetCreature(NPC_AnnouncerGUID) )
                        {
                            c->DespawnOrUnsummon();
                            c->SetHomePosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetPosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetRespawnTime(3);
                            c->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        }
                        NPC_MemoryEntry = 0;
                        InstanceProgress = INSTANCE_PROGRESS_CHAMPIONS_DEAD;
                    }
                    break;
                case INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED:
                    // revert to INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED
                    {
                        if( Creature* c = instance->GetCreature(NPC_BlackKnightVehicleGUID) )
                            c->DespawnOrUnsummon();
                        NPC_BlackKnightVehicleGUID = 0;
                        if( Creature* c = instance->GetCreature(NPC_BlackKnightGUID) )
                        {
                            c->AI()->DoAction(-1);
                            c->DespawnOrUnsummon();
                        }
                        NPC_BlackKnightGUID = 0;
                        if( Creature* c = instance->GetCreature(NPC_AnnouncerGUID) )
                        {
                            c->DespawnOrUnsummon();
                            c->SetHomePosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetPosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetRespawnTime(3);
                            c->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        }
                        InstanceProgress = INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED;
                    }
                    break;
                case INSTANCE_PROGRESS_FINISHED:
                    if( Creature* c = instance->GetCreature(NPC_AnnouncerGUID) )
                        c->DespawnOrUnsummon();
                    break;
            }

            HandleGameObject(GO_MainGateGUID, false);
            HandleGameObject(GO_EnterGateGUID, true);
            Counter = 0;
            SaveToDB();
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, CLEANUP_CHECK_INTERVAL);

            CLEANED = true;
        }

        uint32 GetData(uint32 uiData) const
        {
            switch( uiData )
            {
                case DATA_INSTANCE_PROGRESS:
                    return InstanceProgress;
                case DATA_TEAMID_IN_INSTANCE:
                    return TeamIdInInstance;
            }

            return 0;
        }

        uint64 GetData64(uint32 uiData) const
        {
            switch( uiData )
            {
                case DATA_ANNOUNCER:
                    return NPC_AnnouncerGUID;
                case DATA_PALETRESS:
                    return NPC_ArgentChampionGUID;
            }

            return 0;
        }

        void SetData(uint32 uiType, uint32 uiData)
        {
            switch( uiType )
            {
                case DATA_ANNOUNCER_GOSSIP_SELECT:
                    switch( InstanceProgress )
                    {
                        case INSTANCE_PROGRESS_INITIAL:
                            if (uiData == 0) // normal intro
                            {
                                shortver = false;

                                if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                                {
                                    if( GameObject* gate = instance->GetGameObject(GO_MainGateGUID) )
                                        announcer->SetFacingToObject(gate);
                                    if( Creature* tirion = instance->GetCreature(NPC_TirionGUID) )
                                        tirion->AI()->Talk(TEXT_WELCOME);
                                }
                                events.RescheduleEvent(EVENT_YELL_WELCOME_2, 8000);
                            }
                            else // short version
                            {
                                shortver = true;

                                temp1 = urand(0,4);
                                DoSummonGrandChampion(temp1, 0);
                                do { temp2 = urand(0,4); } while( temp1 == temp2 );
                                DoSummonGrandChampion(temp2, 1);
                                uint8 number = 0;
                                do { number = urand(0,4); } while( number == temp1 || number == temp2 );
                                DoSummonGrandChampion(number, 2);

                                InstanceProgress = INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST;
                                uiData = DONE; // save to db
                                if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                                {
                                    announcer->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                                    announcer->GetMotionMaster()->MovePoint(1, 735.81f, 661.92f, 412.39f);
                                }
                                events.ScheduleEvent(EVENT_GRAND_GROUP_1_MOVE_MIDDLE, 10000);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPIONS_DEAD:
                            if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                            {
                                Counter = urand(0,1);
                                if( Counter )
                                    announcer->AI()->Talk(TEXT_INTRODUCE_EADRIC);
                                else
                                    announcer->AI()->Talk(TEXT_INTRODUCE_PALETRESS);
                            }
                            HandleGameObject(GO_EnterGateGUID, false);
                            events.RescheduleEvent(EVENT_START_ARGENT_CHALLENGE_INTRO, 0);
                            break;
                        case INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED:
                            if( Creature* tirion = instance->GetCreature(NPC_TirionGUID) )
                                tirion->AI()->Talk(TEXT_BK_INTRO);
                            events.RescheduleEvent(EVENT_SUMMON_BLACK_KNIGHT, 3000);
                            break;
                    }
                    break;
                case DATA_GRAND_CHAMPION_REACHED_DEST:
                    if (shortver)
                        break;
                    switch( uiData )
                    {
                        case 0:
                            events.ScheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_2, 0);
                            break;
                        case 1:
                            events.ScheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_3, 0);
                            break;
                        case 2:
                            if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                            {
                                InstanceProgress = INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST;
                                uiData = DONE; // save to db
                                announcer->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                                announcer->GetMotionMaster()->MovePoint(1, 735.81f, 661.92f, 412.39f);
                                events.ScheduleEvent(EVENT_GRAND_GROUP_1_MOVE_MIDDLE, 8500);
                            }
                            break;
                    }
                    break;
                case DATA_MOUNT_DIED:
                    switch( InstanceProgress )
                    {
                        case INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST: // fighting group 1/3
                            if( ++Counter >= 3 )
                            {
                                Counter = 0;
                                InstanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1;
                                uiData = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_GROUP_2_MOVE_MIDDLE, 0);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1: // fighting group 2/3
                            if( ++Counter >= 3 )
                            {
                                Counter = 0;
                                InstanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2;
                                uiData = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_GROUP_3_MOVE_MIDDLE, 0);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2: // fighting group 3/3
                            if( ++Counter >= 3 )
                            {
                                Counter = 0;
                                InstanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3;
                                uiData = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOVE_MIDDLE, 0);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3: // fighting grand champions (on vehicles)
                            if( ++Counter >= 3 )
                            {
                                Counter = 0;
                                InstanceProgress = INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED;
                                for( std::list<uint64>::const_iterator itr = VehicleList.begin(); itr != VehicleList.end(); ++itr )
                                    if( Creature* veh = instance->GetCreature(*itr) )
                                        veh->DespawnOrUnsummon();
                                events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOVE_SIDE, 0);
                            }
                            break;
                    }
                    break;
                case DATA_REACHED_NEW_MOUNT:
                    --Counter;
                    break;
                case DATA_GRAND_CHAMPION_DIED:
                    if( ++Counter >= 3 )
                    {
                        Counter = 0;
                        VehicleList.clear();
                        uiData = DONE;
                        InstanceProgress = INSTANCE_PROGRESS_CHAMPIONS_DEAD;
                        m_auiEncounter[0] = DONE;
                        bool creditCasted = false;
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]) )
                            {
                                c->GetMotionMaster()->MovePoint(9, 747.36f, 670.07f, 411.9f);
                                if (!creditCasted)
                                {
                                    c->CastSpell((Unit*)NULL, 68572, true);
                                    creditCasted = true;
                                }
                            }
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                        {
                            announcer->GetMotionMaster()->MovePoint(0, 743.14f, 628.77f, 411.2f);
                            announcer->SummonGameObject(instance->IsHeroic() ? GO_CHAMPIONS_LOOT_H : GO_CHAMPIONS_LOOT, 746.59f, 618.49f, 411.09f, 1.42f, 0, 0, 0, 0, 90000000); // [LOOT]
                            events.ScheduleEvent(EVENT_RESTORE_ANNOUNCER_GOSSIP, 15000);
                            events.ScheduleEvent(EVENT_GRATZ_SLAIN_CHAMPIONS, 6000);
                        }

                        // bind players to instance
                        if( instance->IsHeroic() )
                            instance->ToInstanceMap()->PermBindAllPlayers();
                    }
                    break;
                case DATA_ARGENT_SOLDIER_DEFEATED:
                    if( ++Counter >= 9 )
                    {
                        Counter = 0;
                        InstanceProgress = INSTANCE_PROGRESS_ARGENT_SOLDIERS_DIED;
                        uiData = DONE; // save to db
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_MOVE_FORWARD, 0);
                    }
                    break;
                case BOSS_ARGENT_CHALLENGE:
                    {
                        m_auiEncounter[1] = uiData;
                        if( uiData == DONE )
                        {
                            HandleGameObject(GO_EnterGateGUID, true);
                            InstanceProgress = INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED;
                            events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_RUN_MIDDLE, 0);
                        }
                    }
                    break;
                case DATA_MEMORY_ENTRY:
                    NPC_MemoryEntry = uiData;
                    break;
                case DATA_SKELETAL_GRYPHON_LANDED:
                    {
                        events.ScheduleEvent(EVENT_START_BLACK_KNIGHT_SCENE, 3000);
                    }
                    break;
                case BOSS_BLACK_KNIGHT:
                    {
                        m_auiEncounter[2] = uiData;
                        if (uiData == NOT_STARTED)
                        {
                            HandleGameObject(GO_EnterGateGUID, false);
                            bAchievIveHadWorse = true;
                        }
                        else if( uiData == DONE )
                        {
                            HandleGameObject(GO_EnterGateGUID, true);
                            InstanceProgress = INSTANCE_PROGRESS_FINISHED;
                        }
                    }
                    break;
                case DATA_ACHIEV_IVE_HAD_WORSE:
                    if (bAchievIveHadWorse)
                        bAchievIveHadWorse = false;
                    break;
            }

            if( uiData == DONE )
                SaveToDB();
        }

        void DoSummonGrandChampion(uint32 BossNumber, uint8 BossOrder)
        {
            uint32 CHAMPION_TO_SUMMON = 0;
            uint32 MINION_TO_SUMMON = 0;
            int32 TEXT_ID = 0;

            switch( BossNumber )
            {
                case 0:
                    CHAMPION_TO_SUMMON = NPC_MOKRA;
                    MINION_TO_SUMMON = NPC_ORGRIMMAR_MINION;
                    TEXT_ID = TEXT_MOKRA_SKILLCRUSHER;
                    break;
                case 1:
                    CHAMPION_TO_SUMMON = NPC_ERESSEA;
                    MINION_TO_SUMMON = NPC_SILVERMOON_MINION;
                    TEXT_ID = TEXT_ERESSEA_DAWNSINGER;
                    break;
                case 2:
                    CHAMPION_TO_SUMMON = NPC_RUNOK;
                    MINION_TO_SUMMON = NPC_THUNDER_BLUFF_MINION;
                    TEXT_ID = TEXT_RUNOK_WILDMANE;
                    break;
                case 3:
                    CHAMPION_TO_SUMMON = NPC_ZULTORE;
                    MINION_TO_SUMMON = NPC_SENJIN_MINION;
                    TEXT_ID = TEXT_ZUL_TORE;
                    break;
                case 4:
                    CHAMPION_TO_SUMMON = NPC_VISCERI;
                    MINION_TO_SUMMON = NPC_UNDERCITY_MINION;
                    TEXT_ID = TEXT_DEATHSTALKER_VESCERI;
                    break;
                default:
                    return;
            }

            Position SpawnPos = SpawnPosition;
            if (shortver)
                switch (BossOrder)
                {
                    case 0:
                        SpawnPos.Relocate(780.43f, 607.15f, 411.82f);
                        break;
                    case 1:
                        SpawnPos.Relocate(768.72f, 581.01f, 411.92f);
                        break;
                    case 2:
                        SpawnPos.Relocate(784.02f, 645.33f, 412.39f);
                        break;
                }

            if( Creature* pBoss = instance->SummonCreature(CHAMPION_TO_SUMMON, SpawnPos) )
            {
                NPC_GrandChampionGUID[BossOrder] = pBoss->GetGUID();
                pBoss->ToCreature()->SetHomePosition(748.309f, 619.448f, 411.3f, M_PI/2);
                pBoss->ToCreature()->SetReactState(REACT_PASSIVE);
                pBoss->AI()->SetData(BossOrder, (shortver ? 1 : 0));

                for( uint8 i = 0; i < 3; ++i )
                    if( Creature* pAdd = instance->SummonCreature(MINION_TO_SUMMON, SpawnPos) )
                    {
                        NPC_GrandChampionMinionsGUID[BossOrder][i] = pAdd->GetGUID();
                        pAdd->SetHomePosition(748.309f, 619.448f, 411.3f, M_PI/2);
                        pAdd->GetMotionMaster()->MoveFollow(pBoss, 2.0f, (i+1)*M_PI/2);
                        pAdd->SetReactState(REACT_PASSIVE);
                    }

            }
            
            if (!shortver)
                if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                {
                    if( TeamIdInInstance == TEAM_HORDE )
                        TEXT_ID -= 10;
                    announcer->AI()->Talk(TEXT_ID);
                    announcer->AI()->Talk(TEXT_ID+1);
                }
        }

        void Update(uint32 diff)
        {
            events.Update(diff);
            switch( events.GetEvent() )
            {
                case EVENT_NULL:
                    break;
                case EVENT_CHECK_PLAYERS:
                    {
                        if( DoNeedCleanup(false) )
                            InstanceCleanup();
                        events.RepeatEvent(CLEANUP_CHECK_INTERVAL);
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_1:
                    {
                        temp1 = urand(0,4);
                        DoSummonGrandChampion(temp1, 0);
                        HandleGameObject(GO_MainGateGUID, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_2:
                    {
                        do { temp2 = urand(0,4); } while( temp1 == temp2 );
                        DoSummonGrandChampion(temp2, 1);
                        HandleGameObject(GO_MainGateGUID, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_3:
                    {
                        uint8 number = 0;
                        do { number = urand(0,4); } while( number == temp1 || number == temp2 );
                        DoSummonGrandChampion(number, 2);
                        HandleGameObject(GO_MainGateGUID, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_CLOSE_GATE:
                    {
                        HandleGameObject(GO_MainGateGUID, false);
                        events.PopEvent();
                    }
                    break;
                case EVENT_YELL_WELCOME_2:
                    {
                        if( Creature* tirion = instance->GetCreature(NPC_TirionGUID) )
                            tirion->AI()->Talk(TEXT_WELCOME_2);
                        events.RescheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_1, 8000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_GROUP_1_MOVE_MIDDLE:
                    {
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                        {
                            announcer->SetFacingTo(4.714f);
                            if( Creature* tirion = instance->GetCreature(NPC_TirionGUID) )
                                tirion->AI()->Talk(TEXT_BEGIN);
                            HandleGameObject(GO_EnterGateGUID, false);
                        }
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[1][i]) )
                            {
                                float angle = rand_norm()*2*M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f+3.0f*cos(angle), 619.448f+3.0f*sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_1_ATTACK, 3000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_GROUP_1_ATTACK:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[1][i]) )
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                if( Unit* target = c->SelectNearestTarget(200.0f) )
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        Counter = 0;
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_GROUP_2_MOVE_MIDDLE:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[0][i]) )
                            {
                                float angle = rand_norm()*2*M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f+3.0f*cos(angle), 619.448f+3.0f*sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_2_ATTACK, 3000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_GROUP_2_ATTACK:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[0][i]) )
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                if( Unit* target = c->SelectNearestTarget(200.0f) )
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_GROUP_3_MOVE_MIDDLE:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[2][i]) )
                            {
                                float angle = rand_norm()*2*M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f+3.0f*cos(angle), 619.448f+3.0f*sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_3_ATTACK, 3000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_GROUP_3_ATTACK:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[2][i]) )
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                if( Unit* target = c->SelectNearestTarget(200.0f) )
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_MOVE_MIDDLE:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]) )
                            {
                                float angle = rand_norm()*2*M_PI;
                                c->GetMotionMaster()->MovePoint(4, 748.309f+3.0f*cos(angle), 619.448f+3.0f*sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOUNTS_ATTACK, 3000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_MOUNTS_ATTACK:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]) )
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                if( Unit* target = c->SelectNearestTarget(200.0f) )
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                                c->CastSpell(c, 67865, true); // SPELL_TRAMPLE_AURA
                            }
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_MOVE_SIDE:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]) )
                            {
                                c->AI()->DoAction(1);
                                switch( i )
                                {
                                    case 0:
                                        c->GetMotionMaster()->MovePoint(5, 736.695f, 650.02f, 412.4f);
                                        break;
                                    case 1:
                                        c->GetMotionMaster()->MovePoint(5, 756.32f, 650.05f, 412.4f);
                                        break;
                                    case 2:
                                        c->GetMotionMaster()->MovePoint(5, 746.5f, 650.65f, 411.7f);
                                        break;
                                }
                            }

                        events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_ATTACK, 15000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_ATTACK:
                    {
                        for( uint8 i=0; i<3; ++i )
                            if( Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]) )
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                if( Unit* target = c->SelectNearestTarget(200.0f) )
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                                c->AI()->DoAction(2);
                            }
                        events.PopEvent();
                    }
                    break;
                case EVENT_GRATZ_SLAIN_CHAMPIONS:
                    {
                        if( Creature* tirion = instance->GetCreature(NPC_TirionGUID) )
                            tirion->AI()->Talk(TEXT_GRATZ_SLAIN_CHAMPIONS);
                        events.PopEvent();
                        HandleGameObject(GO_EnterGateGUID, true);
                    }
                    break;
                case EVENT_RESTORE_ANNOUNCER_GOSSIP:
                    {
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                            announcer->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        events.PopEvent();
                    }
                    break;
                case EVENT_START_ARGENT_CHALLENGE_INTRO:
                    {
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                        {
                            if( GameObject* gate = instance->GetGameObject(GO_MainGateGUID) )
                            {
                                announcer->SetFacingToObject(gate);
                                HandleGameObject(GO_MainGateGUID, true, gate);
                                HandleGameObject(GO_EnterGateGUID, false, gate);
                            }
                            if( Counter )
                            {
                                announcer->AI()->Talk(TEXT_CHEER_EADRIC_1);
                                announcer->AI()->Talk(TEXT_CHEER_EADRIC_2);
                            }
                            else
                            {
                                announcer->AI()->Talk(TEXT_CHEER_PALETRESS_1);
                                announcer->AI()->Talk(TEXT_CHEER_PALETRESS_2);
                            }
                        }
                            
                        for( int8 i = 0; i < 3; ++i )
                        {
                            Position pos(SpawnPosition);
                            float x = pos.GetPositionX();

                            pos.m_positionX = x-2.0f+(i-1)*10.0f;
                            if( Creature* pTrash = instance->SummonCreature(NPC_ARGENT_LIGHTWIELDER, pos) )
                            {
                                pTrash->AI()->SetData(i,0);
                                NPC_ArgentSoldierGUID[i][0] = pTrash->GetGUID();
                            }
                            pos.m_positionX = x+(i-1)*10.0f;
                            if( Creature* pTrash = instance->SummonCreature(NPC_ARGENT_MONK, pos) )
                            {
                                pTrash->AI()->SetData(i,0);
                                NPC_ArgentSoldierGUID[i][1] = pTrash->GetGUID();
                            }
                            pos.m_positionX = x+2.0f+(i-1)*10.0f;
                            if( Creature* pTrash = instance->SummonCreature(NPC_PRIESTESS, pos) )
                            {
                                pTrash->AI()->SetData(i,0);
                                NPC_ArgentSoldierGUID[i][2] = pTrash->GetGUID();
                            }
                        }
                        events.ScheduleEvent(EVENT_SUMMON_ARGENT_CHALLENGE, 4000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_SUMMON_ARGENT_CHALLENGE:
                    {
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                            announcer->GetMotionMaster()->MovePoint(0, 735.81f, 661.92f, 412.39f);
                        if (Creature* boss = instance->SummonCreature(Counter ? NPC_EADRIC : NPC_PALETRESS, SpawnPosition))
                            boss->GetMotionMaster()->MovePoint(0, 746.881f, 660.263f, 411.7f);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 5000);
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_SAY_1, 4000);
                        events.ScheduleEvent(EVENT_ARGENT_SOLDIER_GROUP_ATTACK, 12500);
                        events.PopEvent();
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_SAY_1:
                    {
                        if( Creature* ac = instance->GetCreature(NPC_ArgentChampionGUID) )
                            ac->AI()->Talk(Counter ? TEXT_EADRIC_SAY_1 : TEXT_PALETRESS_SAY_1);
                        if( !Counter )
                            events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_SAY_2, 6000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_SAY_2:
                    {
                        if( Creature* ac = instance->GetCreature(NPC_ArgentChampionGUID) )
                            ac->AI()->Talk(TEXT_PALETRESS_SAY_2);
                        events.PopEvent();
                    }
                    break;
                case EVENT_ARGENT_SOLDIER_GROUP_ATTACK:
                    {
                        Counter = 0;
                        for( uint8 i=0; i<3; ++i )
                            for( uint8 j=0; j<3; ++j )
                                if( Creature* c = instance->GetCreature(NPC_ArgentSoldierGUID[i][j]) )
                                {
                                    c->SetReactState(REACT_AGGRESSIVE);
                                    c->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                    //c->AI()->DoZoneInCombat();
                                }
                        if( Creature* tirion = instance->GetCreature(NPC_TirionGUID) )
                            tirion->AI()->Talk(TEXT_YOU_MAY_BEGIN);
                        events.PopEvent();
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_MOVE_FORWARD:
                    {
                    if (Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID)) {
                        boss->GetMotionMaster()->MovePoint(0, 746.881f, 635.263f, 411.7f);
                    }
                    events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_ATTACK, 3000);
                    events.PopEvent();
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_ATTACK:
                    {
                        if( Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID) )
                        {
                            boss->SetReactState(REACT_AGGRESSIVE);
                            boss->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            if( Unit* target = boss->SelectNearestTarget(200.0f) )
                                boss->AI()->AttackStart(target);
                            boss->AI()->DoZoneInCombat();
                        }
                        events.PopEvent();
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_RUN_MIDDLE:
                    {
                        if( Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID) )
                        {
                            boss->GetMotionMaster()->MovePoint(1, 747.13f, 628.037f, 411.2f);
                            events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_LEAVE_CHEST, 6000);
                        }
                        events.PopEvent();
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_LEAVE_CHEST:
                    {
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                            if( Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID) )
                            {
                                announcer->GetMotionMaster()->MovePoint(0, 743.14f, 628.77f, 411.2f);
                                uint32 chest = 0;
                                if( instance->IsHeroic() )
                                    chest = (boss->GetEntry() == NPC_EADRIC || boss->GetEntry() == NPC_EADRIC_H) ? GO_EADRIC_LOOT_H : GO_PALETRESS_LOOT_H;
                                else
                                    chest = (boss->GetEntry() == NPC_EADRIC || boss->GetEntry() == NPC_EADRIC_H) ? GO_EADRIC_LOOT : GO_PALETRESS_LOOT;
                                announcer->SummonGameObject(chest, 746.59f, 618.49f, 411.09f, 1.42f, 0, 0, 0, 0, 90000000); // [LOOT]
                            }

                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_DISAPPEAR, 4000);
                        events.ScheduleEvent(EVENT_RESTORE_ANNOUNCER_GOSSIP, 15000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_DISAPPEAR:
                    {
                        if( Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID) )
                        {
                            boss->GetMotionMaster()->MovePoint(0, SpawnPosition);
                            boss->DespawnOrUnsummon(3000);
                        }
                        events.PopEvent();
                    }
                    break;
                case EVENT_SUMMON_BLACK_KNIGHT:
                    {
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                            if( Creature* bk_vehicle = announcer->SummonCreature(VEHICLE_BLACK_KNIGHT, 769.834f, 651.915f, 447.035f, 0.0f) )
                            {
                                NPC_BlackKnightVehicleGUID = bk_vehicle->GetGUID();
                                bk_vehicle->SetReactState(REACT_PASSIVE);
                                bk_vehicle->SetFacingTo(M_PI);
                                if( Vehicle* v = bk_vehicle->GetVehicleKit() )
                                    if( Unit* bk = v->GetPassenger(0) )
                                    {
                                        NPC_BlackKnightGUID = bk->GetGUID();
                                        bk->SendMovementFlagUpdate(); // put him on vehicle visually
                                        if( bk->GetTypeId() == TYPEID_UNIT )
                                            bk->ToCreature()->SetReactState(REACT_PASSIVE);
                                    }

                                announcer->SetFacingToObject(bk_vehicle);
                                announcer->AI()->Talk(TEXT_BK_RAFTERS);
                            }
                        events.PopEvent();
                    }
                    break;
                case EVENT_START_BLACK_KNIGHT_SCENE:
                    {
                        if( Creature* bk = instance->GetCreature(NPC_BlackKnightGUID) )
                        {
                            Position exitPos = { 751.003357f, 638.145508f, 411.570129f, M_PI };
                            bk->ExitVehicle(/*&exitPos*/);
                            bk->GetMotionMaster()->MoveJump(exitPos, 2.0f, 2.0f);
                            bk->AI()->Talk(TEXT_BK_SPOILED);
                        }
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_CAST_ANNOUNCER, 2000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_BLACK_KNIGHT_CAST_ANNOUNCER:
                    {
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                        {
                            if( Creature* bk = instance->GetCreature(NPC_BlackKnightGUID) )
                            {
                                bk->SetPosition(745.016f, 631.506f, 411.575f, bk->GetAngle(announcer));
                                bk->SetHomePosition(*bk);
                                bk->SetFacingToObject(announcer);
                                announcer->SetFacingToObject(bk);
                                announcer->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                bk->AddAura(68306, announcer); // spell has attribute player only
                                if( Creature* tirion = instance->GetCreature(NPC_TirionGUID) )
                                    tirion->AI()->Talk(TEXT_BK_MEANING);
                            }
                        }
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_KILL_ANNOUNCER, 1000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_BLACK_KNIGHT_KILL_ANNOUNCER:
                    {
                        if( Creature* bk_vehicle = instance->GetCreature(NPC_BlackKnightVehicleGUID) )
                            bk_vehicle->AI()->DoAction(1);

                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_MOVE_FORWARD, 4000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_BLACK_KNIGHT_MOVE_FORWARD:
                    {
                        if( Creature* bk = instance->GetCreature(NPC_BlackKnightGUID) )
                        {
                            bk->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                            bk->GetMotionMaster()->MovePoint(0, 746.81f, 623.15f, 411.42f);
                            bk->AI()->Talk(TEXT_BK_LICH);
                        }
                        if( Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID) )
                            if (announcer->IsAlive())
                                Unit::Kill(announcer, announcer);
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_SAY_TASK, 14000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_BLACK_KNIGHT_SAY_TASK:
                    {
                        if( Creature* bk = instance->GetCreature(NPC_BlackKnightGUID) )
                        {
                            bk->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            bk->AI()->Talk(TEXT_BK_TASK);
                        }
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_ATTACK, 5000);
                        events.PopEvent();
                    }
                    break;
                case EVENT_BLACK_KNIGHT_ATTACK:
                    {
                        if( Creature* bk = instance->GetCreature(NPC_BlackKnightGUID) )
                        {
                            bk->SetReactState(REACT_AGGRESSIVE);
                            bk->SetUInt32Value(UNIT_FIELD_FLAGS, 0);
                            if( Unit* target = bk->SelectNearestTarget(200.0f) )
                                bk->AI()->AttackStart(target);
                            bk->AI()->DoZoneInCombat();
                            bk->AI()->DoAction(1);
                        }
                        events.PopEvent();
                    }
                    break;
            }           
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                case 11789: // I've Had Worse criteria id
                    return bAchievIveHadWorse;
                case 11863:
                    return NPC_MemoryEntry == 34942;
                case 11904:
                    return NPC_MemoryEntry == 35028;
                case 11905:
                    return NPC_MemoryEntry == 35029;
                case 11906:
                    return NPC_MemoryEntry == 35030;
                case 11907:
                    return NPC_MemoryEntry == 35031;
                case 11908:
                    return NPC_MemoryEntry == 35032;
                case 11909:
                    return NPC_MemoryEntry == 35033;
                case 11910:
                    return NPC_MemoryEntry == 35034;
                case 11911:
                    return NPC_MemoryEntry == 35036;
                case 11912:
                    return NPC_MemoryEntry == 35037;
                case 11913:
                    return NPC_MemoryEntry == 35038;
                case 11914:
                    return NPC_MemoryEntry == 35039;
                case 11915:
                    return NPC_MemoryEntry == 35040;
                case 11916:
                    return NPC_MemoryEntry == 35041;
                case 11917:
                    return NPC_MemoryEntry == 35042;
                case 11918:
                    return NPC_MemoryEntry == 35043;
                case 11919:
                    return NPC_MemoryEntry == 35044;
                case 11920:
                    return NPC_MemoryEntry == 35045;
                case 11921:
                    return NPC_MemoryEntry == 35046;
                case 11922:
                    return NPC_MemoryEntry == 35047;
                case 11923:
                    return NPC_MemoryEntry == 35048;
                case 11924:
                    return NPC_MemoryEntry == 35049;
                case 11925:
                    return NPC_MemoryEntry == 35050;
                case 11926:
                    return NPC_MemoryEntry == 35051;
                case 11927:
                    return NPC_MemoryEntry == 35052;
            }
            return false;
        }
    };
};

void AddSC_instance_trial_of_the_champion()
{
    new instance_trial_of_the_champion();
}
