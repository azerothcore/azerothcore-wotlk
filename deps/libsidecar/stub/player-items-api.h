#ifndef __PLAYER_ITEMS_API__
#define __PLAYER_ITEMS_API__

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

typedef enum PlayerItemErrorCode {
    PlayerItemErrorCodeNoError        = 0,
    PlayerItemErrorCodeNoHandler      = 1,
    PlayerItemErrorCodePlayerNotFound = 2,
    PlayerItemErrorNoInventorySpace   = 3,
    PlayerItemErrorUnknownTemplate    = 4,
    PlayerItemErrorFailedToCreateItem = 5
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

// RemoveItemsWithGuidsFromPlayer request.
typedef struct {
    int errorCode;
    uint64_t* updatedItems;
    int updatedItemsSize;
} RemoveItemsWithGuidsFromPlayerResponse;

typedef RemoveItemsWithGuidsFromPlayerResponse (*RemoveItemsWithGuidsFromPlayerHandler) (uint64_t /*player_guid*/, uint64_t* /*items_guids*/, int /*items_guids_size*/, uint64_t /*assign_player_guid*/);
void SetRemoveItemsWithGuidsFromPlayerHandler(RemoveItemsWithGuidsFromPlayerHandler h);
RemoveItemsWithGuidsFromPlayerResponse CallRemoveItemsWithGuidsFromPlayerHandler(uint64_t player_guid, uint64_t* items_guids, int items_guids_size, uint64_t assign_player_guid);

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

#endif
