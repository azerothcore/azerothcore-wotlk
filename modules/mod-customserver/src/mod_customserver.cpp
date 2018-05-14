/*

# Custom Server Modifications #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------


### Description ###
------------------------------------------------------------------------------------------------------------------
This module serves as a container for smaller scripts that don't need their own module. I also use it to test
ideas which is quicker and easier than writing a new module.


### Features ###
------------------------------------------------------------------------------------------------------------------
- Firework Level: Shoots fireworks in the air when a player reaches specified levels.


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Server/Player
- Script: CustomServer
- Config: Yes
    - Enable Module
    - Enable Module Announce
    - Enable Firework Levels
- SQL: No


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.07.14 - Release
- v2017.07.21 - Added Firework Levels


### Credits ###
------------------------------------------------------------------------------------------------------------------
- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)
- [AzerothCore Discord](https://discord.gg/gkt4y2x)
- [EMUDevs](https://youtube.com/user/EmuDevs)
- [AC-Web](http://ac-web.org/)
- [ModCraft.io](http://modcraft.io/)
- [OwnedCore](http://ownedcore.com/)
- [OregonCore](https://wiki.oregon-core.net/)
- [Wowhead.com](http://wowhead.com)
- [AoWoW](https://wotlk.evowow.com/)


### License ###
------------------------------------------------------------------------------------------------------------------
- This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).

*/


#include "Config.h"

class CustomServer : public PlayerScript
{

public:

    CustomServer() : PlayerScript("CustomServer") { }

    void OnLogin(Player* player)
    {
        // Announce Module
        if (sConfigMgr->GetBoolDefault("CustomServer.Announce", true))
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00CustomServer |rmodule.");
        }
    }

    void OnLevelChanged(Player * player, uint8 oldLevel)
    {
        // Shoot fireworks into the air when hits a specific level
        if (sConfigMgr->GetBoolDefault("CustomServer.FireworkLevels", true))
        {
            if (oldLevel == 4)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 9)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 14)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 19)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 29)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 39)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 49)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 59)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 69)
                player->CastSpell(player, 11541, true);

            if (oldLevel == 79)
                player->CastSpell(player, 11541, true);
        }
    }
};

class CustomServerWorld : public WorldScript
{
public:
	CustomServerWorld() : WorldScript("CustomServerWorld") { }

	void OnBeforeConfigLoad(bool reload) override
	{
		if (!reload) {
			std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/mod_customserver.conf";
#ifdef WIN32
			cfg_file = "Settings/modules/mod_customserver.conf";
#endif
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());
		}
	}
};

void AddCustomServerScripts()
{
	new CustomServerWorld();
    new CustomServer();
}