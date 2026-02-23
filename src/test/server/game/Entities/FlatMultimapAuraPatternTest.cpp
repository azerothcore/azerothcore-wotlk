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

#include "gtest/gtest.h"
#include <boost/container/flat_map.hpp>
#include <cstdint>
#include <set>
#include <vector>

// Lightweight fake aura — just enough state for pattern testing.
struct FakeAura
{
    uint32_t spellId;
    bool removed = false;
    bool expired = false;
    bool updated = false;

    explicit FakeAura(uint32_t id) : spellId(id) {}
    bool IsRemoved() const { return removed; }
    bool IsExpired() const { return expired; }
};

using AuraMap = boost::container::flat_multimap<uint32_t, FakeAura*>;

// -----------------------------------------------------------------------
// 1. Snapshot-update pattern (mirrors _UpdateSpells snapshot loop)
//
//    Snapshot pointers to a vector, then iterate the vector.
//    Entries marked removed during iteration are skipped.
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, SnapshotUpdate)
{
    FakeAura a1(100), a2(100), a3(200), a4(300);
    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(100, &a2);
    map.emplace(200, &a3);
    map.emplace(300, &a4);

    // Snapshot pointers (mirrors Unit::_UpdateSpells)
    std::vector<FakeAura*> snapshot;
    snapshot.reserve(map.size());
    for (auto& [id, aura] : map)
        snapshot.push_back(aura);

    ASSERT_EQ(snapshot.size(), 4u);

    // Mark a2 as removed mid-iteration (simulates cascading removal)
    a2.removed = true;

    // Process snapshot — skip removed entries
    for (FakeAura* aura : snapshot)
    {
        if (!aura->IsRemoved())
            aura->updated = true;
    }

    EXPECT_TRUE(a1.updated);
    EXPECT_FALSE(a2.updated);  // skipped — was removed
    EXPECT_TRUE(a3.updated);
    EXPECT_TRUE(a4.updated);
}

// -----------------------------------------------------------------------
// 2. Erase-and-reset-to-begin (mirrors RemoveOwnedAura / expire loop)
//
//    for (auto i = map.begin(); i != map.end();)
//        if (should_remove) { erase(i); i = map.begin(); }
//        else ++i;
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, EraseResetToBegin)
{
    FakeAura a1(100), a2(200), a3(300), a4(400), a5(500);
    a2.expired = true;
    a4.expired = true;

    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(200, &a2);
    map.emplace(300, &a3);
    map.emplace(400, &a4);
    map.emplace(500, &a5);

    std::vector<FakeAura*> removed;

    // Mirrors the expire loop in _UpdateSpells / RemoveOwnedAuras
    for (AuraMap::iterator i = map.begin(); i != map.end();)
    {
        if (i->second->IsExpired())
        {
            FakeAura* aura = i->second;
            map.erase(i);
            i = map.begin();  // reset — flat_multimap invalidates all
            removed.push_back(aura);
        }
        else
            ++i;
    }

    // a2 and a4 should have been removed
    ASSERT_EQ(removed.size(), 2u);
    EXPECT_EQ(removed[0]->spellId, 200u);
    EXPECT_EQ(removed[1]->spellId, 400u);

    // Remaining entries
    ASSERT_EQ(map.size(), 3u);
    std::set<uint32_t> remaining;
    for (auto& [id, aura] : map)
        remaining.insert(id);
    EXPECT_TRUE(remaining.count(100));
    EXPECT_TRUE(remaining.count(300));
    EXPECT_TRUE(remaining.count(500));
}

// -----------------------------------------------------------------------
// 3. lower_bound / upper_bound erase (mirrors RemoveOwnedAura by spellId
//    and RemoveAurasDueToSpell)
//
//    Iterate a key range, erase matching entries, reset iterator to
//    lower_bound after each erase.
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, LowerUpperBoundErase)
{
    FakeAura a1(100), a2(100), a3(100), a4(200), a5(200);
    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(100, &a2);
    map.emplace(100, &a3);
    map.emplace(200, &a4);
    map.emplace(200, &a5);

    // Remove all entries with key 100 — mirrors RemoveOwnedAura(spellId)
    uint32_t targetKey = 100;
    for (auto itr = map.lower_bound(targetKey);
         itr != map.upper_bound(targetKey);)
    {
        map.erase(itr);
        itr = map.lower_bound(targetKey);  // reset after erase
    }

    // All key-100 entries gone
    EXPECT_EQ(map.count(100), 0u);

    // Key-200 entries untouched
    EXPECT_EQ(map.count(200), 2u);
    ASSERT_EQ(map.size(), 2u);
}

// -----------------------------------------------------------------------
// 3b. Selective erase within a key range
//     (mirrors RemoveOwnedAura with casterGUID / effectMask filter)
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, SelectiveLowerBoundErase)
{
    FakeAura a1(100), a2(100), a3(100);
    // Only remove entries whose spellId matches AND which are expired
    a1.expired = false;
    a2.expired = true;
    a3.expired = false;

    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(100, &a2);
    map.emplace(100, &a3);

    uint32_t targetKey = 100;
    for (auto itr = map.lower_bound(targetKey);
         itr != map.upper_bound(targetKey);)
    {
        if (itr->second->IsExpired())
        {
            map.erase(itr);
            itr = map.lower_bound(targetKey);
        }
        else
            ++itr;
    }

    // Only a2 removed
    EXPECT_EQ(map.count(100), 2u);

    // Verify the right ones survived
    std::set<FakeAura*> survivors;
    for (auto itr = map.lower_bound(100); itr != map.upper_bound(100); ++itr)
        survivors.insert(itr->second);
    EXPECT_TRUE(survivors.count(&a1));
    EXPECT_FALSE(survivors.count(&a2));
    EXPECT_TRUE(survivors.count(&a3));
}

// -----------------------------------------------------------------------
// 4. Erase during snapshot (mirrors cascading removal — snapshot loop
//    processes pointers while the map is mutated underneath)
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, EraseDuringSnapshot)
{
    FakeAura a1(100), a2(200), a3(300), a4(400);
    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(200, &a2);
    map.emplace(300, &a3);
    map.emplace(400, &a4);

    // Snapshot pointers
    std::vector<FakeAura*> snapshot;
    snapshot.reserve(map.size());
    for (auto& [id, aura] : map)
        snapshot.push_back(aura);

    // Process snapshot; during processing, erase entries from the map
    std::vector<uint32_t> processed;
    for (FakeAura* aura : snapshot)
    {
        if (aura->IsRemoved())
            continue;

        processed.push_back(aura->spellId);

        // Simulate cascading removal: processing a1 causes a3 to be
        // removed from the map and marked removed
        if (aura == &a1)
        {
            a3.removed = true;
            // Erase a3 from map by finding it
            for (auto it = map.begin(); it != map.end(); ++it)
            {
                if (it->second == &a3)
                {
                    map.erase(it);
                    break;
                }
            }
        }
    }

    // a1, a2, a4 processed; a3 skipped due to IsRemoved()
    ASSERT_EQ(processed.size(), 3u);
    EXPECT_EQ(processed[0], 100u);
    EXPECT_EQ(processed[1], 200u);
    EXPECT_EQ(processed[2], 400u);

    // Map should have 3 entries (a3 was erased)
    EXPECT_EQ(map.size(), 3u);
}

// -----------------------------------------------------------------------
// 5. Insert during snapshot iteration
//    Snapshot loop must NOT see newly inserted entries.
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, InsertDuringSnapshot)
{
    FakeAura a1(100), a2(200);
    FakeAura a3(300);  // will be inserted during snapshot iteration

    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(200, &a2);

    // Snapshot before iteration
    std::vector<FakeAura*> snapshot;
    snapshot.reserve(map.size());
    for (auto& [id, aura] : map)
        snapshot.push_back(aura);

    ASSERT_EQ(snapshot.size(), 2u);

    // During iteration, insert a new entry
    std::vector<uint32_t> processed;
    for (FakeAura* aura : snapshot)
    {
        if (!aura->IsRemoved())
        {
            processed.push_back(aura->spellId);
            aura->updated = true;
        }

        // Insert a3 while iterating the snapshot
        if (aura == &a1)
            map.emplace(300, &a3);
    }

    // Only the original 2 were processed
    ASSERT_EQ(processed.size(), 2u);
    EXPECT_EQ(processed[0], 100u);
    EXPECT_EQ(processed[1], 200u);

    // a3 was NOT processed (not in snapshot)
    EXPECT_FALSE(a3.updated);

    // But it IS in the map for future iterations
    EXPECT_EQ(map.size(), 3u);
    EXPECT_EQ(map.count(300), 1u);
}

// -----------------------------------------------------------------------
// 6. Predicate-based removal with reset-to-begin
//    (mirrors RemoveOwnedAuras(std::function<bool(Aura const*)>))
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, PredicateRemovalResetBegin)
{
    FakeAura a1(100), a2(200), a3(300), a4(400), a5(500);
    // Remove even-numbered spell IDs
    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(200, &a2);
    map.emplace(300, &a3);
    map.emplace(400, &a4);
    map.emplace(500, &a5);

    auto shouldRemove = [](FakeAura const* a) {
        return (a->spellId % 200) == 0;
    };

    for (AuraMap::iterator iter = map.begin(); iter != map.end();)
    {
        if (shouldRemove(iter->second))
        {
            map.erase(iter);
            iter = map.begin();  // reset — mirrors RemoveOwnedAuras
            continue;
        }
        ++iter;
    }

    ASSERT_EQ(map.size(), 3u);
    EXPECT_EQ(map.count(100), 1u);
    EXPECT_EQ(map.count(200), 0u);
    EXPECT_EQ(map.count(300), 1u);
    EXPECT_EQ(map.count(400), 0u);
    EXPECT_EQ(map.count(500), 1u);
}

// -----------------------------------------------------------------------
// 7. Predicate removal within a key range with reset-to-lower_bound
//    (mirrors RemoveOwnedAuras(spellId, check))
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, PredicateRemovalInKeyRange)
{
    FakeAura a1(100), a2(100), a3(100), a4(100);
    a1.expired = false;
    a2.expired = true;
    a3.expired = false;
    a4.expired = true;

    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(100, &a2);
    map.emplace(100, &a3);
    map.emplace(100, &a4);
    map.emplace(200, new FakeAura(200));  // different key, untouched

    uint32_t spellId = 100;
    for (auto iter = map.lower_bound(spellId);
         iter != map.upper_bound(spellId);)
    {
        if (iter->second->IsExpired())
        {
            map.erase(iter);
            iter = map.lower_bound(spellId);
            continue;
        }
        ++iter;
    }

    // 2 expired removed, 2 non-expired remain under key 100
    EXPECT_EQ(map.count(100), 2u);
    // Key 200 untouched
    EXPECT_EQ(map.count(200), 1u);

    // Clean up heap-allocated entry
    for (auto& [id, aura] : map)
        if (id == 200)
            delete aura;
}

// -----------------------------------------------------------------------
// 8. AuraStateAuras erase-and-reset-to-lower_bound
//    (mirrors _UnapplyAura's m_auraStateAuras cleanup)
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, AuraStateMapErasePattern)
{
    // Uses an enum-like key (AuraStateType is an enum in the real code)
    using AuraStateMap = boost::container::flat_multimap<uint32_t, FakeAura*>;

    FakeAura a1(10), a2(20), a3(30), a4(40);
    AuraStateMap map;
    // State 1 has multiple entries
    map.emplace(1, &a1);
    map.emplace(1, &a2);
    map.emplace(1, &a3);
    // State 2 has one entry
    map.emplace(2, &a4);

    // Remove a2 from state 1 — mirrors _UnapplyAura pattern
    uint32_t auraState = 1;
    FakeAura* target = &a2;
    for (auto itr = map.lower_bound(auraState);
         itr != map.upper_bound(auraState);)
    {
        if (itr->second == target)
        {
            map.erase(itr);
            itr = map.lower_bound(auraState);
            continue;
        }
        ++itr;
    }

    EXPECT_EQ(map.count(1), 2u);
    EXPECT_EQ(map.count(2), 1u);

    // Verify a2 is gone, a1 and a3 remain
    std::set<FakeAura*> stateOnes;
    for (auto itr = map.lower_bound(1); itr != map.upper_bound(1); ++itr)
        stateOnes.insert(itr->second);
    EXPECT_TRUE(stateOnes.count(&a1));
    EXPECT_FALSE(stateOnes.count(&a2));
    EXPECT_TRUE(stateOnes.count(&a3));
}

// -----------------------------------------------------------------------
// 9. Empty map edge cases — all patterns should be no-ops on empty maps
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, EmptyMapPatterns)
{
    AuraMap map;

    // Snapshot of empty map
    std::vector<FakeAura*> snapshot;
    for (auto& [id, aura] : map)
        snapshot.push_back(aura);
    EXPECT_TRUE(snapshot.empty());

    // Erase-reset-to-begin on empty map
    for (auto i = map.begin(); i != map.end();)
    {
        map.erase(i);
        i = map.begin();
    }
    EXPECT_TRUE(map.empty());

    // lower_bound/upper_bound on empty map
    for (auto itr = map.lower_bound(100); itr != map.upper_bound(100);)
    {
        map.erase(itr);
        itr = map.lower_bound(100);
    }
    EXPECT_TRUE(map.empty());
}

// -----------------------------------------------------------------------
// 10. Single-element map — boundary case for erase patterns
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, SingleElementPatterns)
{
    FakeAura a1(100);
    a1.expired = true;

    AuraMap map;
    map.emplace(100, &a1);

    // Erase-reset-to-begin with single element
    for (auto i = map.begin(); i != map.end();)
    {
        if (i->second->IsExpired())
        {
            map.erase(i);
            i = map.begin();
        }
        else
            ++i;
    }

    EXPECT_TRUE(map.empty());
}

// -----------------------------------------------------------------------
// 11. Erase all via reset-to-begin (stress test)
//     Every entry matches removal criteria.
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, EraseAllViaResetBegin)
{
    constexpr int N = 50;
    std::vector<FakeAura> auras;
    auras.reserve(N);

    AuraMap map;
    for (int i = 0; i < N; ++i)
    {
        auras.emplace_back(static_cast<uint32_t>(i * 10));
        map.emplace(auras.back().spellId, &auras.back());
    }

    ASSERT_EQ(map.size(), static_cast<size_t>(N));

    // Remove everything — every entry triggers erase + reset
    for (auto i = map.begin(); i != map.end();)
    {
        map.erase(i);
        i = map.begin();
    }

    EXPECT_TRUE(map.empty());
}

// -----------------------------------------------------------------------
// 12. Duplicate keys with interleaved erase (multiple auras per spellId)
// -----------------------------------------------------------------------
TEST(FlatMultimapAuraPattern, DuplicateKeysInterleavedErase)
{
    FakeAura a1(100), a2(100), a3(100), a4(200), a5(200);
    a2.expired = true;
    a5.expired = true;

    AuraMap map;
    map.emplace(100, &a1);
    map.emplace(100, &a2);
    map.emplace(100, &a3);
    map.emplace(200, &a4);
    map.emplace(200, &a5);

    // Global erase-reset-to-begin for expired entries
    for (auto i = map.begin(); i != map.end();)
    {
        if (i->second->IsExpired())
        {
            map.erase(i);
            i = map.begin();
        }
        else
            ++i;
    }

    EXPECT_EQ(map.size(), 3u);
    EXPECT_EQ(map.count(100), 2u);
    EXPECT_EQ(map.count(200), 1u);
}
