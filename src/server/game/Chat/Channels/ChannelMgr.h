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
#include <map>
#include <memory>
#include <set>
#include <string>

class Player;

#define MAX_CHANNEL_NAME_STR 100
#define MAX_CHANNEL_PASS_STR 31

class ChannelMgr
{
    typedef std::unordered_map<std::wstring, std::shared_ptr<Channel>> ChannelsByNameMap;
    typedef std::unordered_map<uint64, std::shared_ptr<Channel>> ChannelsByGUIDMap;
    typedef std::map<std::string, ChannelRights> ChannelRightsMap;

public:
    static ChannelMgr& Instance()
    {
        static ChannelMgr instance;
        return instance;
    }

    ChannelMgr() : _channelIdMax(0) { }
    ~ChannelMgr() { }

    Channel* GetOrCreateChannel(TeamId team, std::string const& name, uint32 channelDBCId);
    Channel* GetChannel(TeamId team, std::string const& name);
    Channel* GetChannel(uint64 channelId);

    void LoadChannels();
    // must run before LoadChannels: custom channels pick up their rights when they are created
    void LoadChannelRights();
    // rights of custom channels, by case insensitive channel name
    ChannelRights const& GetChannelRightsFor(std::string const& name) const;
    void SetChannelRightsFor(std::string const& name, uint32 flags, uint32 speakDelay,
        std::string const& joinMessage, std::string const& speakMessage, std::set<uint32> const& moderators);

    // one above the highest id in the channels table, skipped rows included
    uint64 GetNextChannelGuid() { return ++_channelIdMax; }

    static void SendNotOnPacket(Player* player, std::string const& channelName);

private:
    ChannelsByNameMap _channelsByName[PVP_TEAMS_COUNT];
    ChannelsByGUIDMap _channelsByGuid;
    ChannelRightsMap _channelRights;
    ChannelRights _emptyChannelRights;

    uint64 _channelIdMax;
};

#define sChannelMgr ChannelMgr::Instance()

#endif
