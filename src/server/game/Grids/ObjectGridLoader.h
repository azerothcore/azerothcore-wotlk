/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_OBJECTGRIDLOADER_H
#define ACORE_OBJECTGRIDLOADER_H

#include "Cell.h"
#include "Define.h"
#include "GridDefines.h"
#include "GridLoader.h"
#include "TypeList.h"

class ObjectWorldLoader;

class ObjectGridLoader
{
    friend class ObjectWorldLoader;

public:
    ObjectGridLoader(NGridType& grid, Map* map, const Cell& cell)
        : i_cell(cell), i_grid(grid), i_map(map), i_gameObjects(0), i_creatures(0), i_corpses (0)
    {}

    void Visit(GameObjectMapType& m);
    void Visit(CreatureMapType& m);
    void Visit(CorpseMapType&) const {}
    void Visit(DynamicObjectMapType&) const {}

    void LoadN(void);

    template<class T> static void SetObjectCell(T* obj, CellCoord const& cellCoord);

private:
    Cell i_cell;
    NGridType& i_grid;
    Map* i_map;
    uint32 i_gameObjects;
    uint32 i_creatures;
    uint32 i_corpses;
};

//Clean up and remove from world
class ObjectGridCleaner
{
public:
    template<class T> void Visit(GridRefManager<T>&);
};

//Delete objects before deleting NGrid
class ObjectGridUnloader
{
public:
    void Visit(CorpseMapType&) { }    // corpses are deleted with Map
    template<class T> void Visit(GridRefManager<T>& m);
};
#endif
