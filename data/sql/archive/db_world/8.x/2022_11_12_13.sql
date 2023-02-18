-- DB update 2022_11_12_12 -> 2022_11_12_13
--
SET @GUID = 21780;
SET @POOL = 1163;

DELETE FROM `gameobject` WHERE `id`=182589 AND `map`=560 AND `guid` IN (30242,30243,30244,30263,30286,33565,33567,34868);
DELETE FROM `gameobject` WHERE `id`=182589 AND `map`=560 AND `guid` BETWEEN @GUID+0 AND @GUID+14;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `ZoneId`, `AreaId`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID+0 , 182589, 560, 2367, 2370, 3, 2151.68, 248.571, 53.8705, -1.93731, 86400, 100, 1),
(@GUID+1 , 182589, 560, 2367, 2370, 3, 2067.49, 106.071, 54.6145, -1.93731, 86400, 100, 1),
(@GUID+2 , 182589, 560, 2367, 2370, 3, 2100.11, 43.5364, 53.5583, 0.680678, 86400, 100, 1),
(@GUID+3 , 182589, 560, 2367, 2370, 3, 2213.61, 247.538, 53.646, -0.087267, 86400, 100, 1),
(@GUID+4 , 182589, 560, 2367, 2370, 3, 2080.19, 64.7402, 53.8836, 2.25148, 86400, 100, 1),
(@GUID+5 , 182589, 560, 2367, 2370, 3, 2080.12, 73.7365, 53.7249, 3.05433, 86400, 100, 1),
(@GUID+6 , 182589, 560, 2367, 2370, 3, 2226.61, 251.616, 53.8043, -2.26893, 86400, 100, 1),
(@GUID+7 , 182589, 560, 2367, 2370, 3, 2056.08, 112.369, 54.6098, 0.366519, 86400, 100, 1),
(@GUID+8 , 182589, 560, 2367, 2370, 3, 2199.23, 272.604, 53.9846, 1.5441, 86400, 100, 1),
(@GUID+9 , 182589, 560, 2367, 2370, 3, 2176.01, 265.24, 53.6466, 0.669957, 86400, 100, 1),
(@GUID+10, 182589, 560, 2367, 2370, 3, 2168.72, 244.449, 53.7167, 5.79311, 86400, 100, 1),
(@GUID+11, 182589, 560, 2367, 2370, 3, 2078.53, 129.964, 54.2812, 5.95176, 86400, 100, 1),
(@GUID+12, 182589, 560, 2367, 2370, 3, 2062.71, 77.1961, 53.9166, 3.64426, 86400, 100, 1),
(@GUID+13, 182589, 560, 2367, 2370, 3, 2108.03, 54.9457, 53.6505, 1.23779, 86400, 100, 1),
(@GUID+14, 182589, 560, 2367, 2370, 3, 2119.21, 42.4893, 53.7846, 5.79153, 86400, 100, 1);

DELETE FROM `pool_template` WHERE `description` LIKE '%Escape from Durnholde Keep - Barrel (182589)%' AND `entry` BETWEEN @POOL+0 AND @POOL+4;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0, 1, 'Escape from Durnholde Keep - Barrel (182589) - Group 1'),
(@POOL+1, 1, 'Escape from Durnholde Keep - Barrel (182589) - Group 2'),
(@POOL+2, 1, 'Escape from Durnholde Keep - Barrel (182589) - Group 3'),
(@POOL+3, 1, 'Escape from Durnholde Keep - Barrel (182589) - Group 4'),
(@POOL+4, 1, 'Escape from Durnholde Keep - Barrel (182589) - Group 5');

DELETE FROM `pool_gameobject` WHERE `description` LIKE '%Barrel (182589) - Escape from Durnholde Keep%' AND `pool_entry` BETWEEN @POOL+0 AND @POOL+4;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
-- GROUP 1
(@GUID+6 , @POOL+0, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 1'),
(@GUID+3 , @POOL+0, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 1'),
(@GUID+8 , @POOL+0, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 1'),
-- GROUP 2
(@GUID+0 , @POOL+1, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 2'),
(@GUID+10, @POOL+1, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 2'),
(@GUID+9 , @POOL+1, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 2'),
-- GROUP 3
(@GUID+1 , @POOL+2, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 3'),
(@GUID+7 , @POOL+2, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 3'),
(@GUID+11, @POOL+2, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 3'),
-- GROUP 4
(@GUID+4 , @POOL+3, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 4'),
(@GUID+5 , @POOL+3, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 4'),
(@GUID+12, @POOL+3, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 4'),
-- GROUP 5
(@GUID+14, @POOL+4, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 5'),
(@GUID+13, @POOL+4, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 5'),
(@GUID+2 , @POOL+4, 0, 'Barrel (182589) - Escape from Durnholde Keep - Group 5');
