/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TRINITY_SKILL_EXTRA_ITEMS_H
#define TRINITY_SKILL_EXTRA_ITEMS_H

#include "Common.h"

// predef classes used in functions
class Player;
// returns true and sets the appropriate info if the player can create extra items with the given spellId
bool canCreateExtraItems(Player* player, uint32 spellId, float &additionalChance, int32 &newMaxOrEntry);
// function to load the extra item creation info from DB
void LoadSkillExtraItemTable();
#endif
