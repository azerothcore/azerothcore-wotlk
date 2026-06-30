#include "events-guild.h"

// GuildMemberAddedHook
OnGuildMemberAddedHook guildMemberAddedHook;
void SetOnGuildMemberAddedHook(OnGuildMemberAddedHook h) {
    guildMemberAddedHook = h;
}

int CallOnGuildMemberAddedHook(uint64_t guild_id, uint64_t player_guid) {
    if (guildMemberAddedHook == 0) {
        return NoHook;
    }
    guildMemberAddedHook(guild_id, player_guid);
    return OK;
}

// GuildMemberLeft
static OnGuildMemberLeftHook guildMemberLeftHook;
void SetOnGuildMemberLeftHook(OnGuildMemberLeftHook h) {
    guildMemberLeftHook = h;
}

int CallOnGuildMemberLeftHook(uint64_t guild_id, uint64_t player_guid) {
    if (guildMemberLeftHook == 0) {
        return NoHook;
    }
    guildMemberLeftHook(guild_id, player_guid);
    return OK;
}

// GuildMemberRemoved
static OnGuildMemberRemovedHook guildMemberRemovedHook;
void SetOnGuildMemberRemovedHook(OnGuildMemberRemovedHook h) {
    guildMemberRemovedHook = h;
}

int CallOnGuildMemberRemovedHook(uint64_t guild_id, uint64_t player_guid) {
    if (guildMemberRemovedHook == 0) {
        return NoHook;
    }
    guildMemberRemovedHook(guild_id, player_guid);
    return OK;
}
