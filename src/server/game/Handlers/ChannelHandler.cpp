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
#include "ObjectMgr.h"                                      // for normalizePlayerName
#include "Player.h"
#include <cctype>

void WorldSession::HandleJoinChannel(WorldPacket& recvPacket)
{
    uint32 channelId;
    uint8 unknown1, unknown2;
    std::string channelName, password;

    recvPacket >> channelId >> unknown1 >> unknown2 >> channelName >> password;

    LOG_DEBUG("chat.system", "CMSG_JOIN_CHANNEL {} Channel: {}, unk1: {}, unk2: {}, channel: {}, password: {}", GetPlayerInfo(), channelId, unknown1, unknown2, channelName, password);
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

    if (channelName.size() >= 100 || !DisallowHyperlinksAndMaybeKick(channelName))
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetJoinChannel(channelName, channelId))
            channel->JoinChannel(GetPlayer(), password);
}

void WorldSession::HandleLeaveChannel(WorldPacket& recvPacket)
{
    uint32 unk;
    std::string channelName;
    recvPacket >> unk >> channelName;

    LOG_DEBUG("chat.system", "CMSG_LEAVE_CHANNEL {} Channel: {}, unk1: {}",
                   GetPlayerInfo(), channelName, unk);
    if (channelName.empty())
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->LeaveChannel(GetPlayer(), true);
}

void WorldSession::HandleChannelList(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    LOG_DEBUG("chat.system", "{} {} Channel: {}",
                   recvPacket.GetOpcode() == CMSG_CHANNEL_DISPLAY_LIST ? "CMSG_CHANNEL_DISPLAY_LIST" : "CMSG_CHANNEL_LIST",
                   GetPlayerInfo(), channelName);
    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->List(GetPlayer());
}

void WorldSession::HandleChannelPassword(WorldPacket& recvPacket)
{
    std::string channelName, password;
    recvPacket >> channelName >> password;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_PASSWORD {} Channel: {}, Password: {}",
                   GetPlayerInfo(), channelName, password);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_SET_OWNER {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_OWNER {} Channel: {}",
                   GetPlayerInfo(), channelName);
    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->SendWhoOwner(GetPlayer()->GetGUID());
}

void WorldSession::HandleChannelModerator(WorldPacket& recvPacket)
{
    std::string channelName, targetName;
    recvPacket >> channelName >> targetName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_MODERATOR {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_UNMODERATOR {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_MUTE {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_UNMUTE {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_INVITE {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_KICK {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_BAN {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_UNBAN {} Channel: {}, Target: {}",
                   GetPlayerInfo(), channelName, targetName);
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

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_ANNOUNCEMENTS {} Channel: {}",
        GetPlayerInfo(), channelName);
    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
            channel->Announce(GetPlayer());
}

void WorldSession::HandleChannelModerateOpcode(WorldPacket& recvPacket)
{
    std::string channelName;
    recvPacket >> channelName;

    LOG_DEBUG("chat.system", "CMSG_CHANNEL_MODERATE {} Channel: {}",
        GetPlayerInfo(), channelName);

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

    LOG_DEBUG("chat.system", "CMSG_GET_CHANNEL_MEMBER_COUNT {} Channel: {}",
                   GetPlayerInfo(), channelName);
    if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetPlayer()->GetTeamId()))
    {
        if (Channel* channel = cMgr->GetChannel(channelName, GetPlayer()))
        {
            LOG_DEBUG("chat.system", "SMSG_CHANNEL_MEMBER_COUNT {} Channel: {} Count: {}",
                           GetPlayerInfo(), channelName, channel->GetNumPlayers());

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
