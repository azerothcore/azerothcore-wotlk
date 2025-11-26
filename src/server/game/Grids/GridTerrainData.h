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

#ifndef GRID_TERRAIN_DATA_H
#define GRID_TERRAIN_DATA_H

#include "Common.h"
#include <fstream>
#include <G3D/Plane.h>
#include <memory>

#define MAX_HEIGHT            100000.0f                     // can be use for find ground height at surface
#define INVALID_HEIGHT       -100000.0f                     // for check, must be equal to VMAP_INVALID_HEIGHT, real value for unknown height is VMAP_INVALID_HEIGHT_VALUE
#define MAX_FALL_DISTANCE     250000.0f                     // "unlimited fall" to find VMap ground if it is available, just larger than MAX_HEIGHT - INVALID_HEIGHT
#define MIN_HEIGHT           -500.0f

#define MAP_LIQUID_STATUS_SWIMMING (LIQUID_MAP_IN_WATER | LIQUID_MAP_UNDER_WATER)
#define MAP_LIQUID_STATUS_IN_CONTACT (MAP_LIQUID_STATUS_SWIMMING | LIQUID_MAP_WATER_WALK)

#define MAP_LIQUID_TYPE_NO_WATER    0x00
#define MAP_LIQUID_TYPE_WATER       0x01
#define MAP_LIQUID_TYPE_OCEAN       0x02
#define MAP_LIQUID_TYPE_MAGMA       0x04
#define MAP_LIQUID_TYPE_SLIME       0x08

#define MAP_ALL_LIQUIDS   (MAP_LIQUID_TYPE_WATER | MAP_LIQUID_TYPE_OCEAN | MAP_LIQUID_TYPE_MAGMA | MAP_LIQUID_TYPE_SLIME)

#define MAP_LIQUID_TYPE_DARK_WATER  0x10

// ******************************************
// Map file format defines
// ******************************************
union u_map_magic
{
    char asChar[4];
    uint32 asUInt;
};

const u_map_magic MapMagic        = { {'M', 'A', 'P', 'S'} };
const uint32 MapVersionMagic      = 9;
const u_map_magic MapAreaMagic    = { {'A', 'R', 'E', 'A'} };
const u_map_magic MapHeightMagic  = { {'M', 'H', 'G', 'T'} };
const u_map_magic MapLiquidMagic  = { {'M', 'L', 'I', 'Q'} };

struct map_fileheader
{
    uint32 mapMagic;
    uint32 versionMagic;
    uint32 buildMagic;
    uint32 areaMapOffset;
    uint32 areaMapSize;
    uint32 heightMapOffset;
    uint32 heightMapSize;
    uint32 liquidMapOffset;
    uint32 liquidMapSize;
    uint32 holesOffset;
    uint32 holesSize;
};

#define MAP_AREA_NO_AREA      0x0001

struct map_areaHeader
{
    uint32 fourcc;
    uint16 flags;
    uint16 gridArea;
};

#define MAP_HEIGHT_NO_HEIGHT            0x0001
#define MAP_HEIGHT_AS_INT16             0x0002
#define MAP_HEIGHT_AS_INT8              0x0004
#define MAP_HEIGHT_HAS_FLIGHT_BOUNDS    0x0008

struct map_heightHeader
{
    uint32 fourcc;
    uint32 flags;
    float  gridHeight;
    float  gridMaxHeight;
};

#define MAP_LIQUID_NO_TYPE    0x0001
#define MAP_LIQUID_NO_HEIGHT  0x0002

struct map_liquidHeader
{
    uint32 fourcc;
    uint8 flags;
    uint8 liquidFlags;
    uint16 liquidType;
    uint8  offsetX;
    uint8  offsetY;
    uint8  width;
    uint8  height;
    float  liquidLevel;
};

// ******************************************
// Loaded map data structures
// ******************************************

struct LoadedAreaData
{
    typedef std::array<uint16, 16 * 16> AreaMapType;

    uint16 gridArea;
    std::unique_ptr<AreaMapType> areaMap;
};

struct LoadedHeightData
{
    typedef std::array<G3D::Plane, 8> HeightPlanesType;

    struct Uint16HeightData
    {
        typedef std::array<uint16, 129 * 129> V9Type;
        typedef std::array<uint16, 128 * 128> V8Type;

        V9Type v9;
        V8Type v8;
        float gridIntHeightMultiplier;
    };

    struct Uint8HeightData
    {
        typedef std::array<uint8, 129 * 129> V9Type;
        typedef std::array<uint8, 128 * 128> V8Type;

        V9Type v9;
        V8Type v8;
        float gridIntHeightMultiplier;
    };

    struct FloatHeightData
    {
        typedef std::array<float, 129 * 129> V9Type;
        typedef std::array<float, 128 * 128> V8Type;

        V9Type v9;
        V8Type v8;
    };

    float gridHeight;
    std::unique_ptr<Uint16HeightData> uint16HeightData;
    std::unique_ptr<Uint8HeightData> uint8HeightData;
    std::unique_ptr<FloatHeightData> floatHeightData;
    std::unique_ptr<HeightPlanesType> minHeightPlanes;
};

struct LoadedLiquidData
{
    typedef std::array<uint16, 16 * 16> LiquidEntryType;
    typedef std::array<uint8, 16 * 16> LiquidFlagsType;
    typedef std::vector<float> LiquidMapType;

    uint16 liquidGlobalEntry;
    uint8 liquidGlobalFlags;
    uint8 liquidOffX;
    uint8 liquidOffY;
    uint8 liquidWidth;
    uint8 liquidHeight;
    float liquidLevel;
    std::unique_ptr<LiquidEntryType> liquidEntry;
    std::unique_ptr<LiquidFlagsType> liquidFlags;
    std::unique_ptr<LiquidMapType> liquidMap;
};

struct LoadedHoleData
{
    typedef std::array<uint16, 16 * 16> HolesType;

    HolesType holes;
};

enum LiquidStatus : uint32
{
    LIQUID_MAP_NO_WATER     = 0x00000000,
    LIQUID_MAP_ABOVE_WATER  = 0x00000001,
    LIQUID_MAP_WATER_WALK   = 0x00000002,
    LIQUID_MAP_IN_WATER     = 0x00000004,
    LIQUID_MAP_UNDER_WATER  = 0x00000008
};

struct LiquidData
{
    LiquidData() = default;

    uint32 Entry{ 0 };
    uint32 Flags{ 0 };
    float  Level{ INVALID_HEIGHT };
    float  DepthLevel{ INVALID_HEIGHT };
    LiquidStatus Status{ LIQUID_MAP_NO_WATER };
};

enum class TerrainMapDataReadResult
{
    Success,
    NotFound,
    ReadError,
    InvalidMagic,
    InvalidAreaData,
    InvalidHeightData,
    InvalidLiquidData,
    InvalidHoleData
};

class GridTerrainData
{
    bool LoadAreaData(std::ifstream& fileStream, uint32 const offset);
    bool LoadHeightData(std::ifstream& fileStream, uint32 const offset);
    bool LoadLiquidData(std::ifstream& fileStream, uint32 const offset);
    bool LoadHolesData(std::ifstream& fileStream, uint32 const offset);

    std::unique_ptr<LoadedAreaData> _loadedAreaData;
    std::unique_ptr<LoadedHeightData> _loadedHeightData;
    std::unique_ptr<LoadedLiquidData> _loadedLiquidData;
    std::unique_ptr<LoadedHoleData> _loadedHoleData;

    bool isHole(int row, int col) const;

    // Get height functions and pointers
    typedef float (GridTerrainData::* GetHeightPtr) (float x, float y) const;
    GetHeightPtr _gridGetHeight;
    float getHeightFromFloat(float x, float y) const;
    float getHeightFromUint16(float x, float y) const;
    float getHeightFromUint8(float x, float y) const;
    float getHeightFromFlat(float x, float y) const;

public:
    GridTerrainData();
    ~GridTerrainData() { };
    TerrainMapDataReadResult Load(std::string const& mapFileName);

    uint16 getArea(float x, float y) const;
    inline float getHeight(float x, float y) const { return (this->*_gridGetHeight)(x, y); }
    float getMinHeight(float x, float y) const;
    float getLiquidLevel(float x, float y) const;
    LiquidData const GetLiquidData(float x, float y, float z, float collisionHeight, Optional<uint8> ReqLiquidType) const;
};

#endif
