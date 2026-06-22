#include "branding/effects/EffectModel.h"
#include "fakes/FakeEffectConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// §03/§7.9 effect APPLICATION decisions: the windowed outgoing/incoming multiplier dispatch and the
// healer overheal->shield transform amount. The pure dispatch lives in core so the adapter
// (EffectMgr/EffectScripts) stays a dumb caller; these tests pin the decisions.

namespace
{
    // Default profiles match ProfileFor(): DPS=RaidWindow 6000/18000, Tank=PersonalSpike 8000/24000,
    // Healer=MechanicTransform (always-on). nowMs=1000 is inside both windows; nowMs=10000 is outside.
    EffectProfile Profile(RoleContribution role, EffectKind kind, uint32_t window, uint32_t cooldown)
    {
        EffectProfile p;
        p.kind = kind;
        p.role = role;
        p.windowDurationMs = window;
        p.cooldownMs = cooldown;
        return p;
    }

    constexpr uint64_t IN_WINDOW = 1000;     // < 6000 and < 8000
    constexpr uint64_t OFF_WINDOW = 10000;   // >= 6000 and >= 8000, < both periods
}

// === WindowedOutgoingMultiplier ===

// RaidWindow (DPS) yields the bounded raid multiplier during its window, 1.0 outside it.
TEST(EffectApplication, OutgoingRaidWindowGatedByWindow)
{
    FakeEffectConfig cfg;
    EffectProfile dps = Profile(RoleContribution::Damage, EffectKind::RaidWindow, 6000, 18000);

    double const inWin = WindowedOutgoingMultiplier(dps, cfg.maxEffectLevel, 1.0, IN_WINDOW, cfg);
    EXPECT_DOUBLE_EQ(inWin, RaidMultiplier(cfg.maxEffectLevel, dps, 1.0, cfg));
    EXPECT_GT(inWin, 1.0);
    EXPECT_LE(inWin, cfg.maxRaidMul);

    EXPECT_DOUBLE_EQ(WindowedOutgoingMultiplier(dps, cfg.maxEffectLevel, 1.0, OFF_WINDOW, cfg), 1.0);
}

// PersonalSpike (tank) yields the large personal multiplier during its window, 1.0 outside it.
TEST(EffectApplication, OutgoingPersonalSpikeGatedByWindow)
{
    FakeEffectConfig cfg;
    EffectProfile tank = Profile(RoleContribution::Tank, EffectKind::PersonalSpike, 8000, 24000);

    double const inWin = WindowedOutgoingMultiplier(tank, cfg.maxEffectLevel, 1.0, IN_WINDOW, cfg);
    EXPECT_DOUBLE_EQ(inWin, PersonalMultiplier(cfg.maxEffectLevel, tank, cfg));
    EXPECT_GT(inWin, cfg.maxRaidMul);   // personal exceeds the raid cap (fantasy)

    EXPECT_DOUBLE_EQ(WindowedOutgoingMultiplier(tank, cfg.maxEffectLevel, 1.0, OFF_WINDOW, cfg), 1.0);
}

// MechanicTransform contributes NO outgoing multiplier (it expresses through the heal hook), even
// though it is structurally always-on.
TEST(EffectApplication, OutgoingMechanicTransformIsNeutral)
{
    FakeEffectConfig cfg;
    EffectProfile healer = Profile(RoleContribution::Healer, EffectKind::MechanicTransform, 0, 0);

    EXPECT_DOUBLE_EQ(WindowedOutgoingMultiplier(healer, cfg.maxEffectLevel, 1.0, IN_WINDOW, cfg), 1.0);
    EXPECT_DOUBLE_EQ(WindowedOutgoingMultiplier(healer, cfg.maxEffectLevel, 1.0, OFF_WINDOW, cfg), 1.0);
}

// Outgoing raid multiplier honours the catalyst stack weight (monotonic non-increasing as weight drops).
TEST(EffectApplication, OutgoingRaidWindowHonoursCatalystWeight)
{
    FakeEffectConfig cfg;
    EffectProfile dps = Profile(RoleContribution::Damage, EffectKind::RaidWindow, 6000, 18000);

    double const full = WindowedOutgoingMultiplier(dps, cfg.maxEffectLevel, 1.0, IN_WINDOW, cfg);
    double const dr = WindowedOutgoingMultiplier(dps, cfg.maxEffectLevel, 0.25, IN_WINDOW, cfg);
    EXPECT_LE(dr, full);
    EXPECT_GE(dr, 1.0);
}

// === WindowedIncomingMultiplier (tank survivability) ===

// A tank's PersonalSpike reduces INCOMING damage in-window to exactly 1/PersonalMultiplier, bounded
// to (0, 1], and returns to 1.0 outside the window.
TEST(EffectApplication, IncomingTankReducesInWindow)
{
    FakeEffectConfig cfg;
    EffectProfile tank = Profile(RoleContribution::Tank, EffectKind::PersonalSpike, 8000, 24000);

    double const reduce = WindowedIncomingMultiplier(tank, cfg.maxEffectLevel, IN_WINDOW, cfg);
    EXPECT_DOUBLE_EQ(reduce, 1.0 / PersonalMultiplier(cfg.maxEffectLevel, tank, cfg));
    EXPECT_GT(reduce, 0.0);
    EXPECT_LT(reduce, 1.0);

    EXPECT_DOUBLE_EQ(WindowedIncomingMultiplier(tank, cfg.maxEffectLevel, OFF_WINDOW, cfg), 1.0);
}

// Non-tank profiles never reduce incoming damage (only the tank PersonalSpike does).
TEST(EffectApplication, IncomingNonTankIsNeutral)
{
    FakeEffectConfig cfg;
    EffectProfile dps = Profile(RoleContribution::Damage, EffectKind::RaidWindow, 6000, 18000);
    EffectProfile healer = Profile(RoleContribution::Healer, EffectKind::MechanicTransform, 0, 0);

    EXPECT_DOUBLE_EQ(WindowedIncomingMultiplier(dps, cfg.maxEffectLevel, IN_WINDOW, cfg), 1.0);
    EXPECT_DOUBLE_EQ(WindowedIncomingMultiplier(healer, cfg.maxEffectLevel, IN_WINDOW, cfg), 1.0);
}

// === OverhealShieldAmount (healer MechanicTransform) ===

// No overheal (heal at or below the target's missing health) yields no shield.
TEST(EffectApplication, OverhealShieldZeroWhenNoOverheal)
{
    FakeEffectConfig cfg;
    EXPECT_EQ(OverhealShieldAmount(300, 400, 10000, cfg.maxEffectLevel, cfg), 0u);  // below missing
    EXPECT_EQ(OverhealShieldAmount(400, 400, 10000, cfg.maxEffectLevel, cfg), 0u);  // exactly fills
}

// The shield is the overheal portion scaled by effect strength (mastery-gated): zero at level 0,
// full overheal at max level (when uncapped).
TEST(EffectApplication, OverhealShieldScalesWithLevel)
{
    FakeEffectConfig cfg;
    // heal 1000 onto 400 missing => 600 overheal; 10000 max hp, cap 0.30*10000 = 3000 (not binding).
    EXPECT_EQ(OverhealShieldAmount(1000, 400, 10000, 0, cfg), 0u);
    EXPECT_EQ(OverhealShieldAmount(1000, 400, 10000, cfg.maxEffectLevel, cfg), 600u);

    uint32_t const mid = OverhealShieldAmount(1000, 400, 10000, cfg.maxEffectLevel / 2, cfg);
    EXPECT_GT(mid, 0u);
    EXPECT_LT(mid, 600u);
}

// The shield is hard-capped to MaxOverhealShieldFraction of the target's max health (anti-degenerate).
TEST(EffectApplication, OverhealShieldCappedToMaxHealthFraction)
{
    FakeEffectConfig cfg;   // maxOverhealShieldFraction = 0.30
    // Huge overheal onto a full target: 100000 overheal, capped to 0.30 * 10000 = 3000.
    EXPECT_EQ(OverhealShieldAmount(100000, 0, 10000, cfg.maxEffectLevel, cfg), 3000u);
}

// Monotonic non-decreasing in proficiency level (more mastery never grants a smaller shield).
TEST(EffectApplication, OverhealShieldMonotonicInLevel)
{
    FakeEffectConfig cfg;
    uint32_t prev = 0;
    for (uint8_t lvl = 0; lvl <= cfg.maxEffectLevel; lvl += 5)
    {
        uint32_t const s = OverhealShieldAmount(5000, 0, 100000, lvl, cfg);
        EXPECT_GE(s, prev);
        prev = s;
    }
}
