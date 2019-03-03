/*

# All Mounts NPC#


### Description ###
------------------------------------------------------------------------------------------------------------------
- Adds an NPC that will teach all available mounts to the player


### To-Do ###
------------------------------------------------------------------------------------------------------------------
- Remove all mounts not compatible with 3.3.5a


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: All_Mounts_NPC
- Config: Yes
- SQL: Yes
    - NPC ID: 601014


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2018.12.15 - Updated for StygianCore
- v2017.09.03 - Added Bengal Tiger + Tiger Riding
- v2017.08.01 - Release


### Credits ###
------------------------------------------------------------------------------------------------------------------
#### A module for AzerothCore by StygianTheBest ([stygianthebest.github.io](http://stygianthebest.github.io)) ####

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

bool AllMountsAnnounceModule = 1;

class AllMountsConfig : public WorldScript
{
public:
    AllMountsConfig() : WorldScript("AllMountsConfig_conf") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/npc_allmounts.conf";
#ifdef WIN32
            cfg_file = "npc_allmounts.conf";
#endif
            std::string cfg_def_file = cfg_file + ".dist";
            sConfigMgr->LoadMore(cfg_def_file.c_str());
            sConfigMgr->LoadMore(cfg_file.c_str());

            AllMountsAnnounceModule = sConfigMgr->GetBoolDefault("AllMountsNPC.Announce", 1);
        }
    }
};

class AllMountsAnnounce : public PlayerScript
{

public:

    AllMountsAnnounce() : PlayerScript("AllMountsAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (AllMountsAnnounceModule)
        {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00AllMountsNPC |rmodule.");
        }
    }
};

class All_Mounts_NPC : public CreatureScript
{

public:

    All_Mounts_NPC() : CreatureScript("All_Mounts_NPC") {}

    bool OnGossipHello(Player* player, Creature* creature) override
    {

        std::ostringstream messageKnown;
        messageKnown << "I have already taught you all there is to know " << player->GetName() << ".";

        player->PlayerTalkClass->ClearMenus();

        if (player->HasSpell(828))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, messageKnown.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        }
        else
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Learn All Mounts", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Maybe Next Time", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        }

        player->SEND_GOSSIP_MENU(601014, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player * player, Creature * creature, uint32 sender, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();

        if (sender != GOSSIP_SENDER_MAIN)
            return false;

        switch (uiAction)
        {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->learnSpell(10790);		// ReinsoftheBengalTiger
            player->learnSpell(828);		// TigerRiding
            player->learnSpell(72286);		// Invincible'sReins
            player->learnSpell(20221);		// Furor'sFabledSteed
            player->learnSpell(48778);		// AcherusDeathcharger
            player->learnSpell(60025);		// AlbinoDrake
            player->learnSpell(127180);		// AlbinoRidingCrane
            player->learnSpell(98204);		// AmaniBattleBear
            player->learnSpell(96503);		// AmaniDragonhawk
            player->learnSpell(43688);		// AmaniWarBear
            player->learnSpell(138424);		// AmberPrimordialDirehorn
            player->learnSpell(123886);		// AmberScorpion
            player->learnSpell(16056);		// AncientFrostsaber
            player->learnSpell(171618);		// AncientLeatherhide
            player->learnSpell(16081);		// ArcticWolf
            player->learnSpell(66906);		// ArgentCharger
            player->learnSpell(63844);		// ArgentHippogryph
            player->learnSpell(66907);		// ArgentWarhorse
            player->learnSpell(67466);		// ArgentWarhorse
            player->learnSpell(139595);		// ArmoredBloodwing
            player->learnSpell(142478);		// ArmoredBlueDragonhawk
            player->learnSpell(61230);		// ArmoredBlueWindRider
            player->learnSpell(60114);		// ArmoredBrownBear
            player->learnSpell(60116);		// ArmoredBrownBear
            player->learnSpell(171629);		// ArmoredFrostboar
            player->learnSpell(171838);		// ArmoredFrostwolf
            player->learnSpell(171626);		// ArmoredIrontusk
            player->learnSpell(171630);		// ArmoredRazorback
            player->learnSpell(96491);		// ArmoredRazzashiRaptor
            player->learnSpell(142266);		// ArmoredRedDragonhawk
            player->learnSpell(136400);		// ArmoredSkyscreamer
            player->learnSpell(61229);		// ArmoredSnowyGryphon
            player->learnSpell(132117);		// AshenPandarenPhoenix
            player->learnSpell(40192);		// AshesofAl'ar
            player->learnSpell(148428);		// AshhideMushanBeast
            player->learnSpell(127170);		// AstralCloudSerpent
            player->learnSpell(123992);		// AzureCloudSerpent
            player->learnSpell(59567);		// AzureDrake
            player->learnSpell(41514);		// AzureNetherwingDrake
            player->learnSpell(127174);		// AzureRidingCrane
            player->learnSpell(118089);		// AzureWaterStrider
            player->learnSpell(51412);		// BigBattleBear
            player->learnSpell(58983);		// BigBlizzardBear
            player->learnSpell(71342);		// BigLoveRocket
            player->learnSpell(22719);		// BlackBattlestrider
            player->learnSpell(127286);		// BlackDragonTurtle
            player->learnSpell(59650);		// BlackDrake
            player->learnSpell(35022);		// BlackHawkstrider
            player->learnSpell(16055);		// BlackNightsaber
            player->learnSpell(138642);		// BlackPrimalRaptor
            player->learnSpell(59976);		// BlackProto-Drake
            player->learnSpell(25863);		// BlackQirajiBattleTank
            player->learnSpell(26655);		// BlackQirajiBattleTank
            player->learnSpell(26656);		// BlackQirajiBattleTank
            player->learnSpell(17461);		// BlackRam
            player->learnSpell(130138);		// BlackRidingGoat
            player->learnSpell(127209);		// BlackRidingYak
            player->learnSpell(64977);		// BlackSkeletalHorse
            player->learnSpell(470);		// BlackStallion
            player->learnSpell(60118);		// BlackWarBear
            player->learnSpell(60119);		// BlackWarBear
            player->learnSpell(48027);		// BlackWarElekk
            player->learnSpell(22718);		// BlackWarKodo
            player->learnSpell(59785);		// BlackWarMammoth
            player->learnSpell(59788);		// BlackWarMammoth
            player->learnSpell(22720);		// BlackWarRam
            player->learnSpell(22721);		// BlackWarRaptor
            player->learnSpell(22717);		// BlackWarSteed
            player->learnSpell(22723);		// BlackWarTiger
            player->learnSpell(22724);		// BlackWarWolf
            player->learnSpell(64658);		// BlackWolf
            player->learnSpell(171627);		// BlacksteelBattleboar
            player->learnSpell(107842);		// BlazingDrake
            player->learnSpell(74856);		// BlazingHippogryph
            player->learnSpell(127220);		// BlondeRidingYak
            player->learnSpell(72808);		// BloodbathedFrostbroodVanquisher
            player->learnSpell(171620);		// BloodhoofBull
            player->learnSpell(127287);		// BlueDragonTurtle
            player->learnSpell(61996);		// BlueDragonhawk
            player->learnSpell(59568);		// BlueDrake
            player->learnSpell(35020);		// BlueHawkstrider
            player->learnSpell(10969);		// BlueMechanostrider
            player->learnSpell(59996);		// BlueProto-Drake
            player->learnSpell(25953);		// BlueQirajiBattleTank
            player->learnSpell(39803);		// BlueRidingNetherRay
            player->learnSpell(129934);		// BlueShado-PanRidingTiger
            player->learnSpell(17463);		// BlueSkeletalHorse
            player->learnSpell(64656);		// BlueSkeletalWarhorse
            player->learnSpell(32244);		// BlueWindRider
            player->learnSpell(138640);		// Bone-WhitePrimalRaptor
            player->learnSpell(142641);		// Brawler'sBurlyMushanBeast
            player->learnSpell(171832);		// BreezestriderStallion
            player->learnSpell(50869);		// BrewfestKodo
            player->learnSpell(43899);		// BrewfestRam
            player->learnSpell(190690);		// BristlingHellboar
            player->learnSpell(59569);		// BronzeDrake
            player->learnSpell(127288);		// BrownDragonTurtle
            player->learnSpell(34406);		// BrownElekk
            player->learnSpell(458);		// BrownHorse
            player->learnSpell(18990);		// BrownKodo
            player->learnSpell(6899);		// BrownRam
            player->learnSpell(88748);		// BrownRidingCamel
            player->learnSpell(130086);		// BrownRidingGoat
            player->learnSpell(127213);		// BrownRidingYak
            player->learnSpell(17464);		// BrownSkeletalHorse
            player->learnSpell(6654);		// BrownWolf
            player->learnSpell(58615);		// BrutalNetherDrake
            player->learnSpell(124550);		// CataclysmicGladiator'sTwilightDrake
            player->learnSpell(75614);		// CelestialSteed
            player->learnSpell(43927);		// CenarionWarHippogryph
            player->learnSpell(171848);		// Challenger'sWarYeti
            player->learnSpell(171846);		// Champion'sTreadblade
            player->learnSpell(6648);		// ChestnutMare
            player->learnSpell(171847);		// CindermaneCharger
            player->learnSpell(139448);		// ClutchofJi-Kun
            player->learnSpell(189364);		// CoalfistGronnling
            player->learnSpell(41515);		// CobaltNetherwingDrake
            player->learnSpell(138423);		// CobaltPrimordialDirehorn
            player->learnSpell(39315);		// CobaltRidingTalbuk
            player->learnSpell(34896);		// CobaltWarTalbuk
            player->learnSpell(170347);		// CoreHound
            player->learnSpell(183117);		// CorruptedDreadwing
            player->learnSpell(97560);		// CorruptedFireHawk
            player->learnSpell(102514);		// CorruptedHippogryph
            player->learnSpell(169952);		// CreepingCarpet
            player->learnSpell(127156);		// CrimsonCloudSerpent
            player->learnSpell(73313);		// CrimsonDeathcharger
            player->learnSpell(129552);		// CrimsonPandarenPhoenix
            player->learnSpell(140250);		// CrimsonPrimalDirehorn
            player->learnSpell(123160);		// CrimsonRidingCrane
            player->learnSpell(127271);		// CrimsonWaterStrider
            player->learnSpell(68188);		// Crusader'sBlackWarhorse
            player->learnSpell(68187);		// Crusader'sWhiteWarhorse
            player->learnSpell(88990);		// DarkPhoenix
            player->learnSpell(39316);		// DarkRidingTalbuk
            player->learnSpell(34790);		// DarkWarTalbuk
            player->learnSpell(103081);		// DarkmoonDancingBear
            player->learnSpell(63635);		// DarkspearRaptor
            player->learnSpell(63637);		// DarnassianNightsaber
            player->learnSpell(64927);		// DeadlyGladiator'sFrostWyrm
            player->learnSpell(190977);		// DeathtuskFelboar
            player->learnSpell(193007);		// Demonsaber
            player->learnSpell(126507);		// Depleted-KypariumRocket
            player->learnSpell(6653);		// DireWolf
            player->learnSpell(171634);		// DomesticatedRazorback
            player->learnSpell(88335);		// DrakeoftheEastWind
            player->learnSpell(88742);		// DrakeoftheNorthWind
            player->learnSpell(88744);		// DrakeoftheSouthWind
            player->learnSpell(88741);		// DrakeoftheWestWind
            player->learnSpell(155741);		// DreadRaven
            player->learnSpell(148972);		// Dreadsteed
            player->learnSpell(171844);		// DustmaneDirewolf
            player->learnSpell(171625);		// DustyRockhide
            player->learnSpell(32239);		// EbonGryphon
            player->learnSpell(194464);		// EclipseDragonhawk
            player->learnSpell(175700);		// EmeraldDrake
            player->learnSpell(149801);		// EmeraldHippogryph
            player->learnSpell(132118);		// EmeraldPandarenPhoenix
            player->learnSpell(8395);		// EmeraldRaptor
            player->learnSpell(142878);		// EnchantedFeyDragon
            player->learnSpell(63639);		// ExodarElekk
            player->learnSpell(110039);		// Experiment12-B
            player->learnSpell(113120);		// Feldrake
            player->learnSpell(97501);		// FelfireHawk
            player->learnSpell(200175);		// Felsaber
            player->learnSpell(148970);		// Felsteed
            player->learnSpell(182912);		// FelsteelAnnihilator
            player->learnSpell(36702);		// FieryWarhorse
            player->learnSpell(101542);		// FlametalonofAlysrazor
            player->learnSpell(97359);		// FlamewardHippogryph
            player->learnSpell(61451);		// FlyingCarpet
            player->learnSpell(44153);		// FlyingMachine
            player->learnSpell(63643);		// ForsakenWarhorse
            player->learnSpell(84751);		// FossilizedRaptor
            player->learnSpell(17460);		// FrostRam
            player->learnSpell(171632);		// FrostplainsBattleboar
            player->learnSpell(23509);		// FrostwolfHowler
            player->learnSpell(75596);		// FrostyFlyingCarpet
            player->learnSpell(65439);		// FuriousGladiator'sFrostWyrm
            player->learnSpell(171851);		// GarnNighthowl
            player->learnSpell(171836);		// GarnSteelmaw
            player->learnSpell(126508);		// GeosynchronousWorldSpinner
            player->learnSpell(136505);		// GhastlyCharger
            player->learnSpell(171635);		// GiantColdsnout
            player->learnSpell(63638);		// GnomereganMechanostrider
            player->learnSpell(89520);		// GoblinMiniHotrod
            player->learnSpell(87090);		// GoblinTrike
            player->learnSpell(87091);		// GoblinTurbo-Trike
            player->learnSpell(123993);		// GoldenCloudSerpent
            player->learnSpell(32235);		// GoldenGryphon
            player->learnSpell(90621);		// GoldenKing
            player->learnSpell(140249);		// GoldenPrimalDirehorn
            player->learnSpell(127176);		// GoldenRidingCrane
            player->learnSpell(127278);		// GoldenWaterStrider
            player->learnSpell(171436);		// GorestriderGronnling
            player->learnSpell(135416);		// GrandArmoredGryphon
            player->learnSpell(135418);		// GrandArmoredWyvern
            player->learnSpell(61465);		// GrandBlackWarMammoth
            player->learnSpell(61467);		// GrandBlackWarMammoth
            player->learnSpell(122708);		// GrandExpeditionYak
            player->learnSpell(136163);		// GrandGryphon
            player->learnSpell(61470);		// GrandIceMammoth
            player->learnSpell(61469);		// GrandIceMammoth
            player->learnSpell(136164);		// GrandWyvern
            player->learnSpell(35710);		// GrayElekk
            player->learnSpell(18989);		// GrayKodo
            player->learnSpell(6777);		// GrayRam
            player->learnSpell(127295);		// GreatBlackDragonTurtle
            player->learnSpell(127302);		// GreatBlueDragonTurtle
            player->learnSpell(35713);		// GreatBlueElekk
            player->learnSpell(49379);		// GreatBrewfestKodo
            player->learnSpell(127308);		// GreatBrownDragonTurtle
            player->learnSpell(23249);		// GreatBrownKodo
            player->learnSpell(65641);		// GreatGoldenKodo
            player->learnSpell(23248);		// GreatGrayKodo
            player->learnSpell(127293);		// GreatGreenDragonTurtle
            player->learnSpell(35712);		// GreatGreenElekk
            player->learnSpell(171636);		// GreatGreytusk
            player->learnSpell(127310);		// GreatPurpleDragonTurtle
            player->learnSpell(35714);		// GreatPurpleElekk
            player->learnSpell(120822);		// GreatRedDragonTurtle
            player->learnSpell(65637);		// GreatRedElekk
            player->learnSpell(23247);		// GreatWhiteKodo
            player->learnSpell(120395);		// GreenDragonTurtle
            player->learnSpell(18991);		// GreenKodo
            player->learnSpell(17453);		// GreenMechanostrider
            player->learnSpell(138643);		// GreenPrimalRaptor
            player->learnSpell(61294);		// GreenProto-Drake
            player->learnSpell(26056);		// GreenQirajiBattleTank
            player->learnSpell(39798);		// GreenRidingNetherRay
            player->learnSpell(129932);		// GreenShado-PanRidingTiger
            player->learnSpell(17465);		// GreenSkeletalWarhorse
            player->learnSpell(32245);		// GreenWindRider
            player->learnSpell(88750);		// GreyRidingCamel
            player->learnSpell(127216);		// GreyRidingYak
            player->learnSpell(148619);		// GrievousGladiator'sCloudSerpent
            player->learnSpell(163025);		// GrinningReaver
            player->learnSpell(189999);		// GroveWarden
            player->learnSpell(48025);		// HeadlessHorseman'sMount
            player->learnSpell(110051);		// HeartoftheAspects
            player->learnSpell(142073);		// Hearthsteed
            player->learnSpell(127169);		// HeavenlyAzureCloudSerpent
            player->learnSpell(127161);		// HeavenlyCrimsonCloudSerpent
            player->learnSpell(127164);		// HeavenlyGoldenCloudSerpent
            player->learnSpell(127165);		// HeavenlyJadeCloudSerpent
            player->learnSpell(127158);		// HeavenlyOnyxCloudSerpent
            player->learnSpell(59799);		// IceMammoth
            player->learnSpell(59797);		// IceMammoth
            player->learnSpell(72807);		// IceboundFrostbroodVanquisher
            player->learnSpell(17459);		// IcyBlueMechanostriderModA
            player->learnSpell(189998);		// IllidariFelstalker
            player->learnSpell(124659);		// ImperialQuilen
            player->learnSpell(186305);		// InfernalDirewolf
            player->learnSpell(201098);		// InfiniteTimereaver
            player->learnSpell(153489);		// IronSkyreaver
            player->learnSpell(63956);		// IronboundProto-Drake
            player->learnSpell(142910);		// IronboundWraithcharger
            player->learnSpell(63636);		// IronforgeRam
            player->learnSpell(171621);		// IronhoofDestroyer
            player->learnSpell(171839);		// IronsideWarwolf
            player->learnSpell(17450);		// IvoryRaptor
            player->learnSpell(113199);		// JadeCloudSerpent
            player->learnSpell(133023);		// JadePandarenKite
            player->learnSpell(121837);		// JadePanther
            player->learnSpell(138426);		// JadePrimordialDirehorn
            player->learnSpell(127274);		// JadeWaterStrider
            player->learnSpell(120043);		// JeweledOnyxPanther
            player->learnSpell(127178);		// JungleRidingCrane
            player->learnSpell(93644);		// Kor'kronAnnihilator
            player->learnSpell(148417);		// Kor'kronJuggernaut
            player->learnSpell(148396);		// Kor'kronWarWolf
            player->learnSpell(107845);		// Life-Binder'sHandmaiden
            player->learnSpell(65917);		// MagicRooster
            player->learnSpell(61309);		// MagnificentFlyingCarpet
            player->learnSpell(139407);		// MalevolentGladiator'sCloudSerpent
            player->learnSpell(55531);		// Mechano-Hog
            player->learnSpell(60424);		// Mekgineer'sChopper
            player->learnSpell(44744);		// MercilessNetherDrake
            player->learnSpell(63796);		// Mimiron'sHead
            player->learnSpell(191314);		// MinionofGrumpus
            player->learnSpell(171825);		// MosshideRiverwallow
            player->learnSpell(93623);		// MottledDrake
            player->learnSpell(171622);		// MottledMeadowstomper
            player->learnSpell(16084);		// MottledRedRaptor
            player->learnSpell(171850);		// MountTemplate49
            player->learnSpell(171827);		// MountTemplate50
            player->learnSpell(171840);		// MountTemplate51
            player->learnSpell(103195);		// MountainHorse
            player->learnSpell(171826);		// MudbackRiverbeast
            player->learnSpell(180545);		// MysticRunesaber
            player->learnSpell(121820);		// ObsidianNightwing
            player->learnSpell(66846);		// OchreSkeletalWarhorse
            player->learnSpell(127154);		// OnyxCloudSerpent
            player->learnSpell(41513);		// OnyxNetherwingDrake
            player->learnSpell(69395);		// OnyxianDrake
            player->learnSpell(127272);		// OrangeWaterStrider
            player->learnSpell(63640);		// OrgrimmarWolf
            player->learnSpell(171833);		// PaleThorngrazer
            player->learnSpell(16082);		// Palomino
            player->learnSpell(118737);		// PandarenKite
            player->learnSpell(130985);		// PandarenKite
            player->learnSpell(32345);		// PeepthePhoenixMount
            player->learnSpell(88718);		// PhosphorescentStoneDrake
            player->learnSpell(472);		// Pinto
            player->learnSpell(60021);		// PlaguedProto-Drake
            player->learnSpell(193695);		// PrestigiousWarSteed
            player->learnSpell(204166);		// PrestigiousWarWolf
            player->learnSpell(148620);		// PridefulGladiator'sCloudSerpent
            player->learnSpell(186828);		// PrimalGladiator'sFelbloodGronnling
            player->learnSpell(97493);		// PurebloodFireHawk
            player->learnSpell(127289);		// PurpleDragonTurtle
            player->learnSpell(35711);		// PurpleElekk
            player->learnSpell(35018);		// PurpleHawkstrider
            player->learnSpell(41516);		// PurpleNetherwingDrake
            player->learnSpell(39801);		// PurpleRidingNetherRay
            player->learnSpell(23246);		// PurpleSkeletalWarhorse
            player->learnSpell(66090);		// Quel'doreiSteed
            player->learnSpell(41252);		// RavenLord
            player->learnSpell(127290);		// RedDragonTurtle
            player->learnSpell(61997);		// RedDragonhawk
            player->learnSpell(59570);		// RedDrake
            player->learnSpell(130092);		// RedFlyingCloud
            player->learnSpell(34795);		// RedHawkstrider
            player->learnSpell(10873);		// RedMechanostrider
            player->learnSpell(138641);		// RedPrimalRaptor
            player->learnSpell(59961);		// RedProto-Drake
            player->learnSpell(26054);		// RedQirajiBattleTank
            player->learnSpell(39800);		// RedRidingNetherRay
            player->learnSpell(129935);		// RedShado-PanRidingTiger
            player->learnSpell(17462);		// RedSkeletalHorse
            player->learnSpell(22722);		// RedSkeletalWarhorse
            player->learnSpell(16080);		// RedWolf
            player->learnSpell(127177);		// RegalRidingCrane
            player->learnSpell(67336);		// RelentlessGladiator'sFrostWyrm
            player->learnSpell(30174);		// RidingTurtle
            player->learnSpell(17481);		// Rivendare'sDeathcharger
            player->learnSpell(171628);		// RocktuskBattleboar
            player->learnSpell(121838);		// RubyPanther
            player->learnSpell(63963);		// RustedProto-Drake
            player->learnSpell(101821);		// RuthlessGladiator'sTwilightDrake
            player->learnSpell(93326);		// SandstoneDrake
            player->learnSpell(121836);		// SapphirePanther
            player->learnSpell(171824);		// SapphireRiverbeast
            player->learnSpell(97581);		// SavageRaptor
            player->learnSpell(64731);		// SeaTurtle
            player->learnSpell(171624);		// ShadowhidePearltusk
            player->learnSpell(171829);		// ShadowmaneCharger
            player->learnSpell(66087);		// SilverCovenantHippogryph
            player->learnSpell(39802);		// SilverRidingNetherRay
            player->learnSpell(39317);		// SilverRidingTalbuk
            player->learnSpell(34898);		// SilverWarTalbuk
            player->learnSpell(63642);		// SilvermoonHawkstrider
            player->learnSpell(134359);		// SkyGolem
            player->learnSpell(138425);		// SlatePrimordialDirehorn
            player->learnSpell(171843);		// SmokyDirewolf
            player->learnSpell(32240);		// SnowyGryphon
            player->learnSpell(191633);		// SoaringSkyterror
            player->learnSpell(171828);		// SolarSpirehawk
            player->learnSpell(130965);		// SonofGalleon
            player->learnSpell(148392);		// SpawnofGalakras
            player->learnSpell(136471);		// SpawnofHorridon
            player->learnSpell(107516);		// SpectralGryphon
            player->learnSpell(92231);		// SpectralSteed
            player->learnSpell(42776);		// SpectralTiger
            player->learnSpell(107517);		// SpectralWindRider
            player->learnSpell(92232);		// SpectralWolf
            player->learnSpell(196681);		// SpiritofEche'ro
            player->learnSpell(10789);		// SpottedFrostsaber
            player->learnSpell(147595);		// Stormcrow
            player->learnSpell(23510);		// StormpikeBattleCharger
            player->learnSpell(63232);		// StormwindSteed
            player->learnSpell(66847);		// StripedDawnsaber
            player->learnSpell(8394);		// StripedFrostsaber
            player->learnSpell(10793);		// StripedNightsaber
            player->learnSpell(98718);		// SubduedSeahorse
            player->learnSpell(179245);		// SummonChauffeur
            player->learnSpell(179244);		// SummonChauffeur
            player->learnSpell(171849);		// SunhideGronnling
            player->learnSpell(66088);		// SunreaverDragonhawk
            player->learnSpell(66091);		// SunreaverHawkstrider
            player->learnSpell(121839);		// SunstonePanther
            player->learnSpell(68057);		// SwiftAllianceSteed
            player->learnSpell(32242);		// SwiftBlueGryphon
            player->learnSpell(23241);		// SwiftBlueRaptor
            player->learnSpell(171830);		// SwiftBreezestrider
            player->learnSpell(43900);		// SwiftBrewfestRam
            player->learnSpell(23238);		// SwiftBrownRam
            player->learnSpell(23229);		// SwiftBrownSteed
            player->learnSpell(23250);		// SwiftBrownWolf
            player->learnSpell(65646);		// SwiftBurgundyWolf
            player->learnSpell(102346);		// SwiftForestStrider
            player->learnSpell(23221);		// SwiftFrostsaber
            player->learnSpell(171842);		// SwiftFrostwolf
            player->learnSpell(23239);		// SwiftGrayRam
            player->learnSpell(65640);		// SwiftGraySteed
            player->learnSpell(23252);		// SwiftGrayWolf
            player->learnSpell(32290);		// SwiftGreenGryphon
            player->learnSpell(35025);		// SwiftGreenHawkstrider
            player->learnSpell(23225);		// SwiftGreenMechanostrider
            player->learnSpell(32295);		// SwiftGreenWindRider
            player->learnSpell(68056);		// SwiftHordeWolf
            player->learnSpell(102350);		// SwiftLovebird
            player->learnSpell(23219);		// SwiftMistsaber
            player->learnSpell(65638);		// SwiftMoonsaber
            player->learnSpell(103196);		// SwiftMountainHorse
            player->learnSpell(37015);		// SwiftNetherDrake
            player->learnSpell(23242);		// SwiftOliveRaptor
            player->learnSpell(23243);		// SwiftOrangeRaptor
            player->learnSpell(23227);		// SwiftPalomino
            player->learnSpell(33660);		// SwiftPinkHawkstrider
            player->learnSpell(32292);		// SwiftPurpleGryphon
            player->learnSpell(35027);		// SwiftPurpleHawkstrider
            player->learnSpell(65644);		// SwiftPurpleRaptor
            player->learnSpell(32297);		// SwiftPurpleWindRider
            player->learnSpell(24242);		// SwiftRazzashiRaptor
            player->learnSpell(32289);		// SwiftRedGryphon
            player->learnSpell(65639);		// SwiftRedHawkstrider
            player->learnSpell(32246);		// SwiftRedWindRider
            player->learnSpell(101573);		// SwiftShorestrider
            player->learnSpell(55164);		// SwiftSpectralGryphon
            player->learnSpell(194046);		// SwiftSpectralRylak
            player->learnSpell(42777);		// SwiftSpectralTiger
            player->learnSpell(102349);		// SwiftSpringstrider
            player->learnSpell(23338);		// SwiftStormsaber
            player->learnSpell(23251);		// SwiftTimberWolf
            player->learnSpell(65643);		// SwiftVioletRam
            player->learnSpell(35028);		// SwiftWarstrider
            player->learnSpell(46628);		// SwiftWhiteHawkstrider
            player->learnSpell(23223);		// SwiftWhiteMechanostrider
            player->learnSpell(23240);		// SwiftWhiteRam
            player->learnSpell(23228);		// SwiftWhiteSteed
            player->learnSpell(134573);		// SwiftWindsteed
            player->learnSpell(23222);		// SwiftYellowMechanostrider
            player->learnSpell(32296);		// SwiftYellowWindRider
            player->learnSpell(49322);		// SwiftZhevra
            player->learnSpell(96499);		// SwiftZulianPanther
            player->learnSpell(24252);		// SwiftZulianTiger
            player->learnSpell(88749);		// TanRidingCamel
            player->learnSpell(39318);		// TanRidingTalbuk
            player->learnSpell(34899);		// TanWarTalbuk
            player->learnSpell(32243);		// TawnyWindRider
            player->learnSpell(18992);		// TealKodo
            player->learnSpell(63641);		// ThunderBluffKodo
            player->learnSpell(129918);		// ThunderingAugustCloudSerpent
            player->learnSpell(139442);		// ThunderingCobaltCloudSerpent
            player->learnSpell(124408);		// ThunderingJadeCloudSerpent
            player->learnSpell(148476);		// ThunderingOnyxCloudSerpent
            player->learnSpell(132036);		// ThunderingRubyCloudSerpent
            player->learnSpell(580);		// TimberWolf
            player->learnSpell(60002);		// Time-LostProto-Drake
            player->learnSpell(171617);		// TrainedIcehoof
            player->learnSpell(171623);		// TrainedMeadowstomper
            player->learnSpell(171638);		// TrainedRiverwallow
            player->learnSpell(171637);		// TrainedRocktusk
            player->learnSpell(171831);		// TrainedSilverpelt
            player->learnSpell(171841);		// TrainedSnarler
            player->learnSpell(61425);		// Traveler'sTundraMammoth
            player->learnSpell(61447);		// Traveler'sTundraMammoth
            player->learnSpell(171619);		// TundraIcehoof
            player->learnSpell(44151);		// Turbo-ChargedFlyingMachine
            player->learnSpell(65642);		// Turbostrider
            player->learnSpell(10796);		// TurquoiseRaptor
            player->learnSpell(59571);		// TwilightDrake
            player->learnSpell(107844);		// TwilightHarbinger
            player->learnSpell(107203);		// Tyrael'sCharger
            player->learnSpell(148618);		// TyrannicalGladiator'sCloudSerpent
            player->learnSpell(92155);		// UltramarineQirajiBattleTank
            player->learnSpell(17454);		// UnpaintedMechanostrider
            player->learnSpell(75207);		// Vashj'irSeahorse
            player->learnSpell(49193);		// VengefulNetherDrake
            player->learnSpell(64659);		// VenomhideRavasaur
            player->learnSpell(41517);		// VeridianNetherwingDrake
            player->learnSpell(101282);		// ViciousGladiator'sTwilightDrake
            player->learnSpell(146622);		// ViciousSkeletalWarhorse
            player->learnSpell(185052);		// ViciousWarKodo
            player->learnSpell(183889);		// ViciousWarMechanostrider
            player->learnSpell(171834);		// ViciousWarRam
            player->learnSpell(171835);		// ViciousWarRaptor
            player->learnSpell(100332);		// ViciousWarSteed
            player->learnSpell(100333);		// ViciousWarWolf
            player->learnSpell(146615);		// ViciousWarsaber
            player->learnSpell(41518);		// VioletNetherwingDrake
            player->learnSpell(132119);		// VioletPandarenPhoenix
            player->learnSpell(60024);		// VioletProto-Drake
            player->learnSpell(10799);		// VioletRaptor
            player->learnSpell(88746);		// VitreousStoneDrake
            player->learnSpell(179478);		// VoidtalonoftheDarkStar
            player->learnSpell(88331);		// VolcanicStoneDrake
            player->learnSpell(163024);		// WarforgedNightmare
            player->learnSpell(171845);		// Warlord'sDeathwheel
            player->learnSpell(189044);		// WarmongeringGladiator'sFelbloodGronnling
            player->learnSpell(171837);		// WarsongDirefang
            player->learnSpell(64657);		// WhiteKodo
            player->learnSpell(15779);		// WhiteMechanostriderModB
            player->learnSpell(54753);		// WhitePolarBear
            player->learnSpell(6898);		// WhiteRam
            player->learnSpell(102488);		// WhiteRidingCamel
            player->learnSpell(130137);		// WhiteRidingGoat
            player->learnSpell(39319);		// WhiteRidingTalbuk
            player->learnSpell(123182);		// WhiteRidingYak
            player->learnSpell(65645);		// WhiteSkeletalWarhorse
            player->learnSpell(16083);		// WhiteStallion
            player->learnSpell(34897);		// WhiteWarTalbuk
            player->learnSpell(189043);		// WildGladiator'sFelbloodGronnling
            player->learnSpell(171633);		// WildGoretusk
            player->learnSpell(98727);		// WingedGuardian
            player->learnSpell(54729);		// WingedSteedoftheEbonBlade
            player->learnSpell(17229);		// WinterspringFrostsaber
            player->learnSpell(171616);		// WitherhideCliffstomper
            player->learnSpell(59791);		// WoolyMammoth
            player->learnSpell(59793);		// WoolyMammoth
            player->learnSpell(74918);		// WoolyWhiteRhino
            player->learnSpell(71810);		// WrathfulGladiator'sFrostWyrm
            player->learnSpell(46197);		// X-51Nether-Rocket
            player->learnSpell(46199);		// X-51Nether-RocketX-TREME
            player->learnSpell(75973);		// X-53TouringRocket
            player->learnSpell(26055);		// YellowQirajiBattleTank

            // Goodbye
            player->PlayerTalkClass->SendCloseGossip();
            break;

        case GOSSIP_ACTION_INFO_DEF + 2:

            // Goodbye
            player->PlayerTalkClass->SendCloseGossip();
            break;
        }

        return true;
    }
};

void AddAllMountsNPCScripts()
{
    new AllMountsConfig();
    new AllMountsAnnounce();
    new All_Mounts_NPC();
}
