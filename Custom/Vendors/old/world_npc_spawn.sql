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
--                      \/__/  \_/__/          http://devthebest.github.io
-- 
-- ################################################################################### --
-- 
-- WORLD: WORLD NPC SPAWN
-- 
-- Places custom NPCs at specific locations in the world. 
---- 2021.04.07:
--			Update to latest AC database by Anhedonie
-- ################################################################################### --
*/




-- ################################################################################### --
--	CITIES, TOWNS, WILDERNESS
-- ################################################################################### --

-- --------------------------------------------------------------------------------------
-- Black Rats (Barbarian King's Crypt)
-- --------------------------------------------------------------------------------------
DELETE FROM `world`.`creature` WHERE `guid` IN (2026023, 2026022, 2026021, 2026006, 2025992, 2025991, 2025990);
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2026023', '2110', '0', '1', '1', '0', '0', '-6554.18', '-3485.95', '292.678', '4.68442', '300', '6', '0', '1', '0', '1', '0', '0', '0');
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2026022', '2110', '0', '1', '1', '0', '0', '-6541.85', '-3489.82', '292.867', '6.27878', '300', '6', '0', '1', '0', '1', '0', '0', '0');
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2026021', '2110', '0', '1', '1', '0', '0', '-6567.08', '-3489.61', '292.867', '2.68951', '300', '6', '0', '1', '0', '1', '0', '0', '0');
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2026006', '2110', '0', '1', '1', '0', '0', '-6554.48', '-3494.7', '292.867', '4.73547', '300', '6', '0', '1', '0', '1', '0', '0', '0');
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2025992', '2110', '0', '1', '1', '0', '0', '-6554.6', '-3475.9', '295.694', '4.74726', '300', '6', '0', '1', '0', '1', '0', '0', '0');
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2025991', '2110', '0', '1', '1', '0', '0', '-6554.31', '-3467.46', '299.08', '0.00344742', '300', '6', '0', '1', '0', '1', '0', '0', '0');
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2025990', '2110', '0', '1', '1', '0', '0', '-6562.23', '-3467.49', '302.042', '0.00344742', '300', '6', '0', '1', '0', '1', '0', '0', '0');

-- --------------------------------------------------------------------------------------
-- Bengal Tiger Handler (Stranglethorn Cave)
-- --------------------------------------------------------------------------------------
DELETE FROM `world`.`creature` WHERE `guid` = 2025782;
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2025782', '601036', '0', '1', '1', '0', '0', '-12832.8', '-1376.24', '113.165', '3.74355', '300', '0', '0', '5342', '0', '0', '0', '0', '0');

-- --------------------------------------------------------------------------------------
-- Pet Vendor Exotic (Sunrock Retreat)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601000;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601000, 601000, 1, 1, 1, 0, 1, 928.782, 970.332, 103.215, 5.25035, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Pet Vendor (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601001;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601001, 601001, 1, 1, 1, 0, 0, -1104.24, 31.6478, 140.599, 3.52235, 300, 0, 0, 4572, 2705, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Cook (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601002;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601002, 601002, 1, 1, 1, 0, 1, -1221.31, -20.9276, 165.672, 0.259021, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Potions (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601004;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601004, 601004, 1, 1, 1, 0, 1, -1225.41, 149.28, 133.218, 4.9125, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Artifacts (Seradane, Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=2023438;
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2023438', '601006', '0', '1', '1', '0', '1', '664.312', '-4091.05', '100.713', '0.1141', '300', '0', '0', '5343', '0', '0', '0', '0', '0');

DELETE FROM `creature` WHERE `guid`=1994535;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1994535, 601006, 1, 1, 1, 0, 1, -10710.8, 2489.71, 7.92193, 4.76729, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Books (BootyBay)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601007;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601007, 601007, 0, 1, 1, 0, 0, -14456.7, 446.481, 4.04955, 0.744934, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Holiday (WinterSpring)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601008;
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('601008', '601008', '1', '1', '1', '0', '0', '6857.82', '-4676.65', '701.147', '1.5397', '300', '0', '0', '5342', '0', '0', '0', '0', '0');

-- --------------------------------------------------------------------------------------
-- Tools - (Ashenvale TalonDeep Path Cave Entrance)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601009;
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('601009', '601009', '1', '1', '1', '0', '0', '1936.73', '-743.61', '114.073', '1.68764', '300', '0', '0', '5342', '0', '0', '0', '0', '0');

-- --------------------------------------------------------------------------------------
-- Clothing (Silvermoon)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601010;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601010, 601010, 530, 1, 1, 0, 0, 9638.45, -7384.21, 15.7281, 4.75106, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Bags (Everlook)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601011;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601011, 601011, 1, 1, 1, 0, 0, 6778.46, -4673.04, 723.84, 2.51994, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Fireworks (Sunrock Retreat)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601012;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601012, 601012, 1, 1, 1, 0, 1, 870.865, 932.492, 115.501, 1.00529, 300, 0, 0, 2399, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Enchanter (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601015;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601015, 601015, 1, 1, 1, 0, 1, -1220.8, 73.2407, 130.162, 4.03285, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Enchanter (Undercity)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1993359;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1993359, 601015, 0, 1, 1, 0, 1, 1688.05, 45.6258, -62.2919, 6.16394, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Buffer (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601016;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601016, 601016, 1, 1, 1, 0, 1, -1206.83, 58.0772, 131.178, 2.9215, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Gambler (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601020;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601020, 601020, 1, 1, 1, 0, 0, -1013, 195.904, 136.64, 2.48562, 300, 0, 0, 4163, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Codebox (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601021;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601021, 601021, 1, 1, 1, 0, 0, -1208.77, -87.7774, 161.45, 1.53137, 300, 0, 0, 4163, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Locksmith (Undercity)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601022;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601022, 601022, 0, 1, 1, 0, 1, 1534, 329.138, -62.1633, 2.37831, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Engineer Contraptions (Everlook)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601023;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601023, 601023, 1, 1, 1, 0, 0, 6692.52, -4660.54, 721.695, 5.06463, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Specialty Gifts (Silvermoon)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601024;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601024, 601024, 530, 1, 1, 0, 1, 9542.79, -7448.55, 15.4654, 6.09409, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
-- --------------------------------------------------------------------------------------
-- Tabards (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601025;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601025, 601025, 1, 1, 1, 0, 0, -1288.81, 129.386, 131.546, 5.26199, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Beastmaster (Sunrock Retreat)
-- --------------------------------------------------------------------------------------
-- SPAWN BeastMaster NPC
DELETE FROM `creature` WHERE `guid`=601026;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601026, 601026, 1, 1, 1, 0, 1, 950.892, 899.442, 107.14, 3.81309, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Jukebox NPC (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601027;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601027, 601027, 1, 1, 1, 0, 0, -1196.29, 142.095, 142.931, 0.655656, 300, 0, 0, 4163, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Elixers/Flasks (Thunder Bluff)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601029;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601029, 601029, 1, 1, 1, 0, 1, -1222.69, 149.248, 133.246, 4.53159, 300, 0, 0, 5342, 0, 0, 0, 0, 0);


-- ################################################################################### --
--	STARTING ZONES
-- ################################################################################### --

-- --------------------------------------------------------------------------------------
-- Heirloom Vendor
-- --------------------------------------------------------------------------------------
SET @BOA := 601704;
SET @GUID := 601704;
DELETE FROM `creature` WHERE `id`=@BOA;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES 
(@GUID,@BOA,0,1,1,0,0,-9022.275391,-76.134964,88.489632,5.9219,100,0,0,4274,3994,0,0,0,0), -- Human (Northshire Valley)
(@GUID+1,@BOA,0,1,1,0,0,-6170.66,350.627,400.116,1.93837,100,0,0,4274,3994,0,0,0,0), -- Dwarf and Gnome (Coldridge Valley)
(@GUID+2,@BOA,1,1,1,0,0,10411.7,781.667,1322.71,5.26217,100,0,0,4274,3994,0,0,0,0), -- NightElf (Shadowglen)
(@GUID+3,@BOA,530,1,1,0,0,-4112.79,-13749,73.5646,4.35504,100,0,0,4274,3994,0,0,0,0), -- Draenei (Crash Site)
(@GUID+4,@BOA,1,1,1,0,0,-597.151,-4210.22,38.4318,4.08879,100,0,0,4274,3994,0,0,0,0), -- Orc and Troll (Valley of Trial)
(@GUID+5,@BOA,0,1,1,0,0,1883.85,1614.12,93.4042,4.55138,100,0,0,4274,3994,0,0,0,0), -- Undead (Deathknell)
(@GUID+6,@BOA,1,1,1,0,0,-2899.01,-231.723,53.8403,4.66684,100,0,0,4274,3994,0,0,0,0), -- Tauren (Camp Narache)
(@GUID+7,@BOA,530,1,1,0,0,10359.4,-6408.47,38.5311,1.88496,100,0,0,4274,3994,0,0,0,0), -- BloodElf (The Sunspire)
(@GUID+8,@BOA,609,1,1,0,0,2435.74,-5610.41,420.092,3.71887,100,0,0,4274,3994,0,0,0,0), -- DeathKnight (The Heart of Acherus) #1
(@GUID+9,@BOA,0,1,1,0,0,2435.74,-5610.41,420.092,3.71887,100,0,0,4274,3994,0,0,0,0); -- DeathKnight (The Heart of Acherus) #2


-- ################################################################################### --
--	SILITHUS CAMP
-- ################################################################################### --

-- --------------------------------------------------------------------------------------
-- Beastmaster (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1994134;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1994134, 601026, 1, 1, 1, 0, 1, -10724.7, 2443.98, 7.60624, 4.33535, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Buffer (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1994477;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1994477, 601016, 1, 1, 1, 0, 1, -10704.4, 2484.29, 7.92193, 3.42427, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Enchanter
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1994480;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1994480, 601015, 1, 1, 1, 0, 1, -10713.3, 2475.62, 7.92193, 1.08771, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Fisherman (Silithus Camp - Waypoint Animated)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1994210; -- Camp Silithus (WAYPOINT ANIMATED)
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1994210, 601005, 1, 1, 1, 0, 1, -10749.5, 2517.59, 1.57246, 1.84172, 300, 0, 0, 5342, 0, 2, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Cowlie the Milker (Silithus Camp - Waypoint Animated)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601030;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601030, 601030, 1, 1, 1, 0, 0, -10740.6, 2430.06, 6.73322, 6.2533, 300, 25, 0, 42, 0, 1, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Cutie Pig (Silithus Camp - Waypoint Animated)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601031;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601031, 601031, 1, 1, 1, 0, 0, -10740.6, 2430.06, 6.73322, 6.2533, 300, 25, 0, 42, 0, 1, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Transmogrifier (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1994536; -- Camp Silithus
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1994536, 601013, 1, 1, 1, 0, 0, -10717.2, 2486.49, 7.92193, 5.72547, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Banker (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=2024319;
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2024319', '601034', '1', '1', '1', '0', '1', '-10716', '2468.83', '7.6044', '3.81682', '300', '0', '0', '5342', '0', '0', '0', '0', '0');

-- --------------------------------------------------------------------------------------
-- Currency (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1994974;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1994974, 601524, 1, 1, 1, 0, 1, -10706.2, 2476.29, 7.92182, 2.28933, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Cloth Goods (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1995970;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1995970, 601518, 1, 1, 1, 0, 1, -10709.1, 2413.96, 7.60836, 4.24502, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Metal/Stone Goods (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1995962;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1995962, 601560, 1, 1, 1, 0, 1, -10711.5, 2409.03, 7.60599, 1.24087, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Elemental Goods (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1995956;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1995956, 601528, 1, 1, 1, 0, 1, -10708.1, 2410.3, 7.60954, 2.62319, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Artifacts (Hinterlands, Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601006;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601006, 601006, 0, 1, 1, 0, 1, 624.897, -3411.3, 108.549, 3.92714, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Legendary Item Vendor (Silithus Cave)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=601028;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (601028, 601028, 1, 1, 1, 0, 0, -10666.5, 2086.56, -47.4262, 0.321985, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Mounts (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1997182;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1997182, 601033, 1, 1, 1, 0, 1, -10800, 2180.89, 2.02087, 2.63022, 300, 0, 0, 5342, 0, 0, 0, 134255104, 0);

-- --------------------------------------------------------------------------------------
-- Exotic Mounts (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1997181;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1997181, 601032, 1, 1, 1, 0, 1, -10796.9, 2195.95, 2.16213, 3.27425, 300, 0, 0, 5342, 0, 0, 0, 134255104, 0);


-- ################################################################################### --
--	GM ISLAND
-- ################################################################################### --

-- --------------------------------------------------------------------------------------
-- Portal Master (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=2024682;
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2024682', '601019', '1', '1', '1', '0', '0', '16199.7', '16205.8', '0.139467', '1.22447', '300', '0', '0', '4163', '0', '0', '0', '0', '0');

-- --------------------------------------------------------------------------------------
-- Global Trainer (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=2024526;
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2024526', '60165', '1', '1', '1', '0', '0', '16254.7', '16304.6', '20.8447', '3.03001', '300', '0', '0', '4274', '3994', '0', '0', '134217728', '0');


-- --------------------------------------------------------------------------------------
-- All Mounts Vendor (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977833;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977833, 601014, 1, 1, 1, 0, 0, 16228.8, 16259.4, 13.4481, 3.11482, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Beastmaster (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1980392;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1980392, 601026, 1, 1, 1, 0, 1, 16207.8, 16236.9, 7.48562, 5.98155, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Buffer (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977831;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977831, 601016, 1, 1, 1, 0, 0, 16217.2, 16262.5, 13.5767, 6.22107, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Codebox (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977825;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977825, 601021, 1, 1, 1, 0, 0, 16228.4, 16262.8, 13.3786, 3.29546, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Enchanter (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977832;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977832, 601015, 1, 1, 1, 0, 1, 16217, 16259.7, 13.5628, 6.22107, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
--	GM Island Decorator (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `id`=601035;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(601035, 1, 1, 1, 0, 0, 16253.8, 16234.9, 33.5163, 2.3098, 300, 0, 0, 53420, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Transmogrifier (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977839; -- GM Island
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977839, 601013, 1, 1, 1, 0, 0, 16228.7, 16255.8, 13.3435, 3.11482, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Mounts (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1996285;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1996285, 601033, 1, 1, 1, 0, 1, 16216.3, 16225.2, 4.94466, 2.66716, 300, 0, 0, 5342, 0, 0, 0, 134255104, 0);

-- --------------------------------------------------------------------------------------
-- Exotic Mounts (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1996283;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1996283, 601032, 1, 1, 1, 0, 1, 16219.2, 16230.7, 7.52852, 2.66716, 300, 0, 0, 5342, 0, 0, 0, 134255104, 0);

-- --------------------------------------------------------------------------------------
-- Rare Pets (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977857;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977857, 601000, 1, 1, 1, 0, 1, 16211.2, 16242.9, 10.7703, 5.6713, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Pets (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1978343;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1978343, 601001, 1, 1, 1, 0, 1, 16222.3, 16235.7, 9.54736, 2.62788, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Food (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977855;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977855, 601002, 1, 1, 1, 0, 1, 16224.2, 16238.8, 10.5448, 2.69856, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Armor (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977854;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977854, 601003, 1, 1, 1, 0, 1, 16225.7, 16241.9, 11.4356, 2.70249, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Potions (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977853;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977853, 601004, 1, 1, 1, 0, 1, 16226.7, 16244.9, 12.0007, 2.91062, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
DELETE FROM `creature` WHERE `guid`=1980706;

-- --------------------------------------------------------------------------------------
-- Fishing (GM Island)
-- --------------------------------------------------------------------------------------
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1980706, 601005, 1, 1, 1, 0, 1, 16227.3, 16247.6, 12.3907, 2.80068, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Artifacts (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977851;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977851, 601006, 1, 1, 1, 0, 1, 16228, 16250.6, 12.8686, 2.91062, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Books (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977850;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977850, 601007, 1, 1, 1, 0, 0, 16228.1, 16253.2, 13.1069, 3.15802, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Holiday (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977848;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977848, 601008, 1, 1, 1, 0, 0, 16213.7, 16245.9, 12.0913, 5.93833, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Tools (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977847;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977847, 601009, 1, 1, 1, 0, 0, 16214.8, 16248.2, 12.4535, 5.93833, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Clothing (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977846;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977846, 601010, 1, 1, 1, 0, 0, 16216.2, 16250.8, 12.7625, 5.93833, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Bags (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977845;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977845, 601011, 1, 1, 1, 0, 0, 16217.1, 16253.4, 13.042, 5.93833, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Fireworks (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977844;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977844, 601012, 1, 1, 1, 0, 1, 16217.2, 16256.1, 13.3398, 0.138163, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Locksmith (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977823;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977823, 601022, 1, 1, 1, 0, 1, 16227.6, 16265.9, 13.2387, 3.13053, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Engineer (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977822;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977822, 601023, 1, 1, 1, 0, 0, 16227, 16269.1, 13.1011, 3.13053, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Specialty (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977710;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977710, 601024, 1, 1, 1, 0, 1, 16216.9, 16266.1, 13.3949, 0.149947, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Tabards (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1977709;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1977709, 601025, 1, 1, 1, 0, 0, 16217.1, 16269.5, 13.1584, 6.08756, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Legendary (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1978727;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1978727, 601028, 1, 1, 1, 0, 0, 16209.6, 16240.2, 9.14474, 5.67523, 300, 0, 0, 5342, 0, 0, 0, 0, 0);

-- --------------------------------------------------------------------------------------
-- Elixer/Flasks (GM Island)
-- --------------------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid`=1979519;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1979519, 601029, 1, 1, 1, 0, 1, 16221.4, 16233.2, 8.7621, 2.66323, 300, 0, 0, 5342, 0, 0, 0, 0, 0);


-- ################################################################################### --
--	DUNGEONS, RAIDS
-- ################################################################################### --


-- ################################################################################### --
--	SPIRIT HEALER
-- ################################################################################### --
DELETE FROM `creature` WHERE `guid`=2025026; -- Camp Silithus
INSERT INTO `world`.`creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('2025026', '6491', '1', '1', '1', '0', '0', '-10715.8', '2350.14', '8.88242', '3.14925', '300', '0', '0', '4121', '0', '0', '0', '0', '0'); -- Spirit Healer

