/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef WDTFILE_H
#define WDTFILE_H

#include "mpq_libmpq04.h"
#include "wmo.h"
#include <string>
#include "stdlib.h"

class ADTFile;

class WDTFile
{
private:
    MPQFile WDT;
    string filename;
public:
    WDTFile(char* file_name, char* file_name1);
    ~WDTFile(void);
    bool init(char* map_id, unsigned int mapID);

    string* gWmoInstansName;
    int gnWMO;

    ADTFile* GetMap(int x, int z);
};

#endif
