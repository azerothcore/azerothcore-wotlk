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

#include "CreatureScript.h"
#include "AllCreatureScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"
#include "ScriptedGossip.h"

bool ScriptMgr::OnGossipHello(Player* player, Creature* creature)
{
    ASSERT(player);
    ASSERT(creature);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureGossipHello(player, creature);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnGossipHello(player, creature) : false;
}

bool ScriptMgr::OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    ASSERT(player);
    ASSERT(creature);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureGossipSelect(player, creature, sender, action);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    return tempScript ? tempScript->OnGossipSelect(player, creature, sender, action) : false;
}

bool ScriptMgr::OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(code);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureGossipSelectCode(player, creature, sender, action, code);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    return tempScript ? tempScript->OnGossipSelectCode(player, creature, sender, action, code) : false;
}

bool ScriptMgr::OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureQuestAccept(player, creature, quest);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestAccept(player, creature, quest) : false;
}

bool ScriptMgr::OnQuestSelect(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestSelect(player, creature, quest) : false;
}

bool ScriptMgr::OnQuestComplete(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestComplete(player, creature, quest) : false;
}

bool ScriptMgr::OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureQuestReward(player, creature, quest, opt);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestReward(player, creature, quest, opt) : false;
}

uint32 ScriptMgr::GetDialogStatus(Player* player, Creature* creature)
{
    ASSERT(player);
    ASSERT(creature);

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    return tempScript ? tempScript->GetDialogStatus(player, creature) : DIALOG_STATUS_SCRIPTED_NO_STATUS;
}

CreatureAI* ScriptMgr::GetCreatureAI(Creature* creature)
{
    ASSERT(creature);

    auto retAI = GetReturnAIScript<AllCreatureScript, CreatureAI>([creature](AllCreatureScript* script)
    {
        return script->GetCreatureAI(creature);
    });

    if (retAI)
    {
        return retAI;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    return tempScript ? tempScript->GetAI(creature) : nullptr;
}

//Fires whenever the UNIT_BYTE2_FLAG_FFA_PVP bit is Changed on the player
void ScriptMgr::OnFfaPvpStateUpdate(Creature* creature, bool InPvp)
{
    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
        {
            script->OnFfaPvpStateUpdate(creature, InPvp);
        });
}

void ScriptMgr::OnCreatureUpdate(Creature* creature, uint32 diff)
{
    ASSERT(creature);

    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->OnAllCreatureUpdate(creature, diff);
    });

    if (auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId()))
    {
        tempScript->OnUpdate(creature, diff);
    }
}

CreatureScript::CreatureScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<CreatureScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<CreatureScript>;
