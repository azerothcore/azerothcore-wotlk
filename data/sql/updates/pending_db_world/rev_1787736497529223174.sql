-- Enchanted Scarlet Thread (175966) appears at four locations in a random,
-- non-repeating order. The Stratholme instance script keeps only one active.
SET @OGUID := 5714446;

DELETE FROM `pool_gameobject` WHERE `guid` IN (20872, @OGUID+0, @OGUID+1, @OGUID+2);
DELETE FROM `gameobject` WHERE `id` = 175966;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(20872,    175966, 329, 2017, 2017, 1, 1, 3614.64, -3124.92, 137.012, -2.84489, 0, 0, -0.989016, 0.147808, 604800, 100, 1, '', 0, 'Malor room - table'),
(@OGUID+0, 175966, 329, 2017, 2017, 1, 1, 3457.50, -3111.17, 137.482,  2.02300, 0, 0,  0.847629, 0.530590, 604800, 100, 1, '', 0, 'Archivist Galford room'),
(@OGUID+1, 175966, 329, 2017, 2017, 1, 1, 3585.85, -3061.59, 136.515,  5.31000, 0, 0,  0.467617, -0.883931, 604800, 100, 1, '', 0, 'Hall opposite Malor room'),
(@OGUID+2, 175966, 329, 2017, 2017, 1, 1, 3622.53, -3124.53, 135.779,  0.00000, 0, 0,  0.000000, 1.000000, 604800, 100, 1, '', 0, 'Malor room - back-left crate');

UPDATE `gameobject_template` SET `ScriptName` = 'go_enchanted_scarlet_thread' WHERE `entry` = 175966;
