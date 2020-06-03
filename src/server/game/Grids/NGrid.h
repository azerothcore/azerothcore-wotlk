/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_NGRID_H
#define ACORE_NGRID_H

/** NGrid is nothing more than a wrapper of the Grid with an NxN cells
 */

#include "Grid.h"
#include "GridReference.h"
#include "Timer.h"
#include "Util.h"

template
<
uint32 N,
class ACTIVE_OBJECT,
class WORLD_OBJECT_TYPES,
class GRID_OBJECT_TYPES
>
class NGrid
{
    public:
        typedef Grid<ACTIVE_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES> GridType;
        NGrid(uint32 id, int32 x, int32 y)
            : i_gridId(id), i_x(x), i_y(y), i_GridObjectDataLoaded(false)
        {
        }

        GridType& GetGridType(const uint32 x, const uint32 y)
        {
            ASSERT(x < N && y < N);
            return i_cells[x][y];
        }

        GridType const& GetGridType(const uint32 x, const uint32 y) const
        {
            ASSERT(x < N && y < N);
            return i_cells[x][y];
        }

        uint32 GetGridId(void) const { return i_gridId; }
        int32 getX() const { return i_x; }
        int32 getY() const { return i_y; }

        void link(GridRefManager<NGrid<N, ACTIVE_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES> >* pTo)
        {
            i_Reference.link(pTo, this);
        }
        bool isGridObjectDataLoaded() const { return i_GridObjectDataLoaded; }
        void setGridObjectDataLoaded(bool pLoaded) { i_GridObjectDataLoaded = pLoaded; }

        /*
        template<class SPECIFIC_OBJECT> void AddWorldObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT *obj)
        {
            GetGridType(x, y).AddWorldObject(obj);
        }

        template<class SPECIFIC_OBJECT> void RemoveWorldObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT *obj)
        {
            GetGridType(x, y).RemoveWorldObject(obj);
        }

        template<class SPECIFIC_OBJECT> void AddGridObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT *obj)
        {
            GetGridType(x, y).AddGridObject(obj);
        }

        template<class SPECIFIC_OBJECT> void RemoveGridObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT *obj)
        {
            GetGridType(x, y).RemoveGridObject(obj);
        }
        */

        // Visit all Grids (cells) in NGrid (grid)
        template<class T, class TT>
        void VisitAllGrids(TypeContainerVisitor<T, TypeMapContainer<TT> > &visitor)
        {
            for (uint32 x = 0; x < N; ++x)
                for (uint32 y = 0; y < N; ++y)
                    GetGridType(x, y).Visit(visitor);
        }

        // Visit a single Grid (cell) in NGrid (grid)
        template<class T, class TT>
        void VisitGrid(const uint32 x, const uint32 y, TypeContainerVisitor<T, TypeMapContainer<TT> > &visitor)
        {
            GetGridType(x, y).Visit(visitor);
        }

    private:
        uint32 i_gridId;
        GridReference<NGrid<N, ACTIVE_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES> > i_Reference;
        int32 i_x;
        int32 i_y;
        GridType i_cells[N][N];
        bool i_GridObjectDataLoaded;
};
#endif

