/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "Vehicle.h"
#include "Player.h"
#include "Log.h"
#include "ObjectAccessor.h"

void WorldSession::HandleDismissControlledVehicle(WorldPacket &recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_DISMISS_CONTROLLED_VEHICLE");
#endif

    uint64 vehicleGUID = _player->GetCharmGUID();

    if (!vehicleGUID)                                       // something wrong here...
    {
        recvData.rfinish();                                // prevent warnings spam
        return;
    }

    uint64 guid;

    recvData.readPackGUID(guid);

    // pussywizard: typical check for incomming movement packets
    if (!_player->m_mover || !_player->m_mover->IsInWorld() || _player->m_mover->IsDuringRemoveFromWorld() || guid != _player->m_mover->GetGUID())
    {
        recvData.rfinish(); // prevent warnings spam
        _player->ExitVehicle();
        return;
    }

    MovementInfo mi;
    mi.guid = guid;
    ReadMovementInfo(recvData, &mi);

    _player->m_mover->m_movementInfo = mi;

    _player->ExitVehicle();
}

void WorldSession::HandleChangeSeatsOnControlledVehicle(WorldPacket &recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_CHANGE_SEATS_ON_CONTROLLED_VEHICLE");
#endif

    Unit* vehicle_base = GetPlayer()->GetVehicleBase();
    if (!vehicle_base)
    {
        recvData.rfinish();                                // prevent warnings spam
        return;
    }

    VehicleSeatEntry const* seat = GetPlayer()->GetVehicle()->GetSeatForPassenger(GetPlayer());
    if (!seat->CanSwitchFromSeat())
    {
        recvData.rfinish();                                // prevent warnings spam
        sLog->outError("HandleChangeSeatsOnControlledVehicle, Opcode: %u, Player %u tried to switch seats but current seatflags %u don't permit that.",
            recvData.GetOpcode(), GetPlayer()->GetGUIDLow(), seat->m_flags);
        return;
    }

    switch (recvData.GetOpcode())
    {
        case CMSG_REQUEST_VEHICLE_PREV_SEAT:
            GetPlayer()->ChangeSeat(-1, false);
            break;
        case CMSG_REQUEST_VEHICLE_NEXT_SEAT:
            GetPlayer()->ChangeSeat(-1, true);
            break;
        case CMSG_CHANGE_SEATS_ON_CONTROLLED_VEHICLE:
        {
            uint64 guid;        // current vehicle guid
            recvData.readPackGUID(guid);

            // pussywizard:
            if (vehicle_base->GetGUID() != guid)
            {
                recvData.rfinish(); // prevent warnings spam
                return;
            }

            MovementInfo movementInfo;
            movementInfo.guid = guid;
            ReadMovementInfo(recvData, &movementInfo);
            vehicle_base->m_movementInfo = movementInfo;

            uint64 accessory;        //  accessory guid
            recvData.readPackGUID(accessory);

            int8 seatId;
            recvData >> seatId;

            if (!accessory)
                GetPlayer()->ChangeSeat(-1, seatId > 0); // prev/next
            else if (Unit* vehUnit = ObjectAccessor::GetUnit(*GetPlayer(), accessory))
            {
                if (Vehicle* vehicle = vehUnit->GetVehicleKit())
                    if (vehicle->HasEmptySeat(seatId))
                        vehUnit->HandleSpellClick(GetPlayer(), seatId);
            }
            break;
        }
        case CMSG_REQUEST_VEHICLE_SWITCH_SEAT:
        {
            uint64 guid;        // current vehicle guid
            recvData.readPackGUID(guid);

            int8 seatId;
            recvData >> seatId;

            if (vehicle_base->GetGUID() == guid)
                GetPlayer()->ChangeSeat(seatId);
            else if (Unit* vehUnit = ObjectAccessor::GetUnit(*GetPlayer(), guid))
                if (Vehicle* vehicle = vehUnit->GetVehicleKit())
                    if (vehicle->HasEmptySeat(seatId))
                        vehUnit->HandleSpellClick(GetPlayer(), seatId);
            break;
        }
        default:
            break;
    }
}

void WorldSession::HandleEnterPlayerVehicle(WorldPacket &data)
{
    // Read guid
    uint64 guid;
    data >> guid;

    if (Player* player = ObjectAccessor::GetPlayer(*_player, guid))
    {
        if (!player->GetVehicleKit())
            return;
        if (!player->IsInRaidWith(_player))
            return;
        if (!player->IsWithinDistInMap(_player, INTERACTION_DISTANCE))
            return;
        // Xinef:
        if (!_player->FindMap() || _player->FindMap()->IsBattleArena())
            return;

        _player->EnterVehicle(player);
    }
}

void WorldSession::HandleEjectPassenger(WorldPacket &data)
{
    Vehicle* vehicle = _player->GetVehicleKit();
    if (!vehicle)
    {
        data.rfinish();                                     // prevent warnings spam
        sLog->outError("HandleEjectPassenger: Player %u is not in a vehicle!", GetPlayer()->GetGUIDLow());
        return;
    }

    uint64 guid;
    data >> guid;

    if (IS_PLAYER_GUID(guid))
    {
        Player* player = ObjectAccessor::GetPlayer(*_player, guid);
        if (!player)
        {
            sLog->outError("Player %u tried to eject player %u from vehicle, but the latter was not found in world!", GetPlayer()->GetGUIDLow(), GUID_LOPART(guid));
            return;
        }

        if (!player->IsOnVehicle(vehicle->GetBase()))
        {
            sLog->outError("Player %u tried to eject player %u, but they are not in the same vehicle", GetPlayer()->GetGUIDLow(), GUID_LOPART(guid));
            return;
        }

        VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(player);
        ASSERT(seat);
        if (seat->IsEjectable())
            player->ExitVehicle();
        else
            sLog->outError("Player %u attempted to eject player %u from non-ejectable seat.", GetPlayer()->GetGUIDLow(), GUID_LOPART(guid));
    }

    else if (IS_CREATURE_GUID(guid))
    {
        Unit* unit = ObjectAccessor::GetUnit(*_player, guid);
        if (!unit) // creatures can be ejected too from player mounts
        {
            sLog->outError("Player %u tried to eject creature guid %u from vehicle, but the latter was not found in world!", GetPlayer()->GetGUIDLow(), GUID_LOPART(guid));
            return;
        }

        if (!unit->IsOnVehicle(vehicle->GetBase()))
        {
            sLog->outError("Player %u tried to eject unit %u, but they are not in the same vehicle", GetPlayer()->GetGUIDLow(), GUID_LOPART(guid));
            return;
        }

        VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(unit);
        ASSERT(seat);
        if (seat->IsEjectable())
        {
            ASSERT(GetPlayer() == vehicle->GetBase());
            unit->ExitVehicle();
        }
        else
            sLog->outError("Player %u attempted to eject creature GUID %u from non-ejectable seat.", GetPlayer()->GetGUIDLow(), GUID_LOPART(guid));
    }
    else
        sLog->outError("HandleEjectPassenger: Player %u tried to eject invalid GUID " UI64FMTD , GetPlayer()->GetGUIDLow(), guid);
}

void WorldSession::HandleRequestVehicleExit(WorldPacket& /*recvData*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_REQUEST_VEHICLE_EXIT");
#endif

    if (Vehicle* vehicle = GetPlayer()->GetVehicle())
    {
        if (VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(GetPlayer()))
        {
            if (seat->CanEnterOrExit())
                GetPlayer()->ExitVehicle();
            else
                sLog->outError("Player %u tried to exit vehicle, but seatflags %u (ID: %u) don't permit that.",
                GetPlayer()->GetGUIDLow(), seat->m_ID, seat->m_flags);
        }
    }
}
