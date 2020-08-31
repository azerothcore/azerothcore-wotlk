/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "Player.h"
#include "sunwell_plateau.h"

DoorData const doorData[] =
{
    { GO_FIRE_BARRIER,     DATA_FELMYST_DOORS,  DOOR_TYPE_PASSAGE, BOUNDARY_NONE },
    { GO_MURUS_GATE_1,     DATA_MURU,     DOOR_TYPE_ROOM,    BOUNDARY_NONE },
    { GO_MURUS_GATE_2,     DATA_MURU,     DOOR_TYPE_PASSAGE, BOUNDARY_NONE },
    { GO_BOSS_COLLISION_1, DATA_KALECGOS, DOOR_TYPE_ROOM,    BOUNDARY_NONE },
    { GO_BOSS_COLLISION_2, DATA_KALECGOS, DOOR_TYPE_ROOM,    BOUNDARY_NONE },
    { GO_FORCE_FIELD,      DATA_KALECGOS, DOOR_TYPE_ROOM,    BOUNDARY_NONE },
    { 0,                   0,             DOOR_TYPE_ROOM,    BOUNDARY_NONE } // END
};

class instance_sunwell_plateau : public InstanceMapScript
{
    public:
        instance_sunwell_plateau() : InstanceMapScript("instance_sunwell_plateau", 580) { }

        struct instance_sunwell_plateau_InstanceMapScript : public InstanceScript
        {
            instance_sunwell_plateau_InstanceMapScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTERS);
                LoadDoorData(doorData);

                KalecgosDragonGUID          = 0;
                SathrovarrGUID              = 0;
                BrutallusGUID               = 0;
                MadrigosaGUID               = 0;
                FelmystGUID                 = 0;
                AlythessGUID                = 0;
                SacrolashGUID               = 0;
                MuruGUID                    = 0;
                KilJaedenGUID               = 0;
                KilJaedenControllerGUID     = 0;
                AnveenaGUID                 = 0;
                KalecgosKjGUID              = 0;

                IceBarrierGUID              = 0;
                memset(&blueFlightOrbGUID, 0, sizeof(blueFlightOrbGUID));
            }

            void OnPlayerEnter(Player* player)
            {
                instance->LoadGrid(1477.94f, 643.22f);
                instance->LoadGrid(1641.45f, 988.08f);
                if (GameObject* gobj = instance->GetGameObject(IceBarrierGUID))
                    gobj->SendUpdateToPlayer(player);
            }

            Player const* GetPlayerInMap() const
            {
                Map::PlayerList const& players = instance->GetPlayers();

                if (!players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* player = itr->GetSource();
                        if (player && !player->HasAura(45839, 0))
                            return player;
                    }
                }
                //else
                //    TC_LOG_DEBUG("scripts", "Instance Sunwell Plateau: GetPlayerInMap, but PlayerList is empty!");

                return nullptr;
            }

            void OnCreatureCreate(Creature* creature)
            {
                if (creature->GetDBTableGUIDLow() > 0 || !IS_PLAYER_GUID(creature->GetOwnerGUID()))
                    creature->CastSpell(creature, SPELL_SUNWELL_RADIANCE, true);

                switch (creature->GetEntry())
                {
                    case NPC_KALECGOS:
                        KalecgosDragonGUID = creature->GetGUID();
                        break;
                    case NPC_SATHROVARR:
                        SathrovarrGUID = creature->GetGUID();
                        break;
                    case NPC_BRUTALLUS:
                        BrutallusGUID = creature->GetGUID();
                        break;
                    case NPC_MADRIGOSA:
                        MadrigosaGUID = creature->GetGUID();
                        break;
                    case NPC_FELMYST:
                        FelmystGUID = creature->GetGUID();
                        break;
                    case NPC_GRAND_WARLOCK_ALYTHESS:
                        AlythessGUID = creature->GetGUID();
                        break;
                    case NPC_LADY_SACROLASH:
                        SacrolashGUID = creature->GetGUID();
                        break;
                    case NPC_MURU:
                        MuruGUID = creature->GetGUID();
                        break;
                    case NPC_KILJAEDEN:
                        KilJaedenGUID = creature->GetGUID();
                        break;
                    case NPC_KILJAEDEN_CONTROLLER:
                        KilJaedenControllerGUID = creature->GetGUID();
                        break;
                    case NPC_ANVEENA:
                        AnveenaGUID = creature->GetGUID();
                        break;
                    case NPC_KALECGOS_KJ:
                        KalecgosKjGUID = creature->GetGUID();
                        break;

                    // Xinef: Felmyst encounter
                    case NPC_DEMONIC_VAPOR_TRAIL:
                    case NPC_UNYIELDING_DEAD:
                        if (Creature* felmyst = instance->GetCreature(FelmystGUID))
                            felmyst->AI()->JustSummoned(creature);
                        break;

                    // Xinef: M'uru encounter
                    case NPC_DARKNESS:
                    case NPC_VOID_SENTINEL:
                    case NPC_VOID_SPAWN:
                        if (Creature* muru = instance->GetCreature(MuruGUID))
                            muru->AI()->JustSummoned(creature);
                        break;

                    // Xinef: Kil'jaeden encounter
                    case NPC_FELFIRE_PORTAL:
                    case NPC_VOLATILE_FELFIRE_FIEND:
                    case NPC_SHIELD_ORB:
                    case NPC_SINISTER_REFLECTION:
                        if (Creature* kiljaedenC = instance->GetCreature(KilJaedenControllerGUID))
                            kiljaedenC->AI()->JustSummoned(creature);
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_FORCE_FIELD:
                    case GO_BOSS_COLLISION_1:
                    case GO_BOSS_COLLISION_2:
                    case GO_FIRE_BARRIER:
                    case GO_MURUS_GATE_1:
                    case GO_MURUS_GATE_2:
                        AddDoor(go, true);
                        break;
                    case GO_ICE_BARRIER:
                        IceBarrierGUID = go->GetGUID();
                        go->setActive(true);
                        break;
                    case GO_ORB_OF_THE_BLUE_DRAGONFLIGHT1:
                        blueFlightOrbGUID[0] = go->GetGUID();
                        break;
                    case GO_ORB_OF_THE_BLUE_DRAGONFLIGHT2:
                        blueFlightOrbGUID[1] = go->GetGUID();
                        break;
                    case GO_ORB_OF_THE_BLUE_DRAGONFLIGHT3:
                        blueFlightOrbGUID[2] = go->GetGUID();
                        break;
                    case GO_ORB_OF_THE_BLUE_DRAGONFLIGHT4:
                        blueFlightOrbGUID[3] = go->GetGUID();
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectRemove(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_FIRE_BARRIER:
                    case GO_MURUS_GATE_1:
                    case GO_MURUS_GATE_2:
                    case GO_BOSS_COLLISION_1:
                    case GO_BOSS_COLLISION_2:
                    case GO_FORCE_FIELD:
                        AddDoor(go, false);
                        break;
                    default:
                        break;
                }
            }

            uint64 GetData64(uint32 id) const
            {
                switch (id)
                {
                    case NPC_KALECGOS:
                        return KalecgosDragonGUID;
                    case NPC_SATHROVARR:
                        return SathrovarrGUID;
                    case NPC_BRUTALLUS:
                        return BrutallusGUID;
                    case NPC_MADRIGOSA:
                        return MadrigosaGUID;
                    case NPC_FELMYST:
                        return FelmystGUID;
                    case NPC_GRAND_WARLOCK_ALYTHESS:
                        return AlythessGUID;
                    case NPC_LADY_SACROLASH:
                        return SacrolashGUID;
                    case NPC_MURU:
                        return MuruGUID;
                    case NPC_ANVEENA:
                        return AnveenaGUID;
                    case NPC_KALECGOS_KJ:
                        return KalecgosKjGUID;
                    case NPC_KILJAEDEN_CONTROLLER:
                        return KilJaedenControllerGUID;
                    case NPC_KILJAEDEN:
                        return KilJaedenGUID;

                    // Orbs
                    case DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1:
                    case DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_2:
                    case DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_3:
                    case DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_4:
                        return blueFlightOrbGUID[id-DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1];
                }
                return 0;
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "S P " << GetBossSaveData();

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void Load(char const* str)
            {
                if (!str)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(str);

                char dataHead1, dataHead2;

                std::istringstream loadStream(str);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'S' && dataHead2 == 'P')
                {
                    for (uint32 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }
                }
                else
                    OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }

            protected:
                uint64 KalecgosDragonGUID;
                uint64 SathrovarrGUID;
                uint64 BrutallusGUID;
                uint64 MadrigosaGUID;
                uint64 FelmystGUID;
                uint64 AlythessGUID;
                uint64 SacrolashGUID;
                uint64 MuruGUID;
                uint64 KilJaedenGUID;
                uint64 KilJaedenControllerGUID;
                uint64 AnveenaGUID;
                uint64 KalecgosKjGUID;

                uint64 IceBarrierGUID;
                uint64 blueFlightOrbGUID[4];
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_sunwell_plateau_InstanceMapScript(map);
        }
};

enum cataclysmBreath
{
    SPELL_CORROSIVE_POISON      = 46293,
    SPELL_FEVERED_FATIGUE       = 46294,
    SPELL_HEX                   = 46295,
    SPELL_NECROTIC_POISON       = 46296,
    SPELL_PIERCING_SHADOW       = 46297,
    SPELL_SHRINK                = 46298,
    SPELL_WAVERING_WILL         = 46299,
    SPELL_WITHERED_TOUCH        = 46300
};

class spell_cataclysm_breath : public SpellScriptLoader
{
    public:
        spell_cataclysm_breath() : SpellScriptLoader("spell_cataclysm_breath") { }

        class spell_cataclysm_breath_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_cataclysm_breath_SpellScript);

            void HandleAfterCast()
            {
                if (Unit* target = GetExplTargetUnit())
                    for (uint8 i = 0; i < 4; ++i)
                        GetCaster()->CastSpell(target, RAND(SPELL_CORROSIVE_POISON, SPELL_FEVERED_FATIGUE, SPELL_HEX, SPELL_NECROTIC_POISON, SPELL_PIERCING_SHADOW, SPELL_SHRINK, SPELL_WAVERING_WILL, SPELL_WITHERED_TOUCH), true);
            }

            void Register()
            {
                AfterCast += SpellCastFn(spell_cataclysm_breath_SpellScript::HandleAfterCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_cataclysm_breath_SpellScript();
        }
};

void AddSC_instance_sunwell_plateau()
{
    new instance_sunwell_plateau();
    new spell_cataclysm_breath();
}
