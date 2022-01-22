-- DB update 2021_10_13_03 -> 2021_10_13_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_13_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_13_03 2021_10_13_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625055681072662039'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625055681072662039');

-- Old Grizzlegut ID 5352, speed_walk to 1, MovementType to 1, wander_distance to 15, 
UPDATE `creature_template` SET `speed_walk` = 1, `MovementType` = 1 WHERE `entry` = 5352;
DELETE FROM `creature` WHERE `id` = 5352 AND `guid` = 51839;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51839, 5352, 1, 0, 0, 1, 1, 0, 0, -5120.65, 1308.87, 37.6403, 0.760874, 9900, 15, 0, 2574, 0, 1, 0, 0, 0, '', 0);

-- Bloodroar ID 5346, MovementType to 1, wander_distance to 10.
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 5346;
DELETE FROM `creature` WHERE `id` = 5346 AND `guid` = 51841;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51841, 5346, 1, 0, 0, 1, 1, 0, 0, -5043.28, 1615.39, 70.4387, 1.53842, 9900, 10, 0, 2576, 0, 1, 0, 0, 0, '', 0);

-- Arash-ethis 5349, MovementType to 1, wander_distance to 15.
DELETE FROM `creature` WHERE `id` = 5349 AND `guid` = 51844;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51844, 5349, 1, 0, 0, 1, 1, 0, 0, -3525.88, 2328.92, 63.964, 2.02379, 9900, 15, 0, 2672, 0, 1, 0, 0, 0, '', 0);

-- Qiaga the Keeper 7996, MovementType to 1, wander_distance to 3.
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 7996;
DELETE FROM `creature` WHERE `id` = 7996 AND `guid` = 93428;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(93428, 7996, 0, 0, 0, 1, 1, 7122, 1, -285.042, -3447.88, 188.545, 4.58799, 350, 3, 0, 2326, 4393, 1, 0, 0, 0, '', 0);

-- Morta'gya the Keeper 8636, MovementType to 1, wander_distance to 3.
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 8636;
DELETE FROM `creature` WHERE `id` = 8636 AND `guid` = 93453;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(93453, 8636, 0, 0, 0, 1, 1, 7918, 1, -287.602, -3453.63, 190.13, 4.96782, 350, 3, 0, 2326, 4393, 1, 0, 0, 0, '', 0);

-- Gorlash 1492, MovementType to 1, wander_distance to 15.
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 1492;
DELETE FROM `creature` WHERE `id` = 1492 AND `guid` = 2634;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(2634, 1492, 0, 0, 0, 1, 1, 10039, 0, -14135.3, -137.275, -8.33448, 3.85509, 360, 15, 0, 6604, 0, 1, 0, 0, 0, '', 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_13_04' WHERE sql_rev = '1625055681072662039';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
