//Reward system made by Talamortis

#include "Configuration/Config.h"
#include "Player.h"
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Define.h"
#include "GossipDef.h"

class reward_system : public PlayerScript
{
public:
    reward_system() : PlayerScript("rewardsystem") {}

    uint32 rewardtimer = urand(2 * HOUR*IN_MILLISECONDS, 4 * HOUR*IN_MILLISECONDS);
    int32 roll = urand(1, 1000);

    void OnBeforePlayerUpdate(Player* player, uint32 p_time)
    {

        if (!sConfigMgr->GetBoolDefault("RewardSystemEnable", true))
            return;
        {
            if (rewardtimer <= p_time)
            {
                roll = urand(1, 1000); //Lets make a random number from 1 - 1000
                QueryResult result = CharacterDatabase.PQuery("SELECT item, quantity FROM reward_system WHERE roll = '%u'", roll);

                if (!result || player->isAFK())
                    return;
                else
                {
                    //Lets now get the item
                    Field* fields = result->Fetch();
                    uint32 pItem = fields[0].GetInt32();
                    uint32 quantity = fields[1].GetInt32();

                    // now lets add the item
                    player->AddItem(pItem, quantity);

                    rewardtimer = urand(2 * HOUR*IN_MILLISECONDS, 4 * HOUR*IN_MILLISECONDS);
                    ChatHandler(player->GetSession()).PSendSysMessage("You have rolled %u which gave you item %u", roll, pItem);
                }
            }
            else
                rewardtimer -= p_time;
        }
    }
};

class reward_system_conf : public WorldScript
{
public:
    reward_system_conf() : WorldScript("reward_system_conf") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string cfg_file = "Settings/modules/mod_reward_system.conf";
            std::string cfg_def_file = cfg_file + ".dist";

            sConfigMgr->LoadMore(cfg_def_file.c_str());

            sConfigMgr->LoadMore(cfg_file.c_str());
        }
    }
};

void AddRewardSystemScripts()
{
    new reward_system();
    new reward_system_conf();
}