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

#include "Item.h"
#include "ObjectMgr.h"
#include "ScriptDefines/AchievementScript.h"
#include "ScriptDefines/PlayerScript.h"
#include "ScriptMgr.h"
#include "IntegrationTestFixture.h"
#include "gtest/gtest.h"

namespace
{
class InventoryArrivalAchievementScript : public AchievementScript
{
public:
    InventoryArrivalAchievementScript()
        : AchievementScript("InventoryArrivalAchievementScript", {ACHIEVEMENTHOOK_ON_BEFORE_CHECK_CRITERIA})
    {
    }

    static void EnsureRegistered()
    {
        if (!Instance)
            Instance = new InventoryArrivalAchievementScript();
    }

    inline static InventoryArrivalAchievementScript* Instance = nullptr;
};

class InventoryArrivalScript : public PlayerScript
{
public:
    InventoryArrivalScript()
        : PlayerScript("InventoryArrivalScript", { PLAYERHOOK_ON_AFTER_MOVE_ITEM_TO_INVENTORY })
    {
    }

    void OnPlayerAfterMoveItemToInventory(Player* player, Item* item, bool update) override
    {
        ++CallCount;
        LastPlayer = player;
        LastItem = item;
        LastUpdate = update;
    }

    static void EnsureRegistered()
    {
        if (!Instance)
            Instance = new InventoryArrivalScript();
    }

    static void Reset()
    {
        CallCount = 0;
        LastPlayer = nullptr;
        LastItem = nullptr;
        LastUpdate = false;
    }

    inline static InventoryArrivalScript* Instance = nullptr;
    inline static uint32 CallCount = 0;
    inline static Player* LastPlayer = nullptr;
    inline static Item* LastItem = nullptr;
    inline static bool LastUpdate = false;
};

class PlayerInventoryHookTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();
        InventoryArrivalAchievementScript::EnsureRegistered();
        InventoryArrivalScript::EnsureRegistered();
        InventoryArrivalScript::Reset();

        auto& templates = *const_cast<ItemTemplateContainer*>(sObjectMgr->GetItemTemplateStore());
        auto& fastTemplates = *const_cast<std::vector<ItemTemplate*>*>(sObjectMgr->GetItemTemplateStoreFast());
        _originalFastTemplateCount = fastTemplates.size();
        _itemEntry = static_cast<uint32>(_originalFastTemplateCount);

        ItemTemplate itemTemplate{};
        itemTemplate.ItemId = _itemEntry;
        itemTemplate.Class = ITEM_CLASS_CONSUMABLE;
        itemTemplate.Stackable = 20;
        auto const [iterator, inserted] = templates.emplace(_itemEntry, std::move(itemTemplate));
        ASSERT_TRUE(inserted);

        fastTemplates.resize(_originalFastTemplateCount + 1);
        fastTemplates[_itemEntry] = &iterator->second;
    }

    void TearDown() override
    {
        IntegrationTestFixture::TearDown();

        auto& templates = *const_cast<ItemTemplateContainer*>(sObjectMgr->GetItemTemplateStore());
        auto& fastTemplates = *const_cast<std::vector<ItemTemplate*>*>(sObjectMgr->GetItemTemplateStoreFast());
        templates.erase(_itemEntry);
        fastTemplates.resize(_originalFastTemplateCount);
    }

    uint32 _itemEntry = 0;
    std::size_t _originalFastTemplateCount = 0;
};

// cppcheck-suppress syntaxError
TEST_F(PlayerInventoryHookTest, DispatchesWithSurvivingItemAfterStackMerge)
{
    TestPlayer* player = CreateTestPlayer();
    uint16 const position = (INVENTORY_SLOT_BAG_0 << 8) | INVENTORY_SLOT_ITEM_START;

    auto* existingItem = new Item();
    ASSERT_TRUE(existingItem->Create(1001, _itemEntry, player));
    existingItem->SetCount(3);
    ASSERT_EQ(player->StoreItem({ItemPosCount(position, 3)}, existingItem, false), existingItem);

    auto* incomingItem = new Item();
    ASSERT_TRUE(incomingItem->Create(1002, _itemEntry, player));
    incomingItem->SetCount(2);

    InventoryArrivalScript::Reset();
    player->MoveItemToInventory({ItemPosCount(position, 2)}, incomingItem, false);

    EXPECT_EQ(InventoryArrivalScript::CallCount, 1u);
    EXPECT_EQ(InventoryArrivalScript::LastPlayer, player);
    EXPECT_EQ(InventoryArrivalScript::LastItem, existingItem);
    EXPECT_EQ(existingItem->GetCount(), 5u);
    EXPECT_FALSE(InventoryArrivalScript::LastUpdate);
}
}
