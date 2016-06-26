/*
REWRITTEN BY XINEF
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"

class instance_razorfen_kraul : public InstanceMapScript
{
    public:
        instance_razorfen_kraul() : InstanceMapScript("instance_razorfen_kraul", 47) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_razorfen_kraul_InstanceMapScript(map);
        }

        struct instance_razorfen_kraul_InstanceMapScript : public InstanceScript
        {
            instance_razorfen_kraul_InstanceMapScript(Map* map) : InstanceScript(map) { }
        };
};

void AddSC_instance_razorfen_kraul()
{
    new instance_razorfen_kraul();
}
