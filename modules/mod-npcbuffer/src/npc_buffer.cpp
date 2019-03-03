/*

# Buffer NPC #

### Description ###
------------------------------------------------------------------------------------------------------------------
This is a one-click buffing NPC that will buff the player with a specific set of spells. The NPC can also
buff everyone the same or by player level. He speaks a random phrase after every use.

- Creates a Buff NPC with emotes
- Buffs the player with no dialogue interaction
- Buffs all the same or by player level
- Speaks a random phrase after every use
- Config: Spell ID(s) for buffs
- Config: Enable/Disable cure resurrection sickness


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC (ID: 601016)
- Script: buff_npc
- Config: Yes
- SQL: Yes


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.08.05
- v2017.08.06 - Removed dialogue options (Just buffs player on click)


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

#include "Config.h"
#include "ScriptPCH.h"

bool BufferAnnounceModule = 1;
bool BuffByLevel = 1;
bool BuffCureRes = 1;
uint32 NumPhrases = 10;

class BufferConfig : public WorldScript
{
public:
    BufferConfig() : WorldScript("BufferConfig_conf") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/npc_buffer.conf";
#ifdef WIN32
            cfg_file = "npc_buffer.conf";
#endif
            std::string cfg_def_file = cfg_file + ".dist";
            sConfigMgr->LoadMore(cfg_def_file.c_str());
            sConfigMgr->LoadMore(cfg_file.c_str());

            BufferAnnounceModule = sConfigMgr->GetBoolDefault("BufferNPC.Announce", 1);
            BuffByLevel = sConfigMgr->GetBoolDefault("Buff.ByLevel", 1);
            BuffCureRes = sConfigMgr->GetBoolDefault("Buff.CureRes", 1);
            NumPhrases = sConfigMgr->GetIntDefault("Buff.NumPhrases", 10);
        }
    }
};

class BufferAnnounce : public PlayerScript
{

public:

    BufferAnnounce() : PlayerScript("BufferAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (BufferAnnounceModule)
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00BufferNPC |rmodule.");
        }
    }
};

class buff_npc : public CreatureScript
{

public:

    buff_npc() : CreatureScript("buff_npc") { }

    bool replace(std::string& str, const std::string& from, const std::string& to)
    {
        size_t start_pos = str.find(from);
        if (start_pos == std::string::npos)
            return false;
        str.replace(start_pos, from.length(), to);
        return true;
    }

    bool OnGossipSelect(Player * player, Creature * creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        // Who are we dealing with?
        string PlayerName = player->GetName();
        uint32 PlayerLevel = player->getLevel();

        // Store Buff IDs
        std::vector<uint32> vecBuffs;
        std::stringstream ss(sConfigMgr->GetStringDefault("Buff.Spells", ""));
        for (std::string buff; std::getline(ss, buff, ';');)
        {
            vecBuffs.push_back(stoul(buff));
        }

        // Cure Resurrection Sickness
        if (BuffCureRes && player->HasAura(15007))
        {
            player->RemoveAura(15007, true);

            std::ostringstream res;
            res << "The aura of death has been lifted from you " << PlayerName << ". Watch yourself out there!";
            creature->MonsterWhisper(res.str().c_str(), player);
        }

        // Are we buffing based on level
        if (BuffByLevel == true)
        {
            // Apply (10-19, 20-29, ..., 70-79, 80)
            if (PlayerLevel < 10)
            {
                // Dish out the buffs
                player->CastSpell(player, 21562, true);     // Prayer of Fortitude (Rank 1)
                player->CastSpell(player, 1126, true);      // Mark of the Wild (Rank 1)
                player->CastSpell(player, 27683, true);     // Prayer of Shadow Protection (Rank 1)

            } // 1-9
            else if (PlayerLevel >= 10 && PlayerLevel < 20)
            {
                player->CastSpell(player, 21562, true);     // Prayer of Fortitude (Rank 1)
                player->CastSpell(player, 1126, true);      // Mark of the Wild (Rank 1)
                player->CastSpell(player, 27683, true);     // Prayer of Shadow Protection (Rank 1)

            } // 10-19
            else if (PlayerLevel >= 20 && PlayerLevel < 30)
            {
                player->CastSpell(player, 21562, true);     // Prayer of Fortitude (Rank 1)
                player->CastSpell(player, 1126, true);      // Mark of the Wild (Rank 1)
                player->CastSpell(player, 27683, true);     // Prayer of Shadow Protection (Rank 1)
                player->CastSpell(player, 13326, true);     // Arcane Intellect (Rank 1)

            } // 20-29
            else if (PlayerLevel >= 30 && PlayerLevel < 40)
            {
                player->CastSpell(player, 21562, true); // Prayer of Fortitude (Rank 1)
                player->CastSpell(player, 25898, true);  // Greater Blessing of Kings (Rank 1)
                player->CastSpell(player, 1126, true);  // Mark of the Wild (Rank 1)
                player->CastSpell(player, 27681, true); // Prayer of Spirit (Rank 1)
                player->CastSpell(player, 27683, true);  // Prayer of Shadow Protection (Rank 1)
                player->CastSpell(player, 13326, true);  // Arcane Intellect (Rank 1)

            } // 30-39
            else if (PlayerLevel >= 40 && PlayerLevel < 50)
            {
                player->CastSpell(player, 21562, true); // Prayer of Fortitude (Rank 1)
                player->CastSpell(player, vecBuffs[3], true); //Mark of the Wild(48469)
                player->CastSpell(player, 27681, true); // Prayer of Spirit (Rank 1)
                player->CastSpell(player, vecBuffs[5], true); //Prayer of Shadow Protection(48170)
                player->CastSpell(player, 13326, true);  // Arcane Intellect (Rank 1)

            } // 40-49
            else if (PlayerLevel >= 50 && PlayerLevel < 60)
            {
                player->CastSpell(player, vecBuffs[1], true); //Prayer of Fortitude(48162)
                player->CastSpell(player, vecBuffs[2], true); //Greater Blessing of Kings(43223)
                player->CastSpell(player, vecBuffs[3], true); //Mark of the Wild(48469)
                player->CastSpell(player, vecBuffs[4], true); //Prayer of Spirit(48074)
                player->CastSpell(player, vecBuffs[5], true); //Prayer of Shadow Protection(48170)
                player->CastSpell(player, vecBuffs[6], true); //Arcane Intellect(36880)
                                              
            } // 50-59
            else if (PlayerLevel >= 60 && PlayerLevel < 70)
            {
                player->CastSpell(player, vecBuffs[1], true); //Prayer of Fortitude(48162)
                player->CastSpell(player, vecBuffs[2], true); //Greater Blessing of Kings(43223)
                player->CastSpell(player, vecBuffs[3], true); //Mark of the Wild(48469)
                player->CastSpell(player, vecBuffs[4], true); //Prayer of Spirit(48074)
                player->CastSpell(player, vecBuffs[5], true); //Prayer of Shadow Protection(48170)
                player->CastSpell(player, vecBuffs[6], true); //Arcane Intellect(36880)

            } // 60-69
            else if (PlayerLevel >= 70 && PlayerLevel < 80)
            {
                player->CastSpell(player, vecBuffs[1], true); //Prayer of Fortitude(48162)
                player->CastSpell(player, vecBuffs[2], true); //Greater Blessing of Kings(43223)
                player->CastSpell(player, vecBuffs[3], true); //Mark of the Wild(48469)
                player->CastSpell(player, vecBuffs[4], true); //Prayer of Spirit(48074)
                player->CastSpell(player, vecBuffs[5], true); //Prayer of Shadow Protection(48170)
                player->CastSpell(player, vecBuffs[6], true); //Arcane Intellect(36880)
                                         
            } // 70-79
            else
            {
                player->CastSpell(player, vecBuffs[1], true); //Prayer of Fortitude(48162)
                player->CastSpell(player, vecBuffs[2], true); //Greater Blessing of Kings(43223)
                player->CastSpell(player, vecBuffs[3], true); //Mark of the Wild(48469)
                player->CastSpell(player, vecBuffs[4], true); //Prayer of Spirit(48074)
                player->CastSpell(player, vecBuffs[5], true); //Prayer of Shadow Protection(48170)
                player->CastSpell(player, vecBuffs[6], true); //Arcane Intellect(36880)

            } // LEVEL 80
        }
        else
        {
            // No level requirement, so buff with max level default buffs
            for (std::vector<uint32>::const_iterator itr = vecBuffs.begin(); itr != vecBuffs.end(); itr++)
            {
                player->CastSpell(player, *itr, true);
            }
        }

        // Choose and speak a random phrase to the player
        // Phrases are stored in the config file
        std::string phrase = "";
        uint32 PhraseNum = urand(1, NumPhrases); // How many phrases does the NPC speak? 
        phrase = "Buff.M" + std::to_string(PhraseNum);
        std::string randMsg = sConfigMgr->GetStringDefault(phrase.c_str(), "");
        replace(randMsg, "%s", PlayerName);
        creature->MonsterWhisper(randMsg.c_str(), player, false);

        // Emote and Close
        creature->HandleEmoteCommand(EMOTE_ONESHOT_FLEX);
        player->CLOSE_GOSSIP_MENU();
        return true;
    }

    // Passive Emotes
    struct buffer_passivesAI : public ScriptedAI
    {
        buffer_passivesAI(Creature * creature) : ScriptedAI(creature) { }

        uint32 uiAdATimer;
        uint32 uiAdBTimer;
        uint32 uiAdCTimer;

        void Reset()
        {
            uiAdATimer = 25000;
            uiAdBTimer = 50000;
            uiAdCTimer = 75000;
        }

        void UpdateAI(const uint32 diff)
        {

            if (uiAdATimer <= diff)
            {
                me->MonsterSay("You know.. I visited the Sunwell once. Long ago.", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CRY);
                me->CastSpell(me, 44940);
                uiAdATimer = 150000;
            }
            else
                uiAdATimer -= diff;

            if (uiAdBTimer <= diff)
            {
                me->MonsterSay("Good day to you traveller.", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
                uiAdBTimer = 150000;
            }
            else
                uiAdBTimer -= diff;

            if (uiAdCTimer <= diff)
            {
                me->MonsterSay("Mr. Grubbs is the toughest grub around. No doubt about it.", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                uiAdCTimer = 150000;
            }
            else
                uiAdCTimer -= diff;
        }
    };

    // CREATURE AI
    CreatureAI * GetAI(Creature * creature) const
    {
        return new buffer_passivesAI(creature);
    }
};

void AddNPCBufferScripts()
{
    new BufferConfig();
    new BufferAnnounce();
    new buff_npc();
}
