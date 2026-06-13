/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __ACORE_CHANNELMGR_H
#define __ACORE_CHANNELMGR_H

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

    static ChannelMgr* forTeam(TeamId teamId);

    Channel* GetJoinChannel(std::string const& name, uint32 channel_id);
    Channel* GetChannel(std::string const& name, Player* p, bool pkt = true);
    static void LoadChannels();

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
