-- DB update 2021_07_07_02 -> 2021_07_07_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_02 2021_07_07_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625314084249000751'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625314084249000751');

-- Verifonix
UPDATE `creature_template` SET `speed_walk` = 1, `MovementType` = 1 WHERE `entry` = 14492;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 where `id` = 14492 AND `guid` IN (49152, 134231, 134232, 134233, 134234, 134235);

-- Diamond Head 
UPDATE `creature_template` SET `speed_walk` = 1, `MovementType` = 1 WHERE `entry` = 5345;
DELETE FROM `creature` WHERE `id` = 5345 AND `guid` = 51843;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51843, 5345, 1, 0, 0, 1, 1, 0, 0, -4748.69, 2897.92, -39.7154, 1.49365, 9900, 15, 0, 2218, 0, 1, 0, 0, 0, '', 0);

-- Lady Szallah 
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 5343;
DELETE FROM `creature` WHERE `id` = 5343 AND `guid` = 51679;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51679, 5343, 1, 0, 0, 1, 1, 11262, 1, -5498.69, 3481.84, -5.82975, 5.64065, 21000, 15, 0, 1919, 1587, 1, 0, 0, 0, '', 0);

-- Qirot 
DELETE FROM `creature` WHERE `id` = 5350 AND `guid` = 51681;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51681, 5350, 1, 0, 0, 1, 1, 11142, 0, -5435.75, 114.241, 28.2281, 4.58413, 21000, 3, 0, 2488, 0, 1, 0, 0, 0, '', 0);

-- Witherheart the Stalker 
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 8218;
DELETE FROM `creature` WHERE `id` = 8218 AND `guid` = 85478;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(85478, 8218, 0, 0, 0, 1, 1, 0, 1, -337.534, -2849.99, 77.1062, 1.57174, 72000, 3, 0, 2218, 0, 1, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_03' WHERE sql_rev = '1625314084249000751';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
