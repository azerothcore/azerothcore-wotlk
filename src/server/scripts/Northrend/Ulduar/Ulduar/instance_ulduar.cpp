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

#include "AreaDefines.h"
#include "CreatureScript.h"
#include "GameTime.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Transport.h"
#include "WorldPacket.h"
#include "WorldStateDefines.h"
#include "WorldStatePackets.h"
#include "ulduar.h"

DoorData const doorData[] =
{
    { GO_LEVIATHAN_DOORS,   BOSS_LEVIATHAN, DOOR_TYPE_ROOM    },
    { GO_XT002_DOORS,       BOSS_XT002,     DOOR_TYPE_ROOM    },
    { GO_KOLOGARN_DOORS,    BOSS_KOLOGARN,  DOOR_TYPE_ROOM    },
    { GO_ASSEMBLY_DOORS,    BOSS_ASSEMBLY,  DOOR_TYPE_ROOM    },
    { GO_ARCHIVUM_DOORS,    BOSS_ASSEMBLY,  DOOR_TYPE_PASSAGE },
    { GO_YOGG_SARON_DOORS,  BOSS_YOGGSARON, DOOR_TYPE_ROOM    },
    { 0,                    0,              DOOR_TYPE_ROOM    }
};

ObjectData const creatureData[] =
{
    { NPC_LEVIATHAN,    BOSS_LEVIATHAN  },
    { NPC_IGNIS,        BOSS_IGNIS      },
    { NPC_RAZORSCALE,   BOSS_RAZORSCALE },
    { NPC_XT002,        BOSS_XT002      },
    { NPC_KOLOGARN,     BOSS_KOLOGARN   },
    { NPC_AURIAYA,      BOSS_AURIAYA    },
    { NPC_MIMIRON,      BOSS_MIMIRON    },
    { NPC_HODIR,        BOSS_HODIR      },
    { NPC_THORIM,       BOSS_THORIM     },
    { NPC_FREYA,        BOSS_FREYA      },
    { NPC_VEZAX,        BOSS_VEZAX      },
    { NPC_YOGGSARON,    BOSS_YOGGSARON  },
    { NPC_ALGALON,      BOSS_ALGALON    },
    // Assembly of Iron members
    { NPC_STEELBREAKER,             DATA_STEELBREAKER           },
    { NPC_MOLGEIM,                  DATA_MOLGEIM                },
    { NPC_BRUNDIR,                  DATA_BRUNDIR                },
    // Mimiron vehicles
    { NPC_MIMIRON_LEVIATHAN_MKII,   DATA_MIMIRON_LEVIATHAN_MKII },
    { NPC_MIMIRON_VX001,            DATA_MIMIRON_VX001          },
    { NPC_MIMIRON_ACU,              DATA_MIMIRON_ACU            },
    // Freya elders
    { NPC_ELDER_IRONBRANCH,         DATA_ELDER_IRONBRANCH       },
    { NPC_ELDER_STONEBARK,          DATA_ELDER_STONEBARK        },
    { NPC_ELDER_BRIGHTLEAF,         DATA_ELDER_BRIGHTLEAF       },
    // Yogg-Saron helpers
    { NPC_SARA,                     DATA_SARA                   },
    { NPC_BRAIN_OF_YOGG_SARON,      DATA_BRAIN_OF_YOGG_SARON    },
    // Algalon helpers
    { NPC_BRANN_BRONZBEARD_ALG,     DATA_BRANN_BRONZEBEARD_ALG  },
    { NPC_BRANN_BASE_CAMP,          DATA_BRANN_BASE_CAMP        },
    { 0,                0               }
};

ObjectData const gameobjectData[] =
{
    { GO_LEVIATHAN_DOORS,               DATA_LEVIATHAN_DOORS            },
    { GO_LIGHTNING_WALL1,               DATA_LIGHTNING_WALL1            },
    { GO_LIGHTNING_WALL2,               DATA_LIGHTNING_WALL2            },
    { GO_XT002_DOORS,                   DATA_XT002_DOORS                },
    { GO_KOLOGARN_DOORS,                DATA_KOLOGARN_DOORS             },
    { GO_ASSEMBLY_DOORS,                DATA_ASSEMBLY_DOORS             },
    { GO_ARCHIVUM_DOORS,                DATA_ARCHIVUM_DOORS             },
    { GO_MIMIRON_DOOR_1,                DATA_GO_MIMIRON_DOOR_1          },
    { GO_MIMIRON_DOOR_2,                DATA_GO_MIMIRON_DOOR_2          },
    { GO_MIMIRON_DOOR_3,                DATA_GO_MIMIRON_DOOR_3          },
    { GO_ARENA_LEVER_GATE,              DATA_THORIM_LEVER_GATE          },
    { GO_ARENA_LEVER,                   DATA_THORIM_LEVER               },
    { GO_ARENA_FENCE,                   DATA_THORIM_FENCE               },
    { GO_FIRST_COLOSSUS_DOORS,          DATA_THORIM_FIRST_DOORS         },
    { GO_SECOND_COLOSSUS_DOORS,         DATA_THORIM_SECOND_DOORS        },
    { GO_YOGG_SARON_DOORS,              DATA_YOGG_SARON_DOORS           },
    { GO_KEEPERS_GATE,                  DATA_KEEPERS_GATE               },
    { GO_DOODAD_UL_SIGILDOOR_01,        DATA_SIGILDOOR_01               },
    { GO_DOODAD_UL_SIGILDOOR_02,        DATA_SIGILDOOR_02               },
    { GO_DOODAD_UL_SIGILDOOR_03,        DATA_SIGILDOOR_03               },
    { GO_DOODAD_UL_UNIVERSEFLOOR_01,    DATA_UNIVERSE_FLOOR_01          },
    { GO_DOODAD_UL_UNIVERSEFLOOR_02,    DATA_UNIVERSE_FLOOR_02          },
    { GO_DOODAD_UL_UNIVERSEGLOBE01,     DATA_UNIVERSE_GLOBE             },
    { GO_DOODAD_UL_ULDUAR_TRAPDOOR_03,  DATA_ALGALON_TRAPDOOR           },
    { GO_MIMIRON_TRAM,                  DATA_MIMIRON_TRAM               },
    { GO_MIMIRON_ACTIVATE_TRAM,         DATA_MIMIRON_ACTIVATE_TRAM      },
    { GO_MIMIRON_TRAM_ROCKET_BOOSTER,   DATA_MIMIRON_TRAM_ROCKET_BOOSTER},
    { GO_MIMIRON_CALL_TRAM_CENTER,      DATA_MIMIRON_CALL_TRAM_CENTER   },
    { GO_MIMIRON_CALL_TRAM_MIMIRON,     DATA_MIMIRON_CALL_TRAM_MIMIRON  },
    { GO_DOODAD_UL_TRAIN_TURNAROUND01,  DATA_MIMIRON_TRAM_TURNAROUND_1  },
    { GO_DOODAD_UL_TRAIN_TURNAROUND02,  DATA_MIMIRON_TRAM_TURNAROUND_2  },
    // Hodir chests (dynamically spawned, one per difficulty)
    { GO_HODIR_CHEST_NORMAL,             DATA_HODIR_CHEST_NORMAL         },
    { GO_HODIR_CHEST_NORMAL_HERO,        DATA_HODIR_CHEST_NORMAL_HERO    },
    { GO_HODIR_CHEST_HARD,               DATA_HODIR_CHEST_HARD           },
    { GO_HODIR_CHEST_HARD_HERO,          DATA_HODIR_CHEST_HARD_HERO      },
    { 0,                                0                               }
};

class instance_ulduar : public InstanceMapScript
{
public:
    instance_ulduar() : InstanceMapScript("instance_ulduar", MAP_ULDUAR) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_ulduar_InstanceMapScript(pMap);
    }

    struct instance_ulduar_InstanceMapScript : public InstanceScript
    {
        instance_ulduar_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, gameobjectData);
            Initialize();
            // 0: 10 man difficulty
            // 1: 25 man difficulty
            m_difficulty = (pMap->Is25ManRaid() ? 0 : 1);
        };

        // Only used for TYPE_WATCHERS bitmask
        uint32 m_watchersMask;
        uint32 C_of_Ulduar_MASK;

        int m_difficulty;

        // Flame Leviathan
        ObjectGuid m_leviathanVisualTowers[4][2];
        ObjectGuid m_RepairSGUID[2];
        bool m_leviathanTowers[4];
        GuidList _leviathanVehicles;
        uint32 m_unbrokenAchievement;
        uint32 m_mageBarrier;

        // Hodir
        bool hmHodir;
        Position normalChestPosition = { 1967.152588f, -204.188461f, 432.686951f, 5.50957f };
        Position hardChestPosition = { 2035.94600f, -202.084885f, 432.686859f, 3.164077f };

        // Freya
        uint32 m_conspeedatoryAttempt;

        // Yogg-Saron

        // Algalon
        uint32 m_algalonTimer;

        // Ancient Gate
        const Position triggerAncientGatePosition = { 1883.65f, 269.272f, 418.406f };

        // Shared
        EventMap _events;
        bool m_mimironTramUsed;
        ObjectGuid m_keepersGossipGUID[4];

        void Initialize() override
        {
            // Bosses
            m_watchersMask = 0;
            C_of_Ulduar_MASK = 0;

            // Flame Leviathan
            for (uint8 i = 0; i < 4; ++i)
                m_leviathanTowers[i] = true;

            _leviathanVehicles.clear();
            m_unbrokenAchievement   = 1;
            m_mageBarrier           = 0;

            // Hodir
            hmHodir = true; // If players fail the Hardmode then becomes false

            // Freya
            m_conspeedatoryAttempt  = 0;

            // Algalon
            m_algalonTimer          = 0;

            // Shared
            _events.Reset();
            m_mimironTramUsed       = false;
        }

        void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override
        {
            packet.Worldstates.reserve(2);
            packet.Worldstates.emplace_back(WORLD_STATE_ULDUAR_ALGALON_TIMER_ENABLED, (m_algalonTimer && m_algalonTimer <= 60) ? 1 : 0);
            packet.Worldstates.emplace_back(WORLD_STATE_ULDUAR_ALGALON_DESPAWN_TIMER, std::min<int32>(m_algalonTimer, 60));
        }

        void OnPlayerEnter(Player* player) override
        {
            // mimiron tram:
            if (GameObject* MimironTram = GetGameObject(DATA_MIMIRON_TRAM))
            {
                player->UpdateVisibilityOf(MimironTram);
                if (StaticTransport* t = MimironTram->ToStaticTransport())
                {
                    if (GameObject* go = GetGameObject(DATA_MIMIRON_TRAM_ROCKET_BOOSTER))
                        if (!go->GetTransport())
                            t->AddPassenger(go, true);
                    if (GameObject* go = GetGameObject(DATA_MIMIRON_ACTIVATE_TRAM))
                        if (!go->GetTransport())
                            t->AddPassenger(go, true);
                }
            }

            if (!GetObjectGuid(BOSS_ALGALON) && m_algalonTimer && (m_algalonTimer <= 60 || m_algalonTimer == TIMER_ALGALON_TO_SUMMON))
            {
                TempSummon* algalon = instance->SummonCreature(NPC_ALGALON, AlgalonLandPos);
                if (!algalon)
                    return;

                if (m_algalonTimer <= 60)
                {
                    _events.RescheduleEvent(EVENT_UPDATE_ALGALON_TIMER, 1min);
                    algalon->AI()->DoAction(ACTION_INIT_ALGALON);
                }
                else // if (m_algalonTimer = TIMER_ALGALON_TO_SUMMON)
                {
                    m_algalonTimer = TIMER_ALGALON_SUMMONED;
                    algalon->SetImmuneToPC(false);
                }
            }
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (GetBossState(i) == IN_PROGRESS)
                    return true;
            }

            // Leviathan does not use IN_PROGRESS type, instead SPECIAL is set and never reset,
            // Check if he is in combat.
            if (Creature* l = instance->GetCreature(GetObjectGuid(BOSS_LEVIATHAN)))
                if (l->IsInCombat())
                    return true;

            return false;
        }

        void ProcessEvent(WorldObject*  /*obj*/, uint32 eventId) override
        {
            // destory towers
            if (eventId >= EVENT_TOWER_OF_LIFE_DESTROYED && eventId <= EVENT_TOWER_OF_FLAMES_DESTROYED)
                SetData(eventId, 0);
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case BOSS_LEVIATHAN:
                    if (state == DONE)
                    {
                        instance->DoForAllPlayers([&](Player* player)
                        {
                            if (Creature* vehicleCreature = player->GetVehicleCreatureBase())
                                vehicleCreature->DespawnOrUnsummon();
                        });

                        if (GameObject* go = GetGameObject(DATA_LEVIATHAN_DOORS))
                            go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                    }
                    break;
                case BOSS_ASSEMBLY:
                    // Assembly doors handled by DoorData, archivum
                    // doors stay open only after DONE
                    if (GameObject* go = GetGameObject(DATA_ARCHIVUM_DOORS))
                        go->SetGoState(state == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case BOSS_MIMIRON:
                    if (state == IN_PROGRESS)
                        m_mimironTramUsed = true;
                    [[fallthrough]];
                case BOSS_HODIR:
                case BOSS_THORIM:
                case BOSS_FREYA:
                    if (GetBossState(BOSS_MIMIRON) == DONE && GetBossState(BOSS_FREYA) == DONE && GetBossState(BOSS_HODIR) == DONE && GetBossState(BOSS_THORIM) == DONE)
                    {
                        scheduler.Schedule(45s, [this](TaskContext /*context*/)
                        {
                            if (GameObject* go = GetGameObject(DATA_KEEPERS_GATE))
                            {
                                go->RemoveGameObjectFlag(GO_FLAG_LOCKED);
                                if (Creature* trigger = instance->SummonCreature(NPC_ANCIENT_GATE_WORLD_TRIGGER, triggerAncientGatePosition, nullptr, 10 * IN_MILLISECONDS))
                                    trigger->AI()->Talk(EMOTE_ANCIENT_GATE_UNLOCKED);
                            }
                        });
                    }
                    if (type == BOSS_HODIR && state == DONE)
                        setChestsLootable(BOSS_HODIR);
                    break;
                case BOSS_ALGALON:
                    if (GameObject* go = GetGameObject(DATA_SIGILDOOR_03))
                    {
                        go->SetGoState(state != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = GetGameObject(DATA_UNIVERSE_FLOOR_01))
                    {
                        go->SetGoState(state != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = GetGameObject(DATA_UNIVERSE_FLOOR_02))
                    {
                        go->SetGoState(state == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = GetGameObject(DATA_UNIVERSE_GLOBE))
                    {
                        go->SetGoState(state == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = GetGameObject(DATA_ALGALON_TRAPDOOR))
                    {
                        go->SetGoState(state == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    break;
                default:
                    break;
            }

            // take care of herbs
            if (type == BOSS_FREYA && state == DONE)
            {
                std::list<GameObject*> goList;
                if (Creature* freya = GetCreature(BOSS_FREYA))
                {
                    freya->GetGameObjectListWithEntryInGrid(goList, { 191019, 190176, 190171, 190170, 189973 }, 333.0f);

                    for (GameObject* herb : goList)
                        herb->SetRespawnTime(7 * DAY);
                }
            }

            if (state == DONE)
                SaveToDB();

            if (type > BOSS_LEVIATHAN && type < MAX_ENCOUNTER && state == IN_PROGRESS)
            {
                instance->DoForAllPlayers([&](Player* player)
                {
                    if (Creature* vehicleCreature = player->GetVehicleCreatureBase())
                        vehicleCreature->DespawnOrUnsummon();
                });
            }

            return true;
        }

        void SpawnHodirChests(Difficulty diff, Creature* hodir)
        {
            switch (diff)
            {
                case RAID_DIFFICULTY_10MAN_NORMAL: // 10 man chest
                {
                    if (!GetObjectGuid(DATA_HODIR_CHEST_NORMAL))
                    {
                        if (GameObject* go = hodir->SummonGameObject(
                            GO_HODIR_CHEST_NORMAL,
                            normalChestPosition.GetPositionX(),
                            normalChestPosition.GetPositionY(),
                            normalChestPosition.GetPositionZ(),
                            normalChestPosition.GetOrientation(), 0, 0, 0, 0, 0))
                        {
                            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                        }
                    }
                    if (!GetObjectGuid(DATA_HODIR_CHEST_HARD))
                    {
                        if (GameObject* go = hodir->SummonGameObject(
                            GO_HODIR_CHEST_HARD,
                            hardChestPosition.GetPositionX(),
                            hardChestPosition.GetPositionY(),
                            hardChestPosition.GetPositionZ(),
                            hardChestPosition.GetOrientation(), 0, 0, 0, 0, 0))
                        {
                            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                            hmHodir = true;
                        }
                    }
                    break;
                }
                case RAID_DIFFICULTY_25MAN_NORMAL: // 25 man chest
                {
                    if (!GetObjectGuid(DATA_HODIR_CHEST_NORMAL_HERO))
                    {
                        if (GameObject* go = hodir->SummonGameObject(
                            GO_HODIR_CHEST_NORMAL_HERO,
                            normalChestPosition.GetPositionX(),
                            normalChestPosition.GetPositionY(),
                            normalChestPosition.GetPositionZ(),
                            normalChestPosition.GetOrientation(), 0, 0, 0, 0, 0))
                        {
                            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                        }
                    }
                    if (!GetObjectGuid(DATA_HODIR_CHEST_HARD_HERO))
                    {
                        if (GameObject* go = hodir->SummonGameObject(
                            GO_HODIR_CHEST_HARD_HERO,
                            hardChestPosition.GetPositionX(),
                            hardChestPosition.GetPositionY(),
                            hardChestPosition.GetPositionZ(),
                            hardChestPosition.GetOrientation(), 0, 0, 0, 0, 0))
                        {
                            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                            hmHodir = true;
                        }
                    }
                    break;
                }
                default:
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_KOLOGARN:
                    if (GetBossState(BOSS_KOLOGARN) == DONE)
                    {
                        creature->SetDisableGravity(true);
                        creature->SetPosition(creature->GetHomePosition());
                        creature->setDeathState(DeathState::JustDied);
                        creature->StopMovingOnCurrentPos();
                    }
                    break;
                case NPC_HODIR:
                    if (GetBossState(BOSS_HODIR) != DONE)
                    {
                        SpawnHodirChests(instance->GetDifficulty(), creature);
                    }
                    break;
                case NPC_ALGALON:
                    if (!m_algalonTimer)
                        creature->DespawnOrUnsummon();
                    break;
                //! These creatures are summoned by something else than Algalon
                //! but need to be controlled/despawned by him - so they need to be
                //! registered in his summon list
                case NPC_ALGALON_VOID_ZONE_VISUAL_STALKER:
                case NPC_ALGALON_STALKER_ASTEROID_TARGET_01:
                case NPC_ALGALON_STALKER_ASTEROID_TARGET_02:
                case NPC_UNLEASHED_DARK_MATTER:
                    if (Creature* algalon = GetCreature(BOSS_ALGALON))
                        algalon->AI()->JustSummoned(creature);
                    break;
            }
        }

        void OpenIfDone(uint32 encounter, GameObject* go, GOState state)
        {
            if (GetBossState(encounter) == DONE)
                go->SetGoState(state);
        }

        GameObject* GetHodirChest(bool hardmode)
        {
            if (hardmode)
            {
                if (GameObject* go = GetGameObject(DATA_HODIR_CHEST_HARD))
                    return go;
                return GetGameObject(DATA_HODIR_CHEST_HARD_HERO);
            }

            if (GameObject* go = GetGameObject(DATA_HODIR_CHEST_NORMAL))
                return go;
            return GetGameObject(DATA_HODIR_CHEST_NORMAL_HERO);
        }

        void OnGameObjectCreate(GameObject* gameObject) override
        {
            InstanceScript::OnGameObjectCreate(gameObject);

            switch (gameObject->GetEntry())
            {
                // Flame Leviathan
                case GO_REPAIR_STATION_TRAP:
                    {
                        if (m_RepairSGUID[0])
                            m_RepairSGUID[1] = gameObject->GetGUID();
                        else
                            m_RepairSGUID[0] = gameObject->GetGUID();
                        break;
                    }
                case GO_LIGHTNING_WALL1:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    break;
                case GO_MIMIRONS_TARGETTING_CRYSTAL:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[3][0] = gameObject->GetGUID();
                    break;
                case GO_FREYAS_TARGETTING_CRYSTAL:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[0][0] = gameObject->GetGUID();
                    break;
                case GO_HODIRS_TARGETTING_CRYSTAL:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[2][0] = gameObject->GetGUID();
                    break;
                case GO_THORIMS_TARGETTING_CRYSTAL:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[1][0] = gameObject->GetGUID();
                    break;
                case GO_MIMIRONS_GENERATOR:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[3][1] = gameObject->GetGUID();
                    break;
                case GO_FREYAS_GENERATOR:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[0][1] = gameObject->GetGUID();
                    break;
                case GO_HODIRS_GENERATOR:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[2][1] = gameObject->GetGUID();
                    break;
                case GO_THORIMS_GENERATOR:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[1][1] = gameObject->GetGUID();
                    break;
                case GO_LEVIATHAN_DOORS:
                    if (GetBossState(BOSS_LEVIATHAN) >= DONE)
                        gameObject->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                    break;
                case GO_KOLOGARN_BRIDGE:
                    OpenIfDone(BOSS_KOLOGARN, gameObject, GO_STATE_READY);
                    break;
                case GO_ARCHIVUM_DOORS:
                    OpenIfDone(BOSS_ASSEMBLY, gameObject, GO_STATE_ACTIVE);
                    break;
                case GO_KEEPERS_GATE:
                    if (GetBossState(BOSS_MIMIRON) == DONE && GetBossState(BOSS_FREYA) == DONE && GetBossState(BOSS_HODIR) == DONE && GetBossState(BOSS_THORIM) == DONE)
                        gameObject->RemoveGameObjectFlag(GO_FLAG_LOCKED);
                    break;
                // Mimiron, Hodir, Vezax
                case GO_MIMIRON_ELEVATOR:
                    gameObject->EnableCollision(false);
                    break;
                case GO_HODIR_FROZEN_DOOR:
                case GO_HODIR_DOOR:
                    if (GetBossState(BOSS_HODIR) == DONE)
                        if (gameObject->GetGoState() != GO_STATE_ACTIVE )
                        {
                            gameObject->SetLootState(GO_READY);
                            gameObject->UseDoorOrButton(0, false);
                        }
                    break;
                case GO_VEZAX_DOOR:
                    if (GetBossState(BOSS_VEZAX) == DONE )
                        if (gameObject->GetGoState() != GO_STATE_ACTIVE )
                        {
                            gameObject->SetLootState(GO_READY);
                            gameObject->UseDoorOrButton(0, false);
                        }
                    break;
                case GO_SNOW_MOUND:
                    gameObject->EnableCollision(false);
                    break;
                // Mimiron Tram
                case GO_MIMIRON_TRAM:
                    if (GetBossState(BOSS_MIMIRON) == DONE)
                        m_mimironTramUsed = true;
                    break;
                // Algalon the Observer
                case GO_CELESTIAL_PLANETARIUM_ACCESS_10:
                case GO_CELESTIAL_PLANETARIUM_ACCESS_25:
                    if (m_algalonTimer)
                        gameObject->SetGameObjectFlag(GO_FLAG_IN_USE);
                    break;
                case GO_DOODAD_UL_SIGILDOOR_01:
                    if (m_algalonTimer)
                        gameObject->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_DOODAD_UL_SIGILDOOR_02:
                    if (m_algalonTimer)
                        gameObject->SetGoState(GO_STATE_ACTIVE);
                    break;
                // Herbs
                case 191019: // Adder's Tongue
                case 190176: // Frost Lotus
                case 190171: // Lichbloom
                case 190170: // Talandra's Rose
                case 189973: // Goldclover
                    if (GetBossState(BOSS_FREYA) == DONE)
                        gameObject->SetRespawnTime(7 * DAY);
                    break;
            }
        }

        void setChestsLootable(uint32 boss)
        {
            if (boss)
            {
                switch (boss)
                {
                    case BOSS_HODIR:
                        if (hmHodir)
                        {
                            if (GameObject* go = GetHodirChest(true))
                            {
                                go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                go->SetLootRecipient(instance);
                            }
                        }
                        if (GameObject* go = GetHodirChest(false))
                        {
                            go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                            go->SetLootRecipient(instance);
                        }
                        break;
                }
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_HODIR_HM_FAIL:
                    if (GameObject* go = GetHodirChest(true))
                    {
                        hmHodir = false;
                        go->Delete();
                    }
                    break;
                case TYPE_WATCHERS:
                    m_watchersMask |= 1 << data;
                    [[fallthrough]];
                case EVENT_KEEPER_TELEPORTED:
                    if (Creature* sara = GetCreature(DATA_SARA))
                        sara->AI()->DoAction(ACTION_SARA_UPDATE_SUMMON_KEEPERS);
                    break;
                case DATA_MAGE_BARRIER:
                    m_mageBarrier = data;
                    break;

                case EVENT_TOWER_OF_LIFE_DESTROYED:
                case EVENT_TOWER_OF_STORM_DESTROYED:
                case EVENT_TOWER_OF_FROST_DESTROYED:
                case EVENT_TOWER_OF_FLAMES_DESTROYED:
                    {
                        m_leviathanTowers[type - EVENT_TOWER_OF_LIFE_DESTROYED] = data;
                        for (uint8 i = 0; i < 2; ++i)
                        {
                            if (GameObject *gameObject = instance->GetGameObject(m_leviathanVisualTowers[type - EVENT_TOWER_OF_LIFE_DESTROYED][i]))
                            {
                                gameObject->SetGoState(GO_STATE_ACTIVE);
                            }
                        }
                        return;
                    }

                case DATA_VEHICLE_SPAWN:
                    SpawnLeviathanEncounterVehicles(data);
                    return;
                case DATA_UNBROKEN_ACHIEVEMENT:
                    m_unbrokenAchievement = data;
                    SaveToDB();
                    return;
                case DATA_DESPAWN_ALGALON:
                    DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_TIMER_ENABLED, 1);
                    DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_DESPAWN_TIMER, 60);
                    m_algalonTimer = 60;
                    _events.RescheduleEvent(EVENT_UPDATE_ALGALON_TIMER, 1min);
                    SaveToDB();
                    return;
                case DATA_ALGALON_SUMMON_STATE:
                case DATA_ALGALON_DEFEATED:
                    DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_TIMER_ENABLED, 0);
                    m_algalonTimer = (type == DATA_ALGALON_DEFEATED ? TIMER_ALGALON_DEFEATED : TIMER_ALGALON_SUMMONED);
                    _events.CancelEvent(EVENT_UPDATE_ALGALON_TIMER);
                    SaveToDB();
                    return;
                // Achievement
                case DATA_DWARFAGEDDON:
                    DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_SPELL_TARGET, SPELL_DWARFAGEDDON);
                    DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_DWARFAGEDDON);
                    return;
                case DATA_CALL_TRAM:
                    if (GameObject* MimironTram = GetGameObject(DATA_MIMIRON_TRAM))
                        if (StaticTransport* t = MimironTram->ToStaticTransport())
                        {
                            if (data == 0 && t->GetGoState() == GO_STATE_ACTIVE && t->GetPathProgress() == t->GetPauseTime())
                            {
                                MimironTram->SetGoState(GO_STATE_READY);
                                if (GameObject* rocketBooster = GetGameObject(DATA_MIMIRON_TRAM_ROCKET_BOOSTER))
                                    rocketBooster->SetGoState(GO_STATE_ACTIVE);
                                if (GameObject* activateTramButton = GetGameObject(DATA_MIMIRON_ACTIVATE_TRAM))
                                    activateTramButton->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                if (GameObject* callTramCenterButton = GetGameObject(DATA_MIMIRON_CALL_TRAM_CENTER))
                                    callTramCenterButton->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                scheduler.Schedule(30s, [this](TaskContext /*context*/)
                                {
                                    if (GameObject* turnaround1 = GetGameObject(DATA_MIMIRON_TRAM_TURNAROUND_1))
                                        turnaround1->UseDoorOrButton();
                                    if (GameObject* rocketBooster = GetGameObject(DATA_MIMIRON_TRAM_ROCKET_BOOSTER))
                                        rocketBooster->SetGoState(GO_STATE_READY);
                                }).Schedule(60s, [this](TaskContext /*context*/)
                                {
                                    if (GameObject* activateTramButton = GetGameObject(DATA_MIMIRON_ACTIVATE_TRAM))
                                        activateTramButton->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                    if (GameObject* callTramMimironButton = GetGameObject(DATA_MIMIRON_CALL_TRAM_MIMIRON))
                                        callTramMimironButton->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                });
                            }
                            if (data == 1 && t->GetGoState() == GO_STATE_READY && t->GetPathProgress() == 0)
                            {
                                MimironTram->SetGoState(GO_STATE_ACTIVE);
                                if (GameObject* rocketBooster = GetGameObject(DATA_MIMIRON_TRAM_ROCKET_BOOSTER))
                                    rocketBooster->SetGoState(GO_STATE_ACTIVE);
                                if (GameObject* activateTramButton = GetGameObject(DATA_MIMIRON_ACTIVATE_TRAM))
                                    activateTramButton->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                if (GameObject* callTramMimironButton = GetGameObject(DATA_MIMIRON_CALL_TRAM_MIMIRON))
                                    callTramMimironButton->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                scheduler.Schedule(33s, [this](TaskContext /*context*/)
                                {
                                    if (GameObject* turnaround2 = GetGameObject(DATA_MIMIRON_TRAM_TURNAROUND_2))
                                        turnaround2->UseDoorOrButton();
                                    if (GameObject* rocketBooster = GetGameObject(DATA_MIMIRON_TRAM_ROCKET_BOOSTER))
                                        rocketBooster->SetGoState(GO_STATE_READY);
                                }).Schedule(63s, [this](TaskContext /*context*/)
                                {
                                    if (GameObject* activateTramButton = GetGameObject(DATA_MIMIRON_ACTIVATE_TRAM))
                                        activateTramButton->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                    if (GameObject* callTramCenterButton = GetGameObject(DATA_MIMIRON_CALL_TRAM_CENTER))
                                        callTramCenterButton->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                });
                            }
                        }
                    break;
                case DATA_BRANN_MEMOTESAY:
                    if (Creature* cr = GetCreature(DATA_BRANN_BASE_CAMP))
                        cr->TextEmote("Go to your vehicles!", nullptr, true);
                    break;
                case DATA_BRANN_EASY_MODE:
                    ProcessEvent(nullptr, EVENT_TOWER_OF_STORM_DESTROYED);
                    ProcessEvent(nullptr, EVENT_TOWER_OF_FROST_DESTROYED);
                    ProcessEvent(nullptr, EVENT_TOWER_OF_FLAMES_DESTROYED);
                    ProcessEvent(nullptr, EVENT_TOWER_OF_LIFE_DESTROYED);
                    break;
            }

            if (type == TYPE_WATCHERS)
                SaveToDB();
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                // Flame Leviathan
                case DATA_REPAIR_STATION1:
                    return m_RepairSGUID[0];
                case DATA_REPAIR_STATION2:
                    return m_RepairSGUID[1];

            }

            return GetObjectGuid(data);
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case TYPE_WATCHERS:
                    return m_watchersMask;

                case EVENT_TOWER_OF_LIFE_DESTROYED:
                case EVENT_TOWER_OF_STORM_DESTROYED:
                case EVENT_TOWER_OF_FROST_DESTROYED:
                case EVENT_TOWER_OF_FLAMES_DESTROYED:
                    return m_leviathanTowers[type - EVENT_TOWER_OF_LIFE_DESTROYED];

                case DATA_MAGE_BARRIER:
                    return m_mageBarrier;

                case DATA_UNBROKEN_ACHIEVEMENT:
                    return m_unbrokenAchievement;

                case DATA_CALL_TRAM:
                    return m_mimironTramUsed;
            }

            return 0;
        }

        void OnUnitDeath(Unit* unit) override
        {
            // Feeds on Tears achievement
            if (unit->IsPlayer())
            {
                if (GetBossState(BOSS_ALGALON) == IN_PROGRESS)
                    if (Creature* algalon = GetCreature(BOSS_ALGALON))
                        algalon->AI()->DoAction(ACTION_FEEDS_ON_TEARS_FAILED);
            }
            else if (unit->IsCreature() && unit->GetAreaId() == AREA_THE_CONSERVATORY_OF_LIFE)
            {
                if (GameTime::GetGameTime().count() > (m_conspeedatoryAttempt + DAY))
                {
                    DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, 21597 /*CON-SPEED-ATORY_TIMED_CRITERIA*/);
                    m_conspeedatoryAttempt = GameTime::GetGameTime().count();
                    SaveToDB();
                }
            }

            // achievement Champion/Conqueror of Ulduar
            if (unit->IsPlayer())
                for (uint8 i = 0; i <= 12; ++i)
                {
                    bool go = false;
                    if (i == BOSS_LEVIATHAN)
                    {
                        if (Creature* c = GetCreature(BOSS_LEVIATHAN))
                            if (c->IsInCombat())
                                go = true;
                    }
                    else
                        go = (GetBossState(i) == IN_PROGRESS);

                    if (go && (C_of_Ulduar_MASK & (1 << i)) == 0)
                    {
                        C_of_Ulduar_MASK |= (1 << i);
                        SaveToDB();
                    }
                }
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            // Boss states 0-13 are read by base InstanceScript.
            data >> m_watchersMask;
            data >> m_conspeedatoryAttempt;
            data >> m_unbrokenAchievement;
            data >> m_algalonTimer;

            if (m_algalonTimer == TIMER_ALGALON_SUMMONED)
                m_algalonTimer = TIMER_ALGALON_TO_SUMMON;

            if (m_algalonTimer && m_algalonTimer <= 60 && GetBossState(BOSS_ALGALON) != DONE)
            {
                DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_TIMER_ENABLED, 1);
                DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_DESPAWN_TIMER, m_algalonTimer);
            }

            data >> C_of_Ulduar_MASK;
            data >> m_mageBarrier;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            // Boss states 0-13 are written by base InstanceScript.
            // Only write extra non-boss data here.
            data << m_watchersMask << ' '
                << m_conspeedatoryAttempt << ' '
                << m_unbrokenAchievement << ' '
                << m_algalonTimer << ' '
                << C_of_Ulduar_MASK << ' '
                << m_mageBarrier;
        }

        void Update(uint32 diff) override
        {
            InstanceScript::Update(diff);

            if (_events.Empty())
                return;

            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case EVENT_UPDATE_ALGALON_TIMER:
                    if (m_algalonTimer == TIMER_ALGALON_DEFEATED)
                        return;

                    SaveToDB();
                    DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_DESPAWN_TIMER, --m_algalonTimer);
                    if (m_algalonTimer)
                    {
                        _events.Repeat(1min);
                        return;
                    }

                    SetData(DATA_ALGALON_DEFEATED, 1);
                    if (Creature* algalon = GetCreature(BOSS_ALGALON))
                        algalon->AI()->DoAction(ACTION_DESPAWN_ALGALON);
            }
        }

        void SpawnLeviathanEncounterVehicles(uint8 mode);

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case 10042:
                case 10352:
                    return (C_of_Ulduar_MASK & (1 << BOSS_LEVIATHAN)) == 0;
                case 10342:
                case 10355:
                    return (C_of_Ulduar_MASK & (1 << BOSS_IGNIS)) == 0;
                case 10340:
                case 10353:
                    return (C_of_Ulduar_MASK & (1 << BOSS_RAZORSCALE)) == 0;
                case 10341:
                case 10354:
                    return (C_of_Ulduar_MASK & (1 << BOSS_XT002)) == 0;
                case 10598:
                case 10599:
                    return (C_of_Ulduar_MASK & (1 << BOSS_ASSEMBLY)) == 0;
                case 10348:
                case 10357:
                    return (C_of_Ulduar_MASK & (1 << BOSS_KOLOGARN)) == 0;
                case 10351:
                case 10363:
                    return (C_of_Ulduar_MASK & (1 << BOSS_AURIAYA)) == 0;
                case 10439:
                case 10719:
                    return (C_of_Ulduar_MASK & (1 << BOSS_HODIR)) == 0;
                case 10403:
                case 10404:
                    return (C_of_Ulduar_MASK & (1 << BOSS_THORIM)) == 0;
                case 10582:
                case 10583:
                    return (C_of_Ulduar_MASK & (1 << BOSS_FREYA)) == 0;
                case 10347:
                case 10361:
                    return (C_of_Ulduar_MASK & (1 << BOSS_MIMIRON)) == 0;
                case 10349:
                case 10362:
                    return (C_of_Ulduar_MASK & (1 << BOSS_VEZAX)) == 0;
                case 10350:
                case 10364:
                    return (C_of_Ulduar_MASK & (1 << BOSS_YOGGSARON)) == 0;
            }
            return false;
        }
    };
};

const Position vehiclePositions[30] =
{
    // Start Positions
    // Siege
    {-814.592f, -64.5436f, 429.927f, 5.96903f},
    {-784.371f, -33.3111f, 429.927f, 5.09636f},
    {-813.698f, -86.8924f, 430.158f, 6.0912f},
    {-739.3f, -21.51f, 429.927f, 4.86947f},
    {-756.948f, -27.9419f, 429.927f, 5.07891f},
    // Chopper
    {-717.556f, -111.2f, 430.157f, 0.0910799f},
    {-717.833f, -106.567f, 430.024f, 0.122173f},
    {-718.451f, -118.248f, 430.27f, 0.05236f},
    {-717.337f, -113.591f, 430.279f, 0.0910799f},
    {-717.076f, -116.456f, 430.361f, 0.0910799f},
    // Demolisher
    {-766.702f, -225.033f, 430.503f, 1.71042f},
    {-729.545f, -186.269f, 430.128f, 1.90241f},
    {-793.69f, -240.574f, 430.981f, 1.64061f},
    {-719.747f, -165.845f, 430.135f, 1.95477f},
    {-732.267f, -203.694f, 432.463f, 2.07694f},
    // Leviathan Positions
    // Siege
    {119.8f, 38.37f, 409.803f, 0.0f},
    {119.8f, 28.37f, 410.803f, 0.0f},
    {119.8f, 18.37f, 409.803f, 0.0f},
    {119.8f, 8.37f, 409.803f, 0.0f},
    {119.8f, -2.37f, 409.803f, 0.0f},
    // Chopper
    {119.8f, -17.37f, 409.803f, 0.0f},
    {119.8f, -27.37f, 409.803f, 0.0f},
    {119.8f, -37.37f, 409.803f, 0.0f},
    {119.8f, -47.37f, 409.803f, 0.0f},
    {119.8f, -57.37f, 409.803f, 0.0f},
    // Demolisher
    {119.8f, -72.37f, 409.803f, 0.0f},
    {119.8f, -82.37f, 409.803f, 0.0f},
    {119.8f, -92.37f, 409.803f, 0.0f},
    {119.8f, -102.37f, 409.803f, 0.0f},
    {119.8f, -112.37f, 409.803f, 0.0f},
};

void instance_ulduar::instance_ulduar_InstanceMapScript::SpawnLeviathanEncounterVehicles(uint8 mode)
{
    if (!_leviathanVehicles.empty())
    {
        for (ObjectGuid const& guid : _leviathanVehicles)
        {
            if (Creature* cr = instance->GetCreature(guid))
            {
                cr->DespawnOrUnsummon();
            }
        }

        _leviathanVehicles.clear();
    }

    if (mode < VEHICLE_POS_NONE)
    {
        for (uint8 i = 0; i < (instance->Is25ManRaid() ? 5 : 2); ++i)
        {
            if (TempSummon* veh = instance->SummonCreature(NPC_SALVAGED_SIEGE_ENGINE, vehiclePositions[15 * mode + i]))
            {
                _leviathanVehicles.push_back(veh->GetGUID());
            }
            if (TempSummon* veh = instance->SummonCreature(NPC_VEHICLE_CHOPPER, vehiclePositions[15 * mode + i + 5]))
            {
                _leviathanVehicles.push_back(veh->GetGUID());
            }
            if (TempSummon* veh = instance->SummonCreature(NPC_SALVAGED_DEMOLISHER, vehiclePositions[15 * mode + i + 10]))
            {
                _leviathanVehicles.push_back(veh->GetGUID());
            }
        }
    }
}

void AddSC_instance_ulduar()
{
    new instance_ulduar();
}
