/*

# Custom Login Modifications #

### Description ###
------------------------------------------------------------------------------------------------------------------
- All options can be enabled or disabled in config
- Player ([ Faction ] - Name - Logon/Logoff message) notification can be announced to the world
- New characters can receive items, bags, and class-specific heirlooms on first login
- New characters can receive class-specific skills on first login
- New characters can receive specialized skills on first login
- New characters can receive exalted rep with capital cities (Ambassador) on first login


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Player/Server
- Script: CustomLogin
- Config: Yes
- SQL: No


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2018.12.19 - Add BOA specific config options
- v2018.12.01 - Fix PlayerAnnounce when exiting game
- v2017.08.25 - Clean up code, add rep gain, add config options
- v2017.08.01 - Release


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


#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "ScriptMgr.h"
#include "GuildMgr.h"

bool LoginEnable = 1;
bool LoginAnnounceModule = 1;
bool LoginPlayerAnnounce = 1;
bool LoginBOA = 1;
bool LoginBOARing = 1;
bool LoginBOABags = 1;
bool LoginBOAShoulders = 1;
bool LoginBOAShoulders2 = 1;
bool LoginBOAChest = 1;
bool LoginBOAChest2 = 1;
bool LoginBOATrinket = 1;
bool LoginBOATrinket2 = 1;
bool LoginBOAWeapon = 1;
bool LoginBOAWeapon2 = 1;
bool LoginBOAWeapon3 = 1;
bool LoginSkills = 1;
bool LoginSpecialAbility = 0;
bool LoginReputation = 1;

class LoginConfig : public WorldScript
{
public:
    LoginConfig() : WorldScript("LoginConfig") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/mod_customlogin.conf";

#ifdef WIN32
            cfg_file = "mod_customlogin.conf";
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
        LoginEnable = sConfigMgr->GetBoolDefault("Login.Enable", 1);
        LoginAnnounceModule = sConfigMgr->GetBoolDefault("Login.Announce", 1);
        LoginPlayerAnnounce = sConfigMgr->GetBoolDefault("Login.PlayerAnnounce", 1);
        LoginBOA = sConfigMgr->GetBoolDefault("Login.BoA", 1);
        LoginBOARing = sConfigMgr->GetBoolDefault("Login.BoA.Ring", 1);
        LoginBOABags = sConfigMgr->GetBoolDefault("Login.BoA.Bags",1);
        LoginBOAShoulders = sConfigMgr->GetBoolDefault("Login.BoA.Shoulders", 1);
        LoginBOAShoulders2 = sConfigMgr->GetBoolDefault("Login.BoA.Shoulders2",1);
        LoginBOAChest = sConfigMgr->GetBoolDefault("Login.BoA.Chest",1);
        LoginBOAChest2 = sConfigMgr->GetBoolDefault("Login.BoA.Chest2",1);
        LoginBOATrinket = sConfigMgr->GetBoolDefault("Login.BoA.Trinket",1);
        LoginBOATrinket2 = sConfigMgr->GetBoolDefault("Login.BoA.Trinket2",1);
        LoginBOAWeapon = sConfigMgr->GetBoolDefault("Login.BoA.Weapon",1);
        LoginBOAWeapon2 = sConfigMgr->GetBoolDefault("Login.BoA.Weapon2",1);
        LoginBOAWeapon3 = sConfigMgr->GetBoolDefault("Login.BoA.Weapon3",1);
        LoginSkills = sConfigMgr->GetBoolDefault("Login.Skills", 1);
        LoginSpecialAbility = sConfigMgr->GetBoolDefault("Login.SpecialAbility", 1);
        LoginReputation = sConfigMgr->GetBoolDefault("Login.Reputation", 1);
    }
};

class LoginAnnounce : public PlayerScript
{

public:

    LoginAnnounce() : PlayerScript("LoginAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (LoginEnable)
        {
            if (LoginAnnounceModule)
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00CustomLogin |rmodule.");
            }
        }
    }
};

class CustomLogin : public PlayerScript
{

public:
    CustomLogin() : PlayerScript("CustomLogin") { }

    void OnFirstLogin(Player* player)
    {
        // If enabled..
        if (LoginEnable)
        {
            // If enabled, give heirloom and other items
            if (LoginBOA)
            {
                // Define Equipment
                uint32 shoulders = 0, chest = 0, trinket = 0, weapon = 0, weapon2 = 0, weapon3 = 0, shoulders2 = 0, chest2 = 0, trinket2 = 0;
                const uint32 bag = 23162;		// Foror's Crate of Endless Resist Gear Storage (36 Slot)
                const uint32 ring = 50255;		// Dread Pirate Ring (5% XP Boost)

                // Outfit the character with bags and heirlooms that match their class
                // NOTE: Some classes have more than one heirloom option per slot
                switch (player->getClass())
                {

                case CLASS_WARRIOR:
                    shoulders = 42949;
                    chest = 48685;
                    trinket = 42991;
                    weapon = 42943;
                    weapon2 = 44092;
                    weapon3 = 44093;
                    break;

                case CLASS_PALADIN:
                    shoulders = 42949;
                    chest = 48685;
                    trinket = 42991;
                    weapon = 42945;
                    weapon2 = 44092;
                    break;

                case CLASS_HUNTER:
                    shoulders = 42950;
                    chest = 48677;
                    trinket = 42991;
                    weapon = 42943;
                    weapon2 = 42946;
                    weapon3 = 44093;
                    break;

                case CLASS_ROGUE:
                    shoulders = 42952;
                    chest = 48689;
                    trinket = 42991;
                    weapon = 42944;
                    weapon2 = 42944;
                    break;

                case CLASS_PRIEST:
                    shoulders = 42985;
                    chest = 48691;
                    trinket = 42992;
                    weapon = 42947;
                    break;

                case CLASS_DEATH_KNIGHT:
                    shoulders = 42949;
                    chest = 48685;
                    trinket = 42991;
                    weapon = 42945;
                    weapon2 = 44092;
                    weapon3 = 42943;
                    break;

                case CLASS_SHAMAN:
                    shoulders = 42951;
                    chest = 48683;
                    trinket = 42992;
                    weapon = 42948;
                    shoulders2 = 42951;
                    chest2 = 48683;
                    weapon2 = 42947;
                    break;

                case CLASS_MAGE:
                    shoulders = 42985;
                    chest = 48691;
                    trinket = 42992;
                    weapon = 42947;
                    break;

                case CLASS_WARLOCK:
                    shoulders = 42985;
                    chest = 48691;
                    trinket = 42992;
                    weapon = 42947;
                    break;

                case CLASS_DRUID:
                    shoulders = 42984;
                    shoulders2 = 42952;
                    chest = 48687;
                    chest2 = 48689;
                    trinket = 42992;
                    trinket2 = 42991;
                    weapon = 42948;
                    weapon2 = 48718;
                    break;

                default:
                    break;
                }

                // Hand out the heirlooms. I prefer only the ring and trinkets for new characters.
                // TODO: Improve the code. No time, no care, no worries!
                switch (player->getClass())
                {

                case CLASS_PRIEST:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;

                case CLASS_DEATH_KNIGHT:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOAWeapon2) { player->AddItem(weapon2, 1); }
                    if (LoginBOAWeapon3) { player->AddItem(weapon3, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;

                case CLASS_PALADIN:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOAWeapon2) { player->AddItem(weapon2, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;

                case CLASS_WARRIOR:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOAWeapon2) { player->AddItem(weapon2, 1); }
                    if (LoginBOAWeapon3) { player->AddItem(weapon3, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;

                case CLASS_HUNTER:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOAWeapon2) { player->AddItem(weapon2, 1); }
                    if (LoginBOAWeapon3) { player->AddItem(weapon3, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;

                case CLASS_ROGUE:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOAWeapon2) { player->AddItem(weapon2, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;

                case CLASS_DRUID:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOATrinket) { player->AddItem(trinket2, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAShoulders2) { player->AddItem(shoulders2, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOAWeapon2) { player->AddItem(weapon2, 1); }
                    if (LoginBOAWeapon3) { player->AddItem(weapon3, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;

                case CLASS_SHAMAN:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAShoulders2) { player->AddItem(shoulders2, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAChest2) { player->AddItem(chest2, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOAWeapon2) { player->AddItem(weapon2, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;

                default:
                    if (LoginBOATrinket) { player->AddItem(trinket, 2); };
                    if (LoginBOARing) { player->AddItem(ring, 1); }
                    if (LoginBOAShoulders) { player->AddItem(shoulders, 1); }
                    if (LoginBOAChest) { player->AddItem(chest, 1); }
                    if (LoginBOAWeapon) { player->AddItem(weapon, 1); }
                    if (LoginBOABags) { player->AddItem(bag, 1); }
                    break;
                }

                // Inform the player they have new items
                std::ostringstream ss;
                ss << "|cffFF8000[|cFFBDB76BCL|cffFF8000] The outfitter has placed |cFFBDB76BHeirloom Gear|cffFF8000 in your backpack!";
                ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
            }

            // If enabled, learn additional skills
            if (LoginSkills)
            {
                switch (player->getClass())
                {

                    /*
                        // Skill Reference

                        player->learnSpell(204);	// Defense
                        player->learnSpell(264);	// Bows
                        player->learnSpell(5011);	// Crossbow
                        player->learnSpell(674);	// Dual Wield
                        player->learnSpell(15590);	// Fists
                        player->learnSpell(266);	// Guns
                        player->learnSpell(196);	// Axes
                        player->learnSpell(198);	// Maces
                        player->learnSpell(201);	// Swords
                        player->learnSpell(750);	// Plate Mail
                        player->learnSpell(200);	// PoleArms
                        player->learnSpell(9116);	// Shields
                        player->learnSpell(197);	// 2H Axe
                        player->learnSpell(199);	// 2H Mace
                        player->learnSpell(202);	// 2H Sword
                        player->learnSpell(227);	// Staves
                        player->learnSpell(2567);	// Thrown
                    */

                case CLASS_PALADIN:
                    player->learnSpell(196);	// Axes
                    player->learnSpell(750);	// Plate Mail
                    player->learnSpell(200);	// PoleArms
                    player->learnSpell(197);	// 2H Axe
                    player->learnSpell(199);	// 2H Mace
                    break;

                case CLASS_SHAMAN:
                    player->learnSpell(15590);	// Fists
                    player->learnSpell(8737);	// Mail
                    player->learnSpell(196);	// Axes
                    player->learnSpell(197);	// 2H Axe
                    player->learnSpell(199);	// 2H Mace
                    break;

                case CLASS_WARRIOR:
                    player->learnSpell(264);	// Bows
                    player->learnSpell(5011);	// Crossbow
                    player->learnSpell(674);	// Dual Wield
                    player->learnSpell(15590);	// Fists
                    player->learnSpell(266);	// Guns
                    player->learnSpell(750);	// Plate Mail
                    player->learnSpell(200);	// PoleArms
                    player->learnSpell(199);	// 2H Mace
                    player->learnSpell(227);	// Staves
                    break;

                case CLASS_HUNTER:
                    player->learnSpell(674);	// Dual Wield
                    player->learnSpell(15590);	// Fists
                    player->learnSpell(264);	// Bows
                    player->learnSpell(266);	// Guns
                    player->learnSpell(8737);	// Mail
                    player->learnSpell(200);	// PoleArms
                    player->learnSpell(227);	// Staves
                    player->learnSpell(202);	// 2H Sword
                    break;

                case CLASS_ROGUE:
                    player->learnSpell(264);	// Bows
                    player->learnSpell(5011);	// Crossbow
                    player->learnSpell(15590);	// Fists
                    player->learnSpell(266);	// Guns
                    player->learnSpell(196);	// Axes
                    player->learnSpell(198);	// Maces
                    player->learnSpell(201);	// Swords
                    break;

                case CLASS_DRUID:
                    player->learnSpell(1180);	// Daggers
                    player->learnSpell(15590);	// Fists
                    player->learnSpell(198);	// Maces
                    player->learnSpell(200);	// PoleArms
                    player->learnSpell(227);	// Staves
                    player->learnSpell(199);	// 2H Mace
                    break;

                case CLASS_MAGE:
                    player->learnSpell(201);	// Swords
                    break;

                case CLASS_WARLOCK:
                    player->learnSpell(201);	// Swords
                    break;

                case CLASS_PRIEST:
                    player->learnSpell(1180);	// Daggers
                    break;

                case CLASS_DEATH_KNIGHT:
                    player->learnSpell(198);	// Maces
                    player->learnSpell(199);	// 2H Mace
                    break;

                default:
                    break;
                }

                // Inform the player they have new skills
                std::ostringstream ss;
                ss << "|cffFF8000[|cFFBDB76BCL|cffFF8000] You have been granted |cFFBDB76Badditional weapon skills|cffFF8000.";
                ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
            }

            // If enabled.. learn special skills abilities
            if (LoginSpecialAbility)
            {
                // Learn Specialized Skills
                player->learnSpell(1784);	// Stealth
                player->learnSpell(921);	// Pick Pocket
                player->learnSpell(1804);	// Lockpicking
                player->learnSpell(11305);	// Sprint (3)
                player->learnSpell(5384);	// Feign Death
                player->learnSpell(475);	// Remove Curse

                // Add a few teleportation runes
                player->AddItem(17031, 5);	// Rune of Teleportation

                // Learn Teleports
                switch (player->GetTeamId())
                {

                case TEAM_ALLIANCE:

                    // Alliance Teleports
                    player->learnSpell(3565);	// Darnassus
                    player->learnSpell(32271);	// Exodar
                    player->learnSpell(3562);	// Ironforge
                    player->learnSpell(33690);	// Shattrath
                    player->learnSpell(3561);	// Stormwind
                    break;

                case TEAM_HORDE:

                    // Horde Teleports
                    player->learnSpell(3567);	// Orgrimmar
                    player->learnSpell(35715);	// Shattrath
                    player->learnSpell(32272);	// Silvermoon
                    player->learnSpell(3566);	// Thunder Bluff
                    player->learnSpell(3563);	// Undercity
                    break;

                default:
                    break;
                }

                // Inform the player they have new skills
                std::ostringstream ss;
                ss << "|cffFF8000[|cFFBDB76BCL|cffFF8000] Your spellbook has been scribed with |cFFBDB76Bspecial abilities|cffFF8000.";
                ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
            }

            // If enabled.. set exalted factions (AzerothCore config for rep not working as of 2017-08-25)
            if (LoginReputation)
            {
                switch (player->GetTeamId())
                {

                    // Alliance Capital Cities
                case TEAM_ALLIANCE:
                    player->SetReputation(47, 999999);	// IronForge
                    player->SetReputation(72, 999999);	// Stormwind 
                    player->SetReputation(69, 999999);	// Darnassus
                    player->SetReputation(389, 999999);	// Gnomeregan
                    player->SetReputation(930, 999999);	// Exodar
                    break;

                    // Horde Capital Cities
                case TEAM_HORDE:
                    player->SetReputation(68, 999999);	// Undercity
                    player->SetReputation(76, 999999);	// Orgrimmar
                    player->SetReputation(81, 999999);	// Thunder Bluff
                    player->SetReputation(530, 999999);	// DarkSpear
                    player->SetReputation(911, 999999);	// Silvermoon
                    break;

                default:
                    break;
                }

                // Inform the player they have exalted reputations
                std::ostringstream ss;
                ss << "|cffFF8000[|cFFBDB76BCL|cffFF8000] Your are now |cFFBDB76BExalted|cffFF8000 with your faction's capital cities.";
                ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
            }
        }
    }

    void OnLogin(Player* player)
    {
        // If enabled..
        if (LoginEnable)
        {
            // If enabled..
            if (LoginPlayerAnnounce)
            {
                // Announce Player Login
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    std::ostringstream ss;
                    ss << "|cffFFFFFF[|cff2897FF Alliance |cffFFFFFF]:|cff4CFF00 " << player->GetName() << "|cffFFFFFF has come online.";
                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                }
                else
                {
                    std::ostringstream ss;
                    ss << "|cffFFFFFF[|cffFF0000 Horde |cffFFFFFF]:|cff4CFF00 " << player->GetName() << "|cffFFFFFF has come online.";
                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                }
            }
        }
    }

    void OnLogout(Player *player)
    {
        if (LoginEnable)
        {
            // If enabled..
            if (LoginPlayerAnnounce)
            {
                // Announce Player Login
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    std::ostringstream ss;
                    ss << "|cffFFFFFF[|cff2897FF Alliance |cffFFFFFF]|cff4CFF00 " << player->GetName() << "|cffFFFFFF has left the game.";
                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                }
                else
                {
                    std::ostringstream ss;
                    ss << "|cffFFFFFF[|cffFF0000 Horde |cffFFFFFF]|cff4CFF00 " << player->GetName() << "|cffFFFFFF has left the game.";
                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                }
            }
        }
    }
};

void AddCustomLoginScripts()
{
    new LoginConfig();
    new LoginAnnounce();
    new CustomLogin();
}
