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

#include "LootScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnLootMoney(Player* player, uint32 gold)
{
    ASSERT(player);

    CALL_ENABLED_HOOKS(LootScript, LOOTHOOK_ON_LOOT_MONEY, script->OnLootMoney(player, gold));
}

LootScript::LootScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, LOOTHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < LOOTHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<LootScript>::AddScript(this, std::move(enabledHooks));
}
