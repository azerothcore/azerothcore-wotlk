-- Enchanted Scarlet Thread (175966) appears at four locations in a random,
-- non-repeating order. The Stratholme instance script keeps only one active.
SET @OGUID := 238;

DELETE FROM `pool_gameobject` WHERE `guid` IN (20872, @OGUID+0, @OGUID+1, @OGUID+2, @OGUID+3);
DELETE FROM `gameobject` WHERE `guid` IN (20872, @OGUID+0, @OGUID+1, @OGUID+2, @OGUID+3);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(@OGUID+0, 175966, 329, 2017, 2017, 1, 1, 3458.015, -3111.456, 137.434, 5.358161926269531, 0, 0, -0.4462, 0.8949, 604800, 100, 1, '', 53622, 'Archivist Galford room'),
(@OGUID+1, 175966, 329, 2017, 2017, 1, 1, 3593.515, -3060.397, 136.482, 1.5358895063400269, 0, 0, 0.6947, 0.7193, 604800, 100, 1, '', 53622, 'Hall opposite Malor room'),
(@OGUID+2, 175966, 329, 2017, 2017, 1, 1, 3614.640, -3124.924, 137.012, 3.438302755355835, 0, 0, -0.9890, 0.1478, 604800, 100, 1, '', 63306, 'Malor room - table'),
(@OGUID+3, 175966, 329, 2017, 2017, 1, 1, 3625.627, -3123.886, 135.665, 5.777040958404541, 0, 0, -0.2504, 0.9681, 604800, 100, 1, '', 50664, 'Malor room - back-left crate');

UPDATE `gameobject_template` SET `ScriptName` = 'go_enchanted_scarlet_thread' WHERE `entry` = 175966;
