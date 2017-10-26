/*

# Codebox NPC #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------


### Description ###
------------------------------------------------------------------------------------------------------------------
Meet Retdream, the Keeper of Codes. She's a codebox NPC that emotes and speaks. This NPC takes codes from the player
and checks them against custom database tables to determine the loot. You can set charges for items to allow players
to use the code once or a specific number of times. It also supports unique codes that can only be used once by any
player.


### Features ###
------------------------------------------------------------------------------------------------------------------
- Creates a CodeBox NPC with emotes
- Gives items and/or gold to players if they enter the correct code
- Reads/Writes code data from the database
- Supports alpha-numeric codes
- Supports multi-item codes
- Supports # of charges per code
- Supports unique codes to be given out only once to any player
- Checks for already redeemed codes
- Checks for # of charges used


### To-Do ###
------------------------------------------------------------------------------------------------------------------
- Allow GM interaction with NPC to create, edit, and disable codes in game
- If possible, create a way to prevent players from trading codes
- Figure out a better way to handle codes multi-item codes with multiple charges
    - ex) You create a code that gives the player 3 items and can be used 3 times
    - A 3 item code with 3 charges MUST have charges set to 9 for each item
    - The first time the code is used it will record 3 items in the database with that code
    - The second time the code is used the database is checked for # of items with that code and returns 3
    - So, to allow 3 uses of the code, we need to set the # of charges to: # of charges * # of items (3 x 3 = 9)


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: codebox_npc
- Config: Yes
    - Enable Module Announce
- SQL: Yes
    - NPC ID: 601021
    - Add Table: lootcode_items (codes, items, charges, etc.)
    - Add Table: lootcode_player (tracks redeemed codes)


### Version ###
------------------------------------------------------------------------------------------------------------------
- 2017.08.13 - Release


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

class CodeboxAnnounce : public PlayerScript
{

public:

    CodeboxAnnounce() : PlayerScript("CodeboxAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (sConfigMgr->GetBoolDefault("CodeboxNPC.Announce", true))
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00CodeboxNPC |rmodule.");
        }
    }
};

class codebox_npc : public CreatureScript
{

public:

    codebox_npc() : CreatureScript("codebox_npc") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        std::string text = "Enter a loot code and press Accept";
        player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "I'd like to enter my loot code.", GOSSIP_SENDER_MAIN, 1, text, 0, true);
        player->SEND_GOSSIP_MENU(601021, creature->GetGUID());
        return true;
    }

    bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32, const char* code)
    {
        if (sender != GOSSIP_SENDER_MAIN)
        {
            return false;
        }

        if (!code)
        {
            code = "";
        }

        // Determine Loot
        getLoot(player, creature, code);

        return true;
    }

    void getLoot(Player* player, Creature* creature, const char* code)
    {
        // Check for a valid code
        QueryResult checkCode = WorldDatabase.PQuery("SELECT code, itemId, quantity, gold, charges, isUnique FROM lootcode_items WHERE code = '%s'", (code));

        // Check if player has redeemed the code
        QueryResult getLoot = WorldDatabase.PQuery("SELECT playerGUID, count(code) AS chargesUsed FROM lootcode_player WHERE playerGUID like %u AND code = '%s'", player->GetGUID(), (code));

        do
        {
            if (!checkCode)
            {
                // No code match found in database
                std::ostringstream messageCode;
                messageCode << "Sorry " << player->GetName() << ", that is not a valid code.";
                player->PlayDirectSound(9638); // No
                creature->MonsterWhisper(messageCode.str().c_str(), player);
                creature->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                player->SEND_GOSSIP_MENU(601021, creature->GetGUID());
                return;
            }
            else {

                // Get checkCode fields
                Field * fields = checkCode->Fetch();
                const char* code = fields[0].GetCString();
                uint32 itemId = fields[1].GetUInt32();
                uint32 quantity = fields[2].GetUInt32();
                uint32 gold = fields[3].GetUInt32();
                uint32 charges = fields[4].GetUInt32();
                uint32 isUnique = fields[5].GetUInt32();

                // Get getLoot fields
                Field * fields2 = getLoot->Fetch();
                uint32 playerGUID = fields2[0].GetUInt32();
                uint32 chargesUsed = fields2[1].GetUInt32();

                // If the code is unqiue, check to see if anyone has already used it.
                if (isUnique == 1)
                {
                    // Query for the unique code
                    QueryResult uniqueRedeemed = WorldDatabase.PQuery("SELECT playerGUID, isUnique FROM lootcode_player WHERE code = '%s' AND isUnique = 1", (code));

                    // If any player has redeemed this unique code, deny the code
                    if (uniqueRedeemed)
                    {
                        std::ostringstream messageCode;
                        messageCode << "Sorry " << player->GetName() << ", This unique code has already been redeemed.";
                        player->PlayDirectSound(9638); // No
                        creature->MonsterWhisper(messageCode.str().c_str(), player);
                        creature->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                        player->SEND_GOSSIP_MENU(601021, creature->GetGUID());
                        return;
                    }
                }

                // Check the # of charges used by the player for this code
                if (chargesUsed < charges)
                {
                    // Add the entry to the database
                    WorldDatabase.PQuery("INSERT INTO lootcode_player (code, playerGUID, isUnique) VALUES ('%s', %u, %u);", (code), player->GetGUID(), isUnique);

                    // Add Item to player inventory
                    if (itemId != NULL)
                    {
                        player->AddItem(itemId, quantity);
                    }

                    // Add Gold to player inventory
                    if (gold != NULL)
                    {
                        player->ModifyMoney(gold * 10000);
                    }
                }
                else
                {
                    // Code charges exceeded
                    std::ostringstream messageCode;
                    messageCode << "Sorry, " << player->GetName() << ". you've reached the limit on this code.";
                    player->PlayDirectSound(9638); // No
                    creature->MonsterWhisper(messageCode.str().c_str(), player);
                    creature->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                    player->SEND_GOSSIP_MENU(601021, creature->GetGUID());
                    return;
                }
            }

        } while (checkCode->NextRow());

        // Code successfully redeemed
        std::ostringstream messageCode;
        messageCode << "Your code has been redeemed " << player->GetName() << ". Have a nice day!";
        creature->MonsterWhisper(messageCode.str().c_str(), player);
        creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
        player->CLOSE_GOSSIP_MENU();
    }

    // NPC PASSIVE EMOTES
    struct codebox_passivesAI : public ScriptedAI
    {
        codebox_passivesAI(Creature * creature) : ScriptedAI(creature) { }

        uint32 uiAdATimer;

        void Reset()
        {
            uiAdATimer = 1000;
        }

        // Speak
        void UpdateAI(uint32 diff)
        {
            if (uiAdATimer <= diff)
            {
                me->MonsterSay("Do you have a code to redeem? Step right up!", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                uiAdATimer = 61000;
            }
            else
            {
                uiAdATimer -= diff;

            }
        }
    };

    // CREATURE AI
    CreatureAI * GetAI(Creature * creature) const
    {
        return new codebox_passivesAI(creature);
    }
};

class codebox_npc_world : public WorldScript
{
public:
	codebox_npc_world() : WorldScript("codebox_npc_world") { }

	void OnBeforeConfigLoad(bool reload) override
	{
		if (!reload) {
			std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/npc_codebox.conf";
#ifdef WIN32
			cfg_file = "Settings/modules/npc_codebox.conf";
#endif
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());
		}
	}
};

void AddNPCCodeboxScripts()
{
	new codebox_npc_world();
    new CodeboxAnnounce();
    new codebox_npc();
}