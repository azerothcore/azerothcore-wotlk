-- DB update 2021_09_02_02 -> 2021_09_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_02_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_02_02 2021_09_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630427477948150965'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630427477948150965');

-- Updated the timings and Health values of the Gordunni shamans so they cast it less frequently
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5236 AND `id` IN (4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5236, 0, 4, 0, 74, 0, 100, 0, 0, 25, 20000, 25000, 0, 11, 8005, 1, 0, 0, 0, 0, 9, 0, 0, 0, 1, 0, 0, 0, 0, 'Gordunni Shaman - On Friendly Between 0-25% Health - Cast \'Healing Wave\' every 20 to 25 seconds'),
(5236, 0, 5, 0, 2, 0, 100, 0, 0, 50, 72000, 90000, 0, 11, 8005, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Shaman - Between 0-50% Health - Cast \'Healing Wave\' every 1:20 to 1:30 minutes');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_03_00' WHERE sql_rev = '1630427477948150965';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
