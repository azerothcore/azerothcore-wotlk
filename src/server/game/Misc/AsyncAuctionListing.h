#ifndef __ASYNCAUCTIONLISTING_H
#define __ASYNCAUCTIONLISTING_H

#include "Common.h"
#include "EventProcessor.h"
#include "WorldPacket.h"

class AuctionListOwnerItemsDelayEvent : public BasicEvent
{
    public:
        AuctionListOwnerItemsDelayEvent(uint64 _creatureGuid, uint64 guid, bool o) : creatureGuid(_creatureGuid), playerguid(guid), owner(o) {}
        virtual ~AuctionListOwnerItemsDelayEvent() {}

        virtual bool Execute(uint64 e_time, uint32 p_time);
        virtual void Abort(uint64 /*e_time*/) {}
        bool getOwner() { return owner; }

    private:
        uint64 creatureGuid;
        uint64 playerguid;
        bool owner;
};

class AuctionListItemsDelayEvent
{
public:
    AuctionListItemsDelayEvent(uint32 msTimer, uint64 playerguid, uint64 creatureguid, std::string searchedname, uint32 listfrom, uint8 levelmin, uint8 levelmax, uint8 usable, uint32 auctionSlotID, uint32 auctionMainCategory, uint32 auctionSubCategory, uint32 quality, uint8 getAll) :
        _msTimer(msTimer), _playerguid(playerguid), _creatureguid(creatureguid), _searchedname(searchedname), _listfrom(listfrom), _levelmin(levelmin), _levelmax(levelmax), _usable(usable), _auctionSlotID(auctionSlotID), _auctionMainCategory(auctionMainCategory), _auctionSubCategory(auctionSubCategory), _quality(quality), _getAll(getAll) { }

    bool Execute();

    uint32 _msTimer;
    uint64 _playerguid;
    uint64 _creatureguid;
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
};

class AsyncAuctionListingMgr
{
public:
    static void Update(uint32 diff) { auctionListingDiff += diff; }
    static uint32 GetDiff() { return auctionListingDiff; }
    static void ResetDiff() { auctionListingDiff = 0; }
    static bool IsAuctionListingAllowed() { return auctionListingAllowed; }
    static void SetAuctionListingAllowed(bool a) { auctionListingAllowed = a; }

    static std::list<AuctionListItemsDelayEvent> & GetList() { return auctionListingList; }
    static std::list<AuctionListItemsDelayEvent> & GetTempList() { return auctionListingListTemp; }
    static ACE_Thread_Mutex& GetLock() { return auctionListingLock; }
    static ACE_Thread_Mutex& GetTempLock() { return auctionListingTempLock; }

private:
    static uint32 auctionListingDiff;
    static bool auctionListingAllowed;
    static std::list<AuctionListItemsDelayEvent> auctionListingList;
    static std::list<AuctionListItemsDelayEvent> auctionListingListTemp;
    static ACE_Thread_Mutex auctionListingLock;
    static ACE_Thread_Mutex auctionListingTempLock;
};

#endif
