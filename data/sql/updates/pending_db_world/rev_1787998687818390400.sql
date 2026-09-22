--
-- Blacksmithing Plans require the skill needed to learn their contained recipe.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 4 AND (`SourceGroup`, `SourceEntry`) IN ((11524, 11614), (11525, 11615), (13721, 12827), (13722, 12830));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 11524, 11614, 0, 0, 7, 0, 164, 270, 0, 0, 0, 0, '', 'Blacksmithing Plans - Plans: Dark Iron Mail requires Blacksmithing 270'),
(4, 11525, 11615, 0, 0, 7, 0, 164, 280, 0, 0, 0, 0, '', 'Blacksmithing Plans - Plans: Dark Iron Shoulders requires Blacksmithing 280'),
(4, 13721, 12827, 0, 0, 7, 0, 164, 285, 0, 0, 0, 0, '', 'Blacksmithing Plans - Plans: Serenity requires Blacksmithing 285'),
(4, 13722, 12830, 0, 0, 7, 0, 164, 290, 0, 0, 0, 0, '', 'Blacksmithing Plans - Plans: Corruption requires Blacksmithing 290');

-- Pool one Blacksmithing Plans object from eight possible locations per instance.
-- Missing positions and rotations adapted from vmangos/core commit 553b1078 by NickTyrer.
-- Three additional Shoulders locations from Gultask, build numbers pending:
-- https://github.com/azerothcore/azerothcore-wotlk/pull/27745#issuecomment-5767833161
-- The 12-hour respawn follows TrinityCore update 2021_11_24_17_world_2019_03_05_00_world.sql.
SET @POOL := 9687;
SET @OGUID := 43103;

DELETE FROM `gameobject` WHERE `id` IN (173232, 173234) AND `guid` IN (@OGUID + 0, @OGUID + 1, @OGUID + 2, 43117, 43118, 43138, 43139, 43140);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(@OGUID + 0, 173232, 230, 0, 0, 1, 1, 709.659, 57.0049, -44.1391, 2.74016, 0, 0, 0.979924, 0.19937, 43200, 100, 1, '', 0, NULL),
(@OGUID + 1, 173232, 230, 0, 0, 1, 1, 860.409, 36.9705, -53.6437, 2.33874, 0, 0, 0.920505, 0.390732, 43200, 100, 1, '', 0, NULL),
(@OGUID + 2, 173232, 230, 0, 0, 1, 1, 1107.97, -156.909, -74.3595, 2.54818, 0, 0, 0.956305, 0.292372, 43200, 100, 1, '', 0, NULL),
(43117, 173234, 230, 0, 0, 1, 1, 686.841, -8.77618, -58.8389, 3.12412, 0, 0, 0.999962, 0.00873464, 43200, 100, 1, '', 0, NULL),
(43118, 173232, 230, 0, 0, 1, 1, 793.133, -32.2615, -52.628, 1.74533, 0, 0, 0.766045, 0.642787, 43200, 100, 1, '', 0, NULL),
(43138, 173234, 230, 1584, 1584, 1, 1, 852.163, -327.889, -49.366, 0.279252, 0, 0, 0.139173, 0.990268, 43200, 100, 1, '', 0, NULL),
(43139, 173234, 230, 1584, 1584, 1, 1, 631.133, -70.6022, -44.4505, 4.67748, 0, 0, -0.719339, 0.694659, 43200, 100, 1, '', 0, NULL),
(43140, 173234, 230, 1584, 1584, 1, 1, 388.327, -159.248, -64.0879, 5.07891, 0, 0, -0.566406, 0.824126, 43200, 100, 1, '', 0, NULL);

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL, 1, 'Blackrock Depths - Blacksmithing Plans');

DELETE FROM `pool_gameobject` WHERE `guid` IN (@OGUID + 0, @OGUID + 1, @OGUID + 2, 43117, 43118, 43138, 43139, 43140);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID + 0, @POOL, 0, 'Blackrock Depths - Blacksmithing Plans - Dark Iron Mail'),
(@OGUID + 1, @POOL, 0, 'Blackrock Depths - Blacksmithing Plans - Dark Iron Mail'),
(@OGUID + 2, @POOL, 0, 'Blackrock Depths - Blacksmithing Plans - Dark Iron Mail'),
(43117, @POOL, 0, 'Blackrock Depths - Blacksmithing Plans - Dark Iron Shoulders'),
(43118, @POOL, 0, 'Blackrock Depths - Blacksmithing Plans - Dark Iron Mail'),
(43138, @POOL, 0, 'Blackrock Depths - Blacksmithing Plans - Dark Iron Shoulders'),
(43139, @POOL, 0, 'Blackrock Depths - Blacksmithing Plans - Dark Iron Shoulders'),
(43140, @POOL, 0, 'Blackrock Depths - Blacksmithing Plans - Dark Iron Shoulders');
