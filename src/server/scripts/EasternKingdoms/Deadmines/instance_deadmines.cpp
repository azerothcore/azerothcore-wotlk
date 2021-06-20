/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "deadmines.h"

class instance_deadmines : public InstanceMapScript
{
    public:
        instance_deadmines() : InstanceMapScript("instance_deadmines", 36) { }

        struct instance_deadmines_InstanceMapScript : public InstanceScript
        {
            instance_deadmines_InstanceMapScript(Map* map) : InstanceScript(map)
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
                    case GO_FACTORY_DOOR:
                        if (_encounters[TYPE_RHAHK_ZOR] == DONE)
                            gameobject->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case GO_IRON_CLAD_DOOR:
                        if (_encounters[TYPE_CANNON] == DONE)
                            HandleGameObject(0, true, gameobject);
                        break;
                }
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case TYPE_RHAHK_ZOR:
                    case TYPE_CANNON:
                        _encounters[type] = data;
                        break;
                }

                if (data == DONE)
                    SaveToDB();
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "D E " << _encounters[0] << ' ' << _encounters[1];
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'D' && dataHead2 == 'E')
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
            return new instance_deadmines_InstanceMapScript(map);
        }
};

void AddSC_instance_deadmines()
{
    new instance_deadmines();
}
