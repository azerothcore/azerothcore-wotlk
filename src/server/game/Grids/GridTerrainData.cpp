#include "DBCStores.h"
#include "GridDefines.h"
#include "GridTerrainData.h"
#include "Log.h"
#include "MapDefines.h"
#include <filesystem>
#include <G3D/Ray.h>

uint16 const holetab_h[4] = { 0x1111, 0x2222, 0x4444, 0x8888 };
uint16 const holetab_v[4] = { 0x000F, 0x00F0, 0x0F00, 0xF000 };

GridTerrainData::GridTerrainData()
{
    _gridGetHeight = &GridTerrainData::getHeightFromFlat;
}

TerrainMapDataReadResult GridTerrainData::Load(std::string const& mapFileName)
{
    // Check if file exists, we do this first as we need to
    // differentiate between file existing and any other file errors
    if (!std::filesystem::exists(mapFileName))
        return TerrainMapDataReadResult::NotFound;

    // Start the input stream and check for any errors
    std::ifstream fileStream(mapFileName, std::ios::binary);
    if (fileStream.fail())
        return TerrainMapDataReadResult::ReadError;

    // Read the map header
    map_fileheader header;
    if (!fileStream.read(reinterpret_cast<char*>(&header), sizeof(header)))
        return TerrainMapDataReadResult::ReadError;

    // Check for valid map and version magics
    if (header.mapMagic != MapMagic.asUInt || header.versionMagic != MapVersionMagic)
        return TerrainMapDataReadResult::InvalidMagic;

    // Load area data
    if (header.areaMapOffset && !LoadAreaData(fileStream, header.areaMapOffset))
        return TerrainMapDataReadResult::InvalidAreaData;

    // Load height data
    if (header.heightMapOffset && !LoadHeightData(fileStream, header.heightMapOffset))
        return TerrainMapDataReadResult::InvalidHeightData;

    // Load liquid data
    if (header.liquidMapOffset && !LoadLiquidData(fileStream, header.liquidMapOffset))
        return TerrainMapDataReadResult::InvalidLiquidData;

    // Load hole data
    if (header.holesSize && !LoadHolesData(fileStream, header.holesOffset))
        return TerrainMapDataReadResult::InvalidHoleData;

    return TerrainMapDataReadResult::Success;
}

bool GridTerrainData::LoadAreaData(std::ifstream& fileStream, uint32 const offset)
{
    fileStream.seekg(offset);

    map_areaHeader header;
    if (!fileStream.read(reinterpret_cast<char*>(&header), sizeof(header)) || header.fourcc != MapAreaMagic.asUInt)
        return false;

    _loadedAreaData = std::make_unique<LoadedAreaData>();
    _loadedAreaData->gridArea = header.gridArea;
    if (!(header.flags & MAP_AREA_NO_AREA))
    {
        _loadedAreaData->areaMap = std::make_unique<LoadedAreaData::AreaMapType>();
        if (!fileStream.read(reinterpret_cast<char*>(_loadedAreaData->areaMap.get()), sizeof(LoadedAreaData::AreaMapType)))
            return false;
    }
    return true;
}

bool GridTerrainData::LoadHeightData(std::ifstream& fileStream, uint32 const offset)
{
    fileStream.seekg(offset);

    map_heightHeader header;
    if (!fileStream.read(reinterpret_cast<char*>(&header), sizeof(header)) || header.fourcc != MapHeightMagic.asUInt)
        return false;

    _loadedHeightData = std::make_unique<LoadedHeightData>();
    _loadedHeightData->gridHeight = header.gridHeight;
    if (!(header.flags & MAP_HEIGHT_NO_HEIGHT))
    {
        if ((header.flags & MAP_HEIGHT_AS_INT16))
        {
            _loadedHeightData->uint16HeightData = std::make_unique<LoadedHeightData::Uint16HeightData>();
            if (!fileStream.read(reinterpret_cast<char*>(&_loadedHeightData->uint16HeightData->v9), sizeof(_loadedHeightData->uint16HeightData->v9))
                || !fileStream.read(reinterpret_cast<char*>(&_loadedHeightData->uint16HeightData->v8), sizeof(_loadedHeightData->uint16HeightData->v8)))
                return false;

            _loadedHeightData->uint16HeightData->gridIntHeightMultiplier = (header.gridMaxHeight - header.gridHeight) / 65535;
            _gridGetHeight = &GridTerrainData::getHeightFromUint16;
        }
        else if ((header.flags & MAP_HEIGHT_AS_INT8))
        {
            _loadedHeightData->uint8HeightData = std::make_unique<LoadedHeightData::Uint8HeightData>();
            if (!fileStream.read(reinterpret_cast<char*>(&_loadedHeightData->uint8HeightData->v9), sizeof(_loadedHeightData->uint8HeightData->v9))
                || !fileStream.read(reinterpret_cast<char*>(&_loadedHeightData->uint8HeightData->v8), sizeof(_loadedHeightData->uint8HeightData->v8)))
                return false;

            _loadedHeightData->uint8HeightData->gridIntHeightMultiplier = (header.gridMaxHeight - header.gridHeight) / 255;
            _gridGetHeight = &GridTerrainData::getHeightFromUint8;
        }
        else
        {
            _loadedHeightData->floatHeightData = std::make_unique<LoadedHeightData::FloatHeightData>();
            if (!fileStream.read(reinterpret_cast<char*>(&_loadedHeightData->floatHeightData->v9), sizeof(_loadedHeightData->floatHeightData->v9))
                || !fileStream.read(reinterpret_cast<char*>(&_loadedHeightData->floatHeightData->v8), sizeof(_loadedHeightData->floatHeightData->v8)))
                return false;

            _gridGetHeight = &GridTerrainData::getHeightFromFloat;
        }
    }
    else
        _gridGetHeight = &GridTerrainData::getHeightFromFlat;

    if (header.flags & MAP_HEIGHT_HAS_FLIGHT_BOUNDS)
    {
        std::array<int16, 9> maxHeights;
        std::array<int16, 9> minHeights;
        if (!fileStream.read(reinterpret_cast<char*>(maxHeights.data()), sizeof(maxHeights)) ||
            !fileStream.read(reinterpret_cast<char*>(minHeights.data()), sizeof(minHeights)))
            return false;

        static uint32 constexpr indices[8][3] =
        {
            { 3, 0, 4 },
            { 0, 1, 4 },
            { 1, 2, 4 },
            { 2, 5, 4 },
            { 5, 8, 4 },
            { 8, 7, 4 },
            { 7, 6, 4 },
            { 6, 3, 4 }
        };

        static float constexpr boundGridCoords[9][2] =
        {
            { 0.0f, 0.0f },
            { 0.0f, -266.66666f },
            { 0.0f, -533.33331f },
            { -266.66666f, 0.0f },
            { -266.66666f, -266.66666f },
            { -266.66666f, -533.33331f },
            { -533.33331f, 0.0f },
            { -533.33331f, -266.66666f },
            { -533.33331f, -533.33331f }
        };

        _loadedHeightData->minHeightPlanes = std::make_unique<LoadedHeightData::HeightPlanesType>();
        for (uint32 quarterIndex = 0; quarterIndex < _loadedHeightData->minHeightPlanes->size(); ++quarterIndex)
            _loadedHeightData->minHeightPlanes->at(quarterIndex) = G3D::Plane(
                G3D::Vector3(boundGridCoords[indices[quarterIndex][0]][0], boundGridCoords[indices[quarterIndex][0]][1], minHeights[indices[quarterIndex][0]]),
                G3D::Vector3(boundGridCoords[indices[quarterIndex][1]][0], boundGridCoords[indices[quarterIndex][1]][1], minHeights[indices[quarterIndex][1]]),
                G3D::Vector3(boundGridCoords[indices[quarterIndex][2]][0], boundGridCoords[indices[quarterIndex][2]][1], minHeights[indices[quarterIndex][2]])
            );
    }

    return true;
}

bool GridTerrainData::LoadLiquidData(std::ifstream& fileStream, uint32 const offset)
{
    fileStream.seekg(offset);

    map_liquidHeader header;
    if (!fileStream.read(reinterpret_cast<char*>(&header), sizeof(header)) || header.fourcc != MapLiquidMagic.asUInt)
        return false;

    _loadedLiquidData = std::make_unique<LoadedLiquidData>();
    _loadedLiquidData->liquidGlobalEntry = header.liquidType;
    _loadedLiquidData->liquidGlobalFlags = header.liquidFlags;
    _loadedLiquidData->liquidOffX = header.offsetX;
    _loadedLiquidData->liquidOffY = header.offsetY;
    _loadedLiquidData->liquidWidth = header.width;
    _loadedLiquidData->liquidHeight = header.height;
    _loadedLiquidData->liquidLevel = header.liquidLevel;

    if (!(header.flags & MAP_LIQUID_NO_TYPE))
    {
        _loadedLiquidData->liquidEntry = std::make_unique<LoadedLiquidData::LiquidEntryType>();
        if (!fileStream.read(reinterpret_cast<char*>(_loadedLiquidData->liquidEntry.get()), sizeof(LoadedLiquidData::LiquidEntryType)))
            return false;

        _loadedLiquidData->liquidFlags = std::make_unique<LoadedLiquidData::LiquidFlagsType>();
        if (!fileStream.read(reinterpret_cast<char*>(_loadedLiquidData->liquidFlags.get()), sizeof(LoadedLiquidData::LiquidFlagsType)))
            return false;
    }
    if (!(header.flags & MAP_LIQUID_NO_HEIGHT))
    {
        _loadedLiquidData->liquidMap = std::make_unique<LoadedLiquidData::LiquidMapType>();
        _loadedLiquidData->liquidMap->resize(_loadedLiquidData->liquidWidth * _loadedLiquidData->liquidHeight);
        if (!fileStream.read(reinterpret_cast<char*>(_loadedLiquidData->liquidMap->data()), _loadedLiquidData->liquidMap->size() * sizeof(float)))
            return false;
    }
    return true;
}

bool GridTerrainData::LoadHolesData(std::ifstream& fileStream, uint32 const offset)
{
    fileStream.seekg(offset);

    _loadedHoleData = std::make_unique<LoadedHoleData>();
    if (!fileStream.read(reinterpret_cast<char*>(&_loadedHoleData->holes), sizeof(_loadedHoleData->holes)))
        return false;

    return true;
}

uint16 GridTerrainData::getArea(float x, float y) const
{
    if (!_loadedAreaData)
        return 0;

    if (!_loadedAreaData->areaMap)
        return _loadedAreaData->gridArea;

    x = 16 * (32 - x / SIZE_OF_GRIDS);
    y = 16 * (32 - y / SIZE_OF_GRIDS);
    int lx = (int)x & 15;
    int ly = (int)y & 15;
    return _loadedAreaData->areaMap->at(lx * 16 + ly);
}

float GridTerrainData::getHeightFromFlat(float /*x*/, float /*y*/) const
{
    if (!_loadedHeightData)
        return INVALID_HEIGHT;

    return _loadedHeightData->gridHeight;
}

float GridTerrainData::getHeightFromFloat(float x, float y) const
{
    if (!_loadedHeightData || !_loadedHeightData->floatHeightData)
        return INVALID_HEIGHT;

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
            float h1 = _loadedHeightData->floatHeightData->v9[(x_int) * 129 + y_int];
            float h2 = _loadedHeightData->floatHeightData->v9[(x_int + 1) * 129 + y_int];
            float h5 = 2 * _loadedHeightData->floatHeightData->v8[x_int * 128 + y_int];
            a = h2 - h1;
            b = h5 - h1 - h2;
            c = h1;
        }
        else
        {
            // 2 triangle (h1, h3, h5 points)
            float h1 = _loadedHeightData->floatHeightData->v9[x_int * 129 + y_int];
            float h3 = _loadedHeightData->floatHeightData->v9[x_int * 129 + y_int + 1];
            float h5 = 2 * _loadedHeightData->floatHeightData->v8[x_int * 128 + y_int];
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
            float h2 = _loadedHeightData->floatHeightData->v9[(x_int + 1) * 129 + y_int];
            float h4 = _loadedHeightData->floatHeightData->v9[(x_int + 1) * 129 + y_int + 1];
            float h5 = 2 * _loadedHeightData->floatHeightData->v8[x_int * 128 + y_int];
            a = h2 + h4 - h5;
            b = h4 - h2;
            c = h5 - h4;
        }
        else
        {
            // 4 triangle (h3, h4, h5 points)
            float h3 = _loadedHeightData->floatHeightData->v9[(x_int) * 129 + y_int + 1];
            float h4 = _loadedHeightData->floatHeightData->v9[(x_int + 1) * 129 + y_int + 1];
            float h5 = 2 * _loadedHeightData->floatHeightData->v8[x_int * 128 + y_int];
            a = h4 - h3;
            b = h3 + h4 - h5;
            c = h5 - h4;
        }
    }
    // Calculate height
    return a * x + b * y + c;
}

float GridTerrainData::getHeightFromUint8(float x, float y) const
{
    if (!_loadedHeightData || !_loadedHeightData->uint8HeightData)
        return INVALID_HEIGHT;

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
    uint8* V9_h1_ptr = &_loadedHeightData->uint8HeightData->v9[x_int * 128 + x_int + y_int];
    if (x + y < 1)
    {
        if (x > y)
        {
            // 1 triangle (h1, h2, h5 points)
            int32 h1 = V9_h1_ptr[0];
            int32 h2 = V9_h1_ptr[129];
            int32 h5 = 2 * _loadedHeightData->uint8HeightData->v8[x_int * 128 + y_int];
            a = h2 - h1;
            b = h5 - h1 - h2;
            c = h1;
        }
        else
        {
            // 2 triangle (h1, h3, h5 points)
            int32 h1 = V9_h1_ptr[0];
            int32 h3 = V9_h1_ptr[1];
            int32 h5 = 2 * _loadedHeightData->uint8HeightData->v8[x_int * 128 + y_int];
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
            int32 h5 = 2 * _loadedHeightData->uint8HeightData->v8[x_int * 128 + y_int];
            a = h2 + h4 - h5;
            b = h4 - h2;
            c = h5 - h4;
        }
        else
        {
            // 4 triangle (h3, h4, h5 points)
            int32 h3 = V9_h1_ptr[1];
            int32 h4 = V9_h1_ptr[130];
            int32 h5 = 2 * _loadedHeightData->uint8HeightData->v8[x_int * 128 + y_int];
            a = h4 - h3;
            b = h3 + h4 - h5;
            c = h5 - h4;
        }
    }
    // Calculate height
    return (float)((a * x) + (b * y) + c) * _loadedHeightData->uint8HeightData->gridIntHeightMultiplier + _loadedHeightData->gridHeight;
}

float GridTerrainData::getHeightFromUint16(float x, float y) const
{
    if (!_loadedHeightData || !_loadedHeightData->uint16HeightData)
        return INVALID_HEIGHT;

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
    uint16* V9_h1_ptr = &_loadedHeightData->uint16HeightData->v9[x_int * 128 + x_int + y_int];
    if (x + y < 1)
    {
        if (x > y)
        {
            // 1 triangle (h1, h2, h5 points)
            int32 h1 = V9_h1_ptr[0];
            int32 h2 = V9_h1_ptr[129];
            int32 h5 = 2 * _loadedHeightData->uint16HeightData->v8[x_int * 128 + y_int];
            a = h2 - h1;
            b = h5 - h1 - h2;
            c = h1;
        }
        else
        {
            // 2 triangle (h1, h3, h5 points)
            int32 h1 = V9_h1_ptr[0];
            int32 h3 = V9_h1_ptr[1];
            int32 h5 = 2 * _loadedHeightData->uint16HeightData->v8[x_int * 128 + y_int];
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
            int32 h5 = 2 * _loadedHeightData->uint16HeightData->v8[x_int * 128 + y_int];
            a = h2 + h4 - h5;
            b = h4 - h2;
            c = h5 - h4;
        }
        else
        {
            // 4 triangle (h3, h4, h5 points)
            int32 h3 = V9_h1_ptr[1];
            int32 h4 = V9_h1_ptr[130];
            int32 h5 = 2 * _loadedHeightData->uint16HeightData->v8[x_int * 128 + y_int];
            a = h4 - h3;
            b = h3 + h4 - h5;
            c = h5 - h4;
        }
    }
    // Calculate height
    return (float)((a * x) + (b * y) + c) * _loadedHeightData->uint16HeightData->gridIntHeightMultiplier + _loadedHeightData->gridHeight;
}

bool GridTerrainData::isHole(int row, int col) const
{
    if (!_loadedHoleData)
        return false;

    int cellRow = row / 8; // 8 squares per cell
    int cellCol = col / 8;
    int holeRow = row % 8 / 2;
    int holeCol = (col - (cellCol * 8)) / 2;

    uint16 hole = _loadedHoleData->holes[cellRow * 16 + cellCol];

    return (hole & holetab_h[holeCol] & holetab_v[holeRow]) != 0;
}

float GridTerrainData::getMinHeight(float x, float y) const
{
    if (!_loadedHeightData || !_loadedHeightData->minHeightPlanes)
        return MIN_HEIGHT;

    GridCoord gridCoord = Acore::ComputeGridCoordSimple(x, y);

    int32 doubleGridX = int32(std::floor(-(x - MAP_HALFSIZE) / CENTER_GRID_OFFSET));
    int32 doubleGridY = int32(std::floor(-(y - MAP_HALFSIZE) / CENTER_GRID_OFFSET));

    float gx = x - (int32(gridCoord.x_coord) - CENTER_GRID_ID + 1) * SIZE_OF_GRIDS;
    float gy = y - (int32(gridCoord.y_coord) - CENTER_GRID_ID + 1) * SIZE_OF_GRIDS;

    uint32 quarterIndex = 0;
    if (doubleGridY & 1)
    {
        if (doubleGridX & 1)
            quarterIndex = 4 + (gx <= gy);
        else
            quarterIndex = 2 + ((-SIZE_OF_GRIDS - gx) > gy);
    }
    else if (doubleGridX & 1)
        quarterIndex = 6 + ((-SIZE_OF_GRIDS - gx) <= gy);
    else
        quarterIndex = gx > gy;

    G3D::Ray ray = G3D::Ray::fromOriginAndDirection(G3D::Vector3(gx, gy, 0.0f), G3D::Vector3::unitZ());
    return ray.intersection(_loadedHeightData->minHeightPlanes->at(quarterIndex)).z;
}

float GridTerrainData::getLiquidLevel(float x, float y) const
{
    if (!_loadedLiquidData)
        return INVALID_HEIGHT;

    if (!_loadedLiquidData->liquidMap)
        return _loadedLiquidData->liquidLevel;

    x = MAP_RESOLUTION * (32 - x / SIZE_OF_GRIDS);
    y = MAP_RESOLUTION * (32 - y / SIZE_OF_GRIDS);

    int cx_int = ((int)x & (MAP_RESOLUTION - 1)) - _loadedLiquidData->liquidOffY;
    int cy_int = ((int)y & (MAP_RESOLUTION - 1)) - _loadedLiquidData->liquidOffX;

    if (cx_int < 0 || cx_int >= _loadedLiquidData->liquidHeight)
        return INVALID_HEIGHT;
    if (cy_int < 0 || cy_int >= _loadedLiquidData->liquidWidth)
        return INVALID_HEIGHT;

    return _loadedLiquidData->liquidMap->at(cx_int * _loadedLiquidData->liquidWidth + cy_int);
}

// Get water state on map
LiquidData const GridTerrainData::GetLiquidData(float x, float y, float z, float collisionHeight, Optional<uint8> ReqLiquidType) const
{
    LiquidData liquidData;
    liquidData.Status = LIQUID_MAP_NO_WATER;

    if (!_loadedLiquidData)
        return liquidData;

    // Check water type (if no water return)
    if (_loadedLiquidData->liquidGlobalFlags || _loadedLiquidData->liquidFlags)
    {
        // Get cell
        float cx = MAP_RESOLUTION * (32 - x / SIZE_OF_GRIDS);
        float cy = MAP_RESOLUTION * (32 - y / SIZE_OF_GRIDS);

        int x_int = (int)cx & (MAP_RESOLUTION - 1);
        int y_int = (int)cy & (MAP_RESOLUTION - 1);

        // Check water type in cell
        int idx = (x_int >> 3) * 16 + (y_int >> 3);
        uint8 type = _loadedLiquidData->liquidFlags ? _loadedLiquidData->liquidFlags->at(idx) : _loadedLiquidData->liquidGlobalFlags;
        uint32 entry = _loadedLiquidData->liquidEntry ? _loadedLiquidData->liquidEntry->at(idx) : _loadedLiquidData->liquidGlobalEntry;
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
                        entry = overrideLiquid;
                        liqTypeIdx = liq->Type;
                    }
                }
            }

            type |= 1 << liqTypeIdx;
        }

        // Check req liquid type mask
        if (type != 0 && (!ReqLiquidType || (*ReqLiquidType & type) != 0))
        {
            // Check water level:
            // Check water height map
            int lx_int = x_int - _loadedLiquidData->liquidOffY;
            int ly_int = y_int - _loadedLiquidData->liquidOffX;
            if (lx_int >= 0 && lx_int < _loadedLiquidData->liquidHeight && ly_int >= 0 && ly_int < _loadedLiquidData->liquidWidth)
            {
                // Get water level
                float liquid_level = _loadedLiquidData->liquidMap ? _loadedLiquidData->liquidMap->at(lx_int * _loadedLiquidData->liquidWidth + ly_int) : _loadedLiquidData->liquidLevel;
                // Get ground level
                float ground_level = getHeight(x, y);

                // Check water level and ground level (sub 0.2 for fix some errors)
                if (liquid_level >= ground_level && z >= ground_level - 0.2f)
                {
                    // All ok in water -> store data
                    liquidData.Entry = entry;
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
