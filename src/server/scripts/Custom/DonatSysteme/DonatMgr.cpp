#include "DonatMgr.h"
#include "Player.h"
#include "Translate.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "Define.h"
#include "GossipDef.h"
#include "Language.h"
#include "DeathMatch.h"
#include "../ServerMenu/ServerMenuMgr.h"

/* ################  загрузка таблиц ################ */
void DonationSysteme::LoadDonationSystemeListContainer() 
{
    for (DonationSysteme::DonationSysteme_Container::const_iterator itr = m_DonationSysteme_Container.begin(); itr != m_DonationSysteme_Container.end(); ++itr)
        delete *itr;

    m_DonationSysteme_Container.clear();

    QueryResult result = CharacterDatabase.Query("SELECT id, gossip_menu, classID, name_RU, name_EN, itemID, count, cost, discount FROM server_donat_menu ORDER BY id;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_INFO("Custom.DonationSyteme", ">> DonationSyteme: Loaded 0 donat item. DB table `server_donat_menu` is empty!.");
        return;
    }

    do
    {
        Field* fields                    = result->Fetch();
        DonationSystemeList* pDonation   = new DonationSystemeList;

        pDonation->id                = fields[0].Get<uint32>();
        pDonation->gossip_menu       = fields[1].Get<uint8>();
        pDonation->classID           = fields[2].Get<uint32>();
        pDonation->name_RU           = fields[3].Get<std::string>();
        pDonation->name_EN           = fields[4].Get<std::string>();
        pDonation->itemID            = fields[5].Get<uint16>();
        pDonation->count             = fields[6].Get<uint32>();
        pDonation->cost              = fields[7].Get<uint32>();
        pDonation->discount          = fields[8].Get<uint32>();

        m_DonationSysteme_Container.push_back(pDonation);
        ++count;
    } while (result->NextRow());

    LOG_INFO("Custom.DonationSyteme", ">> DonationSyteme: Loaded {} donat items in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void DonationSysteme::DonationSystemeListMain(Player* player) {
    ClearGossipMenuFor(player);
    for (DonationSysteme::DonationSysteme_Container::const_iterator itr = m_DonationSysteme_Container.begin(); itr != m_DonationSysteme_Container.end(); ++itr)
        if ((*itr)->gossip_menu == 0)
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, (*itr)->name_RU, (*itr)->name_EN), GOSSIP_SENDER_MAIN + 13, (*itr)->id);
    // меню опций
    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetCustomText(player, RU_DONAT_MENU_OPTION, EN_DONAT_MENU_OPTION), GOSSIP_SENDER_MAIN + 16, 0);   
    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetCustomText(player, RU_HOME_MENU_NO_ICON, EN_HOME_MENU_NO_ICON), GOSSIP_SENDER_MAIN, 0);
    player->PlayerTalkClass->SendGossipMenu(HeadMenu(player), player->GetGUID());
}

void DonationSysteme::GetDonationSystemeAfter(Player* player, uint32 action, uint32 classid) {
    ClearGossipMenuFor(player);
    for (DonationSysteme::DonationSysteme_Container::const_iterator itr = m_DonationSysteme_Container.begin(); itr != m_DonationSysteme_Container.end(); ++itr) {
        if ((*itr)->gossip_menu != 0 && (*itr)->gossip_menu == action && ((*itr)->classID == classid || (*itr)->classID == 0)) {
            AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, ReturnFullName(player, (*itr)->itemID, (*itr)->cost, (*itr)->count, (*itr)->discount), GOSSIP_SENDER_MAIN + 14, (*itr)->id);
        }
    }
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HOME_MENU_NO_ICON, EN_HOME_MENU_NO_ICON), GOSSIP_SENDER_MAIN, 3);
    player->PlayerTalkClass->SendGossipMenu(HeadMenu(player), player->GetGUID());
}

void DonationSysteme::DonatOption(Player* player)
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_CHAR_CONTROL_4, EN_CHAR_CONTROL_4), GOSSIP_SENDER_MAIN + 1, 2, sServerMenuMgr->ConfirmChangeRFN(player, sServerMenuMgr->getFactionCost()), 0, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_CHAR_CONTROL_5, EN_CHAR_CONTROL_5), GOSSIP_SENDER_MAIN + 1, 3, sServerMenuMgr->ConfirmChangeRFN(player, sServerMenuMgr->getRaceCost()), 0, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_CHAR_CONTROL_6, EN_CHAR_CONTROL_6), GOSSIP_SENDER_MAIN + 1, 4, sServerMenuMgr->ConfirmChangeRFN(player, sServerMenuMgr->getNickCost()), 0, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_back_CHAR, EN_back_CHAR), GOSSIP_SENDER_MAIN, 3);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player), player->GetGUID());
}

std::string DonationSysteme::ReturnFullName(Player* player, uint32 entry, uint32 cost, uint32 count, uint32 discount) 
{
    WorldSession* session = player->GetSession();
    if (!session)
        return "";
    std::stringstream ss;    
    ss << " " << DeathMatchMgr->GetItemIcon(entry, 15, 15, 0, 0) << " " << DeathMatchMgr->GetItemLink(entry, session) << " x" << count ;
    ss << "\n       |cff473B32Стоймость: " << returnCost(cost, discount) << " бонус. |r";
    return ss.str(); 
}

void DonationSysteme::LookingItem(Player* player, uint32 id) 
{
    WorldSession* session = player->GetSession();
    if (!session)
        return;

    for (DonationSysteme::DonationSysteme_Container::const_iterator itr = m_DonationSysteme_Container.begin(); itr != m_DonationSysteme_Container.end(); ++itr) {
        if ((*itr)->id == id) 
        {
            std::stringstream str;
            uint32 bonus = player->GetSession()->GetBonuses();
            uint32 final = returnCost((*itr)->cost, (*itr)->discount);

            str << "|cffff9933################|cffffff4d Магазин|cffff9933 ####################\n|cffff9933# Выбранный предмет для покупки:|r\n";
            str << "|cffff9933#|r " << DeathMatchMgr->GetItemIcon((*itr)->itemID, 15, 15, 0, 0) << " " << DeathMatchMgr->GetItemLink((*itr)->itemID, player->GetSession());
            str << "\n|cffff9933#|r |cffff9933Стоимость: |cffffff4d" << (*itr)->cost << "|cffff9933 бонусов.|r\n";

            if ((*itr)->cost != final)
                str << "|cffff9933#|r |cffff9933Скидка: |cffffff4d" << (*itr)->discount << "%|cffff9933, новая цена: |cffffff4d" << final << "|cffff9933 бонусов.|r";

            str << "\n|cffff9933#|r |cffff9933На вашем аккаунте |cffffff4d" << bonus << "|cffff9933 бонусов.|r\n";

            if (bonus < final)
            {
                str << "|cffff9933#|r |cffff9933Вам необходимо еще |cffffff4d" << final - bonus << " бонусов.|r\n";
                str << "|cffff9933#|r |cffff9933Пополните свой аккаунт через наш сайт |cffffff4dwow-idk.ru|r\n";
            }

            str << "|cffff9933############################################|r";
            ChatHandler(player->GetSession()).PSendSysMessage("%s", str.str().c_str());
            break;
        }
    }
}

void DonationSysteme::DonationFunction(Player* player, uint32 i) 
{   
    for (DonationSysteme::DonationSysteme_Container::const_iterator itr = m_DonationSysteme_Container.begin(); itr != m_DonationSysteme_Container.end(); ++itr) {
        if ((*itr)->id == i) { 
            player->GetSession()->SetBonuses(player->GetSession()->GetBonuses() - (*itr)->cost);
            player->AddItem((*itr)->itemID, (*itr)->count);
            ChatHandler(player->GetSession()).PSendSysMessage("Поздравляем вас, с успешной покупкой предмета!");
        }
    }
    player->PlayerTalkClass->SendCloseGossip();
}

void DonationSysteme::DonatPayementFuction(Player* player, uint32 i)
{
    for (DonationSysteme::DonationSysteme_Container::const_iterator itr = m_DonationSysteme_Container.begin(); itr != m_DonationSysteme_Container.end(); ++itr) {
        if ((*itr)->id == i) {
            // линк в чат игроку
            DonationSystemeMgr->LookingItem(player, (*itr)->id);
            // если хватает бонусов то открываем меню покупки
            if (player->GetSession()->GetBonuses() >= returnCost((*itr)->cost, (*itr)->discount)) 
            {
                WorldSession* session = player->GetSession();
                if (!session)
                    return;

                std::stringstream str;
                str << "|cffff9933[|cffffff4dМагазин WOW-IDK|cffff9933]|r\n";
                str << "|cffff9933Вы действительно хотите купить данный предмет: |r\n";
                str <<  DeathMatchMgr->GetItemLink((*itr)->itemID, session) << "\n";
                str << "|cffff9933За |cffffff4d" << returnCost((*itr)->cost, (*itr)->discount) << "|cffff9933 бонусов ?|r";

                player->PlayerTalkClass->ClearMenus();

                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, 
                ReturnFullName(player, (*itr)->itemID, (*itr)->cost, (*itr)->count, (*itr)->discount),  
                GOSSIP_SENDER_MAIN + 15, 
                (*itr)->id, 
                str.str().c_str(), 0, false);
                player->PlayerTalkClass->SendGossipMenu(HeadMenu(player), player->GetGUID());
                return;
            } else {
                GetDonationSystemeAfter(player, i, player->getClass());
            }
        }
    }
}

uint32 DonationSysteme::returnCost(uint32 cost, uint32 discount) 
{
    if (!discount)
        return cost;

    return (cost - ((cost/100) * discount));
}

std::string DonationSysteme::HeadMenu(Player* player) 
{
    std::stringstream ss;
    if (!player)
        ss << "Ошибка...";

    if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
        ss << "Приветствую вас, " << player->GetName() << "\n\n";
        ss << "На вашем аккаунте " << player->GetSession()->GetBonuses() << " бонусов.\n";
        ss << "Пополнить счёт: wow-idk.ru";             
    }
    else {
        ss << "Greetings, " << player->GetName() << "\n\n";
        ss << "You have " << player->GetSession()->GetBonuses() << "bonuses in your account";
        ss << "Top up account wow-idk.ru";
    }
    return ss.str();
}