/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "MySQLThreading.h"
#include "Log.h"
#include <mysql.h>

void MySQL::Library_Init()
{
    mysql_library_init(-1, nullptr, nullptr);
}

void MySQL::Library_End()
{
    mysql_library_end();
}

uint32 MySQL::GetLibraryVersion()
{
    return MYSQL_VERSION_ID;
}
