/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "AsyncAuctionListing.h"
#include "AuctionHouseMgr.h"
#include "Creature.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "SpellAuraEffects.h"

uint32 AsyncAuctionListingMgr::auctionListingDiff = 0;
bool AsyncAuctionListingMgr::auctionListingAllowed = false;
std::list<AuctionListItemsDelayEvent> AsyncAuctionListingMgr::auctionListingList;
std::list<AuctionListItemsDelayEvent> AsyncAuctionListingMgr::auctionListingListTemp;
std::mutex AsyncAuctionListingMgr::auctionListingLock;
std::mutex AsyncAuctionListingMgr::auctionListingTempLock;

bool AuctionListOwnerItemsDelayEvent::Execute(uint64  /*e_time*/, uint32  /*p_time*/)
{
    if (Player* plr = ObjectAccessor::FindPlayer(playerguid))
        plr->GetSession()->HandleAuctionListOwnerItemsEvent(creatureGuid);
    return true;
}

bool AuctionListItemsDelayEvent::Execute()
{
    Player* plr = ObjectAccessor::FindPlayer(_playerguid);
    if (!plr || !plr->IsInWorld() || plr->IsDuringRemoveFromWorld() || plr->IsBeingTeleported())
        return true;

    Creature* creature = plr->GetNPCIfCanInteractWith(_creatureguid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
        return true;

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->getFaction());

    WorldPacket data(SMSG_AUCTION_LIST_RESULT, (4 + 4 + 4) + 50 * ((16 + MAX_INSPECTED_ENCHANTMENT_SLOT * 3) * 4));
    uint32 count = 0;
    uint32 totalcount = 0;
    data << (uint32) 0;

    // converting string that we try to find to lower case
    std::wstring wsearchedname;
    if (!Utf8toWStr(_searchedname, wsearchedname))
        return true;

    wstrToLower(wsearchedname);

    bool result = auctionHouse->BuildListAuctionItems(data, plr,
                  wsearchedname, _listfrom, _levelmin, _levelmax, _usable,
                  _auctionSlotID, _auctionMainCategory, _auctionSubCategory, _quality,
                  count, totalcount, _getAll);

    if (!result)
        return false;

    data.put<uint32>(0, count);
    data << (uint32) totalcount;
    data << (uint32) 300; // clientside search cooldown [ms] (gray search button)
    plr->GetSession()->SendPacket(&data);

    return true;
}
