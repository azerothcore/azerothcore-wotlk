/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2020 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DBCDatabaseLoader_h__
#define DBCDatabaseLoader_h__

#include "DBCFileLoader.h"
#include <string>
#include <vector>

struct DBCDatabaseLoader
{
    DBCDatabaseLoader(char const* dbTable, char const* dbcFormatString, std::vector<char*>& stringPool);

    char* Load(uint32& records, char**& indexTable);

private:
    char const* _sqlTableName;
    char const* _dbcFormat;
    int32 _sqlIndexPos;
    uint32 _recordSize;
    std::vector<char*>& _stringPool;
    char* CloneStringToPool(std::string const& str);

    DBCDatabaseLoader(DBCDatabaseLoader const& right) = delete;
    DBCDatabaseLoader& operator=(DBCDatabaseLoader const& right) = delete;
};

#endif // DBCDatabaseLoader_h__
