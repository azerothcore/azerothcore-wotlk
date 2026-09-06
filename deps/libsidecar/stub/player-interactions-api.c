#include "player-interactions-api.h"

static CanPlayerInteractWithNPCAndFlagsHandler canPlayerInteractWithNPCAndFlagsHandler;
void SetCanPlayerInteractWithNPCAndFlagsHandler(CanPlayerInteractWithNPCAndFlagsHandler h) {
    canPlayerInteractWithNPCAndFlagsHandler = h;
}

CanPlayerInteractWithNPCAndFlagsResponse CallCanPlayerInteractWithNPCAndFlagsHandler(uint64_t player_guid, uint64_t npc_guid, uint32_t npc_flags) {
    if (canPlayerInteractWithNPCAndFlagsHandler == 0) {
        CanPlayerInteractWithNPCAndFlagsResponse resp;
        resp.errorCode = PlayerInteractionErrorCodeNoHandler;
        return resp;
    }

    return canPlayerInteractWithNPCAndFlagsHandler(player_guid, npc_guid, npc_flags);
}

static CanPlayerInteractWithGOAndTypeHandler canPlayerInteractWithGOAndTypeHandler;
void SetCanPlayerInteractWithGOAndTypeHandler(CanPlayerInteractWithGOAndTypeHandler h) {
    canPlayerInteractWithGOAndTypeHandler = h;
}

CanPlayerInteractWithGOAndTypeResponse CallCanPlayerInteractWithGOAndTypeHandler(uint64_t player_guid, uint64_t go_guid, uint8_t go_type) {
    if (canPlayerInteractWithGOAndTypeHandler == 0) {
        CanPlayerInteractWithGOAndTypeResponse resp;
        resp.errorCode = PlayerInteractionErrorCodeNoHandler;
        return resp;
    }

    return canPlayerInteractWithGOAndTypeHandler(player_guid, go_guid, go_type);
}
