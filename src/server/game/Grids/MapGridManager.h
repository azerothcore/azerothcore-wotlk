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

#ifndef MAP_GRID_MANAGER_H
#define MAP_GRID_MANAGER_H

#include "Common.h"
#include "GridDefines.h"
#include "MapDefines.h"
#include "MapGrid.h"

#include <mutex>

class Map;

class MapGridManager
{
public:
    MapGridManager(Map* map) : _map(map), _createdGridsCount(0), _loadedGridsCount(0) { }

    void CreateGrid(uint16 const x, uint16 const y);
    bool LoadGrid(uint16 const x, uint16 const y);
    void UnloadGrid(uint16 const x, uint16 const y);
    bool IsGridCreated(uint16 const x, uint16 const y) const;
    bool IsGridLoaded(uint16 const x, uint16 const y) const;
    MapGridType* GetGrid(uint16 const x, uint16 const y);

    static bool IsValidGridCoordinates(uint16 const x, uint16 const y) { return (x < MAX_NUMBER_OF_GRIDS && y < MAX_NUMBER_OF_GRIDS); }

    uint32 GetCreatedGridsCount();
    uint32 GetLoadedGridsCount();
    uint32 GetCreatedCellsInGridCount(uint16 const x, uint16 const y);
    uint32 GetCreatedCellsInMapCount();

    bool IsGridsFullyCreated() const;
    bool IsGridsFullyLoaded() const;

private:
    Map* _map;

    uint32 _createdGridsCount;
    uint32 _loadedGridsCount;

    std::mutex _gridLock;
    std::unique_ptr<MapGridType> _mapGrid[MAX_NUMBER_OF_GRIDS][MAX_NUMBER_OF_GRIDS];
};

#endif
