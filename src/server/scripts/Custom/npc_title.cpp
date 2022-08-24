#include "ScriptPCH.h"
#include "ScriptMgr.h"

#define MSG_GOSSIP_TEXT_GETTING_STARTED "Приветствую! У меня ты можешь приобрести себе звание."
#define MSG_GOSSIP_TEXT_GETTING_STARTED1 "Каждое из них стоит: [Ивент-Токен]x30 . Выбирай скорей!"

#define MSG_ERR_ARENA_POINT "Недостаточно Ивент-Токен!"
#define MSG_ERR_TITLE "У тебя уже есть такое звание!"
#define MSG_ERR_INCOMBAT "Не могу, ты в бою!"

#define MSG_GOSSIP_TEXT_NEXT_2 "[Вторая страница] ->"
#define MSG_GOSSIP_TEXT_NEXT_3 "[Третья страница] ->"
#define MSG_GOSSIP_TEXT_NEXT_4 "[Четвертая страница] ->"
#define MSG_GOSSIP_TEXT_NEXT_5 "[Пятая страница] ->"

#define MSG_GOSSIP_TEXT_BACK_4 "<- [Четвертая страница] "
#define MSG_GOSSIP_TEXT_BACK_3 "<- [Третья страница] "
#define MSG_GOSSIP_TEXT_BACK_2 "<- [Вторая страница] "
#define MSG_GOSSIP_TEXT_BACK_1 "<- [Первая страница] "


#define MSG_GOSSIP_TEXT_144 "Звание [Адмирал Кровавого Паруса]"
#define MSG_GOSSIP_TEXT_62 "Звание [Безжалостный гладиатор]"
#define MSG_GOSSIP_TEXT_135 "Звание [Безумно влюбленный]"
#define MSG_GOSSIP_TEXT_141 "Звание [Бессмертный]"
#define MSG_GOSSIP_TEXT_138 "Звание [Благодетель]"
#define MSG_GOSSIP_TEXT_170 "Звание [Великий крестоносец]"
#define MSG_GOSSIP_TEXT_28 "Звание [Верховный вождь]"
#define MSG_GOSSIP_TEXT_48 "Звание [Вершитель правосудия]"
#define MSG_GOSSIP_TEXT_134 "Звание [Весельчак]"
#define MSG_GOSSIP_TEXT_72 "Звание [Военачальник]"
#define MSG_GOSSIP_TEXT_42 "Звание [Гладиатор]"
#define MSG_GOSSIP_TEXT_113 "Звание [Гномреганский]"
#define MSG_GOSSIP_TEXT_147 "Звание [Дарнасский]"
#define MSG_GOSSIP_TEXT_143 "Звание [Дженкинс]"
#define MSG_GOSSIP_TEXT_79 "Звание [Дипломат]"
#define MSG_GOSSIP_TEXT_64 "Звание [Длань А'дала]"
#define MSG_GOSSIP_TEXT_43 "Звание [Дуэлянт]"
#define MSG_GOSSIP_TEXT_80 "Звание [Жестокий Гладиатор]"
#define MSG_GOSSIP_TEXT_47 "Звание [Завоеватель]"
#define MSG_GOSSIP_TEXT_122 "Звание [Завоеватель Наксрамаса]"
#define MSG_GOSSIP_TEXT_81 "Звание [Искатель]"
#define MSG_GOSSIP_TEXT_78 "Звание [Исследователь]"
#define MSG_GOSSIP_TEXT_156 "Звание [Крестоносец]"
#define MSG_GOSSIP_TEXT_83 "Звание [Морской дьявол]"
#define MSG_GOSSIP_TEXT_71 "Звание [Мстительный гладиатор]"
#define MSG_GOSSIP_TEXT_142 "Звание [Неумирающий]"
#define MSG_GOSSIP_TEXT_146 "Звание [Неумолимый гладиатор]"
#define MSG_GOSSIP_TEXT_150 "Звание [Оргриммарский]"
#define MSG_GOSSIP_TEXT_46 "Звание [Повелитель Скарабеев]"
#define MSG_GOSSIP_TEXT_139 "Звание [Покоритель Обсидианового святилища]"
#define MSG_GOSSIP_TEXT_77 "Звание [Превозносимый]"
#define MSG_GOSSIP_TEXT_74 "Звание [Премудрый]"
#define MSG_GOSSIP_TEXT_45 "Звание [Претендент]"
#define MSG_GOSSIP_TEXT_177 "Звание [Разгневанный гладиатор]"
#define MSG_GOSSIP_TEXT_151 "Звание [Сен'джинский]"
#define MSG_GOSSIP_TEXT_171 "Звание [Серебряный заступник]"
#define MSG_GOSSIP_TEXT_131 "Звание [Серебряный защитник]"
#define MSG_GOSSIP_TEXT_173 "Звание [Сияние Рассвета]"
#define MSG_GOSSIP_TEXT_157 "Звание [Смертоносный гладиатор]"
#define MSG_GOSSIP_TEXT_75 "Звание [Страж огня]"
#define MSG_GOSSIP_TEXT_140 "Звание [Сумеречный]"
#define MSG_GOSSIP_TEXT_172 "Звание [Терпеливый]"
#define MSG_GOSSIP_TEXT_124 "Звание [Тыквер]"
#define MSG_GOSSIP_TEXT_133 "Звание [Хмелевар]"
#define MSG_GOSSIP_TEXT_125 "Звание [Хранитель мудрости]"
#define MSG_GOSSIP_TEXT_76 "Звание [Хранитель огня]"
#define MSG_GOSSIP_TEXT_145 "Звание [Чокнутый]"
#define MSG_GOSSIP_TEXT_155 "Звание [Чудесный]"
#define MSG_GOSSIP_TEXT_84 "Звание [Шеф-повар]"

using namespace std;

#define CONST_EVENT_CREDIT 2

class npc_title : public CreatureScript
{
public:
	npc_title() : CreatureScript("npc_title") { }


	bool AddTitle(Player* player, Creature* _creature, CharTitlesEntry const* titleInfo)
	{
		if (player->HasTitle(titleInfo)) {
			_creature->Whisper(MSG_ERR_TITLE, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
			return false;
		}

		if (player->HasItemCount(80080, 30, false))
		{
			CloseGossipMenuFor(player);
			player->DestroyItemCount(80080, 30, true, false);
			player->SetTitle(titleInfo);
			_creature->Whisper("Поздравляю! Ты получил новое звание!", LANG_UNIVERSAL, player);
		}
		else
		{
			CloseGossipMenuFor(player);
			_creature->Whisper("У вас недостаточно [Ивент-Токен]", LANG_UNIVERSAL, player);
			return false;
		}

	}

	bool OnGossipHello(Player *player, Creature *_creature)
	{
		
	  /* _creature->Whisper(MSG_GOSSIP_TEXT_GETTING_STARTED, LANG_UNIVERSAL, player);
		_creature->Whisper(MSG_GOSSIP_TEXT_GETTING_STARTED1, LANG_UNIVERSAL, player);
		ClearGossipMenuFor(player); */

        std::string name = player->GetName();
        std::ostringstream info;

        ClearGossipMenuFor(player);
        info << "Приветствую, " << name << "\nХочешь крутое звание?\n" << "Каждое из них стоит: |cff065961[Ивент-Токен]x30|r\nВыбирай скорей!";

		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_144, GOSSIP_SENDER_MAIN, 2);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_62, GOSSIP_SENDER_MAIN, 3);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_135, GOSSIP_SENDER_MAIN, 4);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_141, GOSSIP_SENDER_MAIN, 5);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_138, GOSSIP_SENDER_MAIN, 6);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_170, GOSSIP_SENDER_MAIN, 7);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_28, GOSSIP_SENDER_MAIN, 8);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_48, GOSSIP_SENDER_MAIN, 9);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_134, GOSSIP_SENDER_MAIN, 10);
		AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_72, GOSSIP_SENDER_MAIN, 11);
		AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_NEXT_2, GOSSIP_SENDER_MAIN, 12);
		// SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
        player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), _creature->GetGUID());
		return true;

	}

	bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 action)
	{
		if (!player->getAttackers().empty())
		{
			_creature->Whisper(MSG_ERR_INCOMBAT, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
			return false;
		}

		switch (action)
		{
		case 2:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(144);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 3:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(62);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 4:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(135);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 5:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(141);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 6:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(138);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 7:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(170);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 8:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(28);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 9:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(48);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 10:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(134);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 11:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(72);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 12:
			ClearGossipMenuFor(player);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_42, GOSSIP_SENDER_MAIN, 13);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_113, GOSSIP_SENDER_MAIN, 14);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_147, GOSSIP_SENDER_MAIN, 15);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_143, GOSSIP_SENDER_MAIN, 16);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_79, GOSSIP_SENDER_MAIN, 17);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_64, GOSSIP_SENDER_MAIN, 18);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_43, GOSSIP_SENDER_MAIN, 19);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_80, GOSSIP_SENDER_MAIN, 20);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_47, GOSSIP_SENDER_MAIN, 21);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_122, GOSSIP_SENDER_MAIN, 22);
			AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_BACK_1, GOSSIP_SENDER_MAIN, 56);
			AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_NEXT_3, GOSSIP_SENDER_MAIN, 23);
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
			break;
		case 13:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(42);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 14:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(113);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 15:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(147);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 16:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(143);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 17:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(79);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 18:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(64);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 19:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(43);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 20:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(80);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 21:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(47);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 22:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(122);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 23:
			ClearGossipMenuFor(player);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_81, GOSSIP_SENDER_MAIN, 24);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_78, GOSSIP_SENDER_MAIN, 25);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_156, GOSSIP_SENDER_MAIN, 26);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_83, GOSSIP_SENDER_MAIN, 27);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_71, GOSSIP_SENDER_MAIN, 28);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_142, GOSSIP_SENDER_MAIN, 29);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_146, GOSSIP_SENDER_MAIN, 30);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_150, GOSSIP_SENDER_MAIN, 31);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_46, GOSSIP_SENDER_MAIN, 32);
			AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_BACK_2, GOSSIP_SENDER_MAIN, 57);
			AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_NEXT_4, GOSSIP_SENDER_MAIN, 34);
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
			break;
		case 24:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(81);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 25:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(78);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 26:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(156);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 27:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(83);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 28:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(71);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 29:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(142);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 30:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(146);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 31:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(150);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 32:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(46);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 33:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(278);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 34:
			ClearGossipMenuFor(player);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_139, GOSSIP_SENDER_MAIN, 35);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_77, GOSSIP_SENDER_MAIN, 36);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_74, GOSSIP_SENDER_MAIN, 37);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_45, GOSSIP_SENDER_MAIN, 38);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_177, GOSSIP_SENDER_MAIN, 39);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_151, GOSSIP_SENDER_MAIN, 40);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_171, GOSSIP_SENDER_MAIN, 41);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_131, GOSSIP_SENDER_MAIN, 42);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_173, GOSSIP_SENDER_MAIN, 43);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_157, GOSSIP_SENDER_MAIN, 44);
			AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_BACK_3, GOSSIP_SENDER_MAIN, 58);
			AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_NEXT_5, GOSSIP_SENDER_MAIN, 45);
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
			break;
		case 35:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(139);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 36:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(77);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 37:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(74);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 38:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(45);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 39:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(177);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 40:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(151);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 41:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(171);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 42:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(131);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 43:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(173);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 44:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(157);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 45:
			ClearGossipMenuFor(player);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_75, GOSSIP_SENDER_MAIN, 46);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_140, GOSSIP_SENDER_MAIN, 47);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_172, GOSSIP_SENDER_MAIN, 48);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_124, GOSSIP_SENDER_MAIN, 49);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_133, GOSSIP_SENDER_MAIN, 50);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_76, GOSSIP_SENDER_MAIN, 51);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_125, GOSSIP_SENDER_MAIN, 52);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_145, GOSSIP_SENDER_MAIN, 53);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_155, GOSSIP_SENDER_MAIN, 54);
			AddGossipItemFor(player,GOSSIP_ICON_TRAINER, MSG_GOSSIP_TEXT_84, GOSSIP_SENDER_MAIN, 55);
			AddGossipItemFor(player,GOSSIP_ICON_TALK, MSG_GOSSIP_TEXT_BACK_4, GOSSIP_SENDER_MAIN, 59);
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
			break;
		case 46:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(75);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 47:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(140);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 48:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(172);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 49:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(124);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 50:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(133);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 51:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(125);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 52:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(76);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 53:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(145);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 54:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(155);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 55:
		{CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(84);
		AddTitle(player, _creature, titleInfo);
		}
			break;
		case 56:
			OnGossipHello(player, _creature);
			break;
		case 57:
			OnGossipSelect(player, _creature, sender, 12);
			break;
		case 58:
			OnGossipSelect(player, _creature, sender, 23);
			break;
		case 59:
			OnGossipSelect(player, _creature, sender, 34);
			break;
		}

		return true;
	}
};
void AddSC_npc_title()
{
	new npc_title;
}
