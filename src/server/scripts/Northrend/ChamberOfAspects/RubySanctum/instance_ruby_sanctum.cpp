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
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldPacket.h"
#include "WorldStatePackets.h"
#include "ruby_sanctum.h"

BossBoundaryData const boundaries =
{
    { DATA_GENERAL_ZARITHRIAN, new EllipseBoundary(Position(3013.409f, 529.492f), 45.0, 100.0) },
    { DATA_HALION, new CircleBoundary(Position(3156.037f, 533.2656f), 48.5) }
};

DoorData const doorData[] =
{
    {GO_FIRE_FIELD,     DATA_BALTHARUS_THE_WARBORN, DOOR_TYPE_PASSAGE },
    {GO_FLAME_WALLS,    DATA_SAVIANA_RAGEFIRE,      DOOR_TYPE_PASSAGE },
    {GO_FLAME_WALLS,    DATA_BALTHARUS_THE_WARBORN, DOOR_TYPE_PASSAGE },
    {GO_FLAME_WALLS,    DATA_GENERAL_ZARITHRIAN,    DOOR_TYPE_ROOM,   },
    {GO_BURNING_TREE_4, DATA_HALION_INTRO1,         DOOR_TYPE_PASSAGE },
    {GO_BURNING_TREE_3, DATA_HALION_INTRO1,         DOOR_TYPE_PASSAGE },
    {GO_BURNING_TREE_2, DATA_HALION_INTRO2,         DOOR_TYPE_PASSAGE },
    {GO_BURNING_TREE_1, DATA_HALION_INTRO2,         DOOR_TYPE_PASSAGE },
    {GO_TWILIGHT_FLAME_RING, DATA_HALION,           DOOR_TYPE_ROOM    },
    {0,                 0,                          DOOR_TYPE_ROOM    },
};

class instance_ruby_sanctum : public InstanceMapScript
{
public:
    instance_ruby_sanctum() : InstanceMapScript("instance_ruby_sanctum", 724) { }

    struct instance_ruby_sanctum_InstanceMapScript : public InstanceScript
    {
        instance_ruby_sanctum_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadBossBoundaries(boundaries);
            LoadDoorData(doorData);
        }

        void OnPlayerEnter(Player* /*player*/) override
        {
            if (GetBossState(DATA_HALION_INTRO_DONE) != DONE && GetBossState(DATA_GENERAL_ZARITHRIAN) == DONE)
            {
                if (Creature* halionController = instance->GetCreature(HalionControllerGUID))
                    halionController->AI()->DoAction(ACTION_INTRO_HALION);
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_BALTHARUS_THE_WARBORN:
                    BaltharusTheWarbornGUID = creature->GetGUID();
                    break;
                case NPC_XERESTRASZA:
                    XerestraszaGUID = creature->GetGUID();
                    break;
                case NPC_GENERAL_ZARITHRIAN:
                    GeneralZarithrianGUID = creature->GetGUID();
                    break;
                case NPC_ZARITHRIAN_SPAWN_STALKER:
                    if (!ZarithrianSpawnStalkerGUID[0])
                        ZarithrianSpawnStalkerGUID[0] = creature->GetGUID();
                    else
                        ZarithrianSpawnStalkerGUID[1] = creature->GetGUID();
                    break;
                case NPC_HALION:
                    HalionGUID = creature->GetGUID();
                    break;
                case NPC_TWILIGHT_HALION:
                    TwilightHalionGUID = creature->GetGUID();
                    break;
                case NPC_HALION_CONTROLLER:
                    HalionControllerGUID = creature->GetGUID();
                    break;
                case NPC_ORB_CARRIER:
                    OrbCarrierGUID = creature->GetGUID();
                    break;

                case NPC_LIVING_INFERNO:
                case NPC_LIVING_EMBER:
                case NPC_METEOR_STRIKE_NORTH:
                case NPC_METEOR_STRIKE_SOUTH:
                case NPC_METEOR_STRIKE_EAST:
                case NPC_METEOR_STRIKE_WEST:
                case NPC_METEOR_STRIKE_FLAME:
                case NPC_COMBUSTION:
                case NPC_CONSUMPTION:
                    if (Creature* halion = instance->GetCreature(HalionGUID))
                        halion->AI()->JustSummoned(creature);
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_FIRE_FIELD:
                case GO_FLAME_WALLS:
                case GO_BURNING_TREE_1:
                case GO_BURNING_TREE_2:
                case GO_BURNING_TREE_3:
                case GO_BURNING_TREE_4:
                case GO_TWILIGHT_FLAME_RING:
                    AddDoor(go);
                    break;
                case GO_FLAME_RING:
                    FlameRingGUID = go->GetGUID();
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_FIRE_FIELD:
                case GO_FLAME_WALLS:
                case GO_BURNING_TREE_1:
                case GO_BURNING_TREE_2:
                case GO_BURNING_TREE_3:
                case GO_BURNING_TREE_4:
                    RemoveDoor(go);
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case NPC_BALTHARUS_THE_WARBORN:
                    return BaltharusTheWarbornGUID;
                case NPC_XERESTRASZA:
                    return XerestraszaGUID;
                case NPC_GENERAL_ZARITHRIAN:
                    return GeneralZarithrianGUID;
                case DATA_ZARITHRIAN_SPAWN_STALKER_1:
                case DATA_ZARITHRIAN_SPAWN_STALKER_2:
                    return ZarithrianSpawnStalkerGUID[type - DATA_ZARITHRIAN_SPAWN_STALKER_1];
                case NPC_HALION_CONTROLLER:
                    return HalionControllerGUID;
                case NPC_HALION:
                    return HalionGUID;
                case NPC_TWILIGHT_HALION:
                    return TwilightHalionGUID;
                case NPC_ORB_CARRIER:
                    return OrbCarrierGUID;

                case GO_FLAME_RING:
                    return FlameRingGUID;
            }

            return ObjectGuid::Empty;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_HALION_INTRO_DONE:
                    if (state != DONE)
                    {
                        SetBossState(DATA_HALION_INTRO1, NOT_STARTED);
                        SetBossState(DATA_HALION_INTRO2, NOT_STARTED);
                    }
                    break;
                case DATA_SAVIANA_RAGEFIRE:
                case DATA_BALTHARUS_THE_WARBORN:
                    if (GetBossState(DATA_BALTHARUS_THE_WARBORN) == DONE && GetBossState(DATA_SAVIANA_RAGEFIRE) == DONE)
                        if (Creature* zarithrian = instance->GetCreature(GeneralZarithrianGUID))
                        {
                            zarithrian->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            zarithrian->SetImmuneToPC(false);
                        }
                    break;
                case DATA_GENERAL_ZARITHRIAN:
                    if (state == DONE)
                        if (Creature* halionController = instance->GetCreature(HalionControllerGUID))
                            halionController->AI()->DoAction(ACTION_INTRO_HALION);
                    break;
                case DATA_HALION:
                    DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TOGGLE, 0);
                    DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TWILIGHT, 0);
                    DoUpdateWorldState(WORLDSTATE_CORPOREALITY_MATERIAL, 0);
                    HandleGameObject(FlameRingGUID, true);
                    break;
            }

            return true;
        }

        void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override
        {
            packet.Worldstates.reserve(3);
            packet.Worldstates.emplace_back(WORLDSTATE_CORPOREALITY_MATERIAL, 50);
            packet.Worldstates.emplace_back(WORLDSTATE_CORPOREALITY_TWILIGHT, 50);
            packet.Worldstates.emplace_back(WORLDSTATE_CORPOREALITY_TOGGLE, 0);
        }

    protected:
        ObjectGuid BaltharusTheWarbornGUID;
        ObjectGuid XerestraszaGUID;
        ObjectGuid GeneralZarithrianGUID;
        ObjectGuid ZarithrianSpawnStalkerGUID[2];

        ObjectGuid HalionGUID;
        ObjectGuid TwilightHalionGUID;
        ObjectGuid HalionControllerGUID;
        ObjectGuid OrbCarrierGUID;
        ObjectGuid FlameRingGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_ruby_sanctum_InstanceMapScript(map);
    }
};

class spell_ruby_sanctum_rallying_shout : public SpellScript
{
    PrepareSpellScript(spell_ruby_sanctum_rallying_shout);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RALLY });
    }

    void CountAllies()
    {
        uint32 count = GetSpell()->GetUniqueTargetInfo()->size();
        if (count == GetCaster()->GetAuraCount(SPELL_RALLY))
            return;

        GetCaster()->RemoveAurasDueToSpell(SPELL_RALLY);
        if (count > 0)
            GetCaster()->CastCustomSpell(SPELL_RALLY, SPELLVALUE_AURA_STACK, count, GetCaster(), true);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_ruby_sanctum_rallying_shout::CountAllies);
    }
};

void AddSC_instance_ruby_sanctum()
{
    new instance_ruby_sanctum();
    RegisterSpellScript(spell_ruby_sanctum_rallying_shout);
}
