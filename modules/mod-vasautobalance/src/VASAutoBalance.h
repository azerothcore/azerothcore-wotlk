#ifndef VAS_AUTOBALANCE_H
#define VAS_AUTOBALANCE_H

#include "ScriptMgr.h"
#include "Creature.h"

// Manages registration, loading, and execution of scripts.
class VasScriptMgr
{
    friend class ACE_Singleton<VasScriptMgr, ACE_Null_Mutex>;
    public: /* Initialization */

        // called at the start of ModifyCreatureAttributes method
        // it can be used to add some condition to skip autobalancing system for example
        bool OnBeforeModifyAttributes(Creature* creature, uint32 & instancePlayerCount);
        // called right after default multiplier has been set, you can use it to change
        // current scaling formula based on number of players or just skip modifications
        bool OnAfterDefaultMultiplier(Creature* creature, float &defaultMultiplier);
        // called before change creature values, to tune some values or skip modifications
        bool OnBeforeUpdateStats(Creature* creature, uint32 &scaledHealth, uint32 &scaledMana, float &damageMultiplier, uint32 &newBaseArmor);
};

#define sVasScriptMgr ACE_Singleton<VasScriptMgr, ACE_Null_Mutex>::instance()

/*
* Dedicated hooks for VasAutobalance Module
* Can be used to extend/customize this system
*/
class VasModuleScript : public ModuleScript
{
    protected:

        VasModuleScript(const char* name);

    public: 
        virtual bool OnBeforeModifyAttributes(Creature* /*creature*/, uint32 & /*instancePlayerCount*/) { return true; }
        virtual bool OnAfterDefaultMultiplier(Creature* /*creature*/, float & /*defaultMultiplier*/) { return true; }
        virtual bool OnBeforeUpdateStats(Creature* /*creature*/, uint32 &/*scaledHealth*/, uint32 &/*scaledMana*/, float &/*damageMultiplier*/, uint32 &/*newBaseArmor*/) { return true; }
};

template class ScriptRegistry<VasModuleScript>;

#endif