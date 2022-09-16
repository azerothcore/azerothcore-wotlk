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

#include "InstanceScript.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "temple_of_ahnqiraj.h"

ObjectData const creatureData[] =
{
    { NPC_SARTURA, DATA_SARTURA },
    { NPC_EYE_OF_CTHUN, DATA_EYE_OF_CTHUN },
    { NPC_OURO_SPAWNER, DATA_OURO_SPAWNER },
    { NPC_MASTERS_EYE, DATA_MASTERS_EYE },
    { NPC_VEKLOR, DATA_VEKLOR },
    { NPC_VEKNILASH, DATA_VEKNILASH }
};

class instance_temple_of_ahnqiraj : public InstanceMapScript
{
public:
    instance_temple_of_ahnqiraj() : InstanceMapScript("instance_temple_of_ahnqiraj", 531) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_temple_of_ahnqiraj_InstanceMapScript(map);
    }

    struct instance_temple_of_ahnqiraj_InstanceMapScript : public InstanceScript
    {
        instance_temple_of_ahnqiraj_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            LoadObjectData(creatureData, nullptr);
            doorGUIDs.fill(ObjectGuid::Empty);
            SetBossNumber(MAX_BOSS_NUMBER);
        }

        ObjectGuid SkeramGUID;
        ObjectGuid VemGUID;
        ObjectGuid KriGUID;
        ObjectGuid YaujGUID;
        ObjectGuid ViscidusGUID;
        ObjectGuid CThunGUID;
        GuidVector CThunGraspGUIDs;
        std::array<ObjectGuid, 3> doorGUIDs;

        uint32 BugTrioDeathCount;
        uint32 CthunPhase;

        void Initialize() override
        {
            BugTrioDeathCount = 0;
            CthunPhase = 0;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SKERAM:
                    SkeramGUID = creature->GetGUID();
                    if (!creature->IsAlive())
                    {
                        HandleGameObject(doorGUIDs[2], true);
                    }
                    break;
                case NPC_VEM:
                    VemGUID = creature->GetGUID();
                    break;
                case NPC_KRI:
                    KriGUID = creature->GetGUID();
                    break;
                case NPC_YAUJ:
                    YaujGUID = creature->GetGUID();
                    break;
                case NPC_VISCIDUS:
                    ViscidusGUID = creature->GetGUID();
                    break;
                case NPC_OURO_SPAWNER:
                    if (GetBossState(DATA_OURO) != DONE)
                        creature->Respawn();
                    break;
                case NPC_MASTERS_EYE:
                    if (GetBossState(DATA_TWIN_EMPERORS) != DONE)
                        creature->Respawn(true);
                    break;
                case NPC_CTHUN:
                    CThunGUID = creature->GetGUID();
                    if (!creature->IsAlive())
                    {
                        for (ObjectGuid const& guid : CThunGraspGUIDs)
                        {
                            if (GameObject* cthunGrasp = instance->GetGameObject(guid))
                            {
                                cthunGrasp->DespawnOrUnsummon(1s);
                            }
                        }
                    }
                    break;
                default:
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case AQ40_DOOR_1:
                    doorGUIDs[0] = go->GetGUID();
                    break;
                case AQ40_DOOR_2:
                    doorGUIDs[1] = go->GetGUID();
                    if (Creature* veklor = GetCreature(DATA_VEKLOR))
                    {
                        if (!veklor->IsAlive())
                        {
                            HandleGameObject(go->GetGUID(), true);
                        }
                    }
                    break;
                case AQ40_DOOR_3:
                    doorGUIDs[2] = go->GetGUID();
                    if (Creature* skeram = instance->GetCreature(SkeramGUID))
                    {
                        if (!skeram->IsAlive())
                        {
                            HandleGameObject(go->GetGUID(), true);
                        }
                    }
                    break;
                case GO_CTHUN_GRASP:
                    CThunGraspGUIDs.push_back(go->GetGUID());
                    if (Creature* CThun = instance->GetCreature(CThunGUID))
                    {
                        if (!CThun->IsAlive())
                        {
                            go->DespawnOrUnsummon(1s);
                        }
                    }
                    break;
                default:
                    break;
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_BUG_TRIO_DEATH:
                    return BugTrioDeathCount;

                case DATA_CTHUN_PHASE:
                    return CthunPhase;
            }
            return 0;
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case DATA_SKERAM:
                    return SkeramGUID;
                case DATA_VEM:
                    return VemGUID;
                case DATA_KRI:
                    return KriGUID;
                case DATA_YAUJ:
                    return YaujGUID;
                case DATA_VISCIDUS:
                    return ViscidusGUID;
                case AQ40_DOOR_1:
                    return doorGUIDs[0];
                case AQ40_DOOR_2:
                    return doorGUIDs[1];
                case AQ40_DOOR_3:
                    return doorGUIDs[2];
            }
            return ObjectGuid::Empty;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_BUG_TRIO_DEATH:
                    if (data != 0)
                        ++BugTrioDeathCount;
                    else
                        BugTrioDeathCount = 0;
                    break;
                case DATA_CTHUN_PHASE:
                    CthunPhase = data;
                    if (data == PHASE_CTHUN_DONE)
                    {
                        for (ObjectGuid const& guid : CThunGraspGUIDs)
                        {
                            if (GameObject* cthunGrasp = instance->GetGameObject(guid))
                            {
                                cthunGrasp->DespawnOrUnsummon(1s);
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

            switch (type)
            {
                case DATA_OURO:
                    if (state == FAIL)
                    {
                        if (Creature* ouroSpawner = GetCreature(DATA_OURO_SPAWNER))
                            ouroSpawner->Respawn();
                    }
                    break;
                default:
                    break;
            }

            return true;
        }
    };
};

// 4052, At Battleguard Sartura
class at_battleguard_sartura : public AreaTriggerScript
{
public:
    at_battleguard_sartura() : AreaTriggerScript("at_battleguard_sartura") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* sartura = instance->GetCreature(DATA_SARTURA))
            {
                if (sartura->IsAlive())
                {
                    sartura->SetInCombatWith(player);
                }
            }
        }
        return true;
    }
};

void AddSC_instance_temple_of_ahnqiraj()
{
    new instance_temple_of_ahnqiraj();
    new at_battleguard_sartura();
}
