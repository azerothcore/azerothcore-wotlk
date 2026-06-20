#include "contribution/AccountCeiling.h"
#include "fakes/FakeClock.h"
#include "fakes/FakeContributionConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// A grant within the remaining ceiling passes through unchanged
TEST(AccountCeiling, GrantWithinCeilingPassesThrough)
{
    FakeContributionConfig cfg;          // mats 1000, currency 500
    FakeClock clock(1000);
    AccountEconomyState acc;

    RewardGrant out = ClampToAccountCeiling(RewardGrant{ 100, 50 }, acc, cfg, clock);
    EXPECT_EQ(out.materials, 100u);
    EXPECT_EQ(out.currency, 50u);
}

// §9.3#5 / §10 charter: across alts sharing an account, total economy output is bounded by the ceiling
TEST(AccountCeiling, EconomyOutput_AccountCeiling_Bounded)
{
    FakeContributionConfig cfg;          // mats ceiling 1000
    FakeClock clock(1000);
    AccountEconomyState acc;             // shared across the "alt army"

    uint32_t totalMats = 0;
    for (int alt = 0; alt < 5; ++alt)    // each alt tries to bank 400 mats
        totalMats += ClampToAccountCeiling(RewardGrant{ 400, 0 }, acc, cfg, clock).materials;

    EXPECT_EQ(totalMats, cfg.accountMaterialsCeiling);    // 1000, not 2000
    EXPECT_LE(acc.materialsThisPeriod, cfg.accountMaterialsCeiling);
}

// Once the ceiling is hit, further grants in the period yield nothing
TEST(AccountCeiling, GrantBeyondCeilingClampedToZero)
{
    FakeContributionConfig cfg;
    FakeClock clock(1000);
    AccountEconomyState acc;

    ClampToAccountCeiling(RewardGrant{ 1000, 500 }, acc, cfg, clock);   // exactly fills both
    RewardGrant out = ClampToAccountCeiling(RewardGrant{ 100, 100 }, acc, cfg, clock);
    EXPECT_EQ(out.materials, 0u);
    EXPECT_EQ(out.currency, 0u);
}

// The ceiling refreshes on the period boundary
TEST(AccountCeiling, CeilingResetsAfterPeriod)
{
    FakeContributionConfig cfg;
    FakeClock clock(1000);
    AccountEconomyState acc;

    ClampToAccountCeiling(RewardGrant{ 1000, 0 }, acc, cfg, clock);     // fill mats
    EXPECT_EQ(ClampToAccountCeiling(RewardGrant{ 100, 0 }, acc, cfg, clock).materials, 0u);

    clock.Advance(86400);                                              // a period passes
    EXPECT_EQ(ClampToAccountCeiling(RewardGrant{ 100, 0 }, acc, cfg, clock).materials, 100u);
}
