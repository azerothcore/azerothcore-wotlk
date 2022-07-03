/*
* SD Name: Npc Premium Master.
* SD Custom Script.
* SD Special For Vip Account Patch.
* SD Complete 100%.
* SD Autor (Crispi).
* SD Data 02.01.2012.
*/

#include "ScriptPCH.h"

#define CONST_ARENA_RENAME 0
#define CONST_ARENA_CUSTOMIZE 0
#define CONST_ARENA_CHANGE_FACTION 0
#define CONST_ARENA_CHANGE_RACE 0

#define EMOTE_NO_VIP "Извините, доступно только VIP игрокам..."
#define EMOTE_COOLDOWN "Не могу сделать это сейчас..."
#define EMOTE_NO_SICKENSS "У вас нет ауры 'Слабость после воскрешения'!"
#define EMOTE_NO_DESERTER "У вас нет ауры 'Дезертир'!"
#define EMOTE_COMBAT "Вы находитесь в бою!"
#define EMOTE_NO_ARENA_POINTS "Недостаточно очков арены!"
#define EMOTE_ALREADY_ITEM "Эта вещь у Вас уже есть!"
#define EMOTE_TALENT_RESET "Таланты успешно сброшены!"

#define MSG_RENAME_COMPLETE "Перезайдите и введите новое имя персонажа. Не забудьте после изменения имени выйти и удалить из папки клиента кэш!"
#define MSG_CUSTOMIZE_COMPLETE "Перезайдите и измените внешность персонажа. Не забудьте после изменения внешности выйти и удалить из папки клиента кэш!"
#define MSG_CHANGE_FACTION_COMPLETE "Перезайдите и измените фракцию персонажа. После смены Фракции цепочки квестов будут обнулены!" 
#define MSG_CHANGE_RACE_COMPLETE "Перезайдите и измените расу персонажа. Не забудьте после изменения расы выйти и удалить из папки клиента кэш!"
#define MSG_MAX_SKILL "Ваши навыки повышены до максимума!"
#define MSG_REMOVE_SICKNESS_COMPLETE "'Слабость после воскрешения' удалена. Восстановлены HP & Mana!"
#define MSG_REMOVE_DESERTER_COMPLETE "'Дезертир' удалён. Вы можите снова вернуться на поле боя!"
#define MSG_RIDING_COMPLETE "Ваш навык верховой езды повышен до максимума!"
#define MSG_RESET_COOLDOWN "Ваше время восстановления сброшено!"
#define MSG_CHARACTER_SAVE_TO_DB "Ваш персонаж сохранён!"
#define MSG_RESET_QUEST_STATUS_COMPLETE "Ваши ежедневные и еженедельные задания обновлены!"

class npc_premium_master : public CreatureScript
{
public: 
	npc_premium_master() : CreatureScript("npc_premium_master") { }

	bool OnGossipHello(Player* player, Creature* creature)
	{
		if (!player->GetSession()->IsPremium() && !player->IsGameMaster())
		{
			CloseGossipMenuFor(player);
			creature->Whisper(EMOTE_NO_VIP, LANG_UNIVERSAL, player);
			return true;
		}
		player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_note_02:20|t Получить Звание [VIP]", GOSSIP_SENDER_MAIN, 9500);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/spell_shadow_deathscream:20|t Снять [Слабость после воскрешения]", GOSSIP_SENDER_MAIN, 1209);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/ability_druid_cower:20|t Снять [Дезертир]", GOSSIP_SENDER_MAIN, 1210);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Spell_holy_healingaura:20|t Вылечить персонажа", GOSSIP_SENDER_MAIN, 1202);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Achievement_reputation_08:20|t Сохранить персонажа", GOSSIP_SENDER_MAIN, 1213);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Achievement_reputation_argentchampion:20|t Сбросить таланты", GOSSIP_SENDER_MAIN, 1207);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Achievement_pvp_o_05:20|t Повысить навыки", GOSSIP_SENDER_MAIN, 1204);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Ability_hunter_ferociousinspiration:20|t ViP-Маунт", GOSSIP_SENDER_MAIN, 1216);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_shoulder_56:20|t ViP-Wings ->", GOSSIP_SENDER_MAIN, 1220);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_book_04:20|t ViP-Бафы ->", GOSSIP_SENDER_MAIN, 6999);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема ->", GOSSIP_SENDER_MAIN, 1231);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Ability_mount_charger:20|t Редкие ездовые животные ->", GOSSIP_SENDER_MAIN, 1208);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Ability_mount_gyrocoptor:20|t Элитные ездовые животные ->", GOSSIP_SENDER_MAIN, 1217);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Ability_mount_hordepvpmount:20|t Прото ездовые животные ->", GOSSIP_SENDER_MAIN, 1218);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_09:20|t Превращения ->", GOSSIP_SENDER_MAIN, 1203);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_book_07:20|t Заклинания ->", GOSSIP_SENDER_MAIN, 1206);
		AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Trade_engineering:20|tИзменить персонажа ->", GOSSIP_SENDER_MAIN, 2000);
        SendGossipMenuFor(player, 200034, creature->GetGUID());
		return true;
	}

	bool OnGossipSelect(Player* player, Creature* creature, uint32 uiSender, uint32 action)
	{
		if (!player->getAttackers().empty())
		{
			creature->Whisper(EMOTE_COMBAT, LANG_UNIVERSAL, player);
			CloseGossipMenuFor(player);
			return false;
		}

		player->PlayerTalkClass->ClearMenus();

		switch (action)
		{
		case 4:
			OnGossipHello(player, creature);
			break;
		case 1202: // Heal
			if (player->HasAura(45523))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_COOLDOWN, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->CastSpell(player, 25840, true);
				player->CastSpell(player, 45523, true);
			}
			break;
		case 9500: // NPC-Title
			if (player->GetSession()->IsPremium())
			{
				CloseGossipMenuFor(player);
				CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(178);
				player->SetTitle(titleInfo);
			}
			break;
		case 1207: // Reset talents
			CloseGossipMenuFor(player);			
			player->resetTalents(true);
			player->SendTalentsInfoData(false);
			creature->Whisper(EMOTE_TALENT_RESET, LANG_UNIVERSAL, player);
			break;
		case 1203: // Morphs
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "Бронированный мурлок", GOSSIP_SENDER_MAIN, 499);
			AddGossipItemFor(player,5, "Гном", GOSSIP_SENDER_MAIN, 500);
			AddGossipItemFor(player,5, "Джонатан Богослов", GOSSIP_SENDER_MAIN, 501);
			AddGossipItemFor(player,5, "Маги", GOSSIP_SENDER_MAIN, 502);
			AddGossipItemFor(player,5, "Ворген", GOSSIP_SENDER_MAIN, 503);
			AddGossipItemFor(player,5, "Пандарен монах", GOSSIP_SENDER_MAIN, 504);
			AddGossipItemFor(player,5, "Крок Гроза Плети ", GOSSIP_SENDER_MAIN, 505);
			AddGossipItemFor(player,5, "Железный дворф", GOSSIP_SENDER_MAIN, 506);
			AddGossipItemFor(player,5, "Друид", GOSSIP_SENDER_MAIN, 507);
			AddGossipItemFor(player,5, "Жрец", GOSSIP_SENDER_MAIN, 508);
			AddGossipItemFor(player,5, "Паладин", GOSSIP_SENDER_MAIN, 509);
			AddGossipItemFor(player,5, "Разбойник", GOSSIP_SENDER_MAIN, 510);
			AddGossipItemFor(player,5, "Рыцарь смерти", GOSSIP_SENDER_MAIN, 511);
			AddGossipItemFor(player,5, "Чернокнижник", GOSSIP_SENDER_MAIN, 512);
			AddGossipItemFor(player,5, "Воин", GOSSIP_SENDER_MAIN, 513);
			AddGossipItemFor(player,5, "Маг", GOSSIP_SENDER_MAIN, 514);
			AddGossipItemFor(player,5, "Шаман", GOSSIP_SENDER_MAIN, 515);
			AddGossipItemFor(player,5, "Охотник", GOSSIP_SENDER_MAIN, 516);
			AddGossipItemFor(player,5, "Белая дренейка", GOSSIP_SENDER_MAIN, 517);
			AddGossipItemFor(player,5, "Черная дренейка", GOSSIP_SENDER_MAIN, 518);
			AddGossipItemFor(player,0, "Снять превращение", GOSSIP_SENDER_MAIN, 519);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
			break;
		case 499:
			CloseGossipMenuFor(player); // Starcraft Murlock
			player->SetDisplayId(29348);
			break;
		case 500:
			CloseGossipMenuFor(player); // Ambrose Boltspark
			player->SetDisplayId(28586);
			break;
		case 501:
			CloseGossipMenuFor(player); // Jonathan The Revelator
			player->SetDisplayId(15867);
			break;
		case 502:
			CloseGossipMenuFor(player); // Shattered Sun Magi
			player->SetDisplayId(22959);
			break;
		case 503:
			CloseGossipMenuFor(player); // Worgen
			player->SetDisplayId(657);
			break;
		case 504:
			CloseGossipMenuFor(player); // Pandaren Monk
			player->SetDisplayId(30414);
			break;
		case 505:
			CloseGossipMenuFor(player); // Crok Scourgebane
			player->SetDisplayId(30911);
			break;
		case 506:
			CloseGossipMenuFor(player); // Iron Mender
			player->SetDisplayId(26239);
			break;
		case 507:
			CloseGossipMenuFor(player); // Druid
			player->SetDisplayId(30472);
			break;
		case 508:
			CloseGossipMenuFor(player); // Priest
			player->SetDisplayId(21419);
			break;
		case 509:
			CloseGossipMenuFor(player); // Paladin
			player->SetDisplayId(29774);
			break;
		case 510:
			CloseGossipMenuFor(player); // Rogue
			player->SetDisplayId(30485);
			break;
		case 511:
			CloseGossipMenuFor(player); // Death Knight
			player->SetDisplayId(27153);
			break;
		case 512:
			CloseGossipMenuFor(player); // Warlock
			player->SetDisplayId(30487);
			break;
		case 513:
			CloseGossipMenuFor(player); // Warrior
			player->SetDisplayId(30474);
			break;
		case 514:
			CloseGossipMenuFor(player); // Mage
			player->SetDisplayId(30477);
			break;
		case 515:
			CloseGossipMenuFor(player); // Shaman 
			player->SetDisplayId(29768);
			break;
		case 516:
			CloseGossipMenuFor(player); // Hunter
			player->SetDisplayId(21379);
			break;
		case 517:
			CloseGossipMenuFor(player); // Coliseum Champion
			player->SetDisplayId(30634);
			break;
		case 518:
			CloseGossipMenuFor(player); // Coliseum Champion
			player->SetDisplayId(30771);
			break;
		case 519: // Demorph Player (remove all morphs)
			CloseGossipMenuFor(player);
			player->DeMorph();
			break;
		case 1230: // ViP-Buffs
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_vip:20|t ViP-Buff", GOSSIP_SENDER_MAIN, 7000);
            SendGossipMenuFor(player, 200034, creature->GetGUID());
			break;
		case 1231: // ViP-Buffs
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Воин]", GOSSIP_SENDER_MAIN, 1250);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Паладин]", GOSSIP_SENDER_MAIN, 1251);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Охотник]", GOSSIP_SENDER_MAIN, 1252);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Разбойник]", GOSSIP_SENDER_MAIN, 1253);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Жрец]", GOSSIP_SENDER_MAIN, 1254);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Шаман]", GOSSIP_SENDER_MAIN, 1255);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Маг]", GOSSIP_SENDER_MAIN, 1256);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Чернокнижник]", GOSSIP_SENDER_MAIN, 1257);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Друид]", GOSSIP_SENDER_MAIN, 1258);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_roga:20|t ViP-Диадема [Рыцарь Смерти]", GOSSIP_SENDER_MAIN, 1259);
            SendGossipMenuFor(player, 200034, creature->GetGUID());
			break;
		case 6999: // Power Word Fortitude
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_vip:20|t ViP-Buff +10% ко всем хар-кам", GOSSIP_SENDER_MAIN, 7000);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_vip:20|t ViP-Buff +10% Сила и Выносливость", GOSSIP_SENDER_MAIN, 7001);
			AddGossipItemFor(player,5, "|TInterface/ICONS/icon_vip:20|t ViP-Buff +10% Скорость", GOSSIP_SENDER_MAIN, 7002);
            SendGossipMenuFor(player, 200034, creature->GetGUID());
			break;
		case 7000: // Power Word Fortitude
			CloseGossipMenuFor(player);
			player->CastSpell(player, 90000, true);
			break;
		case 7001: // Prayer of Spirit
			CloseGossipMenuFor(player);
			player->CastSpell(player, 90001, true);
			break;
		case 7002: // Shadow Protection
			CloseGossipMenuFor(player);
			player->CastSpell(player, 90002, true);
			break;
		case 7003: // 36 Slot Bag
			if (player->HasItemCount(68912, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(68912, 1);
			}
			break;
		case 7004: // 36 Slot Bag
			if (player->HasItemCount(68913, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(68913, 1);
			}
			break;
		case 7005: // 36 Slot Bag
			if (player->HasItemCount(68914, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(68914, 1);
			}
			break;
		case 1206: // Buffs
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "Молитва стойкости", GOSSIP_SENDER_MAIN, 4000);
			AddGossipItemFor(player,5, "Молитва духа", GOSSIP_SENDER_MAIN, 4001);
			AddGossipItemFor(player,5, "Молитва защиты от темных сил", GOSSIP_SENDER_MAIN, 4002);
			AddGossipItemFor(player,5, "Великое благословение королей", GOSSIP_SENDER_MAIN, 4003);
			AddGossipItemFor(player,5, "Великое благословение могущества", GOSSIP_SENDER_MAIN, 4004);
			AddGossipItemFor(player,5, "Великое благословение мудрости", GOSSIP_SENDER_MAIN, 4005);
			AddGossipItemFor(player,5, "Великое благословение неприкосновенности", GOSSIP_SENDER_MAIN, 4006);
			AddGossipItemFor(player,5, "Чародейский интеллект", GOSSIP_SENDER_MAIN, 4007);
			AddGossipItemFor(player,5, "Ослабление магии", GOSSIP_SENDER_MAIN, 4008);
			AddGossipItemFor(player,5, "Усиление магии", GOSSIP_SENDER_MAIN, 4009);
			AddGossipItemFor(player,5, "Знак дикой природы", GOSSIP_SENDER_MAIN, 4010);
			AddGossipItemFor(player,5, "Шипы", GOSSIP_SENDER_MAIN, 4011);
			AddGossipItemFor(player,5, "Гениальность", GOSSIP_SENDER_MAIN, 4012);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
			break;
		case 4000: // Power Word Fortitude
			CloseGossipMenuFor(player);
			player->CastSpell(player, 48162, true);
			break;
		case 4001: // Prayer of Spirit
			CloseGossipMenuFor(player);
			player->CastSpell(player, 48074, true);
			break;
		case 4002: // Shadow Protection
			CloseGossipMenuFor(player);
			player->CastSpell(player, 48170, true);
			break;
		case 4003: // Greater Blessing of Kings
			CloseGossipMenuFor(player);
			player->CastSpell(player, 43223, true);
			break;
		case 4004: // Greater Bleesing of Might
			CloseGossipMenuFor(player);
			player->CastSpell(player, 48934, true);
			break;
		case 4005: // Greater Blessing of Wisdom
			CloseGossipMenuFor(player);
			player->CastSpell(player, 48938, true);
			break;
		case 4006: // Greater Blessing of Sanctuary
			CloseGossipMenuFor(player);
			player->CastSpell(player, 25899, true);
			break;
		case 4007: // Arane Intellect
			CloseGossipMenuFor(player);
			player->CastSpell(player, 36880, true);
			break;
		case 4008: // Dampen Magic
			CloseGossipMenuFor(player);
			player->CastSpell(player, 43015, true);
			break;
		case 4009: // Amplify Magic
			CloseGossipMenuFor(player);
			player->CastSpell(player, 43017, true);
			break;
		case 4010: // Gift of the Wild
			CloseGossipMenuFor(player);
			player->CastSpell(player, 69381, true);
			break;
		case 4011: // Thorns
			CloseGossipMenuFor(player);
			player->CastSpell(player, 467, true);
			break;
		case 4012: // Brilliance Intellect
			CloseGossipMenuFor(player);
			player->CastSpell(player, 69994, true);
			break;
		case 2000: // Rename
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Trade_engineering:25|tИзменить имя", GOSSIP_SENDER_MAIN, 2001);
			AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:25|tНазад", GOSSIP_SENDER_MAIN, 4);
			SendGossipMenuFor(player, 200034, creature->GetGUID());
			break;
		case 2001: // Customize
			if (player->GetArenaPoints() < CONST_ARENA_RENAME)
			{
				creature->Whisper(EMOTE_NO_ARENA_POINTS, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->SetAtLoginFlag(AT_LOGIN_RENAME);
				player->ModifyArenaPoints(-CONST_ARENA_RENAME);
				creature->Whisper(MSG_RENAME_COMPLETE, LANG_UNIVERSAL, player);
			}
			break;
		case 2002: // Change Faction
			if (player->GetArenaPoints() < CONST_ARENA_CHANGE_FACTION)
			{
				creature->Whisper(EMOTE_NO_ARENA_POINTS, LANG_UNIVERSAL, player);
				CloseGossipMenuFor(player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
				player->ModifyArenaPoints(-CONST_ARENA_CHANGE_FACTION);
				creature->Whisper(MSG_CHANGE_FACTION_COMPLETE, LANG_UNIVERSAL, player);
			}
			break;
		case 1204: // Max Skills
			CloseGossipMenuFor(player);
			player->UpdateSkillsToMaxSkillsForLevel();
			creature->Whisper(MSG_MAX_SKILL, LANG_UNIVERSAL, player);
			break;
		case 1208: // Mounts Ground
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "Black Qiraji Resonating Crystal", GOSSIP_SENDER_MAIN, 100);
			AddGossipItemFor(player,5, "Amani War Bear", GOSSIP_SENDER_MAIN, 101);
			AddGossipItemFor(player,5, "Big Battle Bear", GOSSIP_SENDER_MAIN, 102);
			AddGossipItemFor(player,5, "Deathcharger's Reins", GOSSIP_SENDER_MAIN, 103);
			AddGossipItemFor(player,5, "Fiery Warhorse's Reins", GOSSIP_SENDER_MAIN, 104);
			AddGossipItemFor(player,5, "Swift Burgundy Wolf", GOSSIP_SENDER_MAIN, 105);
			AddGossipItemFor(player,5, "Great Brewfest Kodo", GOSSIP_SENDER_MAIN, 106);
			AddGossipItemFor(player,5, "Horn of the Frostwolf Howler", GOSSIP_SENDER_MAIN, 107);
			AddGossipItemFor(player,5, "Magic Rooster Egg", GOSSIP_SENDER_MAIN, 108);
			AddGossipItemFor(player,5, "Reins of the White Polar Bear", GOSSIP_SENDER_MAIN, 109);
			AddGossipItemFor(player,5, "Reins of the Brown Polar Bear", GOSSIP_SENDER_MAIN, 110);
			AddGossipItemFor(player,5, "Reins of the Crimson Deathcharger", GOSSIP_SENDER_MAIN, 111);
			AddGossipItemFor(player,5, "Reins of the Raven Lord", GOSSIP_SENDER_MAIN, 112);
			AddGossipItemFor(player,5, "Reins of the Swift Spectral Tiger", GOSSIP_SENDER_MAIN, 113);
			AddGossipItemFor(player,5, "Sea Turtle", GOSSIP_SENDER_MAIN, 114);
			AddGossipItemFor(player,5, "Swift Razzashi Raptor", GOSSIP_SENDER_MAIN, 115);
			AddGossipItemFor(player,5, "Swift White Hawkstrider", GOSSIP_SENDER_MAIN, 116);
			AddGossipItemFor(player,5, "Swift Zhevra", GOSSIP_SENDER_MAIN, 117);
			AddGossipItemFor(player,5, "Swift Zulian Tiger", GOSSIP_SENDER_MAIN, 118);
			AddGossipItemFor(player,5, "The Horseman's Reins", GOSSIP_SENDER_MAIN, 119);
			AddGossipItemFor(player,5, "Wooly White Rhino", GOSSIP_SENDER_MAIN, 120);
			AddGossipItemFor(player,5, "Four Qiraji Resonating Crystal", GOSSIP_SENDER_MAIN, 121);
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
			break;
		case 100: // Black Qiraji Resonating Crystal
			CloseGossipMenuFor(player);
			player->AddItem(21176, 1);
			break;
		case 101: // Amani War Bear
			CloseGossipMenuFor(player);
			player->AddItem(33809, 1);
			break;
		case 102: // Big Battle Bear
			CloseGossipMenuFor(player);
			player->AddItem(38576, 1);
			break;
		case 103: // Deathcharger's Reins
			CloseGossipMenuFor(player);
			player->AddItem(13335, 1);
			break;
		case 104: // Fiery Warhorse's Reins
			CloseGossipMenuFor(player);
			player->AddItem(30480, 1);
			break;
		case 105: // Swift Burgundy Wolf
			CloseGossipMenuFor(player);
			player->CastSpell(player, 65646, true); // Cast Metod Because Item (Faction Flag)
			break;
		case 106: // Great Brewfest Kodo
			CloseGossipMenuFor(player);
			player->AddItem(37828, 1);
			break;
		case 107: // Horn of the Frostwolf Howler
			CloseGossipMenuFor(player);
			player->CastSpell(player, 23509, true); // Cast Metod Because Item (Faction Flag)
			break;
		case 108: // Magic Rooster Egg
			CloseGossipMenuFor(player);
			player->AddItem(46778, 1);
			break;
		case 109: // Reins of the White Polar Bear
			CloseGossipMenuFor(player);
			player->AddItem(43962, 1);
			break;
		case 110: // Reins of the Brown Polar Bear
			CloseGossipMenuFor(player);
			player->AddItem(43963, 1);
			break;
		case 111: // Reins of the Crimson Deathcharger
			CloseGossipMenuFor(player);
			player->AddItem(52200, 1);
			break;
		case 112: // Reins of the Raven Lord
			CloseGossipMenuFor(player);
			player->AddItem(32768, 1);
			break;
		case 113: // Reins of the Swift Spectral Tiger
			CloseGossipMenuFor(player);
			player->AddItem(33225, 1);
			break;
		case 114: // Sea Turtle
			CloseGossipMenuFor(player);
			player->AddItem(46109, 1);
			break;
		case 115: // Swift Razzashi Raptor
			CloseGossipMenuFor(player);
			player->AddItem(19872, 1);
			break;
		case 116: // Swift White Hawkstrider
			CloseGossipMenuFor(player);
			player->AddItem(35513, 1);
			break;
		case 117: // Swift Zhevra
			CloseGossipMenuFor(player);
			player->AddItem(37719, 1);
			break;
		case 118: // Swift Zulian Tiger
			CloseGossipMenuFor(player);
			player->AddItem(19902, 1);
			break;
		case 119: // The Horseman's Reins
			CloseGossipMenuFor(player);
			player->AddItem(37012, 1);
			break;
		case 120: // Wooly White Rhino
			CloseGossipMenuFor(player);
			player->AddItem(54068, 1);
			break;
		case 121: // Four Qiraji Resonating Crystal
			CloseGossipMenuFor(player);
			player->AddItem(21218, 1); // Blue Qiraji Resonating Crystal
			player->AddItem(21323, 1); // Green Qiraji Resonating Crystal
			player->AddItem(21321, 1); // Red Qiraji Resonating Crystal
			player->AddItem(21324, 1); // Yellow Qiraji Resonating Crystal
			break;
		case 1217: // Mounts Fly
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "Argent Hippogryph", GOSSIP_SENDER_MAIN, 122);
			AddGossipItemFor(player,5, "Ashes of Alar", GOSSIP_SENDER_MAIN, 123);
			AddGossipItemFor(player,5, "Big Love Rocket", GOSSIP_SENDER_MAIN, 124);
			AddGossipItemFor(player,5, "Blazing Hippogryph", GOSSIP_SENDER_MAIN, 125);
			AddGossipItemFor(player,5, "Swift Nether Drake", GOSSIP_SENDER_MAIN, 126);
			AddGossipItemFor(player,5, "Vengeful Nether Drake", GOSSIP_SENDER_MAIN, 127);
			AddGossipItemFor(player,5, "Merciless Nether Drake", GOSSIP_SENDER_MAIN, 128);
			AddGossipItemFor(player,5, "Brutal Nether Drake", GOSSIP_SENDER_MAIN, 129);
			AddGossipItemFor(player,5, "Celestial Steed", GOSSIP_SENDER_MAIN, 130);
			AddGossipItemFor(player,5, "Deadly Gladiators Frost Wyrm", GOSSIP_SENDER_MAIN, 131);
			AddGossipItemFor(player,5, "Furious Gladiators Frost Wyrm", GOSSIP_SENDER_MAIN, 132);
			AddGossipItemFor(player,5, "Relentless Gladiators Frost Wyrm", GOSSIP_SENDER_MAIN, 133);
			AddGossipItemFor(player,5, "Wrathful Gladiators Frost Wyrm", GOSSIP_SENDER_MAIN, 134);
			AddGossipItemFor(player,5, "Invincibles Reins", GOSSIP_SENDER_MAIN, 135);
			AddGossipItemFor(player,5, "Mimirons Head", GOSSIP_SENDER_MAIN, 136);
			AddGossipItemFor(player,5, "Reins of the Albino Drake", GOSSIP_SENDER_MAIN, 137);
			AddGossipItemFor(player,5, "Reins of the Azure Drake", GOSSIP_SENDER_MAIN, 138);
			AddGossipItemFor(player,5, "Reins of the Black Drake", GOSSIP_SENDER_MAIN, 139);
			AddGossipItemFor(player,5, "Reins of the Blue Drake", GOSSIP_SENDER_MAIN, 140);
			AddGossipItemFor(player,5, "Reins of the Bronze Drake", GOSSIP_SENDER_MAIN, 141);
			AddGossipItemFor(player,5, "Reins of the Twilight Drake", GOSSIP_SENDER_MAIN, 152);
			AddGossipItemFor(player,5, "Reins of the Onyxian Drake", GOSSIP_SENDER_MAIN, 142);
			AddGossipItemFor(player,5, "X-51 Nether-Rocket X-TREME", GOSSIP_SENDER_MAIN, 143);
			AddGossipItemFor(player,5, "X-53 Touring Rocket", GOSSIP_SENDER_MAIN, 144);
			AddGossipItemFor(player,5, "Frozen Frost Wyrm Heart", GOSSIP_SENDER_MAIN, 145);
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
			break;
		case 122: // Argent Hippogryph
			CloseGossipMenuFor(player);
			player->AddItem(45725, 1);
			break;
		case 123: // Ashes of Alar
			CloseGossipMenuFor(player);
			player->AddItem(32458, 1);
			break;
		case 124: // Big Love Rocket
			CloseGossipMenuFor(player);
			player->AddItem(50520, 1);
			break;
		case 125: // Blazing Hippogryph
			CloseGossipMenuFor(player);
			player->AddItem(54069, 1);
			break;
		case 126: // Swift Nether Drake
			CloseGossipMenuFor(player);
			player->AddItem(30609, 1);
			break;
		case 127: // Vengeful Nether Drake
			CloseGossipMenuFor(player);
			player->AddItem(37676, 1);
			break;
		case 128: // Merciless Nether Drake
			CloseGossipMenuFor(player);
			player->AddItem(34092, 1);
			break;
		case 129: // Brutal Nether Drake
			CloseGossipMenuFor(player);
			player->AddItem(43516, 1);
			break;
		case 130: // Celestial Steed
			CloseGossipMenuFor(player);
			player->AddItem(54811, 1);
			break;
		case 131: // Deadly Gladiator's Frost Wyrm
			CloseGossipMenuFor(player);
			player->AddItem(46708, 1);
			break;
		case 132: // Furious Gladiator's Frost Wyrm
			CloseGossipMenuFor(player);
			player->AddItem(46171, 1);
			break;
		case 133: // Relentless Gladiator's Frost Wyrm
			CloseGossipMenuFor(player);
			player->AddItem(47840, 1);
			break;
		case 134: // Wrathful Gladiator's Frost Wyrm
			CloseGossipMenuFor(player);
			player->AddItem(50435, 1);
			break;
		case 135: // Invincibles Reins
			CloseGossipMenuFor(player);
			player->AddItem(50818, 1);
			break;
		case 136: // Mimiron's Head
			CloseGossipMenuFor(player);
			player->AddItem(45693, 1);
			break;
		case 137: // Reins of the Albino Drake
			CloseGossipMenuFor(player);
			player->AddItem(44178, 1);
			break;
		case 138: // Reins of the Azure Drake
			CloseGossipMenuFor(player);
			player->AddItem(43952, 1);
			break;
		case 139: // Reins of the Black Drake
			CloseGossipMenuFor(player);
			player->AddItem(43986, 1);
			break;
		case 140: // Reins of the Blue Drake
			CloseGossipMenuFor(player);
			player->AddItem(43953, 1);
			break;
		case 141: // Reins of the Bronze Drake
			CloseGossipMenuFor(player);
			player->AddItem(43951, 1);
			break;
		case 142: // Reins of the Onyxian Drake
			CloseGossipMenuFor(player);
			player->AddItem(49636, 1);
			break;
		case 152: // Reins of the Twilight Drake
			CloseGossipMenuFor(player);
			player->AddItem(43954, 1);
			break;
		case 143: // X-51 Nether-Rocket X-TREME
			CloseGossipMenuFor(player);
			player->AddItem(35226, 1);
			break;
		case 144: // X-53 Touring Rocket
			CloseGossipMenuFor(player);
			player->AddItem(54860, 1);
			break;
		case 145: // Frozen Frost Wyrm Heart
			CloseGossipMenuFor(player);   // 33182 Swift Flying Broom // // 33184 Swift Magic Broom // 37011 Magic Broom // 33183 ld Magic Broom
			player->AddItem(38690, 1);
			break;
		case 1218:
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "Reins of the Black Proto-Drake", GOSSIP_SENDER_MAIN, 160);
			AddGossipItemFor(player,5, "Reins of the Blue Proto-Drake", GOSSIP_SENDER_MAIN, 161);
			AddGossipItemFor(player,5, "Reins of the Green Proto-Drake", GOSSIP_SENDER_MAIN, 162);
			AddGossipItemFor(player,5, "Reins of the Ironbound Proto-Drake", GOSSIP_SENDER_MAIN, 163);
			AddGossipItemFor(player,5, "Reins of the Plagued Proto-Drake", GOSSIP_SENDER_MAIN, 164);
			AddGossipItemFor(player,5, "Reins of the Red Proto-Drake", GOSSIP_SENDER_MAIN, 165);
			AddGossipItemFor(player,5, "Reins of the Rusted Proto-Drake", GOSSIP_SENDER_MAIN, 166);
			AddGossipItemFor(player,5, "Reins of the Time-Lost Proto-Drake", GOSSIP_SENDER_MAIN, 167);
			AddGossipItemFor(player,5, "Reins of the Violet Proto-Drake", GOSSIP_SENDER_MAIN, 168);
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
			break;
		case 160: // Reins of the Black Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(44164, 1);
			break;
		case 161: // Reins of the Blue Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(44151, 1);
			break;
		case 162: // Reins of the Green Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(44707, 1);
			break;
		case 163: // Reins of the Ironbound Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(45801, 1);
			break;
		case 164: // Reins of the Plagued Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(44175, 1);
			break;
		case 165: // Reins of the Red Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(44160, 1);
			break;
		case 166: // Reins of the Rusted Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(45802, 1);
			break;
		case 167: // Reins of the Time-Lost Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(44168, 1);
			break;
		case 168: // Reins of the Violet Proto-Drake
			CloseGossipMenuFor(player);
			player->AddItem(44177, 1);
			break;
		case 1209: // Remove Resurrection Sickness Aura
			if (!player->HasAura(15007))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_NO_SICKENSS, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->RemoveAurasDueToSpell(15007);
				player->SetHealth(player->GetMaxHealth()); //Restore Health
				player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA)); // Restore Mana
				creature->Whisper(MSG_REMOVE_SICKNESS_COMPLETE, LANG_UNIVERSAL, player);
			}
			break;
		case 1210: // Remove Deserter Aura
			if (!player->HasAura(26013))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_NO_DESERTER, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->RemoveAurasDueToSpell(26013);
				creature->Whisper(MSG_REMOVE_DESERTER_COMPLETE, LANG_UNIVERSAL, player);
			}
			break;
		case 1213: // Save Character Online
			CloseGossipMenuFor(player);
			player->SaveToDB(false, false);
			creature->Whisper(MSG_CHARACTER_SAVE_TO_DB, LANG_UNIVERSAL, player);
			break;
		case 250: // Classic
			CloseGossipMenuFor(player);
			player->SendMovieStart(2);
			break;
		case 251: // The Wrath Gate
			CloseGossipMenuFor(player);
			player->SendMovieStart(14);
			break;
		case 252: // Fall of The Lich King
			CloseGossipMenuFor(player);
			player->SendMovieStart(16);
			break;
		case 1215: // Сброк КД Квестов
			CloseGossipMenuFor(player);
			player->ResetDailyQuestStatus();
			player->ResetWeeklyQuestStatus();
			creature->Whisper(MSG_RESET_QUEST_STATUS_COMPLETE, LANG_UNIVERSAL, player);
			break;
		case 1250: // Воин
			if (player->HasItemCount(80052, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80052, 1);
			}
			break;
		case 1251: // Паладин
			if (player->HasItemCount(80053, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80053, 1);
			}
			break;
		case 1252: // Охотник
			if (player->HasItemCount(80055, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80055, 1);
			}
			break;
		case 1253: // Разбойник
			if (player->HasItemCount(80058, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80058, 1);
			}
			break;
		case 1254: // Жрец
			if (player->HasItemCount(80059, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80059, 1);
			}
			break;
		case 1255: // Шаман
			if (player->HasItemCount(80057, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80057, 1);
			}
			break;
		case 1256: // Маг
			if (player->HasItemCount(80060, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80060, 1);
			}
			break;
		case 1257: // Чернокжник
			if (player->HasItemCount(80061, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80061, 1);
			}
			break;
		case 1258: // Друид
			if (player->HasItemCount(80056, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80056, 1);
				player->AddItem(80062, 1);
			}
			break;
		case 1259: // Рыцарь Смерти
			if (player->HasItemCount(80054, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(80054, 1);
			}
			break;
		case 1216: // 36 Slot Bag
			if (player->HasItemCount(300048, 1))
			{
				CloseGossipMenuFor(player);
				creature->Whisper(EMOTE_ALREADY_ITEM, LANG_UNIVERSAL, player);
			}
			else
			{
				CloseGossipMenuFor(player);
				player->AddItem(300048, 1);
				player->AddItem(300118, 1);
				player->AddItem(300194, 1);
			}
			break;
		case 1220: // ViP-Wings
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player,5, "|TInterface/ICONS/Inv_shoulder_56:20|t ViP-Wigns [Сила]", GOSSIP_SENDER_MAIN, 7003);
			AddGossipItemFor(player,5, "|TInterface/ICONS/Inv_shoulder_56:20|t ViP-Wigns [Ловкость]", GOSSIP_SENDER_MAIN, 7004);
			AddGossipItemFor(player,5, "|TInterface/ICONS/Inv_shoulder_56:20|t ViP-Wigns [Интеллект]", GOSSIP_SENDER_MAIN, 7005);
			SendGossipMenuFor(player, 200034, creature->GetGUID());
			break;
		}
		return true;
	}
};

void AddSC_npc_premium_master()
{
	new npc_premium_master;
}
