/*

# StygianCore Skeleton Module #

         _,.-------.,_
     ,;~'             '~;,
   ,;                     ;,
  ;                         ;
 ,'                         ',
,;                           ;,
; ;      .           .      ; ;
| ;   ______       ______   ; |
|  `/~"     ~" . "~     "~\'  |
|  ~  ,-~~~^~, | ,~^~~~-,  ~  |
 |   |        }:{        |   |
 |   l       / | \       !   |
 .~  (__,.--" .^. "--.,__)  ~.
 |     ---;' / | \ `;---     |
  \__.       \/^\/       .__/
   V| \                 / |V
    | |T~\___!___!___/~T| |
    | |`IIII_I_I_I_IIII'| |
    |  \,III I I I III,/  |
     \   `~~~~~~~~~~'    /
       \   .       .   /     -dcau (4/15/95)
         \.    ^    ./
           ^~~~^~~~^


### Description ###
------------------------------------------------------------------------------------------------------------------
- This module is a fork of the original AzerothCore skeleton module.
- This module outlines a basic framework to use for creating modules.
- I have included the following examples
    - Config: Reads the conf file for the module.
    - Announce: Announces the module to the console
    - WorldScript: Executes world events.
    - PlayerScript: Executes player events.


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Player/Server
- Script: ModSkeleton
- Config: Yes
- SQL: No


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2018.12.01 - Release


### Credits ###
------------------------------------------------------------------------------------------------------------------
#### A module for AzerothCore by StygianTheBest ([stygianthebest.github.io](http://stygianthebest.github.io)) ####

###### Additional Credits include:
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

#include "ScriptMgr.h"
#include "Configuration/Config.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "Player.h"
#include "Object.h"

bool SkeletonEnabled = true;
bool SkeletonAnnounceModule = true;
bool SkeletonTestWorldEvent = false;
bool SkeletonTestPlayerEvent = false;

// Configuration
class mod_skeleton_Conf : public WorldScript
{
public:
    mod_skeleton_Conf() : WorldScript("mod_skeleton_Conf") { }

    // Initialize Configuration
    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/mod_skeleton.conf";

#ifdef WIN32
            cfg_file = "mod_skeleton.conf";
#endif

            std::string cfg_def_file = cfg_file + ".dist";
            sConfigMgr->LoadMore(cfg_def_file.c_str());
            sConfigMgr->LoadMore(cfg_file.c_str());

            // Load Configuration Settings
            SetInitialWorldSettings();
        }
    }

    // Load Configuration Settings
    void SetInitialWorldSettings()
    {
        SkeletonEnabled = sConfigMgr->GetBoolDefault("Skeleton.Enable", true);
        SkeletonAnnounceModule = sConfigMgr->GetBoolDefault("Skeleton.Announce", true);
        SkeletonTestWorldEvent = sConfigMgr->GetBoolDefault("Skeleton.TestWorldEvent", false);
        SkeletonTestPlayerEvent = sConfigMgr->GetBoolDefault("Skeleton.TestPlayerEvent", false);
    }
};

// Announce
class mod_skeleton_Announce : public PlayerScript
{

public:
    mod_skeleton_Announce() : PlayerScript("mod_skeleton_Announce") {}

    void OnLogin(Player* player)
    {
        if (SkeletonEnabled)
        {
            // Announce Module
            if (SkeletonAnnounceModule)
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cffFFFFFFSkeleton |rmodule");
            }
        }
    }
};

// Example WorldScript
class mod_skeleton_WorldScript : public WorldScript
{
public:
    mod_skeleton_WorldScript() : WorldScript("mod_skeleton_WorldScript") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (SkeletonEnabled)
        {
            // Initialize Module Configuration
        }
    }

    void OnStartup() override
    {
        if (SkeletonEnabled)
        {
            // Test World Event
            if (SkeletonTestWorldEvent)
            {
                //
            }
            else
            {
                //
            }
        }
    }
};

// Example PlayerScript
class mod_skeleton_PlayerScript : public PlayerScript
{
public:
    mod_skeleton_PlayerScript() : PlayerScript("mod_skeleton_PlayerScript") { }

    void OnFirstLogin(Player* player) override
    {
        if (SkeletonEnabled)
        {
            // Test Event
            if (SkeletonTestPlayerEvent)
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cffFFFFFFSkeleton |rmodule. |cffFFFF00PlayerScript:TestPlayerEvent:OnFirstLogin: |cff00ff00ENABLED");
            }
            else
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cffFFFFFFSkeleton |rmodule. |cffFFFF00PlayerScript:TestPlayerEvent:OnFirstLogin: |cffff6060DISABLED");
            }
        }
    }

    void OnLogin(Player* player) override
    {
        if (SkeletonEnabled)
        {
            // Test Event
            if (SkeletonTestPlayerEvent)
            {
                ChatHandler(player->GetSession()).SendSysMessage("|cff676767[|cffFFFFFFSkeleton|cff676767] |r: |cffFFFF00PlayerScript:TestPlayerEvent:OnLogin: |cff00ff00ENABLED");
            }
            else
            {
                ChatHandler(player->GetSession()).SendSysMessage("|cff676767[|cffFFFFFFSkeleton|cff676767] |r: |cffFFFF00PlayerScript:TestPlayerEvent:OnLogin: |cffff6060DISABLED");
            }
        }
    }
};

void AddModSkeletonScripts()
{
    new mod_skeleton_Conf();
    new mod_skeleton_Announce();
    new mod_skeleton_WorldScript();
    new mod_skeleton_PlayerScript();
}
