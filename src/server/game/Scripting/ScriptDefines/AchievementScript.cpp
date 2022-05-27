/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::SetRealmCompleted(AchievementEntry const* achievement)
{
    ExecuteScript<AchievementScript>([&](AchievementScript* script)
    {
        script->SetRealmCompleted(achievement);
    });
}

bool ScriptMgr::IsCompletedCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria, AchievementEntry const* achievement, CriteriaProgress const* progress)
{
    auto ret = IsValidBoolScript<AchievementScript>([&](AchievementScript* script)
    {
        return !script->IsCompletedCriteria(mgr, achievementCriteria, achievement, progress);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsRealmCompleted(AchievementGlobalMgr const* globalmgr, AchievementEntry const* achievement, SystemTimePoint completionTime)
{
    auto ret = IsValidBoolScript<AchievementScript>([&](AchievementScript* script)
    {
        return !script->IsRealmCompleted(globalmgr, achievement, completionTime);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnBeforeCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntryList const* achievementCriteriaList)
{
    ExecuteScript<AchievementScript>([&](AchievementScript* script)
    {
        script->OnBeforeCheckCriteria(mgr, achievementCriteriaList);
    });
}

bool ScriptMgr::CanCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria)
{
    auto ret = IsValidBoolScript<AchievementScript>([&](AchievementScript* script)
    {
        return !script->CanCheckCriteria(mgr, achievementCriteria);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}
