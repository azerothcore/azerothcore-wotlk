#ifndef SERVER_MENU_H
#define SERVER_MENU_H

#define UNIQUE_MENU_ID 123

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

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

    uint32 getFactionCost() { return _factionCost; }
    uint32 getRaceCost() { return _raceCost; }
    uint32 getNickCost() { return _nickCost; }

private:
    static const uint32 _factionCost = 50;
    static const uint32 _raceCost = 30;
    static const uint32 _nickCost = 15;    
};

#define sServerMenuMgr sServerMenu::instance()
#endif