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

#include "MMapFactory.h"
#include <cstring>
namespace MMAP
{
    // ######################## MMapFactory ########################
    // our global singleton copy
    MMapMgr* g_MMapMgr = nullptr;
    bool MMapFactory::forbiddenMaps[1000] = {0};

    MMapMgr* MMapFactory::createOrGetMMapMgr()
    {
        if (!g_MMapMgr)
        {
            g_MMapMgr = new MMapMgr();
        }

        return g_MMapMgr;
    }

    void MMapFactory::InitializeDisabledMaps()
    {
        memset(&forbiddenMaps, 0, sizeof(forbiddenMaps));
        int32 f[] = {616 /*EoE*/, 649 /*ToC25*/, 650 /*ToC5*/, -1};
        uint32 i = 0;
        while (f[i] >= 0)
        {
            forbiddenMaps[f[i++]] = true;
        }
    }

    void MMapFactory::clear()
    {
        if (g_MMapMgr)
        {
            delete g_MMapMgr;
            g_MMapMgr = nullptr;
        }
    }
}
