#include "ScriptPCH.h"

#define MSG_GOSSIP_TEXT_GETTING_STARTED "Приветствую! Я могу обменять твои вещи на [Монета-Donate] в том же количестве."

class Exchanger_NPC : public CreatureScript
{
public:
    Exchanger_NPC() : CreatureScript("Exchanger_NPC") { }

    bool OnGossipHello(Player *player, Creature *_creature)
	{
		if (player->IsInCombat())
        {
            CloseGossipMenuFor(player);
            _creature->Whisper("Выйдите из боя, чтобы продолжить!", LANG_UNIVERSAL, player);
            return true;
        }
        else
    {
			_creature->Whisper(MSG_GOSSIP_TEXT_GETTING_STARTED, LANG_UNIVERSAL, player);
			AddGossipItemFor(player,5, "[Ultimate Trinket Сила] х1", GOSSIP_SENDER_MAIN, 1, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Ultimate Trinket Ловкость] х1", GOSSIP_SENDER_MAIN, 2, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Ultimate Trinket Интеллект] х1", GOSSIP_SENDER_MAIN, 3, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Trinket Сила] х1", GOSSIP_SENDER_MAIN, 4, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Trinket Ловкость] х1", GOSSIP_SENDER_MAIN, 5, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Trinket Интеллект] х1", GOSSIP_SENDER_MAIN, 6, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Ultimate Сумка Сила] х1", GOSSIP_SENDER_MAIN, 7, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Ultimate Сумка Ловкость] х1", GOSSIP_SENDER_MAIN, 8, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Ultimate Сумка Интеллект] х1", GOSSIP_SENDER_MAIN, 9, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Сумка Сила] х1", GOSSIP_SENDER_MAIN, 10, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Сумка Ловкость] х1", GOSSIP_SENDER_MAIN, 11, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Сумка Интеллект] х1", GOSSIP_SENDER_MAIN, 12, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Mega Сумка Сила] х1", GOSSIP_SENDER_MAIN, 13, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Mega Сумка Ловкость] х1", GOSSIP_SENDER_MAIN, 14, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Mega Сумка Интеллект] х1", GOSSIP_SENDER_MAIN, 15, "Все вещи из сумки пропадут!!! Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme-Ring DD] х1", GOSSIP_SENDER_MAIN, 16, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme-Ring SPD] х1", GOSSIP_SENDER_MAIN, 17, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Unique Shield] х1", GOSSIP_SENDER_MAIN, 18, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Unique Battleaxe] х1", GOSSIP_SENDER_MAIN, 19, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Unique Sword] х1", GOSSIP_SENDER_MAIN, 20, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Sword] х1", GOSSIP_SENDER_MAIN, 26, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Unique Wand] х1", GOSSIP_SENDER_MAIN, 25, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Накидка Сила] х1", GOSSIP_SENDER_MAIN, 22, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Накидка Ловкость] х1", GOSSIP_SENDER_MAIN, 23, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Накидка Интеллект] х1", GOSSIP_SENDER_MAIN, 24, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Рубашка Сила] х1", GOSSIP_SENDER_MAIN, 27, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Рубашка Ловкость] х1", GOSSIP_SENDER_MAIN, 28, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Extreme Рубашка Интеллект] х1", GOSSIP_SENDER_MAIN, 29, "Вы уверены?", 0, false);
			AddGossipItemFor(player,5, "[Пылающие Крылья] х1", GOSSIP_SENDER_MAIN, 21);
        }

        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());         
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 uiAction)
    {
        if (sender == GOSSIP_SENDER_MAIN)
        {
            player->PlayerTalkClass->ClearMenus();
            switch(uiAction)
            {          
            case 1: 
                if (player->HasItemCount(500000, 1, false ))
                {
                    CloseGossipMenuFor(player);
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
					player->DestroyItemCount(500001, 1, true, false);
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
            case 3: 
				if (player->HasItemCount(500002, 1, false))
				{
					CloseGossipMenuFor(player);
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
				AddGossipItemFor(player,5, "[Воин] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 30, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Паладин] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 31, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Рыцарь Смерти] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 32, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Охотник] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 33, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Шаман] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 34, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Разбойник] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 35, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Друид] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 36, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Маг] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 37, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Жрец] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 38, "Вы уверены?", 0, false);
				AddGossipItemFor(player,5, "[Чернокнижник] х1-> 2500 Монет", GOSSIP_SENDER_MAIN, 39, "Вы уверены?", 0, false);
				SendGossipMenuFor(player, 200037, _creature->GetGUID());
				break;
			case 30:
				if (player->HasItemCount(500010, 1, false))
				{
					CloseGossipMenuFor(player);
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
			case 27:
				if (player->HasItemCount(500027, 1, false))
				{
					CloseGossipMenuFor(player);
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
        return true;
    } 
};

void AddSC_Exchanger_NPC()
{
    new Exchanger_NPC();
}
