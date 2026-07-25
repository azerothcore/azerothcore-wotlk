/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "gtest/gtest.h"

#include "ObjectGuid.h"
#include "Position.h"
#include "Spell.h"
#include "SpellDefines.h"

// Surface-level tests for the WorldObject spellcasting port API. These do
// not exercise Spell::prepare() — that requires TestMap / TestCreature
// scaffolding and is covered indirectly by the existing proc/immunity
// tests. The goal here is to lock in the new TC-style argument types so a
// future regression to CastSpellTargetArg / CastSpellExtraArgs surfaces
// in CI rather than at the next call site.

TEST(WorldObjectCastApi, CastSpellExtraArgsDefault)
{
    CastSpellExtraArgs args;
    EXPECT_EQ(args.TriggerFlags, TRIGGERED_NONE);
    EXPECT_EQ(args.CastItem, nullptr);
    EXPECT_EQ(args.TriggeringAura, nullptr);
    EXPECT_FALSE(args.OriginalCaster);
}

TEST(WorldObjectCastApi, CastSpellExtraArgsBoolCtor)
{
    CastSpellExtraArgs triggered(true);
    EXPECT_EQ(triggered.TriggerFlags, TRIGGERED_FULL_MASK);

    CastSpellExtraArgs untriggered(false);
    EXPECT_EQ(untriggered.TriggerFlags, TRIGGERED_NONE);
}

TEST(WorldObjectCastApi, CastSpellExtraArgsTriggerFlagsCtor)
{
    CastSpellExtraArgs args(TRIGGERED_IGNORE_GCD);
    EXPECT_EQ(args.TriggerFlags, TRIGGERED_IGNORE_GCD);
}

TEST(WorldObjectCastApi, CastSpellExtraArgsOriginalCasterCtor)
{
    ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(42);
    CastSpellExtraArgs args(guid);
    EXPECT_EQ(args.OriginalCaster, guid);
    EXPECT_EQ(args.TriggerFlags, TRIGGERED_FULL_MASK);
}

TEST(WorldObjectCastApi, CastSpellExtraArgsFluentChain)
{
    ObjectGuid guid = ObjectGuid::Create<HighGuid::Unit>(100, 7);
    CastSpellExtraArgs args = CastSpellExtraArgs()
        .SetTriggerFlags(TRIGGERED_IGNORE_POWER_AND_REAGENT_COST)
        .SetOriginalCaster(guid)
        .AddSpellMod(SPELLVALUE_BASE_POINT0, 123)
        .AddSpellBP0(456);

    EXPECT_EQ(args.TriggerFlags, TRIGGERED_IGNORE_POWER_AND_REAGENT_COST);
    EXPECT_EQ(args.OriginalCaster, guid);
    // SpellValueOverrides is private detail of CustomSpellValues — just
    // verify two entries were appended via the public iteration interface.
    int hits = 0;
    for (auto const& kv : args.SpellValueOverrides)
    {
        EXPECT_EQ(kv.first, SPELLVALUE_BASE_POINT0);
        if (kv.second == 123 || kv.second == 456)
            ++hits;
    }
    EXPECT_EQ(hits, 2);
}

TEST(WorldObjectCastApi, CastSpellExtraArgsSpellValueModCtor)
{
    CastSpellExtraArgs args(SPELLVALUE_MAX_TARGETS, 3);
    int found = 0;
    for (auto const& kv : args.SpellValueOverrides)
    {
        if (kv.first == SPELLVALUE_MAX_TARGETS && kv.second == 3)
            ++found;
    }
    EXPECT_EQ(found, 1);
}

TEST(WorldObjectCastApi, CastSpellTargetArgEmpty)
{
    CastSpellTargetArg t;
    ASSERT_TRUE(t.Targets); // default ctor populates a non-null SpellCastTargets
    EXPECT_EQ(t.Targets->GetTargetMask(), 0u);
}

TEST(WorldObjectCastApi, CastSpellTargetArgNullptr)
{
    CastSpellTargetArg t(nullptr);
    ASSERT_TRUE(t.Targets);
}

TEST(WorldObjectCastApi, CastSpellTargetArgPosition)
{
    Position pos(1.0f, 2.0f, 3.0f, 0.5f);
    CastSpellTargetArg t(pos);
    ASSERT_TRUE(t.Targets);
    EXPECT_NE(t.Targets->GetTargetMask() & TARGET_FLAG_DEST_LOCATION, 0u);
}

TEST(WorldObjectCastApi, CastSpellTargetArgWorldObjectNull)
{
    // Null caster yields an error-state CastSpellTargetArg (Targets stays
    // empty so WorldObject::CastSpell returns SPELL_FAILED_BAD_TARGETS).
    CastSpellTargetArg t(static_cast<WorldObject*>(nullptr));
    EXPECT_FALSE(t.Targets);
}
