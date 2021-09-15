#include <ctime>
#include <chrono>
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "LootBoxWorld.h"

class LootBoxPlayer : public PlayerScript
{
using times = std::pair<time_t, time_t>;

public:
    LootBoxPlayer() : PlayerScript("LootBoxPlayer") { }

    void OnLogin(Player *player) override
    {
        if (sConfigMgr->GetOption<bool>("LootBox.Enable", false))
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00Loot Box |rmodule.");

        QueryResult result = CharacterDatabase.PQuery(
            "SELECT `logout_time` FROM `characters` WHERE guid = %u",
            player->GetGUID().GetCounter()
        );

        std::chrono::system_clock::time_point time(std::chrono::seconds(result->Fetch()->GetUInt32()));
        time_t logout_time = std::chrono::system_clock::to_time_t(time);
        times times = getTimes();
        time_t reset = times.first;
        time_t now = times.second;
        uint32 guid = player->GetGUID().GetCounter();

        if (std::difftime(reset, logout_time) > 0 && std::difftime(now, reset) >= 0) {
            sendReward(player);
            rewarded[guid] = true;
        } else {
            rewarded[guid] = false;
        }
    }

    void OnLevelChanged(Player *player, uint8 /*oldlevel*/) override
    {
        player->AddItem(LootBoxWorld::CustomCurrency, LootBoxWorld::LevelReward);
    }

    void OnCreatureKill(Player *killer, Creature *killed) override
    {
        if (killed->IsDungeonBoss())
            killer->AddItem(LootBoxWorld::CustomCurrency, LootBoxWorld::KillReward);
    }

    void OnCreatureKilledByPet(Player* owner, Creature* killed) override
    {
        if (killed->IsDungeonBoss())
            owner->AddItem(LootBoxWorld::CustomCurrency, LootBoxWorld::KillReward);

    }

    void OnUpdate(Player *player, uint32 /*p_time*/) override
    {
        times times = getTimes();
        time_t reset = times.first;
        time_t now = times.second;
        uint32 guid = player->GetGUID().GetCounter();

        if (!rewarded[guid] && std::difftime(now, reset) >= 0) {
            rewarded[guid] = true;
            sendReward(player);
        }
    }

private:
    std::map<uint32, bool> rewarded;

    void sendReward(Player *player)
    {
        ChatHandler(player->GetSession()).PSendSysMessage("Daily login reward!");
        player->AddItem(LootBoxWorld::CustomCurrency, LootBoxWorld::DailyReward);
    }

    times getTimes()
    {
        time_t now = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
        tm local = *localtime(&now);
        tm time = {
            .tm_sec = 0,
            .tm_min = 0,
            .tm_hour = LootBoxWorld::ResetTimeHour,
            .tm_mday = local.tm_mday,
            .tm_mon = local.tm_mon,
            .tm_year = local.tm_year,
            .tm_wday = local.tm_wday,
            .tm_yday = local.tm_yday,
            .tm_isdst = local.tm_isdst
        };
        time_t reset = mktime(&time);
        return times(reset, now);
    }
};

void AddLootBoxPlayerScripts()
{
    new LootBoxPlayer();
}
