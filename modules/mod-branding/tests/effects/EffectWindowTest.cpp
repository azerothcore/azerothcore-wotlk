#include "effects/EffectModel.h"
#include <gtest/gtest.h>

using namespace Branding;

// ProfileFor maps roles to the right effect kind (§7.9 asymmetry)
TEST(EffectWindow, ProfileForMapsRoleToKind)
{
    EXPECT_EQ(ProfileFor(BrandId::Fire, RoleContribution::Tank).kind, EffectKind::PersonalSpike);
    EXPECT_EQ(ProfileFor(BrandId::Fire, RoleContribution::Healer).kind, EffectKind::MechanicTransform);
    EXPECT_EQ(ProfileFor(BrandId::Fire, RoleContribution::Damage).kind, EffectKind::RaidWindow);
    EXPECT_EQ(ProfileFor(BrandId::Fire, RoleContribution::Tank).role, RoleContribution::Tank);
}

// Windowed profiles have a genuine duty cycle (< 1.0 uptime) and a non-zero cooldown
TEST(EffectWindow, WindowedProfilesHaveDutyCycle)
{
    EffectProfile dps = ProfileFor(BrandId::Fire, RoleContribution::Damage);
    EXPECT_GT(dps.windowDurationMs, 0u);
    EXPECT_GT(dps.cooldownMs, 0u);
    EXPECT_LT(WindowUptimeFraction(dps), 1.0);
}

// IsWindowActive cycles: active during the window phase, inactive during cooldown, then wraps
TEST(EffectWindow, IsWindowActiveCyclesWithinPeriod)
{
    EffectProfile p;
    p.kind = EffectKind::RaidWindow;
    p.windowDurationMs = 6000;
    p.cooldownMs = 18000;   // period 24000

    EXPECT_TRUE(IsWindowActive(p, 0));
    EXPECT_TRUE(IsWindowActive(p, 5999));
    EXPECT_FALSE(IsWindowActive(p, 6000));
    EXPECT_FALSE(IsWindowActive(p, 23999));
    EXPECT_TRUE(IsWindowActive(p, 24000));   // wraps to a new window (24000 % 24000 = 0)
    EXPECT_TRUE(IsWindowActive(p, 24001));   // still in the new window
    EXPECT_FALSE(IsWindowActive(p, 30000));  // 30000 % 24000 = 6000 -> cooldown
}

// MechanicTransform is structural -- always active (gated by strength, not time)
TEST(EffectWindow, MechanicTransformAlwaysActive)
{
    EffectProfile t = ProfileFor(BrandId::Nature, RoleContribution::Healer);
    EXPECT_TRUE(IsWindowActive(t, 0));
    EXPECT_TRUE(IsWindowActive(t, 999999));
}
