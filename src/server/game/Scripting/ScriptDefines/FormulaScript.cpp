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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnHonorCalculation(float& honor, uint8 level, float multiplier)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnHonorCalculation(honor, level, multiplier);
    });
}

void ScriptMgr::OnGrayLevelCalculation(uint8& grayLevel, uint8 playerLevel)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnGrayLevelCalculation(grayLevel, playerLevel);
    });
}

void ScriptMgr::OnColorCodeCalculation(XPColorChar& color, uint8 playerLevel, uint8 mobLevel)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnColorCodeCalculation(color, playerLevel, mobLevel);
    });
}

void ScriptMgr::OnZeroDifferenceCalculation(uint8& diff, uint8 playerLevel)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnZeroDifferenceCalculation(diff, playerLevel);
    });
}

void ScriptMgr::OnBaseGainCalculation(uint32& gain, uint8 playerLevel, uint8 mobLevel, ContentLevels content)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnBaseGainCalculation(gain, playerLevel, mobLevel, content);
    });
}

void ScriptMgr::OnGainCalculation(uint32& gain, Player* player, Unit* unit)
{
    ASSERT(player);
    ASSERT(unit);

    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnGainCalculation(gain, player, unit);
    });
}

void ScriptMgr::OnGroupRateCalculation(float& rate, uint32 count, bool isRaid)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnGroupRateCalculation(rate, count, isRaid);
    });
}

void ScriptMgr::OnAfterArenaRatingCalculation(Battleground* const bg, int32& winnerMatchmakerChange, int32& loserMatchmakerChange, int32& winnerChange, int32& loserChange)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnAfterArenaRatingCalculation(bg, winnerMatchmakerChange, loserMatchmakerChange, winnerChange, loserChange);
    });
}

void ScriptMgr::OnBeforeUpdatingPersonalRating(int32& mod, uint32 type)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnBeforeUpdatingPersonalRating(mod, type);
    });
}
