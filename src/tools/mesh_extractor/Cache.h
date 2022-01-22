/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef CACHE_H
#define CACHE_H
#include "Define.h"
#include "Model.h"
#include "PolicyLock.h"
#include "WorldModelRoot.h"
#include <map>
#include <mutex>
#include <string>

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
