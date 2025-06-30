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
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleVoiceSessionEnableOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_VOICE_SESSION_ENABLE");

    if (!sVoiceChatMgr.CanSeeVoiceChat())
        return;

    // comes from in game voice chat settings
    // is sent during login or when changing settings
    uint8 voiceEnabled, micEnabled;
    recvData >> voiceEnabled;
    recvData >> micEnabled;

    if (!_player)
    {
        _micEnabled = micEnabled;
        _voiceEnabled = voiceEnabled;
        return;
    }

    if (!voiceEnabled)
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
            _voiceEnabled = voiceEnabled;
            _micEnabled = micEnabled;
            sVoiceChatMgr.JoinAvailableVoiceChatChannels(this);
        }
    }

    if (GetCurrentVoiceChannelId())
    {
        VoiceChatChannel* currentChannel = sVoiceChatMgr.GetVoiceChatChannel(GetCurrentVoiceChannelId());
        if (currentChannel)
        {
            if (!micEnabled)
                currentChannel->MuteMember(_player->GetGUID());
            else
                currentChannel->UnmuteMember(_player->GetGUID());
        }
    }

    _micEnabled = micEnabled;
    _voiceEnabled = voiceEnabled;
}

void WorldSession::HandleChannelVoiceOnOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_VOICE_ON");
    // Enable Voice button in channel context menu

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    std::string name;
    recvData >> name;

    if (!_player)
        return;

    // custom channel
    auto cMgr = ChannelMgr(_player->GetTeamId());
    {
        Channel* chn = cMgr.GetChannel(name, _player);
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

void WorldSession::HandleSetActiveVoiceChannel(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_SET_ACTIVE_VOICE_CHANNEL");
    recvData.read_skip<uint32>();
    recvData.read_skip<char*>();
}

void WorldSession::HandleSetActiveVoiceChannelOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_SET_ACTIVE_VOICE_CHANNEL");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player || !_player->IsInWorld())
        return;

    uint32 type;
    std::string name;
    recvData >> type;

    // leave current voice channel if player selects different one
    VoiceChatChannel* currentChannel = nullptr;
    if (GetCurrentVoiceChannelId())
        currentChannel = sVoiceChatMgr.GetVoiceChatChannel(GetCurrentVoiceChannelId());

    switch (type)
    {
        case VOICECHAT_CHANNEL_CUSTOM:
        {
            recvData >> name;

            auto cMgr = ChannelMgr(_player->GetTeamId());
            Channel* channel = cMgr.GetChannel(name, nullptr, false);
            if (!channel || !channel->IsOn(_player->GetGUID()) || channel->IsBanned(_player->GetGUID()) || !channel->IsVoiceEnabled())
                return;

            VoiceChatChannel* voiceChannel = sVoiceChatMgr.GetCustomVoiceChatChannel(name, _player->GetTeamId());

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

void WorldSession::HandleChannelVoiceOffOpcode(WorldPacket& /*recvData*/)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_VOICE_OFF");

    // todo check if possible to send with chat commands
}

void WorldSession::HandleAddVoiceIgnoreOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_ADD_VOICE_IGNORE");

    if (!_player)
        return;

    std::string ignoreName = GetAcoreString(LANG_FRIEND_IGNORE_UNKNOWN);

    recvData >> ignoreName;

    if (!normalizePlayerName(ignoreName))
        return;

    CharacterDatabase.EscapeString(ignoreName);

    ObjectGuid ignoreGuid = sCharacterCache->GetCharacterGuidByName(ignoreName);
    if (!ignoreGuid)
        return;

    LOG_INFO("network", "WORLD: {} asked to Ignore: '{}'", _player->GetName(), ignoreName.c_str());

    FriendsResult ignoreResult = FRIEND_MUTE_NOT_FOUND;
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

    LOG_DEBUG("network", "WORLD: Sent SMSG_FRIEND_STATUS");
}

void WorldSession::HandleDelVoiceIgnoreOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_DEL_VOICE_IGNORE");

    if (!_player)
        return;

    ObjectGuid ignoreGuid;

    recvData >> ignoreGuid;

    _player->GetSocial()->RemoveFromSocialList(ignoreGuid, SOCIAL_FLAG_MUTED);

    sSocialMgr->SendFriendStatus(_player, FRIEND_MUTE_REMOVED, ignoreGuid, false);

    LOG_DEBUG("network", "WORLD: Sent SMSG_FRIEND_STATUS");
}

void WorldSession::HandlePartySilenceOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_PARTY_SILENCE");

    if (!_player)
        return;

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    ObjectGuid ignoreGuid;
    recvData >> ignoreGuid;

    Group* group = _player->GetGroup();
    if (!group)
        return;

    if (!group->IsMember(ignoreGuid))
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

    voiceChannel->ForceMuteMember(ignoreGuid);
}

void WorldSession::HandlePartyUnsilenceOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_PARTY_UNSILENCE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    ObjectGuid ignoreGuid;
    recvData >> ignoreGuid;

    if (!_player)
        return;

    Group* group = _player->GetGroup();
    if (!group)
        return;

    if (!group->IsMember(ignoreGuid))
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

    voiceChannel->ForceUnmuteMember(ignoreGuid);
}

void WorldSession::HandleChannelSilenceOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_SILENCE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player)
        return;

    std::string channelName, playerName;
    recvData >> channelName >> playerName;

    auto cMgr = ChannelMgr(_player->GetTeamId());
    {
        Channel* channel = cMgr.GetChannel(channelName, nullptr, false);
        if (channel && channel->IsVoiceEnabled())
        {
            ObjectGuid playerGuid = sCharacterCache->GetCharacterGuidByName(playerName);
            if (!playerGuid)
                return;

            if (VoiceChatChannel* voiceChannel = sVoiceChatMgr.GetCustomVoiceChatChannel(channelName, _player->GetTeamId()))
            {
                if (voiceChannel->IsOn(playerGuid))
                {
                    voiceChannel->ForceMuteMember(playerGuid);
                    // channel->SetMicMute(_player, playerName.c_str(), true);
                }
            }
        }
    }
}

void WorldSession::HandleChannelUnsilenceOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_CHANNEL_UNSILENCE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player)
        return;

    std::string channelName, playerName;
    recvData >> channelName >> playerName;

    auto cMgr = ChannelMgr(_player->GetTeamId());
    {
        Channel* channel = cMgr.GetChannel(channelName, nullptr, false);
        if (channel && channel->IsVoiceEnabled())
        {

            ObjectGuid playerGuid = sCharacterCache->GetCharacterGuidByName(playerName);
            if (!playerGuid)
                return;

            if (VoiceChatChannel* voiceChannel = sVoiceChatMgr.GetCustomVoiceChatChannel(channelName, _player->GetTeamId()))
            {
                if (voiceChannel->IsOn(playerGuid))
                {
                    voiceChannel->ForceUnmuteMember(playerGuid);
                    // chan->SetMicMute(_player, playerName.c_str(), false);
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
