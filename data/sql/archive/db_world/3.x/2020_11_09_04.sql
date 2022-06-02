-- DB update 2020_11_09_03 -> 2020_11_09_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_09_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_09_03 2020_11_09_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603642724794965100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603642724794965100');
/*
 * Zone: Duskwood
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 898;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 898);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(898, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 58867, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nightbane Worgen - On Aggro - Cast \'58867\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 213;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 213);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(213, 0, 0, 0, 2, 0, 100, 1, 1, 5, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Starving Dire Wolf - Between 1-5% Health - Cast \'3149\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3, 0, 0, 0, 2, 0, 100, 0, 1, 5, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flash Eater - Between 1-5% Health - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1871;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1871);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1871, 0, 0, 0, 0, 0, 100, 0, 5700, 6900, 14500, 17800, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Eliza\'s Guard - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 521;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 521);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(521, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lupos - Between 20-80% Health - Cast \'3149\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 923;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 923);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(923, 0, 0, 0, 2, 0, 100, 1, 1, 5, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Young Black Ravager - Between 1-5% Health - Cast \'3149\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
