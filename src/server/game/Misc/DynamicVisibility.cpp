/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "DynamicVisibility.h"

uint8 DynamicVisibilityMgr::visibilitySettingsIndex = 0;

void DynamicVisibilityMgr::Update(uint32 sessionCount)
{
    if (sessionCount >= (visibilitySettingsIndex + 1) * ((uint32)VISIBILITY_SETTINGS_PLAYER_INTERVAL) && visibilitySettingsIndex < VISIBILITY_SETTINGS_MAX_INTERVAL_NUM - 1)
        ++visibilitySettingsIndex;
    else if (visibilitySettingsIndex && sessionCount < visibilitySettingsIndex * ((uint32)VISIBILITY_SETTINGS_PLAYER_INTERVAL) - 100)
        --visibilitySettingsIndex;
}
