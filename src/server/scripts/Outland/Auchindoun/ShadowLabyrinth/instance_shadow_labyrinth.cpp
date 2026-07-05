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

#include "GameTime.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Map.h"
#include <set>
#include "SpellScriptLoader.h"
#include "shadow_labyrinth.h"
#include "SpellScript.h"

DoorData const doorData[] =
{
    { GO_REFECTORY_DOOR,      DATA_BLACKHEARTTHEINCITEREVENT, DOOR_TYPE_PASSAGE },
    { GO_SCREAMING_HALL_DOOR, DATA_GRANDMASTER_VORPIL,        DOOR_TYPE_PASSAGE },
    { 0,                      0,                              DOOR_TYPE_ROOM    }  // END
};

ObjectData const creatureData[] =
{
    { NPC_HELLMAW, TYPE_HELLMAW },
    { 0,           0            },
};

class instance_shadow_labyrinth : public InstanceMapScript
{
public:
    instance_shadow_labyrinth() : InstanceMapScript("instance_shadow_labyrinth", MAP_AUCHINDOUN_SHADOW_LABYRINTH) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_shadow_labyrinth_InstanceMapScript(map);
    }

    struct instance_shadow_labyrinth_InstanceMapScript : public InstanceScript
    {
        instance_shadow_labyrinth_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(EncounterCount);
            SetPersistentDataCount(PersistentDataCount);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, nullptr);
        }

        uint32 _ritualistsAliveCount;
        std::set<ObjectGuid::LowType> _murmurReinforcementSpawnIds;

        void Initialize() override
        {
            _ritualistsAliveCount = 0;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_CABAL_RITUALIST:
                    if (creature->IsAlive())
                    {
                        ++_ritualistsAliveCount;
                    }
                    break;
                case NPC_CABAL_SUMMONER:
                case NPC_CABAL_SPELLBINDER:
                    // Only the corridor reinforcements have a short respawn timer:
                    // they respawn endlessly to be zapped during Murmur's intro event.
                    if (creature->GetRespawnDelay() < MINUTE)
                    {
                        _murmurReinforcementSpawnIds.insert(creature->GetSpawnId());
                        if (GetBossState(DATA_MURMUR) == DONE)
                        {
                            creature->SetRespawnDelay(WEEK);
                            if (!creature->IsAlive())
                            {
                                creature->SetRespawnTime(WEEK);
                                creature->SaveRespawnTime();
                            }
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            // Once Murmur is dead his corridor reinforcements must stop respawning
            if (type == DATA_MURMUR && state == DONE)
            {
                for (ObjectGuid::LowType spawnId : _murmurReinforcementSpawnIds)
                {
                    bool found = false;
                    auto const bounds = instance->GetCreatureBySpawnIdStore().equal_range(spawnId);
                    for (auto itr = bounds.first; itr != bounds.second; ++itr)
                    {
                        found = true;
                        Creature* reinforcement = itr->second;
                        reinforcement->SetRespawnDelay(WEEK);
                        if (!reinforcement->IsAlive())
                        {
                            reinforcement->SetRespawnTime(WEEK);
                            reinforcement->SaveRespawnTime();
                        }
                    }

                    if (!found)
                    {
                        // Died and already despawned: override its pending map-level respawn
                        time_t respawnTime = GameTime::GetGameTime().count() + WEEK;
                        instance->SaveCreatureRespawnTime(spawnId, respawnTime);
                    }
                }
            }

            return true;
        }

        void OnUnitDeath(Unit* unit) override
        {
            InstanceScript::OnUnitDeath(unit);

            if (unit->GetEntry() == NPC_CABAL_RITUALIST)
            {
                if (!--_ritualistsAliveCount)
                {
                    StorePersistentData(TYPE_RITUALISTS, DONE);
                    if (Creature* hellmaw = GetCreature(TYPE_HELLMAW))
                    {
                        hellmaw->AI()->DoAction(1);
                    }
                }
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == TYPE_RITUALISTS)
                return GetPersistentData(TYPE_RITUALISTS);

            return 0;
        }
    };
};

// 33493 - Mark of Malice
enum MarkOfMalice
{
    SPELL_MARK_OF_MALICE_TRIGGERED = 33494
};

class spell_mark_of_malice : public AuraScript
{
    PrepareAuraScript(spell_mark_of_malice);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MARK_OF_MALICE_TRIGGERED });
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        if (GetCharges() > 1)
        {
            return;
        }

        GetTarget()->CastSpell(GetTarget(), SPELL_MARK_OF_MALICE_TRIGGERED, true);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_mark_of_malice::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

void AddSC_instance_shadow_labyrinth()
{
    new instance_shadow_labyrinth();
    RegisterSpellScript(spell_mark_of_malice);
}
