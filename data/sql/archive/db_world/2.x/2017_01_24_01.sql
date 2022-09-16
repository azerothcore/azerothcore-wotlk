-- DB update 2017_01_24_00 -> 2017_01_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_01_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_01_24_00 2017_01_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1479505563721235300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1479505563721235300');

DELETE FROM `smart_scripts` WHERE `entryorguid` = "938";

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(938, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 1784, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Commando - Out of Combat - Cast \'Stealth\''),
(938, 0, 1, 0, 0, 0, 100, 0, 2400, 4100, 2400, 4100, 11, 2591, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Commando - In Combat - Cast \'Backstab\''),
(938, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 11, 7964, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Commando - Between 0-15% Health - Cast \'Smoke Bomb\'');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
