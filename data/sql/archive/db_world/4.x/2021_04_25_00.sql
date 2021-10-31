-- DB update 2021_04_24_02 -> 2021_04_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_24_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_24_02 2021_04_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1617974280334682621'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617974280334682621');

-- Splintered Skeleton
SET @ENTRY := 10478;

-- Add SAI for Hate to zero
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 25, 0, 18000, 20000, 20000, 20000, 0, 11, 11838, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Splintered Skeleton - In Combat - Cast \'Serverside - Hate to Zero\'');

-- Set Creature spawn locations
DELETE FROM `creature` WHERE (`id` = @ENTRY);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(48855, @ENTRY, 289, 2057, 2057, 1, 1, 9789, 0, 130.59, -2.94946, 75.3979, 3.88106, 86400, 9.26609, 0, 8883, 0, 1, 0, 0, 0, '', 0),
(48853, @ENTRY, 289, 2057, 2057, 1, 1, 11401, 0, 130.454, 11.1551, 75.3979, 2.60897, 86400, 2.18645, 0, 8883, 0, 1, 0, 0, 0, '', 0),
(48852, @ENTRY, 289, 2057, 2057, 1, 1, 9788, 0, 125.041, -7.80471, 75.3979, 4.7045, 86400, 1.84464, 0, 8883, 0, 1, 0, 0, 0, '', 0),
(48856, @ENTRY, 289, 2057, 2057, 1, 1, 9790, 0, 130.76, -13.64, 75.3979, 1.99339, 86400, 2.07342, 0, 8883, 0, 1, 0, 0, 0, '', 0),
(48851, @ENTRY, 289, 2057, 2057, 1, 1, 9788, 0, 123.429, 5.89935, 75.3979, 3.36196, 86400, 1.84617, 0, 8883, 0, 1, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
