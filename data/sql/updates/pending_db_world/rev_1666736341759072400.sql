-- DELETE old spawns. Blade's Edge had no ore pools. Really.
DELETE FROM `gameobject` WHERE `id` IN (181555, 181556, 181557, 181569, 181570) AND `guid` IN (20849,20858,21779,21780,21781,21782,21783,21784,21785,21786,21787,21788,21789,21858,21859,21865,21882,21883,21884,21885,21886,21887,21888,21889,21890,21891,21892,21893,21894,21913,21914,21921,27619,28059,28126,28291,28301,28304,32787,40207,40208,40209,40210,40211,40212,40213,40214,40215,40216,40217,40218,40219,40220,40221,40222,40242,42252,42254,42257,42302,42306,42339,42344,42345,42347,42348,42349,42350,42351,42352,42353,42354,42355,42357,42358,42359,42361,42362,42364,42365,42366,42368,42371,42373,120198,120202,120223,120239,120241,120242,120243,120558,120559,120567,120568,120571,120572,120577,120665,120666);

-- Fel Iron Deposit
-- SET @GUID = N;
-- SET @POOLMOTHER = N;
-- SET @POOL = N;

DELETE FROM `pool_template` WHERE `description` LIKE '%Nagrand%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+2;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0, 4, 'Nagrand - Fel Iron Deposit - Group 1'),

DELETE FROM `pool_pool` WHERE `description` LIKE '%Nagrand%' AND `pool_id` BETWEEN @POOL+0 AND @POOL+60 AND `mother_pool` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+2;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(@POOL+0 , @POOLMOTHER+0, 0, 'Nagrand - Fel Iron Deposit - Group 1'),

DELETE FROM `pool_template` WHERE `description`='Nagrand - Fel Iron Deposit / Khorium Vein' AND `entry` BETWEEN @POOL+0 AND @POOL+60;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0 , 1, 'Nagrand - Fel Iron Deposit / Khorium Vein'),

DELETE FROM `pool_gameobject` WHERE `description` LIKE '%Nagrand%' AND `guid` BETWEEN @GUID+0 AND @GUID+121 AND `pool_entry` BETWEEN @POOL+0 AND @POOL+60;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+0  , @POOL+0 , 0, 'Fel Iron Deposit - Nagrand'),

DELETE FROM `gameobject` WHERE `map`=530 AND `ZoneId`=3518 AND `id` IN (181555, 181557) AND `guid` BETWEEN @GUID+0 AND @GUID+121;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES

/*---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------HERBS--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------*/

-- Delete Duplicates
DELETE FROM `gameobject` WHERE `guid` IN (40184, 40158, 40191, 40160, 40176);
-- Delete old pools
DELETE FROM `pool_template` WHERE `entry` IN (976);
DELETE FROM `pool_gameobject` WHERE `pool_entry` IN (976);

UPDATE `gameobject` SET `position_z`=64.519707 WHERE `guid`=40157;

SET @POOLMOTHER=1284; -- 12
SET @GUID=71984; -- 10

DELETE FROM `pool_template` WHERE `description` LIKE '%Nagrand%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+11;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0 , 7, 'Nagrand - Felweed - Group 1'),

DELETE FROM `pool_gameobject` WHERE `description` LIKE '%Nagrand%' AND `pool_entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+11;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(56366  , @POOLMOTHER+0, 0, 'Felweed - Nagrand'),

DELETE FROM `gameobject` WHERE `ZoneId`=3518 AND `map`=530 AND `id` IN (181270, 181271) AND `guid` BETWEEN @GUID+0 AND @GUID+9;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES

UPDATE `gameobject` SET `ZoneId`=3518 WHERE `guid` IN (