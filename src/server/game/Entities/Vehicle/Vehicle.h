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

#ifndef __ACORE_VEHICLE_H
#define __ACORE_VEHICLE_H

#include "Unit.h"
#include "VehicleDefines.h"

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
    VehicleSeatAddon const* GetSeatAddonForSeatOfPassenger(Unit const* passenger) const;
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

    //npcbot
    /*
    VehicleSeatEntry const* GetSeatForPassenger(Unit const* passenger);
    */
    VehicleSeatEntry const* GetSeatForPassenger(Unit const* passenger) const;
    //end npcbot

    SeatMap::iterator GetSeatIteratorForPassenger(Unit* passenger);

protected:
    friend bool Unit::CreateVehicleKit(uint32 id, uint32 creatureEntry);
    Vehicle(Unit* unit, VehicleEntry const* vehInfo, uint32 creatureEntry);
    friend void Unit::RemoveVehicleKit();
    ~Vehicle() override;

private:
    enum Status
    {
        STATUS_NONE,
        STATUS_INSTALLED,
        STATUS_UNINSTALLING,
    };

    void InitMovementInfoForBase();

    /// This method transforms supplied transport offsets into global coordinates
    void CalculatePassengerPosition(float& x, float& y, float& z, float* o /*= nullptr*/) const override
    {
        TransportBase::CalculatePassengerPosition(x, y, z, o,
                GetBase()->GetPositionX(), GetBase()->GetPositionY(),
                GetBase()->GetPositionZ(), GetBase()->GetOrientation());
    }

    /// This method transforms supplied global coordinates into local offsets
    void CalculatePassengerOffset(float& x, float& y, float& z, float* o /*= nullptr*/) const override
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

class VehicleDespawnEvent : public BasicEvent
{
public:
    VehicleDespawnEvent(Unit& self, uint32 duration) : _self(self), _duration(duration) { }
    bool Execute(uint64 e_time, uint32 p_time) override;

protected:
    Unit& _self;
    uint32 _duration;
};

#endif
