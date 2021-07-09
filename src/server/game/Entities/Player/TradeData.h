/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

enum TradeSlots
{
    TRADE_SLOT_COUNT            = 7,
    TRADE_SLOT_TRADED_COUNT     = 6,
    TRADE_SLOT_NONTRADED        = 6,
    TRADE_SLOT_INVALID          = -1,
};

class TradeData
{
public:                                                 // constructors
    TradeData(Player* player, Player* trader) : m_player(player),  m_trader(trader), m_accepted(false), m_acceptProccess(false), m_money(0), m_spell(0)
    {
    }

    [[nodiscard]] Player* GetTrader() const { return m_trader; }
    [[nodiscard]] TradeData* GetTraderData() const;

    [[nodiscard]] Item* GetItem(TradeSlots slot) const;
    [[nodiscard]] bool HasItem(ObjectGuid itemGuid) const;
    [[nodiscard]] TradeSlots GetTradeSlotForItem(ObjectGuid itemGuid) const;
    void SetItem(TradeSlots slot, Item* item);

    [[nodiscard]] uint32 GetSpell() const { return m_spell; }
    void SetSpell(uint32 spell_id, Item* castItem = nullptr);

    [[nodiscard]] Item*  GetSpellCastItem() const;
    [[nodiscard]] bool HasSpellCastItem() const { return m_spellCastItem; }

    [[nodiscard]] uint32 GetMoney() const { return m_money; }
    void SetMoney(uint32 money);

    [[nodiscard]] bool IsAccepted() const { return m_accepted; }
    void SetAccepted(bool state, bool crosssend = false);

    [[nodiscard]] bool IsInAcceptProcess() const { return m_acceptProccess; }
    void SetInAcceptProcess(bool state) { m_acceptProccess = state; }

private:                                                // internal functions
    void Update(bool for_trader = true);

private:                                                // fields
    Player*    m_player;                                // Player who own of this TradeData
    Player*    m_trader;                                // Player who trade with m_player

    bool       m_accepted;                              // m_player press accept for trade list
    bool       m_acceptProccess;                        // one from player/trader press accept and this processed

    uint32     m_money;                                 // m_player place money to trade

    uint32     m_spell;                                 // m_player apply spell to non-traded slot item
    ObjectGuid m_spellCastItem;                         // applied spell casted by item use

    ObjectGuid m_items[TRADE_SLOT_COUNT];               // traded itmes from m_player side including non-traded slot
};