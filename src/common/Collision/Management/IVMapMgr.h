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

#ifndef _IVMAPMANAGER_H
#define _IVMAPMANAGER_H

#include "Define.h"
#include "ModelIgnoreFlags.h"
#include "Optional.h"
#include <string>

//===========================================================

/**
This is the minimum interface to the VMapMamager.
*/

namespace VMAP
{
    class StaticMapTree;

    enum VMAP_LOAD_RESULT
    {
        VMAP_LOAD_RESULT_ERROR,
        VMAP_LOAD_RESULT_OK,
        VMAP_LOAD_RESULT_IGNORED
    };

    enum class LoadResult : uint8
    {
        Success,
        FileNotFound,
        VersionMismatch
    };

    #define VMAP_INVALID_HEIGHT       -100000.0f            // for check
    #define VMAP_INVALID_HEIGHT_VALUE -200000.0f            // real assigned value in unknown height case

    struct AreaAndLiquidData
    {
        struct AreaInfo
        {
            AreaInfo() = default;
            AreaInfo(int32 _groupId, int32 _adtId, int32 _rootId, uint32 _mogpFlags, uint32 _uniqueId)
                : groupId(_groupId), adtId(_adtId), rootId(_rootId), mogpFlags(_mogpFlags), uniqueId(_uniqueId) { }
            int32 groupId = 0;
            int32 adtId = 0;
            int32 rootId = 0;
            uint32 mogpFlags = 0;
            uint32 uniqueId = 0;
        };

        struct LiquidInfo
        {
            LiquidInfo() = default;
            LiquidInfo(uint32 _type, float _level)
                : type(_type), level(_level) {}
            uint32 type = 0;
            float level = 0.0f;
        };

        float                floorZ = VMAP_INVALID_HEIGHT;
        Optional<AreaInfo>   areaInfo;
        Optional<LiquidInfo> liquidInfo;
    };

    //===========================================================
    class IVMapMgr
    {
    private:
        bool iEnableLineOfSightCalc{true};
        bool iEnableHeightCalc{true};

    public:
        IVMapMgr()  { }

        virtual ~IVMapMgr() = default;

        virtual LoadResult existsMap(const char* pBasePath, unsigned int pMapId, int x, int y) = 0;

        /**
        send debug commands
        */
        virtual bool processCommand(char* pCommand) = 0;

        /**
        Enable/disable LOS calculation
        It is enabled by default. If it is enabled in mid game the maps have to loaded manualy
        */
        void setEnableLineOfSightCalc(bool pVal) { iEnableLineOfSightCalc = pVal; }
        /**
        Enable/disable model height calculation
        It is enabled by default. If it is enabled in mid game the maps have to loaded manualy
        */
        void setEnableHeightCalc(bool pVal) { iEnableHeightCalc = pVal; }

        [[nodiscard]] bool isLineOfSightCalcEnabled() const { return (iEnableLineOfSightCalc); }
        [[nodiscard]] bool isHeightCalcEnabled() const { return (iEnableHeightCalc); }
        [[nodiscard]] bool isMapLoadingEnabled() const { return (iEnableLineOfSightCalc || iEnableHeightCalc  ); }

        [[nodiscard]] virtual std::string getDirFileName(unsigned int pMapId, int x, int y) const = 0;
    };
}

#endif
