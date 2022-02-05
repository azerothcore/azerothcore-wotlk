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

#ifndef _WORLDPACKET_H_
#define _WORLDPACKET_H_

#include "ByteBuffer.h"
#include "Common.h"
#include "Duration.h"
#include "Opcodes.h"

class WorldPacket : public ByteBuffer
{
public:
    // just container for later use
    WorldPacket() : ByteBuffer(0) { }

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
    uint16 m_opcode{NULL_OPCODE};
    TimePoint m_receivedTime; // only set for a specific set of opcodes, for performance reasons.
};

#endif
