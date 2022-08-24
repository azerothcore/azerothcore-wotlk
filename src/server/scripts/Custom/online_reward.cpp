#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "DBCStores.h"
#include "Mail.h"
#include "Item.h"
#include "DatabaseEnv.h"

class played_time_rewards_WorldScript : WorldScript
{
public:
	played_time_rewards_WorldScript() : WorldScript("played_time_rewards") { }

	void OnUpdate(uint32 diff) override
	{
		_events.Update(diff);

		if (_events.ExecuteEvent())
		{
			auto &players = ObjectAccessor::GetPlayers();

			for (auto itr = players.begin(); itr != players.end(); itr++)
			{
				uint32 played = itr->second->GetTotalPlayedTime();

				if (IsDay(played, 740))
				{
					if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(141))
						itr->second->SetTitle(titleInfo);

					SendMail(itr->second, 90705);
				}
				else if (IsDay(played, 240))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 238))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 236))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 234))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 232))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 230))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 228))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 226))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 224))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 222))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 220))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 218))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 216))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 214))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 212))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 210))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 208))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 206))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 204))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 202))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 200))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 198))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 196))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 194))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 192))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 190))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 188))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 186))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 184))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 182))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 180))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 178))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 176))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 174))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 172))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 170))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 168))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 164))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 162))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 160))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 158))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 156))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 154))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 152))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 150))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 148))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 146))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 144))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 142))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 140))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 138))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 136))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 134))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 132))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 130))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 128))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 126))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 124))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 122))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 120))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 118))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 116))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 114))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 112))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 110))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 108))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 106))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 104))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 102))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 100))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 98))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 96))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 94))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 92))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 90))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 88))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 86))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 84))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 82))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 80))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 78))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 76))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 74))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 72))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 70))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 68))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 66))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 64))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 62))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 60))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 58))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 56))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 54))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 52))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 50))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 48))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 46))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 44))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 42))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 40))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 38))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 36))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 34))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 32))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 30))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 28))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 26))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 24))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 22))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 20))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 16))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 14))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 12))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 10))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 8))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 6))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 4))
					SendMail(itr->second, 90705);
				else if (IsDay(played, 2))
					SendMail(itr->second, 90705);
			}

			_events.ScheduleEvent(1, updateInterval * IN_MILLISECONDS);
		}
	}

	void OnStartup() override
	{
		_events.ScheduleEvent(1, updateInterval * IN_MILLISECONDS);
	}

	bool IsDay(uint32 played, uint32 hour)
	{
		return played >= (hour * HOUR) && played <= ((hour * HOUR) + updateInterval);
	}

	void SendMail(Player* player, uint32 itemId)
	{
		MailSender sender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM);
		MailDraft draft("Награда за время в игре!", "Вы получили эту награду, т.к провели в игре достаточно много времени, продолжайте, чтобы получить еще больше наград!");
		auto trans = CharacterDatabase.BeginTransaction();

		if (Item* item = Item::CreateItem(itemId, 5, 0))
		{
			item->SaveToDB(trans);              // Save to prevent being lost at next mail load. If send fails, the item will be deleted.
			draft.AddItem(item);
		}

		draft.SendMailTo(trans, MailReceiver(player), sender);
		CharacterDatabase.CommitTransaction(trans);
	}

private:
	const uint32 updateInterval = 10 * MINUTE;

	EventMap _events;
};

void AddSC_PlayedTimeRewards()
{
	new played_time_rewards_WorldScript();
}
