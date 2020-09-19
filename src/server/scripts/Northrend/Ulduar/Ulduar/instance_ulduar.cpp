/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ulduar.h"
#include "Vehicle.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Transport.h"

class instance_ulduar : public InstanceMapScript
{
public:
    instance_ulduar() : InstanceMapScript("instance_ulduar", 603) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_ulduar_InstanceMapScript(pMap);
    }

    struct instance_ulduar_InstanceMapScript : public InstanceScript
    {
        instance_ulduar_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {Initialize();};

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        uint32 C_of_Ulduar_MASK;

        // Bosses
        uint64 m_uiLeviathanGUID;
        uint64 m_uiIgnisGUID;
        uint64 m_uiRazorscaleGUID;
        uint64 m_uiXT002GUID;
        uint64 m_auiAssemblyGUIDs[3];
        uint64 m_uiKologarnGUID;
        uint64 m_uiAuriayaGUID;
        uint64 m_uiMimironGUID;
        uint64 m_uiHodirGUID;
        uint64 m_uiThorimGUID;
        uint64 m_uiFreyaGUID;
        uint64 m_uiVezaxGUID;
        uint64 m_uiYoggSaronGUID;
        uint64 m_uiAlgalonGUID;

        // Flame Leviathan
        uint64 m_leviathanDoorsGUID;
        uint64 m_leviathanVisualTowers[4][2];
        uint64 m_RepairSGUID[2];
        uint64 m_lightningWalls[2];
        bool m_leviathanTowers[4];
        std::list<uint64> _leviathanVehicles;
        uint32 m_unbrokenAchievement;

        // Razorscale
        uint64 m_RazorscaleHarpoonFireStateGUID[4];

        // XT-002
        uint64 m_xt002DoorsGUID;

        // Kologarn
        uint64 KologarnDoorGUID;

        // Assembly of Iron
        uint64 m_assemblyDoorsGUID;
        uint64 m_archivumDoorsGUID;

        // Thorim
        uint64 m_thorimGameobjectsGUID[5];

        // Mimiron
        uint64 m_MimironDoor[3];
        uint64 m_MimironLeviathanMKIIguid;
        uint64 m_MimironVX001guid;
        uint64 m_MimironACUguid;

        // Freya
        uint64 m_FreyaElder[3];
        uint32 m_conspeedatoryAttempt;

        // Yogg-Saron
        uint64 m_saraGUID;
        uint64 m_yoggsaronBrainGUID;
        uint64 m_yoggsaronDoorsGUID;

        // Algalon
        uint64 m_algalonSigilDoorGUID[3];
        uint64 m_algalonFloorGUID[2];
        uint64 m_algalonUniverseGUID;
        uint64 m_algalonTrapdoorGUID;
        uint64 m_brannBronzebeardAlgGUID;
        uint32 m_algalonTimer;

        // Shared
        EventMap _events;
        bool m_mimironTramUsed;
        uint64 m_mimironTramGUID;
        uint64 m_keepersgateGUID;
        uint64 m_keepersGossipGUID[4];


        void Initialize()
        {
            // Bosses
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            C_of_Ulduar_MASK = 0;
            memset(&m_auiAssemblyGUIDs, 0, sizeof(m_auiAssemblyGUIDs));
            m_uiLeviathanGUID       = 0;
            m_uiIgnisGUID           = 0;
            m_uiRazorscaleGUID      = 0;
            m_uiXT002GUID           = 0;
            m_uiKologarnGUID        = 0;
            m_uiAuriayaGUID         = 0;
            m_uiMimironGUID         = 0;
            m_uiHodirGUID           = 0;
            m_uiThorimGUID          = 0;
            m_uiFreyaGUID           = 0;
            m_uiVezaxGUID           = 0;
            m_uiYoggSaronGUID       = 0;
            m_uiAlgalonGUID         = 0;

            // Flame Leviathan
            memset(&m_leviathanTowers, 1, sizeof(m_leviathanTowers));
            memset(&m_leviathanVisualTowers, 0, sizeof(m_leviathanVisualTowers));
            memset(&m_RepairSGUID, 0, sizeof(m_RepairSGUID));
            memset(&m_lightningWalls, 0, sizeof(m_lightningWalls));
            m_leviathanDoorsGUID    = 0;
            _leviathanVehicles.clear();
            m_unbrokenAchievement   = 1;

            // Razorscale
            memset(&m_RazorscaleHarpoonFireStateGUID, 0, sizeof(m_RazorscaleHarpoonFireStateGUID));

            // XT-002
            m_xt002DoorsGUID        = 0;

            // Kologarn Door
            // Assembly of Iron
            m_assemblyDoorsGUID     = 0;
            m_archivumDoorsGUID     = 0;

            // Thorim
            memset(&m_thorimGameobjectsGUID, 0, sizeof(m_thorimGameobjectsGUID));

            // Mimiron
            memset(&m_MimironDoor, 0, sizeof(m_MimironDoor));
            m_MimironLeviathanMKIIguid = 0;
            m_MimironVX001guid = 0;
            m_MimironACUguid = 0;

            // Freya
            memset(&m_FreyaElder, 0, sizeof(m_FreyaElder));
            m_conspeedatoryAttempt  = 0;

            // Yogg-Saron
            m_saraGUID              = 0;
            m_yoggsaronBrainGUID    = 0;
            m_yoggsaronDoorsGUID    = 0;

            // Algalon
            memset(&m_algalonSigilDoorGUID, 0, sizeof(m_algalonSigilDoorGUID));
            memset(&m_algalonFloorGUID, 0, sizeof(m_algalonFloorGUID));
            m_algalonUniverseGUID   = 0;
            m_algalonTrapdoorGUID   = 0;
            m_brannBronzebeardAlgGUID   = 0;
            m_algalonTimer          = 0;

            // Shared
            _events.Reset();
            memset(&m_keepersGossipGUID, 0, sizeof(m_keepersGossipGUID));
            m_mimironTramUsed       = false;
            m_mimironTramGUID       = 0;
            m_keepersgateGUID       = 0;
        }

        void FillInitialWorldStates(WorldPacket& packet)
        {
            packet << uint32(WORLD_STATE_ALGALON_TIMER_ENABLED) << uint32(m_algalonTimer && m_algalonTimer <= 60);
            packet << uint32(WORLD_STATE_ALGALON_DESPAWN_TIMER) << uint32(std::min<uint32>(m_algalonTimer, 60));
        }

        void OnPlayerEnter(Player* player)
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
                    _events.RescheduleEvent(EVENT_UPDATE_ALGALON_TIMER, 60000);
                    algalon->AI()->DoAction(ACTION_INIT_ALGALON);
                }
                else // if (m_algalonTimer = TIMER_ALGALON_TO_SUMMON)
                {
                    m_algalonTimer = TIMER_ALGALON_SUMMONED;
                    algalon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                }
            }
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < (MAX_ENCOUNTER-1); ++i)
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

        void ProcessEvent(WorldObject*  /*obj*/, uint32 eventId)
        {
            // destory towers
            if (eventId >= EVENT_TOWER_OF_LIFE_DESTROYED && eventId <= EVENT_TOWER_OF_FLAMES_DESTROYED)
                SetData(eventId, 0);
        }

        void OnCreatureCreate(Creature* creature)
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
                        creature->setDeathState(JUST_DIED);
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
                    m_keepersGossipGUID[TYPE_FREYA-TYPE_FREYA] = creature->GetGUID();
                    ShowKeeperGossip(TYPE_FREYA, creature);
                    break;
                case NPC_HODIR_GOSSIP:
                    m_keepersGossipGUID[TYPE_HODIR-TYPE_FREYA] = creature->GetGUID();
                    ShowKeeperGossip(TYPE_HODIR, creature);
                    break;
                case NPC_THORIM_GOSSIP:
                    m_keepersGossipGUID[TYPE_THORIM-TYPE_FREYA] = creature->GetGUID();
                    ShowKeeperGossip(TYPE_THORIM, creature);
                    break;
                case NPC_MIMIRON_GOSSIP:
                    m_keepersGossipGUID[TYPE_MIMIRON-TYPE_FREYA] = creature->GetGUID();
                    ShowKeeperGossip(TYPE_MIMIRON, creature);
                    break;
                case NPC_ELDER_IRONBRANCH:
                case NPC_ELDER_STONEBARK:
                case NPC_ELDER_BRIGHTLEAF:
                    m_FreyaElder[creature->GetEntry()-NPC_ELDER_IRONBRANCH] = creature->GetGUID();
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

        void OnCreatureRemove(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case NPC_BRANN_BRONZBEARD_ALG:
                    if (m_brannBronzebeardAlgGUID == creature->GetGUID())
                        m_brannBronzebeardAlgGUID = 0;
                    break;
            }
        }

        void OpenIfDone(uint32 encounter, GameObject *go, GOState state)
        {
            if (GetData(encounter) == DONE)
                go->SetGoState(state);
        }

        void ShowKeeperGossip(uint8 type, Creature *cr, uint64 guid = 0)
        {
            if (!cr)
            {
                cr = instance->GetCreature(guid);
                if (!cr)
                    return;
            }

            bool on = (GetData(type) == DONE && !(GetData(TYPE_WATCHERS) & (1 << (type-TYPE_FREYA))));
            cr->SetVisible(on);
        }

        void OnGameObjectCreate(GameObject* gameObject)
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
                    m_thorimGameobjectsGUID[DATA_THORIM_LEVER_GATE-DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                case GO_ARENA_LEVER:
                    m_thorimGameobjectsGUID[DATA_THORIM_LEVER-DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                case GO_ARENA_FENCE:
                    m_thorimGameobjectsGUID[DATA_THORIM_FENCE-DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                case GO_FIRST_COLOSSUS_DOORS:
                    m_thorimGameobjectsGUID[DATA_THORIM_FIRST_DOORS-DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                case GO_SECOND_COLOSSUS_DOORS:
                    m_thorimGameobjectsGUID[DATA_THORIM_SECOND_DOORS-DATA_THORIM_LEVER_GATE] = gameObject->GetGUID();
                    break;
                // Yogg-Saron
                case GO_YOGG_SARON_DOORS:
                    m_yoggsaronDoorsGUID = gameObject->GetGUID();
                    break;
                case GO_KEEPERS_GATE:
                    if (GetData(TYPE_MIMIRON) == DONE && GetData(TYPE_FREYA) == DONE && GetData(TYPE_HODIR) == DONE && GetData(TYPE_THORIM) == DONE)
                    {
                        instance->LoadGrid(1903.0f, 248.0f);
                        gameObject->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
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
                        gameObject->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
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
                        gameObject->SetRespawnTime(7*DAY);
                    break;
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case TYPE_LEVIATHAN:
                    m_auiEncounter[type] = data;
                    if (data == DONE)
                    {
                        Map::PlayerList const& pList = instance->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                            if (Vehicle* veh = itr->GetSource()->GetVehicle())
                                veh->Dismiss();
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
                    ShowKeeperGossip(type, NULL, m_keepersGossipGUID[type-TYPE_FREYA]);
                    if (GetData(TYPE_MIMIRON) == DONE && GetData(TYPE_FREYA) == DONE && GetData(TYPE_HODIR) == DONE && GetData(TYPE_THORIM) == DONE)
                    {
                        if (GameObject* go = instance->GetGameObject(m_keepersgateGUID))
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                    }
                    if (type == TYPE_MIMIRON && data == IN_PROGRESS) // after reaching him without tram and starting the fight
                        m_mimironTramUsed = true;
                    break;

                case TYPE_WATCHERS:
                    m_auiEncounter[type] |= 1 << data;
                    break;

                case EVENT_TOWER_OF_LIFE_DESTROYED:
                case EVENT_TOWER_OF_STORM_DESTROYED:
                case EVENT_TOWER_OF_FROST_DESTROYED:
                case EVENT_TOWER_OF_FLAMES_DESTROYED:
                    {
                        instance->LoadGrid(364.0f, -16.0f); //make sure leviathan is loaded
                        m_leviathanTowers[type-EVENT_TOWER_OF_LIFE_DESTROYED] = data;
                        GameObject* gobj = nullptr;
                        if ((gobj = instance->GetGameObject(m_leviathanVisualTowers[type-EVENT_TOWER_OF_LIFE_DESTROYED][0])))
                            gobj->SetGoState(GO_STATE_ACTIVE);
                        if ((gobj = instance->GetGameObject(m_leviathanVisualTowers[type-EVENT_TOWER_OF_LIFE_DESTROYED][1])))
                            gobj->SetGoState(GO_STATE_ACTIVE);
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
                    _events.RescheduleEvent(EVENT_UPDATE_ALGALON_TIMER, 60000);
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
                    if (GameObject* go = instance->GetGameObject(GetData64(GO_DOODAD_UL_SIGILDOOR_03)))
                    {
                        go->SetGoState(data != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = instance->GetGameObject(GetData64(GO_DOODAD_UL_UNIVERSEFLOOR_01)))
                    {
                        go->SetGoState(data != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = instance->GetGameObject(GetData64(GO_DOODAD_UL_UNIVERSEFLOOR_02)))
                    {
                        go->SetGoState(data == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = instance->GetGameObject(GetData64(GO_DOODAD_UL_UNIVERSEGLOBE01)))
                    {
                        go->SetGoState(data == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
                    }
                    if (GameObject* go = instance->GetGameObject(GetData64(GO_DOODAD_UL_ULDUAR_TRAPDOOR_03)))
                    {
                        go->SetGoState(data == IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                        go->EnableCollision(false);
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
            }

            // take care of herbs
            if (type == TYPE_FREYA && data == DONE)
            {
                std::list<GameObject*> goList;
                if (Creature* freya = instance->GetCreature(GetData64(TYPE_FREYA)))
                {
                    freya->GetGameObjectListWithEntryInGrid(goList, 191019 /*Adder's Tongue*/, 333.0f);
                    freya->GetGameObjectListWithEntryInGrid(goList, 190176 /*Frost Lotus*/, 333.0f);
                    freya->GetGameObjectListWithEntryInGrid(goList, 190171 /*Lichbloom*/, 333.0f);
                    freya->GetGameObjectListWithEntryInGrid(goList, 190170 /*Talandra's Rose*/, 333.0f);
                    freya->GetGameObjectListWithEntryInGrid(goList, 189973 /*Goldclover*/, 333.0f);

                    for (std::list<GameObject*>::const_iterator itr = goList.begin(); itr != goList.end(); ++itr)
                        (*itr)->SetRespawnTime(7*DAY);
                }
            }

            if (data == DONE || type == TYPE_LEVIATHAN || type == TYPE_WATCHERS)
                SaveToDB();

            if (type > TYPE_LEVIATHAN && type < TYPE_WATCHERS && data == IN_PROGRESS)
            {
                Map::PlayerList const& pList = instance->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                    if (Vehicle* veh = itr->GetSource()->GetVehicle())
                        veh->Dismiss();
            }
        }

        uint64 GetData64(uint32 data) const
        {
            switch(data)
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
                    return m_RazorscaleHarpoonFireStateGUID[data-200];

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
                    return m_thorimGameobjectsGUID[data-DATA_THORIM_LEVER_GATE];
                    break;

                // Freya Elders
                case NPC_ELDER_IRONBRANCH:
                case NPC_ELDER_STONEBARK:
                case NPC_ELDER_BRIGHTLEAF:
                    return m_FreyaElder[data-NPC_ELDER_IRONBRANCH];

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
                    return m_MimironDoor[data-311];

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

            return 0;
        }

        uint32 GetData(uint32 type) const
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
                    return m_leviathanTowers[type-EVENT_TOWER_OF_LIFE_DESTROYED];

                case DATA_UNBROKEN_ACHIEVEMENT:
                    return m_unbrokenAchievement;

                case DATA_CALL_TRAM:
                    return m_mimironTramUsed;
            }

            return 0;
        }

        void OnUnitDeath(Unit* unit)
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
                if (time(nullptr) > (m_conspeedatoryAttempt + DAY))
                {
                    DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, 21597 /*CON-SPEED-ATORY_TIMED_CRITERIA*/);
                    m_conspeedatoryAttempt = time(nullptr);
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

                    if (go && (C_of_Ulduar_MASK & (1<<i)) == 0)
                    {
                        C_of_Ulduar_MASK |= (1<<i);
                        SaveToDB();
                    }
                }
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "U U " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' ' << m_auiEncounter[3] << ' '
                       << m_auiEncounter[4] << ' ' << m_auiEncounter[5] << ' ' << m_auiEncounter[6] << ' ' << m_auiEncounter[7] << ' '
                       << m_auiEncounter[8] << ' ' << m_auiEncounter[9] << ' ' << m_auiEncounter[10] << ' ' << m_auiEncounter[11] << ' '
                       << m_auiEncounter[12] << ' ' << m_auiEncounter[13] << ' ' << m_auiEncounter[14] << ' ' << m_conspeedatoryAttempt << ' '
                       << m_unbrokenAchievement << ' ' << m_algalonTimer << ' ' << C_of_Ulduar_MASK;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn)
        {
            if (!strIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(strIn);

            char dataHead1, dataHead2;

            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'U' && dataHead2 == 'U')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    loadStream >> m_auiEncounter[i];

                    if (m_auiEncounter[i] == IN_PROGRESS && i != TYPE_WATCHERS)
                        m_auiEncounter[i] = NOT_STARTED;
                }

                // Achievements
                loadStream >> m_conspeedatoryAttempt;
                loadStream >> m_unbrokenAchievement;

                // Algalon
                loadStream >> m_algalonTimer;
                if (m_algalonTimer == TIMER_ALGALON_SUMMONED)
                    m_algalonTimer = TIMER_ALGALON_TO_SUMMON;

                if (m_algalonTimer && m_algalonTimer <= 60 && GetData(TYPE_ALGALON) != DONE)
                {
                    DoUpdateWorldState(WORLD_STATE_ALGALON_TIMER_ENABLED, 1);
                    DoUpdateWorldState(WORLD_STATE_ALGALON_DESPAWN_TIMER, m_algalonTimer);
                }

                // achievement Conqueror/Champion of Ulduar
                loadStream >> C_of_Ulduar_MASK;
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }


        void Update(uint32 diff)
        {
            if (_events.Empty())
                return;

            _events.Update(diff);
            switch (_events.GetEvent())
            {
                case EVENT_UPDATE_ALGALON_TIMER:
                    if (m_algalonTimer == TIMER_ALGALON_DEFEATED)
                    {
                        _events.PopEvent();
                        return;
                    }

                    SaveToDB();
                    DoUpdateWorldState(WORLD_STATE_ALGALON_DESPAWN_TIMER, --m_algalonTimer);
                    if (m_algalonTimer)
                    {
                        _events.RepeatEvent(60000);
                        return;
                    }

                    _events.PopEvent();
                    SetData(DATA_ALGALON_DEFEATED, 1);
                    if (Creature* algalon = instance->GetCreature(m_uiAlgalonGUID))
                        algalon->AI()->DoAction(ACTION_DESPAWN_ALGALON);
            }
        }

        void SpawnLeviathanEncounterVehicles(uint8 mode);

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch (criteria_id)
            {
                case 10042:
                case 10352:
                    return (C_of_Ulduar_MASK & (1<<TYPE_LEVIATHAN)) == 0;
                case 10342:
                case 10355:
                    return (C_of_Ulduar_MASK & (1<<TYPE_IGNIS)) == 0;
                case 10340:
                case 10353:
                    return (C_of_Ulduar_MASK & (1<<TYPE_RAZORSCALE)) == 0;
                case 10341:
                case 10354:
                    return (C_of_Ulduar_MASK & (1<<TYPE_XT002)) == 0;
                case 10598:
                case 10599:
                    return (C_of_Ulduar_MASK & (1<<TYPE_ASSEMBLY)) == 0;
                case 10348:
                case 10357:
                    return (C_of_Ulduar_MASK & (1<<TYPE_KOLOGARN)) == 0;
                case 10351:
                case 10363:
                    return (C_of_Ulduar_MASK & (1<<TYPE_AURIAYA)) == 0;
                case 10439:
                case 10719:
                    return (C_of_Ulduar_MASK & (1<<TYPE_HODIR)) == 0;
                case 10403:
                case 10404:
                    return (C_of_Ulduar_MASK & (1<<TYPE_THORIM)) == 0;
                case 10582:
                case 10583:
                    return (C_of_Ulduar_MASK & (1<<TYPE_FREYA)) == 0;
                case 10347:
                case 10361:
                    return (C_of_Ulduar_MASK & (1<<TYPE_MIMIRON)) == 0;
                case 10349:
                case 10362:
                    return (C_of_Ulduar_MASK & (1<<TYPE_VEZAX)) == 0;
                case 10350:
                case 10364:
                    return (C_of_Ulduar_MASK & (1<<TYPE_YOGGSARON)) == 0;
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
        for (std::list<uint64>::iterator itr = _leviathanVehicles.begin(); itr != _leviathanVehicles.end(); ++itr)
            if (Creature* cr = instance->GetCreature(*itr))
                if (Vehicle* veh = cr->GetVehicleKit())
                    veh->Dismiss();

        _leviathanVehicles.clear();
    }

    if (mode < VEHICLE_POS_NONE)
    {
        TempSummon* veh = nullptr;
        for (uint8 i = 0; i < (instance->Is25ManRaid() ? 5 : 2); ++i)
        {
            if ((veh = instance->SummonCreature(NPC_SALVAGED_SIEGE_ENGINE, vehiclePositions[15*mode+i])))
                _leviathanVehicles.push_back(veh->GetGUID());
            if ((veh = instance->SummonCreature(NPC_VEHICLE_CHOPPER, vehiclePositions[15*mode+i+5])))
                _leviathanVehicles.push_back(veh->GetGUID());
            if ((veh = instance->SummonCreature(NPC_SALVAGED_DEMOLISHER, vehiclePositions[15*mode+i+10])))
                _leviathanVehicles.push_back(veh->GetGUID());
        }
    }
}

void AddSC_instance_ulduar()
{
    new instance_ulduar();
}
