/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "CreatureAI.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectDefines.h"
#include "Opcodes.h"
#include "Player.h"
#include "Vehicle.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleAttackSwingOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    recvData >> guid;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Recvd CMSG_ATTACKSWING: %s", guid.ToString().c_str());
#endif

    Unit* pEnemy = ObjectAccessor::GetUnit(*_player, guid);

    if (!pEnemy)
    {
        // stop attack state at client
        SendAttackStop(nullptr);
        return;
    }

    if (!_player->IsValidAttackTarget(pEnemy))
    {
        // stop attack state at client
        SendAttackStop(pEnemy);
        return;
    }

    //! Client explicitly checks the following before sending CMSG_ATTACKSWING packet,
    //! so we'll place the same check here. Note that it might be possible to reuse this snippet
    //! in other places as well.
    if (Vehicle* vehicle = _player->GetVehicle())
    {
        VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(_player);
        ASSERT(seat);
        if (!(seat->m_flags & VEHICLE_SEAT_FLAG_CAN_ATTACK))
        {
            SendAttackStop(pEnemy);
            return;
        }
    }

    _player->Attack(pEnemy, true);
}

void WorldSession::HandleAttackStopOpcode(WorldPacket& /*recvData*/)
{
    GetPlayer()->AttackStop();
}

void WorldSession::HandleSetSheathedOpcode(WorldPacket& recvData)
{
    uint32 sheathed;
    recvData >> sheathed;

    if (sheathed >= MAX_SHEATH_STATE)
    {
        LOG_ERROR("server", "Unknown sheath state %u ??", sheathed);
        return;
    }

    GetPlayer()->SetSheath(SheathState(sheathed));
}

void WorldSession::SendAttackStop(Unit const* enemy)
{
    WorldPacket data(SMSG_ATTACKSTOP, (8 + 8 + 4));         // we guess size
    data << GetPlayer()->GetPackGUID();
    data << (enemy ? enemy->GetPackGUID() : PackedGuid());  // must be packed guid
    data << uint32(0);                                      // unk, can be 1 also
    SendPacket(&data);
}
