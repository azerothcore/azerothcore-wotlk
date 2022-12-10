-- DB update 2020_11_13_02 -> 2020_11_13_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_13_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_13_02 2020_11_13_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603644503167897700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603644503167897700');
/*
 * Zone: Hinterlands II
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2680;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2680);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2680, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Wolf Pup - Between 20-80% Health - Cast \'3149\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2929;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2929);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2929, 0, 0, 0, 0, 0, 100, 0, 3200, 3900, 9200, 9800, 11, 54663, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Savage Owlbeast - In Combat - Cast \'54663\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2505;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2505);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2505, 0, 0, 0, 2, 0, 100, 1, 10, 40, 0, 0, 11, 26064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Saltwater Snapjaw - Between 10-40% Health - Cast \'26064\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12496;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12496);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12496, 0, 0, 0, 0, 0, 100, 0, 2700, 3100, 32700, 33100, 11, 16359, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreamtracker - In Combat - Cast \'16359\''),
(12496, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 6605, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreamtracker - Between 5-30% Health - Cast \'6605\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12478;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12478);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12478, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 38657, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Verdantine Oracle - Between 30-60% Health - Cast \'38657\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12479;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12479);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12479, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 16498, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Verdantine Tree Warder - On Aggro - Cast \'16498\''),
(12479, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 12747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Verdantine Tree Warder - Between 20-80% Health - Cast \'12747\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12477;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12477);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12477, 0, 0, 0, 0, 0, 100, 0, 2700, 3000, 12700, 15600, 11, 12021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Verdantine Boughguard - In Combat - Cast \'12021\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2924;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2924);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2924, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermane Wolf - Between 20-80% Health - Cast \'3149\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
