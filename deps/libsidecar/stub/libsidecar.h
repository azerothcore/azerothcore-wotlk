#include <stddef.h>

#include "events-guild.h"
#include "player-interactions-api.h"
#include "player-items-api.h"
#include "player-money-api.h"

#ifndef GO_CGO_PROLOGUE_H
#define GO_CGO_PROLOGUE_H

typedef signed char GoInt8;
typedef unsigned char GoUint8;
typedef short GoInt16;
typedef unsigned short GoUint16;
typedef int GoInt32;
typedef unsigned int GoUint32;
typedef long long GoInt64;
typedef unsigned long long GoUint64;
typedef GoInt64 GoInt;
typedef GoUint64 GoUint;
typedef size_t GoUintptr;
typedef float GoFloat32;
typedef double GoFloat64;

/*
  static assertion to make sure the file is being used on architecture
  at least with matching size of GoInt.
*/
typedef char _check_for_64_bit_pointer_matching_GoInt[sizeof(void*)==64/8 ? 1:-1];

typedef void *GoMap;
typedef void *GoChan;
typedef struct { void *t; void *v; } GoInterface;
typedef struct { void *data; GoInt len; GoInt cap; } GoSlice;

#endif

/* End of boilerplate cgo prologue.  */

#ifdef __cplusplus
extern "C" {
#endif

// TC9SetOnGuildMemberAddedHook sets hook for guild member added event.
void TC9SetOnGuildMemberAddedHook(OnGuildMemberAddedHook h);

// TC9SetOnGuildMemberRemovedHook sets hook for guild member removed (kicked) event.
void TC9SetOnGuildMemberRemovedHook(OnGuildMemberRemovedHook h);

// TC9SetOnGuildMemberLeftHook sets hook for guild member left event.
void TC9SetOnGuildMemberLeftHook(OnGuildMemberLeftHook h);

// TC9ProcessEventsHooks calls all events hooks.
void TC9ProcessEventsHooks();

// TC9ProcessGRPCRequests calls all grpc handlers in queue.
//
void TC9ProcessGRPCRequests();

// TC9GetNextAvailableCharacterGuid returns next available characters GUID. Thread unsafe.
GoUint64 TC9GetNextAvailableCharacterGuid();

// TC9GetNextAvailableItemGuid returns next available item GUID. Thread unsafe.
GoUint64 TC9GetNextAvailableItemGuid();

// TC9InitLib inits lib by starting services like grpc and healthcheck.
// Adds game server to the servers registry that will make this server visible for game load balancer.
//
void TC9InitLib(GoUint16 port, GoUint32 realmID, char* availableMaps);

// TC9GracefulShutdown gracefully stops all running services.
//
void TC9GracefulShutdown();

// TC9SetCanPlayerInteractWithNPCAndFlagsHandler sets handler for can player interact with NPC and with given NPC flags request.
//
void TC9SetCanPlayerInteractWithNPCAndFlagsHandler(CanPlayerInteractWithNPCAndFlagsHandler h);

// TC9SetCanPlayerInteractWithGOAndTypeHandler sets handler for can player interact with GameObject and with given object type request.
//
void TC9SetCanPlayerInteractWithGOAndTypeHandler(CanPlayerInteractWithGOAndTypeHandler h);

// TC9SetGetPlayerItemsByGuidsHandler sets handler for getting players item by guids request.
void TC9SetGetPlayerItemsByGuidsHandler(GetPlayerItemsByGuidsHandler h);

// TC9SetRemoveItemsWithGuidsFromPlayerHandler sets handler for removing items by guids from player request.
void TC9SetRemoveItemsWithGuidsFromPlayerHandler(RemoveItemsWithGuidsFromPlayerHandler h);

// TC9SetAddExistingItemToPlayerHandler sets handler for adding item to player request.
void TC9SetAddExistingItemToPlayerHandler(AddExistingItemToPlayerHandler h);

// TC9SetGetMoneyForPlayerHandler sets handler for getting money for player request.
//
void TC9SetGetMoneyForPlayerHandler(GetMoneyForPlayerHandler h);

// TC9SetModifyMoneyForPlayerHandler sets handler for modify money for given player request.
//
void TC9SetModifyMoneyForPlayerHandler(ModifyMoneyForPlayerHandler h);

#ifdef __cplusplus
}
#endif
