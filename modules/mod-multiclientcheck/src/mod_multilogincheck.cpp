/***
 *  @project: Firestorm Freelance
 *  @author: Meltie2013 (github) aka Lilcrazy
 *  @copyright: 2017
 */

#include "ScriptMgr.h"
#include "Config.h"
#include "World.h"
#include "WorldSession.h"

// Check to see if the player is attempting to multi-box
class multi_login_check : public PlayerScript
{
public:
    multi_login_check() : PlayerScript("multi_login_check") { }

	void OnLogin(Player* player)
    {
        if (sConfigMgr->GetBoolDefault("Disallow.Multiple.Client", false))
        {
			if (sConfigMgr->GetBoolDefault("Disallow.Multiple.Client.Announce", true))
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00DisallowMultipleClient |rmodule.");
            }
            
            SessionMap sessions = sWorld->GetAllSessions();
            for (SessionMap::iterator itr = sessions.begin(); itr != sessions.end(); ++itr)
            {
                if (Player* login = itr->second->GetPlayer())
                {
                    if (player != login)
                    {
                        // If Remote Address matches, remove the player from the world
                        if (player->GetSession()->GetRemoteAddress() == login->GetSession()->GetRemoteAddress())
                            player->GetSession()->KickPlayer();
                    }
                }
            }
        }
	}
};

class multi_login_check_world : public WorldScript
{
public:
	multi_login_check_world() : WorldScript("multi_login_check_world") { }

	void OnBeforeConfigLoad(bool reload) override
	{
		if (!reload) {
			std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/mod_multichecklogin.conf";
#ifdef WIN32
			cfg_file = "Settings/modules/mod_multichecklogin.conf";
#endif
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());
		}
	}
};

void AddMultiLoginCheckScripts()
{
    new multi_login_check_world;
    new multi_login_check;
}
