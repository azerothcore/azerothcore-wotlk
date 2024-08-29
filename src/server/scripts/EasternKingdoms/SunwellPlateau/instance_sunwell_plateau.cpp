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

#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "sunwell_plateau.h"

DoorData const doorData[] =
{
    { GO_FIRE_BARRIER,     DATA_FELMYST_DOORS,  DOOR_TYPE_PASSAGE },
    { GO_MURUS_GATE_1,     DATA_MURU,     DOOR_TYPE_ROOM   },
    { GO_MURUS_GATE_2,     DATA_MURU,     DOOR_TYPE_PASSAGE },
    { GO_BOSS_COLLISION_1, DATA_KALECGOS, DOOR_TYPE_ROOM   },
    { GO_BOSS_COLLISION_2, DATA_KALECGOS, DOOR_TYPE_ROOM   },
    { GO_FORCE_FIELD,      DATA_KALECGOS, DOOR_TYPE_ROOM   },
    { 0,                   0,             DOOR_TYPE_ROOM   } // END
};

class instance_sunwell_plateau : public InstanceMapScript
{
public:
    instance_sunwell_plateau() : InstanceMapScript("instance_sunwell_plateau", 580) { }

    struct instance_sunwell_plateau_InstanceMapScript : public InstanceScript
    {
        instance_sunwell_plateau_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
        }

        void OnPlayerEnter(Player* player) override
        {
            instance->LoadGrid(1477.94f, 643.22f);
            instance->LoadGrid(1641.45f, 988.08f);
            if (GameObject* gobj = instance->GetGameObject(IceBarrierGUID))
                gobj->SendUpdateToPlayer(player);
        }

        Player const* GetPlayerInMap() const
        {
            Map::PlayerList const& players = instance->GetPlayers();

            if (!players.IsEmpty())
            {
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    Player* player = itr->GetSource();
                    if (player && !player->HasAura(45839))
                        return player;
                }
            }
            //else
            //    LOG_DEBUG("scripts", "Instance Sunwell Plateau: GetPlayerInMap, but PlayerList is empty!");

            return nullptr;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->GetSpawnId() > 0 || !creature->GetOwnerGUID().IsPlayer())
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

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_FORCE_FIELD:
                case GO_BOSS_COLLISION_1:
                case GO_BOSS_COLLISION_2:
                case GO_FIRE_BARRIER:
                case GO_MURUS_GATE_1:
                case GO_MURUS_GATE_2:
                    AddDoor(go);
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

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_FIRE_BARRIER:
                case GO_MURUS_GATE_1:
                case GO_MURUS_GATE_2:
                case GO_BOSS_COLLISION_1:
                case GO_BOSS_COLLISION_2:
                case GO_FORCE_FIELD:
                    RemoveDoor(go);
                    break;
                default:
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 id) const override
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
                    return blueFlightOrbGUID[id - DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1];
            }

            return ObjectGuid::Empty;
        }

    protected:
        ObjectGuid KalecgosDragonGUID;
        ObjectGuid SathrovarrGUID;
        ObjectGuid BrutallusGUID;
        ObjectGuid MadrigosaGUID;
        ObjectGuid FelmystGUID;
        ObjectGuid AlythessGUID;
        ObjectGuid SacrolashGUID;
        ObjectGuid MuruGUID;
        ObjectGuid KilJaedenGUID;
        ObjectGuid KilJaedenControllerGUID;
        ObjectGuid AnveenaGUID;
        ObjectGuid KalecgosKjGUID;

        ObjectGuid IceBarrierGUID;
        ObjectGuid blueFlightOrbGUID[4];
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
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

class spell_cataclysm_breath : public SpellScript
{
    PrepareSpellScript(spell_cataclysm_breath);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CORROSIVE_POISON, SPELL_FEVERED_FATIGUE, SPELL_HEX, SPELL_NECROTIC_POISON, SPELL_PIERCING_SHADOW, SPELL_SHRINK, SPELL_WAVERING_WILL, SPELL_WITHERED_TOUCH });
    }

    void HandleAfterCast()
    {
        if (Unit* target = GetExplTargetUnit())
            for (uint8 i = 0; i < 4; ++i)
                GetCaster()->CastSpell(target, RAND(SPELL_CORROSIVE_POISON, SPELL_FEVERED_FATIGUE, SPELL_HEX, SPELL_NECROTIC_POISON, SPELL_PIERCING_SHADOW, SPELL_SHRINK, SPELL_WAVERING_WILL, SPELL_WITHERED_TOUCH), true);
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_cataclysm_breath::HandleAfterCast);
    }
};

void AddSC_instance_sunwell_plateau()
{
    new instance_sunwell_plateau();
    RegisterSpellScript(spell_cataclysm_breath);
}
