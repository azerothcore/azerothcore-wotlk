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

ChannelMgr::~ChannelMgr()
{
    for (ChannelMap::iterator itr = channels.begin(); itr != channels.end(); ++itr)
        delete itr->second;

    channels.clear();
}

ChannelMgr* ChannelMgr::forTeam(TeamId teamId)
{
    static ChannelMgr allianceChannelMgr(TEAM_ALLIANCE);
    static ChannelMgr hordeChannelMgr(TEAM_HORDE);

    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL))
        return &allianceChannelMgr;        // cross-faction

    if (teamId == TEAM_ALLIANCE)
        return &allianceChannelMgr;

    if (teamId == TEAM_HORDE)
        return &hordeChannelMgr;

    return nullptr;
}

void ChannelMgr::LoadChannels()
{
    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    //                                                    0          1     2     3         4          5
    QueryResult result = CharacterDatabase.Query("SELECT channelId, name, team, announce, ownership, password FROM channels ORDER BY channelId ASC");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 channels. DB table `channels` is empty.");
        return;
    }

    std::vector<std::pair<std::string, uint32>> toDelete;
    do
    {
        Field* fields = result->Fetch();

        uint32 channelDBId = fields[0].Get<uint32>();
        std::string channelName = fields[1].Get<std::string>();
        TeamId team = TeamId(fields[2].Get<uint32>());
        std::string password = fields[5].Get<std::string>();

        std::wstring channelWName;
        if (!Utf8toWStr(channelName, channelWName))
        {
            LOG_ERROR("server.loading", "Failed to load channel '{}' from database - invalid utf8 sequence? Deleted.", channelName);
            toDelete.emplace_back(channelName, team);
            continue;
        }

        ChannelMgr* mgr = forTeam(team);
        if (!mgr)
        {
            LOG_ERROR("server.loading", "Failed to load custom chat channel '{}' from database - invalid team {}. Deleted.", channelName, team);
            toDelete.emplace_back(channelName, team);
            continue;
        }

        Channel* newChannel = new Channel(channelName, 0, channelDBId, team, fields[3].Get<uint8>(), fields[4].Get<uint8>());
        newChannel->SetPassword(password);
        mgr->channels[channelWName] = newChannel;

        if (QueryResult banResult = CharacterDatabase.Query("SELECT playerGUID, banTime FROM channels_bans WHERE channelId = {}", channelDBId))
        {
            do
            {
                Field* banFields = banResult->Fetch();
                if (!banFields)
                    break;
                newChannel->AddBan(ObjectGuid::Create<HighGuid::Player>(banFields[0].Get<uint32>()), banFields[1].Get<uint32>());
            } while (banResult->NextRow());
        }

        if (channelDBId > ChannelMgr::_channelIdMax)
            ChannelMgr::_channelIdMax = channelDBId;
        ++count;
    } while (result->NextRow());

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

Channel* ChannelMgr::GetJoinChannel(std::string const& name, uint32 channelId)
{
    std::wstring wname;
    Utf8toWStr(name, wname);
    wstrToLower(wname);

    ChannelMap::const_iterator i = channels.find(wname);

    if (i == channels.end())
    {
        Channel* nchan = new Channel(name, channelId, 0, _teamId);
        channels[wname] = nchan;
        return nchan;
    }

    return i->second;
}

Channel* ChannelMgr::GetChannel(std::string const& name, Player* player, bool pkt)
{
    std::wstring wname;
    Utf8toWStr(name, wname);
    wstrToLower(wname);

    ChannelMap::const_iterator i = channels.find(wname);

    if (i == channels.end())
    {
        if (pkt)
        {
            WorldPacket data;
            MakeNotOnPacket(&data, name);
            player->SendDirectMessage(&data);
        }

        return nullptr;
    }

    return i->second;
}

uint32 ChannelMgr::_channelIdMax = 0;
ChannelMgr::ChannelRightsMap ChannelMgr::channels_rights;
ChannelRights ChannelMgr::channelRightsEmpty;

void ChannelMgr::LoadChannelRights()
{
    uint32 oldMSTime = getMSTime();
    channels_rights.clear();

    QueryResult result = CharacterDatabase.Query("SELECT name, flags, speakdelay, joinmessage, delaymessage, moderators FROM channels_rights");
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
        std::set<uint32> moderators;
        auto moderatorList = fields[5].Get<std::string_view>();

        if (!moderatorList.empty())
        {
            for (auto const& itr : Acore::Tokenize(moderatorList, ' ', false))
            {
                uint64 moderator_acc = Acore::StringTo<uint64>(itr).value_or(0);

                if (moderator_acc && ((uint32)moderator_acc) == moderator_acc)
                {
                    moderators.insert((uint32)moderator_acc);
                }
            }
        }

        SetChannelRightsFor(fields[0].Get<std::string>(), fields[1].Get<uint32>(), fields[2].Get<uint32>(), fields[3].Get<std::string>(), fields[4].Get<std::string>(), moderators);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Channel Rights in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

const ChannelRights& ChannelMgr::GetChannelRightsFor(const std::string& name)
{
    std::string nameStr = name;
    std::transform(nameStr.begin(), nameStr.end(), nameStr.begin(), ::tolower);
    ChannelRightsMap::const_iterator itr = channels_rights.find(nameStr);
    if (itr != channels_rights.end())
        return itr->second;
    return channelRightsEmpty;
}

void ChannelMgr::SetChannelRightsFor(const std::string& name, const uint32& flags, const uint32& speakDelay, const std::string& joinmessage, const std::string& speakmessage, const std::set<uint32>& moderators)
{
    std::string nameStr = name;
    std::transform(nameStr.begin(), nameStr.end(), nameStr.begin(), ::tolower);
    channels_rights[nameStr] = ChannelRights(flags, speakDelay, joinmessage, speakmessage, moderators);
}

void ChannelMgr::MakeNotOnPacket(WorldPacket* data, std::string const& name)
{
    data->Initialize(SMSG_CHANNEL_NOTIFY, 1 + name.size());
    (*data) << uint8(5) << name;
}
