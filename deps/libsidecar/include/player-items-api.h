#ifndef __PLAYER_ITEMS_API__
#define __PLAYER_ITEMS_API__

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum PlayerItemErrorCode {
    PlayerItemErrorCodeNoError        = 0,
    PlayerItemErrorCodeNoHandler      = 1,
    PlayerItemErrorCodePlayerNotFound = 2,
    PlayerItemErrorNoInventorySpace   = 3,
    PlayerItemErrorUnknownTemplate    = 4,
    PlayerItemErrorFailedToCreateItem = 5,
    PlayerItemErrorItemNotFound       = 6
} PlayerItemErrorCode;

// GetPlayerItemsByGuids request.
typedef struct {
    uint64_t guid;
    uint32_t entry;
    uint64_t owner;
    uint8_t bagSlot;
    uint8_t slot;
    bool isTradable;
    uint32_t count;
    uint16_t flags;
    uint8_t durability;
    int8_t randomPropertyID;
    const char* text;
} PlayerItem;

typedef struct {
    int errorCode;
    PlayerItem* items;
    int itemsSize;
} GetPlayerItemsByGuidsResponse;

typedef GetPlayerItemsByGuidsResponse (*GetPlayerItemsByGuidsHandler) (uint64_t /*player_guid*/, uint64_t* /*items_guids*/, int /*items_guids_size*/);
void SetGetPlayerItemsByGuidsHandler(GetPlayerItemsByGuidsHandler h);
GetPlayerItemsByGuidsResponse CallGetPlayerItemsByGuidsHandler(uint64_t player_guid, uint64_t* items_guids, int items_guids_size);

// GetPlayerItemByPos request. Resolves an item by its live inventory
// position (bag 255 = backpack/base inventory).
typedef struct {
    int errorCode;
    bool found;
    PlayerItem item;
} GetPlayerItemByPosResponse;

typedef GetPlayerItemByPosResponse (*GetPlayerItemByPosHandler) (uint64_t /*player_guid*/, uint8_t /*bag*/, uint8_t /*slot*/);
void SetGetPlayerItemByPosHandler(GetPlayerItemByPosHandler h);
GetPlayerItemByPosResponse CallGetPlayerItemByPosHandler(uint64_t player_guid, uint8_t bag, uint8_t slot);

// RemoveItemsWithGuidsFromPlayer request.
typedef struct {
    int errorCode;
    uint64_t* updatedItems;
    int updatedItemsSize;
} RemoveItemsWithGuidsFromPlayerResponse;

typedef RemoveItemsWithGuidsFromPlayerResponse (*RemoveItemsWithGuidsFromPlayerHandler) (uint64_t /*player_guid*/, uint64_t* /*items_guids*/, int /*items_guids_size*/, uint64_t /*assign_player_guid*/);
void SetRemoveItemsWithGuidsFromPlayerHandler(RemoveItemsWithGuidsFromPlayerHandler h);
RemoveItemsWithGuidsFromPlayerResponse CallRemoveItemsWithGuidsFromPlayerHandler(uint64_t player_guid, uint64_t* items_guids, int items_guids_size, uint64_t assign_player_guid);

// DestroyItemsWithGuidsFromPlayer: permanently destroy items (Player::DestroyItem).
// Do not use RemoveItemsWith assign=0 for this — that orphans item_instance rows.
typedef struct {
    int errorCode;
    uint64_t* destroyedItems;
    int destroyedItemsSize;
} DestroyItemsWithGuidsFromPlayerResponse;

typedef DestroyItemsWithGuidsFromPlayerResponse (*DestroyItemsWithGuidsFromPlayerHandler) (uint64_t /*player_guid*/, uint64_t* /*items_guids*/, int /*items_guids_size*/);
void SetDestroyItemsWithGuidsFromPlayerHandler(DestroyItemsWithGuidsFromPlayerHandler h);
DestroyItemsWithGuidsFromPlayerResponse CallDestroyItemsWithGuidsFromPlayerHandler(uint64_t player_guid, uint64_t* items_guids, int items_guids_size);

// AddExistingItemToPlayer request.
typedef struct {
    uint64_t playerGuid;
    uint64_t itemGuid;
    uint32_t itemEntry;
    uint32_t itemCount;
    uint16_t itemFlags;
    uint8_t itemDurability;
    int8_t itemRandomPropertyID;
} AddExistingItemToPlayerRequest;

typedef PlayerItemErrorCode (*AddExistingItemToPlayerHandler) (AddExistingItemToPlayerRequest*);
void SetAddExistingItemToPlayerHandler(AddExistingItemToPlayerHandler h);
PlayerItemErrorCode CallAddExistingItemToPlayerHandler(AddExistingItemToPlayerRequest*);

// StoreNewItem: create item from template into player inventory.
typedef struct {
    uint64_t playerGuid;
    uint32_t itemEntry;
    uint32_t count;
    /* Permanent enchantment ids (slot i → ITEM_FIELD_ENCHANTMENT_1_1 + i*3). 0 skips the slot. */
    uint32_t* enchantmentIDs;
    int enchantmentIDsSize;
} StoreNewItemRequest;

typedef struct {
    int errorCode;
    uint64_t itemGuid;
} StoreNewItemResponse;

typedef StoreNewItemResponse (*StoreNewItemHandler) (StoreNewItemRequest*);
void SetStoreNewItemHandler(StoreNewItemHandler h);
StoreNewItemResponse CallStoreNewItemHandler(StoreNewItemRequest*);

// SetItemPermanentEnchantment: set permanent enchantment on a player-owned item.
typedef struct {
    uint64_t playerGuid;
    uint64_t itemGuid;
    uint32_t slot;
    uint32_t enchantmentId;
} SetItemPermanentEnchantmentRequest;

typedef struct {
    int errorCode;
} SetItemPermanentEnchantmentResponse;

typedef SetItemPermanentEnchantmentResponse (*SetItemPermanentEnchantmentHandler)(SetItemPermanentEnchantmentRequest*);
void SetSetItemPermanentEnchantmentHandler(SetItemPermanentEnchantmentHandler h);
SetItemPermanentEnchantmentResponse CallSetItemPermanentEnchantmentHandler(SetItemPermanentEnchantmentRequest*);

#ifdef __cplusplus
}
#endif

#endif
