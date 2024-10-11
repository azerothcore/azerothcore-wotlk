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

#include "AchievementScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::SetRealmCompleted(AchievementEntry const* achievement)
{
    CALL_ENABLED_HOOKS(AchievementScript, ACHIEVEMENTHOOK_SET_REALM_COMPLETED, script->SetRealmCompleted(achievement));
}

bool ScriptMgr::IsCompletedCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria, AchievementEntry const* achievement, CriteriaProgress const* progress)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AchievementScript, ACHIEVEMENTHOOK_IS_COMPLETED_CRITERIA, !script->IsCompletedCriteria(mgr, achievementCriteria, achievement, progress));
}

bool ScriptMgr::IsRealmCompleted(AchievementGlobalMgr const* globalmgr, AchievementEntry const* achievement, SystemTimePoint completionTime)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AchievementScript, ACHIEVEMENTHOOK_IS_REALM_COMPLETED, !script->IsRealmCompleted(globalmgr, achievement, completionTime));
}

void ScriptMgr::OnBeforeCheckCriteria(AchievementMgr* mgr, std::list<AchievementCriteriaEntry const*> const* achievementCriteriaList)
{
    CALL_ENABLED_HOOKS(AchievementScript, ACHIEVEMENTHOOK_ON_BEFORE_CHECK_CRITERIA, script->OnBeforeCheckCriteria(mgr, achievementCriteriaList));
}

bool ScriptMgr::CanCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AchievementScript, ACHIEVEMENTHOOK_CAN_CHECK_CRITERIA, !script->CanCheckCriteria(mgr, achievementCriteria));
}

AchievementScript::AchievementScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, ACHIEVEMENTHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < ACHIEVEMENTHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<AchievementScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<AchievementScript>;
