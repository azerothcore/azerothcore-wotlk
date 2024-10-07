#include "Define.h"
#include "GossipDef.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "ServerMenuMgr.h"
#include "Translate.h"

/* ################  загрузка таблиц ################ */

void sServerMenu::LoadBuffsContainer() {

    for (Buffs_Container::const_iterator itr = m_Buffs_Container.begin(); itr != m_Buffs_Container.end(); ++itr)
        delete *itr;

    m_Buffs_Container.clear();

    QueryResult result = CharacterDatabase.Query("SELECT entry, cost FROM server_menu_buffs ORDER BY cost;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_INFO("server.LoadMenu", ">> ServerMenu: Loaded 0 'buffs. DB table `server_menu_buffs` is empty!");
        return;
    }
    do
    {
        Field* fields      = result->Fetch();
        Buffs_List* pBuffs = new Buffs_List;
        pBuffs->Entry      = fields[0].Get<uint32>();
        pBuffs->Cost       = fields[1].Get<uint32>();

        m_Buffs_Container.push_back(pBuffs);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.LoadMenu", ">> ServerMenu: Loaded %u buffs in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sServerMenu::LoadTitlesContainer() {
    for (Titles_Container::const_iterator itr = m_Titles_Container.begin(); itr != m_Titles_Container.end(); ++itr)
        delete *itr;

    m_Titles_Container.clear();

    QueryResult result = CharacterDatabase.Query("SELECT entry, cost FROM server_menu_titles ORDER BY cost;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_INFO("server.LoadMenu", ">> ServerMenu: Loaded 0 'titles. DB table `server_menu_titles` is empty!");
        return;
    }

    do
    {
        Field* fields        = result->Fetch();
        Titles_List* pTitles = new Titles_List;
        pTitles->Entry       = fields[0].Get<uint32>();
        pTitles->Cost        = fields[1].Get<uint32>();

        m_Titles_Container.push_back(pTitles);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.LoadMenu", ">> ServerMenu: Loaded %u titles in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sServerMenu::LoadTeleportListContainer() {
    for (TeleportList_Container::const_iterator itr = m_TeleportList_Container.begin(); itr != m_TeleportList_Container.end(); ++itr)
        delete *itr;

    m_TeleportList_Container.clear();

    QueryResult result = CharacterDatabase.Query("SELECT id, gossip_menu, faction, cost, name_RU, name_EN, map, position_x, position_y, position_z, orientation FROM server_menu_teleportlist ORDER BY id;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_INFO("server.LoadMenu", ">> ServerMenu: Loaded 0 'teleportlist. DB table `server_menu_teleportlist` is empty!");
        return;
    }

    do
    {
        Field* fields            = result->Fetch();
        TeleportListSTR* pTele   = new TeleportListSTR;
        pTele->id                = fields[0].Get<uint32>();
        pTele->gossip_menu       = fields[1].Get<uint8>();
        pTele->faction           = fields[2].Get<uint8>();
        pTele->cost              = fields[3].Get<uint32>();
        pTele->name_RU           = fields[4].Get<std::string>();
        pTele->name_EN           = fields[5].Get<std::string>();
        pTele->map               = fields[6].Get<uint16>();
        pTele->position_x        = fields[7].Get<float>();
        pTele->position_y        = fields[8].Get<float>();
        pTele->position_z        = fields[9].Get<float>();
        pTele->orientation       = fields[10].Get<float>();

        m_TeleportList_Container.push_back(pTele);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.LoadMenu", ">> ServerMenu: Loaded %u teleportlist in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

/* ################ телепорт ######################### */

void sServerMenu::TeleportListMain(Player* player) {
    ClearGossipMenuFor(player);
    for (TeleportList_Container::const_iterator itr = m_TeleportList_Container.begin(); itr != m_TeleportList_Container.end(); ++itr)
        if((*itr)->gossip_menu == 0)
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, (*itr)->name_RU, (*itr)->name_EN), GOSSIP_SENDER_MAIN + 1, (*itr)->id);
    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_HOME_MENU_NO_ICON, EN_HOME_MENU_NO_ICON), GOSSIP_SENDER_MAIN, GossipHelloMenu);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, GossipHelloMenu + 1), player->GetGUID());
}

void sServerMenu::GetTeleportListAfter(Player* player, uint32 action, uint8 faction) {
    ClearGossipMenuFor(player);
    for (TeleportList_Container::const_iterator itr = m_TeleportList_Container.begin(); itr != m_TeleportList_Container.end(); ++itr) {
        if((*itr)->gossip_menu != 0 && (*itr)->gossip_menu == action && ((*itr)->faction == faction || (*itr)->faction == 3)) {
            AddGossipItemFor(player, GOSSIP_ICON_TAXI, GetText(player, (*itr)->name_RU + ConverterMoneyToGold(player, CalculRequiredMoney(player, (*itr)->cost)), (*itr)->name_EN +
            ConverterMoneyToGold(player, CalculRequiredMoney(player, (*itr)->cost))),
            GOSSIP_SENDER_MAIN + 2, (*itr)->id, ConfirmMoneyTeleport(player, GetText(player, (*itr)->name_RU, (*itr)->name_EN)),
            CalculRequiredMoney(player, (*itr)->cost), false);
        }
    }
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_NO_ICON, EN_HOME_MENU_NO_ICON), GOSSIP_SENDER_MAIN, GossipHelloMenu + 1);
    player->PlayerTalkClass->SendGossipMenu(HeadMenu(player, GossipHelloMenu + 1), player->GetGUID());
}

void sServerMenu::TeleportFunction(Player* player, uint32 i) {
    for (TeleportList_Container::const_iterator itr = m_TeleportList_Container.begin(); itr != m_TeleportList_Container.end(); ++itr) {
        if((*itr)->id == i) {
            player->TeleportTo((*itr)->map, (*itr)->position_x, (*itr)->position_y, (*itr)->position_z, (*itr)->orientation);
            player->ModifyMoney(-CalculRequiredMoney(player, (*itr)->cost));
            ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, RU_SUCCESS_TELEPORT, EN_SUCCESS_TELEPORT), GetText(player, (*itr)->name_RU.c_str(), (*itr)->name_EN.c_str()));
            player->PlayerTalkClass->SendCloseGossip();
            break;
        }
    }
}

/* ############################# Расчет голды ########################## */

uint32 sServerMenu::CalculRequiredMoney(Player* player, uint32 money) {
    /* количество рангов (1 ранг = 2% скидка) */
    uint8 count = player->GetAuraCount(71201);
    return ((money/100) * (100 - (count*2)));
}

std::string sServerMenu::ConverterMoneyToGold(Player* player, uint32 money) {

    uint32 gold                   = money / GOLD;
    uint32 silv                   = (money % GOLD) / SILVER;
    uint32 copp                   = (money % GOLD) % SILVER;

    std::stringstream ss;
    if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        ss << "\nНужно заплатить: ";
    else
        ss << "\nNeed to pay: ";

    if (money == 0)
        ss << "0|TInterface\\moneyframe\\ui-coppericon:11:11:2:0|t";
    else {
        if(gold > 0)
            ss << gold <<"|TInterface\\moneyframe\\ui-goldicon:11:11:2:0|t ";
        if(silv > 0)
           ss << silv << "|TInterface\\moneyframe\\ui-silvericon:11:11:2:0|t ";
        if(copp > 0)
           ss << copp << "|TInterface\\moneyframe\\ui-coppericon:11:11:2:0|t";
    }
    return ss.str();
}

std::string sServerMenu::ConfirmMoneyTeleport(Player* player, std::string telename) {
    std::stringstream ss;
    if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        ss << "Вы уверены что хотите попасть в зону\n    <" << telename << ">\nза указанную сумму ниже ?\n";
    else
        ss << "Are you sure you want to get into the zone\n    <" << telename << ">\nfor the indicated amount below ?\n";
    return ss.str();
}

/* ################ управление персонажем  ################ */
void sServerMenu::CharControlMenu(Player* player) {
    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_1, EN_CHAR_CONTROL_1), GOSSIP_SENDER_MAIN + 5, GossipHelloMenu);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_2, EN_CHAR_CONTROL_2), GOSSIP_SENDER_MAIN + 5, GossipHelloMenu + 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_3, EN_CHAR_CONTROL_3), GOSSIP_SENDER_MAIN + 5, GossipHelloMenu + 2);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_4, EN_CHAR_CONTROL_4), GOSSIP_SENDER_MAIN + 5, GossipHelloMenu + 3, ConfirmChangeRFN(player), CHANGE_FACTION_COST, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_5, EN_CHAR_CONTROL_5), GOSSIP_SENDER_MAIN + 5, GossipHelloMenu + 4, ConfirmChangeRFN(player), CHANGE_RACE_COST, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_CHAR_CONTROL_6, EN_CHAR_CONTROL_6), GOSSIP_SENDER_MAIN + 5, GossipHelloMenu + 5, ConfirmChangeRFN(player), CHANGE_NICK_COST, false);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_back, EN_back), GOSSIP_SENDER_MAIN, GossipHelloMenu);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, GossipHelloMenu + 4), player->GetGUID());
}

void sServerMenu::OpenBankSlot(Player* player) {
    player->PlayerTalkClass->SendCloseGossip();
	player->GetSession()->SendShowBank(player->GetGUID());
}

void sServerMenu::OpenMailSlot(Player* player) {
    player->PlayerTalkClass->SendCloseGossip();
	player->GetSession()->SendShowMailBox(player->GetGUID());
}

std::string sServerMenu::ConfirmChangeRFN(Player* player) {
    std::stringstream ss;
    if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        ss << "\nНужно заплатить: ";
    else
        ss << "\nNeed to pay: ";
    return ss.str();
}

void sServerMenu::ChangeRFN(Player* player, int i) {
    switch (i) {
        case GossipHelloMenu:
            player->ModifyMoney(-CHANGE_FACTION_COST);
            player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
            break;
        case GossipHelloMenu + 1:
            player->ModifyMoney(-CHANGE_RACE_COST);
            player->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
            break;
        case GossipHelloMenu + 2:
            player->ModifyMoney(-CHANGE_NICK_COST);
            player->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
            break;
        default: break;
    }
    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сделайте релог для применение действий.", "Relog to apply actions."));
    player->PlayerTalkClass->SendCloseGossip();
}

/* ################################################ ВСЕ МЕНЮ ################################################ */
bool sServerMenu::CanOpenMenu(Player* player) {
    if (player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena()
        || player->HasStealthAura() || player->isDead() || (player->getClass() == CLASS_DEATH_KNIGHT && player->GetMapId() == 609 && !player->IsGameMaster() && !player->HasSpell(50977))) {
        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сейчас это невозможно.", "Now it is impossible"));
        return true;
    }
    return false;
}

void sServerMenu::BodyMenu(Player* player, uint8 MenuId) {
    switch (MenuId) {
        case GossipHelloMenu: /* главное меню */ sServerMenuMgr->m_GossipHelloMenu(player); break;
        /* ... */
        default: m_GossipHelloMenu(player); break;
    }
}

std::string sServerMenu::HeadMenu(Player* player, uint8 MenuId) {
    std::stringstream ss;
    switch (MenuId) {
        case GossipHelloMenu + 1: {
            if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Телепортация по всему миру:\nТелепорт платный по миру, все собранные ресурсы пойдут на благополучный фонд бездомных собак.\n\n";
                ss << "|cffff0000Важно!|r Чем выше ваш ранг тем дешевле будет стоить телепортация.";
            }
            else {
                ss << "Teleportation around the world:\nTeleport paid worldwide, all collected resources will go to a safe foundation of stray dogs.\n\n";
                ss << "|cffff0000Important!|r The higher your rank, the cheaper it will be to teleport.";
            }
        } break;
        // case GossipHelloMenu + 2: {
        //     if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
        //         ss << "Приветствую вас, " << player->GetName() << "\n\n";
        //         ss << "У вас " << player->GetRankByExp() << " ранг (" << player->GetPvPRank() << " опыта)\n";
        //         ss << "До следующего ранга осталось " << player->PointsUntilNextRank() << " опыта";
        //     }
        //     else {
        //         ss << "Greetings, " << player->GetName() << "\n\n";
        //         ss << "You have " << player->GetRankByExp() << " rank (" << player->GetPvPRank() << " experience)\n";
        //         ss << "Until the next rank remains " << player->PointsUntilNextRank() << " experience.";
        //     }
        // } break;
        case GossipHelloMenu + 3: {
            if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "Что входит в Премиум аккаунт ?\n";
                ss << "   * Опыт для ранга X2\n   * Опыт для репутации X2\n   * Опыт очков чести X2\n";
                ss << "А так же,\n   * Возможность снять дезертир\n   * Возможность снять слабость\n   * Возможность получить бафы всех классов\n\n";
                ss << "Стоимость Премиум услуг в день " << VIP_COST_DAY << " бонусов (минимальное количество дней " << MIN_VIP_DAY << ")";
            }
            else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "What is included in the Premium account ?\n";
                ss << "   * Experience to rank X2\n   * Experience for reputation X2\n   * Honor Points X2\n";
                ss << "As well as,\n   * Ability to remove a deserter\n   * The ability to relieve weakness\n   * The ability to get buffs of all classes\n\n";
                ss << "Premium service cost per day " << VIP_COST_DAY << " bonuses (minimum number of days " << MIN_VIP_DAY << ")";
            }
        } break;
        case GossipHelloMenu + 4: {
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
    return ss.str();
}

/* ################ главное меню ################ */

void sServerMenu::m_GossipHelloMenu(Player* player) {
    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_1, EN_HOME_MENU_1), GOSSIP_SENDER_MAIN, GossipHelloMenu + 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_2, EN_HOME_MENU_2), GOSSIP_SENDER_MAIN, GossipHelloMenu + 2);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_3, EN_HOME_MENU_3), GOSSIP_SENDER_MAIN, GossipHelloMenu + 3);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_4, EN_HOME_MENU_4), GOSSIP_SENDER_MAIN, GossipHelloMenu + 4);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_5, EN_HOME_MENU_5), GOSSIP_SENDER_MAIN, GossipHelloMenu + 5);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_6, EN_HOME_MENU_6), GOSSIP_SENDER_MAIN, GossipHelloMenu + 6);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_7, EN_HOME_MENU_7), GOSSIP_SENDER_MAIN, GossipHelloMenu + 7);
    player->PlayerTalkClass->GetGossipMenu().SetMenuId(GossipHelloMenu);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, GossipHelloMenu), player->GetGUID());
}