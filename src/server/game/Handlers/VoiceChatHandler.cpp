/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ChannelMgr.h"
#include "Group.h"
#include "Language.h"
#include "Log.h"
#include "Opcodes.h"
#include "Player.h"
#include "SocialMgr.h"
#include "VoiceChatChannel.h"
#include "VoiceChatMgr.h"
#include "VoiceChatPackets.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleVoiceSessionEnableOpcode(WorldPackets::VoiceChat::VoiceSessionEnable& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_VOICE_SESSION_ENABLE");

    if (!sVoiceChatMgr.CanSeeVoiceChat())
        return;

    // comes from in game voice chat settings
    // is sent during login or when changing settings

    if (!_player)
    {
        _micEnabled = packet.MicrophoneEnabled;
        _voiceEnabled = packet.VoiceEnabled;
        return;
    }

    if (!packet.VoiceEnabled)
    {
        sVoiceChatMgr.RemoveFromVoiceChatChannels(_player->GetGUID());
        SetCurrentVoiceChannelId(0);
    }
    else
    {
        // send available voice channels
        if (_player->IsInWorld() && !_voiceEnabled)
        {
            // enable it here to allow joining channels
            _voiceEnabled = packet.VoiceEnabled;
            _micEnabled = packet.MicrophoneEnabled;
            sVoiceChatMgr.JoinAvailableVoiceChatChannels(this);
        }
    }

    if (GetCurrentVoiceChannelId())
    {
        VoiceChatChannel* currentChannel = sVoiceChatMgr.GetVoiceChatChannel(GetCurrentVoiceChannelId());
        if (currentChannel)
        {
            if (!packet.MicrophoneEnabled)
                currentChannel->MuteMember(_player->GetGUID());
            else
                currentChannel->UnmuteMember(_player->GetGUID());
        }
    }

    _micEnabled = packet.MicrophoneEnabled;
    _voiceEnabled = packet.VoiceEnabled;
}

void WorldSession::HandleChannelVoiceOnOpcode(WorldPackets::VoiceChat::ChannelVoiceOn& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_VOICE_ON");
    // Enable Voice button in channel context menu

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player)
        return;

    // custom channel
    auto cMgr = ChannelMgr(_player->GetTeamId());
    {
        Channel* chn = cMgr.GetChannel(packet.ChannelName, _player);
        if (!chn)
            return;

        if (chn->IsLFG() || chn->IsConstant())
        {
            LOG_ERROR("voice-chat", "Channel is LFG or constant, can't use voice!");
            return;
        }

        // already enabled
        if (chn->IsVoiceEnabled())
            return;

        chn->ToggleVoice(_player);

        sVoiceChatMgr.CreateCustomVoiceChatChannel(chn->GetName(), _player->GetTeamId());
    }
}

void WorldSession::HandleSetActiveVoiceChannelOpcode(WorldPackets::VoiceChat::SetActiveVoiceChannel& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_SET_ACTIVE_VOICE_CHANNEL");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player || !_player->IsInWorld())
        return;

    // leave current voice channel if player selects different one
    VoiceChatChannel* currentChannel = nullptr;
    if (GetCurrentVoiceChannelId())
        currentChannel = sVoiceChatMgr.GetVoiceChatChannel(GetCurrentVoiceChannelId());

    switch (packet.ChannelType)
    {
        case VOICECHAT_CHANNEL_CUSTOM:
        {
            auto cMgr = ChannelMgr(_player->GetTeamId());
            Channel* channel = cMgr.GetChannel(packet.ChannelName, nullptr, false);
            if (!channel || !channel->IsOn(_player->GetGUID()) || channel->IsBanned(_player->GetGUID()) || !channel->IsVoiceEnabled())
                return;

            VoiceChatChannel* voiceChannel = sVoiceChatMgr.GetCustomVoiceChatChannel(packet.ChannelName, _player->GetTeamId());

            SetActiveVoiceChannel(voiceChannel, currentChannel, _player);

            break;
        }
        case VOICECHAT_CHANNEL_GROUP:
        case VOICECHAT_CHANNEL_RAID:
        {
            Group* group = _player->GetGroup();
            if (group && (group->isBGGroup() || group->isBFGroup()))
                group = _player->GetOriginalGroup();

            if (group)
            {
                VoiceChatChannel* voiceChannel = nullptr;
                if (group->isRaidGroup())
                    voiceChannel = sVoiceChatMgr.GetRaidVoiceChatChannel(group->GetGroupId());
                else
                    voiceChannel = sVoiceChatMgr.GetGroupVoiceChatChannel(group->GetGroupId());

                SetActiveVoiceChannel(voiceChannel, currentChannel, _player);
            }

            break;
        }
        case VOICECHAT_CHANNEL_BG:
        {
            if (_player->InBattleground())
            {
                VoiceChatChannel* voiceChannel = sVoiceChatMgr.GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());

                SetActiveVoiceChannel(voiceChannel, currentChannel, _player);
            }

            break;
        }
        case VOICECHAT_CHANNEL_NONE:
        {
            // leave current channel
            if (currentChannel)
                currentChannel->DevoiceMember(_player->GetGUID());

            SetCurrentVoiceChannelId(0);

            break;
        }
        default:
            break;
    }
}

void WorldSession::HandleChannelVoiceOffOpcode(WorldPackets::VoiceChat::ChannelVoiceOff& /*packet*/)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_VOICE_OFF");

    // todo check if possible to send with chat commands
}

void WorldSession::HandleAddVoiceIgnoreOpcode(WorldPackets::VoiceChat::AddVoiceIgnore& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_ADD_VOICE_IGNORE");

    if (!_player)
        return;

    if (!normalizePlayerName(packet.IgnoreName))
        return;

    CharacterDatabase.EscapeString(packet.IgnoreName);

    ObjectGuid ignoreGuid = sCharacterCache->GetCharacterGuidByName(packet.IgnoreName);
    FriendsResult ignoreResult = FRIEND_MUTE_NOT_FOUND;
    if (ignoreGuid)
    {
        LOG_INFO("network", "WORLD: {} asked to Ignore: '{}'", _player->GetName(), packet.IgnoreName.c_str());

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

    LOG_DEBUG("network", "WORLD: Sent SMSG_FRIEND_STATUS");
}

void WorldSession::HandleDeleteVoiceIgnoreOpcode(WorldPackets::VoiceChat::DeleteVoiceIgnore& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_DEL_VOICE_IGNORE");

    if (!_player)
        return;

    _player->GetSocial()->RemoveFromSocialList(packet.IgnoreGuid, SOCIAL_FLAG_MUTED);

    sSocialMgr->SendFriendStatus(_player, FRIEND_MUTE_REMOVED, packet.IgnoreGuid, false);

    LOG_DEBUG("network", "WORLD: Sent SMSG_FRIEND_STATUS");
}

void WorldSession::HandlePartySilenceOpcode(WorldPackets::VoiceChat::PartySilence& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_PARTY_SILENCE");

    if (!_player)
        return;

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    Group* group = _player->GetGroup();
    if (!group)
        return;

    if (!group->IsMember(packet.SilenceGuid))
        return;

    if (!group->IsLeader(_player->GetGUID()) && group->IsMainAssistant(_player->GetGUID()))
        return;

    VoiceChatChannel* voiceChannel = nullptr;
    if (!group->isBGGroup() && !group->isBFGroup())
    {
        if (group->isRaidGroup())
            voiceChannel = sVoiceChatMgr.GetRaidVoiceChatChannel(group->GetGroupId());
        else
            voiceChannel = sVoiceChatMgr.GetGroupVoiceChatChannel(group->GetGroupId());
    }
    else if (_player->InBattleground())
        voiceChannel = sVoiceChatMgr.GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());

    if (!voiceChannel)
        return;

    voiceChannel->ForceMuteMember(packet.SilenceGuid);
}

void WorldSession::HandlePartyUnsilenceOpcode(WorldPackets::VoiceChat::PartyUnsilence& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_PARTY_UNSILENCE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player)
        return;

    Group* group = _player->GetGroup();
    if (!group)
        return;

    if (!group->IsMember(packet.UnsilenceGuid))
        return;

    if (!group->IsLeader(_player->GetGUID()) && !group->IsMainAssistant(_player->GetGUID()))
        return;

    VoiceChatChannel* voiceChannel = nullptr;
    if (!group->isBGGroup() && !group->isBFGroup())
    {
        if (group->isRaidGroup())
            voiceChannel = sVoiceChatMgr.GetRaidVoiceChatChannel(group->GetGroupId());
        else
            voiceChannel = sVoiceChatMgr.GetGroupVoiceChatChannel(group->GetGroupId());
    }
    else if (_player->InBattleground())
        voiceChannel = sVoiceChatMgr.GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());

    if (!voiceChannel)
        return;

    voiceChannel->ForceUnmuteMember(packet.UnsilenceGuid);
}

void WorldSession::HandleChannelSilenceOpcode(WorldPackets::VoiceChat::ChannelSilence& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_SILENCE_VOICE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player)
        return;

    auto cMgr = ChannelMgr(_player->GetTeamId());
    {
        Channel* channel = cMgr.GetChannel(packet.ChannelName, nullptr, false);
        if (channel && channel->IsVoiceEnabled())
        {
            ObjectGuid playerGuid = sCharacterCache->GetCharacterGuidByName(packet.PlayerName);
            if (!playerGuid)
                return;

            if (VoiceChatChannel* voiceChannel = sVoiceChatMgr.GetCustomVoiceChatChannel(packet.ChannelName, _player->GetTeamId()))
            {
                if (voiceChannel->IsOn(playerGuid))
                {
                    voiceChannel->ForceMuteMember(playerGuid);
                    // channel->SetMicMute(_player, packet.PlayerName.c_str(), true);
                }
            }
        }
    }
}

void WorldSession::HandleChannelUnsilenceOpcode(WorldPackets::VoiceChat::ChannelUnsilence& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_UNSILENCE_VOICE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player)
        return;

    auto cMgr = ChannelMgr(_player->GetTeamId());
    {
        Channel* channel = cMgr.GetChannel(packet.ChannelName, nullptr, false);
        if (channel && channel->IsVoiceEnabled())
        {

            ObjectGuid playerGuid = sCharacterCache->GetCharacterGuidByName(packet.PlayerName);
            if (!playerGuid)
                return;

            if (VoiceChatChannel* voiceChannel = sVoiceChatMgr.GetCustomVoiceChatChannel(packet.ChannelName, _player->GetTeamId()))
            {
                if (voiceChannel->IsOn(playerGuid))
                {
                    voiceChannel->ForceUnmuteMember(playerGuid);
                    // chan->SetMicMute(_player, packet.PlayerName.c_str(), false);
                }
            }
        }
    }
}

void WorldSession::SetActiveVoiceChannel(VoiceChatChannel* voiceChannel, VoiceChatChannel* currentChannel, Player* player)
{
    if (voiceChannel)
    {
        if (currentChannel)
        {
            // if same channel, just update roster
            if (voiceChannel == currentChannel)
            {
                voiceChannel->SendVoiceRosterUpdate();
                return;
            }
            else
                currentChannel->DevoiceMember(player->GetGUID());
        }

        voiceChannel->AddVoiceChatMember(player->GetGUID());
        if (voiceChannel->IsOn(player->GetGUID()))
        {
            // change speaker icon from grey to color
            voiceChannel->VoiceMember(player->GetGUID());
            // allow to speak depending on settings
            if (player->GetSession()->IsMicEnabled())
                voiceChannel->UnmuteMember(player->GetGUID());
            else
                voiceChannel->MuteMember(player->GetGUID());

            player->GetSession()->SetCurrentVoiceChannelId(voiceChannel->GetChannelId());
        }
    }
}
