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

#ifndef SCRIPT_OBJECT_VEHICLE_SCRIPT_H_
#define SCRIPT_OBJECT_VEHICLE_SCRIPT_H_

#include "ScriptObject.h"

class VehicleScript : public ScriptObject
{
protected:
    VehicleScript(const char* name);

public:
    // Called after a vehicle is installed.
    virtual void OnInstall(Vehicle* /*veh*/) { }

    // Called after a vehicle is uninstalled.
    virtual void OnUninstall(Vehicle* /*veh*/) { }

    // Called when a vehicle resets.
    virtual void OnReset(Vehicle* /*veh*/) { }

    // Called after an accessory is installed in a vehicle.
    virtual void OnInstallAccessory(Vehicle* /*veh*/, Creature* /*accessory*/) { }

    // Called after a passenger is added to a vehicle.
    virtual void OnAddPassenger(Vehicle* /*veh*/, Unit* /*passenger*/, int8 /*seatId*/) { }

    // Called after a passenger is removed from a vehicle.
    virtual void OnRemovePassenger(Vehicle* /*veh*/, Unit* /*passenger*/) { }
};

#endif
