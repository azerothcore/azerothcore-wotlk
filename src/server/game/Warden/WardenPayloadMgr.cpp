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

#include "WardenPayloadMgr.h"

WardenPayloadMgr::WardenPayloadMgr() { }

/**
* @brief Finds a free payload id in WardenWin::CachedChecks.
* @return uint16 The free payload id.
*/
uint16 WardenPayloadMgr::GetFreePayloadId()
{
    uint16 payloadId = WardenPayloadOffset;

    auto it = CachedChecks.find(payloadId);
    if (it != CachedChecks.end())
    {
        payloadId = std::prev(CachedChecks.end())->first + 1;
    }

    return payloadId;
}

/**
* @brief Register a payload into cache and returns its payload id.
* @param payload The payload to be stored in WardenWin::CachedChecks.
* @return uint16 The payload id for use with Warden::QueuePayload.
*/
uint16 WardenPayloadMgr::RegisterPayload(const std::string& payload)
{
    uint16 payloadId = GetFreePayloadId();

    WardenCheck wCheck;
    wCheck.Type = _luaCheckType;
    wCheck.Str = payload;
    wCheck.CheckId = payloadId;

    std::string idStr = Acore::StringFormat("%04u", payloadId);
    ASSERT(idStr.size() == 4);
    std::copy(idStr.begin(), idStr.end(), wCheck.IdStr.begin());

    CachedChecks.emplace(payloadId, wCheck);

    return payloadId;
}

/**
* @brief Register a payload with id into cache and returns the result.
* @param payload The payload to be stored in WardenWin::CachedChecks.
* @param payloadId The payload id to be stored as the key in WardenWin::CachedChecks.
* @param replace Whether the key should replace an existing entry value.
* @return bool The payload insertion result. If exists it will return false, otherwise true.
*/
bool WardenPayloadMgr::RegisterPayload(std::string const& payload, uint16 payloadId, bool replace)
{
    auto it = CachedChecks.find(payloadId);

    if (it != CachedChecks.end() && !replace)
    {
        return false;
    }

    WardenCheck wCheck;
    wCheck.Type = _luaCheckType;
    wCheck.Str = payload;
    wCheck.CheckId = payloadId;

    std::string idStr = Acore::StringFormat("%04u", payloadId);
    ASSERT(idStr.size() == 4);
    std::copy(idStr.begin(), idStr.end(), wCheck.IdStr.begin());

    if (replace)
    {
        CachedChecks.erase(payloadId);
    }

    CachedChecks.emplace(payloadId, wCheck);

    return true;
}

/**
* @brief Unregister a payload from cache and return if successful.
* @param payloadId The payload to removed from WardenWin::CachedChecks.
* @return bool If the payloadId was present.
*/
bool WardenPayloadMgr::UnregisterPayload(uint16 payloadId)
{
    return CachedChecks.erase(payloadId);
}

/**
* @brief Get a payload by id from the WardenWin::CachedChecks.
* @param payloadId The payload to fetched from WardenWin::CachedChecks.
* @return WardenCheck* A pointer to the WardenCheck payload.
*/
WardenCheck* WardenPayloadMgr::GetPayloadById(uint16 payloadId)
{
    auto it = CachedChecks.find(payloadId);

    if (it != CachedChecks.end())
    {
        return &it->second;
    }

    return nullptr;
}

/**
* @brief Queue the payload into the normal warden checks.
* @param payloadId The payloadId to be queued.
*/
void WardenPayloadMgr::QueuePayload(uint16 payloadId)
{
    QueuedPayloads.push_back(payloadId);
}

/**
* @brief Dequeue the payload from the WardenWin::_QueuedPayloads queue.
* @param payloadId The payloadId to be dequeued.
* @return bool If the payload was removed.
*/
bool WardenPayloadMgr::DequeuePayload(uint16 payloadId)
{
    size_t const queueSize = QueuedPayloads.size();
    QueuedPayloads.remove(payloadId);

    return queueSize != QueuedPayloads.size();
}

/**
* @brief Clear the payloads from the WardenWin::_QueuedPayloads queue.
*/
void WardenPayloadMgr::ClearQueuedPayloads()
{
    QueuedPayloads.clear();
}

/**
* @brief Get the amount of payloads waiting in WardenWin::_QueuedPayloads.
* @return The amount of payloads in queue.
*/
uint32 WardenPayloadMgr::GetPayloadsInQueue()
{
    return QueuedPayloads.size();
}
