/*
 * Lightweight runtime mapper for Items: DB GUID (uint64) <-> transient Low GUID (uint32)
 */

#include "ItemGuidMap.h"

ItemGuidMap* ItemGuidMap::instance()
{
    // Function-local static to respect the private constructor
    static ItemGuidMap s_Instance;
    return &s_Instance;
}

uint32_t ItemGuidMap::NextLow()
{
    // Simple monotonically increasing counter with free-list reuse
    if (!_free.empty())
    {
        uint32_t id = _free.front();
        _free.pop();
        return id;
    }
    // wrap-around protection is not handled here; upper layers should ensure recyclable usage
    return _next++;
}

uint32_t ItemGuidMap::Acquire(uint64_t dbGuid)
{
    std::lock_guard<std::mutex> g(_mtx);
    auto it = _dbToLow.find(dbGuid);
    if (it != _dbToLow.end())
        return it->second;
    uint32_t low = NextLow();
    _dbToLow.emplace(dbGuid, low);
    return low;
}

uint32_t ItemGuidMap::AcquireForNew()
{
    std::lock_guard<std::mutex> g(_mtx);
    return NextLow();
}

void ItemGuidMap::Bind(uint64_t dbGuid, uint32_t lowGuid)
{
    std::lock_guard<std::mutex> g(_mtx);
    _dbToLow[dbGuid] = lowGuid;
}

void ItemGuidMap::Release(uint64_t dbGuid)
{
    std::lock_guard<std::mutex> g(_mtx);
    auto it = _dbToLow.find(dbGuid);
    if (it != _dbToLow.end())
    {
        _free.push(it->second);
        _dbToLow.erase(it);
    }
}
