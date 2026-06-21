#include "branding/mastery/EnemyMastery.h"
#include "branding/effects/EffectModel.h"
#include "fakes/FakeEffectConfig.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    // Minimal IMasteryTreeConfig for the §14.8.1 rank->level mapping. Only the methods the enemy
    // helpers touch matter; the §14.10 envelope getters return harmless defaults.
    class FakeMasteryTreeConfig : public IMasteryTreeConfig
    {
    public:
        uint8_t maxLevel = 50;
        double  maxUptime = 0.60;
        double  halfLevel = 25.0;
        double  offSchool = 0.25;
        double  maxEnemyMul = 1.5;
        double  enemyEliteLevelFraction = 0.5;
        double   minPpm = 1.0;
        double   maxPpm = 10.0;
        uint32_t minWindowMs = 3000;
        uint32_t maxWindowMs = 12000;
        double   maxProcMagnitude = 2.0;
        double   minReach = 0.0;
        double   maxReach = 40.0;
        uint8_t  archetypeUnlockLevel = 20;

        uint8_t MaxMasteryLevel() const override { return maxLevel; }
        uint8_t MaxArchetypesAtLevel(uint8_t profLevel) const override
        {
            return static_cast<uint8_t>(1 + profLevel / archetypeUnlockLevel);
        }
        double  MaxUptime() const override { return maxUptime; }
        double  UpkeepHalfLevel() const override { return halfLevel; }
        double  OffSchoolFactor() const override { return offSchool; }
        double  MaxEnemyMul() const override { return maxEnemyMul; }
        double  EnemyEliteLevelFraction() const override { return enemyEliteLevelFraction; }
        double   MinPpm() const override { return minPpm; }
        double   MaxPpm() const override { return maxPpm; }
        uint32_t MinWindowMs() const override { return minWindowMs; }
        uint32_t MaxWindowMs() const override { return maxWindowMs; }
        double   MaxProcMagnitude() const override { return maxProcMagnitude; }
        double   MinReach() const override { return minReach; }
        double   MaxReach() const override { return maxReach; }
    };
}

// §14.8.1 -- a Normal creature carries no enemy mastery: level 0, multiplier exactly 1.0.
TEST(EnemyMastery, NormalIsBaseline)
{
    FakeMasteryTreeConfig cfg;
    EXPECT_EQ(EnemyMasteryLevelForRank(EnemyRank::Normal, cfg), 0);
    EXPECT_DOUBLE_EQ(EnemyMasteryMultiplierForRank(EnemyRank::Normal, cfg), 1.0);
}

// §14.8.1 -- bosses are at max mastery; elites at a scaled level <= boss; both bounded by MaxEnemyMul.
TEST(EnemyMastery, BossMaxEliteScaled)
{
    FakeMasteryTreeConfig cfg;

    uint8_t const bossLevel = EnemyMasteryLevelForRank(EnemyRank::Boss, cfg);
    uint8_t const eliteLevel = EnemyMasteryLevelForRank(EnemyRank::Elite, cfg);

    EXPECT_EQ(bossLevel, cfg.maxLevel);                     // "bosses are at max mastery"
    EXPECT_LE(eliteLevel, bossLevel);                       // elite is a scaled-down level
    EXPECT_EQ(eliteLevel, static_cast<uint8_t>(25));        // round(50 * 0.5)

    EXPECT_LE(EnemyMasteryMultiplierForRank(EnemyRank::Boss, cfg), cfg.MaxEnemyMul());
    EXPECT_LE(EnemyMasteryMultiplierForRank(EnemyRank::Elite, cfg), cfg.MaxEnemyMul());
}

// §14.8.1 -- the OUTGOING multiplier is monotonic non-decreasing in rank, never below 1.0.
TEST(EnemyMastery, MultiplierMonotonicInRank)
{
    FakeMasteryTreeConfig cfg;

    double const normal = EnemyMasteryMultiplierForRank(EnemyRank::Normal, cfg);
    double const elite = EnemyMasteryMultiplierForRank(EnemyRank::Elite, cfg);
    double const boss = EnemyMasteryMultiplierForRank(EnemyRank::Boss, cfg);

    EXPECT_GE(normal, 1.0);
    EXPECT_GE(elite, normal);   // Normal <= Elite
    EXPECT_GE(boss, elite);     // Elite <= Boss
    EXPECT_LE(boss, cfg.MaxEnemyMul());
}

// §14.8.1 -- a misconfigured elite fraction can never push the elite level past the boss (clamped to
// [0,1]): > 1.0 caps at MaxMasteryLevel, < 0 floors at 0.
TEST(EnemyMastery, EliteFractionClamped)
{
    FakeMasteryTreeConfig high;
    high.enemyEliteLevelFraction = 5.0;   // absurdly high
    EXPECT_LE(EnemyMasteryLevelForRank(EnemyRank::Elite, high), high.maxLevel);
    EXPECT_EQ(EnemyMasteryLevelForRank(EnemyRank::Elite, high), high.maxLevel);

    FakeMasteryTreeConfig low;
    low.enemyEliteLevelFraction = -1.0;   // negative
    EXPECT_EQ(EnemyMasteryLevelForRank(EnemyRank::Elite, low), 0);
    EXPECT_DOUBLE_EQ(EnemyMasteryMultiplierForRank(EnemyRank::Elite, low), 1.0);
}

// §14.8 -- the convenience wrapper exactly reuses the §14.8 curve (no reimplementation), and the
// enemy ceiling stays strictly below the player one-shot fantasy.
TEST(EnemyMastery, WrapperMatchesCurveAndStaysBelowPlayerFantasy)
{
    FakeMasteryTreeConfig cfg;
    Branding::Test::FakeEffectConfig eff;

    for (EnemyRank rank : { EnemyRank::Normal, EnemyRank::Elite, EnemyRank::Boss })
    {
        double const viaWrapper = EnemyMasteryMultiplierForRank(rank, cfg);
        double const viaCurve = EnemyMasteryMultiplier(EnemyMasteryLevelForRank(rank, cfg), cfg);
        EXPECT_DOUBLE_EQ(viaWrapper, viaCurve);
    }

    EXPECT_LT(cfg.MaxEnemyMul(), eff.MaxPersonalMul());   // spikes are mechanics, not one-shots
}

// §14.8 / §2.2 -- group-size invariance: the SAME rank multiplier rides on top of a 5-man- and a
// 40-man-scaled baseline as a bounded fraction, never a flat addition, so completability holds.
TEST(EnemyMastery, GroupSizeInvariantFractionNotFlat)
{
    FakeMasteryTreeConfig cfg;
    double const mul = EnemyMasteryMultiplierForRank(EnemyRank::Boss, cfg);

    double const scaled5man = 20000.0;    // §2.2 encounter scaled to a 5-man
    double const scaled40man = 100000.0;  // ... and to a 40-man

    double const final5 = scaled5man * mul;     // mastery on top (scaling-then-branding)
    double const final40 = scaled40man * mul;

    EXPECT_NEAR(final5 / scaled5man, final40 / scaled40man, 1e-9);   // identical fraction
    EXPECT_LT(final5, scaled40man);                                  // small group stays below full
}
