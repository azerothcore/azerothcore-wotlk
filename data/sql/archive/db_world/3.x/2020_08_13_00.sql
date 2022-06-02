-- DB update 2020_08_12_00 -> 2020_08_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_12_00 2020_08_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1592668418033075700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592668418033075700');
/*
 * Zone: Mulgore
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2972;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2972);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2972, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6268, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kodo Calf - On Aggro - Cast \'6268\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2989;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2989);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2989, 0, 0, 0, 0, 0, 100, 1, 2700, 8900, 0, 0, 11, 6016, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Digger - In Combat - Cast \'6016\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2973;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2973);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2973, 0, 0, 0, 0, 0, 100, 1, 2300, 8600, 0, 0, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kodo Bull - In Combat - Cast \'5568\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2969;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2969);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2969, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wiry Swoop - Between 20-80% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2975;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2975);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2975, 0, 0, 0, 2, 0, 100, 1, 0, 10, 0, 0, 25, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Hireling - Between 0-10% Health - Flee For Assist (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2958;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2958);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2958, 0, 0, 0, 0, 0, 100, 0, 2300, 4200, 45000, 45500, 11, 5781, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prairie Wolf - In Combat - Cast \'5781\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2951;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2951);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2951, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 1516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Palemane Poacher - On Aggro - Cast \'1516\''),
(2951, 0, 1, 0, 0, 0, 100, 0, 5000, 6700, 12500, 14500, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Palemane Poacher - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2949;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2949);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2949, 0, 0, 0, 0, 0, 100, 0, 1300, 3200, 9800, 13400, 11, 9739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Palemane Tanner - In Combat - Cast \'9739\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2950;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2950);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2950, 0, 0, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Palemane Skinner - Between 20-40% Health - Cast \'774\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2974;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2974);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2974, 0, 0, 0, 0, 0, 100, 1, 2300, 8700, 0, 0, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kodo Matriarch - In Combat - Cast \'5568\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2963;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2963);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2963, 0, 0, 0, 0, 0, 100, 0, 1700, 3700, 9800, 14900, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windfury Wind Witch - In Combat - Cast \'9532\''),
(2963, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 6982, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windfury Wind Witch - Between 5-30% Health - Cast \'6982\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2962;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2962);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2962, 0, 0, 0, 0, 0, 100, 0, 2700, 3600, 12400, 14800, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windfury Harpy - In Combat - Cast \'9532\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2968;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2968);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2968, 0, 0, 0, 0, 0, 100, 0, 1000, 1300, 7800, 9600, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Galak Outrunner - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2967;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2967);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2967, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 3419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Galak Centaur - On Aggro - Cast \'3419\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2956;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2956);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2956, 0, 0, 0, 2, 0, 100, 1, 10, 20, 0, 0, 11, 7272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Adult Plainstrider - Between 10-20% Health - Cast \'7272\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3051;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3051);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3051, 0, 0, 0, 0, 0, 100, 1, 2700, 6900, 0, 0, 11, 6016, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Supervisor Fizsprocket - In Combat - Cast \'6016\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2977;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2977);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2977, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Taskmaster - Between 20-80% Health - Cast \'5679\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2976;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2976);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2976, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 6016, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Laborer - Between 20-80% Health - Cast \'6016\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2959;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2959);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2959, 0, 0, 0, 0, 0, 100, 1, 2700, 8600, 0, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prairie Stalker - In Combat - Cast \'3604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2970;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2970);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2970, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Swoop - Between 30-60% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3035;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3035);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3035, 0, 0, 0, 0, 0, 100, 1, 2800, 6400, 0, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flatland Cougar - In Combat - Cast \'3604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2978;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2978);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2978, 0, 0, 0, 0, 0, 100, 1, 2700, 9800, 0, 0, 11, 6016, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Worker - In Combat - Cast \'6016\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2971;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2971);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2971, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Taloned Swoop - Between 30-60% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2957;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2957);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2957, 0, 0, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 7272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Plainstrider - Between 20-40% Health - Cast \'7272\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2960;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2960);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2960, 0, 0, 0, 0, 0, 100, 1, 2400, 8900, 0, 0, 11, 5781, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prairie Wolf Alpha - In Combat - Cast \'5781\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2964;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2964);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2964, 0, 0, 0, 0, 0, 100, 0, 2100, 3400, 12100, 13400, 11, 13322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windfury Sorceress - In Combat - Cast \'13322\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2965;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2965);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2965, 0, 0, 0, 0, 0, 100, 0, 2800, 3200, 10800, 13200, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windfury Matriarch - In Combat - Cast \'9532\''),
(2965, 0, 1, 0, 2, 0, 100, 1, 10, 40, 0, 0, 11, 332, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Windfury Matriarch - Between 10-40% Health - Cast \'332\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
