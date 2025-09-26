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

#ifndef VoiceChatPackets_h__
#define VoiceChatPackets_h__

#include "ObjectGuid.h"
#include "Packet.h"

namespace WorldPackets
{
    namespace VoiceChat
    {
        class VoiceSessionEnable final : public ClientPacket
        {
        public:
            VoiceSessionEnable(WorldPacket&& packet) : ClientPacket(CMSG_VOICE_SESSION_ENABLE, std::move(packet)) {}

            void Read() override;

            uint8 VoiceEnabled = 0;
            uint8 MicrophoneEnabled = 0;
        };

        class ChannelVoiceOn final : public ClientPacket
        {
        public:
            ChannelVoiceOn(WorldPacket&& packet) : ClientPacket(CMSG_CHANNEL_VOICE_ON, std::move(packet)) {}

            void Read() override;

            std::string ChannelName = "";
        };

        class SetActiveVoiceChannel final : public ClientPacket
        {
        public:
            SetActiveVoiceChannel(WorldPacket&& packet) : ClientPacket(CMSG_SET_ACTIVE_VOICE_CHANNEL, std::move(packet)) {}

            void Read() override;

            uint32 ChannelType;
            std::string ChannelName = "";
        };

        class ChannelVoiceOff final : public ClientPacket
        {
        public:
            ChannelVoiceOff(WorldPacket&& packet) : ClientPacket(CMSG_CHANNEL_VOICE_OFF, std::move(packet)) {}

            void Read() override {};
        };

        class AddVoiceIgnore final : public ClientPacket
        {
        public:
            AddVoiceIgnore(WorldPacket&& packet) : ClientPacket(CMSG_ADD_VOICE_IGNORE, std::move(packet)) {}

            void Read() override;

            std::string IgnoreName = "";
        };

        class DeleteVoiceIgnore final : public ClientPacket
        {
        public:
            DeleteVoiceIgnore(WorldPacket&& packet) : ClientPacket(CMSG_DEL_VOICE_IGNORE, std::move(packet)) {}

            void Read() override;

            ObjectGuid IgnoreGuid;
        };

        class PartySilence final : public ClientPacket
        {
        public:
            PartySilence(WorldPacket&& packet) : ClientPacket(CMSG_PARTY_SILENCE, std::move(packet)) {}

            void Read() override;

            ObjectGuid SilenceGuid;
        };

        class PartyUnsilence final : public ClientPacket
        {
        public:
            PartyUnsilence(WorldPacket&& packet) : ClientPacket(CMSG_PARTY_UNSILENCE, std::move(packet)) {}

            void Read() override;

            ObjectGuid UnsilenceGuid;
        };

        class ChannelSilence final : public ClientPacket
        {
        public:
            ChannelSilence(WorldPacket&& packet) : ClientPacket(CMSG_CHANNEL_SILENCE_VOICE, std::move(packet)) {}

            void Read() override;

            std::string ChannelName = "";
            std::string PlayerName = "";
        };

        class ChannelUnsilence final : public ClientPacket
        {
        public:
            ChannelUnsilence(WorldPacket&& packet) : ClientPacket(CMSG_CHANNEL_UNSILENCE_VOICE, std::move(packet)) {}

            void Read() override;

            std::string ChannelName = "";
            std::string PlayerName = "";
        };

        class AvailableVoiceChannel final : public ServerPacket
        {
        public:
            AvailableVoiceChannel() : ServerPacket(SMSG_AVAILABLE_VOICE_CHANNEL) {}

            WorldPacket const* Write() override;

            uint64 SessionId = 0;
            uint8 Type = 0;
            std::string_view ChannelName = "";
            ObjectGuid PlayerGuid;
        };

        class VoiceSessionLeave final : public ServerPacket
        {
        public:
            VoiceSessionLeave() : ServerPacket(SMSG_VOICE_SESSION_LEAVE, 16) {}

            WorldPacket const* Write() override;

            ObjectGuid PlayerGuid;
            uint64 SessionId = 0;
        };

        class VoiceSessionFull final : public ServerPacket
        {
        public:
            VoiceSessionFull() : ServerPacket(SMSG_VOICESESSION_FULL, 0) {}

            WorldPacket const* Write() override { return &_worldPacket; };
        };

        class VoiceChatStatus final : public ServerPacket
        {
        public:
            VoiceChatStatus() : ServerPacket(SMSG_VOICE_CHAT_STATUS, 1) {}

            WorldPacket const* Write() override;

            uint8 Status;
        };

        class ComSatDisconnect final : public ServerPacket
        {
        public:
            ComSatDisconnect() : ServerPacket(SMSG_COMSAT_DISCONNECT, 0) {}

            WorldPacket const* Write() override { return &_worldPacket; };
        };

        class ComSatConnectFail final : public ServerPacket
        {
        public:
            ComSatConnectFail() : ServerPacket(SMSG_COMSAT_CONNECT_FAIL, 0) {}

            WorldPacket const* Write() override { return &_worldPacket; };
        };

        class ComSatReconnectTry final : public ServerPacket
        {
        public:
            ComSatReconnectTry() : ServerPacket(SMSG_COMSAT_RECONNECT_TRY, 0) {}

            WorldPacket const* Write() override { return &_worldPacket; };
        };
    }
}

#endif // VoiceChatPackets_h__
