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

#ifndef ACORE_GRIDDEFINES_H
#define ACORE_GRIDDEFINES_H

#include "Common.h"
#include "MapDefines.h"
#include "GridCell.h"
#include "MapGrid.h"

// Forward class definitions
class Corpse;
class Creature;
class DynamicObject;
class GameObject;
class Pet;
class Player;
class ObjectGuid;

#define CENTER_GRID_ID          (MAX_NUMBER_OF_GRIDS/2)

#define CENTER_GRID_OFFSET      (SIZE_OF_GRIDS/2)

#define MIN_GRID_DELAY          (MINUTE*IN_MILLISECONDS)
#define MIN_MAP_UPDATE_DELAY    1

#define SIZE_OF_GRID_CELL       (SIZE_OF_GRIDS/MAX_NUMBER_OF_CELLS)

#define CENTER_GRID_CELL_ID     (MAX_NUMBER_OF_CELLS*MAX_NUMBER_OF_GRIDS/2)
#define CENTER_GRID_CELL_OFFSET (SIZE_OF_GRID_CELL/2)

#define TOTAL_NUMBER_OF_CELLS_PER_MAP    (MAX_NUMBER_OF_GRIDS*MAX_NUMBER_OF_CELLS)

#define MAP_RESOLUTION 128

#define MAP_SIZE                (SIZE_OF_GRIDS*MAX_NUMBER_OF_GRIDS)
#define MAP_HALFSIZE            (MAP_SIZE/2)

// List of object types stored in a map grid
typedef TYPELIST_5(GameObject, Player, Creature, Corpse, DynamicObject) AllMapGridStoredObjectTypes;

// List of object types stored on map level
typedef TYPELIST_4(Creature, GameObject, DynamicObject, Corpse) AllMapStoredObjectTypes;

// List of object types that can have far visible range
typedef TYPELIST_2(Creature, GameObject) AllFarVisibleObjectTypes;

typedef GridRefMgr<Corpse>          CorpseMapType;
typedef GridRefMgr<Creature>        CreatureMapType;
typedef GridRefMgr<DynamicObject>   DynamicObjectMapType;
typedef GridRefMgr<GameObject>      GameObjectMapType;
typedef GridRefMgr<Player>          PlayerMapType;

enum GridMapTypeMask
{
    GRID_MAP_TYPE_MASK_CORPSE           = 0x01,
    GRID_MAP_TYPE_MASK_CREATURE         = 0x02,
    GRID_MAP_TYPE_MASK_DYNAMICOBJECT    = 0x04,
    GRID_MAP_TYPE_MASK_GAMEOBJECT       = 0x08,
    GRID_MAP_TYPE_MASK_PLAYER           = 0x10,
    GRID_MAP_TYPE_MASK_ALL              = 0x1F
};

typedef GridCell<AllMapGridStoredObjectTypes, AllFarVisibleObjectTypes> GridCellType;
typedef MapGrid<AllMapGridStoredObjectTypes, AllFarVisibleObjectTypes> MapGridType;

typedef TypeMapContainer<AllMapGridStoredObjectTypes> GridTypeMapContainer;
typedef TypeVectorContainer<AllFarVisibleObjectTypes> FarVisibleGridContainer;
typedef TypeUnorderedMapContainer<AllMapStoredObjectTypes, ObjectGuid> MapStoredObjectTypesContainer;

template<uint32 LIMIT>
struct CoordPair
{
    CoordPair(uint32 x = 0, uint32 y = 0)
        : x_coord(x)
        , y_coord(y)
    {}

    CoordPair(const CoordPair<LIMIT>& obj)
        : x_coord(obj.x_coord)
        , y_coord(obj.y_coord)
    {}

    CoordPair<LIMIT>& operator=(const CoordPair<LIMIT>& obj)
    {
        x_coord = obj.x_coord;
        y_coord = obj.y_coord;
        return *this;
    }

    void dec_x(uint32 val)
    {
        if (x_coord > val)
            x_coord -= val;
        else
            x_coord = 0;
    }

    void inc_x(uint32 val)
    {
        if (x_coord + val < LIMIT)
            x_coord += val;
        else
            x_coord = LIMIT - 1;
    }

    void dec_y(uint32 val)
    {
        if (y_coord > val)
            y_coord -= val;
        else
            y_coord = 0;
    }

    void inc_y(uint32 val)
    {
        if (y_coord + val < LIMIT)
            y_coord += val;
        else
            y_coord = LIMIT - 1;
    }

    [[nodiscard]] bool IsCoordValid() const
    {
        return x_coord < LIMIT && y_coord < LIMIT;
    }

    CoordPair& normalize()
    {
        x_coord = std::min(x_coord, LIMIT - 1);
        y_coord = std::min(y_coord, LIMIT - 1);
        return *this;
    }

    [[nodiscard]] uint32 GetId() const
    {
        return y_coord * LIMIT + x_coord;
    }

    uint32 x_coord;
    uint32 y_coord;
};

template<uint32 LIMIT>
bool operator==(const CoordPair<LIMIT>& p1, const CoordPair<LIMIT>& p2)
{
    return (p1.x_coord == p2.x_coord && p1.y_coord == p2.y_coord);
}

template<uint32 LIMIT>
bool operator!=(const CoordPair<LIMIT>& p1, const CoordPair<LIMIT>& p2)
{
    return !(p1 == p2);
}

typedef CoordPair<MAX_NUMBER_OF_GRIDS> GridCoord;
typedef CoordPair<TOTAL_NUMBER_OF_CELLS_PER_MAP> CellCoord;

namespace Acore
{
    template<class RET_TYPE, int CENTER_VAL>
    inline RET_TYPE Compute(float x, float y, float size)
    {
        int gx = std::max<int>(0, (CENTER_VAL - x / size));
        int gy = std::max<int>(0, (CENTER_VAL - y / size));

        return RET_TYPE(gx, gy);
    }

    inline GridCoord ComputeGridCoord(float x, float y)
    {
        return Compute<GridCoord, CENTER_GRID_ID>(x, y, SIZE_OF_GRIDS);
    }

    inline GridCoord ComputeGridCoordSimple(float x, float y)
    {
        int gx = (int)(CENTER_GRID_ID - x / SIZE_OF_GRIDS);
        int gy = (int)(CENTER_GRID_ID - y / SIZE_OF_GRIDS);
        return GridCoord((MAX_NUMBER_OF_GRIDS - 1) - gx, (MAX_NUMBER_OF_GRIDS - 1) - gy);
    }

    inline CellCoord ComputeCellCoord(float x, float y)
    {
        return Compute<CellCoord, CENTER_GRID_CELL_ID>(x, y, SIZE_OF_GRID_CELL);
    }

    inline void NormalizeMapCoord(float& c)
    {
        if (c > MAP_HALFSIZE - 0.5f)
            c = MAP_HALFSIZE - 0.5f;
        else if (c < -(MAP_HALFSIZE - 0.5f))
            c = -(MAP_HALFSIZE - 0.5f);
    }

    inline bool IsValidMapCoord(float c)
    {
        return std::isfinite(c) && (std::fabs(c) <= MAP_HALFSIZE - 0.5f);
    }

    inline bool IsValidMapCoord(float x, float y)
    {
        return IsValidMapCoord(x) && IsValidMapCoord(y);
    }

    inline bool IsValidMapCoord(float x, float y, float z)
    {
        return IsValidMapCoord(x, y) && IsValidMapCoord(z);
    }

    inline bool IsValidMapCoord(float x, float y, float z, float o)
    {
        return IsValidMapCoord(x, y, z) && std::isfinite(o);
    }
}
#endif
