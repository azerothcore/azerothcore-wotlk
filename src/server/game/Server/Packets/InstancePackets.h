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

#ifndef InstancePackets_h__
#define InstancePackets_h__

#include "Packet.h"
#include "Player.h"

namespace WorldPackets
{
    namespace Instance
    {
        class InstanceReset final : public ServerPacket
        {
        public:
            InstanceReset() : ServerPacket(SMSG_INSTANCE_RESET, 4) {}

            WorldPacket const* Write() override;

            uint32 MapId = 0;
        };

        class InstanceResetFailed final : public ServerPacket
        {
        public:
            InstanceResetFailed() : ServerPacket(SMSG_INSTANCE_RESET_FAILED, 4 + 4) {}

            WorldPacket const* Write() override;

            InstanceResetFailureReason Reason = INSTANCE_RESET_FAILED;
            uint32 MapId = 0;
        };

        class SetDungeonDifficulty final : public ServerPacket
        {
        public:
            SetDungeonDifficulty() : ServerPacket(MSG_SET_DUNGEON_DIFFICULTY, 12) {}

            WorldPacket const* Write() override;

            uint32 Difficulty = -1; // @TODO: Check if cast to Dungeon type will cause problems (SetRaidDifficulty() too)
            uint32 Unk = 0x00000001;
            uint32 IsInGroup = 0;
        };

        class SetDungeonDifficultyClient final : public ClientPacket
        {
        public:
            SetDungeonDifficultyClient(WorldPacket&& packet) : ClientPacket(MSG_SET_DUNGEON_DIFFICULTY, std::move(packet)) {}

            void Read() override;

            uint32 Mode = DUNGEON_DIFFICULTY_NORMAL;
        };

        class ResetFailedNotify final : public ServerPacket
        {
        public:
            ResetFailedNotify() : ServerPacket(SMSG_RESET_FAILED_NOTIFY, 4) {}

            WorldPacket const* Write() override;

            uint32 MapId = 0;
        };

        class SetRaidDifficulty final : public ServerPacket
        {
        public:
            SetRaidDifficulty() : ServerPacket(MSG_SET_RAID_DIFFICULTY, 12) {}

            WorldPacket const* Write() override;

            uint32 Difficulty = -1;
            uint32 Unk = 0x00000001;
            uint32 IsInGroup = 0;
        };

        class SetRaidDifficultyClient final : public ClientPacket
        {
        public:
            SetRaidDifficultyClient(WorldPacket&& packet) : ClientPacket(MSG_SET_RAID_DIFFICULTY, std::move(packet)) {}

            void Read() override;

            uint32 Mode = RAID_DIFFICULTY_10MAN_NORMAL;
        };

        class ResetInstances final : public ClientPacket
        {
        public:
            ResetInstances(WorldPacket&& packet) : ClientPacket(CMSG_RESET_INSTANCES, std::move(packet)) {}

            void Read() override {};
        };

        class InstanceLockResponse final : public ClientPacket
        {
        public:
            InstanceLockResponse(WorldPacket&& packet) : ClientPacket(CMSG_INSTANCE_LOCK_RESPONSE, std::move(packet)) {}

            void Read() override;

            uint8 Accept = 0;
        };
    }
}

#endif // InstancePackets_h__
