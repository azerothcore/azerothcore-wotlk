/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_CELL_H
#define ACORE_CELL_H

#include "TypeContainer.h"
#include "TypeContainerVisitor.h"

#include "GridDefines.h"

class Map;
class WorldObject;

struct CellArea
{
    CellArea() {}
    CellArea(CellCoord low, CellCoord high) : low_bound(low), high_bound(high) {}

    bool operator!() const { return low_bound == high_bound; }

    void ResizeBorders(CellCoord& begin_cell, CellCoord& end_cell) const
    {
        begin_cell = low_bound;
        end_cell = high_bound;
    }

    CellCoord low_bound;
    CellCoord high_bound;
};

struct Cell
{
    Cell() { data.All = 0; }
    Cell(Cell const& cell) { data.All = cell.data.All; }
    explicit Cell(CellCoord const& p);
    explicit Cell(float x, float y);

    void Compute(uint32 &x, uint32 &y) const
    {
        x = data.Part.grid_x * MAX_NUMBER_OF_CELLS + data.Part.cell_x;
        y = data.Part.grid_y * MAX_NUMBER_OF_CELLS + data.Part.cell_y;
    }

    bool DiffCell(const Cell &cell) const
    {
        return(data.Part.cell_x != cell.data.Part.cell_x ||
            data.Part.cell_y != cell.data.Part.cell_y);
    }

    bool DiffGrid(const Cell &cell) const
    {
        return(data.Part.grid_x != cell.data.Part.grid_x ||
            data.Part.grid_y != cell.data.Part.grid_y);
    }

    uint32 CellX() const { return data.Part.cell_x; }
    uint32 CellY() const { return data.Part.cell_y; }
    uint32 GridX() const { return data.Part.grid_x; }
    uint32 GridY() const { return data.Part.grid_y; }
    bool NoCreate() const { return data.Part.nocreate; }
    void SetNoCreate() { data.Part.nocreate = 1; }

    CellCoord GetCellCoord() const
    {
        return CellCoord(
            data.Part.grid_x * MAX_NUMBER_OF_CELLS+data.Part.cell_x,
            data.Part.grid_y * MAX_NUMBER_OF_CELLS+data.Part.cell_y);
    }

    Cell& operator=(Cell const& cell)
    {
        this->data.All = cell.data.All;
        return *this;
    }

    bool operator == (Cell const& cell) const { return (data.All == cell.data.All); }
    bool operator != (Cell const& cell) const { return !operator == (cell); }
    union
    {
        struct
        {
            unsigned grid_x : 6;
            unsigned grid_y : 6;
            unsigned cell_x : 6;
            unsigned cell_y : 6;
            unsigned nocreate : 1;
            unsigned reserved : 7;
        } Part;
        uint32 All;
    } data;

    template<class T, class CONTAINER> void Visit(CellCoord const&, TypeContainerVisitor<T, CONTAINER>& visitor, Map &, WorldObject const&, float) const;
    template<class T, class CONTAINER> void Visit(CellCoord const&, TypeContainerVisitor<T, CONTAINER>& visitor, Map &, float, float, float) const;

    static CellArea CalculateCellArea(float x, float y, float radius);

private:
    template<class T, class CONTAINER> void VisitCircle(TypeContainerVisitor<T, CONTAINER> &, Map &, CellCoord const&, CellCoord const&) const;
};

#endif

