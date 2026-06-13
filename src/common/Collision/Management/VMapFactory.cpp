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

#include "VMapFactory.h"
#include "VMapMgr2.h"

namespace VMAP
{
    VMapMgr2* gVMapMgr = nullptr;

    //===============================================
    // just return the instance
    VMapMgr2* VMapFactory::createOrGetVMapMgr()
    {
        if (!gVMapMgr)
        {
            gVMapMgr = new VMapMgr2();
        }

        return gVMapMgr;
    }

    //===============================================
    // delete all internal data structures
    void VMapFactory::clear()
    {
        delete gVMapMgr;
        gVMapMgr = nullptr;
    }
}
