#ifndef __EVENT_GUILD__
#define __EVENT_GUILD__

#include <stdint.h>

enum CallStatus {
    OK = 0,
    NoHook = 1
};

typedef void (*OnGuildMemberAddedHook) (uint64_t /*guild_id*/, uint64_t /*player_guid*/);
void SetOnGuildMemberAddedHook(OnGuildMemberAddedHook h);
int CallOnGuildMemberAddedHook(uint64_t guild_id, uint64_t player_guid);

typedef void (*OnGuildMemberLeftHook) (uint64_t /*guild_id*/, uint64_t /*player_guid*/);
void SetOnGuildMemberLeftHook(OnGuildMemberLeftHook h);
int CallOnGuildMemberLeftHook(uint64_t guild_id, uint64_t player_guid);

typedef void (*OnGuildMemberRemovedHook) (uint64_t /*guild_id*/, uint64_t /*player_guid*/);
void SetOnGuildMemberRemovedHook(OnGuildMemberRemovedHook h);
int CallOnGuildMemberRemovedHook(uint64_t guild_id, uint64_t player_guid);

#endif
