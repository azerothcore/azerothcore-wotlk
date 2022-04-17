-- DB update 2022_03_10_00 -> 2022_03_10_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_10_00 2022_03_10_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646878467204463700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646878467204463700');

UPDATE `creature` SET `position_x` = -7492.67, `position_y` = -1003.49, `position_z` = 408.652, `orientation` = 0 WHERE `guid` = 84603;
UPDATE `creature` SET `position_x` = -7490.95, `position_y` = -1014.89, `position_z` = 408.643, `orientation` = 0 WHERE `guid` = 84615;
UPDATE `creature` SET `position_x` = -7486.45, `position_y` = -1025.62, `position_z` = 408.641, `orientation` = 0 WHERE `guid` = 84614;
UPDATE `creature` SET `position_x` = -7478.53, `position_y` = -996.153, `position_z` = 408.646, `orientation` = 3.62 WHERE `guid` = 84606;
UPDATE `creature` SET `position_x` = -7471.64, `position_y` = -1005.85, `position_z` = 408.648, `orientation` = 3.37 WHERE `guid` = 84616;
UPDATE `creature` SET `position_x` = -7472.52, `position_y` = -1016.94, `position_z` = 408.641, `orientation` = 2.91 WHERE `guid` = 84605;

DELETE FROM `creature` WHERE `guid` IN (84197, 84201, 84200, 84299, 84298);

DELETE FROM `smart_scripts` WHERE `entryorguid` = -84615 AND `source_type` = 0 AND `id` = 8;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-84615, 0, 8, 0, 58, 0, 100, 1, 0, 1399601, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On waypoint ended - Despawn');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_10_01' WHERE sql_rev = '1646878467204463700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
