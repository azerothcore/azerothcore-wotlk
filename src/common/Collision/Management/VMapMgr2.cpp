/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "VMapMgr2.h"
#include "Errors.h"
#include "MapDefines.h"
#include "MapTree.h"
#include <G3D/Vector3.h>
#include <iomanip>
#include <sstream>
#include <string>

using G3D::Vector3;

namespace VMAP
{
    VMapMgr2::VMapMgr2()
    {
        GetLiquidFlagsPtr = &GetLiquidFlagsDummy;
        IsVMAPDisabledForPtr = &IsVMAPDisabledForDummy;
    }

    VMapMgr2::~VMapMgr2()
    {
    }

    Vector3 VMapMgr2::convertPositionToInternalRep(float x, float y, float z)
    {
        Vector3 pos;
        const float mid = 0.5f * MAX_NUMBER_OF_GRIDS * SIZE_OF_GRIDS;
        pos.x = mid - x;
        pos.y = mid - y;
        pos.z = z;

        return pos;
    }

    // move to MapTree too?
    std::string VMapMgr2::getMapFileName(unsigned int mapId)
    {
        std::stringstream fname;
        fname.width(3);
        fname << std::setfill('0') << mapId << std::string(MAP_FILENAME_EXTENSION2);

        return fname.str();
    }

    LoadResult VMapMgr2::existsMap(const char* basePath, unsigned int mapId, int x, int y)
    {
        return StaticMapTree::CanLoadMap(std::string(basePath), mapId, x, y);
    }

} // namespace VMAP
