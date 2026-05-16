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

/**
 * @file SpellProcDBCValidationTest.cpp
 * @brief Unit tests for validating spell_proc entries against Spell.dbc
 *
 * Tests validate that spell_proc entries provide value beyond DBC defaults:
 * - Entries that override DBC ProcFlags/ProcChance/ProcCharges
 * - Entries that add new functionality (PPM, cooldowns, filtering)
 * - Identification of potentially redundant entries
 *
 * ============================================================================
 * DBC DATA POPULATION STATUS
 * ============================================================================
 *
 * The DBC_ProcFlags, DBC_ProcChance, and DBC_ProcCharges fields in
 * SpellProcTestEntry are currently populated with zeros (0, 0, 0) for all
 * entries. To fully validate spell_proc entries against DBC:
 *
 * 1. Use the generate_spell_proc_dbc_data.py script with MCP connection
 * 2. Or manually query: get_spell_dbc_proc_info(spell_id) for each spell
 *
 * Tests that require DBC data will check HasDBCData() and skip appropriately.
 * Once DBC data is populated, the statistics tests will show:
 * - How many entries override DBC defaults
 * - How many entries add new functionality not in DBC
 * - How many entries might be redundant (just duplicate DBC values)
 * ============================================================================
 */

#include "SpellProcTestData.h"
#include "gtest/gtest.h"
#include <algorithm>
#include <map>
#include <set>

using namespace testing;

// =============================================================================
// DBC Validation Test Fixture
// =============================================================================

class SpellProcDBCValidationTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _allEntries = GetAllSpellProcTestEntries();
    }

    std::vector<SpellProcTestEntry> _allEntries;
};

// =============================================================================
// Parameterized Tests for All Entries
// =============================================================================

class SpellProcDBCValidationParamTest : public ::testing::TestWithParam<SpellProcTestEntry>
{
};

TEST_P(SpellProcDBCValidationParamTest, EntryHasValidSpellId)
{
    auto const& entry = GetParam();
    int32_t spellId = std::abs(entry.SpellId);

    // Spell ID must be positive after abs
    EXPECT_GT(spellId, 0) << "SpellId must be non-zero";

    // Spell IDs in WotLK should be < 80000
    EXPECT_LT(spellId, 80000u)
        << "SpellId " << spellId << " seems out of range for WotLK";
}

INSTANTIATE_TEST_SUITE_P(
    AllSpellProcEntries,
    SpellProcDBCValidationParamTest,
    ::testing::ValuesIn(GetAllSpellProcTestEntries()),
    [](const testing::TestParamInfo<SpellProcTestEntry>& info) {
        // Create unique test name from SpellId (handle negative IDs)
        int32_t id = info.param.SpellId;
        if (id < 0)
            return "SpellId_N" + std::to_string(-id);
        return "SpellId_" + std::to_string(id);
    }
);

// =============================================================================
// Statistics Tests
// =============================================================================

TEST_F(SpellProcDBCValidationTest, CountEntriesWithDBCData)
{
    size_t withDBC = 0;
    size_t withoutDBC = 0;

    for (auto const& entry : _allEntries)
    {
        if (entry.HasDBCData())
            withDBC++;
        else
            withoutDBC++;
    }

    std::cout << "[  INFO    ] Entries with DBC data: " << withDBC << "\n";
    std::cout << "[  INFO    ] Entries without DBC data: " << withoutDBC << std::endl;

    // All entries should eventually have DBC data
    // For now, just verify the count
    EXPECT_EQ(_allEntries.size(), 869u);
}

TEST_F(SpellProcDBCValidationTest, CountEntriesAddingValue)
{
    size_t addsValue = 0;
    size_t potentiallyRedundant = 0;
    size_t noDBCYet = 0;

    for (auto const& entry : _allEntries)
    {
        // SKIP REASON: Entries without DBC data populated cannot be compared
        // against DBC defaults. The HasDBCData() check returns false when
        // DBC_ProcFlags, DBC_ProcChance, and DBC_ProcCharges are all zero.
        // Once DBC data is populated via MCP tools, this count should be 0.
        if (!entry.HasDBCData())
        {
            noDBCYet++;
            continue;
        }

        if (entry.AddsValueBeyondDBC())
            addsValue++;
        else
            potentiallyRedundant++;
    }

    std::cout << "[  INFO    ] Entries adding value: " << addsValue << "\n";
    std::cout << "[  INFO    ] Potentially redundant: " << potentiallyRedundant << "\n";
    std::cout << "[  INFO    ] DBC data not yet populated: " << noDBCYet << std::endl;

    // Most entries should add value (have PPM, cooldowns, filtering, etc.)
    if (addsValue + potentiallyRedundant > 0)
    {
        float valueRate = static_cast<float>(addsValue) / (addsValue + potentiallyRedundant) * 100;
        std::cout << "[  INFO    ] Value-add rate: " << valueRate << "%" << std::endl;
    }
}

TEST_F(SpellProcDBCValidationTest, CategorizeEntriesByFeature)
{
    size_t hasPPM = 0;
    size_t hasCooldown = 0;
    size_t hasSpellTypeMask = 0;
    size_t hasSpellPhaseMask = 0;
    size_t hasHitMask = 0;
    size_t hasAttributesMask = 0;
    size_t hasSpellFamilyMask = 0;
    size_t hasSchoolMask = 0;
    size_t hasCharges = 0;
    size_t hasDisableEffectsMask = 0;

    for (auto const& entry : _allEntries)
    {
        if (entry.ProcsPerMinute > 0) hasPPM++;
        if (entry.Cooldown > 0) hasCooldown++;
        if (entry.SpellTypeMask != 0) hasSpellTypeMask++;
        if (entry.SpellPhaseMask != 0) hasSpellPhaseMask++;
        if (entry.HitMask != 0) hasHitMask++;
        if (entry.AttributesMask != 0) hasAttributesMask++;
        if (entry.SpellFamilyMask0 != 0 || entry.SpellFamilyMask1 != 0 || entry.SpellFamilyMask2 != 0)
            hasSpellFamilyMask++;
        if (entry.SchoolMask != 0) hasSchoolMask++;
        if (entry.Charges > 0) hasCharges++;
        if (entry.DisableEffectsMask != 0) hasDisableEffectsMask++;
    }

    std::cout << "[  INFO    ] Feature usage (adds value beyond DBC):\n"
              << "             PPM: " << hasPPM << "\n"
              << "             Cooldown: " << hasCooldown << "\n"
              << "             SpellTypeMask: " << hasSpellTypeMask << "\n"
              << "             SpellPhaseMask: " << hasSpellPhaseMask << "\n"
              << "             HitMask: " << hasHitMask << "\n"
              << "             AttributesMask: " << hasAttributesMask << "\n"
              << "             SpellFamilyMask: " << hasSpellFamilyMask << "\n"
              << "             SchoolMask: " << hasSchoolMask << "\n"
              << "             Charges: " << hasCharges << "\n"
              << "             DisableEffectsMask: " << hasDisableEffectsMask << std::endl;

    // Most entries should use at least one extended feature
    size_t usingExtendedFeatures = 0;
    for (auto const& entry : _allEntries)
    {
        if (entry.ProcsPerMinute > 0 || entry.Cooldown > 0 ||
            entry.SpellTypeMask != 0 || entry.SpellPhaseMask != 0 ||
            entry.HitMask != 0 || entry.AttributesMask != 0 ||
            entry.SpellFamilyMask0 != 0 || entry.SpellFamilyMask1 != 0 ||
            entry.SpellFamilyMask2 != 0 || entry.SchoolMask != 0 ||
            entry.DisableEffectsMask != 0)
        {
            usingExtendedFeatures++;
        }
    }

    std::cout << "[  INFO    ] Entries using extended features: " << usingExtendedFeatures
              << " / " << _allEntries.size() << std::endl;

    // At least 80% should use extended features
    EXPECT_GT(usingExtendedFeatures, _allEntries.size() * 80 / 100)
        << "Most entries should use extended features";
}

TEST_F(SpellProcDBCValidationTest, IdentifyDBCOverrides)
{
    size_t overridesProcFlags = 0;
    size_t overridesChance = 0;
    size_t overridesCharges = 0;

    for (auto const& entry : _allEntries)
    {
        // SKIP REASON: Cannot compare against DBC defaults when DBC data
        // is not populated. All 869 entries currently have DBC fields = 0.
        // Once populated, this loop will count actual DBC overrides.
        if (!entry.HasDBCData())
            continue;

        if (entry.ProcFlags != 0 && entry.ProcFlags != entry.DBC_ProcFlags)
            overridesProcFlags++;

        if (entry.Chance != 0 && static_cast<uint32_t>(entry.Chance) != entry.DBC_ProcChance)
            overridesChance++;

        if (entry.Charges != 0 && entry.Charges != entry.DBC_ProcCharges)
            overridesCharges++;
    }

    std::cout << "[  INFO    ] DBC Overrides:\n"
              << "             ProcFlags: " << overridesProcFlags << "\n"
              << "             Chance: " << overridesChance << "\n"
              << "             Charges: " << overridesCharges << std::endl;
}

// =============================================================================
// Negative Spell ID Tests (Effect-specific procs)
// =============================================================================

TEST_F(SpellProcDBCValidationTest, CountNegativeSpellIds)
{
    size_t negativeIds = 0;
    size_t positiveIds = 0;

    for (auto const& entry : _allEntries)
    {
        if (entry.SpellId < 0)
            negativeIds++;
        else
            positiveIds++;
    }

    std::cout << "[  INFO    ] Negative SpellIds (effect-specific): " << negativeIds << "\n";
    std::cout << "[  INFO    ] Positive SpellIds: " << positiveIds << std::endl;

    // Both types should exist
    EXPECT_GT(negativeIds, 0u) << "Should have some effect-specific (negative ID) entries";
    EXPECT_GT(positiveIds, 0u) << "Should have some spell-wide (positive ID) entries";
}

// =============================================================================
// SpellFamily Coverage Tests
// =============================================================================

TEST_F(SpellProcDBCValidationTest, CoverageBySpellFamily)
{
    std::map<uint32_t, size_t> familyCounts;
    std::map<uint32_t, std::string> familyNames = {
        {0, "Generic"}, {3, "Mage"}, {4, "Warrior"}, {5, "Warlock"},
        {6, "Priest"}, {7, "Druid"}, {8, "Rogue"}, {9, "Hunter"},
        {10, "Paladin"}, {11, "Shaman"}, {15, "DeathKnight"}
    };

    for (auto const& entry : _allEntries)
    {
        familyCounts[entry.SpellFamilyName]++;
    }

    std::cout << "[  INFO    ] Entries by SpellFamily:\n";
    for (auto const& [family, count] : familyCounts)
    {
        std::string name = familyNames.count(family) ? familyNames[family] : "Unknown";
        std::cout << "             " << name << " (" << family << "): " << count << "\n";
    }

    // Should have entries from multiple spell families
    EXPECT_GT(familyCounts.size(), 5u) << "Should cover multiple spell families";
}

// =============================================================================
// Data Integrity Tests
// =============================================================================

TEST_F(SpellProcDBCValidationTest, NoDuplicateSpellIds)
{
    std::set<int32_t> seenIds;
    std::vector<int32_t> duplicates;

    for (auto const& entry : _allEntries)
    {
        if (seenIds.count(entry.SpellId))
            duplicates.push_back(entry.SpellId);
        else
            seenIds.insert(entry.SpellId);
    }

    if (!duplicates.empty())
    {
        std::cout << "[  WARN    ] Duplicate SpellIds found: ";
        for (auto id : duplicates)
            std::cout << id << " ";
        std::cout << std::endl;
    }

    EXPECT_TRUE(duplicates.empty()) << "Should have no duplicate SpellIds";
}

TEST_F(SpellProcDBCValidationTest, AllEntriesHaveValidStructure)
{
    for (auto const& entry : _allEntries)
    {
        // SpellId must be non-zero
        EXPECT_NE(entry.SpellId, 0)
            << "SpellId cannot be zero";

        // If Chance is set, it should be reasonable (0-100, or 101 for 100% from DBC)
        if (entry.Chance > 0)
        {
            EXPECT_LE(entry.Chance, 101.0f)
                << "SpellId " << entry.SpellId << " has unusual Chance: " << entry.Chance;
        }

        // PPM should be reasonable (typically 0-60)
        if (entry.ProcsPerMinute > 0)
        {
            EXPECT_LE(entry.ProcsPerMinute, 60.0f)
                << "SpellId " << entry.SpellId << " has unusual PPM: " << entry.ProcsPerMinute;
        }

        // SpellPhaseMask should use valid values
        if (entry.SpellPhaseMask != 0)
        {
            // Valid phase masks: PROC_SPELL_PHASE_CAST(1), PROC_SPELL_PHASE_HIT(2), PROC_SPELL_PHASE_FINISH(4)
            EXPECT_LE(entry.SpellPhaseMask, 7u)
                << "SpellId " << entry.SpellId << " has unusual SpellPhaseMask: " << entry.SpellPhaseMask;
        }
    }
}
