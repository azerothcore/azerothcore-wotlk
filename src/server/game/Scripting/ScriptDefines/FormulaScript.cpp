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

#include "FormulaScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnHonorCalculation(float& honor, uint8 level, float multiplier)
{
    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_HONOR_CALCULATION, script->OnHonorCalculation(honor, level, multiplier));
}

void ScriptMgr::OnGrayLevelCalculation(uint8& grayLevel, uint8 playerLevel)
{
    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_GRAY_LEVEL_CALCULATION, script->OnGrayLevelCalculation(grayLevel, playerLevel));
}

void ScriptMgr::OnColorCodeCalculation(XPColorChar& color, uint8 playerLevel, uint8 mobLevel)
{
    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_COLOR_CODE_CALCULATION, script->OnColorCodeCalculation(color, playerLevel, mobLevel));
}

void ScriptMgr::OnZeroDifferenceCalculation(uint8& diff, uint8 playerLevel)
{
    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_ZERO_DIFFERENCE_CALCULATION, script->OnZeroDifferenceCalculation(diff, playerLevel));
}

void ScriptMgr::OnBaseGainCalculation(uint32& gain, uint8 playerLevel, uint8 mobLevel, ContentLevels content)
{
    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_BASE_GAIN_CALCULATION, script->OnBaseGainCalculation(gain, playerLevel, mobLevel, content));
}

void ScriptMgr::OnGainCalculation(uint32& gain, Player* player, Unit* unit)
{
    ASSERT(player);
    ASSERT(unit);

    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_GAIN_CALCULATION, script->OnGainCalculation(gain, player, unit));
}

void ScriptMgr::OnGroupRateCalculation(float& rate, uint32 count, bool isRaid)
{
    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_GROUP_RATE_CALCULATION, script->OnGroupRateCalculation(rate, count, isRaid));
}

void ScriptMgr::OnAfterArenaRatingCalculation(Battleground* const bg, int32& winnerMatchmakerChange, int32& loserMatchmakerChange, int32& winnerChange, int32& loserChange)
{
    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_AFTER_ARENA_RATING_CALCULATION, script->OnAfterArenaRatingCalculation(bg, winnerMatchmakerChange, loserMatchmakerChange, winnerChange, loserChange));
}

void ScriptMgr::OnBeforeUpdatingPersonalRating(int32& mod, uint32 type)
{
    CALL_ENABLED_HOOKS(FormulaScript, FORMULAHOOK_ON_BEFORE_UPDATING_PERSONAL_RATING, script->OnBeforeUpdatingPersonalRating(mod, type));
}

FormulaScript::FormulaScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, FORMULAHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < FORMULAHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<FormulaScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<FormulaScript>;
