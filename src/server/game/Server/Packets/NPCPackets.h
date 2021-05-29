/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef NPCPackets_h__
#define NPCPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"
#include <array>

namespace WorldPackets
{
    namespace NPC
    {
        // CMSG_BANKER_ACTIVATE
        // CMSG_BATTLEMASTER_HELLO
        // CMSG_BINDER_ACTIVATE
        // CMSG_GOSSIP_HELLO
        // CMSG_LIST_INVENTORY
        // CMSG_TRAINER_LIST
        class Hello final : public ClientPacket
        {
        public:
            Hello(WorldPacket&& packet) : ClientPacket(std::move(packet)) { }

            void Read() override;

            ObjectGuid Unit;
        };

        struct TrainerListSpell
        {
            int32 SpellID          = 0;
            uint8 Usable           = 0;
            int32 MoneyCost        = 0;
            int32 ProfessionDialog = 0;
            int32 ProfessionButton = 0;
            uint8 ReqLevel         = 0;
            int32 ReqSkillLine     = 0;
            int32 ReqSkillRank     = 0;
            std::array<int32, 3> ReqAbility = { };
        };

        class TrainerList final : public ServerPacket
        {
        public:
            TrainerList() : ServerPacket(SMSG_TRAINER_LIST) { }

            WorldPacket const* Write() override;

            ObjectGuid TrainerGUID;
            int32 TrainerType = 0;
            std::vector<TrainerListSpell> Spells;
            std::string Greeting;
        };

        class TrainerBuySpell final : public ClientPacket
        {
        public:
            TrainerBuySpell(WorldPacket&& packet) : ClientPacket(CMSG_TRAINER_BUY_SPELL, std::move(packet)) { }

            void Read() override;

            ObjectGuid TrainerGUID;
            int32 SpellID = 0;
        };

        class TrainerBuyFailed final : public ServerPacket
        {
        public:
            TrainerBuyFailed() : ServerPacket(SMSG_TRAINER_BUY_FAILED, 8 + 4 + 4) { }

            WorldPacket const* Write() override;

            ObjectGuid TrainerGUID;
            int32 SpellID             = 0;
            int32 TrainerFailedReason = 0;
        };

        class TrainerBuySucceeded final : public ServerPacket
        {
        public:
            TrainerBuySucceeded() : ServerPacket(SMSG_TRAINER_BUY_SUCCEEDED, 8 + 4) { }

            WorldPacket const* Write() override;

            ObjectGuid TrainerGUID;
            int32 SpellID = 0;
        };
    }
}

#endif // NPCPackets_h__