-- DB update 2020_08_24_00 -> 2020_08_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_24_00 2020_08_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1595681632336513000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595681632336513000');
/*
 * Zone: Feralas
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5363;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5363);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5363, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 6595, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Northspring Roguefeather - Between 20-80% Health - Cast \'6595\' (No Repeat)'),
(5363, 0, 1, 0, 0, 0, 100, 0, 2200, 3300, 9700, 10500, 11, 8876, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Northspring Roguefeather - In Combat - Cast \'8876\''),
(5363, 0, 2, 0, 2, 0, 100, 1, 10, 50, 0, 0, 11, 11014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Northspring Roguefeather - Between 10-50% Health - Cast \'11014\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5366;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5366);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5366, 0, 0, 0, 0, 0, 100, 0, 1100, 2300, 8600, 9000, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Northspring Windcaller - In Combat - Cast \'9532\''),
(5366, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 6728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Northspring Windcaller - Between 30-60% Health - Cast \'6728\' (No Repeat)'),
(5366, 0, 2, 0, 2, 0, 100, 1, 10, 50, 0, 0, 11, 11014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Northspring Windcaller - Between 10-50% Health - Cast \'11014\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5364;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5364);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5364, 0, 0, 0, 2, 0, 100, 1, 10, 50, 0, 0, 11, 11014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Northspring Slayer - Between 10-50% Health - Cast \'11014\' (No Repeat)'),
(5364, 0, 1, 0, 12, 0, 100, 1, 1, 20, 0, 0, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Northspring Slayer - Target Between 1-20% Health - Cast \'7160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5362;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5362);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5362, 0, 0, 0, 2, 0, 100, 1, 10, 50, 0, 0, 11, 11014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Northspring Harpy - Between 10-50% Health - Cast \'11014\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5312;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5312);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5312, 0, 0, 0, 0, 0, 100, 0, 2100, 3000, 30000, 31000, 11, 20667, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lethlas - In Combat - Cast \'20667\''),
(5312, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 12882, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lethlas - Between 20-60% Health - Cast \'12882\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5296;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5296);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5296, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rage Scar Yeti - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5276;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5276);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5276, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 9000, 12000, 11, 11981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sprite Dragon - In Combat - Cast \'11981\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5288;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5288);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5288, 0, 0, 0, 0, 0, 100, 1, 4000, 6000, 0, 0, 11, 3150, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rabid Longtooth - In Combat - Cast \'3150\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8136;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8136, 0, 0, 0, 0, 0, 100, 0, 1300, 2000, 9600, 10000, 11, 8058, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Shalzaru - In Combat - Cast \'8058\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12802;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12802, 0, 0, 0, 0, 0, 100, 0, 4500, 5000, 10500, 12000, 11, 7938, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chimaerok Devourer - In Combat - Cast \'7938\''),
(12802, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chimaerok Devourer - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5462;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5462);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5462, 0, 0, 0, 0, 0, 100, 0, 1100, 1400, 8900, 9300, 11, 11538, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sea Spray - In Combat - Cast \'11538\''),
(5462, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 10987, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sea Spray - Between 20-40% Health - Cast \'10987\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5461;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5461);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5461, 0, 0, 0, 0, 0, 100, 0, 1100, 1300, 10000, 11000, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sea Elemental - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5308;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5308);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5308, 0, 0, 0, 0, 0, 100, 0, 2400, 3200, 12400, 14800, 11, 8281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rogue Vale Screecher - In Combat - Cast \'8281\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5293;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5293);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5293, 0, 0, 0, 0, 0, 100, 0, 1100, 1300, 10000, 11000, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hulking Feral Scar - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5292;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5292);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5292, 0, 0, 0, 0, 0, 100, 0, 1100, 1300, 10000, 11000, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Feral Scar Yeti - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5300;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5300, 0, 0, 0, 0, 0, 100, 0, 1100, 1300, 10000, 11000, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frayfeather Hippogryph - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5307;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5307);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5307, 0, 0, 0, 0, 0, 100, 0, 1200, 1600, 8900, 9300, 11, 59220, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vale Screecher - In Combat - Cast \'59220\''),
(5307, 0, 1, 0, 2, 0, 100, 1, 20, 50, 0, 0, 11, 8281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vale Screecher - Between 20-50% Health - Cast \'8281\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5247;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5247);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5247, 0, 0, 0, 0, 0, 100, 0, 1500, 2500, 45000, 46000, 11, 6016, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zukk\'ash Tunneler - In Combat - Cast \'6016\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5244;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5244);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5244, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 45000, 46000, 11, 5416, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zukk\'ash Stinger - In Combat - Cast \'5416\''),
(5244, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 17170, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zukk\'ash Stinger - Between 5-30% Health - Cast \'17170\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5245;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5245);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5245, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 30000, 31000, 11, 744, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zukk\'ash Wasp - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5246;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5246);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5246, 0, 0, 0, 0, 0, 100, 0, 1500, 2000, 12500, 13000, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zukk\'ash Worker - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5272;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5272);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5272, 0, 0, 0, 0, 0, 100, 0, 1300, 2000, 8700, 9000, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grizzled Ironfur Bear - In Combat - Cast \'31279\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5258;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5258);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5258, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Alpha - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5287;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5287);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5287, 0, 0, 0, 0, 0, 100, 0, 2000, 3500, 9500, 12000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Longtooth Howler - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5260;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5260);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5260, 0, 0, 0, 0, 0, 100, 0, 2000, 3500, 9500, 12000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Groddoc Ape - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5255;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5255);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5255, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7366, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Reaver - On Aggro - Cast \'7366\''),
(5255, 0, 1, 0, 0, 0, 100, 0, 2700, 3800, 9900, 11600, 11, 7369, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Reaver - In Combat - Cast \'7369\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5278;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5278);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5278, 0, 0, 0, 0, 0, 100, 0, 3400, 4100, 9600, 13800, 11, 11981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sprite Darter - In Combat - Cast \'11981\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7584;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7584);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7584, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 16561, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wandering Forest Walker - Between 30-60% Health - Cast \'16561\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5251;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5251);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5251, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Trapper - On Aggro - Cast \'6533\''),
(5251, 0, 1, 0, 0, 0, 100, 0, 1300, 1700, 7800, 8600, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Trapper - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5253;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5253);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5253, 0, 0, 0, 0, 0, 100, 0, 1700, 2300, 12400, 12900, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Brute - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5249;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5249);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5249, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 7102, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Mongrel - Between 20-80% Health - Cast \'7102\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5229;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5229);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5229, 0, 0, 0, 0, 0, 100, 0, 2300, 2900, 8600, 9500, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Ogre - In Combat - Cast \'11976\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5286;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5286);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5286, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Longtooth Runner - On Aggro - Cast \'3149\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5268;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5268);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5268, 0, 0, 0, 0, 0, 100, 0, 1300, 2000, 8700, 9000, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironfur Bear - In Combat - Cast \'31279\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
