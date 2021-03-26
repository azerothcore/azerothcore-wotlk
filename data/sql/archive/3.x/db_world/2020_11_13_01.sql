-- DB update 2020_11_13_00 -> 2020_11_13_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_13_00 2020_11_13_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603644571603416100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603644571603416100');
/*
 * Zone: Silverpine Forest
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1971;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1971);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1971, 0, 0, 0, 0, 0, 100, 0, 2700, 3100, 5400, 5800, 11, 7668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ivar the Foul - In Combat - Cast \'7668\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1869;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1869);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1869, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ravenclaw Champion - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1780;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1780);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1780, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 744, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moss Stalker - Between 20-80% Health - Cast \'744\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1766;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1766);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1766, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3150, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mottled Worg - Between 20-80% Health - Cast \'3150\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1770;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1770);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1770, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonrage Darkrunner - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1769;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1769);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1769, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moonrage Whitescalp - On Aggro - Cast \'12544\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1778;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1778);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1778, 0, 0, 0, 0, 0, 100, 0, 2700, 3000, 7700, 8000, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ferocious Grizzled Bear - In Combat - Cast \'31279\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1765;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1765);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1765, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Worg - Between 20-80% Health - Cast \'3149\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1972;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1972);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1972, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimson the Pale - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1782;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1782);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1782, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moonrage Darksoul - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1779;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1779);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1779, 0, 0, 0, 0, 0, 100, 0, 3100, 3900, 8700, 10200, 11, 6958, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonrage Glutton - In Combat - Cast \'6958\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2332;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2332);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2332, 0, 0, 0, 0, 0, 100, 0, 2400, 2700, 8800, 9400, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Valdred Moray - In Combat - Cast \'14873\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2053;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2053);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2053, 0, 0, 0, 0, 0, 100, 0, 2700, 3000, 22700, 23000, 11, 3261, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Haggard Refugee - In Combat - Cast \'3261\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2054;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2054);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2054, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 5164, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sickly Refugee - Between 20-80% Health - Cast \'5164\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1923;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1923);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1923, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodsnout Worg - Between 20-80% Health - Cast \'3149\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1924;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1924);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1924, 0, 0, 0, 0, 0, 100, 0, 2700, 3000, 17700, 18000, 11, 3264, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonrage Bloodhowler - In Combat - Cast \'3264\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1797;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1797);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1797, 0, 0, 0, 0, 0, 100, 0, 2700, 3000, 7700, 8000, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Giant Grizzled Bear - In Combat - Cast \'31279\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
