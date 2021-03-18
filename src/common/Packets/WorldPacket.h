/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_WORLDPACKET_H
#define AZEROTHCORE_WORLDPACKET_H

#include "Common.h"
#include "ByteBuffer.h"

class WorldPacket : public ByteBuffer
{
public:
    // just container for later use
    WorldPacket()                                       : ByteBuffer(0)
    {
    }
    explicit WorldPacket(uint16 opcode, size_t res = 200) : ByteBuffer(res), m_opcode(opcode) { }
    // copy constructor
    WorldPacket(const WorldPacket& packet)              : ByteBuffer(packet), m_opcode(packet.m_opcode)
    {
    }
    /* requried as of C++ 11 */
#if __cplusplus >= 201103L
    WorldPacket(WorldPacket&&) = default;
    WorldPacket& operator=(const WorldPacket&) = default;
    WorldPacket& operator=(WorldPacket&&) = default;
#endif

    void Initialize(uint16 opcode, size_t newres = 200)
    {
        clear();
        _storage.reserve(newres);
        m_opcode = opcode;
    }

    [[nodiscard]] uint16 GetOpcode() const { return m_opcode; }
    void SetOpcode(uint16 opcode) { m_opcode = opcode; }

protected:
    uint16 m_opcode{0};
};
#endif
