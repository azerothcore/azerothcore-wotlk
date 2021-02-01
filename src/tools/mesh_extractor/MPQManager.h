/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef MPQ_MANAGER_H
#define MPQ_MANAGER_H

#include "MPQ.h"
#include "PolicyLock.h"
#include <mutex>
#include <set>
#include <map>

class DBC;
class MPQManager
{
public:
    MPQManager() {}
    ~MPQManager() {}

    void Initialize();
    FILE* GetFile(const std::string& path);
    FILE* GetFileFrom(const std::string& path, MPQArchive* file);
    DBC* GetDBC(const std::string& name);
    std::vector<std::string> GetAllFiles(std::string extension);

    std::deque<MPQArchive*> Archives;
    int32 BaseLocale;
    std::set<uint32> AvailableLocales;
    std::map<uint32, MPQArchive*> LocaleFiles;

    static char const* Files[];
    static char const* Languages[];
protected:
    void InitializeDBC();
private:
    std::mutex mutex;
};

extern MPQManager* MPQHandler;
#endif