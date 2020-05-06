/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#define _CRT_SECURE_NO_DEPRECATE

#include "loadlib.h"
#include "mpq_libmpq04.h"
#include <cstdio>

class MPQFile;

u_map_fcc MverMagic = { {'R','E','V','M'} };

FileLoader::FileLoader()
{
    data = 0;
    data_size = 0;
    version = 0;
}

FileLoader::~FileLoader()
{
    free();
}

bool FileLoader::loadFile(std::string const& fileName, bool log)
{
    free();
    MPQFile mf(fileName.c_str());
    if(mf.isEof())
    {
        if (log)
            printf("No such file %s\n", fileName.c_str());
        return false;
    }

    data_size = mf.getSize();

    data = new uint8 [data_size];
    mf.read(data, data_size);
    mf.close();
    if (prepareLoadedData())
        return true;

    printf("Error loading %s", fileName.c_str());
    mf.close();
    free();
    return false;
}

bool FileLoader::prepareLoadedData()
{
    // Check version
    version = (file_MVER *) data;
    if (version->fcc != MverMagic.fcc)
        return false;
    if (version->ver != FILE_FORMAT_VERSION)
        return false;
    return true;
}

void FileLoader::free()
{
    delete[] data;
    data = 0;
    data_size = 0;
    version = 0;
}
