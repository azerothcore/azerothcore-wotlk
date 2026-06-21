#include "branding/mastery/Mastery.h"
#include "branding/vault/Vault.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    class FakeVaultConfig : public IVaultConfig
    {
    public:
        uint32_t capacity = 100;
        uint32_t baseCost = 10;
        uint32_t perUnit = 2;
        uint32_t Capacity() const override { return capacity; }
        uint32_t TransferBaseCost() const override { return baseCost; }
        uint32_t TransferCostPerUnit() const override { return perUnit; }
    };

    class FakeMasteryConfig : public IMasteryConfig
    {
    public:
        uint8_t maxLevel = 50;
        double maxBonus = 0.20;
        uint8_t MaxMasteryLevel() const override { return maxLevel; }
        double MaxBonus() const override { return maxBonus; }
    };
}

// --- Vault (§13) ---

TEST(Vault, TransferHasFrictionAndScales)
{
    FakeVaultConfig cfg;
    EXPECT_EQ(VaultTransferCost(0, cfg), 0u);            // nothing to move, no cost
    EXPECT_GE(VaultTransferCost(1, cfg), cfg.baseCost);  // even one unit carries base friction
    EXPECT_GT(VaultTransferCost(20, cfg), VaultTransferCost(10, cfg));  // monotonic in quantity
    EXPECT_EQ(VaultTransferCost(10, cfg), cfg.baseCost + cfg.perUnit * 10);
}

TEST(Vault, CapacityRespected)
{
    FakeVaultConfig cfg;                                 // capacity 100
    EXPECT_TRUE(VaultCanStore(0, 50, cfg));
    EXPECT_TRUE(VaultCanStore(50, 50, cfg));
    EXPECT_FALSE(VaultCanStore(90, 20, cfg));
    EXPECT_FALSE(VaultCanStore(100, 1, cfg));
}

// --- Mastery dual-key (§14) ---

TEST(Mastery, AccountUnlockAloneIsInert)
{
    FakeMasteryConfig cfg;
    // account unlocked but character has earned nothing -> still 0 (must earn the skill)
    EXPECT_DOUBLE_EQ(MasteryEffectiveness(true, 0, cfg), 0.0);
}

TEST(Mastery, CharacterSkillWithoutAccountUnlockIsInert)
{
    FakeMasteryConfig cfg;
    // max character level but account never unlocked the system -> inert (anti-P2W dual-key)
    EXPECT_DOUBLE_EQ(MasteryEffectiveness(false, cfg.maxLevel, cfg), 0.0);
}

TEST(Mastery, BothKeysScaleEffectiveness)
{
    FakeMasteryConfig cfg;
    EXPECT_DOUBLE_EQ(MasteryEffectiveness(true, cfg.maxLevel, cfg), 1.0);
    EXPECT_GT(MasteryEffectiveness(true, cfg.maxLevel, cfg), MasteryEffectiveness(true, 10, cfg));

    double prev = -1.0;
    for (uint8_t lvl = 0; lvl <= cfg.maxLevel; ++lvl)
    {
        double e = MasteryEffectiveness(true, lvl, cfg);
        EXPECT_GE(e, 0.0);
        EXPECT_LE(e, 1.0);
        EXPECT_GE(e, prev);
        prev = e;
    }
}

// --- Mastery consumer bonus (§14, the observable gathering/craft efficiency value) ---

TEST(Mastery, BonusIsZeroUnlessBothKeysPresent)
{
    FakeMasteryConfig cfg;
    EXPECT_DOUBLE_EQ(MasteryBonus(true, 0, cfg), 0.0);            // unlocked, no skill -> no bonus
    EXPECT_DOUBLE_EQ(MasteryBonus(false, cfg.maxLevel, cfg), 0.0); // skill, no unlock -> no bonus
}

TEST(Mastery, BonusScalesToMaxAtFullEffectiveness)
{
    FakeMasteryConfig cfg;
    EXPECT_DOUBLE_EQ(MasteryBonus(true, cfg.maxLevel, cfg), cfg.maxBonus);  // full key -> full bonus
    EXPECT_GT(MasteryBonus(true, cfg.maxLevel, cfg), MasteryBonus(true, 10, cfg));
}

TEST(Mastery, BonusIsBoundedAndMonotonic)
{
    FakeMasteryConfig cfg;
    double prev = -1.0;
    for (uint8_t lvl = 0; lvl <= cfg.maxLevel; ++lvl)
    {
        double b = MasteryBonus(true, lvl, cfg);
        EXPECT_GE(b, 0.0);
        EXPECT_LE(b, cfg.maxBonus);
        EXPECT_GE(b, prev);
        prev = b;
    }
    // Equals MaxBonus weighted by effectiveness (linear consumer mapping).
    EXPECT_DOUBLE_EQ(MasteryBonus(true, 25, cfg), cfg.maxBonus * MasteryEffectiveness(true, 25, cfg));
}

TEST(Mastery, ZeroMaxBonusYieldsNoEffect)
{
    FakeMasteryConfig cfg;
    cfg.maxBonus = 0.0;
    EXPECT_DOUBLE_EQ(MasteryBonus(true, cfg.maxLevel, cfg), 0.0);
}

TEST(Mastery, SystemListIsDefined)
{
    // 1-2 concrete masteries defined (§14 scope): at least Gathering + Crafting.
    EXPECT_GE(static_cast<uint8_t>(MasterySystem::COUNT), 2);
    EXPECT_EQ(static_cast<uint8_t>(MasterySystem::Gathering), 0);
    EXPECT_EQ(static_cast<uint8_t>(MasterySystem::Crafting), 1);
}
