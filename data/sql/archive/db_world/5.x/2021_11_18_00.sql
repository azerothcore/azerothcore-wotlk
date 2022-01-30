-- DB update 2021_11_17_02 -> 2021_11_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_17_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_17_02 2021_11_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636936439824516200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636936439824516200');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 10814;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10814) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10814, 0, 0, 0, 0, 0, 100, 2, 5000, 12800, 13000, 13000, 0, 11, 15708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chromatic Elite Guard - In Combat - Cast \'Mortal Strike\' (Normal Dungeon)'),
(10814, 0, 1, 0, 0, 0, 100, 2, 5600, 15400, 11200, 25700, 0, 11, 16790, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chromatic Elite Guard - In Combat - Cast \'Knockdown\' (Normal Dungeon)'),
(10814, 0, 2, 0, 0, 0, 100, 2, 12000, 20800, 9000, 9000, 0, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chromatic Elite Guard - In Combat - Cast \'Strike\' (Normal Dungeon)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_18_00' WHERE sql_rev = '1636936439824516200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
