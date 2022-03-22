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

#ifndef MiscPackets_h__
#define MiscPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"
#include "Weather.h"

enum WeatherState : uint32;

namespace WorldPackets
{
    namespace Misc
    {
        class AC_GAME_API Weather final : public ServerPacket
        {
        public:
            Weather();
            Weather(WeatherState weatherID, float intensity = 0.0f, bool abrupt = false);

            WorldPacket const* Write() override;

            bool Abrupt = false;
            float Intensity = 0.0f;
            WeatherState WeatherID = WeatherState(0);
        };

        class LevelUpInfo final : public ServerPacket
        {
        public:
            LevelUpInfo() : ServerPacket(SMSG_LEVELUP_INFO, 56) { }

            WorldPacket const* Write() override;

            uint32 Level = 0;
            uint32 HealthDelta = 0;
            std::array<uint32, MAX_POWERS> PowerDelta = { };
            std::array<uint32, MAX_STATS> StatDelta = { };
        };

        class AC_GAME_API PlayMusic final : public ServerPacket
        {
        public:
            PlayMusic() : ServerPacket(SMSG_PLAY_MUSIC, 4) { }
            PlayMusic(uint32 soundKitID) : ServerPacket(SMSG_PLAY_MUSIC, 4), SoundKitID(soundKitID) { }

            WorldPacket const* Write() override;

            uint32 SoundKitID = 0;
        };

        class AC_GAME_API PlayObjectSound final : public ServerPacket
        {
        public:
            PlayObjectSound() : ServerPacket(SMSG_PLAY_OBJECT_SOUND, 4 + 8) { }
            PlayObjectSound(ObjectGuid const& sourceObjectGUID, uint32 soundKitID)
                : ServerPacket(SMSG_PLAY_OBJECT_SOUND, 4 + 8), SourceObjectGUID(sourceObjectGUID), SoundKitID(soundKitID) { }

            WorldPacket const* Write() override;

            ObjectGuid SourceObjectGUID;
            uint32 SoundKitID = 0;

        };

        class AC_GAME_API Playsound final : public ServerPacket
        {
        public:
            Playsound() : ServerPacket(SMSG_PLAY_SOUND, 4) { }
            Playsound(uint32 soundKitID) : ServerPacket(SMSG_PLAY_SOUND, 4), SoundKitID(soundKitID) { }

            WorldPacket const* Write() override;

            uint32 SoundKitID = 0;
        };

        class RandomRollClient final : public ClientPacket
        {
        public:
            RandomRollClient(WorldPacket&& packet) : ClientPacket(MSG_RANDOM_ROLL, std::move(packet)) { }

            void Read() override;

            uint32 Min = 0;
            uint32 Max = 0;
        };

        class RandomRoll final : public ServerPacket
        {
        public:
            RandomRoll() : ServerPacket(MSG_RANDOM_ROLL, 4 + 4 + 4 + 8) { }

            WorldPacket const* Write() override;

            uint32 Min = 0;
            uint32 Max = 0;
            uint32 Result = 0;
            ObjectGuid Roller;
        };

        class CrossedInebriationThreshold final : public ServerPacket
        {
        public:
            CrossedInebriationThreshold() : ServerPacket(SMSG_CROSSED_INEBRIATION_THRESHOLD, 8 + 4 + 4) { }

            WorldPacket const* Write() override;

            ObjectGuid Guid;
            uint32 Threshold = 0;
            uint32 ItemID = 0;
        };
    }
}

#endif // MiscPackets_h__
