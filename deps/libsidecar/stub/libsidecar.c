#include "libsidecar.h"
#include <stdio.h>
#include <stdlib.h>

void panicWithTC9Unavailable(const char* message) {
    fprintf(stderr, "Tried to call '%s', but using stub for libsidecar. If your platform supported, use -DUSE_REAL_LIBSIDECAR=ON in cmake to use the real one.\n", message);
    exit(EXIT_FAILURE);
}

void TC9SetOnGuildMemberAddedHook(OnGuildMemberAddedHook h) { panicWithTC9Unavailable("TC9SetOnGuildMemberAddedHook"); }

// TC9SetOnGuildMemberRemovedHook sets hook for guild member removed (kicked) event.
void TC9SetOnGuildMemberRemovedHook(OnGuildMemberRemovedHook h) { panicWithTC9Unavailable("TC9SetOnGuildMemberRemovedHook"); }

// TC9SetOnGuildMemberLeftHook sets hook for guild member left event.
void TC9SetOnGuildMemberLeftHook(OnGuildMemberLeftHook h) { panicWithTC9Unavailable("TC9SetOnGuildMemberLeftHook"); }

// TC9ProcessEventsHooks calls all events hooks.
void TC9ProcessEventsHooks() { panicWithTC9Unavailable("TC9ProcessEventsHooks"); }

// TC9ProcessGRPCRequests calls all grpc handlers in queue.
//
void TC9ProcessGRPCRequests() { panicWithTC9Unavailable("TC9ProcessGRPCRequests"); }

// TC9GetNextAvailableCharacterGuid returns next available characters GUID. Thread unsafe.
GoUint64 TC9GetNextAvailableCharacterGuid() { panicWithTC9Unavailable("TC9GetNextAvailableCharacterGuid"); return 0; }

// TC9GetNextAvailableItemGuid returns next available item GUID. Thread unsafe.
GoUint64 TC9GetNextAvailableItemGuid() { panicWithTC9Unavailable("TC9GetNextAvailableItemGuid"); return 0; }

// TC9InitLib inits lib by starting services like grpc and healthcheck.
// Adds game server to the servers registry that will make this server visible for game load balancer.
//
void TC9InitLib(GoUint16 port, GoUint32 realmID, char* availableMaps) { panicWithTC9Unavailable("TC9InitLib"); }

// TC9GracefulShutdown gracefully stops all running services.
//
void TC9GracefulShutdown() { panicWithTC9Unavailable("TC9GracefulShutdown"); }

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
