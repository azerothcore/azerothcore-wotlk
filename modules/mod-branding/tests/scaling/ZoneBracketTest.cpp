#include "branding/scaling/ZoneBracket.h"
#include <gtest/gtest.h>

using namespace Branding;

// A configured zone returns its target level; the fallback (area_level) is ignored.
TEST(ZoneBracket, ConfiguredZoneOverridesFallback)
{
    ZoneBracketTable table;
    table.Set(/*zoneId*/ 2717, /*targetLevel*/ 60); // Molten Core -> level 60 bracket

    EXPECT_EQ(table.ResolveTargetLevel(2717, /*fallbackAreaLevel*/ 80), 60);
}

// An unconfigured zone falls back to the supplied area_level (current v1 behaviour).
TEST(ZoneBracket, UnconfiguredZoneFallsBackToAreaLevel)
{
    ZoneBracketTable table;
    EXPECT_EQ(table.ResolveTargetLevel(/*zoneId*/ 1519, /*fallbackAreaLevel*/ 80), 80);
}

// A target level of 0 means "no defined bracket": resolve still returns 0 so the caller
// (the adapter) treats it as no-scaling, matching the area_level <= 0 guard.
TEST(ZoneBracket, ZeroFallbackResolvesToZero)
{
    ZoneBracketTable table;
    EXPECT_EQ(table.ResolveTargetLevel(/*zoneId*/ 1, /*fallbackAreaLevel*/ 0), 0);
}

// Has() reports configured rows; absent zones are not configured.
TEST(ZoneBracket, HasReportsConfiguredRows)
{
    ZoneBracketTable table;
    table.Set(2717, 60);

    EXPECT_TRUE(table.Has(2717));
    EXPECT_FALSE(table.Has(1519));
}

// Re-setting a zone overwrites the previous target (last write wins, idempotent load).
TEST(ZoneBracket, SetOverwritesExistingRow)
{
    ZoneBracketTable table;
    table.Set(2717, 60);
    table.Set(2717, 70);

    EXPECT_EQ(table.ResolveTargetLevel(2717, 80), 70);
}

// Clear() empties the table (reload safety): all zones revert to fallback.
TEST(ZoneBracket, ClearRevertsToFallback)
{
    ZoneBracketTable table;
    table.Set(2717, 60);
    table.Clear();

    EXPECT_FALSE(table.Has(2717));
    EXPECT_EQ(table.ResolveTargetLevel(2717, 80), 80);
    EXPECT_EQ(table.Size(), 0u);
}

// Size() tracks the number of distinct configured zones.
TEST(ZoneBracket, SizeTracksDistinctZones)
{
    ZoneBracketTable table;
    table.Set(2717, 60);
    table.Set(1519, 70);
    table.Set(2717, 55); // overwrite, not a new zone

    EXPECT_EQ(table.Size(), 2u);
}
