//by SymbolixDEV
//Fixed Error SymbolixDEV
//release SymbolixDEV
#include "ScriptMgr.h"
#include "Config.h"
#include <Player.h>

class Boss_Announcer : public PlayerScript
{
public:
	Boss_Announcer() : PlayerScript("Boss_Announcer") {}
	
    void OnLogin(Player *player)
    {
        if (sConfigMgr->GetBoolDefault("Boss.Announcer.Enable", true))
        {
            if (sConfigMgr->GetBoolDefault("Boss.Announcer.Announce", true))
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00BossAnnouncer |rmodule.");
            }
        }
    }

	void OnCreatureKill(Player* player, Creature* boss)
	{
		if (sConfigMgr->GetBoolDefault("Boss.Announcer.Enable", true))
		{
			if (boss->isWorldBoss())
			{
				std::string plr = player->GetName();
				std::string boss_n = boss->GetName();
				bool ingroup = player->GetGroup();
				std::string tag_colour = "7bbef7";
				std::string plr_colour = "7bbef7";
				std::string boss_colour = "ff0000";
				std::ostringstream stream;
				stream << "|CFF" << tag_colour <<
					"|r|cff" << plr_colour << " " << plr <<
					"|r's group killed the mighty |CFF" << boss_colour << "[" << boss_n << "]|r " "boss" << "!";
				sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
			}
		}
	};
};

class Boss_Announcer_World : public WorldScript
{
public:
	Boss_Announcer_World() : WorldScript("Boss_Announcer_World") { }

	void OnBeforeConfigLoad(bool reload) override
	{
		if (!reload) {
			std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/mod_boss_announcer.conf";
#ifdef WIN32
			cfg_file = "Settings/modules/mod_boss_announcer.conf";
#endif
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());
		}
	}
};

void AddBoss_AnnouncerScripts()
{
	new Boss_Announcer_World;
	new Boss_Announcer;
}