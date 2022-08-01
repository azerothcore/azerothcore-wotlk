/*
    Written by Alistar@AC-WEB
    Discord: Alistar#2047
*/

#include "ScriptMgr.h"
#include "PlayedRewards.h"

class PS_PlayedRewards : public PlayerScript
{
public:
    PS_PlayedRewards() : PlayerScript("PS_PlayedRewards") { }

    void OnLogin(Player* player) override
    {
        if (sPlayedRewards->IsEnabled())
            sPlayedRewards->LoadRewardedMap(player);
    }

    void OnLogout(Player* player) override
    {
        if (sPlayedRewards->IsEnabled())
            sPlayedRewards->SaveRewardedMap(player);
    }
};

class WS_PlayedRewards : public WorldScript
{
public:
    WS_PlayedRewards() : WorldScript("WS_PlayedRewards") { }

    void OnStartup() override
    {
        sPlayedRewards->LoadConfig();

        if (sPlayedRewards->IsEnabled())
            sPlayedRewards->LoadFromDB();
    }
};

void AddSC_PlayedRewards()
{
    new PS_PlayedRewards();
    new WS_PlayedRewards();
}
