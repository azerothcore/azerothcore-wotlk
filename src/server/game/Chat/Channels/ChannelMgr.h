/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */
#ifndef __ACORE_CHANNELMGR_H
#define __ACORE_CHANNELMGR_H

#include "Common.h"
#include "Channel.h"
#include "World.h"
#include <map>
#include <string>

#define MAX_CHANNEL_PASS_STR 31

class ChannelMgr
{
    typedef std::unordered_map<std::wstring, Channel*> ChannelMap;
    typedef std::map<std::string, ChannelRights> ChannelRightsMap;

    public:
        ChannelMgr(TeamId teamId) : _teamId(teamId)
        { }

        ~ChannelMgr();

        static ChannelMgr * forTeam(TeamId teamId);

        Channel* GetJoinChannel(std::string const& name, uint32 channel_id);
        Channel* GetChannel(std::string const& name, Player* p, bool pkt = true);
        void LoadChannels();

        static void LoadChannelRights();
        static const ChannelRights& GetChannelRightsFor(const std::string& name);
        static void SetChannelRightsFor(const std::string& name, const uint32& flags, const uint32& speakDelay, const std::string& joinmessage, const std::string& speakmessage, const std::set<uint32>& moderators);
        static uint32 _channelIdMax;

    private:
        ChannelMap channels;
        TeamId _teamId;
        static ChannelRightsMap channels_rights;
        static ChannelRights channelRightsEmpty; // when not found in the map, reference to this is returned

        void MakeNotOnPacket(WorldPacket* data, std::string const& name);
};

class AllianceChannelMgr : public ChannelMgr { public: AllianceChannelMgr() : ChannelMgr(TEAM_ALLIANCE) {} };
class HordeChannelMgr    : public ChannelMgr { public: HordeChannelMgr() : ChannelMgr(TEAM_HORDE) {} };

#endif
