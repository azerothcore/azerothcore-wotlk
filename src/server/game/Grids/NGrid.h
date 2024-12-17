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

#ifndef ACORE_NGRID_H
#define ACORE_NGRID_H

/** NGrid is nothing more than a wrapper of the Grid with an NxN cells
 */

#include "Grid.h"
#include "GridReference.h"
#include "Timer.h"

template
<
    uint32 N,
    class PLAYER_OBJECT,
    class WORLD_OBJECT_TYPES,
    class GRID_OBJECT_TYPES
    >
class NGrid
{
public:
    typedef Grid<PLAYER_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES> GridType;
    NGrid(uint32 id, int32 x, int32 y)
        : i_gridId(id), i_x(x), i_y(y), i_GridObjectDataLoaded(false)
    {
        i_cells.resize(N * N);
    }

    GridType* GetGridType(const uint32 x, const uint32 y)
    {
        ASSERT(x < N && y < N);
        return i_cells[x + y].get();
    }

    [[nodiscard]] GridType const* GetGridType(const uint32 x, const uint32 y) const
    {
        ASSERT(x < N && y < N);
        return i_cells[x + y].get();
    }

    [[nodiscard]] uint32 GetGridId() const { return i_gridId; }
    [[nodiscard]] int32 getX() const { return i_x; }
    [[nodiscard]] int32 getY() const { return i_y; }

    void link(GridRefMgr<NGrid<N, PLAYER_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES> >* pTo)
    {
        i_Reference.link(pTo, this);
    }
    [[nodiscard]] bool isGridObjectDataLoaded() const { return i_GridObjectDataLoaded; }
    void setGridObjectDataLoaded(bool pLoaded) { i_GridObjectDataLoaded = pLoaded; }

    template<class SPECIFIC_OBJECT> void AddWorldObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT* obj)
    {
        GetCell(x, y).AddWorldObject(obj);
    }

    template<class SPECIFIC_OBJECT> void RemoveWorldObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT* obj)
    {
        GetCell(x, y).RemoveWorldObject(obj);
    }

    template<class SPECIFIC_OBJECT> void AddGridObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT* obj)
    {
        GetCell(x, y).AddGridObject(obj);
    }

    template<class SPECIFIC_OBJECT> void RemoveGridObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT* obj)
    {
        GetCell(x, y).RemoveGridObject(obj);
    }

    // Visit all Grids (cells) in NGrid (grid)
    template<class T, class TT>
    void VisitAllGrids(TypeContainerVisitor<T, TypeMapContainer<TT> >& visitor)
    {
        for (auto& cell : i_cells)
            cell->Visit(visitor);
    }

    // Visit a single Grid (cell) in NGrid (grid)
    template<class T, class TT>
    void VisitGrid(const uint32 x, const uint32 y, TypeContainerVisitor<T, TypeMapContainer<TT> >& visitor)
    {
        GridType* gridType = GetGridType(x, y);
        if (!gridType)
            return;

        gridType->Visit(visitor);
    }

private:
    // Creates and returns the cell if not already created
    GridType& GetCell(uint32 const x, uint32 const y)
    {
        GridType* cell = GetGridType(x, y);
        if (!cell)
            i_cells[x + y] = std::make_unique<GridType>();

        return *i_cells[x + y];
    }

    uint32 i_gridId;
    GridReference<NGrid<N, PLAYER_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES> > i_Reference;
    int32 i_x;
    int32 i_y;
    bool i_GridObjectDataLoaded;
    std::vector<std::unique_ptr<GridType>> i_cells;
};
#endif
