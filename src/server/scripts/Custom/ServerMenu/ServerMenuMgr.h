#ifndef SERVER_MENU_H
#define SERVER_MENU_H

#define UNIQUE_MENU_ID 123

#define GetCustomText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

constexpr static const uint32 BuffList[9] = {
    25898, 48470, 53307, 48074, 48162, 48170, 57623, 43002, 47440
};

class sServerMenu
{
public:
    static sServerMenu* instance()
    {
        static sServerMenu* instance = new sServerMenu();
        return instance;
    }

    void OpenBankSlot(Player* /*player*/);
    void OpenMailSlot(Player* /*player*/);
    void ChangeRFN(Player* /*player*/, int /*i*/);
    std::string ConfirmChangeRFN(Player* /*player*/, uint32 /*cost*/);
    std::string HeadMenu(Player* /*player*/, uint8 /*MenuId*/);
    void CharControlMenu(Player* /*player*/);
    void GossipHelloMenu(Player* /*player*/);
    void CommingSoon(Player* player);
    bool CanOpenMenu(Player* /*player*/);

    void RankInfo(Player* /*player*/);

    uint32 getFactionCost() { return _factionCost; }
    uint32 getRaceCost() { return _raceCost; }
    uint32 getNickCost() { return _nickCost; }

    // Передача очков чести игроку
    void OpenTradeHonor(Player* /*player*/);
    // Проверяем игрок онлайн или нет
    void TradeHonorAccept(Player* /*player*/, uint32 /*honor*/, char const* /*args*/);
    // Снимает и выдаем
    void SendHonorToPlayer(Player* /*sender*/, ObjectGuid /*receiver*/, uint32 /*amount*/, bool /*online*/, Player* /*Preceiver*/, char const* /*name*/);

    // Главное меню обменика
    void GossipMenuExchangeHonor(Player* /*player*/);
    // Отоброжение в менюшке сколько что стоит
    std::string ConverterHonorRang(Player* /*player*/, uint32 /*honor*/, uint32 /*exp*/, uint8 /* count */);
    // Расчёт сколько хонора будет стоить
    uint32 CalculHonorForExp(Player* /*player*/, uint32 /*honor*/, uint8 /* count */);
    // Подтверждение обмена валюты
    void ConfirmExchangeHonorForExp(Player* /*player*/, uint32 /*honor*/, uint32 /*exp*/, uint32 /* count */);

    // сброс кд инстов
    void InstanceResetCooldown(Player* /*player*/);

    // обменник эмблем
    void ExchangerToken(Player* /*player*/);
    // подтверждение обмена
    void ExchangerConfirm(Player* /*player*/, bool /*frost*/);

    /* выдача VIP - delay это кол дней указывать в 1,7,30 итд... */
    void GetVipStatus(Player* /*player*/, uint16 /*days*/);
    void GetVipMenu(Player* /*player*/);
    void GetVipMenuForBuy(Player* /*player*/);
    void BuyVip(Player* /*player*/, uint16 /*days*/);
    void RemoveAuraForVip(Player* /*player*/, bool /*disert*/);
    void VipSetBuff(Player* /* player */);
    /* Обучение маунтов */
    void VipMountLearn(Player* /*player*/);

    /* награды за ивент */
    uint32 RewardEventValue(Player* /*player*/, uint32 /*entry*/, bool /*bigEvent*/, uint32 /* prize */, int /*value*/);
    std::string ConverterEventReward(Player* player, uint32 entry, bool bigEvent, uint32 prize, int value, std::string name);
    void GossipMenuEventReward(Player* player, uint32 entry, bool bigEvent, uint32 prize);
    void RewardEvent(Player* player, uint8 value, uint32 amount);

    void SetItemRewardID(uint32 id) { _usedItemRewardID = id; }
    uint32 GetItemRewardID() { return _usedItemRewardID; }

    // выходные опыт на 50% больше
    bool isDoubleDays();

private:
    static const uint32 _factionCost = 50;
    static const uint32 _raceCost = 30;
    static const uint32 _nickCost = 15;

    // ID предмета который игрок за ивент нажал
    uint32 _usedItemRewardID = 0; 
};

#define sServerMenuMgr sServerMenu::instance()
#endif