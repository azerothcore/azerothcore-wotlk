/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#include "ABModuleScript.h"

ABModuleScript::ABModuleScript(const char* name)
    : ModuleScript(name)
{
    ScriptRegistry<ABModuleScript>::AddScript(this);
}
