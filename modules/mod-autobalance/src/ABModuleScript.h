/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_MODULE_SCRIPT_H
#define __AB_MODULE_SCRIPT_H

#include "Creature.h"
#include "ScriptMgr.h"

/*
* Dedicated hooks for Autobalance Module
* Can be used to extend/customize this system
*/
class ABModuleScript : public ModuleScript
{
protected:

    ABModuleScript(const char* name);

public:
    virtual bool OnBeforeModifyAttributes(Creature* /*creature*/, uint32& /*instancePlayerCount*/) { return true; }
    virtual bool OnAfterDefaultMultiplier(Creature* /*creature*/, float&  /*defaultMultiplier*/)   { return true; }
    virtual bool OnBeforeUpdateStats     (Creature* /*creature*/, uint32& /*scaledHealth*/, uint32& /*scaledMana*/, float& /*damageMultiplier*/, uint32& /*newBaseArmor*/) { return true; }
};

template class ScriptRegistry<ABModuleScript>;


#endif
