-- DB update 2020_08_27_00 -> 2020_08_27_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_27_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_27_00 2020_08_27_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1596557352309685400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596557352309685400');
/*
 * Zone: Un'Goro Crater
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6506;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6506);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6506, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6268, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ravasaur Runner - On Aggro - Cast \'6268\''),
(6506, 0, 1, 0, 0, 0, 100, 0, 1700, 2400, 8400, 9800, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ravasaur Runner - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6560;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6560);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6560, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5810, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Guardian - Between 30-60% Health - Cast \'5810\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6508;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6508);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6508, 0, 0, 0, 0, 0, 100, 0, 2700, 3200, 8400, 9300, 11, 14108, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venomhide Ravasaur - In Combat - Cast \'14108\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6556;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6556);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6556, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 14130, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Muculent Ooze - Between 20-80% Health - Cast \'14130\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6514;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6514);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6514, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 12555, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Un\'Goro Gorilla - Between 30-60% Health - Cast \'12555\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6521;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6521);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6521, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11350, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Blaze - On Aggro - Cast \'11350\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
