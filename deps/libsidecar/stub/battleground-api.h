#ifndef __BATTLEGROUND_API__
#define __BATTLEGROUND_API__

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

typedef enum BattlegroundErrorCode {
    BattlegroundErrorCodeNoError          = 0,
    BattlegroundErrorCodeNoHandler        = 1,
    BattlegroundErrorFailedToCreateBG     = 2,
    BattlegroundErrorBattlegroundNotFound = 3,
} BattlegroundErrorCode;

typedef struct {
    uint8_t battlegroundTypeID;
    uint32_t arenaType;
    bool isRated;
    uint32_t mapID;
    uint8_t bracketLvl;
    uint64_t *hordePlayersToAdd;
    int hordePlayersToAddSize;
    uint64_t *alliancePlayersToAdd;
    int alliancePlayersToAddSize;
    uint64_t *randomBGPlayers;
    int randomBGPlayersSize;
} BattlegroundStartRequest;

typedef struct {
    int errorCode;
    uint64_t instanceID;
    uint64_t instanceClientID;
} BattlegroundStartResponse;

typedef BattlegroundStartResponse (*BattlegroundStartHandler) (BattlegroundStartRequest* request);
void SetBattlegroundStartHandler(BattlegroundStartHandler h);
BattlegroundStartResponse CallBattlegroundStartHandler(BattlegroundStartRequest* request);

typedef struct {
    uint8_t battlegroundTypeID;
    uint64_t instanceID;
    uint64_t *hordePlayersToAdd;
    int hordePlayersToAddSize;
    uint64_t *alliancePlayersToAdd;
    int alliancePlayersToAddSize;
    uint64_t *randomBGPlayers;
    int randomBGPlayersSize;
} BattlegroundAddPlayersRequest;

typedef BattlegroundErrorCode (*BattlegroundAddPlayersHandler) (BattlegroundAddPlayersRequest* request);
void SetBattlegroundAddPlayersHandler(BattlegroundAddPlayersHandler h);
BattlegroundErrorCode CallBattlegroundAddPlayersHandler(BattlegroundAddPlayersRequest* request);

typedef enum BattlegroundJoinCheckErrorCode {
    BattlegroundJoinCheckErrorCodeOK = 0,
    BattlegroundJoinCheckErrorCodeNoHook = 1,
    BattlegroundJoinCheckErrorCodeResponseIsFalse = 2,
    BattlegroundJoinCheckErrorCodePlayerNotFound = 3,
} BattlegroundJoinCheckErrorCode;

typedef BattlegroundJoinCheckErrorCode (*CanPlayerJoinBattlegroundQueueHandler)(uint64_t playerGuid);
void SetCanPlayerJoinBattlegroundQueueHandler(CanPlayerJoinBattlegroundQueueHandler h);
BattlegroundJoinCheckErrorCode CallCanPlayerJoinBattlegroundQueueHandler(uint64_t playerGuid);

typedef BattlegroundJoinCheckErrorCode (*CanPlayerTeleportToBattlegroundHandler)(uint64_t playerGuid);
void SetCanPlayerTeleportToBattlegroundHandler(CanPlayerTeleportToBattlegroundHandler h);
BattlegroundJoinCheckErrorCode CallCanPlayerTeleportToBattlegroundHandler(uint64_t playerGuid);

#endif
