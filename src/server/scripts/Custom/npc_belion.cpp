/*
* Patch: NPC Bonus Buff - Boss respawn - Exchange
* By: r0m1ntik
* Date: 25.04.2019
*/

#include <cstring>
#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "Player.h"
#include "WorldSession.h"


using namespace std;

struct BuffData
{
	uint32 Entry;
	uint8  Cost;
	string Name;
	string SubName;
};

BuffData vvData[] =
{
	{ 46587, 20, "Берсерк", "Повышает скорость атаки на 30% и урона на 20% на 1 час" },
	{ 26035, 15, "Счастливый", "+10% ко всем характеристикам на 30 мин" }
};

/* выводим количество VP на акке у игрока */
uint32 GetBonus(Player* player)
{
	uint32 accId = player->GetSession()->GetAccountId();
	QueryResult result = CharacterDatabase.Query("SELECT vp FROM srv175729_blizzcms.users WHERE id = {}", accId);
	Field *field = result->Fetch();
     if (!result)
    {
        player->GetSession()->SendAreaTriggerMessage("Ошибка! Сообщите Администратору!");
        return false;
    }
    else  
    return field[0].Get<uint32>();
}

/* выводим количество DP на акке у игрока */
uint32 GetBonusDP(Player* player)
{
	uint32 accId = player->GetSession()->GetAccountId();
	QueryResult result = CharacterDatabase.Query("SELECT dp FROM srv175729_blizzcms.users WHERE id = {}", accId);
	Field *field = result->Fetch();
    if (!result)
    {
        player->GetSession()->SendAreaTriggerMessage("Ошибка! Сообщите Администратору!");
        return false;
    } 
    else
	return field[0].Get<uint32>();
}

void DelBonus(Player* player, uint32 bonus)
{
	uint32 accId = player->GetSession()->GetAccountId();
	CharacterDatabase.Query("UPDATE srv175729_blizzcms.users SET vp = vp - {} WHERE id = {}", bonus, accId);
}

void DelBonusDP(Player* player, uint32 bonus)
{
	uint32 accId = player->GetSession()->GetAccountId();
	CharacterDatabase.Query("UPDATE srv175729_blizzcms.users SET dp = dp - {} WHERE id = {}", bonus, accId);
}

void AddBonusVP(Player* player, uint32 bonus)
{
	uint32 accId = player->GetSession()->GetAccountId();
	CharacterDatabase.Query("UPDATE srv175729_blizzcms.users SET vp = vp + {} WHERE id = {}", bonus, accId);
}

/* выводим время респавна моба */
uint64 GetRespawnTime(Player* player, uint64 guid)
{
	QueryResult queryResult = CharacterDatabase.Query("SELECT respawnTime FROM creature_respawn WHERE guid = {}", guid);
	if (!queryResult)
		return 0;
	else
	{
		Field *field = queryResult->Fetch();
		return field[0].Get<uint64>();
	}
}

/* выводим онлайн игроков и выдает бафф */
void GetBuffOnline(uint32 i)
{
	SessionMap const& sessions = sWorld->GetAllSessions();
	for (SessionMap::const_iterator it = sessions.begin(); it != sessions.end(); ++it)
	{
		if (Player* player = it->second->GetPlayer())
		{
			if (player->IsInWorld() && !player->GetMap()->IsBattlegroundOrArena())
				player->AddAura(vvData[i].Entry, player);
		}
	}
}

std::string GetNameSpell(uint8 i)
{
	std::string str = vvData[i].Name + " - стоймость|cff065961 " + std::to_string(vvData[i].Cost) + "|r бонусов\n|cff065961" + vvData[i].SubName;
	return str;
}

class npc_bonus_buff : public CreatureScript
{
public: npc_bonus_buff() : CreatureScript("npc_bonus_buff") { }

		bool OnGossipHello(Player* player, Creature* creature)
		{
			std::string name = player->GetName();
			std::ostringstream info;

			ClearGossipMenuFor(player);
            info << "Приветствую, " << name << "\n\nНа вашем счету:\n|cff065961" << GetBonus(player) << "|r очков голосования.\n|cff065961" << GetBonusDP(player) << "|r очков пожертвования.\n";

			AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Achievement_bg_killingblow_most:25:25:-20:0|tТаймер Мировых Боссов", GOSSIP_SENDER_MAIN, 1);
			AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_valentinesboxofchocolates02:25:25:-20:0|tБаффнуть всех -|cff065961 ОНЛАЙН|r", GOSSIP_SENDER_MAIN, 3);
			AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Achievement_pvp_o_05:25:25:-20:0|tОбменять Доступ-Карты|r", GOSSIP_SENDER_MAIN, 16);
			AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Trade_engineering:25:25:-20:0|tИзменить персонажа", GOSSIP_SENDER_MAIN, 17);
			AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_01:25:25:-20:0|tОбмен очков голосования", GOSSIP_SENDER_MAIN, 2);
			AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_02:25:25:-20:0|tОбмен очков пожертвования", GOSSIP_SENDER_MAIN, 11);
            player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), creature->GetGUID());
            return true;
		}

		bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
		{
			ClearGossipMenuFor(player);
			if (sender == GOSSIP_SENDER_MAIN)
			{
				switch (action)
				{
				case 1: /* Таймер мировых боссов */
				{
							std::ostringstream femb;
							time_t current_time = time(0);
							int time_stamp = int(current_time);

							std::string resp_1 = GetRespawnTime(player, 4360017) == 0 ? "|cff02A4B1[Лорд]|CFFE55BB0 Жив. Вперед, убейте его!" : "|cff02A4B1[Лорд]|CFFE55BB0 мертв, реснется через |cff02A4B1" + secsToTimeString(GetRespawnTime(player, 4360017) - time_stamp);
							std::string resp_2 = GetRespawnTime(player, 4660737) == 0 ? "|cff02A4B1[Иллидан]|CFFE55BB0 Жив. Вперед, убейте его!" : "|cff02A4B1[Иллидан]|CFFE55BB0 мертв, реснется через |cff02A4B1" + secsToTimeString(GetRespawnTime(player, 4660737) - time_stamp);
							std::string resp_3 = GetRespawnTime(player, 3932621) == 0 ? "|cff02A4B1[Эфириал]|CFFE55BB0 Жив. Вперед, убейте его!" : "|cff02A4B1[Эфириал]|CFFE55BB0 мертв, реснется через |cff02A4B1" + secsToTimeString(GetRespawnTime(player, 3932621) - time_stamp);
							std::string resp_4 = GetRespawnTime(player, 2376962) == 0 ? "|cff02A4B1[Инквизитор]|CFFE55BB0 Жив. Вперед, убейте его!" : "|cff02A4B1[Инквизитор]|CFFE55BB0 мертв, реснется через |cff02A4B1" + secsToTimeString(GetRespawnTime(player, 2376962) - time_stamp);
							std::string resp_5 = GetRespawnTime(player, 4352959) == 0 ? "|cff02A4B1[Изера]|CFFE55BB0 Жива. Вперед, убейте её!" : "|cff02A4B1[Изера]|CFFE55BB0 мертва, реснется через |cff02A4B1" + secsToTimeString(GetRespawnTime(player, 4352959) - time_stamp);
							std::string resp_6 = GetRespawnTime(player, 3993244) == 0 ? "|cff02A4B1[Кил'Джеден]|CFFE55BB0 Жив. Вперед, убейте его!" : "|cff02A4B1[Кил'Джеден]|CFFE55BB0 мертв, реснется через |cff02A4B1" + secsToTimeString(GetRespawnTime(player, 3993244) - time_stamp);

							std::ostringstream announce;
							announce << "|cff02A4B1[Таймер Боссов]\n" << resp_1 << "\n" << resp_2 << "\n" << resp_3 << "\n" << resp_4 << "\n" << resp_5 << "\n" << resp_6;
							ChatHandler(player->GetSession()).PSendSysMessage(announce.str().c_str());
							CloseGossipMenuFor(player);
				}
					break;

				case 2: /* Обменик бонусов */
				{
							std::string name = player->GetName();
							std::ostringstream info;
						    info << "Приветствую, " << name << "\n\nНа вашем счету:\n|cff065961" << GetBonus(player) << "|r очков голосования.\n\n"
								<< "В данном меню вы сможете обменять ваши бонусы на [Vote-Token].\nВыберите нужный вам пункт:";

							ClearGossipMenuFor(player);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_05:25:25:-20:0|t5 бонусов на [Vote-Token]x5", GOSSIP_SENDER_MAIN, 5);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_03:25:25:-20:0|t50 бонусов на [Vote-Token]x50", GOSSIP_SENDER_MAIN, 6);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_01:25:25:-20:0|t100 бонусов на [Vote-Token]x100", GOSSIP_SENDER_MAIN, 7);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:25:25:-20:0|tНазад", GOSSIP_SENDER_MAIN, 4);
                            player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), creature->GetGUID());
				}
					break;

				case 11: /* Обменик DP => VP */
				{
							std::string name = player->GetName();
							std::ostringstream info;
							info << "Приветствую, " << name << "\n\nНа вашем счету:\n|cff065961" << GetBonus(player) << "|r очков голосования.\n|cff065961" << GetBonusDP(player) << "|r очков пожертвования.\n\n"
								<< "DP - очки пожертвования\n"
								<< "VP - очки голосования\n"
							    << "Выберите нужный вам пункт:";

							ClearGossipMenuFor(player);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_05:25:25:-20:0|t10 DP на 10 бонусов", GOSSIP_SENDER_MAIN, 8, "Вы уверены?", 0, false);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_03:25:25:-20:0|t50 DP на 50 бонусов", GOSSIP_SENDER_MAIN, 9, "Вы уверены?", 0, false);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_01:25:25:-20:0|t100 DP на 100 бонусов", GOSSIP_SENDER_MAIN, 10, "Вы уверены?", 0, false);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_06:25:25:-20:0|t500 DP на [Монета-Donate]x500", GOSSIP_SENDER_MAIN, 12, "Вы уверены?", 0, false);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_04:25:25:-20:0|t1000 DP на [Монета-Donate]x1000", GOSSIP_SENDER_MAIN, 13, "Вы уверены?", 0, false);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Inv_misc_coin_02:25:25:-20:0|t2000 DP на [Монета-Donate]x2000", GOSSIP_SENDER_MAIN, 14, "Вы уверены?", 0, false);
							AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:25:25:-20:0|tНазад", GOSSIP_SENDER_MAIN, 4);
                            player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), creature->GetGUID());
				}
					break;

				case 3: /* Бонус баффы */
				{
							std::string name = player->GetName();
							std::ostringstream info;

							ClearGossipMenuFor(player);
							info << "Приветствую, " << name << "\n\nНа вашем счету |cff065961" << GetBonus(player)
								<< "|r бонусов.\n\nВы можете выдать временный бафф всем онлайн игрокам.\n"
								<< "|cff065961Баффы не выдаются игрокам на арене/бг и духам.|r\n\n"
								<< "Список доступных баффов:";

							for (uint8 i = 0; i < (sizeof(vvData) / sizeof(*vvData)); i++)
								AddGossipItemFor(player,GOSSIP_ICON_BATTLE, GetNameSpell(i), GOSSIP_SENDER_MAIN + 1, i);

							AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Назад в главное меню", GOSSIP_SENDER_MAIN, 4);
                            player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), creature->GetGUID());
				}
					break;

				case 4:
					OnGossipHello(player, creature);
					break;

				case 5:
				case 6:
				case 7:
				{
						  uint32 need = action == 5 ? 5 : action == 6 ? 50 : 100;
						  if (GetBonus(player) < need)
						  {
							  ChatHandler(player->GetSession()).PSendSysMessage("У вас не хватает бонусов.\nНужно %u", need);
						  }
						  else
						  {
							  DelBonus(player, need);
							  player->AddItem(90201, need);
							  ChatHandler(player->GetSession()).PSendSysMessage("Вы успешно получили [Vote-Token] x %u\nПотратив на это %u бонусов.", need, need);
						  }
						  CloseGossipMenuFor(player);
				}
					break;
				case 8:
				case 9:
				case 10:
				{
						   uint32 need = action == 8 ? 10 : action == 9 ? 50 : 100;
						  if (GetBonusDP(player) < need)
						  {
							  ChatHandler(player->GetSession()).PSendSysMessage("У вас не хватает очков пожертвования.\nНужно %u", need);
						  }
						  else
						  {
							  DelBonusDP(player, need);
							  AddBonusVP(player, need);
							  ChatHandler(player->GetSession()).PSendSysMessage("Вы успешно получили [%u] очков голосования.\nПотратив на это [%u] очков пожертвования.", need, need);
						  }
						  CloseGossipMenuFor(player);
				}
					break;
				case 12:
				case 13:
				case 14:
				{
						   uint32 need = action == 12 ? 500 : action == 13 ? 1000 : 2000;
						   if (GetBonusDP(player) < need)
						   {
							   ChatHandler(player->GetSession()).PSendSysMessage("У вас не хватает очков пожертвования.\nНужно %u", need);
						   }
						   else
						   {
							   DelBonusDP(player, need);
							   player->AddItem(90033, need);
							   ChatHandler(player->GetSession()).PSendSysMessage("Вы успешно получили [%u] Монета-Donate.\nПотратив на это [%u] очков пожертвования.", need, need);
						   }
						   CloseGossipMenuFor(player);
				}
					break;
				case 15:
				{
						   if (player->HasItemCount(100502, 1) && player->HasItemCount(100503, 1) && player->HasItemCount(100504, 1))
						   {
							   CloseGossipMenuFor(player);
							   player->DestroyItemCount(100502, 1, true, false);
							   player->DestroyItemCount(100503, 1, true, false);
							   player->DestroyItemCount(100504, 1, true, false);
							   player->AddItem(100510, 1);
						   }
						   else
						   {
							   CloseGossipMenuFor(player);
							   ChatHandler(player->GetSession()).PSendSysMessage("Необходимо иметь все Доступ-Карты [3]");
						   }
				}
					break;
				case 16:
				{
						   std::string name = player->GetName();
						   std::ostringstream info;
						   info << "Приветствую, " << name << "\n\nНа вашем счету |cff065961" << GetBonus(player) << "|r бонусов.\n\n"
							   << "В данном меню вы сможете обменять ваши [Доступ]карты на одну:\n-Доступ 255 \n-Доступ 300\n-Доступ в Огненные Недра\nКроме [Доступ в Крепость Бурь]\n";

						   ClearGossipMenuFor(player);
						   AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Achievement_pvp_o_05:25:25:-20:0|tОбменять Доступ-Карты|r", GOSSIP_SENDER_MAIN, 15);
						   AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:25:25:-20:0|tНазад", GOSSIP_SENDER_MAIN, 4);
                           player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), creature->GetGUID());
				}
					break;
				case 17:
				{
						   std::string name = player->GetName();
						   std::ostringstream info;
						   info << "Приветствую, " << name << "\n\nНа вашем счету |cff065961" << GetBonus(player) << "|r бонусов.\n\n"
							   << "В данном меню вы можете изменить имя или фракцию персонажа\n\n";

						   ClearGossipMenuFor(player);
						   AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Trade_engineering:25:25:-20:0|tИзменить Имя|r - [Vote-Token] х10", GOSSIP_SENDER_MAIN, 18);
						   AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Trade_engineering:25:25:-20:0|tИзменить фракцию|r - [Vote-Token] х20", GOSSIP_SENDER_MAIN, 20);
						//   AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/ICONS/Trade_engineering:25:25:-20:0|tИсправить [Вы не знаете этого языка]", GOSSIP_SENDER_MAIN, 21);
						   AddGossipItemFor(player,GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:25:25:-20:0|tНазад", GOSSIP_SENDER_MAIN, 4);
                           player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), creature->GetGUID());
				}
					break;
				case 18:
				{
						   if (player->HasItemCount(90201, 10))
						   {
							   CloseGossipMenuFor(player);
							   player->DestroyItemCount(90201, 20, true, false);
							   player->SetAtLoginFlag(AT_LOGIN_RENAME);
							   creature->Whisper("Перезайдите и введите новое имя персонажа. Не забудьте после изменения имени выйти и удалить из папки клиента кэш!", LANG_UNIVERSAL, player);
						   }
						   else
						   {
							   CloseGossipMenuFor(player);
							   creature->Whisper("Недостаточно Vote-Token.", LANG_UNIVERSAL, player);
						   }
				}
					break;
				case 20:
				{
						   if (player->HasItemCount(90201, 20))
						   {
							   CloseGossipMenuFor(player);
							   player->DestroyItemCount(90201, 20, true, false);
							   player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
							   creature->Whisper("Перезайдите для смены фракции. Не забудьте после изменения имени выйти и удалить из папки клиента кэш!", LANG_UNIVERSAL, player);
						   }
						   else
						   {
							   CloseGossipMenuFor(player);
							   creature->Whisper("Недостаточно Vote-Token.", LANG_UNIVERSAL, player);
						   }
				}
					break;
				case 21:
				{
						   if (player->GetTeamId() == TEAM_HORDE)
						   {
							   CloseGossipMenuFor(player);
							   player->removeSpell(669, SPEC_MASK_ALL, false);
							   player->learnSpell(669);
							   player->SaveToDB(false, false);
						   }
						   else
						   {
							   CloseGossipMenuFor(player);
							   player->removeSpell(668, SPEC_MASK_ALL, false);
							   player->learnSpell(668);
							   player->SaveToDB(false, false);
						   }
						   creature->Whisper("Исправленно, теперь вы можете говорить.", LANG_UNIVERSAL, player);
				}
					break;
				}
			}
			if (sender == GOSSIP_SENDER_MAIN + 1)
			{
				if (GetBonus(player) < vvData[action].Cost)
					ChatHandler(player->GetSession()).PSendSysMessage("У вас не хватает бонусов.");
				else
				{
					std::string name = player->GetName();
					std::ostringstream message;
					message << "|cff5da673[BELION]|CFFFE8A0E Игрок |CFFE55BB0" << name << "|CFFFE8A0E баффнул всех игроков баффом [|cffEAF4F5" << vvData[action].Name << "|cff02A4B1]|r";
					GetBuffOnline(action);
					CharacterDatabase.Query("UPDATE srv175729_blizzcms.users SET vp = vp - {} WHERE id = {}", vvData[action].Cost, player->GetSession()->GetAccountId());
					sWorld->SendServerMessage(SERVER_MSG_STRING, message.str().c_str());
					CloseGossipMenuFor(player);
				}
			}
			return true;
		}
};

class Login_script : public PlayerScript
{
public:
	Login_script() : PlayerScript("Login_script") {}

	void OnLogin(Player* player)
	{
		uint32 accId = player->GetSession()->GetAccountId();
		QueryResult result = CharacterDatabase.Query("SELECT vp FROM srv175729_blizzcms.users WHERE id = {}", accId);
		if (!result)
			CharacterDatabase.Query("INSERT INTO srv175729_blizzcms.users (id, dp, vp) VALUES ({}, 0, 0)", accId);
	}
};

void AddSC_npc_bonus_buff()
{
	new npc_bonus_buff();
    new Login_script();
}
