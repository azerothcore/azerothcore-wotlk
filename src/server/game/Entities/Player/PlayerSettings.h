/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _PLAYER_SETTINGS_H
#define _PLAYER_SETTINGS_H

class Player;

const std::string AzerothcorePSSource = "ac_default";

enum CharacterSettingIndexes : uint8
{
    SETTING_ANNOUNCER_FLAGS,
    MAX_CHAR_SETTINGS
};

enum AnnouncerFlags : uint8
{
    ANNOUNCER_FLAG_DISABLE_BG_QUEUE      = 1,
    ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE   = 2,
    ANNOUNCER_FLAG_DISABLE_AUTOBROADCAST = 4
};

struct PlayerSetting
{
    uint32 value;

    [[nodiscard]] bool HasFlag(uint32 flag) { return (value & flag) != 0; }
    [[nodiscard]] bool IsEnabled(uint32 equals = 1) { return value == equals; }
    void AddFlag(uint32 flag) { value = value | flag; }
    void RemoveFlag(uint32 flag) { value = value &~ flag; }
};

typedef std::vector<PlayerSetting> PlayerSettingVector;
typedef std::map<std::string, PlayerSettingVector> PlayerSettingMap;

#endif
