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

#include "TC9Sidecar.h"
#include "libsidecar.h"
#include "TC9GuildHooks.h"
#include "TC9GrpcHandler.h"
#include "Config.h"
#include "Log.h"

#define AVAILABLE_MAPS_ALL_MAPS ""

ToCloud9Sidecar* ToCloud9Sidecar::instance()
{
    static ToCloud9Sidecar instance;
    return &instance;
}

ToCloud9Sidecar::ToCloud9Sidecar() : _clusterModeEnabled(false)
{
}

void ToCloud9Sidecar::Init(uint16 port, int realmId)
{
    _clusterModeEnabled = sConfigMgr->GetOption<bool>("Cluster.Enabled", false);

    if (_clusterModeEnabled)
    {
        std::string availableMaps = sConfigMgr->GetOption<std::string>("Cluster.AvailableMaps", AVAILABLE_MAPS_ALL_MAPS);
        TC9InitLib(port, realmId, availableMaps.data());

        SetupHooks();
        SetupGrpcHandlers();
    }
}

void ToCloud9Sidecar::Deinit()
{
    if (_clusterModeEnabled)
        TC9GracefulShutdown();
}

void ToCloud9Sidecar::SetupHooks()
{
    TC9SetOnGuildMemberAddedHook(&ToCloud9GuildHooks::OnGuildMemberAdded);
    TC9SetOnGuildMemberLeftHook(&ToCloud9GuildHooks::OnGuildMemberLeft);
    TC9SetOnGuildMemberRemovedHook(&ToCloud9GuildHooks::OnGuildMemberRemoved);
}

void ToCloud9Sidecar::SetupGrpcHandlers()
{
    TC9SetGetPlayerItemsByGuidsHandler(&ToCloud9GrpcHandler::GetPlayerItemsByGuids);
    TC9SetRemoveItemsWithGuidsFromPlayerHandler(&ToCloud9GrpcHandler::RemoveItemsWithGuidsFromPlayer);
    TC9SetAddExistingItemToPlayerHandler(&ToCloud9GrpcHandler::AddExistingItemToPlayer);

    TC9SetGetMoneyForPlayerHandler(&ToCloud9GrpcHandler::GetMoneyForPlayer);
    TC9SetModifyMoneyForPlayerHandler(&ToCloud9GrpcHandler::ModifyMoneyForPlayer);

    TC9SetCanPlayerInteractWithGOAndTypeHandler(&ToCloud9GrpcHandler::CanPlayerInteractWithGOAndType);
    TC9SetCanPlayerInteractWithNPCAndFlagsHandler(&ToCloud9GrpcHandler::CanPlayerInteractWithNPCAndFlags);
}

void ToCloud9Sidecar::ProcessHooks()
{
    TC9ProcessEventsHooks();
}

void ToCloud9Sidecar::ProcessGrpcRequests()
{
    TC9ProcessGRPCRequests();
}

uint32 ToCloud9Sidecar::GenerateCharacterGuid()
{
    return ObjectGuid::LowType(TC9GetNextAvailableCharacterGuid());
}

uint32 ToCloud9Sidecar::GenerateItemGuid()
{
    return ObjectGuid::LowType(TC9GetNextAvailableItemGuid());
}
