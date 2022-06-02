-- DB update 2020_11_10_01 -> 2020_11_10_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_10_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_10_01 2020_11_10_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603642612256549200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603642612256549200');
/*
 * Zone: Westfall
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7053;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7053);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7053, 0, 0, 0, 0, 0, 100, 0, 3100, 4700, 9600, 12500, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Klaven Mortwake - In Combat - Cast \'14873\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7056;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7056);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7056, 0, 0, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - Out of Combat - Cast \'22766\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6250;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6250);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6250, 0, 0, 0, 0, 0, 100, 0, 2800, 3400, 8800, 9400, 11, 50245, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crawler - In Combat - Cast \'50245\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7052;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7052);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7052, 0, 0, 0, 0, 0, 100, 0, 3100, 4700, 8600, 10100, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - In Combat - Cast \'5679\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 114;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 114);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(114, 0, 0, 0, 2, 0, 100, 0, 1, 5, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Harvest Watcher - Between 1-5% Health - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7051;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7051);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7051, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 7165, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malformed Defias Drone - On Aggro - Cast \'7165\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 831;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 831);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(831, 0, 0, 0, 0, 0, 100, 0, 2800, 3400, 8800, 9400, 11, 50245, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sea Crawler - In Combat - Cast \'50245\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7067;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7067);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7067, 0, 0, 0, 0, 0, 100, 0, 3800, 4900, 9800, 13800, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Drone - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 830;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 830);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(830, 0, 0, 0, 0, 0, 100, 0, 2800, 3400, 8800, 9400, 11, 50245, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sand Crawler - In Combat - Cast \'50245\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 36;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 36);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(36, 0, 0, 0, 2, 0, 100, 0, 1, 5, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Harvest Golem - Between 1-5% Health - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 596;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 596);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(596, 0, 0, 0, 0, 0, 100, 0, 2300, 4100, 7400, 9800, 11, 20883, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brainwashed Noble - In Combat - Cast \'20883\''),
(596, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 6117, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brainwashed Noble - Between 30-60% Health - Cast \'6117\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1216;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1216);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1216, 0, 0, 0, 0, 0, 100, 0, 2800, 3400, 8800, 9400, 11, 50245, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shore Crawler - In Combat - Cast \'50245\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 199;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 199);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(199, 0, 0, 0, 2, 0, 100, 1, 1, 5, 0, 0, 11, 31273, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Fleshripper - Between 1-5% Health - Cast \'31273\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
