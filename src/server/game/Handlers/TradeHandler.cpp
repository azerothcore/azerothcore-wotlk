/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SocialMgr.h"
#include "Spell.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::SendTradeStatus(TradeStatus status)
{
    WorldPacket data;

    switch (status)
    {
        case TRADE_STATUS_BEGIN_TRADE:
            data.Initialize(SMSG_TRADE_STATUS, 4 + 8);
            data << uint32(status);
            data << uint64(0);
            break;
        case TRADE_STATUS_OPEN_WINDOW:
            data.Initialize(SMSG_TRADE_STATUS, 4 + 4);
            data << uint32(status);
            data << uint32(0);                              // added in 2.4.0
            break;
        case TRADE_STATUS_CLOSE_WINDOW:
            data.Initialize(SMSG_TRADE_STATUS, 4 + 4 + 1 + 4);
            data << uint32(status);
            data << uint32(0);
            data << uint8(0);
            data << uint32(0);
            break;
        case TRADE_STATUS_ONLY_CONJURED:
        case TRADE_STATUS_NOT_ELIGIBLE:
            data.Initialize(SMSG_TRADE_STATUS, 4 + 1);
            data << uint32(status);
            data << uint8(0);
            break;
        default:
            data.Initialize(SMSG_TRADE_STATUS, 4);
            data << uint32(status);
            break;
    }

    SendPacket(&data);
}

void WorldSession::HandleIgnoreTradeOpcode(WorldPacket& /*recvPacket*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Ignore Trade %s", _player->GetGUID().ToString().c_str());
#endif
    // recvPacket.print_storage();
}

void WorldSession::HandleBusyTradeOpcode(WorldPacket& /*recvPacket*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Busy Trade %s", _player->GetGUID().ToString().c_str());
#endif
    // recvPacket.print_storage();
}

void WorldSession::SendUpdateTrade(bool trader_data /*= true*/)
{
    TradeData* view_trade = trader_data ? _player->GetTradeData()->GetTraderData() : _player->GetTradeData();

    WorldPacket data(SMSG_TRADE_STATUS_EXTENDED, 1 + 4 + 4 + 4 + 4 + 4 + 7 * (1 + 4 + 4 + 4 + 4 + 8 + 4 + 4 + 4 + 4 + 8 + 4 + 4 + 4 + 4 + 4 + 4));
    data << uint8(trader_data);                             // 1 means traders data, 0 means own
    data << uint32(0);                                      // added in 2.4.0, this value must be equal to value from TRADE_STATUS_OPEN_WINDOW status packet (different value for different players to block multiple trades?)
    data << uint32(TRADE_SLOT_COUNT);                       // trade slots count/number?, = next field in most cases
    data << uint32(TRADE_SLOT_COUNT);                       // trade slots count/number?, = prev field in most cases
    data << uint32(view_trade->GetMoney());                 // trader gold
    data << uint32(view_trade->GetSpell());                 // spell casted on lowest slot item

    for (uint8 i = 0; i < TRADE_SLOT_COUNT; ++i)
    {
        data << uint8(i);                                  // trade slot number, if not specified, then end of packet

        if (Item* item = view_trade->GetItem(TradeSlots(i)))
        {
            data << uint32(item->GetTemplate()->ItemId);       // entry
            data << uint32(item->GetTemplate()->DisplayInfoID);// display id
            data << uint32(item->GetCount());               // stack count
            // wrapped: hide stats but show giftcreator name
            data << uint32(item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_WRAPPED) ? 1 : 0);
            data << item->GetGuidValue(ITEM_FIELD_GIFTCREATOR);
            // perm. enchantment and gems
            data << uint32(item->GetEnchantmentId(PERM_ENCHANTMENT_SLOT));
            for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT + MAX_GEM_SOCKETS; ++enchant_slot)
                data << uint32(item->GetEnchantmentId(EnchantmentSlot(enchant_slot)));
            // creator
            data << item->GetGuidValue(ITEM_FIELD_CREATOR);
            data << uint32(item->GetSpellCharges());        // charges
            data << uint32(item->GetItemSuffixFactor());    // SuffixFactor
            data << int32(item->GetItemRandomPropertyId()); // random properties id
            data << uint32(item->GetTemplate()->LockID);       // lock id
            // max durability
            data << uint32(item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY));
            // durability
            data << uint32(item->GetUInt32Value(ITEM_FIELD_DURABILITY));
        }
        else
        {
            for (uint8 j = 0; j < 18; ++j)
                data << uint32(0);
        }
    }
    SendPacket(&data);
}

//==============================================================
// transfer the items to the players

void WorldSession::moveItems(Item* myItems[], Item* hisItems[])
{
    Player* trader = _player->GetTrader();
    if (!trader)
        return;

    for (uint8 i = 0; i < TRADE_SLOT_TRADED_COUNT; ++i)
    {
        ItemPosCountVec traderDst;
        ItemPosCountVec playerDst;
        bool traderCanTrade = (myItems[i] == nullptr || trader->CanStoreItem(NULL_BAG, NULL_SLOT, traderDst, myItems[i], false) == EQUIP_ERR_OK);
        bool playerCanTrade = (hisItems[i] == nullptr || _player->CanStoreItem(NULL_BAG, NULL_SLOT, playerDst, hisItems[i], false) == EQUIP_ERR_OK);
        if (traderCanTrade && playerCanTrade)
        {
            // Ok, if trade item exists and can be stored
            // If we trade in both directions we had to check, if the trade will work before we actually do it
            // A roll back is not possible after we stored it
            if (myItems[i])
            {
                // logging
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("network", "partner storing: %s", myItems[i]->GetGUID().ToString().c_str());
#endif

                // adjust time (depends on /played)
                if (myItems[i]->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_BOP_TRADEABLE))
                    myItems[i]->SetUInt32Value(ITEM_FIELD_CREATE_PLAYED_TIME, trader->GetTotalPlayedTime() - (_player->GetTotalPlayedTime() - myItems[i]->GetUInt32Value(ITEM_FIELD_CREATE_PLAYED_TIME)));
                // store
                trader->MoveItemToInventory(traderDst, myItems[i], true, true);
            }
            if (hisItems[i])
            {
                // logging
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("network", "player storing: %s", hisItems[i]->GetGUID().ToString().c_str());
#endif

                // adjust time (depends on /played)
                if (hisItems[i]->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_BOP_TRADEABLE))
                    hisItems[i]->SetUInt32Value(ITEM_FIELD_CREATE_PLAYED_TIME, _player->GetTotalPlayedTime() - (trader->GetTotalPlayedTime() - hisItems[i]->GetUInt32Value(ITEM_FIELD_CREATE_PLAYED_TIME)));
                // store
                _player->MoveItemToInventory(playerDst, hisItems[i], true, true);
            }
        }
        else
        {
            // in case of fatal error log error message
            // return the already removed items to the original owner
            if (myItems[i])
            {
                if (!traderCanTrade)
                    LOG_ERROR("server", "trader can't store item: %s", myItems[i]->GetGUID().ToString().c_str());
                if (_player->CanStoreItem(NULL_BAG, NULL_SLOT, playerDst, myItems[i], false) == EQUIP_ERR_OK)
                    _player->MoveItemToInventory(playerDst, myItems[i], true, true);
                else
                    LOG_ERROR("server", "player can't take item back: %s", myItems[i]->GetGUID().ToString().c_str());
            }
            // return the already removed items to the original owner
            if (hisItems[i])
            {
                if (!playerCanTrade)
                    LOG_ERROR("server", "player can't store item: %s", hisItems[i]->GetGUID().ToString().c_str());
                if (trader->CanStoreItem(NULL_BAG, NULL_SLOT, traderDst, hisItems[i], false) == EQUIP_ERR_OK)
                    trader->MoveItemToInventory(traderDst, hisItems[i], true, true);
                else
                    LOG_ERROR("server", "trader can't take item back: %s", hisItems[i]->GetGUID().ToString().c_str());
            }
        }
    }
}

//==============================================================

static void setAcceptTradeMode(TradeData* myTrade, TradeData* hisTrade, Item * *myItems, Item * *hisItems)
{
    myTrade->SetInAcceptProcess(true);
    hisTrade->SetInAcceptProcess(true);

    // store items in local list and set 'in-trade' flag
    for (uint8 i = 0; i < TRADE_SLOT_TRADED_COUNT; ++i)
    {
        if (Item* item = myTrade->GetItem(TradeSlots(i)))
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            LOG_DEBUG("server", "player trade item %s bag: %u slot: %u", item->GetGUID().ToString().c_str(), item->GetBagSlot(), item->GetSlot());
#endif
            //Can return nullptr
            myItems[i] = item;
            myItems[i]->SetInTrade();
        }

        if (Item* item = hisTrade->GetItem(TradeSlots(i)))
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            LOG_DEBUG("server", "partner trade item %s bag: %u slot: %u", item->GetGUID().ToString().c_str(), item->GetBagSlot(), item->GetSlot());
#endif
            hisItems[i] = item;
            hisItems[i]->SetInTrade();
        }
    }
}

static void clearAcceptTradeMode(TradeData* myTrade, TradeData* hisTrade)
{
    myTrade->SetInAcceptProcess(false);
    hisTrade->SetInAcceptProcess(false);
}

static void clearAcceptTradeMode(Item * *myItems, Item * *hisItems)
{
    // clear 'in-trade' flag
    for (uint8 i = 0; i < TRADE_SLOT_TRADED_COUNT; ++i)
    {
        if (myItems[i])
            myItems[i]->SetInTrade(false);
        if (hisItems[i])
            hisItems[i]->SetInTrade(false);
    }
}

void WorldSession::HandleAcceptTradeOpcode(WorldPacket& /*recvPacket*/)
{
    TradeData* my_trade = _player->m_trade;
    if (!my_trade)
        return;

    Player* trader = my_trade->GetTrader();

    TradeData* his_trade = trader->m_trade;
    if (!his_trade)
        return;

    Item* myItems[TRADE_SLOT_TRADED_COUNT]  = { nullptr, nullptr, nullptr, nullptr, nullptr, nullptr };
    Item* hisItems[TRADE_SLOT_TRADED_COUNT] = { nullptr, nullptr, nullptr, nullptr, nullptr, nullptr };
    bool myCanCompleteTrade = true, hisCanCompleteTrade = true;

    // set before checks for propertly undo at problems (it already set in to client)
    my_trade->SetAccepted(true);

    // not accept case incorrect money amount
    if (!_player->HasEnoughMoney(my_trade->GetMoney()))
    {
        SendNotification(LANG_NOT_ENOUGH_GOLD);
        my_trade->SetAccepted(false, true);
        return;
    }

    // not accept case incorrect money amount
    if (!trader->HasEnoughMoney(his_trade->GetMoney()))
    {
        trader->GetSession()->SendNotification(LANG_NOT_ENOUGH_GOLD);
        his_trade->SetAccepted(false, true);
        return;
    }

    if (_player->GetMoney() >= uint32(MAX_MONEY_AMOUNT) - his_trade->GetMoney())
    {
        _player->SendEquipError(EQUIP_ERR_TOO_MUCH_GOLD, nullptr, nullptr);
        my_trade->SetAccepted(false, true);
        return;
    }

    if (trader->GetMoney() >= uint32(MAX_MONEY_AMOUNT) - my_trade->GetMoney())
    {
        trader->SendEquipError(EQUIP_ERR_TOO_MUCH_GOLD, nullptr, nullptr);
        his_trade->SetAccepted(false, true);
        return;
    }

    // not accept if some items now can't be trade (cheating)
    for (uint8 i = 0; i < TRADE_SLOT_TRADED_COUNT; ++i)
    {
        if (Item* item = my_trade->GetItem(TradeSlots(i)))
        {
            if (!item->CanBeTraded(false, true))
            {
                SendTradeStatus(TRADE_STATUS_TRADE_CANCELED);
                return;
            }

            if (item->IsBindedNotWith(trader))
            {
                SendTradeStatus(TRADE_STATUS_NOT_ELIGIBLE);
                SendTradeStatus(TRADE_STATUS_CLOSE_WINDOW/*TRADE_STATUS_TRADE_CANCELED*/);
                return;
            }
        }

        if (Item* item = his_trade->GetItem(TradeSlots(i)))
        {
            if (!item->CanBeTraded(false, true))
            {
                SendTradeStatus(TRADE_STATUS_TRADE_CANCELED);
                return;
            }
            //if (item->IsBindedNotWith(_player))   // dont mark as invalid when his item isnt good (not exploitable because if item is invalid trade will fail anyway later on the same check)
            //{
            //    SendTradeStatus(TRADE_STATUS_NOT_ELIGIBLE);
            //    his_trade->SetAccepted(false, true);
            //    return;
            //}
        }
    }

    if (his_trade->IsAccepted())
    {
        setAcceptTradeMode(my_trade, his_trade, myItems, hisItems);

        Spell* my_spell = nullptr;
        SpellCastTargets my_targets;

        Spell* his_spell = nullptr;
        SpellCastTargets his_targets;

        // not accept if spell can't be casted now (cheating)
        if (uint32 my_spell_id = my_trade->GetSpell())
        {
            SpellInfo const* spellEntry = sSpellMgr->GetSpellInfo(my_spell_id);
            Item* castItem = my_trade->GetSpellCastItem();

            if (!spellEntry || !his_trade->GetItem(TRADE_SLOT_NONTRADED) ||
                    (my_trade->HasSpellCastItem() && !castItem))
            {
                clearAcceptTradeMode(my_trade, his_trade);
                clearAcceptTradeMode(myItems, hisItems);

                my_trade->SetSpell(0);
                return;
            }

            my_spell = new Spell(_player, spellEntry, TRIGGERED_FULL_MASK);
            my_spell->m_CastItem = castItem;
            my_targets.SetTradeItemTarget(_player);
            my_spell->m_targets = my_targets;

            SpellCastResult res = my_spell->CheckCast(true);
            if (res != SPELL_CAST_OK)
            {
                my_spell->SendCastResult(res);

                clearAcceptTradeMode(my_trade, his_trade);
                clearAcceptTradeMode(myItems, hisItems);

                delete my_spell;
                my_trade->SetSpell(0);
                return;
            }
        }

        // not accept if spell can't be casted now (cheating)
        if (uint32 his_spell_id = his_trade->GetSpell())
        {
            SpellInfo const* spellEntry = sSpellMgr->GetSpellInfo(his_spell_id);
            Item* castItem = his_trade->GetSpellCastItem();

            if (!spellEntry || !my_trade->GetItem(TRADE_SLOT_NONTRADED) || (his_trade->HasSpellCastItem() && !castItem))
            {
                delete my_spell;
                his_trade->SetSpell(0);

                clearAcceptTradeMode(my_trade, his_trade);
                clearAcceptTradeMode(myItems, hisItems);
                return;
            }

            his_spell = new Spell(trader, spellEntry, TRIGGERED_FULL_MASK);
            his_spell->m_CastItem = castItem;
            his_targets.SetTradeItemTarget(trader);
            his_spell->m_targets = his_targets;

            SpellCastResult res = his_spell->CheckCast(true);
            if (res != SPELL_CAST_OK)
            {
                his_spell->SendCastResult(res);

                clearAcceptTradeMode(my_trade, his_trade);
                clearAcceptTradeMode(myItems, hisItems);

                delete my_spell;
                delete his_spell;

                his_trade->SetSpell(0);
                return;
            }
        }

        // inform partner client
        trader->GetSession()->SendTradeStatus(TRADE_STATUS_TRADE_ACCEPT);

        // test if item will fit in each inventory
        hisCanCompleteTrade = (trader->CanStoreItems(myItems, TRADE_SLOT_TRADED_COUNT) == EQUIP_ERR_OK);
        myCanCompleteTrade = (_player->CanStoreItems(hisItems, TRADE_SLOT_TRADED_COUNT) == EQUIP_ERR_OK);

        clearAcceptTradeMode(myItems, hisItems);

        // in case of missing space report error
        if (!myCanCompleteTrade)
        {
            clearAcceptTradeMode(my_trade, his_trade);

            SendNotification(LANG_NOT_FREE_TRADE_SLOTS);
            trader->GetSession()->SendNotification(LANG_NOT_PARTNER_FREE_TRADE_SLOTS);
            my_trade->SetAccepted(false);
            his_trade->SetAccepted(false);
            delete my_spell;
            delete his_spell;
            return;
        }
        else if (!hisCanCompleteTrade)
        {
            clearAcceptTradeMode(my_trade, his_trade);

            SendNotification(LANG_NOT_PARTNER_FREE_TRADE_SLOTS);
            trader->GetSession()->SendNotification(LANG_NOT_FREE_TRADE_SLOTS);
            my_trade->SetAccepted(false);
            his_trade->SetAccepted(false);
            delete my_spell;
            delete his_spell;
            return;
        }

        // execute trade: 1. remove
        for (uint8 i = 0; i < TRADE_SLOT_TRADED_COUNT; ++i)
        {
            if (myItems[i])
            {
                myItems[i]->SetGuidValue(ITEM_FIELD_GIFTCREATOR, _player->GetGUID());
                _player->MoveItemFromInventory(myItems[i]->GetBagSlot(), myItems[i]->GetSlot(), true);
            }
            if (hisItems[i])
            {
                hisItems[i]->SetGuidValue(ITEM_FIELD_GIFTCREATOR, trader->GetGUID());
                trader->MoveItemFromInventory(hisItems[i]->GetBagSlot(), hisItems[i]->GetSlot(), true);
            }
        }

        // execute trade: 2. store
        moveItems(myItems, hisItems);

        if( my_trade->GetMoney() >= 10 * GOLD )
        {
            CharacterDatabase.PExecute("INSERT INTO log_money VALUES(%u, %u, \"%s\", \"%s\", %u, \"%s\", %u, \"<TRADE>\", NOW())",
                GetAccountId(), _player->GetGUID().GetCounter(), _player->GetName().c_str(), GetRemoteAddress().c_str(), trader->GetSession()->GetAccountId(), trader->GetName().c_str(), my_trade->GetMoney());
        }
        if( his_trade->GetMoney() >= 10 * GOLD )
        {
            CharacterDatabase.PExecute("INSERT INTO log_money VALUES(%u, %u, \"%s\", \"%s\", %u, \"%s\", %u, \"<TRADE>\", NOW())",
                trader->GetSession()->GetAccountId(), trader->GetGUID().GetCounter(), trader->GetName().c_str(), trader->GetSession()->GetRemoteAddress().c_str(), GetAccountId(), _player->GetName().c_str(), his_trade->GetMoney());
        }

        // update money
        _player->ModifyMoney(-int32(my_trade->GetMoney()));
        _player->ModifyMoney(his_trade->GetMoney());
        trader->ModifyMoney(-int32(his_trade->GetMoney()));
        trader->ModifyMoney(my_trade->GetMoney());

        if (my_spell)
            my_spell->prepare(&my_targets);

        if (his_spell)
            his_spell->prepare(&his_targets);

        // cleanup
        clearAcceptTradeMode(my_trade, his_trade);
        delete _player->m_trade;
        _player->m_trade = nullptr;
        delete trader->m_trade;
        trader->m_trade = nullptr;

        // desynchronized with the other saves here (SaveInventoryAndGoldToDB() not have own transaction guards)
        SQLTransaction trans = CharacterDatabase.BeginTransaction();
        _player->SaveInventoryAndGoldToDB(trans);
        trader->SaveInventoryAndGoldToDB(trans);
        CharacterDatabase.CommitTransaction(trans);

        trader->GetSession()->SendTradeStatus(TRADE_STATUS_TRADE_COMPLETE);
        SendTradeStatus(TRADE_STATUS_TRADE_COMPLETE);
    }
    else
    {
        trader->GetSession()->SendTradeStatus(TRADE_STATUS_TRADE_ACCEPT);
    }
}

void WorldSession::HandleUnacceptTradeOpcode(WorldPacket& /*recvPacket*/)
{
    TradeData* my_trade = _player->GetTradeData();
    if (!my_trade)
        return;

    my_trade->SetAccepted(false, true);
}

void WorldSession::HandleBeginTradeOpcode(WorldPacket& /*recvPacket*/)
{
    TradeData* my_trade = _player->m_trade;
    if (!my_trade)
        return;

    my_trade->GetTrader()->GetSession()->SendTradeStatus(TRADE_STATUS_OPEN_WINDOW);
    SendTradeStatus(TRADE_STATUS_OPEN_WINDOW);
}

void WorldSession::SendCancelTrade()
{
    if (PlayerLogout())
        return;

    SendTradeStatus(TRADE_STATUS_TRADE_CANCELED);
}

void WorldSession::HandleCancelTradeOpcode(WorldPacket& /*recvPacket*/)
{
    _player->TradeCancel(true);
}

void WorldSession::HandleInitiateTradeOpcode(WorldPacket& recvPacket)
{
    ObjectGuid ID;
    recvPacket >> ID;

    if (GetPlayer()->m_trade)
        return;

    if (!GetPlayer()->IsAlive())
    {
        SendTradeStatus(TRADE_STATUS_YOU_DEAD);
        return;
    }

    if (GetPlayer()->HasUnitState(UNIT_STATE_STUNNED))
    {
        SendTradeStatus(TRADE_STATUS_YOU_STUNNED);
        return;
    }

    if (isLogingOut())
    {
        SendTradeStatus(TRADE_STATUS_YOU_LOGOUT);
        return;
    }

    if (GetPlayer()->IsInFlight())
    {
        SendTradeStatus(TRADE_STATUS_TARGET_TO_FAR);
        return;
    }

    if (GetPlayer()->getLevel() < sWorld->getIntConfig(CONFIG_TRADE_LEVEL_REQ))
    {
        SendNotification(GetAcoreString(LANG_TRADE_REQ), sWorld->getIntConfig(CONFIG_TRADE_LEVEL_REQ));
        return;
    }

    if (GetPlayer()->IsSpectator())
        return;

    Player* pOther = ObjectAccessor::FindPlayer(ID);

    if (!pOther)
    {
        SendTradeStatus(TRADE_STATUS_NO_TARGET);
        return;
    }

    if (pOther == GetPlayer() || pOther->m_trade)
    {
        SendTradeStatus(TRADE_STATUS_BUSY);
        return;
    }

    if (!pOther->IsAlive())
    {
        SendTradeStatus(TRADE_STATUS_TARGET_DEAD);
        return;
    }

    if (pOther->IsInFlight())
    {
        SendTradeStatus(TRADE_STATUS_TARGET_TO_FAR);
        return;
    }

    if (pOther->HasUnitState(UNIT_STATE_STUNNED))
    {
        SendTradeStatus(TRADE_STATUS_TARGET_STUNNED);
        return;
    }

    if (pOther->GetSession()->isLogingOut())
    {
        SendTradeStatus(TRADE_STATUS_TARGET_LOGOUT);
        return;
    }

    if (pOther->GetSocial()->HasIgnore(GetPlayer()->GetGUID()))
    {
        SendTradeStatus(TRADE_STATUS_IGNORE_YOU);
        return;
    }

    if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_TRADE) && pOther->GetTeamId() != _player->GetTeamId())
    {
        SendTradeStatus(TRADE_STATUS_WRONG_FACTION);
        return;
    }

    if (!pOther->IsWithinDistInMap(_player, 10.0f, false))
    {
        SendTradeStatus(TRADE_STATUS_TARGET_TO_FAR);
        return;
    }

    if (pOther->getLevel() < sWorld->getIntConfig(CONFIG_TRADE_LEVEL_REQ))
    {
        SendNotification(GetAcoreString(LANG_TRADE_OTHER_REQ), sWorld->getIntConfig(CONFIG_TRADE_LEVEL_REQ));
        return;
    }

    if (!sScriptMgr->CanInitTrade(_player, pOther))
        return;

    // OK start trade
    _player->m_trade = new TradeData(_player, pOther);
    pOther->m_trade = new TradeData(pOther, _player);

    WorldPacket data(SMSG_TRADE_STATUS, 12);
    data << uint32(TRADE_STATUS_BEGIN_TRADE);
    data << _player->GetGUID();
    pOther->GetSession()->SendPacket(&data);
}

void WorldSession::HandleSetTradeGoldOpcode(WorldPacket& recvPacket)
{
    uint32 gold;
    recvPacket >> gold;

    TradeData* my_trade = _player->GetTradeData();
    if (!my_trade)
        return;

    my_trade->SetMoney(gold);
}

void WorldSession::HandleSetTradeItemOpcode(WorldPacket& recvPacket)
{
    // send update
    uint8 tradeSlot;
    uint8 bag;
    uint8 slot;

    recvPacket >> tradeSlot;
    recvPacket >> bag;
    recvPacket >> slot;

    TradeData* my_trade = _player->GetTradeData();
    if (!my_trade)
        return;

    // invalid slot number
    if (tradeSlot >= TRADE_SLOT_COUNT)
    {
        SendTradeStatus(TRADE_STATUS_TRADE_CANCELED);
        return;
    }

    // check cheating, can't fail with correct client operations
    Item* item = _player->GetItemByPos(bag, slot);
    if (!item || (tradeSlot != TRADE_SLOT_NONTRADED && !item->CanBeTraded(false, true)))
    {
        SendTradeStatus(TRADE_STATUS_TRADE_CANCELED);
        return;
    }

    ObjectGuid iGUID = item->GetGUID();

    // prevent place single item into many trade slots using cheating and client bugs
    if (my_trade->HasItem(iGUID))
    {
        // cheating attempt
        SendTradeStatus(TRADE_STATUS_TRADE_CANCELED);
        return;
    }

    my_trade->SetItem(TradeSlots(tradeSlot), item);
}

void WorldSession::HandleClearTradeItemOpcode(WorldPacket& recvPacket)
{
    uint8 tradeSlot;
    recvPacket >> tradeSlot;

    TradeData* my_trade = _player->m_trade;
    if (!my_trade)
        return;

    // invalid slot number
    if (tradeSlot >= TRADE_SLOT_COUNT)
        return;

    my_trade->SetItem(TradeSlots(tradeSlot), nullptr);
}
