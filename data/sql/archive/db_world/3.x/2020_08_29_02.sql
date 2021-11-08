-- DB update 2020_08_29_01 -> 2020_08_29_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_29_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_29_01 2020_08_29_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1596556919928240000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596556919928240000');
/*
 * Zone: Azeroth [Part I]
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10199;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10199);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10199, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 17205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grizzle Snowpaw - On Respawn - Cast \'17205\''),
(10199, 0, 1, 0, 0, 0, 100, 0, 1200, 1400, 8600, 8900, 11, 15793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grizzle Snowpaw - In Combat - Cast \'15793\''),
(10199, 0, 2, 0, 0, 0, 100, 0, 6500, 7000, 14200, 16800, 11, 12548, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grizzle Snowpaw - In Combat - Cast \'12548\''),
(10199, 0, 3, 0, 0, 0, 100, 0, 9400, 9900, 24300, 24900, 11, 8364, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grizzle Snowpaw - In Combat - Cast \'8364\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10201;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10201, 0, 0, 0, 0, 0, 100, 0, 3200, 4100, 9800, 11400, 11, 17146, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Hederine - In Combat - Cast \'17146\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10198;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10198);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10198, 0, 0, 0, 0, 0, 100, 0, 2300, 3100, 6750, 9850, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kashoch the Reaver - In Combat - Cast \'15284\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10196;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10196);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10196, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'General Colbatann - On Aggro - Cast \'9128\''),
(10196, 0, 1, 0, 0, 0, 100, 0, 2700, 3200, 6800, 9300, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'General Colbatann - In Combat - Cast \'11971\''),
(10196, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'General Colbatann - Between 20-40% Health - Cast \'13730\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7104;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7104);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7104, 0, 0, 0, 0, 0, 100, 0, 2100, 2200, 6900, 7300, 11, 12058, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dessecus - In Combat - Cast \'12058\''),
(7104, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 8293, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dessecus - Between 20-60% Health - Cast \'8293\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7132;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7132);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7132, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 6400, 7300, 11, 7947, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Toxic Horror - In Combat - Cast \'7947\''),
(7132, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 13582, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Toxic Horror - Between 20-60% Health - Cast \'13582\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7139;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7139);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7139, 0, 0, 0, 0, 0, 100, 0, 2450, 2850, 6950, 7150, 11, 45, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Irontree Stomper - In Combat - Cast \'45\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14343;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14343);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14343, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 15900, 18600, 11, 3589, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Olm the Wise - In Combat - Cast \'3589\''),
(14343, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 6605, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Olm the Wise - Between 5-30% Health - Cast \'6605\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7137;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7137);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7137, 0, 0, 0, 0, 0, 100, 0, 2300, 2600, 14200, 15300, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Immolatus - In Combat - Cast \'10101\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14345;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14345);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14345, 0, 0, 0, 0, 0, 100, 0, 4100, 5200, 85000, 90000, 11, 3335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Ongar - In Combat - Cast \'3335\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14340;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14340);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14340, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alshirr Banebreath - On Aggro - Cast \'13578\''),
(14340, 0, 1, 0, 0, 0, 100, 0, 2100, 2300, 7400, 7500, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Alshirr Banebreath - In Combat - Cast \'9613\''),
(14340, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11962, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Alshirr Banebreath - Between 30-60% Health - Cast \'11962\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14342;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14342);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14342, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ragepaw - On Aggro - Cast \'13583\''),
(14342, 0, 1, 0, 0, 0, 100, 0, 1900, 2100, 7600, 8300, 11, 13584, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ragepaw - In Combat - Cast \'13584\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2192;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2192);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2192, 0, 0, 0, 0, 0, 100, 0, 2200, 2400, 6500, 6800, 11, 20793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Firecaller Radison - In Combat - Cast \'20793\''),
(2192, 0, 1, 0, 2, 0, 100, 1, 40, 60, 0, 0, 11, 11969, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Firecaller Radison - Between 40-60% Health - Cast \'11969\' (No Repeat)'),
(2192, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 5915, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Firecaller Radison - Between 5-30% Health - Cast \'5915\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7015;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7015);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7015, 0, 0, 0, 0, 0, 100, 0, 2400, 3100, 7800, 8600, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flagglemurk the Cruel - In Combat - Cast \'11976\''),
(7015, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flagglemurk the Cruel - Between 20-40% Health - Cast \'11428\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7017;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7017);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7017, 0, 0, 0, 0, 0, 100, 0, 2100, 2900, 6700, 7400, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Sinslayer - In Combat - Cast \'12057\''),
(7017, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 13586, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Sinslayer - Between 20-40% Health - Cast \'13586\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2191;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2191);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2191, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11980, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Licillin - On Aggro - Cast \'11980\''),
(2191, 0, 1, 0, 0, 0, 100, 0, 2100, 2400, 6100, 6300, 11, 20793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Licillin - In Combat - Cast \'20793\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2184;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2184);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2184, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Moongazer - On Aggro - Cast \'6533\''),
(2184, 0, 1, 0, 0, 0, 100, 0, 1100, 1200, 4600, 5300, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Moongazer - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6650;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6650);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6650, 0, 0, 0, 0, 0, 100, 0, 2100, 2200, 6500, 6800, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'General Fangferror - In Combat - Cast \'12057\''),
(6650, 0, 1, 0, 2, 0, 100, 1, 40, 60, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'General Fangferror - Between 40-60% Health - Cast \'15284\' (No Repeat)'),
(6650, 0, 2, 0, 2, 0, 100, 1, 5, 20, 0, 0, 11, 18812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'General Fangferror - Between 5-20% Health - Cast \'18812\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 13896;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 13896);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(13896, 0, 0, 0, 0, 0, 100, 0, 4800, 8200, 12400, 16800, 11, 7938, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scalebeard - In Combat - Cast \'7938\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6646;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6646);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6646, 0, 0, 0, 0, 0, 100, 0, 2300, 3100, 7900, 8400, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Monnos the Elder - In Combat - Cast \'10101\''),
(6646, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Monnos the Elder - Between 40-80% Health - Cast \'5568\' (No Repeat)'),
(6646, 0, 2, 0, 2, 0, 100, 1, 5, 20, 0, 0, 11, 11876, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Monnos the Elder - Between 5-20% Health - Cast \'11876\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6652;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6652);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6652, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 7500, 8100, 11, 21073, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Master Feardred - In Combat - Cast \'21073\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6647;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6647);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6647, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 18651, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magister Hawkhelm - On Aggro - Cast \'18651\''),
(6647, 0, 1, 0, 0, 0, 100, 0, 2100, 2300, 6900, 7300, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magister Hawkhelm - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6651;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6651);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6651, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gatekeeper Rageroar - On Aggro - Cast \'12747\''),
(6651, 0, 1, 0, 0, 0, 100, 0, 2700, 3200, 8600, 9700, 11, 13584, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gatekeeper Rageroar - In Combat - Cast \'13584\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6648;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6648);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6648, 0, 0, 0, 0, 0, 100, 0, 1500, 1600, 16500, 16600, 11, 13445, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Antilos - In Combat - Cast \'13445\''),
(6648, 0, 1, 0, 0, 0, 100, 0, 3800, 4200, 8800, 9200, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Antilos - In Combat - Cast \'40504\''),
(6648, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Antilos - Between 5-30% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8660;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8660, 0, 0, 0, 0, 0, 100, 0, 1700, 1900, 5400, 6200, 11, 20793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Evalcharr - In Combat - Cast \'20793\''),
(8660, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 15797, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Evalcharr - Between 20-40% Health - Cast \'15797\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5931;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5931);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5931, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreman Rigger - On Aggro - Cast \'6533\''),
(5931, 0, 1, 0, 0, 0, 100, 0, 2100, 2400, 22100, 22400, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreman Rigger - In Combat - Cast \'6016\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5932;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5932);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5932, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 16508, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Whipfang - Between 30-60% Health - Cast \'16508\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4066;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4066);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4066, 0, 0, 0, 0, 0, 100, 0, 2100, 2900, 8700, 9900, 11, 15305, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nal\'taszar - In Combat - Cast \'15305\''),
(4066, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 8211, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nal\'taszar - Between 20-40% Health - Cast \'8211\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5915;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5915);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5915, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7090, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brother Ravenoak - On Aggro - Cast \'7090\''),
(5915, 0, 1, 0, 0, 0, 100, 0, 2100, 2900, 8900, 9900, 11, 12161, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brother Ravenoak - In Combat - Cast \'12161\''),
(5915, 0, 2, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 8716, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brother Ravenoak - Between 40-80% Health - Cast \'8716\' (No Repeat)'),
(5915, 0, 3, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 12160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brother Ravenoak - Between 5-30% Health - Cast \'12160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5916;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5916);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5916, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5759, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Amarassan - On Aggro - Cast \'5759\''),
(5916, 0, 1, 0, 0, 0, 100, 0, 2400, 3900, 12400, 13900, 11, 24332, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Amarassan - In Combat - Cast \'24332\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5928;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5928);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5928, 0, 0, 0, 2, 0, 100, 1, 60, 80, 0, 0, 11, 3405, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sorrow Wing - Between 60-80% Health - Cast \'3405\' (No Repeat)'),
(5928, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 3388, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sorrow Wing - Between 20-40% Health - Cast \'3388\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4015;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4015);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4015, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 32100, 32300, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pridewing Patriarch - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5930;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5930);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5930, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 184, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sister Riven - On Aggro - Cast \'184\''),
(5930, 0, 1, 0, 0, 0, 100, 0, 2100, 2200, 47100, 47200, 11, 3356, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sister Riven - In Combat - Cast \'3356\''),
(5930, 0, 2, 0, 0, 0, 100, 0, 4800, 6200, 16800, 19300, 11, 6725, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sister Riven - In Combat - Cast \'6725\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14230;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14230);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14230, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 10100, 10300, 11, 34828, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Burgle Eye - In Combat - Cast \'34828\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4380;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4380);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4380, 0, 0, 0, 0, 0, 100, 0, 7000, 7500, 15000, 15500, 11, 43134, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkmist Widow - In Combat - Cast \'43134\''),
(4380, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkmist Widow - Between 20-80% Health - Cast \'744\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4339;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4339);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4339, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 10100, 10300, 11, 8873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brimgore - In Combat - Cast \'8873\''),
(4339, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 27641, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brimgore - Between 30-60% Health - Cast \'27641\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5851;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5851);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5851, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Gerogg Hammertoe - On Aggro - Cast \'7164\''),
(5851, 0, 1, 0, 2, 0, 100, 1, 40, 60, 0, 0, 11, 3419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Gerogg Hammertoe - Between 40-60% Health - Cast \'3419\' (No Repeat)'),
(5851, 0, 2, 0, 0, 0, 100, 0, 2700, 3200, 12700, 13500, 11, 1672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Gerogg Hammertoe - In Combat - Cast \'1672\''),
(5851, 0, 3, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 15062, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Gerogg Hammertoe - Between 5-30% Health - Cast \'15062\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3253;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3253);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3253, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7278, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Silithid Harvester - On Aggro - Cast \'7278\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5409;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5409);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5409, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 41, 35000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harvester Swarm - Out of Combat - Despawn In 35000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5842;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5842);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5842, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 53625, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Takk the Leaper - On Aggro - Cast \'53625\''),
(5842, 0, 1, 0, 0, 0, 100, 0, 2500, 3000, 12500, 13000, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Takk the Leaper - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3295;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3295);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3295, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 7279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sludge Beast - Between 20-80% Health - Cast \'7279\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3470;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3470);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3470, 0, 0, 0, 0, 0, 100, 0, 2500, 3500, 13500, 14500, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rathorian - In Combat - Cast \'13737\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5786;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5786);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5786, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12024, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Snagglespear - On Aggro - Cast \'12024\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5787;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5787);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5787, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 3019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enforcer Emilgund - Between 5-30% Health - Cast \'3019\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3056;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3056);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3056, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 48000, 49000, 11, 5781, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghost Howl - In Combat - Cast \'5781\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5343;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5343);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5343, 0, 0, 0, 0, 0, 100, 0, 1100, 1300, 8400, 9500, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Szallah - In Combat - Cast \'9532\''),
(5343, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 8435, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Szallah - Between 40-80% Health - Cast \'8435\' (No Repeat)'),
(5343, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 6728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Szallah - Between 10-30% Health - Cast \'6728\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5350;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5350);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5350, 0, 0, 0, 0, 0, 100, 0, 1500, 3000, 31000, 33000, 11, 13298, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Qirot - In Combat - Cast \'13298\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5356;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5356);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5356, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 5543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Snarler - In Combat - Cast \'5543\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5934;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5934);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5934, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 50000, 60000, 11, 8256, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Heartrazor - In Combat - Cast \'8256\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14426;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14426);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14426, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 9000, 12000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Harb Foulmountain - In Combat - Cast \'3391\''),
(14426, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 45, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Harb Foulmountain - Between 30-60% Health - Cast \'45\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14427;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14427);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14427, 0, 0, 0, 0, 0, 100, 0, 2100, 2700, 9800, 10200, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gibblesnik - In Combat - Cast \'11971\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5935;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5935);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5935, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11020, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironeye the Invincible - Between 30-60% Health - Cast \'11020\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8205;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8205);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8205, 0, 0, 0, 0, 0, 100, 0, 1700, 2400, 10700, 12500, 11, 21081, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Haarka the Ravenous - In Combat - Cast \'21081\''),
(8205, 0, 1, 0, 0, 0, 100, 0, 3200, 4900, 11200, 17400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Haarka the Ravenous - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16855;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 16855);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16855, 0, 0, 0, 0, 0, 100, 0, 4500, 6000, 25000, 26000, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tregla - In Combat - Cast \'6016\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
