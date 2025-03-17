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
    std::string const mapFileName = Acore::StringFormat("{}maps/{:03}{:02}{:02}.map", sWorld->GetDataPath(), _map->GetId(), _grid.GetX(), _grid.GetY());

    // loading data
    LOG_DEBUG("maps", "Loading map {}", mapFileName);
    std::unique_ptr<GridTerrainData> terrainData = std::make_unique<GridTerrainData>();
    TerrainMapDataReadResult loadResult = terrainData->Load(mapFileName);
    if (loadResult == TerrainMapDataReadResult::Success)
        _grid.SetTerrainData(std::move(terrainData));
    else
    {
        if (loadResult == TerrainMapDataReadResult::InvalidMagic)
            LOG_ERROR("maps", "Map file '{}' is from an incompatible clientversion. Please recreate using the mapextractor.", mapFileName);
        else
            LOG_DEBUG("maps", "Error (result: {}) loading map file: {}", uint32(loadResult), mapFileName);
    }

    sScriptMgr->OnLoadGridMap(_map, _grid.GetTerrainData(), _grid.GetX(), _grid.GetY());
}

void GridTerrainLoader::LoadVMap()
{
    int vmapLoadResult = VMAP::VMapFactory::createOrGetVMapMgr()->loadMap((sWorld->GetDataPath() + "vmaps").c_str(), _map->GetId(), _grid.GetX(), _grid.GetY());
    switch (vmapLoadResult)
    {
    case VMAP::VMAP_LOAD_RESULT_OK:
        LOG_DEBUG("maps", "VMAP loaded name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), _grid.GetX(), _grid.GetY(), _grid.GetX(), _grid.GetY());
        break;
    case VMAP::VMAP_LOAD_RESULT_ERROR:
        LOG_DEBUG("maps", "Could not load VMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), _grid.GetX(), _grid.GetY(), _grid.GetX(), _grid.GetY());
        break;
    case VMAP::VMAP_LOAD_RESULT_IGNORED:
        LOG_DEBUG("maps", "Ignored VMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), _grid.GetX(), _grid.GetY(), _grid.GetX(), _grid.GetY());
        break;
    }
}

void GridTerrainLoader::LoadMMap()
{
    if (!DisableMgr::IsPathfindingEnabled(_map))
        return;

    int mmapLoadResult = MMAP::MMapFactory::createOrGetMMapMgr()->loadMap(_map->GetId(), _grid.GetX(), _grid.GetY());
    switch (mmapLoadResult)
    {
    case MMAP::MMAP_LOAD_RESULT_OK:
        LOG_DEBUG("maps", "MMAP loaded name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), _grid.GetX(), _grid.GetY(), _grid.GetX(), _grid.GetY());
        break;
    case MMAP::MMAP_LOAD_RESULT_ERROR:
        LOG_DEBUG("maps", "Could not load MMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), _grid.GetX(), _grid.GetY(), _grid.GetX(), _grid.GetY());
        break;
    case MMAP::MMAP_LOAD_RESULT_IGNORED:
        LOG_DEBUG("maps", "Ignored MMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})",
            _map->GetMapName(), _map->GetId(), _grid.GetX(), _grid.GetY(), _grid.GetX(), _grid.GetY());
        break;
    }
}

bool GridTerrainLoader::ExistMap(uint32 mapid, int gx, int gy)
{
    std::string const mapFileName = Acore::StringFormat("{}maps/{:03}{:02}{:02}.map", sWorld->GetDataPath(), mapid, gx, gy);
    std::ifstream fileStream(mapFileName, std::ios::binary);
    if (fileStream.fail())
    {
        LOG_DEBUG("maps", "Map file '{}': error opening file", mapFileName);
        return false;
    }

    map_fileheader header;
    if (!fileStream.read(reinterpret_cast<char*>(&header), sizeof(header)))
    {
        LOG_DEBUG("maps", "Map file '{}': unable to read header", mapFileName);
        return false;
    }

    if (header.mapMagic != MapMagic.asUInt || header.versionMagic != MapVersionMagic)
    {
        LOG_ERROR("maps", "Map file '{}' is from an incompatible map version ({:.4u} v{}), {:.4s} v{} is expected. Please pull your source, recompile tools and recreate maps using the updated mapextractor, then replace your old map files with new files.",
            mapFileName, 4, header.mapMagic, header.versionMagic, 4, MapMagic.asChar, MapVersionMagic);
        return false;
    }

    return true;
}

bool GridTerrainLoader::ExistVMap(uint32 mapid, int gx, int gy)
{
    if (VMAP::IVMapMgr* vmgr = VMAP::VMapFactory::createOrGetVMapMgr())
    {
        if (vmgr->isMapLoadingEnabled())
        {
            VMAP::LoadResult result = vmgr->existsMap((sWorld->GetDataPath() + "vmaps").c_str(), mapid, gx, gy);
            std::string name = vmgr->getDirFileName(mapid, gx, gy);
            switch (result)
            {
            case VMAP::LoadResult::Success:
                break;
            case VMAP::LoadResult::FileNotFound:
                LOG_DEBUG("maps", "VMap file '{}' does not exist", (sWorld->GetDataPath() + "vmaps/" + name));
                LOG_DEBUG("maps", "Please place VMAP files (*.vmtree and *.vmtile) in the vmap directory ({}), or correct the DataDir setting in your worldserver.conf file.", (sWorld->GetDataPath() + "vmaps/"));
                return false;
            case VMAP::LoadResult::VersionMismatch:
                LOG_ERROR("maps", "VMap file '{}' couldn't be loaded", (sWorld->GetDataPath() + "vmaps/" + name));
                LOG_ERROR("maps", "This is because the version of the VMap file and the version of this module are different, please re-extract the maps with the tools compiled with this module.");
                return false;
            }
        }
    }

    return true;
}

void GridTerrainUnloader::UnloadTerrain()
{
    // Only parent maps manage terrain data
    if (_map->GetInstanceId() != 0)
        return;

    VMAP::VMapFactory::createOrGetVMapMgr()->unloadMap(_map->GetId(), _grid.GetX(), _grid.GetY());
    MMAP::MMapFactory::createOrGetMMapMgr()->unloadMap(_map->GetId(), _grid.GetX(), _grid.GetY());
}
