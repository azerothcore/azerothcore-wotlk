/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "InstanceScript.h"
#include "razorfen_downs.h"

class instance_razorfen_downs : public InstanceMapScript
{
    public:
        instance_razorfen_downs() : InstanceMapScript("instance_razorfen_downs", 129) { }

        struct instance_razorfen_downs_InstanceMapScript : public InstanceScript
        {
            instance_razorfen_downs_InstanceMapScript(Map* map) : InstanceScript(map)
            {
            }

            void Initialize()
            {
                _gongPhase = 0;
                _firesState = 0;
            }

            void OnGameObjectCreate(GameObject* gameobject)
            {
                switch (gameobject->GetEntry())
                {
                    case GO_IDOL_OVEN_FIRE:
                    case GO_IDOL_CUP_FIRE:
                    case GO_IDOL_MOUTH_FIRE:
                        if (_firesState == DONE)
                            gameobject->Delete();
                        break;
                    case GO_GONG:
                        if (_gongPhase == DONE)
                            gameobject->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                }
            }

            uint32 GetData(uint32 type) const
            {
                if (type == GO_GONG)
                    return _gongPhase;
                return 0;
            }

            void SetData(uint32 type, uint32 data)
            {
                if (type == GO_GONG)
                    _gongPhase = data;
                else if (type == GO_BELNISTRASZS_BRAZIER)
                    _firesState = DONE;
                SaveToDB();
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "R D " << _gongPhase << ' ' << _firesState;
                return saveStream.str();
            }

            void Load(const char* str)
            {
                if (!str)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(str);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'R' && dataHead2 == 'D')
                {
                    loadStream >> _gongPhase;
                    loadStream >> _firesState;
                }
            }

        private:
            uint32 _gongPhase;
            uint32 _firesState;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_razorfen_downs_InstanceMapScript(map);
        }
};

void AddSC_instance_razorfen_downs()
{
    new instance_razorfen_downs();
}
