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
#include "Chat.h"
#include "GameTime.h"
#include "Language.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "UpdateMask.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "AuctionHousePackets.h"

// Called when player click on auctioneer npc
void WorldSession::HandleAuctionHelloOpcode(WorldPackets::AuctionHouse::HelloFromClient& packet)
{
    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(packet.CreatureGuid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionHelloOpcode - Unit ({}) not found or you can't interact with him.", packet.CreatureGuid.ToString());
        return;
    }

    if (GetPlayer()->getLevel() < sWorld->getIntConfig(CONFIG_AUCTION_LEVEL_REQ))
    {
        SendNotification(GetAcoreString(LANG_AUCTION_REQ), sWorld->getIntConfig(CONFIG_AUCTION_LEVEL_REQ));
        return;
    }

    if (!sScriptMgr->CanSendAuctionHello(this, packet.CreatureGuid, unit))
    {
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
    {
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);
    }

    AuctionHouseEntry const* auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntry(unit->GetFaction());
    if (!auctionHouseEntry)
    {
        LOG_DEBUG("network.packet", "{}: - Not found AuctionHouseEntry for creature {}", __FUNCTION__, packet.CreatureGuid.ToString());
        return;
    }

    WorldPackets::AuctionHouse::HelloToClient packetSend;
    packetSend.CreatureGuid = packet.CreatureGuid;
    packetSend.HouseID = auctionHouseEntry->houseId;

    SendPacket(packetSend.Write());
}

// Call this method when player bids, creates, or deletes auction
void WorldSession::SendAuctionCommandResult(uint32 auctionId, uint32 action, uint32 errorCode, uint32 bidError)
{
    WorldPackets::AuctionHouse::CommandResult packet;
    packet.AuctionID = auctionId;
    packet.Action = action;
    packet.ErrorCode = errorCode;
    packet.BidError = bidError;

    SendPacket(packet.Write());
}

// Function sends notification, if bidder is online
void WorldSession::SendAuctionBidderNotification(uint32 location, uint32 auctionId, ObjectGuid bidder, uint32 bidSum, uint32 diff, uint32 item_template)
{
    WorldPackets::AuctionHouse::BidderNotification packet;
    packet.Location = location;
    packet.AuctionID = auctionId;
    packet.Bidder = bidder;
    packet.BidSum = bidSum;
    packet.Diff = diff;
    packet.ItemEntry = item_template;

    SendPacket(packet.Write());
}

// Causes on client to display: "Your auction sold"
void WorldSession::SendAuctionOwnerNotification(AuctionEntry* auction)
{
    WorldPackets::AuctionHouse::OwnerNotification packet;
    packet.ID = auction->Id;
    packet.Bid = auction->bid;
    packet.ItemEntry = auction->item_template;

    SendPacket(packet.Write());
}

// Creates new auction and adds auction to some auctionhouse
void WorldSession::HandleAuctionSellItem(WorldPackets::AuctionHouse::SellItem& packet)
{
    if (packet.ItemsCount > MAX_AUCTION_ITEMS)
    {
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    for (uint32 i = 0; i < packet.ItemsCount; ++i)
    {
        auto const& [itemGuid, itemCount] = packet.Items[i];

        if (!itemGuid || !itemCount || itemCount > 1000)
        {
            return;
        }
    }

    if (!packet.Bid || !packet.ElapsedTime)
        return;

    if (packet.Bid > MAX_MONEY_AMOUNT || packet.Buyout > MAX_MONEY_AMOUNT)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Player {} ({}) attempted to sell item with higher price than max gold amount.",
            _player->GetName(), _player->GetGUID().ToString());
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(packet.Auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Unit ({}) not found or you can't interact with him.", packet.Auctioneer.ToString());
        return;
    }

    AuctionHouseEntry const* auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntry(creature->GetFaction());
    if (!auctionHouseEntry)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Unit ({}) has wrong faction.", packet.Auctioneer.ToString());
        return;
    }

    packet.ElapsedTime *= MINUTE;

    switch (packet.ElapsedTime)
    {
        case 1 * MIN_AUCTION_TIME:
        case 2 * MIN_AUCTION_TIME:
        case 4 * MIN_AUCTION_TIME:
            break;
        default:
            return;
    }

    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    std::vector<Item*> items;

    uint32 finalCount = 0;
    uint32 itemEntry = 0;

    for (uint32 i = 0; i < packet.ItemsCount; ++i)
    {
        auto const& [itemGuid, itemCount] = packet.Items[i];

        Item* item = _player->GetItemByGuid(itemGuid);
        if (!item)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }

        if (!itemEntry)
        {
            itemEntry = item->GetTemplate()->ItemId;
        }

        if (sAuctionMgr->GetAItem(item->GetGUID()) || !item->CanBeTraded() || item->IsNotEmptyBag() ||
            item->GetTemplate()->Flags & ITEM_FLAG_CONJURED || item->GetUInt32Value(ITEM_FIELD_DURATION) ||
            item->GetCount() < itemCount || itemEntry != item->GetTemplate()->ItemId)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            return;
        }

        items.emplace_back(item);
        finalCount += itemCount;
    }

    if (!finalCount)
    {
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    // Check if there are 2 identical guids, in this case user is most likely cheating
    for (uint32 i = 0; i < packet.ItemsCount - 1; ++i)
    {
        for (uint32 j = i + 1; j < packet.ItemsCount; ++j)
        {
            if (packet.Items[i].first == packet.Items[j].first)
            {
                SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
                return;
            }
        }
    }

    for (auto const& item : items)
    {
        if (item->GetMaxStackCount() < finalCount)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            return;
        }
    }

    for (uint32 i = 0; i < packet.ItemsCount; ++i)
    {
        Item* item = items[i];

        uint32 auctionTime = uint32(packet.ElapsedTime * sWorld->getRate(RATE_AUCTION_TIME));
        AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

        uint32 deposit = sAuctionMgr->GetAuctionDeposit(auctionHouseEntry, packet.ElapsedTime, item, finalCount);
        if (!_player->HasEnoughMoney(deposit))
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_NOT_ENOUGHT_MONEY);
            return;
        }

        _player->ModifyMoney(-int32(deposit));

        AuctionEntry* AH = new AuctionEntry;
        AH->Id = sObjectMgr->GenerateAuctionID();

        if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
            AH->houseId = AUCTIONHOUSE_NEUTRAL;
        else
        {
            CreatureData const* auctioneerData = sObjectMgr->GetCreatureData(creature->GetSpawnId());
            if (!auctioneerData)
            {
                LOG_ERROR("network.opcode", "Data for auctioneer not found ({})", packet.Auctioneer.ToString());
                return;
            }

            CreatureTemplate const* auctioneerInfo = sObjectMgr->GetCreatureTemplate(auctioneerData->id1);
            if (!auctioneerInfo)
            {
                LOG_ERROR("network.opcode", "Non existing auctioneer ({})", packet.Auctioneer.ToString());
                return;
            }

            const AuctionHouseEntry* AHEntry = sAuctionMgr->GetAuctionHouseEntry(auctioneerInfo->faction);
            AH->houseId = AHEntry->houseId;
        }

        // Required stack size of auction matches to current item stack size, just move item to auctionhouse
        if (packet.ItemsCount == 1 && item->GetCount() == packet.Items[i].second)
        {
            AH->item_guid = item->GetGUID();
            AH->item_template = item->GetEntry();
            AH->itemCount = item->GetCount();
            AH->owner = _player->GetGUID();
            AH->startbid = packet.Bid;
            AH->bidder = ObjectGuid::Empty;
            AH->bid = 0;
            AH->buyout = packet.Buyout;
            AH->expire_time = GameTime::GetGameTime().count() + auctionTime;
            AH->deposit = deposit;
            AH->auctionHouseEntry = auctionHouseEntry;

            LOG_DEBUG("network.opcode", "CMSG_AUCTION_SELL_ITEM: Player {} ({}) is selling item {} entry {} ({}) with count {} with initial bid {} with buyout {} and with time {} (in sec) in auctionhouse {}",
                _player->GetName(), _player->GetGUID().ToString(), item->GetTemplate()->Name1, item->GetEntry(), item->GetGUID().ToString(), item->GetCount(), packet.Bid, packet.Buyout, auctionTime, AH->GetHouseId());

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

            _player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION, 1);
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
            AH->startbid = packet.Bid;
            AH->bidder = ObjectGuid::Empty;
            AH->bid = 0;
            AH->buyout = packet.Buyout;
            AH->expire_time = GameTime::GetGameTime().count() + auctionTime;
            AH->deposit = deposit;
            AH->auctionHouseEntry = auctionHouseEntry;

            LOG_DEBUG("network.opcode", "CMSG_AUCTION_SELL_ITEM: Player {} ({}) is selling item {} entry {} ({}) with count {} with initial bid {} with buyout {} and with time {} (in sec) in auctionhouse {}",
                _player->GetName(), _player->GetGUID().ToString(), newItem->GetTemplate()->Name1, newItem->GetEntry(), newItem->GetGUID().ToString(), newItem->GetCount(), packet.Bid, packet.Buyout, auctionTime, AH->GetHouseId());
            sAuctionMgr->AddAItem(newItem);
            auctionHouse->AddAuction(AH);

            for (uint32 j = 0; j < packet.ItemsCount; ++j)
            {
                Item* item2 = items[j];

                // Item stack count equals required count, ready to delete item - cloned item will be used for auction
                if (item2->GetCount() == packet.Items[j].second)
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
                    item2->SetCount(item2->GetCount() - packet.Items[j].second);
                    item2->SetState(ITEM_CHANGED, _player);
                    _player->ItemRemovedQuestCheck(item2->GetEntry(), packet.Items[j].second);
                    item2->SendUpdateToPlayer(_player);

                    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
                    item2->SaveToDB(trans);
                    CharacterDatabase.CommitTransaction(trans);
                }
            }

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            newItem->SaveToDB(trans);
            AH->SaveToDB(trans);
            _player->SaveInventoryAndGoldToDB(trans);
            CharacterDatabase.CommitTransaction(trans);

            SendAuctionCommandResult(AH->Id, AUCTION_SELL_ITEM, ERR_AUCTION_OK);

            _player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION, 1);
            return;
        }
    }
}

// Called when client bids or buys out auction
void WorldSession::HandleAuctionPlaceBid(WorldPackets::AuctionHouse::PlaceBid& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_PLACE_BID");

    if (!packet.AuctionID || !packet.Price)
        return;                                             //check for cheaters

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(packet.Auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionPlaceBid - Unit ({}) not found or you can't interact with him.", packet.Auctioneer.ToString());
        return;
    }

    // Remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
    {
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);
    }

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    AuctionEntry* auction = auctionHouse->GetAuction(packet.AuctionID);
    Player* player = GetPlayer();

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
    if (packet.Price <= auction->bid || packet.Price < auction->startbid)
        return;

    // price too low for next bid if not buyout
    if ((packet.Price < auction->buyout || auction->buyout == 0) &&
        packet.Price < auction->bid + auction->GetAuctionOutBid())
    {
        //auction has already higher bid, client tests it!
        return;
    }

    if (!player->HasEnoughMoney(packet.Price))
    {
        //you don't have enought money!, client tests!
        //SendAuctionCommandResult(auction->auctionId, AUCTION_PLACE_BID, ???);
        return;
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    if (packet.Price < auction->buyout || !auction->buyout)
    {
        if (auction->bidder)
        {
            if (auction->bidder == player->GetGUID())
                player->ModifyMoney(-int32(packet.Price - auction->bid));
            else
            {
                // mail to last bidder and return money
                sAuctionMgr->SendAuctionOutbiddedMail(auction, packet.Price, GetPlayer(), trans);
                player->ModifyMoney(-int32(packet.Price));
            }
        }
        else
            player->ModifyMoney(-int32(packet.Price));

        auction->bidder = player->GetGUID();
        auction->bid = packet.Price;
        GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID, packet.Price);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_AUCTION_BID);
        stmt->SetData(0, auction->bidder.GetCounter());
        stmt->SetData(1, auction->bid);
        stmt->SetData(2, auction->Id);
        trans->Append(stmt);

        SendAuctionCommandResult(auction->Id, AUCTION_PLACE_BID, ERR_AUCTION_OK, 0);
    }
    else
    {
        // Buyout:
        if (player->GetGUID() == auction->bidder)
        {
            player->ModifyMoney(-int32(auction->buyout - auction->bid));
        }
        else
        {
            player->ModifyMoney(-int32(auction->buyout));

            if (auction->bidder)
            {
                // Buyout for bidded auction ...
                sAuctionMgr->SendAuctionOutbiddedMail(auction, auction->buyout, GetPlayer(), trans);
            }
        }

        auction->bidder = player->GetGUID();
        auction->bid = auction->buyout;
        GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID, auction->buyout);

        //- Mails must be under transaction control too to prevent data loss
        sAuctionMgr->SendAuctionSalePendingMail(auction, trans);
        sAuctionMgr->SendAuctionSuccessfulMail(auction, trans);
        sAuctionMgr->SendAuctionWonMail(auction, trans);

        SendAuctionCommandResult(auction->Id, AUCTION_PLACE_BID, ERR_AUCTION_OK);

        auction->DeleteFromDB(trans);

        sAuctionMgr->RemoveAItem(auction->item_guid);
        auctionHouse->RemoveAuction(auction);
    }

    player->SaveInventoryAndGoldToDB(trans);
    CharacterDatabase.CommitTransaction(trans);
}

// Called when auction_owner cancels his auction
void WorldSession::HandleAuctionRemoveItem(WorldPackets::AuctionHouse::RemoveItem& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_REMOVE_ITEM");

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(packet.Auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionRemoveItem - Unit ({}) not found or you can't interact with him.", packet.Auctioneer.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    AuctionEntry* auction = auctionHouse->GetAuction(packet.AuctionID);
    Player* player = GetPlayer();

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    if (auction && auction->owner == player->GetGUID())
    {
        Item* pItem = sAuctionMgr->GetAItem(auction->item_guid);
        if (pItem)
        {
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
            LOG_ERROR("network.opcode", "Auction id: {} has non-existed item (item: {})!!!", auction->Id, auction->item_guid.ToString());
            SendAuctionCommandResult(0, AUCTION_CANCEL, ERR_AUCTION_DATABASE_ERROR);
            return;
        }
    }
    else
    {
        SendAuctionCommandResult(0, AUCTION_CANCEL, ERR_AUCTION_DATABASE_ERROR);
        //this code isn't possible ... maybe there should be assert
        LOG_ERROR("network.opcode", "CHEATER : {}, he tried to cancel auction (id: {}) of another player, or auction is nullptr", player->GetGUID().ToString(), packet.AuctionID);
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

// Called when player lists his bids
void WorldSession::HandleAuctionListBidderItems(WorldPackets::AuctionHouse::ListBidderItems& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_LIST_BIDDER_ITEMS");

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(packet.Auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionListBidderItems - Unit ({}) not found or you can't interact with him.", packet.Auctioneer.ToString());
        return;
    }

    auto auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());
    if (!auctionHouse)
    {
        LOG_ERROR("network.packet", "{}: - Not found AuctionHouseObject for creature {}", __FUNCTION__, packet.Auctioneer.ToString());
        return;
    }

    // remove fake death
    if (_player->HasUnitState(UNIT_STATE_DIED))
    {
        _player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);
    }

    WorldPackets::AuctionHouse::BidderListResult packetSend(auctionHouse);
    packetSend.OutbiddedAuctionIds = packet.OutbiddedAuctionIds;
    packetSend.PlayerGuid = _player->GetGUID();

    SendPacket(packetSend.Write());
}

// Sends player info about his auctions
void WorldSession::HandleAuctionListOwnerItems(WorldPackets::AuctionHouse::ListOwnerItems& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_LIST_OWNER_ITEMS");

    Creature* creature = _player->GetNPCIfCanInteractWith(packet.Auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_ERROR("network.packet", "{}: - {} not found or you can't interact with him.", __FUNCTION__, packet.Auctioneer.ToString());
        return;
    }

    auto auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());
    if (!auctionHouse)
    {
        LOG_ERROR("network.packet", "{}: - Not found AuctionHouseObject for creature {}", __FUNCTION__, packet.Auctioneer.ToString());
        return;
    }

    WorldPackets::AuctionHouse::ListOwnerResult packetSend;
    packetSend.Auctioneer = packet.Auctioneer;
    packetSend.PlayerGuid = _player->GetGUID();
    packetSend.auctionHouse = auctionHouse;

    // remove fake death
    if (_player->HasUnitState(UNIT_STATE_DIED))
    {
        _player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);
    }

    SendPacket(packetSend.Write());
}

//this void is called when player clicks on search button
void WorldSession::HandleAuctionListItems(WorldPackets::AuctionHouse::ListItems& packet)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_LIST_ITEMS");

    // remove fake death
    if (_player->HasUnitState(UNIT_STATE_DIED))
    {
        _player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);
    }

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(packet.CreatureGuid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network.packet", "WORLD: HandleAuctionListItems - {} not found or you can't interact with him.", packet.CreatureGuid.ToString());
        return;
    }

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());
    if (!auctionHouse)
    {
        LOG_ERROR("network.packet", "{}: - Not found AuctionHouseObject for creature {}", __FUNCTION__, creature->GetGUID().ToString());
        return;
    }

    WorldPackets::AuctionHouse::ListResult packetResult;
    packetResult.auctionHouse = auctionHouse;
    packetResult.player = _player;

    if (!packetResult.IsExistResult(packet))
    {
        return;
    }

    packetResult.ListFrom = packet.ListFrom;

    LOG_DEBUG("auctionHouse", "Auctionhouse search ({}) list from: {}, searchedname: {}, levelmin: {}, levelmax: {}, auctionSlotID: {}, auctionMainCategory: {}, auctionSubCategory: {}, quality: {}, usable: {}",
        packet.CreatureGuid.ToString(),
        packet.ListFrom,
        packet.SearchedName,
        packet.LevelMin,
        packet.LevelMax,
        packet.AuctionSlotID,
        packet.AuctionMainCategory,
        packet.AuctionSubCategory,
        packet.Quality,
        packet.Usable);

    SendPacket(packetResult.Write());
}

void WorldSession::HandleAuctionListPendingSales(WorldPackets::AuctionHouse::ListPendingSales& /*packet*/)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_LIST_PENDING_SALES");

    SendPacket(WorldPackets::AuctionHouse::ListPendingSalesServer().Write());
}
