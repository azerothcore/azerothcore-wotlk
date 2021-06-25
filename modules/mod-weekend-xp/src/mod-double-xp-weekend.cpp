#include "Configuration/Config.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Chat.h"
#include <time.h>

bool Enabled;
uint32 xpAmount;
time_t t = time(NULL);
tm *now = localtime(&t);

class DoubleXpWeekend : public PlayerScript
{
public:
    DoubleXpWeekend() : PlayerScript("DoubleXpWeekend") {}

        void OnLogin(Player* player) override
        {
            // Announce to the player that the XP weekend is happeneing.
            if (!Enabled)
                return;

            if (now->tm_wday == 5 /*Friday*/ || now->tm_wday == 6 /*Satureday*/ || now->tm_wday == 0/*Sunday*/)
                ChatHandler(player->GetSession()).PSendSysMessage("Its the Weekend! Your XP rate has been set to: %u", xpAmount);
            else
                ChatHandler(player->GetSession()).PSendSysMessage("This server is running the |cff4CFF00Double Xp Weekend |rmodule.");
        }

        void OnGiveXP(Player* /*p*/, uint32& amount, Unit* /*victim*/) override
        {
            if (!Enabled)
                return;

            if (now->tm_wday == 5 /*Friday*/ || now->tm_wday == 6 /*Satureday*/ || now->tm_wday == 0/*Sunday*/)
                amount *= xpAmount;
        }
};

class DoubleXpWeekendConf : public WorldScript
{
public:
    DoubleXpWeekendConf() : WorldScript("DoubleXpConf") {}

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            Enabled = sConfigMgr->GetBoolDefault("XPWeekend.Enabled", true);
            xpAmount = sConfigMgr->GetIntDefault("XPWeekend.xpAmount", 2);

        }
    }
};


void AdddoublexpScripts()
{
    new DoubleXpWeekendConf();
    new DoubleXpWeekend();
}
