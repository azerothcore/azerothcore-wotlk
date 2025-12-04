/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Player.h"
#include "WorldSession.h"

TradeData* TradeData::GetTraderData() const
{
    return m_trader->GetTradeData();
}

Item* TradeData::GetItem(TradeSlots slot) const
{
    return m_items[slot] ? m_player->GetItemByGuid(m_items[slot]) : nullptr;
}

bool TradeData::HasItem(ObjectGuid itemGuid) const
{
    for (uint8 i = 0; i < TRADE_SLOT_COUNT; ++i)
        if (m_items[i] == itemGuid)
            return true;

    return false;
}

TradeSlots TradeData::GetTradeSlotForItem(ObjectGuid itemGuid) const
{
    for (uint8 i = 0; i < TRADE_SLOT_COUNT; ++i)
        if (m_items[i] == itemGuid)
            return TradeSlots(i);

    return TRADE_SLOT_INVALID;
}

Item* TradeData::GetSpellCastItem() const
{
    return m_spellCastItem ? m_player->GetItemByGuid(m_spellCastItem) : nullptr;
}

void TradeData::SetItem(TradeSlots slot, Item* item)
{
    ObjectGuid itemGuid = item ? item->GetGUID() : ObjectGuid::Empty;

    if (m_items[slot] == itemGuid)
        return;

    m_items[slot] = itemGuid;

    SetAccepted(false);
    GetTraderData()->SetAccepted(false);

    Update();

    // need remove possible trader spell applied to changed item
    if (slot == TRADE_SLOT_NONTRADED)
        GetTraderData()->SetSpell(0);

    // need remove possible player spell applied (possible move reagent)
    SetSpell(0);
}

void TradeData::SetSpell(uint32 spell_id, Item* castItem /*= nullptr*/)
{
    ObjectGuid itemGuid = castItem ? castItem->GetGUID() : ObjectGuid::Empty;

    if (m_spell == spell_id && m_spellCastItem == itemGuid)
        return;

    m_spell = spell_id;
    m_spellCastItem = itemGuid;

    SetAccepted(false);
    GetTraderData()->SetAccepted(false);

    Update(true);                                           // send spell info to item owner
    Update(false);                                          // send spell info to caster self
}

void TradeData::SetMoney(uint32 money)
{
    if (m_money == money)
        return;

    if (!m_player->HasEnoughMoney(money))
    {
        m_player->GetSession()->SendTradeStatus(TRADE_STATUS_BUSY);
        return;
    }

    m_money = money;

    SetAccepted(false);
    GetTraderData()->SetAccepted(false);

    Update(true);
}

void TradeData::Update(bool forTarget /*= true*/)
{
    if (forTarget)
        m_trader->GetSession()->SendUpdateTrade(true);      // player state for trader
    else
        m_player->GetSession()->SendUpdateTrade(false);     // player state for player
}

void TradeData::SetAccepted(bool state, bool crosssend /*= false*/)
{
    m_accepted = state;

    if (!state)
    {
        if (crosssend)
            m_trader->GetSession()->SendTradeStatus(TRADE_STATUS_BACK_TO_TRADE);
        else
            m_player->GetSession()->SendTradeStatus(TRADE_STATUS_BACK_TO_TRADE);
    }
}
