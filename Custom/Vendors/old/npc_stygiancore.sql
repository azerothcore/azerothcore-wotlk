/*
-- ################################################################################### --
--  ____    __                                         ____                           
-- /\  _`\ /\ \__                  __                 /\  _`\                         
-- \ \,\L\_\ \ ,_\  __  __     __ /\_\     __      ___\ \ \/\_\    ___   _ __    __   
--  \/_\__ \\ \ \/ /\ \/\ \  /'_ `\/\ \  /'__`\  /' _ `\ \ \/_/_  / __`\/\`'__\/'__`\ 
--    /\ \L\ \ \ \_\ \ \_\ \/\ \L\ \ \ \/\ \L\.\_/\ \/\ \ \ \L\ \/\ \L\ \ \ \//\  __/ 
--    \ `\____\ \__\\/`____ \ \____ \ \_\ \__/.\_\ \_\ \_\ \____/\ \____/\ \_\\ \____\
--     \/_____/\/__/ `/___/> \/___L\ \/_/\/__/\/_/\/_/\/_/\/___/  \/___/  \/_/ \/____/
--                      /\___/ /\____/                                                
--                      \/__/  \_/__/          http://stygianthebest.github.io         
-- 
-- ################################################################################### --
-- 
-- WORLD: STYGIANCORE CUSTOM VENDORS
--
-- Adds multiple new vendors with custom inventory for use with StygianCore.
-- 
-- Note: These vendors are placed by importing world_npc_spawn.sql.
--
-- 2021.04.07:
--			Update to latest AC database by Anhedonie
-- ################################################################################### --

-- --------------------------------------------------------------------------------------
-- Deck the halls with boughs of holly.. fa la la la la, la la la la!
-- --------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------
--		ID RANGE	 	TYPE
-- --------------------------------------------------------------------------------------
-- 6010XX - 6019XX 	- 	NPC
-- 7010XX - 7019XX 	- 	ITEM
-- 8010XX - 8019XX 	- 	QUEST
-- 9010XX - 9019XX 	- 	LOOT/INFO
-- 6015XX - 6019XX	- 	GOSSIP MENU 
-- 60113X - 60114X  -   TRINITY STRING, NPC TEXT
--  605XX -  609XX	- 	NPC TEXT

-- --------------------------------------------------------------------------------------
--  NPC INDEX
--  See the world_npc_spawn.sql for predefined spawn points)
-- --------------------------------------------------------------------------------------
-- 	ID		Type				LOCATION
-- --------------------------------------------------------------------------------------
-- 601000 - Exotic Pets 
-- 601001 - Pets		
-- 601002 - Food		
-- 601003 - Armor		
-- 601004 - Potions		
-- 601006 - Artifacts	
-- 601007 - Books		
-- 601008 - Holiday		
-- 601009 - Tools		
-- 601010 - Clothing	
-- 601011 - Bags		
-- 601012 - Fireworks	
-- 601013 - Transmogrifier
-- 601014 - All Mounts
-- 601015 - Enchanter
-- 601016 - Buffer
-- 601017 - 
-- 601018 - Gift Box Sender
-- 601019 - Portal Master
-- 601020 - Gambler
-- 601021 - Codebox
-- 601022 - Locksmith	
-- 601023 - Engineer	
-- 601024 - Specialty	
-- 601025 - Tabards		
-- 601026 - Beastmaster
-- 601028 - Legendary	
-- 601029 - Elixer/Flask
-- 601030 - Cow
-- 601031 - Pig
-- 601032 - Exotic Mounts
-- 601033 - Mounts
-- 601034 - Banker		
-- 601035 - GM Island Decorator
-- 601036 - Bengal Tiger Handler
*/ 



-- --------------------------------------------------------------------------------------
--	EXOTIC PET VENDOR - 601000
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601000,
@Model 		:= 23812, -- Male Lumberjack
@Name 		:= "Grizzly Adams",
@Title 		:= "Exotic Pets",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 2714, 0, 0, 18019); -- Lantern, None

-- NPC ITEMS
DELETE FROM `npc_vendor` WHERE `entry` = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,8494), -- Parrot Cage Hyacinth Macaw
(@Entry,10822), -- Dark Whelpling
(@Entry,8498), -- Tiny Emerald Whelpling
(@Entry,8499), -- Tiny Crimson Whelpling
(@Entry,34535), -- Azure Whelpling
(@Entry,49362), -- Onyxian Whelpling
(@Entry,10398), -- Mechanical Chicken
(@Entry,11023), -- Ancona Chicken
(@Entry,11110), -- Chicken Egg
(@Entry,11474), -- Sprite Darter Egg
(@Entry,11825), -- Pet Bombling
(@Entry,11826), -- Lil' Smoky
(@Entry,11903), -- Cat Carrier Corrupted Kitten
(@Entry,12264), -- Worg Carrier
(@Entry,12529), -- Smolderweb Carrier
(@Entry,13582), -- Zergling Leash
(@Entry,13583), -- Panda Collar
(@Entry,13584), -- Diablo Stone
(@Entry,15996), -- Lifelike Mechanical Toad
(@Entry,18964), -- Turtle Egg Loggerhead
(@Entry,19054), -- Red Dragon Orb
(@Entry,19055), -- Green Dragon Orb
-- (@Entry,19450), -- A Jubling's Tiny Home
(@Entry,19462), -- Unhatched Jubling Egg
(@Entry,20371), -- Blue Murloc Egg
(@Entry,20651), -- Orange Murloc Egg
(@Entry,20769), -- Disgusting Oozeling
(@Entry,21168), -- Baby Shark
(@Entry,21277), -- Tranquil Mechanical Yeti
(@Entry,21301), -- Green Helper Box
(@Entry,21305), -- Red Helper Box
(@Entry,21308), -- Jingling Bell
(@Entry,21309), -- Snowman Kit
(@Entry,22114), -- Pink Murloc Egg
-- (@Entry,22200), -- Silver Shafted Arrow
(@Entry,22235), -- Truesilver Shafted Arrow
(@Entry,22780), -- White Murloc Egg
(@Entry,22781), -- Polar Bear Collar
(@Entry,23002), -- Turtle Box
(@Entry,23007), -- Piglet's Collar
(@Entry,23015), -- Rat Cage
(@Entry,23083), -- Captured Flame
(@Entry,23712), -- White Tiger Cub
(@Entry,23713), -- Hippogryph Hatchling
(@Entry,25535), -- Netherwhelp's Collar
(@Entry,27445), -- Magical Crawdad Box
(@Entry,29363), -- Mana Wyrmling
(@Entry,29953), -- Golden Dragonhawk Hatchling
(@Entry,29956), -- Red Dragonhawk Hatchling
(@Entry,29957), -- Silver Dragonhawk Hatchling
(@Entry,29958), -- Blue Dragonhawk Hatchling
(@Entry,29960), -- Captured Firefly
(@Entry,30360), -- Lurky's Egg
(@Entry,31760), -- Miniwing
(@Entry,32233), -- Wolpertinger's Tankard
-- (@Entry,32465), -- Fortune Coin
(@Entry,32498), -- Fortune Coin
(@Entry,32588), -- Banana Charm
(@Entry,32616), -- Egbert's Egg
(@Entry,32617), -- Sleepy Willy
(@Entry,32622), -- Elekk Training Collar
(@Entry,33154), -- Sinister Squashling
(@Entry,33816), -- Toothy's Bucket
(@Entry,33818), -- Muckbreath's Bucket
(@Entry,33993), -- Mojo
(@Entry,34425), -- Clockwork Rocket Bot
(@Entry,34478), -- Tiny Sporebat
(@Entry,34492), -- Rocket Chicken
(@Entry,34493), -- Dragon Kite
(@Entry,34518), -- Golden Pig Coin
(@Entry,34519), -- Silver Pig Coin
(@Entry,34955), -- Scorched Stone
(@Entry,46396), -- Wolvar Orphan Whistle
(@Entry,46397), -- Oracle Orphan Whistle
(@Entry,35349), -- Snarly's Bucket
(@Entry,35350), -- Chuck's Bucket
(@Entry,35504), -- Phoenix Hatchling
(@Entry,37297), -- Gold Medallion
(@Entry,37298), -- Competitor's Souvenir
(@Entry,38050), -- Soul-Trader Beacon
(@Entry,38628), -- Nether Ray Fry
(@Entry,38658), -- Vampiric Batling
(@Entry,39148), -- Baby Coralshell Turtle
(@Entry,39286), -- Frosty's Collar
(@Entry,39656), -- Tyrael's Hilt
(@Entry,39973), -- Ghostly Skull
(@Entry,40653), -- Reeking Pet Carrier
(@Entry,41133), -- Unhatched Mr. Chilly
(@Entry,43517), -- Penguin Egg
(@Entry,43698), -- Giant Sewer Rat
(@Entry,44721), -- Proto-Drake Whelp
(@Entry,44723), -- Nurtured Penguin Egg
(@Entry,44738), -- Kirin Tor Familiar
(@Entry,44794), -- Spring Rabbit's Foot
(@Entry,44810), -- Turkey Cage
(@Entry,44819), -- Baby Blizzard Bear
(@Entry,44822), -- Albino Snake
(@Entry,44841), -- Little Fawn's Salt Lick
(@Entry,44965), -- Teldrassil Sproutling
(@Entry,44970), -- Dun Morogh Cub
(@Entry,44971), -- Tirisfal Batling
(@Entry,44972), -- Alarming Clockbot NOT IN USE
(@Entry,44973), -- Durotar Scorpion
(@Entry,44974), -- Elwynn Lamb
(@Entry,44980), -- Mulgore Hatchling
(@Entry,44982), -- Enchanted Broom
(@Entry,44983), -- Strand Crawler
(@Entry,44984), -- Ammen Vale Lashling
(@Entry,44998), -- Argent Squire
(@Entry,45002), -- Mechanopeep
(@Entry,45022), -- Argent Gruntling
-- (@Entry,45180), -- Murkimus' Little Spear
(@Entry,45606), -- Sen'jin Fetish
(@Entry,45942), -- XS-001 Constructor Bot
(@Entry,46544), -- Curious Wolvar Pup
(@Entry,46545), -- Curious Oracle Hatchling
(@Entry,46707), -- Pint-Sized Pink Pachyderm
(@Entry,46767), -- Warbot Ignition Key
(@Entry,46802), -- Heavy Murloc Egg
(@Entry,46820), -- Shimmering Wyrmling
-- (@Entry,46821), -- Shimmering Wyrmling
-- (@Entry,46831), -- Macabre Marionette
(@Entry,48112), -- Darting Hatchling
(@Entry,48114), -- Deviate Hatchling
(@Entry,48116), -- Gundrak Hatchling
(@Entry,48118), -- Leaping Hatchling
(@Entry,48120), -- Obsidian Hatchling
(@Entry,48122), -- Ravasaur Hatchling
(@Entry,48124), -- Razormaw Hatchling
(@Entry,48126), -- Razzashi Hatchling
(@Entry,48527), -- Enchanted Onyx
(@Entry,49287), -- Tuskarr Kite
(@Entry,46892), -- Murkimus' Tiny Spear
(@Entry,49343), -- Spectral Tiger Cub
(@Entry,49646), -- Core Hound Pup
(@Entry,49662), -- Gryphon Hatchling
(@Entry,49663), -- Wind Rider Cub
(@Entry,49665), -- Pandaren Monk
(@Entry,49693), -- Lil' Phylactery
(@Entry,49912), -- Perky Pug
(@Entry,50446), -- Toxic Wasteling
(@Entry,53641), -- Ice Chip
(@Entry,54436), -- Blue Clockwork Rocket Bot
(@Entry,54810), -- Celestial Dragon
(@Entry,54847), -- Lil' XT
-- (@Entry,54857), -- Murkimus' Little Spear
(@Entry,56806); -- Mini Thor

-- --------------------------------------------------------------------------------------
--	PET VENDOR - 601001
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601001,
@Model 		:= 23814, -- Female Lumberjack
@Name 		:= "Petra O\'Shea",
@Title 		:= "Pets & Supplies",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 2714, 0, 0, 18019); -- Lantern, None

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,8485), -- Cat Carrier Bombay
(@Entry,8486), -- Cat Carrier Cornish Rex
(@Entry,8487), -- Cat Carrier Orange Tabby
(@Entry,8488), -- Cat Carrier Silver Tabby
(@Entry,8489), -- Cat Carrier White Kitten
(@Entry,8490), -- Cat Carrier Siamese
(@Entry,8491), -- Cat Carrier Black Tabby
(@Entry,46398), -- Calico Cat
(@Entry,8492), -- Parrot Cage Green Wing Macaw
(@Entry,8495), -- Parrot Cage Senegal
(@Entry,8496), -- Parrot Cage Cockatiel
(@Entry,8497), -- Rabbit Crate Snowshoe
(@Entry,8500), -- Great Horned Owl
(@Entry,8501), -- Hawk Owl
(@Entry,10360), -- Black Kingsnake
(@Entry,10361), -- Brown Snake
(@Entry,10392), -- Crimson Snake
(@Entry,39898), -- Cobra Hatchling
(@Entry,10393), -- Cockroach
(@Entry,10394), -- Prairie Dog Whistle
(@Entry,11026), -- Tree Frog Box
(@Entry,11027), -- Wood Frog Box
(@Entry,29364), -- Brown Rabbit Crate
(@Entry,29901), -- Blue Moth Egg
(@Entry,29902), -- Red Moth Egg
(@Entry,29903), -- Yellow Moth Egg
(@Entry,29904), -- White Moth Egg
(@Entry,39896), -- Tickbird Hatchling
(@Entry,39899), -- White Tickbird Hatchling
(@Entry,4401), -- Mechanical Squirrel Box
(@Entry,44820),	-- Red Ribbon Pet Leash
(@Entry,37460), -- Rope Pet Leash
(@Entry,43626),	-- Happy Pet Snack
(@Entry,35223),	-- Papa Hummel's Old Fashioned Pet Buscuit
(@Entry,47541), -- Argent Pony Bridle
(@Entry,37431), -- Fetch Ball
(@Entry,43004), -- Critter Bites
(@Entry,43352);	-- Pet Grooming Kit

-- --------------------------------------------------------------------------------------
--	FOOD VENDOR - 601002
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601002,
@Model 		:= 16302, -- Orc Cook
@Name 		:= "Chef Gruul",
@Title 		:= "Exotic Foods",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 2827, 3351, 0, 18019); -- Meat Cleaver, Rolling Pin

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES
(@Entry, 21023),	-- Dirge's Kickin' Chimaerok Chops
(@Entry, 21024),	-- Chimaerok Tenderloin
(@Entry, 34753),	-- Great Feast
(@Entry, 6358),		-- Oily Blackmouth	
(@Entry, 6522),		-- Deviate Fish	
(@Entry, 43015),	-- Fish Feast	
(@Entry, 43478),	-- Giant Feast
(@Entry, 46887),	-- Bountiful Feast
(@Entry, 43086),
(@Entry, 45932),
(@Entry, 45279),
(@Entry, 44049),
(@Entry, 44071),
(@Entry, 44072),
(@Entry, 44607),
(@Entry, 44722),
(@Entry, 44940),
(@Entry, 33444),
(@Entry, 34769),
(@Entry, 34768),
(@Entry, 35950),
(@Entry, 34764),
(@Entry, 34767),
(@Entry, 34765),
(@Entry, 35948),
(@Entry, 34766),
(@Entry, 35951),
(@Entry, 35947),
(@Entry, 35952),
(@Entry, 38706),
(@Entry, 38698),
(@Entry, 43490),
(@Entry, 41729),
(@Entry, 39520),
(@Entry, 40202),
(@Entry, 43491),
(@Entry, 43492),
(@Entry, 41731),
(@Entry, 42429),
(@Entry, 42778),
(@Entry, 42431),
(@Entry, 42779),
(@Entry, 42777),
(@Entry, 42942),
(@Entry, 42993),
(@Entry, 42994),
(@Entry, 42995),
(@Entry, 42998),
(@Entry, 42996),
(@Entry, 42997),
(@Entry, 43480),
(@Entry, 43488),
(@Entry, 43268),
(@Entry, 43236),
(@Entry, 42999),
(@Entry, 43000),
(@Entry, 43001),
(@Entry, 43005),
(@Entry, 43004),
(@Entry, 34748),
(@Entry, 33445),
(@Entry, 34749),
(@Entry, 34747),
(@Entry, 34751),
(@Entry, 34752),
(@Entry, 34750),
(@Entry, 34754),
(@Entry, 34755),
(@Entry, 34757),
(@Entry, 34756),
(@Entry, 34758),
(@Entry, 34762),
(@Entry, 34759),
(@Entry, 34760),
(@Entry, 44941),
(@Entry, 44953),
(@Entry, 34761),
(@Entry, 34763);

-- --------------------------------------------------------------------------------------
--	ARMOR VENDOR - 601003
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601003,
@Model 		:= 15845, -- Armored Dwarf
@Name 		:= "Dildorf Gaybane",
@Title 		:= "Rare Armor",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (@Entry, 1, 14824, 0, 0, 18019); -- War Axe, None

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,4726),	-- Chief Brigadier Cloak	
(@Entry,16803),	-- Felheart Slippers	
(@Entry,16804),	-- Felheart Bracers	
(@Entry,16805),	-- Felheart Gloves	
(@Entry,16806),	-- Felheart Belt	
(@Entry,16807),	-- Felheart Shoulder Pads	
(@Entry,16808),	-- Felheart Horns	
(@Entry,16809),	-- Felheart Robes	
(@Entry,16810),	-- Felheart Pants	
(@Entry,13077),	-- Girdle of Uther	
(@Entry,13130),	-- Windrunner Legguards
(@Entry,13399),	-- Gargoyle Shredder Talons
(@Entry,14116),	-- Aboriginal Cape
(@Entry,16836),	-- Cenarion Spaulders
(@Entry,16937),	-- Dragonstalker's Spaulders
(@Entry,17110),	-- Seal of the Archmagus
(@Entry,17909),	-- Frostwolf Insignia Rank 6
(@Entry,17082),	-- Shard of the Flame
(@Entry,18168),	-- Force Reactive Disk
(@Entry,18811),	-- Fireproof Cloak
(@Entry,18814),	-- Choker of the Fire Lord
(@Entry,18817),	-- Crown of Destruction
(@Entry,18835),	-- High Warlord's Recurve
(@Entry,18870),	-- Helm of the Lifegiver
(@Entry,19138),	-- Band of Sulfuras
(@Entry,19348),	-- Red Dragonscale Protector
(@Entry,19384),	-- Master Dragonslayer's Ring
(@Entry,19396),	-- Taut Dragonhide Belt
(@Entry,24259),	-- Vengeance Wrap
(@Entry,28529),	-- Royal Cloak of Arathi Kings
(@Entry,29776),	-- Core of Ar'kelos
(@Entry,35584),	-- Embroidered Gown of Zul'Drak
(@Entry,35591),	-- Shoulderguards of the Ice Troll
(@Entry,38287),	-- Empty Mug of Direbrew
(@Entry,41611),	-- Eternal Belt Buckle
(@Entry,44323),	-- Indestructible Alchemist Stone
(@Entry,46323),	-- Starshine Signet
(@Entry,49121),	-- Ring of Ghoulish Glee
(@Entry,50352),	-- Corpse Tongue Coin
(@Entry,47216),	-- The Black Heart
(@Entry,50356),	-- Corroded Skeleton Key
(@Entry,50363);	-- Deathbringer's Will

-- --------------------------------------------------------------------------------------
--	POTION VENDOR - 601004
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601004,
@Model 		:= 16182, -- Elven Wine Seller
@Name 		:= "Glenfiddich Macallan",
@Title 		:= "Potions",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (@Entry, 1, 13612, 0, 0, 18019);

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,8529),		-- NoggenFogger Elixer
(@Entry, 44958), 	-- Ethereal Oil
(@Entry, 43572), 	-- Magic Eater
(@Entry, 40195), 	-- Pygmy Oil
(@Entry, 35720), 	-- Lord of Frost's Private Label
(@Entry,21721),		-- Moonglow
(@Entry,12820),		-- Winterfall Firewater	
(@Entry,'118'),
(@Entry,'858'),
(@Entry,'929'),
(@Entry,'1710'),
(@Entry,'2455'),
(@Entry,'2456'),
(@Entry,'2459'),
(@Entry,'2633'),
(@Entry,'3087'),
(@Entry,'3384'),
(@Entry,'3385'),
(@Entry,'3386'),
(@Entry,'3387'),
(@Entry,'3823'),
(@Entry,'3827'),
(@Entry,'3928'),
(@Entry,'4596'),
(@Entry,'4623'),
(@Entry,'5631'),
(@Entry,'5632'),
(@Entry,'5633'),
(@Entry,'5634'),
(@Entry,'5816'),
(@Entry,'6048'),
(@Entry,'6049'),
(@Entry,'6050'),
(@Entry,'6051'),
(@Entry,'6052'),
(@Entry,'6149'),
(@Entry,'6372'),
(@Entry,'9030'),
(@Entry,'9036'),
(@Entry,'9144'),
(@Entry,'9172'),
(@Entry,'12190'),
(@Entry,'13442'),
(@Entry,'13443'),
(@Entry,'13444'),
(@Entry,'13446'),
(@Entry,'13455'),
(@Entry,'13456'),
(@Entry,'13457'),
(@Entry,'13458'),
(@Entry,'13459'),
(@Entry,'13460'),
(@Entry,'13461'),
(@Entry,'13462'),
(@Entry,'17348'),
(@Entry,'17349'),
(@Entry,'17351'),
(@Entry,'17352'),
(@Entry,'18253'),
(@Entry,'18839'),
(@Entry,'18841'),
(@Entry,'20002'),
(@Entry,'20008'),
(@Entry,'22826'),
(@Entry,'22828'),
(@Entry,'22829'),
(@Entry,'22832'),
(@Entry,'22836'),
(@Entry,'22837'),
(@Entry,'22838'),
(@Entry,'22839'),
(@Entry,'22841'),
(@Entry,'22842'),
(@Entry,'22844'),
(@Entry,'22845'),
(@Entry,'22846'),
(@Entry,'22847'),
(@Entry,'22849'),
(@Entry,'22850'),
(@Entry,'22871'),
(@Entry,'23578'),
(@Entry,'23579'),
(@Entry,'23822'),
(@Entry,'23823'),
(@Entry,'28100'),
(@Entry,'28101'),
(@Entry,'31676'),
(@Entry,'31677'),
(@Entry,'31838'),
-- (@Entry,'31839'),
-- (@Entry,'31840'),
-- (@Entry,'31841'),
-- (@Entry,'31852'),
-- (@Entry,'31853'),
-- (@Entry,'31854'),
-- (@Entry,'31855'),
(@Entry,'32762'),
(@Entry,'32763'),
-- (@Entry,'32783'),
-- (@Entry,'32784'),
(@Entry,'32840'),
(@Entry,'32844'),
(@Entry,'32845'),
(@Entry,'32846'),
(@Entry,'32847'),
-- (@Entry,'32902'),
-- (@Entry,'32903'),
-- (@Entry,'32904'),
-- (@Entry,'32905'),
-- (@Entry,'32909'),
-- (@Entry,'32910'),
(@Entry,'32947'),
(@Entry,'32948'),
(@Entry,'33092'),
(@Entry,'33093'),
(@Entry,'33447'),
(@Entry,'33448'),
(@Entry,'33934'),
(@Entry,'33935'),
(@Entry,'34440'),
-- (@Entry,'36770'),
(@Entry,'38351'),
(@Entry,'39327'),
(@Entry,'39671'),
(@Entry,'40067'),
(@Entry,'40077'),
(@Entry,'40081'),
(@Entry,'40087'),
(@Entry,'40093'),
(@Entry,'40211'),
(@Entry,'40212'),
(@Entry,'40213'),
(@Entry,'40214'),
(@Entry,'40215'),
(@Entry,'40216'),
(@Entry,'40217'),
(@Entry,'41166'),
(@Entry,'42545'),
-- (@Entry,'43530'),
-- (@Entry,'43531'),
(@Entry,'43569'),
(@Entry,'43570'),
(@Entry,'44728'),
(@Entry,'45276'),
(@Entry,'45277');

-- --------------------------------------------------------------------------------------
--	FISHING VENDOR - 601005
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601005,
@Model 		:= 3285, -- Fishing Trainer
@Name 		:= "John the Fisherman",
@Title 		:= "Pro Angler",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (@Entry, 1, 45991, 34484, 0, 18019); -- Fishing Pole, Old Ironjaw

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
-- BOOKS
(@Entry,27532),	-- Book: Master Fishing
(@Entry,16082),	-- Book: Artisan Fishing 
(@Entry,16083),	-- Book: Expert Fishing 
-- ENCHANTS
(@Entry,50816),	-- Scroll Enchant Gloves: Angler 
(@Entry,50406),	-- Formula Enchant Gloves: Angler
(@Entry,38802),	-- Enchant Gloves Fishing
-- POTIONS
(@Entry,6372), 	-- Swim Speed Potion
(@Entry,5996), 	-- Elixer of Water Breathing
(@Entry,18294), -- Elixer of Greater Water Breathing
(@Entry,8827), 	-- Elixer of Water Walking
-- SPECIAL
(@Entry,19979),	-- Hook of the Master Angler 
(@Entry,33223),	-- Fishing Chair
-- VANITY
(@Entry,1827),	-- Meat Cleaver
(@Entry,2763), 	-- Fisherman's Knife
-- CLOTHING
(@Entry,7996),	-- Worn Fishing Hat 
(@Entry,19972),	-- Lucky Fishing Hat
(@Entry,3563), 	-- Seafarer's Pantaloons
(@Entry,7052), 	-- Azure Silk Belt
(@Entry, 50287),-- Boots of the Bay
(@Entry,19969),	-- Nat Pagle's Extreme Anglin' Boots 
(@Entry,6263), 	-- Blue Overalls
(@Entry,3342), 	-- Captain Sander's Shirt
(@Entry,4509), 	-- Seawolf Gloves
(@Entry,792), 	-- Knitted Sandals
(@Entry,33820),	-- Weather Beaten Fishing Hat 
(@Entry, 7348), -- Fletcher's Gloves
(@Entry, 36019), -- Aerie Belt of Nature Protection
-- POLES
(@Entry,19970),	-- Arcanite Fishing Pole 
(@Entry,44050),	-- Mastercraft Kaluak Fishing Pole 
(@Entry,45992),	-- Jeweled Fishing Pole 
(@Entry,25978),	-- Seth's Graphite Fishing Pole 
(@Entry,19022),	-- Nat Pagle's Extreme Angler FC-5000
(@Entry,45991),	-- Bone Fishing Pole 
(@Entry,45858),	-- Nat's Lucky Fishing Pole 
(@Entry,12225),	-- Blump Family Fishing Pole
(@Entry,6367),	-- Big Iron Fishing Pole
(@Entry,6365),	-- Strong Fishing Pole
(@Entry,6366),	-- Darkwood Fishing Pole
(@Entry,6256),	-- Fishing Pole 
-- LINE
(@Entry,34836),	-- Trusilver Spun Fishing Line 
(@Entry,19971),	-- High Test Eternium Fishing Line 
-- LURES
(@Entry,34861), -- Sharpened Fishing Hook
(@Entry,46006), -- Glow Worm
(@Entry,6811), 	-- Aquadynamic Fish Lens
(@Entry,7307), 	-- Flesh Eating Worm
(@Entry,6533), 	-- Aquadynamic Fish Attractor
(@Entry,6532), 	-- Bright Baubles
(@Entry,6530), 	-- Nightcrawlers
(@Entry,6529), 	-- Shiny Bauble
-- ANGLIN'
(@Entry,34832), -- Captain Rumsey's Lager
(@Entry,18229);	-- Nat Pagle's Guide to Extreme Anglin' 

-- --------------------------------------------------------------------------------------
-- CLEAN UP FISHERMAN WAYPOINTS
-- --------------------------------------------------------------------------------------
DELETE FROM `creature_addon` WHERE `guid`=1994210;
DELETE FROM `acore_string` WHERE entry >= 2000006050 AND entry <= 2000006052;
DELETE FROM `waypoint_scripts` WHERE guid >= 938 AND guid <= 941;
DELETE FROM `creature` WHERE guid >= 1995303 AND guid <= 1995315;
DELETE FROM `waypoint_data` WHERE id = 1994210 AND point <= 13;

-- --------------------------------------------------------------------------------------
-- FISHERMAN CREATURE ADDON
-- --------------------------------------------------------------------------------------
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES (1994210, 1994210, 0, 0, 0, 0, 0, NULL);

-- --------------------------------------------------------------------------------------
-- FISHERMAN WAYPOINT STRINGS
-- --------------------------------------------------------------------------------------
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) 
VALUES 
(2000006050, 'Ahh.. the sea. Once it casts its spell, it holds one in its net of wonder forever.', NULL, NULL, 'Ahh.. die See. Hat sie einen einmal im Netz, lässt sie einen nie wieder los.', NULL, NULL, NULL, NULL, NULL),
(2000006051, 'Many men go fishing all of their lives without knowing that it is not fish they are after.', NULL, NULL, 'Viele Männer fischen ihr Leben lang - ohne zu wissen, dass es nicht der Fisch ist, hinter dem sie her sind.', NULL, NULL, NULL, NULL, NULL),
(2000006052, 'I wonder if they ever found that hidden treasure buried on the Isle of Dread?', NULL, NULL, 'Ich wundere mich, ob sie jemals diesen versteckten Schatz auf der Insel des Schreckens gefunden haben?', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------------------------------------
-- FISHERMAN WAYPOINT SCRIPTS
-- --------------------------------------------------------------------------------------
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) 
VALUES 
(938, 0, 0, 0, 0, 2000006050, 0, 0, 0, 0, 938), -- Say
(939, 0, 0, 0, 0, 2000006051, 0, 0, 0, 0, 939), -- Say
(940, 0, 0, 0, 0, 2000006052, 0, 0, 0, 0, 940), -- Say
(941, 0, 31, 601005, 0, 0, 0, 0, 0, 0, 941);	-- Equip

-- --------------------------------------------------------------------------------------
-- FISHERMAN WAYPOINT GUID
-- --------------------------------------------------------------------------------------
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) 
VALUES 
(1995315, 1, 1, 1, 1, 0, 0, -10749, 2517.63, 1.60554, 1.43331, 300, 0, 0, 41, 0, 0, 0, 33554432, 0),
(1995314, 1, 1, 1, 1, 0, 0, -10700.2, 2523.61, 0.792882, 1.43331, 300, 0, 0, 41, 0, 0, 0, 33554432, 0),
(1995313, 1, 1, 1, 1, 0, 0, -10702.7, 2521.03, 2.26718, 1.43331, 300, 0, 0, 2, 0, 0, 0, 33554432, 0),
(1995312, 1, 1, 1, 1, 0, 0, -10732.6, 2518.96, 1.79036, 1.43331, 300, 0, 0, 24, 0, 0, 0, 33554432, 0),
(1995311, 1, 1, 1, 1, 0, 0, -10745.8, 2511.96, 3.60894, 1.43331, 300, 0, 0, 42, 0, 0, 0, 33554432, 0),
(1995310, 1, 1, 1, 1, 0, 0, -10760.3, 2513.04, 1.92615, 1.43331, 300, 0, 0, 5, 0, 0, 0, 33554432, 0),
(1995309, 1, 1, 1, 1, 0, 0, -10791.1, 2489.84, 1.98191, 1.43331, 300, 0, 0, 10, 0, 0, 0, 33554432, 0),
(1995308, 1, 1, 1, 1, 0, 0, -10807.8, 2461.83, 1.04805, 1.43331, 300, 0, 0, 6, 0, 0, 0, 33554432, 0),
(1995307, 1, 1, 1, 1, 0, 0, -10805.9, 2460.9, 2.03948, 1.43331, 300, 0, 0, 20, 0, 0, 0, 33554432, 0),
(1995306, 1, 1, 1, 1, 0, 0, -10791.4, 2490.54, 1.74961, 1.43331, 300, 0, 0, 15, 0, 0, 0, 33554432, 0),
(1995305, 1, 1, 1, 1, 0, 0, -10777.2, 2504.67, 0.528472, 1.43331, 300, 0, 0, 38, 0, 0, 0, 33554432, 0),
(1995304, 1, 1, 1, 1, 0, 0, -10776.3, 2503.56, 1.20431, 1.43331, 300, 0, 0, 4, 0, 0, 0, 33554432, 0),
(1995303, 1, 1, 1, 1, 0, 0, -10749.4, 2519.6, 0.203893, 1.43331, 300, 0, 0, 50, 0, 0, 0, 33554432, 0);

-- --------------------------------------------------------------------------------------
-- FISHERMAN WAYPOINT DATA
-- --------------------------------------------------------------------------------------
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) 
VALUES 

-- Start
(1994210, 1, -10749.4, 2519.6, 0.203893, 0, 30000, 0, 939, 33, 1995303),
(1994210, 2, -10776.3, 2503.56, 1.20431, 0, 0, 0, 0, 100, 1995304),
(1994210, 3, -10777.2, 2504.67, 0.528472, 0, 30000, 0, 0, 100, 1995305),

-- Headed to boats
(1994210, 4, -10791.4, 2490.54, 1.74961, 0, 0, 0, 940, 10, 1995306),
(1994210, 5, -10805.9, 2460.9, 2.03948, 0, 0, 0, 0, 100, 1995307),

-- At the boats, TODO: equip fishing pole (EVENT 941)
(1994210, 6, -10807.8, 2461.83, 1.04805, 0, 60000, 0, 941, 100, 1995308),
(1994210, 7, -10791.1, 2489.84, 1.98191, 0, 0, 0, 0, 100, 1995309),
(1994210, 8, -10760.3, 2513.04, 1.92615, 0, 0, 0, 0, 100, 1995310),
(1994210, 9, -10745.8, 2511.96, 3.60894, 0, 0, 0, 0, 100, 1995311),
(1994210, 10, -10732.6, 2518.96, 1.79036, 0, 0, 0, 0, 100, 1995312),
(1994210, 11, -10702.7, 2521.03, 2.26718, 0, 0, 0, 0, 100, 1995313),

-- Looking at sunset
(1994210, 12, -10700.2, 2523.61, 0.792882, 0, 60000, 0, 938, 33, 1995314),
(1994210, 13, -10749, 2517.63, 1.60554, 0, 0, 0, 0, 25, 1995315);

-- --------------------------------------------------------------------------------------
--	ARTIFACT VENDOR - 601006
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601006,
@Model 		:= 22340, -- Harrison Jones
@Name 		:= "Harrison Jones",
@Title 		:= "Artifacts",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (@Entry, 1, 1906, 0, 0, 18019); -- Torch, None

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,1973),	-- Orb of Deception	
(@Entry,2608),	-- Threshadon Ambergris	
(@Entry,4471),	-- Flint and Tinder	
(@Entry,4696),	-- Lapidis Tankard of Tidesippe	
(@Entry,5060),	-- Thieves' Tools	
(@Entry,5373),	-- Lucky Charm	
(@Entry,5429),	-- A Pretty Rock	
(@Entry,5433),	-- Rag Doll	
(@Entry,5530),	-- Blinding Powder
(@Entry,6297),	-- Old Skull	
(@Entry,8350),	-- The 1 Ring	
(@Entry,34837),	-- The 2 Ring 
(@Entry,45859), -- The 5 Ring	
(@Entry,9327),	-- Security DELTA Data Access Card	
(@Entry,11382),	-- Blood of the Mountain	
(@Entry,11420),	-- Elegant Writing Tool	
(@Entry,13047),	-- Twig of the World Tree	
(@Entry,9242),	-- Ancient Tablet	
(@Entry,18335),	-- Pristine Black Diamond
(@Entry,18665),	-- The Eye of Shadow
(@Entry,24231),	-- Coarse Snuff
(@Entry,29570),	-- A Gnome Effigy
(@Entry,29572),	-- Aboriginal Carvings
(@Entry,31945),	-- Shadow Circuit
(@Entry,39355),	-- Haute Club Membership Card
(@Entry,39356),	-- Mind-Soothing Bauble
(@Entry,40393),	-- Green Sparkly
(@Entry,39351),	-- Richly Appointed Pipe
(@Entry,44464),	-- Crude Eating Utensils
(@Entry,44678),	-- Wine Glass
(@Entry,34826),	-- Gold Wedding Band
(@Entry,45994),	-- Lost Ring 
(@Entry,45995), -- Lost Necklace 
(@Entry,9360),	-- Cuergo's Gold
(@Entry,11840),	-- Master Builder's Shirt
(@Entry,44430),	-- Titanium Seal of Dalaran
(@Entry,18401), -- Foror's Compendium of Dragonslaying
(@Entry,9423), -- The Jackhammer
(@Entry,9429), -- Miner's Hat of the Deep
(@Entry,9424), -- Ginn-su sword
(@Entry,9465), -- Digmaster 5000
(@Entry,9427), -- Stonevault Bonebreaker
(@Entry,19865), -- Warblade of Hakkari
(@Entry,19866), -- Warblade of Hakkari
(@Entry,38802), -- Enchant Gloves Fishing
(@Entry,1168), -- Skullflame Shield
(@Entry,19854), -- Zin'rokh, Destroyer of Worlds
(@Entry,4446), -- Blackvenom Blade
(@Entry,35664), -- Unknown Archeologist's Hammer
(@Entry,8226), -- The Butcher
(@Entry,12608), -- Butcher's Apron
(@Entry,23540), -- Felsteel Longblade
(@Entry,1728), -- Teebu's Blazing Longsword
(@Entry,17782), -- Talisman of Binding Shard
(@Entry,14551), -- Edgemaster Handguards
(@Entry,1604), -- Chromatic Sword
(@Entry,18755), -- Xorthian Firestick
(@Entry,9491), -- Hotshot Pilot Gloves
(@Entry,9425), -- Pendulum of Doom
(@Entry,8029), -- Plans: Wicked Mithril Blade
(@Entry,4354), -- Plans: Rich Purple Silk Shirt

-- (@Entry,45087),	-- Runed Orb
-- (@Entry,45506),	-- Archivum Data Disc
-- (@Entry,43321),	-- Crystallized Tear
-- (@Entry,43329),	-- Pigtail Holder
-- (@Entry,34057),	-- Abyss Crystal
-- (@Entry,37604),	-- Tooth Pick
-- (@Entry,27978),	-- Soap on a Rope
-- (@Entry,27979),	-- Stone of Stupendous Springing Strides
-- (@Entry,19974),	-- Mudskunk Lure
-- (@Entry,21536),	-- Elune Stone
-- (@Entry,21829),	-- Perfume Bottle
-- (@Entry,21833),	-- Cologne Bottle
-- (@Entry,11325),	-- Dark Iron Ale Mug	

(@Entry,46359);	-- Velociraptor Skull

-- --------------------------------------------------------------------------------------
--	BOOK VENDOR - 601007
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601007,
@Model 		:= 3071, -- Dwarf Female
@Name 		:= "Corma McCarthy",
@Title 		:= "Books",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,11108),	-- Faded Photograph	
(@Entry,701003), -- Azerothian Humor Vol. 1
(@Entry,11482),	-- Crystal Pylon User's Manual
(@Entry,18228),	-- Autographed Picture of Foror & Tigule
(@Entry,18229),	-- Nat Pagle's Guide to Extreme Anglin'
(@Entry,18364),	-- The Emerald Dream
(@Entry,18365),	-- A Thoroughly Read Copy of \"Nat Pagle's Guide to Extreme Anglin'.\"
(@Entry,19483),	-- Peeling the Onion
(@Entry,19484),	-- The Frostwolf Artichoke
(@Entry,19851),	-- Grom's Tribute
(@Entry,20010),	-- The Horde's Hellscream
(@Entry,20677),	-- Decoded Twilight Text
(@Entry,29571),	-- A Steamy Romance Novel
(@Entry,37467), -- A Steamy Romance Novel, Forbidden Love
(@Entry,46023), -- A Steamy Romance Novel, Northern Exposure
(@Entry,54291), -- A Steamy Romance Novel, Blue Moon
(@Entry,39358),	-- Give to the Church and the Light Will Provide
(@Entry,39317),	-- News From The North

-- (@Entry,32620),	-- Time-Lost Scroll
-- (@Entry,36877),	-- Folded Letter

(@Entry,39361);	-- Turning the Other Cheek

-- --------------------------------------------------------------------------------------
--	HOLIDAY VENDOR - 601008
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601008,
@Model 		:= 10815, -- Red Imp
@Name 		:= "Krampus the Grinch",
@Title 		:= "Holiday Supplies",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Type 		:= 7,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,20397),	-- Hallowed Wand: Pirate
(@Entry,20398),	-- Hallowed Wand: Ninja
(@Entry,20399),	-- Hallowed Wand: Leper Gnome
(@Entry,20409),	-- Hallowed Wand: Ghost
(@Entry,20410),	-- Hallowed Wand: Bat
(@Entry,20411),	-- Hallowed Wand: Skeleton
(@Entry,20413),	-- Hallowed Wand: Random
(@Entry,20414),	-- Hallowed Wand: Wisp
(@Entry,29575),	-- A Jack-o'-Lantern
(@Entry,34068),	-- Weighted Jack-o'-Lantern
(@Entry,37895),	-- Filled Green Brewfest Stein
(@Entry,33019),	-- Filled Blue Brewfest Stein
(@Entry,44803),	-- Spring Circlet
(@Entry,3419),	-- Red Rose	
(@Entry,34480),	-- Romantic Picnic Basket
(@Entry,21154),	-- Festival Dress
(@Entry,17712),	-- Winter Veil Disguise Kit
(@Entry,21213),	-- Preserved Holly
(@Entry,35557),	-- Huge Snowball
(@Entry,17202),	-- Snowball
(@Entry,21524),	-- Red Winter Hat
(@Entry,21542),	-- Festival Suit
(@Entry,34085),	-- Red Winter Clothes
(@Entry,34086),	-- Winter Boots
(@Entry,34087),	-- Green Winter Clothes
(@Entry,34850),	-- Midsummer Ground Flower
(@Entry,23323),	-- Crown of the Fire Festival
(@Entry,23324),	-- Mantle of the Fire Festival
(@Entry,34683),	-- Sandals of Summer
(@Entry,34685),	-- Vestment of Summer
(@Entry,35280),	-- Tabard of Summer Flames
(@Entry,35279),	-- Tabard of Summer Skies
(@Entry,34686),	-- Brazier of Dancing Flames
(@Entry,42438),	-- Lovely Cake
(@Entry,42436); -- Chocolate Celebration Cake

-- --------------------------------------------------------------------------------------
--	TOOL VENDOR - 601009
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601009,
@Model 		:= 22270, -- Human Merchant
@Name 		:= "DeWalt Stihl",
@Title 		:= "Tools",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,5507),	-- Ornate Spyglass
(@Entry,40772),	-- Gnomish Army Knife
(@Entry,45631),	-- High-Powered Flashlight

-- (@Entry,46709);	-- MiniZep Controller
-- (@Entry,34498),	-- Paper Zeppelin Kit

(@Entry,38089),	-- Ruby Shades
(@Entry,4384),	-- Explosive Sheep	
(@Entry,35227); -- Goblin Weather Machine Prototype 01-B

-- --------------------------------------------------------------------------------------
--	CLOTHING VENDOR - 601010
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601010,
@Model 		:= 16695, -- Elven Banker
@Name 		:= "Prada Armani",
@Title 		:= "Clothing",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,154),	-- Primitive Mantle	
(@Entry,2955),	-- First Mate Hat	
(@Entry,3322),	-- Wispy Cloak		
(@Entry,3342),	-- Captain Sanders' Shirt	
(@Entry,4334),	-- Formal White Shirt	
(@Entry,6125),	-- Brawler's Harness	
(@Entry,6139),	-- Novice's Robe
(@Entry,6263),	-- Blue Overalls	
(@Entry,6555),	-- Bard's Cloak
(@Entry,3427),	-- Stylish Black Shirt	
(@Entry,7348),	-- Fletcher's Gloves	
(@Entry,6796),	-- Red Swashbuckler's Shirt	
(@Entry,6833),	-- White Tuxedo Shirt	
(@Entry,6835),	-- Black Tuxedo Pants
(@Entry,10034),	-- Tuxedo Shirt	
(@Entry,10035),	-- Tuxedo Pants	
(@Entry,10036),	-- Tuxedo Jacket		
(@Entry,18231),	-- Sleeveless T-Shirt
(@Entry,19028),	-- Elegant Dress
(@Entry,22276),	-- Lovely Red Dress
(@Entry,22278),	-- Lovely Blue Dress
(@Entry,22279),	-- Lovely Black Dress
(@Entry,22280),	-- Lovely Purple Dress
(@Entry,10053),	-- Simple Black Dress
(@Entry,22282),	-- Purple Dinner Suit
(@Entry,33820),	-- Weather-Beaten Fishing Hat
(@Entry,38277),	-- Haliscan Jacket
(@Entry,41250),	-- Green Lumberjack Shirt
(@Entry,38),
(@Entry,45),
(@Entry,49),
(@Entry,53),
(@Entry,127),
(@Entry,148),
(@Entry,859),
(@Entry,20901),
(@Entry,2105),
(@Entry,2575),
(@Entry,2576),
(@Entry,2577),
(@Entry,2579),
(@Entry,2587),
(@Entry,3426),
(@Entry,3428),
(@Entry,4330),
(@Entry,4332),
(@Entry,4333),
(@Entry,4335),
(@Entry,4336),
(@Entry,4344),
(@Entry,5107),
(@Entry,6096),
(@Entry,6097),
(@Entry,6117),
(@Entry,6120),
(@Entry,6134),
(@Entry,6136),
(@Entry,6384),
(@Entry,6385),
(@Entry,6795),
(@Entry,10052),
(@Entry,10054),
(@Entry,10055),
(@Entry,10056),
(@Entry,11840),
(@Entry,14617),
(@Entry,16059),
(@Entry,16060),
(@Entry,17723),
(@Entry,20897),
(@Entry,23345),
(@Entry,23473),
(@Entry,23476),
(@Entry,24143),
(@Entry,41248),
(@Entry,41249),
(@Entry,41251),
(@Entry,41252),
(@Entry,41253),
(@Entry,41254),
(@Entry,41255),
(@Entry,42360),
(@Entry,42361),
(@Entry,42363),
(@Entry,42365),
(@Entry,42368),
(@Entry,42369),
(@Entry,42370),
(@Entry,42371),
(@Entry,42372),
(@Entry,42373),
(@Entry,42374),
(@Entry,42375),
(@Entry,42376),
(@Entry,42377),
(@Entry,42378),
(@Entry,44693),
(@Entry,44694),
(@Entry,45280),
(@Entry,45664),
(@Entry,45666),
(@Entry,45667),
(@Entry,45668),
(@Entry,45669),
(@Entry,45670),
(@Entry,45671),
(@Entry,45672),
(@Entry,45673),
(@Entry,45674),
(@Entry,46104),
(@Entry,52019);


-- --------------------------------------------------------------------------------------
--	BAG VENDOR - 601011
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601011,
@Model 		:= 19156, -- Shattrath Thug
@Name 		:= "Slim Shady",
@Title 		:= "Bags",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,23162), 		-- Foror's Crate of Endless Resist Gear Storage (36-Slot Bag)
(@Entry,51809), 		-- Portable Hole (24-Slot Bag)
(@Entry,14156), 		-- Bottomless Bag
(@Entry,41600), 		-- Glacial Bag
(@Entry,37606);			-- Penny Pouch

-- --------------------------------------------------------------------------------------
--	FIREWORKS VENDOR - 601012
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601012,
@Model 		:= 7181, -- Goblin
@Name 		:= "Sparky Skyfire",
@Title 		:= "Fireworks",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35, 	-- 118(Undercity)
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIP
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (@Entry, 1, 2884, 0, 0, 18019); -- Dynamite Stick, None

-- NPC VENDOR ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,41427),	-- Dalaran Firework
(@Entry,34599),	-- Juggling Torch
(@Entry,23771),	-- Green Smoke Flare
(@Entry,23768),	-- White Smoke Flare
(@Entry,21747),	-- Festival Firecracker
(@Entry,21745),	-- Elder's Moonstone
(@Entry,21744),	-- Lucky Rocket Cluster
(@Entry,21713),	-- Elune's Candle
(@Entry,34850),	-- Midsummer Ground Flower
(@Entry,21576),	-- Red Rocket Cluster
(@Entry,21574),	-- Green Rocket Cluster
(@Entry,21571),	-- Blue Rocket Cluster
(@Entry,21570),	-- Cluster Launcher
(@Entry,19026),	-- Snake Burst Firework
(@Entry, 9318),	-- Red Firework	
(@Entry, 9315),	-- Yellow Rose Firework	
(@Entry, 9314),	-- Red Streaks Firework	
(@Entry, 9313),	-- Green Firework	
(@Entry, 9312),	-- Blue Firework	
(@Entry, 8626);	-- Blue Sparkler	

-- --------------------------------------------------------------------------------------
--	TRANSMOGRIFIER - 601013
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601013,
@Model 		:= 19646, -- Soul Trader
@Name 		:= "Tyrion Darksoul",
@Title 		:= "Illusionist",
@Icon 		:= "Interact",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 138936390,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
-- @Script 	:= "npc_transmogrifier";
-- Now Handled with Eluna
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- --------------------------------------------------------------------------------------
--	ALL MOUNTS VENDOR - 601014
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601014,
@Model 		:= 26571, -- The Black Knight
-- @Model 		:= 21249, -- Armored Orc
@Name 		:= "The Mountain",
@Title 		:= "Mount Trainer",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "All_Mounts_NPC";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, 'Hail $N. I can teach you to ride.. anything!');

-- --------------------------------------------------------------------------------------
--	ENCHANTER - 601015
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601015,
@Model 		:= 9353, -- Undead Necromancer
@Name 		:= "Beauregard Boneglitter",
@Title 		:= "Enchantments",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "npc_enchantment";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (@Entry, 1, 11343, 0, 0, 18019); -- Black/Purple Staff, None

-- NPC TEXT
DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, 'Good day $N. Beauregard Boneglitter at your service. I offer a vast array of gear enchantments for the aspiring adventurer.');

-- --------------------------------------------------------------------------------------
--	BUFFER - 601016
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601016,
-- Alliance Version
-- @Model 		:= 4309, -- Human Male Tuxedo
-- @Name 		:= "Bruce Buffer",
-- @Title 		:= "Ph.D.",
-- Horde Version
@Model 		:= 14612, -- Tauren Warmaster
@Name 		:= "Buffmaster Hasselhoof",
@Title 		:= "",
@Icon 		:= "Speak",
@GossipMenu := 4110,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 81,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "buff_npc";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 1906, 0, 0, 18019); -- War Axe(14824), Torch

-- --------------------------------------------------------------------------------------
--	GAMBLER - 601020
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601020,
@Model 		:= 7337, -- Goblin Banker
@Name 		:= "Skinny",
@Title 		:= "Gambler",
@Icon 		:= "LootAll",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "gamble_npc";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, 'Hey there, the name\'s Skinny. You feelin\' lucky?');

-- --------------------------------------------------------------------------------------
--	LOCKSMITH - 601022
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601022,
@Model 		:= 6837, -- Fancy Undead Male
@Name 		:= "Harlowe Coldfinger",
@Title 		:= "Locksmith",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35, 	-- 118(Undercity)
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIP
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 2714, 0, 0, 18019); -- Lantern, None

-- NPC VENDOR ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,5060), 	-- Thieves Tools
(@Entry,'5396'),
(@Entry,'6893'),
(@Entry,'7146'),
(@Entry,'11000'),
(@Entry,'11078'),
(@Entry,'12382'),
(@Entry,'15869'),
(@Entry,'15870'),
(@Entry,'15871'),
(@Entry,'15872'),
(@Entry,'18249'),
(@Entry,'18250'),
(@Entry,'18266'),
(@Entry,'18268'),
(@Entry,'21761'),
(@Entry,'21762'),
(@Entry,'24490'),
(@Entry,'27991'),
(@Entry,'28395'),
(@Entry,'30622'),
(@Entry,'30623'),
(@Entry,'30633'),
(@Entry,'30634'),
(@Entry,'30635'),
(@Entry,'30637'),
(@Entry,'31084'),
(@Entry,'31704'),
(@Entry,'32449'),
(@Entry,'42482'),
(@Entry,'43853'),
(@Entry,'43854'),
(@Entry,'44581'),
(@Entry,'44582'),
(@Entry,'45796'),
(@Entry,'45798');


-- --------------------------------------------------------------------------------------
--	ENGINEER VENDOR - 601023
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601023,
@Model 		:= 11690, -- Umaron Stragarelm (Everlook Goblin) 
@Name 		:= "Fizik Glowspark",
@Title 		:= "Contraptions",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC VENDOR ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,4394),	-- Big Iron Bomb	
(@Entry,10506),	-- Deepdive Helmet	
(@Entry,18984),	-- Dimensional Ripper Everlook
(@Entry,30542),	-- Dimensional Ripper Area 52
(@Entry,37863),	-- Direbrew's Remote
(@Entry,40768),	-- MOLL-E
(@Entry,48933),	-- Wormhole Generator: Northrend
-- (@Entry,49278), -- Goblin Rocket Pack
(@Entry,5507),	-- Ornate Spyglass
(@Entry,40772),	-- Gnomish Army Knife
(@Entry,45631),	-- High-Powered Flashlight
(@Entry,4384),	-- Explosive Sheep	
(@Entry,35227), -- Goblin Weather Machine Prototype 01-B
(@Entry,9492), 	-- Electromagnetic Gigaflux Reactivator
(@Entry,40727), -- Gnomish Gravity Well
(@Entry,49040);	-- Jeeves


-- --------------------------------------------------------------------------------------
--	SPECIALTY ITEMS - 601024
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601024,
@Model 		:= 18148, -- Haris Pilton
@Name 		:= "Andara Delaine",
@Title 		:= "Specialty Gifts",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIP
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 45861, 0, 0, 18019); -- Diamond-Tipped Cane, None

-- NPC VENDOR ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,7340), 		-- Flawless Diamond Solitaire
(@Entry,38089),		-- Ruby Shades
(@Entry,7337),		-- The Rock
(@Entry,34827),		-- Noble's Monocle
(@Entry,34828),		-- Antique Silver Cufflinks
(@Entry, 37934), 	-- Noble' Elementium Signet
(@Entry,4368),		-- Flying Tiger Goggles
(@Entry,32566),		-- Picnic Basket
(@Entry,41367),		-- Dark Jade Focusing Lens
(@Entry,42420),		-- Shadow Crystal Focusing Lens
(@Entry,42421),		-- Shadow Jade Focusing Lens
-- (@Entry,39351),		-- Richly Appointed Pipe
(@Entry,45861), 	-- Diamond-Tipped Cane
(@Entry, 18258), 	-- Gordok Ogre Suit
(@Entry, 44228), 	-- Baby Spice
-- (@Entry, 44958), 	-- Ethereal Oil
-- (@Entry, 13506), 	-- Potion of Petrification
-- (@Entry, 43572), 	-- Magic Eater
-- (@Entry, 40195), 	-- Pygmy Oil
(@Entry, 31337), 	-- Orb of the Blackwhelp
(@Entry, 35275), 	-- Orb of the Sindorei
(@Entry, 45853), 	-- Rituals of the New Moon
(@Entry, 32782), 	-- Time-Lost Figurine
(@Entry, 19979), 	-- Hook of the Master Angler
(@Entry, 5462), 	-- Dartol's Rod of Transformation
(@Entry, 4388), 	-- Discombobulator Ray
(@Entry, 52201),	-- Muradin's Favor
(@Entry, 37254), 	-- Super Simian Sphere
(@Entry, 49704), 	-- Carved Ogre Idol
(@Entry, 23835), 	-- Gnomish Poultryizer
(@Entry, 10716), 	-- Gnomish Shrink Ray
(@Entry, 44818), 	-- Noblegarden Egg
(@Entry, 5332), 	-- Glowing Cat Figurine
(@Entry, 10725), 	-- Gnomish Battle Chicken
(@Entry, 40110), 	-- Haunted Momento
(@Entry, 12185), 	-- Bloodsail Admiral's Hat
(@Entry, 40492), 	-- Argent War Horn
(@Entry, 14022), 	-- Barov Peasent Caller (H)
(@Entry, 14023), 	-- Barov Peasent Called (A)
(@Entry, 32864), 	-- Commander's Badge
(@Entry, 32695), 	-- Captain's Badge
(@Entry, 32694), 	-- Overseer's Badge
(@Entry, 3456), 	-- Dog Whistle
(@Entry, 38506), 	-- Don Carlo's Favorite Hat
(@Entry, 16022), 	-- Arcanite Dragonling
(@Entry, 4396), 	-- Mechanical Dragonling
(@Entry, 35694), 	-- Khorium Boar
(@Entry, 42418), 	-- Emerald Boar
(@Entry, 24124), 	-- Felsteel Boar
(@Entry, 50471), 	-- The Heartbreaker
(@Entry, 54212), 	-- Instant Statue Pedestal
(@Entry, 50966), 	-- Abracadaver
(@Entry, 5218), 	-- Cleansed Timberling Heart
(@Entry, 49490), 	-- Antilinuvian Cornerstone Grimiore
(@Entry, 49308), 	-- Ancient Cornerstone Grimiore
(@Entry, 34029), 	-- Tiny Voodoo Mask
(@Entry, 13353), 	-- Book of the Dead
(@Entry, 54438), 	-- Tiny Blue Ragdoll
(@Entry, 44849), 	-- Tiny Green Ragdoll
(@Entry, 34686), 	-- Brazier of Dancing Flames
(@Entry, 33927), 	-- Brewfest Pony Keg
(@Entry, 38578), 	-- Flag of Ownership
(@Entry, 44606), 	-- Tiny Train Set
(@Entry, 34480), 	-- Romantic Picnic Basket 
(@Entry, 44481), 	-- Grindgear Toy Gorilla
(@Entry, 45047), 	-- Sandbox Tiger
(@Entry, 46780), 	-- Ogre Pinata 
(@Entry, 45063), 	-- Foam Sword Rack
(@Entry, 38301), 	-- D.I.S.C.O.
(@Entry, 33223), 	-- Fishing Chair
(@Entry, 33219), 	-- Goblin Gumbo Kettle
(@Entry, 32542), 	-- Imp in a Ball
(@Entry, 21326), 	-- Defender of the Timbermaw
(@Entry, 38518), 	-- Cro's Apple 
-- (@Entry, 43491), 	-- Bad Clams
(@Entry, 25679), 	-- Comfortable Insoles
-- (@Entry, 43004), 	-- Critter Bites
(@Entry, 36863), 	-- Decahedral Dwarven Dice
(@Entry, 12217), 	-- Dragonbreath Chili
(@Entry, 43492), 	-- Haunted Herring
(@Entry, 44601), 	-- Heavy Copper Racer
(@Entry, 18662), 	-- Heavy Leather Ball
-- (@Entry, 43488), 	-- Last Week's Mammoth
(@Entry, 44792), 	-- Blossoming Branch
(@Entry, 38266), 	-- Rotund Relic
(@Entry, 17202), 	-- Snowball
(@Entry, 43490), 	-- Tasty Cupcake
(@Entry, 33081), 	-- Voodoo Skull
(@Entry, 36862), 	-- Worn Troll Dice
-- (@Entry, 52490), 	-- Stardust
(@Entry, 37604), 	-- Toothpick
(@Entry, 44731), 	-- Bouquet of Ebon Roses
(@Entry, 22206), 	-- Bouquet of Red Roses
(@Entry, 18660), 	-- World Enlarger
(@Entry, 18951), 	-- Evonice's Landin' Pilla
(@Entry, 37313), 	-- Riding Crop
(@Entry, 11122), 	-- Carrot on a Stick
(@Entry, 43660), 	-- Fire Eater's Guide
(@Entry, 13379), 	-- Piccolo of the Flaming Fire
(@Entry, 44482), 	-- Trusty Copper Racer
(@Entry, 50741), 	-- Vile Fumigator's Mask
(@Entry, 44599), 	-- Zippy Copper Racer
(@Entry, 54452), 	-- Etheral Portal
(@Entry, 46349), 	-- Chef's Hat
(@Entry, 38577), 	-- Party Grenade
(@Entry, 54455), 	-- Paint Bomb
(@Entry, 46779), 	-- Path of Cenarius
(@Entry, 38233), 	-- Path of Illidan
(@Entry, 34499), 	-- Paper Flying Machine
(@Entry, 54806), 	-- Frostscyth of Lord Ahune
-- (@Entry, 64482), -- Puzzle Box of Yogg Saron 
(@Entry,18640),		-- Happy Fun Rock
(@Entry, 52252), 	-- Tabard of the Lightbringer
(@Entry,46709),		-- MiniZep Controller
(@Entry,34498);		-- Paper Zeppelin Kit


-- --------------------------------------------------------------------------------------
--	TABARDS - 601025
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601025,
@Model 		:= 12675, -- Tauren Female with Tabard
@Name 		:= "Tanis Rayen",
@Title 		:= "Tabards",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC VENDOR ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,'5976'),
(@Entry,'11364'),
(@Entry,'15196'),
(@Entry,'15197'),
(@Entry,'15198'),
(@Entry,'15199'),
(@Entry,'19031'),
(@Entry,'19032'),
(@Entry,'19160'),
(@Entry,'19505'),
(@Entry,'19506'),
(@Entry,'20131'),
(@Entry,'20132'),
(@Entry,'22999'),
(@Entry,'23192'),
(@Entry,'23999'),
(@Entry,'24004'),
(@Entry,'24344'),
(@Entry,'25549'),
(@Entry,'28788'),
(@Entry,'31279'),
(@Entry,'31404'),
(@Entry,'31405'),
(@Entry,'31773'),
(@Entry,'31774'),
(@Entry,'31775'),
(@Entry,'31776'),
(@Entry,'31777'),
(@Entry,'31778'),
(@Entry,'31779'),
(@Entry,'31780'),
(@Entry,'31781'),
(@Entry,'31804'),
(@Entry,'32445'),
(@Entry,'32828'),
(@Entry,'35221'),
(@Entry,'35279'),
(@Entry,'35280'),
(@Entry,'36941'),
(@Entry,'40643'),
(@Entry,'43154'),
(@Entry,'43155'),
(@Entry,'43156'),
(@Entry,'43157'),
-- (@Entry,'43300'),
-- (@Entry,'43348'),
(@Entry,'43349'),
(@Entry,'45574'),
(@Entry,'45577'),
(@Entry,'45578'),
(@Entry,'45579'),
(@Entry,'45580'),
(@Entry,'45581'),
(@Entry,'45582'),
(@Entry,'45583'),
(@Entry,'45584'),
(@Entry,'45585'),
(@Entry,'45983'),
(@Entry,'46817'),
(@Entry,'46818'),
(@Entry,'46874'),
(@Entry,'49052'),
(@Entry,'49054'),
(@Entry,'49086'),
(@Entry,'51534'),
(@Entry,'52252');

-- --------------------------------------------------------------------------------------
--	BEASTMASTER - 601026
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601026,
@Model 		:= 729, -- Shadowfang Moonwalker (White Worgen)
@Name 		:= "White Fang",
@Title 		:= "BeastMaster",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 4194433,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "BeastMaster";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 2196, 1906, 0, 18019); -- Haunch of Meat, Torch

-- NPC TEXT
DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, 'Greetings $N. And when, on the still cold nights, he pointed his nose at a star and howled long and wolflike, it was his ancestors, dead and dust, pointing nose at star and howling down through the centuries and through him.');

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
-- MEAT
(@Entry,35953),	-- (75) -- Mead Blasted Caribou 
(@Entry,33454),	-- (65) -- Salted Venison 
(@Entry,27854),	-- (55) -- Smoked Talbuk Venison
(@Entry,8952),	-- (45) -- Roasted Quail 
(@Entry,4599),	-- (35) -- Cured Ham Steak  
(@Entry,3771),	-- (25) -- Wild Hog Shank 
(@Entry,3770),	-- (15) -- Mutton Chop
(@Entry,2287),	-- (5)  -- Haunch of Meat
(@Entry,117),	-- (1)  -- Tough Jerky
-- FUNGUS
(@Entry,35947),	-- (75) -- Sparkling Frostcap
(@Entry,33452),	-- (65) -- Honey-Spiced Lichen 
(@Entry,27859),	-- (55) -- Zangar Caps
(@Entry,8948),	-- (45) -- Dried King Bolete
(@Entry,4608),	-- (35) -- Raw Black Truffle 
(@Entry,4607),	-- (25) -- Delicious Cave Mold
(@Entry,4606),	-- (15) -- Spongy Morel
(@Entry,4605),	-- (5)  -- Red-Speckled Mushroom 
(@Entry,4604),	-- (1)  -- Forest Mushroom Cap
-- BREAD
(@Entry,35950),	-- (75) -- Sweet Potato Bread
(@Entry,33449),	-- (65) -- Crusty Flatbread
(@Entry,27855),	-- (55) -- Mag'har Grainbread
(@Entry,8950),	-- (45) -- Homemade Cherry Pie
(@Entry,4601),	-- (35) -- Soft Banana Bread
(@Entry,4544),	-- (25) -- Mulgore Spice Bread
(@Entry,4542),	-- (15) -- Moist Cornbread
(@Entry,4541),	-- (5)  -- Freshly Baked Bread
(@Entry,4540),	-- (1)  -- Tough Hunk of Bread
-- FRUIT
(@Entry,35948),	-- (75) -- Savory Snowplum
(@Entry,35949),	-- (65) -- Tundra Berries
(@Entry,27856),	-- (55) -- Sklethyl Berries
(@Entry,8953),	-- (45) -- Deep Fried Plantains
(@Entry,4602),	-- (35) -- Moon Harvest Pumpkin
(@Entry,4539),	-- (25) -- Goldenbark Apple
(@Entry,4538),	-- (15) -- Snapvine Watermelon
(@Entry,4537),	-- (5)  -- Tel'Abim Banana
(@Entry,4536),	-- (1)  -- Shiny Red Apple
-- FISH
(@Entry,35951),	-- (75) -- Poached Emperor Salmon
(@Entry,33451),	-- (65) -- Filet of Icefin
(@Entry,27858),	-- (55) -- Sunspring Carp
(@Entry,8957),	-- (45) -- Spinefin Halibut
(@Entry,21552),	-- (35) -- Striped Yellowtail
(@Entry,4594),	-- (25) -- Rockscale Cod
(@Entry,4593),	-- (15) -- Bristle Whisker Catfish
(@Entry,4592),	-- (5)  -- Longjaw Mud Snapper
(@Entry,787),	-- (1)  -- Slitherskin Mackeral
-- CHEESE
(@Entry,35952),	-- (75) -- Briny Hardcheese
(@Entry,33443),	-- (65) -- Sour Goat Cheese
(@Entry,27857),	-- (55) -- Gradar Sharp
(@Entry,8932),	-- (45) -- Alterac Swiss
(@Entry,3927),	-- (35) -- Fine Aged Chedder
(@Entry,1707),	-- (25) -- Stormwind Brie
(@Entry,422),	-- (15) -- Dwarven Mild
(@Entry,414),	-- (5)  -- Dalaran Sharp
(@Entry,2070),	-- (1)  -- Darnassian Bleu
-- BUFF
(@Entry,33875),	-- Kibler's Bits
-- RARE
(@Entry,21024);	-- Chimaerok Tenderloin

-- --------------------------------------------------------------------------------------
--	LEGENDARY VENDOR - 601028
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601028,
@Model 		:= 27760, -- Ghostly Tauren Shaman
@Name 		:= "Imooen Winfield",
@Title 		:= "Legendary Artifacts",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 

(@Entry,3419);		-- Red Rose
-- (@Entry,9254);		-- Cuergo's Treasure Map


-- --------------------------------------------------------------------------------------
--	ELIXER/FLASK VENDOR - 601029
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601029,
@Model 		:= 16801, -- Elven Reagent Seller
@Name 		:= "Priorat Bordeaux",
@Title 		:= "Elixers & Flasks",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 13612, 0, 0, 18019); -- Wine Glass

-- NPC ITEMS
DELETE FROM npc_vendor WHERE entry = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,'2454'),
(@Entry,'2457'),
(@Entry,'2458'),
(@Entry,'3382'),
(@Entry,'3383'),
(@Entry,'3388'),
(@Entry,'3389'),
(@Entry,'3390'),
(@Entry,'3391'),
(@Entry,'3825'),
(@Entry,'3826'),
(@Entry,'3828'),
(@Entry,'5996'),
(@Entry,'5997'),
(@Entry,'6373'),
(@Entry,'6662'),
(@Entry,'8410'),
(@Entry,'8411'),
(@Entry,'8412'),
(@Entry,'8423'),
(@Entry,'8424'),
(@Entry,'8529'),
(@Entry,'8827'),
(@Entry,'8949'),
(@Entry,'8951'),
(@Entry,'9088'),
(@Entry,'9154'),
(@Entry,'9155'),
(@Entry,'9179'),
(@Entry,'9187'),
(@Entry,'9197'),
(@Entry,'9206'),
(@Entry,'9224'),
(@Entry,'9233'),
(@Entry,'9264'),
(@Entry,'10592'),
(@Entry,'12820'),
(@Entry,'13445'),
(@Entry,'13447'),
(@Entry,'13452'),
(@Entry,'13453'),
(@Entry,'13454'),
(@Entry,'17708'),
(@Entry,'18294'),
(@Entry,'20004'),
(@Entry,'20007'),
(@Entry,'20079'),
(@Entry,'20080'),
(@Entry,'20081'),
(@Entry,'21546'),
(@Entry,'22823'),
(@Entry,'22824'),
(@Entry,'22825'),
(@Entry,'22827'),
(@Entry,'22830'),
(@Entry,'22831'),
(@Entry,'22833'),
(@Entry,'22834'),
(@Entry,'22835'),
(@Entry,'22840'),
(@Entry,'22848'),
(@Entry,'23444'),
(@Entry,'23871'),
(@Entry,'25539'),
(@Entry,'28102'),
(@Entry,'28103'),
(@Entry,'28104'),
(@Entry,'31679'),
(@Entry,'32062'),
(@Entry,'32063'),
(@Entry,'32067'),
(@Entry,'32068'),
(@Entry,'34130'),
(@Entry,'34537'),
(@Entry,'37449'),
(@Entry,'39666'),
(@Entry,'40068'),
(@Entry,'40070'),
(@Entry,'40072'),
(@Entry,'40073'),
(@Entry,'40076'),
(@Entry,'40078'),
(@Entry,'40097'),
(@Entry,'40109'),
(@Entry,'44012'),
(@Entry,'44325'),
(@Entry,'44327'),
(@Entry,'44328'),
(@Entry,'44329'),
(@Entry,'44330'),
(@Entry,'44331'),
(@Entry,'44332'),
(@Entry,'45621'),
(@Entry,'13510'),
(@Entry,'13511'),
(@Entry,'13512'),
(@Entry,'13513'),
(@Entry,'22851'),
(@Entry,'22853'),
(@Entry,'22854'),
(@Entry,'22861'),
(@Entry,'22866'),
-- (@Entry,'32596'), -- unstable flasks
-- (@Entry,'32597'), 
-- (@Entry,'32598'),
-- (@Entry,'32599'),
-- (@Entry,'32600'),
-- (@Entry,'32601'),
(@Entry,'32764'),
(@Entry,'32766'),
(@Entry,'32767'),
-- (@Entry,'32898'), -- shattrath
-- (@Entry,'32899'), -- shattrath
-- (@Entry,'32900'),
-- (@Entry,'32901'),
(@Entry,'33208'),
-- (@Entry,'35716'), -- shattrath
-- (@Entry,'35717'), -- shattrath
(@Entry,'40079'),
-- (@Entry,'40082'), -- mixture
-- (@Entry,'40083'), -- mixture
-- (@Entry,'40084'), -- mixture
-- (@Entry,'40404'), -- mixture
(@Entry,'44939'),
(@Entry,'45006'),
(@Entry,'45007'),
(@Entry,'45008'),
(@Entry,'45009'),
(@Entry,'46376'),
(@Entry,'46377'),
(@Entry,'46378'),
(@Entry,'46379'),
(@Entry,'47499');

-- --------------------------------------------------------------------------------------
--	COW - 601030
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601030,
@Model 		:= 1060, -- Cow
@Name 		:= "Cowlie",
@Title 		:= "The Milker",
@Icon 		:= NULL,
@GossipMenu := 0,
@MinLevel 	:= 1,
@MaxLevel 	:= 1,
@Faction 	:= 190,
@NPCFlag 	:= 0,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 8,	-- Critter
@TypeFlags 	:= 0,
@FlagsExtra := 0,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- --------------------------------------------------------------------------------------
--	PIG - 601031
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601031,
@Model 		:= 16257, -- Pig
@Name 		:= "Cutie Pig",
@Title 		:= "For Elise",
@Icon 		:= NULL,
@GossipMenu := 0,
@MinLevel 	:= 1,
@MaxLevel 	:= 1,
@Faction 	:= 190,
@NPCFlag 	:= 0,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 8,	-- Critter
@TypeFlags 	:= 0,
@FlagsExtra := 0,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- --------------------------------------------------------------------------------------
--	EXOTIC MOUNT VENDOR - 601032
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601032,
@Model 		:= 14233, -- Ravak Grimtotem, Bounty Hunter
@Name 		:= "Ravak Grimtotem",
@Title 		:= "Exotic Mounts",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@UnitClass  := 1,
@UnitFlags	:= 37376,
@UnitFlags2 := 2048,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, unit_flags2, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, @UnitClass, @UnitFlags, @UnitFlags2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 1909, 0, 0, 18019); -- Silver Hatchet, None

-- NPC ADDON
DELETE FROM `creature_template_addon` WHERE `entry`=@Entry;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (@Entry, 0, 24757, 0, 0, 0, NULL); -- Great Brewfest Kodo

-- NPC ITEMS
DELETE FROM `npc_vendor` WHERE `entry` = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES 
(@Entry,'33976'),
(@Entry,'33999'),
(@Entry,'34060'),
(@Entry,'34061'),
(@Entry,'34092'),
(@Entry,'34129'),
(@Entry,'35906'),
(@Entry,'37011'),
(@Entry,'37012'),
(@Entry,'37676'),
(@Entry,'37719'),
(@Entry,'40775'),
(@Entry,'43516'),
(@Entry,'43951'),
(@Entry,'43952'),
(@Entry,'43953'),
(@Entry,'43954'),
(@Entry,'43955'),
(@Entry,'43956'),
(@Entry,'43958'),
(@Entry,'43959'),
(@Entry,'43961'),
(@Entry,'43962'),
(@Entry,'43986'),
(@Entry,'44077'),
(@Entry,'44080'),
(@Entry,'44083'),
(@Entry,'44086'),
(@Entry,'44151'),
(@Entry,'44160'),
(@Entry,'44164'),
(@Entry,'44175'),
(@Entry,'44178'),
(@Entry,'44223'),
(@Entry,'44224'),
(@Entry,'44225'),
(@Entry,'44226'),
(@Entry,'44230'),
(@Entry,'44231'),
(@Entry,'44234'),
(@Entry,'44235'),
(@Entry,'44413'),
(@Entry,'44554'),
(@Entry,'44558'),
(@Entry,'44689'),
(@Entry,'44690'),
(@Entry,'44707'),
(@Entry,'44842'),
(@Entry,'44843'),
(@Entry,'45801'),
(@Entry,'45802'),
(@Entry,'46099'),
(@Entry,'46100'),
(@Entry,'46101'),
(@Entry,'46109'),
(@Entry,'46171'),
(@Entry,'46308'),
(@Entry,'46708'),
(@Entry,'46743'),
(@Entry,'46744'),
(@Entry,'46745'),
(@Entry,'46746'),
(@Entry,'46747'),
(@Entry,'46748'),
(@Entry,'46749'),
(@Entry,'46750'),
(@Entry,'46751'),
(@Entry,'46752'),
(@Entry,'46813'),
(@Entry,'46814'),
(@Entry,'46815'),
(@Entry,'46816'),
(@Entry,'47100'),
(@Entry,'47101'),
(@Entry,'47179'),
(@Entry,'47180'),
(@Entry,'47840'),
(@Entry,'49044'),
(@Entry,'49046'),
(@Entry,'49096'),
(@Entry,'50250'),
(@Entry,'51954'),
(@Entry,'51955'),
(@Entry,'54068'),
(@Entry,'54797'),
(@Entry,'54860'),

-- Factions
(@Entry,'45125'),
(@Entry,'45586'),
(@Entry,'45589'),
(@Entry,'45590'),
(@Entry,'45591'),
(@Entry,'45592'),
(@Entry,'45593'),
(@Entry,'45595'),
(@Entry,'45596'),
(@Entry,'45597'),

-- Exotics
(@Entry,'19902'), -- Swift Zulian Tiger
(@Entry,'37828'), -- Great Brewfest Kodo
(@Entry,'33977'), -- Swift Brewfest Ram
(@Entry,'35513'), -- Swift White Hawkstrider
(@Entry,'30480'), -- Fiery Warhorse's Riens
(@Entry,'32768'), -- Reins of the Eaven Lord
(@Entry,'32458'), -- Ashes of Alar
(@Entry,'33809'),-- Amani War Bear
(@Entry,'41508'), -- Mechano-Hog
(@Entry,'44168'), -- Time-Lost Proto Drake
(@Entry,'44177'), -- Reins of the Violet Proto Drake
(@Entry,'45693'), -- Mimiron's Head
(@Entry,'45725'), -- Argent Hippogryph
(@Entry,'46102'), -- Venomhide Ravasaur
(@Entry,'49636'), -- Reins of the Onyxian Drake
(@Entry,'49098'), -- Crusader's Black Warhorse
(@Entry,'52200'), -- Reins of the Crimson Deasthcharger
(@Entry,'50818'); -- Invincible's Reins

-- --------------------------------------------------------------------------------------
--	MOUNT VENDOR - 601033
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601033,
@Model 		:= 27163, -- Warmaster Molog
@Name 		:= "Warmaster Molog",
@Title 		:= "Mounts",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 128, -- Vendor
@Scale		:= 1.0,
@Rank		:= 0,
@UnitClass  := 1,
@UnitFlags	:= 37376,
@UnitFlags2 := 2048,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, unit_flags2, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, @UnitClass, @UnitFlags, @UnitFlags2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 21580, 0, 23889, 18019); -- Silver Hatchet, None

-- NPC ADDON
DELETE FROM `creature_template_addon` WHERE `entry`=@Entry;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (@Entry, 0, 14334, 0, 0, 0, NULL); -- Black Undead Horse

-- NPC ITEMS
DELETE FROM `npc_vendor` WHERE `entry` = @Entry;
INSERT INTO npc_vendor (entry, item) VALUES
(@Entry,'1132'),
(@Entry,'2411'),
(@Entry,'2414'),
(@Entry,'5655'),
(@Entry,'5656'),
(@Entry,'5665'),
(@Entry,'5668'),
(@Entry,'5864'),
(@Entry,'5872'),
(@Entry,'5873'),
(@Entry,'8563'),
(@Entry,'8586'),
(@Entry,'8588'),
(@Entry,'8591'),
(@Entry,'8592'),
(@Entry,'8595'),
(@Entry,'8629'),
(@Entry,'8631'),
(@Entry,'8632'),
(@Entry,'12302'),
(@Entry,'12303'),
(@Entry,'12330'),
(@Entry,'12351'),
(@Entry,'12353'),
(@Entry,'12354'),
(@Entry,'13086'),
(@Entry,'13317'),
(@Entry,'13321'),
(@Entry,'13322'),
(@Entry,'13326'),
(@Entry,'13327'),
(@Entry,'13328'),
(@Entry,'13329'),
(@Entry,'13331'),
(@Entry,'13332'),
(@Entry,'13333'),
(@Entry,'13334'),
(@Entry,'13335'),
(@Entry,'15277'),
(@Entry,'15290'),
(@Entry,'15292'),
(@Entry,'15293'),
(@Entry,'18766'),
(@Entry,'18767'),
(@Entry,'18772'),
(@Entry,'18773'),
(@Entry,'18774'),
(@Entry,'18776'),
(@Entry,'18777'),
(@Entry,'18778'),
(@Entry,'18785'),
(@Entry,'18786'),
(@Entry,'18787'),
(@Entry,'18788'),
(@Entry,'18789'),
(@Entry,'18790'),
(@Entry,'18791'),
(@Entry,'18793'),
(@Entry,'18794'),
(@Entry,'18795'),
(@Entry,'18796'),
(@Entry,'18797'),
(@Entry,'18798'),
(@Entry,'18902'),
(@Entry,'19029'),
(@Entry,'19030'),
(@Entry,'19872'),
(@Entry,'21176'),
(@Entry,'21218'),
(@Entry,'21321'),
(@Entry,'21323'),
(@Entry,'21324'),
(@Entry,'25470'),
(@Entry,'25471'),
(@Entry,'25472'),
(@Entry,'25473'),
(@Entry,'25474'),
(@Entry,'25475'),
(@Entry,'25476'),
(@Entry,'25477'),
(@Entry,'25527'),
(@Entry,'25528'),
(@Entry,'25529'),
(@Entry,'25531'),
(@Entry,'25532'),
(@Entry,'25533'),
(@Entry,'28481'),
(@Entry,'28915'),
(@Entry,'28927'),
(@Entry,'28936'),
(@Entry,'29102'),
(@Entry,'29103'),
(@Entry,'29104'),
(@Entry,'29105'),
(@Entry,'29220'),
(@Entry,'29221'),
(@Entry,'29222'),
(@Entry,'29223'),
(@Entry,'29224'),
(@Entry,'29227'),
(@Entry,'29228'),
(@Entry,'29229'),
(@Entry,'29230'),
(@Entry,'29231'),
(@Entry,'29465'),
(@Entry,'29466'),
(@Entry,'29467'),
(@Entry,'29468'),
(@Entry,'29469'),
(@Entry,'29470'),
(@Entry,'29471'),
(@Entry,'29472'),
(@Entry,'29743'),
(@Entry,'29744'),
(@Entry,'29745'),
(@Entry,'29746'),
(@Entry,'29747'),
(@Entry,'30609'),
(@Entry,'31829'),
(@Entry,'31830'),
(@Entry,'31831'),
(@Entry,'31832'),
(@Entry,'31833'),
(@Entry,'31834'),
(@Entry,'31835'),
(@Entry,'31836'),
(@Entry,'32314'),
(@Entry,'32316'),
(@Entry,'32317'),
(@Entry,'32318'),
(@Entry,'32319'),
(@Entry,'32857'),
(@Entry,'32858'),
(@Entry,'32859'),
(@Entry,'32860'),
(@Entry,'32861'),
(@Entry,'32862'),
(@Entry,'33176'),
(@Entry,'33182'),
(@Entry,'33183'),
(@Entry,'33184'),
(@Entry,'33189');

-- --------------------------------------------------------------------------------------
--	BANKER - 601034
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601034,
@Model 		:= 7621, -- Female Tauren
@Name 		:= "Marny",
@Title 		:= "Banker",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 131072, -- Banker
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 2714, 0, 0, 18019); -- Lantern, None

-- --------------------------------------------------------------------------------------
--	GM Island Decorator - 601035
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601035,
@Model 		:= 12162, -- Molten Giant
@Name 		:= "Balrog",
@Title 		:= "|cff00ccffIsland Decorator|r",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1, -- 
@Scale		:= 0.25,
@Rank		:= 1,
@Type 		:= 0,
@TypeFlags 	:= 4,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "GMIsland_Theme_Generator";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- --------------------------------------------------------------------------------------
--	BENGAL TIGER VENDOR - 601036 - Smart Script Trainer
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601036,
@Model 		:= 2575, -- Night Elf Female (Classic)
@Name 		:= "Reina Sands",
@Title 		:= "Bengal Tiger Handler",
@Icon 		:= "Trainer",
@GossipMenu := 60136,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 3, -- 
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 138936390,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Spell1		:= 828, 	-- Tiger Riding (828, 6745 passive)
@Spell2		:= 10790,	-- Reins of the Bengal Tiger
@Spell3 	:= 16609,	-- Pray to Elune
@Item1		:= 8630,	-- Reins of the Bengal Tiger
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- Text
DELETE FROM `npc_text` WHERE `ID` = @Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES (@Entry, 'Greetings $N. Lucky you.. You\'ve arrived at just the right time.', NULL, 0, 0, 0, 6, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 1);

-- Gossip Menu
DELETE FROM `world`.`gossip_menu` WHERE `MenuID` = @GossipMenu;
INSERT INTO `world`.`gossip_menu` (`MenuID`, `TextID`) VALUES (@GossipMenu, @Entry);

-- Gossip Menu Option
DELETE FROM `gossip_menu_option` WHERE `MenuId` = @GossipMenu;
INSERT INTO gossip_menu_option  (`MenuId`, `Optionid`, `optionicon`, `optiontext`, `optionbroadcasttextid`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES (@GossipMenu, 0, 3, 'Train Tiger Riding', 1, 1, @GossipMenu, 0, 0, 0, '');
INSERT INTO gossip_menu_option  (`MenuId`, `Optionid`, `optionicon`, `optiontext`, `optionbroadcasttextid`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES (@GossipMenu, 1, 2, 'Adopt a Bengal Tiger', 1, 1, @GossipMenu, 0, 0, 0, '');
INSERT INTO gossip_menu_option  (`MenuId`, `Optionid`, `optionicon`, `optiontext`, `optionbroadcasttextid`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES (@GossipMenu, 2, 9, 'Pray to Elune', 1, 1, @GossipMenu, 0, 0, 0, '');

-- Smart Scripts
DELETE FROM `smart_scripts` WHERE `entryorguid` = @Entry;
INSERT INTO smart_scripts (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (@Entry, 0, 0, 0, 62, 0, 100, 0, @GossipMenu, 0, 0, 0, 85, @Spell1, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, '');
INSERT INTO smart_scripts (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (@Entry, 0, 1, 0, 62, 0, 100, 0, @GossipMenu, 1, 0, 0, 56, @Item1, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, '');
INSERT INTO smart_scripts (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (@Entry, 0, 2, 0, 62, 0, 100, 0, @GossipMenu, 2, 0, 0, 11, @Spell3, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, '');

-- Update Reins of the Bengal Tiger requirements
UPDATE `world`.`item_template` SET `RequiredLevel`='1', `RequiredSkill`='150', `RequiredSkillRank`='1', `maxcount`='1' WHERE (`entry`='8630');

-- --------------------------------------------------------------------------------------
--	HEIRLOOM VENDOR - 601704
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 601704,
@Model 		:= 25900, -- Small Tyrion
@Name 		:= "Glowing Soul",
@Title 		:= "Heirloom Merchant",
@Icon 		:= "Buy",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 130, -- 
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "";

-- NPC
DELETE FROM creature_template where entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- Text
DELETE FROM `npc_text` WHERE `ID` = 601017;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES (601017, 'Greetings $N. I carry artifacts forged from the old world to help you in your journey.', NULL, 0, 0, 0, 6, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 1);

-- Items
DELETE FROM `npc_vendor` WHERE `entry`=@Entry;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES 
(@Entry,0,42943,0,0,0), -- Bloodied Arcanite Reaper
(@Entry,0,42944,0,0,0), -- Balanced Heartseeker
(@Entry,0,42945,0,0,0), -- Venerable Dal'Rend's Sacred Charge
(@Entry,0,42946,0,0,0), -- Charmed Ancient Bone Bow
(@Entry,0,42947,0,0,0), -- Dignified Headmaster's Charge
(@Entry,0,42948,0,0,0), -- Devout Aurastone Hammer
(@Entry,0,42949,0,0,0), -- Polished Spaulders of Valor
(@Entry,0,42950,0,0,0), -- Champion Herod's Shoulder
(@Entry,0,42951,0,0,0), -- Mystical Pauldrons of Elements
(@Entry,0,42952,0,0,0), -- Stained Shadowcraft Spaulders
(@Entry,0,42984,0,0,0), -- Preened Ironfeather Shoulders
(@Entry,0,42985,0,0,0), -- Tattered Dreadmist Mantle
(@Entry,0,42991,0,0,0), -- Swift Hand of Justice
(@Entry,0,42992,0,0,0), -- Discerning Eye of the Beast
(@Entry,0,44091,0,0,0), -- Sharpened Scarlet Kris
(@Entry,0,44092,0,0,0), -- Reforged Truesilver Champion
(@Entry,0,44093,0,0,0), -- Upgraded Dwarven Hand Cannon
(@Entry,0,44094,0,0,0), -- The Blessed Hammer of Grace
(@Entry,0,44095,0,0,0), -- Grand Staff of Jordan
(@Entry,0,44096,0,0,0), -- Battleworn Thrash Blade
(@Entry,0,44097,0,0,0), -- Inherited Insignia of the Horde
(@Entry,0,44098,0,0,0), -- Inherited Insignia of the Alliance
(@Entry,0,44099,0,0,0), -- Strengthened Stockade Pauldrons
(@Entry,0,44100,0,0,0), -- Pristine Lightforge Spaulders
(@Entry,0,44101,0,0,0), -- Prized Beastmaster's Mantle
(@Entry,0,44102,0,0,0), -- Aged Pauldrons of The Five Thunders
(@Entry,0,44103,0,0,0), -- Exceptional Stormshroud Shoulders
(@Entry,0,44105,0,0,0), -- Lasting Feralheart Spaulders
(@Entry,0,44107,0,0,0), -- Exquisite Sunderseer Mantle
(@Entry,0,48677,0,0,0), -- Champion's Deathdealer Breastplate
(@Entry,0,48685,0,0,0), -- Polished Breastplate of Valor
(@Entry,0,48687,0,0,0), -- Preened Ironfeather Breastplate
(@Entry,0,48689,0,0,0), -- Stained Shadowcraft Tunic
(@Entry,0,48683,0,0,0), -- Mystical Vest of Elements
(@Entry,0,48691,0,0,0), -- Tattered Dreadmist Robe
(@Entry,0,48716,0,0,0), -- Venerable Mass of McGowan
(@Entry,0,48718,0,0,0), -- Repurposed Lava Dredger
(@Entry,0,50255,0,0,0); -- Dread Pirate Ring

