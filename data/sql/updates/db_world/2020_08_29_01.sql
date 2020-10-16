-- DB update 2020_08_29_00 -> 2020_08_29_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_29_00 2020_08_29_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1596557161717294700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596557161717294700');
/*
 * Zone: Thousand Needles
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4248;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4248);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4248, 0, 0, 0, 0, 0, 100, 0, 1700, 2400, 9800, 12600, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pesterhide Hyena - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4124;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4124);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4124, 0, 0, 0, 0, 0, 100, 0, 2100, 3700, 12700, 13400, 11, 24331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Needles Cougar - In Combat - Cast \'24331\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4249;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4249);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4249, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 6576, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pesterhide Snarler - Between 5-30% Health - Cast \'6576\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4154;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4154);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4154, 0, 0, 0, 12, 0, 100, 1, 5, 30, 0, 0, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Salt Flats Scavenger - Target Between 5-30% Health - Cast \'7160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4158;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4158);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4158, 0, 0, 0, 12, 0, 100, 1, 5, 30, 0, 0, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Salt Flats Vulture - Target Between 5-30% Health - Cast \'7160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4130;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4130);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4130, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Silithid Searcher - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9377;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9377);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9377, 0, 0, 0, 0, 0, 100, 0, 1700, 2300, 8700, 9200, 11, 10093, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Swirling Vortex - In Combat - Cast \'10093\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
