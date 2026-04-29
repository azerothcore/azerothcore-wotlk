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

#ifndef _VMAPMANAGER2_H
#define _VMAPMANAGER2_H

#include "IVMapMgr.h"

//===========================================================

#define MAP_FILENAME_EXTENSION2 ".vmtree"

#define FILENAMEBUFFER_SIZE 500

/**
This is the main Class to manage loading and unloading of maps, line of sight, height calculation and so on.
For each map or map tile to load it reads a directory file that contains the ModelContainer files used by this map or map tile.
Each global map or instance has its own dynamic BSP-Tree.
The loaded ModelContainers are included in one of these BSP-Trees.
Additionally a table to match map ids and map names is used.
*/

//===========================================================

namespace G3D
{
    class Vector3;
}

namespace VMAP
{
    enum DisableTypes
    {
        VMAP_DISABLE_AREAFLAG       = 0x1,
        VMAP_DISABLE_HEIGHT         = 0x2,
        VMAP_DISABLE_LOS            = 0x4,
        VMAP_DISABLE_LIQUIDSTATUS   = 0x8
    };

    class VMapMgr2 : public IVMapMgr
    {
    protected:
        static uint32 GetLiquidFlagsDummy(uint32) { return 0; }
        static bool IsVMAPDisabledForDummy(uint32 /*entry*/, uint8 /*flags*/) { return false; }

    public:
        // public for debug
        static G3D::Vector3 convertPositionToInternalRep(float x, float y, float z);
        static std::string getMapFileName(unsigned int mapId);

        VMapMgr2();
        ~VMapMgr2() override;

        bool processCommand(char* /*command*/) override { return false; } // for debug and extensions

        // what's the use of this? o.O
        [[nodiscard]] std::string getDirFileName(unsigned int mapId, int /*x*/, int /*y*/) const override
        {
            return getMapFileName(mapId);
        }
        LoadResult existsMap(const char* basePath, unsigned int mapId, int x, int y) override;

        typedef uint32(*GetLiquidFlagsFn)(uint32 liquidType);
        GetLiquidFlagsFn GetLiquidFlagsPtr;

        typedef bool(*IsVMAPDisabledForFn)(uint32 entry, uint8 flags);
        IsVMAPDisabledForFn IsVMAPDisabledForPtr;
    };
}

#endif
