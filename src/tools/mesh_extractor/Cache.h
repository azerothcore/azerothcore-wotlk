/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef CACHE_H
#define CACHE_H
#include <string>
#include <map>
#include "Define.h"
#include "PolicyLock.h"
#include <mutex>
#include "WorldModelRoot.h"
#include "Model.h"

template<class K, class T>
class GenericCache
{
public:
    GenericCache() {}

    static const uint32 FlushLimit = 300; // We can't get too close to filling up all the memory, and we have to be wary of the maximum number of open streams.

    void Insert(K key, T* val)
    {
        std::lock_guard<std::mutex> guard(mutex);

        if (_items.size() > FlushLimit)
            Clear();
        _items[key] = val;
    }

    T* Get(K key)
    {
        GUARD_RETURN(mutex, nullptr);
        typename std::map<K, T*>::iterator itr = _items.find(key);
        if (itr != _items.end())
            return itr->second;
        return nullptr;
    }

    void Clear()
    {
        for (typename std::map<K, T*>::iterator itr = _items.begin(); itr != _items.end(); ++itr)
            delete itr->second;
        _items.clear();
    }
private:
    std::map<K, T*> _items;
    std::mutex mutex;
};

class CacheClass
{
public:
    CacheClass() {}
    GenericCache<std::string, Model> ModelCache;
    GenericCache<std::string, WorldModelRoot> WorldModelCache;

    void Clear()
    {
        ModelCache.Clear();
        WorldModelCache.Clear();
    }
};

extern CacheClass* Cache;
#endif
