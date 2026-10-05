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

#include "LootMgr.h"
#include "gtest/gtest.h"

#include <set>

TEST(LootTemplateCollectItemIdsTest, CollectsEveryItemOnce)
{
    LootTemplate loot;

    loot.AddEntry(new LootStoreItem(100, 0, 100.0f, false, 1, 0, 1, 1));  // ungrouped
    loot.AddEntry(new LootStoreItem(200, 0, 100.0f, false, 1, 1, 1, 1));  // group 1, explicit chance
    loot.AddEntry(new LootStoreItem(300, 0, 0.0f, false, 1, 1, 1, 1));    // group 1, equal chanced
    loot.AddEntry(new LootStoreItem(400, 0, 50.0f, false, 1, 2, 1, 1));   // group 2
    loot.AddEntry(new LootStoreItem(100, 0, 100.0f, false, 1, 0, 1, 1));  // duplicate collapses

    std::set<uint32> itemIds;
    loot.CollectItemIds(itemIds);

    EXPECT_EQ(itemIds, (std::set<uint32>{100, 200, 300, 400}));
}

TEST(LootTemplateCollectItemIdsTest, EmptyTemplate)
{
    LootTemplate loot;

    std::set<uint32> itemIds;
    loot.CollectItemIds(itemIds);

    EXPECT_TRUE(itemIds.empty());
}
