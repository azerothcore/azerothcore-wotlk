#ifndef __EVENT_GUILD__
#define __EVENT_GUILD__

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

enum GuildHookStatus {
    GuildHookStatusOK = 0,
    GuildHookStatusNoHook = 1
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

// The hook must copy guild_name and member_guids, the caller frees them right after the call.
typedef void (*OnGuildCreatedHook) (uint64_t /*guild_id*/, char* /*guild_name*/, uint64_t /*leader_guid*/, uint64_t* /*member_guids*/, int /*member_guids_size*/);
void SetOnGuildCreatedHook(OnGuildCreatedHook h);
int CallOnGuildCreatedHook(uint64_t guild_id, char* guild_name, uint64_t leader_guid, uint64_t* member_guids, int member_guids_size);

#ifdef __cplusplus
}
#endif

#endif
