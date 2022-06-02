-- DB update 2020_06_23_00 -> 2020_06_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_23_00 2020_06_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589121823177850900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589121823177850900');
/*
 * Zone: Felwood
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10648;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10648);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10648, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xavaric - On Aggro - Cast \'13578\''),
(10648, 0, 1, 0, 0, 0, 100, 0, 1400, 1900, 6500, 7200, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Xavaric - In Combat - Cast \'15496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7111;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7111);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7111, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Hellcaller - On Aggro - Cast \'13578\''),
(7111, 0, 1, 0, 0, 0, 100, 0, 2100, 2200, 6400, 6700, 11, 20823, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Hellcaller - In Combat - Cast \'20823\''),
(7111, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 11990, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Hellcaller - Between 10-30% Health - Cast \'11990\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7108;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7108);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7108, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Betrayer - On Aggro - Cast \'13578\''),
(7108, 0, 1, 0, 0, 0, 100, 0, 1100, 1200, 16100, 16200, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Betrayer - In Combat - Cast \'13443\''),
(7108, 0, 2, 0, 0, 0, 100, 0, 4500, 4900, 10700, 11200, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Betrayer - In Combat - Cast \'15496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7107;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7107);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7107, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Trickster - On Aggro - Cast \'13578\''),
(7107, 0, 1, 0, 0, 0, 100, 1, 1100, 1200, 0, 0, 11, 13338, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Trickster - In Combat - Cast \'13338\' (No Repeat)'),
(7107, 0, 2, 0, 0, 0, 100, 1, 5200, 6400, 0, 0, 11, 11980, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Trickster - In Combat - Cast \'11980\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9462;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9462);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9462, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chieftain Bloodmaw - On Aggro - Cast \'13583\''),
(9462, 0, 1, 0, 0, 0, 100, 0, 1700, 1800, 5900, 6200, 11, 15117, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chieftain Bloodmaw - In Combat - Cast \'15117\''),
(9462, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 5915, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chieftain Bloodmaw - Between 5-30% Health - Cast \'5915\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8961;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8961);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8961, 0, 0, 0, 0, 0, 100, 0, 3300, 3900, 9400, 9600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Ravager - In Combat - Cast \'3391\''),
(8961, 0, 1, 0, 0, 0, 100, 1, 6500, 6600, 0, 0, 11, 17230, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Ravager - In Combat - Cast \'17230\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7101;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7101, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 6900, 7300, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warpwood Shredder - In Combat - Cast \'3391\''),
(7101, 0, 1, 0, 0, 0, 100, 0, 5900, 6000, 12800, 12900, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warpwood Shredder - In Combat - Cast \'13444\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7100;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7100, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11922, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warpwood Moss Flayer - On Aggro - Cast \'11922\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7098;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7098);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7098, 0, 0, 0, 0, 0, 100, 0, 2300, 2400, 13400, 13500, 11, 3589, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironbeak Screecher - In Combat - Cast \'3589\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7138;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7138);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7138, 0, 0, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 2091, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Irontree Wanderer - Between 20-60% Health - Cast \'2091\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7149;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7149);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7149, 0, 0, 0, 0, 0, 100, 0, 1900, 2000, 10100, 11200, 11, 5337, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Withered Protector - In Combat - Cast \'5337\''),
(7149, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Protector - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7136;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7136, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 2602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infernal Sentry - On Aggro - Cast \'2602\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9878;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9878);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9878, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Entropic Beast - On Aggro - Cast \'15661\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8960;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8960);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8960, 0, 0, 0, 0, 0, 100, 0, 2100, 2200, 10100, 10200, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Scavenger - In Combat - Cast \'3604\''),
(8960, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 17230, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Scavenger - Between 20-60% Health - Cast \'17230\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9516;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9516);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9516, 0, 0, 0, 0, 0, 100, 0, 2200, 3100, 8600, 9500, 11, 17399, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Banehollow - In Combat - Cast \'17399\''),
(9516, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 16247, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Banehollow - Between 20-60% Health - Cast \'16247\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9517;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9517);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9517, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 7600, 7900, 11, 20825, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Lord Fel\'dan - In Combat - Cast \'20825\''),
(9517, 0, 1, 0, 2, 0, 100, 1, 60, 80, 0, 0, 11, 9081, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Lord Fel\'dan - Between 60-80% Health - Cast \'9081\' (No Repeat)'),
(9517, 0, 2, 0, 2, 0, 100, 1, 15, 30, 0, 0, 11, 16583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Lord Fel\'dan - Between 15-30% Health - Cast \'16583\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9860;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9860);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9860, 0, 0, 0, 1, 0, 100, 1, 20, 80, 0, 0, 11, 13583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Salia - Out of Combat - Cast \'13583\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9861;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9861);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9861, 0, 0, 0, 0, 0, 100, 0, 1700, 1900, 19700, 19900, 11, 11639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moora - In Combat - Cast \'11639\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9518;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9518);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9518, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17227, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rakaiah - On Aggro - Cast \'17227\''),
(9518, 0, 1, 0, 0, 0, 100, 0, 2300, 2400, 9600, 10100, 11, 15968, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rakaiah - In Combat - Cast \'15968\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7093;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7093);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7093, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 21067, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vile Ooze - On Aggro - Cast \'21067\''),
(7093, 0, 1, 0, 0, 0, 100, 0, 2600, 2700, 6200, 7300, 11, 22595, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vile Ooze - In Combat - Cast \'22595\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7118;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7118);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7118, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11962, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Darkweaver - On Aggro - Cast \'11962\''),
(7118, 0, 1, 0, 0, 0, 100, 0, 2350, 2450, 7900, 8150, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Darkweaver - In Combat - Cast \'9613\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9877;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9877);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9877, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Prince Xavalis - On Aggro - Cast \'13578\''),
(9877, 0, 1, 0, 0, 0, 100, 0, 3500, 4500, 18500, 19500, 11, 11962, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prince Xavalis - In Combat - Cast \'11962\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9862;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9862);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9862, 0, 0, 0, 0, 0, 100, 0, 1400, 1800, 7800, 8400, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Legionnaire - In Combat - Cast \'10966\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7114;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7114);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7114, 0, 0, 0, 0, 0, 100, 0, 2100, 2200, 17100, 17200, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Enforcer - In Combat - Cast \'11977\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7125;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7125);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7125, 0, 0, 0, 0, 0, 100, 0, 2400, 3600, 9800, 11500, 11, 13321, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Hound - In Combat - Cast \'13321\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7113;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7113);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7113, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 3639, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Guardian - On Aggro - Cast \'3639\''),
(7113, 0, 1, 0, 0, 0, 100, 0, 3800, 4200, 9600, 9800, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Guardian - In Combat - Cast \'11972\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7112;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7112);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7112, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Cultist - On Aggro - Cast \'11639\''),
(7112, 0, 1, 0, 0, 0, 100, 0, 3100, 3200, 8600, 8900, 11, 20825, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Cultist - In Combat - Cast \'20825\''),
(7112, 0, 2, 0, 2, 0, 100, 1, 40, 60, 0, 0, 11, 11980, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Cultist - Between 40-60% Health - Cast \'11980\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7115;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7115);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7115, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 20832, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Adept - On Aggro - Cast \'20832\''),
(7115, 0, 1, 0, 0, 0, 100, 0, 3100, 3200, 8600, 8700, 11, 20823, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Adept - In Combat - Cast \'20823\''),
(7115, 0, 2, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 14514, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jaedenar Adept - Between 20-60% Health - Cast \'14514\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7099;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7099);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7099, 0, 0, 0, 0, 0, 100, 0, 2400, 2600, 16200, 16400, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironbeak Hunter - In Combat - Cast \'13443\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9454;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9454);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9454, 0, 0, 0, 0, 0, 100, 0, 2200, 2400, 15400, 15600, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Xavathras - In Combat - Cast \'13443\''),
(9454, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xavathras - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7110;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7110);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7110, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 11013, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Shadowstalker - On Respawn - Cast \'11013\''),
(7110, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Shadowstalker - On Aggro - Cast \'13578\''),
(7110, 0, 2, 0, 0, 0, 100, 0, 2600, 3100, 19800, 20100, 11, 14897, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Shadowstalker - In Combat - Cast \'14897\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7106;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7106);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7106, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Rogue - On Aggro - Cast \'13578\''),
(7106, 0, 1, 0, 0, 0, 100, 0, 2800, 3200, 9600, 10400, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Rogue - In Combat - Cast \'7159\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7109;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7109);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7109, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Felsworn - On Aggro - Cast \'13578\''),
(7109, 0, 1, 0, 0, 0, 100, 0, 2400, 2700, 7800, 8100, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Felsworn - In Combat - Cast \'9613\''),
(7109, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 11443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Felsworn - Between 5-30% Health - Cast \'11443\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7105;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7105);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7105, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Satyr - On Aggro - Cast \'13578\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9464;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9464);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9464, 0, 0, 0, 0, 0, 100, 0, 1700, 1900, 6800, 6900, 11, 15793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overlord Ror - In Combat - Cast \'15793\''),
(9464, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 14100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overlord Ror - Between 20-60% Health - Cast \'14100\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7097;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7097);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7097, 0, 0, 0, 0, 0, 100, 0, 1900, 2100, 8600, 9900, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironbeak Owl - In Combat - Cast \'5708\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8959;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8959);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8959, 0, 0, 0, 0, 0, 100, 0, 2700, 3100, 24200, 26500, 11, 3427, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Wolf - In Combat - Cast \'3427\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
