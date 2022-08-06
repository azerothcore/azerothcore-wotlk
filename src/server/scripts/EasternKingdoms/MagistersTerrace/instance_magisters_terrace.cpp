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
#include "magisters_terrace.h"

class instance_magisters_terrace : public InstanceMapScript
{
public:
    instance_magisters_terrace() : InstanceMapScript("instance_magisters_terrace", 585) { }

    struct instance_magisters_terrace_InstanceMapScript : public InstanceScript
    {
        instance_magisters_terrace_InstanceMapScript(Map* map) : InstanceScript(map) { }

        uint32 Encounter[MAX_ENCOUNTER];

        ObjectGuid VexallusDoorGUID;
        ObjectGuid SelinDoorGUID;
        ObjectGuid SelinEncounterDoorGUID;
        ObjectGuid DelrissaDoorGUID;
        ObjectGuid KaelDoorGUID;
        ObjectGuid EscapeOrbGUID;

        ObjectGuid DelrissaGUID;
        ObjectGuid KaelGUID;

        void Initialize() override
        {
            memset(&Encounter, 0, sizeof(Encounter));
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (Encounter[i] == IN_PROGRESS)
                    return true;
            return false;
        }

        uint32 GetData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case DATA_SELIN_EVENT:
                case DATA_VEXALLUS_EVENT:
                case DATA_DELRISSA_EVENT:
                case DATA_KAELTHAS_EVENT:
                    return Encounter[identifier];
            }
            return 0;
        }

        void SetData(uint32 identifier, uint32 data) override
        {
            switch (identifier)
            {
                case DATA_SELIN_EVENT:
                    HandleGameObject(SelinDoorGUID, data == DONE);
                    HandleGameObject(SelinEncounterDoorGUID, data != IN_PROGRESS);
                    Encounter[identifier] = data;
                    break;
                case DATA_VEXALLUS_EVENT:
                    if (data == DONE)
                        HandleGameObject(VexallusDoorGUID, true);
                    Encounter[identifier] = data;
                    break;
                case DATA_DELRISSA_EVENT:
                    if (data == DONE)
                        HandleGameObject(DelrissaDoorGUID, true);
                    Encounter[identifier] = data;
                    break;
                case DATA_KAELTHAS_EVENT:
                    HandleGameObject(KaelDoorGUID, data != IN_PROGRESS);
                    if (data == DONE)
                        if (GameObject* escapeOrb = instance->GetGameObject(EscapeOrbGUID))
                            escapeOrb->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    Encounter[identifier] = data;
                    break;
            }

            SaveToDB();
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_DELRISSA:
                    DelrissaGUID = creature->GetGUID();
                    break;
                case NPC_KAEL_THAS:
                    KaelGUID = creature->GetGUID();
                    break;
                case NPC_PHOENIX:
                case NPC_PHOENIX_EGG:
                    if (Creature* kael = instance->GetCreature(KaelGUID))
                        kael->AI()->JustSummoned(creature);
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_SELIN_DOOR:
                    if (GetData(DATA_SELIN_EVENT) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    SelinDoorGUID = go->GetGUID();
                    break;
                case GO_SELIN_ENCOUNTER_DOOR:
                    SelinEncounterDoorGUID = go->GetGUID();
                    break;

                case GO_VEXALLUS_DOOR:
                    if (GetData(DATA_VEXALLUS_EVENT) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    VexallusDoorGUID = go->GetGUID();
                    break;

                case GO_DELRISSA_DOOR:
                    if (GetData(DATA_DELRISSA_EVENT) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    DelrissaDoorGUID = go->GetGUID();
                    break;
                case GO_KAEL_DOOR:
                    KaelDoorGUID = go->GetGUID();
                    break;
                case GO_ESCAPE_ORB:
                    if (GetData(DATA_KAELTHAS_EVENT) == DONE)
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    EscapeOrbGUID = go->GetGUID();
                    break;
            }
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << Encounter[0] << ' ' << Encounter[1] << ' ' << Encounter[2] << ' ' << Encounter[3];

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* str) override
        {
            if (!str)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(str);

            std::istringstream loadStream(str);

            for (uint32 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                uint32 tmpState;
                loadStream >> tmpState;
                if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                    tmpState = NOT_STARTED;
                SetData(i, tmpState);
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case NPC_DELRISSA:
                    return DelrissaGUID;
            }

            return ObjectGuid::Empty;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_magisters_terrace_InstanceMapScript(map);
    }
};

void AddSC_instance_magisters_terrace()
{
    new instance_magisters_terrace();
}
