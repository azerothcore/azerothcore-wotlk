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

#include "AllCreatureScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnCreatureAddWorld(Creature* creature)
{
    ASSERT(creature);

    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->OnCreatureAddWorld(creature);
    });
}

void ScriptMgr::OnCreatureRemoveWorld(Creature* creature)
{
    ASSERT(creature);

    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->OnCreatureRemoveWorld(creature);
    });
}

void ScriptMgr::OnCreatureSaveToDB(Creature* creature)
{
    ASSERT(creature);

    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->OnCreatureSaveToDB(creature);
    });
}

void ScriptMgr::OnBeforeCreatureSelectLevel(const CreatureTemplate* cinfo, Creature* creature, uint8& level)
{
    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->OnBeforeCreatureSelectLevel(cinfo, creature, level);
    });
}

void ScriptMgr::Creature_SelectLevel(const CreatureTemplate* cinfo, Creature* creature)
{
    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->Creature_SelectLevel(cinfo, creature);
    });
}

//bool ScriptMgr::CanCreatureSendListInventory(Player* player, Creature* creature, uint32 vendorEntry)
//{
//    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
//    {
//        return !script->CanCreatureSendListInventory(player, creature, vendorEntry);
//    });
//
//    if (ret && *ret)
//        return false;
//
//    return true;
//}

AllCreatureScript::AllCreatureScript(const char* name) :
    ScriptObject(name)
{
    ScriptRegistry<AllCreatureScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<AllCreatureScript>;
