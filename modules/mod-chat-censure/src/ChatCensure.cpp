#include "Channel.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Configuration/Config.h"
#include "Chat.h"

class System_Censure : public PlayerScript
{
    public:
        System_Censure() : PlayerScript("System_Censure") {}

        void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg)
        {
            CheckMessage(player, msg, lang, NULL, NULL, NULL, NULL);
        }

        void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Player* receiver)
        {
            CheckMessage(player, msg, lang, receiver, NULL, NULL, NULL);
        }

        void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Group* group)
        {
            CheckMessage(player, msg, lang, NULL, group, NULL, NULL);
        }

        void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Guild* guild)
        {
            CheckMessage(player, msg, lang, NULL, NULL, guild, NULL);
        }

        void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Channel* channel)
        {
            CheckMessage(player, msg, lang, NULL, NULL, NULL, channel);
        }

    void CheckMessage(Player* player, std::string& msg, uint32 lang, Player* /*receiver*/, Group* /*group*/, Guild* /*guild*/, Channel* channel)
    {
        if (player->IsGameMaster() || lang == LANG_ADDON)
            return;

        // transform to lowercase (for simpler checking)
        std::string lower = msg;
        std::transform(lower.begin(), lower.end(), lower.begin(), ::tolower);

        const uint8 cheksSize = 39;
        std::string checks[cheksSize];
        checks[0] ="http://";
        checks[1] =".com";
        checks[2] =".www";
        checks[3] =".net";
        checks[4] =".org";
        checks[5] =".ru";
        checks[6] ="www.";
        checks[7] ="wow-";
        checks[8] ="sirus.su";
        checks[9] ="uwow.biz";
        checks[10] ="wowcircle.com";
        checks[11] ="epicwow.com";
        checks[12] ="andarius.ru";
        checks[13] ="wowrandom.ru";
        checks[14] ="extazy-gaming.com";
        checks[15] ="wow.opiums.eu";
        checks[16] ="moonwell.su";
        checks[17] ="wow-liberum.ru";
        checks[18] ="alterac-pvp.online";
        checks[19] ="skyblood.ru";
        checks[20] ="darth.wowka.su";
        checks[21] ="wowka.su";
        checks[22] ="wow-age.ru";
        checks[23] ="hf-server.ru";
        checks[24] ="noblegarden.net";
        checks[25] ="turbo-wow.ru";
        checks[26] ="superwow.ru";
        checks[27] ="wow-age.r-u";
        checks[28] ="w-ow-age.r-u";
        checks[29] ="wo-w-age.r-u";
        checks[30] ="wo-w-age.ru";
        checks[31] ="wow-a-ge.r-u";
        checks[32] ="wow-a-ge.ru";
        checks[33] ="wow-age.r-u";
        checks[34] ="wow-age.r-u";
        checks[35] ="wow-age.r-u";
        checks[36] ="wow-age.r-u";
        checks[37] ="wow-age.r-u";
        checks[38] = "wow-age.ru";

        for (int i = 0; i < cheksSize; ++i)
             if (lower.find(checks[i]) != std::string::npos)
             {
                 msg = "";
                 ChatHandler(player->GetSession()).PSendSysMessage("Вы не можете отправлять такого рода сообщения!!");
                 return;
             }
    }
};

void AddMyChatCensureScripts()
{
    new System_Censure();
}
