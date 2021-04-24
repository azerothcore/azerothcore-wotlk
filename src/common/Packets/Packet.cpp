/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "WorldPacket.h"

WorldPackets::Packet::Packet(WorldPacket&& worldPacket) : _worldPacket(std::move(worldPacket))
{
}

WorldPackets::ServerPacket::ServerPacket(OpcodeServer opcode, size_t initialSize /*= 200*/) : Packet(WorldPacket(opcode, initialSize))
{
}

void WorldPackets::ServerPacket::Read()
{
    ASSERT(!"Read not implemented for server packets.");
}

WorldPackets::ClientPacket::ClientPacket(OpcodeClient expectedOpcode, WorldPacket&& packet) : Packet(std::move(packet))
{
    ASSERT(GetOpcode() == expectedOpcode);
}

WorldPackets::ClientPacket::ClientPacket(WorldPacket&& packet)
    : Packet(std::move(packet))
{
}

WorldPacket const* WorldPackets::ClientPacket::Write()
{
    ASSERT(!"Write not allowed for client packets.");
    // Shut up some compilers
    return nullptr;
}
