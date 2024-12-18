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

#include "Group.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Vehicle.h"
#include "trial_of_the_champion.h"

const Position SpawnPosition = {746.67f, 684.08f, 412.5f, 4.65f};
#define CLEANUP_CHECK_INTERVAL  5000

/**
 *  @todo: Missing dialog/RP (already populated in DB) && spawns (can use ToC25 locations?) for:
 *
 *    Garrosh Hellscream 34995
 *    King Varian Wrynn 34990
 *   Lady Jaina Proudmoore 34992 (missing in DB)
 *   Thrall 34994
 *
 *  And possibly NPC_TIRION 33628 is wrong (should be 34996, from ToC25, needs a sniff to confirm, check .h)
 */

class Group;

class instance_trial_of_the_champion : public InstanceMapScript
{
public:
    instance_trial_of_the_champion() : InstanceMapScript("instance_trial_of_the_champion", 650) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_trial_of_the_champion_InstanceMapScript(pMap);
    }

    struct instance_trial_of_the_champion_InstanceMapScript : public InstanceScript
    {
        instance_trial_of_the_champion_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            SetHeaders(DataHeader);
            Initialize();
        }

        bool CLEANED;
        TeamId TeamIdInInstance;
        uint32 InstanceProgress;
        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string str_data;

        GuidList VehicleList;
        EventMap events;
        uint8 Counter;
        uint8 temp1, temp2;
        bool shortver;
        bool bAchievIveHadWorse;

        ObjectGuid NPC_AnnouncerGUID;
        ObjectGuid NPC_TirionGUID;
        ObjectGuid NPC_GrandChampionGUID[3];
        ObjectGuid NPC_GrandChampionMinionsGUID[3][3];
        ObjectGuid NPC_ArgentChampionGUID;
        ObjectGuid NPC_ArgentSoldierGUID[3][3];
        uint32 NPC_MemoryEntry;
        ObjectGuid NPC_BlackKnightVehicleGUID;
        ObjectGuid NPC_BlackKnightGUID;
        ObjectGuid GO_MainGateGUID;
        ObjectGuid GO_EnterGateGUID;

        void Initialize() override
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
        }

        bool IsEncounterInProgress() const override
        {
            for( uint8 i = 0; i < MAX_ENCOUNTER; ++i )
                if (m_auiEncounter[i] == IN_PROGRESS)
                    return true;

            return false;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (TeamIdInInstance == TEAM_NEUTRAL)
            {
                Map::PlayerList const& players = instance->GetPlayers();
                if (!players.IsEmpty())
                    if (Player* pPlayer = players.begin()->GetSource())
                        TeamIdInInstance = pPlayer->GetTeamId();
            }

            switch (creature->GetEntry())
            {
                // Grand Champions:
                case NPC_MOKRA:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_JACOB);
                    break;
                case NPC_ERESSEA:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_AMBROSE);
                    break;
                case NPC_RUNOK:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_COLOSOS);
                    break;
                case NPC_ZULTORE:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_JAELYNE);
                    break;
                case NPC_VISCERI:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_LANA);
                    break;

                // Grand Champion Minions:
                case NPC_ORGRIMMAR_MINION:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_STORMWIND_MINION);
                    break;
                case NPC_SILVERMOON_MINION:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_GNOMEREGAN_MINION);
                    break;
                case NPC_THUNDER_BLUFF_MINION:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_EXODAR_MINION);
                    break;
                case NPC_SENJIN_MINION:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_DARNASSUS_MINION);
                    break;
                case NPC_UNDERCITY_MINION:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_IRONFORGE_MINION);
                    break;

                // Argent Champion:
                case NPC_EADRIC:
                case NPC_PALETRESS:
                    NPC_ArgentChampionGUID = creature->GetGUID();
                    break;

                // Coliseum Announcer:
                case NPC_JAEREN:
                case NPC_ARELAS:
                    NPC_AnnouncerGUID = creature->GetGUID();
                    //if (TeamIdInInstance == TEAM_ALLIANCE)
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
                    if (InstanceProgress < INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED && m_auiEncounter[0] == NOT_STARTED)
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

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
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

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;
            std::ostringstream saveStream;
            saveStream << "T C " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' ' << InstanceProgress;
            str_data = saveStream.str();
            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in) override
        {
            CLEANED = false;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0ms);

            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint16 data0, data1, data2, data3;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3;

            if (dataHead1 == 'T' && dataHead2 == 'C')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                InstanceProgress = data3;
                if (InstanceProgress == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED)
                    InstanceProgress = INSTANCE_PROGRESS_INITIAL;

                for( uint8 i = 0; i < MAX_ENCOUNTER; ++i )
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        // EVENT STUFF BELOW:

        void OnPlayerEnter(Player* plr) override
        {
            if (DoNeedCleanup(plr))
            {
                InstanceCleanup();
            }

            events.RescheduleEvent(EVENT_CHECK_PLAYERS, CLEANUP_CHECK_INTERVAL);
        }

        bool DoNeedCleanup(Player* ignoredPlayer = nullptr)
        {
            uint8 aliveCount = 0;
            for (const auto &itr: instance->GetPlayers())
            {
                if (Player* plr = itr.GetSource())
                {
                    if (plr != ignoredPlayer && plr->IsAlive() && !plr->IsGameMaster())
                    {
                        ++aliveCount;
                    }
                }
            }

            bool need = aliveCount == 0;
            if (!need && CLEANED)
            {
                CLEANED = false;
            }

            return need;
        }

        void InstanceCleanup()
        {
            if (CLEANED)
                return;

            switch (InstanceProgress)
            {
                case INSTANCE_PROGRESS_INITIAL:
                case INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3:
                    // revert to INSTANCE_PROGRESS_INITIAL
                    {
                        for (ObjectGuid const& guid : VehicleList)
                            if (Creature* veh = instance->GetCreature(guid))
                            {
                                veh->DespawnOrUnsummon();
                                veh->SetRespawnTime(3);
                            }
                        for( uint8 i = 0; i < 3; ++i )
                        {
                            for( uint8 j = 0; j < 3; ++j )
                            {
                                if (Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[i][j]))
                                    c->DespawnOrUnsummon();
                                NPC_GrandChampionMinionsGUID[i][j].Clear();
                            }
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]))
                                c->DespawnOrUnsummon();
                            NPC_GrandChampionGUID[i].Clear();
                        }
                        if (Creature* c = instance->GetCreature(NPC_AnnouncerGUID))
                        {
                            c->DespawnOrUnsummon();
                            c->SetHomePosition(748.309f, 619.488f, 411.172f, 4.71239f);
                            c->SetPosition(748.309f, 619.488f, 411.172f, 4.71239f);
                            c->SetRespawnTime(3);
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        }
                        InstanceProgress = INSTANCE_PROGRESS_INITIAL;
                    }
                    break;
                case INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED:
                    {
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                        {
                            announcer->DespawnOrUnsummon();
                            announcer->SetHomePosition(735.81f, 661.92f, 412.39f, 4.714f);
                            announcer->SetPosition(735.81f, 661.92f, 412.39f, 4.714f);
                            announcer->SetRespawnTime(3);
                            announcer->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

                            for( uint8 i = 0; i < 3; ++i )
                                if (Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]))
                                {
                                    uint32 entry = c->GetEntry();
                                    c->DespawnOrUnsummon();
                                    switch (i)
                                    {
                                        case 0:
                                            if (Creature* pBoss = announcer->SummonCreature(entry, 736.695f, 650.02f, 412.4f, 3 * M_PI / 2))
                                            {
                                                NPC_GrandChampionGUID[0] = pBoss->GetGUID();
                                                pBoss->AI()->SetData(0, 2);
                                            }
                                            break;
                                        case 1:
                                            if (Creature* pBoss = announcer->SummonCreature(entry, 756.32f, 650.05f, 412.4f, 3 * M_PI / 2))
                                            {
                                                NPC_GrandChampionGUID[1] = pBoss->GetGUID();
                                                pBoss->AI()->SetData(1, 2);
                                            }
                                            break;
                                        case 2:
                                            if (Creature* pBoss = announcer->SummonCreature(entry, 746.5f, 650.65f, 411.7f, 3 * M_PI / 2))
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
                        for( uint8 i = 0; i < 3; ++i )
                            for( uint8 j = 0; j < 3; ++j )
                            {
                                if (Creature* c = instance->GetCreature(NPC_ArgentSoldierGUID[i][j]))
                                    c->DespawnOrUnsummon();
                                NPC_ArgentSoldierGUID[i][j].Clear();
                            }
                        if (Creature* c = instance->GetCreature(NPC_ArgentChampionGUID))
                        {
                            c->AI()->DoAction(-1); // paletress despawn memory
                            c->DespawnOrUnsummon();
                        }
                        NPC_ArgentChampionGUID.Clear();
                        if (Creature* c = instance->GetCreature(NPC_AnnouncerGUID))
                        {
                            c->DespawnOrUnsummon();
                            c->SetHomePosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetPosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetRespawnTime(3);
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        }
                        NPC_MemoryEntry = 0;
                        InstanceProgress = INSTANCE_PROGRESS_CHAMPIONS_DEAD;
                    }
                    break;
                case INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED:
                    // revert to INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED
                    {
                        if (Creature* c = instance->GetCreature(NPC_BlackKnightVehicleGUID))
                            c->DespawnOrUnsummon();
                        NPC_BlackKnightVehicleGUID.Clear();
                        if (Creature* c = instance->GetCreature(NPC_BlackKnightGUID))
                        {
                            c->AI()->DoAction(-1);
                            c->DespawnOrUnsummon();
                        }
                        NPC_BlackKnightGUID.Clear();
                        if (Creature* c = instance->GetCreature(NPC_AnnouncerGUID))
                        {
                            c->DespawnOrUnsummon();
                            c->SetHomePosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetPosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetRespawnTime(3);
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        }
                        InstanceProgress = INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED;
                    }
                    break;
                case INSTANCE_PROGRESS_FINISHED:
                    if (Creature* c = instance->GetCreature(NPC_AnnouncerGUID))
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

        uint32 GetData(uint32 uiData) const override
        {
            switch (uiData)
            {
                case DATA_INSTANCE_PROGRESS:
                    return InstanceProgress;
                case DATA_TEAMID_IN_INSTANCE:
                    return TeamIdInInstance;
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 uiData) const override
        {
            switch (uiData)
            {
                case DATA_ANNOUNCER:
                    return NPC_AnnouncerGUID;
                case DATA_PALETRESS:
                    return NPC_ArgentChampionGUID;
            }

            return ObjectGuid::Empty;
        }

        void SetData(uint32 uiType, uint32 uiData) override
        {
            switch (uiType)
            {
                case DATA_ANNOUNCER_GOSSIP_SELECT:
                    switch (InstanceProgress)
                    {
                        case INSTANCE_PROGRESS_INITIAL:
                            if (uiData == 0) // normal intro
                            {
                                shortver = false;

                                if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                                {
                                    if (GameObject* gate = instance->GetGameObject(GO_MainGateGUID))
                                        announcer->SetFacingToObject(gate);
                                    if (Creature* tirion = instance->GetCreature(NPC_TirionGUID))
                                        tirion->AI()->Talk(TEXT_WELCOME);
                                }
                                events.RescheduleEvent(EVENT_YELL_WELCOME_2, 8s);
                            }
                            else // short version
                            {
                                shortver = true;

                                temp1 = urand(0, 4);
                                DoSummonGrandChampion(temp1, 0);
                                do { temp2 = urand(0, 4); }
                                while( temp1 == temp2 );
                                DoSummonGrandChampion(temp2, 1);
                                uint8 number = 0;
                                do { number = urand(0, 4); }
                                while( number == temp1 || number == temp2 );
                                DoSummonGrandChampion(number, 2);

                                InstanceProgress = INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST;
                                uiData = DONE; // save to db
                                if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                                {
                                    announcer->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                                    announcer->GetMotionMaster()->MovePoint(1, 735.81f, 661.92f, 412.39f);
                                }
                                events.ScheduleEvent(EVENT_GRAND_GROUP_1_MOVE_MIDDLE, 10s);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPIONS_DEAD:
                            if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                            {
                                Counter = urand(0, 1);
                                if (Counter)
                                    announcer->AI()->Talk(SAY_EADRIC_INTRO_ANNOUNCER);
                                else
                                    announcer->AI()->Talk(SAY_JAEREN_PALETRESS_INTRO);
                            }
                            HandleGameObject(GO_EnterGateGUID, false);
                            events.RescheduleEvent(EVENT_START_ARGENT_CHALLENGE_INTRO, 0ms);
                            break;
                        case INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED:
                            if (Creature* tirion = instance->GetCreature(NPC_TirionGUID))
                                tirion->AI()->Talk(TEXT_BK_INTRO);
                            events.RescheduleEvent(EVENT_SUMMON_BLACK_KNIGHT, 3s);
                            break;
                    }
                    break;
                case DATA_GRAND_CHAMPION_REACHED_DEST:
                    if (shortver)
                        break;
                    switch (uiData)
                    {
                        case 0:
                            events.ScheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_2, 0ms);
                            break;
                        case 1:
                            events.ScheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_3, 0ms);
                            break;
                        case 2:
                            if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                            {
                                InstanceProgress = INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST;
                                uiData = DONE; // save to db
                                announcer->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                                announcer->GetMotionMaster()->MovePoint(1, 735.81f, 661.92f, 412.39f);
                                events.ScheduleEvent(EVENT_GRAND_GROUP_1_MOVE_MIDDLE, 8500ms);
                            }
                            break;
                    }
                    break;
                case DATA_MOUNT_DIED:
                    switch (InstanceProgress)
                    {
                        case INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST: // fighting group 1/3
                            if (++Counter >= 3)
                            {
                                Counter = 0;
                                InstanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1;
                                uiData = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_GROUP_2_MOVE_MIDDLE, 0ms);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1: // fighting group 2/3
                            if (++Counter >= 3)
                            {
                                Counter = 0;
                                InstanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2;
                                uiData = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_GROUP_3_MOVE_MIDDLE, 0ms);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2: // fighting group 3/3
                            if (++Counter >= 3)
                            {
                                Counter = 0;
                                InstanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3;
                                uiData = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOVE_MIDDLE, 0ms);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3: // fighting grand champions (on vehicles)
                            if (++Counter >= 3)
                            {
                                Counter = 0;
                                InstanceProgress = INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED;
                                for (ObjectGuid const& guid : VehicleList)
                                    if (Creature* veh = instance->GetCreature(guid))
                                        veh->DespawnOrUnsummon();
                                events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOVE_SIDE, 0ms);
                            }
                            break;
                    }
                    break;
                case DATA_REACHED_NEW_MOUNT:
                    --Counter;
                    break;
                case DATA_GRAND_CHAMPION_DIED:
                    if (++Counter >= 3)
                    {
                        Counter = 0;
                        VehicleList.clear();
                        uiData = DONE;
                        InstanceProgress = INSTANCE_PROGRESS_CHAMPIONS_DEAD;
                        m_auiEncounter[0] = DONE;
                        bool creditCasted = false;
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]))
                            {
                                c->GetMotionMaster()->MovePoint(9, 747.36f, 670.07f, 411.9f);
                                if (!creditCasted)
                                {
                                    c->CastSpell((Unit*)nullptr, 68572, true);
                                    creditCasted = true;
                                }
                            }
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                        {
                            announcer->GetMotionMaster()->MovePoint(0, 743.14f, 628.77f, 411.2f);
                            announcer->SummonGameObject(instance->IsHeroic() ? GO_CHAMPIONS_LOOT_H : GO_CHAMPIONS_LOOT, 746.59f, 618.49f, 411.09f, 1.42f, 0, 0, 0, 0, 90000000); // [LOOT]
                            events.ScheduleEvent(EVENT_RESTORE_ANNOUNCER_GOSSIP, 15s);
                            events.ScheduleEvent(EVENT_GRATZ_SLAIN_CHAMPIONS, 6s);
                        }

                        // bind players to instance
                        if (instance->IsHeroic())
                            instance->ToInstanceMap()->PermBindAllPlayers();
                    }
                    break;
                case DATA_ARGENT_SOLDIER_DEFEATED:
                    if (++Counter >= 9)
                    {
                        Counter = 0;
                        InstanceProgress = INSTANCE_PROGRESS_ARGENT_SOLDIERS_DIED;
                        uiData = DONE; // save to db
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_MOVE_FORWARD, 0ms);
                    }
                    break;
                case BOSS_ARGENT_CHALLENGE:
                    {
                        m_auiEncounter[1] = uiData;
                        if (uiData == DONE)
                        {
                            HandleGameObject(GO_EnterGateGUID, true);
                            InstanceProgress = INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED;
                            events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_RUN_MIDDLE, 0ms);
                        }
                    }
                    break;
                case DATA_MEMORY_ENTRY:
                    NPC_MemoryEntry = uiData;
                    break;
                case DATA_SKELETAL_GRYPHON_LANDED:
                    {
                        events.ScheduleEvent(EVENT_START_BLACK_KNIGHT_SCENE, 3s);
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
                        else if (uiData == DONE)
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

            if (uiData == DONE)
                SaveToDB();
        }

        void DoSummonGrandChampion(uint32 BossNumber, uint8 BossOrder)
        {
            uint32 CHAMPION_TO_SUMMON = 0;
            uint32 MINION_TO_SUMMON = 0;
            int32 TEXT_ID = 0;

            switch (BossNumber)
            {
                case 0:
                    CHAMPION_TO_SUMMON = NPC_MOKRA;
                    MINION_TO_SUMMON = NPC_ORGRIMMAR_MINION;
                    TEXT_ID = SAY_GRAND_CHAMPIONS_INTRO_SKULLCRUSHER;
                    break;
                case 1:
                    CHAMPION_TO_SUMMON = NPC_ERESSEA;
                    MINION_TO_SUMMON = NPC_SILVERMOON_MINION;
                    TEXT_ID = SAY_GRAND_CHAMPIONS_INTRO_DAWNSINGER;
                    break;
                case 2:
                    CHAMPION_TO_SUMMON = NPC_RUNOK;
                    MINION_TO_SUMMON = NPC_THUNDER_BLUFF_MINION;
                    TEXT_ID = SAY_GRAND_CHAMPIONS_INTRO_WILDMANE;
                    break;
                case 3:
                    CHAMPION_TO_SUMMON = NPC_ZULTORE;
                    MINION_TO_SUMMON = NPC_SENJIN_MINION;
                    TEXT_ID = SAY_GRAND_CHAMPIONS_INTRO_ZULTORE;
                    break;
                case 4:
                    CHAMPION_TO_SUMMON = NPC_VISCERI;
                    MINION_TO_SUMMON = NPC_UNDERCITY_MINION;
                    TEXT_ID = SAY_GRAND_CHAMPIONS_INTRO_DEATHSTALKER;
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

            if (Creature* pBoss = instance->SummonCreature(CHAMPION_TO_SUMMON, SpawnPos))
            {
                NPC_GrandChampionGUID[BossOrder] = pBoss->GetGUID();
                pBoss->ToCreature()->SetReactState(REACT_PASSIVE);
                pBoss->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED);
                pBoss->SetImmuneToAll(true);
                pBoss->ToCreature()->SetHomePosition(748.309f, 619.448f, 411.3f, M_PI / 2);
                pBoss->AI()->SetData(BossOrder, (shortver ? 1 : 0));

                for( uint8 i = 0; i < 3; ++i )
                    if (Creature* pAdd = instance->SummonCreature(MINION_TO_SUMMON, SpawnPos))
                    {
                        NPC_GrandChampionMinionsGUID[BossOrder][i] = pAdd->GetGUID();
                        pAdd->SetReactState(REACT_PASSIVE);
                        pAdd->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        pAdd->SetImmuneToAll(true);
                        pAdd->SetHomePosition(748.309f, 619.448f, 411.3f, M_PI / 2);
                        pAdd->GetMotionMaster()->MoveFollow(pBoss, 2.0f, (i + 1)*M_PI / 2);
                    }
            }

            if (!shortver)
                if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                {
                    announcer->AI()->Talk(TEXT_ID); /// @todo: Missing Argent Raid Spectator cheers.
                }
        }

        void Update(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_NULL:
                    break;
                case EVENT_CHECK_PLAYERS:
                    {
                        if (DoNeedCleanup())
                        {
                            InstanceCleanup();
                        }
                        events.RepeatEvent(CLEANUP_CHECK_INTERVAL);
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_1:
                    {
                        temp1 = urand(0, 4);
                        DoSummonGrandChampion(temp1, 0);
                        HandleGameObject(GO_MainGateGUID, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6s);
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_2:
                    {
                        do { temp2 = urand(0, 4); }
                        while( temp1 == temp2 );
                        DoSummonGrandChampion(temp2, 1);
                        HandleGameObject(GO_MainGateGUID, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6s);
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_3:
                    {
                        uint8 number = 0;
                        do { number = urand(0, 4); }
                        while( number == temp1 || number == temp2 );
                        DoSummonGrandChampion(number, 2);
                        HandleGameObject(GO_MainGateGUID, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6000);
                    }
                    break;
                case EVENT_CLOSE_GATE:
                    {
                        HandleGameObject(GO_MainGateGUID, false);
                    }
                    break;
                case EVENT_YELL_WELCOME_2:
                    {
                        if (Creature* tirion = instance->GetCreature(NPC_TirionGUID))
                        {
                            tirion->AI()->Talk(TEXT_WELCOME_2);
                        }

                        events.RescheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_1, 8s);
                        break;
                    }
                case EVENT_GRAND_GROUP_1_MOVE_MIDDLE:
                    {
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                        {
                            announcer->SetFacingTo(4.714f);
                            if (Creature* tirion = instance->GetCreature(NPC_TirionGUID))
                                tirion->AI()->Talk(TEXT_BEGIN);
                            HandleGameObject(GO_EnterGateGUID, false);
                        }
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[1][i]))
                            {
                                float angle = rand_norm() * 2 * M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f + 3.0f * cos(angle), 619.448f + 3.0f * std::sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_1_ATTACK, 3s);
                    }
                    break;
                case EVENT_GRAND_GROUP_1_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[1][i]))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->SetImmuneToAll(false);
                                if (Unit* target = c->SelectNearestTarget(200.0f))
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        Counter = 0;
                    }
                    break;
                case EVENT_GRAND_GROUP_2_MOVE_MIDDLE:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[0][i]))
                            {
                                float angle = rand_norm() * 2 * M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f + 3.0f * cos(angle), 619.448f + 3.0f * std::sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_2_ATTACK, 3s);
                    }
                    break;
                case EVENT_GRAND_GROUP_2_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[0][i]))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->SetImmuneToAll(false);
                                if (Unit* target = c->SelectNearestTarget(200.0f))
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                    }
                    break;
                case EVENT_GRAND_GROUP_3_MOVE_MIDDLE:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[2][i]))
                            {
                                float angle = rand_norm() * 2 * M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f + 3.0f * cos(angle), 619.448f + 3.0f * std::sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_3_ATTACK, 3s);
                    }
                    break;
                case EVENT_GRAND_GROUP_3_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionMinionsGUID[2][i]))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->SetImmuneToAll(false);
                                if (Unit* target = c->SelectNearestTarget(200.0f))
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_MOVE_MIDDLE:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]))
                            {
                                float angle = rand_norm() * 2 * M_PI;
                                c->GetMotionMaster()->MovePoint(4, 748.309f + 3.0f * cos(angle), 619.448f + 3.0f * std::sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOUNTS_ATTACK, 3s);
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_MOUNTS_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->SetImmuneToAll(false);
                                if (Unit* target = c->SelectNearestTarget(200.0f))
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                                c->CastSpell(c, 67865, true); // SPELL_TRAMPLE_AURA
                            }
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_MOVE_SIDE:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]))
                            {
                                c->AI()->DoAction(1);
                                switch (i)
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

                        events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_ATTACK, 15s);
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(NPC_GrandChampionGUID[i]))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->SetImmuneToAll(false);
                                if (Unit* target = c->SelectNearestTarget(200.0f))
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                                c->AI()->DoAction(2);
                            }
                    }
                    break;
                case EVENT_GRATZ_SLAIN_CHAMPIONS:
                    {
                        if (Creature* tirion = instance->GetCreature(NPC_TirionGUID))
                            tirion->AI()->Talk(TEXT_GRATZ_SLAIN_CHAMPIONS);

                        HandleGameObject(GO_EnterGateGUID, true);
                    }
                    break;
                case EVENT_RESTORE_ANNOUNCER_GOSSIP:
                    {
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                            announcer->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    }
                    break;
                case EVENT_START_ARGENT_CHALLENGE_INTRO:
                    {
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                        {
                            if (GameObject* gate = instance->GetGameObject(GO_MainGateGUID))
                            {
                                announcer->SetFacingToObject(gate);
                                HandleGameObject(GO_MainGateGUID, true, gate);
                                HandleGameObject(GO_EnterGateGUID, false, gate);
                            }
                        }

                        for( int8 i = 0; i < 3; ++i )
                        {
                            Position pos(SpawnPosition);
                            float x = pos.GetPositionX();

                            pos.m_positionX = x - 2.0f + (i - 1) * 10.0f;
                            if (Creature* pTrash = instance->SummonCreature(NPC_ARGENT_LIGHTWIELDER, pos))
                            {
                                pTrash->AI()->SetData(i, 0);
                                NPC_ArgentSoldierGUID[i][0] = pTrash->GetGUID();
                            }
                            pos.m_positionX = x + (i - 1) * 10.0f;
                            if (Creature* pTrash = instance->SummonCreature(NPC_ARGENT_MONK, pos))
                            {
                                pTrash->AI()->SetData(i, 0);
                                NPC_ArgentSoldierGUID[i][1] = pTrash->GetGUID();
                            }
                            pos.m_positionX = x + 2.0f + (i - 1) * 10.0f;
                            if (Creature* pTrash = instance->SummonCreature(NPC_PRIESTESS, pos))
                            {
                                pTrash->AI()->SetData(i, 0);
                                NPC_ArgentSoldierGUID[i][2] = pTrash->GetGUID();
                            }
                        }
                        events.ScheduleEvent(EVENT_SUMMON_ARGENT_CHALLENGE, 4s);
                    }
                    break;
                case EVENT_SUMMON_ARGENT_CHALLENGE:
                    {
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                            announcer->GetMotionMaster()->MovePoint(0, 735.81f, 661.92f, 412.39f);
                        if (Creature* boss = instance->SummonCreature(Counter ? NPC_EADRIC : NPC_PALETRESS, SpawnPosition))
                            boss->GetMotionMaster()->MovePoint(0, 746.881f, 660.263f, 411.7f);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 5s);
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_SAY_1, 4s);
                        events.ScheduleEvent(EVENT_ARGENT_SOLDIER_GROUP_ATTACK, 12s + 500ms);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_SAY_1:
                    {
                        if (Creature* ac = instance->GetCreature(NPC_ArgentChampionGUID))
                            ac->AI()->Talk(Counter ? SAY_EADRIC_INTRO : SAY_PALETRESS_INTRO_1);
                        if (!Counter)
                            events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_SAY_2, 6s);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_SAY_2:
                    {
                        if (Creature* ac = instance->GetCreature(NPC_ArgentChampionGUID))
                            ac->AI()->Talk(SAY_PALETRESS_INTRO_2);
                    }
                    break;
                case EVENT_ARGENT_SOLDIER_GROUP_ATTACK:
                    {
                        Counter = 0;
                        for( uint8 i = 0; i < 3; ++i )
                            for( uint8 j = 0; j < 3; ++j )
                                if (Creature* c = instance->GetCreature(NPC_ArgentSoldierGUID[i][j]))
                                {
                                    c->SetReactState(REACT_AGGRESSIVE);
                                    c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                    c->SetImmuneToAll(false);
                                    //c->AI()->DoZoneInCombat();
                                }
                        if (Creature* tirion = instance->GetCreature(NPC_TirionGUID))
                            tirion->AI()->Talk(TEXT_YOU_MAY_BEGIN);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_MOVE_FORWARD:
                    {
                        if (Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID))
                        {
                            boss->GetMotionMaster()->MovePoint(0, 746.881f, 635.263f, 411.7f);
                        }
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_ATTACK, 3s);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_ATTACK:
                    {
                        if (Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID))
                        {
                            boss->SetReactState(REACT_AGGRESSIVE);
                            boss->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            boss->SetImmuneToAll(false);
                            if (Unit* target = boss->SelectNearestTarget(200.0f))
                                boss->AI()->AttackStart(target);
                            boss->AI()->DoZoneInCombat();
                        }
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_RUN_MIDDLE:
                    {
                        if (Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID))
                        {
                            boss->GetMotionMaster()->MovePoint(1, 747.13f, 628.037f, 411.2f);
                            events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_LEAVE_CHEST, 6s);
                        }
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_LEAVE_CHEST:
                    {
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                            if (Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID))
                            {
                                announcer->GetMotionMaster()->MovePoint(0, 743.14f, 628.77f, 411.2f);
                                uint32 chest = 0;
                                if (instance->IsHeroic())
                                    chest = (boss->GetEntry() == NPC_EADRIC || boss->GetEntry() == NPC_EADRIC_H) ? GO_EADRIC_LOOT_H : GO_PALETRESS_LOOT_H;
                                else
                                    chest = (boss->GetEntry() == NPC_EADRIC || boss->GetEntry() == NPC_EADRIC_H) ? GO_EADRIC_LOOT : GO_PALETRESS_LOOT;
                                announcer->SummonGameObject(chest, 746.59f, 618.49f, 411.09f, 1.42f, 0, 0, 0, 0, 90000000); // [LOOT]
                            }

                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_DISAPPEAR, 4s);
                        events.ScheduleEvent(EVENT_RESTORE_ANNOUNCER_GOSSIP, 15s);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_DISAPPEAR:
                    {
                        if (Creature* boss = instance->GetCreature(NPC_ArgentChampionGUID))
                        {
                            boss->GetMotionMaster()->MovePoint(0, SpawnPosition);
                            boss->DespawnOrUnsummon(3000);
                        }
                    }
                    break;
                case EVENT_SUMMON_BLACK_KNIGHT:
                    {
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                            if (Creature* bk_vehicle = announcer->SummonCreature(VEHICLE_BLACK_KNIGHT, 769.834f, 651.915f, 447.035f, 0.0f))
                            {
                                NPC_BlackKnightVehicleGUID = bk_vehicle->GetGUID();
                                bk_vehicle->SetReactState(REACT_PASSIVE);
                                bk_vehicle->SetFacingTo(M_PI);
                                if (Vehicle* v = bk_vehicle->GetVehicleKit())
                                    if (Unit* bk = v->GetPassenger(0))
                                    {
                                        NPC_BlackKnightGUID = bk->GetGUID();
                                        bk->SendMovementFlagUpdate(); // put him on vehicle visually
                                        if (bk->IsCreature())
                                            bk->ToCreature()->SetReactState(REACT_PASSIVE);
                                    }

                                announcer->SetFacingToObject(bk_vehicle);
                                announcer->AI()->Talk(SAY_KNIGHT_INTRO);
                            }
                    }
                    break;
                case EVENT_START_BLACK_KNIGHT_SCENE:
                    {
                        if (Creature* bk = instance->GetCreature(NPC_BlackKnightGUID))
                        {
                            Position exitPos = { 751.003357f, 638.145508f, 411.570129f, M_PI };
                            bk->ExitVehicle(/*&exitPos*/);
                            bk->GetMotionMaster()->MoveJump(exitPos, 2.0f, 2.0f);
                            bk->AI()->Talk(SAY_BK_INTRO_1);
                        }
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_CAST_ANNOUNCER, 2s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_CAST_ANNOUNCER:
                    {
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                        {
                            if (Creature* bk = instance->GetCreature(NPC_BlackKnightGUID))
                            {
                                bk->SetPosition(745.016f, 631.506f, 411.575f, bk->GetAngle(announcer));
                                bk->SetHomePosition(*bk);
                                bk->SetFacingToObject(announcer);
                                announcer->SetFacingToObject(bk);
                                announcer->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                bk->AddAura(68306, announcer); // spell has attribute player only
                                if (Creature* tirion = instance->GetCreature(NPC_TirionGUID))
                                    tirion->AI()->Talk(TEXT_BK_MEANING);
                            }
                        }
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_KILL_ANNOUNCER, 1s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_KILL_ANNOUNCER:
                    {
                        if (Creature* bk_vehicle = instance->GetCreature(NPC_BlackKnightVehicleGUID))
                            bk_vehicle->AI()->DoAction(1);

                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_MOVE_FORWARD, 4s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_MOVE_FORWARD:
                    {
                        if (Creature* bk = instance->GetCreature(NPC_BlackKnightGUID))
                        {
                            bk->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                            bk->GetMotionMaster()->MovePoint(0, 746.81f, 623.15f, 411.42f);
                            bk->AI()->Talk(SAY_BK_INTRO_2);
                        }
                        if (Creature* announcer = instance->GetCreature(NPC_AnnouncerGUID))
                            if (announcer->IsAlive())
                                Unit::Kill(announcer, announcer);
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_SAY_TASK, 14s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_SAY_TASK:
                    {
                        if (Creature* bk = instance->GetCreature(NPC_BlackKnightGUID))
                        {
                            bk->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            bk->AI()->Talk(SAY_BK_INTRO_3);
                        }
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_ATTACK, 5s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_ATTACK:
                    {
                        if (Creature* bk = instance->GetCreature(NPC_BlackKnightGUID))
                        {
                            bk->SetReactState(REACT_AGGRESSIVE);
                            bk->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                            if (Unit* target = bk->SelectNearestTarget(200.0f))
                                bk->AI()->AttackStart(target);
                            bk->AI()->DoZoneInCombat();
                            bk->AI()->DoAction(1);
                        }
                    }
                    break;
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
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
