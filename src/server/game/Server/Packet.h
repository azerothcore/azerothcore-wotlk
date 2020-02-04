/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v3 license
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#ifndef PacketBaseWorld_h__
#define PacketBaseWorld_h__

#include "WorldPacket.h"

namespace WorldPackets
{
    class Packet
    {
    public:
        Packet(WorldPacket&& worldPacket) : _worldPacket(std::move(worldPacket)) { }

        virtual ~Packet() = default;

        Packet(Packet const& right) = delete;
        Packet& operator=(Packet const& right) = delete;

        virtual WorldPacket const* Write() = 0;
        virtual void Read() = 0;

        WorldPacket const* GetRawPacket() const { return &_worldPacket; }
        size_t GetSize() const { return _worldPacket.size(); }

    protected:
        WorldPacket _worldPacket;
    };

    class ServerPacket : public Packet
    {
    public:
        ServerPacket(OpcodeServer opcode, size_t initialSize = 200) : Packet(WorldPacket(opcode, initialSize)) { }

        void Read() override final { ASSERT(!"Read not implemented for server packets."); }

        void Clear() { _worldPacket.clear(); }
        WorldPacket&& Move() { return std::move(_worldPacket); }

        OpcodeServer GetOpcode() const { return OpcodeServer(_worldPacket.GetOpcode()); }
    };

    class ClientPacket : public Packet
    {
    public:
        ClientPacket(WorldPacket&& packet) : Packet(std::move(packet)) { }
        ClientPacket(OpcodeClient expectedOpcode, WorldPacket&& packet) : Packet(std::move(packet)) { ASSERT(GetOpcode() == expectedOpcode); }

        WorldPacket const* Write() override final
        {
            ASSERT(!"Write not allowed for client packets.");
            // Shut up some compilers
            return nullptr;
        }

        OpcodeClient GetOpcode() const { return OpcodeClient(_worldPacket.GetOpcode()); }
    };
}

#endif
