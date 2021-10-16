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

#ifndef _MMAP_FACTORY_H
#define _MMAP_FACTORY_H

#include "DetourAlloc.h"
#include "DetourExtended.h"
#include "DetourNavMesh.h"
#include "MMapMgr.h"
#include <unordered_map>

namespace MMAP
{
    enum MMAP_LOAD_RESULT
    {
        MMAP_LOAD_RESULT_ERROR,
        MMAP_LOAD_RESULT_OK,
        MMAP_LOAD_RESULT_IGNORED,
    };

    // static class
    // holds all mmap global data
    // access point to MMapMgr singleton
    class MMapFactory
    {
    public:
        static MMapMgr* createOrGetMMapMgr();
        static void clear();
        static void InitializeDisabledMaps();
        static bool forbiddenMaps[1000];
    };
}

#endif
