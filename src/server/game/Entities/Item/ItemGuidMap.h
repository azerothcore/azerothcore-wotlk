/*
 * Lightweight runtime mapper for Items: DB GUID (uint64) <-> transient Low GUID (uint32)
 */

#pragma once

#include <cstdint>
#include <unordered_map>
#include <queue>
#include <mutex>
#include <atomic>

class ItemGuidMap
{
public:
    static ItemGuidMap* instance();

    // Acquire or create a low-guid for a persistent db-guid
    uint32_t Acquire(uint64_t dbGuid);

    // Reserve a new low-guid for a brand new, unsaved item (dbGuid not known yet)
    uint32_t AcquireForNew();

    // Bind a db-guid to an already reserved low-guid (used after first save assigns dbGuid)
    void Bind(uint64_t dbGuid, uint32_t lowGuid);

    // Release mapping and recycle low-guid
    void Release(uint64_t dbGuid);

    // Initialize the starting value for persistent DB GUID generator
    void InitDbGuidSeed(uint64_t start)
    {
        std::lock_guard<std::mutex> g(_mtx);
        if (_nextDbGuid.load() == 0 || start > _nextDbGuid.load())
            _nextDbGuid.store(start);
    }

    // Get next persistent DB GUID
    uint64_t AcquireDbGuid()
    {
        return _nextDbGuid.fetch_add(1, std::memory_order_relaxed);
    }

private:
    ItemGuidMap() = default;

    uint32_t NextLow();

    std::unordered_map<uint64_t, uint32_t> _dbToLow;
    std::queue<uint32_t> _free;
    uint32_t _next{1};
    std::mutex _mtx;
    std::atomic<uint64_t> _nextDbGuid{0};
};

#define sItemGuidMap ItemGuidMap::instance()
