/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef WDTFILE_H
#define WDTFILE_H

#include "mpq_libmpq04.h"
#include "wmo.h"
#include <cstdlib>
#include <string>

class ADTFile;

class WDTFile
{
public:
    WDTFile(char* file_name, char* file_name1);
    ~WDTFile(void);

    bool init(uint32 mapId);
    ADTFile* GetMap(int x, int z);

    std::vector<std::string> _wmoNames;

private:
    MPQFile _file;
    std::string filename;
};

#endif
