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
