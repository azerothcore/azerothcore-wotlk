/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _WORLDPACKET_H_
#define _WORLDPACKET_H_

#include "Common.h"
#include "Opcodes.h"
#include "ByteBuffer.h"
#include "Duration.h"

class WorldPacket : public ByteBuffer
{
public:
    // just container for later use
    WorldPacket() : ByteBuffer(0), m_opcode(NULL_OPCODE) { }

    explicit WorldPacket(uint16 opcode, size_t res = 200) :
        ByteBuffer(res), m_opcode(opcode) { }

    WorldPacket(WorldPacket&& packet) noexcept :
        ByteBuffer(std::move(packet)), m_opcode(packet.m_opcode) { }

    WorldPacket(WorldPacket&& packet, TimePoint receivedTime) :
        ByteBuffer(std::move(packet)), m_opcode(packet.m_opcode), m_receivedTime(receivedTime) { }

    WorldPacket(WorldPacket const& right) :
        ByteBuffer(right), m_opcode(right.m_opcode) { }

    WorldPacket& operator=(WorldPacket const& right)
    {
        if (this != &right)
        {
            m_opcode = right.m_opcode;
            ByteBuffer::operator=(right);
        }

        return *this;
    }

    WorldPacket& operator=(WorldPacket&& right) noexcept
    {
        if (this != &right)
        {
            m_opcode = right.m_opcode;
            ByteBuffer::operator=(std::move(right));
        }

        return *this;
    }

    WorldPacket(uint16 opcode, MessageBuffer&& buffer) :
        ByteBuffer(std::move(buffer)), m_opcode(opcode) { }

    void Initialize(uint16 opcode, size_t newres = 200)
    {
        clear();
        _storage.reserve(newres);
        m_opcode = opcode;
    }

    [[nodiscard]] uint16 GetOpcode() const { return m_opcode; }
    void SetOpcode(uint16 opcode) { m_opcode = opcode; }

    [[nodiscard]] TimePoint GetReceivedTime() const { return m_receivedTime; }

protected:
    uint16 m_opcode;
    TimePoint m_receivedTime; // only set for a specific set of opcodes, for performance reasons.
};

#endif
