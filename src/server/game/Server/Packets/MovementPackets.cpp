/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * You may redistribute it and/or modify it under the terms of the GNU General Public License
 * version 2 or, at your option, any later version.
 */

#include "MovementPackets.h"
#include "Object.h"
#include <G3D/Vector3.h>

uint32 WorldPackets::Movement::MovementFlagsToClient(uint32 flags)
{
    // AC keeps its internal flag positions. Cata moved transport and spline presence out of this field.
    return (flags & 0x000001FF) | ((flags & 0x07FFFC00) >> 1) | ((flags & 0xF0000000) >> 2);
}

uint16 WorldPackets::Movement::ExtraMovementFlagsToClient(uint16 flags)
{
    return (flags & 0x03C3) | ((flags & 0x0038) >> 1) | ((flags & 0x0004) << 3) |
        ((flags & 0x1C00) << 3) | ((flags & 0xE000) >> 3);
}

void WorldPackets::Movement::ReadHeartbeat(WorldPacket& packet, MovementInfo& info)
{
    info = MovementInfo();
    packet >> info.pos.m_positionZ >> info.pos.m_positionX >> info.pos.m_positionY;
    bool hasPitch = !packet.ReadBit();
    bool hasTimestamp = !packet.ReadBit();
    bool hasFallData = packet.ReadBit();
    bool hasFlags2 = !packet.ReadBit();
    bool hasTransport = packet.ReadBit();
    for (uint8 index : { 7, 1, 0, 4, 2 })
        info.guid[index] = packet.ReadBit();
    bool hasOrientation = !packet.ReadBit();
    info.guid[5] = packet.ReadBit();
    info.guid[3] = packet.ReadBit();
    bool hasSplineElevation = !packet.ReadBit();
    bool hasSpline = packet.ReadBit();
    packet.ReadBit();
    info.guid[6] = packet.ReadBit();
    bool hasFlags = !packet.ReadBit();
    bool hasVehicleId = false;
    bool hasTransportTime2 = false;
    if (hasTransport)
    {
        hasVehicleId = packet.ReadBit();
        info.transport.guid[4] = packet.ReadBit();
        info.transport.guid[2] = packet.ReadBit();
        hasTransportTime2 = packet.ReadBit();
        for (uint8 index : { 5, 7, 6, 0, 3, 1 })
            info.transport.guid[index] = packet.ReadBit();
    }
    bool hasFallDirection = hasFallData && packet.ReadBit();
    if (hasFlags)
    {
        uint32 flags = packet.ReadBits(30);
        info.flags = (flags & 0x000001FF) | ((flags & 0x03FFFE00) << 1) | ((flags & 0x3C000000) << 2);
    }
    if (hasFlags2)
    {
        uint16 flags = packet.ReadBits(12);
        info.flags2 = (flags & 0x03C3) | ((flags & 0x001C) << 1) | ((flags & 0x0020) >> 3) |
            ((flags & 0xE000) >> 3) | ((flags & 0x1C00) << 3);
    }
    if (hasTransport)
        info.AddMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    if (hasSpline)
        info.AddMovementFlag(MOVEMENTFLAG_SPLINE_ENABLED);
    if (hasTransportTime2)
        info.AddExtraMovementFlag(MOVEMENTFLAG2_INTERPOLATED_MOVEMENT);
    for (uint8 index : { 3, 6, 1, 7, 2, 5, 0, 4 })
        packet.ReadByteSeq(info.guid[index]);
    if (hasTransport)
    {
        packet >> info.transport.pos.m_positionZ >> info.transport.seat;
        info.transport.pos.SetOrientation(packet.read<float>());
        packet.ReadByteSeq(info.transport.guid[4]);
        packet >> info.transport.pos.m_positionY >> info.transport.time >> info.transport.pos.m_positionX;
        for (uint8 index : { 5, 1, 3, 7 })
            packet.ReadByteSeq(info.transport.guid[index]);
        if (hasVehicleId)
            packet >> info.transport.vehicleId;
        if (hasTransportTime2)
            packet >> info.transport.time2;
        for (uint8 index : { 2, 0, 6 })
            packet.ReadByteSeq(info.transport.guid[index]);
    }
    if (hasOrientation)
        info.pos.SetOrientation(packet.read<float>());
    if (hasFallData)
    {
        packet >> info.jump.zspeed >> info.fallTime;
        if (hasFallDirection)
            packet >> info.jump.xyspeed >> info.jump.cosAngle >> info.jump.sinAngle;
    }
    if (hasPitch)
        info.pitch = G3D::wrap(packet.read<float>(), float(-M_PI), float(M_PI));
    if (hasSplineElevation)
        packet >> info.splineElevation;
    if (hasTimestamp)
        packet >> info.time;
    if (packet.rpos() != packet.size())
        throw ByteBufferInvalidValueException("heartbeat payload", "trailing bytes");
}

void WorldPackets::Movement::WriteMovementUpdate(WorldPacket& packet, MovementInfo const& info)
{
    uint32 flags = MovementFlagsToClient(info.flags);
    uint16 flags2 = ExtraMovementFlagsToClient(info.flags2) & 0x0FFF;
    bool hasFallDirection = info.HasMovementFlag(MOVEMENTFLAG_FALLING);
    bool hasFallData = hasFallDirection || info.fallTime != 0;
    bool hasOrientation = !G3D::fuzzyEq(info.pos.GetOrientation(), 0.0f);
    bool hasTransport = !info.transport.guid.IsEmpty();
    bool hasVehicleId = hasTransport && info.transport.vehicleId != 0;
    bool hasTransportTime2 = hasTransport && info.transport.time2 != 0;
    bool hasPitch = info.HasMovementFlag(MOVEMENTFLAG_SWIMMING | MOVEMENTFLAG_FLYING) ||
        info.HasExtraMovementFlag(MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING);
    bool hasSplineElevation = info.HasMovementFlag(MOVEMENTFLAG_SPLINE_ELEVATION);
    ObjectGuid const& guid = info.guid;
    ObjectGuid const& transport = info.transport.guid;

    packet.WriteBit(hasFallData);
    packet.WriteBit(guid[3]);
    packet.WriteBit(guid[6]);
    packet.WriteBit(!flags2);
    packet.WriteBit(info.HasMovementFlag(MOVEMENTFLAG_SPLINE_ENABLED));
    packet.WriteBit(false); // Timestamp is always present in server movement updates.
    packet.WriteBit(guid[0]);
    packet.WriteBit(guid[1]);
    if (flags2)
        packet.WriteBits(flags2, 12);
    packet.WriteBit(guid[7]);
    packet.WriteBit(!flags);
    packet.WriteBit(!hasOrientation);
    packet.WriteBit(guid[2]);
    packet.WriteBit(!hasSplineElevation);
    packet.WriteBit(false); // Height change failed.
    packet.WriteBit(guid[4]);
    if (hasFallData)
        packet.WriteBit(hasFallDirection);
    packet.WriteBit(guid[5]);
    packet.WriteBit(hasTransport);
    if (flags)
        packet.WriteBits(flags, 30);
    if (hasTransport)
    {
        packet.WriteBit(transport[3]);
        packet.WriteBit(hasVehicleId);
        for (uint8 index : { 6, 1, 7, 0, 4 })
            packet.WriteBit(transport[index]);
        packet.WriteBit(hasTransportTime2);
        packet.WriteBit(transport[5]);
        packet.WriteBit(transport[2]);
    }
    packet.WriteBit(!hasPitch);
    packet.FlushBits();
    packet.WriteByteSeq(guid[5]);
    if (hasFallData)
    {
        if (hasFallDirection)
            packet << info.jump.xyspeed << info.jump.sinAngle << info.jump.cosAngle;
        packet << info.jump.zspeed << info.fallTime;
    }
    if (hasSplineElevation)
        packet << info.splineElevation;
    packet.WriteByteSeq(guid[7]);
    packet << info.pos.GetPositionY();
    packet.WriteByteSeq(guid[3]);
    if (hasTransport)
    {
        if (hasVehicleId)
            packet << info.transport.vehicleId;
        packet.WriteByteSeq(transport[6]);
        packet << info.transport.seat;
        packet.WriteByteSeq(transport[5]);
        packet << info.transport.pos.GetPositionX();
        packet.WriteByteSeq(transport[1]);
        packet << info.transport.pos.GetOrientation();
        packet.WriteByteSeq(transport[2]);
        if (hasTransportTime2)
            packet << info.transport.time2;
        packet.WriteByteSeq(transport[0]);
        packet << info.transport.pos.GetPositionZ();
        for (uint8 index : { 7, 4, 3 })
            packet.WriteByteSeq(transport[index]);
        packet << info.transport.pos.GetPositionY() << info.transport.time;
    }
    packet.WriteByteSeq(guid[4]);
    packet << info.pos.GetPositionX();
    packet.WriteByteSeq(guid[6]);
    packet << info.pos.GetPositionZ() << info.time;
    packet.WriteByteSeq(guid[2]);
    if (hasPitch)
        packet << info.pitch;
    packet.WriteByteSeq(guid[0]);
    if (hasOrientation)
        packet << info.pos.GetOrientation();
    packet.WriteByteSeq(guid[1]);
}

WorldPacket const* WorldPackets::Movement::MoveSetActiveMover::Write()
{
    _worldPacket.WriteBit(MoverGUID[5]);
    _worldPacket.WriteBit(MoverGUID[7]);
    _worldPacket.WriteBit(MoverGUID[3]);
    _worldPacket.WriteBit(MoverGUID[6]);
    _worldPacket.WriteBit(MoverGUID[0]);
    _worldPacket.WriteBit(MoverGUID[4]);
    _worldPacket.WriteBit(MoverGUID[1]);
    _worldPacket.WriteBit(MoverGUID[2]);

    _worldPacket.WriteByteSeq(MoverGUID[6]);
    _worldPacket.WriteByteSeq(MoverGUID[2]);
    _worldPacket.WriteByteSeq(MoverGUID[3]);
    _worldPacket.WriteByteSeq(MoverGUID[0]);
    _worldPacket.WriteByteSeq(MoverGUID[5]);
    _worldPacket.WriteByteSeq(MoverGUID[7]);
    _worldPacket.WriteByteSeq(MoverGUID[1]);
    _worldPacket.WriteByteSeq(MoverGUID[4]);

    return &_worldPacket;
}
