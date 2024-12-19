/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef AUCTION_HOUSE_BOT_AUCTION_HOUSE_SCRIPT_H
#define AUCTION_HOUSE_BOT_AUCTION_HOUSE_SCRIPT_H

#include "Player.h"
#include "ScriptMgr.h"

// =============================================================================
// Interaction with the auction house core mechanisms
// =============================================================================

class AHBot_AuctionHouseScript : public AuctionHouseScript
{
public:
    AHBot_AuctionHouseScript();

    void OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, uint32& profit, bool& sendNotification, bool& updateAchievementCriteria, bool& sendMail) override;
    void OnBeforeAuctionHouseMgrSendAuctionExpiredMail   (AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, bool& sendNotification, bool& sendMail) override;
    void OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail (AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* oldBidder, uint32& oldBidder_accId, Player* newBidder, uint32& newPrice, bool& sendNotification, bool& sendMail) override;

    void OnAuctionAdd       (AuctionHouseObject* ah, AuctionEntry* auction) override;
    void OnAuctionRemove    (AuctionHouseObject* ah, AuctionEntry* auction) override;
    void OnAuctionSuccessful(AuctionHouseObject* ah, AuctionEntry* auction) override;
    void OnAuctionExpire    (AuctionHouseObject* ah, AuctionEntry* auction) override;

    void OnBeforeAuctionHouseMgrUpdate() override;
};

#endif /* AUCTION_HOUSE_BOT_AUCTION_HOUSE_SCRIPT_H */
