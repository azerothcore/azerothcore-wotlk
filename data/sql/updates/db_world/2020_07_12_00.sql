-- DB update 2020_07_07_00 -> 2020_07_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_07_00 2020_07_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589718441651191400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589718441651191400');
/*
 * Zone: Azshara
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6131;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6131);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6131, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 6800, 7400, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Draconic Mageweaver - In Combat - Cast \'9672\''),
(6131, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 12557, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Draconic Mageweaver - Between 30-60% Health - Cast \'12557\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 193;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 193);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(193, 0, 0, 0, 0, 0, 100, 0, 1700, 1900, 6500, 6800, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blue Dragonspawn - In Combat - Cast \'12057\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8408;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8408);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8408, 0, 0, 0, 0, 0, 100, 0, 2100, 2200, 6400, 6500, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warlord Krellian - In Combat - Cast \'11976\''),
(8408, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 10968, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warlord Krellian - Between 20-80% Health - Cast \'10968\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6140;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6140);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6140, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 7600, 8900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hetaera - In Combat - Cast \'3391\''),
(6140, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 7367, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hetaera - Between 20-80% Health - Cast \'7367\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6144;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6144);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6144, 0, 0, 0, 0, 0, 100, 0, 2800, 3100, 8700, 9300, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Son of Arkkoroc - In Combat - Cast \'10101\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6137;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6137);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6137, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 17100, 17300, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arkkoran Pincer - In Combat - Cast \'13443\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6136;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6136, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 32000, 33000, 11, 8139, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arkkoran Muckdweller - In Combat - Cast \'8139\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6135;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6135);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6135, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 7200, 8100, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arkkoran Clacker - In Combat - Cast \'12057\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6371;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6371);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6371, 0, 0, 0, 0, 0, 100, 0, 1700, 2300, 6800, 7400, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Storm Bay Warrior - In Combat - Cast \'11976\''),
(6371, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 12555, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Storm Bay Warrior - Between 30-60% Health - Cast \'12555\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6348;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6348);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6348, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 6700, 8200, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wavethrasher - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6370;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6370);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6370, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12548, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Makrinni Scrabbler - On Aggro - Cast \'12548\''),
(6370, 0, 1, 0, 0, 0, 100, 0, 2100, 2300, 6100, 6300, 11, 20822, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Makrinni Scrabbler - In Combat - Cast \'20822\''),
(6370, 0, 2, 0, 2, 0, 100, 1, 0, 0, 0, 0, 11, 11642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Makrinni Scrabbler - Between 0-0% Health - Cast \'11642\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6352;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6352);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6352, 0, 0, 0, 0, 0, 100, 0, 2100, 2900, 7600, 8100, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coralshell Lurker - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6146;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6146);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6146, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cliff Breaker - On Aggro - Cast \'11443\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8764;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8764);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8764, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8806, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mistwing Ravager - On Aggro - Cast \'8806\''),
(8764, 0, 1, 0, 0, 0, 100, 0, 2700, 3100, 12700, 13100, 11, 21067, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mistwing Ravager - In Combat - Cast \'21067\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8766;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8766);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8766, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 6907, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Forest Ooze - Between 20-80% Health - Cast \'6907\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6380;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6380);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6380, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12553, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderhead Consort - On Aggro - Cast \'12553\''),
(6380, 0, 1, 0, 0, 0, 100, 0, 2700, 3200, 12800, 13400, 11, 36594, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderhead Consort - In Combat - Cast \'36594\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6147;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6147);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6147, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 8147, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cliff Thunderer - Between 20-80% Health - Cast \'8147\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6198;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6198);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6198, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 7600, 7900, 11, 11969, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Surveyor - In Combat - Cast \'11969\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6199;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6199);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6199, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11640, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Reclaimer - On Aggro - Cast \'11640\''),
(6199, 0, 1, 0, 0, 0, 100, 0, 1900, 2000, 5000, 5100, 11, 20823, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Reclaimer - In Combat - Cast \'20823\''),
(6199, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 11642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Reclaimer - Between 20-40% Health - Cast \'11642\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6200;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6200, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Legashi Satyr - Between 20-80% Health - Cast \'11981\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6202;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6202, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 6100, 6300, 11, 20823, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Legashi Hellcaller - In Combat - Cast \'20823\''),
(6202, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11990, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Legashi Hellcaller - Between 30-60% Health - Cast \'11990\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6201;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6201, 0, 0, 0, 0, 0, 100, 0, 1900, 2300, 6900, 7400, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Legashi Rogue - In Combat - Cast \'7159\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6378;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6378);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6378, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12553, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderhead Skystormer - On Aggro - Cast \'12553\''),
(6378, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 6535, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderhead Skystormer - Between 30-60% Health - Cast \'6535\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6189;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6189);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6189, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 8078, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Ursa - Between 20-80% Health - Cast \'8078\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6188;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6188);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6188, 0, 0, 0, 0, 0, 100, 0, 1700, 1900, 6200, 6500, 11, 20295, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Shaman - In Combat - Cast \'20295\''),
(6188, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 6535, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Shaman - Between 40-80% Health - Cast \'6535\' (No Repeat)'),
(6188, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 11986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Shaman - Between 5-30% Health - Cast \'11986\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6187;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6187);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6187, 0, 0, 0, 0, 0, 100, 1, 6500, 10000, 0, 0, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Den Watcher - In Combat - Cast \'9128\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6377;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6377);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6377, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12553, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderhead Stagwing - On Aggro - Cast \'12553\''),
(6377, 0, 1, 0, 0, 0, 100, 0, 2700, 3100, 8600, 9400, 11, 11019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderhead Stagwing - In Combat - Cast \'11019\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6185;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6185);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6185, 0, 0, 0, 0, 0, 100, 0, 1700, 1900, 17500, 19500, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Warrior - In Combat - Cast \'11977\''),
(6185, 0, 1, 0, 0, 0, 100, 0, 2400, 2600, 7600, 8200, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Warrior - In Combat - Cast \'11976\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6186;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6186);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6186, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8262, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Totemic - On Aggro - Cast \'8262\''),
(6186, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 5605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Totemic - Between 5-30% Health - Cast \'5605\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6184;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6184);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6184, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 16498, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Pathfinder - On Aggro - Cast \'16498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8762;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8762);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8762, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timberweb Recluse - On Aggro - Cast \'745\''),
(8762, 0, 1, 0, 0, 0, 100, 0, 1700, 2000, 31700, 32000, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timberweb Recluse - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6148;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6148);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6148, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 16498, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cliff Walker - On Aggro - Cast \'16498\''),
(6148, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11876, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cliff Walker - Between 30-60% Health - Cast \'11876\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6125;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6125);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6125, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 8900, 9600, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Haldarr Satyr - In Combat - Cast \'12057\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6126;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6126);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6126, 0, 0, 0, 0, 0, 100, 1, 5000, 10000, 0, 0, 11, 7098, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Haldarr Trickster - In Combat - Cast \'7098\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6375;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6375);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6375, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12553, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderhead Hippogryph - On Aggro - Cast \'12553\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6117;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6117);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6117, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highborne Lichling - On Aggro - Cast \'12544\''),
(6117, 0, 1, 0, 0, 0, 100, 0, 2100, 2200, 6100, 6200, 11, 20822, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Highborne Lichling - In Combat - Cast \'20822\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6116;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6116);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6116, 0, 0, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 12542, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Highborne Apparition - Between 20-40% Health - Cast \'12542\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6118;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6118);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6118, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 21007, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Varo\'then\'s Ghost - On Aggro - Cast \'21007\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8759;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8759);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8759, 0, 0, 0, 0, 0, 100, 0, 3200, 3300, 9800, 12500, 11, 12612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mosshoof Runner - In Combat - Cast \'12612\'');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
