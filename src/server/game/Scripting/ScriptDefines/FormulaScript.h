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

#ifndef SCRIPT_OBJECT_FORMULA_SCRIPT_H_
#define SCRIPT_OBJECT_FORMULA_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum FormulaHook
{
    FORMULAHOOK_ON_HONOR_CALCULATION,
    FORMULAHOOK_ON_GRAY_LEVEL_CALCULATION,
    FORMULAHOOK_ON_COLOR_CODE_CALCULATION,
    FORMULAHOOK_ON_ZERO_DIFFERENCE_CALCULATION,
    FORMULAHOOK_ON_BASE_GAIN_CALCULATION,
    FORMULAHOOK_ON_GAIN_CALCULATION,
    FORMULAHOOK_ON_GROUP_RATE_CALCULATION,
    FORMULAHOOK_ON_AFTER_ARENA_RATING_CALCULATION,
    FORMULAHOOK_ON_BEFORE_UPDATING_PERSONAL_RATING,
    FORMULAHOOK_END
};

enum XPColorChar : uint8;

class FormulaScript : public ScriptObject
{
protected:
    FormulaScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    // Called after calculating honor.
    virtual void OnHonorCalculation(float& /*honor*/, uint8 /*level*/, float /*multiplier*/) { }

    // Called after gray level calculation.
    virtual void OnGrayLevelCalculation(uint8& /*grayLevel*/, uint8 /*playerLevel*/) { }

    // Called after calculating experience color.
    virtual void OnColorCodeCalculation(XPColorChar& /*color*/, uint8 /*playerLevel*/, uint8 /*mobLevel*/) { }

    // Called after calculating zero difference.
    virtual void OnZeroDifferenceCalculation(uint8& /*diff*/, uint8 /*playerLevel*/) { }

    // Called after calculating base experience gain.
    virtual void OnBaseGainCalculation(uint32& /*gain*/, uint8 /*playerLevel*/, uint8 /*mobLevel*/, ContentLevels /*content*/) { }

    // Called after calculating experience gain.
    virtual void OnGainCalculation(uint32& /*gain*/, Player* /*player*/, Unit* /*unit*/) { }

    // Called when calculating the experience rate for group experience.
    virtual void OnGroupRateCalculation(float& /*rate*/, uint32 /*count*/, bool /*isRaid*/) { }

    // Called after calculating arena rating changes
    virtual void OnAfterArenaRatingCalculation(Battleground* const /*bg*/, int32& /*winnerMatchmakerChange*/, int32& /*loserMatchmakerChange*/, int32& /*winnerChange*/, int32& /*loserChange*/) { };

    // Called before modifying a player's personal rating
    virtual void OnBeforeUpdatingPersonalRating(int32& /*mod*/, uint32 /*type*/) { }
};

#endif
