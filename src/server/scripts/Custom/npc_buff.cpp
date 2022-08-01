#include "ScriptPCH.h"
#include "ScriptMgr.h"
 
#define MSG_GOSSIP_TEXT_GETTING_STARTED "Приветствую, хочешь бафф? Выбирай скорее!"
 
#define MSG_ERR_HONOR "У вас не достаточно хонора для совершения покупки!"
#define MSG_ERR_MONEY "У вас не достаточно денег для совершения покупки!"
#define MSG_ERR_INCOMBAT "Вы находитесь в бою. Чтобы использовать данного Npc выйдите из него."
 
#define MSG_GOSSIP_TEXT_BUFF_POWER_WORD "[Бафнуть] Слово силы: Стойкость"
#define MSG_GOSSIP_TEXT_BUFF_BLESSING_OF_KINGS "[Бафнуть] Благословение Королей"
#define MSG_GOSSIP_TEXT_BUFF_MARK_OF_THE_WILD "[Бафнуть] Знак дикой природы"
#define MSG_GOSSIP_TEXT_BUFF_ARCANE_BRILLIANCE "[Бафнуть] Чародейская гениальность Даларана"
#define MSG_GOSSIP_TEXT_BUFF_BLESSING_OF_MIGHT "[Бафнуть] Великое Благословение могущества"
#define MSG_GOSSIP_TEXT_BUFF_BLESSING_OF_WISDOM "[Бафнуть] Благословение мудрости"
#define MSG_GOSSIP_TEXT_BUFF_DIVINE_SPIRIT "[Бафнуть] Божественный дух"
#define MSG_GOSSIP_TEXT_BUFF_SHADOW_PROTECTION "[Бафнуть] Защита от темной магии"
#define MSG_GOSSIP_TEXT_BUFF_STAMINA "[Бафнуть] Выносливость"
 
#define MSG_GOSSIP_TEXT_SUPPER_BUFF_AEGIS_OF_NELTHARION "[Бафнуть] Защита Нелтариона"
#define MSG_GOSSIP_TEXT_SUPPER_BUFF_BLESSING_ADALS "[Бафнуть] Благословение А'далла"
#define MSG_GOSSIP_TEXT_SUPPER_BUFF_CRIT_SPELLS "[Бафнуть] Критическое срабатывание"
#define MSG_GOSSIP_TEXT_SUPPER_BUFF_BLESSING_PINCHI "[Бафнуть] Благословение мистера Пинчи"
#define MSG_GOSSIP_TEXT_SUPPER_BUFF_ELUNA  "[Бафнуть] Благословение Элуны"
#define MSG_GOSSIP_TEXT_SUPPER_BUFF_WIXR  "[Бафнуть] Воздушный Вихрь"
#define MSG_GOSSIP_TEXT_SUPPER_BUFF_YKYC  "[Бафнуть] Знак Куса"
#define MSG_GOSSIP_TEXT_SUPPER_BUFF_SHPIL  "[Бафнуть] Благословение Двух Шпилей"
 
#define MSG_GOSSIP_TEXT_BUFF_MENU "|TInterface/ICONS/Achievement_dungeon_gloryofthehero:20|t [Меню Баффов - 100 золота] ->"
#define MSG_GOSSIP_TEXT_SUPER_MENU "|TInterface/ICONS/Achievement_dungeon_gloryoftheraider:20|t [Особые бафы - 500 золота] ->"
#define MSG_GOSSIP_TEXT_MAIN_MENU "<- [Вернутся в Главное меню]"
 
#define CONST_HONOR_1 1000000
#define CONST_HONOR_2 10000
#define CONST_MONEY 1000000
#define CONST_MONEY_1 5000000
 
 
class buff : public CreatureScript
{
    public:
    buff() : CreatureScript("buff") { }
 
        bool OnGossipHello(Player *player, Creature *_creature)
                {
            player->PlayerTalkClass->ClearMenus();
        _creature->Whisper(MSG_GOSSIP_TEXT_GETTING_STARTED, LANG_UNIVERSAL, player, false);
        AddGossipItemFor(player,GOSSIP_ICON_DOT, MSG_GOSSIP_TEXT_BUFF_MENU, GOSSIP_SENDER_MAIN, 2);
                AddGossipItemFor(player,GOSSIP_ICON_DOT, MSG_GOSSIP_TEXT_SUPER_MENU, GOSSIP_SENDER_MAIN, 13);
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE,_creature->GetGUID());
        return true;
        }
             
        bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 action )
                {
                  if (!player->getAttackers().empty())
        {
                _creature->Whisper(MSG_ERR_INCOMBAT, LANG_UNIVERSAL, player, false);
                CloseGossipMenuFor(player);
        return false;
                  }
    switch (action)
        {
        case 2:
        player->PlayerTalkClass->ClearMenus();
                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_POWER_WORD, GOSSIP_SENDER_MAIN, 3);
                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_BLESSING_OF_KINGS, GOSSIP_SENDER_MAIN, 4);
                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_MARK_OF_THE_WILD, GOSSIP_SENDER_MAIN, 5);
                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_ARCANE_BRILLIANCE, GOSSIP_SENDER_MAIN, 6);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_BLESSING_OF_MIGHT, GOSSIP_SENDER_MAIN, 7);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_BLESSING_OF_WISDOM, GOSSIP_SENDER_MAIN, 8);
                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_DIVINE_SPIRIT, GOSSIP_SENDER_MAIN, 10);
                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_SHADOW_PROTECTION, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_BUFF_STAMINA, GOSSIP_SENDER_MAIN, 12);
                AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_MAIN_MENU, GOSSIP_SENDER_MAIN, 24);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE,_creature->GetGUID());
                break;

        case 3:
			if (player->GetMoney() < CONST_MONEY)
			{
				_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else{
				// Наложение Защита Нелтариона(Доработано)
				player->CastSpell(player, 69377, true);
				player->ModifyMoney(-CONST_MONEY);
				CloseGossipMenuFor(player);
			}
			break;
    case 4:
		if (player->GetMoney() < CONST_MONEY)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Наложение Защита Нелтариона(Доработано)
			player->CastSpell(player, 56525, true);
			player->ModifyMoney(-CONST_MONEY);
			CloseGossipMenuFor(player);
		}
		break;
        case 5:
			if (player->GetMoney() < CONST_MONEY)
			{
				_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else{
				player->CastSpell(player, 1126, true);
				player->ModifyMoney(-CONST_MONEY);
				CloseGossipMenuFor(player);
			}
			break;
        case 6:
			if (player->GetMoney() < CONST_MONEY)
			{
				_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else{
				player->CastSpell(player, 61316, true);
				player->ModifyMoney(-CONST_MONEY);
				CloseGossipMenuFor(player);
			}
			break;
        case 7:
			if (player->GetMoney() < CONST_MONEY)
			{
				_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else{
				player->CastSpell(player, 29381, true);
				player->ModifyMoney(-CONST_MONEY);
				CloseGossipMenuFor(player);
			}
			break;
        case 8:
			if (player->GetMoney() < CONST_MONEY)
			{
				_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else{
				player->CastSpell(player, 56521, true);
				player->ModifyMoney(-CONST_MONEY);
				CloseGossipMenuFor(player);
			}
			break;
        case 10:
			if (player->GetMoney() < CONST_MONEY)
			{
				_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else{
				player->CastSpell(player, 48074, true);
				player->ModifyMoney(-CONST_MONEY);
				CloseGossipMenuFor(player);
			}
			break;
        case 11:
			if (player->GetMoney() < CONST_MONEY)
			{
				_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else{
				player->CastSpell(player, 48170, true);
				player->ModifyMoney(-CONST_MONEY);
				CloseGossipMenuFor(player);
			}
			break;
        case 12:
			if (player->GetMoney() < CONST_MONEY)
			{
				_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else{
				player->CastSpell(player, 48102, true);
				player->ModifyMoney(-CONST_MONEY);
				CloseGossipMenuFor(player);
			}
			break;
    case 13:
                player->PlayerTalkClass->ClearMenus();
                AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, MSG_GOSSIP_TEXT_SUPPER_BUFF_AEGIS_OF_NELTHARION, GOSSIP_SENDER_MAIN, 16);
                AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, MSG_GOSSIP_TEXT_SUPPER_BUFF_BLESSING_ADALS, GOSSIP_SENDER_MAIN, 17);
                AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, MSG_GOSSIP_TEXT_SUPPER_BUFF_CRIT_SPELLS, GOSSIP_SENDER_MAIN, 18);
                AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, MSG_GOSSIP_TEXT_SUPPER_BUFF_BLESSING_PINCHI, GOSSIP_SENDER_MAIN, 19);
				AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, MSG_GOSSIP_TEXT_SUPPER_BUFF_ELUNA, GOSSIP_SENDER_MAIN, 20);
                AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, MSG_GOSSIP_TEXT_SUPPER_BUFF_WIXR, GOSSIP_SENDER_MAIN, 21);
                AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, MSG_GOSSIP_TEXT_SUPPER_BUFF_YKYC, GOSSIP_SENDER_MAIN, 22);
                AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, MSG_GOSSIP_TEXT_SUPPER_BUFF_SHPIL, GOSSIP_SENDER_MAIN, 23);
 
        AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_MAIN_MENU, GOSSIP_SENDER_MAIN, 24);
                SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE,_creature->GetGUID());
        break;
	case 16:
		if (player->GetMoney() < CONST_MONEY_1)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Наложение Защита Нелтариона(Доработано)
			player->CastSpell(player, 51512, true);
			player->ModifyMoney(-CONST_MONEY_1);
			CloseGossipMenuFor(player);
		}
		break;
	case 17:
		if (player->GetMoney() < CONST_MONEY_1)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Наложение Благословение А'дала
			player->CastSpell(player, 35076, true);
			player->ModifyMoney(-CONST_MONEY_1);
			CloseGossipMenuFor(player);
		}
		break;
	case 18:
		if (player->GetMoney() < CONST_MONEY_1)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Наложение Критического срабатывания положительных эффектов
			player->CastSpell(player, 31305, true);
			player->ModifyMoney(-CONST_MONEY_1);
			CloseGossipMenuFor(player);
		}
		break;
	case 19:
		if (player->GetMoney() < CONST_MONEY_1)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Наложение Благословения мистера Пинчи
			player->CastSpell(player, 33053, true);
			player->ModifyMoney(-CONST_MONEY_1);
			CloseGossipMenuFor(player);
		}
		break;
	case 20:
		if (player->GetMoney() < CONST_MONEY_1)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Элуна
			player->CastSpell(player, 26393, true);
			player->ModifyMoney(-CONST_MONEY_1);
			CloseGossipMenuFor(player);
		}
		break;
	case 21:
		if (player->GetMoney() < CONST_MONEY_1)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Вихрь
			player->CastSpell(player, 54589, true);
			player->ModifyMoney(-CONST_MONEY_1);
			CloseGossipMenuFor(player);
		}
		break;
	case 22:
		if (player->GetMoney() < CONST_MONEY_1)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Знак Куса
			player->CastSpell(player, 34906, true);
			player->ModifyMoney(-CONST_MONEY_1);
			CloseGossipMenuFor(player);
		}
		break;
	case 23:
		if (player->GetMoney() < CONST_MONEY_1)
		{
			_creature->Whisper(MSG_ERR_MONEY, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
		}
		else{
			// Двух Шпилей
			player->CastSpell(player, 33779, true);
			player->ModifyMoney(-CONST_MONEY_1);
			CloseGossipMenuFor(player);
		}
		break;
        case 24:
                OnGossipHello(player, _creature);
                break;
 
                        }
                                return true;
}
 
   };
void AddSC_buff()
{
    new buff;
}
