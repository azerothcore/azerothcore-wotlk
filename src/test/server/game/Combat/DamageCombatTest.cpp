/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CombatManager.h"
#include "IntegrationTestFixture.h"
#include "SpellAuras.h"
#include "SpellInfoTestHelper.h"
#include "ThreatManager.h"
#include "gtest/gtest.h"

namespace
{
class DamageCombatTest : public IntegrationTestFixture
{
protected:
    static constexpr uint32 InitialHealth = 10000;
    static constexpr uint32 Damage = 100;
    static constexpr uint32 TransferredDamage = 20;

    void SetUp() override
    {
        IntegrationTestFixture::SetUp();
        ON_CALL(*GetWorldMock(), getRate(RATE_DURABILITY_LOSS_DAMAGE)).WillByDefault(Return(0.0f));

        _attacker = CreateTestCreature(1, 12345, TEST_FACTION_HOSTILE_TO_MONSTERS);
        _recipient = CreateTestCreature(2, 12346, TEST_FACTION_HOSTILE_TO_ALL);
        _attacker->SetControlledByPlayer(true);
        _recipient->SetControlledByPlayer(true);
        _attacker->SetIsCombatDisallowed(false);
        _recipient->SetIsCombatDisallowed(false);

        // Model charmed creatures: player-controlled, but still able to hold threat.
        ASSERT_TRUE(_recipient->CanHaveThreatList());
        GetTestMap()->GetObjectsStore().Insert<Creature>(_recipient->GetGUID(), _recipient);

        _damageSpell = SpellInfoBuilder()
            .WithId(900001)
            .WithSchoolMask(SPELL_SCHOOL_MASK_NORMAL)
            .WithDmgClass(SPELL_DAMAGE_CLASS_MAGIC)
            .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
            .BuildUnique();
    }

    void TearDown() override
    {
        if (_transferTarget)
            _transferTarget->RemoveAllAuras();

        GetTestMap()->GetObjectsStore().Remove<Creature>(_recipient->GetGUID());
        IntegrationTestFixture::TearDown();
    }

    void DealDirectDamage(DamageEffectType type)
    {
        Unit::DealDamage(_attacker, _recipient, Damage, nullptr, type,
            SPELL_SCHOOL_MASK_NORMAL, _damageSpell.get(), false);
    }

    Aura* AddTransferAura(AuraType type)
    {
        _transferTarget = CreateTestPlayer(3, "TransferTarget");
        _transferTarget->SetFaction(TEST_FACTION_HOSTILE_TO_ALL);
        _transferTarget->SetLevel(80);
        _transferTarget->SetMaxHealth(InitialHealth);
        _transferTarget->SetHealth(InitialHealth);

        _duration.Duration[0] = -1;
        _duration.Duration[1] = -1;
        _duration.Duration[2] = -1;
        _transferSpell = SpellInfoBuilder()
            .WithId(900002)
            .WithEffect(0, SPELL_EFFECT_APPLY_AURA, type)
            .WithEffectBasePoints(0, TransferredDamage)
            .WithEffectMiscValue(0, SPELL_SCHOOL_MASK_NORMAL)
            .BuildUnique();
        _transferSpell->DurationEntry = &_duration;
        return _recipient->AddAura(_transferSpell.get(), 0x1, _transferTarget);
    }

    void DealTransferredDamage(DamageEffectType type)
    {
        DamageInfo damageInfo(_attacker, _transferTarget, Damage, _damageSpell.get(),
            SPELL_SCHOOL_MASK_NORMAL, type);
        Unit::CalcAbsorbResist(damageInfo);
        Unit::DealDamage(_attacker, _transferTarget, damageInfo.GetDamage(), nullptr, type,
            SPELL_SCHOOL_MASK_NORMAL, _damageSpell.get(), false);
    }

    void AdvanceCombat(uint32 elapsed)
    {
        _attacker->TestGetCombatMgr().Update(elapsed);
        _recipient->TestGetCombatMgr().Update(elapsed);
    }

    TestCreature* _attacker = nullptr;
    TestCreature* _recipient = nullptr;
    TestPlayer* _transferTarget = nullptr;
    std::unique_ptr<SpellInfo> _damageSpell;
    std::unique_ptr<SpellInfo> _transferSpell;
    SpellDurationEntry _duration{};
};

// https://github.com/azerothcore/azerothcore-wotlk/pull/28396
// cppcheck-suppress syntaxError
TEST_F(DamageCombatTest, DirectDoTDoesNotStartPvPCombat)
{
    DealDirectDamage(DOT);

    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - Damage);
    EXPECT_FALSE(_recipient->IsInCombat());
    EXPECT_FALSE(_attacker->IsInCombat());
    EXPECT_EQ(_recipient->TestGetThreatMgr().GetThreatListSize(), 0u);
}

TEST_F(DamageCombatTest, DirectDoTDoesNotRefreshPvPCombat)
{
    ASSERT_TRUE(_recipient->TestGetCombatMgr().SetInCombatWith(_attacker));
    AdvanceCombat(PvPCombatReference::PVP_COMBAT_TIMEOUT - 1000);

    DealDirectDamage(DOT);
    AdvanceCombat(1000);

    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - Damage);
    EXPECT_FALSE(_recipient->IsInCombat());
    EXPECT_FALSE(_attacker->IsInCombat());
}

TEST_F(DamageCombatTest, DirectHitStartsAndRefreshesPvPCombat)
{
    DealDirectDamage(SPELL_DIRECT_DAMAGE);
    ASSERT_TRUE(_recipient->TestGetCombatMgr().HasPvPCombat());
    ASSERT_TRUE(_attacker->IsInCombat());
    AdvanceCombat(PvPCombatReference::PVP_COMBAT_TIMEOUT - 1000);

    DealDirectDamage(SPELL_DIRECT_DAMAGE);
    AdvanceCombat(1000);
    EXPECT_TRUE(_recipient->IsInCombat());
    EXPECT_TRUE(_attacker->IsInCombat());
    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - 2 * Damage);

    AdvanceCombat(PvPCombatReference::PVP_COMBAT_TIMEOUT - 1000);
    EXPECT_FALSE(_recipient->IsInCombat());
    EXPECT_FALSE(_attacker->IsInCombat());
}

TEST_F(DamageCombatTest, NpcDoTKeepsPvEThreat)
{
    _attacker->SetControlledByPlayer(false);

    DealDirectDamage(DOT);

    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - Damage);
    EXPECT_TRUE(_recipient->TestGetCombatMgr().HasPvECombat());
    EXPECT_TRUE(_attacker->TestGetCombatMgr().HasPvECombat());
    EXPECT_FLOAT_EQ(_recipient->TestGetThreatMgr().GetThreat(_attacker), float(Damage));
}

TEST_F(DamageCombatTest, DoTGeneratesPvEThreatAfterPlayerControlEnds)
{
    DealDirectDamage(DOT);
    ASSERT_FALSE(_recipient->IsInCombat());

    _recipient->SetControlledByPlayer(false);
    DealDirectDamage(DOT);

    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - 2 * Damage);
    EXPECT_TRUE(_recipient->TestGetCombatMgr().HasPvECombat());
    EXPECT_FLOAT_EQ(_recipient->TestGetThreatMgr().GetThreat(_attacker), float(Damage));
}

class DamageTransferCombatTest : public DamageCombatTest, public testing::WithParamInterface<AuraType>
{
};

TEST_P(DamageTransferCombatTest, PeriodicTransferAllowsPvPCombatToExpire)
{
    Aura* aura = AddTransferAura(GetParam());
    ASSERT_NE(aura, nullptr);
    ASSERT_EQ(aura->GetCaster(), _recipient);

    DealTransferredDamage(DOT);
    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - TransferredDamage);
    ASSERT_FALSE(_recipient->IsInCombat());
    ASSERT_FALSE(_attacker->IsInCombat());

    ASSERT_TRUE(_recipient->TestGetCombatMgr().SetInCombatWith(_attacker));
    AdvanceCombat(PvPCombatReference::PVP_COMBAT_TIMEOUT - 1000);
    DealTransferredDamage(DOT);
    AdvanceCombat(1000);
    ASSERT_FALSE(_recipient->IsInCombat());
    ASSERT_FALSE(_attacker->IsInCombat());

    DealTransferredDamage(DOT);
    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - 3 * TransferredDamage);
    EXPECT_FALSE(_recipient->IsInCombat());
    EXPECT_FALSE(_attacker->IsInCombat());
}

TEST_P(DamageTransferCombatTest, DirectTransferStartsAndRefreshesPvPCombat)
{
    Aura* aura = AddTransferAura(GetParam());
    ASSERT_NE(aura, nullptr);
    ASSERT_EQ(aura->GetCaster(), _recipient);

    DealTransferredDamage(SPELL_DIRECT_DAMAGE);
    ASSERT_TRUE(_recipient->TestGetCombatMgr().HasPvPCombat());
    ASSERT_TRUE(_attacker->IsInCombat());
    AdvanceCombat(PvPCombatReference::PVP_COMBAT_TIMEOUT - 1000);

    DealTransferredDamage(SPELL_DIRECT_DAMAGE);
    AdvanceCombat(1000);
    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - 2 * TransferredDamage);
    EXPECT_TRUE(_recipient->IsInCombat());
    EXPECT_TRUE(_attacker->IsInCombat());

    AdvanceCombat(PvPCombatReference::PVP_COMBAT_TIMEOUT - 1000);
    EXPECT_FALSE(_recipient->IsInCombat());
    EXPECT_FALSE(_attacker->IsInCombat());
}

TEST_P(DamageTransferCombatTest, NpcPeriodicTransferKeepsPvEThreat)
{
    _attacker->SetControlledByPlayer(false);
    Aura* aura = AddTransferAura(GetParam());
    ASSERT_NE(aura, nullptr);
    ASSERT_EQ(aura->GetCaster(), _recipient);

    DealTransferredDamage(DOT);

    EXPECT_EQ(_recipient->GetHealth(), InitialHealth - TransferredDamage);
    EXPECT_TRUE(_recipient->TestGetCombatMgr().HasPvECombat());
    EXPECT_TRUE(_attacker->TestGetCombatMgr().HasPvECombat());
    EXPECT_FLOAT_EQ(_recipient->TestGetThreatMgr().GetThreat(_attacker), float(TransferredDamage));
}

INSTANTIATE_TEST_SUITE_P(TransferAuras, DamageTransferCombatTest,
    testing::Values(SPELL_AURA_SPLIT_DAMAGE_FLAT, SPELL_AURA_SPLIT_DAMAGE_PCT, SPELL_AURA_SHARE_DAMAGE_PCT));
}
