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
}

// --- Deposit planner (§13): combines capacity + transfer-cost + affordability into one decision. ---

TEST(VaultDeposit, RejectsZeroQuantity)
{
    FakeVaultConfig cfg;
    VaultDepositPlan const plan = PlanDeposit(0, 0, 1000, cfg);
    EXPECT_FALSE(plan.allowed);
    EXPECT_EQ(plan.reason, VaultDepositReason::EmptyQuantity);
    EXPECT_EQ(plan.cost, 0u);
}

TEST(VaultDeposit, RejectsWhenOverCapacity)
{
    FakeVaultConfig cfg;                                  // capacity 100
    VaultDepositPlan const plan = PlanDeposit(90, 20, 100000, cfg);
    EXPECT_FALSE(plan.allowed);
    EXPECT_EQ(plan.reason, VaultDepositReason::CapacityExceeded);
}

TEST(VaultDeposit, RejectsWhenCannotAfford)
{
    FakeVaultConfig cfg;                                  // cost = 10 + 2*10 = 30
    VaultDepositPlan const plan = PlanDeposit(0, 10, 29, cfg);
    EXPECT_FALSE(plan.allowed);
    EXPECT_EQ(plan.reason, VaultDepositReason::InsufficientFunds);
    EXPECT_EQ(plan.cost, 30u);                            // cost still reported so the UI can show it
}

TEST(VaultDeposit, AllowsWhenFitsAndAffordable)
{
    FakeVaultConfig cfg;                                  // cost = 10 + 2*10 = 30
    VaultDepositPlan const plan = PlanDeposit(50, 10, 30, cfg);
    EXPECT_TRUE(plan.allowed);
    EXPECT_EQ(plan.reason, VaultDepositReason::Ok);
    EXPECT_EQ(plan.cost, 30u);
}

TEST(VaultDeposit, ExactCapacityBoundaryAllowed)
{
    FakeVaultConfig cfg;                                  // capacity 100
    VaultDepositPlan const plan = PlanDeposit(50, 50, 100000, cfg);
    EXPECT_TRUE(plan.allowed);
    EXPECT_EQ(plan.reason, VaultDepositReason::Ok);
}

// --- Withdraw planner (§13): bounded by what is actually stored; withdrawal is free. ---

TEST(VaultWithdraw, RejectsMoreThanStored)
{
    VaultWithdrawPlan const plan = PlanWithdraw(5, 10);
    EXPECT_FALSE(plan.allowed);
    EXPECT_EQ(plan.amount, 0u);
}

TEST(VaultWithdraw, RejectsZeroQuantity)
{
    VaultWithdrawPlan const plan = PlanWithdraw(5, 0);
    EXPECT_FALSE(plan.allowed);
}

TEST(VaultWithdraw, AllowsUpToStored)
{
    VaultWithdrawPlan const plan = PlanWithdraw(10, 10);
    EXPECT_TRUE(plan.allowed);
    EXPECT_EQ(plan.amount, 10u);
}

TEST(VaultWithdraw, AllowsPartial)
{
    VaultWithdrawPlan const plan = PlanWithdraw(10, 3);
    EXPECT_TRUE(plan.allowed);
    EXPECT_EQ(plan.amount, 3u);
}
