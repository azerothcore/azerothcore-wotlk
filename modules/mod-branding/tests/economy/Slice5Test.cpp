#include "branding/allegiance/Allegiance.h"
#include "branding/economy/Discovery.h"
#include "branding/economy/Economy.h"
#include "fakes/FakeWorldConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// --- Allegiance (§12) ---

TEST(Allegiance, MatchGivesBonusMismatchIsNeutral)
{
    FakeAllegianceConfig cfg;
    EXPECT_DOUBLE_EQ(AllegianceEfficiency(Allegiance::FireChaos, Allegiance::FireChaos, cfg), cfg.matchEfficiency);
    EXPECT_DOUBLE_EQ(AllegianceEfficiency(Allegiance::FireChaos, Allegiance::ShadowVoid, cfg), 1.0);
}

TEST(Allegiance, NeverPenalizesAndNoneIsNeutral)
{
    FakeAllegianceConfig cfg;
    EXPECT_GE(AllegianceEfficiency(Allegiance::NatureWild, Allegiance::ShadowVoid, cfg), 1.0);
    EXPECT_DOUBLE_EQ(AllegianceEfficiency(Allegiance::None, Allegiance::FireChaos, cfg), 1.0);
}

// --- Discovery tier (§8.3) ---

TEST(Discovery, TierForZoneLevelMonotonic)
{
    FakeDiscoveryConfig cfg;
    EXPECT_EQ(TierForZoneLevel(10, cfg), DiscoveryTier::Common);
    EXPECT_EQ(TierForZoneLevel(30, cfg), DiscoveryTier::Uncommon);
    EXPECT_EQ(TierForZoneLevel(50, cfg), DiscoveryTier::Rare);
    EXPECT_EQ(TierForZoneLevel(70, cfg), DiscoveryTier::Epic);

    DiscoveryTier prev = DiscoveryTier::Common;
    for (uint8_t lvl = 1; lvl <= 80; ++lvl)
    {
        DiscoveryTier t = TierForZoneLevel(lvl, cfg);
        EXPECT_GE(static_cast<uint8_t>(t), static_cast<uint8_t>(prev));
        prev = t;
    }
}

// --- Discovery XP (§8.2) ---

TEST(Discovery, RediscoveryYieldsZero)
{
    FakeDiscoveryConfig cfg;
    EXPECT_EQ(DiscoveryXp(40, 40, DiscoveryType::Hidden, false, cfg), 0u);
    EXPECT_GT(DiscoveryXp(40, 40, DiscoveryType::Hidden, true, cfg), 0u);
}

TEST(Discovery, DangerousZonePaysMore)
{
    FakeDiscoveryConfig cfg;
    uint32_t appropriate = DiscoveryXp(40, 40, DiscoveryType::Subzone, true, cfg);
    uint32_t dangerous = DiscoveryXp(40, 60, DiscoveryType::Subzone, true, cfg);   // far above player
    EXPECT_GT(dangerous, appropriate);
}

TEST(Discovery, HiddenBeatsLandmarkBeatsSubzone)
{
    FakeDiscoveryConfig cfg;
    uint32_t sub = DiscoveryXp(40, 40, DiscoveryType::Subzone, true, cfg);
    uint32_t land = DiscoveryXp(40, 40, DiscoveryType::Landmark, true, cfg);
    uint32_t hid = DiscoveryXp(40, 40, DiscoveryType::Hidden, true, cfg);
    EXPECT_LT(sub, land);
    EXPECT_LT(land, hid);
}

TEST(Discovery, ScalesWithPlayerLevel)
{
    FakeDiscoveryConfig cfg;
    uint32_t low = DiscoveryXp(20, 20, DiscoveryType::Subzone, true, cfg);
    uint32_t high = DiscoveryXp(70, 70, DiscoveryType::Subzone, true, cfg);
    EXPECT_GT(high, low);   // % of a larger level-to-next
}

// --- Economy (§8.6) ---

TEST(Economy, CraftConsumesExactInputsAndYieldsOutput)
{
    Recipe recipe{ 10, 5, 42, 100 };
    Resources have{ 30, 20 };

    EXPECT_TRUE(CanCraft(recipe, have));
    CraftResult r = ResolveCraft(recipe, have);
    EXPECT_TRUE(r.crafted);
    EXPECT_EQ(r.consumed.materials, 10u);
    EXPECT_EQ(r.consumed.fragments, 5u);
    EXPECT_EQ(r.outputItemId, 42u);
    EXPECT_EQ(r.charXp, 100u);
}

TEST(Economy, InsufficientResourcesRejectedCleanly)
{
    Recipe recipe{ 10, 5, 42, 100 };
    Resources have{ 8, 5 };   // not enough materials

    EXPECT_FALSE(CanCraft(recipe, have));
    CraftResult r = ResolveCraft(recipe, have);
    EXPECT_FALSE(r.crafted);
    EXPECT_EQ(r.consumed.materials, 0u);
    EXPECT_EQ(r.consumed.fragments, 0u);
    EXPECT_EQ(r.outputItemId, 0u);
}
