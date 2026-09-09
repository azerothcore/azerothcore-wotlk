#include "player-items-api.h"

static GetPlayerItemsByGuidsHandler getPlayerItemsByGuidsHandler;
void SetGetPlayerItemsByGuidsHandler(GetPlayerItemsByGuidsHandler h) {
    getPlayerItemsByGuidsHandler = h;
}

GetPlayerItemsByGuidsResponse CallGetPlayerItemsByGuidsHandler(uint64_t player_guid, uint64_t* items_guids, int items_guids_size) {
    if (getPlayerItemsByGuidsHandler == 0) {
        GetPlayerItemsByGuidsResponse resp;
        resp.errorCode = PlayerItemErrorCodeNoHandler;
        return resp;
    }

    return getPlayerItemsByGuidsHandler(player_guid, items_guids, items_guids_size);
}

static GetPlayerItemByPosHandler getPlayerItemByPosHandler;
void SetGetPlayerItemByPosHandler(GetPlayerItemByPosHandler h) {
    getPlayerItemByPosHandler = h;
}

GetPlayerItemByPosResponse CallGetPlayerItemByPosHandler(uint64_t player_guid, uint8_t bag, uint8_t slot) {
    if (getPlayerItemByPosHandler == 0) {
        GetPlayerItemByPosResponse resp = {0};
        resp.errorCode = PlayerItemErrorCodeNoHandler;
        return resp;
    }

    return getPlayerItemByPosHandler(player_guid, bag, slot);
}

static RemoveItemsWithGuidsFromPlayerHandler removeItemsWithGuidsFromPlayerHandler;
void SetRemoveItemsWithGuidsFromPlayerHandler(RemoveItemsWithGuidsFromPlayerHandler h) {
    removeItemsWithGuidsFromPlayerHandler = h;
}

RemoveItemsWithGuidsFromPlayerResponse CallRemoveItemsWithGuidsFromPlayerHandler(uint64_t player_guid, uint64_t* items_guids, int items_guids_size, uint64_t assign_player_guid) {
    if (removeItemsWithGuidsFromPlayerHandler == 0) {
        RemoveItemsWithGuidsFromPlayerResponse resp;
        resp.errorCode = PlayerItemErrorCodeNoHandler;
        return resp;
    }

    return removeItemsWithGuidsFromPlayerHandler(player_guid, items_guids, items_guids_size, assign_player_guid);
}

static DestroyItemsWithGuidsFromPlayerHandler destroyItemsWithGuidsFromPlayerHandler;
void SetDestroyItemsWithGuidsFromPlayerHandler(DestroyItemsWithGuidsFromPlayerHandler h) {
    destroyItemsWithGuidsFromPlayerHandler = h;
}

DestroyItemsWithGuidsFromPlayerResponse CallDestroyItemsWithGuidsFromPlayerHandler(uint64_t player_guid, uint64_t* items_guids, int items_guids_size) {
    if (destroyItemsWithGuidsFromPlayerHandler == 0) {
        DestroyItemsWithGuidsFromPlayerResponse resp;
        resp.errorCode = PlayerItemErrorCodeNoHandler;
        resp.destroyedItems = 0;
        resp.destroyedItemsSize = 0;
        return resp;
    }

    return destroyItemsWithGuidsFromPlayerHandler(player_guid, items_guids, items_guids_size);
}

static AddExistingItemToPlayerHandler addExistingItemToPlayerHandler;
void SetAddExistingItemToPlayerHandler(AddExistingItemToPlayerHandler h) {
    addExistingItemToPlayerHandler = h;
}

PlayerItemErrorCode CallAddExistingItemToPlayerHandler(AddExistingItemToPlayerRequest *r) {
    if (addExistingItemToPlayerHandler == 0) {
        return PlayerItemErrorCodeNoHandler;
    }

    return addExistingItemToPlayerHandler(r);
}

static StoreNewItemHandler storeNewItemHandler;
void SetStoreNewItemHandler(StoreNewItemHandler h) {
    storeNewItemHandler = h;
}

StoreNewItemResponse CallStoreNewItemHandler(StoreNewItemRequest *r) {
    if (storeNewItemHandler == 0) {
        StoreNewItemResponse resp;
        resp.errorCode = PlayerItemErrorCodeNoHandler;
        resp.itemGuid = 0;
        return resp;
    }
    return storeNewItemHandler(r);
}

static SetItemPermanentEnchantmentHandler setItemPermanentEnchantmentHandler;
void SetSetItemPermanentEnchantmentHandler(SetItemPermanentEnchantmentHandler h) {
    setItemPermanentEnchantmentHandler = h;
}

SetItemPermanentEnchantmentResponse CallSetItemPermanentEnchantmentHandler(SetItemPermanentEnchantmentRequest *r) {
    if (setItemPermanentEnchantmentHandler == 0) {
        SetItemPermanentEnchantmentResponse resp;
        resp.errorCode = PlayerItemErrorCodeNoHandler;
        return resp;
    }
    return setItemPermanentEnchantmentHandler(r);
}
