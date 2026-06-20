#include "scaling/Scaling.h"
#include "fakes/FakeScalingConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    ScalingContext Zone(uint8_t playerLevel, uint8_t zoneTarget)
    {
        ScalingContext ctx;
        ctx.playerLevel = playerLevel;
        ctx.zoneTargetLevel = zoneTarget;
        return ctx;
    }
}

// Event scaling overrides zone scaling (§2.1)
TEST(Scaling, EventTargetOverridesZoneTarget)
{
    ScalingContext ctx = Zone(80, 60);
    EXPECT_EQ(EffectiveTargetLevel(ctx), 60);

    ctx.inEvent = true;
    ctx.eventTargetLevel = 20;
    EXPECT_EQ(EffectiveTargetLevel(ctx), 20);
}

// Downward only: a player at or below the target level is never scaled up
TEST(Scaling, DownwardOnlyNeverScalesUp)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(ScalingFactor(20, 60, cfg), 1.0);   // low player, high zone -> no change
    EXPECT_DOUBLE_EQ(ScalingFactor(60, 60, cfg), 1.0);   // equal -> no change
    EXPECT_LT(ScalingFactor(80, 60, cfg), 1.0);          // high player, low zone -> scaled down
}

// Bigger level gap => stronger downscaling (monotonic)
TEST(Scaling, MoreGapMeansMoreDownscaling)
{
    FakeScalingConfig cfg;
    double const to60 = ScalingFactor(80, 60, cfg);
    double const to40 = ScalingFactor(80, 40, cfg);
    double const to20 = ScalingFactor(80, 20, cfg);
    EXPECT_LT(to40, to60);
    EXPECT_LT(to20, to40);
    EXPECT_GT(to20, 0.0);
}

// ApplyScaling multiplies stats by the factor (Molten Core flavour: lvl 80 -> reduced baseline)
TEST(Scaling, ApplyScalingReducesStatsByFactor)
{
    FakeScalingConfig cfg;
    CombatStats raw;
    raw.health = 30000;
    raw.attackPower = 4000;
    raw.spellPower = 3000;
    raw.armor = 12000;

    ScalingContext ctx = Zone(80, 60);
    double const factor = ScalingFactor(80, 60, cfg);
    CombatStats scaled = ApplyScaling(raw, ctx, cfg);

    EXPECT_LT(scaled.health, raw.health);
    EXPECT_EQ(scaled.health, static_cast<uint32_t>(raw.health * factor + 0.5));
    EXPECT_EQ(scaled.attackPower, static_cast<uint32_t>(raw.attackPower * factor + 0.5));
}

// In an event, scaling uses the (lower) event bracket -> more downscaling than the zone alone
TEST(Scaling, EventScalingAppliesStrongerThanZone)
{
    FakeScalingConfig cfg;
    CombatStats raw;
    raw.health = 30000;

    ScalingContext zoneOnly = Zone(80, 60);
    ScalingContext eventCtx = Zone(80, 60);
    eventCtx.inEvent = true;
    eventCtx.eventTargetLevel = 20;

    EXPECT_LT(ApplyScaling(raw, eventCtx, cfg).health, ApplyScaling(raw, zoneOnly, cfg).health);
}

// Determinism
TEST(Scaling, Deterministic)
{
    FakeScalingConfig cfg;
    CombatStats raw;
    raw.health = 12345;
    ScalingContext ctx = Zone(75, 30);
    EXPECT_EQ(ApplyScaling(raw, ctx, cfg).health, ApplyScaling(raw, ctx, cfg).health);
}
