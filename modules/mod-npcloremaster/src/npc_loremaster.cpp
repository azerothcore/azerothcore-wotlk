/*
# Loremaster NPC

## Description

This places a Loremaster NPC in the game world at various locations who recants the lore of the old world and
brings back the lost memories of so many that sacrificed their lives for this ravaged land we all call home.

As of the release of this module, I have only had time to create three of these NPCs, but I have plans for many
more in the future, and hope that the community can contribute. I have written the module so adding new Loremaster
NPCs is done purely in the database and will chain to one another automatically if done correctly.

## Data

- Type: NPC
- Script: Loremaster_NPC
- Config: Yes
- SQL: Yes
  - NPC ID: 601075-601XXX

## Version

- v2019.01.14 - Release

### Credits

#### An original module for AzerothCore by StygianTheBest ([stygianthebest.github.io](http://stygianthebest.github.io))

##### Additional Credits include

- [Michel Martin Koiter](https://web.archive.org/web/20160329220904/http://www.sonsofthestorm.com:80/memorial_twincruiser.html)
- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)
- [AzerothCore Discord](https://discord.gg/gk
- [Wowhead.com](http://wowhead.com)

### License

- This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).

*/

#include "Config.h"
#include "ScriptPCH.h"
#include "ScriptedGossip.h"

// Locals
uint32 ThisLoremaster;
uint32 NextLoremaster;

// DB
uint32 id;
float position_x;
float position_y;
float position_z;
float orientation;
uint32 mapID;
string destination;

// Config
bool Announce = true;
uint32 FirstLoremaster;
string LoreMessage;
uint32 LoreMessageTimer;

class LoremasterConfig : public WorldScript
{
public:
    LoremasterConfig() : WorldScript("LoremasterConfig") { }

    // Read Configuration File
    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/npc_loremaster.conf";
#ifdef WIN32
            cfg_file = "npc_loremaster.conf";
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
        // Get the bet amounts from config
        Announce = sConfigMgr->GetBoolDefault("Announce", true);
        FirstLoremaster = sConfigMgr->GetIntDefault("FirstLoremasterGUID", 601075);
        LoreMessage = sConfigMgr->GetStringDefault("LoreMessage", "This area is rich with history and lore.");
        LoreMessageTimer = sConfigMgr->GetIntDefault("LoreMessageTimer", 120000);
    }
};

class LoremasterAnnounce : public PlayerScript
{

public:
    LoremasterAnnounce() : PlayerScript("LoremasterAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (Announce)
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00LoremasterNPC |rmodule.");
        }
    }
};

class Loremaster_NPC : public CreatureScript
{

public:

    Loremaster_NPC() : CreatureScript("Loremaster_NPC") { }

    // Get Loremaster Info
    void GetLoremaster(Player *player, Creature * creature)
    {
        // Get Loremaster
        ThisLoremaster = creature->GetDBTableGUIDLow();
        NextLoremaster = ThisLoremaster + 1;

        // Get/Set Destination
        if (QueryResult NextDestination = WorldDatabase.PQuery("SELECT id, position_x, position_y, position_z, orientation, map, name FROM npc_loremaster WHERE id = '%u'", (NextLoremaster)))
        {
            // Get NextDestination fields
            Field * fields = NextDestination->Fetch();
            id = fields[0].GetInt32();
            position_x = fields[1].GetFloat();
            position_y = fields[2].GetFloat();
            position_z = fields[3].GetFloat();
            orientation = fields[4].GetFloat();
            mapID = fields[5].GetUInt32();
            destination = fields[6].GetCString();
        }
        else
        {
            // GUID not found - Assign the first Loremaster entry
            if (NextDestination = WorldDatabase.PQuery("SELECT id, position_x, position_y, position_z, orientation, map, name FROM npc_loremaster WHERE id = '%u'", (FirstLoremaster)))
            {
                // Get NextDestination fields
                Field * fields = NextDestination->Fetch();
                id = fields[0].GetInt32();
                position_x = fields[1].GetFloat();
                position_y = fields[2].GetFloat();
                position_z = fields[3].GetFloat();
                orientation = fields[4].GetFloat();
                mapID = fields[5].GetUInt32();
                destination = fields[6].GetCString();
            }
            else
            {
                // FirstLoremasterGUID not found - Someone broke something - Set destination
                position_x = -10806.2;
                position_y = 2448.78;
                position_z = 2.12592;
                orientation = 5.56451;
                mapID = 1;
                destination = "Camp Silithus";
            }
        }
    }

    // Gossip Hello
    bool OnGossipHello(Player * player, Creature * creature)
    {
        // Gossip Options
        std::ostringstream Option1;
        std::ostringstream Option2;
        std::ostringstream messageHello;
        player->PlayerTalkClass->ClearMenus();

        // Check Player Status
        if (player->IsInFlight() || !player->getAttackers().empty() || player->IsInCombat())
        {
            messageHello << "You appear to be in combat " << player->GetName() << "!";
            creature->MonsterWhisper(messageHello.str().c_str(), player);
            player->CLOSE_GOSSIP_MENU();
            return false;
        }

        // Get Loremaster info
        GetLoremaster(player, creature);

        // Gossip Menu
        Option1 << "Take me to " << destination << " Crom.";
        Option2 << "I think I'll explore this area for now.";
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, Option1.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, Option2.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        player->SEND_GOSSIP_MENU(ThisLoremaster, creature->GetGUID());

        return true;
    }

    // Gossip Select
    bool OnGossipSelect(Player * player, Creature * creature, uint32 sender, uint32 uiAction)
    {
        // Gossip Options
        std::ostringstream messageSelect;
        player->PlayerTalkClass->ClearMenus();

        // Check Sender
        if (sender != GOSSIP_SENDER_MAIN)
        {
            player->CLOSE_GOSSIP_MENU();
            return false;
        }

        // Check Player Status
        if (player->IsInFlight() || !player->getAttackers().empty() || player->IsInCombat())
        {
            messageSelect << "You appear to be in combat " << player->GetName() << "!";
            creature->MonsterWhisper(messageSelect.str().c_str(), player);
            player->CLOSE_GOSSIP_MENU();
            return false;
        }

        // Get Loremaster info
        GetLoremaster(player, creature);

        // Gossip Action
        switch (uiAction)
        {
        case GOSSIP_ACTION_INFO_DEF + 1:

            messageSelect << "Transporting you to " << destination << " " << player->GetName() << ".";
            creature->MonsterWhisper(messageSelect.str().c_str(), player);
            creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
            player->PlayDirectSound(3337);
            player->CastSpell(player, 47292);
            player->TeleportTo(mapID, position_x, position_y, position_z, orientation);
            player->CLOSE_GOSSIP_MENU();
            break;

        case GOSSIP_ACTION_INFO_DEF + 2:

            player->CLOSE_GOSSIP_MENU();
            break;

        default:

            player->CLOSE_GOSSIP_MENU();
            break;
        }

        return true;
    }

    // Passive Emotes
    struct Loremaster_PassivesAI : public ScriptedAI
    {
        Loremaster_PassivesAI(Creature * creature) : ScriptedAI(creature) { }

        uint32 uiAdATimer = LoreMessageTimer;

        void UpdateAI(const uint32 diff)
        {
            if (uiAdATimer <= diff)
            {
                me->MonsterSay(LoreMessage.c_str(), LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                uiAdATimer = LoreMessageTimer;
            }
            else
            {
                uiAdATimer -= diff;
            }
        }
    };

    // Creature AI
    CreatureAI * GetAI(Creature * creature) const
    {
        return new Loremaster_PassivesAI(creature);
    }

};

void AddNPCLoremasterScripts()
{
    new LoremasterConfig();
    new LoremasterAnnounce();
    new Loremaster_NPC();
}
