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
#include "eye_of_eternity.h"

ObjectData const creatureData[] =
{
    { NPC_MALYGOS, DATA_MALYGOS },
    { 0, 0 }
};

ObjectData const gameobjectData[] =
{
    { GO_IRIS_N,         DATA_IRIS           },
    { GO_IRIS_H,         DATA_IRIS           },
    { GO_EXIT_PORTAL,    DATA_EXIT_PORTAL    },
    { GO_NEXUS_PLATFORM, DATA_NEXUS_PLATFORM },
    { 0, 0 }
};

struct instance_eye_of_eternity : public InstanceScript
{
    instance_eye_of_eternity(Map* pMap) : InstanceScript(pMap)
    {
        SetHeaders(DataHeader);
        SetBossNumber(EncounterCount);
        LoadObjectData(creatureData, gameobjectData);
        Initialize();
        _pokeAchievementValid = false;
    }

    bool _pokeAchievementValid = false;
    GuidVector _vortexTriggers;

    void OnCreatureCreate(Creature* creature) override
    {
        InstanceScript::OnCreatureCreate(creature);

        if (creature->GetEntry() == NPC_VORTEX)
            _vortexTriggers.push_back(creature->GetGUID());
    }

    ObjectGuid GetGuidData(uint32 data) const override
    {
        if (data == DATA_VORTEX_TRIGGER)
            return !_vortexTriggers.empty() ? _vortexTriggers.front() : ObjectGuid::Empty;

        return InstanceScript::GetGuidData(data);
    }

    void VortexHandling()
    {
        Creature* malygos = GetCreature(DATA_MALYGOS);
        if (!malygos)
            return;

        for (ObjectGuid const& guid : _vortexTriggers)
        {
            uint8 counter = 0;
            if (Creature* trigger = instance->GetCreature(guid))
            {
                for (auto* ref : malygos->GetThreatMgr().GetUnsortedThreatList())
                {
                    if (counter >= 5)
                        break;

                    if (Player* player = ref->GetVictim()->ToPlayer())
                    {
                        if (player->IsGameMaster() || player->HasAura(SPELL_VORTEX_4))
                            continue;

                        player->CastSpell(trigger, SPELL_VORTEX_4, true);
                        counter++;
                    }
                }
            }
        }
    }

    void OnPlayerEnter(Player* player) override
    {
        if (player && player->IsAlive() && IsBossDone(DATA_MALYGOS))
            player->CastSpell(player, SPELL_SUMMON_RED_DRAGON_BUDDY, true);
    }

    void OnGameObjectCreate(GameObject* gameobject) override
    {
        InstanceScript::OnGameObjectCreate(gameobject);

        uint32 entry = gameobject->GetEntry();

        if (IsBossDone(DATA_MALYGOS))
        {
            if (entry == GO_IRIS_N || entry == GO_IRIS_H)
                gameobject->SetPhaseMask(2, true);
            else if (entry == GO_NEXUS_PLATFORM)
            {
                gameobject->SetDestructibleState(GO_DESTRUCTIBLE_DESTROYED, nullptr, true);
                gameobject->EnableCollision(false);
            }
        }
    }

    void SetData(uint32 type, uint32 /*data*/) override
    {
        switch (type)
        {
            case DATA_SET_IRIS_INACTIVE:
            {
                if (GameObject* iris = GetGameObject(DATA_IRIS))
                {
                    HandleGameObject(ObjectGuid::Empty, true, iris);
                    if (Creature* trigger = iris->SummonCreature(NPC_WORLD_TRIGGER_LAOI, *iris, TEMPSUMMON_TIMED_DESPAWN, 10000))
                        trigger->CastSpell(trigger, SPELL_IRIS_ACTIVATED, true);
                }
                break;
            }
            case DATA_HIDE_IRIS_AND_PORTAL:
                if (GameObject* iris = GetGameObject(DATA_IRIS))
                    iris->SetPhaseMask(2, true);
                if (GameObject* portal = GetGameObject(DATA_EXIT_PORTAL))
                    portal->SetPhaseMask(2, true);
                break;
            case DATA_VORTEX_HANDLING:
                VortexHandling();
                break;
        }
    }

    bool SetBossState(uint32 type, EncounterState state) override
    {
        if (!InstanceScript::SetBossState(type, state))
            return false;

        if (type != DATA_MALYGOS)
            return true;

        switch (state)
        {
            case NOT_STARTED:
                _pokeAchievementValid = false;
                if (GameObject* iris = GetGameObject(DATA_IRIS))
                {
                    iris->SetPhaseMask(1, true);
                    HandleGameObject(iris->GetGUID(), false, iris);
                }
                if (GameObject* portal = GetGameObject(DATA_EXIT_PORTAL))
                    portal->SetPhaseMask(1, true);
                if (GameObject* platform = GetGameObject(DATA_NEXUS_PLATFORM))
                {
                    platform->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, nullptr, true);
                    platform->EnableCollision(true);
                }
                break;
            case IN_PROGRESS:
                _pokeAchievementValid = (instance->GetPlayersCountExceptGMs() < (instance->GetSpawnMode() == 0 ? (uint32)9 : (uint32)21));
                break;
            case DONE:
                _pokeAchievementValid = false;
                if (GameObject* portal = GetGameObject(DATA_EXIT_PORTAL))
                    portal->SetPhaseMask(1, true);
                if (Creature* malygos = GetCreature(DATA_MALYGOS))
                    malygos->SummonCreature(NPC_ALEXSTRASZA, 798.0f, 1268.0f, 299.0f, 2.45f, TEMPSUMMON_MANUAL_DESPAWN);
                break;
            default:
                break;
        }

        return true;
    }

    void ProcessEvent(WorldObject* /*unit*/, uint32 eventId) override
    {
        if (eventId == EVENT_IRIS_ACTIVATED)
        {
            if (Creature* malygos = GetCreature(DATA_MALYGOS))
                if (Player* player = malygos->SelectNearestPlayer(250.0f))
                    malygos->AI()->AttackStart(player);
        }
        else if (eventId == EVENT_DESTROY_PLATFORM)
        {
            if (GameObject* platform = GetGameObject(DATA_NEXUS_PLATFORM))
            {
                platform->SetDestructibleState(GO_DESTRUCTIBLE_DESTROYED, nullptr, true);
                platform->EnableCollision(false);
            }
        }
    }

    bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* source, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
    {
        switch (criteria_id)
        {
            case ACHIEV_CRITERIA_A_POKE_IN_THE_EYE_10:
            case ACHIEV_CRITERIA_A_POKE_IN_THE_EYE_25:
                return _pokeAchievementValid;
            case ACHIEV_CRITERIA_DENYIN_THE_SCION_10:
            case ACHIEV_CRITERIA_DENYIN_THE_SCION_25:
                return source && source->GetVehicle() && source->GetVehicle()->GetVehicleInfo()->m_ID == 224;
        }
        return false;
    }
};

void AddSC_instance_eye_of_eternity()
{
    RegisterInstanceScript(instance_eye_of_eternity, MAP_THE_EYE_OF_ETERNITY);
}
