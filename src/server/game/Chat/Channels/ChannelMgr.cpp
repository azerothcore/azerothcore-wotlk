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

#include "ChannelMgr.h"
#include "Log.h"
#include "Player.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "World.h"
#include <algorithm>
#include <cctype>

namespace
{
    std::string ToLowerChannelName(std::string name)
    {
        std::transform(name.begin(), name.end(), name.begin(),
            [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
        return name;
    }
}

void ChannelMgr::LoadChannels()
{
    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    // 0: channelId, 1: name, 2: team, 3: announce, 4: ownership, 5: password
    CharacterDatabasePreparedStatement* channelsStmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHANNELS);
    PreparedQueryResult result = CharacterDatabase.Query(channelsStmt);
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 channels. DB table `channels` is empty.");
        return;
    }

    std::vector<std::pair<std::string, TeamId>> toDelete;
    do
    {
        Field* fields = result->Fetch();

        uint32 channelDBId = fields[0].Get<uint32>();
        std::string channelName = fields[1].Get<std::string>();
        TeamId team = TeamId(fields[2].Get<uint32>());
        std::string password = fields[5].Get<std::string>();

        // counts every row, also the ones skipped below: their ids stay taken
        if (channelDBId > _channelIdMax)
            _channelIdMax = channelDBId;

        std::wstring channelWName;
        if (!Utf8toWStr(channelName, channelWName))
        {
            LOG_ERROR("server.loading", "Failed to load channel '{}' from database - invalid utf8 sequence? Deleted.", channelName);
            toDelete.emplace_back(channelName, team);
            continue;
        }

        if (team >= PVP_TEAMS_COUNT)
        {
            LOG_ERROR("server.loading", "Failed to load custom chat channel '{}' from database - invalid team {}. Deleted.", channelName, team);
            toDelete.emplace_back(channelName, team);
            continue;
        }

        // with cross faction channels enabled all channels share the alliance map,
        // the same way GetOrCreateChannel/GetChannel look them up
        if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL))
            team = TEAM_ALLIANCE;

        // lookups are case insensitive
        wstrToLower(channelWName);

        // e.g. saved for both teams before cross faction channels were enabled, or
        // differing only in case. Rows come by ascending id, so the newest one wins:
        // it holds the latest settings
        auto const existing = _channelsByName[team].find(channelWName);
        if (existing != _channelsByName[team].end())
        {
            LOG_WARN("server.loading", "Custom chat channel '{}' is saved more than once, using id {} over id {}.",
                channelName, channelDBId, existing->second->GetChannelDBId());
            _channelsByGuid.erase(existing->second->GetChannelDBId());
            --count;
        }

        std::shared_ptr<Channel> newChannel = std::make_shared<Channel>(channelName, 0, channelDBId, team, fields[3].Get<uint8>(), fields[4].Get<uint8>());
        newChannel->SetPassword(password);
        _channelsByName[team][channelWName] = newChannel;
        _channelsByGuid[channelDBId] = newChannel;

        ++count;
    } while (result->NextRow());

    // 0: channelId, 1: playerGUID, 2: banTime
    CharacterDatabasePreparedStatement* bansStmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHANNELS_BANS);
    if (PreparedQueryResult banResult = CharacterDatabase.Query(bansStmt))
    {
        do
        {
            Field* banFields = banResult->Fetch();
            if (!banFields)
                break;

            uint32 const channelId = banFields[0].Get<uint32>();
            if (Channel* channel = GetChannel(channelId))
                channel->AddBan(ObjectGuid::Create<HighGuid::Player>(banFields[1].Get<uint32>()), banFields[2].Get<uint32>());
        } while (banResult->NextRow());
    }

    for (auto& pair : toDelete)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHANNEL);
        stmt->SetData(0, pair.first);
        stmt->SetData(1, pair.second);
        CharacterDatabase.Execute(stmt);
    }

    LOG_INFO("server.loading", ">> Loaded {} channels in {}ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

Channel* ChannelMgr::GetOrCreateChannel(TeamId team, std::string const& name, uint32 channelDBCId)
{
    if (team >= PVP_TEAMS_COUNT)
        return nullptr;

    // Crossfaction handling, force TEAM_ALLIANCE
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL))
        team = TEAM_ALLIANCE;

    std::wstring wname;
    Utf8toWStr(name, wname);
    wstrToLower(wname);

    ChannelsByNameMap::const_iterator itr = _channelsByName[team].find(wname);
    if (itr == _channelsByName[team].end())
    {
        std::shared_ptr<Channel> channel = std::make_shared<Channel>(name, channelDBCId, 0, team);
        _channelsByName[team][wname] = channel;
        if (uint32 dbId = channel->GetChannelDBId())
            _channelsByGuid[dbId] = channel;
        return channel.get();
    }

    return itr->second.get();
}

Channel* ChannelMgr::GetChannel(TeamId team, std::string const& name)
{
    if (team >= PVP_TEAMS_COUNT)
        return nullptr;

    // Crossfaction handling, force TEAM_ALLIANCE
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL))
        team = TEAM_ALLIANCE;

    std::wstring wname;
    Utf8toWStr(name, wname);
    wstrToLower(wname);

    ChannelsByNameMap::const_iterator itr = _channelsByName[team].find(wname);
    if (itr == _channelsByName[team].end())
        return nullptr;

    return itr->second.get();
}

Channel* ChannelMgr::GetChannel(uint64 channelId)
{
    ChannelsByGUIDMap::const_iterator itr = _channelsByGuid.find(channelId);
    if (itr == _channelsByGuid.end())
        return nullptr;

    return itr->second.get();
}

void ChannelMgr::LoadChannelRights()
{
    uint32 oldMSTime = getMSTime();
    _channelRights.clear();

    // 0: name, 1: flags, 2: speakdelay, 3: joinmessage, 4: delaymessage, 5: moderators
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHANNELS_RIGHTS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Channel Rights!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        std::string_view moderatorList = fields[5].Get<std::string_view>();

        std::set<uint32> moderators;
        for (auto const& itr : Acore::Tokenize(moderatorList, ' ', false))
        {
            uint32 moderator_acc = Acore::StringTo<uint32>(itr).value_or(0);
            if (moderator_acc)
                moderators.insert(moderator_acc);
        }

        SetChannelRightsFor(fields[0].Get<std::string>(), fields[1].Get<uint32>(), fields[2].Get<uint32>(), fields[3].Get<std::string>(), fields[4].Get<std::string>(), moderators);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Channel Rights in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

ChannelRights const& ChannelMgr::GetChannelRightsFor(std::string const& name) const
{
    ChannelRightsMap::const_iterator itr = _channelRights.find(ToLowerChannelName(name));
    if (itr != _channelRights.end())
        return itr->second;

    return _emptyChannelRights;
}

void ChannelMgr::SetChannelRightsFor(std::string const& name, uint32 flags, uint32 speakDelay,
    std::string const& joinMessage, std::string const& speakMessage, std::set<uint32> const& moderators)
{
    _channelRights[ToLowerChannelName(name)] = ChannelRights(flags, speakDelay, joinMessage, speakMessage, moderators);
}

void ChannelMgr::SendNotOnPacket(Player* player, std::string const& channelName)
{
    WorldPacket pkt(SMSG_CHANNEL_NOTIFY, 1 + channelName.size() + 1);
    pkt << uint8(CHAT_NOT_MEMBER_NOTICE);
    pkt << channelName;
    player->SendDirectMessage(&pkt);
}
