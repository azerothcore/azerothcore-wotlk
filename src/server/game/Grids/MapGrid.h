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

#ifndef MAP_GRID_H
#define MAP_GRID_H

#include "GridCell.h"
#include "GridReference.h"

class GridTerrainData;

template
<
    class GRID_OBJECT_TYPES,
    class FAR_VISIBLE_OBJECT_TYPES
>
class MapGrid
{
public:
    typedef GridCell<GRID_OBJECT_TYPES, FAR_VISIBLE_OBJECT_TYPES> GridCellType;

    MapGrid(uint16 const x, uint16 const y)
        : _x(x), _y(y), _objectDataLoaded(false), _terrainData(nullptr) { }

    // Unique identifier for grid
    uint32 GetId() const { return _y * MAX_NUMBER_OF_GRIDS + _x; }

    uint16 GetX() const { return _x; }
    uint16 GetY() const { return _y; }

    bool IsObjectDataLoaded() const { return _objectDataLoaded; }
    void SetObjectDataLoaded() { _objectDataLoaded = true; }

    template<class SPECIFIC_OBJECT> void AddGridObject(uint16 const x, uint16 const y, SPECIFIC_OBJECT* obj)
    {
        GetOrCreateCell(x, y).AddGridObject(obj);
    }

    template<class SPECIFIC_OBJECT> void RemoveGridObject(uint16 const x, uint16 const y, SPECIFIC_OBJECT* obj)
    {
        GetOrCreateCell(x, y).RemoveGridObject(obj);
    }

    template<class SPECIFIC_OBJECT> void AddFarVisibleObject(uint16 const x, uint16 const y, SPECIFIC_OBJECT* obj)
    {
        GetOrCreateCell(x, y).AddFarVisibleObject(obj);
    }

    template<class SPECIFIC_OBJECT> void RemoveFarVisibleObject(uint16 const x, uint16 const y, SPECIFIC_OBJECT* obj)
    {
        GetOrCreateCell(x, y).RemoveFarVisibleObject(obj);
    }

    // Visit all cells
    template<class T, class TT>
    void VisitAllCells(TypeContainerVisitor<T, TT>& visitor)
    {
        for (auto& cellX : _cells)
        {
            for (auto& cellY : cellX)
            {
                if (!cellY)
                    continue;

                cellY->Visit(visitor);
            }
        }
    }

    // Visit single cell
    template<class T, class TT>
    void VisitCell(uint16 const x, uint16 const y, TypeContainerVisitor<T, TT>& visitor)
    {
        GridCellType* gridCell = GetCell(x, y);
        if (!gridCell)
            return;

        gridCell->Visit(visitor);
    }

    void link(GridRefMgr<MapGrid<GRID_OBJECT_TYPES, FAR_VISIBLE_OBJECT_TYPES>>* pTo)
    {
        _gridReference.link(pTo, this);
    }

    GridTerrainData* GetTerrainData() const { return _terrainData.get(); }
    std::shared_ptr<GridTerrainData> GetTerrainDataSharedPtr() { return _terrainData; }
    void SetTerrainData(std::shared_ptr<GridTerrainData> terrainData) { _terrainData = terrainData; }

    uint32 GetCreatedCellsCount()
    {
        uint32 count = 0;
        for (auto& cellX : _cells)
        {
            for (auto& cellY : cellX)
            {
                if (!cellY)
                    continue;

                ++count;
            }
        }
        return count;
    }

private:
    // Creates and returns the cell if not already created
    GridCellType& GetOrCreateCell(uint16 const x, uint16 const y)
    {
        GridCellType* cell = GetCell(x, y);
        if (!cell)
            _cells[x][y] = std::make_unique<GridCellType>();

        return *_cells[x][y];
    }

    GridCellType* GetCell(uint16 const x, uint16 const y)
    {
        ASSERT(x < MAX_NUMBER_OF_CELLS && y < MAX_NUMBER_OF_CELLS);
        return _cells[x][y].get();
    }

    GridCellType const* GetCell(uint16 const x, uint16 const y) const
    {
        ASSERT(x < MAX_NUMBER_OF_CELLS && y < MAX_NUMBER_OF_CELLS);
        return _cells[x][y].get();
    }

    uint16 _x;
    uint16 _y;

    bool _objectDataLoaded;
    std::array<std::array<std::unique_ptr<GridCellType>, MAX_NUMBER_OF_CELLS>, MAX_NUMBER_OF_CELLS> _cells; // N * N array
    GridReference<MapGrid<GRID_OBJECT_TYPES, FAR_VISIBLE_OBJECT_TYPES>> _gridReference;

    // Instances will share a copy of the parent maps terrainData
    std::shared_ptr<GridTerrainData> _terrainData;
};

#endif
