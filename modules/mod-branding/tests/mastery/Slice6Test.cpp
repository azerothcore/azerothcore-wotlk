#include "mastery/Mastery.h"
#include "vault/Vault.h"
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
        uint8_t MaxMasteryLevel() const override { return maxLevel; }
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
