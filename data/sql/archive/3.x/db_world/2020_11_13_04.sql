-- DB update 2020_11_13_03 -> 2020_11_13_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_13_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_13_03 2020_11_13_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603644756382883100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603644756382883100');
/*
 * Zone: Azeroth [Part II]
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1848;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1848);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1848, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Maldazzar - On Aggro - Cast \'17204\''),
(1848, 0, 1, 0, 0, 0, 100, 0, 1700, 2400, 8700, 10300, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Maldazzar - In Combat - Cast \'12471\''),
(1848, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 17173, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Maldazzar - Between 20-40% Health - Cast \'17173\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6412;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6412);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6412, 0, 0, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeleton - Out of Combat - Despawn In 5000 ms (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1850;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1850);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1850, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17650, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Putridius - On Aggro - Cast \'17650\''),
(1850, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 12946, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Putridius - Between 20-80% Health - Cast \'12946\' (No Repeat)'),
(1850, 0, 2, 0, 0, 0, 100, 0, 3400, 5200, 12700, 16800, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Putridius - In Combat - Cast \'10101\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1851;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1851);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1851, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 17230, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Husk - Between 20-80% Health - Cast \'17230\' (No Repeat)'),
(1851, 0, 1, 0, 0, 0, 100, 0, 2400, 3800, 14900, 16800, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Husk - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1837;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1837);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1837, 0, 0, 0, 0, 0, 100, 0, 2300, 3000, 9800, 10200, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Judge - In Combat - Cast \'14518\''),
(1837, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 13953, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Judge - Between 30-60% Health - Cast \'13953\' (No Repeat)'),
(1837, 0, 2, 0, 2, 0, 100, 1, 10, 25, 0, 0, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Judge - Between 10-25% Health - Cast \'13005\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1841;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1841);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1841, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Executioner - On Aggro - Cast \'8599\''),
(1841, 0, 1, 0, 0, 0, 100, 0, 2500, 3000, 9500, 10000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Executioner - In Combat - Cast \'16856\''),
(1841, 0, 2, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Executioner - Between 40-80% Health - Cast \'15284\' (No Repeat)'),
(1841, 0, 3, 0, 12, 0, 100, 1, 5, 19, 0, 0, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Executioner - Target Between 5-19% Health - Cast \'7160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1838;
UPDATE `creature_template` SET `unit_class`= 2 WHERE `entry`= 1838;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1838);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1838, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 20294, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Interrogator - On Aggro - Cast \'20294\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1843;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1843);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1843, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 11500, 13000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreman Jerris - In Combat - Cast \'3391\''),
(1843, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 15618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreman Jerris - Between 10-30% Health - Cast \'15618\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1844;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1844);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1844, 0, 0, 0, 0, 0, 100, 0, 2450, 3800, 8700, 9200, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreman Marcrid - In Combat - Cast \'11976\''),
(1844, 0, 1, 0, 12, 0, 100, 1, 20, 50, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreman Marcrid - Target Between 20-50% Health - Cast \'15284\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1847;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1847);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1847, 0, 0, 0, 2, 0, 100, 1, 5, 95, 0, 0, 11, 3427, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foulmane - Between 5-95% Health - Cast \'3427\' (No Repeat)'),
(1847, 0, 1, 0, 0, 0, 100, 0, 3100, 4900, 9600, 11200, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foulmane - In Combat - Cast \'3391\''),
(1847, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 13445, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foulmane - Between 30-60% Health - Cast \'13445\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10358;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10358);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10358, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7068, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fellicent\'s Shade - On Aggro - Cast \'7068\''),
(10358, 0, 1, 0, 0, 0, 100, 0, 2300, 3200, 8900, 9600, 11, 13901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fellicent\'s Shade - In Combat - Cast \'13901\''),
(10358, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 11975, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fellicent\'s Shade - Between 20-40% Health - Cast \'11975\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10359;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10359);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10359, 0, 0, 0, 0, 0, 100, 1, 2700, 3900, 0, 0, 11, 3583, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sri\'skulk - In Combat - Cast \'3583\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1531;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1531);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1531, 0, 0, 0, 0, 0, 100, 0, 2200, 2700, 9200, 9700, 11, 7713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lost Soul - In Combat - Cast \'7713\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1910;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1910);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1910, 0, 0, 0, 0, 0, 100, 0, 2400, 3000, 8700, 10100, 11, 2607, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Muad - In Combat - Cast \'2607\''),
(1910, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 332, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muad - Between 30-60% Health - Cast \'332\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1936;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1936);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1936, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 8700, 9200, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Farmer Solliden - In Combat - Cast \'11976\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12431;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12431);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12431, 0, 0, 0, 0, 0, 100, 0, 2400, 2700, 17500, 17800, 11, 13445, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gorefang - In Combat - Cast \'13445\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12433;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12433);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12433, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12040, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Krethis Shadowspinner - On Aggro - Cast \'12040\''),
(12433, 0, 1, 0, 0, 0, 100, 0, 2400, 2800, 6900, 7300, 11, 17439, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Krethis Shadowspinner - In Combat - Cast \'17439\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8213;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8213);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8213, 0, 0, 0, 2, 0, 100, 1, 10, 40, 0, 0, 11, 26064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironback - Between 10-40% Health - Cast \'26064\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14280;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14280);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14280, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 8600, 11400, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Big Samras - In Combat - Cast \'31279\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
