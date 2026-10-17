#ifndef __PLAYER_INTERACTIONS_API__
#define __PLAYER_INTERACTIONS_API__

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

typedef enum PlayerInteractionErrorCode {
    PlayerInteractionErrorCodeNoError            = 0,
    PlayerInteractionErrorCodeNoHandler          = 1,
    PlayerInteractionErrorCodeCodePlayerNotFound = 2,
} PlayerInteractionErrorCode;

// CanPlayerInteractWithNPCAndFlags request.
typedef struct {
    int  errorCode;
    bool canInteract;
} CanPlayerInteractWithNPCAndFlagsResponse;

typedef CanPlayerInteractWithNPCAndFlagsResponse (*CanPlayerInteractWithNPCAndFlagsHandler) (uint64_t /*playerGUID*/, uint64_t /*npcGUID*/, uint32_t /*npcFlags*/);
void SetCanPlayerInteractWithNPCAndFlagsHandler(CanPlayerInteractWithNPCAndFlagsHandler h);
CanPlayerInteractWithNPCAndFlagsResponse CallCanPlayerInteractWithNPCAndFlagsHandler(uint64_t player_guid, uint64_t npc_guid, uint32_t npc_flags);

// CanPlayerInteractWithGOAndType request.
typedef struct {
    int  errorCode;
    bool canInteract;
} CanPlayerInteractWithGOAndTypeResponse;

typedef CanPlayerInteractWithGOAndTypeResponse (*CanPlayerInteractWithGOAndTypeHandler) (uint64_t /*playerGUID*/, uint64_t /*goGUID*/, uint8_t /*goType*/);
void SetCanPlayerInteractWithGOAndTypeHandler(CanPlayerInteractWithGOAndTypeHandler h);
CanPlayerInteractWithGOAndTypeResponse CallCanPlayerInteractWithGOAndTypeHandler(uint64_t player_guid, uint64_t go_guid, uint8_t go_type);

#endif
