#include "ServerMenuMgr.h"
#include "Player.h"
#include "Chat.h"
#include "Translate.h"

void sServerMenu::OpenBankSlot(Player* player) {
    player->PlayerTalkClass->SendCloseGossip();
	player->GetSession()->SendShowBank(player->GetGUID());
}

void sServerMenu::OpenMailSlot(Player* player) {
    player->PlayerTalkClass->SendCloseGossip();
	player->GetSession()->SendShowMailBox(player->GetGUID());
}

std::string sServerMenu::ConfirmChangeRFN(Player* player, uint32 cost) {
    std::ostringstream ss;
    if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        ss << "\nНужно заплатить: " << cost << " бонусов. Продолжим ?";
    else
        ss << "\nNeed to pay: " << cost << " bonuses. Continue ?";
    return ss.str().c_str();
}

void sServerMenu::ChangeRFN(Player* player, int i) {

    uint32 bonuses = player->GetSession()->GetBonuses();

    switch (i) {
        case 0:
            if (bonuses >= sServerMenuMgr->getFactionCost()) {
                player->GetSession()->SetBonuses(uint32(bonuses - sServerMenuMgr->getFactionCost()));
                player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
                ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сделайте релог для применение действий.", "Relog to apply actions."));
            } else {
                ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,RU_NO_BONUS_HAVE, EN_NO_BONUS_HAVE), sServerMenuMgr->getFactionCost());
            }
            break;
        case 1:
            if (bonuses >= sServerMenuMgr->getRaceCost()) {
                player->GetSession()->SetBonuses(uint32(bonuses - sServerMenuMgr->getRaceCost()));
                player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
                ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сделайте релог для применение действий.", "Relog to apply actions."));
            } else {
                ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,RU_NO_BONUS_HAVE, EN_NO_BONUS_HAVE), sServerMenuMgr->getRaceCost());
            }
            break;
        case 2:
            if (bonuses >= sServerMenuMgr->getNickCost()) {
                player->GetSession()->SetBonuses(uint32(bonuses - sServerMenuMgr->getNickCost()));
                player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
                ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сделайте релог для применение действий.", "Relog to apply actions."));
            } else {
                ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,RU_NO_BONUS_HAVE, EN_NO_BONUS_HAVE), sServerMenuMgr->getNickCost());
            }
            break;
        default: break;
    }
    player->PlayerTalkClass->SendCloseGossip();
}

void sServerMenu::CharControlMenu(Player* player) {
    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_1, EN_CHAR_CONTROL_1), GOSSIP_SENDER_MAIN + 1, 0);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_2, EN_CHAR_CONTROL_2), GOSSIP_SENDER_MAIN + 1, 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_4, EN_CHAR_CONTROL_4), GOSSIP_SENDER_MAIN + 1, 2, ConfirmChangeRFN(player, sServerMenuMgr->getFactionCost()), 0, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_5, EN_CHAR_CONTROL_5), GOSSIP_SENDER_MAIN + 1, 3, ConfirmChangeRFN(player, sServerMenuMgr->getRaceCost()), 0, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_6, EN_CHAR_CONTROL_6), GOSSIP_SENDER_MAIN + 1, 4, ConfirmChangeRFN(player, sServerMenuMgr->getNickCost()), 0, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_back, EN_back), GOSSIP_SENDER_MAIN, 0);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 1), player->GetGUID());
}

std::string sServerMenu::HeadMenu(Player* player, uint8 MenuId) {
    std::ostringstream ss;
    switch (MenuId) {
        case 0: {
            if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "На вашем аккаунте " << player->GetSession()->GetBonuses() << " бонусов.\n";
                ss << "Пополнить счёт: \nhttp://wow-idk.ru/\n\n";
            }
            else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "You have " << player->GetSession()->GetBonuses() << "bonuses in your account";
                ss << "Top up account http://wow-idk.ru/\n\n";
            }
        } break;
        case 1: {
            if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "В данном разделе будет добавлятся уникальные разработки как и стандарт по нужде игрокам.\n";
            } else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "In this section, unique developments will be added as well as a standard according to the needs of the players.\n";
            }
        } break;
        default: break;
    }
    return ss.str().c_str();
}

void sServerMenu::GossipHelloMenu(Player* player) {
    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_1, EN_HOME_MENU_1), GOSSIP_SENDER_MAIN, 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_2, EN_HOME_MENU_2), GOSSIP_SENDER_MAIN, 2);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_3, EN_HOME_MENU_3), GOSSIP_SENDER_MAIN, 3);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_4, EN_HOME_MENU_4), GOSSIP_SENDER_MAIN, 4);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_5, EN_HOME_MENU_5), GOSSIP_SENDER_MAIN, 5);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_6, EN_HOME_MENU_6), GOSSIP_SENDER_MAIN, 6);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_7, EN_HOME_MENU_7), GOSSIP_SENDER_MAIN, 7);
    player->PlayerTalkClass->GetGossipMenu().SetMenuId(UNIQUE_MENU_ID);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 0), player->GetGUID());
}

void sServerMenu::CommingSoon(Player* player) {
    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Система в разработке, работает только раздел Управление персонажем", "Система в разработке, работает только раздел Управление персонажем"), sServerMenuMgr->getFactionCost());
    player->PlayerTalkClass->SendCloseGossip(); 
}

bool sServerMenu::CanOpenMenu(Player* player) {
    if (player->IsInCombat() || player->IsInFlight() || player->IsDeathMatch() || player->GetMap()->IsBattlegroundOrArena()
        || player->HasStealthAura() || player->isDead() || (player->getClass() == CLASS_DEATH_KNIGHT && player->GetMapId() == 609 && !player->IsGameMaster() && !player->HasSpell(50977))) {
        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сейчас это невозможно.", "Now it is impossible"));
        return true;
    }
    return false;
}