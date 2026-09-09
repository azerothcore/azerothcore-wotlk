/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * You may redistribute it and/or modify it under the terms of the GNU General Public License
 * version 2 or, at your option, any later version.
 */

#include "MovementPackets.h"
#include "Object.h"
#include "Util.h"
#include <gtest/gtest.h>
#include <span>

namespace
{
    // Synthetic fixtures from apps/cata/generate_movement_fixtures.py and its pinned reference sequences.
    std::string const Idle = "000040400000803F00000040936C400002030504030201";
    std::string const Sparse = "00004040000080BF00000040D124C01100";
    std::string const OptionalFields =
        "000070400000A03F000020C02FD8BFF84001000020050603090207000400000CC1FF00000040410000F0402A000000"
        "0000C840317151112C0000002B0000006181210000C03F000088C04D0000000000B0400000403F000000BF000080BE"
        "0000803E44332211";

    WorldPacket Heartbeat(std::string const& hex)
    {
        std::vector<uint8> bytes(hex.size() / 2);
        Acore::Impl::HexStrToByteArray(hex, bytes.data(), bytes.size());
        WorldPacket packet(MSG_MOVE_HEARTBEAT, bytes.size());
        if (!bytes.empty())
            packet.append(bytes.data(), bytes.size());
        return packet;
    }

    std::string MovementUpdate(MovementInfo const& info)
    {
        WorldPacket packet(SMSG_MOVE_UPDATE);
        WorldPackets::Movement::WriteMovementUpdate(packet, info);
        return ByteArrayToHexStr(std::span<uint8 const>(packet.contents(), packet.size()));
    }
}

TEST(MovementPacketsTest, ReadsIdleHeartbeatAndWritesMovementUpdate)
{
    WorldPacket packet = Heartbeat(Idle);
    MovementInfo info;
    WorldPackets::Movement::ReadHeartbeat(packet, info);
    EXPECT_EQ(info.guid, ObjectGuid(uint64(0x01020304)));
    EXPECT_EQ(info.flags, 0u);
    EXPECT_EQ(info.flags2, 0u);
    EXPECT_FLOAT_EQ(info.pos.GetPositionX(), 1.0f);
    EXPECT_FLOAT_EQ(info.pos.GetPositionY(), 2.0f);
    EXPECT_FLOAT_EQ(info.pos.GetPositionZ(), 3.0f);
    EXPECT_EQ(info.time, 0x01020304u);
    EXPECT_EQ(packet.rpos(), packet.size());
    EXPECT_EQ(MovementUpdate(info), "53784000000040000000803F0000404004030201030502");

    packet = Heartbeat(Sparse);
    WorldPackets::Movement::ReadHeartbeat(packet, info);
    EXPECT_EQ(info.guid, ObjectGuid(uint64(0x0010000000000001)));
    EXPECT_EQ(info.time, 0u);
    EXPECT_FLOAT_EQ(info.pos.GetOrientation(), 0.0f);
    EXPECT_EQ(MovementUpdate(info), "32684000000040000080BF11000040400000000000");
}

TEST(MovementPacketsTest, ReadsOptionalFieldsAndPreservesTheirWireLayout)
{
    WorldPacket packet = Heartbeat(OptionalFields);
    MovementInfo info;
    WorldPackets::Movement::ReadHeartbeat(packet, info);
    EXPECT_EQ(info.guid, ObjectGuid(uint64(0x0807060504030201)));
    EXPECT_EQ(info.flags, uint32(MOVEMENTFLAG_FALLING | MOVEMENTFLAG_SPLINE_ELEVATION | MOVEMENTFLAG_ONTRANSPORT));
    EXPECT_EQ(info.flags2, MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING | MOVEMENTFLAG2_INTERPOLATED_MOVEMENT);
    EXPECT_FLOAT_EQ(info.pos.GetPositionX(), 1.25f);
    EXPECT_FLOAT_EQ(info.pos.GetPositionY(), -2.5f);
    EXPECT_FLOAT_EQ(info.pos.GetPositionZ(), 3.75f);
    EXPECT_FLOAT_EQ(info.pos.GetOrientation(), 1.5f);
    EXPECT_EQ(info.time, 0x11223344u);
    EXPECT_EQ(info.transport.guid, ObjectGuid(uint64(0x1020304050607080)));
    EXPECT_FLOAT_EQ(info.transport.pos.GetPositionX(), 6.25f);
    EXPECT_FLOAT_EQ(info.transport.pos.GetPositionY(), 7.5f);
    EXPECT_FLOAT_EQ(info.transport.pos.GetPositionZ(), -8.75f);
    EXPECT_FLOAT_EQ(info.transport.pos.GetOrientation(), 2.0f);
    EXPECT_EQ(info.transport.seat, -1);
    EXPECT_EQ(info.transport.time, 42u);
    EXPECT_EQ(info.transport.time2, 43u);
    EXPECT_EQ(info.transport.vehicleId, 44u);
    EXPECT_EQ(info.fallTime, 77u);
    EXPECT_FLOAT_EQ(info.jump.zspeed, -4.25f);
    EXPECT_FLOAT_EQ(info.jump.xyspeed, 5.5f);
    EXPECT_FLOAT_EQ(info.jump.cosAngle, 0.75f);
    EXPECT_FLOAT_EQ(info.jump.sinAngle, -0.5f);
    EXPECT_FLOAT_EQ(info.pitch, -0.25f);
    EXPECT_FLOAT_EQ(info.splineElevation, 0.25f);
    EXPECT_EQ(MovementUpdate(info),
        "E301093C2000800FFC070000B040000000BF0000403F000088C04D0000000000803E09000020C0052C00000021FF31"
        "0000C8407100000040612B0000008100000CC11141510000F0402A000000040000A03F060000704044332211020000"
        "80BE000000C03F03");
}

TEST(MovementPacketsTest, RejectsTruncatedAndTrailingHeartbeatData)
{
    for (std::string const& fixture : { Idle, Sparse, OptionalFields })
    {
        for (std::size_t length = 0; length < fixture.size(); length += 2)
        {
            WorldPacket packet = Heartbeat(fixture.substr(0, length));
            MovementInfo info;
            EXPECT_THROW(WorldPackets::Movement::ReadHeartbeat(packet, info), ByteBufferException) << length;
        }
        WorldPacket packet = Heartbeat(fixture + "00");
        MovementInfo info;
        EXPECT_THROW(WorldPackets::Movement::ReadHeartbeat(packet, info), ByteBufferInvalidValueException);
    }
}

TEST(MovementPacketsTest, TranslatesInternalFlagsAtTheWireBoundary)
{
    using namespace WorldPackets::Movement;
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_WALKING), 0x100u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_DISABLE_GRAVITY), 0x200u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_ROOT), 0x400u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_FALLING), 0x800u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_SWIMMING), 0x100000u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_FLYING), 0x1000000u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_SPLINE_ELEVATION), 0x2000000u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_WATERWALKING), 0x4000000u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_FALLING_SLOW), 0x8000000u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_HOVER), 0x10000000u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_DISABLE_COLLISION), 0x20000000u);
    EXPECT_EQ(MovementFlagsToClient(MOVEMENTFLAG_ONTRANSPORT | MOVEMENTFLAG_SPLINE_ENABLED), 0u);
    EXPECT_EQ(ExtraMovementFlagsToClient(MOVEMENTFLAG2_FULL_SPEED_TURNING), 0x4u);
    EXPECT_EQ(ExtraMovementFlagsToClient(MOVEMENTFLAG2_FULL_SPEED_PITCHING), 0x8u);
    EXPECT_EQ(ExtraMovementFlagsToClient(MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING), 0x10u);
    EXPECT_EQ(ExtraMovementFlagsToClient(MOVEMENTFLAG2_INTERPOLATED_MOVEMENT), 0x2000u);
}
