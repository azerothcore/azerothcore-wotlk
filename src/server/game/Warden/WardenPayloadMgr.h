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

#ifndef _WARDEN_PAYLOAD_MGR_H
#define _WARDEN_PAYLOAD_MGR_H

#include "WardenCheckMgr.h"
#include <list>

class WardenPayloadMgr
{
public:
    WardenPayloadMgr();

    uint16 GetFreePayloadId();
    uint16 RegisterPayload(const std::string& payload);
    bool RegisterPayload(std::string const& payload, uint16 payloadId, bool replace = false);
    bool UnregisterPayload(uint16 payloadId);
    WardenCheck* GetPayloadById(uint16 payloadId);
    void QueuePayload(uint16 payloadId);
    bool DequeuePayload(uint16 payloadId);
    void ClearQueuedPayloads();
    uint32 GetPayloadsInQueue();

    static uint16 constexpr WardenPayloadOffset = 5000;

    std::list<uint16> QueuedPayloads;
    std::map<uint16, WardenCheck> CachedChecks;

private:
    uint32 const _luaCheckType = 139;
};

#endif // _WARDEN_PAYLOAD_MGR_H
