#ifndef __PLAYER_MONEY_API__
#define __PLAYER_MONEY_API__

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

typedef enum PlayerMoneyErrorCode {
    PlayerMoneyErrorCodeNoError        = 0,
    PlayerMoneyErrorCodeNoHandler      = 1,
    PlayerMoneyErrorCodePlayerNotFound = 2,
    PlayerMoneyErrorCodeToMuchMoney    = 3,
} PlayerMoneyErrorCode;

// GetMoneyForPlayer request.
typedef struct {
    int errorCode;
    uint32_t money;
} GetMoneyForPlayerResponse;

typedef GetMoneyForPlayerResponse (*GetMoneyForPlayerHandler) (uint64_t /*player_guid*/);
void SetGetMoneyForPlayerHandler(GetMoneyForPlayerHandler h);
GetMoneyForPlayerResponse CallGetMoneyForPlayerHandler(uint64_t player_guid);

// ModifyMoneyForPlayer request.
typedef struct {
    int errorCode;
    uint32_t newMoneyValue;
} ModifyMoneyForPlayerResponse;

typedef ModifyMoneyForPlayerResponse (*ModifyMoneyForPlayerHandler) (uint64_t /*player_guid*/, int32_t /*amount*/);
void SetModifyMoneyForPlayerHandler(ModifyMoneyForPlayerHandler h);
ModifyMoneyForPlayerResponse CallModifyMoneyForPlayerHandler(uint64_t player_guid, int32_t amount);

#endif
