#include "ScriptPCH.h"
#include "TicketMgr.h"
#include "GameTime.h"

class gm_login : public PlayerScript
{
public:
	gm_login() : PlayerScript("gm_login") { }

	void OnLogin(Player* player)
	{
		{
			if (player->GetSession()->GetSecurity() >= SEC_MODERATOR)
			{
				ChatHandler handler(player->GetSession());
				uint32 accid = player->GetSession()->GetAccountId();
				uint16 gmlvl = player->GetSession()->GetSecurity();
				std::string gmname = player->GetName();
				uint32 playeronline = sWorld->GetPlayerCount();
				std::string uptime = secsToTimeString(GameTime::GetUptime().count()).c_str();
				std::string player_ip = player->GetSession()->GetRemoteAddress();
				uint16 tickets = sTicketMgr->GetOpenTicketCount();

				handler.PSendSysMessage("|cffff0000=================================|r");
				handler.PSendSysMessage("|cff00ff00Привет,|r %s", gmname.c_str());
				handler.PSendSysMessage("|cff00ff00Ваш уровень учетной записи:|r %u", gmlvl);
				handler.PSendSysMessage("|cff00ff00Ваш IP:|r %s", player_ip.c_str());
				handler.PSendSysMessage("|cff00ff00Сейчас|r %u |cff00ff00игроков онлайн|r", playeronline);
				handler.PSendSysMessage("|cff00ff00Открытые тикеты:|r %u", tickets);
				handler.PSendSysMessage("|cff00ff00Время работы сервера:|r %s", uptime.c_str());
				handler.PSendSysMessage("|cff00ff00Удачи и приятной игры|r");
				handler.PSendSysMessage("|cffff0000=================================|r");
				return;
			}
		}
		if (player->GetSession()->IsPremium())
		{
			ChatHandler handler(player->GetSession());
			uint32 accid = player->GetSession()->GetAccountId();
			std::string gmname = player->GetName();
			uint32 playeronline = sWorld->GetPlayerCount();
			std::string uptime = secsToTimeString(GameTime::GetUptime().count()).c_str();
			std::string player_ip = player->GetSession()->GetRemoteAddress();
			uint16 tickets = sTicketMgr->GetOpenTicketCount();
			handler.PSendSysMessage("|cfffcc141Привет,|r|cff8ab6fc %s|r", gmname.c_str());
			handler.PSendSysMessage("|cfffcc141Сейчас|r |cff8ab6fc%u|r |cfffcc141игроков онлайн|r", playeronline);
			handler.PSendSysMessage("|cfffcc141Время работы сервера:|r |cff8ab6fc%s|r", uptime.c_str());
			handler.PSendSysMessage("|cfffcc141Доступные команды:|r");
			handler.PSendSysMessage("|cff8ab6fc[.vip bank]|cfffcc141 - открыть банк|r");
			handler.PSendSysMessage("|cff8ab6fc[.vip mail]|cfffcc141 - открыть почту|r");
			handler.PSendSysMessage("|cfffcc141Приятной игры.|r|TInterface/ICONS/Achievement_bg_tophealer_wsg:15|t");
			QueryResult result = LoginDatabase.Query("SELECT unsetdate FROM account_premium WHERE id = {}", accid);
			if (result)
			{
				Field * field = result->Fetch();
				uint32 unsetdate = field[0].Get<uint32>();
				std::string timeStr = secsToTimeString(unsetdate - time(NULL), false);
				handler.PSendSysMessage("|cff8ab6fc[VIP] |cfffcc141Аккаунт закончится через:|r");
				handler.PSendSysMessage("|cff8ab6fc%s|r", timeStr.c_str());
			}
			return;
		}
		else
		{
			ChatHandler handler(player->GetSession());
			handler.PSendSysMessage("|cff8ab6fc[VIP] |cfffcc141Премиум аккаунт не активен.|r");
			player->DestroyItemCount(68912, 1, true, false);
			player->DestroyItemCount(68913, 1, true, false);
			player->DestroyItemCount(68914, 1, true, false);
			player->DestroyItemCount(80052, 1, true, false);
			player->DestroyItemCount(80053, 1, true, false);
			player->DestroyItemCount(80054, 1, true, false);
			player->DestroyItemCount(80055, 1, true, false);
			player->DestroyItemCount(80056, 1, true, false);
			player->DestroyItemCount(80057, 1, true, false);
			player->DestroyItemCount(80058, 1, true, false);
			player->DestroyItemCount(80059, 1, true, false);
			player->DestroyItemCount(80060, 1, true, false);
			player->DestroyItemCount(80061, 1, true, false);
			player->DestroyItemCount(80062, 1, true, false);
			player->DestroyItemCount(80090, 1, true, false);
			player->removeSpell(300118, SPEC_MASK_ALL, false);
			player->removeSpell(300048, SPEC_MASK_ALL, false);
			player->removeSpell(300194, SPEC_MASK_ALL, false);
			player->removeSpell(90000, SPEC_MASK_ALL, false);
			CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(178);
			player->SetTitle(titleInfo, true);
		}
	}
};

void AddSC_gm_login()
{
	new gm_login();
}
