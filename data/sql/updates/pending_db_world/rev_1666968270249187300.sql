-- Shadowmoon
-- Totals:
-- GUIDs: 124 + 182 + 42 + 12 = 360
-- Pools: 62 + 91 + 14 = 167
-- Mother Pools: 7 + 9 + 2 + 19 = 37

-- DELETE old spawns 
DELETE FROM `gameobject` WHERE `id` IN (181555, 181556, 181557, 181569, 181570) AND `guid` IN (21799, 21800, 21801, 21802, 21803, 21804, 21805, 21806, 21807, 21841, 21906, 21907, 21908, 21909, 21910, 21922, 28145, 28146, 28419, 28421, 28432, 28433, 28446, 30439, 30857, 40429, 40430, 40431, 40455, 40456, 40457, 40458, 40481, 40482, 40483, 40484, 40485, 40486, 40487, 40488, 40489, 40490, 40491, 40492, 40493, 40494, 40495, 40496, 40497, 40498, 40499, 40500, 40501, 40502, 40503, 40504, 40505, 40506, 40507, 40508, 40509, 40510, 40511, 40512, 40513, 40514, 42158, 42159, 42160, 42268, 42286, 42356, 42360, 42363, 42369, 42372, 42374, 42375, 42376, 42379, 42381, 42382, 42383, 42387, 61768, 61910, 61922, 63201, 120196, 120197, 120207, 120235, 120236, 120240, 120663, 120664);

-- Fel Iron Deposit
SET @GUID = 102611; -- 124
SET @POOLMOTHER = 8176; -- 7
SET @POOL = 12680; -- 62

DELETE FROM `pool_template` WHERE `description` LIKE '%Blade\'s Edge Mountains - Fel Iron Deposit%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+6;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0, 1, 'Blade\'s Edge Mountains - Fel Iron Deposit - Group 1'),

DELETE FROM `pool_pool` WHERE `description` LIKE '%Nagrand - Fel Iron Deposit%' AND `pool_id` BETWEEN @POOL+0 AND @POOL+60 AND `mother_pool` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+2;
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
DELETE FROM `gameobject` WHERE `guid` IN ();
-- Delete old pools
DELETE FROM `pool_template` WHERE `entry` IN (976);
DELETE FROM `pool_gameobject` WHERE `pool_entry` IN (976);

UPDATE `gameobject` SET `position_z`=64.519707 WHERE `guid`=40157;

SET @POOLMOTHER=8164; -- 12
SET @GUID=102601; -- 10

DELETE FROM `pool_template` WHERE `description` LIKE '%Nagrand%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+11;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0 , 7, 'Nagrand - Felweed - Group 1'),

DELETE FROM `pool_gameobject` WHERE `description` LIKE '%Nagrand%' AND `pool_entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+11;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
-- FELWEED
-- GROUP 1
(56366  , @POOLMOTHER+0, 0, 'Felweed - Nagrand'),

DELETE FROM `gameobject` WHERE `ZoneId`=3518 AND `map`=530 AND `id` IN (181270, 181271) AND `guid` BETWEEN @GUID+0 AND @GUID+9;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES

UPDATE `gameobject` SET `ZoneId`=3518 WHERE `guid` IN (56366,55626,56364,56061,5147,42140,55681,40175,21361,87145,55192,40174,21362,42189,40168,42208,40157,21363,40173,40172,21364,40152,26632,42209,85968,55691,42394,40155,55195,21349,56377,21358,85964,87417,21357,42187,42423,87416,42422,40166,56368,40165,40163,40164,40171,21359,21360,40180,40170,40169,40159,5372,21356,55628,40161,40177,40182,40154,21350,40178,21351,87413,56367,40162,40156,42188,21352,40153,21353,40167,5324,21354,56365,42331,21355,40181,40179,26684,26694,30581,26667,21466,85983,42143,87429,42393,85982,40193,40194,21456,87427,87430,21457,30680,40187,87432,40186,26673,21459,21458,40185,21460,21464,56410,30679,21463,40195,40188,42407,26674,21462,21465,42144,42142,87431,40190,21461,40192,40183,42207,42333,26700,26698,42139,21468,21467,5647,87150);
UPDATE `gameobject` SET `ZoneId`=3518, `AreaId`=3764 WHERE `guid` IN (21472,30627,40189,21471,21470,21469,42138,21596,42141,40104,21597);
