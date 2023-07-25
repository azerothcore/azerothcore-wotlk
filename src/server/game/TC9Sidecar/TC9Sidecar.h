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

    void SetupHooks();
    void SetupGrpcHandlers();

    void ProcessHooks();
    void ProcessGrpcRequests();

    uint32 GenerateCharacterGuid();
    uint32 GenerateItemGuid();

private:
    bool _clusterModeEnabled;
};

#define sToCloud9Sidecar ToCloud9Sidecar::instance()

#endif // _TC9_SIDECAR_H
