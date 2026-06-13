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

#ifndef SCRIPT_OBJECT_ALL_ITEM_SCRIPT_H_
#define SCRIPT_OBJECT_ALL_ITEM_SCRIPT_H_

#include "ScriptObject.h"

class AllItemScript : public ScriptObject
{
protected:
    AllItemScript(const char* name);

public:
    // Called when a player accepts a quest from the item.
    [[nodiscard]] virtual bool CanItemQuestAccept(Player* /*player*/, Item* /*item*/, Quest const* /*quest*/) { return true; }

    // Called when a player uses the item.
    [[nodiscard]] virtual bool CanItemUse(Player* /*player*/, Item* /*item*/, SpellCastTargets const& /*targets*/) { return false; }

    // Called when the item is destroyed.
    [[nodiscard]] virtual bool CanItemRemove(Player* /*player*/, Item* /*item*/) { return true; }

    // Called when the item expires (is destroyed).
    [[nodiscard]] virtual bool CanItemExpire(Player* /*player*/, ItemTemplate const* /*proto*/) { return true; }

    // Called when a player selects an option in an item gossip window
    virtual void OnItemGossipSelect(Player* /*player*/, Item* /*item*/, uint32 /*sender*/, uint32 /*action*/) { }

    // Called when a player selects an option in an item gossip window
    virtual void OnItemGossipSelectCode(Player* /*player*/, Item* /*item*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { }
};

#endif
