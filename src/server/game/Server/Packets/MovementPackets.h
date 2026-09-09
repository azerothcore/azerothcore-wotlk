/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * You may redistribute it and/or modify it under the terms of the GNU General Public License
 * version 2 or, at your option, any later version.
 */

#ifndef MovementPackets_h__
#define MovementPackets_h__

#include "ObjectGuid.h"
#include "Packet.h"

struct MovementInfo;

namespace WorldPackets
{
    namespace Movement
    {
        uint32 MovementFlagsToClient(uint32 flags);
        uint16 ExtraMovementFlagsToClient(uint16 flags);
        void ReadHeartbeat(WorldPacket& packet, MovementInfo& info);
        void WriteMovementUpdate(WorldPacket& packet, MovementInfo const& info);
        void WriteRunSpeedChange(WorldPacket& packet, ObjectGuid const& guid, uint32 counter, float speed);
        void ReadRunSpeedChangeAck(WorldPacket& packet, MovementInfo& info, uint32& counter, float& speed);
        void WriteRunSpeedUpdate(WorldPacket& packet, MovementInfo const& info, float speed);

        class MoveSetActiveMover final : public ServerPacket
        {
        public:
            MoveSetActiveMover(ObjectGuid moverGuid) : ServerPacket(SMSG_MOVE_SET_ACTIVE_MOVER, 8), MoverGUID(moverGuid) { }

            WorldPacket const* Write() override;

            ObjectGuid MoverGUID;
        };
    }
}

#endif // MovementPackets_h__
