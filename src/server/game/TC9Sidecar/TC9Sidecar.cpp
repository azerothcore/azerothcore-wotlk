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
#include "TC9GroupHooks.h"
#include "TC9GrpcHandler.h"
#include "Config.h"
#include "Log.h"
#include "InstanceSaveMgr.h"
#include "UpdateTime.h"
#include "World.h"

#define AVAILABLE_MAPS_ALL_MAPS ""

MonitoringDataCollectorResponse HandleMonitoringRequest();

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
        uint32 *assignedMaps;
        int assignedMapsSize = 0;

        std::string availableMaps = sConfigMgr->GetOption<std::string>("Cluster.AvailableMaps", AVAILABLE_MAPS_ALL_MAPS);
        TC9InitLib(port, realmId, availableMaps.data(), &assignedMaps, &assignedMapsSize);

        for (int i = 0; i < MAX_MAP_ID; i++)
            _assignedMapsByID[i] = false;

        for (int i = 0; i < assignedMapsSize; i++)
            _assignedMapsByID[assignedMaps[i]] = true;

        free(assignedMaps);

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
    TC9SetOnMapsReassignedHook(&ToCloud9Sidecar::OnMapsReassigned);

    TC9SetOnGuildMemberLeftHook(&ToCloud9GuildHooks::OnGuildMemberLeft);
    TC9SetOnGuildMemberAddedHook(&ToCloud9GuildHooks::OnGuildMemberAdded);
    TC9SetOnGuildMemberRemovedHook(&ToCloud9GuildHooks::OnGuildMemberRemoved);

    TC9SetOnGroupCreatedHook(&ToCloud9GroupHooks::OnGroupCreated);
    TC9SetOnGroupDisbandedHook(&ToCloud9GroupHooks::OnGroupDisbanded);
    TC9SetOnGroupMemberAddedHook(&ToCloud9GroupHooks::OnGroupMemberAdded);
    TC9SetOnGroupMemberRemovedHook(&ToCloud9GroupHooks::OnGroupMemberRemoved);
    TC9SetOnGroupLootTypeChangedHook(&ToCloud9GroupHooks::OnGroupLootTypeChanged);
    TC9SetOnGroupConvertedToRaidHook(&ToCloud9GroupHooks::OnGroupConvertedToRaid);
    TC9SetOnGroupRaidDifficultyChangedHook(&ToCloud9GroupHooks::OnGroupRaidDifficultyChanged);
    TC9SetOnGroupDungeonDifficultyChangedHook(&ToCloud9GroupHooks::OnGroupDungeonDifficultyChanged);
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

    TC9SetMonitoringDataCollectorHandler(&HandleMonitoringRequest);
}

void ToCloud9Sidecar::ProcessHooks()
{
    TC9ProcessEventsHooks();
}

void ToCloud9Sidecar::ProcessGrpcOrHttpRequests()
{
    TC9ProcessGRPCOrHTTPRequests();
}

void ToCloud9Sidecar::ProcessAsyncTasks()
{
    _asyncTasksProcessor.ProcessReadyCallbacks();
}

bool ToCloud9Sidecar::IsMapAssigned(uint32 mapId)
{
    return _assignedMapsByID[mapId];
}

uint32 ToCloud9Sidecar::GenerateCharacterGuid()
{
    return uint32(TC9GetNextAvailableCharacterGuid());
}

uint32 ToCloud9Sidecar::GenerateItemGuid()
{
    return uint32(TC9GetNextAvailableItemGuid());
}

uint32 ToCloud9Sidecar::GenerateInstanceGuid()
{
    return uint32(TC9GetNextAvailableInstanceGuid());
}

void ToCloud9Sidecar::OnMapsReassigned(uint32* addedMaps, int addedMapsSize, uint32* removedMaps, int removedMapsSize)
{
    for (int i = 0; i < addedMapsSize; i++)
        sToCloud9Sidecar->_assignedMapsByID[addedMaps[i]] = true;

    for (int i = 0; i < removedMapsSize; i++)
        sToCloud9Sidecar->_assignedMapsByID[removedMaps[i]] = false;

    if (addedMapsSize > 0)
    {
        std::vector<uint32_t> newMapIDs(addedMaps, addedMaps + addedMapsSize);

        auto instanceSaveStoragePtr = std::make_shared<InstanceSaveMgr::InstanceSaveHashMap>();
        auto playerBindStoragePtr = std::make_shared<PlayerBindStorage>();

        AsyncTask<bool> task(
           [instanceSaveStoragePtr, playerBindStoragePtr, newMapIDs]() -> bool {
               LOG_INFO("server", "Starting to load data for newly assigned maps...");

               sInstanceSaveMgr->LoadInstanceSavesAndBindsForMapIDs(newMapIDs, *instanceSaveStoragePtr, *playerBindStoragePtr);
               return true;
           },
           [instanceSaveStoragePtr, playerBindStoragePtr, newMapIDs](bool) {
               sInstanceSaveMgr->MergeWithNewInstanceSaves(*instanceSaveStoragePtr, *playerBindStoragePtr);
               TC9ReadyToAcceptPlayersFromMaps((uint32_t*)newMapIDs.data(), newMapIDs.size());

               LOG_INFO("server", "Finished loading data for newly assigned maps.");
           }
        );

        task.ExecuteAsync();
        sToCloud9Sidecar->_asyncTasksProcessor.AddCallback(std::move(task));
    }
}

MonitoringDataCollectorResponse HandleMonitoringRequest()
{
    MonitoringDataCollectorResponse res;
    res.errorCode         = MonitoringErrorCodeNoError;
    res.diffMean          = sWorldUpdateTime.GetAverageUpdateTime();
    res.diffMedian        = sWorldUpdateTime.GetPercentile(50);
    res.diff95Percentile  = sWorldUpdateTime.GetPercentile(95);
    res.diff99Percentile  = sWorldUpdateTime.GetPercentile(99);
    res.diffMaxPercentile = sWorldUpdateTime.GetPercentile(100);
    res.connectedPlayers  = sWorld->GetActiveSessionCount();
    return res;
}
