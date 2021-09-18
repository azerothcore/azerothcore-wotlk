-- DB update 2021_09_18_01 -> 2021_09_18_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_18_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_18_01 2021_09_18_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1616252519696041200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616252519696041200');
/*
 * Zone: Nagrand
 * Update by Knindza | <www.azerothcore.org>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18352;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18352);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18352, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32248, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Hunter - On Aggro - Cast \'32248\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18298;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18298);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18298, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 9500, 12000, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - In Combat - Cast \'14873\''),
(18298, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 12540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - Between 20-80% Health - Cast \'12540\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18290;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18290);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18290, 0, 0, 0, 0, 0, 100, 0, 1500, 3000, 18000, 20000, 11, 32019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tusker - In Combat - Cast \'32019\''),
(18290, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 15550, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tusker - Between 30-60% Health - Cast \'15550\' (No Repeat)'),
(18290, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 12612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tusker - Between 20-80% Health - Cast \'12612\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18289;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18289);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18289, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 15550, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bull Elekk - Between 20-80% Health - Cast \'15550\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18660;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18660, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Vaz\'shir - In Combat - Cast \'3391\''),
(18660, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Vaz\'shir - Between 20-80% Health - Cast \'13736\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18661;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18661);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18661, 0, 0, 0, 0, 0, 100, 0, 1500, 3000, 18500, 20000, 11, 11443, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Terrorguard - In Combat - Cast \'11443\''),
(18661, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11876, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Terrorguard - Between 30-60% Health - Cast \'11876\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18043;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18043);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18043, 0, 0, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 1604, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Agitated Orc Spirit - Between 5-15% Health - Cast \'1604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19201;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19201, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 20000, 25000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mountain Gronn - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18145;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18145);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18145, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 32139, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Watoosun\'s Polluted Essence - In Combat - Cast \'32139\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17155;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17155);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17155, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32012, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lake Surger - On Aggro - Cast \'32012\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17136;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17136, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 30798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Warrior - On Respawn - Cast \'30798\' (No Repeat)'),
(17136, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 31994, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Warrior - On Aggro - Cast \'31994\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17154;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17154);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17154, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32013, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Muck Spawn - On Aggro - Cast \'32013\' (No Repeat)'),
(17154, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 21067, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Muck Spawn - In Combat - Cast \'21067\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18202;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18202, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32133, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Putrifier - On Aggro - Cast \'32133\' (No Repeat)'),
(18202, 0, 1, 0, 0, 0, 100, 0, 2500, 4000, 9500, 12000, 11, 32132, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Putrifier - In Combat - Cast \'32132\''),
(18202, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32134, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Putrifier - Between 20-80% Health - Cast \'32134\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18204;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18204);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18204, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 31981, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ortor of Murkblood - On Aggro - Cast \'31981\' (No Repeat)'),
(18204, 0, 1, 0, 0, 0, 100, 0, 2500, 4000, 9500, 12000, 11, 32132, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ortor of Murkblood - In Combat - Cast \'32132\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18207;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18207);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18207, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Scavenger - Between 20-80% Health - Cast \'3391\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18203;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18203);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18203, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Raider - In Combat - Cast \'11971\''),
(18203, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Raider - Between 20-80% Health - Cast \'15496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23026;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23026);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23026, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Serpent - Between 20-80% Health - Cast \'36612\' (No Repeat)');

UPDATE `creature_template` SET `speed_walk` = '0.6', `speed_run` = '0.6', `AIName` = 'SmartAI' WHERE `entry` = 18536;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18536);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18536, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 32008, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Xirkos, Overseer of Fear - In Combat - Cast \'32008\''),
(18536, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 4629, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Xirkos, Overseer of Fear - Between 20-80% Health - Cast \'4629\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21925;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21925);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21925, 0, 0, 0, 0, 0, 100, 0, 2300, 3000, 8700, 9000, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Sathal - In Combat - Cast \'12471\''),
(21925, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 34017, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Sathal - Between 20-80% Health - Cast \'34017\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18567;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18567);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18567, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 31705, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mo\'arg Master Planner - In Combat - Cast \'31705\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16945;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 16945);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16945, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 31705, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mo\'arg Engineer - On Aggro - Cast \'31705\' (No Repeat)'),
(16945, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 32005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mo\'arg Engineer - In Combat - Cast \'32005\''),
(16945, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 15976, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mo\'arg Engineer - Between 20-80% Health - Cast \'15976\' (No Repeat)');

UPDATE `creature_template` SET `speed_walk` = '0.6', `speed_run` = '0.6', `AIName` = 'SmartAI' WHERE `entry` = 18535;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18535);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18535, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 32008, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Demos, Overseer of Hate - In Combat - Cast \'32008\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17152;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17152);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17152, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 32008, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felguard Legionnaire - In Combat - Cast \'32008\''),
(17152, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felguard Legionnaire - Between 20-80% Health - Cast \'15496\' (No Repeat)'),
(17152, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 32009, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felguard Legionnaire - Between 30-60% Health - Cast \'32009\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17131;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17131);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17131, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32020, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Thorngrazer - On Aggro - Cast \'32020\' (No Repeat)'),
(17131, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 20000, 25000, 11, 32019, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Thorngrazer - In Combat - Cast \'32019\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17151;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17151);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17151, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32003, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gan\'arg Tinkerer - Between 20-80% Health - Cast \'32003\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17133;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17133);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17133, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32021, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aged Clefthoof - On Aggro - Cast \'32021\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18065;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18065);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18065, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 10966, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Brute - Between 20-80% Health - Cast \'10966\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18257;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18257);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18257, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32022, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gutripper - Between 20-80% Health - Cast \'32022\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18229;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18229);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18229, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 16044, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Saurfang the Younger - In Combat - Cast \'16044\''),
(18229, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 24573, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Saurfang the Younger - Between 20-80% Health - Cast \'24573\' (No Repeat)'),
(18229, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 67541, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Saurfang the Younger - Between 30-60% Health - Cast \'67541\' (No Repeat)'),
(18229, 0, 3, 0, 2, 0, 100, 1, 10, 20, 0, 0, 11, 26339, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Saurfang the Younger - Between 10-20% Health - Cast \'26339\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18414;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18414);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18414, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 20697, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Elder Yorley - On Aggro - Cast \'20697\' (No Repeat)'),
(18414, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 20695, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Yorley - In Combat - Cast \'20695\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18415;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18415);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18415, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 46151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Elder Ungriz - On Aggro - Cast \'46151\' (No Repeat)'),
(18415, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 59210, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Ungriz - In Combat - Cast \'59210\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17129;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17129);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17129, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 31273, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Windroc - Between 20-80% Health - Cast \'31273\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18413;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18413);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18413, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 12548, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zorbo the Advisor - In Combat - Cast \'12548\''),
(18413, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zorbo the Advisor - Between 30-60% Health - Cast \'11986\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17138;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17138);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17138, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Reaver - Between 20-80% Health - Cast \'15496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17159;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17159);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17159, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32018, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Storm Rager - Between 20-80% Health - Cast \'32018\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17132;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17132);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17132, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32023, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Clefthoof Bull - Between 20-80% Health - Cast \'32023\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17153;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17153);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17153, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 34425, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lake Spirit - In Combat - Cast \'34425\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17141;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17141);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17141, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 6278, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windyreed Wretch - On Aggro - Cast \'6278\' (No Repeat)'),
(17141, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windyreed Wretch - Between 20-80% Health - Cast \'3234\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17139;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17139);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17139, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12024, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windyreed Scavenger - On Aggro - Cast \'12024\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17128;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17128);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17128, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 20000, 25000, 11, 30285, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windroc - In Combat - Cast \'30285\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18334;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18334);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18334, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 20000, 25000, 11, 32019, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wild Elekk - In Combat - Cast \'32019\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18226;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18226);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18226, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32020, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Patriarch - On Aggro - Cast \'32020\' (No Repeat)'),
(18226, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 20000, 25000, 11, 32019, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Patriarch - In Combat - Cast \'32019\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17158;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17158);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17158, 0, 0, 0, 2, 0, 100, 0, 20, 80, 0, 0, 11, 32017, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dust Howler - Between 20-80% Health - Cast \'32017\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18205;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18205);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18205, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32023, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Clefthoof - Between 20-80% Health - Cast \'32023\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17130;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17130);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17130, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 20000, 25000, 11, 32019, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Stag - In Combat - Cast \'32019\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_18_02' WHERE sql_rev = '1616252519696041200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
