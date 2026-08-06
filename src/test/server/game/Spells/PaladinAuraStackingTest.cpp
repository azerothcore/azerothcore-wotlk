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

#include "IntegrationTestFixture.h"
#include "SpellInfoTestHelper.h"
#include "SpellAuraDefines.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "gtest/gtest.h"

/*
 * Paladin aura stacking (SPELL_SPECIFIC_AURA).
 *
 * Two paladins may have the same paladin aura on the same target, but only the
 * strongest one may provide effects. The weaker duplicates stay applied (so Aura
 * Mastery can detect each caster's own aura via HasAura(spellId, casterGUID))
 * without contributing effects, which would otherwise double the bonus.
 *
 * We drive the real aura pipeline (Unit::AddAura -> Aura::TryRefreshStackOrCreate
 * -> Aura::UpdateTargetMap) with a non-area aura effect so no party grouping is
 * needed. _spellSpecific is normally computed by SpellMgr::LoadSpellInfo from DBC
 * data, which the test builder bypasses, so it is set explicitly.
 */
class PaladinAuraStackingTest : public IntegrationTestFixture
{
protected:
    static constexpr uint32 FIRE_RES_AURA_ID  = 48947;   // Fire Resistance Aura rank 5
    static constexpr int32  FIRE_RES_AMOUNT   = 129;     // +129 fire resistance

    static std::unique_ptr<SpellInfo> MakeFireResAura()
    {
        std::unique_ptr<SpellInfo> info = SpellInfoBuilder()
            .WithId(FIRE_RES_AURA_ID)
            .WithSpellFamilyName(SPELLFAMILY_PALADIN)
            .WithSpellFamilyFlags(0, 0, 0x20) // paladin aura family flag -> SPELL_SPECIFIC_AURA
            .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE)
            .WithEffectBasePoints(0, FIRE_RES_AMOUNT)
            .WithEffectMiscValue(0, SPELL_SCHOOL_MASK_FIRE)
            .BuildUnique();

        info->_spellSpecific = SPELL_SPECIFIC_AURA;
        return info;
    }
};

// Two paladins apply the same Fire Resistance Aura to one target:
//   - both auras stay applied (each caster's own aura, so Aura Mastery finds each)
//   - only one aura effect is active (no doubled resistance)
TEST_F(PaladinAuraStackingTest, SameRankAuraCoexistsPerCasterButSingleEffect)
{
    std::unique_ptr<SpellInfo> auraInfo = MakeFireResAura();

    auto* paladinA = CreateTestPlayer(1, "PaladinA");
    auto* paladinB = CreateTestPlayer(2, "PaladinB");
    auto* target   = CreateTestPlayer(3, "Target");

    Aura* auraA = paladinA->AddAura(auraInfo.get(), MAX_EFFECT_MASK, target);
    ASSERT_NE(auraA, nullptr);
    Aura* auraB = paladinB->AddAura(auraInfo.get(), MAX_EFFECT_MASK, target);
    ASSERT_NE(auraB, nullptr);

    // two separate aura objects, one per caster
    EXPECT_NE(auraA, auraB);

    // both auras are present on the target (per-caster)
    EXPECT_TRUE(target->HasAura(FIRE_RES_AURA_ID, paladinA->GetGUID()));
    EXPECT_TRUE(target->HasAura(FIRE_RES_AURA_ID, paladinB->GetGUID()));

    // only the dominant aura registered an effect
    auto const& effects = target->GetAuraEffectsByType(SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE);
    EXPECT_EQ(effects.size(), 1u);
}

// A single caster's repeated application collapses into the existing aura instead of
// creating a duplicate application (the per-caster exclusivity that must be preserved).
TEST_F(PaladinAuraStackingTest, SingleCasterReapplicationRefreshes)
{
    std::unique_ptr<SpellInfo> auraInfo = MakeFireResAura();

    auto* paladinA = CreateTestPlayer(1, "PaladinA");
    auto* target   = CreateTestPlayer(2, "Target");

    Aura* first  = paladinA->AddAura(auraInfo.get(), MAX_EFFECT_MASK, target);
    ASSERT_NE(first, nullptr);
    Aura* second = paladinA->AddAura(auraInfo.get(), MAX_EFFECT_MASK, target);
    ASSERT_NE(second, nullptr);

    // same caster -> same aura object is refreshed, not duplicated
    EXPECT_EQ(first, second);

    auto const& effects = target->GetAuraEffectsByType(SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE);
    EXPECT_EQ(effects.size(), 1u);
}
