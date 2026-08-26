/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "IntegrationTestFixture.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfoTestHelper.h"
#include "gtest/gtest.h"

namespace
{
constexpr uint32 TEST_AURA_SPELL_ID = 900001;
constexpr int32 BASE_AMOUNT = 2;
constexpr int32 SAVED_AMOUNT = 83;
constexpr int32 AURA_DURATION = 60 * MINUTE * IN_MILLISECONDS;

class AuraLoadedStateTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();

        _spellInfo = SpellInfoBuilder()
            .WithId(TEST_AURA_SPELL_ID)
            .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_RESISTANCE)
            .WithEffectBasePoints(0, BASE_AMOUNT)
            .WithEffectMiscValue(0, SPELL_SCHOOL_MASK_FIRE)
            .BuildUnique();
    }

    std::unique_ptr<SpellInfo> _spellInfo;
};

TEST_F(AuraLoadedStateTest, UnresolvedCasterPreservesSavedAmount)
{
    TestPlayer* target = CreateTestPlayer();
    ObjectGuid casterGuid = ObjectGuid::Create<HighGuid::Unit>(9098, 1);
    Aura* aura = Aura::TryCreate(_spellInfo.get(), 1, target, nullptr, nullptr, nullptr, casterGuid);
    ASSERT_NE(aura, nullptr);

    int32 amounts[MAX_SPELL_EFFECTS] = { SAVED_AMOUNT, 0, 0 };
    aura->SetLoadedState(AURA_DURATION, AURA_DURATION, 0, 1, 1, amounts);

    AuraEffect const* effect = aura->GetEffect(0);
    ASSERT_NE(effect, nullptr);
    EXPECT_EQ(effect->GetAmount(), SAVED_AMOUNT);

    aura->Remove();
}

TEST_F(AuraLoadedStateTest, ResolvedCasterStillRecalculatesAmount)
{
    TestPlayer* target = CreateTestPlayer();
    Aura* aura = Aura::TryCreate(_spellInfo.get(), 1, target, target);
    ASSERT_NE(aura, nullptr);

    int32 amounts[MAX_SPELL_EFFECTS] = { SAVED_AMOUNT, 0, 0 };
    aura->SetLoadedState(AURA_DURATION, AURA_DURATION, 0, 1, 1, amounts);

    AuraEffect const* effect = aura->GetEffect(0);
    ASSERT_NE(effect, nullptr);
    EXPECT_EQ(effect->GetAmount(), BASE_AMOUNT);

    aura->Remove();
}
}
