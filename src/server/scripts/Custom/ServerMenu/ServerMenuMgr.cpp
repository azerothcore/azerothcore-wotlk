#include "ServerMenuMgr.h"
#include "DeathMatch.h"
#include "Player.h"
#include "Chat.h"
#include "Translate.h"
#include <time.h>

using namespace Acore::ChatCommands;

void sServerMenu::OpenBankSlot(Player* player) 
{
    if (!player)
        return;

    player->PlayerTalkClass->SendCloseGossip();
	player->GetSession()->SendShowBank(player->GetGUID());
}

void sServerMenu::OpenMailSlot(Player* player) 
{
    if (!player)
        return;

    player->PlayerTalkClass->SendCloseGossip();
	player->GetSession()->SendShowMailBox(player->GetGUID());
}

std::string sServerMenu::ConfirmChangeRFN(Player* player, uint32 cost) 
{
    if (!player)
        return "Cбой системы...";

    std::ostringstream ss;
    if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        ss << "\nНужно заплатить: " << cost << " бонусов. Продолжим ?";
    else
        ss << "\nNeed to pay: " << cost << " bonuses. Continue ?";
    return ss.str().c_str();
}

void sServerMenu::ChangeRFN(Player* player, int i) 
{   
    if (!player)
        return;

    uint32 bonuses = player->GetSession()->GetBonuses();

    switch (i) {
        case 0:
            if (bonuses >= sServerMenuMgr->getFactionCost()) {
                player->GetSession()->SetBonuses(uint32(bonuses - sServerMenuMgr->getFactionCost()));
                player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
                ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, "Сделайте релог для применение действий.", "Relog to apply actions."));
            } else {
                ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player,RU_NO_BONUS_HAVE, EN_NO_BONUS_HAVE), sServerMenuMgr->getFactionCost());
            }
            break;
        case 1:
            if (bonuses >= sServerMenuMgr->getRaceCost()) {
                player->GetSession()->SetBonuses(uint32(bonuses - sServerMenuMgr->getRaceCost()));
                player->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
                ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, "Сделайте релог для применение действий.", "Relog to apply actions."));
            } else {
                ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player,RU_NO_BONUS_HAVE, EN_NO_BONUS_HAVE), sServerMenuMgr->getRaceCost());
            }
            break;
        case 2:
            if (bonuses >= sServerMenuMgr->getNickCost()) {
                player->GetSession()->SetBonuses(uint32(bonuses - sServerMenuMgr->getNickCost()));
                player->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
                ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, "Сделайте релог для применение действий.", "Relog to apply actions."));
            } else {
                ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player,RU_NO_BONUS_HAVE, EN_NO_BONUS_HAVE), sServerMenuMgr->getNickCost());
            }
            break;
        default: break;
    }
    player->PlayerTalkClass->SendCloseGossip();
}

void sServerMenu::CharControlMenu(Player* player) {
    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_CHAR_CONTROL_1, EN_CHAR_CONTROL_1), GOSSIP_SENDER_MAIN + 1, 0);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_CHAR_CONTROL_2, EN_CHAR_CONTROL_2), GOSSIP_SENDER_MAIN + 1, 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_CHAR_CONTROL_3, EN_CHAR_CONTROL_3), GOSSIP_SENDER_MAIN + 1, 5);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_CHAR_CONTROL_7, EN_CHAR_CONTROL_7), GOSSIP_SENDER_MAIN + 1, 6);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HONOR_EXCHANGE_MAIN, EN_HONOR_EXCHANGE_MAIN), GOSSIP_SENDER_MAIN + 1, 7);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_ARENA_EXCHANGE_MAIN, EN_ARENA_EXCHANGE_MAIN), GOSSIP_SENDER_MAIN + 1, 11);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_TOKEN_EXCHANGE_MAIN, EN_TOKEN_EXCHANGE_MAIN), GOSSIP_SENDER_MAIN + 1, 9);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_RESET_INSTANCE_CD, EN_RESET_INSTANCE_CD), GOSSIP_SENDER_MAIN + 1, 8);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_REPAIR_EQUIPMENT, EN_REPAIR_EQUIPMENT), GOSSIP_SENDER_MAIN + 1, 10);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_back_CHAR, EN_back_CHAR), GOSSIP_SENDER_MAIN, 0);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 1), player->GetGUID());
}

void sServerMenu::AccControlMenu(Player* player) {
    static std::stringstream ss;
    ss.str("");
    const char* broadcastText = player->GetSession()->GetAutobroadcast() ?
        (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? RU_ACC_CONTROL_BROADCAST_ON : EN_ACC_CONTROL_BROADCAST_ON) :
        (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? RU_ACC_CONTROL_BROADCAST_OFF : EN_ACC_CONTROL_BROADCAST_OFF);
    ss << (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? RU_ACC_CONTROL_BROADCAST : EN_ACC_CONTROL_BROADCAST) << broadcastText;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ss.str().c_str(), GOSSIP_SENDER_MAIN + 18, 0);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, "Назад", "Back"), GOSSIP_SENDER_MAIN, 0);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 8), player->GetGUID());
}

void sServerMenu::SetBroadcastControl(Player* player) {

    uint32 accountId = player->GetSession()->GetAccountId();

    if (!accountId)
        return;

    player->GetSession()->SetAutobroadcast(!player->GetSession()->GetAutobroadcast());
    sServerMenuMgr->AccControlMenu(player);
}

std::string sServerMenu::HeadMenu(Player* player, uint8 MenuId) 
{
    if (!player)
        return "Сбой системы...";

    std::ostringstream ss;
    switch (MenuId) {
        case 0: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "На вашем аккаунте " << player->GetSession()->GetBonuses() << " бонусов.\n";
                ss << "Пополнить счёт: wow-idk.ru\n\n";
                if (player->GetSession()->IsPremium())
                    ss << "Ваш премиум статус |cff156B06активирован|r.";
                else {
                    ss << "Ваш премиум статус |cffff0000не активирован|r.\n";
                    ss << "Можно приобрести в разделе премиум аккаунт";
                }
            }
            else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "You have " << player->GetSession()->GetBonuses() << "bonuses in your account";
                ss << "Top up account wow-idk.ru\n\n";
                if (player->GetSession()->IsPremium())
                    ss << "Your premium status|cff156B06activated|r.";
                else {
                    ss << "Your premium status |cffff0000not activated|r.\n";
                    ss << "Can be purchased in the section premium account";
                } 
            }
        } break;
        case 1: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "Позволяет вам обменивать очки чести на опыт, удалять сохраненные подземелья, отремонтировать предметы,";
                ss << "обменивать эмблемы, использовать банк и почту, а также управлять их профессиями.";
                ss << "Этот интерфейс поможет вам легко управлять различными аспектами из игрового процесса и облегчить вашу игру.\n";
            } else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "Allows you to exchange honor points for experience, delete saved dungeons, repair items, trade emblems, use the bank and mail, and manage their professions. This interface will help you easily manage various aspects of the gameplay and make your game easier.\n";
            }
        } break;
        case 2: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "У вас " << player->GetHonorPoints() << " очков чести.\n\n";
                ss << "В данном разделе вы можете передать любому игроку на этом проекте часть или весь ваш хонор.\n";
                ss << "Для этого вам нужно получить [5 ранг] а потом уже выбрать количество которое хотите передать и указать ник игрока.\n";
            } else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "You have " << player->GetHonorPoints() << " honor points.\n\n";
                ss << "In this section, you can transfer part or all of your honor to any player on this project.\n";
                ss << "To do this, you need to get [5 Rank] and then select the amount you want to transfer and indicate the player's nickname.\n";
            }
        } break;

        case 3: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "У вас " << player->GetHonorPoints() << " очков чести.\n\n";
                ss << "В данном разделе вы можете обменять очки чести на опыт для ранга.\n\n";
                ss << "Каждый ваш ранг снижает цену на обмен на 100 очков чести.";
            } else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "You have " << player->GetHonorPoints() << " honor points.\n\n";
                ss << "In this section, you can exchange honor points for experience for a rank.\n\n";
                ss << "Each of your ranks reduces the exchange price for 100 honor points.";
            }
        } break;

        case 4: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "В данном разделе вы можете обменять эмблемы льда и триумфа на осколки каменного хранителя.\n";
                ss << "\nУ вас:\n\n  " << DeathMatchMgr->GetItemIcon(49426, 16, 16, 0, -4) << " эмблем льда x" << player->GetItemCount(49426, true) << "\n\n";
                ss << "  " << DeathMatchMgr->GetItemIcon(47241, 16, 16, 0, -4) << " эмблем триумфа x" << player->GetItemCount(47241, true) << "\n\n";
                ss << "  " << DeathMatchMgr->GetItemIcon(43228, 16, 16, 0, -4) << " осколков каменного хранителя x" << player->GetItemCount(43228, true);
            } else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "In this section, you can exchange emblems of ice and triumph for shards of the stone guardian.\n";
                ss << "\nYou have:\n\n  " << DeathMatchMgr->GetItemIcon(49426, 16, 16, 0, -4) << " emblems of frost x" << player->GetItemCount(49426, true) << "\n\n";
                ss << "  " << DeathMatchMgr->GetItemIcon(47241, 16, 16, 0, -4) << " emblems of triumf x" << player->GetItemCount(47241, true) << "\n\n";
                ss << "  " << DeathMatchMgr->GetItemIcon(43228, 16, 16, 0, -4) << " shards of the stone guardian x" << player->GetItemCount(43228, true);
            }
        } break; 

        case 5: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "Что входит в Премиум аккаунт ?\n";
                ss << "   * Опыт для ранга X2\n   * Очки арены за победу/поражение X2\n   * Очки чести X2\n   * Кап арены X2\n";
                ss << "   * Возможность снять дезертир\n   * Возможность снять слабость\n   * Получить бафы\n   * Каждый ранг дает бонус в инстах\n\n";
                ss << "Цена на премиум аккаунт 350 бонусов на 7 дней.";
            }
            else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "What is included in the Premium account ?\n";
                ss << "   * Experience to rank X2\n   * Arena points for victory/defeat X2\n   * Honor Points X2\n   * Кап арены X2\n";
                ss << "   * Ability to remove a deserter\n   * The ability to relieve weakness\n   * Buffs\n   * Each rank gives a bonus in dungeons\n\n";
                ss << "Premium service cost 350 bonuses for 7 days.\n";
            }
        } break;

        case 6: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "Каждый ранг дает вам 5% бонусов к награде.\n";
                ss << "Выберите вашу награду за ивент:\n";
            } else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "Each rank gives you 5% reward bonuses.\n";
                ss << "Select your event reward:\n";
            }
        } break;

        case 7: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "У вас " << player->GetHonorPoints() << " очков чести и \n";
                ss << "         " << player->GetArenaPoints() << " очков арены.\n\n";
                ss << "В данном разделе вы можете обменять очки чести на очки арены.\n\n";
                ss << "Обменный курс 1000 чести = 1 арена.";
            } else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "You have " << player->GetHonorPoints() << " honor points and \n";
                ss << "         " << player->GetArenaPoints() << " arena points.\n\n";
                ss << "In this section, you can exchange honor points for experience for arena points.\n\n";
                ss << "Exchange rate 1000 honor = 1 arena.";
            }
        } break;              

        case 8: {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
                ss << "Приветствую вас, " << player->GetName() << "\n\n";
                ss << "Это интуитивный интерфейс, который дает вам полный доступ к настройкам вашего аккаунта. Здесь вы можете настроить ваш профиль, управлять паролем и безопасностью, отслеживать свои транзакции и многое другое. Этот раздел предлагает вам полный контроль над вашим аккаунтом и позволяет настраивать его так, как вам нравится, сделав вашу игру более комфортной и приятной.\n";
            } else {
                ss << "Greetings, " << player->GetName() << "\n\n";
                ss << "Is an intuitive interface that gives you full access to your account settings. Here you can customize your profile, manage your password and security, track your transactions and much more. This section offers you complete control over your account and allows you to customize it as you wish, making your game more comfortable and pleasant.";
            }
        } break;

        default: break;
    }
    return ss.str().c_str();
}

void sServerMenu::GossipHelloMenu(Player* player) 
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HOME_MENU_1, EN_HOME_MENU_1), GOSSIP_SENDER_MAIN, 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HOME_MENU_2, EN_HOME_MENU_2), GOSSIP_SENDER_MAIN, 2);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HOME_MENU_3, EN_HOME_MENU_3), GOSSIP_SENDER_MAIN, 3);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HOME_MENU_4, EN_HOME_MENU_4), GOSSIP_SENDER_MAIN, 4);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HOME_MENU_5, EN_HOME_MENU_5), GOSSIP_SENDER_MAIN, 5);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HOME_MENU_6, EN_HOME_MENU_6), GOSSIP_SENDER_MAIN, 6);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HOME_MENU_7, EN_HOME_MENU_7), GOSSIP_SENDER_MAIN, 7);
    player->PlayerTalkClass->GetGossipMenu().SetMenuId(UNIQUE_MENU_ID);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 0), player->GetGUID());
}

void sServerMenu::GossipMenuExchangeHonor(Player* player)
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorRang(player, 7500, 50, 1), GOSSIP_SENDER_MAIN + 7, 50);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorRang(player, 15000, 100, 2), GOSSIP_SENDER_MAIN + 7, 100);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorRang(player, 37500, 250, 5), GOSSIP_SENDER_MAIN + 7, 250);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorRang(player, 75000, 500, 10), GOSSIP_SENDER_MAIN + 7, 500);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorRang(player, 187500, 1250, 25), GOSSIP_SENDER_MAIN + 7, 1250);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, "Назад", "Back"), GOSSIP_SENDER_MAIN, 5);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 3), player->GetGUID());    
}

// Обмен очки чести на очки арены
void sServerMenu::GossipMenuExchangeArena(Player* player) 
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorToArena(player, 10000), GOSSIP_SENDER_MAIN + 17, 10);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorToArena(player, 50000), GOSSIP_SENDER_MAIN + 17, 50);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorToArena(player, 200000), GOSSIP_SENDER_MAIN + 17, 200);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterHonorToArena(player, 1000000), GOSSIP_SENDER_MAIN + 17, 1000);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, "Назад", "Back"), GOSSIP_SENDER_MAIN, 5);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 7), player->GetGUID());  
}

std::string sServerMenu::ConverterHonorToArena(Player* player, uint32 honor) 
{   
    if (!player || !honor)
        return "Сбой системы...";

    std::stringstream ss;
    uint32 need = honor/1000;
    if (need <= 0)
        return "error";

    if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
        ss << "Обменять " << honor << " очков чести на\n    |cff473B32" << need << " очков арены.|r";
    } else {
        ss << "Exchange " << honor << " honor points for\n  |cff473B32" << need << " arena points.|r";
    }
    return ss.str();
}

void sServerMenu::ConfirmExchangeHonorForArena(Player* player, uint32 arena) 
{
    if (!player || !arena)
        return;

    uint32 total = arena*1000;

    if (total <= 0)
        return;

    if (player->GetHonorPoints() >= total) {
        // снимает у игрока очки чести 
        player->ModifyHonorPoints(-uint32(total));
        player->ModifyArenaPoints(arena);
        return sServerMenuMgr->GossipMenuExchangeArena(player);
    } else {
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_HONOR_EXCHANGE_FAIL, EN_HONOR_EXCHANGE_FAIL));
        return sServerMenuMgr->GossipMenuExchangeArena(player);
    }
}

std::string sServerMenu::ConverterHonorRang(Player* player, uint32 honor, uint32 exp, uint8 count) 
{   
    if (!player || !honor || !exp)
        return "Сбой системы...";

    std::stringstream ss;
    uint32 need = sServerMenuMgr->CalculHonorForExp(player, honor, count);
    if (need <= 0)
        need = honor;
    if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
        ss << "Обменять " << need << " очков чести на\n    |cff473B32" << exp << " опыта для ранга.|r";
    } else {
        ss << "Exchange " << need << " honor points for\n  |cff473B32" << exp << " exp for rang.|r";
    }
    return ss.str();
}

void sServerMenu::InstanceResetCooldown(Player* player) 
{
    for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
    {
        BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(player->GetGUID(), Difficulty(i));
        for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end();)
        {
            if (itr->first != player->GetMapId())
            {
                sInstanceSaveMgr->PlayerUnbindInstance(player->GetGUID(), itr->first, Difficulty(i), true, player);
                itr = m_boundInstances.begin();
            }
            else
                ++itr;
        }
    }
    ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_RESET_INSTANCE_CD_OK, EN_RESET_INSTANCE_CD_OK));
    player->PlayerTalkClass->SendCloseGossip();
}

void sServerMenu::RepairItems(Player* player) 
{
    player->DurabilityRepairAll(false, 0, false);
    ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_REPAIR_EQUIPMENT_OK, EN_REPAIR_EQUIPMENT_OK));
    player->PlayerTalkClass->SendCloseGossip();
}

uint32 sServerMenu::CalculHonorForExp(Player* player, uint32 honor, uint8 count) 
{
    if (!player || !honor)
        return 0;

    return uint32(honor - (player->GetRankByExp() * 100 * count));
}

void sServerMenu::ConfirmExchangeHonorForExp(Player* player, uint32 honor, uint32 exp, uint32 count)
{
    if (!player || !honor || !exp)
        return;

    uint8 new_count = count == 1250 ? 25 : count == 500 ? 10 : count == 250 ? 5 : count == 100 ? 2 : 1;    

    uint32 total = sServerMenuMgr->CalculHonorForExp(player, honor, new_count);
    if (player->GetHonorPoints() >= total) {
        // снимает у игрока очки чести 
        player->ModifyHonorPoints(-uint32(total));
        player->RewardRankPoints(exp, 7 /*Обменник*/);
        return sServerMenuMgr->GossipMenuExchangeHonor(player);
    } else {
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_HONOR_EXCHANGE_FAIL, EN_HONOR_EXCHANGE_FAIL));
        return sServerMenuMgr->GossipMenuExchangeHonor(player);
    }
}

void sServerMenu::RankInfo(Player* player) 
{
    if (!player)
        return;

    player->PlayerTalkClass->ClearMenus();
    std::string name = player->GetName();
    std::ostringstream femb;

    if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
    {
        femb << "Уважаемый|cff065961 " << name << "|r\n\n"
                << "Ваш текуший ранг: |cff065961" << player->GetRankByExp() << "|r\n"
                << "У вас: |cff065961" << player->GetRankPoints() << "|r опыта\n"
                << "До следущего ранга: |cff065961" << player->PointsUntilNextRank() << "|r опыта\n\n"
                << "Ранги это вот этот значок |TInterface\\icons\\Ability_warrior_rampage:14:14:0:-1|t который отображается в дебафах.\n\n"
                << "Поднимать ранг вы можете за опыт который получите за:\n"
                << "   * Победу на арене\n   * Победу на поле боя\n   * Убийство игроков\n   * Награда за квесты\n   * Ивенты\n"
                << "У |cff065961VIP аккаунтов|r рейтинг на опыт в 2 раза больше.\n\n"
                << "Что дает ранг ?\n"
                << "На каждом ранге есть свои бонусы, чем выше ранг тем больше бонусов.\n"
                << "На каждом ранге у вас открываются секретный продавец в котором могут быть полезные вещи такие как: вещи на А9-T11, трансмогрификацию, маунты, итд...";
    }
    else
    {
        femb << "Respected|cff065961 " << name << "|r\n\n"
                << "Your current rank: |cff065961" << player->GetRankByExp() << "|r\n"
                << "You have |cff065961" << player->GetRankPoints() << "|r experience\n"
                << "To next rank: |cff065961" << player->PointsUntilNextRank() << "|r experience\n\n"
                << "Ranks this is this icon |TInterface\\icons\\Ability_warrior_rampage:14:14:0:-1|t which is displayed in debuffs.\n\n"
                << "You can raise the rank for the experience that you get for:\n"
                << "   * Victory in the arena\n   * Victory on the battlefield\n   * Kill the players\n   * Completing quests\n   * Events\n"
                << "At |cff065961VIP accounts|r experience rating is 2 times higher.\n\n"
                << "What gives the rank?\n"
                << "Each rank has its own bonuses, the higher the rank the more bonuses.\n"
                << "At each rank you will have a secret prodigy in which there may be useful things such as: А9-T11, things for transmogrification, mounts, etc.";
    }

    AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetCustomText(player, "Обновить", "Refresh"), GOSSIP_SENDER_MAIN, 2);
    AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetCustomText(player, "Назад", "Back"), GOSSIP_SENDER_MAIN, 0);
    player->PlayerTalkClass->SendGossipMenu(femb.str().c_str(), player->GetGUID());
}

void sServerMenu::CommingSoon(Player* player)
{
    if (!player)
        return;

    ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player,"Система в разработке, некоторые разделы еще не готовы.", "Система в разработке, некоторые разделы еще не готовы."));
    player->PlayerTalkClass->SendCloseGossip(); 
}

bool sServerMenu::CanOpenMenu(Player* player) 
{
    if (!player)
        return true;

    if (player->IsInCombat() || player->IsInFlight() || player->IsDeathMatch() || player->GetMap()->IsBattlegroundOrArena()
        || player->HasStealthAura() || player->isDead() || (player->getClass() == CLASS_DEATH_KNIGHT && player->GetMapId() == 609 && !player->IsGameMaster() && !player->HasSpell(50977))) {
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, "Сейчас это невозможно.", "Now it is impossible"));
        return true;
    }
    return false;
}

void sServerMenu::OpenTradeHonor(Player* player)
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HONOR_TRADE_1000, EN_HONOR_TRADE_1000), GOSSIP_SENDER_MAIN, 1000, "После подтверждение введите ник игрока", 0, true);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HONOR_TRADE_5000, EN_HONOR_TRADE_5000), GOSSIP_SENDER_MAIN, 5000, "После подтверждение введите ник игрока", 0, true);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HONOR_TRADE_10000, EN_HONOR_TRADE_10000), GOSSIP_SENDER_MAIN, 10000, "После подтверждение введите ник игрока", 0, true);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HONOR_TRADE_25000, EN_HONOR_TRADE_25000), GOSSIP_SENDER_MAIN, 25000, "После подтверждение введите ник игрока", 0, true);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_HONOR_TRADE_50000, EN_HONOR_TRADE_50000), GOSSIP_SENDER_MAIN, 50000, "После подтверждение введите ник игрока", 0, true);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_back, EN_back), GOSSIP_SENDER_MAIN, 5);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 2), player->GetGUID());
}

void sServerMenu::ExchangerToken(Player* player)
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_FROST_EXCHANGE_MENU, EN_FROST_EXCHANGE_MENU), GOSSIP_SENDER_MAIN + 8, 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_TRIUMF_EXCHANGE_MENU, EN_TRIUMF_EXCHANGE_MENU), GOSSIP_SENDER_MAIN + 8, 2);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_FROST_EXCHANGE_MENU_FAST, EN_FROST_EXCHANGE_MENU_FAST), GOSSIP_SENDER_MAIN + 1, 0, GetCustomText(player, RU_FROST_EXCHANGE_FAST_INFO, EN_FROST_EXCHANGE_FAST_INFO), 0, true);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_back, EN_back), GOSSIP_SENDER_MAIN, 5);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 4), player->GetGUID());   
}

void sServerMenu::ExchangerConfirm(Player* player, bool frost)
{
    if (!player)
        return;

    uint32 ID = frost ? 49426 : 47241;
    uint32 count = frost ? 1 : 10;

    if (player->HasItemCount(ID, count)) {
        player->DestroyItemCount(ID, count, true);
        player->AddItem(43228, 1);
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_TOKEN_EXCHANGE_SUCCESS, EN_TOKEN_EXCHANGE_SUCCESS));
    } else {
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_TOKEN_EXCHANGE_FAIL, EN_TOKEN_EXCHANGE_FAIL));
    }

    sServerMenuMgr->ExchangerToken(player);
}

void sServerMenu::ExchangeEmblemToShard(Player* player, const uint32 count)
{
    const uint32 ID = 49426;

    if (!player)
        return;

    if (!count) {
       ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_TOKEN_EXCHANGE_FAIL_ERR, EN_TOKEN_EXCHANGE_FAIL_ERR));
       sServerMenuMgr->ExchangerToken(player);
       return;
    }

    if (player->HasItemCount(ID, count)) {
        player->DestroyItemCount(ID, count, true);
        player->AddItem(43228, count);
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_TOKEN_EXCHANGE_SUCCESS, EN_TOKEN_EXCHANGE_SUCCESS));
    } else {
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_TOKEN_EXCHANGE_FAIL, EN_TOKEN_EXCHANGE_FAIL));
    }

    sServerMenuMgr->ExchangerToken(player);        
}

void sServerMenu::TradeHonorAccept(Player* player, uint32 honor, char const* name) {

    if (!player || !honor ||!name)
        return;

    if (player->GetRankByExp() < 5) {
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_glory_win_9, EN_glory_win_9), 5);
        return sServerMenuMgr->OpenTradeHonor(player); 
    }

    ObjectGuid TargetGUID;
    Player* target = ObjectAccessor::FindPlayerByName(name, false);

    // если игрок не найден
    if (!target) {
        TargetGUID = sCharacterCache->GetCharacterGuidByName(name);
        if (!TargetGUID) {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_PLAYER_NOT_FOUND);
            return sServerMenuMgr->OpenTradeHonor(player);
        }
    } else {
        TargetGUID = target->GetGUID();
    }

    // самому себе нельзя
    if (TargetGUID == player->GetGUID()) {
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, "Вы не можете отправить самому себе!", "You cannot send to yourself!"));
        return sServerMenuMgr->OpenTradeHonor(player);      
    }

    // если у сендера недостаточно хонора
    if (player->GetHonorPoints() < honor) {
        ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, "У вас недостаточно очков чести!", "You don't have enough honor points!"));
        return sServerMenuMgr->OpenTradeHonor(player);
    }

    sServerMenuMgr->SendHonorToPlayer(player, TargetGUID, honor, target ? true : false, target ? target : nullptr, name); 
}

void sServerMenu::SendHonorToPlayer(Player* sender, ObjectGuid receiver, uint32 amount, bool online, Player* Preceiver, char const* name) {

    if (!sender || !receiver || !amount)
        return;    

    // снимает у сендера очки чести 
    sender->ModifyHonorPoints(-uint32(amount));

    if (online) {
        // выдает получателю
        Preceiver->ModifyHonorPoints(amount);
        // кидаем нотификацию получателю
        ChatHandler(Preceiver->GetSession()).PSendSysMessage(GetCustomText(Preceiver, RU_HONOR_TRADE_OK_RECEIVER, EN_HONOR_TRADE_OK_RECEIVER), amount, sender->GetName());
    } else {
        // если игрок оффлайн то обновляем в базе
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_HONOR_BY_GUID);
        stmt->SetData(0, amount);
        stmt->SetData(1, receiver.GetCounter());
        CharacterDatabase.Execute(stmt);
    }

    // кидаем нотификацию отправителю
    ChatHandler(sender->GetSession()).PSendSysMessage(GetCustomText(sender, RU_HONOR_TRADE_OK_SENDER, EN_HONOR_TRADE_OK_SENDER), Preceiver ? Preceiver->GetName() : name, amount);

    // логи
    CharacterDatabasePreparedStatement* stmt_log = CharacterDatabase.GetPreparedStatement(CHAR_INS_TRANSFERT_POINTS);
    stmt_log->SetData(0, sender->GetGUID().GetCounter());
    stmt_log->SetData(1, sender->GetName());
    stmt_log->SetData(2, receiver.GetCounter());
    stmt_log->SetData(3, Preceiver ? Preceiver->GetName() : name);
    stmt_log->SetData(4, amount);
    CharacterDatabase.Execute(stmt_log);

    return sServerMenuMgr->OpenTradeHonor(sender);
}

void sServerMenu::GetVipStatus(Player* player, uint16 days) 
{
    if (!player)
        return;

    const uint32 modtime = days * 86400; // кол дней
    const uint32 login   = player->GetSession()->GetAccountId();

    /* обновляем статус без релога */
    player->GetSession()->SetPremium(true);

    LoginDatabasePreparedStatement* SETpremium = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_PREMIUM);
    SETpremium->SetData(0, login);
    SETpremium->SetData(1, modtime);
    LoginDatabase.Execute(SETpremium);

    /* маунты */
    sServerMenuMgr->VipMountLearn(player);
}

void sServerMenu::BuyVip(Player* player, uint16 days) 
{
    if (!player)
        return;

    std::stringstream NOTIFI;
    const uint32 cost = days*50;
    const uint32 bonuses = player->GetSession()->GetBonuses();
    const uint32 rest = bonuses - cost;

    if (days >= 7 && bonuses >= cost) {

        player->GetSession()->SetBonuses(rest);
        sServerMenuMgr->GetVipStatus(player, days);

        if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
            NOTIFI << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Премиум Аккаунт]: Поздравляем! Вы получили |cffffff4dпремиум|cffff9933 аккаунт на ( ";
            NOTIFI << days << " ) кол.дней.";
        }
        else {
            NOTIFI << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Premium Account]: Congratulations! You received |cffffff4dpremium|cffff9933 account for ( ";
            NOTIFI << days << " ) day(s).";
        }

        sServerMenuMgr->GetVipMenu(player);
    }
    else {
        /* минимальное количество дней */
        if (days < 7) {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
                NOTIFI << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Премиум Аккаунт]: Минимальное количество дней 7.\n";
            else
                NOTIFI << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Премиум Аккаунт]: Minimum number of days 7.\n";
            sServerMenuMgr->GetVipMenuForBuy(player);
        }

        else if (bonuses < cost) {
            if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
                NOTIFI << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Премиум Аккаунт]: У вас не хватает бонусов, нужно еще: " << cost-bonuses;
            else
                NOTIFI << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Премиум Аккаунт]: You do not have enough bonuses, you also need: " << cost-bonuses;
            sServerMenuMgr->GetVipMenuForBuy(player);
        }
    }

    ChatHandler(player->GetSession()).PSendSysMessage("%s", NOTIFI.str().c_str());
    player->GetSession()->SendAreaTriggerMessage("%s", NOTIFI.str().c_str());
}

void sServerMenu::GetVipMenuForBuy(Player* player) 
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_NOTVIP_MENU_2, EN_NOTVIP_MENU_2), GOSSIP_SENDER_MAIN + 9, 4, GetCustomText(player, RU_BUY_VIP_TEXT, EN_BUY_VIP_TEXT), 0, false);
    // AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_NOTVIP_MENU_3, EN_NOTVIP_MENU_3), GOSSIP_SENDER_MAIN + 4, GossipHelloMenu + 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_back, EN_back), GOSSIP_SENDER_MAIN, 0);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 5), player->GetGUID());
}

void sServerMenu::GetVipMenu(Player* player) 
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_VIP_MENU_1, EN_VIP_MENU_1), GOSSIP_SENDER_MAIN + 9, 1);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_VIP_MENU_2, EN_VIP_MENU_2), GOSSIP_SENDER_MAIN + 9, 2);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_VIP_MENU_3, EN_VIP_MENU_3), GOSSIP_SENDER_MAIN + 9, 3);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_back, EN_back), GOSSIP_SENDER_MAIN, 0);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player,  5), player->GetGUID());
}

void sServerMenu::RemoveAuraForVip(Player* player, bool disert)
{
    if (!player)
        return;

    player->RemoveAura(disert ? 26013 : 15007); /* слабость */ /* дизертир */
    player->PlayerTalkClass->SendCloseGossip();
}

void sServerMenu::VipSetBuff(Player* player) 
{
    if (!player)
        return;

    for (const auto& i: BuffList)
        if (!player->HasAura(i))
            player->CastSpell(player, i, true);
    player->PlayerTalkClass->SendCloseGossip();
}

void sServerMenu::VipMountLearn(Player* player)
{
    if (!player)
        return;

    const uint32 vip_buff[] = { 31700, 18991, 18992}; /* указывать ид спеллов через запятую, например:  123, 321, 5432 */
    const uint32 count_spell = 3;                     /* количесто спеллов */    

    if (player->GetSession()->IsPremium()) {
        for (uint32 i = 0; i < count_spell; i++) {
            if (!player->HasSpell(vip_buff[i]))
                player->learnSpell(vip_buff[i], false);
        }
    } else {
        for (uint32 i = 0; i < count_spell; i++) {
            if (player->HasSpell(vip_buff[i]))
                player->removeSpell(vip_buff[i], SPEC_MASK_ALL, false);
        }
    } 
}

uint32 sServerMenu::RewardEventValue(Player* player, uint32 /*entry*/, bool bigEvent, uint32 prize, int value) 
{
    if (!player)
        return 0;

    uint32 val = 0;    

    // Выдаем бонус от ранга (каждый ранг даёт 5%)
    if (value == 1) {
        // Определение большой или меленький ивент
        uint32 honor = bigEvent ? 80000 : 40000;
        // Делим в зависимости от месте на ивенте
        honor /= prize;
        uint32 bonus = honor / 20;
        val = honor + (player->GetRankByExp() * bonus);
    }
    else if (value == 2) {
        uint32 arena = bigEvent ? 300 : 150;
        arena /= prize;
        uint32 bonus = arena / 20;
        val = arena + (player->GetRankByExp() * bonus);
    }
    else { 
        uint32 exp = bigEvent ? 800 : 400;
        exp /= prize;
        uint32 bonus = exp / 20;
        val = exp + (player->GetRankByExp() * bonus);
    }

    return val;
}

void sServerMenu::GossipMenuEventReward(Player* player, uint32 entry, bool bigEvent, uint32 prize)
{
    if (!player)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterEventReward(player, entry, bigEvent, prize, 1, "очков чести"), GOSSIP_SENDER_MAIN + 10, RewardEventValue(player, entry, bigEvent, prize, 1));
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterEventReward(player, entry, bigEvent, prize, 2, "очков арены"), GOSSIP_SENDER_MAIN + 11, RewardEventValue(player, entry, bigEvent, prize, 2));
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, ConverterEventReward(player, entry, bigEvent, prize, 3, "опыта для ранга"), GOSSIP_SENDER_MAIN + 12, RewardEventValue(player, entry, bigEvent, prize, 3));
    //if (prize == 1)
    //    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Выбор предмета для трансмогрикации\n  |cff473B32Временно не доступно.|r", GOSSIP_SENDER_MAIN + 14, 4);
    player->PlayerTalkClass->SendGossipMenu(sServerMenuMgr->HeadMenu(player, 6), player->GetGUID());    
}

std::string sServerMenu::ConverterEventReward(Player* player, uint32 entry, bool bigEvent, uint32 prize, int value, std::string name) 
{   
    if (!player)
        return "Сбой системы...";

    std::stringstream ss;
    uint32 reward = RewardEventValue(player, entry, bigEvent, prize, value);

    if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
        ss << "Получить " << reward << " " << name << "\n  |cff473B32Награда за " << prize << " место.|r";
    } else {
        ss << "Get " << reward << " " << name << "\n  |cff473B32Award for " << prize << " place.|r";
    }
    return ss.str();
}

void sServerMenu::RewardEvent(Player* player, uint8 value, uint32 amount) 
{
    switch(value) {
        case 1: player->ModifyHonorPoints(uint32(amount)); break;
        case 2: player->ModifyArenaPoints(uint32(amount)); break;
        case 3: player->RewardRankPoints(uint32(amount), 8 /*Ивент*/); break;
        default: break;
    }

    ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Награда за ивент]: Вы успешно получили награду за ивент.", "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Event Reward]: You have successfully received an event reward."));

    // удаляем предмет после выбора пункта
    player->DestroyItemCount(GetItemRewardID(), 1, true);

    // логи
    CharacterDatabasePreparedStatement* stmt_log = CharacterDatabase.GetPreparedStatement(CHAR_INS_EVENT_REWARD);
    stmt_log->SetData(0, player->GetGUID().GetCounter());
    stmt_log->SetData(1, player->GetName());
    stmt_log->SetData(2, value == 1 ? amount : 0);
    stmt_log->SetData(3, value == 2 ? amount : 0);
    stmt_log->SetData(4, value == 3 ? amount : 0);
    CharacterDatabase.Execute(stmt_log);

    player->PlayerTalkClass->SendCloseGossip();  
}

bool sServerMenu::isDoubleDays() {
    time_t t = time(nullptr);
    tm* now = localtime(&t);
    return now->tm_wday == 6 || now->tm_wday == 0;
}