/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
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

uint32 MySQL::GetLibraryVersion()
{
    return MYSQL_VERSION_ID;
}
