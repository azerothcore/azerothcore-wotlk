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

#ifndef _TC9_SIDECAR_H
#define _TC9_SIDECAR_H

#include "Common.h"
#include "AsyncTask.h"
#include "AsyncCallbackProcessor.h"

#define MAX_MAP_ID 800 // Probably too much, but let's lean towards caution.

class ToCloud9Sidecar
{
private:
    ToCloud9Sidecar();
    ~ToCloud9Sidecar() {};

public:
    static ToCloud9Sidecar* instance();

    void Init(uint16 port, int realmId);
    void Deinit();

    bool ClusterModeEnabled() { return _clusterModeEnabled; }

    bool IsMapAssigned(uint32 mapId);

    void SetupHooks();
    void SetupGrpcHandlers();

    void ProcessHooks();
    void ProcessGrpcOrHttpRequests();
    void ProcessAsyncTasks();

    uint32 GenerateCharacterGuid();
    uint32 GenerateItemGuid();
    uint32 GenerateInstanceGuid();

private:
    static void OnMapsReassigned(uint32* addedMaps, int addedMapsSize, uint32* removedMaps, int removedMapsSize);

    bool _clusterModeEnabled;

    bool _assignedMapsByID[MAX_MAP_ID];

    AsyncCallbackProcessor<AsyncTask<bool>> _asyncTasksProcessor;
};

#define sToCloud9Sidecar ToCloud9Sidecar::instance()

#endif // _TC9_SIDECAR_H
