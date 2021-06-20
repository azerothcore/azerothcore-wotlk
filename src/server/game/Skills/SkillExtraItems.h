/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_SKILL_EXTRA_ITEMS_H
#define ACORE_SKILL_EXTRA_ITEMS_H

#include "Common.h"

// predef classes used in functions
class Player;
// returns true and sets the appropriate info if the player can create a perfect item with the given spellId
bool CanCreatePerfectItem(Player* player, uint32 spellId, float& perfectCreateChance, uint32& perfectItemType);
// load perfection proc info from DB
void LoadSkillPerfectItemTable();
// returns true and sets the appropriate info if the player can create extra items with the given spellId
bool canCreateExtraItems(Player* player, uint32 spellId, float& additionalChance, int32& newMaxOrEntry);
// function to load the extra item creation info from DB
void LoadSkillExtraItemTable();
#endif
