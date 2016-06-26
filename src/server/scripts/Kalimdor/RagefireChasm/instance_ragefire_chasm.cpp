/*
REWRITTEN BY XINEF
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"

class instance_ragefire_chasm : public InstanceMapScript
{
    public:
        instance_ragefire_chasm() : InstanceMapScript("instance_ragefire_chasm", 389) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_ragefire_chasm_InstanceMapScript(map);
        }

        struct instance_ragefire_chasm_InstanceMapScript : public InstanceScript
        {
            instance_ragefire_chasm_InstanceMapScript(Map* map) : InstanceScript(map) { }
        };
};

void AddSC_instance_ragefire_chasm()
{
    new instance_ragefire_chasm();
}
