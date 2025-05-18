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

#include "Log.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#include "Common.h"
#include "Group.h"
#include "Player.h"
#include "VoiceChatChannel.h"
#include "VoiceChatMgr.h"
#include "ChannelMgr.h"
#include "SocialMgr.h"
#include "World/World.h"
#include "WorldSession.h"
#include "Language.h"

void WorldSession::HandleVoiceSessionEnableOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: CMSG_VOICE_SESSION_ENABLE");
    LOG_ERROR("sql.sql", "WORLD: Received CMSG_VOICE_SESSION_ENABLE");

    if (!sVoiceChatMgr.CanSeeVoiceChat())
        return;

    // comes from in game voice chat settings
    // is sent during login or when changing settings
    uint8 voiceEnabled, micEnabled;
    recvData >> voiceEnabled;
    recvData >> micEnabled;

    if(!voiceEnabled)
    {
        if (_player)
        {
            sVoiceChatMgr.RemoveFromVoiceChatChannels(_player->GetGUID());
            SetCurrentVoiceChannelId(0);
        }
    }
    else
    {
        // send available voice channels
        if (_player && _player->IsInWorld() && !m_voiceEnabled)
        {
            // enable it here to allow joining channels
            m_voiceEnabled = voiceEnabled;
            m_micEnabled = micEnabled;
            sVoiceChatMgr.JoinAvailableVoiceChatChannels(this);
        }
    }

    if (!micEnabled)
    {
        if (_player)
        {
            if (GetCurrentVoiceChannelId())
            {
                VoiceChatChannel* current_channel = sVoiceChatMgr.GetVoiceChatChannel(GetCurrentVoiceChannelId());
                if (current_channel)
                    current_channel->MuteMember(_player->GetGUID());
            }
        }
    }
    else
    {
        if (_player)
        {
            if (GetCurrentVoiceChannelId())
            {
                VoiceChatChannel* current_channel = sVoiceChatMgr.GetVoiceChatChannel(GetCurrentVoiceChannelId());
                if (current_channel)
                    current_channel->UnmuteMember(_player->GetGUID());
            }
        }
    }

    m_micEnabled = micEnabled;
    m_voiceEnabled = voiceEnabled;
}

void WorldSession::HandleChannelVoiceOnOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: CMSG_CHANNEL_VOICE_ON");
    // Enable Voice button in channel context menu
    LOG_ERROR("sql.sql", "WORLD: Received CMSG_CHANNEL_VOICE_ON");

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
            //actual error
            LOG_ERROR("sql.sql", "VoiceChat: Channel is LFG or constant, can't use voice!");
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
    LOG_DEBUG("network", "WORLD: CMSG_SET_ACTIVE_VOICE_CHANNEL");
    recvData.read_skip<uint32>();
    recvData.read_skip<char*>();
}

void WorldSession::HandleSetActiveVoiceChannelOpcode(WorldPacket & recvData)
{
    LOG_ERROR("sql.sql", "WORLD: Received CMSG_SET_ACTIVE_VOICE_CHANNEL");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player || !_player->IsInWorld())
        return;

    uint32 type;
    std::string name;
    recvData >> type;

    // leave current voice channel if player selects different one
    VoiceChatChannel* current_channel = nullptr;
    if (GetCurrentVoiceChannelId())
        current_channel = sVoiceChatMgr.GetVoiceChatChannel(GetCurrentVoiceChannelId());

    switch (type)
    {
        case VOICECHAT_CHANNEL_CUSTOM:
        {
            recvData >> name;
            // custom channel
            auto cMgr = ChannelMgr(_player->GetTeamId());
            if (&cMgr)
            {
                Channel* chan = cMgr.GetChannel(name, nullptr, false);
                if (!chan || !chan->IsOn(_player->GetGUID()) || chan->IsBanned(_player->GetGUID()) || !chan->IsVoiceEnabled())
                    return;
            }
            else
                return;

            if (VoiceChatChannel* v_channel = sVoiceChatMgr.GetCustomVoiceChatChannel(name, _player->GetTeamId()))
            {
                if (current_channel)
                {
                    // if same channel, just update roster
                    if (v_channel == current_channel)
                    {
                        v_channel->SendVoiceRosterUpdate();
                        return;
                    }
                    else
                        current_channel->DevoiceMember(_player->GetGUID());
                }

                v_channel->AddVoiceChatMember(_player->GetGUID());
                if (v_channel->IsOn(_player->GetGUID()))
                {
                    // change speaker icon from grey to color
                    v_channel->VoiceMember(_player->GetGUID());
                    // allow to speak depending on settings
                    if (IsMicEnabled())
                        v_channel->UnmuteMember(_player->GetGUID());
                    else
                        v_channel->MuteMember(_player->GetGUID());

                    SetCurrentVoiceChannelId(v_channel->GetChannelId());
                }
            }

            break;
        }
        case VOICECHAT_CHANNEL_GROUP:
        case VOICECHAT_CHANNEL_RAID:
        {
            // group
            Group* grp = _player->GetGroup();
            if (grp && grp->isBGGroup())
                grp = _player->GetOriginalGroup();

            if (grp)
            {
                VoiceChatChannel* v_channel = nullptr;
                if (grp->isRaidGroup())
                    v_channel = sVoiceChatMgr.GetRaidVoiceChatChannel(grp->GetId());
                else
                    v_channel = sVoiceChatMgr.GetGroupVoiceChatChannel(grp->GetId());

                if (v_channel)
                {
                    if (current_channel)
                    {
                        // if same channel, just update roster
                        if (v_channel == current_channel)
                        {
                            v_channel->SendVoiceRosterUpdate();
                            return;
                        }
                        else
                            current_channel->DevoiceMember(_player->GetGUID());
                    }

                    v_channel->AddVoiceChatMember(_player->GetGUID());
                    if (v_channel->IsOn(_player->GetGUID()))
                    {
                        // change speaker icon from grey to color
                        v_channel->VoiceMember(_player->GetGUID());
                        // allow to speak depending on settings
                        if (IsMicEnabled())
                            v_channel->UnmuteMember(_player->GetGUID());
                        else
                            v_channel->MuteMember(_player->GetGUID());

                        SetCurrentVoiceChannelId(v_channel->GetChannelId());
                    }
                }
            }

            break;
        }
        case VOICECHAT_CHANNEL_BG:
        {
            // bg
            if (_player->InBattleground())
            {
                VoiceChatChannel* v_channel = sVoiceChatMgr.GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());
                if (v_channel)
                {
                    if (current_channel)
                    {
                        // if same channel, just update roster
                        if (v_channel == current_channel)
                        {
                            v_channel->SendVoiceRosterUpdate();
                            return;
                        }
                        else
                            current_channel->DevoiceMember(_player->GetGUID());
                    }

                    v_channel->AddVoiceChatMember(_player->GetGUID());
                    if (v_channel->IsOn(_player->GetGUID()))
                    {
                        // change speaker icon from grey to color
                        v_channel->VoiceMember(_player->GetGUID());
                        // allow to speak depending on settings
                        if (IsMicEnabled())
                            v_channel->UnmuteMember(_player->GetGUID());
                        else
                            v_channel->MuteMember(_player->GetGUID());

                        SetCurrentVoiceChannelId(v_channel->GetChannelId());
                    }
                }
            }

            break;
        }
        case VOICECHAT_CHANNEL_NONE:
        {
            // leave current channel
            if (current_channel)
            {
                current_channel->DevoiceMember(_player->GetGUID());
            }
            SetCurrentVoiceChannelId(0);

            break;
        }
        default:
            break;
    }
}

void WorldSession::HandleChannelVoiceOffOpcode(WorldPacket& recvData)
{
    LOG_ERROR("sql.sql", "WORLD: Received CMSG_CHANNEL_VOICE_OFF");

    // todo check if possible to send with chat commands
}

void WorldSession::HandleAddVoiceIgnoreOpcode(WorldPacket& recvData)
{
    LOG_ERROR("sql.sql", "WORLD: Received opcode CMSG_ADD_VOICE_IGNORE");

    std::string IgnoreName = GetAcoreString(LANG_FRIEND_IGNORE_UNKNOWN);

    recvData >> IgnoreName;

    if (!normalizePlayerName(IgnoreName))
        return;

    CharacterDatabase.EscapeString(IgnoreName);

    LOG_ERROR("sql.sql", "WORLD: {} asked to Ignore: '{}'",
        _player->GetName(), IgnoreName.c_str());

    ObjectGuid ignoreGUID = sCharacterCache->GetCharacterGuidByName(IgnoreName);
    if (!ignoreGUID)
        return;

    // CharacterDatabase.AsyncQuery(&WorldSession::HandleAddMutedOpcodeCallBack, GetAccountId(), "SELECT guid FROM characters WHERE name = '{}'", IgnoreName.c_str());
    // _queryProcessor.AddCallback(CharacterDatabase.AsyncQuery(stmt).WithPreparedCallback(std::bind(&WorldSession::HandleAddMutedOpcodeCallBack, this, std::placeholders::_1)));
    
    if (!_player)
        return;

    FriendsResult ignoreResult = FRIEND_MUTE_NOT_FOUND;
    if (ignoreGUID == _player->GetGUID())
        ignoreResult = FRIEND_MUTE_SELF;
    else if (_player->GetSocial()->HasMute(ignoreGUID))
        ignoreResult = FRIEND_MUTE_ALREADY;
    else
    {
        ignoreResult = FRIEND_MUTE_ADDED;

        // mute list full
        if (!_player->GetSocial()->AddToSocialList(ignoreGUID, SOCIAL_FLAG_MUTED))
            ignoreResult = FRIEND_MUTE_FULL;
    }

    sSocialMgr->SendFriendStatus(_player, ignoreResult, ignoreGUID, false);

    LOG_ERROR("sql.sql", "WORLD: Sent (SMSG_FRIEND_STATUS)");
}

void WorldSession::HandleDelVoiceIgnoreOpcode(WorldPacket& recvData)
{
    ObjectGuid ignoreGUID;

    LOG_ERROR("sql.sql", "WORLD: Received opcode CMSG_DEL_VOICE_IGNORE");

    recvData >> ignoreGUID;

    _player->GetSocial()->RemoveFromSocialList(ignoreGUID, SOCIAL_FLAG_MUTED);

    sSocialMgr->SendFriendStatus(GetPlayer(), FRIEND_MUTE_REMOVED, ignoreGUID, false);

    LOG_ERROR("sql.sql", "WORLD: Sent motd (SMSG_FRIEND_STATUS)");
}

void WorldSession::HandlePartySilenceOpcode(WorldPacket& recvData)
{
    LOG_ERROR("sql.sql", "WORLD: Received CMSG_PARTY_SILENCE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    ObjectGuid ignoreGUID;
    recvData >> ignoreGUID;

    if (!_player)
        return;

    Group* grp = _player->GetGroup();
    if (!grp)
        return;

    if (!grp->IsMember(ignoreGUID))
        return;

    if (!grp->IsLeader(_player->GetGUID()) && grp->IsMainAssistant(_player->GetGUID()))
        return;

    VoiceChatChannel* v_channel = nullptr;
    if (!grp->isBGGroup())
    {
        if (grp->isRaidGroup())
            v_channel = sVoiceChatMgr.GetRaidVoiceChatChannel(grp->GetId());
        else
            v_channel = sVoiceChatMgr.GetGroupVoiceChatChannel(grp->GetId());
    }
    else if (_player->InBattleground())
        v_channel = sVoiceChatMgr.GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());

    if (!v_channel)
        return;

    v_channel->ForceMuteMember(ignoreGUID);
}

void WorldSession::HandlePartyUnsilenceOpcode(WorldPacket& recvData)
{
    LOG_ERROR("sql.sql", "WORLD: Received CMSG_PARTY_UNSILENCE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    ObjectGuid ignoreGUID;
    recvData >> ignoreGUID;

    if (!_player)
        return;

    Group* grp = _player->GetGroup();
    if (!grp)
        return;

    if (!grp->IsMember(ignoreGUID))
        return;

    if (!grp->IsLeader(_player->GetGUID()) && !grp->IsMainAssistant(_player->GetGUID()))
        return;

    VoiceChatChannel* v_channel = nullptr;
    if (!grp->isBGGroup())
    {
        if (grp->isRaidGroup())
            v_channel = sVoiceChatMgr.GetRaidVoiceChatChannel(grp->GetId());
        else
            v_channel = sVoiceChatMgr.GetGroupVoiceChatChannel(grp->GetId());
    }
    else if (_player->InBattleground())
        v_channel = sVoiceChatMgr.GetBattlegroundVoiceChatChannel(_player->GetBattlegroundId(), _player->GetBgTeamId());

    if (!v_channel)
        return;

    v_channel->ForceUnmuteMember(ignoreGUID);
}

void WorldSession::HandleChannelSilenceOpcode(WorldPacket& recvData)
{
    LOG_ERROR("sql.sql", "WORLD: Received CMSG_CHANNEL_SILENCE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player)
        return;

    std::string channelName, playerName;
    recvData >> channelName >> playerName;

    auto cMgr = ChannelMgr(_player->GetTeamId());
    {
        Channel* chan = cMgr.GetChannel(channelName, nullptr, false);
        if (chan && chan->IsVoiceEnabled())
        {
            ObjectGuid plrGuid = sCharacterCache->GetCharacterGuidByName(playerName);
            if (!plrGuid)
                return;

            if (VoiceChatChannel* v_channel = sVoiceChatMgr.GetCustomVoiceChatChannel(channelName, _player->GetTeamId()))
            {
                if (v_channel->IsOn(plrGuid))
                {
                    v_channel->ForceMuteMember(plrGuid);
                    // chan->SetMicMute(_player, playerName.c_str(), true);
                }
            }
        }
    }
}

void WorldSession::HandleChannelUnsilenceOpcode(WorldPacket& recvData)
{
    LOG_ERROR("sql.sql", "WORLD: Received CMSG_CHANNEL_UNSILENCE");

    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    if (!_player)
        return;

    std::string channelName, playerName;
    recvData >> channelName >> playerName;

    auto cMgr = ChannelMgr(_player->GetTeamId());
    {
        Channel* chan = cMgr.GetChannel(channelName, nullptr, false);
        if (chan && chan->IsVoiceEnabled())
        {

            ObjectGuid plrGuid = sCharacterCache->GetCharacterGuidByName(playerName);
            if (!plrGuid)
                return;

            if (VoiceChatChannel* v_channel = sVoiceChatMgr.GetCustomVoiceChatChannel(channelName, _player->GetTeamId()))
            {
                if (v_channel->IsOn(plrGuid))
                {
                    v_channel->ForceUnmuteMember(plrGuid);
                    // chan->SetMicMute(_player, playerName.c_str(), false);
                }
            }
        }
    }
}
