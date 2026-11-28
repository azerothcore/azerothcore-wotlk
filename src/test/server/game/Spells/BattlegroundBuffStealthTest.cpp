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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "GameObject.h"
#include "IntegrationTestFixture.h"
#include "SpellInfoTestHelper.h"
#include "gtest/gtest.h"

namespace
{
class TestGameObject : public GameObject
{
public:
    void Initialize(Map* map, GameObjectTemplate const* goInfo)
    {
        SetMap(map);
        SetPhaseMask(PHASEMASK_NORMAL, false);
        Relocate(0.0f, 0.0f, 0.0f, 0.0f);
        Object::_Create(1, goInfo->entry, HighGuid::GameObject);
        m_goInfo = goInfo;
        SetGoType(GameobjectTypes(goInfo->type));
        Object::AddToWorld();
    }

    ~TestGameObject() override
    {
        if (Object::IsInWorld())
            Object::RemoveFromWorld();
    }
};

// Exercise real target validation with minimal spell data, without casting spells or applying auras.
class BattlegroundBuffStealthTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();
        GetTestMap()->SetMapType(MAP_BATTLEGROUND);
        _stealthedTarget = CreateTestCreature(1, 50001, TEST_FACTION_HOSTILE_TO_ALL);
        _stealthedTarget->m_stealth.AddFlag(STEALTH_GENERAL);
        // Keep the target undetectable even at the pickup's activation distance.
        _stealthedTarget->m_stealth.SetValue(STEALTH_GENERAL, 10000);
        _buffSpell = SpellInfoBuilder().WithId(23451).BuildUnique();
        _pickupInfo.entry = 179871;
        _pickupInfo.type = GAMEOBJECT_TYPE_TRAP;
        _pickupInfo.trap.spellId = 23451;
        _pickupInfo.trap.cooldown = 3;
    }

    TestCreature* _stealthedTarget = nullptr;
    std::unique_ptr<SpellInfo> _buffSpell;
    GameObjectTemplate _pickupInfo{};
};

class ArenaShadowSightTest : public BattlegroundBuffStealthTest
{
protected:
    void SetUp() override
    {
        BattlegroundBuffStealthTest::SetUp();
        GetTestMap()->SetMapType(MAP_ARENA);
        _pickupInfo.entry = 184663;
        _pickupInfo.trap.diameter = 5;
        _pickupInfo.trap.spellId = 34709;
        _pickupInfo.trap.type = 1;
        _buffSpell = SpellInfoBuilder().WithId(34709).BuildUnique();
    }
};
}

TEST_F(BattlegroundBuffStealthTest, PickupCanTargetStealthedUnit)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    ASSERT_FALSE(pickup.CanSeeOrDetect(_stealthedTarget, false));
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);
}

TEST_F(BattlegroundBuffStealthTest, PickupCanTargetVisibleUnit)
{
    _stealthedTarget->m_stealth.DelFlag(STEALTH_GENERAL);
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    ASSERT_TRUE(pickup.CanSeeOrDetect(_stealthedTarget, false));
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);
}

TEST_F(BattlegroundBuffStealthTest, PickupCanTargetInvisibleUnit)
{
    _stealthedTarget->m_stealth.DelFlag(STEALTH_GENERAL);
    _stealthedTarget->m_invisibility.AddFlag(INVISIBILITY_GENERAL);
    _stealthedTarget->m_invisibility.SetValue(INVISIBILITY_GENERAL, 100);
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    ASSERT_FALSE(pickup.CanSeeOrDetect(_stealthedTarget, false));
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);
}

TEST_F(ArenaShadowSightTest, PickupCanTargetStealthedUnit)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    ASSERT_FALSE(pickup.CanSeeOrDetect(_stealthedTarget, false));
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);
}

TEST_F(ArenaShadowSightTest, PickupCanTargetInvisibleUnit)
{
    _stealthedTarget->m_stealth.DelFlag(STEALTH_GENERAL);
    _stealthedTarget->m_invisibility.AddFlag(INVISIBILITY_GENERAL);
    _stealthedTarget->m_invisibility.SetValue(INVISIBILITY_GENERAL, 100);
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    ASSERT_FALSE(pickup.CanSeeOrDetect(_stealthedTarget, false));
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);
}

TEST_F(ArenaShadowSightTest, PickupCanTargetVisibleUnit)
{
    _stealthedTarget->m_stealth.DelFlag(STEALTH_GENERAL);
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    ASSERT_TRUE(pickup.CanSeeOrDetect(_stealthedTarget, false));
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);
}

TEST_F(ArenaShadowSightTest, OwnedSingleUseTrapStillRequiresStealthDetection)
{
    TestGameObject trap;
    trap.Initialize(GetTestMap(), &_pickupInfo);
    trap.SetOwnerGUID(ObjectGuid::Create<HighGuid::Unit>(50002, 2));

    EXPECT_EQ(_buffSpell->CheckTarget(&trap, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(ArenaShadowSightTest, OtherSpellsFromPickupStillRequireStealthDetection)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);
    SpellInfo otherSpell(TestSpellEntryHelper().WithId(1).Get());

    EXPECT_EQ(otherSpell.CheckTarget(&pickup, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(ArenaShadowSightTest, SingleUseTrapWithoutPickupCooldownStillRequiresStealthDetection)
{
    _pickupInfo.trap.cooldown = 0;
    TestGameObject trap;
    trap.Initialize(GetTestMap(), &_pickupInfo);

    EXPECT_EQ(_buffSpell->CheckTarget(&trap, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(ArenaShadowSightTest, PickupOutsidePvPStillRequiresStealthDetection)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    for (uint32 mapType : { MAP_COMMON, MAP_INSTANCE, MAP_RAID })
    {
        GetTestMap()->SetMapType(mapType);
        EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS) << mapType;
    }
}

TEST_F(BattlegroundBuffStealthTest, PickupOutsidePvPStillRequiresStealthDetection)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    for (uint32 mapType : { MAP_COMMON, MAP_INSTANCE, MAP_RAID })
    {
        GetTestMap()->SetMapType(mapType);
        EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS) << mapType;
    }
}

TEST_F(BattlegroundBuffStealthTest, HunterTrapKeepsExplicitAndImplicitTargetChecks)
{
    GameObjectTemplate hunterTrapInfo{};
    hunterTrapInfo.entry = 164639;
    hunterTrapInfo.type = GAMEOBJECT_TYPE_TRAP;
    hunterTrapInfo.trap.spellId = 63487;
    hunterTrapInfo.trap.diameter = 5;
    hunterTrapInfo.trap.type = 1;
    hunterTrapInfo.trap.cooldown = 0;

    TestGameObject hunterTrap;
    hunterTrap.Initialize(GetTestMap(), &hunterTrapInfo);
    hunterTrap.SetOwnerGUID(ObjectGuid::Create<HighGuid::Unit>(50002, 2));

    SpellInfo hunterTrapSpell(TestSpellEntryHelper().WithId(63487).Get());
    ASSERT_FALSE(hunterTrap.CanSeeOrDetect(_stealthedTarget, false));
    EXPECT_EQ(hunterTrapSpell.CheckTarget(&hunterTrap, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
    EXPECT_EQ(hunterTrapSpell.CheckTarget(&hunterTrap, _stealthedTarget, true), SPELL_CAST_OK);

    _stealthedTarget->m_stealth.DelFlag(STEALTH_GENERAL);
    EXPECT_EQ(hunterTrapSpell.CheckTarget(&hunterTrap, _stealthedTarget, false), SPELL_CAST_OK);
}

TEST_F(BattlegroundBuffStealthTest, OwnedPickupStillRequiresStealthDetection)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);
    // An unresolved owner must not make a summoned trap count as an ownerless pickup.
    pickup.SetOwnerGUID(ObjectGuid::Create<HighGuid::Unit>(50002, 2));

    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(BattlegroundBuffStealthTest, OtherSpellsFromPickupStillRequireStealthDetection)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);
    SpellInfo otherSpell(TestSpellEntryHelper().WithId(1).Get());

    EXPECT_EQ(otherSpell.CheckTarget(&pickup, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(BattlegroundBuffStealthTest, EnvironmentalTrapStillRequiresStealthDetection)
{
    GameObjectTemplate fireInfo{};
    fireInfo.entry = 148976;
    fireInfo.type = GAMEOBJECT_TYPE_TRAP;
    fireInfo.trap.diameter = 10;
    fireInfo.trap.spellId = 12796;
    fireInfo.trap.cooldown = 3;
    TestGameObject trap;
    trap.Initialize(GetTestMap(), &fireInfo);
    SpellInfo fireSpell(TestSpellEntryHelper().WithId(12796).Get());

    EXPECT_EQ(fireSpell.CheckTarget(&trap, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(BattlegroundBuffStealthTest, NonPickupTrapStillRequiresStealthDetection)
{
    _pickupInfo.trap.cooldown = 0;
    TestGameObject trap;
    trap.Initialize(GetTestMap(), &_pickupInfo);

    EXPECT_EQ(_buffSpell->CheckTarget(&trap, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(BattlegroundBuffStealthTest, OtherObjectTypesStillRequireStealthDetection)
{
    _pickupInfo.type = GAMEOBJECT_TYPE_GOOBER;
    TestGameObject gameObject;
    gameObject.Initialize(GetTestMap(), &_pickupInfo);

    EXPECT_EQ(_buffSpell->CheckTarget(&gameObject, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(BattlegroundBuffStealthTest, UnitCasterStillRequiresStealthDetection)
{
    TestCreature* caster = CreateTestCreature(2, 50002, TEST_FACTION_HOSTILE_TO_ALL);

    EXPECT_EQ(_buffSpell->CheckTarget(caster, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
    EXPECT_EQ(_buffSpell->CheckTarget(caster, _stealthedTarget, true), SPELL_CAST_OK);
}

TEST_F(BattlegroundBuffStealthTest, PickupCannotTargetAnotherPhase)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);
    ASSERT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);

    _stealthedTarget->SetPhaseMask(2, false);
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(BattlegroundBuffStealthTest, PickupCannotTargetGmHiddenUnit)
{
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);
    ASSERT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);

    _stealthedTarget->m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GM, SEC_GAMEMASTER);
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_FAILED_BAD_TARGETS);
}

TEST_F(BattlegroundBuffStealthTest, PickupCannotTargetDeadUnit)
{
    _stealthedTarget->SetAlive(false);
    _stealthedTarget->SetCorpseRemoveTime(60);
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    ASSERT_TRUE(pickup.CanSeeOrDetect(_stealthedTarget, true));
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_FAILED_TARGETS_DEAD);
}

TEST_F(BattlegroundBuffStealthTest, PickupDoesNotChangeExplicitTargetSemantics)
{
    _stealthedTarget->AddUnitState(UNIT_STATE_STUNNED);
    _buffSpell->AttributesEx6 |= SPELL_ATTR6_DO_NOT_CHAIN_TO_CROWD_CONTROLLED_TARGETS;
    TestGameObject pickup;
    pickup.Initialize(GetTestMap(), &_pickupInfo);

    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, false), SPELL_CAST_OK);
    EXPECT_EQ(_buffSpell->CheckTarget(&pickup, _stealthedTarget, true), SPELL_FAILED_BAD_TARGETS);
}
