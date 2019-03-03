//Reward system made by Talamortis

#include "Configuration/Config.h"
#include "Player.h"
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Define.h"
#include "GossipDef.h"

bool RewardSystem_Enable;
uint32 Max_roll;

class reward_system : public PlayerScript
{
public:
    reward_system() : PlayerScript("reward_system") {}

    uint32 RewardTimer;
    int32 roll;

    void OnLogin(Player* p)
    {
        if (RewardSystem_Enable)
        {
            
            RewardTimer = (sConfigMgr->GetIntDefault("RewardTime", 1)*HOUR*IN_MILLISECONDS);
        }
    }

    void OnBeforeUpdate(Player* player, uint32 p_time)
    {
        if (RewardSystem_Enable)
        {
            if (RewardTimer > 0)
            {
                if (player->isAFK())
                    return;

                if (RewardTimer <= p_time)
                {
                    roll = urand(1, Max_roll);
                    QueryResult result = CharacterDatabase.PQuery("SELECT item, quantity FROM reward_system WHERE roll = '%u'", roll);

                    if (!result)
                    {
                        ChatHandler(player->GetSession()).PSendSysMessage("better luck next time your roll was %u", roll);
                        RewardTimer = (sConfigMgr->GetIntDefault("RewardTime", 1)*HOUR*IN_MILLISECONDS);
                        return;
                    }

                    //Lets now get the item
                    do
                    {
                        Field* fields = result->Fetch();
                        uint32 pItem = fields[0].GetInt32();
                        uint32 quantity = fields[1].GetInt32();

                        // now lets add the item
                        player->AddItem(pItem, quantity);
                        ChatHandler(player->GetSession()).PSendSysMessage("Congratulations you have won with a roll of %u", roll);
                    } while (result->NextRow());


                    RewardTimer = (sConfigMgr->GetIntDefault("RewardTime", 1)*HOUR*IN_MILLISECONDS);
                }
                else  RewardTimer -= p_time;
            }

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
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/reward_system.conf";

#ifdef WIN32
            cfg_file = "reward_system.conf";
#endif // WIN32

            std::string cfg_def_file = cfg_file + ".dist";
            sConfigMgr->LoadMore(cfg_def_file.c_str());
            sConfigMgr->LoadMore(cfg_file.c_str());
            RewardSystem_Enable = sConfigMgr->GetBoolDefault("RewardSystemEnable", true);
            Max_roll = sConfigMgr->GetIntDefault("MaxRoll", 1000);
        }
    }
};

void AddRewardSystemScripts()
{
    new reward_system();
    new reward_system_conf();
}