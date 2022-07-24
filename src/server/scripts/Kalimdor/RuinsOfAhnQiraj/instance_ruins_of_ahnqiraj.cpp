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
#include "ScriptMgr.h"
#include "ruins_of_ahnqiraj.h"

ObjectData const creatureData[] =
{
    { NPC_OSSIRIAN,  DATA_OSSIRIAN },
    { NPC_KURINNAXX, DATA_KURINNAXX }
};

class instance_ruins_of_ahnqiraj : public InstanceMapScript
{
public:
    instance_ruins_of_ahnqiraj() : InstanceMapScript("instance_ruins_of_ahnqiraj", 509) { }

    struct instance_ruins_of_ahnqiraj_InstanceMapScript : public InstanceScript
    {
        instance_ruins_of_ahnqiraj_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(NUM_ENCOUNTER);
            LoadObjectData(creatureData, nullptr);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_KURINNAXX:
                    _kurinnaxxGUID = creature->GetGUID();
                    break;
                case NPC_RAJAXX:
                    _rajaxxGUID = creature->GetGUID();
                    break;
                case NPC_MOAM:
                    _moamGUID = creature->GetGUID();
                    break;
                case NPC_BURU:
                    _buruGUID = creature->GetGUID();
                    break;
                case NPC_AYAMISS:
                    _ayamissGUID = creature->GetGUID();
                    break;
                case NPC_OSSIRIAN:
                    _ossirianGUID = creature->GetGUID();
                    break;
            }
        }

        bool SetBossState(uint32 bossId, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(bossId, state))
                return false;

            return true;
        }

        void SetGuidData(uint32 type, ObjectGuid data) override
        {
            if (type == DATA_PARALYZED)
                _paralyzedGUID = data;
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_KURINNAXX:
                    return _kurinnaxxGUID;
                case DATA_RAJAXX:
                    return _rajaxxGUID;
                case DATA_MOAM:
                    return _moamGUID;
                case DATA_BURU:
                    return _buruGUID;
                case DATA_AYAMISS:
                    return _ayamissGUID;
                case DATA_OSSIRIAN:
                    return _ossirianGUID;
                case DATA_PARALYZED:
                    return _paralyzedGUID;
            }

            return ObjectGuid::Empty;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "R A" << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(char const* data) override
        {
            if (!data)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(data);

            char dataHead1, dataHead2;

            std::istringstream loadStream(data);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'R' && dataHead2 == 'A')
            {
                for (uint8 i = 0; i < NUM_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > TO_BE_DECIDED)
                        tmpState = NOT_STARTED;
                    SetBossState(i, EncounterState(tmpState));
                }
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    private:
        ObjectGuid _kurinnaxxGUID;
        ObjectGuid _rajaxxGUID;
        ObjectGuid _moamGUID;
        ObjectGuid _buruGUID;
        ObjectGuid _ayamissGUID;
        ObjectGuid _ossirianGUID;
        ObjectGuid _paralyzedGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_ruins_of_ahnqiraj_InstanceMapScript(map);
    }
};

void AddSC_instance_ruins_of_ahnqiraj()
{
    new instance_ruins_of_ahnqiraj();
}
