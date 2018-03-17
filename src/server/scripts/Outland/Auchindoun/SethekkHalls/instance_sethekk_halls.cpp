/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "sethekk_halls.h"

class instance_sethekk_halls : public InstanceMapScript
{
public:
    instance_sethekk_halls() : InstanceMapScript("instance_sethekk_halls", 556) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_sethekk_halls_InstanceMapScript(map);
    }

    struct instance_sethekk_halls_InstanceMapScript : public InstanceScript
    {
        instance_sethekk_halls_InstanceMapScript(Map* map) : InstanceScript(map) {}

        uint32 AnzuEncounter;
        uint64 m_uiIkissDoorGUID;
        uint64 _talonKingsCofferGUID;

        void Initialize()
        {
            AnzuEncounter = NOT_STARTED;
            m_uiIkissDoorGUID = 0;
            _talonKingsCofferGUID = 0;
        }

        void OnCreatureCreate(Creature* creature)
        {
            if (creature->GetEntry() == NPC_ANZU || creature->GetEntry() == NPC_VOICE_OF_THE_RAVEN_GOD)
                if (AnzuEncounter >= IN_PROGRESS)
                    creature->DespawnOrUnsummon(1);
        }

        void OnGameObjectCreate(GameObject* go)
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

        void SetData(uint32 type, uint32 data)
        {
            switch (type)
            {
                case DATA_IKISSDOOREVENT:
                    if (data == DONE)
                    {
                        DoUseDoorOrButton(m_uiIkissDoorGUID, DAY*IN_MILLISECONDS);
                        if (GameObject* coffer = instance->GetGameObject(_talonKingsCofferGUID))
                            coffer->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE|GO_FLAG_INTERACT_COND);
                    }
                    break;
                case TYPE_ANZU_ENCOUNTER:
                    AnzuEncounter = data;
                    SaveToDB();
                    break;
            }
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "S H " << AnzuEncounter;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn)
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
