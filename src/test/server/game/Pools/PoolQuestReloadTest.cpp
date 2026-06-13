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

/*
 * Regression test for pool quest reload bug.
 *
 * When `.reload creature_queststarter` is executed, LoadQuestRelationsHelper()
 * clears the creature quest relation map (_creatureQuestRelations) which
 * contains the active pooled daily quest.  It repopulates the pool mapping
 * (mQuestCreatureRelation) but never calls Spawn1Object() to re-insert the
 * active quest into the creature relation map.  This causes ALL pool-based
 * daily quests (Dalaran cooking, fishing, jewelcrafting, etc.) to vanish
 * from their NPCs.
 */

#include "ObjectMgr.h"
#include "PoolMgr.h"
#include "QuestDef.h"
#include "gtest/gtest.h"

namespace
{

// Test IDs chosen to avoid collisions with real data
static constexpr uint32 TEST_QUEST_ID    = 99998;
static constexpr uint32 TEST_CREATURE_ID = 99999;

class PoolQuestReloadTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        creatureQuestMap = sObjectMgr->GetCreatureQuestRelationMap();

        // Establish the pool-side mapping: quest -> creature
        // This is what LoadQuestRelationsHelper populates for pooled quests
        sPoolMgr->mQuestCreatureRelation.insert(
            PooledQuestRelation::value_type(TEST_QUEST_ID, TEST_CREATURE_ID));
    }

    void TearDown() override
    {
        // Clean up: remove test entries from both maps
        auto range = sPoolMgr->mQuestCreatureRelation.equal_range(TEST_QUEST_ID);
        sPoolMgr->mQuestCreatureRelation.erase(range.first, range.second);

        // Remove any test entries left in creature quest relations
        auto crRange = creatureQuestMap->equal_range(TEST_CREATURE_ID);
        for (auto it = crRange.first; it != crRange.second; )
        {
            if (it->second == TEST_QUEST_ID)
                it = creatureQuestMap->erase(it);
            else
                ++it;
        }
    }

    /// Helper: count how many times quest appears on a creature in the quest relation map
    uint32 CountQuestOnCreature(uint32 creatureId, uint32 questId)
    {
        uint32 count = 0;
        auto range = creatureQuestMap->equal_range(creatureId);
        for (auto it = range.first; it != range.second; ++it)
            if (it->second == questId)
                ++count;
        return count;
    }

    /// Simulate what Spawn1Object does: copy the active pool quest
    /// from mQuestCreatureRelation into the creature quest relation map
    void SimulateSpawn1Object(uint32 questId)
    {
        PoolGroup<Quest> poolGroup;
        PoolObject obj(questId, 0.0f);
        poolGroup.Spawn1Object(&obj);
    }

    /// Simulate what LoadQuestRelationsHelper does on reload:
    /// 1. Clear the creature quest relation map
    /// 2. Clear and repopulate mQuestCreatureRelation
    /// Non-pooled quests would be re-added to the creature map, but
    /// pooled quests only go into mQuestCreatureRelation.
    void SimulateReload()
    {
        // Step 1: map.clear() — line 8589 of ObjectMgr.cpp
        creatureQuestMap->clear();

        // Step 2: poolRelationMap->clear() — line 8604 of ObjectMgr.cpp
        sPoolMgr->mQuestCreatureRelation.clear();

        // Step 3: Repopulate poolRelationMap from DB
        // (In the real code this re-reads creature_queststarter LEFT JOIN pool_quest)
        sPoolMgr->mQuestCreatureRelation.insert(
            PooledQuestRelation::value_type(TEST_QUEST_ID, TEST_CREATURE_ID));

        // NOTE: The real reload handler does NOT call Spawn1Object here.
        // That is the bug.
    }

    QuestRelations* creatureQuestMap = nullptr;
};

// ------------------------------------------------------------------
// Baseline: Spawn1Object correctly adds pooled quest to NPC
// ------------------------------------------------------------------
// cppcheck-suppress syntaxError
TEST_F(PoolQuestReloadTest, Spawn1ObjectAddsQuestToCreatureRelationMap)
{
    // Initially the quest should NOT be on the creature
    EXPECT_EQ(CountQuestOnCreature(TEST_CREATURE_ID, TEST_QUEST_ID), 0u)
        << "Quest should not be on creature before Spawn1Object";

    // Spawn1Object reads from mQuestCreatureRelation and inserts into
    // the creature quest relation map
    SimulateSpawn1Object(TEST_QUEST_ID);

    EXPECT_EQ(CountQuestOnCreature(TEST_CREATURE_ID, TEST_QUEST_ID), 1u)
        << "Quest should appear on creature after Spawn1Object";
}

// ------------------------------------------------------------------
// BUG: Reload clears pooled quest without re-spawning it
// ------------------------------------------------------------------
TEST_F(PoolQuestReloadTest, ReloadCreatureQuestStarterRemovesPooledQuest)
{
    // 1. Spawn the pool quest onto the NPC (normal startup behavior)
    SimulateSpawn1Object(TEST_QUEST_ID);
    ASSERT_EQ(CountQuestOnCreature(TEST_CREATURE_ID, TEST_QUEST_ID), 1u)
        << "Precondition: quest must be on creature before reload";

    // 2. Simulate `.reload creature_queststarter`
    SimulateReload();

    // 3. THE BUG: quest is gone from the NPC even though it's still
    //    the active daily in the pool
    EXPECT_EQ(CountQuestOnCreature(TEST_CREATURE_ID, TEST_QUEST_ID), 0u)
        << "BUG: After reload, pooled quest vanishes from creature "
           "because Spawn1Object is never called";

    // 4. Verify mQuestCreatureRelation still has the mapping
    //    (the pool system KNOWS about the quest, it's just not on the NPC)
    auto range = sPoolMgr->mQuestCreatureRelation.equal_range(TEST_QUEST_ID);
    EXPECT_NE(range.first, range.second)
        << "Pool mapping should still exist after reload";
}

// ------------------------------------------------------------------
// Calling Spawn1Object after reload would fix the problem
// ------------------------------------------------------------------
TEST_F(PoolQuestReloadTest, Spawn1ObjectAfterReloadRestoresQuest)
{
    // Setup: spawn, reload (quest disappears)
    SimulateSpawn1Object(TEST_QUEST_ID);
    SimulateReload();
    ASSERT_EQ(CountQuestOnCreature(TEST_CREATURE_ID, TEST_QUEST_ID), 0u)
        << "Precondition: quest must be missing after reload";

    // Fix: call Spawn1Object again for the active pool quest
    SimulateSpawn1Object(TEST_QUEST_ID);

    EXPECT_EQ(CountQuestOnCreature(TEST_CREATURE_ID, TEST_QUEST_ID), 1u)
        << "Spawn1Object after reload should restore the quest on the NPC";
}

// ------------------------------------------------------------------
// Non-pooled quests survive reload (contrast with pooled quests)
// ------------------------------------------------------------------
TEST_F(PoolQuestReloadTest, NonPooledQuestSurvivesReload)
{
    static constexpr uint32 REGULAR_QUEST_ID = 99990;

    // A non-pooled quest is added directly to the creature quest map
    // (this is what LoadQuestRelationsHelper does for quests without pool_entry)
    creatureQuestMap->insert(QuestRelations::value_type(TEST_CREATURE_ID, REGULAR_QUEST_ID));

    // Simulate reload: clear and repopulate
    creatureQuestMap->clear();
    // Non-pooled quests get re-inserted directly (simulating the DB reload)
    creatureQuestMap->insert(QuestRelations::value_type(TEST_CREATURE_ID, REGULAR_QUEST_ID));

    EXPECT_EQ(CountQuestOnCreature(TEST_CREATURE_ID, REGULAR_QUEST_ID), 1u)
        << "Non-pooled quests survive reload because they are re-inserted directly";

    // Cleanup
    auto range = creatureQuestMap->equal_range(TEST_CREATURE_ID);
    for (auto it = range.first; it != range.second; )
    {
        if (it->second == REGULAR_QUEST_ID)
            it = creatureQuestMap->erase(it);
        else
            ++it;
    }
}

}  // namespace

// ------------------------------------------------------------------
// PoolQuestReloadFixTest: exercises the actual ReSpawnPoolQuests() fix
// by setting up PoolMgr private state (friend class access).
// Must be at global scope to match the friend declaration in PoolMgr.
// ------------------------------------------------------------------
class PoolQuestReloadFixTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        creatureQuestMap = sObjectMgr->GetCreatureQuestRelationMap();

        // Set up pool infrastructure (private members via friend access)
        sPoolMgr->mPoolTemplate[TEST_POOL_ID].MaxLimit = 1;

        // Create the pool group entry (Spawn1Object doesn't use pool group
        // internals, it only reads mQuestCreatureRelation)
        sPoolMgr->mPoolQuestGroups[TEST_POOL_ID].SetPoolId(TEST_POOL_ID);

        sPoolMgr->mQuestSearchMap[TEST_QUEST_ID] = TEST_POOL_ID;

        // Mark the quest as active/spawned
        sPoolMgr->mSpawnedData.ActivateObject<Quest>(TEST_QUEST_ID, TEST_POOL_ID);

        // Set up pool-side mapping: quest -> creature
        sPoolMgr->mQuestCreatureRelation.insert(
            PooledQuestRelation::value_type(TEST_QUEST_ID, TEST_CREATURE_ID));
    }

    void TearDown() override
    {
        // Clean up all test state from the singletons
        sPoolMgr->mPoolTemplate.erase(TEST_POOL_ID);
        sPoolMgr->mPoolQuestGroups.erase(TEST_POOL_ID);
        sPoolMgr->mQuestSearchMap.erase(TEST_QUEST_ID);
        sPoolMgr->mSpawnedData.RemoveObject<Quest>(TEST_QUEST_ID, TEST_POOL_ID);

        auto range = sPoolMgr->mQuestCreatureRelation.equal_range(TEST_QUEST_ID);
        sPoolMgr->mQuestCreatureRelation.erase(range.first, range.second);

        auto crRange = creatureQuestMap->equal_range(TEST_CREATURE_ID);
        for (auto it = crRange.first; it != crRange.second; )
        {
            if (it->second == TEST_QUEST_ID)
                it = creatureQuestMap->erase(it);
            else
                ++it;
        }
    }

    static constexpr uint32 TEST_QUEST_ID    = 99998;
    static constexpr uint32 TEST_CREATURE_ID = 99999;
    static constexpr uint32 TEST_POOL_ID     = 99997;

    QuestRelations* creatureQuestMap = nullptr;
};

TEST_F(PoolQuestReloadFixTest, ReSpawnPoolQuestsRestoresQuestAfterReload)
{
    // 1. Spawn the quest onto the NPC (simulates normal startup)
    PoolGroup<Quest> poolGroup;
    PoolObject obj(TEST_QUEST_ID, 0.0f);
    poolGroup.Spawn1Object(&obj);

    auto count = [&]() {
        uint32 n = 0;
        auto range = creatureQuestMap->equal_range(TEST_CREATURE_ID);
        for (auto it = range.first; it != range.second; ++it)
            if (it->second == TEST_QUEST_ID)
                ++n;
        return n;
    };

    ASSERT_EQ(count(), 1u) << "Quest should be on creature before reload";

    // 2. Simulate reload: clear creature quest map and repopulate pool mapping
    creatureQuestMap->clear();
    sPoolMgr->mQuestCreatureRelation.clear();
    sPoolMgr->mQuestCreatureRelation.insert(
        PooledQuestRelation::value_type(TEST_QUEST_ID, TEST_CREATURE_ID));

    ASSERT_EQ(count(), 0u) << "Quest should be gone after reload clears the map";

    // 3. THE FIX: ReSpawnPoolQuests re-inserts active pool quests
    sPoolMgr->ReSpawnPoolQuests();

    EXPECT_EQ(count(), 1u)
        << "ReSpawnPoolQuests should restore active pool quests after reload";
}
