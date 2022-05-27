/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "sethekk_halls.h"

class instance_sethekk_halls : public InstanceMapScript
{
public:
    instance_sethekk_halls() : InstanceMapScript("instance_sethekk_halls", 556) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_sethekk_halls_InstanceMapScript(map);
    }

    struct instance_sethekk_halls_InstanceMapScript : public InstanceScript
    {
        instance_sethekk_halls_InstanceMapScript(Map* map) : InstanceScript(map) {}

        uint32 AnzuEncounter;
        ObjectGuid m_uiIkissDoorGUID;
        ObjectGuid _talonKingsCofferGUID;

        void Initialize() override
        {
            AnzuEncounter = NOT_STARTED;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->GetEntry() == NPC_ANZU || creature->GetEntry() == NPC_VOICE_OF_THE_RAVEN_GOD)
                if (AnzuEncounter >= IN_PROGRESS)
                    creature->DespawnOrUnsummon(1);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_IKISS_DOOR:
                    m_uiIkissDoorGUID = go->GetGUID();
                    break;
                case GO_THE_TALON_KINGS_COFFER:
                    _talonKingsCofferGUID = go->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_IKISSDOOREVENT:
                    if (data == DONE)
                    {
                        DoUseDoorOrButton(m_uiIkissDoorGUID, DAY * IN_MILLISECONDS);
                        if (GameObject* coffer = instance->GetGameObject(_talonKingsCofferGUID))
                            coffer->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE | GO_FLAG_INTERACT_COND);
                    }
                    break;
                case TYPE_ANZU_ENCOUNTER:
                    AnzuEncounter = data;
                    SaveToDB();
                    break;
            }
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "S H " << AnzuEncounter;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn) override
        {
            if (!strIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(strIn);

            char dataHead1, dataHead2;

            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'S' && dataHead2 == 'H')
            {
                loadStream >> AnzuEncounter;
                if (AnzuEncounter == IN_PROGRESS)
                    AnzuEncounter = NOT_STARTED;
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};

void AddSC_instance_sethekk_halls()
{
    new instance_sethekk_halls();
}
