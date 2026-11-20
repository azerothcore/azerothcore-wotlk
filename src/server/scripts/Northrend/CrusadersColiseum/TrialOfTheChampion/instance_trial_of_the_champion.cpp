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

#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Vehicle.h"
#include "trial_of_the_champion.h"

const Position SpawnPosition = {746.67f, 684.08f, 412.5f, 4.65f};

ObjectData const creatureData[] =
{
    { NPC_JAEREN,           DATA_ANNOUNCER              },
    { NPC_ARELAS,           DATA_ANNOUNCER              },
    { NPC_TIRION,           DATA_TIRION                 },
    { NPC_EADRIC,           DATA_PALETRESS              },
    { NPC_PALETRESS,        DATA_PALETRESS              },
    { NPC_BLACK_KNIGHT,     DATA_BLACK_KNIGHT           },
    { VEHICLE_BLACK_KNIGHT, DATA_BLACK_KNIGHT_VEHICLE   },
    { 0,                    0                           }
};

ObjectData const gameobjectData[] =
{
    { GO_MAIN_GATE,         DATA_MAIN_GATE              },
    { GO_NORTH_PORTCULLIS,  DATA_ENTER_GATE             },
    { 0,                    0                           }
};

enum AchievementCriteria
{
    CRITERIA_IVE_HAD_WORSE              = 11789,
    CRITERIA_MEMORY_HOGGER              = 11863,
    CRITERIA_MEMORY_VANCLEEF            = 11904,
    CRITERIA_MEMORY_MUTANUS             = 11905,
    CRITERIA_MEMORY_HEROD               = 11906,
    CRITERIA_MEMORY_LUCIFRON            = 11907,
    CRITERIA_MEMORY_THUNDERAAN          = 11908,
    CRITERIA_MEMORY_CHROMAGGUS          = 11909,
    CRITERIA_MEMORY_HAKKAR              = 11910,
    CRITERIA_MEMORY_VEKNILASH           = 11911,
    CRITERIA_MEMORY_KALITHRESH          = 11912,
    CRITERIA_MEMORY_MALCHEZAAR          = 11913,
    CRITERIA_MEMORY_GRUUL               = 11914,
    CRITERIA_MEMORY_VASHJ               = 11915,
    CRITERIA_MEMORY_ARCHIMONDE          = 11916,
    CRITERIA_MEMORY_ILLIDAN             = 11917,
    CRITERIA_MEMORY_DELRISSA            = 11918,
    CRITERIA_MEMORY_ENTROPIUS           = 11919,
    CRITERIA_MEMORY_INGVAR              = 11920,
    CRITERIA_MEMORY_CYANIGOSA           = 11921,
    CRITERIA_MEMORY_ECK                 = 11922,
    CRITERIA_MEMORY_ONYXIA              = 11923,
    CRITERIA_MEMORY_HEIGAN              = 11924,
    CRITERIA_MEMORY_IGNIS               = 11925,
    CRITERIA_MEMORY_VEZAX               = 11926,
    CRITERIA_MEMORY_ALGALON             = 11927,
};

struct MemoryCriteria
{
    uint32 criteriaId;
    uint32 memoryEntry;
};

// the Argent Challenge summons one memory at random, each one credits its own criteria
MemoryCriteria const MemoryCriteriaTable[] =
{
    { CRITERIA_MEMORY_HOGGER,      NPC_MEMORY_HOGGER      },
    { CRITERIA_MEMORY_VANCLEEF,    NPC_MEMORY_VANCLEEF    },
    { CRITERIA_MEMORY_MUTANUS,     NPC_MEMORY_MUTANUS     },
    { CRITERIA_MEMORY_HEROD,       NPC_MEMORY_HEROD       },
    { CRITERIA_MEMORY_LUCIFRON,    NPC_MEMORY_LUCIFRON    },
    { CRITERIA_MEMORY_THUNDERAAN,  NPC_MEMORY_THUNDERAAN  },
    { CRITERIA_MEMORY_CHROMAGGUS,  NPC_MEMORY_CHROMAGGUS  },
    { CRITERIA_MEMORY_HAKKAR,      NPC_MEMORY_HAKKAR      },
    { CRITERIA_MEMORY_VEKNILASH,   NPC_MEMORY_VEKNILASH   },
    { CRITERIA_MEMORY_KALITHRESH,  NPC_MEMORY_KALITHRESH  },
    { CRITERIA_MEMORY_MALCHEZAAR,  NPC_MEMORY_MALCHEZAAR  },
    { CRITERIA_MEMORY_GRUUL,       NPC_MEMORY_GRUUL       },
    { CRITERIA_MEMORY_VASHJ,       NPC_MEMORY_VASHJ       },
    { CRITERIA_MEMORY_ARCHIMONDE,  NPC_MEMORY_ARCHIMONDE  },
    { CRITERIA_MEMORY_ILLIDAN,     NPC_MEMORY_ILLIDAN     },
    { CRITERIA_MEMORY_DELRISSA,    NPC_MEMORY_DELRISSA    },
    { CRITERIA_MEMORY_ENTROPIUS,   NPC_MEMORY_ENTROPIUS   },
    { CRITERIA_MEMORY_INGVAR,      NPC_MEMORY_INGVAR      },
    { CRITERIA_MEMORY_CYANIGOSA,   NPC_MEMORY_CYANIGOSA   },
    { CRITERIA_MEMORY_ECK,         NPC_MEMORY_ECK         },
    { CRITERIA_MEMORY_ONYXIA,      NPC_MEMORY_ONYXIA      },
    { CRITERIA_MEMORY_HEIGAN,      NPC_MEMORY_HEIGAN      },
    { CRITERIA_MEMORY_IGNIS,       NPC_MEMORY_IGNIS       },
    { CRITERIA_MEMORY_VEZAX,       NPC_MEMORY_VEZAX       },
    { CRITERIA_MEMORY_ALGALON,     NPC_MEMORY_ALGALON     },
};

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

class instance_trial_of_the_champion : public InstanceMapScript
{
public:
    instance_trial_of_the_champion() : InstanceMapScript(TrialOfTheChampionScriptName, MAP_TRIAL_OF_THE_CHAMPION) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_trial_of_the_champion_InstanceMapScript(map);
    }

    struct instance_trial_of_the_champion_InstanceMapScript : public InstanceScript
    {
        instance_trial_of_the_champion_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadObjectData(creatureData, gameobjectData);
        }

        bool _cleaned = false;
        uint32 _instanceProgress = INSTANCE_PROGRESS_INITIAL;

        GuidList _vehicleList;
        EventMap events;
        uint8 _counter = 0;
        uint8 _champion1 = 0;
        uint8 _champion2 = 0;
        bool _shortVersion = false;
        bool _achievementIveHadWorse = true;

        // creatures the instance summons in groups of up to three share an entry, so they are
        // tracked here and not through the object data table
        ObjectGuid _grandChampionGUID[3];
        ObjectGuid _grandChampionMinionsGUID[3][3];
        ObjectGuid _argentSoldierGUID[3][3];
        uint32 _memoryEntry = 0;

        void Initialize() override
        {
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0ms);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                // Grand Champions:
                case NPC_MOKRA:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_JACOB);
                    break;
                case NPC_ERESSEA:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_AMBROSE);
                    break;
                case NPC_RUNOK:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_COLOSOS);
                    break;
                case NPC_ZULTORE:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_JAELYNE);
                    break;
                case NPC_VISCERI:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_LANA);
                    break;

                // Grand Champion Minions:
                case NPC_ORGRIMMAR_MINION:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_STORMWIND_MINION);
                    break;
                case NPC_SILVERMOON_MINION:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_GNOMEREGAN_MINION);
                    break;
                case NPC_THUNDER_BLUFF_MINION:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_EXODAR_MINION);
                    break;
                case NPC_SENJIN_MINION:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_DARNASSUS_MINION);
                    break;
                case NPC_UNDERCITY_MINION:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        creature->UpdateEntry(NPC_IRONFORGE_MINION);
                    break;

                // Coliseum Announcer:
                case NPC_JAEREN:
                case NPC_ARELAS:
                    creature->SetReactState(REACT_PASSIVE);
                    break;

                // Beginning vehicles:
                case VEHICLE_ARGENT_WARHORSE:
                case VEHICLE_ARGENT_BATTLEWORG:
                    if (_instanceProgress < INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED && !IsBossDone(BOSS_GRAND_CHAMPIONS))
                        _vehicleList.push_back(creature->GetGUID());
                    else
                        creature->DespawnOrUnsummon();
                    break;
            }
            if (creature->GetMountID())
                if (CreatureAddon const* addon = creature->GetCreatureAddon())
                    if (addon->mount != creature->GetMountID())
                        creature->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, addon->mount);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            switch (go->GetEntry())
            {
                case GO_MAIN_GATE:
                    HandleGameObject(go->GetGUID(), false, go);
                    break;
                case GO_SOUTH_PORTCULLIS:
                case GO_EAST_PORTCULLIS:
                    HandleGameObject(go->GetGUID(), false, go);
                    break;
                case GO_NORTH_PORTCULLIS:
                    HandleGameObject(go->GetGUID(), true, go);
                    break;
            }
        }

        // the boss states alone do not describe how far the arena roleplay got, so the progress
        // counter is saved next to them
        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _instanceProgress;
            if (_instanceProgress == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED)
                _instanceProgress = INSTANCE_PROGRESS_INITIAL;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _instanceProgress;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case BOSS_ARGENT_CHALLENGE:
                    if (state == DONE)
                    {
                        HandleGameObject(DATA_ENTER_GATE, true);
                        _instanceProgress = INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED;
                        SaveToDB();
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_RUN_MIDDLE, 0ms);
                    }
                    break;
                case BOSS_BLACK_KNIGHT:
                    if (state == NOT_STARTED)
                        _achievementIveHadWorse = true;
                    else if (state == DONE)
                    {
                        HandleGameObject(DATA_ENTER_GATE, true);
                        _instanceProgress = INSTANCE_PROGRESS_FINISHED;
                        SaveToDB();
                    }
                    break;
                default:
                    break;
            }

            return true;
        }

        // EVENT STUFF BELOW:

        void OnPlayerEnter(Player* player) override
        {
            InstanceScript::OnPlayerEnter(player);

            if (DoNeedCleanup(player))
                InstanceCleanup();

            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
        }

        bool DoNeedCleanup(Player* ignoredPlayer = nullptr)
        {
            uint8 aliveCount = 0;
            for (auto const& itr: instance->GetPlayers())
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
            if (!need && _cleaned)
            {
                _cleaned = false;
            }

            return need;
        }

        void InstanceCleanup()
        {
            if (_cleaned)
                return;

            switch (_instanceProgress)
            {
                case INSTANCE_PROGRESS_INITIAL:
                    break;
                case INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2:
                case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3:
                    // revert to INSTANCE_PROGRESS_INITIAL
                    {
                        for (ObjectGuid const& guid : _vehicleList)
                            if (Creature* veh = instance->GetCreature(guid))
                                veh->DespawnOrUnsummon(0ms, 3s);
                        _vehicleList.clear();
                        for( uint8 i = 0; i < 3; ++i )
                        {
                            for( uint8 j = 0; j < 3; ++j )
                            {
                                if (Creature* c = instance->GetCreature(_grandChampionMinionsGUID[i][j]))
                                    c->DespawnOrUnsummon();
                                _grandChampionMinionsGUID[i][j].Clear();
                            }
                            if (Creature* c = instance->GetCreature(_grandChampionGUID[i]))
                                c->DespawnOrUnsummon();
                            _grandChampionGUID[i].Clear();
                        }
                        if (Creature* c = GetCreature(DATA_ANNOUNCER))
                        {
                            c->SetHomePosition(748.309f, 619.488f, 411.172f, 4.71239f);
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                            c->DespawnOrUnsummon(0ms, 3s);
                        }
                        _instanceProgress = INSTANCE_PROGRESS_INITIAL;
                    }
                    break;
                case INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED:
                    {
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                        {
                            announcer->SetHomePosition(735.81f, 661.92f, 412.39f, 4.714f);
                            announcer->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

                            for( uint8 i = 0; i < 3; ++i )
                                if (Creature* c = instance->GetCreature(_grandChampionGUID[i]))
                                {
                                    uint32 entry = c->GetEntry();
                                    c->DespawnOrUnsummon();
                                    switch (i)
                                    {
                                        case 0:
                                            if (Creature* champion = announcer->SummonCreature(entry,
                                                736.695f, 650.02f, 412.4f, 3 * M_PI / 2))
                                            {
                                                _grandChampionGUID[0] = champion->GetGUID();
                                                champion->AI()->SetData(0, 2);
                                            }
                                            break;
                                        case 1:
                                            if (Creature* champion = announcer->SummonCreature(entry,
                                                756.32f, 650.05f, 412.4f, 3 * M_PI / 2))
                                            {
                                                _grandChampionGUID[1] = champion->GetGUID();
                                                champion->AI()->SetData(1, 2);
                                            }
                                            break;
                                        case 2:
                                            if (Creature* champion = announcer->SummonCreature(entry,
                                                746.5f, 650.65f, 411.7f, 3 * M_PI / 2))
                                            {
                                                _grandChampionGUID[2] = champion->GetGUID();
                                                champion->AI()->SetData(2, 2);
                                            }
                                            break;
                                    }
                                }
                            announcer->DespawnOrUnsummon(0ms, 3s);
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
                                if (Creature* c = instance->GetCreature(_argentSoldierGUID[i][j]))
                                    c->DespawnOrUnsummon();
                                _argentSoldierGUID[i][j].Clear();
                            }
                        if (Creature* c = GetCreature(DATA_PALETRESS))
                        {
                            c->AI()->DoAction(ACTION_DESPAWN_MEMORY);
                            c->DespawnOrUnsummon();
                        }
                        if (Creature* c = GetCreature(DATA_ANNOUNCER))
                        {
                            c->SetHomePosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                            c->DespawnOrUnsummon(0ms, 3s);
                        }
                        _memoryEntry = 0;
                        _instanceProgress = INSTANCE_PROGRESS_CHAMPIONS_DEAD;
                    }
                    break;
                case INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED:
                    // revert to INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED
                    {
                        if (Creature* c = GetCreature(DATA_BLACK_KNIGHT_VEHICLE))
                            c->DespawnOrUnsummon();
                        if (Creature* c = GetCreature(DATA_BLACK_KNIGHT))
                        {
                            c->AI()->DoAction(ACTION_DESPAWN_SUMMONS);
                            c->DespawnOrUnsummon();
                        }
                        if (Creature* c = GetCreature(DATA_ANNOUNCER))
                        {
                            c->SetHomePosition(743.14f, 628.77f, 411.2f, 4.71239f);
                            c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                            c->DespawnOrUnsummon(0ms, 3s);
                        }
                        _instanceProgress = INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED;
                    }
                    break;
                case INSTANCE_PROGRESS_FINISHED:
                    if (Creature* c = GetCreature(DATA_ANNOUNCER))
                        c->DespawnOrUnsummon();
                    break;
            }

            HandleGameObject(DATA_MAIN_GATE, false);
            HandleGameObject(DATA_ENTER_GATE, true);
            _counter = 0;
            SaveToDB();
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);

            _cleaned = true;
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_INSTANCE_PROGRESS:
                    return _instanceProgress;
                case DATA_TEAMID_IN_INSTANCE:
                    return GetTeamIdInInstance();
            }

            return 0;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_ANNOUNCER_GOSSIP_SELECT:
                    switch (_instanceProgress)
                    {
                        case INSTANCE_PROGRESS_INITIAL:
                            if (data == 0) // normal intro
                            {
                                _shortVersion = false;

                                if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                                {
                                    if (GameObject* gate = GetGameObject(DATA_MAIN_GATE))
                                        announcer->SetFacingToObject(gate);
                                    if (Creature* tirion = GetCreature(DATA_TIRION))
                                        tirion->AI()->Talk(TEXT_WELCOME);
                                }
                                events.RescheduleEvent(EVENT_YELL_WELCOME_2, 8s);
                            }
                            else // short version
                            {
                                _shortVersion = true;

                                _champion1 = urand(0, 4);
                                DoSummonGrandChampion(_champion1, 0);
                                do { _champion2 = urand(0, 4); }
                                while( _champion1 == _champion2 );
                                DoSummonGrandChampion(_champion2, 1);
                                uint8 number = 0;
                                do { number = urand(0, 4); }
                                while( number == _champion1 || number == _champion2 );
                                DoSummonGrandChampion(number, 2);

                                _instanceProgress = INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST;
                                data = DONE; // save to db
                                if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                                {
                                    announcer->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                                    announcer->GetMotionMaster()->MovePoint(1, 735.81f, 661.92f, 412.39f);
                                }
                                events.ScheduleEvent(EVENT_GRAND_GROUP_1_MOVE_MIDDLE, 10s);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPIONS_DEAD:
                            if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                            {
                                _counter = urand(0, 1);
                                if (_counter)
                                    announcer->AI()->Talk(SAY_EADRIC_INTRO_ANNOUNCER);
                                else
                                    announcer->AI()->Talk(SAY_JAEREN_PALETRESS_INTRO);
                            }
                            HandleGameObject(DATA_ENTER_GATE, false);
                            events.RescheduleEvent(EVENT_START_ARGENT_CHALLENGE_INTRO, 0ms);
                            break;
                        case INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED:
                            if (Creature* tirion = GetCreature(DATA_TIRION))
                                tirion->AI()->Talk(TEXT_BK_INTRO);
                            events.RescheduleEvent(EVENT_SUMMON_BLACK_KNIGHT, 3s);
                            break;
                    }
                    break;
                case DATA_GRAND_CHAMPION_REACHED_DEST:
                    if (_shortVersion)
                        break;
                    switch (data)
                    {
                        case 0:
                            events.ScheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_2, 0ms);
                            break;
                        case 1:
                            events.ScheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_3, 0ms);
                            break;
                        case 2:
                            if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                            {
                                _instanceProgress = INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST;
                                data = DONE; // save to db
                                announcer->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                                announcer->GetMotionMaster()->MovePoint(1, 735.81f, 661.92f, 412.39f);
                                events.ScheduleEvent(EVENT_GRAND_GROUP_1_MOVE_MIDDLE, 8500ms);
                            }
                            break;
                    }
                    break;
                case DATA_MOUNT_DIED:
                    switch (_instanceProgress)
                    {
                        case INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST: // fighting group 1/3
                            if (++_counter >= 3)
                            {
                                _counter = 0;
                                _instanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1;
                                data = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_GROUP_2_MOVE_MIDDLE, 0ms);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1: // fighting group 2/3
                            if (++_counter >= 3)
                            {
                                _counter = 0;
                                _instanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2;
                                data = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_GROUP_3_MOVE_MIDDLE, 0ms);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2: // fighting group 3/3
                            if (++_counter >= 3)
                            {
                                _counter = 0;
                                _instanceProgress = INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3;
                                data = DONE; // save to db
                                events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOVE_MIDDLE, 0ms);
                            }
                            break;
                        case INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3: // fighting grand champions (on vehicles)
                            if (++_counter >= 3)
                            {
                                _counter = 0;
                                _instanceProgress = INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED;
                                for (ObjectGuid const& guid : _vehicleList)
                                    if (Creature* veh = instance->GetCreature(guid))
                                        veh->DespawnOrUnsummon();
                                events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOVE_SIDE, 0ms);
                            }
                            break;
                    }
                    break;
                case DATA_REACHED_NEW_MOUNT:
                    --_counter;
                    break;
                case DATA_GRAND_CHAMPION_DIED:
                    if (++_counter >= 3)
                    {
                        _counter = 0;
                        _vehicleList.clear();
                        data = DONE;
                        _instanceProgress = INSTANCE_PROGRESS_CHAMPIONS_DEAD;
                        SetBossState(BOSS_GRAND_CHAMPIONS, DONE);
                        bool creditCasted = false;
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionGUID[i]))
                            {
                                c->GetMotionMaster()->MovePoint(POINT_CHAMPION_LEAVE_ARENA, 747.36f, 670.07f, 411.9f);
                                if (!creditCasted)
                                {
                                    c->CastSpell((Unit*)nullptr, SPELL_GRAND_CHAMPIONS_CREDIT, true);
                                    creditCasted = true;
                                }
                            }
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                        {
                            announcer->GetMotionMaster()->MovePoint(0, 743.14f, 628.77f, 411.2f);
                            uint32 lootEntry = instance->IsHeroic() ? GO_CHAMPIONS_LOOT_H : GO_CHAMPIONS_LOOT;
                            announcer->SummonGameObject(lootEntry, 746.59f, 618.49f, 411.09f, 1.42f, 0, 0, 0, 0,
                                90000000); // [LOOT]
                            events.ScheduleEvent(EVENT_RESTORE_ANNOUNCER_GOSSIP, 15s);
                            events.ScheduleEvent(EVENT_GRATZ_SLAIN_CHAMPIONS, 6s);
                        }

                        // bind players to instance
                        if (instance->IsHeroic())
                            instance->ToInstanceMap()->PermBindAllPlayers();
                    }
                    break;
                case DATA_ARGENT_SOLDIER_DEFEATED:
                    if (++_counter >= 9)
                    {
                        _counter = 0;
                        _instanceProgress = INSTANCE_PROGRESS_ARGENT_SOLDIERS_DIED;
                        data = DONE; // save to db
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_MOVE_FORWARD, 0ms);
                    }
                    break;
                case DATA_MEMORY_ENTRY:
                    _memoryEntry = data;
                    break;
                case DATA_SKELETAL_GRYPHON_LANDED:
                    {
                        events.ScheduleEvent(EVENT_START_BLACK_KNIGHT_SCENE, 3s);
                    }
                    break;
                case DATA_ACHIEVEMENT_IVE_HAD_WORSE:
                    if (_achievementIveHadWorse)
                        _achievementIveHadWorse = false;
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        void DoSummonGrandChampion(uint32 championIndex, uint8 bossOrder)
        {
            uint32 championEntry = 0;
            uint32 minionEntry = 0;
            int32 introTextId = 0;

            switch (championIndex)
            {
                case 0:
                    championEntry = NPC_MOKRA;
                    minionEntry = NPC_ORGRIMMAR_MINION;
                    introTextId = SAY_GRAND_CHAMPIONS_INTRO_SKULLCRUSHER;
                    break;
                case 1:
                    championEntry = NPC_ERESSEA;
                    minionEntry = NPC_SILVERMOON_MINION;
                    introTextId = SAY_GRAND_CHAMPIONS_INTRO_DAWNSINGER;
                    break;
                case 2:
                    championEntry = NPC_RUNOK;
                    minionEntry = NPC_THUNDER_BLUFF_MINION;
                    introTextId = SAY_GRAND_CHAMPIONS_INTRO_WILDMANE;
                    break;
                case 3:
                    championEntry = NPC_ZULTORE;
                    minionEntry = NPC_SENJIN_MINION;
                    introTextId = SAY_GRAND_CHAMPIONS_INTRO_ZULTORE;
                    break;
                case 4:
                    championEntry = NPC_VISCERI;
                    minionEntry = NPC_UNDERCITY_MINION;
                    introTextId = SAY_GRAND_CHAMPIONS_INTRO_DEATHSTALKER;
                    break;
                default:
                    return;
            }

            Position SpawnPos = SpawnPosition;
            if (_shortVersion)
                switch (bossOrder)
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

            if (Creature* champion = instance->SummonCreature(championEntry, SpawnPos))
            {
                _grandChampionGUID[bossOrder] = champion->GetGUID();
                champion->ToCreature()->SetReactState(REACT_PASSIVE);
                champion->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED);
                champion->SetImmuneToAll(true);
                champion->ToCreature()->SetHomePosition(748.309f, 619.448f, 411.3f, M_PI / 2);
                champion->AI()->SetData(bossOrder, (_shortVersion ? 1 : 0));

                for( uint8 i = 0; i < 3; ++i )
                    if (Creature* minion = instance->SummonCreature(minionEntry, SpawnPos))
                    {
                        _grandChampionMinionsGUID[bossOrder][i] = minion->GetGUID();
                        minion->SetReactState(REACT_PASSIVE);
                        minion->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        minion->SetImmuneToAll(true);
                        minion->SetHomePosition(748.309f, 619.448f, 411.3f, M_PI / 2);
                        minion->GetMotionMaster()->MoveFollow(champion, 2.0f, (i + 1)*M_PI / 2);
                    }
            }

            if (!_shortVersion)
                if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                {
                    announcer->AI()->Talk(introTextId); /// @todo: Missing Argent Raid Spectator cheers.
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
                        events.Repeat(5s);
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_1:
                    {
                        _champion1 = urand(0, 4);
                        DoSummonGrandChampion(_champion1, 0);
                        HandleGameObject(DATA_MAIN_GATE, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6s);
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_2:
                    {
                        do { _champion2 = urand(0, 4); }
                        while( _champion1 == _champion2 );
                        DoSummonGrandChampion(_champion2, 1);
                        HandleGameObject(DATA_MAIN_GATE, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6s);
                    }
                    break;
                case EVENT_SUMMON_GRAND_CHAMPION_3:
                    {
                        uint8 number = 0;
                        do { number = urand(0, 4); }
                        while( number == _champion1 || number == _champion2 );
                        DoSummonGrandChampion(number, 2);
                        HandleGameObject(DATA_MAIN_GATE, true);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 6s);
                    }
                    break;
                case EVENT_CLOSE_GATE:
                    {
                        HandleGameObject(DATA_MAIN_GATE, false);
                    }
                    break;
                case EVENT_YELL_WELCOME_2:
                    {
                        if (Creature* tirion = GetCreature(DATA_TIRION))
                        {
                            tirion->AI()->Talk(TEXT_WELCOME_2);
                        }

                        events.RescheduleEvent(EVENT_SUMMON_GRAND_CHAMPION_1, 8s);
                        break;
                    }
                case EVENT_GRAND_GROUP_1_MOVE_MIDDLE:
                    {
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                        {
                            announcer->SetFacingTo(4.714f);
                            if (Creature* tirion = GetCreature(DATA_TIRION))
                                tirion->AI()->Talk(TEXT_BEGIN);
                            HandleGameObject(DATA_ENTER_GATE, false);
                        }
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionMinionsGUID[1][i]))
                            {
                                float angle = rand_norm() * 2 * M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f + 3.0f * cos(angle),
                                    619.448f + 3.0f * std::sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_1_ATTACK, 3s);
                    }
                    break;
                case EVENT_GRAND_GROUP_1_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionMinionsGUID[1][i]))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->SetImmuneToAll(false);
                                if (Unit* target = c->SelectNearestTarget(200.0f))
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                            }
                        _counter = 0;
                    }
                    break;
                case EVENT_GRAND_GROUP_2_MOVE_MIDDLE:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionMinionsGUID[0][i]))
                            {
                                float angle = rand_norm() * 2 * M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f + 3.0f * cos(angle),
                                    619.448f + 3.0f * std::sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_2_ATTACK, 3s);
                    }
                    break;
                case EVENT_GRAND_GROUP_2_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionMinionsGUID[0][i]))
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
                            if (Creature* c = instance->GetCreature(_grandChampionMinionsGUID[2][i]))
                            {
                                float angle = rand_norm() * 2 * M_PI;
                                c->GetMotionMaster()->MovePoint(0, 748.309f + 3.0f * cos(angle),
                                    619.448f + 3.0f * std::sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_GROUP_3_ATTACK, 3s);
                    }
                    break;
                case EVENT_GRAND_GROUP_3_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionMinionsGUID[2][i]))
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
                            if (Creature* c = instance->GetCreature(_grandChampionGUID[i]))
                            {
                                float angle = rand_norm() * 2 * M_PI;
                                c->GetMotionMaster()->MovePoint(POINT_CHAMPION_MOVE_MIDDLE,
                                    748.309f + 3.0f * cos(angle), 619.448f + 3.0f * std::sin(angle), 411.3f);
                            }

                        events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_MOUNTS_ATTACK, 3s);
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_MOUNTS_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionGUID[i]))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->SetImmuneToAll(false);
                                if (Unit* target = c->SelectNearestTarget(200.0f))
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                                c->CastSpell(c, SPELL_TRAMPLE_AURA, true);
                            }
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_MOVE_SIDE:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionGUID[i]))
                            {
                                c->AI()->DoAction(ACTION_DISMOUNT);
                                switch (i)
                                {
                                    case 0:
                                        c->GetMotionMaster()->MovePoint(POINT_CHAMPION_MOVE_SIDE, 736.695f,
                                            650.02f, 412.4f);
                                        break;
                                    case 1:
                                        c->GetMotionMaster()->MovePoint(POINT_CHAMPION_MOVE_SIDE, 756.32f,
                                            650.05f, 412.4f);
                                        break;
                                    case 2:
                                        c->GetMotionMaster()->MovePoint(POINT_CHAMPION_MOVE_SIDE, 746.5f,
                                            650.65f, 411.7f);
                                        break;
                                }
                            }

                        events.ScheduleEvent(EVENT_GRAND_CHAMPIONS_ATTACK, 15s);
                    }
                    break;
                case EVENT_GRAND_CHAMPIONS_ATTACK:
                    {
                        for( uint8 i = 0; i < 3; ++i )
                            if (Creature* c = instance->GetCreature(_grandChampionGUID[i]))
                            {
                                c->SetReactState(REACT_AGGRESSIVE);
                                c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                c->SetImmuneToAll(false);
                                if (Unit* target = c->SelectNearestTarget(200.0f))
                                    c->AI()->AttackStart(target);
                                c->AI()->DoZoneInCombat();
                                c->AI()->DoAction(ACTION_ENABLE_CHAMPION_ABILITIES);
                            }
                    }
                    break;
                case EVENT_GRATZ_SLAIN_CHAMPIONS:
                    {
                        if (Creature* tirion = GetCreature(DATA_TIRION))
                            tirion->AI()->Talk(TEXT_GRATZ_SLAIN_CHAMPIONS);

                        HandleGameObject(DATA_ENTER_GATE, true);
                    }
                    break;
                case EVENT_RESTORE_ANNOUNCER_GOSSIP:
                    {
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                            announcer->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    }
                    break;
                case EVENT_START_ARGENT_CHALLENGE_INTRO:
                    {
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                        {
                            if (GameObject* gate = GetGameObject(DATA_MAIN_GATE))
                            {
                                announcer->SetFacingToObject(gate);
                                // upstream passed the main gate pointer to both calls, so the enter gate is left alone
                                HandleGameObject(DATA_MAIN_GATE, true);
                                HandleGameObject(DATA_MAIN_GATE, false);
                            }
                        }

                        for( int8 i = 0; i < 3; ++i )
                        {
                            Position pos(SpawnPosition);
                            float x = pos.GetPositionX();

                            pos.m_positionX = x - 2.0f + (i - 1) * 10.0f;
                            if (Creature* soldier = instance->SummonCreature(NPC_ARGENT_LIGHTWIELDER, pos))
                            {
                                soldier->AI()->SetData(i, 0);
                                _argentSoldierGUID[i][0] = soldier->GetGUID();
                            }
                            pos.m_positionX = x + (i - 1) * 10.0f;
                            if (Creature* soldier = instance->SummonCreature(NPC_ARGENT_MONK, pos))
                            {
                                soldier->AI()->SetData(i, 0);
                                _argentSoldierGUID[i][1] = soldier->GetGUID();
                            }
                            pos.m_positionX = x + 2.0f + (i - 1) * 10.0f;
                            if (Creature* soldier = instance->SummonCreature(NPC_PRIESTESS, pos))
                            {
                                soldier->AI()->SetData(i, 0);
                                _argentSoldierGUID[i][2] = soldier->GetGUID();
                            }
                        }
                        events.ScheduleEvent(EVENT_SUMMON_ARGENT_CHALLENGE, 4s);
                    }
                    break;
                case EVENT_SUMMON_ARGENT_CHALLENGE:
                    {
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                            announcer->GetMotionMaster()->MovePoint(0, 735.81f, 661.92f, 412.39f);
                        if (Creature* boss = instance->SummonCreature(_counter ? NPC_EADRIC : NPC_PALETRESS,
                            SpawnPosition))
                            boss->GetMotionMaster()->MovePoint(0, 746.881f, 660.263f, 411.7f);
                        events.ScheduleEvent(EVENT_CLOSE_GATE, 5s);
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_SAY_1, 4s);
                        events.ScheduleEvent(EVENT_ARGENT_SOLDIER_GROUP_ATTACK, 12s + 500ms);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_SAY_1:
                    {
                        if (Creature* ac = GetCreature(DATA_PALETRESS))
                            ac->AI()->Talk(_counter ? SAY_EADRIC_INTRO : SAY_PALETRESS_INTRO_1);
                        if (!_counter)
                            events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_SAY_2, 6s);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_SAY_2:
                    {
                        if (Creature* ac = GetCreature(DATA_PALETRESS))
                            ac->AI()->Talk(SAY_PALETRESS_INTRO_2);
                    }
                    break;
                case EVENT_ARGENT_SOLDIER_GROUP_ATTACK:
                    {
                        _counter = 0;
                        for( uint8 i = 0; i < 3; ++i )
                            for( uint8 j = 0; j < 3; ++j )
                                if (Creature* c = instance->GetCreature(_argentSoldierGUID[i][j]))
                                {
                                    c->SetReactState(REACT_AGGRESSIVE);
                                    c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                    c->SetImmuneToAll(false);
                                    //c->AI()->DoZoneInCombat();
                                }
                        if (Creature* tirion = GetCreature(DATA_TIRION))
                            tirion->AI()->Talk(TEXT_YOU_MAY_BEGIN);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_MOVE_FORWARD:
                    {
                        if (Creature* boss = GetCreature(DATA_PALETRESS))
                        {
                            boss->GetMotionMaster()->MovePoint(0, 746.881f, 635.263f, 411.7f);
                        }
                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_ATTACK, 3s);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_ATTACK:
                    {
                        if (Creature* boss = GetCreature(DATA_PALETRESS))
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
                        if (Creature* boss = GetCreature(DATA_PALETRESS))
                        {
                            boss->GetMotionMaster()->MovePoint(1, 747.13f, 628.037f, 411.2f);
                            events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_LEAVE_CHEST, 6s);
                        }
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_LEAVE_CHEST:
                    {
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                            if (Creature* boss = GetCreature(DATA_PALETRESS))
                            {
                                announcer->GetMotionMaster()->MovePoint(0, 743.14f, 628.77f, 411.2f);
                                uint32 chest = 0;
                                if (boss->GetEntry() == NPC_EADRIC || boss->GetEntry() == NPC_EADRIC_H)
                                    chest = instance->IsHeroic() ? GO_EADRIC_LOOT_H : GO_EADRIC_LOOT;
                                else
                                    chest = instance->IsHeroic() ? GO_PALETRESS_LOOT_H : GO_PALETRESS_LOOT;
                                announcer->SummonGameObject(chest, 746.59f, 618.49f, 411.09f, 1.42f, 0, 0, 0, 0,
                                    90000000); // [LOOT]
                            }

                        events.ScheduleEvent(EVENT_ARGENT_CHALLENGE_DISAPPEAR, 4s);
                        events.ScheduleEvent(EVENT_RESTORE_ANNOUNCER_GOSSIP, 15s);
                    }
                    break;
                case EVENT_ARGENT_CHALLENGE_DISAPPEAR:
                    {
                        if (Creature* boss = GetCreature(DATA_PALETRESS))
                        {
                            boss->GetMotionMaster()->MovePoint(0, SpawnPosition);
                            boss->DespawnOrUnsummon(3s);
                        }
                    }
                    break;
                case EVENT_SUMMON_BLACK_KNIGHT:
                    {
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                            if (Creature* bk_vehicle = announcer->SummonCreature(VEHICLE_BLACK_KNIGHT,
                                769.834f, 651.915f, 447.035f, 0.0f))
                            {
                                HandleGameObject(DATA_ENTER_GATE, false);
                                bk_vehicle->SetReactState(REACT_PASSIVE);
                                bk_vehicle->SetFacingTo(M_PI);
                                if (Vehicle* v = bk_vehicle->GetVehicleKit())
                                    if (Unit* bk = v->GetPassenger(0))
                                    {
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
                        if (Creature* bk = GetCreature(DATA_BLACK_KNIGHT))
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
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                        {
                            if (Creature* bk = GetCreature(DATA_BLACK_KNIGHT))
                            {
                                bk->SetPosition(745.016f, 631.506f, 411.575f, bk->GetAngle(announcer));
                                bk->SetHomePosition(*bk);
                                bk->SetFacingToObject(announcer);
                                announcer->SetFacingToObject(bk);
                                announcer->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                // spell has attribute player only
                                bk->AddAura(SPELL_DEATH_RESPITE_ANNOUNCER, announcer);
                                if (Creature* tirion = GetCreature(DATA_TIRION))
                                    tirion->AI()->Talk(TEXT_BK_MEANING);
                            }
                        }
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_KILL_ANNOUNCER, 1s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_KILL_ANNOUNCER:
                    {
                        if (Creature* bk_vehicle = GetCreature(DATA_BLACK_KNIGHT_VEHICLE))
                            bk_vehicle->AI()->DoAction(1);

                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_MOVE_FORWARD, 4s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_MOVE_FORWARD:
                    {
                        if (Creature* bk = GetCreature(DATA_BLACK_KNIGHT))
                        {
                            bk->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                            bk->GetMotionMaster()->MovePoint(0, 746.81f, 623.15f, 411.42f);
                            bk->AI()->Talk(SAY_BK_INTRO_2);
                        }
                        if (Creature* announcer = GetCreature(DATA_ANNOUNCER))
                            if (announcer->IsAlive())
                                announcer->KillSelf();
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_SAY_TASK, 14s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_SAY_TASK:
                    {
                        if (Creature* bk = GetCreature(DATA_BLACK_KNIGHT))
                        {
                            bk->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            bk->AI()->Talk(SAY_BK_INTRO_3);
                        }
                        events.ScheduleEvent(EVENT_BLACK_KNIGHT_ATTACK, 5s);
                    }
                    break;
                case EVENT_BLACK_KNIGHT_ATTACK:
                    {
                        if (Creature* bk = GetCreature(DATA_BLACK_KNIGHT))
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

        bool CheckAchievementCriteriaMeet(uint32 criteriaId, Player const* /*source*/, Unit const* /*target*/,
            uint32 /*miscValue1*/) override
        {
            if (criteriaId == CRITERIA_IVE_HAD_WORSE)
                return _achievementIveHadWorse;

            for (MemoryCriteria const& memory : MemoryCriteriaTable)
                if (memory.criteriaId == criteriaId)
                    return _memoryEntry == memory.memoryEntry;

            return false;
        }
    };
};

void AddSC_instance_trial_of_the_champion()
{
    new instance_trial_of_the_champion();
}
