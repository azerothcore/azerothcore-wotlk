/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __TRINITY_CHANNELMGR_H
#define __TRINITY_CHANNELMGR_H

#include "Common.h"
#include "Channel.h"

#include <map>
#include <string>

#include "World.h"

#define MAX_CHANNEL_PASS_STR 31

class ChannelMgr
{
    typedef std::map<std::wstring, Channel*> ChannelMap;

    protected:
        ChannelMgr() : team(0) { }
        ~ChannelMgr();

    public:
        static ChannelMgr* forTeam(TeamId teamId);
        void setTeam(TeamId newTeam) { teamId = newTeam; }

        Channel* GetJoinChannel(std::string const& name, uint32 channel_id);
        Channel* GetChannel(std::string const& name, Player* p, bool pkt = true);
        void LeftChannel(std::string const& name);

    private:
        ChannelMap channels;
        TeamId teamId;

        void MakeNotOnPacket(WorldPacket* data, std::string const& name);
};

#endif
