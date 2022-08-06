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
#include "ScriptObject.h"
#include "shadow_labyrinth.h"

class instance_shadow_labyrinth : public InstanceMapScript
{
public:
    instance_shadow_labyrinth() : InstanceMapScript("instance_shadow_labyrinth", 555) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_shadow_labyrinth_InstanceMapScript(map);
    }

    struct instance_shadow_labyrinth_InstanceMapScript : public InstanceScript
    {
        instance_shadow_labyrinth_InstanceMapScript(Map* map) : InstanceScript(map) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];

        ObjectGuid m_uiHellmawGUID;
        ObjectGuid m_uiRefectoryDoorGUID;
        ObjectGuid m_uiScreamingHallDoorGUID;

        uint32 m_uiFelOverseerCount;

        void Initialize() override
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            m_uiFelOverseerCount = 0;
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)
                    return true;

            return false;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case REFECTORY_DOOR:
                    m_uiRefectoryDoorGUID = go->GetGUID();
                    if (m_auiEncounter[DATA_BLACKHEARTTHEINCITEREVENT] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case SCREAMING_HALL_DOOR:
                    m_uiScreamingHallDoorGUID = go->GetGUID();
                    if (m_auiEncounter[DATA_GRANDMASTERVORPILEVENT] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_FEL_OVERSEER:
                    if (creature->IsAlive())
                        ++m_uiFelOverseerCount;
                    break;
                case NPC_HELLMAW:
                    m_uiHellmawGUID = creature->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 uiData) override
        {
            switch (type)
            {
                case TYPE_OVERSEER:
                    if (!--m_uiFelOverseerCount)
                    {
                        m_auiEncounter[type] = DONE;
                        if (Creature* cr = instance->GetCreature(m_uiHellmawGUID))
                            cr->AI()->DoAction(1);
                    }
                    break;

                case DATA_BLACKHEARTTHEINCITEREVENT:
                    if (uiData == DONE)
                        DoUseDoorOrButton(m_uiRefectoryDoorGUID);
                    m_auiEncounter[type] = uiData;
                    break;

                case DATA_GRANDMASTERVORPILEVENT:
                    if (uiData == DONE)
                        DoUseDoorOrButton(m_uiScreamingHallDoorGUID);
                    m_auiEncounter[type] = uiData;
                    break;

                case DATA_MURMUREVENT:
                case TYPE_HELLMAW:
                    m_auiEncounter[type] = uiData;
                    break;
            }

            if (uiData == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == TYPE_OVERSEER)
                return m_auiEncounter[0];
            return 0;
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "S L " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' '
                       << m_auiEncounter[2] << ' ' << m_auiEncounter[3] << ' ' << m_auiEncounter[4];

            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;
            if (dataHead1 == 'S' && dataHead2 == 'L')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    loadStream >> m_auiEncounter[i];
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;
                }
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};

void AddSC_instance_shadow_labyrinth()
{
    new instance_shadow_labyrinth();
}
