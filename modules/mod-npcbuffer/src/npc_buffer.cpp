/*

# Buffer NPC

_This module was created for [StygianCore](https://rebrand.ly/stygiancoreproject). A World of Warcraft 3.3.5a Solo/LAN repack by StygianTheBest | [GitHub](https://rebrand.ly/stygiangithub) | [Website](https://rebrand.ly/stygianthebest))_

### Description
------------------------------------------------------------------------------------------------------------------
This is a one-click buffing NPC that will buff the player with a specific set of spells. The NPC can also buff
everyone the same or by player level. He speaks a configurable random phrase after every use and can also attract
the player using configurable emote options.

- Creates a Buff NPC with emotes
- Buffs the player with no dialogue interaction
- Buffs all the same or by player level
- Speaks configurable random whispers to the player after every use
- Attracts the player using configurable emotes
- Config:
    - Buff by level
    - Spell ID(s) for buffs
    - Enable/Disable cure resurrection sickness
    - Emote Options

### Data
------------------------------------------------------------------------------------------------------------------
- Type: NPC (ID: 601016)
- Script: buff_npc
- Config: Yes
- SQL: Yes

### Version
------------------------------------------------------------------------------------------------------------------
- v2019.02.13 - Added phrases/emotes, config options, updated AI
- v2017.08.06 - Removed dialogue options (Just buffs player on click)
- v2017.08.05

### CREDITS
------------------------------------------------------------------------------------------------------------------
![Styx](https://stygianthebest.github.io/assets/img/avatar/avatar-128.jpg "Styx")
![StygianCore](https://stygianthebest.github.io/assets/img/projects/stygiancore/StygianCore.png "StygianCore")

##### This module was created for [StygianCore](https://rebrand.ly/stygiancoreproject). A World of Warcraft 3.3.5a Solo/LAN repack by StygianTheBest | [GitHub](https://rebrand.ly/stygiangithub) | [Website](https://rebrand.ly/stygianthebest))

#### Additional Credits

- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)
- [OregonCore](https://wiki.oregon-core.net/)
- [Wowhead.com](http://wowhead.com)
- [OwnedCore](http://ownedcore.com/)
- [ModCraft.io](http://modcraft.io/)
- [MMO Society](https://www.mmo-society.com/)
- [AoWoW](https://wotlk.evowow.com/)
- [More credits are cited in the sources](https://github.com/StygianTheBest)

### LICENSE
------------------------------------------------------------------------------------------------------------------
This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).

*/

#include "Config.h"
#include "ScriptPCH.h"

bool BFAnnounceModule;
bool BuffByLevel;
bool BuffCureRes;
uint32 BuffNumPhrases;
uint32 BuffNumWhispers;
uint32 BuffMessageTimer;
uint32 BuffEmoteSpell;
uint32 BuffEmoteCommand;

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

            BFAnnounceModule = sConfigMgr->GetBoolDefault("Buff.Announce", 1);
            BuffByLevel = sConfigMgr->GetBoolDefault("Buff.ByLevel", 1);
            BuffCureRes = sConfigMgr->GetBoolDefault("Buff.CureRes", 1);
            BuffNumPhrases = sConfigMgr->GetIntDefault("Buff.NumPhrases", 3);
            BuffNumWhispers = sConfigMgr->GetIntDefault("Buff.NumWhispers", 3);
            BuffMessageTimer = sConfigMgr->GetIntDefault("Buff.MessageTimer", 60000);
            BuffEmoteSpell = sConfigMgr->GetIntDefault("Buff.EmoteSpell", 44940);
            BuffEmoteCommand = sConfigMgr->GetIntDefault("Buff.EmoteCommand", 3);

            // Enforce Min/Max Time
            if (BuffMessageTimer != 0)
            {
                if (BuffMessageTimer < 60000 || BuffMessageTimer > 300000)
                {
                    BuffMessageTimer = 60000;
                }
            }
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
        if (BFAnnounceModule)
        {
            ChatHandler(player->GetSession()).SendSysMessage("");
        }
    }
};

class buff_npc : public CreatureScript
{

public:

    buff_npc() : CreatureScript("buff_npc") { }

    static bool replace(std::string& str, const std::string& from, const std::string& to)
    {
        size_t start_pos = str.find(from);
        if (start_pos == std::string::npos)
            return false;
        str.replace(start_pos, from.length(), to);
        return true;
    }

    static string PickWhisper(string Name)
    {
        // Choose and speak a random phrase to the player
        // Phrases are stored in the config file
        std::string whisper = "";
        uint32 WhisperNum = urand(1, BuffNumWhispers); // How many phrases does the NPC speak? 
        whisper = "BF.W" + std::to_string(WhisperNum);

        // Sanitize
        if (whisper == "")
        {
            whisper = "ERROR! NPC Emote Text Not Found! Check the npc_buffer.conf!";
        }

        std::string randMsg = sConfigMgr->GetStringDefault(whisper.c_str(), "");
        replace(randMsg, "%s", Name);
        return randMsg.c_str();
    }

    static string PickPhrase()
    {
        // Choose and speak a random phrase to the player
        // Phrases are stored in the config file
        std::string phrase = "";
        uint32 PhraseNum = urand(1, BuffNumPhrases); // How many phrases does the NPC speak? 
        phrase = "BF.P" + std::to_string(PhraseNum);

        // Sanitize
        if (phrase == "")
        {
            phrase = "ERROR! NPC Emote Text Not Found! Check the npc_buffer.conf!";
        }

        std::string randMsg = sConfigMgr->GetStringDefault(phrase.c_str(), "");
        return randMsg.c_str();
    }

    bool OnGossipSelect(Player *player, Creature *creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        // Who are we dealing with?
        string CreatureWhisper = "Init";
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
                player->CastSpell(player, 48469, true); //Mark of the Wild(48469)
                player->CastSpell(player, 27681, true); // Prayer of Spirit (Rank 1)
                player->CastSpell(player, 48170, true); //Prayer of Shadow Protection(48170)
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
        creature->MonsterWhisper(PickWhisper(PlayerName).c_str(), player);

        // Emote and Close
        creature->HandleEmoteCommand(EMOTE_ONESHOT_FLEX);
        player->CLOSE_GOSSIP_MENU();
        return true;
    }

    // Passive Emotes
    struct NPC_PassiveAI : public ScriptedAI
    {
        NPC_PassiveAI(Creature * creature) : ScriptedAI(creature) { }

        uint32 MessageTimer;

        // Called once when client is loaded
        void Reset()
        {
            MessageTimer = urand(BuffMessageTimer, 300000); // 1-5 minutes
        }

        // Called at World update tick
        void UpdateAI(const uint32 diff)
        {
            if (MessageTimer <= diff)
            {
                std::string Message = PickPhrase();
                me->MonsterSay(Message.c_str(), LANG_UNIVERSAL, NULL);

                // Use gesture?
                if (BuffEmoteCommand != 0)
                {
                    me->HandleEmoteCommand(BuffEmoteCommand);
                }

                // Alert players?
                if (BuffEmoteSpell != 0)
                {
                    me->CastSpell(me, BuffEmoteSpell);
                }

                MessageTimer = urand(BuffMessageTimer, 300000);
            }
            else { MessageTimer -= diff; }
        }
    };

    // CREATURE AI
    CreatureAI * GetAI(Creature * creature) const
    {
        return new NPC_PassiveAI(creature);
    }
};

void AddNPCBufferScripts()
{
    new BufferConfig();
    new BufferAnnounce();
    new buff_npc();
}
