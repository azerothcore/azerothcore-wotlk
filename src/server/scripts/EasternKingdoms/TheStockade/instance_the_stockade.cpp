/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"

class instance_the_stockade : public InstanceMapScript
{
    public:
        instance_the_stockade() : InstanceMapScript("instance_the_stockade", 34) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_the_stockade_InstanceMapScript(map);
        }

        struct instance_the_stockade_InstanceMapScript : public InstanceScript
        {
            instance_the_stockade_InstanceMapScript(Map* map) : InstanceScript(map) { }
        };
};

void AddSC_instance_the_stockade()
{
    new instance_the_stockade();
}
