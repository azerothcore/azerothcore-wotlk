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

#ifndef PacketBaseWorld_h__
#define PacketBaseWorld_h__

#include "WDataStore.h"

namespace WorldPackets
{
    class AC_GAME_API Packet
    {
    public:
        Packet(WDataStore&& worldPacket);

        virtual ~Packet() = default;

        Packet(Packet const& right) = delete;
        Packet& operator=(Packet const& right) = delete;

        virtual WDataStore const* Write() = 0;
        virtual void Read() = 0;

        [[nodiscard]] WDataStore const* GetRawPacket() const { return &_worldPacket; }
        [[nodiscard]] std::size_t GetSize() const { return _worldPacket.size(); }

    protected:
        WDataStore _worldPacket;
    };

    class AC_GAME_API ServerPacket : public Packet
    {
    public:
        ServerPacket(OpcodeServer opcode, std::size_t initialSize = 200);

        void Read() final;

        void Clear() { _worldPacket.clear(); }
        WDataStore&& Move() { return std::move(_worldPacket); }
        void ShrinkToFit() { _worldPacket.shrink_to_fit(); }

        [[nodiscard]] OpcodeServer GetOpcode() const { return OpcodeServer(_worldPacket.GetOpcode()); }
    };

    class AC_GAME_API ClientPacket : public Packet
    {
    public:
        ClientPacket(WDataStore&& packet);
        ClientPacket(OpcodeClient expectedOpcode, WDataStore&& packet);

        WDataStore const* Write() final;

        [[nodiscard]] OpcodeClient GetOpcode() const { return OpcodeClient(_worldPacket.GetOpcode()); }
    };
}

#endif // PacketBaseWorld_h__
