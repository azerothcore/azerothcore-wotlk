/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __ACORE_VEHICLE_H
#define __ACORE_VEHICLE_H

#include "ObjectDefines.h"
#include "VehicleDefines.h"
#include "EventProcessor.h"
#include "Unit.h"

struct VehicleEntry;
class Unit;

class Vehicle : public TransportBase
{
    public:
        void Install();
        void Uninstall();
        void Reset(bool evading = false);
        void InstallAllAccessories(bool evading);
        void ApplyAllImmunities();
        void InstallAccessory(uint32 entry, int8 seatId, bool minion, uint8 type, uint32 summonTime);   //! May be called from scripts

        Unit* GetBase() const { return _me; }
        VehicleEntry const* GetVehicleInfo() const { return _vehicleInfo; }
        uint32 GetCreatureEntry() const { return _creatureEntry; }

        bool HasEmptySeat(int8 seatId) const;
        Unit* GetPassenger(int8 seatId) const;
        int8 GetNextEmptySeat(int8 seatId, bool next) const;
        uint8 GetAvailableSeatCount() const;

        bool AddPassenger(Unit* passenger, int8 seatId = -1);
        void EjectPassenger(Unit* passenger, Unit* controller);
        void RemovePassenger(Unit* passenger);
        void RelocatePassengers();
        void RemoveAllPassengers();
        void Dismiss();
        bool IsVehicleInUse();
        void TeleportVehicle(float x, float y, float z, float ang);

        SeatMap Seats;

        VehicleSeatEntry const* GetSeatForPassenger(Unit const* passenger);
        SeatMap::iterator GetSeatIteratorForPassenger(Unit* passenger);

    protected:
        friend bool Unit::CreateVehicleKit(uint32 id, uint32 creatureEntry);
        Vehicle(Unit* unit, VehicleEntry const* vehInfo, uint32 creatureEntry);
        friend void Unit::RemoveVehicleKit();
        ~Vehicle();

    private:
        enum Status
        {
            STATUS_NONE,
            STATUS_INSTALLED,
            STATUS_UNINSTALLING,
        };

        void InitMovementInfoForBase();

        /// This method transforms supplied transport offsets into global coordinates
        void CalculatePassengerPosition(float& x, float& y, float& z, float* o /*= NULL*/) const
        {
            TransportBase::CalculatePassengerPosition(x, y, z, o,
                GetBase()->GetPositionX(), GetBase()->GetPositionY(),
                GetBase()->GetPositionZ(), GetBase()->GetOrientation());
        }

        /// This method transforms supplied global coordinates into local offsets
        void CalculatePassengerOffset(float& x, float& y, float& z, float* o /*= NULL*/) const
        {
            TransportBase::CalculatePassengerOffset(x, y, z, o,
                GetBase()->GetPositionX(), GetBase()->GetPositionY(),
                GetBase()->GetPositionZ(), GetBase()->GetOrientation());
        }

        Unit* _me;
        VehicleEntry const* _vehicleInfo;
        uint32 _usableSeatNum;         // Number of seats that match VehicleSeatEntry::UsableByPlayer, used for proper display flags
        uint32 _creatureEntry;         // Can be different than me->GetBase()->GetEntry() in case of players
        Status _status;
};

#endif
