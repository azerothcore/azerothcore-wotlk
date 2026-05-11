#include "Config.h"
#include "DatabaseEnv.h"
#include "Mail.h"
#include "Player.h"
#include "PlayerScript.h"

class LevelRewardsPlayerScript : public PlayerScript
{
public:
    LevelRewardsPlayerScript() : PlayerScript("LevelRewardsPlayerScript",
        {
            PLAYERHOOK_ON_LEVEL_CHANGED,
        })
    {
    }

    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        if (!sConfigMgr->GetOption<bool>("LevelRewards.Enable", true))
            return;

        uint8 level = player->GetLevel();
        if (level % 10 != 0)
            return;

        std::string key = "LevelRewards.Gold." + std::to_string(level);
        uint32 gold = sConfigMgr->GetOption<uint32>(key, 0);
        if (gold == 0)
            return;

        std::string subject = sConfigMgr->GetOption<std::string>("LevelRewards.Subject",
            "Level " + std::to_string(level) + " Milestone Reward!");
        std::string body = sConfigMgr->GetOption<std::string>("LevelRewards.Message", "");

        ReplacePlaceholder(subject, level);
        ReplacePlaceholder(body, level);

        // 1 gold = 10000 copper (100 silver * 100 copper)
        uint32 money = gold * 10000;

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        MailDraft(subject, body)
            .AddMoney(money)
            .SendMailTo(trans, MailReceiver(player), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM));
        CharacterDatabase.CommitTransaction(trans);
    }

private:
    static void ReplacePlaceholder(std::string& str, uint8 level)
    {
        std::string levelStr = std::to_string(level);
        size_t pos;
        while ((pos = str.find("{level}")) != std::string::npos)
            str.replace(pos, 7, levelStr);
        while ((pos = str.find("$B")) != std::string::npos)
            str.replace(pos, 2, "\n");
    }
};

void Addmod_level_rewardsScripts()
{
    new LevelRewardsPlayerScript();
}
