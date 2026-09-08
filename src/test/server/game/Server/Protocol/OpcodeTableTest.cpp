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

#include "GuildPackets.h"
#include "Opcodes.h"
#include "gtest/gtest.h"

TEST(OpcodeTableTest, KeepsDirectionsIndependent)
{
    OpcodeTable table;
    table.Initialize();

    OpcodeClient clientOverlap = static_cast<OpcodeClient>(0x0014);
    OpcodeServer serverOverlap = static_cast<OpcodeServer>(0x0014);
    ASSERT_NE(table[clientOverlap], nullptr);
    ASSERT_NE(table[serverOverlap], nullptr);
    EXPECT_STREQ(table[clientOverlap]->Name, "CMSG_CREATEGAMEOBJECT");
    EXPECT_STREQ(table[serverOverlap]->Name, "SMSG_GAMETIME_SET");
    EXPECT_EQ(table.GetOpcodeNameForLogging(clientOverlap), "[CMSG_CREATEGAMEOBJECT 0x0014 (20)]");
    EXPECT_EQ(table.GetOpcodeNameForLogging(serverOverlap), "[SMSG_GAMETIME_SET 0x0014 (20)]");

    ASSERT_NE(table[CMSG_GMTICKET_CREATE], nullptr);
    ASSERT_NE(table[CMSG_ACCEPT_LEVEL_GRANT], nullptr);
    EXPECT_NE(table[CMSG_GMTICKET_CREATE], table[CMSG_ACCEPT_LEVEL_GRANT]);
    EXPECT_STREQ(table[CMSG_GMTICKET_CREATE]->Name, "CMSG_GMTICKET_CREATE");
    EXPECT_STREQ(table[CMSG_ACCEPT_LEVEL_GRANT]->Name, "CMSG_ACCEPT_LEVEL_GRANT");

    EXPECT_EQ(table.GetOpcodeNameForLogging(MSG_MINIMAP_PING_SERVER), "[MSG_MINIMAP_PING 0x6635 (26165)]");

    uint16 serverOnly = uint16(SMSG_AUTH_RESPONSE);
    EXPECT_NE(table.GetIncomingOpcode(serverOnly), nullptr);
    EXPECT_EQ(table[static_cast<OpcodeClient>(serverOnly)], nullptr);

    EXPECT_EQ(table.GetOpcodeNameForLogging(static_cast<OpcodeClient>(NUM_OPCODE_HANDLERS)),
        "[INVALID OPCODE 0xFFFF (65535)]");
}

TEST(OpcodeTableTest, AcceptsCataclysmGuildQueriesSentAfterWorldEntry)
{
    OpcodeTable table;
    table.Initialize();

    OpcodeHandler const* moneyQuery = table.GetIncomingOpcode(0x1225);
    ASSERT_NE(moneyQuery, nullptr);
    EXPECT_STREQ(moneyQuery->Name, "CMSG_GUILD_BANK_REMAINING_WITHDRAW_MONEY_QUERY");
    EXPECT_EQ(moneyQuery->Status, STATUS_LOGGEDIN);
    EXPECT_NE(table[static_cast<OpcodeClient>(0x1225)], nullptr);

    OpcodeHandler const* tracking = table.GetIncomingOpcode(0x1027);
    ASSERT_NE(tracking, nullptr);
    EXPECT_STREQ(tracking->Name, "CMSG_GUILD_SET_ACHIEVEMENT_TRACKING");
    EXPECT_EQ(tracking->Status, STATUS_UNHANDLED);

    WorldPackets::Guild::GuildBankRemainingWithdrawMoney response;
    response.RemainingWithdrawMoney = -1;
    WorldPacket const* packet = response.Write();
    EXPECT_EQ(packet->GetOpcode(), 0x5DB4);
    ASSERT_EQ(packet->size(), 8u);
    for (std::size_t index = 0; index < packet->size(); ++index)
        EXPECT_EQ(packet->contents()[index], 0xFF);
}
