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
-- WORLD: Item Pricing (Low Cost)
--
-- Reprices the items sold by custom NPC vendors in StygianCore.
--
-- Item Stack Note: 
-- The `buyprice` for items in stacks is per item. Ex: Buying an item that stacks 
-- to 5 (Snowballs) that has a `sellprice` of 2 silver should have the `buyprice` 
-- set to 10 silver. This avoids buy low/sell high price exploits!
-- 
-- 2021.04.07:
--			Update to latest AC database by Anhedonie
-- ################################################################################### --
*/



-- --------------------------------------------------------------------------------------
--	CURRENCY CONVERSION
-- --------------------------------------------------------------------------------------
SET @1C :=1;				--	   1 Copper
SET @5C :=5;				--	   5 Copper
SET @10C :=10;				--	   10 Copper
SET @25C :=25;				--	   25 Copper
SET @50C :=50;				--	   50 Coarse
SET @75C :=75;				--	   75 Copper
SET @1S :=100;				--	   1 Silver
SET @2S :=200;				--	   2 Silver
SET @3S :=300;				--	   3 Silver
SET @4S :=400;				--	   4 Silver
SET @5S :=500;				--	   5 Silver
SET @10S :=1000;			--	   10 Silver
SET @15S :=1500;			--		15 Silver
SET @20S :=2000;			--	   20 Silver
SET @25S :=2500;			--	   25 Silver
SET @50S :=5000;			--	   50 Silver
SET @75S :=7500;			--	   75 Silver
SET @1G :=10000; 			--     1 Gold
SET @2G :=20000; 			--     2 Gold
SET @3G :=30000; 			--     3 Gold
SET @4G :=40000; 			--     4 Gold
SET @5G :=50000; 			--     5 Gold
SET @10G :=100000; 			--    10 Gold
SET @15G :=150000; 			--    15 Gold
SET @18G :=180000; 			--    18 Gold
SET @20G :=200000; 			--    20 Gold
SET @25G :=250000; 			--    25 Gold
SET @30G :=300000; 			--    30 Gold
SET @40G :=400000; 			--    40 Gold
SET @50G :=500000; 			--    50 Gold
SET @75G :=750000; 			--    75 Gold
SET @100G :=1000000; 		--   100 Gold
SET @150G :=1500000; 		--   150 Gold
SET @200G :=2000000; 		--   200 Gold
SET @250G :=2500000; 		--   250 Gold
SET @300G :=3000000; 		--   300 Gold
SET @350G :=3500000; 		--   350 Gold
SET @375G :=3750000; 		--   375 Gold
SET @500G :=5000000; 		--   500 Gold
SET @750G :=7500000; 		--   750 Gold
SET @1000G :=10000000; 		--  1000 Gold
SET @1250G :=12500000; 		--  1250 Gold
SET @1500G :=15000000; 		--  1500 Gold
SET @2500G :=25000000; 		--  2500 Gold
SET @5000G :=50000000; 		--  5000 Gold
SET @7500G :=75000000; 		--  7500 Gold
SET @10000G :=100000000; 	-- 10000 Gold
SET @12500G :=125000000; 	-- 12500 Gold
SET @15000G :=150000000; 	-- 15000 Gold
SET @20000G :=200000000; 	-- 20000 Gold
SET @25000G :=250000000; 	-- 20000 Gold
SET @50000G :=500000000; 	-- 50000 Gold
SET @75000G :=750000000; 	-- 75000 Gold

-- --------------------------------------------------------------------------------------
--	FIXED ITEMS
-- --------------------------------------------------------------------------------------
-- UPDATE item_template SET sellprice=@1C, buyprice=@1C WHERE entry = 1729; 	-- Gunny of the Night Watch
-- UPDATE item_template SET sellprice=@1S, buyprice=@1S WHERE entry = 46870; 	-- Confessor's Prayer Book
-- UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32872; 	-- Illidari Rod of Discipline
-- UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44549; 	-- Pattern: Revenant's Treads


-- --------------------------------------------------------------------------------------
--	TEMPLATE
-- --------------------------------------------------------------------------------------
-- UPDATE item_template SET sellprice=@1C, buyprice=@1C WHERE entry = ; -- 
-- UPDATE item_template SET sellprice=@1S, buyprice=@1S WHERE entry = ; -- 
-- UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = ; -- 


-- --------------------------------------------------------------------------------------
--	MISC. ITEMS
-- --------------------------------------------------------------------------------------

UPDATE item_template SET sellprice=@25S, buyprice=@25S WHERE entry = 11754;		-- Black Diamond


-- --------------------------------------------------------------------------------------
--	LORE/ARTIFACT ITEMS
-- --------------------------------------------------------------------------------------

-- Legendary
UPDATE item_template SET sellprice=@1G, buyprice=@5000G WHERE entry = 13262;	-- Ashbringer
UPDATE item_template SET sellprice=@1G, buyprice=@5000G WHERE entry = 22630;	-- Atiesh, Greatstaff of the Guardian
UPDATE item_template SET sellprice=@1G, buyprice=@5000G WHERE entry = 25596;	-- Peep's Whistle
UPDATE item_template SET sellprice=@1G, buyprice=@5000G WHERE entry = 192;		-- Martin's Broken Staff
UPDATE item_template SET sellprice=@1G, buyprice=@5000G WHERE entry = 17;		-- Martin Fury

-- 10
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 21024;		-- Chimaerok Tenderloin
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 5433; 		-- Rag Doll
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 40393; 		-- Green Sparkly
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 39356; 		-- Mind Soothing Bauble 
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 5373; 		-- Lucky Charm
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 5060; 		-- Thieves Tools

-- 25
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 5429; 		-- A Pretty Rock
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 31945; 		-- Shadow Circuit
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 29572; 		-- Aboriginal Carvings
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 6297; 		-- Old Skull 
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 29570; 		-- A Gnome Effigy 
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 39355; 		-- Haute Club Membership Card 
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 24231; 		-- Coarse Snuff 
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 4471; 		-- Flint and Tinder 

-- 50  
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 12608; 		-- Butcher's Apron
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 9327; 		-- Security DELTA Data Access Card	
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 39351;		-- Richly Appointed Pipe
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 38264; 		-- A Very Pretty Rock
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 46359; 		-- Velociraptor Skull
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 11108; 		-- Faded Photograph
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 18228; 		-- Autographed Picture of Tigole and Furor
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 18229; 		-- Nat Pagel's Guide to Extreme Anglin'
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 20010; 		-- The Horde's Hellscream
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 19484; 		-- The Frostwolf Artichoke
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 19483; 		-- Peelin' The Onion
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 11482; 		-- Crystal Pilon User's Manual
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 2608; 		-- Threshadon Ambergris
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 9242; 		-- Ancient Tablet

-- 75
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 18365; 		-- A Thoroughly Read Copy of Nat's Anglin'
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 11420; 		-- Elegant Writing Tool 
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 39351;		-- Richly Appointed Pipe

-- 100
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 9254;		-- Cuergo's Treasure Map
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 18335; 		-- Pristine Black Diamond
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 34826; 		-- Gold Wedding Band
UPDATE item_template SET sellprice=@2G, buyprice=@10G WHERE entry = 9360;		-- Cuergo's Gold

-- 250
UPDATE item_template SET sellprice=@2G, buyprice=@10G WHERE entry = 11382; 		-- Blood of the Mountain
UPDATE item_template SET sellprice=@2G, buyprice=@10G WHERE entry = 44464; 		-- Crude Eating Utensils
UPDATE item_template SET sellprice=@2G, buyprice=@10G WHERE entry = 45994; 		-- Lost Ring 
UPDATE item_template SET sellprice=@2G, buyprice=@10G WHERE entry = 45995; 		-- Lost Necklace 

-- 500
UPDATE item_template SET sellprice=@3G, buyprice=@10G WHERE entry = 18665; 		-- Eye of Shadow
UPDATE item_template SET sellprice=@5G, buyprice=@10G WHERE entry = 44430; 		-- Titanium Seal of Dalaran 

-- 750
UPDATE item_template SET sellprice=@15G, buyprice=@10G WHERE entry = 8350;		-- The 1 Ring
UPDATE item_template SET sellprice=@10G, buyprice=@10G WHERE entry = 34837; 	-- The 2 Ring 
UPDATE item_template SET sellprice=@10G, buyprice=@10G WHERE entry = 45859; 	-- The 5 Ring

-- 1000
UPDATE item_template SET sellprice=@50G, buyprice=@50G WHERE entry = 9361;	-- Cuergo's Gold with Worm

-- --------------------------------------------------------------------------------------
-- 	HOLIDAY
-- --------------------------------------------------------------------------------------

UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 20397;	    -- Hallowed Wand: Pirate
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 20398;	    -- Hallowed Wand: Ninja
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 20399;	    -- Hallowed Wand: Leper Gnome
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 20409;	    -- Hallowed Wand: Ghost
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 20410;	    -- Hallowed Wand: Bat
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 20411;	    -- Hallowed Wand: Skeleton
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 20413;	    -- Hallowed Wand: Random
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 20414;	    -- Hallowed Wand: Wisp
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 29575;	    -- A Jack-o'-Lantern
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 34068;	    -- Weighted Jack-o'-Lantern
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 37895;	    -- Filled Green Brewfest Stein
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 33019;	    -- Filled Blue Brewfest Stein
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 44803;	    -- Spring Circlet
UPDATE item_template SET sellprice=@25S, buyprice=@25S WHERE entry = 3419;	    -- Red Rose	
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 34480;	    -- Romantic Picnic Basket
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 21154;	    -- Festival Dress
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 17712;	    -- Winter Veil Disguise Kit
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 21213;	    -- Preserved Holly
UPDATE item_template SET sellprice=@25S, buyprice=@25S WHERE entry = 35557;	    -- Huge Snowball
UPDATE item_template SET sellprice=@2S, buyprice=@10S WHERE entry = 17202;	    -- Snowball
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 21524;	    -- Red Winter Hat
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 21542;	    -- Festival Suit
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 34085;	    -- Red Winter Clothes
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 34086;	    -- Winter Boots
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 34087;	    -- Green Winter Clothes
UPDATE item_template SET sellprice=@25S, buyprice=@1S WHERE entry = 34850;	    -- Midsummer Ground Flower
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 23323;	    -- Crown of the Fire Festival
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 23324;	    -- Mantle of the Fire Festival
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 34683;	    -- Sandals of Summer
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 34685;	    -- Vestment of Summer
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 35280;	    -- Tabard of Summer Flames
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 35279;	    -- Tabard of Summer Skies
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 42438;	    -- Lovely Cake
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 42436;      -- Chocolate Celebration Cake
UPDATE item_template SET sellprice=@50G, buyprice=@250G WHERE entry = 34686;	-- Brazier of Dancing Flames

-- --------------------------------------------------------------------------------------
--	RARE DROPS
-- --------------------------------------------------------------------------------------

-- 75
UPDATE item_template SET sellprice=@5G, buyprice=@5g WHERE entry = 12709; 		-- Finkle's Skinner

-- 250
UPDATE item_template SET sellprice=@2G, buyprice=@250G WHERE entry = 4696; 		-- Lapidis Tankard of Tidesippe
UPDATE item_template SET sellprice=@2G, buyprice=@250G WHERE entry = 13047; 	-- Twig of the World Tree
UPDATE item_template SET sellprice=@5G, buyprice=@250G WHERE entry = 11840;		-- Master Builder's Shirt

-- 500
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 1973; 	-- Orb of Deception

-- 750
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 13397; 	-- Stoneskin Gargoyle Cape
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 4354; 	-- Plans: Rich Purple Silk Shirt
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 9423; 	-- The Jackhammer
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 9424; 	-- Ginn-su sword
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 9465; 	-- Digmaster 5000
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 9427; 	-- Stonevault Bonebreaker
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 38802;	-- Enchant Gloves Fishing
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 19854; 	-- Zin'rokh, Destroyer of Worlds
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 35664; 	-- Unknown Archeologist's Hammer
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 8226;		-- The Butcher
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 23540; 	-- Felsteel Longblade
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 1728; 	-- Teebu's Blazing Longsword
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 14551; 	-- Edgemaster Handguards
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 9491; 	-- Hotshot Pilot Gloves
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 9425; 	-- Pendulum of Doom
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 45861; 	-- Diamond-Tipped Cane
UPDATE item_template SET sellprice=@25G, buyprice=@750G WHERE entry = 12592; 	-- Black Blade of Shazram

-- 1000
UPDATE item_template SET sellprice=@100G, buyprice=@1000G WHERE entry = 4446; 	-- Blackvenom Blade
UPDATE item_template SET sellprice=@100G, buyprice=@1000G WHERE entry = 1604; 	-- Chromatic Sword
UPDATE item_template SET sellprice=@100G, buyprice=@1000G WHERE entry = 8029; 	-- Plans: Wicked Mithril Blade

-- 2500                                
UPDATE item_template SET sellprice=@250G, buyprice=@2500G WHERE entry = 21025;	-- Recipe: Dirge's Kickin' Chimaerok Chops
UPDATE item_template SET sellprice=@250G, buyprice=@2500G WHERE entry = 9429; 	-- Miner's Hat of the Deep

-- 5000                                 
UPDATE item_template SET sellprice=@500G, buyprice=@5000G WHERE entry = 18755; 	-- Xorthian Firestick
UPDATE item_template SET sellprice=@500G, buyprice=@5000G WHERE entry = 18401; 	-- Foror's Compendium of Dragonslaying
UPDATE item_template SET sellprice=@500G, buyprice=@5000G WHERE entry = 1168; 	-- Skullflame Shield

-- 15,000
UPDATE item_template SET sellprice=@1500G, buyprice=@15000G WHERE entry = 17782; -- Talisman of Binding Shard


-- --------------------------------------------------------------------------------------
--	BAGS
-- --------------------------------------------------------------------------------------

UPDATE item_template SET sellprice=@1C, buyprice=@1C WHERE entry = 37606;		-- Penny Pouch
UPDATE item_template SET sellprice=@1G, buyprice=@50G WHERE entry = 38082; 		-- Gigantique Bag (22-Slot Bag)
UPDATE item_template SET sellprice=@1G, buyprice=@75G WHERE entry = 51809; 		-- Portable Hole (24-Slot Bag)
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 23162; 	-- Foror's Crate of Endless Resist Gear Storage (36-Slot Bag)
UPDATE item_template SET sellprice=@1G, buyprice=@75G WHERE entry = 51809; 		-- Portable Hole (24-Slot Bag)
UPDATE item_template SET sellprice=@1G, buyprice=@20G WHERE entry = 14156; 		-- Bottomless Bag
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 38145; 		-- Deathweave Bag
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 41600; 		-- Glacial Bag
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 50316; 		-- Papa's Brand New Bag
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 50317; 		-- Papa's New Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =1470; 		-- Murloc Skin Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =1685; 		-- Troll-hide Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =4957; 		-- Old Moneybag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =6446; 		-- Snakeskin Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =6754; 		-- Large Moneybag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =7734; 		-- Six Demon Bag
/*

UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =856; 			-- Blue Leather Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =932; 			-- Fel Steed Saddlebags
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =1014; 		-- Large Moneybag (old)
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =1191; 		-- Bag of Marbles

UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =1977; 		-- 20-slot Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =2657; 		-- Red Leather Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =3343; 		-- Captain Sanders Booty Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =3349; 		-- Sidas Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =3352; 		-- Ooze-covered Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =3960; 		-- Bag of Water Elemental Bracers
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =4238; 		-- Linen Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =4240; 		-- Woolen Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =4241; 		-- Green Woolen Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =4292; 		-- Pattern: Green Woolen Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =4497; 		-- Heavy Brown Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =4930; 		-- Handmade Leather Bag

UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =5081; 		-- Kodo Hide Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =5083; 		-- Pattern: Kodo Hide Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =5573; 		-- Green Leather Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =5574; 		-- White Leather Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =5762; 		-- Red Linen Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =5763; 		-- Red Woolen Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =5771; 		-- Pattern: Red Linen Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =5772; 		-- Pattern: Red Woolen Bag

UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =6754; 		-- Large Moneybag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =7734; 		-- Six Demon Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =10050; 		-- Mageweave Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =10051; 		-- Red Mageweave Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =11845; 		-- Handmade Leather Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =11955; 		-- Bag of Empty Ooze Containers
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =13725; 		-- Krastinovs Bag of Horrors
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =14046; 		-- Runecloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =14155; 		-- Mooncloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =14468; 		-- Pattern: Runecloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =14499; 		-- Pattern: Mooncloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =14510; 		-- Pattern: Bottomless Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =15866; 		-- Veildust Medicine Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =15902; 		-- A Crazy Grab Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =19775; 		-- Sealed Azure Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =19891; 		-- Jindos Bag of Whammies
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =20393; 		-- Treat Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =20400; 		-- Pumpkin Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =20603; 		-- Bag of Spoils
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =20766; 		-- Slimy Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =20767; 		-- Scum Covered Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =20768; 		-- Oozing Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21031; 		-- Cabbage Kimchi
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21041; 		-- Bag of Gold
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21156; 		-- Scarab Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21341; 		-- Felcloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21342; 		-- Core Felcloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21371; 		-- Pattern: Core Felcloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21528; 		-- Colossal Bag of Loot
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21813; 		-- Bag of Heart Candies
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21841; 		-- Netherweave Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21843; 		-- Imbued Netherweave Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21858; 		-- Spellfire Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21872; 		-- Ebon Shadowbag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21876; 		-- Primal Mooncloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21893; 		-- Pattern: Imbued Netherweave Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21911; 		-- Pattern: Spellfire Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21915; 		-- Pattern: Ebon Shadowbag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =21919; 		-- Pattern: Primal Mooncloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22248; 		-- Enchanted Runecloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22249; 		-- Big Bag of Enchantment
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22251; 		-- Cenarion Herb Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22308; 		-- Pattern: Enchanted Runecloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22309; 		-- Pattern: Big Bag of Enchantment
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22310; 		-- Pattern: Cenarion Herb Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22571; 		-- Couriers Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22611; 		-- Craftsmans Writ - Runecloth Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =22679; 		-- Supply Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =23215; 		-- Bag of Smorc Ingredients
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =23749; 		-- Empty Bota Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =23750; 		-- Filled Bota Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =23852; 		-- Nolkais Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =24270; 		-- Bag of Jewels
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =24314; 		-- Pattern: Bag of Jewels
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =25419; 		-- Unmarked Bag of Gems
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =25423; 		-- Bag of Premium Gems
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 27680; 		-- Halaani Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =29449; 		-- Bladespire Bagel
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =29540; 		-- Reinforced Mining Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =29664; 		-- Pattern: Reinforced Mining Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =30444; 		-- Pattern: Reinforced Mining Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =32777; 		-- Kronks Grab Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =34490; 		-- Bag of Many Hides
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =34491; 		-- Pattern: Bag of Many Hides
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =38225; 		-- Mycah's Botanical Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =38229; 		-- Pattern: Mycahs Botanical Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =38307; 		-- Craftys Bottomless Inscription Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =38347; 		-- Mammoth Mining Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =38622; 		-- Lafoos Bug Bag
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry =41597; 		-- Abyssal Bag
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry =41598; 		-- Mysterious Bag
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry =41599; 		-- Frostweave Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =41888; 		-- Small Velvet Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =42183; 		-- Pattern: Abyssal Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =42184; 		-- Pattern: Glacial Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =42185; 		-- Pattern: Mysterious Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =42186; 		-- Pattern: Frostweave Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =42342; 		-- Bag of Popcorn
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =42350; 		-- Bag of Peanuts
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =43289; 		-- Bag of Jagged Shards
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =43345; 		-- Dragon Hide Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =44113; 		-- Small Spice Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =44510; 		-- Pattern: Mammoth Mining Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =45773; 		-- Emerald Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =45774; 		-- Pattern: Emerald Bag
UPDATE item_template SET sellprice=@1G, buyprice=@3G WHERE entry =46007; 		-- Bag of Fishing Treasures
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry =51013; 		-- Discarded Bag of Entrails
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry =51866; 		-- Discarded Bag of Entrails
*/

-- --------------------------------------------------------------------------------------
--	KEYS
-- --------------------------------------------------------------------------------------

-- QUEST KEYS
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 5396;		-- Key to the Searing Gorge (Tunnel)

-- DUNGEON KEYS
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry = 6893; 		-- Gnomregan Workshop Key (Gnomeregan)
UPDATE item_template SET sellprice=@50S, buyprice=@2G WHERE entry = 7146;		-- The Scarlet Key (Scarlet Monestary)
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry = 11078;		-- Relic Coffer Key (Blackrock Depths)
UPDATE item_template SET sellprice=@50S, buyprice=@2G WHERE entry = 11197; 		-- Dark Keeper Key (Blackrock Depths)
UPDATE item_template SET sellprice=@50S, buyprice=@50G WHERE entry = 11000; 	-- Shadowforge Key (Blackrock Depths)
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 18250; 		-- Gordok Shackle Key (Dire Maul)
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 18266; 		-- Gordok Courtyard Key (Dire Maul)
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 18268; 		-- Gordok Inner Door Key (Dire Maul)
UPDATE item_template SET sellprice=@50S, buyprice=@50G WHERE entry = 18249; 	-- Crescent Key (Dire Maul)
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 12382; 		-- Key to the City (Stratholme)
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 27991; 		-- Shadow Labrynth Key
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 28395; 		-- Shattered Halls Key
UPDATE item_template SET sellprice=@50S, buyprice=@50G WHERE entry = 31704; 	-- The Tempest Key (Tempest Keep)
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 32449; 		-- Essence Infused Moonstone (Sethekk Halls, Druid Flight Form)
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 30622; 		-- Flamewrought Key (Alliance - Heroic Hellfire Citadel)
UPDATE item_template SET sellprice=@50S, buyprice=@5G WHERE entry = 30637; 		-- Flamewrought Key (Horde - Heroic Hellfire Citadel)
UPDATE item_template SET sellprice=@50S, buyprice=@10G WHERE entry = 30623; 	-- Reservior Key (Heroic Coilfang Reservoir)
UPDATE item_template SET sellprice=@50S, buyprice=@10G WHERE entry = 30633; 	-- Auchenai Key (Heroic Auchindoun)
UPDATE item_template SET sellprice=@50S, buyprice=@15G WHERE entry = 30634; 	-- Warpforged Key (Heroic Tempest Keep)
UPDATE item_template SET sellprice=@50S, buyprice=@15G WHERE entry = 30635; 	-- Key of Time (Heroic Caverns of Time)

-- RAID KEYS
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry = 21761; 		-- Scarab Coffer Key (Ahn Quiraj)
UPDATE item_template SET sellprice=@50S, buyprice=@2G WHERE entry = 21762; 		-- Greater Scarab Coffer Key (Ahn Quiraj)
UPDATE item_template SET sellprice=@50S, buyprice=@100G WHERE entry = 24490; 	-- The Master's Key (Karazhan)
UPDATE item_template SET sellprice=@50S, buyprice=@10G WHERE entry = 31084; 	-- Key to the Arcatraz
UPDATE item_template SET sellprice=@50S, buyprice=@15G WHERE entry = 42482; 	-- The Violet Hold Key
UPDATE item_template SET sellprice=@50S, buyprice=@25G WHERE entry = 44582; 	-- Key to the Focusing Iris (Eye of Eternity)
UPDATE item_template SET sellprice=@50S, buyprice=@25G WHERE entry = 44581; 	-- Heroic Key to the Focusing Iris (Eye of Eternity)
UPDATE item_template SET sellprice=@50S, buyprice=@100G WHERE entry = 45796; 	-- Celestial Planetarium Key (Ulduar)
UPDATE item_template SET sellprice=@50S, buyprice=@250G WHERE entry = 45798; 	-- Heroic Celestial Planetarium Key (Ulduar)

-- SKELETON KEYS
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 15869; 		-- Silver Skeleton Key
UPDATE item_template SET sellprice=@25S, buyprice=@25S WHERE entry = 15870; 		-- Golden Skeleton Key
UPDATE item_template SET sellprice=@25S, buyprice=@25S WHERE entry = 15871; 		-- TrueSilver Skeleton Key
UPDATE item_template SET sellprice=@50S, buyprice=@50S WHERE entry = 15872; 		-- Arcanite Skeleton Key
UPDATE item_template SET sellprice=@50S, buyprice=@50S WHERE entry = 43853; 		-- Titanium Skeleton Key
UPDATE item_template SET sellprice=@50S, buyprice=@50S WHERE entry = 43854; 		-- Cobalt Skeleton Key


-- --------------------------------------------------------------------------------------
--	SPECIALTY ITEMS
-- --------------------------------------------------------------------------------------

-- FUN
UPDATE item_template SET buyprice=@1G WHERE entry = 32566; 		-- Picnic Basket
UPDATE item_template SET buyprice=@1G WHERE entry = 41367;		-- Dark Jade Focusing Lens
UPDATE item_template SET buyprice=@1G WHERE entry = 42420;		-- Shadow Crystal Focusing Lens
UPDATE item_template SET buyprice=@1G WHERE entry = 42421;		-- Shadow Jade Focusing Lens
UPDATE item_template SET buyprice=@50G WHERE entry = 45861; 	-- Diamond-Tipped Cane
UPDATE item_template SET buyprice=@25G WHERE entry = 7340; 		-- Flawless Diamond Solitaire
UPDATE item_template SET buyprice=@25G WHERE entry = 38089;		-- Ruby Shades
UPDATE item_template SET buyprice=@50G WHERE entry = 7337; 		-- The Rock
UPDATE item_template SET buyprice=@10S WHERE entry = 18640; 	-- Happy Fun Rock

-- CHARACTER TRANSFORM
UPDATE item_template SET buyprice=@25G WHERE entry = 18258; 	-- Gordok Ogre Suit
UPDATE item_template SET buyprice=@25S WHERE entry = 44228; 	-- Baby Spice
UPDATE item_template SET buyprice=@25S WHERE entry = 44958; 	-- Ethereal Oil
UPDATE item_template SET buyprice=@25S WHERE entry = 13506; 	-- Potion of Petrification
UPDATE item_template SET buyprice=@25S WHERE entry = 43572; 	-- Magic Eater
UPDATE item_template SET buyprice=@25S WHERE entry = 40195; 	-- Pygmy Oil
UPDATE item_template SET buyprice=@25G WHERE entry = 31337; 	-- Orb of the Blackwhelp
UPDATE item_template SET buyprice=@25G WHERE entry = 35275; 	-- Orb of the Sindorei
UPDATE item_template SET buyprice=@25G WHERE entry = 45853; 	-- Rituals of the New Moon
UPDATE item_template SET buyprice=@25G WHERE entry = 32782; 	-- Time-Lost Figurine
UPDATE item_template SET buyprice=@100G WHERE entry = 19979; 	-- Hook of the Master Angler
UPDATE item_template SET buyprice=@25G WHERE entry = 5462; 		-- Dartol's Rod of Transformation
UPDATE item_template SET buyprice=@100G WHERE entry = 4388; 	-- Discombobulator Ray
UPDATE item_template SET buyprice=@100G WHERE entry = 52201;	-- Muradin's Favor
UPDATE item_template SET buyprice=@100G WHERE entry = 37254; 	-- Super Simian Sphere
UPDATE item_template SET buyprice=@25G WHERE entry = 49704; 	-- Carved Ogre Idol
UPDATE item_template SET buyprice=@25G WHERE entry = 23835; 	-- Gnomish Poultryizer
UPDATE item_template SET buyprice=@25G WHERE entry = 10716; 	-- Gnomish Shrink Ray
UPDATE item_template SET buyprice=@1G WHERE entry = 44818; 		-- Noblegarden Egg

-- SUMMON GUARDIANS
UPDATE item_template SET buyprice=@10G WHERE entry = 5332; 		-- Glowing Cat Figurine
UPDATE item_template SET buyprice=@10G WHERE entry = 10725; 	-- Gnomish Battle Chicken
UPDATE item_template SET buyprice=@50G WHERE entry = 40110; 	-- Haunted Momento
UPDATE item_template SET buyprice=@500G WHERE entry = 12185; 	-- Bloodsail Admiral's Hat
UPDATE item_template SET buyprice=@10G WHERE entry = 40492; 	-- Argent War Horn
UPDATE item_template SET buyprice=@25G WHERE entry = 14022; 	-- Barov Peasent Caller (H)
UPDATE item_template SET buyprice=@25G WHERE entry = 14023; 	-- Barov Peasent Called (A)
UPDATE item_template SET buyprice=@10G WHERE entry = 32864; 	-- Commander's Badge
UPDATE item_template SET buyprice=@10G WHERE entry = 32695; 	-- Captain's Badge
UPDATE item_template SET buyprice=@10G WHERE entry = 32694; 	-- Overseer's Badge
UPDATE item_template SET buyprice=@25S WHERE entry = 3456; 		-- Dog Whistle
UPDATE item_template SET buyprice=@15G WHERE entry = 38506; 	-- Don Carlo's Favorite Hat
UPDATE item_template SET buyprice=@15G WHERE entry = 16022; 	-- Arcanite Dragonling
UPDATE item_template SET buyprice=@15G WHERE entry = 4396; 		-- Mechanical Dragonling
UPDATE item_template SET buyprice=@10G WHERE entry = 35694; 	-- Khorium Boar
UPDATE item_template SET buyprice=@10G WHERE entry = 42418; 	-- Emerald Boar
UPDATE item_template SET buyprice=@10G WHERE entry = 24124; 	-- Felsteel Boar
UPDATE item_template SET buyprice=@10G WHERE entry = 50471; 	-- The Heartbreaker
UPDATE item_template SET buyprice=@10G WHERE entry = 54212; 	-- Instant Statue Pedestal
UPDATE item_template SET buyprice=@250G WHERE entry = 50966; 	-- Abracadaver
UPDATE item_template SET buyprice=@10G WHERE entry = 5218; 		-- Cleansed Timberling Heart
UPDATE item_template SET buyprice=@10G WHERE entry = 49490; 	-- Antilinuvian Cornerstone Grimiore
UPDATE item_template SET buyprice=@10G WHERE entry = 49308; 	-- Ancient Cornerstone Grimiore
UPDATE item_template SET buyprice=@15G WHERE entry = 34029; 	-- Tiny Voodoo Mask
UPDATE item_template SET buyprice=@15G WHERE entry = 13353; 	-- Book of the Dead

-- PLACE OBJECT ON GROUND
UPDATE item_template SET buyprice=@1G WHERE entry = 54438; 		-- Tiny Blue Ragdoll
UPDATE item_template SET buyprice=@1G WHERE entry = 44849; 		-- Tiny Green Ragdoll
-- UPDATE item_template SET buyprice=@250G WHERE entry = 34686; -- Brazier of Dancing Flames
UPDATE item_template SET buyprice=@15G WHERE entry = 33927; 	-- Brewfest Pony Keg
UPDATE item_template SET buyprice=@10G WHERE entry = 38578; 	-- Flag of Ownership
UPDATE item_template SET sellprice=@1G, buyprice=@2G WHERE entry = 44606; 		-- Tiny Train Set
UPDATE item_template SET buyprice=@5G WHERE entry = 34480; 		-- Romantic Picnic Basket 
UPDATE item_template SET buyprice=@1G WHERE entry = 44481; 		-- Grindgear Toy Gorilla
UPDATE item_template SET buyprice=@1G WHERE entry = 45047; 		-- Sandbox Tiger
UPDATE item_template SET buyprice=@5G WHERE entry = 46780; 		-- Ogre Pinata 
UPDATE item_template SET buyprice=@25G WHERE entry = 45063; 	-- Foam Sword Rack
UPDATE item_template SET buyprice=@25G WHERE entry = 38301; 	-- D.I.S.C.O.
UPDATE item_template SET buyprice=@25G WHERE entry = 33223; 	-- Fishing Chair
UPDATE item_template SET buyprice=@5G WHERE entry = 33219; 		-- Goblin Gumbo Kettle
UPDATE item_template SET buyprice=@25G WHERE entry = 32542; 	-- Imp in a Ball
UPDATE item_template SET buyprice=@25G WHERE entry = 21326; 	-- Defender of the Timbermaw

-- MISC/MULTIPLE EFFECTS
UPDATE item_template SET buyprice=@1G WHERE entry = 38518; 	    -- Cro's Apple 
UPDATE item_template SET buyprice=@1G WHERE entry = 43491; 	    -- Bad Clams
UPDATE item_template SET buyprice=@1G WHERE entry = 25679; 		-- Comfortable Insoles
UPDATE item_template SET buyprice=@1G WHERE entry = 43004; 	    -- Critter Bites
UPDATE item_template SET buyprice=@5G WHERE entry = 36863; 		-- Decahedral Dwarven Dice
UPDATE item_template SET buyprice=@1G WHERE entry = 12217; 	    -- Dragonbreath Chili
UPDATE item_template SET buyprice=@1G WHERE entry = 43492; 		-- Haunted Herring
UPDATE item_template SET buyprice=@1G WHERE entry = 44601; 		-- Heavy Copper Racer
UPDATE item_template SET buyprice=@1G WHERE entry = 18662; 		-- Heavy Leather Ball
UPDATE item_template SET buyprice=@1G WHERE entry = 43488; 	    -- Last Week's Mammoth
UPDATE item_template SET buyprice=@1G WHERE entry = 35720; 	    -- Lord of Frost's Private Label
UPDATE item_template SET buyprice=@1G WHERE entry = 37934; 		-- Noble' Elementium Signet
UPDATE item_template SET buyprice=@1G WHERE entry = 44792; 		-- Blossoming Branch
UPDATE item_template SET buyprice=@1G WHERE entry = 38266; 		-- Rotund Relic
-- UPDATE item_template SET buyprice=@25S WHERE entry = 17202; 	-- Snowball
UPDATE item_template SET buyprice=@25S WHERE entry = 43490; 	-- Tasty Cupcake
UPDATE item_template SET buyprice=@1G WHERE entry = 33081; 		-- Voodoo Skull
UPDATE item_template SET buyprice=@5G WHERE entry = 36862; 		-- Worn Troll Dice
-- UPDATE item_template SET buyprice=@100G WHERE entry = 52490;	-- Stardust
UPDATE item_template SET buyprice=@25S WHERE entry = 37604; 	-- Toothpick
UPDATE item_template SET buyprice=@3G WHERE entry = 44731; 		-- Bouquet of Ebon Roses
UPDATE item_template SET buyprice=@3G WHERE entry = 22206; 		-- Bouquet of Red Roses
UPDATE item_template SET buyprice=@5G WHERE entry = 18660; 		-- World Enlarger
UPDATE item_template SET buyprice=@5G WHERE entry = 18951; 		-- Evonice's Landin' Pilla
UPDATE item_template SET buyprice=@10G WHERE entry = 9492; 		-- Electromagnetic Gigaflux Reactivator
UPDATE item_template SET buyprice=@10G WHERE entry = 37313; 	-- Riding Crop
UPDATE item_template SET buyprice=@3G WHERE entry = 11122; 		-- Carrot on a Stick
UPDATE item_template SET buyprice=@1G WHERE entry = 43660; 		-- Fire Eater's Guide
UPDATE item_template SET buyprice=@25G WHERE entry = 13379; 	-- Piccolo of the Flaming Fire
UPDATE item_template SET buyprice=@1G WHERE entry = 44482; 	    -- Trusty Copper Racer
UPDATE item_template SET buyprice=@10G WHERE entry = 50741; 	-- Vile Fumigator's Mask
UPDATE item_template SET buyprice=@1G WHERE entry = 44599; 	    -- Zippy Copper Racer
UPDATE item_template SET buyprice=@10G WHERE entry = 54452; 	-- Etheral Portal
UPDATE item_template SET buyprice=@500G WHERE entry = 46349; 	-- Chef's Hat
UPDATE item_template SET buyprice=@1G WHERE entry = 38577; 		-- Party Grenade
UPDATE item_template SET buyprice=@1G WHERE entry = 54455; 		-- Paint Bomb
UPDATE item_template SET buyprice=@5G WHERE entry = 46779; 		-- Path of Cenarius
UPDATE item_template SET buyprice=@5G WHERE entry = 38233; 		-- Path of Illidan
UPDATE item_template SET buyprice=@1G WHERE entry = 34499; 	    -- Paper Flying Machine
UPDATE item_template SET buyprice=@100G WHERE entry = 54806; 	-- Frostscyth of Lord Ahune
-- UPDATE item_template SET buyprice=@100G WHERE entry = 64482; -- Puzzle Box of Yogg Saron 
UPDATE item_template SET buyprice=@25G WHERE entry = 52252; 	-- Tabard of the Lightbringer
UPDATE item_template SET buyprice=@10G WHERE entry = 40727; 	-- Gnomish Gravity Well

-- --------------------------------------------------------------------------------------
--	FISHING
-- --------------------------------------------------------------------------------------

-- BOOKS
UPDATE item_template SET sellprice=@5G, buyprice=@10G WHERE entry = 27532;			-- Book: Master Fishing
UPDATE item_template SET sellprice=@2G, buyprice=@5G WHERE entry = 16082;			-- Book: Artisan Fishing 
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry = 16083;			-- Book: Expert Fishing 

-- ENCHANTS
UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry = 50816;			-- Scroll Enchant Gloves: Angler 
UPDATE item_template SET sellprice=@5G, buyprice=@10G WHERE entry = 50406;			-- Formula Enchant Gloves: Angler
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry = 38802;			-- Enchant Gloves Fishing

-- POTIONS
UPDATE item_template SET sellprice=@25S, buyprice=@50S WHERE entry = 6372; 			-- Swim Speed Potion
UPDATE item_template SET sellprice=@10S, buyprice=@25S WHERE entry = 5996; 			-- Elixer of Water Breathing
UPDATE item_template SET sellprice=@25S, buyprice=@1G WHERE entry = 18294; 			-- Elixer of Greater Water Breathing
UPDATE item_template SET sellprice=@10S, buyprice=@25S WHERE entry = 8827; 			-- Elixer of Water Walking

-- SPECIAL
UPDATE item_template SET sellprice=@5G, buyprice=@25G WHERE entry = 19979;			-- Hook of the Master Angler 
UPDATE item_template SET sellprice=@5G, buyprice=@50G WHERE entry = 33223;			-- Fishing Chair

-- VANITY
-- UPDATE item_template SET sellprice=@50G, buyprice=@50G WHERE entry = 1827;		-- Meat Cleaver
-- UPDATE item_template SET sellprice=@50G, buyprice=@50G WHERE entry = 2763; 		-- Fisherman's Knife

-- CLOTHING
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry = 7996;			-- Worn Fishing Hat 
UPDATE item_template SET sellprice=@1G, buyprice=@2G WHERE entry = 19972;			-- Lucky Fishing Hat
-- UPDATE item_template SET sellprice=@50G, buyprice=@50G WHERE entry = 3563; 		-- Seafarer's Pantaloons
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 7052; 			-- Azure Silk Belt
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry =  50287;			-- Boots of the Bay
UPDATE item_template SET sellprice=@2G, buyprice=@5G WHERE entry = 19969;			-- Nat Pagle's Extreme Anglin' Boots 
UPDATE item_template SET sellprice=@1G, buyprice=@2G WHERE entry = 6263; 			-- Blue Overalls
-- UPDATE item_template SET sellprice=@50G, buyprice=@50G WHERE entry = 3342; 		-- Captain Sander's Shirt
-- UPDATE item_template SET sellprice=@50G, buyprice=@50G WHERE entry = 4509; 		-- Seawolf Gloves
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry = 792; 			-- Knitted Sandals
UPDATE item_template SET sellprice=@5G, buyprice=@10G WHERE entry = 33820;			-- Weather Beaten Fishing Hat 
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry =  7348; 			-- Fletcher's Gloves
UPDATE item_template SET sellprice=@50S, buyprice=@1G WHERE entry =  36019; 		-- Aerie Belt of Nature Protection

-- FISHING POLES
UPDATE item_template SET sellprice=@50G, buyprice=@250G WHERE entry = 19970;		-- Arcanite Fishing Pole 
UPDATE item_template SET sellprice=@50G, buyprice=@250G WHERE entry = 44050;		-- Mastercraft Kaluak Fishing Pole 
UPDATE item_template SET sellprice=@50G, buyprice=@250G WHERE entry = 45992;		-- Jeweled Fishing Pole 
UPDATE item_template SET sellprice=@25G, buyprice=@100G WHERE entry = 25978;		-- Seth's Graphite Fishing Pole 
UPDATE item_template SET sellprice=@25G, buyprice=@100G WHERE entry = 19022;		-- Nat Pagle's Extreme Angler FC-5000
UPDATE item_template SET sellprice=@25G, buyprice=@100G WHERE entry = 45991;		-- Bone Fishing Pole 
UPDATE item_template SET sellprice=@5G, buyprice=@50G WHERE entry = 45858;			-- Nat's Lucky Fishing Pole 
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 12225;			-- Blump Family Fishing Pole
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 6367;			-- Big Iron Fishing Pole
UPDATE item_template SET sellprice=@1G, buyprice=@15G WHERE entry = 6365;			-- Strong Fishing Pole
UPDATE item_template SET sellprice=@5G, buyprice=@50G WHERE entry = 6366;			-- Darkwood Fishing Pole
-- UPDATE item_template SET sellprice=@5S, buyprice=@25S WHERE entry = 6256;		-- Fishing Pole 
-- UPDATE item_template SET sellprice=@50G, buyprice=@50G WHERE entry = 45120;		-- Basic Fishing Pole

-- FISHING LINE
UPDATE item_template SET sellprice=@1G, buyprice=@2G WHERE entry = 34836;			-- Trusilver Spun Fishing Line 
UPDATE item_template SET sellprice=@2G, buyprice=@5G WHERE entry = 19971;			-- High Test Eternium Fishing Line 
	
-- LURES	
UPDATE item_template SET sellprice=@1G, buyprice=@2G WHERE entry = 7307; 			-- Flesh Eating Worm
UPDATE item_template SET sellprice=@1G, buyprice=@2G WHERE entry = 46006; 			-- Glow Worm
UPDATE item_template SET sellprice=@1G, buyprice=@2G WHERE entry = 34861; 			-- Sharpened Fishing Hook
UPDATE item_template SET sellprice=@75S, buyprice=@75S WHERE entry = 6811; 			-- Aquadynamic Fish Lens
UPDATE item_template SET sellprice=@25S, buyprice=@25S WHERE entry = 6533; 			-- Aquadynamic Fish Attractor
UPDATE item_template SET sellprice=@5S, buyprice=@5S WHERE entry = 6532; 			-- Bright Baubles
UPDATE item_template SET sellprice=@1S, buyprice=@1S WHERE entry = 6530; 			-- Nightcrawlers
UPDATE item_template SET sellprice=@1S, buyprice=@1S WHERE entry = 6529; 			-- Shiny Bauble
	
-- ANGLIN'	
UPDATE item_template SET sellprice=@50S, buyprice=@50S WHERE entry = 34832; 		-- Captain Rumsey's Lager
-- UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 18229;			-- Nat Pagle's Guide to Extreme Anglin' 

-- --------------------------------------------------------------------------------------
--	BOOKS
-- --------------------------------------------------------------------------------------

UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 18364; 	-- The Emerald Dream
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 1108; 	-- Faded Photograph 
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 18229; 	-- Nat Pagel's Guide to Extreme Anglin'
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 18365; 	-- A Thoroughly Read Copy of Nat's Anglin'
UPDATE item_template SET sellprice=@5G, buyprice=@5G WHERE entry = 18228; 	-- Autographed Picture of Tigole and Furor
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 20010; 	-- The Horde's Hellscream
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 19484; 	-- The Frostwolf Artichoke
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 19483; 	-- Peelin' The Onion
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 11482; 	-- Crystal Pilon User's Manual
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 19851; 	-- Grom's Tribute
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 39317; 	-- News from the North
UPDATE item_template SET sellprice=@2G, buyprice=@2G WHERE entry = 29571; 	-- A Steamy Romance Novel
UPDATE item_template SET sellprice=@2G, buyprice=@2G WHERE entry = 37467; 	-- A Steamy Romance Novel
UPDATE item_template SET sellprice=@2G, buyprice=@2G WHERE entry = 46023; 	-- A Steamy Romance Novel
UPDATE item_template SET sellprice=@2G, buyprice=@2G WHERE entry = 54291; 	-- A Steamy Romance Novel

-- --------------------------------------------------------------------------------------
--	ENGINEERING
-- --------------------------------------------------------------------------------------  
        
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 46709; -- Mini-Zep Controller
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 35227; 	-- Gnomish Weather Generator
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 30542; 	-- Dimensional Ripper Area-52
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 18984; 	-- Dimensional Ripper Everlook 
UPDATE item_template SET sellprice=@1G, buyprice=@40G WHERE entry = 37863; 	-- Direbrew's Remote
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 40768; 	-- MOLL-E
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 48933; 	-- Wormhole Generator: Northrend
UPDATE item_template SET sellprice=@1G, buyprice=@25G WHERE entry = 49040; 	-- Jeeves
UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry = 40772; 	-- Gnomish Army Knife

-- --------------------------------------------------------------------------------------
--	FOOD
-- --------------------------------------------------------------------------------------

-- UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 21024;		  -- Chimaerok Tenderloin

-- --------------------------------------------------------------------------------------
--	POTION/ELIXER/FLASK
-- --------------------------------------------------------------------------------------

UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 3386; 		  -- Potion of Curing
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 13462; 	  -- Purification Potion
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 6372; 		  -- Swim Speed Potion
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 5634; 		  -- Free Action Potion
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 12820; 	  -- Winterfall Firewater
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 2459; 		  -- Swiftness Potion
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 34130; 	  -- Diver's Recovery Potion
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 37449; 	  -- Breath of Murloc
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 23871; 	  -- Potion of Water Breathing 30m 
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 8411; 		  -- Lung Juice Cocktail 
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 8412; 		  -- Ground Scorpok Assay
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 8410; 		  -- ROIDS 
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 20079; 	  -- Spirit of Zanza
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 20080; 	  -- Sheen of Zanza
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 20081; 	  -- Swiftness of Zanza
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 8423; 		  -- Cerebral Cortex Compound 
UPDATE item_template SET sellprice=@10S, buyprice=@10S WHERE entry = 8424; 		  -- Gizzard Gum 

UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 32840; 	  -- Major Arcane Protection
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 32844; 	  -- Major Nature Protection
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 32847; 	  -- Major Frost Protection
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 32846; 	  -- Major Fire Protection
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 32845; 	  -- Major Shadow Protection
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 23578; 	  -- McWeakSauce
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 23579; 	  -- McWeakSauce
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 39327; 	  -- Noth's Special Brew 
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 32947; 	  -- Auchenai Healing Potion 
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 32948; 	  -- Auchenai Mana Potion 
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 38351; 	  -- Murliver Oil 
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 33935; 	  -- Crystal Mana Potion 
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 33934; 	  -- Crystal Healing Potion 
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 45008; 	  -- Jilians Tonic of Stoneblood
UPDATE item_template SET sellprice=@15S, buyprice=@15S WHERE entry = 31838; 	  -- Major Combat Healing Potion

UPDATE item_template SET sellprice=@20S, buyprice=@20S WHERE entry = 47499;		  -- Flask of the North 
UPDATE item_template SET sellprice=@20S, buyprice=@20S WHERE entry = 25539;		  -- Potion of Water Breathing 1h

UPDATE item_template SET sellprice=@25G, buyprice=@250G WHERE entry = 43569; 	  -- Endless Healing Potion 
UPDATE item_template SET sellprice=@25G, buyprice=@250G WHERE entry = 43570; 	  -- Endless Mana Potion 
UPDATE item_template SET sellprice=@25G, buyprice=@250G WHERE entry = 44728; 	  -- Endless Rejuvination Potion 

-- --------------------------------------------------------------------------------------
--	CLOTHING
-- --------------------------------------------------------------------------------------

UPDATE item_template SET sellprice=@1C, buyprice=@1C WHERE entry = 6833; 			-- White Tuxedo Shirt 
UPDATE item_template SET sellprice=@1C, buyprice=@1C WHERE entry = 6835; 			-- Black Tuxedo Pants 
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 52019; 		-- Precious's Ribbon 
UPDATE item_template SET sellprice=@1G, buyprice=@15000G WHERE entry = 45280; 		-- Shirt of Uber
UPDATE item_template SET sellprice=@1G, buyprice=@15000G WHERE entry = 46104; 		-- Shirt of the Yogg Slayer

-- --------------------------------------------------------------------------------------
--	GOODS VENDORS
-- --------------------------------------------------------------------------------------
UPDATE item_template SET sellprice=@18G, buyprice=@18G WHERE entry = 36914;   --  
UPDATE item_template SET sellprice=@18G, buyprice=@18G WHERE entry = 36915;   --  
UPDATE item_template SET sellprice=@30G, buyprice=@30G WHERE entry = 37706;   --  
UPDATE item_template SET sellprice=@100G, buyprice=@100G WHERE entry = 18562; --  
UPDATE item_template SET sellprice=@100G, buyprice=@100G WHERE entry = 17203; --  
UPDATE item_template SET sellprice=@250G, buyprice=@250G WHERE entry = 17771; --  
UPDATE item_template SET sellprice=@50G, buyprice=@50G WHERE entry = 12655;   --  
UPDATE item_template SET sellprice=@40G, buyprice=@40G WHERE entry = 30183;   --  
UPDATE item_template SET sellprice=@40G, buyprice=@40G WHERE entry = 23572;   --  

-- --------------------------------------------------------------------------------------
--	GEMS
-- --------------------------------------------------------------------------------------
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 38456; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44066; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28120; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 27679; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28119; -- 
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 38545; -- 
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 38546; -- 
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 38547; -- 
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 38548; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 38549; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28360; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28362; --
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28118; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 27777; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32636; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32634; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 34256; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32635; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32639; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 27786; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 27785; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32638; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32637; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28363; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28123; --
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28556; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 28557; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32641; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 32640; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44089; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44088; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44087; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44084; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44082; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44081; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44076; --  
UPDATE item_template SET sellprice=@1G, buyprice=@1G WHERE entry = 44078; --  

-- --------------------------------------------------------------------------------------
--	TABARDS
-- --------------------------------------------------------------------------------------

-- UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry = 35280; 	-- Tabard of Summer Flames
-- UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry = 35279; 	-- Tabard of Summer Skies
-- UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry = 45584; 	-- Thunder Bluff Tabard
-- UPDATE item_template SET sellprice=@5G, buyprice=@50G WHERE entry = 46874; 	-- Argent Crusader's Tabard
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '5976';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '11364';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '15196';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '15197';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '15198';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '15199';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '19031';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '19032';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '19160';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '19505';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '19506';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '20131';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '20132';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '22999';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '23192';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '23999';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '24004';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '24344';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '25549';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '28788';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31279';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31404';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31405';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31773';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31774';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31775';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31776';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31777';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31778';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31779';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31780';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31781';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '31804';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '32445';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '32828';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '35221';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '35279';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '35280';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '36941';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '40643';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '43154';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '43155';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '43156';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '43157';
-- UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry = '43300';
-- UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry = '43348';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '43349';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45574';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45577';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45578';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45579';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45580';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45581';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45582';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45583';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45584';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45585';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '45983';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '46817';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '46818';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '46874';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '49052';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '49054';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '49086';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '51534';
UPDATE item_template SET sellprice=@2G, buyprice=@3G WHERE entry = '52252';

-- --------------------------------------------------------------------------------------
--	FIREWORKS
-- --------------------------------------------------------------------------------------

UPDATE item_template SET buyprice=@50S WHERE entry = 21745; 	-- Elder's Moonstone
UPDATE item_template SET buyprice=@1G WHERE entry = 21744; 		-- Lucky Rocket Cluster
UPDATE item_template SET buyprice=@2G WHERE entry = 21570; 		-- Cluster Launcher
UPDATE item_template SET buyprice=@10S WHERE entry = 34599; 	-- Juggling Torch


-- --------------------------------------------------------------------------------------
--	ETHEREAL SOUL TRADER PRICES
-- --------------------------------------------------------------------------------------
/*
UPDATE item_template SET buyprice=@75S WHERE entry = 38291; 	-- Etheral Mutagen
UPDATE item_template SET buyprice=@50S WHERE entry = 38294; 	-- Ethereal Liquour
UPDATE item_template SET buyprice=@25S WHERE entry = 38300; 	-- Diluted Etheraum Essence
UPDATE item_template SET buyprice=@50S WHERE entry = 38308; 	-- Ethereal Essence Sphere
UPDATE item_template SET sellprice=@10S WHERE entry = 38291; 	-- Etheral Mutagen
UPDATE item_template SET sellprice=@5S WHERE entry = 39294; 	-- Ethereal Liquour
UPDATE item_template SET sellprice=@1S WHERE entry = 38300; 	-- Diluted Etheraum Essence
UPDATE item_template SET sellprice=@5S WHERE entry = 38308; 	-- Ethereal Essence Sphere
*/

-- --------------------------------------------------------------------------------------
--	FISHING PRICES
-- --------------------------------------------------------------------------------------

-- Achievement
UPDATE item_template SET sellprice=@25G WHERE entry = 34486; 	-- Old Crafty
UPDATE item_template SET sellprice=@25G WHERE entry = 34484; 	-- Old Ironjaw
-- Items
UPDATE item_template SET sellprice=@25S WHERE entry = 6651; 	-- Broken Wine Bottle
UPDATE item_template SET sellprice=@50S WHERE entry = 27442; 	-- Goldenscale Vendorfish
UPDATE item_template SET sellprice=@50S WHERE entry = 6360; 	-- Steelscale Crushfish
UPDATE item_template SET sellprice=@50S WHERE entry = 19808; 	-- Rockhide Strongfish
UPDATE item_template SET sellprice=@50S WHERE entry = 44703; 	-- Dark Herring
UPDATE item_template SET sellprice=@50S WHERE entry = 44505; 	-- Dustbringer
-- Mud Snapper
UPDATE item_template SET sellprice=@50S WHERE entry = 6292; 	-- 10 Mud Snapper
UPDATE item_template SET sellprice=@1G WHERE entry = 6294; 		-- 12 Mud Snapper
UPDATE item_template SET sellprice=@2G WHERE entry = 6295; 		-- 15 Mud Snapper
-- Catfish
UPDATE item_template SET sellprice=@50S WHERE entry = 6309; 	-- 17 Catfish
UPDATE item_template SET sellprice=@50S WHERE entry = 6310; 	-- 19 Catfish
UPDATE item_template SET sellprice=@1G WHERE entry = 6311; 		-- 22 Catfish
UPDATE item_template SET sellprice=@2G WHERE entry = 6363; 		-- 26 Catfish
UPDATE item_template SET sellprice=@5G WHERE entry = 6364; 		-- 32 Catfish
-- Grouper
UPDATE item_template SET sellprice=@50S WHERE entry = 13876; 	-- 40 Grouper
UPDATE item_template SET sellprice=@50S WHERE entry = 13877; 	-- 47 Grouper
UPDATE item_template SET sellprice=@1G WHERE entry = 13878; 	-- 53 Grouper
UPDATE item_template SET sellprice=@2G WHERE entry = 13879; 	-- 59 Grouper
UPDATE item_template SET sellprice=@10G WHERE entry = 13880; 	-- 68 Grouper
-- Redgill
UPDATE item_template SET sellprice=@50S WHERE entry = 13885; 	-- 34 Redgill
UPDATE item_template SET sellprice=@50S WHERE entry = 13886; 	-- 37 Redgill
UPDATE item_template SET sellprice=@50S WHERE entry = 13882; 	-- 42 Redgill
UPDATE item_template SET sellprice=@1G WHERE entry = 13883; 	-- 45 Redgill
UPDATE item_template SET sellprice=@2G WHERE entry = 13884; 	-- 49 Redgill
UPDATE item_template SET sellprice=@10G WHERE entry = 13887; 	-- 52 Redgill
-- Salmon
UPDATE item_template SET sellprice=@50S WHERE entry = 13901; 	-- 15 Salmon
UPDATE item_template SET sellprice=@50S WHERE entry = 13902; 	-- 18 Salmon
UPDATE item_template SET sellprice=@50S WHERE entry = 13903; 	-- 22 Salmon
UPDATE item_template SET sellprice=@1G WHERE entry = 13904; 	-- 25 Salmon
UPDATE item_template SET sellprice=@2G WHERE entry = 13905; 	-- 29 Salmon
UPDATE item_template SET sellprice=@10G WHERE entry = 13906; 	-- 32 Salmon
-- Lobster
UPDATE item_template SET sellprice=@50S WHERE entry = 13907; 	--  7 Lobster
UPDATE item_template SET sellprice=@50S WHERE entry = 13908; 	--  9 Lobster
UPDATE item_template SET sellprice=@50S WHERE entry = 13909; 	-- 12 Lobster
UPDATE item_template SET sellprice=@50S WHERE entry = 13910; 	-- 15 Lobster
UPDATE item_template SET sellprice=@1G WHERE entry = 13911; 	-- 19 Lobster
UPDATE item_template SET sellprice=@2G WHERE entry = 13912; 	-- 21 Lobster
UPDATE item_template SET sellprice=@10G WHERE entry = 13913; 	-- 22 Lobster
-- Mightfish
UPDATE item_template SET sellprice=@50S WHERE entry = 13914; 	--  70 Mightfish
UPDATE item_template SET sellprice=@1G WHERE entry = 13915; 	--  85 Mightfish
UPDATE item_template SET sellprice=@2G WHERE entry = 13916; 	--  92 Mightfish
UPDATE item_template SET sellprice=@10G WHERE entry = 13917; 	-- 103 Mightfish

-- --------------------------------------------------------------------------------------
--  CURRENCY PRICES
-- --------------------------------------------------------------------------------------

 -- HOLIDAY
UPDATE item_template SET sellprice=@1G, buyprice=@30G WHERE entry = 37829; 	    -- Brewfest Prize Token
 
 -- CRAFT
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 24245; 	    -- Glowcap
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 28558; 	    -- Spirit Shard 
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 29736; 	    -- Arcane Rune  
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 29735; 	    -- Holy Dust 
UPDATE item_template SET sellprice=@10G, buyprice=@20G WHERE entry = 41596; 	-- Dalaran Jewelcrafter's Token
UPDATE item_template SET sellprice=@10G, buyprice=@20G WHERE entry = 43016; 	-- Dalaran Cooking Award

-- BG/PVP
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 26044; 	    -- Halaa Research Token
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 26045; 	    -- Halaa Battle Token
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 20558; 	    -- Warsong Gulch Mark of Honor
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 20559; 	    -- Arathi Basin Mark of Honor
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 20560; 	    -- Alterac Valley Mark of Honor
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 29024; 	    -- Eye of the Storm Mark of Honor
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 24579; 	    -- Mark of Honor Hold
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 24581; 	    -- Mark of Thrallmar
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 47395; 	    -- Isle of Conquest Mark of Honor
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 42425; 	    -- Strand of the Ancients Mark of Honor
UPDATE item_template SET sellprice=@1G, buyprice=@100G WHERE entry = 43589; 	    -- Wintergrasp Mark of Honor

-- DUNGEON/RAID
UPDATE item_template SET sellprice=@1G, buyprice=@10G WHERE entry = 43228; 	    -- Stone Keeper's Shard
UPDATE item_template SET sellprice=@5G, buyprice=@500G WHERE entry = 40752; 	    -- Emblem of Heroism (Heirloom)
UPDATE item_template SET sellprice=@10G, buyprice=@100G WHERE entry = 29434;     -- Badge of Justice (Legacy)
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 44990;     -- Champion's Seal (i200)
UPDATE item_template SET sellprice=@20G, buyprice=@350G WHERE entry = 40753;	    -- Emblem of Valor (i213)
UPDATE item_template SET sellprice=@20G, buyprice=@500G WHERE entry = 45624;     -- Emblem of Conquest(i213)
UPDATE item_template SET sellprice=@30G, buyprice=@750G WHERE entry = 47241;     -- Emblem of Triumph (i232)
UPDATE item_template SET sellprice=@40G, buyprice=@1250G WHERE entry = 47557;     -- Grand Regalia of the Grand Protector (i258)
UPDATE item_template SET sellprice=@40G, buyprice=@1250G WHERE entry = 47558;     -- Grand Regalia of the Grand Conquorer (i258)
UPDATE item_template SET sellprice=@40G, buyprice=@1250G WHERE entry = 47559;     -- Grand Regalia of the Grand Vanquisher (i258)
UPDATE item_template SET sellprice=@50G, buyprice=@1500G WHERE entry = 49426;     -- Emblem of Frost (i264)


-- --------------------------------------------------------------------------------------
--	HEIRLOOM PRICES
-- --------------------------------------------------------------------------------------

-- WEAPON 2H
UPDATE item_template SET buyprice=@500G WHERE entry = 42943;  	-- Bloodied Arcanite Reaper
UPDATE item_template SET buyprice=@350G WHERE entry = 42946;  	-- Charmed Ancient Bone Bow
UPDATE item_template SET buyprice=@500G WHERE entry = 42947;  	-- Dignified Headmaster's Charge
UPDATE item_template SET buyprice=@500G WHERE entry = 44092;  	-- Reforged Truesilver Champion
UPDATE item_template SET buyprice=@350G WHERE entry = 44093;  	-- Upgraded Dwarven Hand Cannon
UPDATE item_template SET buyprice=@500G WHERE entry = 44095;  	-- Grand Staff of Jordan
UPDATE item_template SET buyprice=@500G WHERE entry = 48718;  	-- Repurposed Lava Dredger

-- WEAPON 1H
UPDATE item_template SET buyprice=@250G WHERE entry = 42944;  	-- Balanced Heartseeker
UPDATE item_template SET buyprice=@350G WHERE entry = 42945;  	-- Venerable Dal'Rend's Sacred Charge
UPDATE item_template SET buyprice=@350G WHERE entry = 42948;  	-- Devout Aurastone Hammer
UPDATE item_template SET buyprice=@250G WHERE entry = 44091;  	-- Sharpened Scarlet Kris
UPDATE item_template SET buyprice=@350G WHERE entry = 44094;  	-- The Blessed Hammer of Grace
UPDATE item_template SET buyprice=@350G WHERE entry = 44096;  	-- Battleworn Thrash Blade
UPDATE item_template SET buyprice=@350G WHERE entry = 48716;  	-- Venerable Mass of McGowan

-- Shoulder
UPDATE item_template SET buyprice=@250G WHERE entry = 42950; 	-- Champion Herod's Shoulder
UPDATE item_template SET buyprice=@250G WHERE entry = 42951; 	-- Mystical Pauldrons of Elements
UPDATE item_template SET buyprice=@250G WHERE entry = 42952; 	-- Stained Shadowcraft Spaulders
UPDATE item_template SET buyprice=@250G WHERE entry = 42984; 	-- Preened Ironfeather Shoulders
UPDATE item_template SET buyprice=@250G WHERE entry = 42985; 	-- Tattered Dreadmist Mantle
UPDATE item_template SET buyprice=@250G WHERE entry = 42949; 	-- Polished Spaulders of Valor
UPDATE item_template SET buyprice=@250G WHERE entry = 44099; 	-- Strengthened Stockade Pauldrons
UPDATE item_template SET buyprice=@250G WHERE entry = 44100; 	-- Pristine Lightforge Spaulders
UPDATE item_template SET buyprice=@250G WHERE entry = 44101; 	-- Prized Beastmaster's Mantle
UPDATE item_template SET buyprice=@250G WHERE entry = 44102; 	-- Aged Pauldrons of The Five Thunders
UPDATE item_template SET buyprice=@250G WHERE entry = 44103; 	-- Exceptional Stormshroud Shoulders
UPDATE item_template SET buyprice=@250G WHERE entry = 44105; 	-- Lasting Feralheart Spaulders
UPDATE item_template SET buyprice=@250G WHERE entry = 44107; 	-- Exquisite Sunderseer Mantle

-- Breastplate/Robe
UPDATE item_template SET buyprice=@250G WHERE entry = 48677; 	-- Champion's Deathdealer Breastplate
UPDATE item_template SET buyprice=@250G WHERE entry = 48685; 	-- Polished Breastplate of Valor
UPDATE item_template SET buyprice=@250G WHERE entry = 48687; 	-- Preened Ironfeather Breastplate
UPDATE item_template SET buyprice=@250G WHERE entry = 48689; 	-- Stained Shadowcraft Tunic
UPDATE item_template SET buyprice=@250G WHERE entry = 48683; 	-- Mystical Vest of Elements
UPDATE item_template SET buyprice=@250G WHERE entry = 48691; 	-- Tattered Dreadmist Robe

-- Trinket
UPDATE item_template SET buyprice=@250G WHERE entry = 42991;  	-- Swift Hand of Justice
UPDATE item_template SET buyprice=@250G WHERE entry = 42992;  	-- Discerning Eye of the Beast
UPDATE item_template SET buyprice=@150G WHERE entry = 44097;  	-- Inherited Insignia of the Horde
UPDATE item_template SET buyprice=@150G WHERE entry = 44098;  	-- Inherited Insignia of the Alliance

-- Ring
UPDATE item_template SET buyprice=@250G WHERE entry = 50255;  	-- Dread Pirate Ring

-- --------------------------------------------------------------------------------------
-- PET PRICES
-- --------------------------------------------------------------------------------------

-- PET TOOLS
UPDATE item_template SET buyprice=@1S WHERE entry = 37460; 	              --  Rope Pet Leash
UPDATE item_template SET buyprice=@1S WHERE entry = 44820; 	              --  Red Ribbon Pet Leash
UPDATE item_template SET buyprice=@1S WHERE entry=43626;	              --  Happy Pet Snack
UPDATE item_template SET buyprice=@5S WHERE entry=35223;	              --  Papa Hummel's Old Fashioned Pet Buscuit
UPDATE item_template SET buyprice=@1S WHERE entry=37431;	              --  Fetch Ball
UPDATE item_template SET buyprice=@2S WHERE entry=43352;	              --  Pet Grooming Kit
UPDATE item_template SET buyprice=@1S WHERE entry=22200; 	              --  Silver Shafted Arrow
UPDATE item_template SET buyprice=@1G WHERE entry=47541; 	              --  Argent Pony Bridle

-- MECHANICAL
UPDATE item_template SET sellprice=@5G, buyprice=@5G WHERE entry=4401;     	--  Mechanical Squirrel Box
UPDATE item_template SET sellprice=@5G, buyprice=@5G WHERE entry=10398;    	--  Mechanical Chicken
UPDATE item_template SET sellprice=@5G, buyprice=@5G WHERE entry=11825;    	--  Pet Bombling
UPDATE item_template SET sellprice=@5G, buyprice=@5G WHERE entry=11826; 	--  Lil' Smoky
UPDATE item_template SET sellprice=@5G, buyprice=@5G WHERE entry=15996;  	--  Lifelike Mechanical Toad
UPDATE item_template SET sellprice=@5G, buyprice=@5G WHERE entry=21277;  	--  Tranquil Mechanical Yeti
UPDATE item_template SET buyprice=@10G WHERE entry=54847;                	--  Lil' XT
UPDATE item_template SET buyprice=@10G WHERE entry=56806;                	--  Mini Thor
UPDATE item_template SET buyprice=@5G WHERE entry=54436;                	--  Blue Clockwork Rocket Bot
UPDATE item_template SET buyprice=@5G WHERE entry=34425;                	--  Clockwork Rocket Bot
UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry=34492;     --  Rocket Chicken
UPDATE item_template SET sellprice=@1G, buyprice=@5G WHERE entry=44972;     --  Alarming Clockbot NOT IN USE
UPDATE item_template SET buyprice=@10G WHERE entry=45942;                	--  XS-001 Constructor Bot
UPDATE item_template SET buyprice=@10G WHERE entry=46767;                	--  Warbot Ignition Key
UPDATE item_template SET buyprice=@10G WHERE entry=45002;                	--  Mechanopeep

-- CATS
UPDATE item_template SET buyprice=@5G WHERE entry=8485;                  --  Cat Carrier Bombay
UPDATE item_template SET buyprice=@5G WHERE entry=8486;                  --  Cat Carrier Cornish Rex
UPDATE item_template SET buyprice=@5G WHERE entry=8487;                  --  Cat Carrier Orange Tabby
UPDATE item_template SET buyprice=@5G WHERE entry=8488;                  --  Cat Carrier Silver Tabby
UPDATE item_template SET buyprice=@5G WHERE entry=8489;                  --  Cat Carrier White Kitten
UPDATE item_template SET buyprice=@5G WHERE entry=8490;                  --  Cat Carrier Siamese
UPDATE item_template SET buyprice=@5G WHERE entry=8491;                  --  Cat Carrier Black Tabby
UPDATE item_template SET buyprice=@10G WHERE entry=46398;                --  Cat Carrier Calico Cat
UPDATE item_template SET buyprice=@25G WHERE entry=11903;                --  Cat Carrier Corrupted Kitten

-- BIRDS
UPDATE item_template SET buyprice=@10G WHERE entry=8492;                 --  Parrot Cage Green Wing Macaw
UPDATE item_template SET buyprice=@5G WHERE entry=8495;                  --  Parrot Cage Senegal
UPDATE item_template SET buyprice=@5G WHERE entry=8496;                  --  Parrot Cage Cockatiel
UPDATE item_template SET buyprice=@5G WHERE entry=8497;                  --  Rabbit Crate Snowshoe
UPDATE item_template SET buyprice=@5G WHERE entry=29364;                 --  Brown Rabbit Crate
UPDATE item_template SET buyprice=@5G WHERE entry=39896;                 --  Tickbird Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=39899;                 --  White Tickbird Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=8500;                  --  Great Horned Owl
UPDATE item_template SET buyprice=@5G WHERE entry=8501;                  --  Hawk Owl

-- SNAKES
UPDATE item_template SET buyprice=@5G WHERE entry=10360;                  --  Black Kingsnake
UPDATE item_template SET buyprice=@5G WHERE entry=10361;                  --  Brown Snake
UPDATE item_template SET buyprice=@5G WHERE entry=10392;                  --  Crimson Snake
UPDATE item_template SET buyprice=@5G WHERE entry=44822;                  --  Albino Snake
UPDATE item_template SET buyprice=@5G WHERE entry=39898;                  --  Cobra Hatchling

-- FROGS
UPDATE item_template SET buyprice=@5G WHERE entry=11026;                  --  Tree Frog Box
UPDATE item_template SET buyprice=@5G WHERE entry=11027;                  --  Wood Frog Box
UPDATE item_template SET buyprice=@25G WHERE entry=33993;                 --  Mojo

-- MOTHS
UPDATE item_template SET buyprice=@5G WHERE entry=29901;                 --  Blue Moth Egg
UPDATE item_template SET buyprice=@5G WHERE entry=29902;                 --  Red Moth Egg
UPDATE item_template SET buyprice=@5G WHERE entry=29903;                 --  Yellow Moth Egg
UPDATE item_template SET buyprice=@5G WHERE entry=29904;                 --  White Moth Egg

-- CRITTERS
-- UPDATE item_template SET buyprice=@25S WHERE entry=10393;            --  Cockroach
-- UPDATE item_template SET buyprice=@5G WHERE entry=11110;             --  Chicken Egg
-- UPDATE item_template SET buyprice=@5G WHERE entry=11023;             --  Ancona Chicken
-- UPDATE item_template SET buyprice=@1G WHERE entry=10394;             --  Prairie Dog Whistle
UPDATE item_template SET buyprice=@5G WHERE entry=44794;                --  Spring Rabbit's Foot
UPDATE item_template SET buyprice=@5G WHERE entry=22781;                --  Polar Bear Collar
UPDATE item_template SET buyprice=@5G WHERE entry=23007;                --  Piglet's Collar
UPDATE item_template SET buyprice=@5G WHERE entry=23712;                --  White Tiger Cub
UPDATE item_template SET buyprice=@5G WHERE entry=23713;                --  Hippogryph Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=29363;                --  Mana Wyrmling
UPDATE item_template SET buyprice=@5G WHERE entry=46820;                --  Shimmering Wyrmling
UPDATE item_template SET buyprice=@5G WHERE entry=32588;                --  Banana Charm
UPDATE item_template SET buyprice=@5G WHERE entry=32622;                --  Elekk Training Collar
UPDATE item_template SET buyprice=@5G WHERE entry=38628;                --  Nether Ray Fry
UPDATE item_template SET buyprice=@5G WHERE entry=38658;                --  Vampiric Batling
UPDATE item_template SET buyprice=@5G WHERE entry=44723;                --  Nurtured Penguin Egg
UPDATE item_template SET buyprice=@10G WHERE entry=41133;               --  Unhatched Mr. Chilly
UPDATE item_template SET buyprice=@5G WHERE entry=43517;                --  Penguin Egg
UPDATE item_template SET buyprice=@5G WHERE entry=44810;                --  Turkey Cage
UPDATE item_template SET buyprice=@10G WHERE entry=44819;               --  Baby Blizzard Bear
UPDATE item_template SET buyprice=@100G WHERE entry=44841;              --  Little Fawn's Salt Lick
UPDATE item_template SET buyprice=@5G WHERE entry=46544;                --  Curious Wolvar Pup
UPDATE item_template SET buyprice=@5G WHERE entry=46545;                --  Curious Oracle Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=49662;                --  Gryphon Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=49663;                --  Wind Rider Cub
UPDATE item_template SET buyprice=@10G WHERE entry=49912;               --  Perky Pug
UPDATE item_template SET buyprice=@10G WHERE entry=44983;               --  Strand Crawler
UPDATE item_template SET buyprice=@5G WHERE entry=21168;                --  Baby Shark

-- ZONE
UPDATE item_template SET buyprice=@10G WHERE entry=44984;                --  Ammen Vale Lashling
UPDATE item_template SET buyprice=@10G WHERE entry=44970;                --  Dun Morogh Cub
UPDATE item_template SET buyprice=@10G WHERE entry=44971;                --  Tirisfal Batling
UPDATE item_template SET buyprice=@10G WHERE entry=44973;                --  Durotar Scorpion
UPDATE item_template SET buyprice=@10G WHERE entry=44974;                --  Elwynn Lamb

-- DRAGONS
UPDATE item_template SET buyprice=@50G WHERE entry=10822;                 --  Dark Whelpling
UPDATE item_template SET buyprice=@50G WHERE entry=8498;                  --  Tiny Emerald Whelpling
UPDATE item_template SET buyprice=@50G WHERE entry=8499;                  --  Tiny Crimson Whelpling
UPDATE item_template SET buyprice=@5G WHERE entry=11474;                  --  Sprite Darter Egg
UPDATE item_template SET buyprice=@10G WHERE entry=19054;                 --  Red Dragon Orb
UPDATE item_template SET buyprice=@10G WHERE entry=19055;                 --  Green Dragon Orb
UPDATE item_template SET buyprice=@5G WHERE entry=29953;                  --  Golden Dragonhawk Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=29956;                  --  Red Dragonhawk Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=29957;                  --  Silver Dragonhawk Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=29958;                  --  Blue Dragonhawk Hatchling
UPDATE item_template SET buyprice=@10G WHERE entry=25535;                 --  Netherwhelp's Collar
UPDATE item_template SET buyprice=@50G WHERE entry=34535;                 --  Azure Whelpling
UPDATE item_template SET buyprice=@10G WHERE entry=44721;                 --  Proto-Drake Whelp
UPDATE item_template SET buyprice=@10G WHERE entry=54810;                 --  Celestial Dragon
UPDATE item_template SET buyprice=@100G WHERE entry=49362;                --  Onyxian Whelpling
UPDATE item_template SET buyprice=@10G WHERE entry=39286;                 --  Frosty's Collar

-- MURLOC
UPDATE item_template SET buyprice=@25G WHERE entry=20651;               --  Orange Murloc Egg
UPDATE item_template SET buyprice=@25G WHERE entry=20371;               --  Blue Murloc Egg
UPDATE item_template SET buyprice=@25G WHERE entry=22114;               --  Pink Murloc Egg
UPDATE item_template SET buyprice=@25G WHERE entry=22780;               --  White Murloc Egg
UPDATE item_template SET buyprice=@50G WHERE entry=30360;               --  Lurky's Egg
UPDATE item_template SET buyprice=@50G WHERE entry=46802;               --  Heavy Murloc Egg
UPDATE item_template SET buyprice=@50G WHERE entry=46892;               --  Murkimus' Tiny Spear

-- TURTLES
UPDATE item_template SET buyprice=@10G WHERE entry=18964;               --  Turtle Egg Loggerhead
UPDATE item_template SET buyprice=@5G WHERE entry=23002;                --  Turtle Box
UPDATE item_template SET buyprice=@5G WHERE entry=39148;                --  Baby Coralshell Turtle

-- HOLIDAY
UPDATE item_template SET buyprice=@5G WHERE entry=21308;                --  Jingling Bell
UPDATE item_template SET buyprice=@5G WHERE entry=21309;                --  Snowman Kit
UPDATE item_template SET buyprice=@5G WHERE entry=22235;                --  Truesilver Shafted Arrow
UPDATE item_template SET buyprice=@5G WHERE entry=32233;                --  Wolpertinger's Tankard
UPDATE item_template SET buyprice=@10G WHERE entry=23083;               --  Captured Flame
UPDATE item_template SET buyprice=@10G WHERE entry=33154;               --  Sinister Squashling

-- SAURS
UPDATE item_template SET buyprice=@5G WHERE entry=48112;                --  Darting Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=48114;                --  Deviate Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=48116;                --  Gundrak Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=48118;                --  Leaping Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=48120;                --  Obsidian Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=48122;                --  Ravasaur Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=48124;                --  Razormaw Hatchling
UPDATE item_template SET buyprice=@5G WHERE entry=48126;                --  Razzashi Hatchling

-- HUMANOID
UPDATE item_template SET buyprice=@5G WHERE entry=21301;               --  Green Helper Box
UPDATE item_template SET buyprice=@5G WHERE entry=21305;               --  Red Helper Box
UPDATE item_template SET buyprice=@10G WHERE entry=45022;              --  Argent Gruntling
UPDATE item_template SET buyprice=@10G WHERE entry=44998;              --  Argent Squire

-- QUEST/ACHIEVEMENT
UPDATE item_template SET buyprice=@5G WHERE entry=40653;                --  Reeking Pet Carrier
UPDATE item_template SET buyprice=@10G WHERE entry=32617;               --  Sleepy Willy
UPDATE item_template SET buyprice=@10G WHERE entry=46707;               --  Pint-Sized Pink Pachyderm
UPDATE item_template SET buyprice=@5G WHERE entry=31760;                --  Miniwing
UPDATE item_template SET buyprice=@5G WHERE entry=32616;                --  Egbert's Egg
UPDATE item_template SET buyprice=@5G WHERE entry=33816;                --  Toothy's Bucket
UPDATE item_template SET buyprice=@5G WHERE entry=33818;                --  Muckbreath's Bucket
UPDATE item_template SET buyprice=@5G WHERE entry=35349;                --  Snarly's Bucket
UPDATE item_template SET buyprice=@5G WHERE entry=35350;                --  Chuck's Bucket
UPDATE item_template SET buyprice=@500G WHERE entry=12264;              --  Worg Carrier
UPDATE item_template SET buyprice=@500G WHERE entry=12529;              --  Smolderweb Carrier
UPDATE item_template SET buyprice=@5G WHERE entry=46396;                --  Wolvar Orphan Whistle
UPDATE item_template SET buyprice=@5G WHERE entry=46397;                --  Oracle Orphan Whistle

-- RARE DROP
UPDATE item_template SET buyprice=@500G WHERE entry=53641;              --  Ice Chip
UPDATE item_template SET buyprice=@500G WHERE entry=8494;               --  Parrot Cage Hyacinth Macaw
UPDATE item_template SET buyprice=@500G WHERE entry=43698;              --  Giant Sewer Rat
UPDATE item_template SET buyprice=@500G WHERE entry=20769;              --  Disgusting Oozeling
UPDATE item_template SET buyprice=@500G WHERE entry=27445;              --  Magical Crawdad Box

-- TRADING CARD
UPDATE item_template SET buyprice=@1G WHERE entry=38050;                 --  Soul-Trader Beacon
UPDATE item_template SET buyprice=@25G WHERE entry=13582;                --  Zergling Leash
UPDATE item_template SET buyprice=@50G WHERE entry=13583;                --  Panda Collar
UPDATE item_template SET buyprice=@50G WHERE entry=13584;                --  Diablo Stone
UPDATE item_template SET buyprice=@5G WHERE entry=19462;                 --  Unhatched Jubling Egg
UPDATE item_template SET buyprice=@5G WHERE entry=49287;                 --  Tuskarr Kite
UPDATE item_template SET buyprice=@5G WHERE entry=34493;                 --  Dragon Kite

-- EXOTIC
UPDATE item_template SET buyprice=@5G WHERE entry=23015;                 --  Rat Cage
UPDATE item_template SET buyprice=@25G WHERE entry=44738;                --  Kirin Tor Familiar
UPDATE item_template SET buyprice=@25G WHERE entry=49665;                --  Pandaren Monk
UPDATE item_template SET buyprice=@25G WHERE entry=44980;                --  Mulgore Hatchling
UPDATE item_template SET buyprice=@25G WHERE entry=44982;                --  Enchanted Broom
UPDATE item_template SET buyprice=@25G WHERE entry=45606;                --  Sen'jin Fetish
UPDATE item_template SET buyprice=@25G WHERE entry=34955;                --  Scorched Stone
UPDATE item_template SET buyprice=@25G WHERE entry=44965;                --  Teldrassil Sproutling
UPDATE item_template SET buyprice=@25G WHERE entry=34478;                --  Tiny Sporebat
UPDATE item_template SET buyprice=@50G WHERE entry=29960;                --  Captured Firefly
UPDATE item_template SET buyprice=@50G WHERE entry=35504;                --  Phoenix Hatchling
UPDATE item_template SET buyprice=@50G WHERE entry=39656;                --  Tyrael's Hilt
UPDATE item_template SET buyprice=@25G WHERE entry=39973;                --  Ghostly Skull
UPDATE item_template SET buyprice=@10G WHERE entry=49343;                --  Spectral Tiger Cub
UPDATE item_template SET buyprice=@25G WHERE entry=49646;                --  Core Hound Pup
UPDATE item_template SET buyprice=@25G WHERE entry=49693;                --  Lil' Phylactery
UPDATE item_template SET buyprice=@10G WHERE entry=48527;                --  Enchanted Onyx
UPDATE item_template SET buyprice=@50G WHERE entry=50446;                --  Toxic Wasteling

-- OTHER LOCALE
UPDATE item_template SET buyprice=@5G WHERE entry=32498;                 --  Fortune Coin
UPDATE item_template SET buyprice=@5G WHERE entry=37298;                 --  Competitor's Souvenir
UPDATE item_template SET buyprice=@5G WHERE entry=37297;                 --  Gold Medallion
UPDATE item_template SET buyprice=@10G WHERE entry=34518;                --  Golden Pig Coin
UPDATE item_template SET buyprice=@10G WHERE entry=34519;                --  Silver Pig Coin


-- --------------------------------------------------------------------------------------
--	MOUNT PRICING
-- --------------------------------------------------------------------------------------

-- Exotics
-- 1000
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 33809;   -- Amani War Bear
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 45725;   -- Argent Hippogryph
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 46102;   -- Venonhide Ravasaur

-- 1500
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 37828;   -- Great Brewfest Kodo
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 33977;   -- Swift Brewfest Ram
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 19902;   -- Swift Zulian Tiger
UPDATE item_template SET sellprice=@10G, buyprice=@150G WHERE entry = 49098;   -- Crusader's Black Warhorse
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 52200;   -- Reins of the Crimson Deathcharger
UPDATE item_template SET sellprice=@10G, buyprice=@150G WHERE entry = 44234;   -- Reins of the Traveler's Tundra Mammoth
-- 2500
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 37012;   -- The Horseman's Reins
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 35513;   -- Swift White Hawkstrikder
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 32768;   -- Reins of the Raven Lord
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 41508;   -- Mechano-Hog
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 30480;   -- Fiery Warharse's Reins
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 49636;   -- Reins of the Onyxian Drake
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 50250;   -- Big Love Rocket
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 44177;   -- Reins of the Violet Proto Drake

-- 5000
UPDATE item_template SET sellprice=@10G, buyprice=@1000G WHERE entry = 44168;   -- Time-Lost Proto Drake

-- 15000
UPDATE item_template SET sellprice=@10G, buyprice=@1000G WHERE entry = 32458; -- Ashes of Alar
UPDATE item_template SET sellprice=@10G, buyprice=@1000G WHERE entry = 45693; -- Mimiron's Head

-- 75000
UPDATE item_template SET sellprice=@10G, buyprice=@5000G WHERE entry = 50818; -- Invincible's Reins

-- FACTIONS
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45125; --  Stormwind Steed
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45586; --  Ironforge Ram
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45589; --  Gnomeregan Mechanostrider
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45590; --  Exodar Elekk
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45591; --  Darnassian Nightsaber
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45592; --  Thunder Bluff Kodo
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45593; --  Darkspear Raptor
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45595; --  Orgrimmar Wolf
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45596; --  Silvermoon Hawkstrider
UPDATE item_template SET sellprice=@10G, buyprice=@250G WHERE entry = 45597; --  Forsaken Warhorse

-- UNPRICED MOUNTS

UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 13335; --  Deathcharger's Reins
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 19872; --  Swift Razzashi Raptor
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 19029; --  Horn of the Frostwolf Howler
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 28915; --  Riens of the Dark Riding Talbuk
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29465; --  Black Battle Strider
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29466; --  Black War Kodo
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29467; --  Black War Ram
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29468; --  Black War Steed Bridle
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29469; --  Horns of the Black War Wolf
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29568; --  Black War Steed
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 20569; --  Horn of the Black War Wolf
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29470; --  Red Skeletal Warhorse
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29471; --  Reins of the Black War Tiger
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 29472; --  Whistle of the Black War Raptor
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 33176; --  Flying Broom
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 33182; --  Swift Flying Broom
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 33183; --  Old Flying Broom
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 33184; --  Swift Magic Broom
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 33189; --  Rickety Magic Broom
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 34060; --  Flying Machine Control
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 34061; --  Turbo Flying Machine Control
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 34129; --  Swift Warstrider
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 35906; --  Reins of the Black War Elekk
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 37011; --  Magic Broom
UPDATE item_template SET sellprice=@10G, buyprice=@500G WHERE entry = 37676; --  Vengeful Nether Drake
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 43956; --  Reins of the Black War Mammoth
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 44077; --  Reins of the Black War Mammoth
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 44554; --  Flying Carpet
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 46101; --  Blue Skeletal Warhorse
UPDATE item_template SET sellprice=@10G, buyprice=@1000G WHERE entry = 46109; --  Sea Turtle
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 46814; --  Sunreaver Dragonhawk
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 46816; --  Sunreaver Hawkstrider
UPDATE item_template SET sellprice=@10G, buyprice=@200G WHERE entry = 47180; --  Argent Warhorse
