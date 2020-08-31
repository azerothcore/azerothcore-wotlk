-- DB update 2020_07_21_00 -> 2020_07_21_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_21_00 2020_07_21_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590935951123059600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590935951123059600');
/*
 * Zone: The Barrens
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23714;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23714);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23714, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 8400, 9200, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Elder - In Combat - Cast \'9532\''),
(23714, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Elder - Between 20-80% Health - Cast \'11986\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23592;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23592);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23592, 0, 0, 0, 0, 0, 100, 0, 3400, 4000, 10800, 12400, 11, 43108, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Breaker - In Combat - Cast \'43108\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4378;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4378);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4378, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 17200, 17400, 11, 43133, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkmist Recluse - In Combat - Cast \'43133\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4379;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4379);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4379, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkmist Silkspinner - On Aggro - Cast \'745\''),
(4379, 0, 1, 0, 0, 0, 100, 0, 2400, 2800, 32400, 32800, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkmist Silkspinner - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23873;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23873);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23873, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 53625, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goreclaw the Ravenous - On Aggro - Cast \'53625\''),
(23873, 0, 1, 0, 0, 0, 100, 0, 2600, 2900, 17600, 17900, 11, 32019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goreclaw the Ravenous - In Combat - Cast \'32019\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4356;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4356);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4356, 0, 0, 0, 0, 0, 100, 0, 2300, 2600, 32300, 32600, 11, 3427, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodfen Razormaw - In Combat - Cast \'3427\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4357;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4357);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4357, 0, 0, 0, 0, 0, 100, 0, 2200, 2800, 22200, 22800, 11, 6607, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodfen Lashtail - In Combat - Cast \'6607\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3414;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3414);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3414, 0, 0, 0, 0, 0, 100, 0, 2200, 2400, 9600, 9800, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'General Twinbraid - In Combat - Cast \'14873\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3376;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3376);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3376, 0, 0, 0, 0, 0, 100, 0, 2100, 3100, 9100, 10100, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Soldier - In Combat - Cast \'12057\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3459;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3459);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3459, 0, 0, 0, 0, 0, 100, 0, 2600, 3300, 9600, 11200, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razormane Warfrenzy - In Combat - Cast \'12057\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4128;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4128);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4128, 0, 0, 0, 0, 0, 100, 0, 2100, 2500, 12100, 12500, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hecklefang Stalker - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3466;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3466);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3466, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zhevra Courser - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3476;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3476);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3476, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 12400, 12900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Isha Awak - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3455;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3455);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3455, 0, 0, 0, 0, 0, 100, 0, 2300, 2800, 9400, 9900, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cannoneer Whessan - In Combat - Cast \'5679\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3454;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3454);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3454, 0, 0, 0, 0, 0, 100, 0, 2300, 2800, 9400, 9900, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cannoneer Smythe - In Combat - Cast \'5679\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3386;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3386);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3386, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8362, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Theramore Preserver - On Aggro - Cast \'8362\''),
(3386, 0, 1, 0, 0, 0, 100, 0, 2100, 2300, 8400, 8900, 11, 9734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Theramore Preserver - In Combat - Cast \'9734\''),
(3386, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Theramore Preserver - Between 30-60% Health - Cast \'11642\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3385;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3385);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3385, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Theramore Marine - On Aggro - Cast \'7164\''),
(3385, 0, 1, 0, 0, 0, 100, 0, 2100, 2400, 12800, 15200, 11, 72, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Theramore Marine - In Combat - Cast \'72\''),
(3385, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Theramore Marine - Between 20-40% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8236;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8236);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8236, 0, 0, 0, 2, 0, 100, 1, 5, 10, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muck Frenzy - Between 5-10% Health - Cast \'8269\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6020;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6020);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6020, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 12100, 13100, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slimeshell Makrura - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3382;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3382);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3382, 0, 0, 0, 0, 0, 100, 0, 1000, 1100, 7500, 8000, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Southsea Cannoneer - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6494;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6494);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6494, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tazan - Between 30-60% Health - Cast \'6253\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3384;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3384);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3384, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 3011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Southsea Privateer - On Aggro - Cast \'3011\''),
(3384, 0, 1, 0, 0, 0, 100, 0, 2000, 2100, 8500, 9000, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Southsea Privateer - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3383;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3383);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3383, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 32100, 32300, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Southsea Cutthroat - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4316;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4316);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4316, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 12100, 13100, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Packhound - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3286;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3286);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3286, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 32100, 32300, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Overseer - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3283;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3283);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3283, 0, 0, 0, 0, 0, 100, 1, 5000, 8000, 0, 0, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Enforcer - In Combat - Cast \'9128\' (No Repeat)'),
(3283, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Enforcer - Between 20-40% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7288;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7288);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7288, 0, 0, 0, 0, 0, 100, 0, 2400, 2800, 12400, 12800, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Foreman Puzik Gallywix - In Combat - Cast \'12057\''); 
 
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7307;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7307);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7307, 0, 0, 0, 0, 0, 100, 0, 2500, 3500, 12500, 14500, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Lookout - In Combat - Cast \'3391\'');
 
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7308;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7308);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7308, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Patroller - On Aggro - Cast \'745\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7310;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7310);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7310, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 13000, 14000, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mutated Venture Co. Drone - In Combat - Cast \'12057\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7287;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7287);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7287, 0, 0, 0, 0, 0, 100, 0, 2400, 3000, 12400, 13000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreman Silixiz - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7067;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7067);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7067, 0, 0, 0, 0, 0, 100, 0, 2700, 3200, 12700, 14700, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Drone - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3282;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3282);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3282, 0, 0, 0, 0, 0, 100, 0, 1000, 1100, 8500, 8900, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Mercenary - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3471;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3471);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3471, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tinkerer Sniggles - On Aggro - Cast \'745\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3284;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3284);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3284, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Drudger - Between 20-80% Health - Cast \'3391\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3285;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3285);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3285, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Peon - Between 20-80% Health - Cast \'3391\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3244;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3244);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3244, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 7272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Plainstrider - Between 30-60% Health - Cast \'7272\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3241;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3241);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3241, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Savannah Patriarch - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3245;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3245);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3245, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 3019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ornery Plainstrider - Between 5-30% Health - Cast \'3019\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3280;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3280);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3280, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 6728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Witchwing Windcaller - Between 20-80% Health - Cast \'6728\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3278;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3278);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3278, 0, 0, 0, 0, 0, 100, 1, 4000, 6500, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Witchwing Slayer - In Combat - Cast \'13730\' (No Repeat)'),
(3278, 0, 1, 0, 12, 0, 100, 1, 5, 30, 0, 0, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Witchwing Slayer - Target Between 5-30% Health - Cast \'7160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3276;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3276);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3276, 0, 0, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 7098, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Witchwing Harpy - Between 40-80% Health - Cast \'7098\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3242;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3242);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3242, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zhevra Runner - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3246;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3246);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3246, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fleeting Plainstrider - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3425;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3425);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3425, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Savannah Prowler - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3255;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3255);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3255, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunscale Screecher - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3248;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3248);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3248, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Barrens Giraffe - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3426;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3426);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3426, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zhevra Charger - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4127;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4127);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4127, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hecklefang Hyena - Between 20-80% Health - Cast \'3604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3463;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3463);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3463, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17498, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wandering Barrens Giraffe - On Aggro - Cast \'17498\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4129;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4129);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4129, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hecklefang Snarler - Between 20-80% Health - Cast \'3604\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
