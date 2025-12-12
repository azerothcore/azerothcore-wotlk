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

#ifndef _IMMAPMANAGER_H
#define _IMMAPMANAGER_H

// Interface for IMMapManger
namespace MMAP
{
    enum MMAP_LOAD_RESULT
    {
        MMAP_LOAD_RESULT_ERROR,
        MMAP_LOAD_RESULT_OK,
        MMAP_LOAD_RESULT_IGNORED,
    };

    class IMMapMgr
    {
    private:
        bool iEnablePathFinding;

    public:
        IMMapMgr() : iEnablePathFinding(true) {}
        virtual ~IMMapMgr(void) {}

        //Enabled/Disabled Pathfinding
        void setEnablePathFinding(bool value) { iEnablePathFinding = value; }
        bool isEnablePathFinding() const { return (iEnablePathFinding); }
    };
}

#endif
