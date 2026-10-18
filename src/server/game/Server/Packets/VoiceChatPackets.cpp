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

void WorldPackets::VoiceChat::ChannelVoiceOff::Read()
{
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
    _worldPacket >> PvpRaid;
}

void WorldPackets::VoiceChat::PartyUnsilence::Read()
{
    _worldPacket >> UnsilenceGuid;
    _worldPacket >> PvpRaid;
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

void WorldPackets::VoiceChat::ChannelSilenceAll::Read()
{
    _worldPacket >> ChannelName;
    _worldPacket >> PlayerName;
}

void WorldPackets::VoiceChat::ChannelUnsilenceAll::Read()
{
    _worldPacket >> ChannelName;
    _worldPacket >> PlayerName;
}

WorldPacket const* WorldPackets::VoiceChat::AvailableVoiceChannel::Write()
{
    _worldPacket << SessionId;
    _worldPacket << uint8(Type);
    if (Type == VoiceChatChannelType::Custom)
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

WorldPacket const* WorldPackets::VoiceChat::NotifyPartySquelch::Write()
{
    _worldPacket << uint32(Squelched ? 1 : 0);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::VoiceChat::EchoPartySquelch::Write()
{
    _worldPacket << PlayerGuid;
    _worldPacket << uint32(Squelched ? 1 : 0);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::VoiceChat::VoiceChatStatus::Write()
{
    _worldPacket << Status;

    return &_worldPacket;
}
