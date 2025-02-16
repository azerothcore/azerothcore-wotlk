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

#include "AuctionHouseMgr.h"
#include "AuctionHouseSearcher.h"
#include "Chat.h"
#include "GameTime.h"
#include "Language.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

//void called when player click on auctioneer npc
void WorldSession::HandleAuctionHelloOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;                                            //NPC guid
    recvData >> guid;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionHelloOpcode - Unit ({}) not found or you can't interact with him.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    SendAuctionHello(guid, unit);
}

//this void causes that auction window is opened
void WorldSession::SendAuctionHello(ObjectGuid guid, Creature* unit)
{
    if (GetPlayer()->GetLevel() < sWorld->getIntConfig(CONFIG_AUCTION_LEVEL_REQ))
    {
        ChatHandler(this).SendNotification(LANG_AUCTION_REQ, sWorld->getIntConfig(CONFIG_AUCTION_LEVEL_REQ));
        return;
    }

    if (!sScriptMgr->CanSendAuctionHello(this, guid, unit))
        return;

    AuctionHouseEntry const* ahEntry = AuctionHouseMgr::GetAuctionHouseEntryFromFactionTemplate(unit->GetFaction());
    if (!ahEntry)
        return;

    WorldPacket data(MSG_AUCTION_HELLO, 12);
    data << guid;
    data << uint32(ahEntry->houseId);
    data << uint8(1);                                       // 3.3.3: 1 - AH enabled, 0 - AH disabled
    SendPacket(&data);
}

//call this method when player bids, creates, or deletes auction
void WorldSession::SendAuctionCommandResult(uint32 auctionId, uint32 Action, uint32 ErrorCode, uint32 bidError)
{
    WorldPacket data(SMSG_AUCTION_COMMAND_RESULT, 16);
    data << auctionId;
    data << Action;
    data << ErrorCode;
    if (!ErrorCode && Action)
        data << bidError;                                   //when bid, then send 0, once...
    SendPacket(&data);
}

//this function sends notification, if bidder is online
void WorldSession::SendAuctionBidderNotification(uint32 location, uint32 auctionId, ObjectGuid bidder, uint32 bidSum, uint32 diff, uint32 item_template)
{
    WorldPacket data(SMSG_AUCTION_BIDDER_NOTIFICATION, (8 * 4));
    data << uint32(location);
    data << uint32(auctionId);
    data << bidder;
    data << uint32(bidSum);
    data << uint32(diff);
    data << uint32(item_template);
    data << uint32(0);
    SendPacket(&data);
}

//this void causes on client to display: "Your auction sold"
void WorldSession::SendAuctionOwnerNotification(AuctionEntry* auction)
{
    WorldPacket data(SMSG_AUCTION_OWNER_NOTIFICATION, (8 * 4));
    data << uint32(auction->Id);
    data << uint32(auction->bid);
    data << uint32(0);                                      //unk
    data << uint64(0);                                      //unk (bidder guid?)
    data << uint32(auction->item_template);
    data << uint32(0);                                      //unk
    data << float(0);                                       //unk (time?)
    SendPacket(&data);
}

//this void creates new auction and adds auction to some auctionhouse
void WorldSession::HandleAuctionSellItem(WorldPacket& recvData)
{
    ObjectGuid auctioneer;
    uint32 itemsCount, etime, bid, buyout;
    recvData >> auctioneer;
    recvData >> itemsCount;

    ObjectGuid itemGUIDs[MAX_AUCTION_ITEMS]; // 160 slot = 4x 36 slot bag + backpack 16 slot
    uint32 count[MAX_AUCTION_ITEMS];
    memset(count, 0, sizeof(count));

    if (itemsCount > MAX_AUCTION_ITEMS)
    {
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        recvData.rfinish();
        return;
    }

    for (uint32 i = 0; i < itemsCount; ++i)
    {
        recvData >> itemGUIDs[i];
        recvData >> count[i];

        if (!itemGUIDs[i] || !count[i] || count[i] > 1000)
        {
            recvData.rfinish();
            return;
        }
    }

    recvData >> bid;
    recvData >> buyout;
    recvData >> etime;

    if (!bid || !etime)
        return;

    if (bid > MAX_MONEY_AMOUNT || buyout > MAX_MONEY_AMOUNT)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Player {} ({}) attempted to sell item with higher price than max gold amount.",
            _player->GetName(), _player->GetGUID().ToString());
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Unit ({}) not found or you can't interact with him.", auctioneer.ToString());
        return;
    }

    AuctionHouseEntry const* auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntryFromFactionTemplate(creature->GetFaction());
    if (!auctionHouseEntry)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Unit ({}) has wrong faction.", auctioneer.ToString());
        return;
    }

    etime *= MINUTE;

    switch (etime)
    {
        case 1*MIN_AUCTION_TIME:
        case 2*MIN_AUCTION_TIME:
        case 4*MIN_AUCTION_TIME:
            break;
        default:
            return;
    }

    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    Item* items[MAX_AUCTION_ITEMS];

    uint32 finalCount = 0;
    uint32 itemEntry = 0;

    for (uint32 i = 0; i < itemsCount; ++i)
    {
        Item* item = _player->GetItemByGuid(itemGUIDs[i]);

        if (!item)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }

        if (itemEntry == 0)
            itemEntry = item->GetTemplate()->ItemId;

        if (sAuctionMgr->GetAItem(item->GetGUID()) || !item->CanBeTraded() || item->IsNotEmptyBag() ||
                item->GetTemplate()->HasFlag(ITEM_FLAG_CONJURED) || item->GetUInt32Value(ITEM_FIELD_DURATION) ||
                item->GetCount() < count[i] || itemEntry != item->GetTemplate()->ItemId)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            return;
        }

        items[i] = item;
        finalCount += count[i];
    }

    if (!finalCount)
    {
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    // check if there are 2 identical guids, in this case user is most likely cheating
    for (uint32 i = 0; i < itemsCount - 1; ++i)
    {
        for (uint32 j = i + 1; j < itemsCount; ++j)
        {
            if (itemGUIDs[i] == itemGUIDs[j])
            {
                SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
                return;
            }
        }
    }

    for (uint32 i = 0; i < itemsCount; ++i)
    {
        Item* item = items[i];

        if (item->GetMaxStackCount() < finalCount)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            return;
        }
    }

    for (uint32 i = 0; i < itemsCount; ++i)
    {
        Item* item = items[i];

        uint32 auctionTime = uint32(etime * sWorld->getRate(RATE_AUCTION_TIME));
        AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

        uint32 deposit = sAuctionMgr->GetAuctionDeposit(auctionHouseEntry, etime, item, finalCount);
        if (!_player->HasEnoughMoney(deposit))
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_NOT_ENOUGHT_MONEY);
            return;
        }

        _player->ModifyMoney(-int32(deposit));

        AuctionEntry* AH = new AuctionEntry;
        AH->Id = sObjectMgr->GenerateAuctionID();

        if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
            AH->houseId = AuctionHouseId::Neutral;
        else
        {
            CreatureData const* auctioneerData = sObjectMgr->GetCreatureData(creature->GetSpawnId());
            if (!auctioneerData)
            {
                LOG_ERROR("network.opcode", "Data for auctioneer not found ({})", auctioneer.ToString());
                delete AH;
                return;
            }

            CreatureTemplate const* auctioneerInfo = sObjectMgr->GetCreatureTemplate(auctioneerData->id1);
            if (!auctioneerInfo)
            {
                LOG_ERROR("network.opcode", "Non existing auctioneer ({})", auctioneer.ToString());
                delete AH;
                return;
            }

            const AuctionHouseEntry* AHEntry = sAuctionMgr->GetAuctionHouseEntryFromFactionTemplate(auctioneerInfo->faction);
            AH->houseId = AuctionHouseId(AHEntry->houseId);
        }

        // Required stack size of auction matches to current item stack size, just move item to auctionhouse
        if (itemsCount == 1 && item->GetCount() == count[i])
        {
            AH->item_guid = item->GetGUID();
            AH->item_template = item->GetEntry();
            AH->itemCount = item->GetCount();
            AH->owner = _player->GetGUID();
            AH->startbid = bid;
            AH->bidder = ObjectGuid::Empty;
            AH->bid = 0;
            AH->buyout = buyout;
            AH->expire_time = GameTime::GetGameTime().count() + auctionTime;
            AH->deposit = deposit;
            AH->auctionHouseEntry = auctionHouseEntry;

            LOG_DEBUG("network.opcode", "CMSG_AUCTION_SELL_ITEM: Player {} ({}) is selling item {} entry {} ({}) with count {} with initial bid {} with buyout {} and with time {} (in sec) in auctionhouse {}",
                _player->GetName(), _player->GetGUID().ToString(), item->GetTemplate()->Name1, item->GetEntry(), item->GetGUID().ToString(), item->GetCount(), bid, buyout, auctionTime, AH->GetHouseId());
            sAuctionMgr->AddAItem(item);
            auctionHouse->AddAuction(AH);

            _player->MoveItemFromInventory(item->GetBagSlot(), item->GetSlot(), true);

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            item->DeleteFromInventoryDB(trans);
            item->SaveToDB(trans);
            AH->SaveToDB(trans);
            _player->SaveInventoryAndGoldToDB(trans);
            CharacterDatabase.CommitTransaction(trans);

            SendAuctionCommandResult(AH->Id, AUCTION_SELL_ITEM, ERR_AUCTION_OK);

            GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION, 1);
            return;
        }
        else // Required stack size of auction does not match to current item stack size, clone item and set correct stack size
        {
            Item* newItem = item->CloneItem(finalCount, _player);
            if (!newItem)
            {
                LOG_ERROR("network.opcode", "CMSG_AUCTION_SELL_ITEM: Could not create clone of item {}", item->GetEntry());
                SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
                return;
            }

            AH->item_guid = newItem->GetGUID();
            AH->item_template = newItem->GetEntry();
            AH->itemCount = newItem->GetCount();
            AH->owner = _player->GetGUID();
            AH->startbid = bid;
            AH->bidder = ObjectGuid::Empty;
            AH->bid = 0;
            AH->buyout = buyout;
            AH->expire_time = GameTime::GetGameTime().count() + auctionTime;
            AH->deposit = deposit;
            AH->auctionHouseEntry = auctionHouseEntry;

            LOG_DEBUG("network.opcode", "CMSG_AUCTION_SELL_ITEM: Player {} ({}) is selling item {} entry {} ({}) with count {} with initial bid {} with buyout {} and with time {} (in sec) in auctionhouse {}",
                _player->GetName(), _player->GetGUID().ToString(), newItem->GetTemplate()->Name1, newItem->GetEntry(), newItem->GetGUID().ToString(), newItem->GetCount(), bid, buyout, auctionTime, AH->GetHouseId());
            sAuctionMgr->AddAItem(newItem);
            auctionHouse->AddAuction(AH);

            for (uint32 j = 0; j < itemsCount; ++j)
            {
                Item* item2 = items[j];

                // Item stack count equals required count, ready to delete item - cloned item will be used for auction
                if (item2->GetCount() == count[j])
                {
                    _player->MoveItemFromInventory(item2->GetBagSlot(), item2->GetSlot(), true);

                    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
                    item2->DeleteFromInventoryDB(trans);
                    item2->DeleteFromDB(trans);
                    CharacterDatabase.CommitTransaction(trans);
                    delete item2;
                }
                else // Item stack count is bigger than required count, update item stack count and save to database - cloned item will be used for auction
                {
                    item2->SetCount(item2->GetCount() - count[j]);
                    item2->SetState(ITEM_CHANGED, _player);
                    _player->ItemRemovedQuestCheck(item2->GetEntry(), count[j]);
                    item2->SendUpdateToPlayer(_player);
                }
            }

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            newItem->SaveToDB(trans);
            AH->SaveToDB(trans);
            _player->SaveInventoryAndGoldToDB(trans);
            CharacterDatabase.CommitTransaction(trans);

            SendAuctionCommandResult(AH->Id, AUCTION_SELL_ITEM, ERR_AUCTION_OK);

            GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION, 1);
            return;
        }
    }
}

//this function is called when client bids or buys out auction
void WorldSession::HandleAuctionPlaceBid(WorldPacket& recvData)
{
    ObjectGuid auctioneer;
    uint32 auctionId;
    uint32 price;
    recvData >> auctioneer;
    recvData >> auctionId >> price;

    if (!auctionId || !price)
        return;                                             //check for cheaters

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionPlaceBid - Unit ({}) not found or you can't interact with him.", auctioneer.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    AuctionEntry* auction = auctionHouse->GetAuction(auctionId);
    Player* player = GetPlayer();

    if (!sScriptMgr->OnPlayerCanPlaceAuctionBid(player, auction))
    {
        SendAuctionCommandResult(0, AUCTION_PLACE_BID, ERR_AUCTION_RESTRICTED_ACCOUNT);
        return;
    }

    if (!auction || auction->owner == player->GetGUID())
    {
        //you cannot bid your own auction:
        SendAuctionCommandResult(0, AUCTION_PLACE_BID, ERR_AUCTION_BID_OWN);
        return;
    }

    // impossible have online own another character (use this for speedup check in case online owner)
    Player* auction_owner = ObjectAccessor::FindConnectedPlayer(auction->owner);
    if (!auction_owner && sCharacterCache->GetCharacterAccountIdByGuid(auction->owner) == GetAccountId())
    {
        //you cannot bid your another character auction:
        SendAuctionCommandResult(0, AUCTION_PLACE_BID, ERR_AUCTION_BID_OWN);
        return;
    }

    // cheating
    if (price <= auction->bid || price < auction->startbid)
        return;

    // price too low for next bid if not buyout
    if ((price < auction->buyout || auction->buyout == 0) &&
            price < auction->bid + AuctionEntry::CalculateAuctionOutBid(auction->bid))
    {
        //auction has already higher bid, client tests it!
        return;
    }

    if (!player->HasEnoughMoney(price))
    {
        //you don't have enought money!, client tests!
        //SendAuctionCommandResult(auction->auctionId, AUCTION_PLACE_BID, ???);
        return;
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    if (price < auction->buyout || auction->buyout == 0)
    {
        if (auction->bidder)
        {
            if (auction->bidder == player->GetGUID())
                player->ModifyMoney(-int32(price - auction->bid));
            else
            {
                // mail to last bidder and return money
                sAuctionMgr->SendAuctionOutbiddedMail(auction, price, GetPlayer(), trans);
                player->ModifyMoney(-int32(price));
            }
        }
        else
            player->ModifyMoney(-int32(price));

        auction->bidder = player->GetGUID();
        auction->bid = price;

        sAuctionMgr->GetAuctionHouseSearcher()->UpdateBid(auction);

        GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID, price);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_AUCTION_BID);
        stmt->SetData(0, auction->bidder.GetCounter());
        stmt->SetData(1, auction->bid);
        stmt->SetData(2, auction->Id);
        trans->Append(stmt);

        SendAuctionCommandResult(auction->Id, AUCTION_PLACE_BID, ERR_AUCTION_OK, 0);
    }
    else
    {
        //buyout:
        if (player->GetGUID() == auction->bidder)
            player->ModifyMoney(-int32(auction->buyout - auction->bid));
        else
        {
            player->ModifyMoney(-int32(auction->buyout));
            if (auction->bidder)                          //buyout for bidded auction ..
                sAuctionMgr->SendAuctionOutbiddedMail(auction, auction->buyout, GetPlayer(), trans);
        }
        auction->bidder = player->GetGUID();
        auction->bid = auction->buyout;
        GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID, auction->buyout);

        //- Mails must be under transaction control too to prevent data loss
        sAuctionMgr->SendAuctionSalePendingMail(auction, trans);
        sAuctionMgr->SendAuctionSuccessfulMail(auction, trans);
        sAuctionMgr->SendAuctionWonMail(auction, trans);
        sScriptMgr->OnAuctionSuccessful(auctionHouse, auction);

        SendAuctionCommandResult(auction->Id, AUCTION_PLACE_BID, ERR_AUCTION_OK);

        auction->DeleteFromDB(trans);

        sAuctionMgr->RemoveAItem(auction->item_guid);
        auctionHouse->RemoveAuction(auction);
    }
    player->SaveInventoryAndGoldToDB(trans);
    CharacterDatabase.CommitTransaction(trans);
}

//this void is called when auction_owner cancels his auction
void WorldSession::HandleAuctionRemoveItem(WorldPacket& recvData)
{
    ObjectGuid auctioneer;
    uint32 auctionId;
    recvData >> auctioneer;
    recvData >> auctionId;

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionRemoveItem - Unit ({}) not found or you can't interact with him.", auctioneer.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    AuctionEntry* auction = auctionHouse->GetAuction(auctionId);
    Player* player = GetPlayer();

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    if (auction && auction->owner == player->GetGUID())
    {
        Item* pItem = sAuctionMgr->GetAItem(auction->item_guid);
        if (!pItem)
            return;

        if (auction->bidder)                        // If we have a bidder, we have to send him the money he paid
        {
            uint32 auctionCut = auction->GetAuctionCut();
            if (!player->HasEnoughMoney(auctionCut))          //player doesn't have enough money, maybe message needed
                return;
            //some auctionBidderNotification would be needed, but don't know that parts..
            sAuctionMgr->SendAuctionCancelledToBidderMail(auction, trans);
            player->ModifyMoney(-int32(auctionCut));
        }

        // item will deleted or added to received mail list
        MailDraft(auction->BuildAuctionMailSubject(AUCTION_CANCELED), AuctionEntry::BuildAuctionMailBody(ObjectGuid::Empty, 0, auction->buyout, auction->deposit))
        .AddItem(pItem)
        .SendMailTo(trans, player, auction, MAIL_CHECK_MASK_COPIED);
    }
    else
    {
        SendAuctionCommandResult(0, AUCTION_CANCEL, ERR_AUCTION_DATABASE_ERROR);
        //this code isn't possible ... maybe there should be assert
        LOG_ERROR("network.opcode", "CHEATER : {}, he tried to cancel auction (id: {}) of another player, or auction is nullptr", player->GetGUID().ToString(), auctionId);
        return;
    }

    //inform player, that auction is removed
    SendAuctionCommandResult(auction->Id, AUCTION_CANCEL, ERR_AUCTION_OK);

    // Now remove the auction

    player->SaveInventoryAndGoldToDB(trans);
    auction->DeleteFromDB(trans);
    CharacterDatabase.CommitTransaction(trans);

    sAuctionMgr->RemoveAItem(auction->item_guid);
    auctionHouse->RemoveAuction(auction);
}

//called when player lists his bids
void WorldSession::HandleAuctionListBidderItems(WorldPacket& recvData)
{
    ObjectGuid guid;                                            //NPC guid
    uint32 listfrom;                                        //page of auctions
    uint32 outbiddedCount;                                  //count of outbidded auctions

    recvData >> guid;
    recvData >> listfrom;                                  // not used in fact (this list not have page control in client)
    recvData >> outbiddedCount;
    if (recvData.size() != (16 + outbiddedCount * 4))
    {
        LOG_ERROR("network.opcode", "Client sent bad opcode!!! with count: {} and size : {} (must be: {})", outbiddedCount, (unsigned long)recvData.size(), (16 + outbiddedCount * 4));
        outbiddedCount = 0;
    }

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionListBidderItems - Unit ({}) not found or you can't interact with him.", guid.ToString());
        recvData.rfinish();
        return;
    }

    // Arbitrary cap, can be adjusted if needed
    if (outbiddedCount > 1000)
        return;

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseEntry const* ahEntry = AuctionHouseMgr::GetAuctionHouseEntryFromFactionTemplate(creature->GetFaction());
    if (!ahEntry)
        return;

    AuctionHouseFaction auctionHouseFaction = AuctionHouseMgr::GetAuctionHouseFactionFromHouseId(AuctionHouseId(ahEntry->houseId));

    // Client sends this list, which I'm honestly not entirely sure why?
    std::vector<uint32> auctionIds;
    auctionIds.reserve(outbiddedCount);
    while (outbiddedCount > 0) // add all data, which client requires
    {
        --outbiddedCount;
        uint32 outbiddedAuctionId;
        recvData >> outbiddedAuctionId;
        auctionIds.push_back(outbiddedAuctionId);
    }

    sAuctionMgr->GetAuctionHouseSearcher()->QueueSearchRequest(new AuctionSearchBidderListRequest(auctionHouseFaction, std::move(auctionIds), GetPlayer()->GetGUID()));
}

//this void sends player info about his auctions
void WorldSession::HandleAuctionListOwnerItems(WorldPacket& recvData)
{
    ObjectGuid guid;
    uint32 listfrom;

    recvData >> guid;
    recvData >> listfrom;       // not used in fact (this list does not have page control in client)

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
        return;

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseEntry const* ahEntry = AuctionHouseMgr::GetAuctionHouseEntryFromFactionTemplate(creature->GetFaction());
    if (!ahEntry)
        return;

    AuctionHouseFaction auctionHouseFaction = AuctionHouseMgr::GetAuctionHouseFactionFromHouseId(AuctionHouseId(ahEntry->houseId));

    sAuctionMgr->GetAuctionHouseSearcher()->QueueSearchRequest(new AuctionSearchOwnerListRequest(auctionHouseFaction, GetPlayer()->GetGUID()));
}

//this void is called when player clicks on search button
void WorldSession::HandleAuctionListItems(WorldPacket& recvData)
{
    std::string searchedname;
    uint8 levelmin, levelmax, usable;
    uint32 listfrom, auctionSlotID, auctionMainCategory, auctionSubCategory, quality;
    ObjectGuid guid;

    recvData >> guid;
    recvData >> listfrom;                                  // start, used for page control listing by 50 elements
    recvData >> searchedname;

    recvData >> levelmin >> levelmax;
    recvData >> auctionSlotID >> auctionMainCategory >> auctionSubCategory;
    recvData >> quality >> usable;

    uint8 getAll;
    recvData >> getAll;

    // Read sort block
    uint8 sortOrderCount;
    recvData >> sortOrderCount;

    if (sortOrderCount > AUCTION_SORT_MAX)
        return;

    AuctionSortOrderVector sortOrder;
    for (uint8 i = 0; i < sortOrderCount; i++)
    {
        uint8 sortMode;
        uint8 isDesc;
        recvData >> sortMode;
        recvData >> isDesc;
        AuctionSortInfo sortInfo;
        sortInfo.isDesc = (isDesc == 1);
        sortInfo.sortOrder = static_cast<AuctionSortOrder>(sortMode);
        sortOrder.push_back(std::move(sortInfo));
    }

    // converting string that we try to find to lower case
    std::wstring wsearchedname;
    if (!Utf8toWStr(searchedname, wsearchedname))
        return;

    wstrToLower(wsearchedname);

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
        return;

    // remove fake death
    if (_player->HasUnitState(UNIT_STATE_DIED))
        _player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseEntry const* ahEntry = AuctionHouseMgr::GetAuctionHouseEntryFromFactionTemplate(creature->GetFaction());
    if (!ahEntry)
        return;

    AuctionHouseFaction auctionHouseFaction = AuctionHouseMgr::GetAuctionHouseFactionFromHouseId(AuctionHouseId(ahEntry->houseId));

    AuctionHouseSearchInfo ahSearchInfo;
    ahSearchInfo.wsearchedname = wsearchedname;
    ahSearchInfo.listfrom = listfrom;
    ahSearchInfo.levelmin = levelmin;
    ahSearchInfo.levelmax = levelmax;
    ahSearchInfo.usable = usable;
    ahSearchInfo.inventoryType = auctionSlotID;
    ahSearchInfo.itemClass = auctionMainCategory;
    ahSearchInfo.itemSubClass = auctionSubCategory;
    ahSearchInfo.quality = quality;
    ahSearchInfo.getAll = getAll;
    ahSearchInfo.sorting = std::move(sortOrder);

    AuctionHousePlayerInfo ahPlayerInfo;
    ahPlayerInfo.playerGuid = GetPlayer()->GetGUID();
    ahPlayerInfo.faction = GetPlayer()->GetFaction();
    ahPlayerInfo.loc_idx = GetPlayer()->GetSession()->GetSessionDbLocaleIndex();
    ahPlayerInfo.locdbc_idx = GetPlayer()->GetSession()->GetSessionDbcLocale();
    if (usable)
    {
        AuctionHouseUsablePlayerInfo usablePlayerInfo;
        usablePlayerInfo.classMask = GetPlayer()->getClassMask();
        usablePlayerInfo.raceMask = GetPlayer()->getRaceMask();
        usablePlayerInfo.level = GetPlayer()->GetLevel();

        SkillStatusMap const& skillMap = GetPlayer()->GetSkillStatusMap();
        for (auto const& pair : skillMap)
            usablePlayerInfo.skills.insert(std::make_pair(pair.first, GetPlayer()->GetSkillValue(pair.first)));

        PlayerSpellMap const& spellMap = GetPlayer()->GetSpellMap();
        for (auto const& pair : spellMap)
        {
            if (pair.second->State != PLAYERSPELL_REMOVED && pair.second->IsInSpec(GetPlayer()->GetActiveSpec()))
                usablePlayerInfo.spells.insert(pair.first);
        }
        ahPlayerInfo.usablePlayerInfo = std::move(usablePlayerInfo);
    }

    sAuctionMgr->GetAuctionHouseSearcher()->QueueSearchRequest(new AuctionSearchListRequest(auctionHouseFaction, std::move(ahSearchInfo), std::move(ahPlayerInfo)));
}

void WorldSession::HandleAuctionListPendingSales(WorldPacket& recvData)
{
    recvData.read_skip<uint64>();

    uint32 count = 0;

    WorldPacket data(SMSG_AUCTION_LIST_PENDING_SALES, 4);
    data << uint32(count);                                  // count
    /*for (uint32 i = 0; i < count; ++i)
    {
        data << "";                                         // string
        data << "";                                         // string
        data << uint32(0);
        data << uint32(0);
        data << float(0);
    }*/
    SendPacket(&data);
}
