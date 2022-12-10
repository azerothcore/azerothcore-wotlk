-- DB update 2021_10_03_03 -> 2021_10_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_03_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_03_03 2021_10_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632561997649572238'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632561997649572238');

-- Devouring Ectoplasm casts 'Clone' on self when <= 20% health
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3638;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3638) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3638, 0, 0, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 11, 7952, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Devouring Ectoplasm - Between 0-20% Health - Cast \'Clone\' (No Repeat)');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_04_00' WHERE sql_rev = '1632561997649572238';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
