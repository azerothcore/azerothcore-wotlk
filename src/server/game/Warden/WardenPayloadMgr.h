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

 /**
 * @class WardenPayloadMgr
 * @brief The WardenPayloadMgr is responsible for maintaining custom payloads used by modules.
 */
class WardenPayloadMgr
{
public:
    WardenPayloadMgr();

    /**
    * @brief Finds a free payload id in WardenPayloadMgr::CachedChecks.
    * @return uint16 The free payload id. Returns 0 if there is no free id.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * uint16 payloadId = payloadMgr->GetFreePayloadId();
    * if(payloadId)
    * {
    *   //payloadId is free.
    * }
    * @endcode
    */
    uint16 GetFreePayloadId();

    /**
    * @brief Register a payload into cache and returns its payload id.
    * @param payload The payload to be stored in WardenPayloadMgr::CachedChecks.
    * @return uint16 The payload id for use with WardenPayloadMgr::QueuePayload. Returns 0 if it failed to register.
    * @note
    * - Payloads are truncated to 512 bytes on the client, you may have to register your payloads in chunks if they are larger than this.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * uint16 payloadId = payloadMgr->RegisterPayload("message('Hello World!');");
    * payloadMgr->QueuePayload(payloadId);
    * @endcode
    */
    uint16 RegisterPayload(const std::string& payload);

    /**
    * @brief Register a payload into cache with a custom id and returns the result.
    * @param payload The payload to be stored in WardenPayloadMgr::CachedChecks.
    * @param payloadId The payload id to be stored as the key in WardenPayloadMgr::CachedChecks.
    * @param replace Whether the key should replace an existing entry value.
    * @return bool The payload insertion result. If exists it will return false, otherwise true.
    * @note
    * - Payloads are truncated to 512 bytes on the client, you may have to register your payloads in chunks if they are larger than this.
    * - It's a good idea to keep the value for payloadId between 9000-9999 for self defined payloads as they're the least likely occupied ids.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * bool result = payloadMgr->RegisterPayload("message('Hello World!');", 5000, false);
    * if(result)
    * {
    *   payloadMgr->QueuePayload(payloadId);
    * }
    * @endcode
    */
    bool RegisterPayload(std::string const& payload, uint16 payloadId, bool replace = false);

    /**
    * @brief Unregister a payload from cache and return if successful.
    * @param payloadId The payload to removed from WardenPayloadMgr::CachedChecks.
    * @return bool If the payloadId was present.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * bool result = payloadMgr->UnregisterPayload(5000);
    * @endcode
    */
    bool UnregisterPayload(uint16 payloadId);

    /**
    * @brief Get a payload by id from the WardenPayloadMgr::CachedChecks.
    * @param payloadId The payload to fetched from WardenPayloadMgr::CachedChecks.
    * @return WardenCheck* A pointer to the WardenCheck payload.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * WardenCheck* payload = payloadMgr->GetPayloadById(5000);
    * if(payload)
    * {
    *   //Use payload
    * }
    * @endcode
    */
    WardenCheck* GetPayloadById(uint16 payloadId);

    /**
    * @brief Queue the payload into the normal warden checks.
    * @param payloadId The payloadId to be queued.
    * @param pushToFront If payload should be pushed to the front queue.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * //Queues the payload id at the back of the queue.
    * payloadMgr->QueuePayload(5000, false);
    * @endcode
    */
    void QueuePayload(uint16 payloadId, bool pushToFront = false);

    /**
    * @brief Dequeue the payload from the WardenPayloadMgr::QueuedPayloads queue.
    * @param payloadId The payloadId to be dequeued.
    * @return bool If the payload was removed.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * //Removes the payload id from the queue.
    * bool result = payloadMgr->DequeuePayload(5000);
    * if(result)
    * {
    *   //Payload id 5000 is now free.
    * }
    * @endcode
    */
    bool DequeuePayload(uint16 payloadId);

    /**
    * @brief Clear the payloads from the WardenPayloadMgr::QueuedPayloads queue.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * //Clears all of the payload ids from the queue.
    * payloadMgr->ClearQueuedPayloads();
    * @endcode
    */
    void ClearQueuedPayloads();

    /**
    * @brief Get the amount of payloads waiting in WardenPayloadMgr::QueuedPayloads.
    * @return The amount of payloads in queue.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * //Gets the payload id count from the queue.
    * uint32 count = payloadMgr->GetPayloadCountInQueue();
    * @endcode
    */
    uint32 GetPayloadCountInQueue();

    /**
    * @brief Get payloads waiting in WardenPayloadMgr::QueuedPayloads.
    * @return The payloads in queue.
    *
    * <b>Example:</b>
    * @code{.cpp}
    * //Gets the payload ids from the queue.
    * std::list<uint16>* payloads = payloadMgr->GetPayloadsInQueue();
    * @endcode
    */
    std::list<uint16>* GetPayloadsInQueue();

    /**
    * @brief The minimum id available for custom payloads.
    */
    static uint16 constexpr WardenPayloadOffsetMin = 5000;

    /**
    * @brief The maximum id available for custom payloads.
    */
    static uint16 constexpr WardenPayloadOffsetMax = 9999;

    /**
    * @brief The checktype used for warden payloads.
    */
    static uint32 constexpr WardenPayloadCheckType = 139;

    /**
    * @brief The list of currently queued payload ids to be sent through Warden.
    */
    std::list<uint16> QueuedPayloads;

    /**
    * @brief The cached payloads that are accessed by payload id.
    */
    std::map<uint16, WardenCheck> CachedChecks;
};

#endif // _WARDEN_PAYLOAD_MGR_H
