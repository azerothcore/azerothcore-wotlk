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

#include "AreaTriggerScript.h"
#include "ALEScript.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

bool ScriptMgr::OnAreaTrigger(Player* player, AreaTrigger const* trigger)
{
    ASSERT(player);
    ASSERT(trigger);

    auto ret = IsValidBoolScript<ALEScript>([&](ALEScript* script)
    {
        return script->CanAreaTrigger(player, trigger);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<AreaTriggerScript>::GetScriptById(sObjectMgr->GetAreaTriggerScriptId(trigger->entry));
    return tempScript ? tempScript->OnTrigger(player, trigger) : false;
}

AreaTriggerScript::AreaTriggerScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<AreaTriggerScript>::AddScript(this);
}

bool OnlyOnceAreaTriggerScript::OnTrigger(Player* player, AreaTrigger const* trigger)
{
    uint32 const triggerId = trigger->entry;

    if (InstanceScript* instance = player->GetInstanceScript())
    {
        if (instance->IsAreaTriggerDone(triggerId))
        {
            return true;
        }
        else
        {
            instance->MarkAreaTriggerDone(triggerId);
        }
    }

    return _OnTrigger(player, trigger);
}

void OnlyOnceAreaTriggerScript::ResetAreaTriggerDone(InstanceScript* script, uint32 triggerId)
{
    script->ResetAreaTriggerDone(triggerId);
}

void OnlyOnceAreaTriggerScript::ResetAreaTriggerDone(Player const* player, AreaTrigger const* trigger)
{
    if (InstanceScript* instance = player->GetInstanceScript())
    {
        ResetAreaTriggerDone(instance, trigger->entry);
    }
}

template class AC_GAME_API ScriptRegistry<AreaTriggerScript>;
