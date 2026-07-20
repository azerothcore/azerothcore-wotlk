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

#include "CharacterCache.h"
#include "ChannelMgr.h"
#include "Group.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SocialMgr.h"
#include "VoiceChatMgr.h"
#include "VoiceChatPackets.h"
#include "WorldSession.h"

void WorldSession::HandleVoiceSessionEnableOpcode(WorldPackets::VoiceChat::VoiceSessionEnable& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_VOICE_SESSION_ENABLE");

    // sent by the client on login and whenever the voice settings change

    if (!sVoiceChatMgr->CanSeeVoiceChat())
        return;

    if (!_player)
    {
        _voiceEnabled = packet.VoiceEnabled;
        _micEnabled = packet.MicrophoneEnabled;
        return;
    }

    if (!packet.VoiceEnabled)
    {
        sVoiceChatMgr->RemoveFromVoiceChatChannels(_player->GetGUID());
        SetCurrentVoiceChannelId(0);
    }
    else if (_player->IsInWorld() && !_voiceEnabled)
    {
        // enable before joining so the channels accept the player
        _voiceEnabled = packet.VoiceEnabled;
        _micEnabled = packet.MicrophoneEnabled;
        sVoiceChatMgr->JoinAvailableVoiceChatChannels(this);
    }

    if (GetCurrentVoiceChannelId())
    {
        if (Channel* currentChannel = sVoiceChatMgr->GetVoiceChatChannel(GetCurrentVoiceChannelId()))
        {
            if (!packet.MicrophoneEnabled)
                currentChannel->MuteVoiceMember(_player->GetGUID());
            else
                currentChannel->UnmuteVoiceMember(_player->GetGUID());
        }
    }

    _voiceEnabled = packet.VoiceEnabled;
    _micEnabled = packet.MicrophoneEnabled;
}

void WorldSession::HandleChannelVoiceOnOpcode(WorldPackets::VoiceChat::ChannelVoiceOn& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_VOICE_ON");

    // Enable Voice button in the channel context menu

    if (!sVoiceChatMgr->CanUseVoiceChat())
        return;

    if (!_player)
        return;

    if (Channel* channel = sChannelMgr.GetChannel(_player->GetTeamId(), packet.ChannelName))
        channel->VoiceOn(_player);
    else
        ChannelMgr::SendNotOnPacket(_player, packet.ChannelName);
}

void WorldSession::HandleSetActiveVoiceChannelOpcode(WorldPackets::VoiceChat::SetActiveVoiceChannel& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_SET_ACTIVE_VOICE_CHANNEL");

    if (!sVoiceChatMgr->CanUseVoiceChat())
        return;

    if (!_player || !_player->IsInWorld())
        return;

    // leave the current voice channel if the player selects a different one
    Channel* currentChannel = nullptr;
    if (GetCurrentVoiceChannelId())
        currentChannel = sVoiceChatMgr->GetVoiceChatChannel(GetCurrentVoiceChannelId());

    switch (static_cast<VoiceChatChannelType>(packet.ChannelType))
    {
        case VoiceChatChannelType::Custom:
        {
            Channel* channel = sChannelMgr.GetChannel(_player->GetTeamId(), packet.ChannelName);
            if (!channel || !channel->IsOn(_player->GetGUID()) || channel->IsBanned(_player->GetGUID()) || !channel->IsVoiceEnabled())
                return;

            Channel* voiceChannel = sVoiceChatMgr->GetCustomVoiceChatChannel(packet.ChannelName, _player->GetTeamId());
            SetActiveVoiceChannel(voiceChannel, currentChannel, _player);
            break;
        }
        case VoiceChatChannelType::Group:
        case VoiceChatChannelType::Raid:
        {
            Group* group = _player->GetGroup();
            if (group && (group->isBGGroup() || group->isBFGroup()))
                group = _player->GetOriginalGroup();

            if (group)
            {
                Channel* voiceChannel = nullptr;
                if (group->isRaidGroup())
                    voiceChannel = sVoiceChatMgr->GetRaidVoiceChatChannel(group->GetGroupId());
                else
                    voiceChannel = sVoiceChatMgr->GetGroupVoiceChatChannel(group->GetGroupId());

                SetActiveVoiceChannel(voiceChannel, currentChannel, _player);
            }
            break;
        }
        case VoiceChatChannelType::Battleground:
        {
            if (_player->InBattleground())
            {
                Channel* voiceChannel = sVoiceChatMgr->GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());
                SetActiveVoiceChannel(voiceChannel, currentChannel, _player);
            }
            break;
        }
        default:
        {
            // leave the current channel
            if (currentChannel)
                currentChannel->DevoiceMember(_player->GetGUID());

            SetCurrentVoiceChannelId(0);
            break;
        }
    }
}

void WorldSession::SetActiveVoiceChannel(Channel* voiceChannel, Channel* currentChannel, Player* player)
{
    if (!voiceChannel)
        return;

    if (currentChannel)
    {
        // if it is the same channel, just refresh the roster
        if (voiceChannel == currentChannel)
        {
            voiceChannel->SendVoiceRoster();
            return;
        }

        currentChannel->DevoiceMember(player->GetGUID());
    }

    voiceChannel->AddVoiceChatMember(player->GetGUID());
    if (voiceChannel->IsOnVoice(player->GetGUID()))
    {
        // change speaker icon from grey to color
        voiceChannel->VoiceMember(player->GetGUID());

        // allow to speak depending on the client settings
        if (IsMicEnabled())
            voiceChannel->UnmuteVoiceMember(player->GetGUID());
        else
            voiceChannel->MuteVoiceMember(player->GetGUID());

        SetCurrentVoiceChannelId(voiceChannel->GetVoiceId());
    }
}

void WorldSession::HandleChannelVoiceOffOpcode(WorldPackets::VoiceChat::ChannelVoiceOff& /*packet*/)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_VOICE_OFF");

    // not sent by the 3.3.5 client
}

void WorldSession::HandleAddVoiceIgnoreOpcode(WorldPackets::VoiceChat::AddVoiceIgnore& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_ADD_VOICE_IGNORE");

    if (!_player)
        return;

    if (!normalizePlayerName(packet.IgnoreName))
        return;

    ObjectGuid ignoreGuid = sCharacterCache->GetCharacterGuidByName(packet.IgnoreName);
    if (!ignoreGuid)
        return;

    LOG_DEBUG("network", "WORLD: {} asked to mute: '{}'", _player->GetName(), packet.IgnoreName);

    FriendsResult ignoreResult;
    if (ignoreGuid == _player->GetGUID())
        ignoreResult = FRIEND_MUTE_SELF;
    else if (_player->GetSocial()->HasMute(ignoreGuid))
        ignoreResult = FRIEND_MUTE_ALREADY;
    else
    {
        ignoreResult = FRIEND_MUTE_ADDED;

        // mute list full
        if (!_player->GetSocial()->AddToSocialList(ignoreGuid, SOCIAL_FLAG_MUTED))
            ignoreResult = FRIEND_MUTE_FULL;
    }

    sSocialMgr->SendFriendStatus(_player, ignoreResult, ignoreGuid, false);
}

void WorldSession::HandleDeleteVoiceIgnoreOpcode(WorldPackets::VoiceChat::DeleteVoiceIgnore& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_DEL_VOICE_IGNORE");

    if (!_player)
        return;

    _player->GetSocial()->RemoveFromSocialList(packet.IgnoreGuid, SOCIAL_FLAG_MUTED);

    sSocialMgr->SendFriendStatus(_player, FRIEND_MUTE_REMOVED, packet.IgnoreGuid, false);
}

void WorldSession::HandlePartySilenceOpcode(WorldPackets::VoiceChat::PartySilence& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_PARTY_SILENCE");

    if (!sVoiceChatMgr->CanUseVoiceChat())
        return;

    if (!_player)
        return;

    Group* group = _player->GetGroup();
    if (!group || !group->IsMember(packet.SilenceGuid))
        return;

    if (!group->IsLeader(_player->GetGUID()) && !group->IsMainAssistant(_player->GetGUID()))
        return;

    Channel* voiceChannel = nullptr;
    if (!group->isBGGroup() && !group->isBFGroup())
    {
        if (group->isRaidGroup())
            voiceChannel = sVoiceChatMgr->GetRaidVoiceChatChannel(group->GetGroupId());
        else
            voiceChannel = sVoiceChatMgr->GetGroupVoiceChatChannel(group->GetGroupId());
    }
    else if (_player->InBattleground())
        voiceChannel = sVoiceChatMgr->GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());

    if (!voiceChannel)
        return;

    voiceChannel->ForceMuteVoiceMember(packet.SilenceGuid);
}

void WorldSession::HandlePartyUnsilenceOpcode(WorldPackets::VoiceChat::PartyUnsilence& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_PARTY_UNSILENCE");

    if (!sVoiceChatMgr->CanUseVoiceChat())
        return;

    if (!_player)
        return;

    Group* group = _player->GetGroup();
    if (!group || !group->IsMember(packet.UnsilenceGuid))
        return;

    if (!group->IsLeader(_player->GetGUID()) && !group->IsMainAssistant(_player->GetGUID()))
        return;

    Channel* voiceChannel = nullptr;
    if (!group->isBGGroup() && !group->isBFGroup())
    {
        if (group->isRaidGroup())
            voiceChannel = sVoiceChatMgr->GetRaidVoiceChatChannel(group->GetGroupId());
        else
            voiceChannel = sVoiceChatMgr->GetGroupVoiceChatChannel(group->GetGroupId());
    }
    else if (_player->InBattleground())
        voiceChannel = sVoiceChatMgr->GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());

    if (!voiceChannel)
        return;

    voiceChannel->ForceUnmuteVoiceMember(packet.UnsilenceGuid);
}

void WorldSession::HandleChannelSilenceOpcode(WorldPackets::VoiceChat::ChannelSilence& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_SILENCE_VOICE");

    if (!sVoiceChatMgr->CanUseVoiceChat())
        return;

    if (!_player)
        return;

    Channel* channel = sChannelMgr.GetChannel(_player->GetTeamId(), packet.ChannelName);
    if (!channel || !channel->IsVoiceEnabled())
        return;

    // only the channel owner or a moderator may silence members
    uint8 const flags = channel->GetPlayerFlags(_player->GetGUID());
    if (!(flags & MEMBER_FLAG_OWNER) && !(flags & MEMBER_FLAG_MODERATOR))
        return;

    ObjectGuid playerGuid = sCharacterCache->GetCharacterGuidByName(packet.PlayerName);
    if (!playerGuid)
        return;

    if (channel->IsOnVoice(playerGuid))
        channel->ForceMuteVoiceMember(playerGuid);
}

void WorldSession::HandleChannelUnsilenceOpcode(WorldPackets::VoiceChat::ChannelUnsilence& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_UNSILENCE_VOICE");

    if (!sVoiceChatMgr->CanUseVoiceChat())
        return;

    if (!_player)
        return;

    Channel* channel = sChannelMgr.GetChannel(_player->GetTeamId(), packet.ChannelName);
    if (!channel || !channel->IsVoiceEnabled())
        return;

    // only the channel owner or a moderator may unsilence members
    uint8 const flags = channel->GetPlayerFlags(_player->GetGUID());
    if (!(flags & MEMBER_FLAG_OWNER) && !(flags & MEMBER_FLAG_MODERATOR))
        return;

    ObjectGuid playerGuid = sCharacterCache->GetCharacterGuidByName(packet.PlayerName);
    if (!playerGuid)
        return;

    if (channel->IsOnVoice(playerGuid))
        channel->ForceUnmuteVoiceMember(playerGuid);
}
