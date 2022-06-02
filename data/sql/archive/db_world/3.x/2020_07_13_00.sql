-- DB update 2020_07_12_00 -> 2020_07_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_12_00 2020_07_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589718566727079200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589718566727079200');
/*
 * Zone: Ashenvale
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3931;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3931);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3931, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 12160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadethicket Oracle - Between 30-60% Health - Cast \'12160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3736;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3736);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3736, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 9800, 12600, 11, 3602, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkslayer Mordenthal - In Combat - Cast \'3602\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6072;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6072);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6072, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 11600, 12400, 11, 17620, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Diathorus the Seeker - In Combat - Cast \'17620\''),
(6072, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 37624, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Diathorus the Seeker - Between 30-60% Health - Cast \'37624\' (No Repeat)'),
(6072, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 12542, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Diathorus the Seeker - Between 5-30% Health - Cast \'12542\' (No Repeat)');

UPDATE `creature_template` SET `unit_class` = '8' WHERE `entry` = 4619;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4619;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4619);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4619, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7098, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Geltharis - On Aggro - Cast \'7098\''),
(4619, 0, 1, 0, 0, 0, 100, 0, 2100, 2400, 10700, 11300, 11, 35913, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Geltharis - In Combat - Cast \'35913\''),
(4619, 0, 2, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 37628, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Geltharis - Between 40-80% Health - Cast \'37628\' (No Repeat)'),
(4619, 0, 3, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 6925, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Geltharis - Between 5-15% Health - Cast \'6925\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3825;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3825);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3825, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostpaw Alpha - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3815;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3815);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3815, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 8611, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blink Dragon - Between 30-60% Health - Cast \'8611\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3730;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3730);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3730, 0, 0, 0, 0, 0, 100, 0, 1700, 1900, 8700, 9600, 11, 3602, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dark Strand Excavator - In Combat - Cast \'3602\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4789;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4789);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4789, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 30831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Rogue - On Respawn - Cast \'30831\''),
(4789, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6205, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Rogue - On Aggro - Cast \'6205\''),
(4789, 0, 2, 0, 0, 0, 100, 0, 2100, 2300, 8700, 9600, 11, 6595, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Rogue - In Combat - Cast \'6595\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4788;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4788);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4788, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Satyr - On Aggro - Cast \'7164\''),
(4788, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Satyr - Between 20-60% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3812;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3812);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3812, 0, 0, 0, 0, 0, 100, 0, 2400, 3100, 8600, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Clattering Crawler - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3814;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3814);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3814, 0, 0, 0, 0, 0, 100, 0, 2400, 3100, 8600, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spined Crawler - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3809;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3809);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3809, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 9400, 10800, 11, 15793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashenvale Bear - In Combat - Cast \'15793\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
