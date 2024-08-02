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
#include "Errors.h"
#include "Log.h"
#include "StringFormat.h"

WardenPayloadMgr::WardenPayloadMgr() { }

uint16 WardenPayloadMgr::GetFreePayloadId()
{
    uint16 payloadId = WardenPayloadOffsetMin;

    while (CachedChecks.find(payloadId) != CachedChecks.end())
    {
        payloadId++;

        if (payloadId > WardenPayloadMgr::WardenPayloadOffsetMax)
        {
            LOG_ERROR("warden", "Max warden payload id of '{}' passed!", WardenPayloadMgr::WardenPayloadOffsetMax);
            return 0;
        }
    }

    return payloadId;
}

uint16 WardenPayloadMgr::RegisterPayload(const std::string& payload)
{
    uint16 payloadId = GetFreePayloadId();

    if (!payloadId || !RegisterPayload(payload, payloadId, false))
    {
        LOG_ERROR("warden", "Failed to register payload.");
        return 0;
    }

    return payloadId;
}

bool WardenPayloadMgr::RegisterPayload(std::string const& payload, uint16 payloadId, bool replace)
{
    //Payload id should be over or equal to the offset to prevent conflicts.
    if (payloadId < WardenPayloadMgr::WardenPayloadOffsetMin)
    {
        LOG_ERROR("warden", "Tried to register payloadId lower than '{}'.", WardenPayloadMgr::WardenPayloadOffsetMin);
        return false;
    }

    auto it = CachedChecks.find(payloadId);
    if (it != CachedChecks.end() && !replace)
    {
        LOG_ERROR("warden", "Payload Id '{}' already exists in CachedChecks.", payloadId);
        return false;
    }

    WardenCheck wCheck;
    wCheck.Type = WardenPayloadMgr::WardenPayloadCheckType;
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

bool WardenPayloadMgr::UnregisterPayload(uint16 payloadId)
{
    return CachedChecks.erase(payloadId);
}

WardenCheck* WardenPayloadMgr::GetPayloadById(uint16 payloadId)
{
    auto it = CachedChecks.find(payloadId);

    if (it != CachedChecks.end())
    {
        return &it->second;
    }

    return nullptr;
}

void WardenPayloadMgr::QueuePayload(uint16 payloadId, bool pushToFront)
{
    auto it = CachedChecks.find(payloadId);

    //Do not queue a payload if there is no payload matching the payloadId.
    if (it == CachedChecks.end())
    {
        LOG_ERROR("warden", "Failed to queue payload id '{}' as it does not exist in CachedChecks.", payloadId);
        return;
    }

    if (pushToFront)
    {
        QueuedPayloads.push_front(payloadId);
    }
    else
    {
        QueuedPayloads.push_back(payloadId);
    }
}

bool WardenPayloadMgr::DequeuePayload(uint16 payloadId)
{
    std::size_t const queueSize = QueuedPayloads.size();
    QueuedPayloads.remove(payloadId);

    return queueSize != QueuedPayloads.size();
}

void WardenPayloadMgr::ClearQueuedPayloads()
{
    QueuedPayloads.clear();
}

uint32 WardenPayloadMgr::GetPayloadCountInQueue()
{
    return QueuedPayloads.size();
}

std::list<uint16>* WardenPayloadMgr::GetPayloadsInQueue()
{
    return &QueuedPayloads;
}
