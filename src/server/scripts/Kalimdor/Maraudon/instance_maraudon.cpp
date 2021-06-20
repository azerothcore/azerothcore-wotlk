/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "maraudon.h"

class instance_maraudon : public InstanceMapScript
{
    public:
        instance_maraudon() : InstanceMapScript("instance_maraudon", 349) { }

        struct instance_maraudon_InstanceMapScript : public InstanceScript
        {
            instance_maraudon_InstanceMapScript(Map* map) : InstanceScript(map)
            {
            }

            void Initialize()
            {
                memset(&_encounters, 0, sizeof(_encounters));
            }

            void OnGameObjectCreate(GameObject* gameobject)
            {
                switch (gameobject->GetEntry())
                {
                    case GO_CORRUPTION_SPEWER:
                        if (_encounters[TYPE_NOXXION] == DONE)
                            HandleGameObject(0, true, gameobject);
                        break;
                }
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case TYPE_NOXXION:
                        _encounters[type] = data;
                        break;
                }

                if (data == DONE)
                    SaveToDB();
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "M A " << _encounters[0];
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'M' && dataHead2 == 'A')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        loadStream >> _encounters[i];
                        if (_encounters[i] == IN_PROGRESS)
                            _encounters[i] = NOT_STARTED;
                    }
                }
            }

        private:
            uint32 _encounters[MAX_ENCOUNTERS];
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_maraudon_InstanceMapScript(map);
        }
};

void AddSC_instance_maraudon()
{
    new instance_maraudon();
}
