/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _MYSQLTHREADING_H
#define _MYSQLTHREADING_H

#include "Log.h"

namespace MySQL
{
    void Library_Init();
    void Library_End();
    uint32 GetLibraryVersion();
}

#endif
