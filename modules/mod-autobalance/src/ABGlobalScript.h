/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_GLOBAL_SCRIPT_H
#define __AB_GLOBAL_SCRIPT_H

#include "ScriptMgr.h"

class AutoBalance_GlobalScript : public GlobalScript {
public:
    AutoBalance_GlobalScript() : GlobalScript("AutoBalance_GlobalScript", {
        GLOBALHOOK_ON_AFTER_UPDATE_ENCOUNTER_STATE
    }) { }

    void OnAfterUpdateEncounterState(Map* map, EncounterCreditType type, uint32 creditEntry, Unit* source, Difficulty difficulty_fixed, DungeonEncounterList const* encounters, uint32 dungeonCompleted, bool updated) override;
};

#endif /* __AB_GLOBAL_SCRIPT_H */
