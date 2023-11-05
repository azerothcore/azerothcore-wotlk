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

#include "AsyncAuctionOperation.h"
#include "AuctionHouseMgr.h"
#include "AuctionHousePackets.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"

Player* AsyncAuctionOperation::GetPlayer() const
{
    return ObjectAccessor::FindPlayer(_playerGuid);
}

void SellItemTask::Execute()
{
    auto player{ GetPlayer() };
    if (!player)
        return;

    auto session{ player->GetSession() };

    if (_packet->ItemsCount > MAX_AUCTION_ITEMS)
    {
        session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    for (uint32 i = 0; i < _packet->ItemsCount; ++i)
    {
        auto const& [itemGuid, itemCount] = _packet->Items[i];
        if (!itemGuid || !itemCount || itemCount > 1000)
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }
    }

    if (!_packet->Bid || !_packet->ExpireTime)
    {
        session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    if (_packet->Bid > MAX_MONEY_AMOUNT || _packet->Buyout > MAX_MONEY_AMOUNT)
    {
        LOG_ERROR("network", "WORLD: HandleAuctionSellItem - Player {} ({}) attempted to sell item with higher price than max gold amount.", player->GetName(), player->GetGUID().ToString());
        session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    Creature* creature = player->GetNPCIfCanInteractWith(_packet->Auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_ERROR("network", "WORLD: HandleAuctionSellItem - Unit ({}) not found or you can't interact with him.", _packet->Auctioneer.ToString());
        session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    AuctionHouseEntry const* auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntry(creature->GetFaction());
    if (!auctionHouseEntry)
    {
        LOG_ERROR("network", "WORLD: HandleAuctionSellItem - Unit ({}) has wrong faction.", _packet->Auctioneer.ToString());
        session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    Seconds depositTime{ Minutes{ _packet->ExpireTime } };
    if (depositTime != 12h && depositTime != 1_days && depositTime != 2_days)
    {
        LOG_ERROR("network", "HandleAuctionSellItem: Incorrect deposit time: {}. Player info: {}", Acore::Time::ToTimeString(depositTime), session->GetPlayerInfo());
        session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    if (player->HasUnitState(UNIT_STATE_DIED))
        player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    std::array<Item*, MAX_AUCTION_ITEMS> items{};
    uint32 finalCount = 0;
    uint32 itemEntry = 0;

    for (uint32 i = 0; i < _packet->ItemsCount; ++i)
    {
        auto const& [itemGuid, itemCount] = _packet->Items[i];

        Item* item = player->GetItemByGuid(itemGuid);
        if (!item)
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }

        if (!itemEntry)
            itemEntry = item->GetTemplate()->ItemId;

        if (sAuctionMgr->GetAuctionItem(item->GetGUID()))
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }

        if (!item->CanBeTraded())
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_INVENTORY, EQUIP_ERR_CANNOT_TRADE_THAT);
            return;
        }

        if (item->IsNotEmptyBag())
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_INVENTORY, EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS);
            return;
        }

        if (item->GetTemplate()->Flags & ITEM_FLAG_CONJURED || item->GetUInt32Value(ITEM_FIELD_DURATION))
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_INVENTORY, EQUIP_ERR_CANNOT_TRADE_THAT);
            return;
        }

        if (item->GetCount() < itemCount || itemEntry != item->GetTemplate()->ItemId)
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }

        items[i] = item;
        finalCount += itemCount;
    }

    if (!finalCount)
    {
        session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
        return;
    }

    // Check if there are 2 identical guids, in this case user is most likely cheating
    for (uint32 i = 0; i < _packet->ItemsCount - 1; ++i)
    {
        for (uint32 j = i + 1; j < _packet->ItemsCount; ++j)
        {
            if (_packet->Items[i].first == _packet->Items[j].first)
            {
                session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
                return;
            }
        }
    }

    for (uint32 i = 0; i < _packet->ItemsCount; ++i)
    {
        Item* item = items[i];
        if (!item || item->GetMaxStackCount() < finalCount)
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }
    }

    for (uint32 i = 0; i < _packet->ItemsCount; ++i)
    {
        Item* item = items[i];

        auto auctionTime = Seconds(std::size_t(float(depositTime.count()) * sWorld->getRate(RATE_AUCTION_TIME)));
        AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

        uint32 deposit = sAuctionMgr->GetAuctionDeposit(auctionHouseEntry, Minutes{ _packet->ExpireTime }, item, finalCount);
        if (!player->HasEnoughMoney(deposit))
        {
            session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_NOT_ENOUGHT_MONEY);
            return;
        }

        player->ModifyMoney(-int32(deposit));

        auto auction = std::make_unique<AuctionEntry>();
        auction->Id = sObjectMgr->GenerateAuctionID();

        if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
            auction->HouseId = AUCTIONHOUSE_NEUTRAL;
        else
        {
            AuctionHouseEntry const* AHEntry = sAuctionMgr->GetAuctionHouseEntry(creature->GetCreatureTemplate()->faction);
            auction->HouseId = AHEntry->houseId;
        }

        auction->PlayerOwner = player->GetGUID();
        auction->StartBid = _packet->Bid;
        auction->BuyOut = _packet->Buyout;
        auction->BuyOut = _packet->Buyout;
        auction->ExpireTime = GameTime::GetGameTime() + auctionTime;
        auction->Deposit = deposit;
        auction->auctionHouseEntry = auctionHouseEntry;

        // Required stack size of auction matches to current item stack size, just move item to auctionhouse
        if (_packet->ItemsCount == 1 && item->GetCount() == _packet->Items[i].second)
        {
            auction->ItemGuid = item->GetGUID();
            auction->ItemID = item->GetEntry();
            auction->ItemCount = item->GetCount();

            LOG_DEBUG("network.opcode", "CMSG_AUCTION_SELL_ITEM: Player {} ({}) is selling item {} entry {} ({}) with count {} with initial Bid {} with BuyOut {} and with time {} (in sec) in auctionhouse {}",
                      player->GetName(), player->GetGUID().ToString(), item->GetTemplate()->Name1, item->GetEntry(), item->GetGUID().ToString(), item->GetCount(), _packet->Bid, _packet->Buyout, auctionTime.count(), auction->GetHouseId());

            player->MoveItemFromInventory(item->GetBagSlot(), item->GetSlot(), true);

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            item->DeleteFromInventoryDB(trans);
            item->SaveToDB(trans);

            auction->SaveToDB(trans);
            player->SaveInventoryAndGoldToDB(trans);

            CharacterDatabase.CommitTransaction(trans);

            session->SendAuctionCommandResult(auction.get(), AUCTION_SELL_ITEM, ERR_AUCTION_OK);

            sAuctionMgr->AddAuctionItem(item);
            auctionHouse->AddAuction(std::move(auction));

            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION, 1);
            return;
        }
        else // Required stack size of auction does not match to current item stack size, clone item and set correct stack size
        {
            Item* newItem = item->CloneItem(finalCount, player);
            if (!newItem)
            {
                LOG_ERROR("network.opcode", "CMSG_AUCTION_SELL_ITEM: Could not create clone of item {}", item->GetEntry());
                session->SendAuctionCommandResult(nullptr, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
                return;
            }

            auction->ItemGuid = newItem->GetGUID();
            auction->ItemID = newItem->GetEntry();
            auction->ItemCount = newItem->GetCount();

            LOG_DEBUG("network.opcode", "CMSG_AUCTION_SELL_ITEM: Player {} ({}) is selling item {} entry {} ({}) with count {} with initial Bid {} with BuyOut {} and with time {} (in sec) in auctionhouse {}",
                player->GetName(), player->GetGUID().ToString(), newItem->GetTemplate()->Name1, newItem->GetEntry(), newItem->GetGUID().ToString(),
                newItem->GetCount(), _packet->Bid, _packet->Buyout, auctionTime.count(), auction->GetHouseId());

            for (uint32 j = 0; j < _packet->ItemsCount; ++j)
            {
                Item* item2 = items[j];

                // Item stack count equals required count, ready to delete item - cloned item will be used for auction
                if (item2->GetCount() == _packet->Items[j].second)
                {
                    player->MoveItemFromInventory(item2->GetBagSlot(), item2->GetSlot(), true);

                    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
                    item2->DeleteFromInventoryDB(trans);
                    item2->DeleteFromDB(trans);
                    CharacterDatabase.CommitTransaction(trans);
                    delete item2;
                }
                else // Item stack count is bigger than required count, update item stack count and save to database - cloned item will be used for auction
                {
                    item2->SetCount(item2->GetCount() - _packet->Items[j].second);
                    item2->SetState(ITEM_CHANGED, player);
                    player->ItemRemovedQuestCheck(item2->GetEntry(), _packet->Items[j].second);
                    item2->SendUpdateToPlayer(player);

                    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
                    item2->SaveToDB(trans);
                    CharacterDatabase.CommitTransaction(trans);
                }
            }

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            newItem->SaveToDB(trans);
            auction->SaveToDB(trans);
            player->SaveInventoryAndGoldToDB(trans);
            CharacterDatabase.CommitTransaction(trans);

            session->SendAuctionCommandResult(auction.get(), AUCTION_SELL_ITEM, ERR_AUCTION_OK);

            sAuctionMgr->AddAuctionItem(newItem);
            auctionHouse->AddAuction(std::move(auction));

            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION, 1);
            return;
        }
    }
}

void PlaceBidTask::Execute()
{
    auto player{ GetPlayer() };
    if (!player)
        return;

    auto session{ player->GetSession() };

    Creature* creature = player->GetNPCIfCanInteractWith(_auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_ERROR("network", "WORLD: HandleAuctionPlaceBid - Unit ({}) not found or you can't interact with him.", _auctioneer.ToString());
        return;
    }

    // Remove fake death
    if (player->HasUnitState(UNIT_STATE_DIED))
        player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());
    AuctionEntry* auction = auctionHouse->GetAuction(_auctionID);

    if (!auction || auction->PlayerOwner == player->GetGUID())
    {
        //you cannot Bid your own auction:
        session->SendAuctionCommandResult(nullptr, AUCTION_PLACE_BID, ERR_AUCTION_BID_OWN);
        return;
    }

    // Impossible have online own another character (use this for speedup check in case online owner)
    Player* auctionOwner = ObjectAccessor::FindConnectedPlayer(auction->PlayerOwner);
    if (!auctionOwner && sCharacterCache->GetCharacterAccountIdByGuid(auction->PlayerOwner) == session->GetAccountId())
    {
        // Cannot Bid another character auction
        session->SendAuctionCommandResult(nullptr, AUCTION_PLACE_BID, ERR_AUCTION_BID_OWN);
        return;
    }

    // cheating
    if (_price <= auction->Bid || _price < auction->StartBid)
    {
        // client test but possible in result lags
        session->SendAuctionCommandResult(auction, AUCTION_PLACE_BID, ERR_AUCTION_HIGHER_BID);
    }

    // price too low for next Bid if not BuyOut
    if ((_price < auction->BuyOut || auction->BuyOut == 0) && _price < auction->Bid + auction->GetAuctionOutBid())
    {
        // Auction has already higher Bid, client tests it!
        session->SendAuctionCommandResult(auction, AUCTION_PLACE_BID, ERR_AUCTION_BID_INCREMENT);
        return;
    }

    if (!player->HasEnoughMoney(_price))
        return;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    if (_price < auction->BuyOut || auction->BuyOut == 0)
    {
        if (auction->Bidder)
        {
            if (auction->Bidder == player->GetGUID())
                player->ModifyMoney(-int32(_price - auction->Bid));
            else
            {
                // mail to last Bidder and return money
                sAuctionMgr->SendAuctionOutbiddedMail(auction, _price, player, trans);
                player->ModifyMoney(-int32(_price));
            }
        }
        else
            player->ModifyMoney(-int32(_price));

        auction->Bidder = player->GetGUID();
        auction->Bid = _price;
        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID, _price);

        auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_AUCTION_BID);
        stmt->SetData(0, auction->Bidder.GetCounter());
        stmt->SetData(1, auction->Bid);
        stmt->SetData(2, auction->Id);
        trans->Append(stmt);

        session->SendAuctionCommandResult(auction, AUCTION_PLACE_BID, ERR_AUCTION_OK);
    }
    else
    {
        // Buyout:
        if (player->GetGUID() == auction->Bidder)
            player->ModifyMoney(-int32(auction->BuyOut - auction->Bid));
        else
        {
            player->ModifyMoney(-int32(auction->BuyOut));

            if (auction->Bidder) // Buyout for Bid auction
                sAuctionMgr->SendAuctionOutbiddedMail(auction, auction->BuyOut, player, trans);
        }

        auction->Bidder = player->GetGUID();
        auction->Bid = auction->BuyOut;

        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID, auction->BuyOut);

        //- Mails must be under transaction control too to prevent data loss
        sAuctionMgr->SendAuctionSalePendingMail(auction, trans);
        sAuctionMgr->SendAuctionSuccessfulMail(auction, trans);
        sAuctionMgr->SendAuctionWonMail(auction, trans);
        sScriptMgr->OnAuctionSuccessful(auctionHouse, auction);

        session->SendAuctionCommandResult(auction, AUCTION_PLACE_BID, ERR_AUCTION_OK);
        auction->DeleteFromDB(trans);

        sAuctionMgr->RemoveAItem(auction->ItemGuid);
        auctionHouse->RemoveAuction(auction);
    }

    player->SaveInventoryAndGoldToDB(trans);
    CharacterDatabase.CommitTransaction(trans);
}

void ListBidderItemsTask::Execute()
{
    auto player{ GetPlayer() };
    if (!player)
        return;

    Creature* creature = player->GetNPCIfCanInteractWith(_auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_ERROR("network", "Unit ({}) not found or you can't interact with him.", _auctioneer.ToString());
        return;
    }

    // remove fake death
    if (player->HasUnitState(UNIT_STATE_DIED))
        player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    auto auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());
    if (!auctionHouse)
    {
        LOG_ERROR("network.packet", "Not found AuctionHouseObject for creature {}", _auctioneer.ToString());
        return;
    }

    WorldPackets::AuctionHouse::BidderListResult packetSend(auctionHouse);
    packetSend.OutbiddedAuctionIds = std::move(_outbiddedAuctionIds);
    packetSend.PlayerGuid = GetPlayerGUID();

    player->SendDirectMessage(packetSend.Write());
}

void ListOwnerTask::Execute()
{
    auto player{ GetPlayer() };
    if (!player)
        return;

    Creature* creature = player->GetNPCIfCanInteractWith(_creatureGuid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_ERROR("network", "Unit ({}) not found or you can't interact with him.", _creatureGuid.ToString());
        return;
    }

    // remove fake death
    if (player->HasUnitState(UNIT_STATE_DIED))
        player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    WorldPackets::AuctionHouse::ListOwnerResult packetSend;
    packetSend.Auctioneer = _creatureGuid;
    packetSend.PlayerGuid = GetPlayerGUID();
    packetSend.auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    player->SendDirectMessage(packetSend.Write());
}

void ListItemsTask::Execute()
{
    auto player{ GetPlayer() };
    if (!player || player->IsDuringRemoveFromWorld() || player->IsBeingTeleported())
        return;

    Creature* creature = player->GetNPCIfCanInteractWith(_packet->CreatureGuid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
        return;

    WorldPackets::AuctionHouse::ListResult packetSend;
    if (!packetSend.IsCorrectSearchedName(_packet->SearchedName))
    {
        LOG_ERROR("network", "ListItemsTask::Execute: Incorrect searched name: {}. Player: {}", _packet->SearchedName, player->GetSession()->GetPlayerInfo());
        return;
    }

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());
    auctionHouse->BuildListAuctionItems(packetSend, player, std::move(_packet));
    player->SendDirectMessage(packetSend.Write());
}
