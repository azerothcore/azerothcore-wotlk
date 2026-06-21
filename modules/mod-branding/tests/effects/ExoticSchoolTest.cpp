#include "branding/effects/EffectModel.h"
#include "branding/effects/ItemBrand.h"
#include "branding/proficiency/Knowledge.h"
#include "fakes/FakeEffectConfig.h"
#include <gtest/gtest.h>
#include <set>

using namespace Branding;
using namespace Branding::Test;

// §7.10 exotic schools. These tests are brand-AGNOSTIC: they sweep every BrandId in [0, COUNT) so the
// §7.9 effect-model and §7 knowledge invariants are guaranteed to hold uniformly for the classic seven
// AND the exotic additions (and for any future brand). The four exotic ids are also asserted to exist,
// be distinct, and live below COUNT.

namespace
{
    constexpr uint8_t kBrandCount = static_cast<uint8_t>(BrandId::COUNT);

    KnowledgeState Unlocked(BrandId b)
    {
        return KnowledgeState{ static_cast<uint32_t>(1u << static_cast<int>(b)) };
    }
}

// The v1 exotic schools (§7.10) exist, are distinct, and are valid enum members below COUNT.
TEST(ExoticSchool, V1SchoolsExistDistinctAndInRange)
{
    BrandId const exotic[] = { BrandId::Wind, BrandId::Lightning, BrandId::Blood, BrandId::Void };
    for (BrandId b : exotic)
        EXPECT_LT(static_cast<uint8_t>(b), kBrandCount);

    std::set<uint8_t> ids;
    for (BrandId b : exotic)
        ids.insert(static_cast<uint8_t>(b));
    EXPECT_EQ(ids.size(), 4u) << "exotic school ids must be distinct";
}

// ProfileFor resolves the role-correct EffectKind for EVERY brand (§7.9 / §7.10 invariant).
TEST(ExoticSchool, ProfileForRoleKindUniformAcrossAllBrands)
{
    for (uint8_t i = 0; i < kBrandCount; ++i)
    {
        BrandId const brand = static_cast<BrandId>(i);
        EXPECT_EQ(ProfileFor(brand, RoleContribution::Tank).kind, EffectKind::PersonalSpike);
        EXPECT_EQ(ProfileFor(brand, RoleContribution::Healer).kind, EffectKind::MechanicTransform);
        EXPECT_EQ(ProfileFor(brand, RoleContribution::Damage).kind, EffectKind::RaidWindow);
        EXPECT_EQ(ProfileFor(brand, RoleContribution::Support).kind, EffectKind::RaidWindow);
        EXPECT_EQ(ProfileFor(brand, RoleContribution::Control).kind, EffectKind::RaidWindow);
    }
}

// Windowed (non-transform) profiles never have passive uptime, for every brand (§7.9).
TEST(ExoticSchool, WindowedProfilesHaveNoPassiveUptimeAcrossAllBrands)
{
    for (uint8_t i = 0; i < kBrandCount; ++i)
    {
        BrandId const brand = static_cast<BrandId>(i);
        for (RoleContribution role : { RoleContribution::Tank, RoleContribution::Damage,
                                       RoleContribution::Support, RoleContribution::Control })
        {
            double const uptime = WindowUptimeFraction(ProfileFor(brand, role));
            EXPECT_GT(uptime, 0.0);
            EXPECT_LT(uptime, 1.0);
        }
    }
}

// §7.9 magnitude invariants hold for every brand: raid bounded by cap, tank personal > dps personal.
TEST(ExoticSchool, MagnitudeInvariantsUniformAcrossAllBrands)
{
    FakeEffectConfig cfg;
    for (uint8_t i = 0; i < kBrandCount; ++i)
    {
        BrandId const brand = static_cast<BrandId>(i);
        EffectProfile const dps = ProfileFor(brand, RoleContribution::Damage);
        for (double w = 0.0; w <= 1.0; w += 0.25)
        {
            double const m = RaidMultiplier(cfg.maxEffectLevel, dps, w, cfg);
            EXPECT_GE(m, 1.0);
            EXPECT_LE(m, cfg.maxRaidMul);
        }

        double const tank = PersonalMultiplier(cfg.maxEffectLevel, ProfileFor(brand, RoleContribution::Tank), cfg);
        double const dpsP = PersonalMultiplier(cfg.maxEffectLevel, dps, cfg);
        EXPECT_GT(tank, dpsP) << "tank branding must be more dramatic than dps for brand " << uint32_t(i);
    }
}

// Knowledge gating is uniform: exotic brands unlock, gate earning, and gate expression like any brand.
TEST(ExoticSchool, KnowledgeGatingUniformForExoticSchools)
{
    for (BrandId b : { BrandId::Wind, BrandId::Lightning, BrandId::Blood, BrandId::Void })
    {
        KnowledgeState none{ 0 };
        EXPECT_FALSE(CanEarnProficiency(b, none));
        EXPECT_FALSE(CanExpressBrand(b, none));

        KnowledgeState k{ 0 };
        EXPECT_TRUE(UnlockBrand(b, k));
        EXPECT_TRUE(CanEarnProficiency(b, k));
        EXPECT_TRUE(CanExpressBrand(b, k));
    }
}

// Loadout validation treats an exotic brand exactly like a classic one (§7.9 player agency layer).
TEST(ExoticSchool, LoadoutValidationUniformForExoticSchools)
{
    FakeItemBrandConfig cfg;
    for (BrandId b : { BrandId::Wind, BrandId::Lightning, BrandId::Blood, BrandId::Void })
    {
        KnowledgeState const unlocked = Unlocked(b);
        EXPECT_TRUE(IsLoadoutValid(BrandLoadout{ b, 0 }, unlocked, 0, cfg));   // 1 archetype at lvl 0

        KnowledgeState const locked{ 0 };
        EXPECT_FALSE(IsLoadoutValid(BrandLoadout{ b, 0 }, locked, 50, cfg));   // brand locked
    }
}
