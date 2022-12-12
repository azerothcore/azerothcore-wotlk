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
-- WORLD: WORLD OBJECT SPAWN
-- 
-- Places custom objects at specific locations in the world. 
--
-- 2021.04.07:
--			Update to latest AC database by Anhedonie
-- ################################################################################### --
*/



-- ################################################################################### --
-- Update StygianCore table structure for GOMove object import
-- ################################################################################### --

-- ALTER TABLE `world`.`gameobject` DROP COLUMN zoneId;
-- ALTER TABLE `world`.`gameobject` DROP COLUMN areaId;
-- ALTER TABLE `world`.`gameobject` DROP COLUMN ScriptName;

-- ALTER TABLE `world`.`gameobject`
-- ADD zoneId smallint(5),
-- ADD areaId smallint(5),
-- ADD ScriptName char(64);

-- ################################################################################### --
--	CITIES, TOWNS, WILDERNESS
-- ################################################################################### --

-- --------------------------------------------------------------------------------------
-- Bengal Tiger Cave
-- --------------------------------------------------------------------------------------

-- Campfire
DELETE FROM `world`.`gameobject` WHERE `guid` = 501960;			
REPLACE INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501960', '191775', '0', '1', '1', '-12834.9', '-1377.37', '112.856', '0.540488', '-0', '-0', '-0.266967', '-0.963706', '300', '0', '1', '0');

-- --------------------------------------------------------------------------------------
-- Sunrock Retreat
-- --------------------------------------------------------------------------------------

-- Clean Up GUIDs
DELETE FROM `gameobject` WHERE guid >= 269190 AND guid <= 269200;

-- Campfire
REPLACE INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (269190, 192719, 1, 1, 1, 929.697, 968.275, 103.289, 2.31689, -0, -0, -0.916181, -0.400765, 300, 0, 1, 0);
-- Firework Barrel (Fireworks Vendor)
REPLACE INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('269191', '180878', '1', '1', '1', '872.643', '931.83', '115.445', '1.52363', '-0', '-0', '-0.690238', '-0.723583', '300', '0', '1', '0'); 
-- Firework Launcher Doodad (Firworks Vendor)
REPLACE INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('269192', '186292', '1', '1', '1', '869.812', '933.805', '115.549', '0.235584', '-0', '-0', '-0.11752', '-0.993071', '300', '0', '1', '0'); 


-- --------------------------------------------------------------------------------------
-- Everlook
-- --------------------------------------------------------------------------------------

-- Christmas Tree
REPLACE INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('269193', '178667', '1', '1', '1', '6862.36', '-4677.75', '701.166', '1.86956', '-0', '-0', '-0.804469', '-0.593995', '300', '0', '1', '0'); 

-- Present
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('269194', '180799', '1', '1', '1', '6863.02', '-4675.36', '700.969', '2.20569', '-0', '-0', '-0.892495', '-0.451058', '300', '0', '1', '0');

-- Present
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('269195', '180747', '1', '1', '1', '6861.11', '-4676.52', '701.152', '4.89568', '-0', '-0', '-0.639427', '0.768852', '300', '0', '1', '0'); 

-- Jack-O-Lantern
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`,`position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('269196', '180405', '1', '1', '1', '6854.33', '-4676.81', '700.906', '3.26993', '-0', '-0', '-0.997942', '0.0641246', '300', '0', '1', '0'); 

-- Skull Candle
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('269197', '186269', '1', '1', '1', '6851.84', '-4675.13', '700.604', '0.89405', '-0', '-0', '-0.432285', '-0.901737', '300', '0', '1', '0'); 

-- Pile of Skulls
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('269198', '179915', '1', '1', '1', '6852.3', '-4676.73', '700.711', '1.34173', '-0', '-0', '-0.621665', '-0.783283', '300', '0', '1', '0');

-- Bonfire
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501443', '194979', '1', '1', '1', '6731.53', '-4643.84', '722.238', '4.1418', '-0', '-0', '-0.877533', '0.479516', '300', '0', '1', '0');

-- Bench
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501437', '194827', '1', '1', '1', '6729.03', '-4647.93', '721.605', '0.854903', '-0', '-0', '-0.414553', '-0.910025', '300', '0', '1', '0');


-- --------------------------------------------------------------------------------------
-- Alterac Mountains
-- --------------------------------------------------------------------------------------

-- Christmas Tree
DELETE FROM `gameobject` WHERE `guid`=501444;
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (501444, 192129, 0, 1, 1, 171.202, -275.448, 150.482, 6.23073, -0, -0, -0.0262259, 0.999656, 300, 0, 1, 0);

-- Christmas Tree
DELETE FROM `gameobject` WHERE `guid`=501445;
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (501455, 178558, 0, 1, 1, 179.436, -270.605, 148.081, 0.139975, -0, -0, -0.0699302, -0.997552, 300, 0, 1, 0);


-- --------------------------------------------------------------------------------------
-- Thunder Bluff
-- --------------------------------------------------------------------------------------

-- Campfire (Pet Vendor)
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (269199, 194017, 1, 1, 1, -1105.89, 33.3562, 140.598, 0.616385, -0, -0, -0.303337, -0.952883, 300, 0, 1, 0); 

-- Elise Place Christmas Tree
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501857', '178668', '1', '1', '1', '-746.052', '-1060.43', '193.402', '5.76076', '-0', '-0', '-0.258255', '0.966077', '300', '0', '1', '0');


-- ################################################################################### --
--	SILITHUS CAMP
-- ################################################################################### --

-- --------------------------------------------------------------------------------------
-- Fisherman Items (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `gameobject` WHERE `guid`=500467; -- Fishing Chair
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (500467, 186475, 1, 1, 1, -10749.2, 2516.27, 2.26279, 1.81423, -0, -0, -0.787729, -0.616021, 300, 0, 1, 0);

DELETE FROM `gameobject` WHERE `guid`=500469; -- Oily Blackmouth School
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (500469, 180682, 1, 1, 1, -10750.8, 2527.94, 0.00143518, 3.84841, -0, -0, -0.938199, 0.346096, 300, 0, 1, 0);

-- --------------------------------------------------------------------------------------
-- Large Bonfire (Silithus Camp - Front of Cave Near Sea)
-- --------------------------------------------------------------------------------------
DELETE FROM `gameobject` WHERE `guid`=501064;
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (501064, 191824, 1, 1, 1, -10792.9, 2187.16, 2.47621, 6.28232, -0, -0, -0.000415137, 1, 300, 0, 1, 0);

-- --------------------------------------------------------------------------------------
-- Ghostly Cooking Fires (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `gameobject` WHERE `guid`=501042; -- Near Haystack
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (501042, 195087, 1, 1, 1, -10726.9, 2444.32, 7.60427, 4.2097, -0, -0, -0.860752, 0.509025, 300, 0, 1, 0);

DELETE FROM `gameobject` WHERE `guid`=501040; -- Near Haystack
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (501040, 195087, 1, 1, 1, -10722.7, 2442.5, 7.60622, 4.14294, -0, -0, -0.87726, 0.480015, 300, 0, 1, 0);

-- --------------------------------------------------------------------------------------
-- Forge In Tent (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `gameobject` WHERE `guid`=500694;
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (500694, 192572, 1, 1, 1, -10710.3, 2411.39, 7.60782, 5.82762, -0, -0, -0.22582, 0.974169, 300, 0, 1, 0);

-- --------------------------------------------------------------------------------------
-- Anvil In Tent (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `gameobject` WHERE `guid`=500927;
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (500927, 192019, 1, 1, 1, -10712.2, 2412.71, 7.60568, 5.69013, -0, -0, -0.2922, 0.956357, 300, 0, 1, 0);

-- --------------------------------------------------------------------------------------
-- Mailbox (Silithus Camp)
-- --------------------------------------------------------------------------------------
DELETE FROM `gameobject` WHERE `guid`=500802;
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (500802, 195629, 1, 1, 1, -10725, 2471.15, 7.58998, 0.506509, -0, -0, -0.250556, -0.968102, 300, 0, 1, 0);

-- --------------------------------------------------------------------------------------
-- Guild Bank Totem (Silithus Camp)
-- --------------------------------------------------------------------------------------
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501164', '187295', '1', '1', '1', '-10714', '2467.41', '7.60594', '3.67938', '-0', '-0', '-0.964065', '0.265667', '300', '0', '1', '0');

-- --------------------------------------------------------------------------------------
-- Campfire + Totems (Legendary Vendor, Silithus Cave)
-- --------------------------------------------------------------------------------------
DELETE FROM `gameobject` WHERE `guid`=500352; -- Campfire
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (500352, 191341, 1, 1, 1, -10663.7, 2086.46, -47.2649, 6.16928, -0, -0, -0.0569244, 0.998379, 300, 0, 1, 0);

DELETE FROM `gameobject` WHERE `guid`=500354; -- Fire Totem
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (500354, 211036, 1, 1, 1, -10668, 2089.45, -47.2756, 5.26214, -0, -0, -0.488635, 0.872488, 300, 0, 1, 0);

DELETE FROM `gameobject` WHERE `guid`=500353; -- Fire Totem
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (500353, 211036, 1, 1, 1, -10665, 2084.24, -47.4209, 5.15611, -0, -0, -0.534181, 0.84537, 300, 0, 1, 0);

-- --------------------------------------------------------------------------------------
-- Gravestones
-- --------------------------------------------------------------------------------------
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501268', '195186', '1', '1', '1', '-10723.5', '2351.02', '7.34298', '6.18089', '-0', '-0', '-0.0511261', '0.998692', '300', '0', '1', '0'); -- Black Knight's Grave
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501272', '184742', '1', '1', '1', '-10725.7', '2351.3', '7.10057', '6.19031', '-0', '-0', '-0.0464208', '0.998922', '300', '0', '1', '0'); -- Tirion Fordrings Grave
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501285', '61', '1', '1', '1', '-10719.2', '2348.09', '8.22528', '2.90343', '-0', '-0', '-0.992918', '-0.118801', '300', '0', '1', '0'); -- Grave
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501282', '194537', '1', '1', '1', '-10718.8', '2343.64', '9.10721', '2.71886', '-0', '-0', '-0.977745', '-0.209798', '300', '0', '1', '0'); -- Grave
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501281', '194538', '1', '1', '1', '-10716.4', '2350.71', '8.65505', '2.8995', '-0', '-0', '-0.992683', '-0.120753', '300', '0', '1', '0'); -- Grave
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501280', '177239', '1', '1', '1', '-10720.3', '2354.72', '7.94209', '2.62461', '-0', '-0', '-0.966777', '-0.255622', '300', '0', '1', '0'); -- Grave
REPLACE  INTO `world`.`gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES ('501275', '181369', '1', '1', '1', '-10723.3', '2347.15', '7.57764', '3.01731', '-0', '-0', '-0.99807', '-0.062102', '300', '0', '1', '0'); -- Grave