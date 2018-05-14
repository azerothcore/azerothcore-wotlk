/*

# BeastMaster NPC #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------


### Description ###
------------------------------------------------------------------------------------------------------------------
WhiteFang is a Beastmaster NPC that howls! This NPC allows any player, or only Hunters, to adopt and use pets. He
also teaches the player specific Hunter skills for use with their pets. A player can adopt normal or exotic pets
depending on how you've configured the NPC. For each pet I use a model for a rare creature of the same type, so
they all look cool. He also sells a great selection of pet food for every level of pet. Hunters can access the
stables as well. This has been a lot of fun for players on my server, and pets work great and just like they do
on a Hunter in or out of dungeons.


### Features ###
------------------------------------------------------------------------------------------------------------------
- Adds a Worgen BeastMaster NPC with sounds/emotes
- Allows all classes, or Hunters only, to adopt new pets
- Teaches Normal and Exotic Pets
- Allows Exotic Beast acquisition with or without spec
- Teaches Hunter abilities to the player
- Sells pet food For all pet levels
- Pet scale is configurable


### To-Do ###
------------------------------------------------------------------------------------------------------------------
- If possible, create working stable for non-Hunter player
- Fix pet spells disappearing from pet bar on relog/dismiss (Note: they persist if added back)

### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: BeastMaster
- Config: Yes
    - Enable Module Announce
    - Enable For Hunter Only
    - Enable Exotic Pet Adoption Without Spec (Teaches Beast Mastery)
    - Set Pet Scaling Factor
- SQL: Yes
    - NPC ID: 601026


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.09.03 - Release
- v2017.09.04 - Fixed Spirit Beast persistence (teaches Beast Mastery to player)
- v2017.09.08 - Created new Pet Food item list for all pet levels
- v2017.09.11
    - Added Exotic Pet: Spirit Bear
    - Added Pet: Warp Stalker
    - Added Pet: Wind Serpent
    - Added Pet: Nether Ray
    - Added Pet: Spore Bat
    - Updated pet models to rare spawn models
- v2017.09.13 - Teaches additional hunter spells (Eagle Eye, Eyes of the Beast, Beast Lore)
- v2017.09.30 - Add pet->InitLevelupSpellsForLevel(); recommended by Alistar


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
#include "Pet.h"
#include "ScriptPCH.h"
#include "ScriptedGossip.h"

class BeastMasterAnnounce : public PlayerScript
{

public:

    BeastMasterAnnounce() : PlayerScript("BeastMasterAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (sConfigMgr->GetBoolDefault("BeastMasterNPC.Announce", true))
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00BeastMasterNPC |rmodule");
        }
    }
};

class BeastMaster : public CreatureScript
{

public:

    BeastMaster() : CreatureScript("BeastMaster") { }

    void CreatePet(Player *player, Creature * m_creature, uint32 entry)
    {
        // Get Pet Scale from config
        const float PetScale = sConfigMgr->GetFloatDefault("BeastMaster.PetScale", 1.0);

        // If enabled for Hunters only..
        if (sConfigMgr->GetBoolDefault("BeastMaster.HunterOnly", true))
        {
            if (player->getClass() != CLASS_HUNTER)
            {
                m_creature->MonsterWhisper("Silly fool, Pets are for Hunters!", player, false);
                m_creature->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                player->CLOSE_GOSSIP_MENU();
                return;
            }
        }

        // Check if player already has a pet
        if (player->GetPet())
        {
            m_creature->MonsterWhisper("First you must abandon or stable your current pet!", player, false);
            player->CLOSE_GOSSIP_MENU();
            return;
        }

        // Summon Creature
        Creature *creatureTarget = m_creature->SummonCreature(entry, player->GetPositionX(), player->GetPositionY() + 2, player->GetPositionZ(), player->GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 500);
        if (!creatureTarget) { return; }

        // Create Tamed Creature
        Pet* pet = player->CreateTamedPetFrom(creatureTarget, 0);
        if (!pet) { return; }

        // Kill Original Creature
        creatureTarget->setDeathState(JUST_DIED);
        creatureTarget->RemoveCorpse();
        creatureTarget->SetHealth(0);   // For Nice GM View

        // Set Pet Happiness
        pet->SetPower(POWER_HAPPINESS, 1048000);

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
        pet->SetObjectScale(PetScale);

        // Caster Pets?
        player->SetMinion(pet, true);

        // Save Pet
        pet->GetCharmInfo()->SetPetNumber(sObjectMgr->GeneratePetNumber(), true);
        player->PetSpellInitialize();
        pet->InitLevelupSpellsForLevel();
        pet->SavePetToDB(PET_SAVE_AS_CURRENT, 0);

        // Learn Hunter Abilities
        // Assume player has already learned the spells if they have Eagle Eye
        if (!player->HasSpell(6197))
        {
            // player->learnSpell(13481);	// Tame Beast - Not working for non-hunter classes
            player->learnSpell(883);	// Call Pet
            player->learnSpell(982);	// Revive Pet
            player->learnSpell(2641);	// Dismiss Pet
            player->learnSpell(6991);	// Feed Pet
            player->learnSpell(33976);	// Mend Pet	
            player->learnSpell(1002);	// Eyes of the Beast
            player->learnSpell(1462);	// Beast Lore
            player->learnSpell(6197);	// Eagle Eye
        }

        // Farewell
        std::ostringstream messageAdopt;
        messageAdopt << "A fine choice " << player->GetName() << "! Your " << pet->GetName() << " shall know no law but that of the club and fang.";
        m_creature->MonsterWhisper(messageAdopt.str().c_str(), player);
        player->CLOSE_GOSSIP_MENU();
        m_creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
    }

    bool OnGossipHello(Player *player, Creature * m_creature)
    {
        // Howl
        m_creature->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);

        // If enabled for Hunters only..
        if (sConfigMgr->GetBoolDefault("BeastMaster.HunterOnly", true))
        {
            if (player->getClass() != CLASS_HUNTER)
            {
                m_creature->MonsterWhisper("Silly fool, Pets are for Hunters!", player, false);
                m_creature->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                player->CLOSE_GOSSIP_MENU();
                return false;
            }
        }

        // MAIN MENU
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Pets", GOSSIP_SENDER_MAIN, 51);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Rare Pets", GOSSIP_SENDER_MAIN, 54);

        // Allow Exotic Pets regardless of spec
        if (sConfigMgr->GetBoolDefault("BeastMaster.ExoticNoSpec", true))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Pets", GOSSIP_SENDER_MAIN, 53);
        }
        else
        {
            if (player->CanTameExoticPets())
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Pets", GOSSIP_SENDER_MAIN, 53);
            }
        }

        // Stables for hunters only - Doesn't seem to work for other classes
        if (player->getClass() == CLASS_HUNTER)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Visit Stable", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_STABLEPET);
        }

        // Pet Food Vendor
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "Buy Pet Food", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
        player->PlayerTalkClass->SendGossipMenu(601026, m_creature->GetGUID());

        // Howl/Roar
        player->PlayDirectSound(9036);
        m_creature->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);

        return true;
    }

    bool OnGossipSelect(Player *player, Creature * m_creature, uint32 sender, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();

        switch (action)
        {

            // MAIN MENU
        case 50:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Pets", GOSSIP_SENDER_MAIN, 51);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Rare Pets", GOSSIP_SENDER_MAIN, 54);

            // Allow Exotics for all players
            if (sConfigMgr->GetBoolDefault("BeastMaster.ExoticNoSpec", true))
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Pets", GOSSIP_SENDER_MAIN, 53);
            }
            else
            {
                // Allow Exotics only for Hunters with Beast Mastery
                if (player->CanTameExoticPets())
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Browse Exotic Pets", GOSSIP_SENDER_MAIN, 53);
                }
            }

            // Stables for hunters only - Doesn't seem to work for other classes
            if (player->getClass() == CLASS_HUNTER)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Visit Stable", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_STABLEPET);
            }

            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "Buy Pet Food", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
            player->PlayerTalkClass->SendGossipMenu(100001, m_creature->GetGUID());
            break;

            // PETS PAGE 1
        case 51:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Back..", GOSSIP_SENDER_MAIN, 50);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Next..", GOSSIP_SENDER_MAIN, 52);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Bat", GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Bear", GOSSIP_SENDER_MAIN, 2);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Boar", GOSSIP_SENDER_MAIN, 300);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Cat", GOSSIP_SENDER_MAIN, 4);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Carrion Bird", GOSSIP_SENDER_MAIN, 5);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Crab", GOSSIP_SENDER_MAIN, 6);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Crocolisk", GOSSIP_SENDER_MAIN, 7);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Dragonhawk", GOSSIP_SENDER_MAIN, 8);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Gorilla", GOSSIP_SENDER_MAIN, 9);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Hound", GOSSIP_SENDER_MAIN, 10);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Hyena", GOSSIP_SENDER_MAIN, 11);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Moth", GOSSIP_SENDER_MAIN, 12);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Nether Ray", GOSSIP_SENDER_MAIN, 13);
            player->PlayerTalkClass->SendGossipMenu(100002, m_creature->GetGUID());
            break;

            // PETS PAGE 2
        case 52:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Back..", GOSSIP_SENDER_MAIN, 50);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Previous..", GOSSIP_SENDER_MAIN, 51);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Owl", GOSSIP_SENDER_MAIN, 140);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Raptor", GOSSIP_SENDER_MAIN, 15);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Ravager", GOSSIP_SENDER_MAIN, 16);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Scorpid", GOSSIP_SENDER_MAIN, 17);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Serpent", GOSSIP_SENDER_MAIN, 18);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Spider", GOSSIP_SENDER_MAIN, 19);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Spore Bat", GOSSIP_SENDER_MAIN, 20);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Tallstrider", GOSSIP_SENDER_MAIN, 21);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Turtle", GOSSIP_SENDER_MAIN, 22);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Warp Stalker", GOSSIP_SENDER_MAIN, 23);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Wasp", GOSSIP_SENDER_MAIN, 24);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Wind Serpent", GOSSIP_SENDER_MAIN, 25);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Wolf", GOSSIP_SENDER_MAIN, 26);
            player->PlayerTalkClass->SendGossipMenu(100003, m_creature->GetGUID());
            break;

            // EXOTIC BEASTS
        case 53:

            // Teach Beast Mastery or Spirit Beasts won't work properly
            if (!player->HasSpell(53270))
            {
                player->learnSpell(53270);
                std::ostringstream messageLearn;
                messageLearn << "I have taught you the art of Beast Mastery " << player->GetName() << ".";
                m_creature->MonsterWhisper(messageLearn.str().c_str(), player);
            }

            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Back..", GOSSIP_SENDER_MAIN, 50);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Chimaera", GOSSIP_SENDER_MAIN, 27);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Core Hound", GOSSIP_SENDER_MAIN, 28);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Devilsaur", GOSSIP_SENDER_MAIN, 29);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Rhino", GOSSIP_SENDER_MAIN, 30);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Silithid", GOSSIP_SENDER_MAIN, 31);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Jormungar Worm", GOSSIP_SENDER_MAIN, 32);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Arcturis (Spirit Bear)", GOSSIP_SENDER_MAIN, 33);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Gondria (Spirit Tiger)", GOSSIP_SENDER_MAIN, 34);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Loque'nahak (Spirit Leopard)", GOSSIP_SENDER_MAIN, 35);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Skoll (Spirit Worg)", GOSSIP_SENDER_MAIN, 36);
            player->PlayerTalkClass->SendGossipMenu(100003, m_creature->GetGUID());
            break;

            // RARE PETS
        case 54:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Back..", GOSSIP_SENDER_MAIN, 50);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Mazzranache (Tallstrider)", GOSSIP_SENDER_MAIN, 37);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Aotona (Bird)", GOSSIP_SENDER_MAIN, 38);
            player->PlayerTalkClass->SendGossipMenu(100004, m_creature->GetGUID());
            break;

            // STABLE
        case GOSSIP_OPTION_STABLEPET:
            player->GetSession()->SendStablePet(m_creature->GetGUID());
            break;

            // VENDOR
        case GOSSIP_OPTION_VENDOR:
            player->GetSession()->SendListInventory(m_creature->GetGUID());
            break;

            // BEASTS
        case 1: // Bat (Shadikith The Glider)
            CreatePet(player, m_creature, 16180);
            break;

        case 2: // Bear (Ursollok)
            CreatePet(player, m_creature, 12037);
            break;

        case 300: // Boar (Armored Brown)
            CreatePet(player, m_creature, 29996);
            break;

        case 4: // Cat (Shadowclaw)
            CreatePet(player, m_creature, 2175);
            break;

        case 5: // Carrion Bird (Zaricotl)
            CreatePet(player, m_creature, 2931);
            break;

        case 6: // Crab (Crusty)
            CreatePet(player, m_creature, 18241);
            break;

        case 7: // Crocolisk (Izod Green)
            CreatePet(player, m_creature, 1417);
            break;

        case 8: // Dragonhawk (Bloodfalcon)
            CreatePet(player, m_creature, 18155);
            break;

        case 9: // Gorilla (King Mukla)
            CreatePet(player, m_creature, 1559);
            break;

        case 10: // Hound (Darkhound - Registers as Wolf Pre-Cata)
            CreatePet(player, m_creature, 29452);
            break;

        case 11: // Hyena (Snort the Heckler)
            CreatePet(player, m_creature, 5829);
            break;

        case 12: // Moth (Aspatha the Broodmother)
            CreatePet(player, m_creature, 25498);
            break;

        case 13: // Nether Ray (Count Ungula)
            CreatePet(player, m_creature, 18285);
            break;

        case 140:  // Owl (Olm the Wise)
            CreatePet(player, m_creature, 14343);
            break;

        case 15: // Raptor (Lar'korwi)
            CreatePet(player, m_creature, 9684);
            break;

        case 16: // Ravager (Rip-blade Ravager)
            CreatePet(player, m_creature, 22123);
            break;

        case 17: // Scorpid (Krellak)
            CreatePet(player, m_creature, 14476);
            break;

        case 18: // Serpent (Emperor Cobra)
            CreatePet(player, m_creature, 28011);
            break;

        case 19: // Spider (Krethis the Shadowspinner)
            CreatePet(player, m_creature, 12433);
            break;

        case 20: // Spore Bat (Sporewing)
            CreatePet(player, m_creature, 18280);
            break;

        case 21: // TallStrider (Green/Purple)
            CreatePet(player, m_creature, 22807);
            break;

        case 22: // Turtle (Cranky Benj)
            CreatePet(player, m_creature, 14223);
            break;

        case 23: // WarpStalker (Gezzarak the Huntress)
            CreatePet(player, m_creature, 23163);
            break;

        case 24: // Wasp (Blacksting)
            CreatePet(player, m_creature, 18283);
            break;

        case 25: // Wind Serpent (Azzere the Skyblade)
            CreatePet(player, m_creature, 5834);
            break;

        case 26: // Wolf (Ghostpaw Alpha)
            CreatePet(player, m_creature, 3825);
            break;

        case 27: // Exotic: Chimaera (Nuramoc)
            CreatePet(player, m_creature, 20932);
            break;

        case 28: // Exotic: Core Hound (Lava/Fire) (21108 - Fel/Fire)
            CreatePet(player, m_creature, 11671);
            break;

        case 29: // Exotic: Devilsaur (King Krush)
            CreatePet(player, m_creature, 32485);
            break;

        case 30: // Rhino (Wooly Rhino Matriarch Brown)
            CreatePet(player, m_creature, 25487);
            break;

        case 31: // Exotic: Silithid (Clutchmother Zavas)
            CreatePet(player, m_creature, 6582);
            break;

        case 32: // Exotic: Worm (Rattlebore)
            CreatePet(player, m_creature, 26360);
            break;

        case 33: // Exotic Spirit: Bear (Arcturis)
            CreatePet(player, m_creature, 38453);
            break;

        case 34: // Exotic Spirit: Night Saber (Gondria)
            CreatePet(player, m_creature, 33776);
            break;

        case 35: // Exotic Spirit: Leopard (Loque'nahak)
            CreatePet(player, m_creature, 32517);
            break;

        case 36: // Exotic Sprit: Worg (Skoll)
            CreatePet(player, m_creature, 35189);
            break;

        case 37: // Rare: Tallstrider (Mazzranache)
            CreatePet(player, m_creature, 3068);
            break;

        case 38: // Rare: Bird of Prey (Aotona)
            CreatePet(player, m_creature, 32481);
            break;
        }

        return true;
    }
};

class BeastMasterWorld : public WorldScript
{
public:
	BeastMasterWorld() : WorldScript("BeastMasterWorld") { }

	void OnBeforeConfigLoad(bool reload) override
	{
		if (!reload) {
			std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/npc_beastmaster.conf";
#ifdef WIN32
			cfg_file = "Settings/modules/npc_beastmaster.conf";
#endif
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());
		}
	}
};

void AddBeastMasterScripts()
{
	new BeastMasterWorld();
    new BeastMasterAnnounce();
    new BeastMaster();
}