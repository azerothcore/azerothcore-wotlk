/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _GUILDMGR_H
#define _GUILDMGR_H

#include "Guild.h"

class GuildMgr
{
    friend class ACE_Singleton<GuildMgr, ACE_Null_Mutex>;

private:
    GuildMgr();
    ~GuildMgr();

public:
    Guild* GetGuildByLeader(uint64 guid) const;
    Guild* GetGuildById(uint32 guildId) const;
    Guild* GetGuildByName(std::string const& guildName) const;
    std::string GetGuildNameById(uint32 guildId) const;

    void LoadGuilds();
    void AddGuild(Guild* guild);
    void RemoveGuild(uint32 guildId);

    uint32 GenerateGuildId();
    void SetNextGuildId(uint32 Id) { NextGuildId = Id; }

    void ResetTimes();
protected:
    typedef UNORDERED_MAP<uint32, Guild*> GuildContainer;
    uint32 NextGuildId;
    GuildContainer GuildStore;
};

#define sGuildMgr ACE_Singleton<GuildMgr, ACE_Null_Mutex>::instance()

#endif
