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

#include "AsyncAuctionMgr.h"
#include "AuctionHouseMgr.h"
#include "AuctionHousePackets.h"
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

// Called when player click on auctioneer npc
void WorldSession::HandleAuctionHelloOpcode(WorldPackets::AuctionHouse::HelloFromClient& packet)
{
    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(packet.CreatureGuid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionHelloOpcode - Unit ({}) not found or you can't interact with him.", packet.CreatureGuid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    SendAuctionHello(packet.CreatureGuid, unit);
}

// This void causes that auction window is opened
void WorldSession::SendAuctionHello(ObjectGuid guid, Creature* unit)
{
    if (GetPlayer()->GetLevel() < sWorld->getIntConfig(CONFIG_AUCTION_LEVEL_REQ))
    {
        SendNotification(GetAcoreString(LANG_AUCTION_REQ), sWorld->getIntConfig(CONFIG_AUCTION_LEVEL_REQ));
        return;
    }

    if (!sScriptMgr->CanSendAuctionHello(this, guid, unit))
        return;

    AuctionHouseEntry const* auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntry(unit->GetFaction());
    if (!auctionHouseEntry)
    {
        LOG_DEBUG("network.packet", "{}: - Not found AuctionHouseEntry for creature {}", __FUNCTION__, guid.ToString());
        return;
    }

    WorldPackets::AuctionHouse::HelloToClient packetSend;
    packetSend.CreatureGuid = guid;
    packetSend.HouseID = auctionHouseEntry->houseId;

    SendPacket(packetSend.Write());
}

// Call this method when player bids, creates, or deletes auction
void WorldSession::SendAuctionCommandResult(AuctionEntry const* auction, uint32 action, uint32 errorCode, uint32 inventoryError /*= 0*/)
{
    WorldPackets::AuctionHouse::CommandResult packet{ auction };
    packet.Action = action;
    packet.ErrorCode = errorCode;
    packet.InventoryError = inventoryError;

    SendPacket(packet.Write());
}

// Sends notification, if Bidder is online
void WorldSession::SendAuctionBidderNotification(uint32 location, uint32 auctionId, ObjectGuid Bidder, uint32 bidSum, uint32 diff, uint32 ItemID)
{
    WorldPackets::AuctionHouse::BidderNotification packet;
    packet.Location = location;
    packet.AuctionID = auctionId;
    packet.Bidder = Bidder;
    packet.BidSum = bidSum;
    packet.Diff = diff;
    packet.ItemEntry = ItemID;

    SendPacket(packet.Write());
}

// This void causes on client to display: "Your auction sold"
void WorldSession::SendAuctionOwnerNotification(AuctionEntry* auction)
{
    WorldPackets::AuctionHouse::OwnerNotification packet;
    packet.ID = auction->Id;
    packet.Bid = auction->Bid;
    packet.ItemEntry = auction->ItemID;

    SendPacket(packet.Write());
}

// Creates new auction and adds auction to some auctionhouse
void WorldSession::HandleAuctionSellItem(WorldPackets::AuctionHouse::SellItem& packet)
{
    LOG_DEBUG("network", "WORLD: Recived CMSG_AUCTION_SELL_ITEM");
    sAsyncAuctionMgr->SellItem(_player->GetGUID(), std::make_shared<AuctionSellItem>(std::move(packet.SellItems)));
}

// Called when client bids or buys out auction
void WorldSession::HandleAuctionPlaceBid(WorldPackets::AuctionHouse::PlaceBid& packet)
{
    if (!packet.AuctionID || !packet.Price)
        return; // Check for cheaters

    sAsyncAuctionMgr->PlaceBid(_player->GetGUID(), packet.Auctioneer, packet.AuctionID, packet.Price);
}

// Called when auction_owner cancels his auction
void WorldSession::HandleAuctionRemoveItem(WorldPackets::AuctionHouse::RemoveItem& packet)
{
    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(packet.Auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionRemoveItem - Unit ({}) not found or you can't interact with him.", packet.Auctioneer.ToString());
        return;
    }

    // Remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());
    AuctionEntry* auction = auctionHouse->GetAuction(packet.AuctionID);
    Player* player = GetPlayer();

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    if (auction && auction->PlayerOwner == player->GetGUID())
    {
        Item* pItem = sAuctionMgr->GetAuctionItem(auction->ItemGuid);
        if (pItem)
        {
            if (auction->Bidder) // If we have a Bidder, we have to send him the money he paid
            {
                uint32 auctionCut = auction->GetAuctionCut();
                if (!player->HasEnoughMoney(auctionCut))          //player doesn't have enough money, maybe message needed
                    return;

                //some auctionBidderNotification would be needed, but don't know that parts..
                sAuctionMgr->SendAuctionCancelledToBidderMail(auction, trans);
                player->ModifyMoney(-int32(auctionCut));
            }

            // item will deleted or added to received mail list
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_CANCELED), AuctionEntry::BuildAuctionMailBody(ObjectGuid::Empty, 0, auction->BuyOut, auction->Deposit))
                    .AddItem(pItem)
                    .SendMailTo(trans, player, auction, MAIL_CHECK_MASK_COPIED);
        }
        else
        {
            LOG_ERROR("network.opcode", "Auction id: {} has non-existed item (item: {})!!!", auction->Id, auction->ItemGuid.ToString());
            SendAuctionCommandResult(nullptr, AUCTION_CANCEL, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }
    }
    else
    {
        SendAuctionCommandResult(nullptr, AUCTION_CANCEL, ERR_AUCTION_DATABASE_ERROR);

        // This code isn't possible ... maybe there should be assert
        LOG_ERROR("network.opcode", "CHEATER : {}, he tried to cancel auction (id: {}) of another player, or auction is nullptr", player->GetGUID().ToString(), packet.AuctionID);
        return;
    }

    //inform player, that auction is removed
    SendAuctionCommandResult(auction, AUCTION_CANCEL, ERR_AUCTION_OK);

    // Now remove the auction

    player->SaveInventoryAndGoldToDB(trans);
    auction->DeleteFromDB(trans);
    CharacterDatabase.CommitTransaction(trans);

    sAuctionMgr->RemoveAItem(auction->ItemGuid);
    auctionHouse->RemoveAuction(auction);
}

// Called when player lists his bids
void WorldSession::HandleAuctionListBidderItems(WorldPackets::AuctionHouse::ListBidderItems& packet)
{
    sAsyncAuctionMgr->ListBidderItems(_player->GetGUID(), packet.Auctioneer, std::move(packet.OutbiddedAuctionIds));
}

// Sends player info about his auctions
void WorldSession::HandleAuctionListOwnerItems(WorldPackets::AuctionHouse::ListOwnerItems& packet)
{
    sAsyncAuctionMgr->ListOwnerItems(_player->GetGUID(), packet.Auctioneer);
}

// Called when player clicks on search button
void WorldSession::HandleAuctionListItems(WorldPackets::AuctionHouse::ListItems& packet)
{
    // Remove fake death
    if (_player->HasUnitState(UNIT_STATE_DIED))
        _player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    sAsyncAuctionMgr->ListItems(_player->GetGUID(), std::make_shared<AuctionListItems>(std::move(packet.AuctionItems)));
}

void WorldSession::HandleAuctionListPendingSales(WorldPackets::AuctionHouse::ListPendingSales& /*packet*/)
{
    SendPacket(WorldPackets::AuctionHouse::ListPendingSalesServer().Write());
}
