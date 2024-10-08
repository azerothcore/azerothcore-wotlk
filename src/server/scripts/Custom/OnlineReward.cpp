#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "DBCStores.h"
#include "Mail.h"
#include "Chat.h"
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
            time_t t1 = time(NULL);
            tm t = *localtime(&t1);
            std::stringstream m2t;
            m2t << std::to_string(t.tm_hour) << ":" << std::to_string(t.tm_min);
            std::string text = m2t.str().c_str();

            if (count > 0)
            {
                if (text == "0:0")
                    SendMail();
                if (text == "1:0")
                    SendMail();
                if (text == "2:0")
                    SendMail();
                if (text == "3:0")
                    SendMail();
                if (text == "4:0")
                    SendMail();
                if (text == "5:0")
                    SendMail();
                if (text == "6:0")
                    SendMail();
                if (text == "7:0")
                    SendMail();
                if (text == "8:0")
                    SendMail();
                if (text == "9:0")
                    SendMail();
                if (text == "10:0")
                    SendMail();
                if (text == "11:0")
                    SendMail();
                if (text == "12:0")
                    SendMail();
                if (text == "13:0")
                    SendMail();
                if (text == "14:0")
                    SendMail();
                if (text == "15:0")
                    SendMail();
                if (text == "16:0")
                    SendMail();
                if (text == "17:0")
                    SendMail();
                if (text == "18:0")
                    SendMail();
                if (text == "19:0")
                    SendMail();
                if (text == "20:0")
                    SendMail();
                if (text == "21:0")
                    SendMail();
                if (text == "22:0")
                    SendMail();
                if (text == "23:0")
                    SendMail();
                if (text == "24:0")
                    SendMail();
            }
            else{}

            _events.ScheduleEvent(1, updateInterval * IN_MILLISECONDS);
        }
    }
    void GetData() 
    {
        QueryResult qrs1 = CharacterDatabase.Query("SELECT COUNT(*) FROM online_gift");
        count = (*qrs1)[0].Get<uint8>();
        if (count > 0)
        {
            QueryResult qrs2 = CharacterDatabase.Query("Select items FROM online_gift");
            std::string* itemsinfo = new std::string[count];
            for (int i = 0; i < count; i++)
            {
                itemsinfo[i] = (*qrs2)[0].Get<std::string>();
                (*qrs2).NextRow();
            }
            ItemsGift = new uint32[count];
            ItemsCount = new uint32[count];
            for (int i = 0; i < count; i++)
            {
                int iPos = itemsinfo[i].find(":");
                ItemsGift[i] = atoi(itemsinfo[i].substr(0, iPos).c_str());
                ItemsCount[i] = atoi(itemsinfo[i].substr(iPos+1).c_str());
            }
            LOG_INFO("server.loading", "[Online_Giflt]: Загрузка items прошла успелно!");
        }
        else
        {
            return;
        }
    }
    void OnStartup() override
    {
        _events.ScheduleEvent(1, updateInterval * IN_MILLISECONDS);
        GetData();
    }

    void SendMail()
    {
        auto& players = ObjectAccessor::GetPlayers();
        for (auto itr = players.begin(); itr != players.end(); itr++)
        {

            MailSender sender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM);
            MailDraft draft("Награда за Онлайн", "Данную награду вы получили за онлайн на нашем сервере!");
            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            for (unsigned long i = 0; i < count; i++)
            {
                Item* item = Item::CreateItem(ItemsGift[i], ItemsCount[i], itr->second);
                if (item)
                {
                    item->SaveToDB(trans);
                    draft.AddItem(item);
                }
            }
            draft.SendMailTo(trans, MailReceiver(itr->second, itr->second->GetGUID().GetCounter()), sender);
            CharacterDatabase.CommitTransaction(trans);

            ChatHandler(itr->second->GetSession()).PSendSysMessage("|cff44CC00[Онлайн Награда]:|r Вам было выслано письмо с наградой!");
        }
    }

private:
    const uint32 updateInterval = 1 * MINUTE;
    uint32* ItemsGift = nullptr;
    uint32* ItemsCount = nullptr;
    uint8 count = 0;
    EventMap _events;
};

void AddSC_PlayedTimeRewards()
{
    new played_time_rewards_WorldScript();
}