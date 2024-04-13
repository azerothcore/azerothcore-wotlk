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

#include "AuctionHouseScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnAuctionAdd(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_AUCTION_ADD, script->OnAuctionAdd(ah, entry));
}

void ScriptMgr::OnAuctionRemove(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_AUCTION_REMOVE, script->OnAuctionRemove(ah, entry));
}

void ScriptMgr::OnAuctionSuccessful(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_AUCTION_SUCCESSFUL, script->OnAuctionSuccessful(ah, entry));
}

void ScriptMgr::OnAuctionExpire(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_AUCTION_EXPIRE, script->OnAuctionExpire(ah, entry));
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionWonMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* bidder, uint32& bidder_accId, bool& sendNotification, bool& updateAchievementCriteria, bool& sendMail)
{
    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_WON_MAIL, script->OnBeforeAuctionHouseMgrSendAuctionWonMail(auctionHouseMgr, auction, bidder, bidder_accId, sendNotification, updateAchievementCriteria, sendMail));
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, bool& sendMail)
{
    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_SALE_PENDING_MAIL, script->OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(auctionHouseMgr, auction, owner, owner_accId, sendMail));
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, uint32& profit, bool& sendNotification, bool& updateAchievementCriteria, bool& sendMail)
{
    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_SUCCESSFUL_MAIL, script->OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(auctionHouseMgr, auction, owner, owner_accId, profit, sendNotification, updateAchievementCriteria, sendMail));
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionExpiredMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, bool& sendNotification, bool& sendMail)
{
    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_EXPIRED_MAIL, script->OnBeforeAuctionHouseMgrSendAuctionExpiredMail(auctionHouseMgr, auction, owner, owner_accId, sendNotification, sendMail));
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* oldBidder, uint32& oldBidder_accId, Player* newBidder, uint32& newPrice, bool& sendNotification, bool& sendMail)
{
    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_OUTBIDDED_MAIL, script->OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(auctionHouseMgr, auction, oldBidder, oldBidder_accId, newBidder, newPrice, sendNotification, sendMail));
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* bidder, uint32& bidder_accId, bool& sendMail)
{
    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_SEND_AUCTION_CANCELLED_TO_BIDDER_MAIL, script->OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(auctionHouseMgr, auction, bidder, bidder_accId, sendMail));
}

void ScriptMgr::OnBeforeAuctionHouseMgrUpdate()
{
    CALL_ENABLED_HOOKS(AuctionHouseScript, AUCTIONHOUSEHOOK_ON_BEFORE_AUCTIONHOUSEMGR_UPDATE, script->OnBeforeAuctionHouseMgrUpdate());
}

AuctionHouseScript::AuctionHouseScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, AUCTIONHOUSEHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < AUCTIONHOUSEHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<AuctionHouseScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<AuctionHouseScript>;
