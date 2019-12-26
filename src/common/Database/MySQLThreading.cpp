/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "MySQLThreading.h"
#include "MySQLWorkaround.h"

void MySQL::Library_Init()
{
    mysql_library_init(-1, nullptr, nullptr);
}

void MySQL::Library_End()
{
    mysql_library_end();
}

char const* MySQL::GetLibraryVersion()
{
    return MYSQL_SERVER_VERSION;
}
