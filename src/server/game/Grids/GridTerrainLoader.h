/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ACORE_GRID_TERRAIN_LOADER_H
#define ACORE_GRID_TERRAIN_LOADER_H

#include "GridDefines.h"

class GridTerrainLoader
{
public:
    GridTerrainLoader(MapGridType& grid, Map* map)
        : _grid(grid), _map(map) { }

    void LoadTerrain();

    static bool ExistMap(uint32 mapid, int gx, int gy);
    static bool ExistVMap(uint32 mapid, int gx, int gy);

private:
    void LoadMap();
    void LoadVMap();
    void LoadMMap();

    MapGridType& _grid;
    Map* _map;
};

class GridTerrainUnloader
{
public:
    GridTerrainUnloader(MapGridType& grid, Map* map)
        : _grid(grid), _map(map) { }

    void UnloadTerrain();

private:
    MapGridType& _grid;
    Map* _map;
};

#endif
