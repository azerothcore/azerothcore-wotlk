/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "Player.h"
#include "AuctionHouseBot.h"

class AHBot_WorldScript : public WorldScript
{
public:
    AHBot_WorldScript() : WorldScript("AHBot_WorldScript") { }

    void OnBeforeConfigLoad(bool /*reload*/) override
    {
        auctionbot->InitializeConfiguration();
    }

    void OnStartup() override
    {
        sLog->outString("Initialize AuctionHouseBot...");
        auctionbot->Initialize();
    }
};

class AHBot_AuctionHouseScript : public AuctionHouseScript
{
public:
    AHBot_AuctionHouseScript() : AuctionHouseScript("AHBot_AuctionHouseScript") { }

    void OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* owner, uint32& /*owner_accId*/, uint32& /*profit*/, bool& sendNotification, bool& updateAchievementCriteria, bool& /*sendMail*/) override
    {
        if (owner && owner->GetGUID().GetCounter() == auctionbot->GetAHBplayerGUID())
        {
            sendNotification = false;
            updateAchievementCriteria = false;
        }
    }

    void OnBeforeAuctionHouseMgrSendAuctionExpiredMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* owner, uint32& /*owner_accId*/, bool& sendNotification, bool& /*sendMail*/) override
    {
        if (owner && owner->GetGUID().GetCounter() == auctionbot->GetAHBplayerGUID())
            sendNotification = false;
    }

    void OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* auction, Player* oldBidder, uint32& /*oldBidder_accId*/, Player* newBidder, uint32& newPrice, bool& /*sendNotification*/, bool& /*sendMail*/) override
    {
        if (oldBidder && !newBidder)
            oldBidder->GetSession()->SendAuctionBidderNotification(auction->GetHouseId(), auction->Id, ObjectGuid::Create<HighGuid::Player>(auctionbot->GetAHBplayerGUID()), newPrice, auction->GetAuctionOutBid(), auction->item_template);
    }

    void OnAuctionAdd(AuctionHouseObject* /*ah*/, AuctionEntry* auction) override
    {
        auctionbot->IncrementItemCounts(auction);
    }

    void OnAuctionRemove(AuctionHouseObject* /*ah*/, AuctionEntry* auction) override
    {
        auctionbot->DecrementItemCounts(auction, auction->item_template);
    }

    void OnBeforeAuctionHouseMgrUpdate() override
    {
        auctionbot->Update();
    }
};

class AHBot_MailScript : public MailScript
{
public:
    AHBot_MailScript() : MailScript("AHBot_MailScript") { }

    void OnBeforeMailDraftSendMailTo(MailDraft* /*mailDraft*/, MailReceiver const& receiver, MailSender const& sender, MailCheckMask& /*checked*/, uint32& /*deliver_delay*/, uint32& /*custom_expiration*/, bool& deleteMailItemsFromDB, bool& sendMail) override
    {
        if (receiver.GetPlayerGUIDLow() == auctionbot->GetAHBplayerGUID())
        {
            if (sender.GetMailMessageType() == MAIL_AUCTION)        // auction mail with items
                deleteMailItemsFromDB = true;
            sendMail = false;
        }
    }
};

void AddAHBotScripts()
{
    new AHBot_WorldScript();
    new AHBot_AuctionHouseScript();
    new AHBot_MailScript();
}
