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

#include "CreatureScript.h"
#include "GameTime.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Transport.h"
#include "Vehicle.h"
#include "WorldPacket.h"
#include "ulduar.h"

class instance_ulduar : public InstanceMapScript
{
public:
    instance_ulduar() : InstanceMapScript("instance_ulduar", 603) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_ulduar_InstanceMapScript(pMap);
    }

    struct instance_ulduar_InstanceMapScript : public InstanceScript
    {
        instance_ulduar_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            Initialize();
            SetHeaders(DataHeader);
            // 0: 10 man difficulty
            // 1: 25 man difficulty
            m_difficulty = (pMap->Is25ManRaid() ? 0 : 1);
        };

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        uint32 C_of_Ulduar_MASK;

        int m_difficulty;

        // Bosses
        ObjectGuid m_uiLeviathanGUID;
        ObjectGuid m_uiIgnisGUID;
        ObjectGuid m_uiRazorscaleGUID;
        ObjectGuid m_uiXT002GUID;
        ObjectGuid m_auiAssemblyGUIDs[3];
        ObjectGuid m_uiKologarnGUID;
        ObjectGuid m_uiAuriayaGUID;
        ObjectGuid m_uiMimironGUID;
        ObjectGuid m_uiHodirGUID;
        ObjectGuid m_uiThorimGUID;
        ObjectGuid m_uiFreyaGUID;
        ObjectGuid m_uiVezaxGUID;
        ObjectGuid m_uiYoggSaronGUID;
        ObjectGuid m_uiAlgalonGUID;

        // Flame Leviathan
        ObjectGuid m_leviathanDoorsGUID;
        ObjectGuid m_leviathanVisualTowers[4][2];
        ObjectGuid m_RepairSGUID[2];
        ObjectGuid m_lightningWalls[2];
        bool m_leviathanTowers[4];
        GuidList _leviathanVehicles;
        uint32 m_unbrokenAchievement;
        uint32 m_mageBarrier;

        // Razorscale
        ObjectGuid m_RazorscaleHarpoonFireStateGUID[4];

        // XT-002
        ObjectGuid m_xt002DoorsGUID;

        // Kologarn
        ObjectGuid KologarnDoorGUID;

        // Assembly of Iron
        ObjectGuid m_assemblyDoorsGUID;
        ObjectGuid m_archivumDoorsGUID;

        // Thorim
        ObjectGuid m_thorimGameobjectsGUID[5];

        // Hodir's chests
        bool hmHodir;
        ObjectGuid m_hodirNormalChest;
        ObjectGuid m_hodirHardmodeChest;
        Position normalChestPosition = { 1967.152588f, -204.188461f, 432.686951f, 5.50957f };
        Position hardChestPosition = { 2035.94600f, -202.084885f, 432.686859f, 3.164077f };

        // Mimiron
        ObjectGuid m_MimironDoor[3];
        ObjectGuid m_MimironLeviathanMKIIguid;
        ObjectGuid m_MimironVX001guid;
        ObjectGuid m_MimironACUguid;

        // Freya
        ObjectGuid m_FreyaElder[3];
        uint32 m_conspeedatoryAttempt;

        // Yogg-Saron
        ObjectGuid m_saraGUID;
        ObjectGuid m_yoggsaronBrainGUID;
        ObjectGuid m_yoggsaronDoorsGUID;

        // Algalon
        ObjectGuid m_algalonSigilDoorGUID[3];
        ObjectGuid m_algalonFloorGUID[2];
        ObjectGuid m_algalonUniverseGUID;
        ObjectGuid m_algalonTrapdoorGUID;
        ObjectGuid m_brannBronzebeardAlgGUID;
        ObjectGuid m_brannBronzebeardBaseCamp;
        uint32 m_algalonTimer;

        // Shared
        EventMap _events;
        bool m_mimironTramUsed;
        ObjectGuid m_mimironTramGUID;
        ObjectGuid m_keepersgateGUID;
        ObjectGuid m_keepersGossipGUID[4];

        void Initialize() override
        {
            // Bosses
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
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

        void FillInitialWorldStates(WorldPacket& packet) override
        {
            packet << uint32(WORLD_STATE_ALGALON_TIMER_ENABLED) << uint32(m_algalonTimer && m_algalonTimer <= 60);
            packet << uint32(WORLD_STATE_ALGALON_DESPAWN_TIMER) << uint32(std::min<uint32>(m_algalonTimer, 60));
        }

        void OnPlayerEnter(Player* player) override
        {
            // mimiron tram:
            instance->LoadGrid(2307.0f, 284.632f);
            if (GameObject* MimironTram = instance->GetGameObject(m_mimironTramGUID))
                player->UpdateVisibilityOf(MimironTram);

            if (!m_uiAlgalonGUID && m_algalonTimer && (m_algalonTimer <= 60 || m_algalonTimer == TIMER_ALGALON_TO_SUMMON))
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
            for (uint8 i = 0; i < (MAX_ENCOUNTER - 1); ++i)
            {
                if (m_auiEncounter[i] == IN_PROGRESS)
                    return true;
            }

            // Leviathan does not use IN_PROGRESS type, instead SPECIAL is set and never reset,
            // Check if he is in combat.
            if (Unit* l = instance->GetCreature(m_uiLeviathanGUID))
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

        void SpawnHodirChests(Difficulty diff, Creature* hodir)
        {
            switch (diff)
            {
                case RAID_DIFFICULTY_10MAN_NORMAL: // 10 man chest
                {
                    if (!m_hodirNormalChest)
                    {
                        if (GameObject* go = hodir->SummonGameObject(
                            GO_HODIR_CHEST_NORMAL,
                            normalChestPosition.GetPositionX(),
                            normalChestPosition.GetPositionY(),
                            normalChestPosition.GetPositionZ(),
                            normalChestPosition.GetOrientation(), 0, 0, 0, 0, 0))
                        {
                            m_hodirNormalChest = go->GetGUID();
                            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                        }
                    }
                    if (!m_hodirHardmodeChest)
                    {
                        if (GameObject* go = hodir->SummonGameObject(
                            GO_HODIR_CHEST_HARD,
                            hardChestPosition.GetPositionX(),
                            hardChestPosition.GetPositionY(),
                            hardChestPosition.GetPositionZ(),
                            hardChestPosition.GetOrientation(), 0, 0, 0, 0, 0))
                        {
                            m_hodirHardmodeChest = go->GetGUID();
                            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                            hmHodir = true;
                        }
                    }
                    break;
                }
                case RAID_DIFFICULTY_25MAN_NORMAL: // 25 man chest
                {
                    if (!m_hodirNormalChest)
                    {
                        if (GameObject* go = hodir->SummonGameObject(
                            GO_HODIR_CHEST_NORMAL_HERO,
                            normalChestPosition.GetPositionX(),
                            normalChestPosition.GetPositionY(),
                            normalChestPosition.GetPositionZ(),
                            normalChestPosition.GetOrientation(), 0, 0, 0, 0, 0))
                        {
                            m_hodirNormalChest = go->GetGUID();
                            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                        }
                    }
                    if (!m_hodirHardmodeChest)
                    {
                        if (GameObject* go = hodir->SummonGameObject(
                            GO_HODIR_CHEST_HARD_HERO,
                            hardChestPosition.GetPositionX(),
                            hardChestPosition.GetPositionY(),
                            hardChestPosition.GetPositionZ(),
                            hardChestPosition.GetOrientation(), 0, 0, 0, 0, 0))
                        {
                            m_hodirHardmodeChest = go->GetGUID();
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
            switch(creature->GetEntry())
            {
                case NPC_LEVIATHAN:
                    m_uiLeviathanGUID = creature->GetGUID();
                    break;
                case NPC_IGNIS:
                    m_uiIgnisGUID = creature->GetGUID();
                    break;
                case NPC_RAZORSCALE:
                    m_uiRazorscaleGUID = creature->GetGUID();
                    break;
                case NPC_XT002:
                    m_uiXT002GUID = creature->GetGUID();
                    break;
                case NPC_STEELBREAKER:
                    m_auiAssemblyGUIDs[0] = creature->GetGUID();
                    break;
                case NPC_MOLGEIM:
                    m_auiAssemblyGUIDs[1] = creature->GetGUID();
                    break;
                case NPC_BRUNDIR:
                    m_auiAssemblyGUIDs[2] = creature->GetGUID();
                    break;
                case NPC_KOLOGARN:
                    m_uiKologarnGUID = creature->GetGUID();
                    if (GetData(TYPE_KOLOGARN) == DONE)
                    {
                        creature->SetDisableGravity(true);
                        creature->SetPosition(creature->GetHomePosition());
                        creature->setDeathState(DeathState::JustDied);
                        creature->StopMovingOnCurrentPos();
                    }
                    break;
                case NPC_AURIAYA:
                    m_uiAuriayaGUID = creature->GetGUID();
                    break;
                case NPC_MIMIRON:
                    m_uiMimironGUID = creature->GetGUID();
                    break;
                case NPC_HODIR:
                    m_uiHodirGUID = creature->GetGUID();
                    if (m_auiEncounter[TYPE_HODIR] != DONE)
                    {
                        SpawnHodirChests(instance->GetDifficulty(), creature);
                    }
                    break;
                case NPC_THORIM:
                    m_uiThorimGUID = creature->GetGUID();
                    break;
                case NPC_FREYA:
                    m_uiFreyaGUID = creature->GetGUID();
                    break;
                case NPC_VEZAX:
                    m_uiVezaxGUID = creature->GetGUID();
                    break;
                case NPC_YOGGSARON:
                    m_uiYoggSaronGUID = creature->GetGUID();
                    break;
                case NPC_ALGALON:
                    m_uiAlgalonGUID = creature->GetGUID();
                    break;
                case NPC_HARPOON_FIRE_STATE:
                    {
                        if( creature->GetPositionX() > 595 )
                            m_RazorscaleHarpoonFireStateGUID[3] = creature->GetGUID();
                        else if( creature->GetPositionX() > 585 )
                            m_RazorscaleHarpoonFireStateGUID[2] = creature->GetGUID();
                        else if( creature->GetPositionX() > 575 )
                            m_RazorscaleHarpoonFireStateGUID[1] = creature->GetGUID();
                        else
                            m_RazorscaleHarpoonFireStateGUID[0] = creature->GetGUID();
                    }
                    break;
                case NPC_MIMIRON_LEVIATHAN_MKII:
                    m_MimironLeviathanMKIIguid = creature->GetGUID();
                    break;
                case NPC_MIMIRON_VX001:
                    m_MimironVX001guid = creature->GetGUID();
                    break;
                case NPC_MIMIRON_ACU:
                    m_MimironACUguid = creature->GetGUID();
                    break;
                case NPC_FREYA_GOSSIP:
                    m_keepersGossipGUID[TYPE_FREYA - TYPE_FREYA] = creature->GetGUID();
                    ShowKeeperGossip(TYPE_FREYA, creature);
                    break;
                case NPC_HODIR_GOSSIP:
                    m_keepersGossipGUID[TYPE_HODIR - TYPE_FREYA] = creature->GetGUID();
                    ShowKeeperGossip(TYPE_HODIR, creature);
                    break;
                case NPC_THORIM_GOSSIP:
                    m_keepersGossipGUID[TYPE_THORIM - TYPE_FREYA] = creature->GetGUID();
                    ShowKeeperGossip(TYPE_THORIM, creature);
                    break;
                case NPC_MIMIRON_GOSSIP:
                    m_keepersGossipGUID[TYPE_MIMIRON - TYPE_FREYA] = creature->GetGUID();
                    ShowKeeperGossip(TYPE_MIMIRON, creature);
                    break;
                case NPC_ELDER_IRONBRANCH:
                case NPC_ELDER_STONEBARK:
                case NPC_ELDER_BRIGHTLEAF:
                    m_FreyaElder[creature->GetEntry() - NPC_ELDER_IRONBRANCH] = creature->GetGUID();
                    break;
                case NPC_SARA:
                    m_saraGUID = creature->GetGUID();
                    break;
                case NPC_BRAIN_OF_YOGG_SARON:
                    m_yoggsaronBrainGUID = creature->GetGUID();
                    break;
                case NPC_BRANN_BRONZBEARD_ALG:
                    m_brannBronzebeardAlgGUID = creature->GetGUID();
                    break;
                case NPC_BRANN_BASE_CAMP:
                    m_brannBronzebeardBaseCamp = creature->GetGUID();
                    break;
                //! These creatures are summoned by something else than Algalon
                //! but need to be controlled/despawned by him - so they need to be
                //! registered in his summon list
                case NPC_ALGALON_VOID_ZONE_VISUAL_STALKER:
                case NPC_ALGALON_STALKER_ASTEROID_TARGET_01:
                case NPC_ALGALON_STALKER_ASTEROID_TARGET_02:
                case NPC_UNLEASHED_DARK_MATTER:
                    if (Creature* algalon = instance->GetCreature(m_uiAlgalonGUID))
                        algalon->AI()->JustSummoned(creature);
                    break;
            }
        }

        void OnCreatureRemove(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_BRANN_BRONZBEARD_ALG:
                    if (m_brannBronzebeardAlgGUID == creature->GetGUID())
                        m_brannBronzebeardAlgGUID.Clear();
                    break;
            }
        }

        void OpenIfDone(uint32 encounter, GameObject* go, GOState state)
        {
            if (GetData(encounter) == DONE)
                go->SetGoState(state);
        }

        void ShowKeeperGossip(uint8 type, Creature* cr, ObjectGuid guid = ObjectGuid::Empty)
        {
            if (!cr)
            {
                cr = instance->GetCreature(guid);
                if (!cr)
                    return;
            }

            bool on = (GetData(type) == DONE && !(GetData(TYPE_WATCHERS) & (1 << (type - TYPE_FREYA))));
            cr->SetVisible(on);
        }

        void OnGameObjectCreate(GameObject* gameObject) override
        {
            switch (gameObject->GetEntry())
            {
                // Flame Leviathan
                case GO_REPAIR_STATION_TRAP:
                    {
                        if(m_RepairSGUID[0])
                            m_RepairSGUID[1] = gameObject->GetGUID();
                        else
                            m_RepairSGUID[0] = gameObject->GetGUID();
                        break;
                    }
                case GO_LIGHTNING_WALL1:
                    m_lightningWalls[0] = gameObject->GetGUID();
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    break;
                case GO_LIGHTNING_WALL2:
                    m_lightningWalls[1] = gameObject->GetGUID();
                    break;
                case GO_MIMIRONS_TARGETTING_CRYSTAL:
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[3][0] = gameObject->GetGUID();
                    break;
                case GO_FREYAS_TARGETTING_CRYSTAL:
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[0][0] = gameObject->GetGUID();
                    break;
                case GO_HODIRS_TARGETTING_CRYSTAL:
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[2][0] = gameObject->GetGUID();
                    break;
                case GO_THORIMS_TARGETTING_CRYSTAL:
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[1][0] = gameObject->GetGUID();
                    break;
                case GO_MIMIRONS_GENERATOR:
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[3][1] = gameObject->GetGUID();
                    break;
                case GO_FREYAS_GENERATOR:
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[0][1] = gameObject->GetGUID();
                    break;
                case GO_HODIRS_GENERATOR:
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[2][1] = gameObject->GetGUID();
                    break;
                case GO_THORIMS_GENERATOR:
                    OpenIfDone(TYPE_LEVIATHAN, gameObject, GO_STATE_ACTIVE);
                    m_leviathanVisualTowers[1][1] = gameObject->GetGUID();
                    break;
                case GO_LEVIATHAN_DOORS:
                    if (GetData(TYPE_LEVIATHAN) >= DONE)
                        gameObject->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                    m_leviathanDoorsGUID = gameObject->GetGUID();
                    break;
                // XT-002, Kologarn, Assembly of Iron
                case GO_XT002_DOORS:
                    m_xt002DoorsGUID = gameObject->GetGUID();
                    break;
                case GO_KOLOGARN_DOORS:
                    KologarnDoorGUID = gameObject->GetGUID();
                    break;
                case GO_KOLOGARN_BRIDGE:
                    OpenIfDone(TYPE_KOLOGARN, gameObject, GO_STATE_READY);
                    break;
                case GO_ASSEMBLY_DOORS:
                    m_assemblyDoorsGUID = gameObject->GetGUID();
                    break;
                case GO_ARCHIVUM_DOORS:
                    m_archivumDoorsGUID = gameObject->GetGUID();
                    OpenIfDone(TYPE_ASSEMBLY, gameObject, GO_STATE_ACTIVE);
                    break;
                // Thorim
                case GO_ARENA_LEVER_GATE:
                    m_thorimGameobjectsGUID[DATA_THORIM_LEVER_GATE - DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                case GO_ARENA_LEVER:
                    m_thorimGameobjectsGUID[DATA_THORIM_LEVER - DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                case GO_ARENA_FENCE:
                    m_thorimGameobjectsGUID[DATA_THORIM_FENCE - DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                case GO_FIRST_COLOSSUS_DOORS:
                    m_thorimGameobjectsGUID[DATA_THORIM_FIRST_DOORS - DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                case GO_SECOND_COLOSSUS_DOORS:
                    m_thorimGameobjectsGUID[DATA_THORIM_SECOND_DOORS - DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                // Yogg-Saron
                case GO_YOGG_SARON_DOORS:
                    m_yoggsaronDoorsGUID = gameObject->GetGUID();
                    break;
                case GO_KEEPERS_GATE:
                    if (GetData(TYPE_MIMIRON) == DONE && GetData(TYPE_FREYA) == DONE && GetData(TYPE_HODIR) == DONE && GetData(TYPE_THORIM) == DONE)
                    {
                        instance->LoadGrid(1903.0f, 248.0f);
                        gameObject->RemoveGameObjectFlag(GO_FLAG_LOCKED);
                    }

                    m_keepersgateGUID = gameObject->GetGUID();
                    break;
                // Mimiron, Hodir, Vezax
                case GO_MIMIRON_ELEVATOR:
                    gameObject->EnableCollision(false);
                    break;
                case GO_MIMIRON_DOOR_1:
                    m_MimironDoor[0] = gameObject->GetGUID();
                    break;
                case GO_MIMIRON_DOOR_2:
                    m_MimironDoor[1] = gameObject->GetGUID();
                    break;
                case GO_MIMIRON_DOOR_3:
                    m_MimironDoor[2] = gameObject->GetGUID();
                    break;
                case GO_HODIR_FROZEN_DOOR:
                case GO_HODIR_DOOR:
                    if (GetData(TYPE_HODIR) == DONE)
                        if( gameObject->GetGoState() != GO_STATE_ACTIVE )
                        {
                            gameObject->SetLootState(GO_READY);
                            gameObject->UseDoorOrButton(0, false);
                        }
                    break;
                case GO_VEZAX_DOOR:
                    if( GetData(TYPE_VEZAX) == DONE )
                        if( gameObject->GetGoState() != GO_STATE_ACTIVE )
                        {
                            gameObject->SetLootState(GO_READY);
                            gameObject->UseDoorOrButton(0, false);
                        }
                    break;
                case GO_SNOW_MOUND:
                    gameObject->EnableCollision(false);
                    break;
                case GO_MIMIRON_TRAM:
                    if (GetData(TYPE_MIMIRON) == DONE)
                        m_mimironTramUsed = true;
                    m_mimironTramGUID = gameObject->GetGUID();
                    break;
                // Algalon the Observer
                case GO_CELESTIAL_PLANETARIUM_ACCESS_10:
                case GO_CELESTIAL_PLANETARIUM_ACCESS_25:
                    if (m_algalonTimer)
                        gameObject->SetGameObjectFlag(GO_FLAG_IN_USE);
                    break;
                case GO_DOODAD_UL_SIGILDOOR_01:
                    m_algalonSigilDoorGUID[0] = gameObject->GetGUID();
                    if (m_algalonTimer)
                        gameObject->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_DOODAD_UL_SIGILDOOR_02:
                    m_algalonSigilDoorGUID[1] = gameObject->GetGUID();
                    if (m_algalonTimer)
                        gameObject->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_DOODAD_UL_SIGILDOOR_03:
                    m_algalonSigilDoorGUID[2] = gameObject->GetGUID();
                    break;
                case GO_DOODAD_UL_UNIVERSEFLOOR_01:
                    m_algalonFloorGUID[0] = gameObject->GetGUID();
                    break;
                case GO_DOODAD_UL_UNIVERSEFLOOR_02:
                    m_algalonFloorGUID[1] = gameObject->GetGUID();
                    break;
                case GO_DOODAD_UL_UNIVERSEGLOBE01:
                    m_algalonUniverseGUID = gameObject->GetGUID();
                    break;
                case GO_DOODAD_UL_ULDUAR_TRAPDOOR_03:
                    m_algalonTrapdoorGUID = gameObject->GetGUID();
                    break;
                // Herbs
                case 191019: // Adder's Tongue
                case 190176: // Frost Lotus
                case 190171: // Lichbloom
                case 190170: // Talandra's Rose
                case 189973: // Goldclover
                    if (GetData(TYPE_FREYA) == DONE)
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
                    case TYPE_HODIR:
                        if (hmHodir)
                        {
                            if (GameObject* go = instance->GetGameObject(m_hodirHardmodeChest))
                            {
                                go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                                go->SetLootRecipient(instance);
                            }
                        }
                        if (GameObject* go = instance->GetGameObject(m_hodirNormalChest))
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
            switch(type)
            {
                case TYPE_LEVIATHAN:
                    m_auiEncounter[type] = data;
                    if (data == DONE)
                    {
                        Map::PlayerList const& pList = instance->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                        {
                            if (Creature* vehicleCreature = itr->GetSource()->GetVehicleCreatureBase())
                            {
                                vehicleCreature->DespawnOrUnsummon();
                            }
                        }
                    }
                    break;
                case TYPE_IGNIS:
                case TYPE_RAZORSCALE:
                case TYPE_XT002:
                case TYPE_AURIAYA:
                case TYPE_VEZAX:
                case TYPE_YOGGSARON:
                case TYPE_KOLOGARN:
                    m_auiEncounter[type] = data;
                    break;
                case TYPE_ASSEMBLY:
                    if (GameObject* go = instance->GetGameObject(m_assemblyDoorsGUID))
                        go->SetGoState(data == IN_PROGRESS ? GO_STATE_READY : GO_STATE_ACTIVE);
                    if (GameObject* go = instance->GetGameObject(m_archivumDoorsGUID))
                        go->SetGoState(data == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);

                    m_auiEncounter[type] = data;
                    break;
                case TYPE_MIMIRON:
                case TYPE_HODIR:
                case TYPE_THORIM:
                case TYPE_FREYA:
                    m_auiEncounter[type] = data;
                    ShowKeeperGossip(type, nullptr, m_keepersGossipGUID[type - TYPE_FREYA]);
                    if (GetData(TYPE_MIMIRON) == DONE && GetData(TYPE_FREYA) == DONE && GetData(TYPE_HODIR) == DONE && GetData(TYPE_THORIM) == DONE)
                    {
                        if (GameObject* go = instance->GetGameObject(m_keepersgateGUID))
                            go->RemoveGameObjectFlag(GO_FLAG_LOCKED);
                    }
                    if (type == TYPE_MIMIRON && data == IN_PROGRESS) // after reaching him without tram and starting the fight
                        m_mimironTramUsed = true;
                    if (GetData(TYPE_HODIR) == DONE)
                        setChestsLootable(TYPE_HODIR);
                    break;
                case TYPE_HODIR_HM_FAIL:
                    if (GameObject* go = instance->GetGameObject(m_hodirHardmodeChest))
                    {
                        hmHodir = false;
                        go->Delete();
                        m_hodirHardmodeChest.Clear();
                    }
                    break;
                case TYPE_WATCHERS:
                    m_auiEncounter[type] |= 1 << data;
                    break;

                case DATA_MAGE_BARRIER:
                    m_mageBarrier = data;
                    break;

                case EVENT_TOWER_OF_LIFE_DESTROYED:
                case EVENT_TOWER_OF_STORM_DESTROYED:
                case EVENT_TOWER_OF_FROST_DESTROYED:
                case EVENT_TOWER_OF_FLAMES_DESTROYED:
                    {
                        instance->LoadGrid(364.0f, -16.0f); //make sure leviathan is loaded
                        instance->LoadGrid(364.0f, 32.0f); //make sure Mimiron's and Thorim's Targetting Crystal are loaded
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
                    DoUpdateWorldState(WORLD_STATE_ALGALON_TIMER_ENABLED, 1);
                    DoUpdateWorldState(WORLD_STATE_ALGALON_DESPAWN_TIMER, 60);
                    m_algalonTimer = 60;
                    _events.RescheduleEvent(EVENT_UPDATE_ALGALON_TIMER, 1min);
                    SaveToDB();
                    return;
                case DATA_ALGALON_SUMMON_STATE:
                case DATA_ALGALON_DEFEATED:
                    DoUpdateWorldState(WORLD_STATE_ALGALON_TIMER_ENABLED, 0);
                    m_algalonTimer = (type == DATA_ALGALON_DEFEATED ? TIMER_ALGALON_DEFEATED : TIMER_ALGALON_SUMMONED);
                    _events.CancelEvent(EVENT_UPDATE_ALGALON_TIMER);
                    SaveToDB();
                    return;
                case TYPE_ALGALON:
                    m_auiEncounter[type] = data;
                    if (GameObject* go = instance->GetGameObject(GetGuidData(GO_DOODAD_UL_SIGILDOOR_03)))
                    {
                        go->SetGoState(data != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = instance->GetGameObject(GetGuidData(GO_DOODAD_UL_UNIVERSEFLOOR_01)))
                    {
                        go->SetGoState(data != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = instance->GetGameObject(GetGuidData(GO_DOODAD_UL_UNIVERSEFLOOR_02)))
                    {
                        go->SetGoState(data == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = instance->GetGameObject(GetGuidData(GO_DOODAD_UL_UNIVERSEGLOBE01)))
                    {
                        go->SetGoState(data == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = instance->GetGameObject(GetGuidData(GO_DOODAD_UL_ULDUAR_TRAPDOOR_03)))
                    {
                        go->SetGoState(data == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }

                    if (data == FAIL)
                    {
                        scheduler.Schedule(5s, [this](TaskContext)
                        {
                            if (m_algalonTimer && (m_algalonTimer <= 60 || m_algalonTimer == TIMER_ALGALON_TO_SUMMON))
                            {
                                instance->SummonCreature(NPC_ALGALON, AlgalonLandPos);
                            }
                        });
                    }

                    break;

                // Achievement
                case DATA_DWARFAGEDDON:
                    DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_SPELL_TARGET, SPELL_DWARFAGEDDON);
                    DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_DWARFAGEDDON);
                    return;
                case DATA_CALL_TRAM:
                    if (GameObject* MimironTram = instance->GetGameObject(m_mimironTramGUID))
                        if (StaticTransport* t = MimironTram->ToStaticTransport())
                        {
                            if (data == 0 && t->GetGoState() == GO_STATE_ACTIVE && t->GetPathProgress() == t->GetPauseTime())
                                MimironTram->SetGoState(GO_STATE_READY);
                            if (data == 1 && t->GetGoState() == GO_STATE_READY && t->GetPathProgress() == 0)
                                MimironTram->SetGoState(GO_STATE_ACTIVE);
                        }
                    break;
                case DATA_BRANN_MEMOTESAY:
                    if (Creature* cr = instance->GetCreature(m_brannBronzebeardBaseCamp))
                    {
                        cr->TextEmote("Go to your vehicles!", nullptr, true);
                    }
                    break;
                case DATA_BRANN_EASY_MODE:
                    ProcessEvent(nullptr, EVENT_TOWER_OF_STORM_DESTROYED);
                    ProcessEvent(nullptr, EVENT_TOWER_OF_FROST_DESTROYED);
                    ProcessEvent(nullptr, EVENT_TOWER_OF_FLAMES_DESTROYED);
                    ProcessEvent(nullptr, EVENT_TOWER_OF_LIFE_DESTROYED);
                    break;
            }

            // take care of herbs
            if (type == TYPE_FREYA && data == DONE)
            {
                std::list<GameObject*> goList;
                if (Creature* freya = instance->GetCreature(GetGuidData(TYPE_FREYA)))
                {
                    freya->GetGameObjectListWithEntryInGrid(goList, 191019 /*Adder's Tongue*/, 333.0f);
                    freya->GetGameObjectListWithEntryInGrid(goList, 190176 /*Frost Lotus*/, 333.0f);
                    freya->GetGameObjectListWithEntryInGrid(goList, 190171 /*Lichbloom*/, 333.0f);
                    freya->GetGameObjectListWithEntryInGrid(goList, 190170 /*Talandra's Rose*/, 333.0f);
                    freya->GetGameObjectListWithEntryInGrid(goList, 189973 /*Goldclover*/, 333.0f);

                    for (std::list<GameObject*>::const_iterator itr = goList.begin(); itr != goList.end(); ++itr)
                        (*itr)->SetRespawnTime(7 * DAY);
                }
            }

            if (data == DONE || type == TYPE_LEVIATHAN || type == TYPE_WATCHERS)
                SaveToDB();

            if (type > TYPE_LEVIATHAN && type < TYPE_WATCHERS && data == IN_PROGRESS)
            {
                Map::PlayerList const& pList = instance->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                {
                    if (Creature* vehicleCreature = itr->GetSource()->GetVehicleCreatureBase())
                    {
                        vehicleCreature->DespawnOrUnsummon();
                    }
                }
            }
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                // Bosses
                case TYPE_LEVIATHAN:
                    return m_uiLeviathanGUID;
                case TYPE_IGNIS:
                    return m_uiIgnisGUID;
                case TYPE_RAZORSCALE:
                    return m_uiRazorscaleGUID;
                case TYPE_XT002:
                    return m_uiXT002GUID;
                case TYPE_KOLOGARN:
                    return m_uiKologarnGUID;
                case TYPE_AURIAYA:
                    return m_uiAuriayaGUID;
                case TYPE_MIMIRON:
                    return m_uiMimironGUID;
                case TYPE_HODIR:
                    return m_uiHodirGUID;
                case TYPE_THORIM:
                    return m_uiThorimGUID;
                case TYPE_FREYA:
                    return m_uiFreyaGUID;
                case TYPE_VEZAX:
                    return m_uiVezaxGUID;
                case TYPE_YOGGSARON:
                    return m_uiYoggSaronGUID;
                case TYPE_ALGALON:
                    return m_uiAlgalonGUID;
                case DATA_STEELBREAKER:
                    return m_auiAssemblyGUIDs[0];
                case DATA_MOLGEIM:
                    return m_auiAssemblyGUIDs[1];
                case DATA_BRUNDIR:
                    return m_auiAssemblyGUIDs[2];

                // Flame Leviathan
                case DATA_REPAIR_STATION1:
                    return m_RepairSGUID[0];
                case DATA_REPAIR_STATION2:
                    return m_RepairSGUID[1];
                case DATA_LIGHTNING_WALL1:
                    return m_lightningWalls[0];
                case DATA_LIGHTNING_WALL2:
                    return m_lightningWalls[1];
                case GO_LEVIATHAN_DOORS:
                    return m_leviathanDoorsGUID;

                // Razorscales Harpoon Fire State GUIDs
                case DATA_HARPOON_FIRE_STATE_1:
                case DATA_HARPOON_FIRE_STATE_2:
                case DATA_HARPOON_FIRE_STATE_3:
                case DATA_HARPOON_FIRE_STATE_4:
                    return m_RazorscaleHarpoonFireStateGUID[data - 200];

                // XT-002
                case GO_XT002_DOORS:
                    return m_xt002DoorsGUID;
                // XT-002
                case GO_KOLOGARN_DOORS:
                    return KologarnDoorGUID;
                // Thorim
                case DATA_THORIM_LEVER_GATE:
                case DATA_THORIM_LEVER:
                case DATA_THORIM_FENCE:
                case DATA_THORIM_FIRST_DOORS:
                case DATA_THORIM_SECOND_DOORS:
                    return m_thorimGameobjectsGUID[data - DATA_THORIM_LEVER_GATE];

                // Hodir chests
                case GO_HODIR_CHEST_HARD:
                    return m_hodirHardmodeChest;
                case GO_HODIR_CHEST_NORMAL:
                    return m_hodirNormalChest;

                // Freya Elders
                case NPC_ELDER_IRONBRANCH:
                case NPC_ELDER_STONEBARK:
                case NPC_ELDER_BRIGHTLEAF:
                    return m_FreyaElder[data - NPC_ELDER_IRONBRANCH];

                // Mimiron's first vehicle (spawned by default)
                case DATA_MIMIRON_LEVIATHAN_MKII:
                    return m_MimironLeviathanMKIIguid;
                case DATA_MIMIRON_VX001:
                    return m_MimironVX001guid;
                case DATA_MIMIRON_ACU:
                    return m_MimironACUguid;
                case DATA_GO_MIMIRON_DOOR_1:
                case DATA_GO_MIMIRON_DOOR_2:
                case DATA_GO_MIMIRON_DOOR_3:
                    return m_MimironDoor[data - 311];

                // Yogg-Saron
                case GO_YOGG_SARON_DOORS:
                    return m_yoggsaronDoorsGUID;
                case NPC_SARA:
                    return m_saraGUID;
                case NPC_BRAIN_OF_YOGG_SARON:
                    return m_yoggsaronBrainGUID;

                // Algalon the Observer
                case GO_DOODAD_UL_SIGILDOOR_01:
                    return m_algalonSigilDoorGUID[0];
                case GO_DOODAD_UL_SIGILDOOR_02:
                    return m_algalonSigilDoorGUID[1];
                case GO_DOODAD_UL_SIGILDOOR_03:
                    return m_algalonSigilDoorGUID[2];
                case GO_DOODAD_UL_UNIVERSEFLOOR_01:
                    return m_algalonFloorGUID[0];
                case GO_DOODAD_UL_UNIVERSEFLOOR_02:
                    return m_algalonFloorGUID[1];
                case GO_DOODAD_UL_UNIVERSEGLOBE01:
                    return m_algalonUniverseGUID;
                case GO_DOODAD_UL_ULDUAR_TRAPDOOR_03:
                    return m_algalonTrapdoorGUID;
                case NPC_BRANN_BRONZBEARD_ALG:
                    return m_brannBronzebeardAlgGUID;
            }

            return ObjectGuid::Empty;
        }

        uint32 GetData(uint32 type) const override
        {
            switch(type)
            {
                case TYPE_LEVIATHAN:
                case TYPE_IGNIS:
                case TYPE_RAZORSCALE:
                case TYPE_XT002:
                case TYPE_ASSEMBLY:
                case TYPE_KOLOGARN:
                case TYPE_AURIAYA:
                case TYPE_MIMIRON:
                case TYPE_HODIR:
                case TYPE_THORIM:
                case TYPE_FREYA:
                case TYPE_VEZAX:
                case TYPE_YOGGSARON:
                case TYPE_ALGALON:
                case TYPE_WATCHERS:
                    return m_auiEncounter[type];

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
            if (unit->GetTypeId() == TYPEID_PLAYER)
            {
                if (GetData(TYPE_ALGALON) == IN_PROGRESS)
                    if (Creature* algalon = instance->GetCreature(m_uiAlgalonGUID))
                        algalon->AI()->DoAction(ACTION_FEEDS_ON_TEARS_FAILED);
            }
            else if (unit->GetTypeId() == TYPEID_UNIT && unit->GetAreaId() == 4656 /*Conservatory of Life*/)
            {
                if (GameTime::GetGameTime().count() > (m_conspeedatoryAttempt + DAY))
                {
                    DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, 21597 /*CON-SPEED-ATORY_TIMED_CRITERIA*/);
                    m_conspeedatoryAttempt = GameTime::GetGameTime().count();
                    SaveToDB();
                }
            }

            // achievement Champion/Conqueror of Ulduar
            if (unit->GetTypeId() == TYPEID_PLAYER)
                for (uint8 i = 0; i <= 12; ++i)
                {
                    bool go = false;
                    if (i == TYPE_LEVIATHAN)
                    {
                        if (Creature* c = instance->GetCreature(m_uiLeviathanGUID))
                            if (c->IsInCombat())
                                go = true;
                    }
                    else
                        go = (m_auiEncounter[i] == IN_PROGRESS);

                    if (go && (C_of_Ulduar_MASK & (1 << i)) == 0)
                    {
                        C_of_Ulduar_MASK |= (1 << i);
                        SaveToDB();
                    }
                }
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> m_auiEncounter[0];
            data >> m_auiEncounter[1];
            data >> m_auiEncounter[2];
            data >> m_auiEncounter[3];
            data >> m_auiEncounter[4];
            data >> m_auiEncounter[5];
            data >> m_auiEncounter[6];
            data >> m_auiEncounter[7];
            data >> m_auiEncounter[8];
            data >> m_auiEncounter[9];
            data >> m_auiEncounter[10];
            data >> m_auiEncounter[11];
            data >> m_auiEncounter[12];
            data >> m_auiEncounter[13];
            data >> m_auiEncounter[14];
            data >> m_conspeedatoryAttempt;
            data >> m_unbrokenAchievement;
            data >> m_algalonTimer;

            if (m_algalonTimer == TIMER_ALGALON_SUMMONED)
                m_algalonTimer = TIMER_ALGALON_TO_SUMMON;

            if (m_algalonTimer && m_algalonTimer <= 60 && GetData(TYPE_ALGALON) != DONE)
            {
                DoUpdateWorldState(WORLD_STATE_ALGALON_TIMER_ENABLED, 1);
                DoUpdateWorldState(WORLD_STATE_ALGALON_DESPAWN_TIMER, m_algalonTimer);
            }

            data >> C_of_Ulduar_MASK;
            data >> m_mageBarrier;

            for (uint8 i = 0; i < (MAX_ENCOUNTER - 1); ++i)
            {
                if (m_auiEncounter[i] == IN_PROGRESS)
                {
                    m_auiEncounter[i] = NOT_STARTED;
                }
            }
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' ' << m_auiEncounter[3] << ' '
                << m_auiEncounter[4] << ' ' << m_auiEncounter[5] << ' ' << m_auiEncounter[6] << ' ' << m_auiEncounter[7] << ' '
                << m_auiEncounter[8] << ' ' << m_auiEncounter[9] << ' ' << m_auiEncounter[10] << ' ' << m_auiEncounter[11] << ' '
                << m_auiEncounter[12] << ' ' << m_auiEncounter[13] << ' ' << m_auiEncounter[14] << ' ' << m_conspeedatoryAttempt << ' '
                << m_unbrokenAchievement << ' ' << m_algalonTimer << ' ' << C_of_Ulduar_MASK << ' ' << m_mageBarrier;
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
                    {
                        return;
                    }

                    SaveToDB();
                    DoUpdateWorldState(WORLD_STATE_ALGALON_DESPAWN_TIMER, --m_algalonTimer);
                    if (m_algalonTimer)
                    {
                        _events.Repeat(1min);
                        return;
                    }

                    SetData(DATA_ALGALON_DEFEATED, 1);
                    if (Creature* algalon = instance->GetCreature(m_uiAlgalonGUID))
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
                    return (C_of_Ulduar_MASK & (1 << TYPE_LEVIATHAN)) == 0;
                case 10342:
                case 10355:
                    return (C_of_Ulduar_MASK & (1 << TYPE_IGNIS)) == 0;
                case 10340:
                case 10353:
                    return (C_of_Ulduar_MASK & (1 << TYPE_RAZORSCALE)) == 0;
                case 10341:
                case 10354:
                    return (C_of_Ulduar_MASK & (1 << TYPE_XT002)) == 0;
                case 10598:
                case 10599:
                    return (C_of_Ulduar_MASK & (1 << TYPE_ASSEMBLY)) == 0;
                case 10348:
                case 10357:
                    return (C_of_Ulduar_MASK & (1 << TYPE_KOLOGARN)) == 0;
                case 10351:
                case 10363:
                    return (C_of_Ulduar_MASK & (1 << TYPE_AURIAYA)) == 0;
                case 10439:
                case 10719:
                    return (C_of_Ulduar_MASK & (1 << TYPE_HODIR)) == 0;
                case 10403:
                case 10404:
                    return (C_of_Ulduar_MASK & (1 << TYPE_THORIM)) == 0;
                case 10582:
                case 10583:
                    return (C_of_Ulduar_MASK & (1 << TYPE_FREYA)) == 0;
                case 10347:
                case 10361:
                    return (C_of_Ulduar_MASK & (1 << TYPE_MIMIRON)) == 0;
                case 10349:
                case 10362:
                    return (C_of_Ulduar_MASK & (1 << TYPE_VEZAX)) == 0;
                case 10350:
                case 10364:
                    return (C_of_Ulduar_MASK & (1 << TYPE_YOGGSARON)) == 0;
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

