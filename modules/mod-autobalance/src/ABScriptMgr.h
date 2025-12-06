/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_SCRIPT_MGR_H
#define __AB_SCRIPT_MGR_H

#include "Creature.h"
#include "ScriptMgr.h"

// Manages registration, loading, and execution of scripts.
class ABScriptMgr
{
    public: /* Initialization */

    static ABScriptMgr* instance();

    // Called at the start of ModifyCreatureAttributes method.
    // It can be used to add some condition to skip autobalancing system for example.
    bool OnBeforeModifyAttributes(Creature* creature, uint32 & instancePlayerCount);

    // Called right after default multiplier has been set, you can use it to change.
    // Current scaling formula based on number of players or just skip modifications
    bool OnAfterDefaultMultiplier(Creature* creature, float &defaultMultiplier);

    // Called before change creature values, to tune some values or skip modifications.
    bool OnBeforeUpdateStats     (Creature* creature, uint32 &scaledHealth, uint32 &scaledMana, float &damageMultiplier, uint32 &newBaseArmor);
};

#define sABScriptMgr ABScriptMgr::instance()

#endif
