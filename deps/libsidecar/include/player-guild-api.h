#ifndef __PLAYER_GUILD_API__
#define __PLAYER_GUILD_API__

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum PlayerGuildErrorCode {
    PlayerGuildErrorCodeNoError   = 0,
    PlayerGuildErrorCodeNoHandler = 1,
} PlayerGuildErrorCode;

// SetPlayerGuildFields request: refreshes PLAYER_GUILDID / PLAYER_GUILDRANK on
// a live player object so the client re-arms the guild control UI without a
// relog. applied is false when the player is not online on this worldserver.
typedef struct {
    int errorCode;
    bool applied;
} SetPlayerGuildFieldsResponse;

typedef SetPlayerGuildFieldsResponse (*SetPlayerGuildFieldsHandler) (uint64_t /*player_guid*/, uint32_t /*guild_id*/, uint32_t /*rank*/);
void SetSetPlayerGuildFieldsHandler(SetPlayerGuildFieldsHandler h);
SetPlayerGuildFieldsResponse CallSetPlayerGuildFieldsHandler(uint64_t player_guid, uint32_t guild_id, uint32_t rank);

#ifdef __cplusplus
}
#endif

#endif
