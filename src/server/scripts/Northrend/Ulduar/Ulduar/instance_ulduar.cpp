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
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Transport.h"
#include "WorldPacket.h"
#include "WorldStateDefines.h"
#include "WorldStatePackets.h"
#include "ulduar.h"

DoorData const doorData[] =
{
    { GO_LEVIATHAN_DOORS,              BOSS_LEVIATHAN, DOOR_TYPE_ROOM       },
    { GO_LIGHTNING_WALL1,              BOSS_LEVIATHAN, DOOR_TYPE_PASSAGE    },
    { GO_XT002_DOORS,                  BOSS_XT002,     DOOR_TYPE_ROOM       },
    { GO_ASSEMBLY_DOORS,               BOSS_ASSEMBLY,  DOOR_TYPE_ROOM       },
    { GO_ARCHIVUM_DOORS,               BOSS_ASSEMBLY,  DOOR_TYPE_PASSAGE    },
    { GO_MIMIRON_DOOR_1,               BOSS_MIMIRON,   DOOR_TYPE_ROOM       },
    { GO_MIMIRON_DOOR_2,               BOSS_MIMIRON,   DOOR_TYPE_ROOM       },
    { GO_MIMIRON_DOOR_3,               BOSS_MIMIRON,   DOOR_TYPE_ROOM       },
    { GO_HODIR_FRONTDOOR,              BOSS_HODIR,     DOOR_TYPE_ROOM       },
    { GO_HODIR_FROZEN_DOOR,            BOSS_HODIR,     DOOR_TYPE_PASSAGE    },
    { GO_HODIR_DOOR,                   BOSS_HODIR,     DOOR_TYPE_PASSAGE    },
    { GO_KEEPERS_GATE,                 BOSS_HODIR,     DOOR_TYPE_PASSAGE    },
    { GO_KEEPERS_GATE,                 BOSS_MIMIRON,   DOOR_TYPE_PASSAGE    },
    { GO_KEEPERS_GATE,                 BOSS_THORIM,    DOOR_TYPE_PASSAGE    },
    { GO_KEEPERS_GATE,                 BOSS_FREYA,     DOOR_TYPE_PASSAGE    },
    { GO_VEZAX_DOOR,                   BOSS_VEZAX,     DOOR_TYPE_PASSAGE    },
    // GO_YOGG_SARON_DOORS is handled by boss_yoggsaron_sara: it closes 15 seconds
    // after the pull, not immediately when the encounter enters IN_PROGRESS.
    { GO_DOODAD_UL_SIGILDOOR_03,       BOSS_ALGALON,   DOOR_TYPE_ROOM       },
    { GO_DOODAD_UL_UNIVERSEFLOOR_01,   BOSS_ALGALON,   DOOR_TYPE_ROOM       },
    { GO_DOODAD_UL_UNIVERSEFLOOR_02,   BOSS_ALGALON,   DOOR_TYPE_SPAWN_HOLE },
    { GO_DOODAD_UL_UNIVERSEGLOBE01,    BOSS_ALGALON,   DOOR_TYPE_SPAWN_HOLE },
    { GO_DOODAD_UL_ULDUAR_TRAPDOOR_03, BOSS_ALGALON,   DOOR_TYPE_SPAWN_HOLE },
    { 0,                               0,              DOOR_TYPE_ROOM       }
};

// Observation Ring keeper positions, indexed by KEEPER_* constants
static Position const ObservationRingKeepersPos[4] =
{
    {1945.6823f,  33.342014f, 411.44083f, 5.270895f}, // Freya
    {1945.7609f, -81.52171f,  411.4407f,  1.029744f}, // Hodir
    {2028.7656f,  17.42014f,  411.44458f, 3.857178f}, // Mimiron
    {2028.8219f, -65.73573f,  411.44257f, 2.460914f}  // Thorim
};

static uint32 const ObservationRingKeeperEntry[4] =
{
    NPC_FREYA_GOSSIP, NPC_HODIR_GOSSIP,
    NPC_MIMIRON_GOSSIP, NPC_THORIM_GOSSIP
};

static uint32 const ObservationRingKeeperData[4] =
{
    DATA_FREYA_GOSSIP, DATA_HODIR_GOSSIP,
    DATA_MIMIRON_GOSSIP, DATA_THORIM_GOSSIP
};

static uint32 const ObservationRingKeeperBoss[4] =
{
    BOSS_FREYA, BOSS_HODIR, BOSS_MIMIRON, BOSS_THORIM
};

// Yelled across the whole map ~59.5s after the kill, replaying when someone approaches the Formation Grounds on later visits
static struct { bool rhydian; uint8 textGroup; Milliseconds nextDelay; } const BrannRhydianDialogue[] =
{
    { false, 0, 8900ms }, // What a battle! Did you see that, Rhydian?!
    { true,  2, 8500ms }, // Our friends fought well, Brann, but we're not done yet.
    { false, 1, 8500ms }, // Perhaps so, but it's only a matter of time until we break back into Ulduar...
    { true,  3, 8500ms }, // None at all. I suspect it has something to do with that giant mechanical construct...
    { false, 2, 8500ms }, // Oi. So we'll have to contend with that thing after all then?
    { false, 3, 8500ms }, // What about the plated proto-drake and the fire giant that were spotted nearby?...
    { true,  4, 8500ms }, // The Kirin Tor can't possibly spare any additional resources...
    { true,  5, 8500ms }, // We can sneak past them. As long as we can take down that construct...
    { false, 4, 8500ms }, // Sneak?! What do you think we are, marmots?
    { true,  6, 8500ms }, // We're hunting an old god, Brann.
    { false, 5, 0ms    }  // Fine. If our allies are going to be the ones getting their hands dirty...
};

ObjectData const creatureData[] =
{
    { NPC_LEVIATHAN,    BOSS_LEVIATHAN  },
    { NPC_IGNIS,        BOSS_IGNIS      },
    { NPC_RAZORSCALE,   BOSS_RAZORSCALE },
    { NPC_XT002,        BOSS_XT002      },
    { NPC_HEART_OF_DECONSTRUCTOR,DATA_XT002_HEART },
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
    { NPC_MIMIRON_DB_TARGET,        DATA_MIMIRON_DB_TARGET      },
    // Freya elders
    { NPC_ELDER_IRONBRANCH,         DATA_ELDER_IRONBRANCH       },
    { NPC_ELDER_STONEBARK,          DATA_ELDER_STONEBARK        },
    { NPC_ELDER_BRIGHTLEAF,         DATA_ELDER_BRIGHTLEAF       },
    // Yogg-Saron helpers
    { NPC_SARA,                     DATA_SARA                   },
    { NPC_BRAIN_OF_YOGG_SARON,      DATA_BRAIN_OF_YOGG_SARON    },
    { NPC_VOICE_OF_YOGG_SARON,      DATA_VOICE_OF_YOGG_SARON    },
    // Observation Ring Keepers
    { NPC_FREYA_GOSSIP,             DATA_FREYA_GOSSIP           },
    { NPC_HODIR_GOSSIP,             DATA_HODIR_GOSSIP           },
    { NPC_MIMIRON_GOSSIP,           DATA_MIMIRON_GOSSIP         },
    { NPC_THORIM_GOSSIP,            DATA_THORIM_GOSSIP          },
    // Algalon helpers
    { NPC_BRANN_BRONZBEARD_ALG,     DATA_BRANN_BRONZEBEARD_ALG  },
    { NPC_BRANN_BASE_CAMP,          DATA_BRANN_BASE_CAMP        },
    // Flame Leviathan outro
    { NPC_BRANN_FORMATION_GROUNDS,  DATA_BRANN_FORMATION_GROUNDS },
    { 0,                0               }
};

ObjectData const gameobjectData[] =
{
    { GO_LEVIATHAN_DOORS,               DATA_LEVIATHAN_DOORS            },
    { GO_LIGHTNING_WALL1,               DATA_LIGHTNING_WALL1            },
    { GO_LIGHTNING_WALL2,               DATA_LIGHTNING_WALL2            },
    { GO_XT002_DOORS,                   DATA_XT002_DOORS                },
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
    // Hodir loot chests (DB-spawned, filtered by spawnMask per difficulty)
    { GO_HODIR_CHEST_NORMAL,            DATA_HODIR_CHEST_NORMAL         },
    { GO_HODIR_CHEST_NORMAL_HERO,       DATA_HODIR_CHEST_NORMAL_HERO    },
    { GO_HODIR_CHEST_HARD,              DATA_HODIR_CHEST_HARD           },
    { GO_HODIR_CHEST_HARD_HERO,         DATA_HODIR_CHEST_HARD_HERO      },
    { 0,                                0                               }
};

ObjectData const summonData[] =
{
    { NPC_SARONITE_ANIMUS,          BOSS_VEZAX }, // summoned by a Saronite Vapor, not Vezax
    { NPC_STRENGTHENED_IRON_ROOTS,  BOSS_FREYA }, // summoned by the rooted player, not Freya
    { 0,                            0          }
};

BossBoundaryData const boundaries =
{
    { BOSS_LEVIATHAN, new RectangleBoundary(130.0f, 450.0f, -170.0f, 110.0f) },
};

class instance_ulduar : public InstanceMapScript
{
public:
    instance_ulduar() : InstanceMapScript("instance_ulduar", MAP_ULDUAR) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_ulduar_InstanceMapScript(map);
    }

    struct instance_ulduar_InstanceMapScript : public InstanceScript
    {
        instance_ulduar_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            SetPersistentDataCount(MAX_PERSISTENT_DATA);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, gameobjectData);
            LoadSummonData(summonData);
            LoadBossBoundaries(boundaries);
            Initialize();
        };

        // Flame Leviathan
        ObjectGuid _leviathanVisualTowers[4][2];
        ObjectGuid _repairSGUID[2];
        bool _leviathanTowers[4];
        GuidList _leviathanVehicles;
        GuidUnorderedSet _leviathanGauntletGUIDs;
        GuidUnorderedSet _leviathanBeaconGUIDs;
        GuidList _leviathanCrewGUIDs;
        bool _leviathanOutroSpawned;
        bool _leviathanSequenceStarted;
        ObjectGuid _formationRhydianGUID;
        ObjectGuid _leviathanMachineGUID;

        // Hodir
        bool _hmHodir;

        // Ancient Gate
        Position const triggerAncientGatePosition = { 1883.65f, 269.272f, 418.406f };

        // Shared
        EventMap _events;
        bool _mimironTramUsed;
        bool _algalonResummonPending;

        void Initialize() override
        {
            // Flame Leviathan
            for (uint8 i = 0; i < 4; ++i)
                _leviathanTowers[i] = true;

            _leviathanVehicles.clear();
            _leviathanGauntletGUIDs.clear();
            _leviathanBeaconGUIDs.clear();
            _leviathanCrewGUIDs.clear();
            _leviathanOutroSpawned = false;
            _leviathanSequenceStarted = false;
            _formationRhydianGUID.Clear();
            _leviathanMachineGUID.Clear();

            // Hodir
            _hmHodir = true; // If players fail the Hardmode then becomes false

            // Shared
            _events.Reset();
            _mimironTramUsed       = false;
            _algalonResummonPending = false;
        }

        void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override
        {
            uint32 algalonTimer =
                GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER);
            packet.Worldstates.reserve(2);
            packet.Worldstates.emplace_back(
                WORLD_STATE_ULDUAR_ALGALON_TIMER_ENABLED,
                (algalonTimer && algalonTimer <= 60) ? 1 : 0);
            packet.Worldstates.emplace_back(
                WORLD_STATE_ULDUAR_ALGALON_DESPAWN_TIMER,
                std::min<uint32>(algalonTimer, 60));
        }

        void DespawnLeviathanGauntlet()
        {
            for (ObjectGuid const& guid : _leviathanGauntletGUIDs)
                if (Creature* creature = instance->GetCreature(guid))
                    creature->DespawnOrUnsummon(0ms, 7_days);
            _leviathanGauntletGUIDs.clear();

            for (ObjectGuid const& guid : _leviathanBeaconGUIDs)
                if (GameObject* beacon = instance->GetGameObject(guid))
                    beacon->SetDestructibleState(GO_DESTRUCTIBLE_DESTROYED, nullptr, true);
            _leviathanBeaconGUIDs.clear();
        }

        void SetLeviathanVehiclesUsable(bool usable)
        {
            for (ObjectGuid const& guid : _leviathanVehicles)
                if (Creature* vehicle = instance->GetCreature(guid))
                {
                    if (usable)
                        vehicle->SetNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);
                    else
                        vehicle->RemoveNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);
                }
        }

        void SpawnLeviathanOutro(bool justKilled)
        {
            if (_leviathanOutroSpawned)
                return;

            _leviathanOutroSpawned = true;

            std::list<TempSummon*> summons;
            instance->SummonCreatureGroup(SUMMON_GROUP_LEVIATHAN_OUTRO_RHYDIAN, &summons);
            if (!summons.empty())
                _formationRhydianGUID = summons.front()->GetGUID();

            summons.clear();
            instance->SummonCreatureGroup(SUMMON_GROUP_LEVIATHAN_OUTRO_MAGES, &summons);
            if (justKilled)
                for (TempSummon* mage : summons)
                    mage->CastSpell(mage, SPELL_SIMPLE_TELEPORT_VISUAL, true);

            summons.clear();
            instance->SummonCreatureGroup(SUMMON_GROUP_LEVIATHAN_OUTRO_BATTLE_MAGES, &summons);
            for (TempSummon* battleMage : summons)
            {
                if (justKilled)
                    battleMage->CastSpell(battleMage, SPELL_SIMPLE_TELEPORT_VISUAL, true);
                // The two by the portal sustain it; the one at the Formation Grounds teleporter does not
                if (battleMage->GetPositionX() > 200.0f)
                    battleMage->CastSpell(battleMage, SPELL_ARCANE_CHANNELING, false);
            }

            instance->SummonGameObjectGroup(GO_SUMMON_GROUP_LEVIATHAN_PORTAL);

            // The crew stands by the Leviathan gate until the sequence sends it into formation
            summons.clear();
            instance->SummonCreatureGroup(SUMMON_GROUP_LEVIATHAN_OUTRO_MARCH, &summons);
            for (TempSummon* crew : summons)
                _leviathanCrewGUIDs.push_back(crew->GetGUID());

            if (justKilled)
            {
                StartLeviathanOutroSequence();
                return;
            }

            // On later visits the landing, march and dialogue replay once someone approaches the Formation Grounds
            scheduler.Schedule(2s, [this](TaskContext context)
            {
                if (_leviathanSequenceStarted)
                    return;

                bool triggered = false;
                instance->DoForAllPlayers([&](Player* player)
                {
                    if (player->IsAlive() && player->GetExactDist2d(234.0f, -100.0f) < 150.0f)
                        triggered = true;
                });

                if (triggered)
                    StartLeviathanOutroSequence();
                else
                    context.Repeat(2s);
            });
        }

        void StartLeviathanOutroSequence()
        {
            if (_leviathanSequenceStarted)
                return;

            _leviathanSequenceStarted = true;

            // The crew runs its sniffed column routes into the formation slots, paired by group row order
            static uint32 const marchPaths[] =
            {
                3414401, 3414402, 3414403, 3414404, 3414405, 3414406,
                3414501, 3414502, 3414503, 3414504, 3414505, 3414506
            };
            if (std::vector<TempSummonData> const* formation = sObjectMgr->GetSummonGroup(MAP_ULDUAR, SUMMONER_TYPE_MAP, SUMMON_GROUP_LEVIATHAN_OUTRO))
            {
                auto slot = formation->begin();
                uint8 pathIndex = 0;
                for (ObjectGuid const& guid : _leviathanCrewGUIDs)
                {
                    Creature* crew = instance->GetCreature(guid);
                    if (!crew)
                        continue;
                    while (slot != formation->end() && slot->entry != crew->GetEntry())
                        ++slot;
                    if (slot == formation->end() || pathIndex >= sizeof(marchPaths) / sizeof(marchPaths[0]))
                        break;
                    crew->SetHomePosition(slot->pos);
                    crew->GetMotionMaster()->MovePath(marchPaths[pathIndex], FORCED_MOVEMENT_RUN);
                    ++slot;
                    ++pathIndex;
                }
            }
            _leviathanCrewGUIDs.clear();

            // The machine flies its sniffed arc over the grounds and reaches the descent point at ~36s
            std::list<TempSummon*> machine;
            instance->SummonCreatureGroup(SUMMON_GROUP_LEVIATHAN_OUTRO_MACHINE, &machine);
            if (!machine.empty())
            {
                _leviathanMachineGUID = machine.front()->GetGUID();
                machine.front()->SetCanFly(true);
                machine.front()->GetMotionMaster()->MovePath(PATH_FLYING_MACHINE_APPROACH);
            }

            scheduler.Schedule(13s, [this](TaskContext /*context*/)
            {
                if (Creature* rhydian = instance->GetCreature(_formationRhydianGUID))
                {
                    rhydian->SetHomePosition({ 239.31581f, -123.64426f, 409.80365f, 3.104f });
                    rhydian->GetMotionMaster()->MovePath(PATH_RHYDIAN_TO_BRANN, FORCED_MOVEMENT_WALK);
                }
            }).Schedule(36s, [this](TaskContext /*context*/)
            {
                if (Creature* flyingMachine = instance->GetCreature(_leviathanMachineGUID))
                    flyingMachine->GetMotionMaster()->MoveLand(0, { 246.4216f, -80.03793f, 409.80365f });
            }).Schedule(39s, [this](TaskContext /*context*/)
            {
                std::list<TempSummon*> brann;
                instance->SummonCreatureGroup(SUMMON_GROUP_LEVIATHAN_OUTRO_BRANN, &brann);
                if (brann.empty())
                    return;

                if (std::vector<TempSummonData> const* formation = sObjectMgr->GetSummonGroup(MAP_ULDUAR, SUMMONER_TYPE_MAP, SUMMON_GROUP_LEVIATHAN_OUTRO))
                    for (TempSummonData const& slot : *formation)
                        if (slot.entry == NPC_BRANN_FORMATION_GROUNDS)
                        {
                            brann.front()->SetHomePosition(slot.pos);
                            break;
                        }

                brann.front()->GetMotionMaster()->MovePath(PATH_BRANN_FORMATION_GROUNDS, FORCED_MOVEMENT_WALK);
            }).Schedule(59500ms, [this](TaskContext /*context*/)
            {
                PlayBrannRhydianLine(0);
            });
        }

        void PlayBrannRhydianLine(uint8 index)
        {
            auto const& line = BrannRhydianDialogue[index];
            Creature* speaker = line.rhydian
                ? instance->GetCreature(_formationRhydianGUID)
                : GetCreature(DATA_BRANN_FORMATION_GROUNDS);
            if (speaker)
                speaker->AI()->Talk(line.textGroup);

            uint8 const next = static_cast<uint8>(index + 1);
            if (next < static_cast<uint8>(sizeof(BrannRhydianDialogue) / sizeof(BrannRhydianDialogue[0])))
                scheduler.Schedule(line.nextDelay, [this, next](TaskContext /*context*/)
                {
                    PlayBrannRhydianLine(next);
                });
        }

        void OnPlayerEnter(Player* player) override
        {
            if (IsBossDone(BOSS_LEVIATHAN))
                SpawnLeviathanOutro(false);
            // The salvaged vehicles wait for the raid at the Expedition Base Camp, they are not tied to Brann's intro
            else if (GetBossState(BOSS_LEVIATHAN) != SPECIAL && _leviathanVehicles.empty())
                SpawnLeviathanEncounterVehicles(VEHICLE_POS_START);

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

            // Spawn Observation Ring keepers for defeated bosses
            uint32 watchersMask =
                GetPersistentData(PERSISTENT_DATA_WATCHERS_MASK);
            for (uint8 i = KEEPER_FREYA; i <= KEEPER_THORIM; ++i)
                if (IsBossDone(ObservationRingKeeperBoss[i])
                    && !(watchersMask & (1 << i))
                    && !GetObjectGuid(ObservationRingKeeperData[i]))
                    instance->SummonCreature(
                        ObservationRingKeeperEntry[i],
                        ObservationRingKeepersPos[i]);

            uint32 algalonTimer =
                GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER);
            if (!GetObjectGuid(BOSS_ALGALON) && !_algalonResummonPending && algalonTimer
                && (algalonTimer <= 60
                    || algalonTimer == TIMER_ALGALON_TO_SUMMON))
            {
                TempSummon* algalon = instance->SummonCreature(NPC_ALGALON, AlgalonLandPos);
                if (!algalon)
                    return;

                if (algalonTimer <= 60)
                {
                    _events.RescheduleEvent(EVENT_UPDATE_ALGALON_TIMER, 1min);
                    algalon->AI()->DoAction(ACTION_INIT_ALGALON);
                }
                else // if (algalonTimer == TIMER_ALGALON_TO_SUMMON)
                {
                    StorePersistentData(
                        PERSISTENT_DATA_ALGALON_TIMER,
                        TIMER_ALGALON_SUMMONED);
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
            else if (eventId == EVENT_HODIR_SHATTER_CHEST)
            {
                if (GameObject* go = GetHodirChest(true))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                    scheduler.Schedule(3s, [this](TaskContext /*context*/)
                    {
                        if (GetBossState(BOSS_HODIR) != DONE)
                            SetData(TYPE_HODIR_HM_FAIL, 0);
                    });
                }
            }
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

                        DespawnLeviathanGauntlet();
                        SpawnLeviathanOutro(true);
                    }
                    break;
                case BOSS_MIMIRON:
                    if (state == IN_PROGRESS)
                        _mimironTramUsed = true;
                    [[fallthrough]];
                case BOSS_HODIR:
                case BOSS_THORIM:
                case BOSS_FREYA:
                    if (AllBossesDone({BOSS_MIMIRON, BOSS_FREYA, BOSS_HODIR, BOSS_THORIM}))
                    {
                        scheduler.Schedule(45s, [this](TaskContext /*context*/)
                        {
                            if (Creature* trigger = instance->SummonCreature(NPC_ANCIENT_GATE_WORLD_TRIGGER, triggerAncientGatePosition, nullptr, 10 * IN_MILLISECONDS))
                                trigger->AI()->Talk(EMOTE_ANCIENT_GATE_UNLOCKED);
                        });
                    }
                    if (type == BOSS_HODIR && state == DONE)
                        setChestsLootable(BOSS_HODIR);
                    if (state == DONE)
                    {
                        uint8 keeperIdx = type - BOSS_FREYA;
                        instance->SummonCreature(
                            ObservationRingKeeperEntry[keeperIdx],
                            ObservationRingKeepersPos[keeperIdx]);
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
                case NPC_ALGALON:
                    if (!GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER))
                        creature->DespawnOrUnsummon();
                    break;
                // Gone for good once Flame Leviathan is defeated
                case NPC_STEELFORGED_DEFENDER:
                case NPC_DEFENDER_GENERATED:
                case NPC_ULDUAR_GAUNTLET_GENERATOR:
                case NPC_IRONWORK_CANNON:
                    if (IsBossDone(BOSS_LEVIATHAN))
                        creature->DespawnOrUnsummon(0ms, 7_days);
                    else
                        _leviathanGauntletGUIDs.insert(creature->GetGUID());
                    break;
                case NPC_ULDUAR_COLOSSUS:
                case NPC_RUNEFORGED_SENTRY:
                {
                    // Waypoint patrols survive the kill (sniffed); only the static spawns are cleared
                    CreatureData const* data = creature->GetCreatureData();
                    if (data && data->movementType == WAYPOINT_MOTION_TYPE)
                        break;
                    if (IsBossDone(BOSS_LEVIATHAN))
                        creature->DespawnOrUnsummon(0ms, 7_days);
                    else
                        _leviathanGauntletGUIDs.insert(creature->GetGUID());
                    break;
                }
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

            if ((gameObject->GetEntry() >= GO_STORM_BEACON_FIRST && gameObject->GetEntry() <= GO_STORM_BEACON_LAST)
                || gameObject->GetEntry() == GO_STORM_BEACON_FORMATION_GROUNDS)
            {
                if (IsBossDone(BOSS_LEVIATHAN))
                {
                    // Deferred: this hook runs before the object is in world, where SetDestructibleState
                    // cannot swap the collision model and AddToWorld would re-enable collision
                    scheduler.Schedule(1ms, [this, guid = gameObject->GetGUID()](TaskContext /*context*/)
                    {
                        if (GameObject* beacon = instance->GetGameObject(guid))
                            beacon->SetDestructibleState(GO_DESTRUCTIBLE_DESTROYED, nullptr, true);
                    });
                }
                else
                    _leviathanBeaconGUIDs.insert(gameObject->GetGUID());
                return;
            }

            switch (gameObject->GetEntry())
            {
                // Flame Leviathan
                case GO_REPAIR_STATION_TRAP:
                    {
                        if (_repairSGUID[0])
                            _repairSGUID[1] = gameObject->GetGUID();
                        else
                            _repairSGUID[0] = gameObject->GetGUID();
                        break;
                    }
                case GO_MIMIRONS_TARGETTING_CRYSTAL:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    _leviathanVisualTowers[3][0] = gameObject->GetGUID();
                    break;
                case GO_FREYAS_TARGETTING_CRYSTAL:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    _leviathanVisualTowers[0][0] = gameObject->GetGUID();
                    break;
                case GO_HODIRS_TARGETTING_CRYSTAL:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    _leviathanVisualTowers[2][0] = gameObject->GetGUID();
                    break;
                case GO_THORIMS_TARGETTING_CRYSTAL:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    _leviathanVisualTowers[1][0] = gameObject->GetGUID();
                    break;
                case GO_MIMIRONS_GENERATOR:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    _leviathanVisualTowers[3][1] = gameObject->GetGUID();
                    break;
                case GO_FREYAS_GENERATOR:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    _leviathanVisualTowers[0][1] = gameObject->GetGUID();
                    break;
                case GO_HODIRS_GENERATOR:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    _leviathanVisualTowers[2][1] = gameObject->GetGUID();
                    break;
                case GO_THORIMS_GENERATOR:
                    OpenIfDone(BOSS_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    _leviathanVisualTowers[1][1] = gameObject->GetGUID();
                    break;
                case GO_LEVIATHAN_DOORS:
                    if (GetBossState(BOSS_LEVIATHAN) >= DONE)
                        gameObject->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                    break;
                case GO_KOLOGARN_BRIDGE:
                    OpenIfDone(BOSS_KOLOGARN, gameObject, GO_STATE_READY);
                    break;
                case GO_KEEPERS_GATE:
                    if (AllBossesDone({BOSS_MIMIRON, BOSS_FREYA, BOSS_HODIR, BOSS_THORIM}))
                        gameObject->RemoveGameObjectFlag(GO_FLAG_LOCKED);
                    break;
                // Mimiron, Hodir, Vezax
                case GO_MIMIRON_ELEVATOR:
                    gameObject->EnableCollision(false);
                    break;
                case GO_SNOW_MOUND:
                    gameObject->EnableCollision(false);
                    break;
                // Hodir loot chests: spawned locked via gameobject_template_addon,
                // unlocked by setChestsLootable() when the encounter is defeated
                case GO_HODIR_CHEST_NORMAL:
                case GO_HODIR_CHEST_NORMAL_HERO:
                case GO_HODIR_CHEST_HARD:
                case GO_HODIR_CHEST_HARD_HERO:
                    if (GetBossState(BOSS_HODIR) == DONE)
                    {
                        gameObject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                        gameObject->SetLootRecipient(instance);
                    }
                    break;
                // Mimiron Tram
                case GO_MIMIRON_TRAM:
                    if (GetBossState(BOSS_MIMIRON) == DONE)
                        _mimironTramUsed = true;
                    break;
                // Algalon the Observer
                case GO_CELESTIAL_PLANETARIUM_ACCESS_10:
                case GO_CELESTIAL_PLANETARIUM_ACCESS_25:
                    if (GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER))
                        gameObject->SetGameObjectFlag(GO_FLAG_IN_USE);
                    break;
                case GO_DOODAD_UL_SIGILDOOR_03:
                case GO_DOODAD_UL_UNIVERSEFLOOR_01:
                case GO_DOODAD_UL_UNIVERSEFLOOR_02:
                case GO_DOODAD_UL_UNIVERSEGLOBE01:
                case GO_DOODAD_UL_ULDUAR_TRAPDOOR_03:
                    gameObject->EnableCollision(false);
                    break;
                case GO_DOODAD_UL_SIGILDOOR_01:
                    if (GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER))
                        gameObject->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_DOODAD_UL_SIGILDOOR_02:
                    if (GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER))
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
                // Freya Loot
                case 194324:
                case 194325:
                case 194326:
                case 194327:
                case 194328:
                case 194329:
                case 194330:
                case 194331:
                    gameObject->SetLootRecipient(instance);
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
                        if (_hmHodir)
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
                        _hmHodir = false;
                        go->DespawnOrUnsummon(0ms, 7_days);
                    }
                    break;
                case DATA_MAGE_BARRIER:
                    StorePersistentData(
                        PERSISTENT_DATA_MAGE_BARRIER, data);
                    break;
                case EVENT_KEEPER_TELEPORTED:
                    if (Creature* sara = GetCreature(DATA_SARA))
                        sara->AI()->DoAction(ACTION_SARA_UPDATE_SUMMON_KEEPERS);
                    break;
                case EVENT_TOWER_OF_LIFE_DESTROYED:
                case EVENT_TOWER_OF_STORM_DESTROYED:
                case EVENT_TOWER_OF_FROST_DESTROYED:
                case EVENT_TOWER_OF_FLAMES_DESTROYED:
                    {
                        _leviathanTowers[type - EVENT_TOWER_OF_LIFE_DESTROYED] = data;
                        for (uint8 i = 0; i < 2; ++i)
                        {
                            if (GameObject *gameObject = instance->GetGameObject(_leviathanVisualTowers[type - EVENT_TOWER_OF_LIFE_DESTROYED][i]))
                            {
                                gameObject->SetGoState(GO_STATE_ACTIVE);
                            }
                        }
                        return;
                    }

                case DATA_VEHICLE_SPAWN:
                    SpawnLeviathanEncounterVehicles(data);
                    return;
                case DATA_LEVIATHAN_VEHICLES_USABLE:
                    // Archmage Pentarus has just answered Brann, the crews get a moment to reach the vehicles
                    scheduler.Schedule(3s, [this](TaskContext /*context*/)
                    {
                        SetLeviathanVehiclesUsable(true);
                    });
                    return;
                case DATA_DESPAWN_ALGALON:
                    DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_TIMER_ENABLED, 1);
                    DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_DESPAWN_TIMER, 60);
                    StorePersistentData(PERSISTENT_DATA_ALGALON_TIMER, 60);
                    _events.RescheduleEvent(EVENT_UPDATE_ALGALON_TIMER, 1min);
                    return;
                case DATA_RESUMMON_ALGALON:
                    _algalonResummonPending = true;
                    _events.RescheduleEvent(EVENT_RESUMMON_ALGALON, 2s);
                    return;
                case DATA_ALGALON_SUMMON_STATE:
                case DATA_ALGALON_DEFEATED:
                    DoUpdateWorldState(WORLD_STATE_ULDUAR_ALGALON_TIMER_ENABLED, 0);
                    StorePersistentData(PERSISTENT_DATA_ALGALON_TIMER,
                        type == DATA_ALGALON_DEFEATED
                            ? TIMER_ALGALON_DEFEATED
                            : TIMER_ALGALON_SUMMONED);
                    _events.CancelEvent(EVENT_UPDATE_ALGALON_TIMER);
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

        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                // Flame Leviathan
                case DATA_REPAIR_STATION1:
                    return _repairSGUID[0];
                case DATA_REPAIR_STATION2:
                    return _repairSGUID[1];

            }

            return GetObjectGuid(data);
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case EVENT_TOWER_OF_LIFE_DESTROYED:
                case EVENT_TOWER_OF_STORM_DESTROYED:
                case EVENT_TOWER_OF_FROST_DESTROYED:
                case EVENT_TOWER_OF_FLAMES_DESTROYED:
                    return _leviathanTowers[type - EVENT_TOWER_OF_LIFE_DESTROYED];

                case DATA_MAGE_BARRIER:
                    return GetPersistentData(
                        PERSISTENT_DATA_MAGE_BARRIER);

                case DATA_CALL_TRAM:
                    return _mimironTramUsed;
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
                uint32 conspeedatory =
                    GetPersistentData(PERSISTENT_DATA_CONSPEEDATORY);
                if (GameTime::GetGameTime().count() > (conspeedatory + DAY))
                {
                    DoStartTimedAchievement(
                        ACHIEVEMENT_TIMED_TYPE_EVENT,
                        21597 /*CON-SPEED-ATORY_TIMED_CRITERIA*/);
                    StorePersistentData(PERSISTENT_DATA_CONSPEEDATORY,
                        GameTime::GetGameTime().count());
                }
            }

            // achievement Champion/Conqueror of Ulduar
            if (unit->IsPlayer())
                for (uint8 i = 0; i <= 12; ++i)
                {
                    bool inCombat = false;
                    if (i == BOSS_LEVIATHAN)
                    {
                        if (Creature* c = GetCreature(BOSS_LEVIATHAN))
                            if (c->IsInCombat())
                                inCombat = true;
                    }
                    else
                        inCombat = (GetBossState(i) == IN_PROGRESS);

                    uint32 mask =
                        GetPersistentData(PERSISTENT_DATA_C_OF_ULDUAR_MASK);
                    if (inCombat && (mask & (1 << i)) == 0)
                        StorePersistentData(
                            PERSISTENT_DATA_C_OF_ULDUAR_MASK,
                            mask | (1 << i));
                }
        }

        void Load(char const* data) override
        {
            InstanceScript::Load(data);

            if (!data)
                StorePersistentData(PERSISTENT_DATA_UNBROKEN, 1);

            uint32 algalonTimer =
                GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER);
            if (algalonTimer == TIMER_ALGALON_SUMMONED)
            {
                StorePersistentData(
                    PERSISTENT_DATA_ALGALON_TIMER,
                    TIMER_ALGALON_TO_SUMMON);
            }

            algalonTimer =
                GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER);
            if (algalonTimer && algalonTimer <= 60
                && GetBossState(BOSS_ALGALON) != DONE)
            {
                DoUpdateWorldState(
                    WORLD_STATE_ULDUAR_ALGALON_TIMER_ENABLED, 1);
                DoUpdateWorldState(
                    WORLD_STATE_ULDUAR_ALGALON_DESPAWN_TIMER,
                    algalonTimer);
            }
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
                {
                    uint32 algalonTimer =
                        GetPersistentData(PERSISTENT_DATA_ALGALON_TIMER);
                    if (algalonTimer == TIMER_ALGALON_DEFEATED)
                        return;

                    StorePersistentData(
                        PERSISTENT_DATA_ALGALON_TIMER,
                        --algalonTimer);
                    DoUpdateWorldState(
                        WORLD_STATE_ULDUAR_ALGALON_DESPAWN_TIMER,
                        algalonTimer);
                    if (algalonTimer)
                    {
                        _events.Repeat(1min);
                        return;
                    }

                    SetData(DATA_ALGALON_DEFEATED, 1);
                    if (Creature* algalon = GetCreature(BOSS_ALGALON))
                        algalon->AI()->DoAction(ACTION_DESPAWN_ALGALON);
                    break;
                }
                case EVENT_RESUMMON_ALGALON:
                    _algalonResummonPending = false;
                    if (!GetCreature(BOSS_ALGALON))
                        if (Creature* algalon = instance->SummonCreature(NPC_ALGALON, AlgalonSummonPos))
                            algalon->AI()->DoAction(ACTION_START_INTRO);
                    break;
            }
        }

        void SpawnLeviathanEncounterVehicles(uint8 mode);

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            uint32 mask = GetPersistentData(PERSISTENT_DATA_C_OF_ULDUAR_MASK);
            switch (criteria_id)
            {
                case 10042:
                case 10352:
                    return (mask & (1 << BOSS_LEVIATHAN)) == 0;
                case 10342:
                case 10355:
                    return (mask & (1 << BOSS_IGNIS)) == 0;
                case 10340:
                case 10353:
                    return (mask & (1 << BOSS_RAZORSCALE)) == 0;
                case 10341:
                case 10354:
                    return (mask & (1 << BOSS_XT002)) == 0;
                case 10598:
                case 10599:
                    return (mask & (1 << BOSS_ASSEMBLY)) == 0;
                case 10348:
                case 10357:
                    return (mask & (1 << BOSS_KOLOGARN)) == 0;
                case 10351:
                case 10363:
                    return (mask & (1 << BOSS_AURIAYA)) == 0;
                case 10439:
                case 10719:
                    return (mask & (1 << BOSS_HODIR)) == 0;
                case 10403:
                case 10404:
                    return (mask & (1 << BOSS_THORIM)) == 0;
                case 10582:
                case 10583:
                    return (mask & (1 << BOSS_FREYA)) == 0;
                case 10347:
                case 10361:
                    return (mask & (1 << BOSS_MIMIRON)) == 0;
                case 10349:
                case 10362:
                    return (mask & (1 << BOSS_VEZAX)) == 0;
                case 10350:
                case 10364:
                    return (mask & (1 << BOSS_YOGGSARON)) == 0;
            }
            return false;
        }

        bool CheckRequiredBosses(uint32 bossId, Player const* player) const override
        {
            if (_SkipCheckRequiredBosses(player))
                return true;

            switch (bossId)
            {
                case BOSS_YOGGSARON:
                    if (GetBossState(BOSS_VEZAX) != DONE)
                        return false;
                    break;
                default:
                    break;
            }

            return true;
        }
    };
};

const Position vehiclePositions[30] =
{
    // Start Positions (Sniffed)
    // Siege
    {-814.592f, -64.5436f, 429.927f, 5.96903f},
    {-784.746f, -33.7638f, 429.926f, 5.09636f},
    {-813.698f, -86.8924f, 430.158f, 6.0912f},
    {-720.126f, -14.5091f, 429.926f, 4.85201f},
    {-756.948f, -27.9419f, 429.927f, 5.07891f},
    // Chopper
    {-718.451f, -112.609f, 430.231f, 0.1745329f},
    {-717.833f, -106.567f, 430.024f, 0.122173f},
    {-718.451f, -118.248f, 430.2697f, 0.052359f},
    {-718.307f, -124.421f, 430.1585f, 0.174532f},
    {-718.000f, -130.715f, 429.9037f, 0.134259f}, // Not Sniffed
    // Demolisher
    {-766.702f, -225.033f, 430.503f, 1.71042f},
    {-729.545f, -186.269f, 430.128f, 2.93406f},
    {-793.69f, -240.574f, 430.981f, 1.64061f},
    {-719.747f, -165.845f, 430.135f, 1.95477f},
    {-746.234f, -211.748f, 431.754f, 1.83259f},
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

        // The raid may look the vehicles over on arrival, but cannot board them until the Kirin Tor say so
        if (mode == VEHICLE_POS_START && GetPersistentData(PERSISTENT_DATA_MAGE_BARRIER) != MAGE_BARRIER_LOWERED)
            SetLeviathanVehiclesUsable(false);
    }
}

void AddSC_instance_ulduar()
{
    new instance_ulduar();
}
