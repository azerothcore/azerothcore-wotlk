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

#ifndef AZEROTHCORE_WAND_COMBAT_TEST_FIXTURE_H
#define AZEROTHCORE_WAND_COMBAT_TEST_FIXTURE_H

#include "IntegrationTestFixture.h"
#include "Item.h"
#include "ObjectMgr.h"
#include "Spell.h"
#include "SpellInfoTestHelper.h"

class WandTestSpell : public Spell
{
public:
    using Spell::Spell;
    using Spell::m_attackType;
    using Spell::m_procAttacker;
    using Spell::m_procVictim;
    using Spell::prepareDataForTriggerSystem;
};

// Native server fixtures: real equipment, skills and combat code; synthetic DBC/DB data.
class WandCombatTestFixture : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();
        ON_CALL(*GetWorldMock(), getIntConfig(CONFIG_SKILL_GAIN_WEAPON)).WillByDefault(Return(1));
        ON_CALL(*GetWorldMock(), getRate(RATE_MISS_CHANCE_MULTIPLIER_TARGET_CREATURE)).WillByDefault(Return(11.0f));
        ON_CALL(*GetWorldMock(), getRate(RATE_MISS_CHANCE_MULTIPLIER_TARGET_PLAYER)).WillByDefault(Return(7.0f));

        // Full cast checks use collision height, unlike the lower-level hit calculation.
        constexpr uint32 displayId = 99001;
        if (!sCreatureModelDataStore.LookupEntry(displayId))
        {
            auto* model = new CreatureModelDataEntry{};
            model->Id = displayId;
            model->Scale = 1.0f;
            model->CollisionWidth = 1.0f;
            model->CollisionHeight = 2.0f;
            sCreatureModelDataStore.SetEntry(displayId, model);
        }
        if (!sCreatureDisplayInfoStore.LookupEntry(displayId))
        {
            auto* display = new CreatureDisplayInfoEntry{};
            display->Displayid = displayId;
            display->ModelId = displayId;
            display->scale = 1.0f;
            sCreatureDisplayInfoStore.SetEntry(displayId, display);
        }

        for (uint32 skill : { SKILL_WANDS, SKILL_BOWS, SKILL_THROWN, SKILL_UNARMED })
            if (!sSkillLineStore.LookupEntry(skill))
            {
                auto* entry = new SkillLineEntry{};
                entry->id = skill;
                sSkillLineStore.SetEntry(skill, entry);
            }

        _player = CreateTestPlayer();
        _player->SetByteValue(UNIT_FIELD_BYTES_0, 0, RACE_HUMAN);
        _player->SetByteValue(UNIT_FIELD_BYTES_0, 1, CLASS_PRIEST);
        _player->SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, TEST_FACTION_HOSTILE_TO_MONSTERS);
        _player->SetLevel(80);
        _player->SetMaxHealth(10000);
        _player->SetHealth(10000);
        _player->SetNativeDisplayId(displayId);
        _player->SetDisplayId(displayId);
        _player->SetSkill(SKILL_UNARMED, 0, 400, 400);
        _player->Relocate(0.0f, 0.0f, 0.0f);
        _victim = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_ALL);
        _victim->SetNativeDisplayId(displayId);
        _victim->SetDisplayId(displayId);
        _victim->Relocate(15.0f, 0.0f, 0.0f);
        GetTestMap()->GetObjectsStore().Insert<Creature>(_victim->GetGUID(), _victim);

        _weaponTemplate.ItemId = 99001;
        _weaponTemplate.Class = ITEM_CLASS_WEAPON;
        _weaponTemplate.SubClass = ITEM_SUBCLASS_WEAPON_WAND;
        _weaponTemplate.InventoryType = INVTYPE_RANGEDRIGHT;
        _weaponTemplate.Damage[0].DamageMin = 10.0f;
        _weaponTemplate.Damage[0].DamageMax = 10.0f;
        _weaponTemplate.Damage[0].DamageType = SPELL_SCHOOL_FIRE;
        _weaponTemplate.Delay = 1500;
        _weaponTemplate.Stackable = 1;
        _weaponTemplate.MaxDurability = 50000; // Keep thrown weapons usable throughout a rate sample.
        _ammoTemplate.ItemId = 99002;
        _ammoTemplate.Class = ITEM_CLASS_PROJECTILE;
        _ammoTemplate.SubClass = ITEM_SUBCLASS_ARROW;
        _ammoTemplate.InventoryType = INVTYPE_AMMO;
        _ammoTemplate.Stackable = 50000;
        auto* templates = const_cast<std::vector<ItemTemplate*>*>(sObjectMgr->GetItemTemplateStoreFast());
        _oldTemplateSize = templates->size();
        if (templates->size() <= _ammoTemplate.ItemId)
            templates->resize(_ammoTemplate.ItemId + 1);
        _oldTemplate = (*templates)[_weaponTemplate.ItemId];
        _oldAmmoTemplate = (*templates)[_ammoTemplate.ItemId];
        (*templates)[_weaponTemplate.ItemId] = &_weaponTemplate;
        (*templates)[_ammoTemplate.ItemId] = &_ammoTemplate;

        _weapon = std::make_unique<Item>();
        ASSERT_TRUE(_weapon->Create(1, _weaponTemplate.ItemId, _player));
        _player->VisualizeItem(EQUIPMENT_SLOT_RANGED, _weapon.get());
        _player->SetCanModifyStats(true);
        _player->_ApplyItemBonuses(&_weaponTemplate, EQUIPMENT_SLOT_RANGED, true);
        _ammo = std::make_unique<Item>();
        ASSERT_TRUE(_ammo->Create(2, _ammoTemplate.ItemId, _player));
        _ammo->SetCount(50000);
        _player->VisualizeItem(INVENTORY_SLOT_ITEM_START, _ammo.get());
        _player->SetUInt32Value(PLAYER_AMMO_ID, _ammoTemplate.ItemId);
        _player->SetSkill(SKILL_WANDS, 0, 1, 400);
        ASSERT_EQ(_player->GetWeaponSkillValue(RANGED_ATTACK, _victim), 1u);

        _shoot = MakeRangedSpell(5019, ITEM_SUBCLASS_WEAPON_WAND, SPELL_DAMAGE_CLASS_MAGIC, true);
        _shoot->RangeEntry = &_range;
        _range.RangeMax[0] = _range.RangeMax[1] = 30.0f;
    }

    void TearDown() override
    {
        // Spell::prepare transfers ownership to the caster's event queue.
        if (!_player)
        {
            IntegrationTestFixture::TearDown();
            return;
        }
        _player->InterruptNonMeleeSpells(true);
        _player->m_Events.KillAllEvents(true);
        _player->RemoveItem(INVENTORY_SLOT_BAG_0, INVENTORY_SLOT_ITEM_START, false);
        _ammo.reset();
        _player->RemoveItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, false);
        _weapon.reset();
        GetTestMap()->GetObjectsStore().Remove<Creature>(_victim->GetGUID());
        IntegrationTestFixture::TearDown();
        auto* templates = const_cast<std::vector<ItemTemplate*>*>(sObjectMgr->GetItemTemplateStoreFast());
        if (templates->size() > _weaponTemplate.ItemId)
        {
            (*templates)[_weaponTemplate.ItemId] = _oldTemplate;
            (*templates)[_ammoTemplate.ItemId] = _oldAmmoTemplate;
            templates->resize(_oldTemplateSize);
        }
    }

    static std::unique_ptr<SpellInfo> MakeRangedSpell(uint32 id, uint32 subclass, uint32 damageClass, bool repeat)
    {
        auto info = SpellInfoBuilder().WithId(id).WithDmgClass(damageClass)
            .WithEffect(0, subclass == ITEM_SUBCLASS_WEAPON_WAND ?
                SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL : SPELL_EFFECT_WEAPON_DAMAGE).BuildUnique();
        info->EquippedItemClass = ITEM_CLASS_WEAPON;
        info->EquippedItemSubClassMask = 1 << subclass;
        info->Attributes = SPELL_ATTR0_USES_RANGED_SLOT | SPELL_ATTR0_IS_ABILITY;
        info->AttributesCu = SPELL_ATTR0_CU_NEGATIVE_EFF0 | SPELL_ATTR0_CU_DIRECT_DAMAGE;
        info->AttributesEx2 = repeat ? SPELL_ATTR2_AUTO_REPEAT : 0;
        info->AttributesEx3 = SPELL_ATTR3_NORMAL_RANGED_ATTACK;
        info->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
        info->ExplicitTargetMask = TARGET_FLAG_UNIT;
        info->SetCritCapable(true);
        return info;
    }

    void SetWeaponSkill(uint16 value, uint8 victimLevel = 80)
    {
        _player->SetSkill(_weapon->GetSkill(), 0, value, 400);
        _victim->SetLevel(victimLevel);
    }

    void ApplyHitItem(uint32 stat, int32 rating)
    {
        ItemTemplate item{};
        item.StatsCount = 1;
        item.ItemStat[0].ItemStatType = stat;
        item.ItemStat[0].ItemStatValue = rating;
        _player->_ApplyItemBonuses(&item, EQUIPMENT_SLOT_NECK, true);
    }

    float MissChance() const
    {
        return _player->MeleeSpellMissChance(_victim, RANGED_ATTACK,
            int32(_player->GetWeaponSkillValue(RANGED_ATTACK, _victim)) -
            int32(_victim->GetMaxSkillValueForLevel(_player)), _shoot->Id);
    }

    TestPlayer* _player = nullptr;
    TestCreature* _victim = nullptr;
    std::unique_ptr<Item> _weapon;
    std::unique_ptr<Item> _ammo;
    std::unique_ptr<SpellInfo> _shoot;
    ItemTemplate _weaponTemplate{};
    ItemTemplate _ammoTemplate{};
    SpellRangeEntry _range{};
    ItemTemplate* _oldTemplate = nullptr;
    ItemTemplate* _oldAmmoTemplate = nullptr;
    std::size_t _oldTemplateSize = 0;
};

#endif
