#include "MapGridManager.h"
#include "GridObjectLoader.h"
#include "GridTerrainLoader.h"

void MapGridManager::CreateGrid(uint16 const x, uint16 const y)
{
    std::lock_guard<std::mutex> guard(_gridLock);
    if (IsGridCreated(x, y))
        return;

    std::unique_ptr<MapGridType> grid = std::make_unique<MapGridType>(x, y);
    grid->link(_map);

    GridTerrainLoader loader(*grid, _map);
    loader.LoadTerrain();

    _mapGrid[x][y] = std::move(grid);

    ++_createdGridsCount;
}

bool MapGridManager::LoadGrid(uint16 const x, uint16 const y)
{
    MapGridType* grid = GetGrid(x, y);
    if (!grid || grid->IsObjectDataLoaded())
        return false;

    // Must mark as loaded first, as GridObjectLoader spawning objects can attempt to recursively load the grid
    grid->SetObjectDataLoaded();

    GridObjectLoader loader(*grid, _map);
    loader.LoadAllCellsInGrid();

    ++_loadedGridsCount;
    return true;
}

void MapGridManager::UnloadGrid(uint16 const x, uint16 const y)
{
    MapGridType* grid = GetGrid(x, y);
    if (!grid)
        return;

    {
        GridObjectCleaner worker;
        TypeContainerVisitor<GridObjectCleaner, GridTypeMapContainer> visitor(worker);
        grid->VisitAllCells(visitor);
    }

    _map->RemoveAllObjectsInRemoveList();

    {
        GridObjectUnloader worker;
        TypeContainerVisitor<GridObjectUnloader, GridTypeMapContainer> visitor(worker);
        grid->VisitAllCells(visitor);
    }

    GridTerrainUnloader terrainUnloader(*grid, _map);
    terrainUnloader.UnloadTerrain();

    _mapGrid[x][y] = nullptr;
}

bool MapGridManager::IsGridCreated(uint16 const x, uint16 const y) const
{
    if (!MapGridManager::IsValidGridCoordinates(x, y))
        return false;

    return _mapGrid[x][y].get();
}

bool MapGridManager::IsGridLoaded(uint16 const x, uint16 const y) const
{
    if (!MapGridManager::IsValidGridCoordinates(x, y))
        return false;

    return _mapGrid[x][y].get() && _mapGrid[x][y]->IsObjectDataLoaded();
}

MapGridType* MapGridManager::GetGrid(uint16 const x, uint16 const y)
{
    if (!MapGridManager::IsValidGridCoordinates(x, y))
        return nullptr;

    return _mapGrid[x][y].get();
}

uint32 MapGridManager::GetCreatedGridsCount()
{
    return _createdGridsCount;
}

uint32 MapGridManager::GetLoadedGridsCount()
{
    return _loadedGridsCount;
}

uint32 MapGridManager::GetCreatedCellsInGridCount(uint16 const x, uint16 const y)
{
    MapGridType* grid = GetGrid(x, y);
    if (grid)
        return grid->GetCreatedCellsCount();

    return 0;
}

uint32 MapGridManager::GetCreatedCellsInMapCount()
{
    uint32 count = 0;
    for (uint32 gridX = 0; gridX < MAX_NUMBER_OF_GRIDS; ++gridX)
    {
        for (uint32 gridY = 0; gridY < MAX_NUMBER_OF_GRIDS; ++gridY)
        {
            if (MapGridType* grid = GetGrid(gridX, gridY))
                count += grid->GetCreatedCellsCount();
        }
    }
    return count;
}

bool MapGridManager::IsGridsFullyCreated() const
{
    return _createdGridsCount == (MAX_NUMBER_OF_GRIDS * MAX_NUMBER_OF_GRIDS);
}

bool MapGridManager::IsGridsFullyLoaded() const
{
    return _loadedGridsCount == (MAX_NUMBER_OF_GRIDS * MAX_NUMBER_OF_GRIDS);
}
