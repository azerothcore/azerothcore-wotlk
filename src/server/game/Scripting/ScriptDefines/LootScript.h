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

#ifndef SCRIPT_OBJECT_LOOT_SCRIPT_H_
#define SCRIPT_OBJECT_LOOT_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum LootHook
{
    LOOTHOOK_ON_LOOT_MONEY,
    LOOTHOOK_END
};

class LootScript : public ScriptObject
{
protected:
    LootScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    /**
     * @brief This hook called before money loot
     *
     * @param player Contains information about the Player
     * @param gold Contains information about money
     */
    virtual void OnLootMoney(Player* /*player*/, uint32 /*gold*/) { }
};

#endif
