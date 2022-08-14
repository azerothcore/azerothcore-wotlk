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

/* ScriptData
SDName: Instance_Temple_of_Ahnqiraj
SD%Complete: 80
SDComment:
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "InstanceScript.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "temple_of_ahnqiraj.h"

ObjectData const creatureData[] =
{
    { NPC_SARTURA, DATA_SARTURA },
    { NPC_EYE_OF_CTHUN, DATA_EYE_OF_CTHUN }
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
        }

        //If Vem is dead...
        bool IsBossDied[3];

        //Storing Skeram, Vem and Kri.
        ObjectGuid SkeramGUID;
        ObjectGuid VemGUID;
        ObjectGuid KriGUID;
        ObjectGuid YaujGUID;
        ObjectGuid VeklorGUID;
        ObjectGuid VeknilashGUID;
        ObjectGuid ViscidusGUID;
        std::array<ObjectGuid, 3> doorGUIDs;

        uint32 BugTrioDeathCount;

        uint32 CthunPhase;

        void Initialize() override
        {
            IsBossDied[0] = false;
            IsBossDied[1] = false;
            IsBossDied[2] = false;

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
                case NPC_VEKLOR:
                    VeklorGUID = creature->GetGUID();
                    if (!creature->IsAlive())
                    {
                        HandleGameObject(doorGUIDs[1], true);
                    }
                    break;
                case NPC_VEKNILASH:
                    VeknilashGUID = creature->GetGUID();
                    break;
                case NPC_VISCIDUS:
                    ViscidusGUID = creature->GetGUID();
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
                    if (Creature* veklor = instance->GetCreature(VeklorGUID))
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
                default:
                    break;
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_VEKLORISDEAD:
                    if (IsBossDied[1])
                        return 1;
                    break;

                case DATA_VEKNILASHISDEAD:
                    if (IsBossDied[2])
                        return 1;
                    break;

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
                case DATA_VEKLOR:
                    return VeklorGUID;
                case DATA_VEKNILASH:
                    return VeknilashGUID;
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

                case DATA_VEKLOR_DEATH:
                    IsBossDied[1] = true;
                    break;

                case DATA_VEKNILASH_DEATH:
                    IsBossDied[2] = true;
                    break;

                case DATA_CTHUN_PHASE:
                    CthunPhase = data;
                    break;
            }
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
