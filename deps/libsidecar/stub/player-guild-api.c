#include "player-guild-api.h"

static SetPlayerGuildFieldsHandler setPlayerGuildFieldsHandler;
void SetSetPlayerGuildFieldsHandler(SetPlayerGuildFieldsHandler h) {
    setPlayerGuildFieldsHandler = h;
}

SetPlayerGuildFieldsResponse CallSetPlayerGuildFieldsHandler(uint64_t player_guid, uint32_t guild_id, uint32_t rank) {
    if (setPlayerGuildFieldsHandler == 0) {
        SetPlayerGuildFieldsResponse resp = {0};
        resp.errorCode = PlayerGuildErrorCodeNoHandler;
        return resp;
    }

    return setPlayerGuildFieldsHandler(player_guid, guild_id, rank);
}
