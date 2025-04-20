#include "battleground-api.h"

static BattlegroundStartHandler battlegroundStartHandler;
void SetBattlegroundStartHandler(BattlegroundStartHandler h) {
    battlegroundStartHandler = h;
}

BattlegroundStartResponse CallBattlegroundStartHandler(BattlegroundStartRequest* request) {
    if (battlegroundStartHandler == 0) {
        BattlegroundStartResponse resp;
        resp.errorCode = BattlegroundErrorCodeNoHandler;
        return resp;
    }

    return battlegroundStartHandler(request);
}

static BattlegroundAddPlayersHandler battlegroundAddPlayersHandler;
void SetBattlegroundAddPlayersHandler(BattlegroundAddPlayersHandler h) {
    battlegroundAddPlayersHandler = h;
}

BattlegroundErrorCode CallBattlegroundAddPlayersHandler(BattlegroundAddPlayersRequest* request) {
    if (battlegroundAddPlayersHandler == 0) {
        return BattlegroundErrorCodeNoHandler;
    }

    return battlegroundAddPlayersHandler(request);
}

static CanPlayerJoinBattlegroundQueueHandler canPlayerJoinBattlegroundQueueHandler = 0;

void SetCanPlayerJoinBattlegroundQueueHandler(CanPlayerJoinBattlegroundQueueHandler h) {
    canPlayerJoinBattlegroundQueueHandler = h;
}

BattlegroundJoinCheckErrorCode CallCanPlayerJoinBattlegroundQueueHandler(uint64_t playerGuid) {
    if (canPlayerJoinBattlegroundQueueHandler == 0) {
        return BattlegroundJoinCheckErrorCodeNoHook;
    }
    return canPlayerJoinBattlegroundQueueHandler(playerGuid);
}

static CanPlayerTeleportToBattlegroundHandler canPlayerTeleportToBattlegroundHandler = 0;

void SetCanPlayerTeleportToBattlegroundHandler(CanPlayerTeleportToBattlegroundHandler h) {
    canPlayerTeleportToBattlegroundHandler = h;
}

BattlegroundJoinCheckErrorCode CallCanPlayerTeleportToBattlegroundHandler(uint64_t playerGuid) {
    if (canPlayerTeleportToBattlegroundHandler == 0) {
        return BattlegroundJoinCheckErrorCodeNoHook;
    }
    return canPlayerTeleportToBattlegroundHandler(playerGuid);
}