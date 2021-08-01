/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ChannelMgr.h"
#include "ObjectMgr.h"                                      // for normalizePlayerName
#include "Player.h"
#include <cctype>

void WorldSession::HandleJoinChannel(WorldPacket& recvPacket)
{
    uint32 channelId;
    uint8 unknown1, unknown2;
    std::string channelName, password;

    recvPacket >> channelId >> unknown1 >> unknown2 >> channelName >> password;

    LOG_DEBUG("chat.system", "CMSG_JOIN_CHANNEL %s Channel: %u, unk1: %u, unk2: %u, channel: %s, password: %s", GetPlayerInfo().c_str(), channelId, unknown1, unknown2, channelName.c_str(), password.c_str());
    if (channelId)
    {
        ChatChannelsEntry const* channel = sChatChannelsStore.LookupEntry(channelId);
        if (!channel)
            return;

        AreaTableEntry const* zone = sAreaTableStore.LookupEntry(GetPlayer()->GetZoneId());
        if (!zone || !GetPlayer()->CanJoinConstantChannelInZone(channel, zone))
            return;
    }

    if (channelName.empty())
        return;

    if (isdigit(channelName[0]))
        return;

    // pussywizard: restrict allowed characters in channel name to avoid |0 and possibly other exploits
    //if (!ObjectMgr::IsValidChannelName(channelName))
    if (channelName.find("|") != std::string::npos || channelName.size() >= 100)
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
    {
        if (Channel* channel = cMgr->GetJoinChannel(channelName, channelId))
            channel->JoinChannel(GetPlayer(), password);
    }
}

void WorldSession::HandleLeaveChannel(WorldPacket& recvPacket)
{
    uint32 unk;
    std::string channelName;
    recvPacket >> unk >> channelName;

    LOG_DEBUG("chat.system", "CMSG_LEAVE_CHANNEL %s Channel: %s, unk1: %u",
                   GetPlayerInfo().c_str(), channelName.c_str(), unk);
    if (channelName.empty())
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
    {
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->LeaveChannel(GetPlayer(), true);
    }
}

void WorldSession::HandleChannelList(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    LOG_DEBUG("chat.system", "%s %s Channel: %s",
                   recvPacket.GetOpcode() == CMSG_CHANNEL_DISPLAY_LIST ? "CMSG_CHANNEL_DISPLAY_LIST" : "CMSG_CHANNEL_LIST",
                   GetPlayerInfo().c_str(), channelName.c_str());
    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->List(GetPlayer());
}

void WorldSession::HandleChannelPassword(WorldPacket& recvPacket)
{
    std::string channelName, password;
    recvPacket >> channelName >> password;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_PASSWORD %s Channel: %s, Password: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), password.c_str());
    if (password.length() > MAX_CHANNEL_PASS_STR)
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->Password(GetPlayer(), password);
}

void WorldSession::HandleChannelSetOwner(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_SET_OWNER %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->SetOwner(GetPlayer(), targetName);
}

void WorldSession::HandleChannelOwner(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_OWNER %s Channel: %s",
                   GetPlayerInfo().c_str(), channelName.c_str());
    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->SendWhoOwner(GetPlayer()->GetGUID());
}

void WorldSession::HandleChannelModerator(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_MODERATOR %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->SetModerator(GetPlayer(), targetName);
}

void WorldSession::HandleChannelUnmoderator(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_UNMODERATOR %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->UnsetModerator(GetPlayer(), targetName);
}

void WorldSession::HandleChannelMute(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_MUTE %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->SetMute(GetPlayer(), targetName);
}

void WorldSession::HandleChannelUnmute(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_UNMUTE %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->UnsetMute(GetPlayer(), targetName);
}

void WorldSession::HandleChannelInvite(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_INVITE %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->Invite(GetPlayer(), targetName);
}

void WorldSession::HandleChannelKick(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_KICK %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->Kick(GetPlayer(), targetName);
}

void WorldSession::HandleChannelBan(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_BAN %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->Ban(GetPlayer(), targetName);
}

void WorldSession::HandleChannelUnban(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_UNBAN %s Channel: %s, Target: %s",
                   GetPlayerInfo().c_str(), channelName.c_str(), targetName.c_str());
    if (!normalizePlayerName(targetName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->UnBan(GetPlayer(), targetName);
}

void WorldSession::HandleChannelAnnouncements(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_ANNOUNCEMENTS %s Channel: %s",
        GetPlayerInfo().c_str(), channelName.c_str());
    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->Announce(GetPlayer());
}

void WorldSession::HandleChannelModerateOpcode(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_MODERATE %s Channel: %s",
        GetPlayerInfo().c_str(), channelName.c_str());

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* chn = cMgr->GetChannel(channelName, GetPlayer()))
            chn->ToggleModeration(GetPlayer());
}

void WorldSession::HandleChannelDisplayListQuery(WorldPacket& recvPacket)
{
    // this should be OK because the 2 function _were_ the same
    HandleChannelList(recvPacket);
}

void WorldSession::HandleGetChannelMemberCount(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    LOG_DEBUG("chat.system", "CMSG_GET_CHANNEL_MEMBER_COUNT %s Channel: %s",
                   GetPlayerInfo().c_str(), channelName.c_str());
    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
    {
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
        {
            LOG_DEBUG("chat.system", "SMSG_CHANNEL_MEMBER_COUNT %s Channel: %s Count: %u",
                           GetPlayerInfo().c_str(), channelName.c_str(), channel->GetNumPlayers());

            WorldPacket data(SMSG_CHANNEL_MEMBER_COUNT, channel->GetName().size() + 1 + 4);
            data << channel->GetName();
            data << uint8(channel->GetFlags());
            data << uint32(channel->GetNumPlayers());
            SendPacket(&data);
        }
    }
}

void WorldSession::HandleSetChannelWatch(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    GetPlayer()->ClearChannelWatch();

    if (channelName.empty())
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, nullptr, false))
            channel->AddWatching(GetPlayer());
}

void WorldSession::HandleClearChannelWatch(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    if (channelName.empty())
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, nullptr, false))
            channel->RemoveWatching(GetPlayer());
}
