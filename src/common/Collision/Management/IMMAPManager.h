/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _IMMAPMANAGER_H
#define _IMMAPMANAGER_H

#include <string>
#include "Define.h"

// Interface for IMMapManger
namespace MMAP
{
    enum MMAP_LOAD_RESULT
    {
        MMAP_LOAD_RESULT_ERROR,
        MMAP_LOAD_RESULT_OK,
        MMAP_LOAD_RESULT_IGNORED,
    };

    class IMMapManager
    {
        private:
            bool iEnablePathFinding;

        public:
            IMMapManager() : iEnablePathFinding(true) {}
            virtual ~IMMapManager(void) {}

            //Enabled/Disabled Pathfinding
            void setEnablePathFinding(bool value) { iEnablePathFinding = value; }
            bool isEnablePathFinding() const { return (iEnablePathFinding); }
    };
}

#endif