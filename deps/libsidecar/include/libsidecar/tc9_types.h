#ifndef TC9_TYPES_H
#define TC9_TYPES_H

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Error codes */
typedef enum TC9ErrorCode {
    TC9_ERROR_SUCCESS = 0,
    TC9_ERROR_INIT_FAILED = 1,
    TC9_ERROR_NO_HANDLER = 2,
    TC9_ERROR_PLAYER_NOT_FOUND = 3,
    TC9_ERROR_NO_INVENTORY_SPACE = 4,
    TC9_ERROR_UNKNOWN_TEMPLATE = 5,
    TC9_ERROR_FAILED_TO_CREATE_ITEM = 6,
    TC9_ERROR_CONNECTION_FAILED = 7,
    TC9_ERROR_UNKNOWN = 99
} TC9ErrorCode;

/* Player Item */
typedef struct TC9PlayerItem {
    uint64_t guid;
    uint32_t entry;
    uint64_t owner;
    uint8_t bagSlot;
    uint8_t slot;
    bool isTradable;
    uint32_t count;
    uint16_t flags;
    uint32_t durability;
    uint32_t randomPropertyID;
    const char* text;  /* Null-terminated string, caller owns memory */
} TC9PlayerItem;

/* Get Player Items Response */
typedef struct TC9GetPlayerItemsResponse {
    int errorCode;
    TC9PlayerItem* items;  /* Array of items, caller must free */
    int itemsSize;
} TC9GetPlayerItemsResponse;

/* Remove Items Response */
typedef struct TC9RemoveItemsResponse {
    int errorCode;
    uint64_t* updatedItems;  /* Array of updated item GUIDs, caller must free */
    int updatedItemsSize;
} TC9RemoveItemsResponse;

/* Item to Add */
typedef struct TC9ItemToAdd {
    uint64_t guid;
    uint32_t entry;
    uint32_t count;
    uint16_t flags;
    uint32_t durability;
    uint32_t randomPropertyID;
    const char* text;  /* Null-terminated string */
} TC9ItemToAdd;

/* Battleground Start Request */
typedef struct TC9BattlegroundStartRequest {
    uint8_t battlegroundTypeID;
    uint8_t arenaType;
    bool isRated;
    uint32_t mapID;
    uint8_t bracketLvl;

    uint64_t* hordePlayerGUIDs;
    int hordePlayerCount;

    uint64_t* alliancePlayerGUIDs;
    int alliancePlayerCount;
} TC9BattlegroundStartRequest;

/* Battleground Start Response */
typedef struct TC9BattlegroundStartResponse {
    uint64_t instanceID;
    uint64_t instanceClientID;
} TC9BattlegroundStartResponse;

/* Battleground Add Players Request */
typedef struct TC9BattlegroundAddPlayersRequest {
    uint8_t battlegroundTypeID;
    uint64_t instanceID;

    uint64_t* hordePlayerGUIDs;
    int hordePlayerCount;

    uint64_t* alliancePlayerGUIDs;
    int alliancePlayerCount;
} TC9BattlegroundAddPlayersRequest;

/*
 * Callback function types
 * These are registered by AzerothCore and called by libsidecar
 */

/* Get player items by GUIDs */
typedef TC9GetPlayerItemsResponse (*TC9GetPlayerItemsByGuidsHandler)(
    uint64_t playerGuid,
    uint64_t* itemGuids,
    int itemGuidsSize
);

/* Remove items from player */
typedef TC9RemoveItemsResponse (*TC9RemoveItemsWithGuidsFromPlayerHandler)(
    uint64_t playerGuid,
    uint64_t* itemGuids,
    int itemGuidsSize,
    uint64_t assignToPlayerGuid
);

/* Add existing item to player */
typedef TC9ErrorCode (*TC9AddExistingItemToPlayerHandler)(
    uint64_t playerGuid,
    TC9ItemToAdd* item
);

/* Get money for player */
typedef uint32_t (*TC9GetMoneyForPlayerHandler)(
    uint64_t playerGuid,
    int* errorCode  /* OUT: error code */
);

/* Modify money for player */
typedef uint32_t (*TC9ModifyMoneyForPlayerHandler)(
    uint64_t playerGuid,
    int32_t value,
    int* errorCode  /* OUT: error code */
);

/* Can player interact with NPC */
typedef bool (*TC9CanPlayerInteractWithNPCHandler)(
    uint64_t playerGuid,
    uint64_t npcGuid,
    uint32_t npcFlags,
    int* errorCode  /* OUT: error code */
);

/* Can player interact with GameObject */
typedef bool (*TC9CanPlayerInteractWithGOHandler)(
    uint64_t playerGuid,
    uint64_t goGuid,
    uint8_t goType,
    int* errorCode  /* OUT: error code */
);

/* Start battleground */
typedef TC9BattlegroundStartResponse (*TC9StartBattlegroundHandler)(
    TC9BattlegroundStartRequest* request,
    int* errorCode  /* OUT: error code */
);

/* Add players to battleground */
typedef TC9ErrorCode (*TC9AddPlayersToBattlegroundHandler)(
    TC9BattlegroundAddPlayersRequest* request
);

/* Can player join battleground queue */
typedef TC9ErrorCode (*TC9CanPlayerJoinBattlegroundQueueHandler)(
    uint64_t playerGuid
);

/* Can player teleport to battleground */
typedef TC9ErrorCode (*TC9CanPlayerTeleportToBattlegroundHandler)(
    uint64_t playerGuid
);

/* Monitoring error codes */
typedef enum TC9MonitoringErrorCode {
    TC9_MONITORING_ERROR_NO_ERROR = 0,
    TC9_MONITORING_ERROR_NO_HANDLER = 1
} TC9MonitoringErrorCode;

/* Monitoring data response */
typedef struct TC9MonitoringDataCollectorResponse {
    int errorCode;
    uint32_t connectedPlayers;
    uint32_t diffMean;
    uint32_t diffMedian;
    uint32_t diff95Percentile;
    uint32_t diff99Percentile;
    uint32_t diffMaxPercentile;
} TC9MonitoringDataCollectorResponse;

/* Monitoring data collector handler */
typedef TC9MonitoringDataCollectorResponse (*TC9MonitoringDataCollectorHandler)(void);

#ifdef __cplusplus
}
#endif

#endif /* TC9_TYPES_H */
