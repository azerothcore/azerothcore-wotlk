/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __ACORE_VEHICLEDEFINES_H
#define __ACORE_VEHICLEDEFINES_H

#include "Define.h"
#include "Map.h"
#include "Object.h"
#include <vector>
#include <map>

struct VehicleSeatEntry;

enum PowerType
{
    POWER_STEAM                                  = 61,
    POWER_PYRITE                                 = 41,
    POWER_HEAT                                   = 101,
    POWER_OOZE                                   = 121,
    POWER_BLOOD                                  = 141,
    POWER_WRATH                                  = 142
};

enum VehicleFlags
{
    VEHICLE_FLAG_NO_STRAFE                       = 0x00000001,           // Sets MOVEFLAG2_NO_STRAFE
    VEHICLE_FLAG_NO_JUMPING                      = 0x00000002,           // Sets MOVEFLAG2_NO_JUMPING
    VEHICLE_FLAG_FULLSPEEDTURNING                = 0x00000004,           // Sets MOVEFLAG2_FULLSPEEDTURNING
    VEHICLE_FLAG_ALLOW_PITCHING                  = 0x00000010,           // Sets MOVEFLAG2_ALLOW_PITCHING
    VEHICLE_FLAG_FULLSPEEDPITCHING               = 0x00000020,           // Sets MOVEFLAG2_FULLSPEEDPITCHING
    VEHICLE_FLAG_CUSTOM_PITCH                    = 0x00000040,           // If set use pitchMin and pitchMax from DBC, otherwise pitchMin = -pi/2, pitchMax = pi/2
    VEHICLE_FLAG_ADJUST_AIM_ANGLE                = 0x00000400,           // Lua_IsVehicleAimAngleAdjustable
    VEHICLE_FLAG_ADJUST_AIM_POWER                = 0x00000800,           // Lua_IsVehicleAimPowerAdjustable
};

enum VehicleSpells
{
    VEHICLE_SPELL_RIDE_HARDCODED                = 46598,
    VEHICLE_SPELL_PARACHUTE                     = 45472,

    VEHICLE_SPELL_GEIST_CONTROL_END             = 58119,
    VEHICLE_SPELL_SHADE_CONTROL_END             = 58664
};

enum VehicleNPCs
{
    NPC_EIDOLON_WATCHER                         = 31110,
    NPC_LITHE_STALKER                           = 30895
};

struct PassengerInfo
{
    uint64 Guid;
    bool IsUnselectable;

    void Reset()
    {
        Guid = 0;
        IsUnselectable = false;
    }
};

struct VehicleSeat
{
    explicit VehicleSeat(VehicleSeatEntry const* seatInfo) : SeatInfo(seatInfo)
    {
        Passenger.Reset();
    }

    bool IsEmpty() const { return !Passenger.Guid; }

    VehicleSeatEntry const* SeatInfo;
    PassengerInfo Passenger;
};

struct VehicleAccessory
{
    VehicleAccessory(uint32 entry, int8 seatId, bool isMinion, uint8 summonType, uint32 summonTime) :
        AccessoryEntry(entry), IsMinion(isMinion), SummonTime(summonTime), SeatId(seatId), SummonedType(summonType) {}
    uint32 AccessoryEntry;
    uint32 IsMinion;
    uint32 SummonTime;
    int8 SeatId;
    uint8 SummonedType;
};

typedef std::vector<VehicleAccessory> VehicleAccessoryList;
typedef std::map<uint32, VehicleAccessoryList> VehicleAccessoryContainer;
typedef std::map<int8, VehicleSeat> SeatMap;

class TransportBase
{
protected:
    TransportBase() { }
    virtual ~TransportBase() { }

public:
    /// This method transforms supplied transport offsets into global coordinates
    virtual void CalculatePassengerPosition(float& x, float& y, float& z, float* o = nullptr) const = 0;

    /// This method transforms supplied global coordinates into local offsets
    virtual void CalculatePassengerOffset(float& x, float& y, float& z, float* o = nullptr) const = 0;

protected:
    static void CalculatePassengerPosition(float& x, float& y, float& z, float* o, float transX, float transY, float transZ, float transO)
    {
        float inx = x, iny = y, inz = z;
        if (o)
            *o = Position::NormalizeOrientation(transO + *o);

        x = transX + inx * std::cos(transO) - iny * std::sin(transO);
        y = transY + iny * std::cos(transO) + inx * std::sin(transO);
        z = transZ + inz;
    }

    static void CalculatePassengerOffset(float& x, float& y, float& z, float* o, float transX, float transY, float transZ, float transO)
    {
        if (o)
            *o = Position::NormalizeOrientation(*o - transO);

        z -= transZ;
        y -= transY;    // y = searchedY * std::cos(o) + searchedX * std::sin(o)
        x -= transX;    // x = searchedX * std::cos(o) + searchedY * std::sin(o + pi)
        float inx = x, iny = y;
        y = (iny - inx * std::tan(transO)) / (std::cos(transO) + std::sin(transO) * std::tan(transO));
        x = (inx + iny * std::tan(transO)) / (std::cos(transO) + std::sin(transO) * std::tan(transO));
    }
};

#endif
