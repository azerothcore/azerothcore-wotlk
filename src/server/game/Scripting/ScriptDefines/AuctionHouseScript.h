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

#ifndef SCRIPT_OBJECT_AUCTION_HOUSE_SCRIPT_H_
#define SCRIPT_OBJECT_AUCTION_HOUSE_SCRIPT_H_

#include "ScriptObject.h"

enum AuctionHouseHook
{
    AUCTIONHOUSEHOOK_ON_AUCTION_ADD,
    AUCTIONHOUSEHOOK_ON_AUCTION_REMOVE,
    AUCTIONHOUSEHOOK_ON_AUCTION_SUCCESSFUL,
    AUCTIONHOUSEHOOK_ON_AUCTION_EXPIRE,
    AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_WON_MAIL,
    AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_SALE_PENDING_MAIL,
    AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_SUCCESSFUL_MAIL,
    AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_EXPIRED_MAIL,
    AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_OUTBIDDED_MAIL,
    AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_CANCELLED_TO_BIDDER_MAIL,
    AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_UPDATE,
    AUCTIONHOUSEHOOK_END
};

class AuctionHouseScript : public ScriptObject
{
protected:
    AuctionHouseScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    // Called when an auction is added to an auction house.
    virtual void OnAuctionAdd(AuctionHouseObject* /*ah*/, AuctionEntry* /*entry*/) { }

    // Called when an auction is removed from an auction house.
    virtual void OnAuctionRemove(AuctionHouseObject* /*ah*/, AuctionEntry* /*entry*/) { }

    // Called when an auction was succesfully completed.
    virtual void OnAuctionSuccessful(AuctionHouseObject* /*ah*/, AuctionEntry* /*entry*/) { }

    // Called when an auction expires.
    virtual void OnAuctionExpire(AuctionHouseObject* /*ah*/, AuctionEntry* /*entry*/) { }

    // Called before sending the mail concerning a won auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionWonMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*bidder*/, uint32& /*bidder_accId*/, bool& /*sendNotification*/, bool& /*updateAchievementCriteria*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning a pending sale
    virtual void OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*owner*/, uint32& /*owner_accId*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning a successful auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*owner*/, uint32& /*owner_accId*/, uint32& /*profit*/, bool& /*sendNotification*/, bool& /*updateAchievementCriteria*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning an expired auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionExpiredMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*owner*/, uint32& /*owner_accId*/, bool& /*sendNotification*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning an outbidded auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*oldBidder*/, uint32& /*oldBidder_accId*/, Player* /*newBidder*/, uint32& /*newPrice*/, bool& /*sendNotification*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning an cancelled auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*bidder*/, uint32& /*bidder_accId*/, bool& /*sendMail*/) { }

    // Called before updating the auctions
    virtual void OnBeforeAuctionHouseMgrUpdate() { }
};

#endif
