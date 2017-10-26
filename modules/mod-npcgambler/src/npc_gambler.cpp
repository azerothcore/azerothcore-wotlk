/*

# Gambler NPC #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------


### Description ###
------------------------------------------------------------------------------------------------------------------
This is Skinny, a gold gambling NPC that emotes and speaks. You can bet specific amounts of gold and win or lose
double the amount you've bet. There is also a configurable jackpot that can be won on a roll of 100 within the
first 10 rolls. I've coded in some fun stuff and he's been useful to players on my server that need a little extra
gold. Beware.. He doesn't like cheapskates!


### Features ###
------------------------------------------------------------------------------------------------------------------
- A roll of 50 or higher wins double the bet
- A roll of less than 50 loses double the bet
- A roll of 100 within the first 10 rolls hits the jackpot
- The jackpot can only be hit in the first 10 rolls of each session to discourage spam
- A little help is given to players losing 5 rolls in a row


### To-Do ###
------------------------------------------------------------------------------------------------------------------
- Track and display jackpot winners/dates
- Create lottery from player losses


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: gamble_npc
- Config: Yes
    - Enable Module Announce
    - Set Bet and Jackpot amounts
- SQL: Yes
    - NPC ID: 601020


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.08.10 - Release


### Credits ###
------------------------------------------------------------------------------------------------------------------
- [Unknown Author](https://gist.github.com/anonymous/5114051)
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

#include "config.h"

class GamblerAnnounce : public PlayerScript
{

public:

    GamblerAnnounce() : PlayerScript("GamblerAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (sConfigMgr->GetBoolDefault("GamblerNPC.Announce", true))
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00GamblerNPC |rmodule.");
        }
    }
};

class gamble_npc : public CreatureScript
{

public:

    gamble_npc() : CreatureScript("gamble_npc") { }

    // Get bet amounts from config
    const uint32 Bet1 = sConfigMgr->GetIntDefault("Gambler.Amount1", 1);
    const uint32 Bet2 = sConfigMgr->GetIntDefault("Gambler.Amount2", 2);
    const uint32 Bet3 = sConfigMgr->GetIntDefault("Gambler.Amount3", 3);
    const uint32 Bet4 = sConfigMgr->GetIntDefault("Gambler.Amount4", 4);
    const uint32 Bet5 = sConfigMgr->GetIntDefault("Gambler.Amount5", 5);
    const uint32 Jackpot = sConfigMgr->GetIntDefault("Gambler.Jackpot", 50);

    // How much $$$ the player has
    uint32 Pocket = 0;

    // Bets
    uint32 Bets = 0;		// # of bets placed
    uint32 Wins = 0;		// # of wins
    uint32 Losses = 0;		// # of losses

    // Gossip Hello
    bool OnGossipHello(Player * player, Creature * creature)
    {
        player->PlayerTalkClass->ClearMenus();

        Bets = 0;						// Reset # of bets placed
        Pocket = player->GetMoney();	// How much gold does the player have?
        //Pocket = Pocket * 10000;		// How much gold does the player have?

        // For the high-rollers
        if (Pocket >= 50000000) // 5000 Gold
        {
            std::ostringstream messageTaunt;
            messageTaunt << "Whadda we have here? A high-roller eh? Step right up " << player->GetName() << "!";
            player->GetSession()->SendNotification(messageTaunt.str().c_str());
        }

        std::ostringstream messageJackpot;
        messageJackpot << "Place your bet. Today's Jackpot is " << Jackpot << " gold.";
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, messageJackpot.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "So, how does this game work?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        player->SEND_GOSSIP_MENU(601020, creature->GetGUID());
        return true;
    }

    // Gossip Select
    bool OnGossipSelect(Player * player, Creature * creature, uint32 sender, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();

        std::ostringstream Option1;
        std::ostringstream Option2;
        std::ostringstream Option3;
        std::ostringstream Option4;
        std::ostringstream Option5;
        std::ostringstream messageInstruct;

        if (sender != GOSSIP_SENDER_MAIN)
            return false;

        switch (uiAction)
        {

        case GOSSIP_ACTION_INFO_DEF + 1:
            Option1 << Bet1 << " Gold";
            Option2 << Bet2 << " Gold";
            Option3 << Bet3 << " Gold";
            Option4 << Bet4 << " Gold";
            Option5 << Bet5 << " Gold";
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, Option1.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, Option2.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, Option3.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, Option4.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, Option5.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
            break;

        case GOSSIP_ACTION_INFO_DEF + 2:
            messageInstruct << "The rules are simple " << player->GetName() << ".. If you roll higher than 50, you win double the bet amount. Otherwise, you lose twice the bet amount. A roll of 100 wins the jackpot. Good Luck!";
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT_11, messageInstruct.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Alright Skinny, I'm up for some gambling.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
            break;

        case GOSSIP_ACTION_INFO_DEF + 3:
            OnGossipSelectGold(player, creature, 1, 1, Bet1);
            break;

        case GOSSIP_ACTION_INFO_DEF + 4:
            OnGossipSelectGold(player, creature, 1, 1, Bet2);
            break;

        case GOSSIP_ACTION_INFO_DEF + 5:
            OnGossipSelectGold(player, creature, 1, 1, Bet3);
            break;

        case GOSSIP_ACTION_INFO_DEF + 6:
            OnGossipSelectGold(player, creature, 1, 1, Bet4);
            break;

        case GOSSIP_ACTION_INFO_DEF + 7:
            OnGossipSelectGold(player, creature, 1, 1, Bet5);
            break;

        case GOSSIP_ACTION_INFO_DEF + 8:
            player->PlayerTalkClass->ClearMenus();
            OnGossipHello(player, creature);
            break;
        }

        return true;
    }

    // Gossip Select Gold
    bool OnGossipSelectGold(Player* player, Creature* creature, uint32 sender, uint32 uiAction, uint32 gold)
    {
        player->PlayerTalkClass->ClearMenus();

        uint32 Roll = 0;		// Dice roll
        uint32 Amount = 0;		// Bet amount

        // Generate a "random" number	
        Roll = urand(1, 100);
        Bets = Bets + 1;

        // The house always wins (discourage spamming for the jackpot)
        if (Bets >= 10 && Roll == 100)
        {
            // If they have bet 10 times this session, decrement their roll 
            // by 1 to prevent a roll of 100 and hitting the jackpot. 
            Roll = Roll - 1;
        }

        // Setup the bet amount
        Amount = gold * 10000;			// Convert copper to gold
        Amount = Amount * 2;			// Double the bet amount

        // Losing Streak? Aww.. how about some help.
        // After 5 losses in a row, add +25 to their next roll.
        if (Losses >= 5 && Roll < 50)
        {
            std::ostringstream messageHelp;
            messageHelp << "Lady luck isn't on your side tonight " << player->GetName() << ".";
            creature->MonsterWhisper(messageHelp.str().c_str(), player);
            Roll = Roll + 25;
            Losses = 0;
        }

        // For the cheapskates
        Pocket = player->GetMoney();	// How much gold does the player currently have?
        if (Pocket < (Amount / 2))
        {
            std::ostringstream messageTaunt;
            messageTaunt << "Hey, I got no time for cheapskates " << player->GetName() << ". Come back when you have " << ((Amount / 10000) / 2) << " gold!";
            player->AddAura(228, player);	// Polymorph Chicken
            player->AddAura(5782, player);	// Fear
            creature->MonsterWhisper(messageTaunt.str().c_str(), player);
            player->CLOSE_GOSSIP_MENU();
            player->PlayDirectSound(5960); // Goblin Pissed
            creature->HandleEmoteCommand(EMOTE_ONESHOT_RUDE);
            return false;
        }

        // Hittin' the jackpot!
        if (Roll == 100)
        {
            std::ostringstream messageAction;
            std::ostringstream messageNotice;
            player->ModifyMoney(Jackpot * 10000);
            player->PlayDirectSound(3337);
            player->CastSpell(player, 47292);
            player->CastSpell(player, 44940);
            messageAction << "The bones come to rest with a total roll of " << Roll << ".";
            messageNotice << "Wowzers " << player->GetName() << "! You hit the jackpot and win " << Jackpot << " gold!";
            creature->MonsterWhisper(messageAction.str().c_str(), player);
            player->GetSession()->SendNotification(messageNotice.str().c_str());
            player->CLOSE_GOSSIP_MENU();
            creature->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
            return true;
        }

        // Why does it happen? Because it happens.. Roll the bones.. Roll the bones!
        if (Roll >= 50)
        {
            std::ostringstream messageAction;
            std::ostringstream messageNotice;
            player->ModifyMoney(Amount);
            Wins = Wins + 1;
            Losses = 0;
            player->PlayDirectSound(3337);
            player->CastSpell(player, 47292);
            player->CastSpell(player, 44940);
            messageAction << "The bones come to rest with a total roll of " << Roll << ".";
            messageNotice << "Congratulations " << player->GetName() << ", You've won " << Amount / 10000 << " gold!";
            creature->MonsterWhisper(messageAction.str().c_str(), player);
            ChatHandler(player->GetSession()).SendSysMessage(messageNotice.str().c_str());
            creature->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
        }
        else
        {
            std::ostringstream messageAction;
            std::ostringstream messageNotice;
            player->ModifyMoney(-Amount);
            Losses = Losses + 1;
            messageAction << "The bones come to rest with a total roll of " << Roll << ".";
            messageNotice << "Tough luck " << player->GetName() << ", you've lost " << Amount / 10000 << " gold!";
            creature->MonsterWhisper(messageAction.str().c_str(), player);
            ChatHandler(player->GetSession()).SendSysMessage(messageNotice.str().c_str());
            creature->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
        }

        OnGossipSelect(player, creature, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        return true;
    }

    // Passive Emotes
    struct gambler_passivesAI : public ScriptedAI
    {
        gambler_passivesAI(Creature * creature) : ScriptedAI(creature) { }

        uint32 uiAdATimer;
        uint32 uiAdBTimer;
        uint32 uiAdCTimer;

        void Reset()
        {
            uiAdATimer = 1000;
            uiAdBTimer = 23000;
            uiAdCTimer = 11000;
        }

        // Speak
        void UpdateAI(uint32 diff)
        {

            if (uiAdATimer <= diff)
            {
                me->MonsterSay("Come one, come all! Step right up to Skinny's! Place your bets, Place your bets!", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                me->CastSpell(me, 44940);
                uiAdATimer = 61000;
            }
            else
                uiAdATimer -= diff;

            if (uiAdBTimer <= diff)
            {
                me->MonsterSay("Come on! Place your bets, Don't be a chicken!", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CHICKEN);
                uiAdBTimer = 61000;
            }
            else
                uiAdBTimer -= diff;

            if (uiAdCTimer <= diff)
            {
                me->MonsterSay("Don't make me sad, Come and gamble! Step right up and win today!", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CRY);
                uiAdCTimer = 61000;
            }
            else
            {
                uiAdCTimer -= diff;
            }
        }
    };

    // Creature AI
    CreatureAI * GetAI(Creature * creature) const
    {
        return new gambler_passivesAI(creature);
    }
};

class gamble_npc_world : public WorldScript
{
public:
	gamble_npc_world() : WorldScript("gamble_npc_world") { }

	void OnBeforeConfigLoad(bool reload) override
	{
		if (!reload) {
			std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/npc_gambler.conf";
#ifdef WIN32
			cfg_file = "Settings/modules/npc_gambler.conf";
#endif
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());
		}
	}
};

void AddNPCGamblerScripts()
{
    new GamblerAnnounce();
    new gamble_npc();
}