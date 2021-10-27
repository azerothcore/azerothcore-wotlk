#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "AchievementMgr.h"

class ColonistPlayer : public PlayerScript
{
public:
    ColonistPlayer() : PlayerScript("ColonistPlayer") { }

    void OnLogin(Player* player) override
    {
        if (sConfigMgr->GetOption<int>("MaxPlayerLevel", false) <= 19)
        {
            player->CompletedAchievement(sAchievementStore.LookupEntry(23464));

            if (isPioneer(player))
                player->CompletedAchievement(sAchievementStore.LookupEntry(23465));
        }
    }

    bool OnBeforeAchiComplete(Player */*player*/, AchievementEntry const *achievement) override
    {
        if (sConfigMgr->GetOption<int>("MaxPlayerLevel", false) > 19
            && (achievement->ID == 23464 || achievement->ID == 23465))
        {
            return false;
        }

        return true;
    }

    void OnAchiComplete(Player* player, AchievementEntry const* /*achievement*/) override
    {
        if (sConfigMgr->GetOption<int>("MaxPlayerLevel", 80) <= 19 && isPioneer(player))
            player->CompletedAchievement(sAchievementStore.LookupEntry(23465));
    }

private:
    bool isPioneer(Player *player)
    {
        return player->HasAchieved(504) && player->HasAchieved(628) && player->HasAchieved(629)
            && player->HasAchieved(630) && player->HasAchieved(631) && player->HasAchieved(632);
    }
};

void AddColonistPlayerScripts()
{
    new ColonistPlayer();
}
