-- DB update 2023_01_03_01 -> 2023_01_03_02
-- XYZ:-11092.80 -1157.22 55.19 map 0
DELETE FROM pool_gameobject WHERE guid IN (74125,74126,74127,74128,74129) AND pool_entry = 4505;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(74125, 4505, 0, 'Spawn Point 106 - Copper'),
(74126, 4505, 0, 'Spawn Point 106 - Tin'),
(74127, 4505, 0, 'Spawn Point 106 - Iron'),
(74128, 4505, 10, 'Spawn Point 106 - Silver'),
(74129, 4505, 10, 'Spawn Point 106 - Gold'); 

-- XYZ:-11080.60 -1109.60 45.51 map 0
DELETE FROM pool_gameobject WHERE guid IN (74150,74151,74152,74153,74154) AND pool_entry = 4510;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(74150, 4510, 0, 'Spawn Point 111 - Copper'),
(74151, 4510, 0, 'Spawn Point 111 - Tin'),
(74152, 4510, 0, 'Spawn Point 111 - Iron'),
(74153, 4510, 10, 'Spawn Point 111 - Silver'),
(74154, 4510, 10, 'Spawn Point 111 - Gold'); 

-- XYZ:-11080.00 -1109.00 44.76 map 0
DELETE FROM pool_gameobject WHERE guid IN (73650,73651,73652,73653,73654) AND pool_entry = 4410;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(73650, 4410, 0, 'Spawn Point 11 - Copper'),
(73651, 4410, 0, 'Spawn Point 11 - Tin'),
(73652, 4410, 0, 'Spawn Point 11 - Iron'),
(73653, 4410, 10, 'Spawn Point 11 - Silver'),
(73654, 4410, 10, 'Spawn Point 11 - Gold'); 

-- XYZ:-11104.10 -1087.41 63.20 map 0
DELETE FROM pool_gameobject WHERE guid IN (73870,73871,73872,73873,73874) AND pool_entry = 4454;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(73870, 4454, 0, 'Spawn Point 55 - Copper'),
(73871, 4454, 0, 'Spawn Point 55 - Tin'),
(73872, 4454, 0, 'Spawn Point 55 - Iron'),
(73873, 4454, 10, 'Spawn Point 55 - Silver'),
(73874, 4454, 10, 'Spawn Point 55 - Gold'); 

-- XYZ:-11099.10 -1155.55 42.44 map 0
DELETE FROM pool_gameobject WHERE guid IN (73940,73941,73942,73943,73944) AND pool_entry = 4468;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(73940, 4468, 0, 'Spawn Point 69 - Copper'),
(73941, 4468, 0, 'Spawn Point 69 - Tin'),
(73942, 4468, 0, 'Spawn Point 69 - Iron'),
(73943, 4468, 10, 'Spawn Point 69 - Silver'),
(73944, 4468, 10, 'Spawn Point 69 - Gold'); 

-- XYZ:-11123.50 -1165.56 44.41 map 0
DELETE FROM pool_gameobject WHERE guid IN (74080,74081,74082,74083,74084) AND pool_entry = 4496;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(74080, 4496, 0, 'Spawn Point 97 - Copper'),
(74081, 4496, 0, 'Spawn Point 97 - Tin'),
(74082, 4496, 0, 'Spawn Point 97 - Iron'),
(74083, 4496, 10, 'Spawn Point 97 - Silver'),
(74084, 4496, 10, 'Spawn Point 97 - Gold'); 
 
-- XYZ:-11129.10 -1153.68 45.12 map 0
DELETE FROM pool_gameobject WHERE guid IN (73755,73756,73757,73758,73759) AND pool_entry = 4431;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(73755, 4431, 0, 'Spawn Point 32 - Copper'),
(73756, 4431, 0, 'Spawn Point 32 - Tin'),
(73757, 4431, 0, 'Spawn Point 32 - Iron'),
(73758, 4431, 10, 'Spawn Point 32 - Silver'),
(73759, 4431, 10, 'Spawn Point 32 - Gold'); 
