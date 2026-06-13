/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
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
