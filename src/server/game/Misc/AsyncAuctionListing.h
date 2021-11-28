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

#ifndef __ASYNCAUCTIONLISTING_H
#define __ASYNCAUCTIONLISTING_H

#include "AuctionHouseMgr.h"

#include <mutex>

class AuctionListOwnerItemsDelayEvent : public BasicEvent
{
public:
    AuctionListOwnerItemsDelayEvent(ObjectGuid _creatureGuid, ObjectGuid guid, bool o) : creatureGuid(_creatureGuid), playerguid(guid), owner(o) {}
    ~AuctionListOwnerItemsDelayEvent() override {}

    bool Execute(uint64 e_time, uint32 p_time) override;
    void Abort(uint64 /*e_time*/) override {}
    bool getOwner() { return owner; }

private:
    ObjectGuid creatureGuid;
    ObjectGuid playerguid;
    bool owner;
};

class AuctionListItemsDelayEvent
{
public:
    AuctionListItemsDelayEvent(uint32 msTimer, ObjectGuid playerguid, ObjectGuid creatureguid, std::string searchedname, uint32 listfrom, uint8 levelmin, uint8 levelmax,
        uint8 usable, uint32 auctionSlotID, uint32 auctionMainCategory, uint32 auctionSubCategory, uint32 quality, uint8 getAll, AuctionSortOrderVector sortOrder) :
        _msTimer(msTimer), _playerguid(playerguid), _creatureguid(creatureguid), _searchedname(searchedname), _listfrom(listfrom), _levelmin(levelmin), _levelmax(levelmax),_usable(usable),
        _auctionSlotID(auctionSlotID), _auctionMainCategory(auctionMainCategory), _auctionSubCategory(auctionSubCategory), _quality(quality), _getAll(getAll), _sortOrder(sortOrder) { }

    bool Execute();

    uint32 _msTimer;
    ObjectGuid _playerguid;
    ObjectGuid _creatureguid;
    std::string _searchedname;
    uint32 _listfrom;
    uint8 _levelmin;
    uint8 _levelmax;
    uint8 _usable;
    uint32 _auctionSlotID;
    uint32 _auctionMainCategory;
    uint32 _auctionSubCategory;
    uint32 _quality;
    uint8 _getAll;
    AuctionSortOrderVector _sortOrder;
};

class AsyncAuctionListingMgr
{
public:
    static void Update(uint32 diff) { auctionListingDiff += diff; }
    static uint32 GetDiff() { return auctionListingDiff; }
    static void ResetDiff() { auctionListingDiff = 0; }
    static bool IsAuctionListingAllowed() { return auctionListingAllowed; }
    static void SetAuctionListingAllowed(bool a) { auctionListingAllowed = a; }

    static std::list<AuctionListItemsDelayEvent>& GetList() { return auctionListingList; }
    static std::list<AuctionListItemsDelayEvent>& GetTempList() { return auctionListingListTemp; }
    static std::mutex& GetLock() { return auctionListingLock; }
    static std::mutex& GetTempLock() { return auctionListingTempLock; }

private:
    static uint32 auctionListingDiff;
    static bool auctionListingAllowed;
    static std::list<AuctionListItemsDelayEvent> auctionListingList;
    static std::list<AuctionListItemsDelayEvent> auctionListingListTemp;
    static std::mutex auctionListingLock;
    static std::mutex auctionListingTempLock;
};

#endif
