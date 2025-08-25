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

#include "VoiceChatPackets.h"
#include "VoiceChatDefines.h"

void WorldPackets::VoiceChat::VoiceSessionEnable::Read()
{
    _worldPacket >> VoiceEnabled;
    _worldPacket >> MicrophoneEnabled;
}

void WorldPackets::VoiceChat::ChannelVoiceOn::Read()
{
    _worldPacket >> ChannelName;
}

void WorldPackets::VoiceChat::SetActiveVoiceChannel::Read()
{
    _worldPacket >> ChannelType;
    _worldPacket >> ChannelName;
}

void WorldPackets::VoiceChat::AddVoiceIgnore::Read()
{
    _worldPacket >> IgnoreName;
}

void WorldPackets::VoiceChat::DeleteVoiceIgnore::Read()
{
    _worldPacket >> IgnoreGuid;
}

void WorldPackets::VoiceChat::PartySilence::Read()
{
    _worldPacket >> SilenceGuid;
}

void WorldPackets::VoiceChat::PartyUnsilence::Read()
{
    _worldPacket >> UnsilenceGuid;
}

void WorldPackets::VoiceChat::ChannelSilence::Read()
{
    _worldPacket >> ChannelName;
    _worldPacket >> PlayerName;
}

void WorldPackets::VoiceChat::ChannelUnsilence::Read()
{
    _worldPacket >> ChannelName;
    _worldPacket >> PlayerName;
}

WorldPacket const* WorldPackets::VoiceChat::AvailableVoiceChannel::Write()
{
    _worldPacket << SessionId;
    _worldPacket << Type;
    if (Type == VOICECHAT_CHANNEL_CUSTOM)
        _worldPacket << ChannelName;
    else
        _worldPacket << uint8(0);
    _worldPacket << PlayerGuid;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::VoiceChat::VoiceSessionLeave::Write()
{
    _worldPacket << PlayerGuid;
    _worldPacket << SessionId;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::VoiceChat::VoiceChatStatus::Write()
{
    _worldPacket << Status;

    return &_worldPacket;
}
