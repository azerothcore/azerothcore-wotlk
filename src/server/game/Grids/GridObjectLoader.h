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

#ifndef ACORE_GRID_OBJECT_LOADER_H
#define ACORE_GRID_OBJECT_LOADER_H

#include "Cell.h"
#include "Define.h"
#include "GridDefines.h"
#include "ObjectMgr.h"

class GridObjectLoader
{
public:
    GridObjectLoader(MapGridType& grid, Map* map)
        : _grid(grid), _map(map) { }

    void LoadAllCellsInGrid();

private:
    template<class T>
    void AddObjectHelper(Map* map, T* obj);

    void LoadCreatures(CellGuidSet const& guid_set, Map* map);
    void LoadGameObjects(CellGuidSet const& guid_set, Map* map);

    MapGridType& _grid;
    Map* _map;
};

// Clean up and remove from world
class GridObjectCleaner
{
public:
    template<class T> void Visit(GridRefMgr<T>&);
};

// Delete objects before deleting NGrid
class GridObjectUnloader
{
public:
    void Visit(CorpseMapType&) { }    // corpses are deleted with Map
    template<class T> void Visit(GridRefMgr<T>& m);
};
#endif
