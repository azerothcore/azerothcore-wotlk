/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008+  TrinityCore <http://www.trinitycore.org/>
 */

#ifndef _MAPDEFINES_H
#define _MAPDEFINES_H

#include "Define.h"
#include "DetourNavMesh.h"

#define MAX_NUMBER_OF_GRIDS      64
#define SIZE_OF_GRIDS            533.3333f

#define MMAP_MAGIC 0x4d4d4150   // 'MMAP'
#define MMAP_VERSION 15

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

enum NavTerrain
{
    NAV_EMPTY   = 0x00,
    NAV_GROUND  = 0x01,
    NAV_MAGMA   = 0x02,
    NAV_SLIME   = 0x04,
    NAV_WATER   = 0x08,
    NAV_UNUSED1 = 0x10,
    NAV_UNUSED2 = 0x20,
    NAV_UNUSED3 = 0x40,
    NAV_UNUSED4 = 0x80
                  // we only have 8 bits
};

#endif /* _MAPDEFINES_H */
