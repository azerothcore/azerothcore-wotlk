-- DB update 2020_07_22_00 -> 2020_07_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_22_00 2020_07_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590936036679871300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590936036679871300');
/*
 * Zone: Dustwallow Marsh
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4388;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4388);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4388, 0, 0, 0, 0, 0, 100, 0, 2400, 3600, 9800, 12400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Murk Thresher - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16072;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 16072);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16072, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 18100, 18300, 11, 16509, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidelord Rrurgaz - In Combat - Cast \'16509\''),
(16072, 0, 1, 0, 0, 0, 100, 1, 5000, 7000, 0, 0, 11, 16244, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidelord Rrurgaz - In Combat - Cast \'16244\' (No Repeat)'),
(16072, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 15588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidelord Rrurgaz - Between 30-60% Health - Cast \'15588\' (No Repeat)'),
(16072, 0, 3, 0, 2, 0, 100, 1, 5, 25, 0, 0, 11, 17207, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidelord Rrurgaz - Between 5-25% Health - Cast \'17207\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15591;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15591);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15591, 0, 0, 0, 0, 0, 100, 0, 2400, 3200, 12900, 14600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Minion of Weavil - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4370;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4370);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4370, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15499, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Sorceress - On Aggro - Cast \'15499\''),
(4370, 0, 1, 0, 0, 0, 100, 0, 2700, 2900, 7700, 8900, 11, 12737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Sorceress - In Combat - Cast \'12737\''),
(4370, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 15532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Sorceress - Between 30-60% Health - Cast \'15532\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4364;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4364);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4364, 0, 0, 0, 0, 0, 100, 1, 2500, 3000, 0, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Warrior - In Combat - Cast \'9080\' (No Repeat)'),
(4364, 0, 1, 0, 0, 0, 100, 0, 6800, 9900, 17800, 20400, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Warrior - In Combat - Cast \'16856\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4366;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4366);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4366, 0, 0, 0, 0, 0, 100, 1, 2500, 3000, 0, 0, 11, 16509, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Serpent Guard - In Combat - Cast \'16509\' (No Repeat)'),
(4366, 0, 1, 0, 0, 0, 100, 0, 5400, 6200, 10500, 13600, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Serpent Guard - In Combat - Cast \'12057\''),
(4366, 0, 2, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Serpent Guard - Between 5-15% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4371;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4371);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4371, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15654, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Siren - On Aggro - Cast \'15654\''),
(4371, 0, 1, 0, 0, 0, 100, 0, 2300, 2600, 6700, 9700, 11, 15587, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Siren - In Combat - Cast \'15587\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4374;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4374);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4374, 0, 0, 0, 0, 0, 100, 1, 2500, 3000, 0, 0, 11, 16128, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Hydra - In Combat - Cast \'16128\' (No Repeat)'),
(4374, 0, 1, 0, 0, 0, 100, 0, 6200, 7400, 13400, 16800, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Hydra - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23679;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23679);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23679, 0, 0, 0, 0, 0, 100, 0, 2300, 2500, 7600, 7800, 11, 43125, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Garn Mathers - In Combat - Cast \'43125\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23590;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23590);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23590, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Conjuror - On Aggro - Cast \'12544\''),
(23590, 0, 1, 0, 0, 0, 100, 0, 2100, 2300, 7900, 8900, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Conjuror - In Combat - Cast \'9053\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23591;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23591);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23591, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 43107, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Diver - On Aggro - Cast \'43107\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23589;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23589);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23589, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 38557, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Rummager - On Aggro - Cast \'38557\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4397;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4397);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4397, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9464, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mudrock Spikeshell - On Aggro - Cast \'9464\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4361;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4361);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4361, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6278, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mirefin Muckdweller - On Aggro - Cast \'6278\''),
(4361, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 9462, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mirefin Muckdweller - Between 30-60% Health - Cast \'9462\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4362;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4362);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4362, 0, 0, 0, 0, 0, 100, 0, 2100, 3100, 8100, 9100, 11, 37988, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mirefin Coastrunner - In Combat - Cast \'37988\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23841;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23841);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23841, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 17100, 17400, 11, 12054, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorspine - In Combat - Cast \'12054\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4385;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4385);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4385, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withervine Rager - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4377;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4377);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4377, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkmist Hatchling - On Just Summoned - Despawn In 30000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4346;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4346);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4346, 0, 0, 0, 0, 0, 100, 0, 2100, 2600, 12100, 12600, 11, 43132, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Noxious Flayer - In Combat - Cast \'43132\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4414;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4414);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4414, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7951, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkfang Venomspitter - On Aggro - Cast \'7951\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4834;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4834);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4834, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Theramore Infiltrator - On Respawn - Cast \'22766\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4387;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4387);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4387, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5337, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Withervine Mire Beast - Between 30-60% Health - Cast \'5337\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5184;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5184);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5184, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Theramore Sentry - On Aggro - Cast \'7165\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4347;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4347);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4347, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 32100, 32300, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Noxious Reaver - In Combat - Cast \'744\''),
(4347, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Noxious Reaver - Between 30-60% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23881;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23881);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23881, 0, 0, 0, 0, 0, 100, 1, 5000, 6000, 0, 0, 11, 10022, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Cylla - In Combat - Cast \'10022\' (No Repeat)'),
(23881, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 35204, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Cylla - Between 30-60% Health - Cast \'35204\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23594;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23594);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23594, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11876, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Destroyer - Between 20-80% Health - Cast \'11876\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4389;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4389);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4389, 0, 0, 0, 0, 0, 100, 0, 2300, 2600, 12300, 12600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murk Thresher - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4390;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4390);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4390, 0, 0, 0, 0, 0, 100, 0, 2900, 3100, 15300, 15600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Murk Thresher - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4401;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4401, 0, 0, 0, 0, 0, 100, 0, 2100, 2500, 10100, 10500, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Muckshell Clacker - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4404;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4404);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4404, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 9600, 9900, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Muckshell Scrabbler - In Combat - Cast \'9532\''),
(4404, 0, 1, 0, 2, 0, 100, 1, 10, 40, 0, 0, 11, 8005, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muckshell Scrabbler - Between 10-40% Health - Cast \'8005\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23687;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23687);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23687, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 11500, 12000, 11, 8873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scorchscale Drake - In Combat - Cast \'8873\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4324;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4324);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4324, 0, 0, 0, 0, 0, 100, 0, 2400, 2600, 9400, 9600, 11, 11021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Searing Whelp - In Combat - Cast \'11021\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4323;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4323);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4323, 0, 0, 0, 0, 0, 100, 0, 2400, 2700, 9400, 9700, 11, 11985, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Searing Hatchling - In Combat - Cast \'11985\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5057;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5057);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5057, 0, 0, 0, 0, 0, 100, 0, 2100, 3200, 15100, 15900, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Theramore Deserter - In Combat - Cast \'14873\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4348;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4348);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4348, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 32100, 32300, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Noxious Shredder - In Combat - Cast \'744\''),
(4348, 0, 1, 0, 0, 0, 100, 0, 4500, 5000, 15000, 15500, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Noxious Shredder - In Combat - Cast \'3391\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
