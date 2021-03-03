-- DB update 2019_03_24_00 -> 2019_03_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_24_00 2019_03_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553294024713457200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553294024713457200');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7750;

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7750);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7750, 0, 0, 0, 20, 0, 100, 0, 2701, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(7750, 0, 1, 2, 19, 0, 100, 0, 2701, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 14, 44733, 141980, 0, 0, 0, 0, 0, ''),
(7750, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 14, 44732, 141981, 0, 0, 0, 0, 0, '');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
