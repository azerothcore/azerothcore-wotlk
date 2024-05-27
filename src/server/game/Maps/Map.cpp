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

#include "Map.h"
#include "Battleground.h"
#include "CellImpl.h"
#include "Chat.h"
#include "DisableMgr.h"
#include "DynamicTree.h"
#include "GameTime.h"
#include "Geometry.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "InstanceScript.h"
#include "LFGMgr.h"
#include "MapInstanced.h"
#include "Metric.h"
#include "MiscPackets.h"
#include "Object.h"
#include "ObjectAccessor.h"
#include "ObjectGridLoader.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "ScriptMgr.h"
#include "Transport.h"
#include "VMapFactory.h"
#include "Vehicle.h"
#include "Weather.h"

union u_map_magic
{
    char asChar[4];
    uint32 asUInt;
};

u_map_magic MapMagic        = { {'M', 'A', 'P', 'S'} };
uint32 MapVersionMagic      = 9;
u_map_magic MapAreaMagic    = { {'A', 'R', 'E', 'A'} };
u_map_magic MapHeightMagic  = { {'M', 'H', 'G', 'T'} };
u_map_magic MapLiquidMagic  = { {'M', 'L', 'I', 'Q'} };

static uint16 const holetab_h[4] = { 0x1111, 0x2222, 0x4444, 0x8888 };
static uint16 const holetab_v[4] = { 0x000F, 0x00F0, 0x0F00, 0xF000 };

ZoneDynamicInfo::ZoneDynamicInfo() : MusicId(0), WeatherId(WEATHER_STATE_FINE),
                                     WeatherGrade(0.0f), OverrideLightId(0), LightFadeInTime(0) { }

Map::~Map()
{
    // UnloadAll must be called before deleting the map

    sScriptMgr->OnDestroyMap(this);

    while (!i_worldObjects.empty())
    {
        WorldObject* obj = *i_worldObjects.begin();
        ASSERT(obj->IsWorldObject());
        LOG_DEBUG("maps", "Map::~Map: WorldObject TypeId is not a corpse! ({})", static_cast<uint8>(obj->GetTypeId()));
        //ASSERT(obj->GetTypeId() == TYPEID_CORPSE);
        obj->RemoveFromWorld();
        obj->ResetMap();
    }

    if (!m_scriptSchedule.empty())
        sScriptMgr->DecreaseScheduledScriptCount(m_scriptSchedule.size());

    //MMAP::MMapFactory::createOrGetMMapMgr()->unloadMap(GetId());
    MMAP::MMapFactory::createOrGetMMapMgr()->unloadMapInstance(GetId(), i_InstanceId);
}

bool Map::ExistMap(uint32 mapid, int gx, int gy)
{
    int len = sWorld->GetDataPath().length() + strlen("maps/%03u%02u%02u.map") + 1;
    char* tmp = new char[len];
    snprintf(tmp, len, (char*)(sWorld->GetDataPath() + "maps/%03u%02u%02u.map").c_str(), mapid, gx, gy);

    bool ret = false;
    FILE* pf = fopen(tmp, "rb");

    if (!pf)
        LOG_ERROR("maps", "Map file '{}': does not exist!", tmp);
    else
    {
        map_fileheader header;
        if (fread(&header, sizeof(header), 1, pf) == 1)
        {
            if (header.mapMagic != MapMagic.asUInt || header.versionMagic != MapVersionMagic)
            {
                LOG_ERROR("maps", "Map file '{}' is from an incompatible map version (%.*u v{}), %.*s v{} is expected. Please pull your source, recompile tools and recreate maps using the updated mapextractor, then replace your old map files with new files.",
                    tmp, 4, header.mapMagic, header.versionMagic, 4, MapMagic.asChar, MapVersionMagic);
            }

            else
                ret = true;
        }
        fclose(pf);
    }
    delete [] tmp;
    return ret;
}

bool Map::ExistVMap(uint32 mapid, int gx, int gy)
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
                    LOG_ERROR("maps", "VMap file '{}' does not exist", (sWorld->GetDataPath() + "vmaps/" + name));
                    LOG_ERROR("maps", "Please place VMAP files (*.vmtree and *.vmtile) in the vmap directory ({}), or correct the DataDir setting in your worldserver.conf file.", (sWorld->GetDataPath() + "vmaps/"));
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

void Map::LoadMMap(int gx, int gy)
{
    if (!DisableMgr::IsPathfindingEnabled(this)) // pussywizard
        return;

    int mmapLoadResult = MMAP::MMapFactory::createOrGetMMapMgr()->loadMap(GetId(), gx, gy);
    switch (mmapLoadResult)
    {
        case MMAP::MMAP_LOAD_RESULT_OK:
            LOG_DEBUG("maps", "MMAP loaded name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})", GetMapName(), GetId(), gx, gy, gx, gy);
            break;
        case MMAP::MMAP_LOAD_RESULT_ERROR:
            LOG_DEBUG("maps", "Could not load MMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})", GetMapName(), GetId(), gx, gy, gx, gy);
            break;
        case MMAP::MMAP_LOAD_RESULT_IGNORED:
            LOG_DEBUG("maps", "Ignored MMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})", GetMapName(), GetId(), gx, gy, gx, gy);
            break;
    }
}

void Map::LoadVMap(int gx, int gy)
{
    // x and y are swapped !!
    int vmapLoadResult = VMAP::VMapFactory::createOrGetVMapMgr()->loadMap((sWorld->GetDataPath() + "vmaps").c_str(), GetId(), gx, gy);
    switch (vmapLoadResult)
    {
        case VMAP::VMAP_LOAD_RESULT_OK:
            LOG_DEBUG("maps", "VMAP loaded name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})", GetMapName(), GetId(), gx, gy, gx, gy);
            break;
        case VMAP::VMAP_LOAD_RESULT_ERROR:
            LOG_DEBUG("maps", "Could not load VMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})", GetMapName(), GetId(), gx, gy, gx, gy);
            break;
        case VMAP::VMAP_LOAD_RESULT_IGNORED:
            LOG_DEBUG("maps", "Ignored VMAP name:{}, id:{}, x:{}, y:{} (vmap rep.: x:{}, y:{})", GetMapName(), GetId(), gx, gy, gx, gy);
            break;
    }
}

void Map::LoadMap(int gx, int gy, bool reload)
{
    if (i_InstanceId != 0)
    {
        if (GridMaps[gx][gy])
            return;

        // load grid map for base map
        m_parentMap->EnsureGridCreated(GridCoord(63 - gx, 63 - gy));

        GridMaps[gx][gy] = m_parentMap->GridMaps[gx][gy];
        return;
    }

    if (GridMaps[gx][gy] && !reload)
        return;

    //map already load, delete it before reloading (Is it necessary? Do we really need the ability the reload maps during runtime?)
    if (GridMaps[gx][gy])
    {
        LOG_DEBUG("maps", "Unloading previously loaded map {} before reloading.", GetId());
        sScriptMgr->OnUnloadGridMap(this, GridMaps[gx][gy], gx, gy);

        delete (GridMaps[gx][gy]);
        GridMaps[gx][gy] = nullptr;
    }

    // map file name
    char* tmp = nullptr;
    int len = sWorld->GetDataPath().length() + strlen("maps/%03u%02u%02u.map") + 1;
    tmp = new char[len];
    snprintf(tmp, len, (char*)(sWorld->GetDataPath() + "maps/%03u%02u%02u.map").c_str(), GetId(), gx, gy);
    LOG_DEBUG("maps", "Loading map {}", tmp);
    // loading data
    GridMaps[gx][gy] = new GridMap();
    if (!GridMaps[gx][gy]->loadData(tmp))
    {
        LOG_ERROR("maps", "Error loading map file: \n {}\n", tmp);
    }
    delete [] tmp;

    sScriptMgr->OnLoadGridMap(this, GridMaps[gx][gy], gx, gy);
}

void Map::LoadMapAndVMap(int gx, int gy)
{
    LoadMap(gx, gy);
    if (i_InstanceId == 0)
    {
        LoadVMap(gx, gy);                                   // Only load the data for the base map
        LoadMMap(gx, gy);
    }
}

Map::Map(uint32 id, uint32 InstanceId, uint8 SpawnMode, Map* _parent) :
    i_mapEntry(sMapStore.LookupEntry(id)), i_spawnMode(SpawnMode), i_InstanceId(InstanceId),
    m_unloadTimer(0), m_VisibleDistance(DEFAULT_VISIBILITY_DISTANCE),
    _instanceResetPeriod(0), m_activeNonPlayersIter(m_activeNonPlayers.end()),
    _transportsUpdateIter(_transports.end()), i_scriptLock(false), _defaultLight(GetDefaultMapLight(id))
{
    m_parentMap = (_parent ? _parent : this);
    for (unsigned int idx = 0; idx < MAX_NUMBER_OF_GRIDS; ++idx)
    {
        for (unsigned int j = 0; j < MAX_NUMBER_OF_GRIDS; ++j)
        {
            //z code
            GridMaps[idx][j] = nullptr;
            setNGrid(nullptr, idx, j);
        }
    }

    //lets initialize visibility distance for map
    Map::InitVisibilityDistance();

    sScriptMgr->OnCreateMap(this);
}

void Map::InitVisibilityDistance()
{
    //init visibility for continents
    m_VisibleDistance = World::GetMaxVisibleDistanceOnContinents();

    switch (GetId())
    {
        case 609: // Scarlet Enclave (DK starting zone)
            m_VisibleDistance = 125.0f;
            break;
        case 25: // Scott Test (box map)
            m_VisibleDistance = 200.0f;
            break;
    }
}

// Template specialization of utility methods
template<class T>
void Map::AddToGrid(T* obj, Cell const& cell)
{
    NGridType* grid = getNGrid(cell.GridX(), cell.GridY());
    if (obj->IsWorldObject())
        grid->GetGridType(cell.CellX(), cell.CellY()).template AddWorldObject<T>(obj);
    else
        grid->GetGridType(cell.CellX(), cell.CellY()).template AddGridObject<T>(obj);
}

template<>
void Map::AddToGrid(Creature* obj, Cell const& cell)
{
    NGridType* grid = getNGrid(cell.GridX(), cell.GridY());
    if (obj->IsWorldObject())
        grid->GetGridType(cell.CellX(), cell.CellY()).AddWorldObject(obj);
    else
        grid->GetGridType(cell.CellX(), cell.CellY()).AddGridObject(obj);

    obj->SetCurrentCell(cell);
}

template<>
void Map::AddToGrid(GameObject* obj, Cell const& cell)
{
    NGridType* grid = getNGrid(cell.GridX(), cell.GridY());
    grid->GetGridType(cell.CellX(), cell.CellY()).AddGridObject(obj);

    obj->SetCurrentCell(cell);
}

template<>
void Map::AddToGrid(DynamicObject* obj, Cell const& cell)
{
    NGridType* grid = getNGrid(cell.GridX(), cell.GridY());
    if (obj->IsWorldObject())
        grid->GetGridType(cell.CellX(), cell.CellY()).AddWorldObject(obj);
    else
        grid->GetGridType(cell.CellX(), cell.CellY()).AddGridObject(obj);

    obj->SetCurrentCell(cell);
}

template<>
void Map::AddToGrid(Corpse* obj, Cell const& cell)
{
    NGridType* grid = getNGrid(cell.GridX(), cell.GridY());
    // Corpses are a special object type - they can be added to grid via a call to AddToMap
    // or loaded through ObjectGridLoader.
    // Both corpses loaded from database and these freshly generated by Player::CreateCoprse are added to _corpsesByCell
    // ObjectGridLoader loads all corpses from _corpsesByCell even if they were already added to grid before it was loaded
    // so we need to explicitly check it here (Map::AddToGrid is only called from Player::BuildPlayerRepop, not from ObjectGridLoader)
    // to avoid failing an assertion in GridObject::AddToGrid
    if (grid->isGridObjectDataLoaded())
    {
        if (obj->IsWorldObject())
            grid->GetGridType(cell.CellX(), cell.CellY()).AddWorldObject(obj);
        else
            grid->GetGridType(cell.CellX(), cell.CellY()).AddGridObject(obj);
    }
}

template<class T>
void Map::SwitchGridContainers(T* /*obj*/, bool /*on*/)
{
}

template<>
void Map::SwitchGridContainers(Creature* obj, bool on)
{
    ASSERT(!obj->IsPermanentWorldObject());
    CellCoord p = Acore::ComputeCellCoord(obj->GetPositionX(), obj->GetPositionY());
    if (!p.IsCoordValid())
    {
        LOG_ERROR("maps", "Map::SwitchGridContainers: Object {} has invalid coordinates X:{} Y:{} grid cell [{}:{}]",
            obj->GetGUID().ToString(), obj->GetPositionX(), obj->GetPositionY(), p.x_coord, p.y_coord);
        return;
    }

    Cell cell(p);
    if (!IsGridLoaded(GridCoord(cell.data.Part.grid_x, cell.data.Part.grid_y)))
        return;

    LOG_DEBUG("maps", "Switch object {} from grid[{}, {}] {}", obj->GetGUID().ToString(), cell.GridX(), cell.GridY(), on);
    NGridType* ngrid = getNGrid(cell.GridX(), cell.GridY());
    ASSERT(ngrid);

    GridType& grid = ngrid->GetGridType(cell.CellX(), cell.CellY());

    obj->RemoveFromGrid(); //This step is not really necessary but we want to do ASSERT in remove/add

    if (on)
    {
        grid.AddWorldObject(obj);
        AddWorldObject(obj);
    }
    else
    {
        grid.AddGridObject(obj);
        RemoveWorldObject(obj);
    }

    obj->m_isTempWorldObject = on;
}

template<>
void Map::SwitchGridContainers(GameObject* obj, bool on)
{
    ASSERT(!obj->IsPermanentWorldObject());
    CellCoord p = Acore::ComputeCellCoord(obj->GetPositionX(), obj->GetPositionY());
    if (!p.IsCoordValid())
    {
        LOG_ERROR("maps", "Map::SwitchGridContainers: Object {} has invalid coordinates X:{} Y:{} grid cell [{}:{}]",
            obj->GetGUID().ToString(), obj->GetPositionX(), obj->GetPositionY(), p.x_coord, p.y_coord);
        return;
    }

    Cell cell(p);
    if (!IsGridLoaded(GridCoord(cell.data.Part.grid_x, cell.data.Part.grid_y)))
        return;

    //LOG_DEBUG(LOG_FILTER_MAPS, "Switch object {} from grid[{}, {}] {}", obj->GetGUID().ToString(), cell.data.Part.grid_x, cell.data.Part.grid_y, on);
    NGridType* ngrid = getNGrid(cell.GridX(), cell.GridY());
    ASSERT(ngrid);

    GridType& grid = ngrid->GetGridType(cell.CellX(), cell.CellY());

    obj->RemoveFromGrid(); //This step is not really necessary but we want to do ASSERT in remove/add

    if (on)
    {
        grid.AddWorldObject(obj);
        AddWorldObject(obj);
    }
    else
    {
        grid.AddGridObject(obj);
        RemoveWorldObject(obj);
    }
}

template<class T>
void Map::DeleteFromWorld(T* obj)
{
    // Note: In case resurrectable corpse and pet its removed from global lists in own destructor
    delete obj;
}

template<>
void Map::DeleteFromWorld(Player* player)
{
    ObjectAccessor::RemoveObject(player);

    RemoveUpdateObject(player); //TODO: I do not know why we need this, it should be removed in ~Object anyway
    delete player;
}

void Map::EnsureGridCreated(const GridCoord& p)
{
    if (getNGrid(p.x_coord, p.y_coord)) // pussywizard
        return;
    std::lock_guard<std::mutex> guard(GridLock);
    EnsureGridCreated_i(p);
}

//Create NGrid so the object can be added to it
//But object data is not loaded here
void Map::EnsureGridCreated_i(const GridCoord& p)
{
    if (!getNGrid(p.x_coord, p.y_coord))
    {
        // pussywizard: moved setNGrid to the end of the function
        NGridType* ngt = new NGridType(p.x_coord * MAX_NUMBER_OF_GRIDS + p.y_coord, p.x_coord, p.y_coord);

        // build a linkage between this map and NGridType
        buildNGridLinkage(ngt); // pussywizard: getNGrid(x, y) changed to: ngt

        //z coord
        int gx = (MAX_NUMBER_OF_GRIDS - 1) - p.x_coord;
        int gy = (MAX_NUMBER_OF_GRIDS - 1) - p.y_coord;

        if (!GridMaps[gx][gy])
        {
            LoadMapAndVMap(gx, gy);
        }

        // pussywizard: moved here
        setNGrid(ngt, p.x_coord, p.y_coord);
    }
}

//Create NGrid and load the object data in it
bool Map::EnsureGridLoaded(const Cell& cell)
{
    EnsureGridCreated(GridCoord(cell.GridX(), cell.GridY()));
    NGridType* grid = getNGrid(cell.GridX(), cell.GridY());

    ASSERT(grid);
    if (!isGridObjectDataLoaded(cell.GridX(), cell.GridY()))
    {
        //if (!isGridObjectDataLoaded(cell.GridX(), cell.GridY()))
        //{
        LOG_DEBUG("maps", "Loading grid[{}, {}] for map {} instance {}", cell.GridX(), cell.GridY(), GetId(), i_InstanceId);

        setGridObjectDataLoaded(true, cell.GridX(), cell.GridY());

        ObjectGridLoader loader(*grid, this, cell);
        loader.LoadN();

        Balance();
        return true;
        //}
    }

    return false;
}

void Map::LoadGrid(float x, float y)
{
    EnsureGridLoaded(Cell(x, y));
}

void Map::LoadAllCells()
{
    for (uint32 cellX = 0; cellX < TOTAL_NUMBER_OF_CELLS_PER_MAP; cellX++)
        for (uint32 cellY = 0; cellY < TOTAL_NUMBER_OF_CELLS_PER_MAP; cellY++)
            LoadGrid((cellX + 0.5f - CENTER_GRID_CELL_ID) * SIZE_OF_GRID_CELL, (cellY + 0.5f - CENTER_GRID_CELL_ID) * SIZE_OF_GRID_CELL);
}

bool Map::AddPlayerToMap(Player* player)
{
    CellCoord cellCoord = Acore::ComputeCellCoord(player->GetPositionX(), player->GetPositionY());
    if (!cellCoord.IsCoordValid())
    {
        LOG_ERROR("maps", "Map::Add: Player ({}) has invalid coordinates X:{} Y:{} grid cell [{}:{}]",
            player->GetGUID().ToString(), player->GetPositionX(), player->GetPositionY(), cellCoord.x_coord, cellCoord.y_coord);
        return false;
    }

    Cell cell(cellCoord);
    EnsureGridLoaded(cell);
    AddToGrid(player, cell);

    // Check if we are adding to correct map
    ASSERT (player->GetMap() == this);
    player->SetMap(this);
    player->AddToWorld();

    SendInitTransports(player);
    SendInitSelf(player);
    SendZoneDynamicInfo(player);

    player->m_clientGUIDs.clear();
    player->UpdateObjectVisibility(false);

    if (player->IsAlive())
        ConvertCorpseToBones(player->GetGUID());

    sScriptMgr->OnPlayerEnterMap(this, player);
    return true;
}

template<class T>
void Map::InitializeObject(T* /*obj*/)
{
}

template<>
void Map::InitializeObject(Creature*  /*obj*/)
{
    //obj->_moveState = MAP_OBJECT_CELL_MOVE_NONE;
}

template<>
void Map::InitializeObject(GameObject*  /*obj*/)
{
    //obj->_moveState = MAP_OBJECT_CELL_MOVE_NONE;
}

template<class T>
bool Map::AddToMap(T* obj, bool checkTransport)
{
    //TODO: Needs clean up. An object should not be added to map twice.
    if (obj->IsInWorld())
    {
        ASSERT(obj->IsInGrid());
        obj->UpdateObjectVisibility(true);
        return true;
    }

    CellCoord cellCoord = Acore::ComputeCellCoord(obj->GetPositionX(), obj->GetPositionY());
    //It will create many problems (including crashes) if an object is not added to grid after creation
    //The correct way to fix it is to make AddToMap return false and delete the object if it is not added to grid
    //But now AddToMap is used in too many places, I will just see how many ASSERT failures it will cause
    ASSERT(cellCoord.IsCoordValid());
    if (!cellCoord.IsCoordValid())
    {
        LOG_ERROR("maps", "Map::AddToMap: Object {} has invalid coordinates X:{} Y:{} grid cell [{}:{}]",
            obj->GetGUID().ToString(), obj->GetPositionX(), obj->GetPositionY(), cellCoord.x_coord, cellCoord.y_coord);
        return false; //Should delete object
    }

    Cell cell(cellCoord);
    if (obj->isActiveObject())
        EnsureGridLoaded(cell);
    else
        EnsureGridCreated(GridCoord(cell.GridX(), cell.GridY()));

    AddToGrid(obj, cell);

    //Must already be set before AddToMap. Usually during obj->Create.
    //obj->SetMap(this);
    obj->AddToWorld();

    if (checkTransport)
        if (!(obj->GetTypeId() == TYPEID_GAMEOBJECT && obj->ToGameObject()->IsTransport())) // dont add transport to transport ;d
            if (Transport* transport = GetTransportForPos(obj->GetPhaseMask(), obj->GetPositionX(), obj->GetPositionY(), obj->GetPositionZ(), obj))
                transport->AddPassenger(obj, true);

    InitializeObject(obj);

    if (obj->isActiveObject())
        AddToActive(obj);

    //something, such as vehicle, needs to be update immediately
    //also, trigger needs to cast spell, if not update, cannot see visual
    obj->UpdateObjectVisibility(true);

    // Xinef: little hack for vehicles, accessories have to be added after visibility update so they wont fall off the vehicle, moved from Creature::AIM_Initialize
    // Initialize vehicle, this is done only for summoned npcs, DB creatures are handled by grid loaders
    if (obj->GetTypeId() == TYPEID_UNIT)
        if (Vehicle* vehicle = obj->ToCreature()->GetVehicleKit())
            vehicle->Reset();
    return true;
}

template<>
bool Map::AddToMap(MotionTransport* obj, bool /*checkTransport*/)
{
    //TODO: Needs clean up. An object should not be added to map twice.
    if (obj->IsInWorld())
        return true;

    CellCoord cellCoord = Acore::ComputeCellCoord(obj->GetPositionX(), obj->GetPositionY());
    if (!cellCoord.IsCoordValid())
    {
        LOG_ERROR("maps", "Map::Add: Object {} has invalid coordinates X:{} Y:{} grid cell [{}:{}]",
            obj->GetGUID().ToString(), obj->GetPositionX(), obj->GetPositionY(), cellCoord.x_coord, cellCoord.y_coord);
        return false; //Should delete object
    }

    Cell cell(cellCoord);
    if (obj->isActiveObject())
        EnsureGridLoaded(cell);

    obj->AddToWorld();

    if (obj->isActiveObject())
        AddToActive(obj);

    _transports.insert(obj);

    // Broadcast creation to players
    if (!GetPlayers().IsEmpty())
    {
        for (Map::PlayerList::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
        {
            if (itr->GetSource()->GetTransport() != obj)
            {
                UpdateData data;
                obj->BuildCreateUpdateBlockForPlayer(&data, itr->GetSource());
                WorldPacket packet;
                data.BuildPacket(packet);
                itr->GetSource()->SendDirectMessage(&packet);
            }
        }
    }

    return true;
}

bool Map::IsGridLoaded(const GridCoord& p) const
{
    return (getNGrid(p.x_coord, p.y_coord) && isGridObjectDataLoaded(p.x_coord, p.y_coord));
}

void Map::VisitNearbyCellsOfPlayer(Player* player, TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer>& gridVisitor,
                                   TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer>& worldVisitor,
                                   TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer>& largeGridVisitor,
                                   TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer>& largeWorldVisitor)
{
    // check for valid position
    if (!player->IsPositionValid())
        return;

    // check normal grid activation range of the player
    VisitNearbyCellsOf(player, gridVisitor, worldVisitor, largeGridVisitor, largeWorldVisitor);

    // check maximum visibility distance for large creatures
    CellArea area = Cell::CalculateCellArea(player->GetPositionX(), player->GetPositionY(), MAX_VISIBILITY_DISTANCE);

    for (uint32 x = area.low_bound.x_coord; x <= area.high_bound.x_coord; ++x)
    {
        for (uint32 y = area.low_bound.y_coord; y <= area.high_bound.y_coord; ++y)
        {
            // marked cells are those that have been visited
            // don't visit the same cell twice
            uint32 cell_id = (y * TOTAL_NUMBER_OF_CELLS_PER_MAP) + x;
            if (isCellMarkedLarge(cell_id))
                continue;

            markCellLarge(cell_id);
            CellCoord pair(x, y);
            Cell cell(pair);

            Visit(cell, largeGridVisitor);
            Visit(cell, largeWorldVisitor);
        }
    }
}

void Map::VisitNearbyCellsOf(WorldObject* obj, TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer>& gridVisitor,
                             TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer>& worldVisitor,
                             TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer>& largeGridVisitor,
                             TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer>& largeWorldVisitor)
{
    // Check for valid position
    if (!obj->IsPositionValid())
        return;

    // Update mobs/objects in ALL visible cells around object!
    CellArea area = Cell::CalculateCellArea(obj->GetPositionX(), obj->GetPositionY(), obj->GetGridActivationRange());

    for (uint32 x = area.low_bound.x_coord; x <= area.high_bound.x_coord; ++x)
    {
        for (uint32 y = area.low_bound.y_coord; y <= area.high_bound.y_coord; ++y)
        {
            // marked cells are those that have been visited
            // don't visit the same cell twice
            uint32 cell_id = (y * TOTAL_NUMBER_OF_CELLS_PER_MAP) + x;
            if (isCellMarked(cell_id))
                continue;

            markCell(cell_id);
            CellCoord pair(x, y);
            Cell cell(pair);
            //cell.SetNoCreate(); // in mmaps this is missing

            Visit(cell, gridVisitor);
            Visit(cell, worldVisitor);

            if (!isCellMarkedLarge(cell_id))
            {
                markCellLarge(cell_id);
                Visit(cell, largeGridVisitor);
                Visit(cell, largeWorldVisitor);
            }
        }
    }
}

void Map::Update(const uint32 t_diff, const uint32 s_diff, bool  /*thread*/)
{
    if (t_diff)
        _dynamicTree.update(t_diff);

    /// update worldsessions for existing players
    for (m_mapRefIter = m_mapRefMgr.begin(); m_mapRefIter != m_mapRefMgr.end(); ++m_mapRefIter)
    {
        Player* player = m_mapRefIter->GetSource();
        if (player && player->IsInWorld())
        {
            //player->Update(t_diff);
            WorldSession* session = player->GetSession();
            MapSessionFilter updater(session);
            session->Update(s_diff, updater);
        }
    }

    _creatureRespawnScheduler.Update(t_diff);

    if (!t_diff)
    {
        for (m_mapRefIter = m_mapRefMgr.begin(); m_mapRefIter != m_mapRefMgr.end(); ++m_mapRefIter)
        {
            Player* player = m_mapRefIter->GetSource();

            if (!player || !player->IsInWorld())
                continue;

            // update players at tick
            player->Update(s_diff);
        }

        HandleDelayedVisibility();
        return;
    }

    /// update active cells around players and active objects
    resetMarkedCells();
    resetMarkedCellsLarge();

    Acore::ObjectUpdater updater(t_diff, false);

    // for creature
    TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer  > grid_object_update(updater);
    // for pets
    TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer > world_object_update(updater);

    // for large creatures
    Acore::ObjectUpdater largeObjectUpdater(t_diff, true);
    TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer  > grid_large_object_update(largeObjectUpdater);
    TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer  > world_large_object_update(largeObjectUpdater);

    // pussywizard: container for far creatures in combat with players
    std::vector<Creature*> updateList;
    updateList.reserve(10);

    // non-player active objects, increasing iterator in the loop in case of object removal
    for (m_activeNonPlayersIter = m_activeNonPlayers.begin(); m_activeNonPlayersIter != m_activeNonPlayers.end();)
    {
        WorldObject* obj = *m_activeNonPlayersIter;
        ++m_activeNonPlayersIter;

        if (!obj || !obj->IsInWorld())
            continue;

        VisitNearbyCellsOf(obj, grid_object_update, world_object_update, grid_large_object_update, world_large_object_update);
    }

    // the player iterator is stored in the map object
    // to make sure calls to Map::Remove don't invalidate it
    for (m_mapRefIter = m_mapRefMgr.begin(); m_mapRefIter != m_mapRefMgr.end(); ++m_mapRefIter)
    {
        Player* player = m_mapRefIter->GetSource();

        if (!player || !player->IsInWorld())
            continue;

        // update players at tick
        player->Update(s_diff);

        VisitNearbyCellsOfPlayer(player, grid_object_update, world_object_update, grid_large_object_update, world_large_object_update);

        // If player is using far sight, visit that object too
        if (WorldObject* viewPoint = player->GetViewpoint())
        {
            if (Creature* viewCreature = viewPoint->ToCreature())
            {
                VisitNearbyCellsOf(viewCreature, grid_object_update, world_object_update, grid_large_object_update, world_large_object_update);
            }
            else if (DynamicObject* viewObject = viewPoint->ToDynObject())
            {
                VisitNearbyCellsOf(viewObject, grid_object_update, world_object_update, grid_large_object_update, world_large_object_update);
            }
        }

        // handle updates for creatures in combat with player and are more than X yards away
        if (player->IsInCombat())
        {
            updateList.clear();
            float rangeSq = player->GetGridActivationRange() - 1.0f;
            rangeSq = rangeSq * rangeSq;
            HostileReference* ref = player->getHostileRefMgr().getFirst();
            while (ref)
            {
                if (Unit* unit = ref->GetSource()->GetOwner())
                    if (Creature* cre = unit->ToCreature())
                        if (cre->FindMap() == player->FindMap() && cre->GetExactDist2dSq(player) > rangeSq)
                            updateList.push_back(cre);
                ref = ref->next();
            }
            for (std::vector<Creature*>::const_iterator itr = updateList.begin(); itr != updateList.end(); ++itr)
                VisitNearbyCellsOf(*itr, grid_object_update, world_object_update, grid_large_object_update, world_large_object_update);
        }
    }

    for (_transportsUpdateIter = _transports.begin(); _transportsUpdateIter != _transports.end();) // pussywizard: transports updated after VisitNearbyCellsOf, grids around are loaded, everything ok
    {
        MotionTransport* transport = *_transportsUpdateIter;
        ++_transportsUpdateIter;

        if (!transport->IsInWorld())
            continue;

        transport->Update(t_diff);
    }

    SendObjectUpdates();

    ///- Process necessary scripts
    if (!m_scriptSchedule.empty())
    {
        i_scriptLock = true;
        ScriptsProcess();
        i_scriptLock = false;
    }

    MoveAllCreaturesInMoveList();
    MoveAllGameObjectsInMoveList();
    MoveAllDynamicObjectsInMoveList();

    HandleDelayedVisibility();

    sScriptMgr->OnMapUpdate(this, t_diff);

    METRIC_VALUE("map_creatures", uint64(GetObjectsStore().Size<Creature>()),
        METRIC_TAG("map_id", std::to_string(GetId())),
        METRIC_TAG("map_instanceid", std::to_string(GetInstanceId())));

    METRIC_VALUE("map_gameobjects", uint64(GetObjectsStore().Size<GameObject>()),
        METRIC_TAG("map_id", std::to_string(GetId())),
        METRIC_TAG("map_instanceid", std::to_string(GetInstanceId())));
}

void Map::HandleDelayedVisibility()
{
    if (i_objectsForDelayedVisibility.empty())
        return;
    for (std::unordered_set<Unit*>::iterator itr = i_objectsForDelayedVisibility.begin(); itr != i_objectsForDelayedVisibility.end(); ++itr)
        (*itr)->ExecuteDelayedUnitRelocationEvent();
    i_objectsForDelayedVisibility.clear();
}

struct ResetNotifier
{
    template<class T>inline void resetNotify(GridRefMgr<T>& m)
    {
        for (typename GridRefMgr<T>::iterator iter = m.begin(); iter != m.end(); ++iter)
            iter->GetSource()->ResetAllNotifies();
    }
    template<class T> void Visit(GridRefMgr<T>&) {}
    void Visit(CreatureMapType& m) { resetNotify<Creature>(m);}
    void Visit(PlayerMapType& m) { resetNotify<Player>(m);}
};

void Map::RemovePlayerFromMap(Player* player, bool remove)
{
    player->getHostileRefMgr().deleteReferences(true); // pussywizard: multithreading crashfix

    bool inWorld = player->IsInWorld();
    player->RemoveFromWorld();
    SendRemoveTransports(player);

    if (!inWorld) // pussywizard: if was in world, RemoveFromWorld() called DestroyForNearbyPlayers()
        player->DestroyForNearbyPlayers(); // pussywizard: previous player->UpdateObjectVisibility(true)

    if (player->IsInGrid())
        player->RemoveFromGrid();
    else
        ASSERT(remove); //maybe deleted in logoutplayer when player is not in a map

    sScriptMgr->OnPlayerLeaveMap(this, player);
    if (remove)
    {
        DeleteFromWorld(player);
    }
}

void Map::AfterPlayerUnlinkFromMap()
{
}

template<class T>
void Map::RemoveFromMap(T* obj, bool remove)
{
    bool inWorld = obj->IsInWorld() && obj->GetTypeId() >= TYPEID_UNIT && obj->GetTypeId() <= TYPEID_GAMEOBJECT;
    obj->RemoveFromWorld();

    if (obj->isActiveObject())
        RemoveFromActive(obj);

    if (!inWorld) // pussywizard: if was in world, RemoveFromWorld() called DestroyForNearbyPlayers()
        obj->DestroyForNearbyPlayers(); // pussywizard: previous player->UpdateObjectVisibility()

    obj->RemoveFromGrid();

    obj->ResetMap();

    if (remove)
        DeleteFromWorld(obj);
}

template<>
void Map::RemoveFromMap(MotionTransport* obj, bool remove)
{
    obj->RemoveFromWorld();
    if (obj->isActiveObject())
        RemoveFromActive(obj);

    Map::PlayerList const& players = GetPlayers();
    if (!players.IsEmpty())
    {
        UpdateData data;
        obj->BuildOutOfRangeUpdateBlock(&data);
        WorldPacket packet;
        data.BuildPacket(packet);
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (itr->GetSource()->GetTransport() != obj)
                itr->GetSource()->SendDirectMessage(&packet);
    }

    if (_transportsUpdateIter != _transports.end())
    {
        TransportsContainer::iterator itr = _transports.find(obj);
        if (itr == _transports.end())
            return;
        if (itr == _transportsUpdateIter)
            ++_transportsUpdateIter;
        _transports.erase(itr);
    }
    else
        _transports.erase(obj);

    obj->ResetMap();

    if (remove)
    {
        // if option set then object already saved at this moment
        if (!sWorld->getBoolConfig(CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY))
            obj->SaveRespawnTime();
        DeleteFromWorld(obj);
    }
}

void Map::PlayerRelocation(Player* player, float x, float y, float z, float o)
{
    Cell old_cell(player->GetPositionX(), player->GetPositionY());
    Cell new_cell(x, y);

    if (old_cell.DiffGrid(new_cell) || old_cell.DiffCell(new_cell))
    {
        player->RemoveFromGrid();

        if (old_cell.DiffGrid(new_cell))
            EnsureGridLoaded(new_cell);

        AddToGrid(player, new_cell);
    }

    player->Relocate(x, y, z, o);
    if (player->IsVehicle())
        player->GetVehicleKit()->RelocatePassengers();
    player->UpdatePositionData();
    player->UpdateObjectVisibility(false);
}

void Map::CreatureRelocation(Creature* creature, float x, float y, float z, float o)
{
    Cell old_cell = creature->GetCurrentCell();
    Cell new_cell(x, y);

    if (old_cell.DiffGrid(new_cell) || old_cell.DiffCell(new_cell))
    {
        if (old_cell.DiffGrid(new_cell))
            EnsureGridLoaded(new_cell);

        AddCreatureToMoveList(creature);
    }
    else
        RemoveCreatureFromMoveList(creature);

    creature->Relocate(x, y, z, o);
    if (creature->IsVehicle())
        creature->GetVehicleKit()->RelocatePassengers();
    creature->UpdatePositionData();
    creature->UpdateObjectVisibility(false);
}

void Map::GameObjectRelocation(GameObject* go, float x, float y, float z, float o)
{
    Cell old_cell = go->GetCurrentCell();
    Cell new_cell(x, y);

    if (old_cell.DiffGrid(new_cell) || old_cell.DiffCell(new_cell))
    {
        if (old_cell.DiffGrid(new_cell))
            EnsureGridLoaded(new_cell);

        AddGameObjectToMoveList(go);
    }
    else
        RemoveGameObjectFromMoveList(go);

    go->Relocate(x, y, z, o);
    go->UpdateModelPosition();
    go->SetPositionDataUpdate();
    go->UpdateObjectVisibility(false);
}

void Map::DynamicObjectRelocation(DynamicObject* dynObj, float x, float y, float z, float o)
{
    Cell old_cell = dynObj->GetCurrentCell();
    Cell new_cell(x, y);

    if (old_cell.DiffGrid(new_cell) || old_cell.DiffCell(new_cell))
    {
        if (old_cell.DiffGrid(new_cell))
            EnsureGridLoaded(new_cell);

        AddDynamicObjectToMoveList(dynObj);
    }
    else
        RemoveDynamicObjectFromMoveList(dynObj);

    dynObj->Relocate(x, y, z, o);
    dynObj->SetPositionDataUpdate();
    dynObj->UpdateObjectVisibility(false);
}

void Map::AddCreatureToMoveList(Creature* c)
{
    if (c->_moveState == MAP_OBJECT_CELL_MOVE_NONE)
        _creaturesToMove.push_back(c);
    c->_moveState = MAP_OBJECT_CELL_MOVE_ACTIVE;
}

void Map::RemoveCreatureFromMoveList(Creature* c)
{
    if (c->_moveState == MAP_OBJECT_CELL_MOVE_ACTIVE)
        c->_moveState = MAP_OBJECT_CELL_MOVE_INACTIVE;
}

void Map::AddGameObjectToMoveList(GameObject* go)
{
    if (go->_moveState == MAP_OBJECT_CELL_MOVE_NONE)
        _gameObjectsToMove.push_back(go);
    go->_moveState = MAP_OBJECT_CELL_MOVE_ACTIVE;
}

void Map::RemoveGameObjectFromMoveList(GameObject* go)
{
    if (go->_moveState == MAP_OBJECT_CELL_MOVE_ACTIVE)
        go->_moveState = MAP_OBJECT_CELL_MOVE_INACTIVE;
}

void Map::AddDynamicObjectToMoveList(DynamicObject* dynObj)
{
    if (dynObj->_moveState == MAP_OBJECT_CELL_MOVE_NONE)
        _dynamicObjectsToMove.push_back(dynObj);
    dynObj->_moveState = MAP_OBJECT_CELL_MOVE_ACTIVE;
}

void Map::RemoveDynamicObjectFromMoveList(DynamicObject* dynObj)
{
    if (dynObj->_moveState == MAP_OBJECT_CELL_MOVE_ACTIVE)
        dynObj->_moveState = MAP_OBJECT_CELL_MOVE_INACTIVE;
}

void Map::MoveAllCreaturesInMoveList()
{
    for (std::vector<Creature*>::iterator itr = _creaturesToMove.begin(); itr != _creaturesToMove.end(); ++itr)
    {
        Creature* c = *itr;
        if (c->FindMap() != this)
            continue;

        if (c->_moveState != MAP_OBJECT_CELL_MOVE_ACTIVE)
        {
            c->_moveState = MAP_OBJECT_CELL_MOVE_NONE;
            continue;
        }

        c->_moveState = MAP_OBJECT_CELL_MOVE_NONE;
        if (!c->IsInWorld())
            continue;

        Cell const& old_cell = c->GetCurrentCell();
        Cell new_cell(c->GetPositionX(), c->GetPositionY());

        c->RemoveFromGrid();
        if (old_cell.DiffGrid(new_cell))
            EnsureGridLoaded(new_cell);
        AddToGrid(c, new_cell);
    }
    _creaturesToMove.clear();
}

void Map::MoveAllGameObjectsInMoveList()
{
    for (std::vector<GameObject*>::iterator itr = _gameObjectsToMove.begin(); itr != _gameObjectsToMove.end(); ++itr)
    {
        GameObject* go = *itr;
        if (go->FindMap() != this)
            continue;

        if (go->_moveState != MAP_OBJECT_CELL_MOVE_ACTIVE)
        {
            go->_moveState = MAP_OBJECT_CELL_MOVE_NONE;
            continue;
        }

        go->_moveState = MAP_OBJECT_CELL_MOVE_NONE;
        if (!go->IsInWorld())
            continue;

        Cell const& old_cell = go->GetCurrentCell();
        Cell new_cell(go->GetPositionX(), go->GetPositionY());

        go->RemoveFromGrid();
        if (old_cell.DiffGrid(new_cell))
            EnsureGridLoaded(new_cell);
        AddToGrid(go, new_cell);
    }
    _gameObjectsToMove.clear();
}

void Map::MoveAllDynamicObjectsInMoveList()
{
    for (std::vector<DynamicObject*>::iterator itr = _dynamicObjectsToMove.begin(); itr != _dynamicObjectsToMove.end(); ++itr)
    {
        DynamicObject* dynObj = *itr;
        if (dynObj->FindMap() != this)
            continue;

        if (dynObj->_moveState != MAP_OBJECT_CELL_MOVE_ACTIVE)
        {
            dynObj->_moveState = MAP_OBJECT_CELL_MOVE_NONE;
            continue;
        }

        dynObj->_moveState = MAP_OBJECT_CELL_MOVE_NONE;
        if (!dynObj->IsInWorld())
            continue;

        Cell const& old_cell = dynObj->GetCurrentCell();
        Cell new_cell(dynObj->GetPositionX(), dynObj->GetPositionY());

        dynObj->RemoveFromGrid();
        if (old_cell.DiffGrid(new_cell))
            EnsureGridLoaded(new_cell);
        AddToGrid(dynObj, new_cell);
    }
    _dynamicObjectsToMove.clear();
}

bool Map::UnloadGrid(NGridType& ngrid)
{
    // pussywizard: UnloadGrid only done when whole map is unloaded, no need to worry about moving npcs between grids, etc.

    const uint32 x = ngrid.getX();
    const uint32 y = ngrid.getY();

    {
        ObjectGridCleaner worker;
        TypeContainerVisitor<ObjectGridCleaner, GridTypeMapContainer> visitor(worker);
        ngrid.VisitAllGrids(visitor);
    }

    RemoveAllObjectsInRemoveList();

    {
        ObjectGridUnloader worker;
        TypeContainerVisitor<ObjectGridUnloader, GridTypeMapContainer> visitor(worker);
        ngrid.VisitAllGrids(visitor);
    }

    ASSERT(i_objectsToRemove.empty());

    delete &ngrid;
    setNGrid(nullptr, x, y);

    int gx = (MAX_NUMBER_OF_GRIDS - 1) - x;
    int gy = (MAX_NUMBER_OF_GRIDS - 1) - y;

    if (i_InstanceId == 0)
    {
        if (GridMaps[gx][gy])
        {
            GridMaps[gx][gy]->unloadData();
            delete GridMaps[gx][gy];
        }
        // x and y are swapped
        VMAP::VMapFactory::createOrGetVMapMgr()->unloadMap(GetId(), gx, gy);
        MMAP::MMapFactory::createOrGetMMapMgr()->unloadMap(GetId(), gx, gy);
    }

    GridMaps[gx][gy] = nullptr;

    LOG_DEBUG("maps", "Unloading grid[{}, {}] for map {} finished", x, y, GetId());
    return true;
}

void Map::RemoveAllPlayers()
{
    if (HavePlayers())
    {
        for (MapRefMgr::iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
        {
            Player* player = itr->GetSource();
            if (!player->IsBeingTeleportedFar())
            {
                // this is happening for bg
                LOG_ERROR("maps", "Map::UnloadAll: player {} is still in map {} during unload, this should not happen!", player->GetName(), GetId());
                player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, player->m_homebindO);
            }
        }
    }
}

void Map::UnloadAll()
{
    // clear all delayed moves, useless anyway do this moves before map unload.
    _creaturesToMove.clear();
    _gameObjectsToMove.clear();

    for (GridRefMgr<NGridType>::iterator i = GridRefMgr<NGridType>::begin(); i != GridRefMgr<NGridType>::end();)
    {
        NGridType& grid(*i->GetSource());
        ++i;
        UnloadGrid(grid); // deletes the grid and removes it from the GridRefMgr
    }

    // pussywizard: crashfix, some npc can be left on transport (not a default passenger)
    if (!AllTransportsEmpty())
        AllTransportsRemovePassengers();

    for (TransportsContainer::iterator itr = _transports.begin(); itr != _transports.end();)
    {
        MotionTransport* transport = *itr;
        ++itr;

        transport->RemoveFromWorld();
        delete transport;
    }

    _transports.clear();

    for (auto& cellCorpsePair : _corpsesByCell)
    {
        for (Corpse* corpse : cellCorpsePair.second)
        {
            corpse->RemoveFromWorld();
            corpse->ResetMap();
            delete corpse;
        }
    }

    _corpsesByCell.clear();
    _corpsesByPlayer.clear();
    _corpseBones.clear();
}

// *****************************
// Grid function
// *****************************
GridMap::GridMap()
{
    _flags = 0;
    // Area data
    _gridArea = 0;
    _areaMap = nullptr;
    // Height level data
    _gridHeight = INVALID_HEIGHT;
    _gridGetHeight = &GridMap::getHeightFromFlat;
    _gridIntHeightMultiplier = 0;
    m_V9 = nullptr;
    m_V8 = nullptr;
    _maxHeight = nullptr;
    _minHeight = nullptr;
    // Liquid data
    _liquidGlobalEntry = 0;
    _liquidGlobalFlags = 0;
    _liquidOffX   = 0;
    _liquidOffY   = 0;
    _liquidWidth  = 0;
    _liquidHeight = 0;
    _liquidLevel = INVALID_HEIGHT;
    _liquidEntry = nullptr;
    _liquidFlags = nullptr;
    _liquidMap  = nullptr;
    _holes = nullptr;
}

GridMap::~GridMap()
{
    unloadData();
}

bool GridMap::loadData(char* filename)
{
    // Unload old data if exist
    unloadData();

    map_fileheader header;
    // Not return error if file not found
    FILE* in = fopen(filename, "rb");
    if (!in)
        return true;

    if (fread(&header, sizeof(header), 1, in) != 1)
    {
        fclose(in);
        return false;
    }

    if (header.mapMagic == MapMagic.asUInt && header.versionMagic == MapVersionMagic)
    {
        // loadup area data
        if (header.areaMapOffset && !loadAreaData(in, header.areaMapOffset, header.areaMapSize))
        {
            LOG_ERROR("maps", "Error loading map area data\n");
            fclose(in);
            return false;
        }
        // loadup height data
        if (header.heightMapOffset && !loadHeightData(in, header.heightMapOffset, header.heightMapSize))
        {
            LOG_ERROR("maps", "Error loading map height data\n");
            fclose(in);
            return false;
        }
        // loadup liquid data
        if (header.liquidMapOffset && !loadLiquidData(in, header.liquidMapOffset, header.liquidMapSize))
        {
            LOG_ERROR("maps", "Error loading map liquids data\n");
            fclose(in);
            return false;
        }
        // loadup holes data (if any. check header.holesOffset)
        if (header.holesSize && !loadHolesData(in, header.holesOffset, header.holesSize))
        {
            LOG_ERROR("maps", "Error loading map holes data\n");
            fclose(in);
            return false;
        }
        fclose(in);
        return true;
    }
    LOG_ERROR("maps", "Map file '{}' is from an incompatible clientversion. Please recreate using the mapextractor.", filename);
    fclose(in);
    return false;
}

void GridMap::unloadData()
{
    delete[] _areaMap;
    delete[] m_V9;
    delete[] m_V8;
    delete[] _maxHeight;
    delete[] _minHeight;
    delete[] _liquidEntry;
    delete[] _liquidFlags;
    delete[] _liquidMap;
    delete[] _holes;
    _areaMap = nullptr;
    m_V9 = nullptr;
    m_V8 = nullptr;
    _maxHeight = nullptr;
    _minHeight = nullptr;
    _liquidEntry = nullptr;
    _liquidFlags = nullptr;
    _liquidMap  = nullptr;
    _holes = nullptr;
    _gridGetHeight = &GridMap::getHeightFromFlat;
}

bool GridMap::loadAreaData(FILE* in, uint32 offset, uint32 /*size*/)
{
    map_areaHeader header;
    fseek(in, offset, SEEK_SET);

    if (fread(&header, sizeof(header), 1, in) != 1 || header.fourcc != MapAreaMagic.asUInt)
        return false;

    _gridArea = header.gridArea;
    if (!(header.flags & MAP_AREA_NO_AREA))
    {
        _areaMap = new uint16 [16 * 16];
        if (fread(_areaMap, sizeof(uint16), 16 * 16, in) != 16 * 16)
            return false;
    }
    return true;
}

bool GridMap::loadHeightData(FILE* in, uint32 offset, uint32 /*size*/)
{
    map_heightHeader header;
    fseek(in, offset, SEEK_SET);

    if (fread(&header, sizeof(header), 1, in) != 1 || header.fourcc != MapHeightMagic.asUInt)
        return false;

    _gridHeight = header.gridHeight;
    if (!(header.flags & MAP_HEIGHT_NO_HEIGHT))
    {
        if ((header.flags & MAP_HEIGHT_AS_INT16))
        {
            m_uint16_V9 = new uint16 [129 * 129];
            m_uint16_V8 = new uint16 [128 * 128];
            if (fread(m_uint16_V9, sizeof(uint16), 129 * 129, in) != 129 * 129 ||
                    fread(m_uint16_V8, sizeof(uint16), 128 * 128, in) != 128 * 128)
                return false;
            _gridIntHeightMultiplier = (header.gridMaxHeight - header.gridHeight) / 65535;
            _gridGetHeight = &GridMap::getHeightFromUint16;
        }
        else if ((header.flags & MAP_HEIGHT_AS_INT8))
        {
            m_uint8_V9 = new uint8 [129 * 129];
            m_uint8_V8 = new uint8 [128 * 128];
            if (fread(m_uint8_V9, sizeof(uint8), 129 * 129, in) != 129 * 129 ||
                    fread(m_uint8_V8, sizeof(uint8), 128 * 128, in) != 128 * 128)
                return false;
            _gridIntHeightMultiplier = (header.gridMaxHeight - header.gridHeight) / 255;
            _gridGetHeight = &GridMap::getHeightFromUint8;
        }
        else
        {
            m_V9 = new float [129 * 129];
            m_V8 = new float [128 * 128];
            if (fread(m_V9, sizeof(float), 129 * 129, in) != 129 * 129 ||
                    fread(m_V8, sizeof(float), 128 * 128, in) != 128 * 128)
                return false;
            _gridGetHeight = &GridMap::getHeightFromFloat;
        }
    }
    else
        _gridGetHeight = &GridMap::getHeightFromFlat;

    if (header.flags & MAP_HEIGHT_HAS_FLIGHT_BOUNDS)
    {
        _maxHeight = new int16[3 * 3];
        _minHeight = new int16[3 * 3];
        if (fread(_maxHeight, sizeof(int16), 3 * 3, in) != 3 * 3 ||
                fread(_minHeight, sizeof(int16), 3 * 3, in) != 3 * 3)
            return false;
    }

    return true;
}

bool GridMap::loadLiquidData(FILE* in, uint32 offset, uint32 /*size*/)
{
    map_liquidHeader header;
    fseek(in, offset, SEEK_SET);

    if (fread(&header, sizeof(header), 1, in) != 1 || header.fourcc != MapLiquidMagic.asUInt)
        return false;

    _liquidGlobalEntry = header.liquidType;
    _liquidGlobalFlags = header.liquidFlags;
    _liquidOffX  = header.offsetX;
    _liquidOffY  = header.offsetY;
    _liquidWidth = header.width;
    _liquidHeight = header.height;
    _liquidLevel  = header.liquidLevel;

    if (!(header.flags & MAP_LIQUID_NO_TYPE))
    {
        _liquidEntry = new uint16[16 * 16];
        if (fread(_liquidEntry, sizeof(uint16), 16 * 16, in) != 16 * 16)
            return false;

        _liquidFlags = new uint8[16 * 16];
        if (fread(_liquidFlags, sizeof(uint8), 16 * 16, in) != 16 * 16)
            return false;
    }
    if (!(header.flags & MAP_LIQUID_NO_HEIGHT))
    {
        _liquidMap = new float[uint32(_liquidWidth) * uint32(_liquidHeight)];
        if (fread(_liquidMap, sizeof(float), _liquidWidth * _liquidHeight, in) != (uint32(_liquidWidth) * uint32(_liquidHeight)))
            return false;
    }
    return true;
}

bool GridMap::loadHolesData(FILE* in, uint32 offset, uint32 /*size*/)
{
    if (fseek(in, offset, SEEK_SET) != 0)
        return false;

    _holes = new uint16[16 * 16];
    if (fread(_holes, sizeof(uint16), 16 * 16, in) != 16 * 16)
        return false;

    return true;
}

uint16 GridMap::getArea(float x, float y) const
{
    if (!_areaMap)
        return _gridArea;

    x = 16 * (32 - x / SIZE_OF_GRIDS);
    y = 16 * (32 - y / SIZE_OF_GRIDS);
    int lx = (int)x & 15;
    int ly = (int)y & 15;
    return _areaMap[lx * 16 + ly];
}

float GridMap::getHeightFromFlat(float /*x*/, float /*y*/) const
{
    return _gridHeight;
}

float GridMap::getHeightFromFloat(float x, float y) const
{
    if (!m_V8 || !m_V9)
        return _gridHeight;

    x = MAP_RESOLUTION * (32 - x / SIZE_OF_GRIDS);
    y = MAP_RESOLUTION * (32 - y / SIZE_OF_GRIDS);

    int x_int = (int)x;
    int y_int = (int)y;
    x -= x_int;
    y -= y_int;
    x_int &= (MAP_RESOLUTION - 1);
    y_int &= (MAP_RESOLUTION - 1);

    if (isHole(x_int, y_int))
        return INVALID_HEIGHT;

    // Height stored as: h5 - its v8 grid, h1-h4 - its v9 grid
    // +--------------> X
    // | h1-------h2     Coordinates is:
    // | | \  1  / |     h1 0, 0
    // | |  \   /  |     h2 0, 1
    // | | 2  h5 3 |     h3 1, 0
    // | |  /   \  |     h4 1, 1
    // | | /  4  \ |     h5 1/2, 1/2
    // | h3-------h4
    // V Y
    // For find height need
    // 1 - detect triangle
    // 2 - solve linear equation from triangle points
    // Calculate coefficients for solve h = a*x + b*y + c

    float a, b, c;
    // Select triangle:
    if (x + y < 1)
    {
        if (x > y)
        {
            // 1 triangle (h1, h2, h5 points)
            float h1 = m_V9[(x_int) * 129 + y_int];
            float h2 = m_V9[(x_int + 1) * 129 + y_int];
            float h5 = 2 * m_V8[x_int * 128 + y_int];
            a = h2 - h1;
            b = h5 - h1 - h2;
            c = h1;
        }
        else
        {
            // 2 triangle (h1, h3, h5 points)
            float h1 = m_V9[x_int * 129 + y_int  ];
            float h3 = m_V9[x_int * 129 + y_int + 1];
            float h5 = 2 * m_V8[x_int * 128 + y_int];
            a = h5 - h1 - h3;
            b = h3 - h1;
            c = h1;
        }
    }
    else
    {
        if (x > y)
        {
            // 3 triangle (h2, h4, h5 points)
            float h2 = m_V9[(x_int + 1) * 129 + y_int  ];
            float h4 = m_V9[(x_int + 1) * 129 + y_int + 1];
            float h5 = 2 * m_V8[x_int * 128 + y_int];
            a = h2 + h4 - h5;
            b = h4 - h2;
            c = h5 - h4;
        }
        else
        {
            // 4 triangle (h3, h4, h5 points)
            float h3 = m_V9[(x_int) * 129 + y_int + 1];
            float h4 = m_V9[(x_int + 1) * 129 + y_int + 1];
            float h5 = 2 * m_V8[x_int * 128 + y_int];
            a = h4 - h3;
            b = h3 + h4 - h5;
            c = h5 - h4;
        }
    }
    // Calculate height
    return a * x + b * y + c;
}

float GridMap::getHeightFromUint8(float x, float y) const
{
    if (!m_uint8_V8 || !m_uint8_V9)
        return _gridHeight;

    x = MAP_RESOLUTION * (32 - x / SIZE_OF_GRIDS);
    y = MAP_RESOLUTION * (32 - y / SIZE_OF_GRIDS);

    int x_int = (int)x;
    int y_int = (int)y;
    x -= x_int;
    y -= y_int;
    x_int &= (MAP_RESOLUTION - 1);
    y_int &= (MAP_RESOLUTION - 1);

    if (isHole(x_int, y_int))
        return INVALID_HEIGHT;

    int32 a, b, c;
    uint8* V9_h1_ptr = &m_uint8_V9[x_int * 128 + x_int + y_int];
    if (x + y < 1)
    {
        if (x > y)
        {
            // 1 triangle (h1, h2, h5 points)
            int32 h1 = V9_h1_ptr[  0];
            int32 h2 = V9_h1_ptr[129];
            int32 h5 = 2 * m_uint8_V8[x_int * 128 + y_int];
            a = h2 - h1;
            b = h5 - h1 - h2;
            c = h1;
        }
        else
        {
            // 2 triangle (h1, h3, h5 points)
            int32 h1 = V9_h1_ptr[0];
            int32 h3 = V9_h1_ptr[1];
            int32 h5 = 2 * m_uint8_V8[x_int * 128 + y_int];
            a = h5 - h1 - h3;
            b = h3 - h1;
            c = h1;
        }
    }
    else
    {
        if (x > y)
        {
            // 3 triangle (h2, h4, h5 points)
            int32 h2 = V9_h1_ptr[129];
            int32 h4 = V9_h1_ptr[130];
            int32 h5 = 2 * m_uint8_V8[x_int * 128 + y_int];
            a = h2 + h4 - h5;
            b = h4 - h2;
            c = h5 - h4;
        }
        else
        {
            // 4 triangle (h3, h4, h5 points)
            int32 h3 = V9_h1_ptr[  1];
            int32 h4 = V9_h1_ptr[130];
            int32 h5 = 2 * m_uint8_V8[x_int * 128 + y_int];
            a = h4 - h3;
            b = h3 + h4 - h5;
            c = h5 - h4;
        }
    }
    // Calculate height
    return (float)((a * x) + (b * y) + c) * _gridIntHeightMultiplier + _gridHeight;
}

float GridMap::getHeightFromUint16(float x, float y) const
{
    if (!m_uint16_V8 || !m_uint16_V9)
        return _gridHeight;

    x = MAP_RESOLUTION * (32 - x / SIZE_OF_GRIDS);
    y = MAP_RESOLUTION * (32 - y / SIZE_OF_GRIDS);

    int x_int = (int)x;
    int y_int = (int)y;
    x -= x_int;
    y -= y_int;
    x_int &= (MAP_RESOLUTION - 1);
    y_int &= (MAP_RESOLUTION - 1);

    if (isHole(x_int, y_int))
        return INVALID_HEIGHT;

    int32 a, b, c;
    uint16* V9_h1_ptr = &m_uint16_V9[x_int * 128 + x_int + y_int];
    if (x + y < 1)
    {
        if (x > y)
        {
            // 1 triangle (h1, h2, h5 points)
            int32 h1 = V9_h1_ptr[  0];
            int32 h2 = V9_h1_ptr[129];
            int32 h5 = 2 * m_uint16_V8[x_int * 128 + y_int];
            a = h2 - h1;
            b = h5 - h1 - h2;
            c = h1;
        }
        else
        {
            // 2 triangle (h1, h3, h5 points)
            int32 h1 = V9_h1_ptr[0];
            int32 h3 = V9_h1_ptr[1];
            int32 h5 = 2 * m_uint16_V8[x_int * 128 + y_int];
            a = h5 - h1 - h3;
            b = h3 - h1;
            c = h1;
        }
    }
    else
    {
        if (x > y)
        {
            // 3 triangle (h2, h4, h5 points)
            int32 h2 = V9_h1_ptr[129];
            int32 h4 = V9_h1_ptr[130];
            int32 h5 = 2 * m_uint16_V8[x_int * 128 + y_int];
            a = h2 + h4 - h5;
            b = h4 - h2;
            c = h5 - h4;
        }
        else
        {
            // 4 triangle (h3, h4, h5 points)
            int32 h3 = V9_h1_ptr[  1];
            int32 h4 = V9_h1_ptr[130];
            int32 h5 = 2 * m_uint16_V8[x_int * 128 + y_int];
            a = h4 - h3;
            b = h3 + h4 - h5;
            c = h5 - h4;
        }
    }
    // Calculate height
    return (float)((a * x) + (b * y) + c) * _gridIntHeightMultiplier + _gridHeight;
}

bool GridMap::isHole(int row, int col) const
{
    if (!_holes)
        return false;

    int cellRow = row / 8; // 8 squares per cell
    int cellCol = col / 8;
    int holeRow = row % 8 / 2;
    int holeCol = (col - (cellCol * 8)) / 2;

    uint16 hole = _holes[cellRow * 16 + cellCol];

    return (hole & holetab_h[holeCol] & holetab_v[holeRow]) != 0;
}

float GridMap::getMinHeight(float x, float y) const
{
    if (!_minHeight)
        return -500.0f;

    static uint32 const indices[] =
    {
        3, 0, 4,
        0, 1, 4,
        1, 2, 4,
        2, 5, 4,
        5, 8, 4,
        8, 7, 4,
        7, 6, 4,
        6, 3, 4
    };

    static float const boundGridCoords[] =
    {
        0.0f, 0.0f,
        0.0f, -266.66666f,
        0.0f, -533.33331f,
        -266.66666f, 0.0f,
        -266.66666f, -266.66666f,
        -266.66666f, -533.33331f,
        -533.33331f, 0.0f,
        -533.33331f, -266.66666f,
        -533.33331f, -533.33331f
    };

    Cell cell(x, y);
    float gx = x - (int32(cell.GridX()) - CENTER_GRID_ID + 1) * SIZE_OF_GRIDS;
    float gy = y - (int32(cell.GridY()) - CENTER_GRID_ID + 1) * SIZE_OF_GRIDS;

    uint32 quarterIndex = 0;
    if (cell.CellY() < MAX_NUMBER_OF_CELLS / 2)
    {
        if (cell.CellX() < MAX_NUMBER_OF_CELLS / 2)
        {
            quarterIndex = 4 + (gy > gx);
        }
        else
            quarterIndex = 2 + ((-SIZE_OF_GRIDS - gx) > gy);
    }
    else if (cell.CellX() < MAX_NUMBER_OF_CELLS / 2)
    {
        quarterIndex = 6 + ((-SIZE_OF_GRIDS - gx) <= gy);
    }
    else
        quarterIndex = gx > gy;

    quarterIndex *= 3;

    return G3D::Plane(
               G3D::Vector3(boundGridCoords[indices[quarterIndex + 0] * 2 + 0], boundGridCoords[indices[quarterIndex + 0] * 2 + 1], _minHeight[indices[quarterIndex + 0]]),
               G3D::Vector3(boundGridCoords[indices[quarterIndex + 1] * 2 + 0], boundGridCoords[indices[quarterIndex + 1] * 2 + 1], _minHeight[indices[quarterIndex + 1]]),
               G3D::Vector3(boundGridCoords[indices[quarterIndex + 2] * 2 + 0], boundGridCoords[indices[quarterIndex + 2] * 2 + 1], _minHeight[indices[quarterIndex + 2]])
           ).distance(G3D::Vector3(gx, gy, 0.0f));
}

float GridMap::getLiquidLevel(float x, float y) const
{
    if (!_liquidMap)
        return _liquidLevel;

    x = MAP_RESOLUTION * (32 - x / SIZE_OF_GRIDS);
    y = MAP_RESOLUTION * (32 - y / SIZE_OF_GRIDS);

    int cx_int = ((int)x & (MAP_RESOLUTION - 1)) - _liquidOffY;
    int cy_int = ((int)y & (MAP_RESOLUTION - 1)) - _liquidOffX;

    if (cx_int < 0 || cx_int >= _liquidHeight)
        return INVALID_HEIGHT;
    if (cy_int < 0 || cy_int >= _liquidWidth)
        return INVALID_HEIGHT;

    return _liquidMap[cx_int * _liquidWidth + cy_int];
}

// Get water state on map
inline LiquidData const GridMap::GetLiquidData(float x, float y, float z, float collisionHeight, uint8 ReqLiquidType) const
{
    LiquidData liquidData;

    // Check water type (if no water return)
    if (_liquidGlobalFlags || _liquidFlags)
    {
        // Get cell
        float cx = MAP_RESOLUTION * (32 - x / SIZE_OF_GRIDS);
        float cy = MAP_RESOLUTION * (32 - y / SIZE_OF_GRIDS);

        int x_int = (int) cx & (MAP_RESOLUTION - 1);
        int y_int = (int) cy & (MAP_RESOLUTION - 1);

        // Check water type in cell
        int idx=(x_int>>3)*16 + (y_int>>3);
        uint8 type = _liquidFlags ? _liquidFlags[idx] : _liquidGlobalFlags;
        uint32 entry = _liquidEntry ? _liquidEntry[idx] : _liquidGlobalEntry;
        if (LiquidTypeEntry const* liquidEntry = sLiquidTypeStore.LookupEntry(entry))
        {
            type &= MAP_LIQUID_TYPE_DARK_WATER;
            uint32 liqTypeIdx = liquidEntry->Type;
            if (entry < 21)
            {
                if (AreaTableEntry const* area = sAreaTableStore.LookupEntry(getArea(x, y)))
                {
                    uint32 overrideLiquid = area->LiquidTypeOverride[liquidEntry->Type];
                    if (!overrideLiquid && area->zone)
                    {
                        area = sAreaTableStore.LookupEntry(area->zone);
                        if (area)
                            overrideLiquid = area->LiquidTypeOverride[liquidEntry->Type];
                    }

                    if (LiquidTypeEntry const* liq = sLiquidTypeStore.LookupEntry(overrideLiquid))
                    {
                        entry      = overrideLiquid;
                        liqTypeIdx = liq->Type;
                    }
                }
            }

            type |= 1 << liqTypeIdx;
        }

         // Check req liquid type mask
        if (type != 0 && (!ReqLiquidType || (ReqLiquidType & type) != 0))
        {
            // Check water level:
            // Check water height map
            int lx_int = x_int - _liquidOffY;
            int ly_int = y_int - _liquidOffX;
            if (lx_int >= 0 && lx_int < _liquidHeight && ly_int >= 0 && ly_int < _liquidWidth)
            {
                // Get water level
                float liquid_level = _liquidMap ? _liquidMap[lx_int * _liquidWidth + ly_int] : _liquidLevel;
                // Get ground level
                float ground_level = getHeight(x, y);

                // Check water level and ground level (sub 0.2 for fix some errors)
                if (liquid_level >= ground_level && z >= ground_level - 0.2f)
                {
                    // All ok in water -> store data
                    liquidData.Entry  = entry;
                    liquidData.Flags = type;
                    liquidData.Level = liquid_level;
                    liquidData.DepthLevel = ground_level;

                    // For speed check as int values
                    float delta = liquid_level - z;

                    if (delta > collisionHeight)
                        liquidData.Status = LIQUID_MAP_UNDER_WATER;
                    else if (delta > 0.0f)
                        liquidData.Status = LIQUID_MAP_IN_WATER;
                    else if (delta > -0.1f)
                        liquidData.Status = LIQUID_MAP_WATER_WALK;
                    else
                        liquidData.Status = LIQUID_MAP_ABOVE_WATER;
                }
            }
        }
    }

    return liquidData;
}

GridMap* Map::GetGrid(float x, float y)
{
    // half opt method
    int gx = (int)(32 - x / SIZE_OF_GRIDS);                 //grid x
    int gy = (int)(32 - y / SIZE_OF_GRIDS);                 //grid y

    // ensure GridMap is loaded
    EnsureGridCreated(GridCoord(63 - gx, 63 - gy));

    return GridMaps[gx][gy];
}

float Map::GetWaterOrGroundLevel(uint32 phasemask, float x, float y, float z, float* ground /*= nullptr*/, bool /*swim = false*/, float collisionHeight) const
{
    if (const_cast<Map*>(this)->GetGrid(x, y))
    {
        // we need ground level (including grid height version) for proper return water level in point
        float ground_z = GetHeight(phasemask, x, y, z + Z_OFFSET_FIND_HEIGHT, true, 50.0f);
        if (ground)
            *ground = ground_z;

        LiquidData const& liquidData = const_cast<Map*>(this)->GetLiquidData(phasemask, x, y, ground_z, collisionHeight, MAP_ALL_LIQUIDS);
        switch (liquidData.Status)
        {
            case LIQUID_MAP_ABOVE_WATER:
                return std::max<float>(liquidData.Level, ground_z);
            case LIQUID_MAP_NO_WATER:
                return ground_z;
            default:
                return liquidData.Level;
        }
    }

    return VMAP_INVALID_HEIGHT_VALUE;
}

Transport* Map::GetTransportForPos(uint32 phase, float x, float y, float z, WorldObject* worldobject)
{
    G3D::Vector3 v(x, y, z + 2.0f);
    G3D::Ray r(v, G3D::Vector3(0, 0, -1));
    for (TransportsContainer::const_iterator itr = _transports.begin(); itr != _transports.end(); ++itr)
        if ((*itr)->IsInWorld() && (*itr)->GetExactDistSq(x, y, z) < 75.0f * 75.0f && (*itr)->m_model)
        {
            float dist = 30.0f;
            bool hit = (*itr)->m_model->intersectRay(r, dist, false, phase, VMAP::ModelIgnoreFlags::Nothing);
            if (hit)
                return *itr;
        }

    if (worldobject)
        if (GameObject* staticTrans = worldobject->FindNearestGameObjectOfType(GAMEOBJECT_TYPE_TRANSPORT, 75.0f))
            if (staticTrans->m_model)
            {
                float dist = 10.0f;
                bool hit = staticTrans->m_model->intersectRay(r, dist, false, phase, VMAP::ModelIgnoreFlags::Nothing);
                if (hit)
                    if (GetHeight(phase, x, y, z, true, 30.0f) < (v.z - dist + 1.0f))
                        return staticTrans->ToTransport();
            }

    return nullptr;
}

float Map::GetHeight(float x, float y, float z, bool checkVMap /*= true*/, float maxSearchDist /*= DEFAULT_HEIGHT_SEARCH*/) const
{
    // find raw .map surface under Z coordinates
    float mapHeight = VMAP_INVALID_HEIGHT_VALUE;
    float gridHeight = GetGridHeight(x, y);
    if (G3D::fuzzyGe(z, gridHeight - GROUND_HEIGHT_TOLERANCE))
        mapHeight = gridHeight;

    float vmapHeight = VMAP_INVALID_HEIGHT_VALUE;
    if (checkVMap)
    {
        VMAP::IVMapMgr* vmgr = VMAP::VMapFactory::createOrGetVMapMgr();
        vmapHeight = vmgr->getHeight(GetId(), x, y, z, maxSearchDist);   // look from a bit higher pos to find the floor
    }

    // mapHeight set for any above raw ground Z or <= INVALID_HEIGHT
    // vmapheight set for any under Z value or <= INVALID_HEIGHT
    if (vmapHeight > INVALID_HEIGHT)
    {
        if (mapHeight > INVALID_HEIGHT)
        {
            // we have mapheight and vmapheight and must select more appropriate

            // we are already under the surface or vmap height above map heigt
            // or if the distance of the vmap height is less the land height distance
            if (vmapHeight > mapHeight || std::fabs(mapHeight - z) > std::fabs(vmapHeight - z))
                return vmapHeight;
            else
                return mapHeight;                           // better use .map surface height
        }
        else
            return vmapHeight;                              // we have only vmapHeight (if have)
    }

    return mapHeight;                               // explicitly use map data
}

float Map::GetGridHeight(float x, float y) const
{
    if (GridMap* gmap = const_cast<Map*>(this)->GetGrid(x, y))
        return gmap->getHeight(x, y);

    return VMAP_INVALID_HEIGHT_VALUE;
}

float Map::GetMinHeight(float x, float y) const
{
    if (GridMap const* grid = const_cast<Map*>(this)->GetGrid(x, y))
        return grid->getMinHeight(x, y);

    return -500.0f;
}

static inline bool IsInWMOInterior(uint32 mogpFlags)
{
    return (mogpFlags & 0x2000) != 0;
}

bool Map::GetAreaInfo(uint32 phaseMask, float x, float y, float z, uint32& flags, int32& adtId, int32& rootId, int32& groupId) const
{
    float vmap_z = z;
    float dynamic_z = z;
    float check_z = z;
    VMAP::IVMapMgr* vmgr = VMAP::VMapFactory::createOrGetVMapMgr();
    uint32 vflags;
    int32 vadtId;
    int32 vrootId;
    int32 vgroupId;
    uint32 dflags;
    int32 dadtId;
    int32 drootId;
    int32 dgroupId;

    bool hasVmapAreaInfo = vmgr->GetAreaInfo(GetId(), x, y, vmap_z, vflags, vadtId, vrootId, vgroupId);
    bool hasDynamicAreaInfo = _dynamicTree.GetAreaInfo(x, y, dynamic_z, phaseMask, dflags, dadtId, drootId, dgroupId);
    auto useVmap = [&]() { check_z = vmap_z; flags = vflags; adtId = vadtId; rootId = vrootId; groupId = vgroupId; };
    auto useDyn = [&]() { check_z = dynamic_z; flags = dflags; adtId = dadtId; rootId = drootId; groupId = dgroupId; };

    if (hasVmapAreaInfo)
    {
        if (hasDynamicAreaInfo && dynamic_z > vmap_z)
            useDyn();
        else
            useVmap();
    }
    else if (hasDynamicAreaInfo)
    {
        useDyn();
    }

    if (hasVmapAreaInfo || hasDynamicAreaInfo)
    {
        // check if there's terrain between player height and object height
        if (GridMap* gmap = const_cast<Map*>(this)->GetGrid(x, y))
        {
            float mapHeight = gmap->getHeight(x, y);
            // z + 2.0f condition taken from GetHeight(), not sure if it's such a great choice...
            if (z + 2.0f > mapHeight && mapHeight > check_z)
                return false;
        }

        return true;
    }

    return false;
}

uint32 Map::GetAreaId(uint32 phaseMask, float x, float y, float z) const
{
    uint32 mogpFlags;
    int32 adtId, rootId, groupId;
    float vmapZ = z;
    bool hasVmapArea = GetAreaInfo(phaseMask, x, y, vmapZ, mogpFlags, adtId, rootId, groupId);

    uint32 gridAreaId    = 0;
    float  gridMapHeight = INVALID_HEIGHT;
    if (GridMap* gmap = const_cast<Map*>(this)->GetGrid(x, y))
    {
        gridAreaId    = gmap->getArea(x, y);
        gridMapHeight = gmap->getHeight(x, y);
    }

    uint16 areaId = 0;

    // floor is the height we are closer to (but only if above)
    if (hasVmapArea && G3D::fuzzyGe(z, vmapZ - GROUND_HEIGHT_TOLERANCE) && (G3D::fuzzyLt(z, gridMapHeight - GROUND_HEIGHT_TOLERANCE) || vmapZ > gridMapHeight))
    {
        // wmo found
        if (WMOAreaTableEntry const* wmoEntry = GetWMOAreaTableEntryByTripple(rootId, adtId, groupId))
            areaId = wmoEntry->areaId;

        if (!areaId)
            areaId = gridAreaId;
    }
    else
        areaId = gridAreaId;

    if (!areaId)
        areaId = i_mapEntry->linked_zone;

    return areaId;
}

uint32 Map::GetZoneId(uint32 phaseMask, float x, float y, float z) const
{
    uint32 areaId = GetAreaId(phaseMask, x, y, z);
    if (AreaTableEntry const* area = sAreaTableStore.LookupEntry(areaId))
        if (area->zone)
            return area->zone;

    return areaId;
}

void Map::GetZoneAndAreaId(uint32 phaseMask, uint32& zoneid, uint32& areaid, float x, float y, float z) const
{
    areaid = zoneid = GetAreaId(phaseMask, x, y, z);
    if (AreaTableEntry const* area = sAreaTableStore.LookupEntry(areaid))
        if (area->zone)
            zoneid = area->zone;
}

LiquidData const Map::GetLiquidData(uint32 phaseMask, float x, float y, float z, float collisionHeight, uint8 ReqLiquidType)
{
   LiquidData liquidData;

    VMAP::IVMapMgr* vmgr = VMAP::VMapFactory::createOrGetVMapMgr();
    float liquid_level = INVALID_HEIGHT;
    float ground_level = INVALID_HEIGHT;
    uint32 liquid_type = 0;
    uint32 mogpFlags = 0;
    bool useGridLiquid = true;
    if (vmgr->GetLiquidLevel(GetId(), x, y, z, ReqLiquidType, liquid_level, ground_level, liquid_type, mogpFlags))
    {
        useGridLiquid = !IsInWMOInterior(mogpFlags);
        LOG_DEBUG("maps", "GetLiquidStatus(): vmap liquid level: {} ground: {} type: {}", liquid_level, ground_level, liquid_type);
        // Check water level and ground level
        if (liquid_level > ground_level && G3D::fuzzyGe(z, ground_level - GROUND_HEIGHT_TOLERANCE))
        {
            // hardcoded in client like this
            if (GetId() == 530 && liquid_type == 2)
                liquid_type = 15;

            uint32 liquidFlagType = 0;
            if (LiquidTypeEntry const* liq = sLiquidTypeStore.LookupEntry(liquid_type))
                liquidFlagType = liq->Type;

            if (liquid_type && liquid_type < 21)
            {
                if (AreaTableEntry const* area = sAreaTableStore.LookupEntry(GetAreaId(phaseMask, x, y, z)))
                {
                    uint32 overrideLiquid = area->LiquidTypeOverride[liquidFlagType];
                    if (!overrideLiquid && area->zone)
                    {
                        area = sAreaTableStore.LookupEntry(area->zone);
                        if (area)
                            overrideLiquid = area->LiquidTypeOverride[liquidFlagType];
                    }

                    if (LiquidTypeEntry const* liq = sLiquidTypeStore.LookupEntry(overrideLiquid))
                    {
                        liquid_type = overrideLiquid;
                        liquidFlagType = liq->Type;
                    }
                }
            }

            liquidData.Level = liquid_level;
            liquidData.DepthLevel = ground_level;
            liquidData.Entry = liquid_type;
            liquidData.Flags = 1 << liquidFlagType;
        }

        float delta = liquid_level - z;

        // Get position delta
        if (delta > collisionHeight)
            liquidData.Status = LIQUID_MAP_UNDER_WATER;
        else if (delta > 0.0f)
            liquidData.Status = LIQUID_MAP_IN_WATER;
        else if (delta > -0.1f)
            liquidData.Status = LIQUID_MAP_WATER_WALK;
        else
            liquidData.Status = LIQUID_MAP_ABOVE_WATER;
    }

    if (useGridLiquid)
    {
        if (GridMap* gmap = const_cast<Map*>(this)->GetGrid(x, y))
        {
            LiquidData const& map_data = gmap->GetLiquidData(x, y, z, collisionHeight, ReqLiquidType);
            // Not override LIQUID_MAP_ABOVE_WATER with LIQUID_MAP_NO_WATER:
            if (map_data.Status != LIQUID_MAP_NO_WATER && (map_data.Level > ground_level))
            {
                // hardcoded in client like this
                uint32 liquidEntry = map_data.Entry;
                if (GetId() == 530 && liquidEntry == 2)
                    liquidEntry = 15;

                liquidData = map_data;
                liquidData.Entry = liquidEntry;
            }
        }
    }

   return liquidData;
}

void Map::GetFullTerrainStatusForPosition(uint32 /*phaseMask*/, float x, float y, float z, float collisionHeight, PositionFullTerrainStatus& data, uint8 reqLiquidType)
{
    GridMap* gmap = GetGrid(x, y);

    VMAP::IVMapMgr* vmgr = VMAP::VMapFactory::createOrGetVMapMgr();
    VMAP::AreaAndLiquidData vmapData;
    // VMAP::AreaAndLiquidData dynData;
    VMAP::AreaAndLiquidData* wmoData = nullptr;
    vmgr->GetAreaAndLiquidData(GetId(), x, y, z, reqLiquidType, vmapData);
    // _dynamicTree.GetAreaAndLiquidData(x, y, z, phaseMask, reqLiquidType, dynData);

    uint32 gridAreaId = 0;
    float gridMapHeight = INVALID_HEIGHT;
    if (gmap)
    {
        gridAreaId = gmap->getArea(x, y);
        gridMapHeight = gmap->getHeight(x, y);
    }

    bool useGridLiquid = true;

    // floor is the height we are closer to (but only if above)
    data.floorZ = VMAP_INVALID_HEIGHT;
    if (gridMapHeight > INVALID_HEIGHT && G3D::fuzzyGe(z, gridMapHeight - GROUND_HEIGHT_TOLERANCE))
        data.floorZ = gridMapHeight;

    if (vmapData.floorZ > VMAP_INVALID_HEIGHT && G3D::fuzzyGe(z, vmapData.floorZ - GROUND_HEIGHT_TOLERANCE) &&
        (G3D::fuzzyLt(z, gridMapHeight - GROUND_HEIGHT_TOLERANCE) || vmapData.floorZ > gridMapHeight))
    {
        data.floorZ = vmapData.floorZ;
        wmoData = &vmapData;
    }

    // NOTE: Objects will not detect a case when a wmo providing area/liquid despawns from under them
    // but this is fine as these kind of objects are not meant to be spawned and despawned a lot
    // example: Lich King platform
    /*
    if (dynData.floorZ > VMAP_INVALID_HEIGHT && G3D::fuzzyGe(z, dynData.floorZ - GROUND_HEIGHT_TOLERANCE) &&
        (G3D::fuzzyLt(z, gridMapHeight - GROUND_HEIGHT_TOLERANCE) || dynData.floorZ > gridMapHeight) &&
        (G3D::fuzzyLt(z, vmapData.floorZ - GROUND_HEIGHT_TOLERANCE) || dynData.floorZ > vmapData.floorZ))
    {
        data.floorZ = dynData.floorZ;
        wmoData = &dynData;
    }
    */

    if (wmoData)
    {
        if (wmoData->areaInfo)
        {
            // wmo found
            WMOAreaTableEntry const* wmoEntry = GetWMOAreaTableEntryByTripple(wmoData->areaInfo->rootId, wmoData->areaInfo->adtId, wmoData->areaInfo->groupId);
            data.outdoors = (wmoData->areaInfo->mogpFlags & 0x8) != 0;
            if (wmoEntry)
            {
                data.areaId = wmoEntry->areaId;
                if (wmoEntry->Flags & 4)
                    data.outdoors = true;
                else if (wmoEntry->Flags & 2)
                    data.outdoors = false;
            }

            if (!data.areaId)
                data.areaId = gridAreaId;

            useGridLiquid = !IsInWMOInterior(wmoData->areaInfo->mogpFlags);
        }
    }
    else
    {
        data.outdoors = true;
        data.areaId = gridAreaId;
        if (AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(data.areaId))
            data.outdoors = (areaEntry->flags & (AREA_FLAG_INSIDE | AREA_FLAG_OUTSIDE)) != AREA_FLAG_INSIDE;
    }

    if (!data.areaId)
        data.areaId = i_mapEntry->linked_zone;

    AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(data.areaId);

    // liquid processing
    if (wmoData && wmoData->liquidInfo && wmoData->liquidInfo->level > wmoData->floorZ)
    {
        uint32 liquidType = wmoData->liquidInfo->type;
        if (GetId() == 530 && liquidType == 2) // gotta love blizzard hacks
            liquidType = 15;

        uint32 liquidFlagType = 0;
        if (LiquidTypeEntry const* liquidData = sLiquidTypeStore.LookupEntry(liquidType))
            liquidFlagType = liquidData->Type;

        if (liquidType && liquidType < 21 && areaEntry)
        {
            uint32 overrideLiquid = areaEntry->LiquidTypeOverride[liquidFlagType];
            if (!overrideLiquid && areaEntry->zone)
            {
                AreaTableEntry const* zoneEntry = sAreaTableStore.LookupEntry(areaEntry->zone);
                if (zoneEntry)
                    overrideLiquid = zoneEntry->LiquidTypeOverride[liquidFlagType];
            }

            if (LiquidTypeEntry const* overrideData = sLiquidTypeStore.LookupEntry(overrideLiquid))
            {
                liquidType = overrideLiquid;
                liquidFlagType = overrideData->Type;
            }
        }

        data.liquidInfo.Level = wmoData->liquidInfo->level;
        data.liquidInfo.DepthLevel = wmoData->floorZ;
        data.liquidInfo.Entry = liquidType;
        data.liquidInfo.Flags = 1 << liquidFlagType;

        // Get position delta
        float delta = wmoData->liquidInfo->level - z;

        if (delta > collisionHeight)
            data.liquidInfo.Status = LIQUID_MAP_UNDER_WATER;
        else if (delta > 0.0f)
            data.liquidInfo.Status = LIQUID_MAP_IN_WATER;
        else if (delta > -0.1f)
            data.liquidInfo.Status = LIQUID_MAP_WATER_WALK;
        else
            data.liquidInfo.Status = LIQUID_MAP_ABOVE_WATER;
    }

    // look up liquid data from grid map
    if (gmap && useGridLiquid)
    {
        LiquidData const& gridLiquidData = gmap->GetLiquidData(x, y, z, collisionHeight, reqLiquidType);
        if (gridLiquidData.Status != LIQUID_MAP_NO_WATER && (!wmoData || gridLiquidData.Level > wmoData->floorZ))
        {
            uint32 liquidEntry = gridLiquidData.Entry;
            if (GetId() == 530 && liquidEntry == 2)
                liquidEntry = 15;

            data.liquidInfo = gridLiquidData;
            data.liquidInfo.Entry = liquidEntry;
        }
    }
}

float Map::GetWaterLevel(float x, float y) const
{
    if (GridMap* gmap = const_cast<Map*>(this)->GetGrid(x, y))
        return gmap->getLiquidLevel(x, y);
    else
        return 0;
}

bool Map::isInLineOfSight(float x1, float y1, float z1, float x2, float y2, float z2, uint32 phasemask, LineOfSightChecks checks, VMAP::ModelIgnoreFlags ignoreFlags) const
{
    if (!sWorld->getBoolConfig(CONFIG_VMAP_BLIZZLIKE_PVP_LOS))
    {
        if (IsBattlegroundOrArena())
        {
            ignoreFlags = VMAP::ModelIgnoreFlags::Nothing;
        }
    }

    if (!sWorld->getBoolConfig(CONFIG_VMAP_BLIZZLIKE_LOS_OPEN_WORLD))
    {
        if (IsWorldMap())
        {
            ignoreFlags = VMAP::ModelIgnoreFlags::Nothing;
        }
    }

    if ((checks & LINEOFSIGHT_CHECK_VMAP) && !VMAP::VMapFactory::createOrGetVMapMgr()->isInLineOfSight(GetId(), x1, y1, z1, x2, y2, z2, ignoreFlags))
    {
        return false;
    }

    if (sWorld->getBoolConfig(CONFIG_CHECK_GOBJECT_LOS) && (checks & LINEOFSIGHT_CHECK_GOBJECT_ALL))
    {
        ignoreFlags = VMAP::ModelIgnoreFlags::Nothing;
        if (!(checks & LINEOFSIGHT_CHECK_GOBJECT_M2))
        {
            ignoreFlags = VMAP::ModelIgnoreFlags::M2;
        }

        if (!_dynamicTree.isInLineOfSight(x1, y1, z1, x2, y2, z2, phasemask, ignoreFlags))
        {
            return false;
        }
    }

    return true;
}

bool Map::GetObjectHitPos(uint32 phasemask, float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float& ry, float& rz, float modifyDist)
{
    G3D::Vector3 startPos(x1, y1, z1);
    G3D::Vector3 dstPos(x2, y2, z2);

    G3D::Vector3 resultPos;
    bool result = _dynamicTree.GetObjectHitPos(phasemask, startPos, dstPos, resultPos, modifyDist);

    rx = resultPos.x;
    ry = resultPos.y;
    rz = resultPos.z;
    return result;
}

float Map::GetHeight(uint32 phasemask, float x, float y, float z, bool vmap/*=true*/, float maxSearchDist /*= DEFAULT_HEIGHT_SEARCH*/) const
{
    float h1, h2;
    h1 = GetHeight(x, y, z, vmap, maxSearchDist);
    h2 = _dynamicTree.getHeight(x, y, z, maxSearchDist, phasemask);
    return std::max<float>(h1, h2);
}

bool Map::IsInWater(uint32 phaseMask, float x, float y, float pZ, float collisionHeight) const
{
    LiquidData const& liquidData = const_cast<Map*>(this)->GetLiquidData(phaseMask, x, y, pZ, collisionHeight, MAP_ALL_LIQUIDS);
    return (liquidData.Status & MAP_LIQUID_STATUS_SWIMMING) != 0;
}

bool Map::IsUnderWater(uint32 phaseMask, float x, float y, float z, float collisionHeight) const
{
    LiquidData const& liquidData = const_cast<Map*>(this)->GetLiquidData(phaseMask, x, y, z, collisionHeight, MAP_LIQUID_TYPE_WATER | MAP_LIQUID_TYPE_OCEAN);
    return liquidData.Status == LIQUID_MAP_UNDER_WATER;
}

bool Map::HasEnoughWater(WorldObject const* searcher, float x, float y, float z) const
{
    LiquidData const& liquidData = const_cast<Map*>(this)->GetLiquidData(searcher->GetPhaseMask(), x, y, z, searcher->GetCollisionHeight(), MAP_ALL_LIQUIDS);
    return (liquidData.Status & MAP_LIQUID_STATUS_SWIMMING) != 0 && HasEnoughWater(searcher, liquidData);
}

bool Map::HasEnoughWater(WorldObject const* searcher, LiquidData const& liquidData) const
{
    float minHeightInWater = searcher->GetMinHeightInWater();
    return liquidData.Level > INVALID_HEIGHT && liquidData.Level > liquidData.DepthLevel && liquidData.Level - liquidData.DepthLevel >= minHeightInWater;
}

char const* Map::GetMapName() const
{
    return i_mapEntry ? i_mapEntry->name[sWorld->GetDefaultDbcLocale()] : "UNNAMEDMAP\x0";
}

void Map::SendInitSelf(Player* player)
{
    LOG_DEBUG("maps", "Creating player data for himself {}", player->GetGUID().ToString());

    WorldPacket packet;
    UpdateData data;

    // attach to player data current transport data
    if (Transport* transport = player->GetTransport())
        transport->BuildCreateUpdateBlockForPlayer(&data, player);

    // build data for self presence in world at own client (one time for map)
    player->BuildCreateUpdateBlockForPlayer(&data, player);

    // build and send self update packet before sending to player his own auras
    data.BuildPacket(packet);
    player->SendDirectMessage(&packet);

    // send to player his own auras (this is needed here for timely initialization of some fields on client)
    player->GetAurasForTarget(player, true);

    // clean buffers for further work
    packet.clear();
    data.Clear();

    // build other passengers at transport also (they always visible and marked as visible and will not send at visibility update at add to map
    if (Transport* transport = player->GetTransport())
        for (Transport::PassengerSet::const_iterator itr = transport->GetPassengers().begin(); itr != transport->GetPassengers().end(); ++itr)
            if (player != (*itr) && player->HaveAtClient(*itr))
                (*itr)->BuildCreateUpdateBlockForPlayer(&data, player);

    data.BuildPacket(packet);
    player->SendDirectMessage(&packet);
}

void Map::SendInitTransports(Player* player)
{
    // Hack to send out transports
    UpdateData transData;
    for (TransportsContainer::const_iterator itr = _transports.begin(); itr != _transports.end(); ++itr)
        if (*itr != player->GetTransport())
            (*itr)->BuildCreateUpdateBlockForPlayer(&transData, player);

    WorldPacket packet;
    transData.BuildPacket(packet);
    player->GetSession()->SendPacket(&packet);
}

void Map::SendRemoveTransports(Player* player)
{
    // Hack to send out transports
    UpdateData transData;
    for (TransportsContainer::const_iterator itr = _transports.begin(); itr != _transports.end(); ++itr)
        if (*itr != player->GetTransport())
            (*itr)->BuildOutOfRangeUpdateBlock(&transData);

    // pussywizard: remove static transports from client
    for (GuidUnorderedSet::const_iterator it = player->m_clientGUIDs.begin(); it != player->m_clientGUIDs.end(); )
    {
        if ((*it).IsTransport())
        {
            transData.AddOutOfRangeGUID(*it);
            it = player->m_clientGUIDs.erase(it);
        }
        else
            ++it;
    }

    WorldPacket packet;
    transData.BuildPacket(packet);
    player->GetSession()->SendPacket(&packet);
}

inline void Map::setNGrid(NGridType* grid, uint32 x, uint32 y)
{
    if (x >= MAX_NUMBER_OF_GRIDS || y >= MAX_NUMBER_OF_GRIDS)
    {
        LOG_ERROR("maps", "map::setNGrid() Invalid grid coordinates found: {}, {}!", x, y);
        ABORT();
    }
    i_grids[x][y] = grid;
}

void Map::SendObjectUpdates()
{
    UpdateDataMapType update_players;
    UpdatePlayerSet player_set;

    while (!_updateObjects.empty())
    {
        Object* obj = *_updateObjects.begin();
        ASSERT(obj->IsInWorld());

        _updateObjects.erase(_updateObjects.begin());
        obj->BuildUpdate(update_players, player_set);
    }

    WorldPacket packet;                                     // here we allocate a std::vector with a size of 0x10000
    for (UpdateDataMapType::iterator iter = update_players.begin(); iter != update_players.end(); ++iter)
    {
        iter->second.BuildPacket(packet);
        iter->first->GetSession()->SendPacket(&packet);
        packet.clear();                                     // clean the string
    }
}

void Map::DelayedUpdate(const uint32 t_diff)
{
    for (_transportsUpdateIter = _transports.begin(); _transportsUpdateIter != _transports.end();)
    {
        MotionTransport* transport = *_transportsUpdateIter;
        ++_transportsUpdateIter;

        if (!transport->IsInWorld())
            continue;

        transport->DelayedUpdate(t_diff);
    }

    RemoveAllObjectsInRemoveList();
}

void Map::AddObjectToRemoveList(WorldObject* obj)
{
    ASSERT(obj->GetMapId() == GetId() && obj->GetInstanceId() == GetInstanceId());

    obj->CleanupsBeforeDelete(false);                            // remove or simplify at least cross referenced links

    i_objectsToRemove.insert(obj);
    //LOG_DEBUG("maps", "Object ({}) added to removing list.", obj->GetGUID().ToString());
}

void Map::AddObjectToSwitchList(WorldObject* obj, bool on)
{
    ASSERT(obj->GetMapId() == GetId() && obj->GetInstanceId() == GetInstanceId());
    // i_objectsToSwitch is iterated only in Map::RemoveAllObjectsInRemoveList() and it uses
    // the contained objects only if GetTypeId() == TYPEID_UNIT , so we can return in all other cases
    if (obj->GetTypeId() != TYPEID_UNIT && obj->GetTypeId() != TYPEID_GAMEOBJECT)
        return;

    std::map<WorldObject*, bool>::iterator itr = i_objectsToSwitch.find(obj);
    if (itr == i_objectsToSwitch.end())
        i_objectsToSwitch.insert(itr, std::make_pair(obj, on));
    else if (itr->second != on)
        i_objectsToSwitch.erase(itr);
    else
        ABORT();
}

void Map::RemoveAllObjectsInRemoveList()
{
    while (!i_objectsToSwitch.empty())
    {
        std::map<WorldObject*, bool>::iterator itr = i_objectsToSwitch.begin();
        WorldObject* obj = itr->first;
        bool on = itr->second;
        i_objectsToSwitch.erase(itr);

        if (!obj->IsPermanentWorldObject())
        {
            switch (obj->GetTypeId())
            {
                case TYPEID_UNIT:
                    SwitchGridContainers<Creature>(obj->ToCreature(), on);
                    break;
                case TYPEID_GAMEOBJECT:
                    SwitchGridContainers<GameObject>(obj->ToGameObject(), on);
                    break;
                default:
                    break;
            }
        }
    }

    //LOG_DEBUG("maps", "Object remover 1 check.");
    while (!i_objectsToRemove.empty())
    {
        std::unordered_set<WorldObject*>::iterator itr = i_objectsToRemove.begin();
        WorldObject* obj = *itr;
        i_objectsToRemove.erase(itr);

        switch (obj->GetTypeId())
        {
            case TYPEID_CORPSE:
                {
                    Corpse* corpse = ObjectAccessor::GetCorpse(*obj, obj->GetGUID());
                    if (!corpse)
                        LOG_ERROR("maps", "Tried to delete corpse/bones {} that is not in map.", obj->GetGUID().ToString());
                    else
                        RemoveFromMap(corpse, true);
                    break;
                }
            case TYPEID_DYNAMICOBJECT:
                RemoveFromMap((DynamicObject*)obj, true);
                break;
            case TYPEID_GAMEOBJECT:
                if (MotionTransport* transport = obj->ToGameObject()->ToMotionTransport())
                    RemoveFromMap(transport, true);
                else
                    RemoveFromMap(obj->ToGameObject(), true);
                break;
            case TYPEID_UNIT:
                // in case triggered sequence some spell can continue casting after prev CleanupsBeforeDelete call
                // make sure that like sources auras/etc removed before destructor start
                obj->ToCreature()->CleanupsBeforeDelete();
                RemoveFromMap(obj->ToCreature(), true);
                break;
            default:
                LOG_ERROR("maps", "Non-grid object (TypeId: {}) is in grid object remove list, ignored.", obj->GetTypeId());
                break;
        }
    }

    //LOG_DEBUG("maps", "Object remover 2 check.");
}

uint32 Map::GetPlayersCountExceptGMs() const
{
    uint32 count = 0;
    for (MapRefMgr::const_iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
        if (!itr->GetSource()->IsGameMaster())
            ++count;
    return count;
}

void Map::SendToPlayers(WorldPacket const* data) const
{
    for (MapRefMgr::const_iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
        itr->GetSource()->GetSession()->SendPacket(data);
}

template<class T>
void Map::AddToActive(T* obj)
{
    AddToActiveHelper(obj);
}

template <>
void Map::AddToActive(Creature* c)
{
    AddToActiveHelper(c);
}

template<>
void Map::AddToActive(DynamicObject* d)
{
    AddToActiveHelper(d);
}

template<>
void Map::AddToActive(GameObject* d)
{
    AddToActiveHelper(d);
}

template<class T>
void Map::RemoveFromActive(T* obj)
{
    RemoveFromActiveHelper(obj);
}

template <>
void Map::RemoveFromActive(Creature* c)
{
    RemoveFromActiveHelper(c);
}

template<>
void Map::RemoveFromActive(DynamicObject* obj)
{
    RemoveFromActiveHelper(obj);
}

template<>
void Map::RemoveFromActive(GameObject* obj)
{
    RemoveFromActiveHelper(obj);
}

template bool Map::AddToMap(Corpse*, bool);
template bool Map::AddToMap(Creature*, bool);
template bool Map::AddToMap(GameObject*, bool);
template bool Map::AddToMap(DynamicObject*, bool);

template void Map::RemoveFromMap(Corpse*, bool);
template void Map::RemoveFromMap(Creature*, bool);
template void Map::RemoveFromMap(GameObject*, bool);
template void Map::RemoveFromMap(DynamicObject*, bool);

/* ******* Dungeon Instance Maps ******* */

InstanceMap::InstanceMap(uint32 id, uint32 InstanceId, uint8 SpawnMode, Map* _parent)
    : Map(id, InstanceId, SpawnMode, _parent),
      m_resetAfterUnload(false), m_unloadWhenEmpty(false),
      instance_data(nullptr), i_script_id(0)
{
    //lets initialize visibility distance for dungeons
    InstanceMap::InitVisibilityDistance();

    // the timer is started by default, and stopped when the first player joins
    // this make sure it gets unloaded if for some reason no player joins
    m_unloadTimer = std::max(sWorld->getIntConfig(CONFIG_INSTANCE_UNLOAD_DELAY), (uint32)MIN_UNLOAD_DELAY);

    // pussywizard:
    if (IsRaid())
        if (time_t resetTime = sInstanceSaveMgr->GetResetTimeFor(id, Difficulty(SpawnMode)))
            if (time_t extendedResetTime = sInstanceSaveMgr->GetExtendedResetTimeFor(id, Difficulty(SpawnMode)))
                _instanceResetPeriod = extendedResetTime - resetTime;
}

InstanceMap::~InstanceMap()
{
    delete instance_data;
    instance_data = nullptr;
    sInstanceSaveMgr->DeleteInstanceSaveIfNeeded(GetInstanceId(), true);
}

void InstanceMap::InitVisibilityDistance()
{
    //init visibility distance for instances
    m_VisibleDistance = World::GetMaxVisibleDistanceInInstances();

    // pussywizard: this CAN NOT exceed MAX_VISIBILITY_DISTANCE
    switch (GetId())
    {
        case 429: // Dire Maul
        case 550: // The Eye
        case 578: // The Nexus: The Oculus
            m_VisibleDistance = 175.0f;
            break;
        case 649: // Trial of the Crusader
        case 650: // Trial of the Champion
        case 595: // Culling of Startholme
        case 658: // Pit of Saron
            m_VisibleDistance = 150.0f;
            break;
        case 615: // Obsidian Sanctum
        case 616: // Eye of Eternity
        case 603: // Ulduar
        case 668: // Halls of Reflection
        case 631: // Icecrown Citadel
        case 724: // Ruby Sanctum
            m_VisibleDistance = 200.0f;
            break;
        case 531: // Ahn'Qiraj Temple
            m_VisibleDistance = 300.0f;
            break;
    }
}

/*
    Do map specific checks to see if the player can enter
*/
Map::EnterState InstanceMap::CannotEnter(Player* player, bool loginCheck)
{
    if (!loginCheck && player->GetMapRef().getTarget() == this)
    {
        LOG_ERROR("maps", "InstanceMap::CanEnter - player {} ({}) already in map {}, {}, {}!",
            player->GetName(), player->GetGUID().ToString(), GetId(), GetInstanceId(), GetSpawnMode());

        return CANNOT_ENTER_ALREADY_IN_MAP;
    }

    // allow GM's to enter
    if (player->IsGameMaster())
        return Map::CannotEnter(player, loginCheck);

    // cannot enter if the instance is full (player cap), GMs don't count
    uint32 maxPlayers = GetMaxPlayers();
    if (GetPlayersCountExceptGMs() >= (loginCheck ? maxPlayers + 1 : maxPlayers))
    {
        LOG_DEBUG("maps", "MAP: Instance '{}' of map '{}' cannot have more than '{}' players. Player '{}' rejected", GetInstanceId(), GetMapName(), maxPlayers, player->GetName());
        player->SendTransferAborted(GetId(), TRANSFER_ABORT_MAX_PLAYERS);
        return CANNOT_ENTER_MAX_PLAYERS;
    }

    // cannot enter while an encounter is in progress on raids
    bool checkProgress = (IsRaid() || GetId() == 668 /*HoR*/);
    if (checkProgress && GetInstanceScript() && GetInstanceScript()->IsEncounterInProgress())
    {
        player->SendTransferAborted(GetId(), TRANSFER_ABORT_ZONE_IN_COMBAT);
        return CANNOT_ENTER_ZONE_IN_COMBAT;
    }

    // xinef: dont allow LFG Group to enter other instance that is selected
    if (Group* group = player->GetGroup())
        if (group->isLFGGroup())
            if (!sLFGMgr->inLfgDungeonMap(group->GetGUID(), GetId(), GetDifficulty()))
            {
                player->SendTransferAborted(GetId(), TRANSFER_ABORT_MAP_NOT_ALLOWED);
                return CANNOT_ENTER_UNSPECIFIED_REASON;
            }

    // cannot enter if instance is in use by another party/soloer that have a permanent save in the same instance id
    PlayerList const& playerList = GetPlayers();
    if (!playerList.IsEmpty())
        for (PlayerList::const_iterator i = playerList.begin(); i != playerList.end(); ++i)
            if (Player* iPlayer = i->GetSource())
            {
                if (iPlayer == player) // login case, player already added to map
                    continue;
                if (iPlayer->IsGameMaster()) // bypass GMs
                    continue;
                if (!player->GetGroup()) // player has not group and there is someone inside, deny entry
                {
                    player->SendTransferAborted(GetId(), TRANSFER_ABORT_MAX_PLAYERS);
                    return CANNOT_ENTER_INSTANCE_BIND_MISMATCH;
                }
                // player inside instance has no group or his groups is different to entering player's one, deny entry
                if (!iPlayer->GetGroup() || iPlayer->GetGroup() != player->GetGroup())
                {
                    player->SendTransferAborted(GetId(), TRANSFER_ABORT_MAX_PLAYERS);
                    return CANNOT_ENTER_INSTANCE_BIND_MISMATCH;
                }
                break;
            }

    return Map::CannotEnter(player, loginCheck);
}

/*
    Do map specific checks and add the player to the map if successful.
*/
bool InstanceMap::AddPlayerToMap(Player* player)
{
    if (m_resetAfterUnload) // this instance has been reset, it's not meant to be used anymore
        return false;

    if (IsDungeon())
    {
        Group* group = player->GetGroup();

        // get an instance save for the map
        InstanceSave* mapSave = sInstanceSaveMgr->GetInstanceSave(GetInstanceId());
        if (!mapSave)
        {
            LOG_ERROR("maps", "InstanceMap::Add: InstanceSave does not exist for map {} spawnmode {} with instance id {}", GetId(), GetSpawnMode(), GetInstanceId());
            return false;
        }

        // check for existing instance binds
        InstancePlayerBind* playerBind = sInstanceSaveMgr->PlayerGetBoundInstance(player->GetGUID(), GetId(), Difficulty(GetSpawnMode()));
        if (playerBind && playerBind->perm)
        {
            if (playerBind->save != mapSave)
            {
                LOG_ERROR("maps", "InstanceMap::Add: player {} ({}) is permanently bound to instance {}, {}, {}, {} but he is being put into instance {}, {}, {}, {}",
                    player->GetName(), player->GetGUID().ToString(), playerBind->save->GetMapId(), playerBind->save->GetInstanceId(), playerBind->save->GetDifficulty(),
                    playerBind->save->CanReset(), mapSave->GetMapId(), mapSave->GetInstanceId(), mapSave->GetDifficulty(), mapSave->CanReset());
                return false;
            }
        }
        else if (player->GetSession()->PlayerLoading() && playerBind && playerBind->save != mapSave)
        {
            // Prevent "Convert to Raid" exploit to reset instances
            return false;
        }
        else
        {
            playerBind = sInstanceSaveMgr->PlayerBindToInstance(player->GetGUID(), mapSave, false, player);
            // pussywizard: bind lider also if not yet bound
            if (Group* g = player->GetGroup())
                if (g->GetLeaderGUID() != player->GetGUID())
                    if (!sInstanceSaveMgr->PlayerGetBoundInstance(g->GetLeaderGUID(), mapSave->GetMapId(), mapSave->GetDifficulty()))
                    {
                        sInstanceSaveMgr->PlayerCreateBoundInstancesMaps(g->GetLeaderGUID());
                        sInstanceSaveMgr->PlayerBindToInstance(g->GetLeaderGUID(), mapSave, false, ObjectAccessor::FindConnectedPlayer(g->GetLeaderGUID()));
                    }
        }

        // increase current instances (hourly limit)
        // xinef: specific instances are still limited
        if (!group || !group->isLFGGroup() || !group->IsLfgRandomInstance())
            player->AddInstanceEnterTime(GetInstanceId(), GameTime::GetGameTime().count());

        if (!playerBind->perm && !mapSave->CanReset() && group && !group->isLFGGroup() && !group->IsLfgRandomInstance())
        {
            WorldPacket data(SMSG_INSTANCE_LOCK_WARNING_QUERY, 9);
            data << uint32(60000);
            data << uint32(instance_data ? instance_data->GetCompletedEncounterMask() : 0);
            data << uint8(0);
            player->GetSession()->SendPacket(&data);
            player->SetPendingBind(mapSave->GetInstanceId(), 60000);
        }
    }

    // initialize unload state
    m_unloadTimer = 0;
    m_resetAfterUnload = false;
    m_unloadWhenEmpty = false;

    // this will acquire the same mutex so it cannot be in the previous block
    Map::AddPlayerToMap(player);

    if (instance_data)
        instance_data->OnPlayerEnter(player);

    return true;
}

void InstanceMap::Update(const uint32 t_diff, const uint32 s_diff, bool /*thread*/)
{
    Map::Update(t_diff, s_diff);

    if (t_diff)
        if (instance_data)
            instance_data->Update(t_diff);
}

void InstanceMap::RemovePlayerFromMap(Player* player, bool remove)
{
    // pussywizard: moved m_unloadTimer to InstanceMap::AfterPlayerUnlinkFromMap(), in this function if 2 players run out at the same time the instance won't close
    //if (!m_unloadTimer && m_mapRefMgr.getSize() == 1)
    //    m_unloadTimer = m_unloadWhenEmpty ? MIN_UNLOAD_DELAY : std::max(sWorld->getIntConfig(CONFIG_INSTANCE_UNLOAD_DELAY), (uint32)MIN_UNLOAD_DELAY);
    Map::RemovePlayerFromMap(player, remove);

    // If remove == true - player already deleted.
    if (!remove)
        player->SetPendingBind(0, 0);
}

void InstanceMap::AfterPlayerUnlinkFromMap()
{
    if (!m_unloadTimer && !HavePlayers())
        m_unloadTimer = m_unloadWhenEmpty ? MIN_UNLOAD_DELAY : std::max(sWorld->getIntConfig(CONFIG_INSTANCE_UNLOAD_DELAY), (uint32)MIN_UNLOAD_DELAY);
    Map::AfterPlayerUnlinkFromMap();
}

void InstanceMap::CreateInstanceScript(bool load, std::string data, uint32 completedEncounterMask)
{
    if (instance_data)
    {
        return;
    }

    bool isOtherAI = false;

    sScriptMgr->OnBeforeCreateInstanceScript(this, instance_data, load, data, completedEncounterMask);

    if (instance_data)
        isOtherAI = true;

    // if Eluna AI was fetched succesfully we should not call CreateInstanceData nor set the unused scriptID
    if (!isOtherAI)
    {
        InstanceTemplate const* mInstance = sObjectMgr->GetInstanceTemplate(GetId());
        if (mInstance)
        {
            i_script_id = mInstance->ScriptId;
            instance_data = sScriptMgr->CreateInstanceScript(this);
        }
    }

    if (!instance_data)
        return;

    // use mangos behavior if we are dealing with Eluna AI
    // initialize should then be called only if load is false
    if (!isOtherAI || !load)
    {
        instance_data->Initialize();
    }

    if (load)
    {
        instance_data->SetCompletedEncountersMask(completedEncounterMask, false);
        if (data != "")
            instance_data->Load(data.c_str());
    }

    instance_data->LoadInstanceSavedGameobjectStateData();
}

/*
    Returns true if there are no players in the instance
*/
bool InstanceMap::Reset(uint8 method, GuidList* globalResetSkipList)
{
    if (method == INSTANCE_RESET_GLOBAL)
    {
        // pussywizard: teleport out immediately
        for (MapRefMgr::iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
        {
            // teleport players that are no longer bound (can be still bound if extended id)
            if (!globalResetSkipList || std::find(globalResetSkipList->begin(), globalResetSkipList->end(), itr->GetSource()->GetGUID()) == globalResetSkipList->end())
                itr->GetSource()->RepopAtGraveyard();
        }

        // reset map only if noone is bound
        if (!globalResetSkipList || globalResetSkipList->empty())
        {
            // pussywizard: setting both m_unloadWhenEmpty and m_unloadTimer intended, in case RepopAtGraveyard failed
            if (HavePlayers())
                m_unloadWhenEmpty = true;
            m_unloadTimer = MIN_UNLOAD_DELAY;
            m_resetAfterUnload = true;
        }

        return m_mapRefMgr.IsEmpty();
    }

    if (HavePlayers())
    {
        if (method == INSTANCE_RESET_ALL || method == INSTANCE_RESET_CHANGE_DIFFICULTY)
        {
            for (MapRefMgr::iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
                itr->GetSource()->SendResetFailedNotify(GetId());
        }
    }
    else
    {
        m_unloadTimer = MIN_UNLOAD_DELAY;
        m_resetAfterUnload = true;
    }

    return m_mapRefMgr.IsEmpty();
}

std::string const& InstanceMap::GetScriptName() const
{
    return sObjectMgr->GetScriptName(i_script_id);
}

void InstanceMap::PermBindAllPlayers()
{
    if (!IsDungeon())
        return;

    InstanceSave* save = sInstanceSaveMgr->GetInstanceSave(GetInstanceId());
    if (!save)
    {
        LOG_ERROR("maps", "Cannot bind players because no instance save is available for instance map (Name: {}, Entry: {}, InstanceId: {})!", GetMapName(), GetId(), GetInstanceId());
        return;
    }

    Player* player;
    Group* group;
    // group members outside the instance group don't get bound
    for (MapRefMgr::iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
    {
        player = itr->GetSource();
        group = player->GetGroup();

        // players inside an instance cannot be bound to other instances
        // some players may already be permanently bound, in this case nothing happens
        InstancePlayerBind* bind = sInstanceSaveMgr->PlayerGetBoundInstance(player->GetGUID(), save->GetMapId(), save->GetDifficulty());

        if (!bind || !bind->perm)
        {
            WorldPacket data(SMSG_INSTANCE_SAVE_CREATED, 4);
            data << uint32(0);
            player->GetSession()->SendPacket(&data);
            sInstanceSaveMgr->PlayerBindToInstance(player->GetGUID(), save, true, player);
        }

        // Xinef: Difficulty change prevention
        if (group)
            group->SetDifficultyChangePrevention(DIFFICULTY_PREVENTION_CHANGE_BOSS_KILLED);
    }
}

void InstanceMap::UnloadAll()
{
    ASSERT(!HavePlayers());

    if (m_resetAfterUnload)
    {
        DeleteRespawnTimes();
        DeleteCorpseData();
    }

    Map::UnloadAll();
}

void InstanceMap::SendResetWarnings(uint32 timeLeft) const
{
    for (MapRefMgr::const_iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
        itr->GetSource()->SendInstanceResetWarning(GetId(), itr->GetSource()->GetDifficulty(IsRaid()), timeLeft, false);
}

MapDifficulty const* Map::GetMapDifficulty() const
{
    return GetMapDifficultyData(GetId(), GetDifficulty());
}

uint32 InstanceMap::GetMaxPlayers() const
{
    MapDifficulty const* mapDiff = GetMapDifficulty();
    if (mapDiff && mapDiff->maxPlayers)
        return mapDiff->maxPlayers;

    return GetEntry()->maxPlayers;
}

uint32 InstanceMap::GetMaxResetDelay() const
{
    MapDifficulty const* mapDiff = GetMapDifficulty();
    return mapDiff ? mapDiff->resetTime : 0;
}

/* ******* Battleground Instance Maps ******* */

BattlegroundMap::BattlegroundMap(uint32 id, uint32 InstanceId, Map* _parent, uint8 spawnMode)
    : Map(id, InstanceId, spawnMode, _parent), m_bg(nullptr)
{
    //lets initialize visibility distance for BG/Arenas
    BattlegroundMap::InitVisibilityDistance();
}

BattlegroundMap::~BattlegroundMap()
{
    if (m_bg)
    {
        //unlink to prevent crash, always unlink all pointer reference before destruction
        m_bg->SetBgMap(nullptr);
        m_bg = nullptr;
    }
}

void BattlegroundMap::InitVisibilityDistance()
{
    //init visibility distance for BG/Arenas
    m_VisibleDistance = World::GetMaxVisibleDistanceInBGArenas();

    if (IsBattleArena()) // pussywizard: start with 30yd visibility range on arenas to ensure players can't get informations about the opponents in any way
        m_VisibleDistance = 30.0f;
}

Map::EnterState BattlegroundMap::CannotEnter(Player* player, bool loginCheck)
{
    if (!loginCheck && player->GetMapRef().getTarget() == this)
    {
        LOG_ERROR("maps", "BGMap::CanEnter - player {} is already in map!", player->GetGUID().ToString());
        ABORT();
        return CANNOT_ENTER_ALREADY_IN_MAP;
    }

    if (player->GetBattlegroundId() != GetInstanceId())
        return CANNOT_ENTER_INSTANCE_BIND_MISMATCH;

    // pussywizard: no need to check player limit here, invitations are limited by Battleground::GetFreeSlotsForTeam

    return Map::CannotEnter(player, loginCheck);
}

bool BattlegroundMap::AddPlayerToMap(Player* player)
{
    player->m_InstanceValid = true;
    if (IsBattleArena())
        player->CastSpell(player, 100102, true);
    return Map::AddPlayerToMap(player);
}

void BattlegroundMap::RemovePlayerFromMap(Player* player, bool remove)
{
    if (Battleground* bg = GetBG())
    {
        bg->RemovePlayerAtLeave(player);
        if (IsBattleArena())
            bg->RemoveSpectator(player);
    }
    if (IsBattleArena())
        player->RemoveAura(100102);
    Map::RemovePlayerFromMap(player, remove);
}

void BattlegroundMap::SetUnload()
{
    m_unloadTimer = MIN_UNLOAD_DELAY;
}

void BattlegroundMap::RemoveAllPlayers()
{
    if (HavePlayers())
        for (MapRefMgr::iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (!player->IsBeingTeleportedFar())
                    player->TeleportTo(player->GetEntryPoint());
}

Corpse* Map::GetCorpse(ObjectGuid const guid)
{
    return _objectsStore.Find<Corpse>(guid);
}

Creature* Map::GetCreature(ObjectGuid const guid)
{
    return _objectsStore.Find<Creature>(guid);
}

GameObject* Map::GetGameObject(ObjectGuid const guid)
{
    return _objectsStore.Find<GameObject>(guid);
}

Pet* Map::GetPet(ObjectGuid const guid)
{
    return _objectsStore.Find<Pet>(guid);
}

Transport* Map::GetTransport(ObjectGuid guid)
{
    if (guid.GetHigh() != HighGuid::Mo_Transport && guid.GetHigh() != HighGuid::Transport)
        return nullptr;

    GameObject* go = GetGameObject(guid);
    return go ? go->ToTransport() : nullptr;
}

DynamicObject* Map::GetDynamicObject(ObjectGuid guid)
{
    return _objectsStore.Find<DynamicObject>(guid);
}

void Map::UpdateIteratorBack(Player* player)
{
    if (m_mapRefIter == player->GetMapRef())
        m_mapRefIter = m_mapRefIter->nocheck_prev();
}

void Map::SaveCreatureRespawnTime(ObjectGuid::LowType spawnId, time_t& respawnTime)
{
    if (!respawnTime)
    {
        // Delete only
        RemoveCreatureRespawnTime(spawnId);
        return;
    }

    time_t now = GameTime::GetGameTime().count();
    if (GetInstanceResetPeriod() > 0 && respawnTime - now + 5 >= GetInstanceResetPeriod())
        respawnTime = now + YEAR;

    _creatureRespawnTimes[spawnId] = respawnTime;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CREATURE_RESPAWN);
    stmt->SetData(0, spawnId);
    stmt->SetData(1, uint32(respawnTime));
    stmt->SetData(2, GetId());
    stmt->SetData(3, GetInstanceId());
    CharacterDatabase.Execute(stmt);
}

void Map::RemoveCreatureRespawnTime(ObjectGuid::LowType spawnId)
{
    _creatureRespawnTimes.erase(spawnId);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CREATURE_RESPAWN);
    stmt->SetData(0, spawnId);
    stmt->SetData(1, GetId());
    stmt->SetData(2, GetInstanceId());
    CharacterDatabase.Execute(stmt);
}

void Map::SaveGORespawnTime(ObjectGuid::LowType spawnId, time_t& respawnTime)
{
    if (!respawnTime)
    {
        // Delete only
        RemoveGORespawnTime(spawnId);
        return;
    }

    time_t now = GameTime::GetGameTime().count();
    if (GetInstanceResetPeriod() > 0 && respawnTime - now + 5 >= GetInstanceResetPeriod())
        respawnTime = now + YEAR;

    _goRespawnTimes[spawnId] = respawnTime;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_GO_RESPAWN);
    stmt->SetData(0, spawnId);
    stmt->SetData(1, uint32(respawnTime));
    stmt->SetData(2, GetId());
    stmt->SetData(3, GetInstanceId());
    CharacterDatabase.Execute(stmt);
}

void Map::RemoveGORespawnTime(ObjectGuid::LowType spawnId)
{
    _goRespawnTimes.erase(spawnId);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GO_RESPAWN);
    stmt->SetData(0, spawnId);
    stmt->SetData(1, GetId());
    stmt->SetData(2, GetInstanceId());
    CharacterDatabase.Execute(stmt);
}

void Map::LoadRespawnTimes()
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CREATURE_RESPAWNS);
    stmt->SetData(0, GetId());
    stmt->SetData(1, GetInstanceId());
    if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
    {
        do
        {
            Field* fields = result->Fetch();
            ObjectGuid::LowType lowguid = fields[0].Get<uint32>();
            uint32 respawnTime = fields[1].Get<uint32>();

            _creatureRespawnTimes[lowguid] = time_t(respawnTime);
        } while (result->NextRow());
    }

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GO_RESPAWNS);
    stmt->SetData(0, GetId());
    stmt->SetData(1, GetInstanceId());
    if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
    {
        do
        {
            Field* fields = result->Fetch();
            ObjectGuid::LowType lowguid = fields[0].Get<uint32>();
            uint32 respawnTime = fields[1].Get<uint32>();

            _goRespawnTimes[lowguid] = time_t(respawnTime);
        } while (result->NextRow());
    }
}

void Map::DeleteRespawnTimes()
{
    _creatureRespawnTimes.clear();
    _goRespawnTimes.clear();

    DeleteRespawnTimesInDB(GetId(), GetInstanceId());
}

void Map::DeleteRespawnTimesInDB(uint16 mapId, uint32 instanceId)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CREATURE_RESPAWN_BY_INSTANCE);
    stmt->SetData(0, mapId);
    stmt->SetData(1, instanceId);
    CharacterDatabase.Execute(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GO_RESPAWN_BY_INSTANCE);
    stmt->SetData(0, mapId);
    stmt->SetData(1, instanceId);
    CharacterDatabase.Execute(stmt);
}

void Map::UpdateEncounterState(EncounterCreditType type, uint32 creditEntry, Unit* source)
{
    Difficulty difficulty_fixed = (IsSharedDifficultyMap(GetId()) ? Difficulty(GetDifficulty() % 2) : GetDifficulty());
    DungeonEncounterList const* encounters;
    // 631 : ICC - 724 : Ruby Sanctum --- For heroic difficulties, for some reason, we don't have an encounter list, so we get the encounter list from normal diff. We shouldn't change difficulty_fixed variable.
    if ((GetId() == 631 || GetId() == 724) && IsHeroic())
    {
        encounters = sObjectMgr->GetDungeonEncounterList(GetId(), !Is25ManRaid() ? RAID_DIFFICULTY_10MAN_NORMAL : RAID_DIFFICULTY_25MAN_NORMAL);
    }
    else
    {
        encounters = sObjectMgr->GetDungeonEncounterList(GetId(), difficulty_fixed);
    }

    if (!encounters)
    {
        return;
    }

    uint32 dungeonId = 0;
    bool updated = false;

    for (DungeonEncounterList::const_iterator itr = encounters->begin(); itr != encounters->end(); ++itr)
    {
        DungeonEncounter const* encounter = *itr;
        if (encounter->creditType == type && encounter->creditEntry == creditEntry)
        {
            if (source)
                if (InstanceScript* instanceScript = source->GetInstanceScript())
                {
                    uint32 prevMask = instanceScript->GetCompletedEncounterMask();
                    instanceScript->SetCompletedEncountersMask((1 << encounter->dbcEntry->encounterIndex) | instanceScript->GetCompletedEncounterMask(), true);
                    if (prevMask != instanceScript->GetCompletedEncounterMask())
                        updated = true;
                }

            if (encounter->lastEncounterDungeon)
            {
                dungeonId = encounter->lastEncounterDungeon;
                break;
            }
        }
    }

    // pussywizard:
    LogEncounterFinished(type, creditEntry);

    sScriptMgr->OnAfterUpdateEncounterState(this, type, creditEntry, source, difficulty_fixed, encounters, dungeonId, updated);

    if (dungeonId)
    {
        Map::PlayerList const& players = GetPlayers();
        for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
        {
            if (Player* player = i->GetSource())
                if (Group* grp = player->GetGroup())
                    if (grp->isLFGGroup())
                    {
                        sLFGMgr->FinishDungeon(grp->GetGUID(), dungeonId, this);
                        return;
                    }
        }
    }
}

void Map::LogEncounterFinished(EncounterCreditType type, uint32 creditEntry)
{
    if (!IsRaid() || !GetEntry() || GetEntry()->Expansion() < 2) // only for wotlk raids, because logs take up tons of mysql memory
        return;
    InstanceMap* map = ToInstanceMap();
    if (!map)
        return;
    std::string playersInfo;
    char buffer[16384], buffer2[255];
    Map::PlayerList const& pl = map->GetPlayers();
    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
        if (Player* p = itr->GetSource())
        {
            std::string auraStr;
            const Unit::AuraApplicationMap& a = p->GetAppliedAuras();
            for (auto iterator = a.begin(); iterator != a.end(); ++iterator)
            {
                snprintf(buffer2, 255, "%u(%u) ", iterator->first, iterator->second->GetEffectMask());
                auraStr += buffer2;
            }

            snprintf(buffer, 16384, "%s (%s, acc: %u, ip: %s, guild: %u), xyz: (%.1f, %.1f, %.1f), auras: %s\n",
                p->GetName().c_str(), p->GetGUID().ToString().c_str(), p->GetSession()->GetAccountId(), p->GetSession()->GetRemoteAddress().c_str(), p->GetGuildId(), p->GetPositionX(), p->GetPositionY(), p->GetPositionZ(), auraStr.c_str());
            playersInfo += buffer;
        }
    CleanStringForMysqlQuery(playersInfo);
    CharacterDatabase.Execute("INSERT INTO log_encounter VALUES(NOW(), {}, {}, {}, {}, '{}')", GetId(), (uint32)GetDifficulty(), type, creditEntry, playersInfo);
}

bool Map::AllTransportsEmpty() const
{
    for (TransportsContainer::const_iterator itr = _transports.begin(); itr != _transports.end(); ++itr)
        if (!(*itr)->GetPassengers().empty())
            return false;

    return true;
}

void Map::AllTransportsRemovePassengers()
{
    for (TransportsContainer::const_iterator itr = _transports.begin(); itr != _transports.end(); ++itr)
        while (!(*itr)->GetPassengers().empty())
            (*itr)->RemovePassenger(*((*itr)->GetPassengers().begin()), true);
}

time_t Map::GetLinkedRespawnTime(ObjectGuid guid) const
{
    ObjectGuid linkedGuid = sObjectMgr->GetLinkedRespawnGuid(guid);
    switch (linkedGuid.GetHigh())
    {
        case HighGuid::Unit:
            return GetCreatureRespawnTime(linkedGuid.GetCounter());
        case HighGuid::GameObject:
            return GetGORespawnTime(linkedGuid.GetCounter());
        default:
            break;
    }

    return time_t(0);
}

void Map::AddCorpse(Corpse* corpse)
{
    corpse->SetMap(this);

    _corpsesByCell[corpse->GetCellCoord().GetId()].insert(corpse);
    if (corpse->GetType() != CORPSE_BONES)
        _corpsesByPlayer[corpse->GetOwnerGUID()] = corpse;
    else
        _corpseBones.insert(corpse);
}

void Map::RemoveCorpse(Corpse* corpse)
{
    ASSERT(corpse);

    corpse->DestroyForNearbyPlayers();
    if (corpse->IsInGrid())
        RemoveFromMap(corpse, false);
    else
    {
        corpse->RemoveFromWorld();
        corpse->ResetMap();
    }

    _corpsesByCell[corpse->GetCellCoord().GetId()].erase(corpse);
    if (corpse->GetType() != CORPSE_BONES)
        _corpsesByPlayer.erase(corpse->GetOwnerGUID());
    else
        _corpseBones.erase(corpse);
}

Corpse* Map::ConvertCorpseToBones(ObjectGuid const ownerGuid, bool insignia /*= false*/)
{
    Corpse* corpse = GetCorpseByPlayer(ownerGuid);
    if (!corpse)
        return nullptr;

    RemoveCorpse(corpse);

    // remove corpse from DB
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    corpse->DeleteFromDB(trans);
    CharacterDatabase.CommitTransaction(trans);

    Corpse* bones = NULL;

    // create the bones only if the map and the grid is loaded at the corpse's location
    // ignore bones creating option in case insignia
    if ((insignia ||
        (IsBattlegroundOrArena() ? sWorld->getBoolConfig(CONFIG_DEATH_BONES_BG_OR_ARENA) : sWorld->getBoolConfig(CONFIG_DEATH_BONES_WORLD))) &&
        !IsRemovalGrid(corpse->GetPositionX(), corpse->GetPositionY()))
    {
        // Create bones, don't change Corpse
        bones = new Corpse();
        bones->Create(corpse->GetGUID().GetCounter());

        for (uint8 i = OBJECT_FIELD_TYPE + 1; i < CORPSE_END; ++i)                    // don't overwrite guid and object type
            bones->SetUInt32Value(i, corpse->GetUInt32Value(i));

        bones->SetCellCoord(corpse->GetCellCoord());
        bones->Relocate(corpse->GetPositionX(), corpse->GetPositionY(), corpse->GetPositionZ(), corpse->GetOrientation());
        bones->SetPhaseMask(corpse->GetPhaseMask(), false);

        bones->SetUInt32Value(CORPSE_FIELD_FLAGS, CORPSE_FLAG_UNK2 | CORPSE_FLAG_BONES);
        bones->SetGuidValue(CORPSE_FIELD_OWNER, corpse->GetOwnerGUID());

        for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i)
            if (corpse->GetUInt32Value(CORPSE_FIELD_ITEM + i))
                bones->SetUInt32Value(CORPSE_FIELD_ITEM + i, 0);

        AddCorpse(bones);

        bones->UpdatePositionData();

        // add bones in grid store if grid loaded where corpse placed
        AddToMap(bones);
    }

    // all references to the corpse should be removed at this point
    delete corpse;

    return bones;
}

void Map::RemoveOldCorpses()
{
    time_t now = GameTime::GetGameTime().count();

    std::vector<ObjectGuid> corpses;
    corpses.reserve(_corpsesByPlayer.size());

    for (auto const& p : _corpsesByPlayer)
        if (p.second->IsExpired(now))
            corpses.push_back(p.first);

    for (ObjectGuid const& ownerGuid : corpses)
        ConvertCorpseToBones(ownerGuid);

    std::vector<Corpse*> expiredBones;
    for (Corpse* bones : _corpseBones)
        if (bones->IsExpired(now))
            expiredBones.push_back(bones);

    for (Corpse* bones : expiredBones)
    {
        RemoveCorpse(bones);
        delete bones;
    }
}

void Map::ScheduleCreatureRespawn(ObjectGuid creatureGuid, Milliseconds respawnTimer)
{
    _creatureRespawnScheduler.Schedule(respawnTimer, [this, creatureGuid](TaskContext)
    {
        if (Creature* creature = GetCreature(creatureGuid))
        {
            creature->Respawn();
        }
    });
}

void Map::SendZoneDynamicInfo(Player* player)
{
    uint32 zoneId = player->GetZoneId();
    ZoneDynamicInfoMap::const_iterator itr = _zoneDynamicInfo.find(zoneId);
    if (itr == _zoneDynamicInfo.end())
        return;

    if (uint32 music = itr->second.MusicId)
        player->SendDirectMessage(WorldPackets::Misc::PlayMusic(music).Write());

    if (WeatherState weatherId = itr->second.WeatherId)
    {
        WorldPackets::Misc::Weather weather(weatherId, itr->second.WeatherGrade);
        player->SendDirectMessage(weather.Write());
    }

    if (uint32 overrideLight = itr->second.OverrideLightId)
    {
        WorldPacket data(SMSG_OVERRIDE_LIGHT, 4 + 4 + 1);
        data << uint32(_defaultLight);
        data << uint32(overrideLight);
        data << uint32(itr->second.LightFadeInTime);
        player->SendDirectMessage(&data);
    }
}

void Map::PlayDirectSoundToMap(uint32 soundId, uint32 zoneId)
{
    Map::PlayerList const& players = GetPlayers();
    if (!players.IsEmpty())
    {
        WorldPacket data(SMSG_PLAY_SOUND, 4);
        data << uint32(soundId);

        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (!zoneId || player->GetZoneId() == zoneId)
                    player->SendDirectMessage(&data);
    }
}

void Map::SetZoneMusic(uint32 zoneId, uint32 musicId)
{
    if (_zoneDynamicInfo.find(zoneId) == _zoneDynamicInfo.end())
        _zoneDynamicInfo.insert(ZoneDynamicInfoMap::value_type(zoneId, ZoneDynamicInfo()));

    _zoneDynamicInfo[zoneId].MusicId = musicId;

    Map::PlayerList const& players = GetPlayers();
    if (!players.IsEmpty())
    {
        WorldPackets::Misc::PlayMusic playMusic(musicId);
        playMusic.Write();

        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->GetZoneId() == zoneId)
                    player->SendDirectMessage(playMusic.GetRawPacket());
    }
}

void Map::SetZoneWeather(uint32 zoneId, WeatherState weatherId, float weatherGrade)
{
    if (_zoneDynamicInfo.find(zoneId) == _zoneDynamicInfo.end())
        _zoneDynamicInfo.insert(ZoneDynamicInfoMap::value_type(zoneId, ZoneDynamicInfo()));

    ZoneDynamicInfo& info = _zoneDynamicInfo[zoneId];
    info.WeatherId = weatherId;
    info.WeatherGrade = weatherGrade;
    Map::PlayerList const& players = GetPlayers();

    if (!players.IsEmpty())
    {
        WorldPackets::Misc::Weather weather(weatherId, weatherGrade);

        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->GetZoneId() == zoneId)
                    player->SendDirectMessage(weather.Write());
    }
}

void Map::SetZoneOverrideLight(uint32 zoneId, uint32 lightId, Milliseconds fadeInTime)
{
    if (_zoneDynamicInfo.find(zoneId) == _zoneDynamicInfo.end())
        _zoneDynamicInfo.insert(ZoneDynamicInfoMap::value_type(zoneId, ZoneDynamicInfo()));

    ZoneDynamicInfo& info = _zoneDynamicInfo[zoneId];
    info.OverrideLightId = lightId;
    info.LightFadeInTime = static_cast<uint32>(fadeInTime.count());
    Map::PlayerList const& players = GetPlayers();

    if (!players.IsEmpty())
    {
        WorldPacket data(SMSG_OVERRIDE_LIGHT, 4 + 4 + 4);
        data << uint32(_defaultLight);
        data << uint32(lightId);
        data << uint32(static_cast<uint32>(fadeInTime.count()));

        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->GetZoneId() == zoneId)
                    player->SendDirectMessage(&data);
    }
}

void Map::DoForAllPlayers(std::function<void(Player*)> exec)
{
    for (auto const& it : GetPlayers())
    {
        if (Player* player = it.GetSource())
        {
            exec(player);
        }
    }
}

/**
 * @brief Check if a given source can reach a specific point following a path
 * and normalize the coords. Use this method for long paths, otherwise use the
 * overloaded method with the start coords when you need to do a quick check on small segments
 *
 */
bool Map::CanReachPositionAndGetValidCoords(WorldObject const* source, PathGenerator *path, float &destX, float &destY, float &destZ, bool failOnCollision, bool failOnSlopes) const
{
    G3D::Vector3 prevPath = path->GetStartPosition();
    for (auto& vector : path->GetPath())
    {
        float x = vector.x;
        float y = vector.y;
        float z = vector.z;

        if (!CanReachPositionAndGetValidCoords(source, prevPath.x, prevPath.y, prevPath.z, x, y, z, failOnCollision, failOnSlopes))
        {
            destX = x;
            destY = y;
            destZ = z;
            return false;
        }

        prevPath = vector;
    }

    destX = prevPath.x;
    destY = prevPath.y;
    destZ = prevPath.z;

    return true;
}

/**
 * @brief validate the new destination and set reachable coords
 * Check if a given unit can reach a specific point on a segment
 * and set the correct dest coords
 * NOTE: use this method with small segments.
 *
 * @param failOnCollision if true, the methods will return false when a collision occurs
 * @param failOnSlopes if true, the methods will return false when a non walkable slope is found
 *
 * @return true if the destination is valid, false otherwise
 *
 **/

bool Map::CanReachPositionAndGetValidCoords(WorldObject const* source, float& destX, float& destY, float& destZ, bool failOnCollision, bool failOnSlopes) const
{
    return CanReachPositionAndGetValidCoords(source, source->GetPositionX(), source->GetPositionY(), source->GetPositionZ(), destX, destY, destZ, failOnCollision, failOnSlopes);
}

bool Map::CanReachPositionAndGetValidCoords(WorldObject const* source, float startX, float startY, float startZ, float &destX, float &destY, float &destZ, bool failOnCollision, bool failOnSlopes) const
{
    if (!CheckCollisionAndGetValidCoords(source, startX, startY, startZ, destX, destY, destZ, failOnCollision))
    {
        return false;
    }

    Unit const* unit = source->ToUnit();
    // if it's not an unit (Object) then we do not have to continue
    // with walkable checks
    if (!unit)
    {
        return true;
    }

    /*
     * Walkable checks
     */
    bool isWaterNext = HasEnoughWater(unit, destX, destY, destZ);
    Creature const* creature = unit->ToCreature();
    bool cannotEnterWater = isWaterNext && (creature && !creature->CanEnterWater());
    bool cannotWalkOrFly = !isWaterNext && !source->ToPlayer() && !unit->CanFly() && (creature && !creature->CanWalk());
    if (cannotEnterWater || cannotWalkOrFly ||
        (failOnSlopes && !PathGenerator::IsWalkableClimb(startX, startY, startZ, destX, destY, destZ, source->GetCollisionHeight())))
    {
        return false;
    }

    return true;
}

/**
 * @brief validate the new destination and set coords
 * Check if a given unit can face collisions in a specific segment
 *
 * @return true if the destination is valid, false otherwise
 *
 **/
bool Map::CheckCollisionAndGetValidCoords(WorldObject const* source, float startX, float startY, float startZ, float &destX, float &destY, float &destZ, bool failOnCollision) const
{
    // Prevent invalid coordinates here, position is unchanged
    if (!Acore::IsValidMapCoord(startX, startY, startZ) || !Acore::IsValidMapCoord(destX, destY, destZ))
    {
        LOG_FATAL("maps", "Map::CheckCollisionAndGetValidCoords invalid coordinates startX: {}, startY: {}, startZ: {}, destX: {}, destY: {}, destZ: {}", startX, startY, startZ, destX, destY, destZ);
        return false;
    }

    bool isWaterNext = IsInWater(source->GetPhaseMask(), destX, destY, destZ, source->GetCollisionHeight());

    PathGenerator path(source);

    // Use a detour raycast to get our first collision point
    path.SetUseRaycast(true);
    bool result = path.CalculatePath(startX, startY, startZ, destX, destY, destZ, false);

    Unit const* unit = source->ToUnit();
    bool notOnGround = path.GetPathType() & PATHFIND_NOT_USING_PATH
        || isWaterNext || (unit && unit->IsFlying());

    // Check for valid path types before we proceed
    if (!result || (!notOnGround && path.GetPathType() & ~(PATHFIND_NORMAL | PATHFIND_SHORTCUT | PATHFIND_INCOMPLETE | PATHFIND_FARFROMPOLY_END)))
    {
        return false;
    }

    G3D::Vector3 endPos = path.GetPath().back();
    destX = endPos.x;
    destY = endPos.y;
    destZ = endPos.z;

    // collision check
    bool collided = false;

    // check static LOS
    float halfHeight = source->GetCollisionHeight() * 0.5f;

    // Unit is not on the ground, check for potential collision via vmaps
    if (notOnGround)
    {
        bool col = VMAP::VMapFactory::createOrGetVMapMgr()->GetObjectHitPos(source->GetMapId(),
            startX, startY, startZ + halfHeight,
            destX, destY, destZ + halfHeight,
            destX, destY, destZ, -CONTACT_DISTANCE);

        destZ -= halfHeight;

        // Collided with static LOS object, move back to collision point
        if (col)
        {
            collided = true;
        }
    }

    // check dynamic collision
    bool col = source->GetMap()->GetObjectHitPos(source->GetPhaseMask(),
        startX, startY, startZ + halfHeight,
        destX, destY, destZ + halfHeight,
        destX, destY, destZ, -CONTACT_DISTANCE);

    destZ -= halfHeight;

    // Collided with a gameobject, move back to collision point
    if (col)
    {
        collided = true;
    }

    float groundZ = VMAP_INVALID_HEIGHT_VALUE;
    source->UpdateAllowedPositionZ(destX, destY, destZ, &groundZ);

    // position has no ground under it (or is too far away)
    if (groundZ <= INVALID_HEIGHT && unit && !unit->CanFly())
    {
        // fall back to gridHeight if any
        float gridHeight = GetGridHeight(destX, destY);
        if (gridHeight > INVALID_HEIGHT)
        {
            destZ = gridHeight + unit->GetHoverHeight();
        }
        else
        {
            return false;
        }
    }

    return !failOnCollision || !collided;
}

void Map::LoadCorpseData()
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CORPSES);
    stmt->SetData(0, GetId());
    stmt->SetData(1, GetInstanceId());

    //        0     1     2     3            4      5          6          7       8       9        10     11        12    13          14          15         16
    // SELECT posX, posY, posZ, orientation, mapId, displayId, itemCache, bytes1, bytes2, guildId, flags, dynFlags, time, corpseType, instanceId, phaseMask, guid FROM corpse WHERE mapId = ? AND instanceId = ?
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();
        CorpseType type = CorpseType(fields[13].Get<uint8>());
        uint32 guid = fields[16].Get<uint32>();
        if (type >= MAX_CORPSE_TYPE || type == CORPSE_BONES)
        {
            LOG_ERROR("maps", "Corpse (guid: {}) have wrong corpse type ({}), not loading.", guid, type);
            continue;
        }

        Corpse* corpse = new Corpse(type);

        if (!corpse->LoadCorpseFromDB(GenerateLowGuid<HighGuid::Corpse>(), fields))
        {
            delete corpse;
            continue;
        }

        AddCorpse(corpse);

        corpse->UpdatePositionData();
    } while (result->NextRow());
}

void Map::DeleteCorpseData()
{
    // DELETE FROM corpse WHERE mapId = ? AND instanceId = ?
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CORPSES_FROM_MAP);
    stmt->SetData(0, GetId());
    stmt->SetData(1, GetInstanceId());
    CharacterDatabase.Execute(stmt);
}

std::string Map::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << std::boolalpha
        << "Id: " << GetId() << " InstanceId: " << GetInstanceId() << " Difficulty: " << std::to_string(GetDifficulty())
        << " HasPlayers: " << HavePlayers();
    return sstr.str();
}

std::string InstanceMap::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << Map::GetDebugInfo() << "\n"
        << std::boolalpha
        << "ScriptId: " << GetScriptId() << " ScriptName: " << GetScriptName();
    return sstr.str();
}
