#include "ScriptPCH.h"
#include "Chat.h"
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Common.h"
#include "Player.h"
#include "WorldSession.h"
#include "Language.h"
#include "Log.h"
#include "SpellAuras.h"
#include "World.h"
#include "Mail.h"
#include "Item.h"
#include "Config.h"
#include "revision.h"
#include "ObjectMgr.h"
#include "WorldPacket.h"
#include "DatabaseEnv.h"
#include "TicketMgr.h"
#include "Battleground.h"

void SendMail(Player* player, uint32 itemId)
{
	MailSender sender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM);
	MailDraft draft("[DONATE-ALERT]", "Возврат вещей с Поля Боя!");
	auto trans = CharacterDatabase.BeginTransaction();

	if (Item* item = Item::CreateItem(itemId, 1, 0))
	{
		item->SaveToDB(trans);              // Save to prevent being lost at next mail load. If send fails, the item will be deleted.
		draft.AddItem(item);
	}

	draft.SendMailTo(trans, MailReceiver(player), sender);
	CharacterDatabase.CommitTransaction(trans);
}

class Donate_Alert : public PlayerScript
{
public:
	Donate_Alert() : PlayerScript("Donate_Alert") {}

	void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea)
	{
		Battleground* bg = player->GetBattleground();
		if (bg && player->GetMap()->IsBattlegroundOrArena() && bg->GetStatus() == STATUS_WAIT_JOIN)
		{
			ChatHandler handler(player->GetSession());
			if (sGameEventMgr->IsActiveEvent(150))
			{
				handler.PSendSysMessage("|cffff0000[Донат-Время] |cff14ECCFДонат-Вещи |cff913a07запрещены |cff14ECCF на Полях Сражения на 3 часа. |r");
				std::ostringstream donat_alert;
				char const* color;
				color = "|cffff0000[DONATE-ALERT] |cff14ECCF";

				if (player->HasItemCount(500005, 1, false) || player->HasItemCount(500006, 1, false) || player->HasItemCount(500007, 1, false) /* сумки-экстрим */
					|| player->HasItemCount(500055, 1, false) || player->HasItemCount(500056, 1, false) || player->HasItemCount(500057, 1, false) /* сумки-ултимейт */
					|| player->HasItemCount(500058, 1, false) || player->HasItemCount(500059, 1, false) || player->HasItemCount(500060, 1, false)
					|| player->HasItemCount(500010, 1, false) || player->HasItemCount(500011, 1, false) || player->HasItemCount(500012, 1, false)
					|| player->HasItemCount(500013, 1, false) || player->HasItemCount(500014, 1, false) || player->HasItemCount(500015, 1, false)
					|| player->HasItemCount(500016, 1, false) || player->HasItemCount(500017, 1, false) || player->HasItemCount(500018, 1, false)
					|| player->HasItemCount(500019, 1, false)) /* сумки и крылья */
				{
					donat_alert << color << "У вас обнаружены донат вещи.\n"
						<< color << "Пожалуйста выложите их в банк.\n"
						<< color << "Использование доната на Полях Боя - Запрещено!";

					if (player->GetTeamId() == TEAM_HORDE)
						player->TeleportTo(1, 1293.797974f, -4327.997070f, 34.034290f, 1.094702f);
					else
						player->TeleportTo(0, -8958.486328f, 533.348083f, 97.405876f, 1.538157f);
					handler.PSendSysMessage(donat_alert.str().c_str());
				}

				if (player->HasItemCount(90203, 1, false)) /* кольцо-ммотопдд */
				{
					donat_alert << color << "У вас обнаружены донат вещи.\n"
						<< color << "Использование доната на Полях Боя - Запрещено!\n"
						<< color << "Вещи отправлены на вашу почту!";

					handler.PSendSysMessage(donat_alert.str().c_str());
					player->DestroyItemCount(90203, 1, true, false);
					SendMail(player, 90203);
				}
				if (player->HasItemCount(90202, 1, false)) /* кольцо-ммотоп спд */
				{
					donat_alert << color << "У вас обнаружены донат вещи.\n"
						<< color << "Использование доната на Полях Боя - Запрещено!\n"
						<< color << "Вещи отправлены на вашу почту!";

					handler.PSendSysMessage(donat_alert.str().c_str());
					player->DestroyItemCount(90202, 1, true, false);
					SendMail(player, 90202);
				}
				if (player->HasItemCount(500000, 1, false)) /* тринкет */
				{
					donat_alert << color << "У вас обнаружены донат вещи.\n"
						<< color << "Использование доната на Полях Боя - Запрещено!\n"
						<< color << "Вещи отправлены на вашу почту!";

					handler.PSendSysMessage(donat_alert.str().c_str());
					player->DestroyItemCount(500000, 1, true, false);
					SendMail(player, 500000);
				}
				if (player->HasItemCount(500001, 1, false)) /* тринкет */
				{
					donat_alert << color << "У вас обнаружены донат вещи.\n"
						<< color << "Использование доната на Полях Боя - Запрещено!\n"
						<< color << "Вещи отправлены на вашу почту!";

					handler.PSendSysMessage(donat_alert.str().c_str());
					player->DestroyItemCount(500001, 1, true, false);
					SendMail(player, 500001);
				}
				if (player->HasItemCount(500002, 1, false)) /* тринкет */
				{
					donat_alert << color << "У вас обнаружены донат вещи.\n"
						<< color << "Использование доната на Полях Боя - Запрещено!\n"
						<< color << "Вещи отправлены на вашу почту!";

					handler.PSendSysMessage(donat_alert.str().c_str());
					player->DestroyItemCount(500002, 1, true, false);
					SendMail(player, 500002);
				}
			}
			else
				handler.PSendSysMessage("|cffff0000[Донат-Время] |cff14ECCFДонат-Вещи |cff5da673разрешены |cff14ECCF на Полях Сражения на 3 часа. |r");
		}

		if (bg && player->GetMap()->IsBattleArena() && bg->GetStatus() == STATUS_WAIT_JOIN)
		{
			ChatHandler handler(player->GetSession());
			// handler.PSendSysMessage("Вы в зоне Арены, которая вот вот начнётся!");
		}
	}
};

void AddSC_Donate_Alert_System()
{
	new Donate_Alert();
}
