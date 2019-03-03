/*

# BeastMaster NPC #

### Description ###
------------------------------------------------------------------------------------------------------------------
WhiteFang is a Beastmaster NPC that howls! This NPC allows any player, or only Hunters, to adopt and use beasts.
He also teaches the player specific Hunter skills for use with their beasts. A player can adopt normal or exotic
beasts depending on how you've configured the NPC. For each type of beast I use a rare spawn model of a creature
of the same type, so they all look cool. He also sells a great selection of grub for every level of beast. Hunters
can access the stables as well. This has been a lot of fun for players of my repack, StygianCore, and beasts work
great and just like they do on a Hunter in or out of dungeons.


### Features ###
------------------------------------------------------------------------------------------------------------------
- Adds a Worgen BeastMaster NPC with sounds/emotes
- Allows adopting of beasts by level, class, and ability
- Teaches player all required Hunter abilities
- Sells beast food For all levels
- The scale of the beast is configurable


### To-Do ###
------------------------------------------------------------------------------------------------------------------
- Fix beast spells disappearing from beast bar on relog/dismiss (Note: they persist if added back)
- If possible, create working stable for non-Hunter player
- If possible, show the player's pet on the login screen for non-Hunter classes


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: BeastMaster
- Config: Yes
    - Module Announce
    - CorePatch check
    - Level Requirement
    - Enabled for Hunter class only
    - Require Beast Mastery talent
    - Allow Exotic Beasts for all classes (Teaches Beast Mastery)
    - Set Beast Scale Factor
- SQL: Yes
    - NPC ID: 601026


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2019.01.23 - Bugfixes, Merged AC repo
- v2019.01.08 - Added "Better Pet Handling" & "PetAlwaysHappy" config options
- v2017.09.30 - Add pet->InitLevelupSpellsForLevel(); recommended by Alistar
- v2017.09.13 - Teaches additional hunter spells (Eagle Eye, Eyes of the Beast, Beast Lore)
- v2017.09.11
    - Added Exotic Pet: Spirit Bear
    - Added Pet: Warp Stalker
    - Added Pet: Wind Serpent
    - Added Pet: Nether Ray
    - Added Pet: Spore Bat
    - Updated pet models to rare spawn models
- v2017.09.08 - Created new Pet Food item list for all pet levels
- v2017.09.04 - Fixed Spirit Beast persistence (teaches Beast Mastery to player)
- v2017.09.03 - Release


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
- [Stoabrogga] - Read pets from config file, Enums


### License ###
------------------------------------------------------------------------------------------------------------------
- This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).

*/

#include "Config.h"
#include "Pet.h"
#include "ScriptPCH.h"
#include "Configuration/Config.h"
#include "ScriptedGossip.h"

std::vector<uint32> HunterSpells = { 883, 982, 2641, 6991, 48990, 1002, 1462, 6197 };

std::map<std::string, uint32> Beasts;
std::map<std::string, uint32> RareBeasts;
std::map<std::string, uint32> ExoticBeasts;

uint32 BeastMasterMinLevel = 10;
float BeastMasterBeastScale = 1.0;
bool BeastMasterAnnounceToPlayer = 1;
bool BeastMasterHunterOnly = 0;
bool BeastMasterAdoptExotic = 1;
bool BeastMasterKeepBeastHappy = 1;
bool BeastMasterCorePatch = 0;
bool BeastMasterTalentRequired = 0;

enum PetGossip
{
    PET_BEASTMASTER_HOWL = 9036,
    PET_PAGE_SIZE = 13,
    PET_PAGE_START_BEASTS = 501,
    PET_PAGE_START_RARE_BEASTS = 601,
    PET_PAGE_START_EXOTIC_BEASTS = 701,
    PET_PAGE_MAX = 801,
    PET_MAIN_MENU = 50,
    PET_REMOVE_SKILLS = 80,
    PET_GOSSIP_HELLO = 601026
};

enum PetSpells
{
    PET_SPELL_CALL_PET = 883,
    PET_SPELL_BEAST_MASTERY = 53270,
    PET_MAX_HAPPINESS = 1048000
};

class BeastMasterConf : public WorldScript
{
public:
    BeastMasterConf() : WorldScript("BeastMasterConf") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/npc_beastmaster.conf";
#ifdef WIN32
            cfg_file = "npc_beastmaster.conf";
#endif
            std::string cfg_def_file = cfg_file + ".dist";

            sConfigMgr->LoadMore(cfg_def_file.c_str());
            sConfigMgr->LoadMore(cfg_file.c_str());

            BeastMasterAdoptExotic = sConfigMgr->GetBoolDefault("BeastMaster.AdoptExotic", true);
            BeastMasterAnnounceToPlayer = sConfigMgr->GetBoolDefault("BeastMaster.Announce", true);
            BeastMasterBeastScale = sConfigMgr->GetFloatDefault("BeastMaster.BeastScale", 1.0);
            BeastMasterCorePatch = sConfigMgr->GetBoolDefault("BeastMaster.CorePatch", false);
            BeastMasterHunterOnly = sConfigMgr->GetBoolDefault("BeastMaster.HunterOnly", false);
            BeastMasterKeepBeastHappy = sConfigMgr->GetBoolDefault("BeastMaster.KeepBeastHappy", true);
            BeastMasterMinLevel = sConfigMgr->GetIntDefault("BeastMaster.MinLevel", 10);
            BeastMasterTalentRequired = sConfigMgr->GetBoolDefault("BeastMaster.TalentRequired", false);

            // Sanitize (just n' case ya'll)
            if (BeastMasterMinLevel < 0 || BeastMasterMinLevel > 80)
            {
                BeastMasterMinLevel = 10;
            }
            if (BeastMasterBeastScale < 0.1 || BeastMasterBeastScale > 10)
            {
                BeastMasterBeastScale = 1.0;
            }

            LoadPets(sConfigMgr->GetStringDefault("BeastMaster.Beasts", ""), Beasts);
            LoadPets(sConfigMgr->GetStringDefault("BeastMaster.RareBeasts", ""), RareBeasts);
            LoadPets(sConfigMgr->GetStringDefault("BeastMaster.ExoticBeasts", ""), ExoticBeasts);
        }
    }

private:
    static void LoadPets(std::string pets, std::map<std::string, uint32> &petMap)
    {
        std::string delimitedValue;
        std::stringstream petsStringStream;
        std::string petName;
        int count = 0;

        petsStringStream.str(pets);

        while (std::getline(petsStringStream, delimitedValue, ','))
        {
            if (count % 2 == 0)
            {
                petName = delimitedValue;
            }
            else
            {
                uint32 petId = atoi(delimitedValue.c_str());

                if (petId >= 0)
                {
                    petMap[petName] = petId;
                }
            }

            count++;
        }
    }
};

class BeastMasterAnnounce : public PlayerScript
{

public:

    BeastMasterAnnounce() : PlayerScript("BeastMasterAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (BeastMasterAnnounceToPlayer)
        {
            if (BeastMasterCorePatch)
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00BeastMasterNPC (Patched) |rmodule.");
            else
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00BeastMasterNPC |rmodule.");
        }
    }
};

class BeastMaster : public CreatureScript
{

public:

    BeastMaster() : CreatureScript("BeastMaster") { }

    void CreatePet(Player *player, Creature * m_creature, uint32 entry)
    {
        // Check if player already has a pet
        if (player->GetPet())
        {
            player->CLOSE_GOSSIP_MENU();
            m_creature->MonsterWhisper("First you must abandon or stable your current pet!", player, false);
            m_creature->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
            return;
        }

        // Create Tamed Creature
        Pet* pet = player->CreateTamedPetFrom(entry, PET_SPELL_CALL_PET);
        if (!pet) { return; }

        // Set Pet Happiness
        pet->SetPower(POWER_HAPPINESS, PET_MAX_HAPPINESS);

        // Initialize Pet
        pet->AddUInt64Value(UNIT_FIELD_CREATEDBY, player->GetGUID());
        pet->SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, player->getFaction());
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel());

        // Prepare Level-Up Visual
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel() - 1);
        pet->GetMap()->AddToMap(pet->ToCreature());

        // Visual Effect for Level-Up
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel());

        // Initialize Pet Stats
        pet->InitTalentForLevel();
        if (!pet->InitStatsForLevel(player->getLevel()))
        {
            // sLog->outError("Pet Create fail: no init stats for entry %u", entry);
            pet->UpdateAllStats();
        }

        // Scale Pet
        pet->SetObjectScale(BeastMasterBeastScale);

        // Caster Pets?
        player->SetMinion(pet, true);

        // Save Pet
        pet->GetCharmInfo()->SetPetNumber(sObjectMgr->GeneratePetNumber(), true);
        player->PetSpellInitialize();
        pet->InitLevelupSpellsForLevel();
        pet->SavePetToDB(PET_SAVE_AS_CURRENT, 0);

        // Learn Hunter Abilities (only for non-hunter classes)
        if (player->getClass() != CLASS_HUNTER)
        {
            // Assume player has already learned the spells if they have Call Pet
            if (!player->HasSpell(PET_SPELL_CALL_PET))
            {
                for (int i = 0; i < HunterSpells.size(); ++i)
                    player->learnSpell(HunterSpells[i]);
            }
        }

        // Farewell
        std::ostringstream messageAdopt;
        messageAdopt << "A fine choice " << player->GetName() << "! Your " << pet->GetName() << " shall know no law but that of the club and fang.";
        player->CLOSE_GOSSIP_MENU();
        m_creature->MonsterWhisper(messageAdopt.str().c_str(), player);
        m_creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
    }

    bool OnGossipHello(Player *player, Creature * m_creature)
    {
        // Howl
        m_creature->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);

        // Are we only serving the Hunter class?
        if (BeastMasterHunterOnly && player->getClass() != CLASS_HUNTER)
        {
            // Are there any core modifications to Pet.cpp?
            // This check is not needed, but here for amusement.
            if (BeastMasterCorePatch)
            {
                std::ostringstream messageSorry;
                messageSorry << "Sorry " << player->GetName() << ", but your knowledge of the wilds leaves much to be desired.";
                m_creature->MonsterWhisper(messageSorry.str().c_str(), player);
                m_creature->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
            }
            else
            {
                std::ostringstream messagePatch;
                messagePatch << "Hail " << player->GetName() << ", take only memories, leave only footprints.";
                m_creature->MonsterWhisper(messagePatch.str().c_str(), player);
                return false;
            }
        }
        // Check level requirement
        else if (player->getLevel() < BeastMasterMinLevel && BeastMasterMinLevel != 0)
        {
            std::ostringstream messageExperience;
            messageExperience << "Sorry " << player->GetName() << ", but you must reach Level " << BeastMasterMinLevel << " before adopting a beast.";
            m_creature->MonsterWhisper(messageExperience.str().c_str(), player);
            m_creature->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
            return false;
        }
        else
        {
            // MAIN MENU
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_BEASTS);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Rare Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_RARE_BEASTS);

            // Exotic Beasts can be adopted by anyone or only the hunter class with or without the Beast Mastery talent
            if (BeastMasterAdoptExotic || player->HasSpell(PET_SPELL_BEAST_MASTERY) || player->HasTalent(PET_SPELL_BEAST_MASTERY, player->GetActiveSpec()))
            {
                // If player isn't a Hunter class, let them adopt exotic beasts.
                if (player->getClass() != CLASS_HUNTER)
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_EXOTIC_BEASTS);

                    // Greet the player
                    std::ostringstream messageSorry;
                    messageSorry << "Hail " << player->GetName() << ", take only memories, leave only footprints.";
                    m_creature->MonsterWhisper(messageSorry.str().c_str(), player);
                }
                else
                {
                    // Is the player a real beast master?
                    if (player->HasTalent(PET_SPELL_BEAST_MASTERY, player->GetActiveSpec()))
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_EXOTIC_BEASTS);

                        // Greet the player
                        std::ostringstream messageAdopt;
                        messageAdopt << "Greetings " << player->GetName() << ", it's an honor to meet a true Beast Master.";
                        m_creature->MonsterWhisper(messageAdopt.str().c_str(), player);
                        m_creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    }
                    else
                    {
                        // If not, can hunters adopt exotic beasts without learning beast mastery first ?
                        if (!BeastMasterTalentRequired)
                        {
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_EXOTIC_BEASTS);

                            // Greet the player
                            std::ostringstream messageAdopt;
                            messageAdopt << "How goes it " << player->GetName() << "? Have you seen my exotic beasts yet?";
                            m_creature->MonsterWhisper(messageAdopt.str().c_str(), player);
                            m_creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                        }
                        else
                        {
                            // Hunters must train beast mastery before adopting exotic beasts.
                            std::ostringstream messageAdopt;
                            messageAdopt << "Alas " << player->GetName() << ".. One must master the ways of the wilds to control exotic beasts.";
                            m_creature->MonsterWhisper(messageAdopt.str().c_str(), player);
                            m_creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                        }
                    }
                }
            }

            // Remove Hunter abilties from non-Hunter characters
            if (player->getClass() != CLASS_HUNTER && player->HasSpell(PET_SPELL_CALL_PET))
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Unlearn Hunter Abilities", GOSSIP_SENDER_MAIN, PET_REMOVE_SKILLS);
            }
        }

        // Stables for Hunters only - Not working for non-Hunter classes
        if (player->getClass() == CLASS_HUNTER)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Visit Stable", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_STABLEPET);
        }

        // Buy Food
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "Buy Food", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
        player->PlayerTalkClass->SendGossipMenu(PET_GOSSIP_HELLO, m_creature->GetGUID());

        // Howl/Roar
        player->PlayDirectSound(PET_BEASTMASTER_HOWL);
        m_creature->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
        return true;
    }

    bool OnGossipSelect(Player *player, Creature * m_creature, uint32 sender, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();

        if (action == PET_MAIN_MENU)
        {
            // MAIN MENU
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_BEASTS);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Rare Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_RARE_BEASTS);

            // EXOTIC BEASTS can be adopted by anyone or only the hunter class with or without the Beast Mastery talent
            if (BeastMasterAdoptExotic || player->HasSpell(PET_SPELL_BEAST_MASTERY) || player->HasTalent(PET_SPELL_BEAST_MASTERY, player->GetActiveSpec()))
            {
                // Allow exotic beast adoption if not a Hunter class
                if (player->getClass() != CLASS_HUNTER)
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_EXOTIC_BEASTS);
                }
                else
                {
                    // Do Hunters need to learn Beast Mastery before adopting exotic beasts?
                    if (!BeastMasterTalentRequired || player->HasTalent(PET_SPELL_BEAST_MASTERY, player->GetActiveSpec()))
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Beasts", GOSSIP_SENDER_MAIN, PET_PAGE_START_EXOTIC_BEASTS);
                    }
                    else
                    {
                        // Of all the things I've lost, I miss my mind the most.
                    }
                }
            }

            // Remove Hunter abilities (for non-Hunter classes)
            if (player->getClass() != CLASS_HUNTER && player->HasSpell(PET_SPELL_CALL_PET))
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Unlearn Hunter Abilities", GOSSIP_SENDER_MAIN, PET_REMOVE_SKILLS);
            }

            // Stables for Hunters only - Doesn't seem to work for other classes
            if (player->getClass() == CLASS_HUNTER)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Visit Stable", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_STABLEPET);
            }

            // Buy Food
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "Buy Food", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
            //player->PlayerTalkClass->SendGossipMenu(DEFAULT_GOSSIP_MESSAGE, m_creature->GetGUID());
            player->PlayerTalkClass->SendGossipMenu(PET_GOSSIP_HELLO, m_creature->GetGUID());
        }
        else if (action >= PET_PAGE_START_BEASTS && action < PET_PAGE_START_RARE_BEASTS)
        {
            // BEASTS
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Back..", GOSSIP_SENDER_MAIN, PET_MAIN_MENU);
            int page = action - PET_PAGE_START_BEASTS + 1;
            int maxPage = Beasts.size() / PET_PAGE_SIZE + (Beasts.size() % PET_PAGE_SIZE != 0);

            if (page > 1)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Previous..", GOSSIP_SENDER_MAIN, PET_PAGE_START_BEASTS + page - 2);
            }

            if (page < maxPage)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Next..", GOSSIP_SENDER_MAIN, PET_PAGE_START_BEASTS + page);
            }

            AddGossip(player, Beasts, page);
            player->PlayerTalkClass->SendGossipMenu(DEFAULT_GOSSIP_MESSAGE, m_creature->GetGUID());
        }
        else if (action >= PET_PAGE_START_RARE_BEASTS && action < PET_PAGE_START_EXOTIC_BEASTS)
        {
            // RARE BEASTS
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Back..", GOSSIP_SENDER_MAIN, PET_MAIN_MENU);
            int page = action - PET_PAGE_START_RARE_BEASTS + 1;
            int maxPage = RareBeasts.size() / PET_PAGE_SIZE + (RareBeasts.size() % PET_PAGE_SIZE != 0);

            if (page > 1)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Previous..", GOSSIP_SENDER_MAIN, PET_PAGE_START_RARE_BEASTS + page - 2);
            }
            if (page < maxPage)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Next..", GOSSIP_SENDER_MAIN, PET_PAGE_START_RARE_BEASTS + page);
            }

            AddGossip(player, RareBeasts, page);
            player->PlayerTalkClass->SendGossipMenu(DEFAULT_GOSSIP_MESSAGE, m_creature->GetGUID());
        }
        else if (action >= PET_PAGE_START_EXOTIC_BEASTS && action < PET_PAGE_MAX)
        {
            // EXOTIC BEASTS
            // Teach Beast Mastery or Spirit Beasts won't work properly
            if (!(player->HasSpell(PET_SPELL_BEAST_MASTERY) || player->HasTalent(PET_SPELL_BEAST_MASTERY, player->GetActiveSpec())))
            {
                player->addSpell(PET_SPELL_BEAST_MASTERY, SPEC_MASK_ALL, false);
                std::ostringstream messageLearn;
                messageLearn << "I have taught you the art of Beast Mastery " << player->GetName() << ".";
                m_creature->MonsterWhisper(messageLearn.str().c_str(), player);
            }

            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Back..", GOSSIP_SENDER_MAIN, PET_MAIN_MENU);
            int page = action - PET_PAGE_START_EXOTIC_BEASTS + 1;
            int maxPage = ExoticBeasts.size() / PET_PAGE_SIZE + (ExoticBeasts.size() % PET_PAGE_SIZE != 0);

            if (page > 1)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Previous..", GOSSIP_SENDER_MAIN, PET_PAGE_START_EXOTIC_BEASTS + page - 2);
            }

            if (page < maxPage)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Next..", GOSSIP_SENDER_MAIN, PET_PAGE_START_EXOTIC_BEASTS + page);
            }

            AddGossip(player, ExoticBeasts, page);
            player->PlayerTalkClass->SendGossipMenu(DEFAULT_GOSSIP_MESSAGE, m_creature->GetGUID());
        }
        else if (action == PET_REMOVE_SKILLS)
        {
            // Remove Hunter Abilities
            for (int i = 0; i < HunterSpells.size(); ++i)
            {
                player->removeSpell(HunterSpells[i], SPEC_MASK_ALL, false); // Remove Hunter Abilities
            }
            player->removeSpell(PET_SPELL_BEAST_MASTERY, SPEC_MASK_ALL, false); // Remove Beast Mastery Talent
            player->CLOSE_GOSSIP_MENU();
        }
        else if (action == GOSSIP_OPTION_STABLEPET)
        {
            // STABLE
            player->GetSession()->SendStablePet(m_creature->GetGUID());
        }
        else if (action == GOSSIP_OPTION_VENDOR)
        {
            // VENDOR
            player->GetSession()->SendListInventory(m_creature->GetGUID());
        }

        // BEASTS
        if (action > 1000)
        {
            CreatePet(player, m_creature, action);
        }

        return true;
    }

private:
    static void AddGossip(Player *player, std::map<std::string, uint32> &petMap, int page)
    {
        std::map<std::string, uint32>::iterator it;
        int count = 1;

        for (it = petMap.begin(); it != petMap.end(); it++)
        {
            if (count > (page - 1) * PET_PAGE_SIZE && count <= page * PET_PAGE_SIZE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, it->first, GOSSIP_SENDER_MAIN, it->second);

            count++;
        }
    }
};

class BeastMaster_PlayerScript : public PlayerScript
{
public:
    BeastMaster_PlayerScript()
        : PlayerScript("BeastMaster_PlayerScript")
    {
    }

    // Infinite Beast Happiness
    void OnBeforeUpdate(Player* player, uint32 /*p_time*/) override
    {
        if (BeastMasterKeepBeastHappy && player->GetPet())
        {
            Pet* pet = player->GetPet();

            if (pet->getPetType() == HUNTER_PET)
            {
                pet->SetPower(POWER_HAPPINESS, PET_MAX_HAPPINESS);
            }
        }
    }
};

void AddBeastMasterScripts()
{
    new BeastMasterConf();
    new BeastMasterAnnounce();
    new BeastMaster();
    new BeastMaster_PlayerScript();
}
