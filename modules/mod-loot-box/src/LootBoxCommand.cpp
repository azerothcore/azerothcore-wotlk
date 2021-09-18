#include "ScriptMgr.h"
#include "Player.h"
#include "Chat.h"
#include "World.h"
#include "LootBoxWorld.h"

class LootBoxCommand : public CommandScript
{
public:
    LootBoxCommand() : CommandScript("LootBoxCommand") {}

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> rewards =
        {
            {"macaroons", SEC_CONSOLE, true, &HandleDailyMacaroons, ""}
        };

        static std::vector<ChatCommand> commands =
        {
            {"daily", SEC_CONSOLE, true, nullptr, "", rewards}
        };

        return commands;
    }

    static bool HandleDailyMacaroons(ChatHandler */*handler*/, const char */*args*/)
    {
        SessionMap const &sessions = sWorld->GetAllSessions();

        for (SessionMap::const_iterator itr = sessions.begin(); itr != sessions.end(); ++itr) {
            if (!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld())
                continue;

            Player *player = itr->second->GetPlayer();

            ChatHandler(player->GetSession()).PSendSysMessage("Daily login reward!");
            player->AddItem(LootBoxWorld::CustomCurrency, LootBoxWorld::DailyReward);
        }

        return true;
    }
};

void AddLootBoxCommandScripts()
{
    new LootBoxCommand();
}
