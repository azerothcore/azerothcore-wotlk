#include "branding/effects/EffectModel.h"
#include "fakes/FakeEffectConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// === §7.11 Leveling-scoped branding (issue #77) ===
//
// A sub-max character expresses a SEPARATE, account-keyed branding budget in dungeons and active
// invasions, capped by MaxLevelingMul and forced to 1.0 at max level so the §7.9 earned-proficiency
// dual-key and the §1 anti-P2W rule stay untouched.

namespace
{
    AccountBrandStanding Standing(uint8_t maxedBrands, uint8_t knowledgeTier = 0)
    {
        return AccountBrandStanding{ maxedBrands, knowledgeTier };
    }
}

// The leveling multiplier is ALWAYS bounded by its own cap and never below 1.0, for every in-range
// level, both contexts, and every account standing.
TEST(LevelingScoped, MultiplierBoundedByCap)
{
    FakeEffectConfig cfg;
    for (LevelingContext ctx : { LevelingContext::Dungeon, LevelingContext::Invasion })
    {
        for (uint8_t lvl = 1; lvl < cfg.maxCharacterLevel; lvl += 7)
        {
            for (uint8_t maxed = 0; maxed <= 32; ++maxed)
            {
                double m = LevelingMultiplier(lvl, ctx, Standing(maxed), cfg);
                EXPECT_GE(m, 1.0);
                EXPECT_LE(m, cfg.maxLevelingMul);
            }
        }
    }
}

// The hard boundary at ding-to-cap: at (and above) max level the leveling budget is exactly 1.0 --
// only the §7.9 earned-proficiency path can produce a multiplier at endgame.
TEST(LevelingScoped, OneAtAndAboveMaxLevel)
{
    FakeEffectConfig cfg;
    EXPECT_DOUBLE_EQ(1.0, LevelingMultiplier(cfg.maxCharacterLevel, LevelingContext::Dungeon, Standing(8), cfg));
    EXPECT_DOUBLE_EQ(1.0, LevelingMultiplier(cfg.maxCharacterLevel, LevelingContext::Invasion, Standing(8), cfg));
    EXPECT_DOUBLE_EQ(1.0, LevelingMultiplier(static_cast<uint8_t>(cfg.maxCharacterLevel + 5),
        LevelingContext::Dungeon, Standing(32), cfg));
    // Just below the cap, a well-standing account DOES get a budget.
    EXPECT_GT(LevelingMultiplier(static_cast<uint8_t>(cfg.maxCharacterLevel - 1),
        LevelingContext::Dungeon, Standing(8), cfg), 1.0);
}

// Inert outside a dungeon/invasion: no open-world leveling buff.
TEST(LevelingScoped, InertOutsideContext)
{
    FakeEffectConfig cfg;
    for (uint8_t lvl = 1; lvl < cfg.maxCharacterLevel; lvl += 10)
        EXPECT_DOUBLE_EQ(1.0, LevelingMultiplier(lvl, LevelingContext::None, Standing(32), cfg));
}

// Fully disabled by config (servers can switch the behaviour off).
TEST(LevelingScoped, InertWhenDisabled)
{
    FakeEffectConfig cfg;
    cfg.levelingEnabled = false;
    EXPECT_DOUBLE_EQ(1.0, LevelingMultiplier(20, LevelingContext::Dungeon, Standing(32), cfg));
    EXPECT_DOUBLE_EQ(1.0, LevelingMultiplier(20, LevelingContext::Invasion, Standing(32), cfg));
}

// Mild scaling: monotonically non-decreasing in the account's maxed-brand count (but bounded).
TEST(LevelingScoped, MonotonicNonDecreasingInMaxedBrands)
{
    FakeEffectConfig cfg;
    double prev = 0.0;
    for (uint8_t maxed = 0; maxed <= 32; ++maxed)
    {
        double m = LevelingMultiplier(20, LevelingContext::Dungeon, Standing(maxed), cfg);
        EXPECT_GE(m, prev);
        prev = m;
    }
}

// Anti-P2W parity with §1: a traded/purchased max-level shell gains NOTHING from §7.11, regardless of
// how much account standing the buyer's account has -- the budget is 1.0 at cap.
TEST(LevelingScoped, TradedShellInertAtCap)
{
    FakeEffectConfig cfg;
    for (uint8_t maxed = 0; maxed <= 32; ++maxed)
        EXPECT_DOUBLE_EQ(1.0, LevelingMultiplier(cfg.maxCharacterLevel, LevelingContext::Dungeon, Standing(maxed), cfg));
}

// Group-bounded: there is no per-capita stacking input in the model -- even an extreme standing stays
// capped, so N branders in a group cannot multiply into a degenerate one-shot.
TEST(LevelingScoped, GroupBoundedNoPerCapitaStacking)
{
    FakeEffectConfig cfg;
    double solo = LevelingMultiplier(20, LevelingContext::Dungeon, Standing(4), cfg);
    double maxed = LevelingMultiplier(20, LevelingContext::Dungeon, Standing(255), cfg);
    EXPECT_LE(solo, cfg.maxLevelingMul);
    EXPECT_LE(maxed, cfg.maxLevelingMul);
    EXPECT_DOUBLE_EQ(cfg.maxLevelingMul, maxed);   // saturates AT the cap, never past it
}

// Transforms are granted while leveling in BOTH contexts (the druid-tank-nature-healing fantasy is a
// MechanicTransform), and never outside a context; config can switch them off.
TEST(LevelingScoped, GrantsTransformsInBothContexts)
{
    FakeEffectConfig cfg;
    EXPECT_TRUE(LevelingGrantsTransforms(LevelingContext::Dungeon, cfg));
    EXPECT_TRUE(LevelingGrantsTransforms(LevelingContext::Invasion, cfg));
    EXPECT_FALSE(LevelingGrantsTransforms(LevelingContext::None, cfg));

    cfg.levelingGrantsTransforms = false;
    EXPECT_FALSE(LevelingGrantsTransforms(LevelingContext::Dungeon, cfg));
}
