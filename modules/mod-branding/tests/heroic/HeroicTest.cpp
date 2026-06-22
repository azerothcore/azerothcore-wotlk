#include "branding/scaling/Heroic.h"
#include "fakes/FakeHeroicConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    HeroicContext Ctx(SelectedDifficulty selected, bool nativeHeroic, uint8_t maxLevel = 80)
    {
        HeroicContext c;
        c.selected = selected;
        c.nativeHeroicMap = nativeHeroic;
        c.maxLevel = maxLevel;
        return c;
    }
}

// Normal difficulty: the overlay is inert -- no stat tuning, no level override, no tier bump.
TEST(Heroic, NormalIsInert)
{
    FakeHeroicConfig cfg;
    HeroicContext const ctx = Ctx(SelectedDifficulty::Normal, false);

    EXPECT_FALSE(HeroicOverlayEngages(ctx));
    EXPECT_DOUBLE_EQ(HeroicHealthMul(ctx, cfg), 1.0);
    EXPECT_DOUBLE_EQ(HeroicDamageMul(ctx, cfg), 1.0);
    EXPECT_EQ(HeroicLevelTarget(ctx, cfg), 0);
    EXPECT_EQ(HeroicTierBonus(ctx, cfg), 0);
}

// Heroic on a map WITHOUT native heroic: the overlay engages and supplies tuning + level target.
TEST(Heroic, OverlayEngagesOnNonNativeMap)
{
    FakeHeroicConfig cfg;
    HeroicContext const ctx = Ctx(SelectedDifficulty::Heroic, false, 80);

    EXPECT_TRUE(HeroicOverlayEngages(ctx));
    EXPECT_DOUBLE_EQ(HeroicHealthMul(ctx, cfg), cfg.heroicHealthMul);
    EXPECT_DOUBLE_EQ(HeroicDamageMul(ctx, cfg), cfg.heroicDamageMul);
    EXPECT_EQ(HeroicLevelTarget(ctx, cfg), 80);
    EXPECT_EQ(HeroicTierBonus(ctx, cfg), cfg.heroicTierBonus);
}

// Native-heroic deference: the engine already tuned the content -- never double-scale stats or level.
// The reward-tier bump still applies because the run IS heroic (§2.4.2).
TEST(Heroic, DefersToNativeHeroic)
{
    FakeHeroicConfig cfg;
    HeroicContext const ctx = Ctx(SelectedDifficulty::Heroic, true, 80);

    EXPECT_FALSE(HeroicOverlayEngages(ctx));
    EXPECT_DOUBLE_EQ(HeroicHealthMul(ctx, cfg), 1.0);
    EXPECT_DOUBLE_EQ(HeroicDamageMul(ctx, cfg), 1.0);
    EXPECT_EQ(HeroicLevelTarget(ctx, cfg), 0);
    EXPECT_EQ(HeroicTierBonus(ctx, cfg), cfg.heroicTierBonus);
}

// Monotonic in difficulty: heroic encounter muls are never below normal, tier bonus never below.
TEST(Heroic, MonotonicInDifficulty)
{
    FakeHeroicConfig cfg;
    HeroicContext const normal = Ctx(SelectedDifficulty::Normal, false);
    HeroicContext const heroic = Ctx(SelectedDifficulty::Heroic, false);

    EXPECT_GE(HeroicHealthMul(heroic, cfg), HeroicHealthMul(normal, cfg));
    EXPECT_GE(HeroicDamageMul(heroic, cfg), HeroicDamageMul(normal, cfg));
    EXPECT_GE(HeroicTierBonus(heroic, cfg), HeroicTierBonus(normal, cfg));
    EXPECT_GE(HeroicHealthMul(heroic, cfg), 1.0);   // overlay only makes content harder
}
