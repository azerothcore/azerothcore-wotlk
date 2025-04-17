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

#include "CreatureAI.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "blood_furnace.h"

DoorData const doorData[] =
{
    { GO_MAKER_DOOR_FRONT,   DATA_THE_MAKER, DOOR_TYPE_ROOM    },
    { GO_MAKER_DOOR_REAR,    DATA_THE_MAKER, DOOR_TYPE_PASSAGE },
    { GO_BROGGOK_DOOR_FRONT, DATA_BROGGOK,   DOOR_TYPE_ROOM    },
    { GO_BROGGOK_DOOR_REAR,  DATA_BROGGOK,   DOOR_TYPE_PASSAGE },
    { GO_KELIDAN_DOOR_EXIT1, DATA_KELIDAN,   DOOR_TYPE_PASSAGE },
    { GO_KELIDAN_DOOR_EXIT2, DATA_KELIDAN,   DOOR_TYPE_PASSAGE },
    { 0,                                0,   DOOR_TYPE_ROOM    } // END
};

ObjectData const gameobjectData[] =
{
    { GO_BROGGOK_DOOR_REAR, DATA_BROGGOK_REAR_DOOR },
    { GO_BROGGOK_LEVER,     DATA_BROGGOK_LEVER     },
    { 0,                    0,                     }
};

ObjectData const creatureData[] =
{
    { NPC_BROGGOK, DATA_BROGGOK },
    { NPC_KELIDAN, DATA_KELIDAN },
    { 0,           0            }
};

class instance_blood_furnace : public InstanceMapScript
{
public:
    instance_blood_furnace() : InstanceMapScript("instance_blood_furnace", 542) {}

    struct instance_blood_furnace_InstanceMapScript : public InstanceScript
    {
        instance_blood_furnace_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, gameobjectData);
        }

        void Initialize() override
        {
            memset(&_prisonerCounter, 0, sizeof(_prisonerCounter));
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->GetEntry() == NPC_NASCENT_FEL_ORC)
                StorePrisoner(creature);

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnUnitDeath(Unit* unit) override
        {
            if (unit && unit->IsCreature() && unit->GetEntry() == NPC_NASCENT_FEL_ORC)
                PrisonerDied(unit->GetGUID());
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            if (go->GetEntry() == 181821)               //Broggok prison cell front right
                _prisonGUIDs[0] = go->GetGUID();
            if (go->GetEntry() == 181818)               //Broggok prison cell back right
                _prisonGUIDs[1] = go->GetGUID();
            if (go->GetEntry() == 181820)               //Broggok prison cell front left
                _prisonGUIDs[2] = go->GetGUID();
            if (go->GetEntry() == 181817)               //Broggok prison cell back left
                _prisonGUIDs[3] = go->GetGUID();

            InstanceScript::OnGameObjectCreate(go);
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                case DATA_PRISON_CELL1:
                case DATA_PRISON_CELL2:
                case DATA_PRISON_CELL3:
                case DATA_PRISON_CELL4:
                    return _prisonGUIDs[data - DATA_PRISON_CELL1];
            }

            return ObjectGuid::Empty;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (type == DATA_BROGGOK)
            {
                if (state == IN_PROGRESS)
                    ActivateCell(DATA_PRISON_CELL1);
                else if (state == NOT_STARTED)
                {
                    ResetPrisons();
                    DoRespawnGameObject(DATA_BROGGOK_LEVER);
                }
            }

            return true;
        }

        void ResetPrisons()
        {
            for (uint8 i = 0; i < 4; ++i)
            {
                _prisonerCounter[i] = _prisonersCell[i].size();
                ResetPrisoners(_prisonersCell[i]);
                HandleGameObject(_prisonGUIDs[i], false);
            }
        }

        void ResetPrisoners(GuidSet prisoners)
        {
            for (ObjectGuid const& guid : prisoners)
                if (Creature* prisoner = instance->GetCreature(guid))
                    ResetPrisoner(prisoner);
        }

        void ResetPrisoner(Creature* prisoner)
        {
            if (!prisoner->IsAlive())
                prisoner->Respawn(true);
            prisoner->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            prisoner->SetImmuneToAll(true);
        }

        void StorePrisoner(Creature* creature)
        {
            float posX = creature->GetPositionX();
            float posY = creature->GetPositionY();

            if (posX >= 405.0f && posX <= 423.0f)
            {
                if (posY >= 106.0f && posY <= 123.0f)
                {
                    _prisonersCell[0].insert(creature->GetGUID());
                    ++_prisonerCounter[0];
                    ResetPrisoner(creature);
                }
                else if (posY >= 76.0f && posY <= 91.0f)
                {
                    _prisonersCell[1].insert(creature->GetGUID());
                    ++_prisonerCounter[1];
                    ResetPrisoner(creature);
                }
            }
            else if (posX >= 490.0f && posX <= 506.0f)
            {
                if (posY >= 106.0f && posY <= 123.0f)
                {
                    _prisonersCell[2].insert(creature->GetGUID());
                    ++_prisonerCounter[2];
                    ResetPrisoner(creature);
                }
                else if (posY >= 76.0f && posY <= 91.0f)
                {
                    _prisonersCell[3].insert(creature->GetGUID());
                    ++_prisonerCounter[3];
                    ResetPrisoner(creature);
                }
            }
        }

        void PrisonerDied(ObjectGuid guid)
        {
            if (_prisonersCell[0].find(guid) != _prisonersCell[0].end() && --_prisonerCounter[0] <= 0)
                ActivateCell(DATA_PRISON_CELL2);
            else if (_prisonersCell[1].find(guid) != _prisonersCell[1].end() && --_prisonerCounter[1] <= 0)
                ActivateCell(DATA_PRISON_CELL3);
            else if (_prisonersCell[2].find(guid) != _prisonersCell[2].end() && --_prisonerCounter[2] <= 0)
                ActivateCell(DATA_PRISON_CELL4);
            else if (_prisonersCell[3].find(guid) != _prisonersCell[3].end() && --_prisonerCounter[3] <= 0)
                ActivateCell(DATA_BROGGOK_REAR_DOOR);
        }

        void ActivateCell(uint8 id)
        {
            switch (id)
            {
                case DATA_PRISON_CELL1:
                case DATA_PRISON_CELL2:
                case DATA_PRISON_CELL3:
                case DATA_PRISON_CELL4:
                    HandleGameObject(_prisonGUIDs[id - DATA_PRISON_CELL1], true);
                    ActivatePrisoners(_prisonersCell[id - DATA_PRISON_CELL1]);
                    break;
                case DATA_BROGGOK_REAR_DOOR:
                    if (GameObject* go = GetGameObject(DATA_BROGGOK_REAR_DOOR))
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    if (Creature* broggok = GetCreature(DATA_BROGGOK))
                        broggok->AI()->DoAction(ACTION_ACTIVATE_BROGGOK);
                    break;
            }
        }

        void ActivatePrisoners(GuidSet prisoners)
        {
            for (ObjectGuid const& guid : prisoners)
                if (Creature* prisoner = instance->GetCreature(guid))
                {
                    prisoner->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    prisoner->SetImmuneToAll(false);
                    prisoner->SetInCombatWithZone();
                }
        }

        private:
            ObjectGuid _prisonGUIDs[4];
            GuidSet _prisonersCell[4];
            uint8 _prisonerCounter[4];
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_blood_furnace_InstanceMapScript(map);
    }
};

void AddSC_instance_blood_furnace()
{
    new instance_blood_furnace();
}
