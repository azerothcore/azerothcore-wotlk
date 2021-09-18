#include <ctime>
#include <chrono>
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "LootBoxWorld.h"

class LootBoxPlayer : public PlayerScript
{
public:
    LootBoxPlayer() : PlayerScript("LootBoxPlayer") { }

    void OnLogin(Player *player) override
    {
        if (sConfigMgr->GetOption<bool>("LootBox.Enable", false))
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00Loot Box |rmodule.");

        uint32 guid = player->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.PQuery("SELECT `logout_time` FROM `characters` WHERE guid = %u", guid);
        std::chrono::system_clock::time_point logout_time_point(std::chrono::seconds(result->Fetch()->GetUInt32()));
        time_t logout_time = std::chrono::system_clock::to_time_t(logout_time_point);
        time_t now = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
        time_t reset = getReset();

        if (std::difftime(reset, logout_time) > 0 && std::difftime(now, reset) >= 0)
            sendDailyReward(player);
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

private:
    void sendDailyReward(Player *player)
    {
        ChatHandler(player->GetSession()).PSendSysMessage("Daily login reward!");
        player->AddItem(LootBoxWorld::CustomCurrency, LootBoxWorld::DailyReward);
    }

    time_t getReset()
    {
        time_t now = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
        tm local = *localtime(&now);
        local.tm_sec = 0;
        local.tm_min = 0;
        local.tm_hour = 0;
        time_t reset = mktime(&local);
        return reset;
    }
};

void AddLootBoxPlayerScripts()
{
    new LootBoxPlayer();
}
