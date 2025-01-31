#include "DisableMgr.h"
#include "GridTerrainLoader.h"
#include "MMapFactory.h"
#include "MMapMgr.h"
#include "ScriptMgr.h"
#include "VMapFactory.h"
#include "VMapMgr2.h"

void GridTerrainLoader::LoadTerrain()
{
    LoadMap();
    if (_map->GetInstanceId() == 0)
    {
        LoadVMap();
        LoadMMap();
    }
}

void GridTerrainLoader::LoadMap()
{
    // Instances will point to the parent maps terrain data
    if (_map->GetInstanceId() != 0)
    {
        // load grid map for base map
        Map* parentMap = const_cast<Map*>(_map->GetParent());

        // GetGridTerrainData will create the parent map grid
        _grid.SetTerrainData(parentMap->GetGridTerrainDataSharedPtr(GridCoord(_grid.GetX(), _grid.GetY())));
        return;
    }

    // map file name
    char* tmp = nullptr;
    int len = sWorld->GetDataPath().length() + strlen("maps/%03u%02u%02u.map") + 1;
    tmp = new char[len];
    snprintf(tmp, len, (char*)(sWorld->GetDataPath() + "maps/%03u%02u%02u.map").c_str(), _map->GetId(), GetX(), GetY());

    // loading data
    LOG_DEBUG("maps", "Loading map {}", tmp);
    std::unique_ptr<GridTerrainData> terrainData = std::make_unique<GridTerrainData>();
    if (!terrainData->loadData(tmp))
        LOG_ERROR("maps", "Error loading map file: \n {}\n", tmp);

    _grid.SetTerrainData(std::move(terrainData));
    delete[] tmp;

    sScriptMgr->OnLoadGridMap(_map, _grid.GetTerrainData(), GetX(), GetY());
}

void GridTerrainLoader::LoadVMap()
{
    int vmapLoadResult = VMAP::VMapFactory::createOrGetVMapMgr()->loadMap((sWorld->GetDataPath() + "vmaps").c_str(), _map->GetId(), GetX(), GetY());
    switch (vmapLoadResult)
    {
    case VMAP::VMAP_LOAD_RESULT_OK:
        LOG_DEBUG("maps", "VMAP loaded name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), GetX(), GetY(), GetX(), GetY());
        break;
    case VMAP::VMAP_LOAD_RESULT_ERROR:
        LOG_DEBUG("maps", "Could not load VMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), GetX(), GetY(), GetX(), GetY());
        break;
    case VMAP::VMAP_LOAD_RESULT_IGNORED:
        LOG_DEBUG("maps", "Ignored VMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), GetX(), GetY(), GetX(), GetY());
        break;
    }
}

void GridTerrainLoader::LoadMMap()
{
    if (!DisableMgr::IsPathfindingEnabled(_map))
        return;

    int mmapLoadResult = MMAP::MMapFactory::createOrGetMMapMgr()->loadMap(_map->GetId(), GetX(), GetY());
    switch (mmapLoadResult)
    {
    case MMAP::MMAP_LOAD_RESULT_OK:
        LOG_DEBUG("maps", "MMAP loaded name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), GetX(), GetY(), GetX(), GetY());
        break;
    case MMAP::MMAP_LOAD_RESULT_ERROR:
        LOG_DEBUG("maps", "Could not load MMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), GetX(), GetY(), GetX(), GetY());
        break;
    case MMAP::MMAP_LOAD_RESULT_IGNORED:
        LOG_DEBUG("maps", "Ignored MMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), GetX(), GetY(), GetX(), GetY());
        break;
    }
}

void GridTerrainUnloader::UnloadTerrain()
{
    // Only parent maps manage terrain data
    if (_map->GetInstanceId() != 0)
        return;

    int gx = (MAX_NUMBER_OF_GRIDS - 1) - _grid.GetX();
    int gy = (MAX_NUMBER_OF_GRIDS - 1) - _grid.GetY();

    if (GridTerrainData* terrainData = _grid.GetTerrainData())
        terrainData->unloadData();

    VMAP::VMapFactory::createOrGetVMapMgr()->unloadMap(_map->GetId(), gx, gy);
    MMAP::MMapFactory::createOrGetMMapMgr()->unloadMap(_map->GetId(), gx, gy);
}
