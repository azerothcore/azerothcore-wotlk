/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 */

#include "Bag.h"
#include "DynamicObject.h"
#include "UpdateFieldFlags.h"
#include <gtest/gtest.h>
#include <string>

TEST(UpdateFieldsTest, LoadsAllEnchantmentsWithoutOverwritingItemOrBagFields)
{
    class TestBag : public Bag
    {
    public:
        using Object::_InitValues;
        using Object::_LoadIntoDataField;
    } bag;
    bag._InitValues();
    bag.SetUInt32Value(ITEM_FIELD_DURABILITY, 39);
    bag.SetUInt32Value(ITEM_FIELD_MAXDURABILITY, 40);
    bag.SetUInt32Value(CONTAINER_FIELD_NUM_SLOTS, 1);
    bag.SetGuidValue(CONTAINER_FIELD_SLOT_1, ObjectGuid::Create<HighGuid::Item>(123));

    std::string enchants;
    for (uint32 word = 1; word <= 45; ++word)
        enchants += std::to_string(word) + " ";
    ASSERT_TRUE(bag._LoadIntoDataField(enchants, ITEM_FIELD_ENCHANTMENT_1_1,
        MAX_ENCHANTMENT_SLOT * MAX_ENCHANTMENT_OFFSET));
    EXPECT_EQ(bag.GetEnchantmentId(PROP_ENCHANTMENT_SLOT_0), 31u);
    EXPECT_EQ(bag.GetEnchantmentCharges(PROP_ENCHANTMENT_SLOT_4), 45u);
    // Absolute build-15595 positions, independent of the server enum expressions.
    EXPECT_EQ(bag.GetUInt32Value(0x44), 45u);
    EXPECT_EQ(bag.GetUInt32Value(0x47), 39u);
    EXPECT_EQ(bag.GetUInt32Value(0x48), 40u);
    EXPECT_EQ(bag.GetUInt32Value(0x4A), 1u);
    EXPECT_EQ(bag.GetGuidValue(0x4C), ObjectGuid::Create<HighGuid::Item>(123));
    EXPECT_EQ(bag.GetValuesCount(), 0x94u);
    EXPECT_EQ(ItemUpdateFieldFlags[0x44], UF_FLAG_PUBLIC);
    EXPECT_EQ(ItemUpdateFieldFlags[0x47], UF_FLAG_OWNER | UF_FLAG_ITEM_OWNER);
    EXPECT_EQ(ItemUpdateFieldFlags[0x48], UF_FLAG_OWNER | UF_FLAG_ITEM_OWNER);
    EXPECT_EQ(ItemUpdateFieldFlags[0x4B], UF_FLAG_NONE);
}

TEST(UpdateFieldsTest, KeepsAreaSpellsUpdatingWithCataclysmVisualBits)
{
    class TestDynamicObject : public DynamicObject
    {
    public:
        using Object::_InitValues;
    } object;
    object._InitValues();
    // A visual whose low byte is not the old WotLK area-spell type byte.
    object.SetUInt32Value(DYNAMICOBJECT_BYTES, 0x10001234);
    EXPECT_TRUE(object.IsUpdateNeeded());
    EXPECT_EQ(DynamicObjectUpdateFieldFlags[0x0A], UF_FLAG_DYNAMIC);
    EXPECT_EQ(CorpseUpdateFieldFlags[0x22], UF_FLAG_PUBLIC);
    EXPECT_EQ(CorpseUpdateFieldFlags[0x23], UF_FLAG_DYNAMIC);
    EXPECT_EQ(CORPSE_END, 0x24);
}
