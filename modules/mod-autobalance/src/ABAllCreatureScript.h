/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_ALL_CREATURE_SCRIPT_H
#define __AB_ALL_CREATURE_SCRIPT_H

#include "ScriptMgr.h"

class AutoBalance_AllCreatureScript : public AllCreatureScript
{
public:
    AutoBalance_AllCreatureScript()
        : AllCreatureScript("AutoBalance_AllCreatureScript")
    {
    }

    void OnBeforeCreatureSelectLevel(const CreatureTemplate* /*creatureTemplate*/, Creature* creature, uint8& level) override;
    void OnCreatureSelectLevel(const CreatureTemplate* /* cinfo */, Creature* creature) override;
    void OnCreatureAddWorld(Creature* creature) override;
    void OnCreatureRemoveWorld(Creature* creature) override;
    void OnAllCreatureUpdate(Creature* creature, uint32 /*diff*/) override;

    // Reset the passed creature to stock if the config has changed
    bool ResetCreatureIfNeeded(Creature* creature);
    void ModifyCreatureAttributes(Creature* creature);

private:
    bool _isSummonCloneOfSummoner(Creature* summon);
};

#endif /* __AB_ALL_CREATURE_SCRIPT_H */
