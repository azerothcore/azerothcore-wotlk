/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "magisters_terrace.h"

class instance_magisters_terrace : public InstanceMapScript
{
public:
    instance_magisters_terrace() : InstanceMapScript("instance_magisters_terrace", 585) { }

    struct instance_magisters_terrace_InstanceMapScript : public InstanceScript
    {
        instance_magisters_terrace_InstanceMapScript(Map* map) : InstanceScript(map) { }

        uint32 Encounter[MAX_ENCOUNTER];

        uint64 VexallusDoorGUID;
        uint64 SelinDoorGUID;
        uint64 SelinEncounterDoorGUID;
        uint64 DelrissaDoorGUID;
        uint64 KaelDoorGUID;
        uint64 EscapeOrbGUID;

        uint64 DelrissaGUID;
        uint64 KaelGUID;

        void Initialize()
        {
            memset(&Encounter, 0, sizeof(Encounter));
            
            VexallusDoorGUID = 0;
            SelinDoorGUID = 0;
            SelinEncounterDoorGUID = 0;
            DelrissaDoorGUID = 0;
            KaelDoorGUID = 0;
            EscapeOrbGUID = 0;

            DelrissaGUID = 0;
            KaelGUID = 0;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (Encounter[i] == IN_PROGRESS)
                    return true;
            return false;
        }

        uint32 GetData(uint32 identifier) const
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

        void SetData(uint32 identifier, uint32 data)
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
                            escapeOrb->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    Encounter[identifier] = data;
                    break;
            }

            SaveToDB();
        }

        void OnCreatureCreate(Creature* creature)
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

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
                case GO_SELIN_DOOR:
                    if (GetData(DATA_SELIN_EVENT) == DONE)
                        HandleGameObject(0, true, go);
                    SelinDoorGUID = go->GetGUID();
                    break;
                case GO_SELIN_ENCOUNTER_DOOR:
                    SelinEncounterDoorGUID = go->GetGUID();
                    break;

                case GO_VEXALLUS_DOOR:
                    if (GetData(DATA_VEXALLUS_EVENT) == DONE)
                        HandleGameObject(0, true, go);
                    VexallusDoorGUID = go->GetGUID();
                    break;
                
                case GO_DELRISSA_DOOR:
                    if (GetData(DATA_DELRISSA_EVENT) == DONE)
                        HandleGameObject(0, true, go);
                    DelrissaDoorGUID = go->GetGUID();
                    break;
                case GO_KAEL_DOOR:
                    KaelDoorGUID = go->GetGUID();
                    break;
                case GO_ESCAPE_ORB:
                    if (GetData(DATA_KAELTHAS_EVENT) == DONE)
                        go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    EscapeOrbGUID = go->GetGUID();
                    break;
            }
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << Encounter[0] << ' ' << Encounter[1] << ' ' << Encounter[2] << ' ' << Encounter[3];

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* str)
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

        uint64 GetData64(uint32 identifier) const
        {
            switch (identifier)
            {
                case NPC_DELRISSA:
                    return DelrissaGUID;
            }
            return 0;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_magisters_terrace_InstanceMapScript(map);
    }
};

void AddSC_instance_magisters_terrace()
{
    new instance_magisters_terrace();
}
