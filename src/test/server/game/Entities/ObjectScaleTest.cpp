/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "IntegrationTestFixture.h"
#include "SpellAuras.h"
#include "SpellInfoTestHelper.h"
#include "gtest/gtest.h"

namespace
{

// Noggenfogger Elixir "tiny" effect: SPELL_AURA_MOD_SCALE_2, -50%
static constexpr uint32 SCALE_AURA_SPELL_ID = 16595;
static constexpr int32  SCALE_AURA_PCT      = -50;

static constexpr uint32 NATIVE_DISPLAY_ID = 90010;
static constexpr uint32 OTHER_DISPLAY_ID  = 7550;

class ObjectScaleTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();

        _scaleAuraInfo = SpellInfoBuilder()
            .WithId(SCALE_AURA_SPELL_ID)
            .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_SCALE_2)
            .WithEffectBasePoints(0, SCALE_AURA_PCT)
            .BuildUnique();

        // Permanent aura, removed by the tests themselves
        _durationEntry = {};
        _durationEntry.Duration[0] = -1;
        _durationEntry.Duration[1] = -1;
        _durationEntry.Duration[2] = -1;
        _scaleAuraInfo->DurationEntry = &_durationEntry;
    }

    std::unique_ptr<SpellInfo> _scaleAuraInfo;
    SpellDurationEntry _durationEntry;
};

// Tiny, then a display change (transform), then back to the native display: the aura must keep working
// cppcheck-suppress syntaxError
TEST_F(ObjectScaleTest, PlayerKeepsScaleAuraAcrossDisplayChange)
{
    TestPlayer* player = CreateTestPlayer(1, "TinyPlayer");
    player->SetNativeDisplayId(NATIVE_DISPLAY_ID);
    player->SetDisplayId(NATIVE_DISPLAY_ID);

    Aura* aura = player->AddAura(_scaleAuraInfo.get(), 0x1, player);
    ASSERT_NE(aura, nullptr);
    EXPECT_FLOAT_EQ(player->GetObjectScale(), 0.5f);

    player->SetDisplayId(OTHER_DISPLAY_ID);
    EXPECT_FLOAT_EQ(player->GetObjectScale(), 0.5f);

    player->SetDisplayId(NATIVE_DISPLAY_ID);
    EXPECT_FLOAT_EQ(player->GetObjectScale(), 0.5f);

    player->RemoveAurasDueToSpell(SCALE_AURA_SPELL_ID);
    EXPECT_FLOAT_EQ(player->GetObjectScale(), 1.0f);
}

// Display change first, then tiny: the order must not matter
// cppcheck-suppress syntaxError
TEST_F(ObjectScaleTest, PlayerScaleAuraAfterDisplayChange)
{
    TestPlayer* player = CreateTestPlayer(1, "TinyPlayer");
    player->SetNativeDisplayId(NATIVE_DISPLAY_ID);
    player->SetDisplayId(OTHER_DISPLAY_ID);
    EXPECT_FLOAT_EQ(player->GetObjectScale(), 1.0f);

    Aura* aura = player->AddAura(_scaleAuraInfo.get(), 0x1, player);
    ASSERT_NE(aura, nullptr);
    EXPECT_FLOAT_EQ(player->GetObjectScale(), 0.5f);

    player->SetDisplayId(NATIVE_DISPLAY_ID);
    EXPECT_FLOAT_EQ(player->GetObjectScale(), 0.5f);
}

// Restoring the native display (end of a transform or shapeshift) must keep the aura
// cppcheck-suppress syntaxError
TEST_F(ObjectScaleTest, PlayerRestoreDisplayIdKeepsScaleAura)
{
    TestPlayer* player = CreateTestPlayer(1, "TinyPlayer");
    player->SetNativeDisplayId(NATIVE_DISPLAY_ID);
    player->SetDisplayId(OTHER_DISPLAY_ID);

    Aura* aura = player->AddAura(_scaleAuraInfo.get(), 0x1, player);
    ASSERT_NE(aura, nullptr);

    player->RestoreDisplayId();
    EXPECT_EQ(player->GetDisplayId(), NATIVE_DISPLAY_ID);
    EXPECT_FLOAT_EQ(player->GetObjectScale(), 0.5f);
}

// Creature with a native scale of 3 (e.g. a DisplayScale 3 model): display changes keep it, auras add to it
// cppcheck-suppress syntaxError
TEST_F(ObjectScaleTest, CreatureKeepsNativeScale)
{
    TestCreature* creature = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_ALL);
    creature->SetTestNativeObjectScale(3.0f);
    creature->SetNativeDisplayId(NATIVE_DISPLAY_ID);
    creature->SetDisplayId(NATIVE_DISPLAY_ID);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 3.0f);

    creature->SetDisplayId(OTHER_DISPLAY_ID);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 3.0f);

    Aura* aura = creature->AddAura(_scaleAuraInfo.get(), 0x1, creature);
    ASSERT_NE(aura, nullptr);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 2.5f);

    creature->SetDisplayId(NATIVE_DISPLAY_ID);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 2.5f);

    creature->RemoveAurasDueToSpell(SCALE_AURA_SPELL_ID);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 3.0f);
}

// Display change with an explicit scale (e.g. SmartAI morph to a model with its own DisplayScale)
// cppcheck-suppress syntaxError
TEST_F(ObjectScaleTest, CreatureExplicitDisplayScale)
{
    TestCreature* creature = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_ALL);
    creature->SetTestNativeObjectScale(3.0f);
    creature->SetNativeDisplayId(NATIVE_DISPLAY_ID);

    creature->SetDisplayId(OTHER_DISPLAY_ID, 2.0f);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 2.0f);

    Aura* aura = creature->AddAura(_scaleAuraInfo.get(), 0x1, creature);
    ASSERT_NE(aura, nullptr);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 1.5f);

    creature->RemoveAurasDueToSpell(SCALE_AURA_SPELL_ID);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 2.0f);

    creature->SetDisplayId(NATIVE_DISPLAY_ID);
    EXPECT_FLOAT_EQ(creature->GetObjectScale(), 3.0f);
}

} // namespace
