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

#include "AuctionHousePackets.h"
#include "Creature.h"
#include "WorldSession.h"
#include "Player.h"
#include "GameTime.h"

// Proof of concept, we should shift the info we're obtaining in here into AuctionEntry probably
static bool SortAuction(AuctionEntry* left, AuctionEntry* right, AuctionSortOrderVector& sortOrder, Player* player, bool checkMinBidBuyout)
{
    for (auto const& thisOrder : sortOrder)
    {
        switch (thisOrder.sortOrder)
        {
            case AUCTION_SORT_BID:
            {
                if (left->bid == right->bid)
                {
                    if (checkMinBidBuyout)
                    {
                        if (left->buyout == right->buyout)
                        {
                            if (left->startbid == right->startbid)
                            {
                                continue;
                            }

                            return thisOrder.isDesc ? left->startbid > right->startbid : left->startbid < right->startbid;
                        }

                        return thisOrder.isDesc ? left->buyout > right->buyout : left->buyout < right->buyout;
                    }

                    continue;
                }

                return thisOrder.isDesc ? left->bid > right->bid : left->bid < right->bid;
            }
            case AUCTION_SORT_BUYOUT:
            case AUCTION_SORT_BUYOUT_2:
            {
                if (left->buyout == right->buyout)
                {
                    continue;
                }

                return thisOrder.isDesc ? left->buyout > right->buyout : left->buyout < right->buyout;
            }
            case AUCTION_SORT_ITEM:
            {
                ItemTemplate const* protoLeft = sObjectMgr->GetItemTemplate(left->item_template);
                ItemTemplate const* protoRight = sObjectMgr->GetItemTemplate(right->item_template);
                if (!protoLeft || !protoRight)
                {
                    continue;
                }

                std::string leftName = protoLeft->Name1;
                std::string rightName = protoRight->Name1;
                if (leftName.empty() || rightName.empty())
                {
                    continue;
                }

                LocaleConstant locale = LOCALE_enUS;
                if (player && player->GetSession())
                {
                    locale = player->GetSession()->GetSessionDbLocaleIndex();
                }

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
                if (result == 0)
                {
                    continue;
                }

                return thisOrder.isDesc ? result > 0 : result < 0;
            }
            case AUCTION_SORT_MINLEVEL:
            {
                ItemTemplate const* protoLeft = sObjectMgr->GetItemTemplate(left->item_template);
                ItemTemplate const* protoRight = sObjectMgr->GetItemTemplate(right->item_template);
                if (!protoLeft || !protoRight)
                {
                    continue;
                }

                if (protoLeft->RequiredLevel == protoRight->RequiredLevel)
                {
                    continue;
                }

                return thisOrder.isDesc ? protoLeft->RequiredLevel > protoRight->RequiredLevel : protoLeft->RequiredLevel < protoRight->RequiredLevel;
            }
            case AUCTION_SORT_OWNER:
            {
                std::string leftName;
                sCharacterCache->GetCharacterNameByGuid(left->owner, leftName);

                std::string rightName;
                sCharacterCache->GetCharacterNameByGuid(right->owner, rightName);

                int result = leftName.compare(rightName);
                if (result == 0)
                {
                    continue;
                }

                return thisOrder.isDesc ? result > 0 : result < 0;
            }
            case AUCTION_SORT_RARITY:
            {
                ItemTemplate const* protoLeft = sObjectMgr->GetItemTemplate(left->item_template);
                ItemTemplate const* protoRight = sObjectMgr->GetItemTemplate(right->item_template);
                if (!protoLeft || !protoRight)
                {
                    continue;
                }

                if (protoLeft->Quality == protoRight->Quality)
                {
                    continue;
                }

                return thisOrder.isDesc ? protoLeft->Quality > protoRight->Quality : protoLeft->Quality < protoRight->Quality;
            }
            case AUCTION_SORT_STACK:
            {
                if (left->itemCount == right->itemCount)
                {
                    continue;
                }

                if (!thisOrder.isDesc)
                {
                    return (left->itemCount < right->itemCount);
                }

                return (left->itemCount > right->itemCount);
            }
            case AUCTION_SORT_TIMELEFT:
            {
                if (left->expire_time == right->expire_time)
                {
                    continue;
                }

                return thisOrder.isDesc ? left->expire_time > right->expire_time : left->expire_time < right->expire_time;
            }
            case AUCTION_SORT_MINBIDBUY:
            {
                if (left->buyout == right->buyout)
                {
                    if (left->startbid == right->startbid)
                    {
                        continue;
                    }

                    return thisOrder.isDesc ? left->startbid > right->startbid : left->startbid < right->startbid;
                }

                return thisOrder.isDesc ? left->buyout > right->buyout : left->buyout < right->buyout;
            }
            case AUCTION_SORT_MAX:
                // Such sad travis appeasement
            case AUCTION_SORT_UNK4:
            default:
                break;
        }
    }

    return false;
}

bool WorldPackets::AuctionHouse::BuildAuctionInfo(WorldPacket& packet, AuctionEntry const* auctionEntry)
{
    Item* item = sAuctionMgr->GetAItem(auctionEntry->item_guid);
    if (!item)
    {
        LOG_ERROR("auctionHouse", "AuctionEntry::BuildAuctionInfo: Auction {} has a non-existent item: {}", auctionEntry->Id, auctionEntry->item_guid.ToString());
        return false;
    }

    packet << uint32(auctionEntry->Id);
    packet << uint32(item->GetEntry());

    for (uint8 i = 0; i < MAX_INSPECTED_ENCHANTMENT_SLOT; ++i)
    {
        packet << uint32(item->GetEnchantmentId(EnchantmentSlot(i)));
        packet << uint32(item->GetEnchantmentDuration(EnchantmentSlot(i)));
        packet << uint32(item->GetEnchantmentCharges(EnchantmentSlot(i)));
    }

    packet << int32(item->GetItemRandomPropertyId());                 // Random item property id
    packet << uint32(item->GetItemSuffixFactor());                    // SuffixFactor
    packet << uint32(item->GetCount());                               // item->count
    packet << uint32(item->GetSpellCharges());                        // item->charge FFFFFFF
    packet << uint32(0);                                              // Unknown
    packet << auctionEntry->owner;                                    // Auction->owner
    packet << uint32(auctionEntry->startbid);                         // Auction->startbid (not sure if useful)
    packet << uint32(auctionEntry->bid ? auctionEntry->GetAuctionOutBid() : 0);

    // Minimal outbid
    packet << uint32(auctionEntry->buyout);                            // Auction->buyout
    packet << uint32((auctionEntry->expire_time - GameTime::GetGameTime().count()) * IN_MILLISECONDS); // time left
    packet << auctionEntry->bidder;                                    // auction->bidder current
    packet << uint32(auctionEntry->bid);                               // current bid

    return true;
}

void WorldPackets::AuctionHouse::HelloFromClient::Read()
{
    _worldPacket >> CreatureGuid;
}

WorldPacket const* WorldPackets::AuctionHouse::HelloToClient::Write()
{
    _worldPacket << CreatureGuid;
    _worldPacket << uint32(HouseID);
    _worldPacket << uint8(IsAHEnable);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::AuctionHouse::BidderNotification::Write()
{
    _worldPacket << uint32(Location);
    _worldPacket << uint32(AuctionID);
    _worldPacket << Bidder;
    _worldPacket << uint32(BidSum);
    _worldPacket << uint32(Diff);
    _worldPacket << uint32(ItemEntry);
    _worldPacket << uint32(Unk7);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::AuctionHouse::OwnerNotification::Write()
{
    _worldPacket << uint32(ID);
    _worldPacket << uint32(Bid);
    _worldPacket << uint32(Unk3);
    _worldPacket << uint64(Unk4); // (bidder guid?)
    _worldPacket << uint32(ItemEntry);
    _worldPacket << uint32(Unk6);
    _worldPacket << float(Unk7); // (time?)

    return &_worldPacket;
}

WorldPacket const* WorldPackets::AuctionHouse::CommandResult::Write()
{
    _worldPacket << uint32(AuctionID);
    _worldPacket << uint32(Action);
    _worldPacket << uint32(ErrorCode);

    if (!ErrorCode && Action)
    {
        // When bid, then send 0, once...
        _worldPacket << uint32(BidError);
    }

    return &_worldPacket;
}

void WorldPackets::AuctionHouse::SellItem::Read()
{
    Items.fill(std::make_pair(ObjectGuid::Empty, 0));

    _worldPacket >> Auctioneer;
    _worldPacket >> ItemsCount;

    for (uint32 i = 0; i < ItemsCount; ++i)
    {
        _worldPacket >> Items[i].first;
        _worldPacket >> Items[i].second;
    }

    _worldPacket >> Bid;
    _worldPacket >> Buyout;
    _worldPacket >> ElapsedTime;
}

void WorldPackets::AuctionHouse::PlaceBid::Read()
{
    _worldPacket >> Auctioneer;
    _worldPacket >> AuctionID;
    _worldPacket >> Price;
}

void WorldPackets::AuctionHouse::RemoveItem::Read()
{
    _worldPacket >> Auctioneer;
    _worldPacket >> AuctionID;
}

void WorldPackets::AuctionHouse::ListBidderItems::Read()
{
    _worldPacket >> Auctioneer;
    _worldPacket >> ListFrom;
    _worldPacket >> OutbiddedCount;

    if (GetSize() != (16 + OutbiddedCount * 4))
    {
        LOG_ERROR("network.packet", "Client sent bad opcode!!! with count: {} and size : {} (must be: {})", OutbiddedCount, GetSize(), (16 + OutbiddedCount * 4));
        OutbiddedCount = 0;
    }

    while (OutbiddedCount > 0) // add all data, which client requires
    {
        uint32 outbiddedAuctionId;
        _worldPacket >> outbiddedAuctionId;
        OutbiddedAuctionIds.emplace_back(outbiddedAuctionId);
        OutbiddedCount--;
    }
}

WorldPackets::AuctionHouse::BidderListResult::BidderListResult(AuctionHouseObject* auctionHouse)
    : ServerPacket(SMSG_AUCTION_BIDDER_LIST_RESULT, (4 + 4 + 4) + 30000)
{
    _auctionHouse = ASSERT_NOTNULL(auctionHouse);
}

WorldPacket const* WorldPackets::AuctionHouse::BidderListResult::Write()
{
    ASSERT(_auctionHouse, "> Build packet without check exist auction house!");
    ASSERT(!PlayerGuid.IsEmpty(), "> Build packet with null player guid!");

    _worldPacket << uint32(Unk1);

    uint32 count = 0;
    uint32 totalcount = 0;

    for (auto const& outbiddedAuctionId : OutbiddedAuctionIds)
    {
        AuctionEntry* auction = _auctionHouse->GetAuction(outbiddedAuctionId);
        if (auction && BuildAuctionInfo(_worldPacket, auction))
        {
            ++totalcount;
            ++count;
        }
    }

    for (auto const& [__, auction] : _auctionHouse->GetAuctions())
    {
        if (auction && auction->bidder == PlayerGuid)
        {
            if (BuildAuctionInfo(_worldPacket, auction))
            {
                ++count;
            }

            ++totalcount;
        }
    }

    _worldPacket.put<uint32>(0, count);
    _worldPacket << uint32(totalcount);
    _worldPacket << uint32(SearchDelay); // clientside search cooldown [ms] (gray search button)

    return &_worldPacket;
}

void WorldPackets::AuctionHouse::ListOwnerItems::Read()
{
    _worldPacket >> Auctioneer;
    _worldPacket >> ListFrom;
}

WorldPacket const* WorldPackets::AuctionHouse::ListOwnerResult::Write()
{
    ASSERT(auctionHouse, "> Build packet without check exist auction house!");

    _worldPacket << uint32(Unk1);

    uint32 count{ 0 };
    uint32 totalCount{ 0 };

    for (auto const& [__, auction] : auctionHouse->GetAuctions())
    {
        if (auction && auction->owner == PlayerGuid)
        {
            if (BuildAuctionInfo(_worldPacket, auction))
            {
                count++;
            }

            totalCount++;
        }
    }

    _worldPacket.put<uint32>(0, count);
    _worldPacket << uint32(totalCount);
    _worldPacket << uint32(SearchDelay);

    return &_worldPacket;
}

void WorldPackets::AuctionHouse::ListItems::Read()
{
    _worldPacket >> CreatureGuid;
    _worldPacket >> ListFrom;
    _worldPacket >> SearchedName;
    _worldPacket >> LevelMin;
    _worldPacket >> LevelMax;
    _worldPacket >> AuctionSlotID;
    _worldPacket >> AuctionMainCategory;
    _worldPacket >> AuctionSubCategory;
    _worldPacket >> Quality >> Usable;
    _worldPacket >> GetAll;
    _worldPacket >> SortOrderCount;

    for (uint8 i = 0; i < SortOrderCount; i++)
    {
        uint8 sortMode{ 0 };
        uint8 isDesc{ 0 };
        _worldPacket >> sortMode;
        _worldPacket >> isDesc;

        AuctionSortInfo sortInfo;
        sortInfo.isDesc = (isDesc == 1);
        sortInfo.sortOrder = static_cast<AuctionSortOrder>(sortMode);
        SortOrder.emplace_back(std::move(sortInfo));
    }
}

bool WorldPackets::AuctionHouse::ListResult::IsCorrectSearchedName(ListItems const& packetListItems)
{
    // converting string that we try to find to lower case
    return Utf8toWStr(packetListItems.SearchedName, WSearchedName);
}

bool WorldPackets::AuctionHouse::ListResult::IsExistResult(ListItems const& packetListItems)
{
    if (!IsCorrectSearchedName(packetListItems))
    {
        return false;
    }

    ASSERT(player);
    ASSERT(auctionHouse);

    wstrToLower(WSearchedName);

    // pussywizard: optimization, this is a simplified case
    if (packetListItems.AuctionMainCategory == 0xffffffff &&
        packetListItems.AuctionSubCategory == 0xffffffff &&
        packetListItems.AuctionSlotID == 0xffffffff &&
        packetListItems.Quality == 0xffffffff &&
        packetListItems.LevelMin == 0x00 &&
        packetListItems.LevelMax == 0x00 &&
        packetListItems.Usable == 0x00 &&
        WSearchedName.empty())
    {
        for (auto const& [__, auction] : auctionHouse->GetAuctions())
        {
            AuctionShortlist.emplace_back(auction);
        }
    }
    else
    {
        auto curTime = GameTime::GetGameTime();

        int loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
        int locdbc_idx = player->GetSession()->GetSessionDbcLocale();

        for (auto const& [__, auction] : auctionHouse->GetAuctions())
        {
            // Skip expired auctions
            if (auction->expire_time < curTime.count())
            {
                continue;
            }

            Item* item = sAuctionMgr->GetAItem(auction->item_guid);
            if (!item)
            {
                continue;
            }

            ItemTemplate const* proto = item->GetTemplate();
            if (packetListItems.AuctionMainCategory != 0xffffffff && proto->Class != packetListItems.AuctionMainCategory)
            {
                continue;
            }

            if (packetListItems.AuctionSubCategory != 0xffffffff && proto->SubClass != packetListItems.AuctionSubCategory)
            {
                continue;
            }

            if (packetListItems.AuctionSlotID != 0xffffffff && proto->InventoryType != packetListItems.AuctionSlotID)
            {
                // xinef: exception, robes are counted as chests
                if (packetListItems.AuctionSlotID != INVTYPE_CHEST || proto->InventoryType != INVTYPE_ROBE)
                {
                    continue;
                }
            }

            if (packetListItems.Quality != 0xffffffff && proto->Quality < packetListItems.Quality)
            {
                continue;
            }

            if (packetListItems.LevelMin != 0x00 && (proto->RequiredLevel < packetListItems.LevelMin || (packetListItems.LevelMax != 0x00 && proto->RequiredLevel > packetListItems.LevelMax)))
            {
                continue;
            }

            if (packetListItems.Usable != 0x00)
            {
                if (player->CanUseItem(item) != EQUIP_ERR_OK)
                {
                    continue;
                }

                // xinef: check already learded recipes and pets
                if (proto->Spells[1].SpellTrigger == ITEM_SPELLTRIGGER_LEARN_SPELL_ID && player->HasSpell(proto->Spells[1].SpellId))
                {
                    continue;
                }
            }

            // Allow search by suffix (ie: of the Monkey) or partial name (ie: Monkey)
            // No need to do any of this if no search term was entered
            if (!WSearchedName.empty())
            {
                std::string name = proto->Name1;
                if (name.empty())
                {
                    continue;
                }

                // local name
                if (loc_idx >= 0)
                {
                    if (ItemLocale const* il = sObjectMgr->GetItemLocale(proto->ItemId))
                    {
                        ObjectMgr::GetLocaleString(il->Name, loc_idx, name);
                    }
                }

                // DO NOT use GetItemEnchantMod(proto->RandomProperty) as it may return a result
                //  that matches the search but it may not equal item->GetItemRandomPropertyId()
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
                if (!Utf8FitTo(name, WSearchedName))
                {
                    continue;
                }
            }

            AuctionShortlist.emplace_back(auction);
        }
    }

    // Check if sort enabled, and first sort column is valid, if not don't sort
    if (!packetListItems.SortOrder.empty())
    {
        AuctionSortInfo const& sortInfo = *packetListItems.SortOrder.begin();
        if (sortInfo.sortOrder >= AUCTION_SORT_MINLEVEL && sortInfo.sortOrder < AUCTION_SORT_MAX && sortInfo.sortOrder != AUCTION_SORT_UNK4)
        {
            // Partial sort to improve performance a bit, but the last pages will burn
            if (static_cast<unsigned long long>(packetListItems.ListFrom) + 50 <= AuctionShortlist.size())
            {
                std::partial_sort(AuctionShortlist.begin(), AuctionShortlist.begin() + packetListItems.ListFrom + 50, AuctionShortlist.end(),
                    std::bind(SortAuction, std::placeholders::_1, std::placeholders::_2, packetListItems.SortOrder, player, sortInfo.sortOrder == AUCTION_SORT_BID));
            }
            else
            {
                std::sort(AuctionShortlist.begin(), AuctionShortlist.end(),
                    std::bind(SortAuction, std::placeholders::_1, std::placeholders::_2, packetListItems.SortOrder, player, sortInfo.sortOrder == AUCTION_SORT_BID));
            }
        }
    }

    return true;
}

WorldPacket const* WorldPackets::AuctionHouse::ListResult::Write()
{
    //ASSERT(!AuctionShortlist.empty(), "> Build packet without check exist result!");

    _worldPacket << uint32(Unk1);

    uint32 count{ 0 };
    uint32 totalCount{ 0 };

    for (auto const& auction : AuctionShortlist)
    {
        // Add the item if no search term or if entered search term was found
        if (count < 50 && totalCount >= ListFrom)
        {
            Item* item = sAuctionMgr->GetAItem(auction->item_guid);
            if (!item)
            {
                continue;
            }

            count++;
            BuildAuctionInfo(_worldPacket, auction);
        }

        totalCount++;
    }

    _worldPacket.put<uint32>(0, count);
    _worldPacket << uint32(totalCount);
    _worldPacket << uint32(SearchDelay); // clientside search cooldown [ms] (gray search button)

    return &_worldPacket;
}

void WorldPackets::AuctionHouse::ListPendingSales::Read()
{
    _worldPacket >> Unk1;
}

WorldPacket const* WorldPackets::AuctionHouse::ListPendingSalesServer::Write()
{
    _worldPacket << uint32(Unk1);  // count

    /*for (uint32 i = 0; i < count; ++i)
    {
        data << "";                                         // string
        data << "";                                         // string
        data << uint32(0);
        data << uint32(0);
        data << float(0);
    }*/

    return &_worldPacket;
}
