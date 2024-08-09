#include "player-money-api.h"

static GetMoneyForPlayerHandler getMoneyForPlayerHandler;
void SetGetMoneyForPlayerHandler(GetMoneyForPlayerHandler h) {
    getMoneyForPlayerHandler = h;
}

GetMoneyForPlayerResponse CallGetMoneyForPlayerHandler(uint64_t player_guid) {
    if (getMoneyForPlayerHandler == 0) {
        GetMoneyForPlayerResponse resp;
        resp.errorCode = PlayerMoneyErrorCodeNoHandler;
        return resp;
    }

    return getMoneyForPlayerHandler(player_guid);
}

static ModifyMoneyForPlayerHandler modifyMoneyForPlayerHandler;
void SetModifyMoneyForPlayerHandler(ModifyMoneyForPlayerHandler h) {
    modifyMoneyForPlayerHandler = h;
}

ModifyMoneyForPlayerResponse CallModifyMoneyForPlayerHandler(uint64_t player_guid, int32_t amount) {
    if (modifyMoneyForPlayerHandler == 0) {
        ModifyMoneyForPlayerResponse resp;
        resp.errorCode = PlayerMoneyErrorCodeNoHandler;
        return resp;
    }

    return modifyMoneyForPlayerHandler(player_guid, amount);
}
