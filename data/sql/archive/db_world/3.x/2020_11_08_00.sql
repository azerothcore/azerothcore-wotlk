-- DB update 2020_11_07_02 -> 2020_11_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_07_02 2020_11_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603642988008842900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603642988008842900');
/*
 * Zone: Swamp of Sorrows II
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 922;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 922);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(922, 0, 0, 0, 0, 0, 100, 0, 2800, 3400, 8800, 9400, 11, 50245, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Silt Crawler - In Combat - Cast \'50245\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1082;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1082);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1082, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 50433, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sawtooth Crocolisk - On Aggro - Cast \'50433\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 757;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 757);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(757, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lost One Fisherman - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14447;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14447);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14447, 0, 0, 0, 0, 0, 100, 0, 2700, 4800, 9600, 12700, 11, 13579, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gilmorian - In Combat - Cast \'13579\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9916;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9916);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9916, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jarquia - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 750;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 750);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(750, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 11700, 13400, 11, 9612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Marsh Inkspewer - In Combat - Cast \'9612\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 752;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 752);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(752, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12550, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Marsh Oracle - On Aggro - Cast \'12550\' (No Repeat)'),
(752, 0, 1, 0, 0, 0, 100, 0, 2300, 2900, 8700, 9600, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Marsh Oracle - In Combat - Cast \'9532\''),
(752, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 11986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Marsh Oracle - Between 20-40% Health - Cast \'11986\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5477;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5477);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5477, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Noboru the Cudgel - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1088;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1088);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1088, 0, 0, 0, 0, 0, 100, 0, 2800, 3400, 8800, 9400, 11, 50245, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Monstrous Crawler - In Combat - Cast \'50245\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 768;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 768);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(768, 0, 0, 0, 0, 0, 100, 0, 2300, 2700, 9700, 12700, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Panther - In Combat - Cast \'51772\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1087;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1087);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1087, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 3604, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sawtooth Snapper - Between 30-60% Health - Cast \'3604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5622;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5622);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5622, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ongeku - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 763;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 763);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(763, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 7165, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lost One Chieftain - On Aggro - Cast \'7165\' (No Repeat)'),
(763, 0, 1, 0, 0, 0, 100, 0, 2700, 3400, 17700, 18400, 11, 11977, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lost One Chieftain - In Combat - Cast \'11977\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 761;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 761);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(761, 0, 0, 0, 2, 0, 100, 1, 50, 90, 0, 0, 11, 8376, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lost One Seer - Between 50-90% Health - Cast \'8376\' (No Repeat)'),
(761, 0, 1, 0, 2, 0, 100, 1, 5, 45, 0, 0, 11, 4971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lost One Seer - Between 5-45% Health - Cast \'4971\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17115;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17115);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17115, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 14868, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cursed Lost One - On Aggro - Cast \'14868\' (No Repeat)'),
(17115, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 6713, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cursed Lost One - Between 20-80% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 862;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 862);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(862, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stonard Explorer - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14448;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14448);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14448, 0, 0, 0, 0, 0, 100, 0, 3800, 4600, 9800, 13400, 11, 21748, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Molt Thorn - In Combat - Cast \'21748\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1084;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1084);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1084, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 50433, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Young Sawtooth Crocolisk - On Aggro - Cast \'50433\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 858;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 858);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(858, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 745, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sorrow Spinner - On Aggro - Cast \'745\' (No Repeat)'),
(858, 0, 1, 0, 0, 0, 100, 0, 2700, 3100, 32700, 33100, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sorrow Spinner - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 767;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 767);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(767, 0, 0, 0, 0, 0, 100, 0, 2300, 2700, 9700, 12700, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Swamp Jaguar - In Combat - Cast \'51772\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 764;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 764);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(764, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 9616, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Swampwalker - Between 30-60% Health - Cast \'9616\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1081;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1081);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1081, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 8138, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mire Lord - Between 20-80% Health - Cast \'8138\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 765;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 765);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(765, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 9616, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Swampwalker Elder - Between 30-60% Health - Cast \'9616\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
