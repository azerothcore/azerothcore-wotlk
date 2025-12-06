/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#include "ABModuleScript.h"
#include "ABScriptMgr.h"

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

ABScriptMgr* ABScriptMgr::instance()
{
    static ABScriptMgr instance;
    return &instance;
}

bool ABScriptMgr::OnBeforeModifyAttributes(Creature* creature, uint32& instancePlayerCount)
{
    auto ret = IsValidBoolScript<ABModuleScript>([&](ABModuleScript* script)
        {
            return !script->OnBeforeModifyAttributes(creature, instancePlayerCount);
        });

    if (ret && *ret)
        return false;

    return true;
}

bool ABScriptMgr::OnAfterDefaultMultiplier(Creature* creature, float& defaultMultiplier)
{
    auto ret = IsValidBoolScript<ABModuleScript>([&](ABModuleScript* script)
        {
            return !script->OnAfterDefaultMultiplier(creature, defaultMultiplier);
        });

    if (ret && *ret)
        return false;

    return true;
}

bool ABScriptMgr::OnBeforeUpdateStats(Creature* creature, uint32& scaledHealth, uint32& scaledMana, float& damageMultiplier, uint32& newBaseArmor)
{
    auto ret = IsValidBoolScript<ABModuleScript>([&](ABModuleScript* script)
        {
            return !script->OnBeforeUpdateStats(creature, scaledHealth, scaledMana, damageMultiplier, newBaseArmor);
        });

    if (ret && *ret)
        return false;

    return true;
}
