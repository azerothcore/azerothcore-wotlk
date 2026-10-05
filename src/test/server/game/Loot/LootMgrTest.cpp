/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
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

namespace
{
// Test ids chosen to avoid collisions with real data
constexpr uint32 TEST_REFERENCE_ID_A = 999001;
constexpr uint32 TEST_REFERENCE_ID_B = 999002;
constexpr uint32 TEST_MISSING_REFERENCE_ID = 999999;
}  // namespace

class LootTemplateCollectItemIdsTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        // A references B, and B references A, forming a cycle.
        LootTemplate* templateA = new LootTemplate();
        templateA->AddEntry(new LootStoreItem(500, 0, 100.0f, false, 1, 0, 1, 1));
        templateA->AddEntry(new LootStoreItem(0, TEST_REFERENCE_ID_B, 100.0f, false, 1, 0, 1, 1));
        LootTemplates_Reference.m_LootTemplates[TEST_REFERENCE_ID_A] = templateA;

        LootTemplate* templateB = new LootTemplate();
        templateB->AddEntry(new LootStoreItem(600, 0, 100.0f, false, 1, 0, 1, 1));
        templateB->AddEntry(new LootStoreItem(0, TEST_REFERENCE_ID_A, 100.0f, false, 1, 0, 1, 1));
        LootTemplates_Reference.m_LootTemplates[TEST_REFERENCE_ID_B] = templateB;
    }

    void TearDown() override
    {
        auto removeTemplate = [](uint32 lootId)
        {
            auto itr = LootTemplates_Reference.m_LootTemplates.find(lootId);
            if (itr == LootTemplates_Reference.m_LootTemplates.end())
                return;

            delete itr->second;
            LootTemplates_Reference.m_LootTemplates.erase(itr);
        };

        removeTemplate(TEST_REFERENCE_ID_A);
        removeTemplate(TEST_REFERENCE_ID_B);
    }
};

TEST_F(LootTemplateCollectItemIdsTest, CollectsEveryItemOnce)
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

TEST_F(LootTemplateCollectItemIdsTest, EmptyTemplate)
{
    LootTemplate loot;

    std::set<uint32> itemIds;
    loot.CollectItemIds(itemIds);

    EXPECT_TRUE(itemIds.empty());
}

TEST_F(LootTemplateCollectItemIdsTest, FollowsReferencesAndTerminatesOnCycles)
{
    LootTemplate loot;

    loot.AddEntry(new LootStoreItem(400, 0, 100.0f, false, 1, 0, 1, 1));
    loot.AddEntry(new LootStoreItem(0, TEST_REFERENCE_ID_A, 100.0f, false, 1, 0, 1, 1));

    std::set<uint32> itemIds;
    loot.CollectItemIds(itemIds);

    // A -> B -> A must terminate, collecting each referenced item once.
    EXPECT_EQ(itemIds, (std::set<uint32>{400, 500, 600}));
}

TEST_F(LootTemplateCollectItemIdsTest, IgnoresMissingReferences)
{
    LootTemplate loot;

    loot.AddEntry(new LootStoreItem(0, TEST_MISSING_REFERENCE_ID, 100.0f, false, 1, 0, 1, 1));

    std::set<uint32> itemIds;
    loot.CollectItemIds(itemIds);

    EXPECT_TRUE(itemIds.empty());
}
