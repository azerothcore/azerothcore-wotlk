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

#ifndef ACORE_FORMULAS_H
#define ACORE_FORMULAS_H

#include "SharedDefines.h"
#include <cmath>

class Player;
class Unit;

enum ContentLevels : uint8;

namespace Acore::Honor
{
    inline float hk_honor_at_level_f(uint8 level, float multiplier = 1.0f)
    {
        float honor = multiplier * level * 1.55f;
        //sScriptMgr->OnHonorCalculation(honor, level, multiplier); // pussywizard: optimization
        return honor;
    }

    inline uint32 hk_honor_at_level(uint8 level, float multiplier = 1.0f)
    {
        return uint32(std::ceil(hk_honor_at_level_f(level, multiplier)));
    }
}

namespace Acore::XP
{
    inline uint8 GetGrayLevel(uint8 pl_level)
    {
        uint8 level;

        if (pl_level <= 5)
            level = 0;
        else if (pl_level <= 39)
            level = pl_level - 5 - pl_level / 10;
        else if (pl_level <= 59)
            level = pl_level - 1 - pl_level / 5;
        else
            level = pl_level - 9;

        //sScriptMgr->OnGrayLevelCalculation(level, pl_level); // pussywizard: optimization
        return level;
    }

    inline XPColorChar GetColorCode(uint8 pl_level, uint8 mob_level)
    {
        XPColorChar color;

        if (mob_level >= pl_level + 5)
            color = XP_RED;
        else if (mob_level >= pl_level + 3)
            color = XP_ORANGE;
        else if (mob_level >= pl_level - 2)
            color = XP_YELLOW;
        else if (mob_level > GetGrayLevel(pl_level))
            color = XP_GREEN;
        else
            color = XP_GRAY;

        //sScriptMgr->OnColorCodeCalculation(color, pl_level, mob_level); // pussywizard: optimization
        return color;
    }

    inline uint8 GetZeroDifference(uint8 pl_level)
    {
        uint8 diff;

        if (pl_level < 8)
            diff = 5;
        else if (pl_level < 10)
            diff = 6;
        else if (pl_level < 12)
            diff = 7;
        else if (pl_level < 16)
            diff = 8;
        else if (pl_level < 20)
            diff = 9;
        else if (pl_level < 30)
            diff = 11;
        else if (pl_level < 40)
            diff = 12;
        else if (pl_level < 45)
            diff = 13;
        else if (pl_level < 50)
            diff = 14;
        else if (pl_level < 55)
            diff = 15;
        else if (pl_level < 60)
            diff = 16;
        else
            diff = 17;

        //sScriptMgr->OnZeroDifferenceCalculation(diff, pl_level); // pussywizard: optimization
        return diff;
    }

    uint32 BaseGain(uint8 pl_level, uint8 mob_level, ContentLevels content);

    uint32 Gain(Player* player, Unit* unit, bool isBattleGround = false);

    inline float xp_in_group_rate(uint32 count, bool isRaid)
    {
        float rate;

        if (isRaid)
        {
            // FIXME: Must apply decrease modifiers depending on raid size.
            rate = 1.0f;
        }
        else
        {
            switch (count)
            {
            case 0:
            case 1:
            case 2:
                rate = 1.0f;
                break;
            case 3:
                rate = 1.166f;
                break;
            case 4:
                rate = 1.3f;
                break;
            case 5:
            default:
                rate = 1.4f;
            }
        }

        //sScriptMgr->OnGroupRateCalculation(rate, count, isRaid); // pussywizard: optimization
        return rate;
    }
}

#endif
