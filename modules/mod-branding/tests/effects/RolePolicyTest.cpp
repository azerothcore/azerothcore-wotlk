#include "branding/effects/RolePolicy.h"
#include <gtest/gtest.h>

using namespace Branding;

// §14.11 talent-spec seam: role is a player choice per loadout, gated by class CAPABILITY, with the
// default behind a swappable policy. These tests pin the pure decisions (capability, clamping, both
// policies) -- the adapter only samples live signals and calls them.

namespace
{
    // WoW 3.3.5 class ids (src/server/shared/SharedDefines.h).
    constexpr uint8_t WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
                      DEATH_KNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, DRUID = 11;

    // ShapeshiftForm (src/server/game/Entities/Unit/UnitDefines.h).
    constexpr uint8_t FORM_CAT = 0x01, FORM_BEAR = 0x05, FORM_DIREBEAR = 0x08;

    RoleSignals Sig(uint8_t classId, uint8_t tab = 0, uint8_t form = 0, bool frost = false)
    {
        RoleSignals s;
        s.classId = classId;
        s.dominantTab = tab;
        s.shapeshiftForm = form;
        s.inFrostPresence = frost;
        return s;
    }
}

// === Capability ===

TEST(RolePolicy, CapabilityPerClass)
{
    // Pure dps classes: Damage only.
    for (uint8_t c : { MAGE, WARLOCK, HUNTER, ROGUE })
    {
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Damage));
        EXPECT_FALSE(RoleAllowed(c, RoleContribution::Tank));
        EXPECT_FALSE(RoleAllowed(c, RoleContribution::Healer));
    }

    // Tank-capable, not healer.
    for (uint8_t c : { WARRIOR, DEATH_KNIGHT })
    {
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Tank));
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Damage));
        EXPECT_FALSE(RoleAllowed(c, RoleContribution::Healer));
    }

    // Healer-capable, not tank.
    for (uint8_t c : { PRIEST, SHAMAN })
    {
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Healer));
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Damage));
        EXPECT_FALSE(RoleAllowed(c, RoleContribution::Tank));
    }

    // Full hybrids.
    for (uint8_t c : { PALADIN, DRUID })
    {
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Tank));
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Healer));
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Damage));
    }
}

// Damage is legal for every class (the safe default / clamp target).
TEST(RolePolicy, DamageAlwaysAllowed)
{
    for (uint8_t c = 1; c <= DRUID; ++c)
        EXPECT_TRUE(RoleAllowed(c, RoleContribution::Damage));
}

// === ResolveSelectedRole: explicit choice, clamped to capability ===

TEST(RolePolicy, ExplicitChoiceHonouredWhenAllowed)
{
    ClassDefaultRolePolicy policy;
    EXPECT_EQ(ResolveSelectedRole(RoleContribution::Tank, Sig(WARRIOR), policy), RoleContribution::Tank);
    EXPECT_EQ(ResolveSelectedRole(RoleContribution::Healer, Sig(DRUID), policy), RoleContribution::Healer);
}

// An illegal explicit choice (rogue healer -- the anti-OP case) is clamped to Damage, never honoured.
TEST(RolePolicy, ExplicitChoiceClampedWhenIllegal)
{
    ClassDefaultRolePolicy policy;
    EXPECT_EQ(ResolveSelectedRole(RoleContribution::Healer, Sig(ROGUE), policy), RoleContribution::Damage);
    EXPECT_EQ(ResolveSelectedRole(RoleContribution::Tank, Sig(PRIEST), policy), RoleContribution::Damage);
}

// None (unset) delegates to the default policy.
TEST(RolePolicy, NoneDelegatesToPolicy)
{
    ClassDefaultRolePolicy classDefault;
    EXPECT_EQ(ResolveSelectedRole(RoleContribution::None, Sig(DRUID), classDefault), RoleContribution::Damage);

    TalentInferredRolePolicy talent;
    // A Prot warrior (tab 2) with no explicit choice infers Tank under the talent policy.
    EXPECT_EQ(ResolveSelectedRole(RoleContribution::None, Sig(WARRIOR, 2), talent), RoleContribution::Tank);
}

// === ClassDefaultRolePolicy: always Damage (clamped) ===

TEST(RolePolicy, ClassDefaultAlwaysDamage)
{
    ClassDefaultRolePolicy policy;
    for (uint8_t c : { WARRIOR, PALADIN, PRIEST, DEATH_KNIGHT, DRUID, MAGE })
        EXPECT_EQ(policy.DefaultRole(Sig(c), RoleCapabilityMask(c)), RoleContribution::Damage);
}

// === TalentInferredRolePolicy: tab + druid form + DK presence ===

TEST(RolePolicy, TalentWarrior)
{
    TalentInferredRolePolicy p;
    EXPECT_EQ(p.DefaultRole(Sig(WARRIOR, 0), RoleCapabilityMask(WARRIOR)), RoleContribution::Damage);   // Arms
    EXPECT_EQ(p.DefaultRole(Sig(WARRIOR, 2), RoleCapabilityMask(WARRIOR)), RoleContribution::Tank);     // Prot
}

TEST(RolePolicy, TalentPaladin)
{
    TalentInferredRolePolicy p;
    EXPECT_EQ(p.DefaultRole(Sig(PALADIN, 0), RoleCapabilityMask(PALADIN)), RoleContribution::Healer);   // Holy
    EXPECT_EQ(p.DefaultRole(Sig(PALADIN, 1), RoleCapabilityMask(PALADIN)), RoleContribution::Tank);     // Prot
    EXPECT_EQ(p.DefaultRole(Sig(PALADIN, 2), RoleCapabilityMask(PALADIN)), RoleContribution::Damage);   // Ret
}

TEST(RolePolicy, TalentPriestShaman)
{
    TalentInferredRolePolicy p;
    EXPECT_EQ(p.DefaultRole(Sig(PRIEST, 0), RoleCapabilityMask(PRIEST)), RoleContribution::Healer);     // Disc
    EXPECT_EQ(p.DefaultRole(Sig(PRIEST, 2), RoleCapabilityMask(PRIEST)), RoleContribution::Damage);     // Shadow
    EXPECT_EQ(p.DefaultRole(Sig(SHAMAN, 2), RoleCapabilityMask(SHAMAN)), RoleContribution::Healer);     // Resto
    EXPECT_EQ(p.DefaultRole(Sig(SHAMAN, 0), RoleCapabilityMask(SHAMAN)), RoleContribution::Damage);     // Ele
}

TEST(RolePolicy, TalentDruidFeralAmbiguityResolvedByForm)
{
    TalentInferredRolePolicy p;
    EXPECT_EQ(p.DefaultRole(Sig(DRUID, 0), RoleCapabilityMask(DRUID)), RoleContribution::Damage);       // Balance
    EXPECT_EQ(p.DefaultRole(Sig(DRUID, 2), RoleCapabilityMask(DRUID)), RoleContribution::Healer);       // Resto
    // Feral (tab 1): bear -> Tank, cat/none -> Damage.
    EXPECT_EQ(p.DefaultRole(Sig(DRUID, 1, FORM_BEAR), RoleCapabilityMask(DRUID)), RoleContribution::Tank);
    EXPECT_EQ(p.DefaultRole(Sig(DRUID, 1, FORM_DIREBEAR), RoleCapabilityMask(DRUID)), RoleContribution::Tank);
    EXPECT_EQ(p.DefaultRole(Sig(DRUID, 1, FORM_CAT), RoleCapabilityMask(DRUID)), RoleContribution::Damage);
    EXPECT_EQ(p.DefaultRole(Sig(DRUID, 1, 0), RoleCapabilityMask(DRUID)), RoleContribution::Damage);
}

TEST(RolePolicy, TalentDeathKnightByPresence)
{
    TalentInferredRolePolicy p;
    // Tank is presence-driven, not tree-driven, in WotLK.
    EXPECT_EQ(p.DefaultRole(Sig(DEATH_KNIGHT, 0, 0, /*frost*/ true), RoleCapabilityMask(DEATH_KNIGHT)), RoleContribution::Tank);
    EXPECT_EQ(p.DefaultRole(Sig(DEATH_KNIGHT, 0, 0, /*frost*/ false), RoleCapabilityMask(DEATH_KNIGHT)), RoleContribution::Damage);
}

TEST(RolePolicy, TalentPureDpsAlwaysDamage)
{
    TalentInferredRolePolicy p;
    for (uint8_t c : { MAGE, WARLOCK, HUNTER, ROGUE })
        for (uint8_t tab = 0; tab < 3; ++tab)
            EXPECT_EQ(p.DefaultRole(Sig(c, tab), RoleCapabilityMask(c)), RoleContribution::Damage);
}
