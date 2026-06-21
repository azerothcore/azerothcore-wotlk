#include "branding/allegiance/Allegiance.h"
#include "branding/common/Brand.h"
#include "branding/contribution/ContributionTypes.h"
#include "fakes/FakeWorldConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// --- Allegiance selection parsing/validation (§12 adapter support) ---

TEST(AllegianceSelection, ParsesValidIds)
{
    Allegiance out = Allegiance::None;

    EXPECT_TRUE(ParseAllegiance(1, out));
    EXPECT_EQ(out, Allegiance::FireChaos);

    EXPECT_TRUE(ParseAllegiance(4, out));
    EXPECT_EQ(out, Allegiance::TitanOrder);
}

TEST(AllegianceSelection, RejectsNoneAndOutOfRange)
{
    Allegiance out = Allegiance::FireChaos;   // sentinel: must be left untouched on failure

    // 0 == None is not a selectable allegiance (selection must commit to a real side).
    EXPECT_FALSE(ParseAllegiance(0, out));
    EXPECT_EQ(out, Allegiance::FireChaos);

    // COUNT and anything at/above it is out of range.
    EXPECT_FALSE(ParseAllegiance(static_cast<uint32_t>(Allegiance::COUNT), out));
    EXPECT_FALSE(ParseAllegiance(999, out));
    EXPECT_EQ(out, Allegiance::FireChaos);
}

TEST(AllegianceSelection, RoundTripsEveryRealAllegiance)
{
    for (uint8_t id = 1; id < static_cast<uint8_t>(Allegiance::COUNT); ++id)
    {
        Allegiance out = Allegiance::None;
        EXPECT_TRUE(ParseAllegiance(id, out));
        EXPECT_EQ(static_cast<uint8_t>(out), id);
    }
}

// --- Brand -> Allegiance bridge (maps content brand to its ideological alignment for the apply point) ---

TEST(AllegianceBridge, MapsKnownBrandsToAllegiances)
{
    EXPECT_EQ(BrandAlignment(BrandId::Fire), Allegiance::FireChaos);
    EXPECT_EQ(BrandAlignment(BrandId::Nature), Allegiance::NatureWild);
    EXPECT_EQ(BrandAlignment(BrandId::Shadow), Allegiance::ShadowVoid);
    EXPECT_EQ(BrandAlignment(BrandId::Arcane), Allegiance::TitanOrder);
}

TEST(AllegianceBridge, UnalignedBrandsAreNeutralAndEveryBrandIsTotal)
{
    // Brands without an ideological side map to None -> always a neutral 1.0 efficiency.
    FakeAllegianceConfig cfg;
    for (uint8_t b = 0; b < static_cast<uint8_t>(BrandId::COUNT); ++b)
    {
        Allegiance const a = BrandAlignment(static_cast<BrandId>(b));
        EXPECT_LT(static_cast<uint8_t>(a), static_cast<uint8_t>(Allegiance::COUNT));
        if (a == Allegiance::None)
        {
            EXPECT_DOUBLE_EQ(AllegianceEfficiency(Allegiance::FireChaos, a, cfg), 1.0);
        }
    }
}

// --- Event -> Allegiance bridge (aligns a public event's reward to an ideology for the apply point) ---

TEST(AllegianceBridge, MapsEventTypesToAllegiances)
{
    EXPECT_EQ(EventAlignment(EventType::Invasion), Allegiance::FireChaos);
    EXPECT_EQ(EventAlignment(EventType::ResourceSurge), Allegiance::NatureWild);
    EXPECT_EQ(EventAlignment(EventType::EliteHunt), Allegiance::ShadowVoid);
    EXPECT_EQ(EventAlignment(EventType::ProfessionAnomaly), Allegiance::TitanOrder);
}

TEST(AllegianceBridge, EventApplyPointBonusOnMatchNeutralOtherwise)
{
    FakeAllegianceConfig cfg;
    // An Invasion (Fire/Chaos) rewards a Fire/Chaos player and is neutral for everyone else.
    Allegiance const content = EventAlignment(EventType::Invasion);
    EXPECT_DOUBLE_EQ(AllegianceEfficiency(Allegiance::FireChaos, content, cfg), cfg.matchEfficiency);
    EXPECT_DOUBLE_EQ(AllegianceEfficiency(Allegiance::ShadowVoid, content, cfg), 1.0);
    EXPECT_DOUBLE_EQ(AllegianceEfficiency(Allegiance::None, content, cfg), 1.0);
}

// --- Efficiency never penalizes regardless of selection (defense-in-depth for the application point) ---

TEST(AllegianceSelection, EfficiencyAlwaysAtLeastNeutral)
{
    FakeAllegianceConfig cfg;
    for (uint8_t p = 0; p < static_cast<uint8_t>(Allegiance::COUNT); ++p)
        for (uint8_t c = 0; c < static_cast<uint8_t>(Allegiance::COUNT); ++c)
            EXPECT_GE(AllegianceEfficiency(static_cast<Allegiance>(p), static_cast<Allegiance>(c), cfg), 1.0);
}
