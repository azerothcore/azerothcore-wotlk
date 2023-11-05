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
#include "AuctionHousePackets.h"
#include "Common.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Item.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "StopWatch.h"
#include "UpdateTime.h"
#include "WorldPacket.h"
#include <sstream>
#include <vector>

constexpr auto AH_MINIMUM_DEPOSIT = 100;

// Proof of concept, we should shift the info we're obtaining in here into AuctionEntry probably
static bool SortAuction(AuctionEntry* left, AuctionEntry* right, AuctionSortOrderVector& sortOrder, Player* player, bool checkMinBidBuyout)
{
    for (auto const& order : sortOrder)
    {
        switch (order.SortOrder)
        {
            case AuctionSortOrder::Bid:
            {
                if (left->Bid == right->Bid)
                {
                    if (checkMinBidBuyout)
                    {
                        if (left->BuyOut == right->BuyOut)
                        {
                            if (left->StartBid == right->StartBid)
                                continue;

                            return order.IsDesc ? left->StartBid > right->StartBid : left->StartBid < right->StartBid;
                        }

                        return order.IsDesc ? left->BuyOut > right->BuyOut : left->BuyOut < right->BuyOut;
                    }

                    continue;
                }

                return order.IsDesc ? left->Bid > right->Bid : left->Bid < right->Bid;
            }
            case AuctionSortOrder::BuyOut:
            case AuctionSortOrder::BuyOut2:
            {
                if (left->BuyOut == right->BuyOut)
                    continue;

                return order.IsDesc ? left->BuyOut > right->BuyOut : left->BuyOut < right->BuyOut;
            }
            case AuctionSortOrder::Item:
            {
                ItemTemplate const* protoLeft = sObjectMgr->GetItemTemplate(left->ItemID);
                ItemTemplate const* protoRight = sObjectMgr->GetItemTemplate(right->ItemID);
                if (!protoLeft || !protoRight)
                    continue;

                std::string leftName = protoLeft->Name1;
                std::string rightName = protoRight->Name1;
                if (leftName.empty() || rightName.empty())
                    continue;

                LocaleConstant locale = LOCALE_enUS;
                if (player && player->GetSession())
                    locale = player->GetSession()->GetSessionDbLocaleIndex();

                if (locale > LOCALE_enUS)
                {
                    if (ItemLocale const* leftIl = sObjectMgr->GetItemLocale(protoLeft->ItemId))
                    {
                        ObjectMgr::GetLocaleString(leftIl->Name, locale, leftName);
                    }

                    if (ItemLocale const* rightIl = sObjectMgr->GetItemLocale(protoRight->ItemId))
                    {
                        ObjectMgr::GetLocaleString(rightIl->Name, locale, rightName);
                    }
                }

                int result = leftName.compare(rightName);
                if (!result)
                    continue;

                return order.IsDesc ? result > 0 : result < 0;
            }
            case AuctionSortOrder::MinLevel:
            {
                ItemTemplate const* protoLeft  = sObjectMgr->GetItemTemplate(left->ItemID);
                ItemTemplate const* protoRight = sObjectMgr->GetItemTemplate(right->ItemID);
                if (!protoLeft || !protoRight)
                    continue;

                if (protoLeft->RequiredLevel == protoRight->RequiredLevel)
                    continue;

                return order.IsDesc ? protoLeft->RequiredLevel > protoRight->RequiredLevel : protoLeft->RequiredLevel < protoRight->RequiredLevel;
            }
            case AuctionSortOrder::Owner:
            {
                std::string leftName;
                std::string rightName;
                sCharacterCache->GetCharacterNameByGuid(left->PlayerOwner, leftName);
                sCharacterCache->GetCharacterNameByGuid(right->PlayerOwner, rightName);

                int result = leftName.compare(rightName);
                if (!result)
                    continue;

                return order.IsDesc ? result > 0 : result < 0;
            }
            case AuctionSortOrder::Rarity:
            {
                ItemTemplate const* protoLeft  = sObjectMgr->GetItemTemplate(left->ItemID);
                ItemTemplate const*  protoRight = sObjectMgr->GetItemTemplate(right->ItemID);
                if (!protoLeft || !protoRight)
                    continue;

                if (protoLeft->Quality == protoRight->Quality)
                    continue;

                return order.IsDesc ? protoLeft->Quality > protoRight->Quality : protoLeft->Quality < protoRight->Quality;
            }
            case AuctionSortOrder::Stack:
            {
                if (left->ItemCount == right->ItemCount)
                    continue;

                if (!order.IsDesc)
                    return left->ItemCount < right->ItemCount;

                return left->ItemCount > right->ItemCount;
            }
            case AuctionSortOrder::TimeLeft:
            {
                if (left->ExpireTime == right->ExpireTime)
                    continue;

                return order.IsDesc ? left->ExpireTime > right->ExpireTime : left->ExpireTime < right->ExpireTime;
            }
            case AuctionSortOrder::MinBidBuy:
            {
                if (left->BuyOut == right->BuyOut)
                {
                    if (left->StartBid == right->StartBid)
                        continue;

                    return order.IsDesc ? left->StartBid > right->StartBid : left->StartBid < right->StartBid;
                }

                return order.IsDesc ? left->BuyOut > right->BuyOut : left->BuyOut < right->BuyOut;
            }
            case AuctionSortOrder::Max:
                // Such sad travis appeasement
            case AuctionSortOrder::Unk4:
            default:
                break;
        }
    }

    return false;
}

AuctionHouseObject* AuctionHouseMgr::GetAuctionsMap(uint32 factionTemplateId)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
        return &_neutralAuctions;

    // team have linked auction houses
    FactionTemplateEntry const* u_entry = sFactionTemplateStore.LookupEntry(factionTemplateId);
    if (!u_entry)
        return &_neutralAuctions;
    else if (u_entry->ourMask & FACTION_MASK_ALLIANCE)
        return &_allianceAuctions;
    else if (u_entry->ourMask & FACTION_MASK_HORDE)
        return &_hordeAuctions;

    return &_neutralAuctions;
}

AuctionHouseObject* AuctionHouseMgr::GetAuctionsMapByHouseId(uint8 auctionHouseId)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
        return &_neutralAuctions;

    switch (auctionHouseId)
    {
        case AUCTIONHOUSE_ALLIANCE:
            return &_allianceAuctions;
        case AUCTIONHOUSE_HORDE:
            return &_hordeAuctions;
            break;
    }

    return &_neutralAuctions;
}

AuctionEntry* AuctionHouseObject::GetAuction(uint32 id)
{
    std::shared_lock guard(_mutex);

    auto auction{ Acore::Containers::MapGetValuePtr(_auctions, id) };
    if (!auction)
        return nullptr;

    return auction->get();
}

void AuctionHouseObject::AddAuction(std::unique_ptr<AuctionEntry>&& auction)
{
    std::unique_lock guard(_mutex);
    ASSERT(auction);

    auto const [itr, isEmplace] = _auctions.emplace(auction->Id, std::move(auction));
    sScriptMgr->OnAuctionAdd(this, itr->second.get());
}

bool AuctionHouseObject::RemoveAuction(AuctionEntry* auction)
{
    std::unique_lock guard(_mutex);
    sScriptMgr->OnAuctionRemove(this, auction);
    return _auctions.erase(auction->Id) > 0;
}

void AuctionHouseObject::Update()
{
    std::unique_lock guard(_mutex);

    auto checkTime{ GameTime::GetGameTime() + 1min };

    // If storage is empty, no need to update. next == nullptr in this case.
    if (_auctions.empty())
        return;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    std::list<uint32> _toDelete;

    for (auto const& [auctionID, auction] : _auctions)
    {
        if (auction->ExpireTime > checkTime)
            continue;

        ///- Either cancel the auction if there was no bidder
        if (!auction->Bidder)
        {
            sAuctionMgr->SendAuctionExpiredMail(auction.get(), trans);
            sScriptMgr->OnAuctionExpire(this, auction.get());
        }
        ///- Or perform the transaction
        else
        {
            //we should send an "item sold" message if the seller is online
            //we send the item to the winner
            //we send the money to the seller
            sAuctionMgr->SendAuctionSuccessfulMail(auction.get(), trans);
            sAuctionMgr->SendAuctionWonMail(auction.get(), trans);
            sScriptMgr->OnAuctionSuccessful(this, auction.get());
        }

        ///- In any case clear the auction
        auction->DeleteFromDB(trans);

        sAuctionMgr->RemoveAItem(auction->ItemGuid);
        sScriptMgr->OnAuctionRemove(this, auction.get());
        _toDelete.emplace_back(auctionID);
    }

    CharacterDatabase.CommitTransaction(trans);

    if (!_toDelete.empty())
        for (auto id : _toDelete)
            _auctions.erase(id);
}

void AuctionHouseObject::BuildListAuctionItems(WorldPackets::AuctionHouse::ListResult& packet, Player* player, std::shared_ptr<AuctionListItems> listItems)
{
    // Ensures that listfrom is not greater that auctions count
    listItems->ListFrom = std::min(listItems->ListFrom, static_cast<uint32>(GetCount()));
    packet.ListFrom = listItems->ListFrom;
    packet.IsGetAll = listItems->GetAll == 1;

    if (listItems->GetAll || (listItems->IsNoFilter() && packet.WSearchedName.empty()))
    {
        ForEachAuctions([&packet](AuctionEntry* auction)
        {
            packet.AuctionShortlist.emplace_back(auction);
        });
    }
    else
    {
        auto curTime = GameTime::GetGameTime();
        int loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
        int locdbc_idx = player->GetSession()->GetSessionDbcLocale();

        wstrToLower(packet.WSearchedName);

        ForEachAuctions([&packet, player, &listItems, curTime, loc_idx, locdbc_idx](AuctionEntry* auction)
        {
            // Skip expired auctions
            if (auction->ExpireTime < curTime)
                return;

            Item* item = sAuctionMgr->GetAuctionItem(auction->ItemGuid);
            if (!item)
                return;

            ItemTemplate const* proto = item->GetTemplate();
            if (listItems->ItemClass != 0xffffffff && proto->Class != listItems->ItemClass)
                return;

            if (listItems->ItemSubClass != 0xffffffff && proto->SubClass != listItems->ItemSubClass)
                return;

            if (listItems->InventoryType != 0xffffffff && proto->InventoryType != listItems->InventoryType)
            {
                // xinef: exception, robes are counted as chests
                if (listItems->InventoryType != INVTYPE_CHEST || proto->InventoryType != INVTYPE_ROBE)
                    return;
            }

            if (listItems->Quality != 0xffffffff && proto->Quality < listItems->Quality)
                return;

            if (listItems->LevelMin != 0x00 && (proto->RequiredLevel < listItems->LevelMin ||
                (listItems->LevelMax != 0x00 && proto->RequiredLevel > listItems->LevelMax)))
                return;

            if (listItems->Usable != 0x00)
            {
                if (player->CanUseItem(item) != EQUIP_ERR_OK)
                    return;

                // xinef: check already learded recipes and pets
                if (proto->Spells[1].SpellTrigger == ITEM_SPELLTRIGGER_LEARN_SPELL_ID && player->HasSpell(proto->Spells[1].SpellId))
                    return;
            }

            // Allow search by suffix (ie: of the Monkey) or partial name (ie: Monkey)
            // No need to do any of this if no search term was entered
            if (!packet.WSearchedName.empty())
            {
                std::string name = proto->Name1;
                if (name.empty())
                    return;

                // local name
                if (loc_idx > 0)
                    if (ItemLocale const* il = sObjectMgr->GetItemLocale(proto->ItemId))
                        ObjectMgr::GetLocaleString(il->Name, loc_idx, name);

                // DO NOT use GetItemEnchantMod(proto->RandomProperty) as it may return a result
                //  that matches the search, but it may not equal item->GetItemRandomPropertyId()
                //  used in BuildAuctionInfo() which then causes wrong items to be listed
                int32 propRefID = item->GetItemRandomPropertyId();

                if (propRefID)
                {
                    // Append the suffix to the name (ie: of the Monkey) if one exists
                    // These are found in ItemRandomSuffix.dbc and ItemRandomProperties.dbc
                    // even though the DBC name seems misleading
                    std::array<char const*, 16> const* suffix = nullptr;

                    if (propRefID < 0)
                    {
                        ItemRandomSuffixEntry const* itemRandEntry = sItemRandomSuffixStore.LookupEntry(-item->GetItemRandomPropertyId());
                        if (itemRandEntry)
                            suffix = &itemRandEntry->Name;
                    }
                    else
                    {
                        ItemRandomPropertiesEntry const* itemRandEntry = sItemRandomPropertiesStore.LookupEntry(item->GetItemRandomPropertyId());
                        if (itemRandEntry)
                            suffix = &itemRandEntry->Name;
                    }

                    // dbc local name
                    if (suffix)
                    {
                        // Append the suffix (ie: of the Monkey) to the name using localization
                        // or default enUS if localization is invalid
                        name += ' ';
                        name += (*suffix)[locdbc_idx >= 0 ? locdbc_idx : LOCALE_enUS];
                    }
                }

                // Perform the search (with or without suffix)
                if (!Utf8FitTo(name, packet.WSearchedName))
                    return;
            }

            packet.AuctionShortlist.emplace_back(auction);
        });
    }

    if (packet.AuctionShortlist.empty())
        return;

    // Check if sort enabled, and first sort column is valid, if not don't sort
    if (!listItems->SortOrder.empty())
    {
        AuctionSortInfo const& sortInfo = *listItems->SortOrder.begin();
        if (sortInfo.SortOrder >= AuctionSortOrder::MinLevel && sortInfo.SortOrder < AuctionSortOrder::Max && sortInfo.SortOrder != AuctionSortOrder::Unk4)
        {
            // Partial sort to improve performance a bit, but the last pages will burn
            if (listItems->ListFrom + 50 <= packet.AuctionShortlist.size())
                std::partial_sort(packet.AuctionShortlist.begin(), packet.AuctionShortlist.begin() + listItems->ListFrom + 50, packet.AuctionShortlist.end(),
                    std::bind(SortAuction, std::placeholders::_1, std::placeholders::_2, listItems->SortOrder, player, sortInfo.SortOrder == AuctionSortOrder::Bid));
            else
                std::sort(packet.AuctionShortlist.begin(), packet.AuctionShortlist.end(), std::bind(SortAuction, std::placeholders::_1, std::placeholders::_2, listItems->SortOrder,
                    player, sortInfo.SortOrder == AuctionSortOrder::Bid));
        }
    }
}

std::size_t AuctionHouseObject::GetCount()
{
    std::shared_lock guard(_mutex);
    return _auctions.size();
}

void AuctionHouseObject::ForEachAuctions(std::function<void(AuctionEntry*)> const& fn)
{
    std::shared_lock guard(_mutex);

    for (auto const& [auctionID, auction] : _auctions)
        fn(auction.get());
}

void AuctionHouseObject::ForEachAuctionsWrite(std::function<void(AuctionEntry*)> const& fn)
{
    std::unique_lock guard(_mutex);

    for (auto const& [auctionID, auction] : _auctions)
        fn(auction.get());
}

AuctionHouseMgr::~AuctionHouseMgr()
{
    ClearItems();
}

AuctionHouseMgr* AuctionHouseMgr::instance()
{
    static AuctionHouseMgr instance;
    return &instance;
}

uint32 AuctionHouseMgr::GetAuctionDeposit(AuctionHouseEntry const* entry, Minutes expireTime, Item* pItem, uint32 count)
{
    auto depositRate = sWorld->getRate(RATE_AUCTION_DEPOSIT);
    uint32 minDeposit{ uint32(float(AH_MINIMUM_DEPOSIT) * depositRate) };

    uint32 MSV = pItem->GetTemplate()->SellPrice;
    if (MSV <= 0)
        return minDeposit;

    float multiplier = CalculatePct(float(entry->depositPercent), 3);
    uint32 timeHr(expireTime.count() / 60 / 12);
    auto deposit = uint32(((multiplier * float(MSV) * float(count) / 3) * timeHr * 3) * depositRate);

    LOG_DEBUG("auctionHouse", "MSV:        {}", MSV);
    LOG_DEBUG("auctionHouse", "Items:      {}", count);
    LOG_DEBUG("auctionHouse", "Multiplier: {}", multiplier);
    LOG_DEBUG("auctionHouse", "Deposit:    {}", deposit);

    if (deposit < minDeposit)
        return minDeposit;

    return deposit;
}

Item* AuctionHouseMgr::GetAuctionItem(ObjectGuid itemGuid)
{
    return Acore::Containers::MapGetValuePtr(_items, itemGuid);
}

//does not clear ram
void AuctionHouseMgr::SendAuctionWonMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification, bool updateAchievementCriteria, bool sendMail)
{
    Item* item = GetAuctionItem(auction->ItemGuid);
    if (!item)
        return;

    uint32 bidder_accId = 0;
    Player* bidder = ObjectAccessor::FindConnectedPlayer(auction->Bidder);
    if (bidder)
        bidder_accId = bidder->GetSession()->GetAccountId();
    else
        bidder_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->Bidder);

    // receiver exist
    if (bidder || bidder_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionWonMail(this, auction, bidder, bidder_accId, sendNotification, updateAchievementCriteria, sendMail);

        // set owner to bidder (to prevent delete item with sender char deleting)
        // owner in `data` will set at mail receive and item extracting
        auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ITEM_OWNER);
        stmt->SetData(0, auction->Bidder.GetCounter());
        stmt->SetData(1, item->GetGUID().GetCounter());
        trans->Append(stmt);

        if (bidder)
        {
            if (sendNotification) // can be changed in the hook
                bidder->GetSession()->SendAuctionBidderNotification(auction->GetHouseId(), auction->Id, auction->Bidder, 0, 0, auction->ItemID);

            // FIXME: for offline player need also
            if (updateAchievementCriteria) // can be changed in the hook
                bidder->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WON_AUCTIONS, 1);
        }

        if (sendMail) // can be changed in the hook
        {
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_WON), AuctionEntry::BuildAuctionMailBody(auction->PlayerOwner, auction->Bid, auction->BuyOut))
                .AddItem(item)
                .SendMailTo(trans, MailReceiver(bidder, auction->Bidder.GetCounter()), auction, MAIL_CHECK_MASK_COPIED);
        }
    }
    else
        sAuctionMgr->RemoveAItem(auction->ItemGuid, true, trans);
}

void AuctionHouseMgr::SendAuctionSalePendingMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail)
{
    Player* owner = ObjectAccessor::FindConnectedPlayer(auction->PlayerOwner);
    uint32 owner_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->PlayerOwner);

    // owner exist (online or offline)
    if (owner || owner_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(this, auction, owner, owner_accId, sendMail);

        uint32 deliveryDelay = sWorld->getIntConfig(CONFIG_MAIL_DELIVERY_DELAY);

        ByteBuffer timePacker;
        timePacker.AppendPackedTime(GameTime::GetGameTime().count() + time_t(deliveryDelay));

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_SALE_PENDING),
                AuctionEntry::BuildAuctionMailBody(auction->Bidder, auction->Bid, auction->BuyOut, auction->Deposit, auction->GetAuctionCut(), deliveryDelay, timePacker.read<uint32>()))
            .SendMailTo(trans, MailReceiver(owner, auction->PlayerOwner.GetCounter()), auction, MAIL_CHECK_MASK_COPIED);
    }
}

// Send mail to auction owner, when auction is successful, it does not clear ram
void AuctionHouseMgr::SendAuctionSuccessfulMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification, bool updateAchievementCriteria, bool sendMail)
{
    Player* owner = ObjectAccessor::FindConnectedPlayer(auction->PlayerOwner);
    uint32 owner_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->PlayerOwner);

    // Owner exist
    if (owner || owner_accId)
    {
        uint32 profit = auction->Bid + auction->Deposit - auction->GetAuctionCut();
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(this, auction, owner, owner_accId, profit, sendNotification, updateAchievementCriteria, sendMail);

        if (owner)
        {
            if (updateAchievementCriteria) // can be changed in the hook
            {
                owner->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_EARNED_BY_AUCTIONS, profit);
                owner->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_SOLD, auction->Bid);
            }

            if (sendNotification) // can be changed in the hook
                owner->GetSession()->SendAuctionOwnerNotification(auction);
        }

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_SUCCESSFUL), AuctionEntry::BuildAuctionMailBody(auction->Bidder, auction->Bid, auction->BuyOut, auction->Deposit, auction->GetAuctionCut()))
            .AddMoney(profit)
            .SendMailTo(trans, MailReceiver(owner, auction->PlayerOwner.GetCounter()), auction, MAIL_CHECK_MASK_COPIED, sWorld->getIntConfig(CONFIG_MAIL_DELIVERY_DELAY));

        if (auction->Bid >= 500 * GOLD)
        {
            if (auto gpd = sCharacterCache->GetCharacterCacheByGuid(auction->Bidder))
            {
                Player* bidder = ObjectAccessor::FindConnectedPlayer(auction->Bidder);
                std::string owner_name;
                uint8 owner_level = 0;

                if (CharacterCacheEntry const *gpd_owner = sCharacterCache->GetCharacterCacheByGuid(auction->PlayerOwner))
                {
                    owner_name = gpd_owner->Name;
                    owner_level = gpd_owner->Level;
                }

                CharacterDatabase.Execute(
                        "INSERT INTO log_money VALUES({}, {}, \"{}\", \"{}\", {}, \"{}\", {}, \"profit: {}g, bidder: {} {} lvl (guid: {}), seller: {} {} lvl (guid: {}), item {} ({})\", NOW(), {})",
                        gpd->AccountId, auction->Bidder.GetCounter(), gpd->Name, bidder ? bidder->GetSession()->GetRemoteAddress() : "", owner_accId, owner_name, auction->Bid,
                        (profit / GOLD), gpd->Name, gpd->Level, auction->Bidder.GetCounter(), owner_name, owner_level, auction->PlayerOwner.GetCounter(), auction->ItemID,
                        auction->ItemCount, 2);
            }
        }
    }
}

// Does not clear ram
void AuctionHouseMgr::SendAuctionExpiredMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification, bool sendMail)
{
    // Return an item in auction to its owner by mail
    Item* pItem = GetAuctionItem(auction->ItemGuid);
    if (!pItem)
        return;

    Player* owner = ObjectAccessor::FindConnectedPlayer(auction->PlayerOwner);
    uint32 ownerAccId = sCharacterCache->GetCharacterAccountIdByGuid(auction->PlayerOwner);

    // owner exist
    if (owner || ownerAccId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionExpiredMail(this, auction, owner, ownerAccId, sendNotification, sendMail);

        if (owner && sendNotification) // can be changed in the hook
            owner->GetSession()->SendAuctionOwnerNotification(auction);

        if (sendMail) // can be changed in the hook
        {
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_EXPIRED), AuctionEntry::BuildAuctionMailBody(ObjectGuid::Empty, 0, auction->BuyOut, auction->Deposit))
                .AddItem(pItem)
                .SendMailTo(trans, MailReceiver(owner, auction->PlayerOwner.GetCounter()), auction, MAIL_CHECK_MASK_COPIED, 0);
        }
    }
    else
        sAuctionMgr->RemoveAItem(auction->ItemGuid, true, trans);
}

// Sends mail to old bidder
void AuctionHouseMgr::SendAuctionOutbiddedMail(AuctionEntry* auction, uint32 newPrice, Player* newBidder, CharacterDatabaseTransaction trans, bool sendNotification, bool sendMail)
{
    Player* oldBidder = ObjectAccessor::FindConnectedPlayer(auction->Bidder);

    uint32 oldBidderAccId = 0;
    if (!oldBidder)
        oldBidderAccId = sCharacterCache->GetCharacterAccountIdByGuid(auction->Bidder);

    // old bidder exist
    if (oldBidder || oldBidderAccId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(this, auction, oldBidder, oldBidderAccId, newBidder, newPrice, sendNotification, sendMail);

        if (oldBidder && newBidder && sendNotification) // can be changed in the hook
            oldBidder->GetSession()->SendAuctionBidderNotification(auction->GetHouseId(), auction->Id, newBidder->GetGUID(), newPrice, auction->GetAuctionOutBid(), auction->ItemID);

        if (sendMail) // can be changed in the hook
        {
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_OUTBIDDED),
                AuctionEntry::BuildAuctionMailBody(auction->PlayerOwner, auction->Bid, auction->BuyOut, auction->Deposit, auction->GetAuctionCut()))
                .AddMoney(auction->Bid)
                .SendMailTo(trans, MailReceiver(oldBidder, auction->Bidder.GetCounter()), auction, MAIL_CHECK_MASK_COPIED);
        }
    }
}

// Sends mail, when auction is cancelled to old bidder
void AuctionHouseMgr::SendAuctionCancelledToBidderMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail)
{
    uint32 bidderAccId{};
    Player* bidder = ObjectAccessor::FindConnectedPlayer(auction->Bidder);
    if (!bidder)
        bidderAccId = sCharacterCache->GetCharacterAccountIdByGuid(auction->Bidder);

    // bidder exist
    if (bidder || bidderAccId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(this, auction, bidder, bidderAccId, sendMail);
        if (sendMail) // can be changed in the hook
        {
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_CANCELLED_TO_BIDDER),
                AuctionEntry::BuildAuctionMailBody(auction->PlayerOwner, auction->Bid, auction->BuyOut, auction->Deposit))
                .AddMoney(auction->Bid)
                .SendMailTo(trans, MailReceiver(bidder, auction->Bidder.GetCounter()), auction, MAIL_CHECK_MASK_COPIED);
        }
    }
}

void AuctionHouseMgr::LoadAuctionItems()
{
    StopWatch sw;

    // need to clear in case we are reloading
    ClearItems();

    // data needs to be at first place for Item::LoadFromDB
    auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_AUCTION_ITEMS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 auction items. DB table `auctionhouse` or `item_instance` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    for (auto const& fields : *result)
    {
        ObjectGuid::LowType itemGuid = fields[11].Get<uint32>();
        uint32 itemID = fields[12].Get<uint32>();

        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemID);
        if (!proto)
        {
            LOG_ERROR("auctionHouse", "AuctionHouseMgr::LoadAuctionItems: Unknown item (GUID: {} id: #{}) in auction, skipped.", itemGuid, itemID);
            continue;
        }

        Item* item = NewItemOrBag(proto);
        if (!item->LoadFromDB(itemGuid, ObjectGuid::Empty, fields.Fetch(), itemID))
        {
            delete item;
            continue;
        }

        AddAuctionItem(item);
    }

    LOG_INFO("server.loading", ">> Loaded {} auction items in {}", _items.size(), sw);
    LOG_INFO("server.loading", "");
}

void AuctionHouseMgr::LoadAuctions()
{
    StopWatch sw;
    auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_AUCTIONS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 auctions. DB table `auctionhouse` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count{};
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    for (auto const& fields : *result)
    {
        auto auction{ std::make_unique<AuctionEntry>() };
        if (!auction->LoadFromDB(fields.Fetch()))
        {
            auction->DeleteFromDB(trans);
            continue;
        }

        GetAuctionsMapByHouseId(auction->GetHouseId())->AddAuction(std::move(auction));
        count++;
    }

    CharacterDatabase.CommitTransaction(trans);

    LOG_INFO("server.loading", ">> Loaded {} auctions in {}", count, sw);
    LOG_INFO("server.loading", "");
}

void AuctionHouseMgr::AddAuctionItem(Item* item)
{
    std::unique_lock guard(_mutex);
    auto itemGuid{ item->GetGUID() };

    ASSERT(item);
    ASSERT(!_items.contains(itemGuid));

    _items.emplace(itemGuid, item);
}

bool AuctionHouseMgr::RemoveAItem(ObjectGuid itemGuid, bool deleteFromDB, CharacterDatabaseTransaction trans /*= nullptr*/)
{
    std::unique_lock guard(_mutex);
    auto const& itr = _items.find(itemGuid);
    if (itr == _items.end())
        return false;

    if (deleteFromDB)
    {
        ASSERT(trans);
        itr->second->FSetState(ITEM_REMOVED);
        itr->second->SaveToDB(trans);
    }

    _items.erase(itemGuid);
    return true;
}

void AuctionHouseMgr::Update()
{
    sScriptMgr->OnBeforeAuctionHouseMgrUpdate();
    _hordeAuctions.Update();
    _allianceAuctions.Update();
    _neutralAuctions.Update();
}

AuctionHouseEntry const* AuctionHouseMgr::GetAuctionHouseEntry(uint32 factionTemplateId)
{
    uint32 houseid = AUCTIONHOUSE_NEUTRAL; // goblin auction house

    if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
    {
        //FIXME: found way for proper auctionhouse selection by another way
        // AuctionHouse.dbc have faction field with _player_ factions associated with auction house races.
        // but no easy way convert creature faction to player race faction for specific city
        FactionTemplateEntry const* u_entry = sFactionTemplateStore.LookupEntry(factionTemplateId);
        if (!u_entry)
            houseid = AUCTIONHOUSE_NEUTRAL; // goblin auction house
        else if (u_entry->ourMask & FACTION_MASK_ALLIANCE)
            houseid = AUCTIONHOUSE_ALLIANCE; // human auction house
        else if (u_entry->ourMask & FACTION_MASK_HORDE)
            houseid = AUCTIONHOUSE_HORDE; // orc auction house
        else
            houseid = AUCTIONHOUSE_NEUTRAL; // goblin auction house
    }

    return sAuctionHouseStore.LookupEntry(houseid);
}

AuctionHouseEntry const* AuctionHouseMgr::GetAuctionHouseEntryFromHouse(uint8 houseId)
{
    return (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION)) ? sAuctionHouseStore.LookupEntry(AUCTIONHOUSE_NEUTRAL) : sAuctionHouseStore.LookupEntry(houseId);
}

void AuctionHouseMgr::ClearItems()
{
    for (auto& [itemGuid, item] : _items)
        delete item;
}

// Inserts to WorldPacket auction's data
bool AuctionEntry::BuildAuctionInfo(WorldPacket& data) const
{
    Item* item = sAuctionMgr->GetAuctionItem(ItemGuid);
    if (!item)
    {
        LOG_ERROR("auctionHouse", "AuctionEntry::BuildAuctionInfo: Auction {} has a non-existent item: {}", Id, ItemGuid.ToString());
        return false;
    }

    data << uint32(Id);
    data << uint32(item->GetEntry());

    for (uint8 i = 0; i < MAX_INSPECTED_ENCHANTMENT_SLOT; ++i)
    {
        data << uint32(item->GetEnchantmentId(EnchantmentSlot(i)));
        data << uint32(item->GetEnchantmentDuration(EnchantmentSlot(i)));
        data << uint32(item->GetEnchantmentCharges(EnchantmentSlot(i)));
    }

    data << int32(item->GetItemRandomPropertyId());                 // Random item property id
    data << uint32(item->GetItemSuffixFactor());                    // SuffixFactor
    data << uint32(item->GetCount());                               // item->count
    data << uint32(item->GetSpellCharges());                        // item->charge FFFFFFF
    data << uint32(0);                                              // Unknown
    data << PlayerOwner;                                            // Auction->owner
    data << uint32(StartBid);                                       // Auction->startbid (not sure if useful)
    data << uint32(Bid ? GetAuctionOutBid() : 0);

    // Minimal outbid
    data << uint32(BuyOut);                                         // Auction->buyout
    data << uint32(GetExpiredTime().count());// time left
    data << Bidder;                                                 // auction->bidder current
    data << uint32(Bid);                                            // current bid
    return true;
}

uint32 AuctionEntry::GetAuctionCut() const
{
    int32 cut = int32(CalculatePct(Bid, auctionHouseEntry->cutPercent) * sWorld->getRate(RATE_AUCTION_CUT));
    return std::max(cut, 0);
}

/// the sum of outbid is (1% from current bid)*5, if bid is very small, it is 1c
uint32 AuctionEntry::GetAuctionOutBid() const
{
    uint32 outbid = CalculatePct(Bid, 5);
    return outbid ? outbid : 1;
}

Milliseconds AuctionEntry::GetExpiredTime() const
{
    return ExpireTime - GameTime::GetGameTime();
}

void AuctionEntry::DeleteFromDB(CharacterDatabaseTransaction trans) const
{
    auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_AUCTION);
    stmt->SetData(0, Id);
    trans->Append(stmt);
}

void AuctionEntry::SaveToDB(CharacterDatabaseTransaction trans) const
{
    auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_AUCTION);
    stmt->SetData(0, Id);
    stmt->SetData(1, HouseId);
    stmt->SetData(2, ItemGuid.GetCounter());
    stmt->SetData(3, PlayerOwner.GetCounter());
    stmt->SetData(4, BuyOut);
    stmt->SetData(5, ExpireTime);
    stmt->SetData(6, Bidder.GetCounter());
    stmt->SetData(7, Bid);
    stmt->SetData(8, StartBid);
    stmt->SetData(9, Deposit);
    trans->Append(stmt);
}

bool AuctionEntry::LoadFromDB(Field* fields)
{
    Id = fields[0].Get<uint32>();
    HouseId = fields[1].Get<uint8>();
    ItemGuid = ObjectGuid::Create<HighGuid::Item>(fields[2].Get<uint32>());
    ItemID = fields[3].Get<uint32>();
    ItemCount = fields[4].Get<uint32>();
    PlayerOwner = ObjectGuid::Create<HighGuid::Player>(fields[5].Get<uint32>());
    BuyOut = fields[6].Get<uint32>();
    ExpireTime = fields[7].Get<Seconds>();
    Bidder = ObjectGuid::Create<HighGuid::Player>(fields[8].Get<uint32>());
    Bid = fields[9].Get<uint32>();
    StartBid = fields[10].Get<uint32>();
    Deposit = fields[11].Get<uint32>();

    auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntryFromHouse(HouseId);
    if (!auctionHouseEntry)
    {
        LOG_ERROR("auctionHouse", "Auction {} has invalid house id {}", Id, HouseId);
        return false;
    }

    // check if sold item exists for guid
    // and item_template in fact (GetAItem will fail if problematic in result check in AuctionHouseMgr::LoadAuctionItems)
    if (!sAuctionMgr->GetAuctionItem(ItemGuid))
    {
        LOG_ERROR("auctionHouse", "Auction {} has not a existing item : {}", Id, ItemGuid.ToString());
        return false;
    }

    return true;
}

std::string AuctionEntry::BuildAuctionMailSubject(MailAuctionAnswers response) const
{
    std::ostringstream strm;
    strm << ItemID << ":0:" << response << ':' << Id << ':' << ItemCount;
    return strm.str();
}

std::string AuctionEntry::BuildAuctionMailBody(ObjectGuid guid, uint32 bid, uint32 buyout, uint32 deposit /*= 0*/, uint32 cut /*= 0*/, uint32 moneyDelay /*= 0*/, uint32 eta /*= 0*/)
{
    std::ostringstream strm;
    strm.width(16);
    strm << std::right << std::hex << guid.GetRawValue();
    strm << std::dec << ':' << bid << ':' << buyout;
    strm << ':' << deposit << ':' << cut;
    strm << ':' << moneyDelay << ':' << eta;
    return strm.str();
}
