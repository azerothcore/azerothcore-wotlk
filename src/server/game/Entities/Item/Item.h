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

#ifndef AZEROTHCORE_ITEM_H
#define AZEROTHCORE_ITEM_H

#include "Common.h"
#include "DatabaseEnv.h"
#include "ItemTemplate.h"
#include "LootMgr.h"
#include "Object.h"

class SpellInfo;
class Bag;
class Unit;

struct ItemSetEffect
{
    uint32 setid;
    uint32 item_count;
    SpellInfo const* spells[8];
};

enum InventorySlot
{
    NULL_BAG    = 0,
    NULL_SLOT   = 255
};

// EnumUtils: DESCRIBE THIS
enum InventoryResult : uint8
{
    EQUIP_ERR_OK                                 = 0,
    EQUIP_ERR_CANT_EQUIP_LEVEL_I                 = 1,
    EQUIP_ERR_CANT_EQUIP_SKILL                   = 2,
    EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT             = 3,
    EQUIP_ERR_BAG_FULL                           = 4,
    EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG        = 5,
    EQUIP_ERR_CANT_TRADE_EQUIP_BAGS              = 6,
    EQUIP_ERR_ONLY_AMMO_CAN_GO_HERE              = 7,
    EQUIP_ERR_NO_REQUIRED_PROFICIENCY            = 8,
    EQUIP_ERR_NO_EQUIPMENT_SLOT_AVAILABLE        = 9,
    EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM        = 10,
    EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM2       = 11,
    EQUIP_ERR_NO_EQUIPMENT_SLOT_AVAILABLE2       = 12,
    EQUIP_ERR_CANT_EQUIP_WITH_TWOHANDED          = 13,
    EQUIP_ERR_CANT_DUAL_WIELD                    = 14,
    EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG            = 15,
    EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG2           = 16,
    EQUIP_ERR_CANT_CARRY_MORE_OF_THIS            = 17,
    EQUIP_ERR_NO_EQUIPMENT_SLOT_AVAILABLE3       = 18,
    EQUIP_ERR_ITEM_CANT_STACK                    = 19,
    EQUIP_ERR_ITEM_CANT_BE_EQUIPPED              = 20,
    EQUIP_ERR_ITEMS_CANT_BE_SWAPPED              = 21,
    EQUIP_ERR_SLOT_IS_EMPTY                      = 22,
    EQUIP_ERR_ITEM_NOT_FOUND                     = 23,
    EQUIP_ERR_CANT_DROP_SOULBOUND                = 24,
    EQUIP_ERR_OUT_OF_RANGE                       = 25,
    EQUIP_ERR_TRIED_TO_SPLIT_MORE_THAN_COUNT     = 26,
    EQUIP_ERR_COULDNT_SPLIT_ITEMS                = 27,
    EQUIP_ERR_MISSING_REAGENT                    = 28,
    EQUIP_ERR_NOT_ENOUGH_MONEY                   = 29,
    EQUIP_ERR_NOT_A_BAG                          = 30,
    EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS        = 31,
    EQUIP_ERR_DONT_OWN_THAT_ITEM                 = 32,
    EQUIP_ERR_CAN_EQUIP_ONLY1_QUIVER             = 33,
    EQUIP_ERR_MUST_PURCHASE_THAT_BAG_SLOT        = 34,
    EQUIP_ERR_TOO_FAR_AWAY_FROM_BANK             = 35,
    EQUIP_ERR_ITEM_LOCKED                        = 36,
    EQUIP_ERR_YOU_ARE_STUNNED                    = 37,
    EQUIP_ERR_YOU_ARE_DEAD                       = 38,
    EQUIP_ERR_CANT_DO_RIGHT_NOW                  = 39,
    EQUIP_ERR_INT_BAG_ERROR                      = 40,
    EQUIP_ERR_CAN_EQUIP_ONLY1_BOLT               = 41,
    EQUIP_ERR_CAN_EQUIP_ONLY1_AMMOPOUCH          = 42,
    EQUIP_ERR_STACKABLE_CANT_BE_WRAPPED          = 43,
    EQUIP_ERR_EQUIPPED_CANT_BE_WRAPPED           = 44,
    EQUIP_ERR_WRAPPED_CANT_BE_WRAPPED            = 45,
    EQUIP_ERR_BOUND_CANT_BE_WRAPPED              = 46,
    EQUIP_ERR_UNIQUE_CANT_BE_WRAPPED             = 47,
    EQUIP_ERR_BAGS_CANT_BE_WRAPPED               = 48,
    EQUIP_ERR_ALREADY_LOOTED                     = 49,
    EQUIP_ERR_INVENTORY_FULL                     = 50,
    EQUIP_ERR_BANK_FULL                          = 51,
    EQUIP_ERR_ITEM_IS_CURRENTLY_SOLD_OUT         = 52,
    EQUIP_ERR_BAG_FULL3                          = 53,
    EQUIP_ERR_ITEM_NOT_FOUND2                    = 54,
    EQUIP_ERR_ITEM_CANT_STACK2                   = 55,
    EQUIP_ERR_BAG_FULL4                          = 56,
    EQUIP_ERR_ITEM_SOLD_OUT                      = 57,
    EQUIP_ERR_OBJECT_IS_BUSY                     = 58,
    EQUIP_ERR_NONE                               = 59,
    EQUIP_ERR_NOT_IN_COMBAT                      = 60,
    EQUIP_ERR_NOT_WHILE_DISARMED                 = 61,
    EQUIP_ERR_BAG_FULL6                          = 62,
    EQUIP_ERR_CANT_EQUIP_RANK                    = 63,
    EQUIP_ERR_CANT_EQUIP_REPUTATION              = 64,
    EQUIP_ERR_TOO_MANY_SPECIAL_BAGS              = 65,
    EQUIP_ERR_LOOT_CANT_LOOT_THAT_NOW            = 66,
    EQUIP_ERR_ITEM_UNIQUE_EQUIPABLE              = 67,
    EQUIP_ERR_VENDOR_MISSING_TURNINS             = 68,
    EQUIP_ERR_NOT_ENOUGH_HONOR_POINTS            = 69,
    EQUIP_ERR_NOT_ENOUGH_ARENA_POINTS            = 70,
    EQUIP_ERR_ITEM_MAX_COUNT_SOCKETED            = 71,
    EQUIP_ERR_MAIL_BOUND_ITEM                    = 72,
    EQUIP_ERR_NO_SPLIT_WHILE_PROSPECTING         = 73,
    EQUIP_ERR_ITEM_MAX_COUNT_EQUIPPED_SOCKETED   = 75,
    EQUIP_ERR_ITEM_UNIQUE_EQUIPPABLE_SOCKETED    = 76,
    EQUIP_ERR_TOO_MUCH_GOLD                      = 77,
    EQUIP_ERR_NOT_DURING_ARENA_MATCH             = 78,
    EQUIP_ERR_CANNOT_TRADE_THAT                  = 79,
    EQUIP_ERR_PERSONAL_ARENA_RATING_TOO_LOW      = 80,
    EQUIP_ERR_EVENT_AUTOEQUIP_BIND_CONFIRM       = 81,
    EQUIP_ERR_ARTEFACTS_ONLY_FOR_OWN_CHARACTERS  = 82,
    // no output                                 = 83,
    EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_COUNT_EXCEEDED     = 84,
    EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_SOCKETED_EXCEEDED  = 85,
    EQUIP_ERR_SCALING_STAT_ITEM_LEVEL_EXCEEDED           = 86,
    EQUIP_ERR_PURCHASE_LEVEL_TOO_LOW                     = 87,
    EQUIP_ERR_CANT_EQUIP_NEED_TALENT                     = 88,
    EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_EQUIPPED_EXCEEDED  = 89
};

// EnumUtils: DESCRIBE THIS
enum BuyResult
{
    BUY_ERR_CANT_FIND_ITEM                      = 0,
    BUY_ERR_ITEM_ALREADY_SOLD                   = 1,
    BUY_ERR_NOT_ENOUGHT_MONEY                   = 2,
    BUY_ERR_SELLER_DONT_LIKE_YOU                = 4,
    BUY_ERR_DISTANCE_TOO_FAR                    = 5,
    BUY_ERR_ITEM_SOLD_OUT                       = 7,
    BUY_ERR_CANT_CARRY_MORE                     = 8,
    BUY_ERR_RANK_REQUIRE                        = 11,
    BUY_ERR_REPUTATION_REQUIRE                  = 12
};

// EnumUtils: DESCRIBE THIS
enum SellResult
{
    SELL_ERR_CANT_FIND_ITEM                      = 1,       // The item was not found.
    SELL_ERR_CANT_SELL_ITEM                      = 2,       // The merchant doesn't want that item.
    SELL_ERR_CANT_FIND_VENDOR                    = 3,       // The merchant doesn't like you.
    SELL_ERR_YOU_DONT_OWN_THAT_ITEM              = 4,       // You don't own that item.
    SELL_ERR_UNK                                 = 5,       // Nothing appears...
    SELL_ERR_ONLY_EMPTY_BAG                      = 6,       // You can only do that with empty bags.
    SELL_ERR_CANT_SELL_TO_THIS_MERCHANT          = 7,       // You cannot sell items to this merchant.
    SELL_ERR_MUST_REPAIR_ITEM_DURABILITY_TO_USE  = 8,       // You must repair that item's durability to use it.
    SELL_INTERNAL_BAG_ERROR                      = 9        // Internal Bag Error
};

// -1 from client enchantment slot number
enum EnchantmentSlot : uint8
{
    PERM_ENCHANTMENT_SLOT           = 0,
    TEMP_ENCHANTMENT_SLOT           = 1,
    SOCK_ENCHANTMENT_SLOT           = 2,
    SOCK_ENCHANTMENT_SLOT_2         = 3,
    SOCK_ENCHANTMENT_SLOT_3         = 4,
    BONUS_ENCHANTMENT_SLOT          = 5,
    PRISMATIC_ENCHANTMENT_SLOT      = 6,                    // added at apply special permanent enchantment
    MAX_INSPECTED_ENCHANTMENT_SLOT  = 7,

    PROP_ENCHANTMENT_SLOT_0         = 7,                    // used with RandomSuffix and RandomProperty
    PROP_ENCHANTMENT_SLOT_1         = 8,                    // used with RandomSuffix and RandomProperty
    PROP_ENCHANTMENT_SLOT_2         = 9,                    // used with RandomSuffix and RandomProperty
    PROP_ENCHANTMENT_SLOT_3         = 10,                   // used with RandomSuffix and RandomProperty
    PROP_ENCHANTMENT_SLOT_4         = 11,                   // used with RandomSuffix and RandomProperty
    MAX_ENCHANTMENT_SLOT            = 12
};

#define MAX_VISIBLE_ITEM_OFFSET       2                     // 2 fields per visible item (entry+enchantment)

#define MAX_GEM_SOCKETS               MAX_ITEM_PROTO_SOCKETS// (BONUS_ENCHANTMENT_SLOT-SOCK_ENCHANTMENT_SLOT) and item proto size, equal value expected

enum EnchantmentOffset
{
    ENCHANTMENT_ID_OFFSET       = 0,
    ENCHANTMENT_DURATION_OFFSET = 1,
    ENCHANTMENT_CHARGES_OFFSET  = 2                         // now here not only charges, but something new in wotlk
};

#define MAX_ENCHANTMENT_OFFSET    3

enum EnchantmentSlotMask
{
    ENCHANTMENT_CAN_SOULBOUND  = 0x01,
    ENCHANTMENT_UNK1           = 0x02,
    ENCHANTMENT_UNK2           = 0x04,
    ENCHANTMENT_UNK3           = 0x08
};

enum ItemUpdateState
{
    ITEM_UNCHANGED                               = 0,
    ITEM_CHANGED                                 = 1,
    ITEM_NEW                                     = 2,
    ITEM_REMOVED                                 = 3
};

#define MAX_ITEM_SPELLS 5

bool ItemCanGoIntoBag(ItemTemplate const* proto, ItemTemplate const* pBagProto);

class Item : public Object
{
public:
    static Item* CreateItem(uint32 item, uint32 count, Player const* player = nullptr, bool clone = false, uint32 randomPropertyId = 0);
    Item* CloneItem(uint32 count, Player const* player = nullptr) const;

    Item();

    virtual bool Create(ObjectGuid::LowType guidlow, uint32 itemid, Player const* owner);

    [[nodiscard]] ItemTemplate const* GetTemplate() const;

    [[nodiscard]] ObjectGuid GetOwnerGUID() const { return GetGuidValue(ITEM_FIELD_OWNER); }
    void SetOwnerGUID(ObjectGuid guid) { SetGuidValue(ITEM_FIELD_OWNER, guid); }
    [[nodiscard]] Player* GetOwner() const;

    void SetBinding(bool val) { ApplyModFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_SOULBOUND, val); }
    [[nodiscard]] bool IsSoulBound() const { return HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_SOULBOUND); }
    [[nodiscard]] bool IsBoundAccountWide() const { return GetTemplate()->HasFlag(ITEM_FLAG_IS_BOUND_TO_ACCOUNT) != 0; }
    bool IsBindedNotWith(Player const* player) const;
    [[nodiscard]] bool IsBoundByEnchant() const;
    [[nodiscard]] bool IsBoundByTempEnchant() const;
    virtual void SaveToDB(CharacterDatabaseTransaction trans);
    virtual bool LoadFromDB(ObjectGuid::LowType guid, ObjectGuid owner_guid, Field* fields, uint32 entry);
    static void DeleteFromDB(CharacterDatabaseTransaction trans, ObjectGuid::LowType itemGuid);
    virtual void DeleteFromDB(CharacterDatabaseTransaction trans);
    static void DeleteFromInventoryDB(CharacterDatabaseTransaction trans, ObjectGuid::LowType itemGuid);
    void DeleteFromInventoryDB(CharacterDatabaseTransaction trans);
    void SaveRefundDataToDB();
    void DeleteRefundDataFromDB(CharacterDatabaseTransaction* trans);

    Bag* ToBag() { if (IsBag()) return reinterpret_cast<Bag*>(this); else return nullptr; }
    [[nodiscard]] const Bag* ToBag() const { if (IsBag()) return reinterpret_cast<const Bag*>(this); else return nullptr; }

    [[nodiscard]] bool IsLocked() const { return !HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_UNLOCKED); }
    [[nodiscard]] bool IsBag() const { return GetTemplate()->InventoryType == INVTYPE_BAG; }
    [[nodiscard]] bool IsCurrencyToken() const { return GetTemplate()->IsCurrencyToken(); }
    [[nodiscard]] bool IsNotEmptyBag() const;
    [[nodiscard]] bool IsBroken() const { return GetUInt32Value(ITEM_FIELD_MAXDURABILITY) > 0 && GetUInt32Value(ITEM_FIELD_DURABILITY) == 0; }
    [[nodiscard]] bool CanBeTraded(bool mail = false, bool trade = false) const;
    void SetInTrade(bool b = true) { mb_in_trade = b; }
    [[nodiscard]] bool IsInTrade() const { return mb_in_trade; }
    [[nodiscard]] bool IsRefundable() const { return HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_REFUNDABLE); }
    [[nodiscard]] bool IsBOPTradable() const { return HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_BOP_TRADEABLE); }
    [[nodiscard]] bool IsWrapped() const { return HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_WRAPPED); }

    bool HasEnchantRequiredSkill(Player const* player) const;
    [[nodiscard]] uint32 GetEnchantRequiredLevel() const;

    bool IsFitToSpellRequirements(SpellInfo const* spellInfo) const;
    [[nodiscard]] bool IsLimitedToAnotherMapOrZone(uint32 cur_mapId, uint32 cur_zoneId) const;
    [[nodiscard]] bool GemsFitSockets() const;

    [[nodiscard]] uint32 GetCount() const { return GetUInt32Value(ITEM_FIELD_STACK_COUNT); }
    void SetCount(uint32 value) { SetUInt32Value(ITEM_FIELD_STACK_COUNT, value); }
    [[nodiscard]] uint32 GetMaxStackCount() const { return GetTemplate()->GetMaxStackSize(); }
    // Checks if this item has sockets, whether built-in or added by an upgrade.
    [[nodiscard]] bool HasSocket() const;
    [[nodiscard]] uint8 GetGemCountWithID(uint32 GemID) const;
    [[nodiscard]] uint8 GetGemCountWithLimitCategory(uint32 limitCategory) const;
    InventoryResult CanBeMergedPartlyWith(ItemTemplate const* proto) const;

    [[nodiscard]] uint8 GetSlot() const {return m_slot;}
    Bag* GetContainer() { return m_container; }
    [[nodiscard]] uint8 GetBagSlot() const;
    void SetSlot(uint8 slot) { m_slot = slot; }
    [[nodiscard]] uint16 GetPos() const { return uint16(GetBagSlot()) << 8 | GetSlot(); }
    void SetContainer(Bag* container) { m_container = container; }

    [[nodiscard]] bool IsInBag() const { return m_container != nullptr; }
    [[nodiscard]] bool IsEquipped() const;

    uint32 GetSkill();
    uint32 GetSpell();

    // RandomPropertyId (signed but stored as unsigned)
    [[nodiscard]] int32 GetItemRandomPropertyId() const { return GetInt32Value(ITEM_FIELD_RANDOM_PROPERTIES_ID); }
    [[nodiscard]] uint32 GetItemSuffixFactor() const { return GetUInt32Value(ITEM_FIELD_PROPERTY_SEED); }
    void SetItemRandomProperties(int32 randomPropId);
    void UpdateItemSuffixFactor();
    static int32 GenerateItemRandomPropertyId(uint32 item_id);
    void SetEnchantment(EnchantmentSlot slot, uint32 id, uint32 duration, uint32 charges, ObjectGuid caster = ObjectGuid::Empty);
    void SetEnchantmentDuration(EnchantmentSlot slot, uint32 duration, Player* owner);
    void SetEnchantmentCharges(EnchantmentSlot slot, uint32 charges);
    void ClearEnchantment(EnchantmentSlot slot);
    [[nodiscard]] uint32 GetEnchantmentId(EnchantmentSlot slot)       const { return GetUInt32Value(ITEM_FIELD_ENCHANTMENT_1_1 + slot * MAX_ENCHANTMENT_OFFSET + ENCHANTMENT_ID_OFFSET);}
    [[nodiscard]] uint32 GetEnchantmentDuration(EnchantmentSlot slot) const { return GetUInt32Value(ITEM_FIELD_ENCHANTMENT_1_1 + slot * MAX_ENCHANTMENT_OFFSET + ENCHANTMENT_DURATION_OFFSET);}
    [[nodiscard]] uint32 GetEnchantmentCharges(EnchantmentSlot slot)  const { return GetUInt32Value(ITEM_FIELD_ENCHANTMENT_1_1 + slot * MAX_ENCHANTMENT_OFFSET + ENCHANTMENT_CHARGES_OFFSET);}

    [[nodiscard]] std::string const& GetText() const { return m_text; }
    void SetText(std::string const& text) { m_text = text; }

    void SendUpdateSockets();

    void SendTimeUpdate(Player* owner);
    void UpdateDuration(Player* owner, uint32 diff);

    // spell charges (signed but stored as unsigned)
    [[nodiscard]] int32 GetSpellCharges(uint8 index/*0..5*/ = 0) const { return GetInt32Value(ITEM_FIELD_SPELL_CHARGES + index); }
    void  SetSpellCharges(uint8 index/*0..5*/, int32 value) { SetInt32Value(ITEM_FIELD_SPELL_CHARGES + index, value); }

    Loot loot;
    bool m_lootGenerated;

    // Update States
    [[nodiscard]] ItemUpdateState GetState() const { return uState; }
    void SetState(ItemUpdateState state, Player* forplayer = nullptr);
    void AddToUpdateQueueOf(Player* player);
    void RemoveFromUpdateQueueOf(Player* player);
    [[nodiscard]] bool IsInUpdateQueue() const { return uQueuePos != -1; }
    [[nodiscard]] uint32 GetQueuePos() const { return uQueuePos; }
    void FSetState(ItemUpdateState state)               // forced
    {
        uState = state;
    }

    [[nodiscard]] bool hasQuest(uint32 quest_id) const override { return GetTemplate()->StartQuest == quest_id; }
    [[nodiscard]] bool hasInvolvedQuest(uint32 /*quest_id*/) const override { return false; }
    [[nodiscard]] bool IsPotion() const { return GetTemplate()->IsPotion(); }
    [[nodiscard]] bool IsWeaponVellum() const { return GetTemplate()->IsWeaponVellum(); }
    [[nodiscard]] bool IsArmorVellum() const { return GetTemplate()->IsArmorVellum(); }
    [[nodiscard]] bool IsConjuredConsumable() const { return GetTemplate()->IsConjuredConsumable(); }

    // Item Refund system
    void SetNotRefundable(Player* owner, bool changestate = true, CharacterDatabaseTransaction* trans = nullptr);
    void SetRefundRecipient(ObjectGuid::LowType pGuidLow) { m_refundRecipient = pGuidLow; }
    void SetPaidMoney(uint32 money) { m_paidMoney = money; }
    void SetPaidExtendedCost(uint32 iece) { m_paidExtendedCost = iece; }
    ObjectGuid::LowType GetRefundRecipient() { return m_refundRecipient; }
    uint32 GetPaidMoney() { return m_paidMoney; }
    uint32 GetPaidExtendedCost() { return m_paidExtendedCost; }

    void UpdatePlayedTime(Player* owner);
    uint32 GetPlayedTime();
    bool IsRefundExpired();

    // Soulbound trade system
    void SetSoulboundTradeable(AllowedLooterSet& allowedLooters);
    void ClearSoulboundTradeable(Player* currentOwner);
    bool CheckSoulboundTradeExpire();

    void BuildUpdate(UpdateDataMapType& data_map) override;
    void AddToObjectUpdate() override;
    void RemoveFromObjectUpdate() override;

    [[nodiscard]] uint32 GetScriptId() const { return GetTemplate()->ScriptId; }

    std::string GetDebugInfo() const override;
private:
    std::string m_text;
    uint8 m_slot;
    Bag* m_container;
    ItemUpdateState uState;
    int32 uQueuePos;
    bool mb_in_trade;                                   // true if item is currently in trade-window
    time_t m_lastPlayedTimeUpdate;
    uint32 m_refundRecipient;
    uint32 m_paidMoney;
    uint32 m_paidExtendedCost;
    AllowedLooterSet allowedGUIDs;
};
#endif
