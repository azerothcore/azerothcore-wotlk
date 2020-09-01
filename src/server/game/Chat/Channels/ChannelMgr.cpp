/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ChannelMgr.h"
#include "Player.h"
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
    QueryResult result = CharacterDatabase.PQuery("SELECT channelId, name, team, announce, ownership, password FROM channels WHERE team = %u ORDER BY channelId ASC", _teamId);
    if (!result)
    {
        sLog->outString(">> Loaded 0 channels for %s", _teamId == TEAM_ALLIANCE ? "Alliance" : "Horde");
        sLog->outString();
        return;
    }

    do
    {
        Field* fields = result->Fetch();
        if (!fields)
            break;

        uint32 channelDBId = fields[0].GetUInt32();
        std::string channelName = fields[1].GetString();
        std::string password = fields[5].GetString();
        std::wstring channelWName;
        Utf8toWStr(channelName, channelWName);

        Channel* newChannel = new Channel(channelName, 0, channelDBId, TeamId(fields[2].GetUInt32()), fields[3].GetUInt8(), fields[4].GetUInt8());
        newChannel->SetPassword(password);
        channels[channelWName] = newChannel;

        if (QueryResult banResult = CharacterDatabase.PQuery("SELECT playerGUID, banTime FROM channels_bans WHERE channelId = %u", channelDBId))
        {
            do
            {
                Field* banFields = banResult->Fetch();
                if (!banFields)
                    break;
                newChannel->AddBan(banFields[0].GetUInt32(), banFields[1].GetUInt32());     
            }
            while (banResult->NextRow());
        }

        if (channelDBId > ChannelMgr::_channelIdMax) 
            ChannelMgr::_channelIdMax = channelDBId;
        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u channels for %s in %ums", count, _teamId == TEAM_ALLIANCE ? "Alliance" : "Horde", GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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
            player->GetSession()->SendPacket(&data);
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
        sLog->outString();
        sLog->outString(">>  Loaded 0 Channel Rights!");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        std::set<uint32> moderators;
        const char* moderatorList = fields[5].GetCString();
        if (moderatorList)
        {
            Tokenizer tokens(moderatorList, ' ');
            for (Tokenizer::const_iterator i = tokens.begin(); i != tokens.end(); ++i)
            {
                uint64 moderator_acc = atol(*i);
                if (moderator_acc && ((uint32)moderator_acc) == moderator_acc)
                    moderators.insert((uint32)moderator_acc);
            }
        }

        SetChannelRightsFor(fields[0].GetString(), fields[1].GetUInt32(), fields[2].GetUInt32(), fields[3].GetString(), fields[4].GetString(), moderators);

        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %d Channel Rights in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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
