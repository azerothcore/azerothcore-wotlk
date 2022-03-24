-- DB update 2022_03_18_17 -> 2022_03_18_18
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_18_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_18_17 2022_03_18_18 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647218276224332700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647218276224332700');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1449 AND `id` IN (7, 8);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1514 AND `id` = 5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1449, 0, 7, 0, 20, 0, 100, 0, 349, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Quest Complete - Set Faction 495'),
(1449, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Just Died - Set Faction 35'),
(1514, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 10, 1219, 1449, 0, 0, 0, 0, 0, 0, 'Mokk the Savage - On Just Died - Set Faction 35 to Doctor');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_18_18' WHERE sql_rev = '1647218276224332700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
