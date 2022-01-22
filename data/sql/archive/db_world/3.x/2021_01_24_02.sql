-- DB update 2021_01_24_01 -> 2021_01_24_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_24_01 2021_01_24_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1610768378723362000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610768378723362000');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2784;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2784 AND `id` IN (0,1,2,3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(2784, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 4, 5896, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'King Magni Bronzebeard - On Aggro - Play Sound 5896'),
(2784, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 25000, 30000, 0, 11, 19135, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'King Magni Bronzebeard - In Combat - Cast Avatar'),
(2784, 0, 2, 0, 0, 0, 100, 0, 8000, 10000, 20000, 30000, 0, 11, 20686, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'King Magni Bronzebeard - In Combat - Cast Knock Away'),
(2784, 0, 3, 0, 0, 0, 100, 0, 12000, 15000, 15000, 20000, 0, 11, 20685, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'King Magni Bronzebeard - In Combat - Cast Storm Bolt');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
