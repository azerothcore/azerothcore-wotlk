#include "ScriptPCH.h"

#define MSG_GOSSIP_TEXT_GETTING_STARTED "Приветствую! Я могу обменять твои вещи на [Монета-Donate] в том же количестве."

class Exchanger_NPC : public CreatureScript
{
public:
    Exchanger_NPC() : CreatureScript("Exchanger_NPC") { }

    bool OnGossipHello(Player *player, Creature *_creature)
	{
        std::string name = player->GetName();
        std::ostringstream info;

        ClearGossipMenuFor(player);
        info << "Приветствую, " << name << "\nЯ могу обменять твои вещи на [Монета-Donate] в том же количестве.\n" << "Стоимость обмена: |cff065961[Монета-Donate]x100|r\n" ;

        AddGossipItemFor(player,5, "|TInterface/ICONS/Inv_misc_coin_01:25:25:-20:0|tПерейти к обмену", GOSSIP_SENDER_MAIN, 777);
        AddGossipItemFor(player, GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:25:25:-20:0|tВыйти", GOSSIP_SENDER_MAIN, 444);
        player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), _creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 uiAction)
    {
        std::string name = player->GetName();
        std::ostringstream info;
        info << "Выберите вещь для обмена.\n" << "Стоимость обмена: |cff065961[Монета-Donate]x100|r\n";

        if (sender == GOSSIP_SENDER_MAIN && player->HasItemCount(90033, 100, false))
        {
            player->PlayerTalkClass->ClearMenus();
            switch (uiAction)
            {
            case 777: /* Обмен */
            {
                ClearGossipMenuFor(player);
                AddGossipItemFor(player, 5, "[Сумки]", GOSSIP_SENDER_MAIN, 150);
                AddGossipItemFor(player, 5, "[Пылающие Крылья] ", GOSSIP_SENDER_MAIN, 21);
                AddGossipItemFor(player, 5, "[Оружие]", GOSSIP_SENDER_MAIN, 149);
                AddGossipItemFor(player, 5, "[Прочее]", GOSSIP_SENDER_MAIN, 148);
                player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), _creature->GetGUID());
            }
            break;
            case 148:
                player->PlayerTalkClass->ClearMenus();
                AddGossipItemFor(player, 5, "[Ultimate Trinket Сила] х1", GOSSIP_SENDER_MAIN, 1, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Ultimate Trinket Ловкость] х1", GOSSIP_SENDER_MAIN, 2, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Ultimate Trinket Интеллект] х1", GOSSIP_SENDER_MAIN, 3, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Trinket Сила] х1", GOSSIP_SENDER_MAIN, 4, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Trinket Ловкость] х1", GOSSIP_SENDER_MAIN, 5, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Trinket Интеллект] х1", GOSSIP_SENDER_MAIN, 6, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme-Ring DD] х1", GOSSIP_SENDER_MAIN, 16, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme-Ring SPD] х1", GOSSIP_SENDER_MAIN, 17, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Накидка Сила] х1", GOSSIP_SENDER_MAIN, 22, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Накидка Ловкость] х1", GOSSIP_SENDER_MAIN, 23, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Накидка Интеллект] х1", GOSSIP_SENDER_MAIN, 24, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Рубашка Сила] х1", GOSSIP_SENDER_MAIN, 27, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Рубашка Ловкость] х1", GOSSIP_SENDER_MAIN, 28, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Рубашка Интеллект] х1", GOSSIP_SENDER_MAIN, 29, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Neck Сила] х1", GOSSIP_SENDER_MAIN, 50, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Neck Ловкость] х1", GOSSIP_SENDER_MAIN, 51, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Neck Интеллект] х1", GOSSIP_SENDER_MAIN, 52, "Вы уверены?", 0, false);
                player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), _creature->GetGUID());
                break;
            case 149:
                player->PlayerTalkClass->ClearMenus();
                AddGossipItemFor(player, 5, "[Unique Shield] х1", GOSSIP_SENDER_MAIN, 18, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Unique Battleaxe] х1", GOSSIP_SENDER_MAIN, 19, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Battleaxe] х1", GOSSIP_SENDER_MAIN, 57, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Unique Sword] Скорость: 1.80", GOSSIP_SENDER_MAIN, 53, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Unique Sword] Скорость: 3.00", GOSSIP_SENDER_MAIN, 20, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Unique Sword One-Hand]", GOSSIP_SENDER_MAIN, 54, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Sword] Скорость: 2.10", GOSSIP_SENDER_MAIN, 55, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Sword] Скорость: 3.00", GOSSIP_SENDER_MAIN, 26, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Sword One-Hand]", GOSSIP_SENDER_MAIN, 56, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Dagger] х1", GOSSIP_SENDER_MAIN, 40, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Unique Wand] х1", GOSSIP_SENDER_MAIN, 25, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Bow] х1", GOSSIP_SENDER_MAIN, 58, "Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Unique Bow] х1", GOSSIP_SENDER_MAIN, 59, "Вы уверены?", 0, false);
                player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), _creature->GetGUID());
                break;
            case 150:
                player->PlayerTalkClass->ClearMenus();
                AddGossipItemFor(player, 5, "[Ultimate Сумка Сила] х1", GOSSIP_SENDER_MAIN, 7, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Ultimate Сумка Ловкость] х1", GOSSIP_SENDER_MAIN, 8, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Ultimate Сумка Интеллект] х1", GOSSIP_SENDER_MAIN, 9, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Сумка Сила] х1", GOSSIP_SENDER_MAIN, 10, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Сумка Ловкость] х1", GOSSIP_SENDER_MAIN, 11, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Extreme Сумка Интеллект] х1", GOSSIP_SENDER_MAIN, 12, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Mega Сумка Сила] х1", GOSSIP_SENDER_MAIN, 13, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Mega Сумка Ловкость] х1", GOSSIP_SENDER_MAIN, 14, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Mega Сумка Интеллект] х1", GOSSIP_SENDER_MAIN, 15, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Mega Сумка Скорость-Сила] х1", GOSSIP_SENDER_MAIN, 155, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Mega Сумка Скорость-Ловкость] х1", GOSSIP_SENDER_MAIN, 156, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                AddGossipItemFor(player, 5, "[Mega Сумка Скорость-Интеллект] х1", GOSSIP_SENDER_MAIN, 157, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
                player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), _creature->GetGUID());
                break;
            case 59:
                if (player->HasItemCount(500034, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500034, 1, true, false);
                    player->AddItem(90033, 7000);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 58:
                if (player->HasItemCount(500033, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500033, 1, true, false);
                    player->AddItem(90033, 3500);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 57:
                if (player->HasItemCount(500039, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500039, 1, true, false);
                    player->AddItem(90033, 3500);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 53:
                if (player->HasItemCount(500035, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500035, 1, true, false);
                    player->AddItem(90033, 7000);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 54:
                if (player->HasItemCount(500038, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500038, 1, true, false);
                    player->AddItem(90033, 7000);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 55:
                if (player->HasItemCount(500036, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500036, 1, true, false);
                    player->AddItem(90033, 3500);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 56:
                if (player->HasItemCount(500037, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500037, 1, true, false);
                    player->AddItem(90033, 3500);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 50:
                if (player->HasItemCount(90250, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(90250, 1, true, false);
                    player->AddItem(90033, 2500);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 51:
                if (player->HasItemCount(90251, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(90251, 1, true, false);
                    player->AddItem(90033, 2500);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 52:
                if (player->HasItemCount(90252, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(90252, 1, true, false);
                    player->AddItem(90033, 2500);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 155:
                if (player->HasItemCount(500062, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500062, 1, true, false);
                    player->AddItem(90033, 5000);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 156:
                if (player->HasItemCount(500063, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500063, 1, true, false);
                    player->AddItem(90033, 5000);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 157:
                if (player->HasItemCount(500064, 1, false))
                {
                    CloseGossipMenuFor(player);
                    player->DestroyItemCount(90033, 100, true, false);
                    player->DestroyItemCount(500064, 1, true, false);
                    player->AddItem(90033, 5000);
                    _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                    return false;
                }
                break;
            case 444:
                CloseGossipMenuFor(player);
                break;
                    case 1:
                        if (player->HasItemCount(500000, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500000, 1, true, false);
                            player->AddItem(90033, 1500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 2:
                        if (player->HasItemCount(500001, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500001, 1, true, false);
                            player->AddItem(90033, 1500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 3:
                        if (player->HasItemCount(500002, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500002, 1, true, false);
                            player->AddItem(90033, 1500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;

                    case 4:
                        if (player->HasItemCount(500003, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500003, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 5:
                        if (player->HasItemCount(5000011, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(5000011, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 6:
                        if (player->HasItemCount(500004, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500004, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 7:
                        if (player->HasItemCount(500055, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500055, 1, true, false);
                            player->AddItem(90033, 1500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 8:
                        if (player->HasItemCount(500056, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500056, 1, true, false);
                            player->AddItem(90033, 1500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 9:
                        if (player->HasItemCount(500057, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500057, 1, true, false);
                            player->AddItem(90033, 1500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 10:
                        if (player->HasItemCount(500005, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500005, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 11:
                        if (player->HasItemCount(500006, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500006, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 12:
                        if (player->HasItemCount(500007, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500007, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 13:
                        if (player->HasItemCount(500058, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500058, 1, true, false);
                            player->AddItem(90033, 5000);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 14:
                        if (player->HasItemCount(500059, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500059, 1, true, false);
                            player->AddItem(90033, 5000);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 15:
                        if (player->HasItemCount(500060, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500060, 1, true, false);
                            player->AddItem(90033, 5000);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 16:
                        if (player->HasItemCount(90203, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(90203, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 17:
                        if (player->HasItemCount(90202, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(90202, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 18:
                        if (player->HasItemCount(500020, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500020, 1, true, false);
                            player->AddItem(90033, 7000);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 19:
                        if (player->HasItemCount(27490, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(27490, 1, true, false);
                            player->AddItem(90033, 7000);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 20:
                        if (player->HasItemCount(500008, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500008, 1, true, false);
                            player->AddItem(90033, 7000);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 21:
                        player->PlayerTalkClass->ClearMenus();
                        AddGossipItemFor(player, 5, "[Воин] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 30, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Паладин] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 31, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Рыцарь Смерти] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 32, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Охотник] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 33, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Шаман] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 34, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Разбойник] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 35, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Друид] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 36, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Маг] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 37, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Жрец] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 38, "Вы уверены?", 0, false);
                        AddGossipItemFor(player, 5, "[Чернокнижник] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 39, "Вы уверены?", 0, false);
                        SendGossipMenuFor(player, 200037, _creature->GetGUID());
                        break;
                    case 30:
                        if (player->HasItemCount(500010, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500010, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 31:
                        if (player->HasItemCount(500011, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500011, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 32:
                        if (player->HasItemCount(500012, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500012, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 33:
                        if (player->HasItemCount(500013, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500013, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 34:
                        if (player->HasItemCount(500014, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500014, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 35:
                        if (player->HasItemCount(500015, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500015, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 36:
                        if (player->HasItemCount(500016, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500016, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 37:
                        if (player->HasItemCount(500017, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500017, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 38:
                        if (player->HasItemCount(500018, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500018, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 39:
                        if (player->HasItemCount(500019, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500019, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 22:
                        if (player->HasItemCount(500024, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500024, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 23:
                        if (player->HasItemCount(500025, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500025, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 24:
                        if (player->HasItemCount(500026, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500026, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 25:
                        if (player->HasItemCount(500030, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500030, 1, true, false);
                            player->AddItem(90033, 7000);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 26:
                        if (player->HasItemCount(500031, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500031, 1, true, false);
                            player->AddItem(90033, 3500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 40:
                        if (player->HasItemCount(500032, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500032, 1, true, false);
                            player->AddItem(90033, 3500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 27:
                        if (player->HasItemCount(500027, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500027, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 28:
                        if (player->HasItemCount(500028, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500028, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    case 29:
                        if (player->HasItemCount(500029, 1, false))
                        {
                            CloseGossipMenuFor(player);
                            player->DestroyItemCount(90033, 100, true, false);
                            player->DestroyItemCount(500029, 1, true, false);
                            player->AddItem(90033, 2500);
                            _creature->Whisper("Вы совершили обмен!", LANG_UNIVERSAL, player);
                        }
                        else
                        {
                            CloseGossipMenuFor(player);
                            _creature->Whisper("Вы не владеете этой вещью!", LANG_UNIVERSAL, player);
                            return false;
                        }
                        break;
                    }
                }
                else
                {
                    CloseGossipMenuFor(player);
                    _creature->Whisper("Необходимо [Монета-Donate]x100 для совершения обмена.", LANG_UNIVERSAL, player);
                    return false;
                }
            }
};

void AddSC_Exchanger_NPC()
{
    new Exchanger_NPC();
}
