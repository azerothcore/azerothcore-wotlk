#include "events-guild.h"

// GuildMemberAddedHook
OnGuildMemberAddedHook guildMemberAddedHook;
void SetOnGuildMemberAddedHook(OnGuildMemberAddedHook h) {
    guildMemberAddedHook = h;
}

int CallOnGuildMemberAddedHook(uint64_t guild_id, uint64_t player_guid) {
    if (guildMemberAddedHook == 0) {
        return GuildHookStatusNoHook;
    }
    guildMemberAddedHook(guild_id, player_guid);
    return GuildHookStatusOK;
}

// GuildMemberLeft
static OnGuildMemberLeftHook guildMemberLeftHook;
void SetOnGuildMemberLeftHook(OnGuildMemberLeftHook h) {
    guildMemberLeftHook = h;
}

int CallOnGuildMemberLeftHook(uint64_t guild_id, uint64_t player_guid) {
    if (guildMemberLeftHook == 0) {
        return GuildHookStatusNoHook;
    }
    guildMemberLeftHook(guild_id, player_guid);
    return GuildHookStatusOK;
}

// GuildMemberRemoved
static OnGuildMemberRemovedHook guildMemberRemovedHook;
void SetOnGuildMemberRemovedHook(OnGuildMemberRemovedHook h) {
    guildMemberRemovedHook = h;
}

int CallOnGuildMemberRemovedHook(uint64_t guild_id, uint64_t player_guid) {
    if (guildMemberRemovedHook == 0) {
        return GuildHookStatusNoHook;
    }
    guildMemberRemovedHook(guild_id, player_guid);
    return GuildHookStatusOK;
}

// GuildCreated
static OnGuildCreatedHook guildCreatedHook;
void SetOnGuildCreatedHook(OnGuildCreatedHook h) {
    guildCreatedHook = h;
}

int CallOnGuildCreatedHook(uint64_t guild_id, char* guild_name, uint64_t leader_guid, uint64_t* member_guids, int member_guids_size) {
    if (guildCreatedHook == 0) {
        return GuildHookStatusNoHook;
    }
    guildCreatedHook(guild_id, guild_name, leader_guid, member_guids, member_guids_size);
    return GuildHookStatusOK;
}
