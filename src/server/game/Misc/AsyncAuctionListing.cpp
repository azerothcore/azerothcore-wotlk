/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AsyncAuctionListing.h"
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

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

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
                  count, totalcount, _getAll, _sortOrder);

    if (!result)
        return false;

    data.put<uint32>(0, count);
    data << (uint32) totalcount;
    data << (uint32) 300; // clientside search cooldown [ms] (gray search button)
    plr->GetSession()->SendPacket(&data);

    return true;
}
