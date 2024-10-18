#include "libsidecar.h"
#include <stdio.h>
#include <stdlib.h>

void panicWithTC9Unavailable(const char* message) {
    fprintf(stderr, "Tried to call '%s', but using stub for libsidecar. If your platform supported, use -DUSE_REAL_LIBSIDECAR=ON in cmake to use the real one.\n", message);
    exit(EXIT_FAILURE);
}

void TC9SetOnGroupCreatedHook(OnGroupCreatedHook h) { panicWithTC9Unavailable("TC9SetOnGroupCreatedHook"); }

// TC9SetOnGroupMemberAddedHook sets hook for member added event.
//
void TC9SetOnGroupMemberAddedHook(OnGroupMemberAddedHook h)  { panicWithTC9Unavailable("TC9SetOnGroupMemberAddedHook"); }

// TC9SetOnGroupMemberRemovedHook sets hook for member left/kicked event.
//
void TC9SetOnGroupMemberRemovedHook(OnGroupMemberRemovedHook h) { panicWithTC9Unavailable("TC9SetOnGroupMemberRemovedHook"); }

// TC9SetOnGroupDisbandedHook sets hook for group disbanded event.
//
void TC9SetOnGroupDisbandedHook(OnGroupDisbandedHook h) { panicWithTC9Unavailable("TC9SetOnGroupDisbandedHook"); }

// TC9SetOnGroupLootTypeChangedHook sets hook for group loot type changed event.
//
void TC9SetOnGroupLootTypeChangedHook(OnGroupLootTypeChangedHook h) { panicWithTC9Unavailable("TC9SetOnGroupLootTypeChangedHook"); }

// TC9SetOnGroupDungeonDifficultyChangedHook sets hook for group dungeon difficulty changed event.
//
void TC9SetOnGroupDungeonDifficultyChangedHook(OnGroupDungeonDifficultyChangedHook h) { panicWithTC9Unavailable("TC9SetOnGroupDungeonDifficultyChangedHook"); }

// TC9SetOnGroupRaidDifficultyChangedHook sets hook for group raid difficulty changed event.
//
void TC9SetOnGroupRaidDifficultyChangedHook(OnGroupRaidDifficultyChangedHook h) { panicWithTC9Unavailable("TC9SetOnGroupRaidDifficultyChangedHook"); }

// TC9SetOnGroupConvertedToRaidHook sets hook for group converted to raid event.
//
void TC9SetOnGroupConvertedToRaidHook(OnGroupConvertedToRaidHook h) { panicWithTC9Unavailable("TC9SetOnGroupConvertedToRaidHook"); }

void TC9SetOnGuildMemberAddedHook(OnGuildMemberAddedHook h) { panicWithTC9Unavailable("TC9SetOnGuildMemberAddedHook"); }

// TC9SetOnGuildMemberRemovedHook sets hook for guild member removed (kicked) event.
void TC9SetOnGuildMemberRemovedHook(OnGuildMemberRemovedHook h) { panicWithTC9Unavailable("TC9SetOnGuildMemberRemovedHook"); }

// TC9SetOnGuildMemberLeftHook sets hook for guild member left event.
void TC9SetOnGuildMemberLeftHook(OnGuildMemberLeftHook h) { panicWithTC9Unavailable("TC9SetOnGuildMemberLeftHook"); }

// TC9ProcessEventsHooks calls all events hooks.
void TC9ProcessEventsHooks() { panicWithTC9Unavailable("TC9ProcessEventsHooks"); }

// TC9ProcessGRPCOrHTTPRequests calls all grpc or http handlers in queue.
//
void TC9ProcessGRPCOrHTTPRequests() { panicWithTC9Unavailable("TC9ProcessGRPCOrHTTPRequests"); }

// TC9GetNextAvailableCharacterGuid returns next available characters GUID. Thread unsafe.
GoUint64 TC9GetNextAvailableCharacterGuid() { panicWithTC9Unavailable("TC9GetNextAvailableCharacterGuid"); return 0; }

// TC9GetNextAvailableItemGuid returns next available item GUID. Thread unsafe.
GoUint64 TC9GetNextAvailableItemGuid() { panicWithTC9Unavailable("TC9GetNextAvailableItemGuid"); return 0; }

// TC9GetNextAvailableInstanceGuid returns next available dungeon/raid instance GUID. Thread unsafe.
GoUint64 TC9GetNextAvailableInstanceGuid() { panicWithTC9Unavailable("TC9GetNextAvailableInstanceGuid"); return 0; }

// TC9InitLib inits lib by starting services like grpc and healthcheck.
// Adds game server to the servers registry that will make this server visible for game load balancer.
//
void TC9InitLib(GoUint16 port, GoUint32 realmID, char* availableMaps, uint32_t** assignedMaps, int* assignedMapsSize) { panicWithTC9Unavailable("TC9InitLib"); }

// TC9GracefulShutdown gracefully stops all running services.
//
void TC9GracefulShutdown() { panicWithTC9Unavailable("TC9GracefulShutdown"); }

// TC9ReadyToAcceptPlayersFromMaps notifies servers registry that this server
// loaded maps related data and ready to accept players from those maps.
//
void TC9ReadyToAcceptPlayersFromMaps(uint32_t* maps, int mapsLen) { panicWithTC9Unavailable("TC9GracefulShutdown"); }

// TC9SetCanPlayerInteractWithNPCAndFlagsHandler sets handler for can player interact with NPC and with given NPC flags request.
//
void TC9SetCanPlayerInteractWithNPCAndFlagsHandler(CanPlayerInteractWithNPCAndFlagsHandler h) { panicWithTC9Unavailable("TC9SetCanPlayerInteractWithNPCAndFlagsHandler"); }

// TC9SetCanPlayerInteractWithGOAndTypeHandler sets handler for can player interact with GameObject and with given object type request.
//
void TC9SetCanPlayerInteractWithGOAndTypeHandler(CanPlayerInteractWithGOAndTypeHandler h) { panicWithTC9Unavailable("TC9SetCanPlayerInteractWithGOAndTypeHandler"); }

// TC9SetGetPlayerItemsByGuidsHandler sets handler for getting players item by guids request.
void TC9SetGetPlayerItemsByGuidsHandler(GetPlayerItemsByGuidsHandler h) { panicWithTC9Unavailable("TC9SetGetPlayerItemsByGuidsHandler"); }

// TC9SetRemoveItemsWithGuidsFromPlayerHandler sets handler for removing items by guids from player request.
void TC9SetRemoveItemsWithGuidsFromPlayerHandler(RemoveItemsWithGuidsFromPlayerHandler h) { panicWithTC9Unavailable("TC9SetRemoveItemsWithGuidsFromPlayerHandler"); }

// TC9SetAddExistingItemToPlayerHandler sets handler for adding item to player request.
void TC9SetAddExistingItemToPlayerHandler(AddExistingItemToPlayerHandler h) { panicWithTC9Unavailable("TC9SetAddExistingItemToPlayerHandler"); }

// TC9SetGetMoneyForPlayerHandler sets handler for getting money for player request.
//
void TC9SetGetMoneyForPlayerHandler(GetMoneyForPlayerHandler h) { panicWithTC9Unavailable("TC9SetGetMoneyForPlayerHandler"); }

// TC9SetModifyMoneyForPlayerHandler sets handler for modify money for given player request.
//
void TC9SetModifyMoneyForPlayerHandler(ModifyMoneyForPlayerHandler h) { panicWithTC9Unavailable("TC9SetModifyMoneyForPlayerHandler"); }


// TC9SetOnMapsReassignedHook sets hook for maps reassigning by servers registry event.
//
void TC9SetOnMapsReassignedHook(OnMapsReassignedHook h) { panicWithTC9Unavailable("TC9SetOnMapsReassignedHook"); }

// TC9SetMonitoringDataCollectorHandler sets handler for getting data to handle monitoring request.
//
void TC9SetMonitoringDataCollectorHandler(MonitoringDataCollectorHandler h) { panicWithTC9Unavailable("TC9SetOnMapsReassignedHook"); }

