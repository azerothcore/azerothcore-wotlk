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

// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include "Creature.h"
#include "Errors.h"
#include "ScriptMgr.h"
#include "ScriptObject.h"
#include "ScriptRegistry.h"
#include "Vehicle.h"

void ScriptMgr::OnInstall(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

    if (auto tempScript = ScriptRegistry<VehicleScript>::Instance()->GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
        tempScript->OnInstall(veh);
}

void ScriptMgr::OnUninstall(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

    if (auto tempScript = ScriptRegistry<VehicleScript>::Instance()->GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
        tempScript->OnUninstall(veh);
}

void ScriptMgr::OnReset(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

    if (auto tempScript = ScriptRegistry<VehicleScript>::Instance()->GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
        tempScript->OnReset(veh);
}

void ScriptMgr::OnInstallAccessory(Vehicle* veh, Creature* accessory)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(accessory);

    if (auto tempScript = ScriptRegistry<VehicleScript>::Instance()->GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
        tempScript->OnInstallAccessory(veh, accessory);
}

void ScriptMgr::OnAddPassenger(Vehicle* veh, Unit* passenger, int8 seatId)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(passenger);

    if (auto tempScript = ScriptRegistry<VehicleScript>::Instance()->GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
        tempScript->OnAddPassenger(veh, passenger, seatId);
}

void ScriptMgr::OnRemovePassenger(Vehicle* veh, Unit* passenger)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(passenger);

    if (auto tempScript = ScriptRegistry<VehicleScript>::Instance()->GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
        tempScript->OnRemovePassenger(veh, passenger);
}
