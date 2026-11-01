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

#include "GameObject.h"
#include "IntegrationTestFixture.h"
#include "MovementGenerator.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellInfoTestHelper.h"
#include "gtest/gtest.h"

TEST(GroundingTotemTest, SingleTargetSpellCanBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectImplicitTargets(EFFECT_0, TARGET_UNIT_TARGET_ENEMY)
        .BuildUnique();

    EXPECT_TRUE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, AreaTargetingSpellCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectImplicitTargets(EFFECT_0, TARGET_UNIT_CASTER, TARGET_UNIT_SRC_AREA_ENEMY)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, PersistentAreaAuraCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithEffect(EFFECT_0, SPELL_EFFECT_PERSISTENT_AREA_AURA)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, AbilityCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithAttributes(SPELL_ATTR0_IS_ABILITY)
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, SpellWithNoRedirectionAttributeCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithAttributesEx(SPELL_ATTR1_NO_REDIRECTION)
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, SpellIgnoringImmunitiesCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithAttributes(SPELL_ATTR0_NO_IMMUNITIES)
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

namespace
{
enum GroundingTotemSpells : uint32
{
    SPELL_FREEZING_TRAP_EFFECT = 14309,
    SPELL_GROUNDING_TOTEM_EFFECT = 8178
};

class GroundingTotemTargetTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();

        // Death handling needs the idle movement factory.
        if (!sMovementGeneratorRegistry->HasItem(IDLE_MOTION_TYPE))
            (new IdleMovementFactory())->RegisterSelf();

        _hunter = CreateTestCreature(1, 99001, TEST_FACTION_HOSTILE_TO_MONSTERS);
        _shaman = CreateTestCreature(2, 99002, TEST_FACTION_HOSTILE_TO_ALL);
        _groundingTotem = CreateTestCreature(3, 5925, TEST_FACTION_HOSTILE_TO_ALL);
        _groundingTotem->AddUnitTypeMask(UNIT_MASK_TOTEM);
        for (Creature* creature : {_hunter, _shaman, _groundingTotem})
            GetTestMap()->GetObjectsStore().Insert<Creature>(creature->GetGUID(), creature);

        _trap = std::make_unique<GameObject>();
        _trap->_Create(4, HighGuid::GameObject, 1);
        _trap->SetMap(GetTestMap());
        _trap->SetOwnerGUID(_hunter->GetGUID());
        _trap->SetGoType(GAMEOBJECT_TYPE_TRAP);
        _trap->SetUInt32Value(GAMEOBJECT_FACTION, _hunter->GetFaction());
        _trap->Object::AddToWorld();

        _freezingTrapInfo = SpellInfoBuilder()
            .WithId(SPELL_FREEZING_TRAP_EFFECT)
            .WithSpellFamilyName(SPELLFAMILY_HUNTER)
            .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
            .WithDmgClass(SPELL_DAMAGE_CLASS_MAGIC)
            .WithEffect(EFFECT_0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_STUN)
            .WithEffectImplicitTargets(EFFECT_0, TARGET_UNIT_TARGET_ENEMY)
            .BuildUnique();
        _freezingTrapInfo->_InitializeExplicitTargetMask();

        _groundingTotemInfo = SpellInfoBuilder()
            .WithId(SPELL_GROUNDING_TOTEM_EFFECT)
            .WithProcCharges(1)
            .WithEffect(EFFECT_0, SPELL_EFFECT_APPLY_AREA_AURA_PARTY, SPELL_AURA_SPELL_MAGNET)
            .WithEffectImplicitTargets(EFFECT_0, TARGET_UNIT_CASTER)
            .BuildUnique();

        // Grounding belongs to the totem; the shaman receives an application of its party aura.
        Aura* grounding = Aura::TryRefreshStackOrCreate(_groundingTotemInfo.get(), 1,
            _groundingTotem, _groundingTotem);
        ASSERT_NE(grounding, nullptr);
        AuraApplication* application = _shaman->_CreateAuraApplication(grounding, 1);
        ASSERT_NE(application, nullptr);
        _shaman->_ApplyAura(application, 1);
        ASSERT_TRUE(_shaman->HasSpellMagnetAura());
        ASSERT_EQ(grounding->GetUnitOwner(), _groundingTotem);
        ASSERT_EQ(grounding->GetCharges(), 1);
    }

    void TearDown() override
    {
        _groundingTotem->RemoveAllAuras();
        _trap->Object::RemoveFromWorld();
        _trap.reset();

        for (Creature* creature : {_hunter, _shaman, _groundingTotem})
            GetTestMap()->GetObjectsStore().Remove<Creature>(creature->GetGUID());

        IntegrationTestFixture::TearDown();
    }

    Unit* SelectFreezingTrapTarget(WorldObject* caster)
    {
        Spell spell(caster, _freezingTrapInfo.get(), TRIGGERED_NONE, _hunter->GetGUID());
        SpellCastTargets targets;
        targets.SetUnitTarget(_shaman);
        spell.InitExplicitTargets(targets);
        spell.SelectExplicitTargets();
        return spell.m_targets.GetUnitTarget();
    }

    TestCreature* _hunter = nullptr;
    TestCreature* _shaman = nullptr;
    TestCreature* _groundingTotem = nullptr;
    std::unique_ptr<GameObject> _trap;
    std::unique_ptr<SpellInfo> _freezingTrapInfo;
    std::unique_ptr<SpellInfo> _groundingTotemInfo;
};

// cppcheck-suppress syntaxError
TEST_F(GroundingTotemTargetTest, UnitCastRedirectsAndConsumesGrounding)
{
    EXPECT_EQ(SelectFreezingTrapTarget(_hunter), _groundingTotem);

    _groundingTotem->m_Events.Update(100);
    EXPECT_FALSE(_shaman->HasSpellMagnetAura());
    EXPECT_FALSE(_groundingTotem->IsAlive());
}

TEST_F(GroundingTotemTargetTest, FreezingTrapRedirectsAndConsumesGrounding)
{
    ASSERT_TRUE(_freezingTrapInfo->CanBeRedirectedBySpellMagnet());
    ASSERT_EQ(_freezingTrapInfo->CheckExplicitTarget(_trap.get(), _groundingTotem), SPELL_CAST_OK);
    EXPECT_EQ(SelectFreezingTrapTarget(_trap.get()), _groundingTotem);

    _groundingTotem->m_Events.Update(100);
    EXPECT_FALSE(_shaman->HasSpellMagnetAura());
    EXPECT_FALSE(_groundingTotem->IsAlive());
}

TEST_F(GroundingTotemTargetTest, FreezingTrapWithoutGroundingKeepsOriginalTarget)
{
    _groundingTotem->RemoveAllAuras();

    EXPECT_EQ(SelectFreezingTrapTarget(_trap.get()), _shaman);
}

TEST_F(GroundingTotemTargetTest, NonRedirectableTrapKeepsOriginalTargetAndGrounding)
{
    _freezingTrapInfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION;

    EXPECT_EQ(SelectFreezingTrapTarget(_trap.get()), _shaman);

    _groundingTotem->m_Events.Update(100);
    ASSERT_TRUE(_shaman->HasSpellMagnetAura());
    EXPECT_EQ(_shaman->GetAura(SPELL_GROUNDING_TOTEM_EFFECT)->GetCharges(), 1);
    EXPECT_TRUE(_groundingTotem->IsAlive());
}

TEST_F(GroundingTotemTargetTest, AreaTrapKeepsOriginalTargetAndGrounding)
{
    _freezingTrapInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_PERSISTENT_AREA_AURA;

    EXPECT_EQ(SelectFreezingTrapTarget(_trap.get()), _shaman);

    _groundingTotem->m_Events.Update(100);
    ASSERT_TRUE(_shaman->HasSpellMagnetAura());
    EXPECT_EQ(_shaman->GetAura(SPELL_GROUNDING_TOTEM_EFFECT)->GetCharges(), 1);
    EXPECT_TRUE(_groundingTotem->IsAlive());
}
}
