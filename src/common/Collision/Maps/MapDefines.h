/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 or later license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 * Copyright (C) 2008+  TrinityCore <http://www.trinitycore.org/>
 */

#ifndef _MAPDEFINES_H
#define _MAPDEFINES_H

#include "Define.h"
#include "DetourNavMesh.h"

#define MAX_NUMBER_OF_GRIDS      64
#define SIZE_OF_GRIDS            533.3333f

#define MMAP_MAGIC 0x4d4d4150   // 'MMAP'
#define MMAP_VERSION 14

struct MmapTileHeader
{
    uint32 mmapMagic{MMAP_MAGIC};
    uint32 dtVersion;
    uint32 mmapVersion{MMAP_VERSION};
    uint32 size{0};
    char usesLiquids{true};
    char padding[3] {};

    MmapTileHeader() : dtVersion(DT_NAVMESH_VERSION) { }
};

// All padding fields must be handled and initialized to ensure mmaps_generator will produce binary-identical *.mmtile files
static_assert(sizeof(MmapTileHeader) == 20, "MmapTileHeader size is not correct, adjust the padding field size");
static_assert(sizeof(MmapTileHeader) == (sizeof(MmapTileHeader::mmapMagic) +
              sizeof(MmapTileHeader::dtVersion) +
              sizeof(MmapTileHeader::mmapVersion) +
              sizeof(MmapTileHeader::size) +
              sizeof(MmapTileHeader::usesLiquids) +
              sizeof(MmapTileHeader::padding)), "MmapTileHeader has uninitialized padding fields");

enum NavArea
{
    NAV_AREA_EMPTY          = 0,
    // areas 1-60 will be used for destructible areas (currently skipped in vmaps, WMO with flag 1)
    // ground is the highest value to make recast choose ground over water when merging surfaces very close to each other (shallow water would be walkable)
    NAV_AREA_GROUND         = 11,
    NAV_AREA_GROUND_STEEP   = 10,
    NAV_AREA_WATER          = 9,
    NAV_AREA_MAGMA_SLIME    = 8, // don't need to differentiate between them
    NAV_AREA_MAX_VALUE      = NAV_AREA_GROUND,
    NAV_AREA_MIN_VALUE      = NAV_AREA_MAGMA_SLIME,
    NAV_AREA_ALL_MASK       = 0x3F // max allowed value
};

enum NavTerrainFlag
{
    NAV_EMPTY        = 0x00,
    NAV_GROUND       = 1 << (NAV_AREA_MAX_VALUE - NAV_AREA_GROUND),
    NAV_GROUND_STEEP = 1 << (NAV_AREA_MAX_VALUE - NAV_AREA_GROUND_STEEP),
    NAV_WATER        = 1 << (NAV_AREA_MAX_VALUE - NAV_AREA_WATER),
    NAV_MAGMA_SLIME  = 1 << (NAV_AREA_MAX_VALUE - NAV_AREA_MAGMA_SLIME)
};

#endif /* _MAPDEFINES_H */
