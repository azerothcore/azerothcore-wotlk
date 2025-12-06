#include "utils/Utils.h"
#include "Chat.h"
#include "Config.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Log.h"
#include "Map.h"
#include "ObjectGuid.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Unit.h"
#include <cstdint>
#include <iostream>
#include <map>
#include <math.h>
#include <string>
#include <unordered_map>
#include <vector>

bool SoloCraftEnable = 1;
bool SoloCraftAnnounceModule = 1;
bool SoloCraftDebuffEnable = 1;
bool SolocraftXPBalEnabled = 1;
bool SolocraftXPEnabled = 1;
bool SolocraftNoXPFlag = 0;
float SoloCraftSpellMult = 1.0;
float SoloCraftStatsMult = 100.0;
float SoloCraftXPMod = 1.0;
uint32 SolocraftLevelDiff = 1;
uint32 SolocraftDungeonLevel = 1;
std::unordered_map<uint8, uint32> classes;
std::unordered_map<uint32, uint32> dungeons;
std::unordered_map<uint32, float> diff_Multiplier;
std::unordered_map<uint32, float> diff_Multiplier_Heroics;
std::vector<uint32_t> SolocraftInstanceExcluded;

float D5 = 1.0;
float D10 = 1.0;
float D25 = 1.0;
float D40 = 1.0;
float D649H10 = 1.0;
float D649H25 = 1.0;

class SolocraftConfig : public WorldScript
{
public:
    SolocraftConfig() : WorldScript("SolocraftConfig", {
        WORLDHOOK_ON_BEFORE_CONFIG_LOAD
    }) {}

    void OnBeforeConfigLoad(bool /*reload*/) override
    {
        // Load Configuration Settings
        SetInitialWorldSettings();
    }

    // Load Configuration Settings
    void SetInitialWorldSettings()
    {
        SoloCraftEnable = sConfigMgr->GetOption<bool>("Solocraft.Enable", 1);
        SoloCraftAnnounceModule = sConfigMgr->GetOption<bool>("Solocraft.Announce", 1);

        //Balancing
        SoloCraftDebuffEnable = sConfigMgr->GetOption<bool>("SoloCraft.Debuff.Enable", 1);
        SoloCraftSpellMult = sConfigMgr->GetOption<float>("SoloCraft.Spellpower.Mult", 2.5);
        SoloCraftStatsMult = sConfigMgr->GetOption<float>("SoloCraft.Stats.Mult", 100.0);
        classes =
        {
            {1, sConfigMgr->GetOption<uint8>("SoloCraft.WARRIOR", 100) },
            {2, sConfigMgr->GetOption<uint8>("SoloCraft.PALADIN", 100) },
            {3, sConfigMgr->GetOption<uint8>("SoloCraft.HUNTER", 100) },
            {4, sConfigMgr->GetOption<uint8>("SoloCraft.ROGUE", 100) },
            {5, sConfigMgr->GetOption<uint8>("SoloCraft.PRIEST", 100) },
            {6, sConfigMgr->GetOption<uint8>("SoloCraft.DEATH_KNIGHT", 100) },
            {7, sConfigMgr->GetOption<uint8>("SoloCraft.SHAMAN", 100) },
            {8, sConfigMgr->GetOption<uint8>("SoloCraft.MAGE", 100) },
            {9, sConfigMgr->GetOption<uint8>("SoloCraft.WARLOCK", 100) },
            {11, sConfigMgr->GetOption<uint8>("SoloCraft.DRUID", 100) },
        };

        //XP Enabled
        SolocraftXPEnabled = sConfigMgr->GetOption<bool>("Solocraft.XP.Enabled", 1);

        //XP Balancing
        SolocraftXPBalEnabled = sConfigMgr->GetOption<bool>("Solocraft.XPBal.Enabled", 1);

        //Level Thresholds
        SolocraftLevelDiff = sConfigMgr->GetOption<uint32>("Solocraft.Max.Level.Diff", 10);

        //Catch All Dungeon Level Threshold
        SolocraftDungeonLevel = sConfigMgr->GetOption<uint32>("Solocraft.Dungeon.Level", 80);

        // Dungeon Base Level
        dungeons =
        {
            // Wow Classic
            {33, sConfigMgr->GetOption<uint32>("Solocraft.ShadowfangKeep.Level", 15) },
            {34, sConfigMgr->GetOption<uint32>("Solocraft.Stockades.Level", 22) },
            {36, sConfigMgr->GetOption<uint32>("Solocraft.Deadmines.Level", 18) },
            {43, sConfigMgr->GetOption<uint32>("Solocraft.WailingCaverns.Level", 17) },
            {47, sConfigMgr->GetOption<uint32>("Solocraft.RazorfenKraulInstance.Level", 30) },
            {48, sConfigMgr->GetOption<uint32>("Solocraft.Blackfathom.Level", 20) },
            {70, sConfigMgr->GetOption<uint32>("Solocraft.Uldaman.Level", 40) },
            {90, sConfigMgr->GetOption<uint32>("Solocraft.GnomeragonInstance.Level", 24) },
            {109, sConfigMgr->GetOption<uint32>("Solocraft.SunkenTemple.Level", 50) },
            {129, sConfigMgr->GetOption<uint32>("Solocraft.RazorfenDowns.Level", 40) },
            {189, sConfigMgr->GetOption<uint32>("Solocraft.MonasteryInstances.Level", 35) },                  // Scarlet Monastery
            {209, sConfigMgr->GetOption<uint32>("Solocraft.TanarisInstance.Level", 44) },                     // Zul'Farrak
            {229, sConfigMgr->GetOption<uint32>("Solocraft.BlackRockSpire.Level", 55) },
            {230, sConfigMgr->GetOption<uint32>("Solocraft.BlackrockDepths.Level", 50) },
            {249, sConfigMgr->GetOption<uint32>("Solocraft.OnyxiaLairInstance.Level", 60) },
            {289, sConfigMgr->GetOption<uint32>("Solocraft.SchoolofNecromancy.Level", 55) },                  // Scholomance
            {309, sConfigMgr->GetOption<uint32>("Solocraft.Zul'gurub.Level", 60) },
            {329, sConfigMgr->GetOption<uint32>("Solocraft.Stratholme.Level", 55) },
            {349, sConfigMgr->GetOption<uint32>("Solocraft.Mauradon.Level", 48) },
            {389, sConfigMgr->GetOption<uint32>("Solocraft.OrgrimmarInstance.Level", 15) },                   // Ragefire Chasm
            {409, sConfigMgr->GetOption<uint32>("Solocraft.MoltenCore.Level", 60) },
            {429, sConfigMgr->GetOption<uint32>("Solocraft.DireMaul.Level", 48) },
            {469, sConfigMgr->GetOption<uint32>("Solocraft.BlackwingLair.Level", 40) },
            {509, sConfigMgr->GetOption<uint32>("Solocraft.AhnQiraj.Level", 60) },                            // Ruins of Ahn'Qiraj
            {531, sConfigMgr->GetOption<uint32>("Solocraft.AhnQirajTemple.Level", 60) },

            // BC Instances
            {269, sConfigMgr->GetOption<uint32>("Solocraft.CavernsOfTime.Level", 68) },                       // The Black Morass
            {532, sConfigMgr->GetOption<uint32>("Solocraft.Karazahn.Level", 68) },
            {534, sConfigMgr->GetOption<uint32>("Solocraft.HyjalPast.Level", 70) },                           // The Battle for Mount Hyjal - Hyjal Summit
            {540, sConfigMgr->GetOption<uint32>("Solocraft.HellfireMilitary.Level", 68) },                    // The Shattered Halls
            {542, sConfigMgr->GetOption<uint32>("Solocraft.HellfireDemon.Level", 68) },                       // The Blood Furnace
            {543, sConfigMgr->GetOption<uint32>("Solocraft.HellfireRampart.Level", 68) },
            {544, sConfigMgr->GetOption<uint32>("Solocraft.HellfireRaid.Level", 68) },                        // Magtheridon's Lair
            {545, sConfigMgr->GetOption<uint32>("Solocraft.CoilfangPumping.Level", 68) },                     // The Steamvault
            {546, sConfigMgr->GetOption<uint32>("Solocraft.CoilfangMarsh.Level", 68) },                       // The Underbog
            {547, sConfigMgr->GetOption<uint32>("Solocraft.CoilfangDraenei.Level", 68) },                     // The Slavepens
            {548, sConfigMgr->GetOption<uint32>("Solocraft.CoilfangRaid.Level", 70) },                        // Serpentshrine Cavern
            {550, sConfigMgr->GetOption<uint32>("Solocraft.TempestKeepRaid.Level", 70) },                     // The Eye
            {552, sConfigMgr->GetOption<uint32>("Solocraft.TempestKeepArcane.Level", 68) },                   // The Arcatraz
            {553, sConfigMgr->GetOption<uint32>("Solocraft.TempestKeepAtrium.Level", 68) },                   // The Botanica
            {554, sConfigMgr->GetOption<uint32>("Solocraft.TempestKeepFactory.Level", 68) },                  // The Mechanar
            {555, sConfigMgr->GetOption<uint32>("Solocraft.AuchindounShadow.Level", 68) },                    // Shadow Labyrinth
            {556, sConfigMgr->GetOption<uint32>("Solocraft.AuchindounDemon.Level", 68) },                     // Sethekk Halls
            {557, sConfigMgr->GetOption<uint32>("Solocraft.AuchindounEthereal.Level", 68) },                  // Mana-Tombs
            {558, sConfigMgr->GetOption<uint32>("Solocraft.AuchindounDraenei.Level", 68) },                   // Auchenai Crypts
            {560, sConfigMgr->GetOption<uint32>("Solocraft.HillsbradPast.Level", 68) },                       // Old Hillsbrad Foothills
            {564, sConfigMgr->GetOption<uint32>("Solocraft.BlackTemple.Level", 70) },
            {565, sConfigMgr->GetOption<uint32>("Solocraft.GruulsLair.Level", 70) },
            {568, sConfigMgr->GetOption<uint32>("Solocraft.ZulAman.Level", 68) },
            {580, sConfigMgr->GetOption<uint32>("Solocraft.SunwellPlateau.Level", 70) },
            {585, sConfigMgr->GetOption<uint32>("Solocraft.Sunwell5ManFix.Level", 68) },                      // Magister's Terrace

            // WOTLK Instances
            {533, sConfigMgr->GetOption<uint32>("Solocraft.StratholmeRaid.Level", 78) },                      // Naxxramas
            {574, sConfigMgr->GetOption<uint32>("Solocraft.Valgarde70.Level", 78) },                          // Utgarde Keep
            {575, sConfigMgr->GetOption<uint32>("Solocraft.UtgardePinnacle.Level", 78) },
            {576, sConfigMgr->GetOption<uint32>("Solocraft.Nexus70.Level", 78) },                             // The Nexus
            {578, sConfigMgr->GetOption<uint32>("Solocraft.Nexus80.Level", 78) },                             // The Occulus
            {595, sConfigMgr->GetOption<uint32>("Solocraft.StratholmeCOT.Level", 78) },                       // The Culling of Stratholme
            {599, sConfigMgr->GetOption<uint32>("Solocraft.Ulduar70.Level", 78) },                            // Halls of Stone
            {600, sConfigMgr->GetOption<uint32>("Solocraft.DrakTheronKeep.Level", 78) },                      // Drak'Tharon Keep
            {601, sConfigMgr->GetOption<uint32>("Solocraft.Azjol_Uppercity.Level", 78) },                     // Azjol-Nerub
            {602, sConfigMgr->GetOption<uint32>("Solocraft.Ulduar80.Level", 78) },                            // Halls of Lighting
            {603, sConfigMgr->GetOption<uint32>("Solocraft.UlduarRaid.Level", 80) },                          // Ulduar
            {604, sConfigMgr->GetOption<uint32>("Solocraft.GunDrak.Level", 78) },
            {608, sConfigMgr->GetOption<uint32>("Solocraft.DalaranPrison.Level", 78) },                       // Violet Hold
            {615, sConfigMgr->GetOption<uint32>("Solocraft.ChamberOfAspectsBlack.Level", 80) },               // The Obsidian Sanctum
            {616, sConfigMgr->GetOption<uint32>("Solocraft.NexusRaid.Level", 80) },                           // The Eye of Eternity
            {619, sConfigMgr->GetOption<uint32>("Solocraft.Azjol_LowerCity.Level", 78) },                     // Ahn'kahet: The Old Kingdom
            {631, sConfigMgr->GetOption<uint32>("Solocraft.IcecrownCitadel.Level", 80) },                     // Icecrown Citadel
            {632, sConfigMgr->GetOption<uint32>("Solocraft.IcecrownCitadel5Man.Level", 78) },                 // The Forge of Souls
            {649, sConfigMgr->GetOption<uint32>("Solocraft.ArgentTournamentRaid.Level", 80) },                // Trial of the Crusader
            {650, sConfigMgr->GetOption<uint32>("Solocraft.ArgentTournamentDungeon.Level", 80) },             // Trial of the Champion
            {658, sConfigMgr->GetOption<uint32>("Solocraft.QuarryOfTears.Level", 78) },                       // Pit of Saron
            {668, sConfigMgr->GetOption<uint32>("Solocraft.HallsOfReflection.Level", 78) },                   // Halls of Reflection
            {724, sConfigMgr->GetOption<uint32>("Solocraft.ChamberOfAspectsRed.Level", 80) },                 // The Ruby Sanctum
        };

        // Dungeon Difficulty | Catch alls
        D5 = sConfigMgr->GetOption<float>("Solocraft.Dungeon", 5.0);
        D10 = sConfigMgr->GetOption<float>("Solocraft.Heroic", 10.0);
        D25 = sConfigMgr->GetOption<float>("Solocraft.Raid25", 25.0);
        D40 = sConfigMgr->GetOption<float>("Solocraft.Raid40", 40.0);

        diff_Multiplier =
        {
            // WOW Classic Instances
            {33, sConfigMgr->GetOption<float>("Solocraft.ShadowfangKeep", 5.0) },
            {34, sConfigMgr->GetOption<float>("Solocraft.Stockades", 5.0) },
            {36, sConfigMgr->GetOption<float>("Solocraft.Deadmines", 5.0) },
            {43, sConfigMgr->GetOption<float>("Solocraft.WailingCaverns", 5.0) },
            {47, sConfigMgr->GetOption<float>("Solocraft.RazorfenKraulInstance", 5.0) },
            {48, sConfigMgr->GetOption<float>("Solocraft.Blackfathom", 5.0) },
            {70, sConfigMgr->GetOption<float>("Solocraft.Uldaman", 5.0) },
            {90, sConfigMgr->GetOption<float>("Solocraft.GnomeragonInstance", 5.0) },
            {109, sConfigMgr->GetOption<float>("Solocraft.SunkenTemple", 5.0) },
            {129, sConfigMgr->GetOption<float>("Solocraft.RazorfenDowns", 5.0) },
            {189, sConfigMgr->GetOption<float>("Solocraft.MonasteryInstances", 5.0) },                     // Scarlet
            {209, sConfigMgr->GetOption<float>("Solocraft.TanarisInstance", 5.0) },                        // Zul'Farrak
            {229, sConfigMgr->GetOption<float>("Solocraft.BlackRockSpire", 10.0) },
            {230, sConfigMgr->GetOption<float>("Solocraft.BlackrockDepths", 5.0) },
            {249, sConfigMgr->GetOption<float>("Solocraft.OnyxiaLairInstance", 40.0) },
            {289, sConfigMgr->GetOption<float>("Solocraft.SchoolofNecromancy", 5.0) },                     // Scholo
            {309, sConfigMgr->GetOption<float>("Solocraft.Zul'gurub", 20.0) },
            {329, sConfigMgr->GetOption<float>("Solocraft.Stratholme", 5.0) },
            {349, sConfigMgr->GetOption<float>("Solocraft.Mauradon", 5.0) },
            {389, sConfigMgr->GetOption<float>("Solocraft.OrgrimmarInstance", 5.0) },                      // Ragefire
            {409, sConfigMgr->GetOption<float>("Solocraft.MoltenCore", 40.0) },
            {429, sConfigMgr->GetOption<float>("Solocraft.DireMaul", 5.0) },
            {469, sConfigMgr->GetOption<float>("Solocraft.BlackwingLair", 40.0) },
            {509, sConfigMgr->GetOption<float>("Solocraft.AhnQiraj", 20.0) },
            {531, sConfigMgr->GetOption<float>("Solocraft.AhnQirajTemple", 40.0) },

            // BC Instances
            {269, sConfigMgr->GetOption<float>("Solocraft.CavernsOfTime", 5.0) },                          // Black Morass
            {532, sConfigMgr->GetOption<float>("Solocraft.Karazahn", 10.0) },
            {534, sConfigMgr->GetOption<float>("Solocraft.HyjalPast", 25.0) },                             // Mount Hyjal
            {540, sConfigMgr->GetOption<float>("Solocraft.HellfireMilitary", 5.0) },                       // The Shattered Halls
            {542, sConfigMgr->GetOption<float>("Solocraft.HellfireDemon", 5.0) },                          // The Blood Furnace
            {543, sConfigMgr->GetOption<float>("Solocraft.HellfireRampart", 5.0) },
            {544, sConfigMgr->GetOption<float>("Solocraft.HellfireRaid", 25.0) },                          // Magtheridon's Lair
            {545, sConfigMgr->GetOption<float>("Solocraft.CoilfangPumping", 5.0) },                        // The Steamvault
            {546, sConfigMgr->GetOption<float>("Solocraft.CoilfangMarsh", 5.0) },                          // The Underbog
            {547, sConfigMgr->GetOption<float>("Solocraft.CoilfangDraenei", 5.0) },                        // The Slavepens
            {548, sConfigMgr->GetOption<float>("Solocraft.CoilfangRaid", 25.0) },                          // Serpentshrine Cavern
            {550, sConfigMgr->GetOption<float>("Solocraft.TempestKeepRaid", 25.0) },                       // The Eye
            {552, sConfigMgr->GetOption<float>("Solocraft.TempestKeepArcane", 5.0) },                      // The Arcatraz
            {553, sConfigMgr->GetOption<float>("Solocraft.TempestKeepAtrium", 5.0) },                      // The Botanica
            {554, sConfigMgr->GetOption<float>("Solocraft.TempestKeepFactory", 5.0) },                     // The Mechanar
            {555, sConfigMgr->GetOption<float>("Solocraft.AuchindounShadow", 5.0) },                       // Shadow Labyrinth
            {556, sConfigMgr->GetOption<float>("Solocraft.AuchindounDemon", 5.0) },                        // Sethekk Halls
            {557, sConfigMgr->GetOption<float>("Solocraft.AuchindounEthereal", 5.0) },                     // Mana-Tombs
            {558, sConfigMgr->GetOption<float>("Solocraft.AuchindounDraenei", 5.0) },                      // Auchenai Crypts
            {560, sConfigMgr->GetOption<float>("Solocraft.HillsbradPast", 5.0) },                          // Old Hillsbrad Foothills
            {564, sConfigMgr->GetOption<float>("Solocraft.BlackTemple", 25.0) },
            {565, sConfigMgr->GetOption<float>("Solocraft.GruulsLair", 25.0) },
            {568, sConfigMgr->GetOption<float>("Solocraft.ZulAman", 5.0) },
            {580, sConfigMgr->GetOption<float>("Solocraft.SunwellPlateau", 25.0) },
            {585, sConfigMgr->GetOption<float>("Solocraft.Sunwell5ManFix", 5.0) },                         // Magister's Terrace

            // WOTLK Instances
            {533, sConfigMgr->GetOption<float>("Solocraft.StratholmeRaid", 10.0) },                        //  Nax 10
            {574, sConfigMgr->GetOption<float>("Solocraft.Valgarde70", 5.0) },                             // Utgarde Keep
            {575, sConfigMgr->GetOption<float>("Solocraft.UtgardePinnacle", 5.0) },
            {576, sConfigMgr->GetOption<float>("Solocraft.Nexus70", 5.0) },                                // The Nexus
            {578, sConfigMgr->GetOption<float>("Solocraft.Nexus80", 5.0) },                                // The Occulus
            {595, sConfigMgr->GetOption<float>("Solocraft.StratholmeCOT", 5.0) },                          // The Culling of Stratholme
            {599, sConfigMgr->GetOption<float>("Solocraft.Ulduar70", 5.0) },                               // Halls of Stone
            {600, sConfigMgr->GetOption<float>("Solocraft.DrakTheronKeep", 5.0) },                         // Drak'Tharon Keep
            {601, sConfigMgr->GetOption<float>("Solocraft.Azjol_Uppercity", 5.0) },                        // Azjol-Nerub
            {602, sConfigMgr->GetOption<float>("Solocraft.Ulduar80", 5.0) },                               // Halls of Lighting
            {603, sConfigMgr->GetOption<float>("Solocraft.UlduarRaid", 10.0) },                            // Ulduar 10
            {604, sConfigMgr->GetOption<float>("Solocraft.GunDrak", 5.0) },
            {608, sConfigMgr->GetOption<float>("Solocraft.DalaranPrison", 5.0) },                          // Violet Hold
            {615, sConfigMgr->GetOption<float>("Solocraft.ChamberOfAspectsBlack", 10.0) },                 // The Obsidian Sanctum 10
            {616, sConfigMgr->GetOption<float>("Solocraft.NexusRaid", 10.0) },                             // The Eye of Eternity 10
            {619, sConfigMgr->GetOption<float>("Solocraft.Azjol_LowerCity", 5.0) },                        // Ahn'kahet: The Old Kingdom
            {631, sConfigMgr->GetOption<float>("Solocraft.IcecrownCitadel", 10.0) },                       // Icecrown Citadel 10
            {632, sConfigMgr->GetOption<float>("Solocraft.IcecrownCitadel5Man", 5.0) },                    // The Forge of Souls
            {649, sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentRaid", 10.0) },                  // Trial of the Crusader 10
            {650, sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentDungeon", 5.0) },                // Trial of the Champion
            {658, sConfigMgr->GetOption<float>("Solocraft.QuarryOfTears", 5.0) },                          // Pit of Saron
            {668, sConfigMgr->GetOption<float>("Solocraft.HallsOfReflection", 5.0) },                      // Halls of Reflection
            {724, sConfigMgr->GetOption<float>("Solocraft.ChamberOfAspectsRed", 10.0) },                   // The Ruby Sanctum 10
        };

        // Heroics
        diff_Multiplier_Heroics =
        {
            // BC Instances Heroics
            {269, sConfigMgr->GetOption<float>("Solocraft.CavernsOfTimeH", 5.0) },                         // Black Morass H
            {540, sConfigMgr->GetOption<float>("Solocraft.HellfireMilitaryH", 5.0) },                      // The Shattered Halls H
            {542, sConfigMgr->GetOption<float>("Solocraft.HellfireDemonH", 5.0) },                         // The Blood Furnace H
            {543, sConfigMgr->GetOption<float>("Solocraft.HellfireRampartH", 5.0) },                       // Heroic
            {545, sConfigMgr->GetOption<float>("Solocraft.CoilfangPumpingH", 5.0) },                       // The Steamvault
            {546, sConfigMgr->GetOption<float>("Solocraft.CoilfangMarshH", 5.0) },                         // The Underbog
            {547, sConfigMgr->GetOption<float>("Solocraft.CoilfangDraeneiH", 5.0) },                       // The Slavepens H
            {552, sConfigMgr->GetOption<float>("Solocraft.TempestKeepArcaneH", 5.0) },                     // The Arcatraz H
            {553, sConfigMgr->GetOption<float>("Solocraft.TempestKeepAtriumH", 5.0) },                     // The Botanica H
            {554, sConfigMgr->GetOption<float>("Solocraft.TempestKeepFactoryH", 5.0) },                    // The Mechanar H
            {555, sConfigMgr->GetOption<float>("Solocraft.AuchindounShadowH", 5.0) },                      // Shadow Labyrinth H
            {556, sConfigMgr->GetOption<float>("Solocraft.AuchindounDemonH", 5.0) },                       // Sethekk Halls H
            {557, sConfigMgr->GetOption<float>("Solocraft.AuchindounEtherealH", 5.0) },                    // Mana-Tombs H
            {558, sConfigMgr->GetOption<float>("Solocraft.AuchindounDraeneiH", 5.0) },                     // Auchenai Crypts H
            {560, sConfigMgr->GetOption<float>("Solocraft.HillsbradPastH", 5.0) },                         // Old Hillsbrad Foothills H
            {568, sConfigMgr->GetOption<float>("Solocraft.ZulAmanH", 5.0) },                               // Zul'Aman H
            {585, sConfigMgr->GetOption<float>("Solocraft.Sunwell5ManFixH", 5.0) },                        // Magister's Terrace H

            // WOTLK Instances Heroics
            {533, sConfigMgr->GetOption<float>("Solocraft.StratholmeRaidH", 25.0) },                       // Naxxramas 25
            {574, sConfigMgr->GetOption<float>("Solocraft.Valgarde70H", 5.0) },                            // Utgarde Keep H
            {575, sConfigMgr->GetOption<float>("Solocraft.UtgardePinnacleH", 5.0) },                       // Utgarde Pinnacle H
            {576, sConfigMgr->GetOption<float>("Solocraft.Nexus70H", 5.0) },                               // The Nexus H
            {578, sConfigMgr->GetOption<float>("Solocraft.Nexus80H", 5.0) },                               // The Occulus H
            {595, sConfigMgr->GetOption<float>("Solocraft.StratholmeCOTH", 5.0) },                         // The Culling of Stratholme H
            {599, sConfigMgr->GetOption<float>("Solocraft.Ulduar70H", 5.0) },                              // Halls of Stone H
            {600, sConfigMgr->GetOption<float>("Solocraft.DrakTheronKeepH", 5.0) },                        // Drak'Tharon Keep H
            {601, sConfigMgr->GetOption<float>("Solocraft.Azjol_UppercityH", 5.0) },                       // Azjol-Nerub H
            {602, sConfigMgr->GetOption<float>("Solocraft.Ulduar80H", 5.0) },                              // Halls of Lighting H
            {603, sConfigMgr->GetOption<float>("Solocraft.UlduarRaidH", 25.0) },                           // Ulduar 25
            {604, sConfigMgr->GetOption<float>("Solocraft.GunDrakH", 5.0) },                               // Gundrak H
            {608, sConfigMgr->GetOption<float>("Solocraft.DalaranPrisonH", 5.0) },                         // Violet Hold H
            {615, sConfigMgr->GetOption<float>("Solocraft.ChamberOfAspectsBlackH", 25.0) },                // The Obsidian Sanctum 25
            {616, sConfigMgr->GetOption<float>("Solocraft.NexusRaidH", 25.0) },                            // The Eye of Eternity 25
            {619, sConfigMgr->GetOption<float>("Solocraft.Azjol_LowerCityH", 5.0) },                       // Ahn'kahet: The Old Kingdom H
            {631, sConfigMgr->GetOption<float>("Solocraft.IcecrownCitadelH", 25.0) },                      // Icecrown Citadel 25
            {632, sConfigMgr->GetOption<float>("Solocraft.IcecrownCitadel5ManH", 5.0) },                   // The Forge of Souls
            {649, sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentRaidH", 25.0) },                 // Trial of the Crusader 25
            {650, sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentDungeonH", 5.0) },               // Trial of the Champion H
            {658, sConfigMgr->GetOption<float>("Solocraft.QuarryOfTearsH", 5.0) },                         // Pit of Saron H
            {668, sConfigMgr->GetOption<float>("Solocraft.HallsOfReflectionH", 5.0) },                     // Halls of Reflection H
            {724, sConfigMgr->GetOption<float>("Solocraft.ChamberOfAspectsRedH", 25.0) },                  // The Ruby Sanctum 25
        };

        //Unique Raids beyond the heroic and normal versions of themselves
        D649H10 = sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentRaidH10", 10.0);  //Trial of the Crusader 10 Heroic
        D649H25 = sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentRaidH25", 25.0);  //Trial of the Crusader 25 Heroic

        //Get from conf excluded map for Solocraft scaling
        LoadList(sConfigMgr->GetOption<std::string>("Solocraft.Instance.Excluded", ""), SolocraftInstanceExcluded);
    }
};

class SolocraftAnnounce : public PlayerScript
{
private:
    std::map<ObjectGuid, bool> playerInInstanceMap;

public:
    SolocraftAnnounce() : PlayerScript("SolocraftAnnounce", {
        PLAYERHOOK_ON_LOGIN,
        PLAYERHOOK_ON_LOGOUT,
        PLAYERHOOK_ON_MAP_CHANGED,
        PLAYERHOOK_ON_GIVE_EXP
    }) {}

    void OnPlayerLogin(Player* player) override
    {
        if (SoloCraftEnable && SoloCraftAnnounceModule)
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SoloCraft |rmodule.");
    }

    void OnPlayerLogout(Player* player) override
    {
        QueryResult result = CharacterDatabase.Query("SELECT `GUID` FROM `custom_solocraft_character_stats` WHERE `GUID`={}", player->GetGUID().GetCounter());
        if (result)
        {
            //Remove database entry as the player has logged out
            CharacterDatabase.Execute("DELETE FROM `custom_solocraft_character_stats` WHERE `GUID`={}", player->GetGUID().GetCounter());
        }
        playerInInstanceMap.erase(player->GetGUID());
    }

    void OnPlayerMapChanged(Player* player) override
    {
        if (player->GetMap()->IsDungeon() || player->GetMap()->IsRaid())
            playerInInstanceMap[player->GetGUID()] = true;
        else
            playerInInstanceMap[player->GetGUID()] = false;
    }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (SolocraftXPBalEnabled && playerInInstanceMap[player->GetGUID()])
        {
            // Decrease Experience based on number of players and difficulty of instance (0 to 100%)
            amount = uint32(amount * SoloCraftXPMod);
        }
    }
};

class SolocraftPlayerInstanceHandler : public PlayerScript
{
public:
    SolocraftPlayerInstanceHandler() : PlayerScript("SolocraftPlayerInstanceHandler", {
        PLAYERHOOK_ON_MAP_CHANGED
    }) {}
    
    bool IsInSolocraftInstanceExcludedList(uint32 id)
    {
        return find(SolocraftInstanceExcluded.begin(), SolocraftInstanceExcluded.end(), id) != SolocraftInstanceExcluded.end();
    }

    void OnPlayerMapChanged(Player* player) override
    {
        if (sConfigMgr->GetOption<bool>("Solocraft.Enable", true))
        {
            Map* map = player->GetMap();
            float difficulty = CalculateDifficulty(map);
            uint32 dunLevel = CalculateDungeonLevel(map);
            uint32 numInGroup = GetNumInGroup(player);
            uint32 classBalance = GetClassBalance(player);
            ApplyBuffs(player, map, difficulty, dunLevel, numInGroup, classBalance);
        }
    }

    // Set the instance difficulty
    float CalculateDifficulty(Map* map)
    {
        if (map)
        {
            if (IsInSolocraftInstanceExcludedList(map->GetId()))
                return 0;

            if (map->Is25ManRaid())
            {
                if (map->IsHeroic() && map->GetId() == 649)
                    return D649H25;
                else if (diff_Multiplier_Heroics.find(map->GetId()) == diff_Multiplier_Heroics.end())
                    return D25;
                else
                    return diff_Multiplier_Heroics[map->GetId()];
            }

            if (map->IsHeroic())
            {
                if (map->GetId() == 649)
                    return D649H10;
                else if (diff_Multiplier_Heroics.find(map->GetId()) == diff_Multiplier_Heroics.end())
                    return D10;
                else
                    return diff_Multiplier_Heroics[map->GetId()];
            }

            if (diff_Multiplier.find(map->GetId()) == diff_Multiplier.end())
            {
                if (map->IsDungeon())
                    return D5;
                else if (map->IsRaid())
                    return D40;
            }
            else
                return diff_Multiplier[map->GetId()];
        }

        return 0;
    }

    // Set the Dungeon Level
    uint32 CalculateDungeonLevel(Map* map)
    {
        if (dungeons.find(map->GetId()) == dungeons.end())
            return SolocraftDungeonLevel;
        else
            return dungeons[map->GetId()];
    }

    // Get the group's size
    uint32 GetNumInGroup(Player* player)
    {
        uint32 numInGroup = 1;
        Group* group = player->GetGroup();

        if (group)
        {
            Group::MemberSlotList const& groupMembers = group->GetMemberSlots();
            numInGroup = groupMembers.size();
        }

        return numInGroup;
    }

    // Get the Player's class balance debuff
    uint32 GetClassBalance(Player* player)
    {
        uint32 classBalance = 100;

        if (classes.find(player->getClass()) == classes.end())
            return classBalance;
        else if (classes[player->getClass()] >= 0 && classes[player->getClass()] <= 100)
            return classes[player->getClass()];
        else
            return classBalance;
    }

    // Get the current group members GUIDS and return the total sum of the difficulty offset by all group members currently in the dungeon
    float GetGroupDifficulty(Player* player)
    {
        float GroupDifficulty = 0.0;
        Group* group = player->GetGroup();

        if (group)
        {
            Group::MemberSlotList const& groupMembers = group->GetMemberSlots();
            for (Group::member_citerator itr = groupMembers.begin(); itr != groupMembers.end(); ++itr)
            {
                if (itr->guid != player->GetGUID())
                {
                    QueryResult result = CharacterDatabase.Query("SELECT `GUID`, `Difficulty`, `GroupSize` FROM `custom_solocraft_character_stats` WHERE `GUID`={}", itr->guid.GetCounter());
                    if (result)
                    {
                        if ((*result)[1].Get<float>() > 0)
                            GroupDifficulty = GroupDifficulty + (*result)[1].Get<float>();
                    }
                }
            }
        }

        return GroupDifficulty;
    }

    // Resets buffers
    void ClearBuffs(Player* player)
    {
        //Database query to get offset from the last instance player exited
        QueryResult result = CharacterDatabase.Query("SELECT `GUID`, `Difficulty`, `GroupSize`, `SpellPower`, `Stats` FROM `custom_solocraft_character_stats` WHERE `GUID`={}", player->GetGUID().GetCounter());
        uint32 SpellPowerBonus = 0;

        if (result)
        {
            float difficulty = (*result)[1].Get<float>();
            SpellPowerBonus = (*result)[3].Get<uint32>();
            float StatsMultPct = (*result)[4].Get<float>();
            SoloCraftXPMod = 1.0;

            for (uint32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
                player->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, difficulty * StatsMultPct, false);

            if (player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN) && !SolocraftNoXPFlag)
                player->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);

            SolocraftNoXPFlag = 0;
            CharacterDatabase.Execute("DELETE FROM custom_solocraft_character_stats WHERE GUID = {}", player->GetGUID().GetCounter());
        }

        if (player->getPowerType() == POWER_MANA || player->getClass() == CLASS_DRUID)
            player->ApplySpellPowerBonus(SpellPowerBonus, false);
    }

    // Apply the player buffs
    void ApplyBuffs(Player* player, Map* map, float difficulty, int dunLevel, int numInGroup, int classBalance)
    {
        // Check whether to debuff back to normal or check to buff the player
        if (difficulty == 0 || IsInSolocraftInstanceExcludedList(map->GetId()))
            ClearBuffs(player); // Check to revert player back to normal - Moving this here fixed logout and login while in instance buff and debuff issues
        else
        {
            std::ostringstream ss;

            int SpellPowerBonus = 0;

            // Check for an existing No XP Gain flag - other mod compatibility
            if (player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN))
                SolocraftNoXPFlag = 1;

            // If a player is too high level for dungeon don't buff but if in a group will count towards the group offset balancing.
            if (player->GetLevel() <= dunLevel + SolocraftLevelDiff)
            {

                // Get Current members total difficulty offset and if it exceeds the difficulty offset of the dungeon then debuff new group members coming in until all members leave and re-enter. This happens when a player already inside dungeon invite others to the group but the player already has the full difficulty offset.
                float GroupDifficulty = GetGroupDifficulty(player);

                // Check to either debuff or buff player entering dungeon.  Debuff must be enabled in Config
                if (GroupDifficulty >= difficulty && SoloCraftDebuffEnable == 1)
                {
                    // Current dungeon offset exceeded - Debuff player modified by ClassBalance Adjustment
                    difficulty = (-abs(difficulty)) + ((((float)classBalance / 100) * difficulty) / numInGroup);
                    // Float variables suck
                    difficulty = roundf(difficulty * 100) / 100;

                    // Disable player XP gain if debuff applied
                    if (!player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN) && SolocraftXPBalEnabled)
                        player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
                }
                else
                {
                    // Current Dungeon offset not exceeded - Buff player
                    // Group difficulty and ClassBalance Adjustment
                    difficulty = (((float)classBalance / 100) * difficulty) / numInGroup;
                    // Float variables suck - two decimal rounding
                    difficulty = roundf(difficulty * 100) / 100;

                    // Set XP Modifier
                    SoloCraftXPMod = (1.04 / difficulty) - 0.02;
                    SoloCraftXPMod = roundf(SoloCraftXPMod * 100) / 100;

                    // Check for negative XP modifier - Disable XP Gain
                    if (SoloCraftXPMod < 0)
                    {
                        SoloCraftXPMod = 0;
                        if (!player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN) && SolocraftXPBalEnabled)
                            player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
                    }

                    // Check XP modifier for over max limit and adjust
                    if (SoloCraftXPMod > 1)
                        SoloCraftXPMod = 1.0;
                }

                // Check Database for a current dungeon entry
                QueryResult result = CharacterDatabase.Query("SELECT `GUID`, `Difficulty`, `GroupSize`, `SpellPower`, `Stats` FROM `custom_solocraft_character_stats` WHERE `GUID`={}", player->GetGUID().GetCounter());

                // Modify Player Stats
                // STATS defined/enum in SharedDefines.h
                for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
                {
                    // Check for Dungeon to Dungeon Transfer and remove old buff
                    if (result)
                        player->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, (*result)[1].Get<float>() * (*result)[4].Get<float>(), false);
                    // Buff the player
                    // Unitmods enum UNIT_MOD_STAT_START defined in Unit.h line 391
                    player->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, difficulty * SoloCraftStatsMult, true);

                }

                // Set player health
                // Defined in Unit.h line 1524
                player->SetFullHealth();

                if (player->IsExistPet())
                {
                    // Set Pet Health
                    player->CastSpell(player, 6962, true);

                }

                // Spellcaster Stat modify
                if (player->getPowerType() == POWER_MANA || player->getClass() == CLASS_DRUID)
                {
                    // Buff the player's mana
                    player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));

                    // Check for Dungeon to Dungeon Transfer and remove old Spellpower buff
                    if (result)
                    {
                        // remove spellpower bonus
                        player->ApplySpellPowerBonus((*result)[3].Get<uint32>() * (*result)[4].Get<float>(), false);
                    }

                    // Buff Spellpower
                    // Debuffed characters do not get spellpower
                    if (difficulty > 0)
                    {
                        SpellPowerBonus = static_cast<int>((player->GetBaseSpellPowerBonus() * SoloCraftSpellMult) * difficulty);
                        player->ApplySpellPowerBonus(SpellPowerBonus, true);
                    }
                }

                // XP Gain Disabled
                if (!SolocraftXPEnabled)
                {
                    SoloCraftXPMod = 0;
                    if (!player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN))
                        player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
                }

                // Announcements
                if (difficulty > 0)
                {
                    // Announce to player - Buff
                    if (!SolocraftXPEnabled)
                    {
                        ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered {}  - Difficulty Offset: {:.2f}. Spellpower Bonus: {}. Class Balance Weight: {}.  XP Gain: |cffFF0000Disabled";
                        ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), difficulty, SpellPowerBonus, classBalance);
                    }
                    else
                    {
                        if (!SolocraftXPBalEnabled)
                        {
                            ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered {}  - Difficulty Offset: {:.2f}. Spellpower Bonus: {}. Class Balance Weight: {}.  XP Balancing: |cffFF0000Disabled";
                            ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), difficulty, SpellPowerBonus, classBalance);
                        }
                        else
                        {
                            ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered {}  - Difficulty Offset: {:.2f}. Spellpower Bonus: {}. Class Balance Weight: {}.  XP Balancing: |cff4CFF00Enabled";
                            ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), difficulty, SpellPowerBonus, classBalance);
                        }
                    }
                }
                else
                {
                    // Announce to player - Debuff
                    if (!SolocraftXPBalEnabled && SolocraftXPEnabled)
                    {
                        ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered {}  - |cffFF0000BE ADVISED - You have been debuffed by offset: {:.2f} with a Class Balance Weight: {}. |cffFF8000 A group member already inside has the dungeon's full buff offset.  No Spellpower buff will be applied to spell casters.  ALL group members must exit the dungeon and re-enter to receive a balanced offset.";
                        ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), difficulty, classBalance);
                    }
                    else
                    {
                        ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered {}  - |cffFF0000BE ADVISED - You have been debuffed by offset: {:.2f} with a Class Balance Weight: {} and no XP will be awarded. |cffFF8000 A group member already inside has the dungeon's full buff offset.  No Spellpower buff will be applied to spell casters.  ALL group members must exit the dungeon and re-enter to receive a balanced offset.";
                        ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), difficulty, classBalance);
                    }
                }

                // Save Player Dungeon Offsets to Database
                CharacterDatabase.Execute("REPLACE INTO custom_solocraft_character_stats (GUID, Difficulty, GroupSize, SpellPower, Stats) VALUES ({}, {}, {}, {}, {})", player->GetGUID().GetCounter(), difficulty, numInGroup, SpellPowerBonus, SoloCraftStatsMult);
            }
            else
            {
                // Announce to player - Over Max Level Threshold
                ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered {}  - |cffFF0000You have not been buffed. |cffFF8000 Your level is higher than the max level ({}) threshold for this dungeon.";
                ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), dunLevel + SolocraftLevelDiff);
                ClearBuffs(player); // Check to revert player back to normal
            }
        }
    }

private:
    std::map<uint32, float> _unitDifficulty;
};

void AddSolocraftScripts()
{
    new SolocraftConfig();
    new SolocraftAnnounce();
    new SolocraftPlayerInstanceHandler();
}
