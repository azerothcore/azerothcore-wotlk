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

#ifndef QuestPackets_h__
#define QuestPackets_h__

#include "ObjectGuid.h"
#include "Packet.h"
#include "QuestDef.h"

namespace WorldPackets
{
    namespace Quest
    {
        class QuestLogFull final : public ServerPacket
        {
        public:
            QuestLogFull() : ServerPacket(SMSG_QUESTLOG_FULL, 0) {}

            WorldPacket const* Write() override { return &_worldPacket; }
        };

        class QuestUpdateComplete final : public ServerPacket
        {
        public:
            QuestUpdateComplete() : ServerPacket(SMSG_QUESTUPDATE_COMPLETE, 4) {}

            WorldPacket const* Write() override;

            uint32 QuestId = 0;
        };

        class QuestGiverQuestComplete final : public ServerPacket
        {
        public:
            QuestGiverQuestComplete() : ServerPacket(SMSG_QUESTGIVER_QUEST_COMPLETE, 4 + 4 + 4 + 4 + 4) {}

            WorldPacket const* Write() override;

            uint32 QuestId = 0;
            uint32 Experience = 0;
            uint32 RewardMoney = 0;
            uint32 RewardHonor = 0;
            uint32 RewardTalents = 0;
            uint32 RewardArena = 0;
        };

        class QuestGiverQuestFailed final : public ServerPacket
        {
        public:
            QuestGiverQuestFailed() : ServerPacket(SMSG_QUESTGIVER_QUEST_FAILED, 4 + 4) {}

            WorldPacket const* Write() override;

            uint32 QuestId = 0;
            uint32 FailureReason = 0;
        };

        class QuestUpdateFailedTimer final : public ServerPacket
        {
        public:
            QuestUpdateFailedTimer() : ServerPacket(SMSG_QUESTUPDATE_FAILEDTIMER, 4) {}

            WorldPacket const* Write() override;

            uint32 QuestId = 0;
        };

        class QuestGiverQuestInvalid final : public ServerPacket
        {
        public:
            QuestGiverQuestInvalid() : ServerPacket(SMSG_QUESTGIVER_QUEST_INVALID, 4) {}

            WorldPacket const* Write() override;

            QuestFailedReason FailureReason = INVALIDREASON_DONT_HAVE_REQ;
        };

        class QuestConfirmAccept final : public ServerPacket
        {
        public:
            QuestConfirmAccept() : ServerPacket(SMSG_QUEST_CONFIRM_ACCEPT, 4 + 16 + 8) {}

            WorldPacket const* Write() override;

            uint32 QuestId = 0;
            std::string_view QuestTitle = "";
            ObjectGuid PlayerGuid;
        };

        class QuestPushResult final : public ServerPacket
        {
        public:
            QuestPushResult() : ServerPacket(MSG_QUEST_PUSH_RESULT, 8 + 1) {}

            WorldPacket const* Write() override;

            ObjectGuid PlayerGuid;
            QuestShareMessages QuestShareMessage = QUEST_PARTY_MSG_SHARING_QUEST; // valid values: 0-8
        };

        class QuestUpdateAddItem final : public ServerPacket
        {
        public:
            QuestUpdateAddItem() : ServerPacket(SMSG_QUESTUPDATE_ADD_ITEM, 0) {}

            WorldPacket const* Write() override { return &_worldPacket; };
        };

        class QuestUpdateAddKill final : public ServerPacket
        {
        public:
            QuestUpdateAddKill() : ServerPacket(SMSG_QUESTUPDATE_ADD_KILL, 4 * 4 + 8) {}

            WorldPacket const* Write() override;

            uint32 QuestId = 0;
            uint32 CreatureEntry = 0;
            uint32 CurrentCount = 0;
            uint32 RequiredCount = 0;
            ObjectGuid ObjectiveGuid;
        };

        class QuestUpdateAddPvPKill final : public ServerPacket
        {
        public:
            QuestUpdateAddPvPKill() : ServerPacket(SMSG_QUESTUPDATE_ADD_PVP_KILL, 3 * 4) {}

            WorldPacket const* Write() override;

            uint32 QuestId = 0;
            uint32 CurrentCount = 0;
            uint32 RequiredCount = 0;
        };

        class QuestPushResultClient final : public ClientPacket
        {
        public:
            QuestPushResultClient(WorldPacket&& packet) : ClientPacket(MSG_QUEST_PUSH_RESULT, std::move(packet)) {}

            void Read() override;

            ObjectGuid PlayerGuid;
            uint32 QuestId = 0;
            QuestShareMessages QuestShareMessage = QUEST_PARTY_MSG_SHARING_QUEST;
        };

        class QuestGiverQuestAutoLaunch final : public ClientPacket
        {
        public:
            QuestGiverQuestAutoLaunch(WorldPacket&& packet) : ClientPacket(CMSG_QUESTGIVER_QUEST_AUTOLAUNCH, std::move(packet)) {}

            void Read() override {};
        };

        class QuestLogSwapQuest final : public ClientPacket
        {
        public:
            QuestLogSwapQuest(WorldPacket&& packet) : ClientPacket(CMSG_QUESTLOG_SWAP_QUEST, std::move(packet)) {}

            void Read() override;

            uint8 Slot1 = 0;
            uint8 Slot2 = 0;
        };

        class QuestLogRemoveQuest final : public ClientPacket
        {
        public:
            QuestLogRemoveQuest(WorldPacket&& packet) : ClientPacket(CMSG_QUESTLOG_REMOVE_QUEST, std::move(packet)) {}

            void Read() override;

            uint8 Slot = 0;
        };

        class QuestConfirmAcceptClient final : public ClientPacket
        {
        public:
            QuestConfirmAcceptClient(WorldPacket&& packet) : ClientPacket(CMSG_QUEST_CONFIRM_ACCEPT, std::move(packet)) {}

            void Read() override;

            uint32 QuestId = 0;
        };

        class PushQuestToParty final : public ClientPacket
        {
        public:
            PushQuestToParty(WorldPacket&& packet) : ClientPacket(CMSG_PUSHQUESTTOPARTY, std::move(packet)) {}

            void Read() override;

            uint32 QuestId = 0;
        };
    }
}

#endif // QuestPackets_h__
