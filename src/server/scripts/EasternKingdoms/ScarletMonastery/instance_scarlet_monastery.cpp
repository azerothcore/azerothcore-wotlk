/*
REWRITTEN BY XINEF
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

class instance_scarlet_monastery : public InstanceMapScript
{
    public:
        instance_scarlet_monastery() : InstanceMapScript("instance_scarlet_monastery", 189) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_scarlet_monastery_InstanceMapScript(map);
        }

        struct instance_scarlet_monastery_InstanceMapScript : public InstanceScript
        {
            instance_scarlet_monastery_InstanceMapScript(Map* map) : InstanceScript(map) {}
        };
};

void AddSC_instance_scarlet_monastery()
{
    new instance_scarlet_monastery();
}
