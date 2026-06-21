#include "branding/effects/EffectModel.h"
#include "branding/effects/ItemBrand.h"
#include "fakes/FakeEffectConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    EffectProfile Profile(RoleContribution role, EffectKind kind = EffectKind::RaidWindow,
        uint32_t window = 6000, uint32_t cooldown = 18000)
    {
        EffectProfile p;
        p.kind = kind;
        p.role = role;
        p.windowDurationMs = window;
        p.cooldownMs = cooldown;
        return p;
    }

    KnowledgeState Unlocked(BrandId b)
    {
        return KnowledgeState{ static_cast<uint32_t>(1u << static_cast<int>(b)) };
    }
}

// === Effect model (§7.9) ===

// Raid multiplier is ALWAYS bounded by the cap and never below 1.0 (mandate prevention)
TEST(EffectModel, RaidMultiplierBoundedByCap)
{
    FakeEffectConfig cfg;
    EffectProfile p = Profile(RoleContribution::Damage);
    for (uint8_t lvl = 0; lvl <= cfg.maxEffectLevel; lvl += 5)
    {
        for (double w = 0.0; w <= 1.0; w += 0.1)
        {
            double m = RaidMultiplier(lvl, p, w, cfg);
            EXPECT_GE(m, 1.0);
            EXPECT_LE(m, cfg.maxRaidMul);
        }
    }
}

// Raid multiplier is non-increasing as the catalyst stacking weight shrinks (more same-role stacks)
TEST(EffectModel, RaidMultiplierNonIncreasingInStacking)
{
    FakeEffectConfig cfg;
    EffectProfile p = Profile(RoleContribution::Damage);
    double w1 = 1.0, w2 = 0.4, w3 = 0.16;     // weights for ranks 1,2,3 (decaying)
    EXPECT_GE(RaidMultiplier(cfg.maxEffectLevel, p, w1, cfg), RaidMultiplier(cfg.maxEffectLevel, p, w2, cfg));
    EXPECT_GE(RaidMultiplier(cfg.maxEffectLevel, p, w2, cfg), RaidMultiplier(cfg.maxEffectLevel, p, w3, cfg));
}

// Personal multiplier may exceed the raid cap (fantasy) but stays within the personal cap
TEST(EffectModel, PersonalCanExceedRaidCapButBoundedByPersonalCap)
{
    FakeEffectConfig cfg;
    double tankMax = PersonalMultiplier(cfg.maxEffectLevel, Profile(RoleContribution::Tank), cfg);
    EXPECT_GT(tankMax, cfg.maxRaidMul);
    EXPECT_LE(tankMax, cfg.maxPersonalMul);
}

// Tank personal magnitude is strictly larger than dps at equal level (§7.9 asymmetry)
TEST(EffectModel, TankPersonalGreaterThanDpsAtEqualLevel)
{
    FakeEffectConfig cfg;
    double tank = PersonalMultiplier(cfg.maxEffectLevel, Profile(RoleContribution::Tank), cfg);
    double dps = PersonalMultiplier(cfg.maxEffectLevel, Profile(RoleContribution::Damage), cfg);
    EXPECT_GT(tank, dps);
}

// Windowed effects have no passive uptime
TEST(EffectModel, WindowedUptimeBelowOne)
{
    EffectProfile p = Profile(RoleContribution::Damage, EffectKind::RaidWindow, 6000, 18000);
    double uptime = WindowUptimeFraction(p);
    EXPECT_GT(uptime, 0.0);
    EXPECT_LT(uptime, 1.0);
    EXPECT_DOUBLE_EQ(uptime, 6000.0 / 24000.0);
}

// Prestige fires only at max proficiency
TEST(EffectModel, PrestigeAtMaxLevel)
{
    FakeEffectConfig cfg;
    EXPECT_FALSE(IsPrestige(static_cast<uint8_t>(cfg.maxEffectLevel - 1), cfg));
    EXPECT_TRUE(IsPrestige(cfg.maxEffectLevel, cfg));
}

// === Item branding (§7.9) ===

TEST(ItemBrand, IntensityMonotonicInProgression)
{
    FakeItemBrandConfig cfg;
    ItemBrandState a{ BrandId::Fire, 0, 0, 0 };
    ItemBrandState b{ BrandId::Fire, 0, 3, 0 };
    ItemBrandState c{ BrandId::Fire, 2, 0, 0 };
    EXPECT_LT(ItemEffectIntensity(a, cfg), ItemEffectIntensity(b, cfg));
    EXPECT_LT(ItemEffectIntensity(b, cfg), ItemEffectIntensity(c, cfg));
}

TEST(ItemBrand, UpgradeAdvancesLevelsAndStepsThenCaps)
{
    FakeItemBrandConfig cfg;
    ItemBrandState s{ BrandId::Fire, 0, 0, 0 };

    ItemUpgradeResult r1 = ApplyItemUpgrade(s, 10 * cfg.upgradeCostPerLevel, cfg);   // buy 10 levels
    EXPECT_EQ(r1.levelsGained, 10);
    EXPECT_EQ(s.step, 1);            // 10 levels = 1 step (8) + 2
    EXPECT_EQ(s.levelInStep, 2);

    ApplyItemUpgrade(s, 100000, cfg);                                                // overshoot
    EXPECT_EQ(s.step, cfg.maxStep);  // capped at the max state
    EXPECT_EQ(s.levelInStep, cfg.levelsPerStep);
}

TEST(ItemBrand, MaxCumulativeCostCheaperThanAccountKnowledge)
{
    FakeItemBrandConfig cfg;
    EXPECT_LT(ItemMaxCumulativeCost(cfg), cfg.accountKnowledgeCost);   // item branding is easier
}

// Anti-P2W: a maxed branded item is inert on an account that cannot express the brand
TEST(ItemBrand, TradedMaxedItemInertWithoutAccess)
{
    FakeItemBrandConfig cfg;
    ItemBrandState maxed{ BrandId::Fire, cfg.maxStep, cfg.levelsPerStep, 0 };
    EXPECT_GT(ResolvedItemEffectIntensity(maxed, true, cfg), 0.0);
    EXPECT_DOUBLE_EQ(ResolvedItemEffectIntensity(maxed, false, cfg), 0.0);
}

// === Loadout (§7.9) ===

TEST(ItemBrand, LoadoutValidWhenUnlockedAndArchetypeInRange)
{
    FakeItemBrandConfig cfg;
    KnowledgeState fire = Unlocked(BrandId::Fire);

    EXPECT_TRUE(IsLoadoutValid(BrandLoadout{ BrandId::Fire, 0 }, fire, 0, cfg));   // 1 archetype at lvl 0
    EXPECT_TRUE(IsLoadoutValid(BrandLoadout{ BrandId::Fire, 4 }, fire, 50, cfg));  // 6 archetypes at lvl 50
}

TEST(ItemBrand, LoadoutInvalidWhenBrandLockedOrArchetypeOutOfRange)
{
    FakeItemBrandConfig cfg;
    KnowledgeState fire = Unlocked(BrandId::Fire);

    EXPECT_FALSE(IsLoadoutValid(BrandLoadout{ BrandId::Shadow, 0 }, fire, 50, cfg));  // brand locked
    EXPECT_FALSE(IsLoadoutValid(BrandLoadout{ BrandId::Fire, 5 }, fire, 0, cfg));     // only 1 archetype at lvl 0
}
