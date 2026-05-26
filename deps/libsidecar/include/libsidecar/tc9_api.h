#ifndef TC9_API_H
#define TC9_API_H

#include "tc9_types.h"
#include "tc9_events.h"

#ifdef __cplusplus
extern "C" {
#endif

/* DLL export/import macros */
#if defined(_WIN32) || defined(__CYGWIN__)
    #ifdef TC9_BUILDING_DLL
        #define TC9_API __declspec(dllexport)
    #else
        #define TC9_API __declspec(dllimport)
    #endif
#else
    #define TC9_API __attribute__((visibility("default")))
#endif

/*
 * Library Initialization and Shutdown
 */

/**
 * Initialize libsidecar and all services.
 *
 * @param port Game server port
 * @param realmID Realm ID
 * @param isCrossRealm Whether this is a cross-realm server
 * @param availableMaps Comma-separated list of available map IDs (e.g., "0,1,530")
 * @param assignedMaps OUT: Array of assigned map IDs (caller must free with free())
 * @param assignedMapsSize OUT: Number of assigned maps
 * @return TC9_ERROR_SUCCESS on success, error code on failure
 *
 * This function:
 * - Loads configuration from environment variables
 * - Connects to NATS, servers-registry, GUID provider, matchmaking
 * - Starts gRPC server, HTTP health server
 * - Registers game server with registry
 * - Returns assigned maps
 *
 * Must be called before any other TC9 functions.
 */
TC9_API int TC9InitLib(
    uint16_t port,
    uint32_t realmID,
    bool isCrossRealm,
    const char* availableMaps,
    uint32_t** assignedMaps,
    int* assignedMapsSize
);

/**
 * Gracefully shutdown libsidecar and cleanup all resources.
 *
 * Stops all services, closes connections, and frees resources.
 * Should be called before process exit.
 */
TC9_API void TC9GracefulShutdown(void);

/*
 * Request Processing
 */

/**
 * Process queued gRPC and HTTP requests.
 *
 * This function:
 * 1. Processes all read requests in parallel using thread pool
 * 2. Processes all write requests sequentially
 *
 * Must be called regularly from the main game loop.
 */
TC9_API void TC9ProcessGRPCOrHTTPRequests(void);

/**
 * Process queued NATS event hooks.
 *
 * Processes events from NATS (guild, group, server registry events).
 * Must be called regularly from the main game loop.
 */
TC9_API void TC9ProcessEventsHooks(void);

/*
 * GUID Generation
 */

/**
 * Get next available character GUID.
 *
 * Thread unsafe - must be called from main thread only.
 * Fast path with no atomic operations (~10ns per call).
 *
 * @param realmID Realm ID, or 0 to use default realm
 * @return Next character GUID, or 0 on error
 */
TC9_API uint64_t TC9GetNextAvailableCharacterGuid(uint32_t realmID);

/**
 * Get next available item GUID.
 *
 * THREAD SAFE - can be called from multiple threads concurrently.
 * Uses atomic operations (~50ns per call).
 *
 * @param realmID Realm ID, or 0 to use default realm
 * @return Next item GUID, or 0 on error
 */
TC9_API uint64_t TC9GetNextAvailableItemGuid(uint32_t realmID);

/**
 * Get next available instance (dungeon/raid) GUID.
 *
 * Thread unsafe - must be called from main thread only.
 * Fast path with no atomic operations (~10ns per call).
 *
 * @param realmID Realm ID, or 0 to use default realm
 * @return Next instance GUID, or 0 on error
 */
TC9_API uint64_t TC9GetNextAvailableInstanceGuid(uint32_t realmID);

/*
 * Map Loading Notification
 */

/**
 * Notify servers-registry that maps have been loaded and server is ready.
 *
 * @param maps Array of loaded map IDs
 * @param mapsLen Number of maps in array
 *
 * This is an async notification. Should be called after loading map data.
 */
TC9_API void TC9ReadyToAcceptPlayersFromMaps(
    uint32_t* maps,
    int mapsLen
);

/*
 * Matchmaking Notifications
 */

/**
 * Notify matchmaking service that a player left a battleground.
 *
 * @param playerGUID Player's GUID
 * @param realmID Realm ID
 * @param instanceID Battleground instance ID
 *
 * This is an async notification.
 */
TC9_API void TC9PlayerLeftBattleground(
    uint64_t playerGUID,
    uint32_t realmID,
    uint32_t instanceID
);

/**
 * Notify matchmaking service that battleground status changed.
 *
 * @param instanceID Battleground instance ID
 * @param status New status (0=Progress, 1=WaitJoin, 2=InProgress, 3=Finished)
 *
 * This is an async notification.
 */
TC9_API void TC9BattlegroundStatusChanged(
    uint32_t instanceID,
    uint8_t status
);

/*
 * Callback Handler Registration
 *
 * These functions register AzerothCore handlers that will be called
 * when gRPC requests are processed.
 *
 * All handlers must be registered before calling TC9InitLib.
 */

/**
 * Register handler for GetPlayerItemsByGuids requests.
 */
TC9_API void TC9SetGetPlayerItemsByGuidsHandler(
    TC9GetPlayerItemsByGuidsHandler handler
);

/**
 * Register handler for RemoveItemsWithGuidsFromPlayer requests.
 */
TC9_API void TC9SetRemoveItemsWithGuidsFromPlayerHandler(
    TC9RemoveItemsWithGuidsFromPlayerHandler handler
);

/**
 * Register handler for AddExistingItemToPlayer requests.
 */
TC9_API void TC9SetAddExistingItemToPlayerHandler(
    TC9AddExistingItemToPlayerHandler handler
);

/**
 * Register handler for GetMoneyForPlayer requests.
 */
TC9_API void TC9SetGetMoneyForPlayerHandler(
    TC9GetMoneyForPlayerHandler handler
);

/**
 * Register handler for ModifyMoneyForPlayer requests.
 */
TC9_API void TC9SetModifyMoneyForPlayerHandler(
    TC9ModifyMoneyForPlayerHandler handler
);

/**
 * Register handler for CanPlayerInteractWithNPC requests.
 */
TC9_API void TC9SetCanPlayerInteractWithNPCHandler(
    TC9CanPlayerInteractWithNPCHandler handler
);

/**
 * Register handler for CanPlayerInteractWithGameObject requests.
 */
TC9_API void TC9SetCanPlayerInteractWithGOHandler(
    TC9CanPlayerInteractWithGOHandler handler
);

/**
 * Register handler for StartBattleground requests.
 */
TC9_API void TC9SetStartBattlegroundHandler(
    TC9StartBattlegroundHandler handler
);

/**
 * Register handler for AddPlayersToBattleground requests.
 */
TC9_API void TC9SetAddPlayersToBattlegroundHandler(
    TC9AddPlayersToBattlegroundHandler handler
);

/**
 * Register handler for CanPlayerJoinBattlegroundQueue requests.
 */
TC9_API void TC9SetCanPlayerJoinBattlegroundQueueHandler(
    TC9CanPlayerJoinBattlegroundQueueHandler handler
);

/**
 * Register handler for CanPlayerTeleportToBattleground requests.
 */
TC9_API void TC9SetCanPlayerTeleportToBattlegroundHandler(
    TC9CanPlayerTeleportToBattlegroundHandler handler
);

/*
 * Event Hook Registration
 *
 * These functions register callbacks for NATS events (group, guild, registry).
 * The hooks are called when TC9ProcessEventsHooks() processes queued events.
 *
 * All hooks must be registered before calling TC9InitLib.
 */

/**
 * Register hook for GroupCreated events.
 */
TC9_API void TC9SetOnGroupCreatedHook(TC9OnGroupCreatedHook hook);

/**
 * Register hook for GroupMemberAdded events.
 */
TC9_API void TC9SetOnGroupMemberAddedHook(TC9OnGroupMemberAddedHook hook);

/**
 * Register hook for GroupMemberRemoved events.
 */
TC9_API void TC9SetOnGroupMemberRemovedHook(TC9OnGroupMemberRemovedHook hook);

/**
 * Register hook for GroupDisbanded events.
 */
TC9_API void TC9SetOnGroupDisbandedHook(TC9OnGroupDisbandedHook hook);

/**
 * Register hook for GroupLootTypeChanged events.
 */
TC9_API void TC9SetOnGroupLootTypeChangedHook(TC9OnGroupLootTypeChangedHook hook);

/**
 * Register hook for GroupDungeonDifficultyChanged events.
 */
TC9_API void TC9SetOnGroupDungeonDifficultyChangedHook(TC9OnGroupDungeonDifficultyChangedHook hook);

/**
 * Register hook for GroupRaidDifficultyChanged events.
 */
TC9_API void TC9SetOnGroupRaidDifficultyChangedHook(TC9OnGroupRaidDifficultyChangedHook hook);

/**
 * Register hook for GroupConvertedToRaid events.
 */
TC9_API void TC9SetOnGroupConvertedToRaidHook(TC9OnGroupConvertedToRaidHook hook);

/**
 * Register hook for GuildMemberAdded events.
 */
TC9_API void TC9SetOnGuildMemberAddedHook(TC9OnGuildMemberAddedHook hook);

/**
 * Register hook for GuildMemberLeft events.
 */
TC9_API void TC9SetOnGuildMemberLeftHook(TC9OnGuildMemberLeftHook hook);

/**
 * Register hook for GuildMemberRemoved events.
 */
TC9_API void TC9SetOnGuildMemberRemovedHook(TC9OnGuildMemberRemovedHook hook);

/**
 * Register hook for MapsReassigned events from servers-registry.
 */
TC9_API void TC9SetOnMapsReassignedHook(TC9OnMapsReassignedHook hook);

/*
 * Monitoring Data Collector
 *
 * Register a handler that collects real-time monitoring metrics from AzerothCore.
 * This handler is called via HTTP endpoint to provide metrics for Prometheus.
 *
 * The handler should return:
 * - connectedPlayers: Number of currently connected players
 * - diffMean: Mean network latency in milliseconds
 * - diffMedian: Median network latency in milliseconds
 * - diff95Percentile: 95th percentile latency in milliseconds
 * - diff99Percentile: 99th percentile latency in milliseconds
 * - diffMaxPercentile: Maximum latency in milliseconds
 *
 * Must be registered before calling TC9InitLib.
 */

/**
 * Register handler for collecting monitoring metrics.
 */
TC9_API void TC9SetMonitoringDataCollectorHandler(TC9MonitoringDataCollectorHandler handler);

#ifdef __cplusplus
}
#endif

#endif /* TC9_API_H */
