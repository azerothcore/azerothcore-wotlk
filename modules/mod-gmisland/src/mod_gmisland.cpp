/*

# GM Island #

### Description ###
------------------------------------------------------------------------------------------------------------------
This module customizes GM Island by theming it in a few different ways. This module will be expanded to include
other GM Island related content.


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Server/Player/NPC
- Script: GMIslandTheme
- Config: Yes
- SQL: Yes
    - NPC ID: 601035 (Molten Giant)


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2018.12.01 - Trinity Script Conversion & Release


### Credits ###
------------------------------------------------------------------------------------------------------------------
#### A module for AzerothCore by StygianTheBest ([http://stygianthebest.github.io](stygianthebest.github.io)) ####

###### Additional Credits include:
- [Arister](http://www.ac-web.org/forums/showthread.php?204335-GMIsland-Theme-Manager)
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
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include <cstring>

bool GMIAnnounce = true;
uint32 GMICooldown = 25;

namespace Tools
{
    uint32 GetCooldown()
    {
        if (QueryResult cd_query = WorldDatabase.PQuery("SELECT `date` FROM `gmi_logs` ORDER BY `id` DESC LIMIT 1"))
            return cd_query ? (time(NULL) - cd_query->Fetch()[0].GetUInt32()) : 0;
        else
            return 0;
    }

    void SendAnnounceToGMs(const char* text, WorldSession* self)
    {
        std::map<uint32, WorldPacket> localizedPackets;
        SessionMap const& smap = sWorld->GetAllSessions();
        for (SessionMap::const_iterator iter = smap.begin(); iter != smap.end(); ++iter)
        {
            if (Player* player = iter->second->GetPlayer())
            {
                AccountTypes gmLevel = player->GetSession()->GetSecurity();

                if (uint32(gmLevel) != 0)
                {
                    if (localizedPackets.find(player->GetSession()->GetSessionDbLocaleIndex()) == localizedPackets.end())
                        ChatHandler::BuildChatPacket(localizedPackets[player->GetSession()->GetSessionDbLocaleIndex()], CHAT_MSG_RAID_BOSS_EMOTE, LANG_UNIVERSAL, NULL, NULL, text);

                    player->SendDirectMessage(&localizedPackets[player->GetSession()->GetSessionDbLocaleIndex()]);
                }
            }
        }
    }

}; using namespace Tools;

class GMIslandConfig : public WorldScript
{
public:

    GMIslandConfig() : WorldScript("GMIslandConfig") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/mod_gmisland.conf";
#ifdef WIN32
            cfg_file = "mod_gmisland.conf";
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
        GMICooldown = sConfigMgr->GetIntDefault("GMI.Cooldown", 25);
        GMIAnnounce = sConfigMgr->GetBoolDefault("GMI.Announce", true);
    }
};

class GMIslandAnnounce : public PlayerScript
{

public:

    GMIslandAnnounce() : PlayerScript("GMIslandAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (GMIAnnounce)
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00GMIsland |rmodule.");
        }
    }

};

class GMIsland_Theme_Generator : public CreatureScript
{
public:
    GMIsland_Theme_Generator() : CreatureScript("GMIsland_Theme_Generator") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->GetZoneId() != 876)
        {
            creature->MonsterWhisper("Sorry, you can't use this outside GM Island!", player, true);
        }
        else
        {
            if (GetCooldown() >= GMICooldown || GetCooldown() == 0)
            {
                if (QueryResult t_query = WorldDatabase.PQuery("SELECT `id`, `name` FROM `gmi_themes` WHERE `id` > 0 AND `available` = 1"))
                {
                    do
                    {
                        Field * t_fields = t_query->Fetch();
                        player->ADD_GOSSIP_ITEM(0, t_fields[1].GetString().c_str(), GOSSIP_SENDER_MAIN, t_fields[0].GetUInt32());
                    } while (t_query->NextRow());
                }
            }
            else
            {
                char message[255];

                sprintf(message, "You can do that in exactly %u seconds!", (GMICooldown - GetCooldown()));

                player->ADD_GOSSIP_ITEM(0, message, GOSSIP_SENDER_MAIN, 0);
            }

            player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
        }
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        switch (action)
        {
        case 0: {
            player->CLOSE_GOSSIP_MENU();
        } break;
        default: {
            if (QueryResult ts_query = WorldDatabase.PQuery("SELECT `entry`, `pos_x`,`pos_y`,`pos_z`,`pos_o` FROM `gmi_templates` WHERE `id` = %u", action))
            {
                WorldDatabase.PQuery("INSERT INTO `gmi_logs` (`theme_id`, `date`) VALUES (%u, UNIX_TIMESTAMP())", action);
                do
                {
                    Field * ts_fields = ts_query->Fetch();

                    float ang = ts_fields[4].GetFloat();

                    float rot2 = std::sin(ang / 2);
                    float rot3 = std::cos(ang / 2);

                    creature->SummonGameObject(ts_fields[0].GetUInt32(), ts_fields[1].GetFloat(), ts_fields[2].GetFloat(), ts_fields[3].GetFloat(), ang, 0, 0, rot2, rot3, GMICooldown);
                } while (ts_query->NextRow());

                if (QueryResult tn_query = WorldDatabase.PQuery("SELECT `name` FROM `gmi_themes` WHERE `id` = %u LIMIT 1", action))
                {
                    Field * tn_fields = tn_query->Fetch();

                    std::ostringstream message;
                    message << "|cffFFFFFF[|cffDA70D6 GM Island |cffFFFFFF]:|cff4CFF00 " << player->GetName() << "|cffFFFFFF changed the theme to |cffDA70D6" << tn_fields[0].GetString() << "|r.";
                    SendAnnounceToGMs(message.str().c_str(), NULL);
                }
            }
        } break;
        }
        player->CLOSE_GOSSIP_MENU();

        return true;
    }
};

void AddGMIslandScripts()
{
    new GMIslandConfig();
    new GMIslandAnnounce();
    new GMIsland_Theme_Generator();
}
