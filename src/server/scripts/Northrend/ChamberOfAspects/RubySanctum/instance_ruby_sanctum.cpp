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
#include "InstanceScript.h"
#include "Spell.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldStateDefines.h"
#include "WorldStatePackets.h"
#include "ruby_sanctum.h"
#include <array>

BossBoundaryData const Boundaries =
{
    { DATA_GENERAL_ZARITHRIAN, new EllipseBoundary(Position(3013.409f, 529.492f), 45.0, 100.0) },
    { DATA_HALION, new CircleBoundary(Position(3156.037f, 533.2656f), 48.5) }
};

DoorData const Doors[] =
{
    { GO_FIRE_FIELD,          DATA_BALTHARUS_THE_WARBORN, DOOR_TYPE_PASSAGE },
    { GO_FLAME_WALLS,         DATA_SAVIANA_RAGEFIRE,      DOOR_TYPE_PASSAGE },
    { GO_FLAME_WALLS,         DATA_BALTHARUS_THE_WARBORN, DOOR_TYPE_PASSAGE },
    { GO_FLAME_WALLS,         DATA_GENERAL_ZARITHRIAN,    DOOR_TYPE_ROOM    },
    { GO_BURNING_TREE_4,      DATA_HALION_INTRO1,         DOOR_TYPE_PASSAGE },
    { GO_BURNING_TREE_3,      DATA_HALION_INTRO1,         DOOR_TYPE_PASSAGE },
    { GO_BURNING_TREE_2,      DATA_HALION_INTRO2,         DOOR_TYPE_PASSAGE },
    { GO_BURNING_TREE_1,      DATA_HALION_INTRO2,         DOOR_TYPE_PASSAGE },
    { GO_TWILIGHT_FLAME_RING, DATA_HALION,                DOOR_TYPE_ROOM    },
    { 0,                      0,                          DOOR_TYPE_ROOM    }
};

ObjectData const CreatureObjectData[] =
{
    { NPC_BALTHARUS_THE_WARBORN, DATA_BALTHARUS_THE_WARBORN },
    { NPC_XERESTRASZA,           DATA_XERESTRASZA           },
    { NPC_GENERAL_ZARITHRIAN,    DATA_GENERAL_ZARITHRIAN    },
    { NPC_HALION,                DATA_HALION                },
    { NPC_TWILIGHT_HALION,       DATA_TWILIGHT_HALION       },
    { NPC_HALION_CONTROLLER,     DATA_HALION_CONTROLLER     },
    { NPC_ORB_CARRIER,           DATA_ORB_CARRIER           },
    { 0,                         0                          }
};

ObjectData const GameObjectObjectData[] =
{
    { GO_FLAME_RING, DATA_FLAME_RING },
    { 0,             0               }
};

ObjectData const SummonObjectData[] =
{
    { NPC_ONYX_FLAMECALLER,    DATA_GENERAL_ZARITHRIAN },
    { NPC_LIVING_INFERNO,      DATA_HALION             },
    { NPC_LIVING_EMBER,        DATA_HALION             },
    { NPC_METEOR_STRIKE_NORTH, DATA_HALION             },
    { NPC_METEOR_STRIKE_SOUTH, DATA_HALION             },
    { NPC_METEOR_STRIKE_EAST,  DATA_HALION             },
    { NPC_METEOR_STRIKE_WEST,  DATA_HALION             },
    { NPC_METEOR_STRIKE_FLAME, DATA_HALION             },
    { NPC_COMBUSTION,          DATA_HALION             },
    { NPC_CONSUMPTION,         DATA_HALION             },
    { 0,                       0                       }
};

class instance_ruby_sanctum : public InstanceMapScript
{
public:
    instance_ruby_sanctum() : InstanceMapScript(RubySanctumScriptName, MAP_THE_RUBY_SANCTUM) { }

    struct instance_ruby_sanctum_InstanceMapScript : public InstanceScript
    {
        instance_ruby_sanctum_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadBossBoundaries(Boundaries);
            LoadDoorData(Doors);
            LoadObjectData(CreatureObjectData, GameObjectObjectData);
            LoadSummonData(SummonObjectData);
        }

        void OnPlayerEnter(Player* /*player*/) override
        {
            if (GetBossState(DATA_HALION_INTRO_DONE) != DONE && GetBossState(DATA_GENERAL_ZARITHRIAN) == DONE)
                if (Creature* halionController = GetCreature(DATA_HALION_CONTROLLER))
                    halionController->AI()->DoAction(ACTION_INTRO_HALION);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            if (creature->GetEntry() != NPC_ZARITHRIAN_SPAWN_STALKER)
                return;

            if (!_zarithrianSpawnStalkerGUIDs[0])
                _zarithrianSpawnStalkerGUIDs[0] = creature->GetGUID();
            else
                _zarithrianSpawnStalkerGUIDs[1] = creature->GetGUID();
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_ZARITHRIAN_SPAWN_STALKER_1:
                case DATA_ZARITHRIAN_SPAWN_STALKER_2:
                    return _zarithrianSpawnStalkerGUIDs[type - DATA_ZARITHRIAN_SPAWN_STALKER_1];
                default:
                    break;
            }

            return InstanceScript::GetGuidData(type);
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
                    {
                        if (Creature* zarithrian = GetCreature(DATA_GENERAL_ZARITHRIAN))
                        {
                            zarithrian->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            zarithrian->SetImmuneToPC(false);
                        }
                    }
                    break;
                case DATA_GENERAL_ZARITHRIAN:
                    if (state == DONE)
                        if (Creature* halionController = GetCreature(DATA_HALION_CONTROLLER))
                            halionController->AI()->DoAction(ACTION_INTRO_HALION);

                    break;
                case DATA_HALION:
                    DoUpdateWorldState(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_TOGGLE, 0);
                    DoUpdateWorldState(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_TWILIGHT, 0);
                    DoUpdateWorldState(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_MATERIAL, 0);
                    HandleGameObject(DATA_FLAME_RING, true);
                    break;
                default:
                    break;
            }

            return true;
        }

        void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override
        {
            packet.Worldstates.reserve(3);
            packet.Worldstates.emplace_back(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_MATERIAL, 50);
            packet.Worldstates.emplace_back(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_TWILIGHT, 50);
            packet.Worldstates.emplace_back(WORLD_STATE_RUBY_SANCTUM_CORPOREALITY_TOGGLE, 0);
        }

    private:
        std::array<ObjectGuid, 2> _zarithrianSpawnStalkerGUIDs;
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
