-- DB update 2021_09_17_02 -> 2021_09_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_17_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_17_02 2021_09_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1616252675947625100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616252675947625100');
/*
 * Zone: Blade's Edge Mountain
 * Update by Knindza | <www.azerothcore.org>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22244;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22244);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22244, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unbound Ethereal - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22242;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22242);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22242, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 38860, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bash\'ir Spell-Thief - On Respawn - Cast \'38860\' (No Repeat)'),
(22242, 0, 1, 0, 0, 0, 100, 0, 2500, 4500, 12000, 15000, 11, 29881, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bash\'ir Spell-Thief - In Combat - Cast \'29881\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22182;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22182);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22182, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 35319, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lightning Wasp - On Aggro - Cast \'35319\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22287;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22287);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22287, 0, 0, 0, 0, 0, 100, 0, 2400, 3500, 9800, 11400, 11, 15588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amberpelt Clefthoof - In Combat - Cast \'15588\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22283;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22283);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22283, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 41281, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Eredar Stormbringer - On Aggro - Cast \'41281\' (No Repeat)'),
(22283, 0, 1, 0, 0, 0, 100, 0, 2700, 3000, 8700, 9000, 11, 39083, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Eredar Stormbringer - In Combat - Cast \'39083\''),
(22283, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 39082, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Eredar Stormbringer - Between 10-30% Health - Cast \'39082\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22221;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22221);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22221, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 37628, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felstorm Overseer - On Aggro - Cast \'37628\' (No Repeat)'),
(22221, 0, 1, 0, 0, 0, 100, 0, 2700, 3000, 6700, 7000, 11, 37945, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felstorm Overseer - In Combat - Cast \'37945\''),
(22221, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 37488, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felstorm Overseer - Between 10-30% Health - Cast \'37488\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22218;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22218);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22218, 0, 0, 0, 0, 0, 100, 0, 2700, 4000, 8700, 9000, 11, 1106, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Insidious Familiar - In Combat - Cast \'1106\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22217;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22217);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22217, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 18376, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felstorm Corruptor - On Aggro - Cast \'18376\' (No Repeat)'),
(22217, 0, 1, 0, 0, 0, 100, 0, 1700, 3100, 8900, 9600, 11, 15232, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felstorm Corruptor - In Combat - Cast \'15232\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22174;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22174);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22174, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Trigul - In Combat - Cast \'3391\''),
(22174, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 33628, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Trigul - Between 20-80% Health - Cast \'33628\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22289;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22289);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22289, 0, 0, 0, 2, 0, 100, 1, 5, 20, 0, 0, 11, 7139, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkflame Infernal - Between 5-20% Health - Cast \'7139\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21021;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21021);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21021, 0, 0, 0, 0, 0, 100, 0, 2100, 3400, 8700, 9600, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scorch Imp - In Combat - Cast \'9053\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19961;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19961);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19961, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36846, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomforge Attendant - Between 20-80% Health - Cast \'36846\' (No Repeat)'),
(19961, 0, 1, 0, 2, 0, 100, 1, 10, 20, 0, 0, 11, 36208, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomforge Attendant - Between 10-20% Health - Cast \'36208\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19960;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19960);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19960, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36253, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomforge Engineer - On Aggro - Cast \'36253\' (No Repeat)'),
(19960, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 36251, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomforge Engineer - Between 5-30% Health - Cast \'36251\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16952;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 16952);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16952, 0, 0, 0, 0, 0, 100, 0, 2700, 4200, 9600, 10400, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anger Guard - In Combat - Cast \'15496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21123;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21123);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21123, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 14000, 15000, 11, 32093, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felsworn Scalewing - In Combat - Cast \'32093\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21300;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21300, 0, 0, 0, 1, 0, 100, 0, 5000, 10000, 20000, 30000, 11, 36274, 0, 0, 0, 0, 0, 10, 0, 21124, 0, 0, 0, 0, 0, 'Fel Corrupter - Out of Combat - Cast \'36274\''),
(21300, 0, 1, 0, 0, 0, 100, 0, 2100, 3400, 5600, 6200, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fel Corrupter - In Combat - Cast \'9613\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21124;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21124);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21124, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 35570, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felsworn Daggermaw - On Aggro - Cast \'35570\' (No Repeat)'),
(21124, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 30000, 31000, 11, 7367, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felsworn Daggermaw - In Combat - Cast \'7367\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20668;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20668);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20668, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36471, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fiendling Flesh Beast - Between 20-80% Health - Cast \'36471\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21470;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21470);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21470, 0, 0, 0, 2, 0, 100, 1, 30, 90, 0, 0, 11, 10855, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Angered Arakkoa Protector - Between 30-90% Health - Cast \'10855\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20161;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20161);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20161, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 37579, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vekh\'nir Matriarch - On Aggro - Cast \'37579\' (No Repeat)'),
(20161, 0, 1, 0, 0, 0, 100, 0, 2700, 3000, 9500, 10000, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vekh\'nir Matriarch - In Combat - Cast \'9613\''),
(20161, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 34110, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vekh\'nir Matriarch - Between 5-30% Health - Cast \'34110\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19982;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19982);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19982, 0, 0, 0, 0, 0, 100, 0, 3500, 4000, 29500, 30000, 11, 35321, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vekh\'nir Keeneye - In Combat - Cast \'35321\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19983;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19983);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19983, 0, 0, 0, 0, 0, 100, 0, 4500, 5000, 17500, 20000, 11, 37654, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vekh\'nir Stormcaller - In Combat - Cast \'37654\''),
(19983, 0, 1, 0, 2, 0, 100, 1, 10, 50, 0, 0, 11, 32717, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vekh\'nir Stormcaller - Between 10-50% Health - Cast \'32717\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21254;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21254);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21254, 0, 0, 0, 0, 0, 100, 0, 3500, 4000, 16500, 18000, 11, 34802, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dullgrom Dredger - In Combat - Cast \'34802\''),
(21254, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dullgrom Dredger - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19984;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19984);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19984, 0, 0, 0, 0, 0, 100, 0, 3700, 4000, 12700, 14000, 11, 37583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vekh\'nir Dreadhawk - In Combat - Cast \'37583\''),
(19984, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 11642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vekh\'nir Dreadhawk - Between 10-30% Health - Cast \'11642\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21839;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21839);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21839, 0, 0, 0, 0, 0, 100, 0, 4800, 6400, 14600, 16200, 11, 32914, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mature Silkwing - In Combat - Cast \'32914\'');

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20747);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20747, 0, 0, 0, 2, 0, 100, 1, 5, 40, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silkwing Larva - Between 5-40% Health - Say Line 0 (No Repeat)'),
(20747, 0, 1, 2, 2, 0, 100, 1, 5, 40, 0, 0, 11, 36948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silkwing Larva - Between 5-40% Health - Cast \'36948\' (No Repeat)'),
(20747, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silkwing Larva - Between 5-40% Health - Kill Self (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21373;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21373);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21373, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 50318, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silkwing - Between 20-80% Health - Cast \'50318\' (No Repeat)'),
(21373, 0, 1, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silkwing - On Evade - Despawn In 5000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21516;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21516);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21516, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36399, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death\'s Watch - On Aggro - Cast \'36399\' (No Repeat)'),
(21516, 0, 1, 0, 0, 0, 100, 0, 3700, 5200, 13600, 15000, 11, 22919, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death\'s Watch - In Combat - Cast \'22919\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19980;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19980);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19980, 0, 0, 0, 0, 0, 100, 0, 3500, 5000, 13500, 15000, 11, 36406, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Void Terror - In Combat - Cast \'36406\''),
(19980, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 36405, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Void Terror - Between 10-30% Health - Cast \'36405\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21519;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21519);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21519, 0, 0, 0, 0, 0, 100, 0, 3400, 4000, 10400, 12000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death\'s Might - In Combat - Cast \'15496\''),
(21519, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32736, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death\'s Might - Between 20-80% Health - Cast \'32736\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22123;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22123);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22123, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 25640, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rip-Blade Ravager - On Aggro - Cast \'25640\' (No Repeat)'),
(22123, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3242, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rip-Blade Ravager - Between 20-80% Health - Cast \'3242\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20751;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20751);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20751, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 35570, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Daggermaw Lashtail - On Aggro - Cast \'35570\' (No Repeat)'),
(20751, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 30000, 31000, 11, 7367, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Daggermaw Lashtail - In Combat - Cast \'7367\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20714;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20714);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20714, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 744, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ridgespine Stalker - Between 20-80% Health - Cast \'744\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21189;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21189);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21189, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36471, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystal Flayer - Between 20-80% Health - Cast \'36471\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21004;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21004);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21004, 0, 0, 0, 2, 0, 100, 1, 10, 40, 0, 0, 11, 36513, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lesser Nether Drake - Between 10-40% Health - Cast \'36513\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21423;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21423);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21423, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 25640, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gore-Scythe Ravager - On Aggro - Cast \'25640\' (No Repeat)'),
(21423, 0, 1, 0, 0, 0, 100, 0, 4000, 5000, 19000, 20000, 11, 13443, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gore-Scythe Ravager - In Combat - Cast \'13443\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21956;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21956);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21956, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 19000, 20000, 11, 13443, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rema - In Combat - Cast \'13443\''),
(21956, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 5781, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rema - Between 20-80% Health - Cast \'5781\' (No Repeat)'),
(21956, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rema - Between 10-30% Health - Cast \'8599\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21033);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21033, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 37839, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bladewing Bloodletter - On Aggro - Cast \'37839\''),
(21033, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 37838, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bladewing Bloodletter - Between 20-40% Health - Cast \'37838\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22052;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22052);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22052, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 20500, 25000, 11, 35321, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Daggermaw Blackhide - In Combat - Cast \'35321\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21040;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21040);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21040, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Outraged Raven\'s Wood Sapling - Between 20-80% Health - Cast \'3391\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20211;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20211);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20211, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 37579, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruuan\'ok Matriarch - On Aggro - Cast \'37579\' (No Repeat)'),
(20211, 0, 1, 0, 0, 0, 100, 0, 2700, 3000, 9500, 10000, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruuan\'ok Matriarch - In Combat - Cast \'9613\''),
(20211, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 34110, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ruuan\'ok Matriarch - Between 5-30% Health - Cast \'34110\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19987;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19987);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19987, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 12000, 15000, 11, 37581, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruuan\'ok Ravenguard - In Combat - Cast \'37581\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19985;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19985);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19985, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12550, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ruuan\'ok Cloudgazer - On Aggro - Cast \'12550\' (No Repeat)'),
(19985, 0, 1, 0, 0, 0, 100, 0, 2500, 3500, 7500, 8000, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruuan\'ok Cloudgazer - In Combat - Cast \'9532\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19986;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19986);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19986, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 37681, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruuan\'ok Skyfury - Between 30-60% Health - Cast \'37681\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20757;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20757);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20757, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 33245, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - On Aggro - Cast \'33245\' (No Repeat)'),
(20757, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 33061, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - Between 20-80% Health - Cast \'33061\' (No Repeat)'),
(20757, 0, 2, 0, 0, 0, 100, 0, 2500, 3000, 7500, 8000, 11, 15242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - In Combat - Cast \'15242\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20729;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20729);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20729, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 22911, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bladespire Ravager - On Aggro - Cast \'22911\' (No Repeat)'),
(20729, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 16128, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bladespire Ravager - Between 20-80% Health - Cast \'16128\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20753;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20753);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20753, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12493, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dorgok - On Aggro - Cast \'12493\' (No Repeat)'),
(20753, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 39119, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dorgok - Between 10-30% Health - Cast \'39119\' (No Repeat)'),
(20753, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 18000, 19000, 11, 11962, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dorgok - In Combat - Cast \'11962\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19956;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19956);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19956, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 35777, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Lookout - On Respawn - Cast \'35777\' (No Repeat)'),
(19956, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 35240, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Lookout - Between 20-80% Health - Cast \'35240\' (No Repeat)'),
(19956, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 37786, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Lookout - Between 5-30% Health - Cast \'37786\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19948;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19948);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19948, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Skirmisher - On Just Died - Say Line 1'),
(19948, 0, 1, 2, 4, 0, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Skirmisher - On Aggro - Say Line 0'),
(19948, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 34932, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Skirmisher - On Aggro - Cast \'34932\''),
(19948, 0, 3, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 34802, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Skirmisher - Between 20-80% Health - Cast \'34802\' (No Repeat)'),
(19948, 0, 4, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 37786, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Skirmisher - Between 5-30% Health - Cast \'37786\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20726;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20726);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20726, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12550, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mugdorg - On Aggro - Cast \'12550\' (No Repeat)'),
(20726, 0, 1, 0, 0, 0, 100, 0, 2500, 3000, 8500, 9000, 11, 12058, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mugdorg - In Combat - Cast \'12058\''),
(20726, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 35240, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mugdorg - Between 20-80% Health - Cast \'35240\' (No Repeat)'),
(20726, 0, 3, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 11986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mugdorg - Between 10-30% Health - Cast \'11986\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20731;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20731);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20731, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12544, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Droggam - On Aggro - Cast \'12544\' (No Repeat)'),
(20731, 0, 1, 0, 0, 0, 100, 0, 2500, 3000, 8500, 9000, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Droggam - In Combat - Cast \'9053\''),
(20731, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 35240, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Droggam - Between 20-80% Health - Cast \'35240\' (No Repeat)'),
(20731, 0, 3, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 11831, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Droggam - Between 10-30% Health - Cast \'11831\' (No Repeat)');

DELETE FROM `creature_text` WHERE `CreatureID` = 20730 AND `GroupID` = 0 AND `ID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (20730, 0, 0, 'That weapon mine now!', 12, 0, 100, 0, 0, 0, 0, 0, 'Glumdor on Weapon steal.');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20730;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20730);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20730, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 11500, 14000, 11, 32009, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - In Combat - Cast \'32009\''),
(20730, 0, 1, 2, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36208, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - Between 20-80% Health - Cast \'36208\' (No Repeat)'),
(20730, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - Between 20-80% Health - Say Line 0 (No Repeat)'),
(20730, 0, 3, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 8599, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - Between 10-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20732;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20732);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20732, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 8500, 9000, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gorr\'Dim - In Combat - Cast \'9672\''),
(20732, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 35240, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gorr\'Dim - Between 20-80% Health - Cast \'35240\' (No Repeat)'),
(20732, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 15091, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gorr\'Dim - Between 10-30% Health - Cast \'15091\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20723;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20723);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20723, 0, 0, 0, 0, 0, 100, 0, 3500, 4000, 10500, 12000, 11, 11978, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - In Combat - Cast \'11978\''),
(20723, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 23600, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Between 20-80% Health - Cast \'23600\' (No Repeat)'),
(20723, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 8599, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Between 10-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21975;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21975);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21975, 0, 0, 0, 0, 0, 100, 0, 2100, 3600, 9400, 11200, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bladespire Sober Defender - In Combat - Cast \'15496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20728;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20728);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20728, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 20500, 25000, 11, 35321, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bladespire Raptor - In Combat - Cast \'35321\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21381;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21381);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21381, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 37359, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Crust Burster - On Aggro - Cast \'37359\' (No Repeat)'),
(21381, 0, 1, 0, 0, 0, 100, 0, 2400, 3000, 10600, 12400, 11, 21067, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Crust Burster - In Combat - Cast \'21067\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22308;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22308);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22308, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 39182, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Hunter - On Aggro - Cast \'39182\' (No Repeat)'),
(22308, 0, 1, 0, 0, 0, 100, 0, 1400, 2000, 6800, 7500, 11, 15547, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Hunter - In Combat - Cast \'15547\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21810;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21810);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21810, 0, 0, 0, 0, 0, 100, 0, 2400, 4700, 9800, 13600, 11, 15576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Hewer - In Combat - Cast \'15576\''),
(21810, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 8599, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Hewer - Between 10-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20329;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20329);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20329, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 37475, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grishna Matriarch - On Respawn - Cast \'37475\' (No Repeat)'),
(20329, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 37579, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grishna Matriarch - On Aggro - Cast \'37579\' (No Repeat)'),
(20329, 0, 2, 0, 0, 0, 100, 0, 2700, 3000, 8700, 9000, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grishna Matriarch - In Combat - Cast \'9613\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21325;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21325);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21325, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 37823, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raven\'s Wood Stonebark - On Aggro - Cast \'37823\' (No Repeat)'),
(21325, 0, 1, 0, 0, 0, 100, 0, 2400, 4000, 10600, 13800, 11, 12612, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raven\'s Wood Stonebark - In Combat - Cast \'12612\''),
(21325, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 37709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Raven\'s Wood Stonebark - Between 20-80% Health - Cast \'37709\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21048;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21048);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21048, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 30798, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boulder\'mok Chieftain - On Aggro - Cast \'30798\' (No Repeat)'),
(21048, 0, 1, 0, 0, 0, 100, 0, 2800, 3400, 12800, 13400, 11, 8078, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Boulder\'mok Chieftain - In Combat - Cast \'8078\''),
(21048, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 35491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boulder\'mok Chieftain - Between 10-30% Health - Cast \'35491\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21047;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21047);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21047, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12550, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boulder\'mok Shaman - On Aggro - Cast \'12550\' (No Repeat)'),
(21047, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boulder\'mok Shaman - Between 20-80% Health - Cast \'11986\' (No Repeat)'),
(21047, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 28902, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boulder\'mok Shaman - Between 10-30% Health - Cast \'28902\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21046;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21046);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21046, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 9500, 13000, 11, 37577, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Boulder\'mok Brute - In Combat - Cast \'37577\''),
(21046, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 8599, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boulder\'mok Brute - Between 10-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21042;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21042);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21042, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 31273, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dire Raven - Between 20-80% Health - Cast \'31273\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21492;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21492);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21492, 0, 0, 0, 0, 0, 100, 0, 2700, 3200, 8400, 9000, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Blessed - In Combat - Cast \'9053\''),
(21492, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11969, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Blessed - Between 20-80% Health - Cast \'11969\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22099;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22099);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22099, 0, 0, 0, 0, 0, 100, 0, 2500, 4500, 9500, 12500, 11, 35857, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Provisioner - In Combat - Cast \'35857\''),
(22099, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 34802, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Provisioner - Between 20-80% Health - Cast \'34802\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21383;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21383);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21383, 0, 0, 0, 1, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 37653, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Acolyte - Out of Combat - Cast \'0\''),
(21383, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 17139, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Acolyte - On Aggro - Cast \'17139\' (No Repeat)'),
(21383, 0, 2, 0, 0, 0, 100, 0, 2400, 3000, 8600, 9200, 11, 32707, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Acolyte - In Combat - Cast \'32707\''),
(21383, 0, 3, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11969, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Acolyte - Between 20-80% Health - Cast \'11969\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21382;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21382);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21382, 0, 0, 0, 1, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 37635, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Zealot - Out of Combat - Cast \'37635\''),
(21382, 0, 1, 0, 0, 0, 100, 0, 2700, 3200, 8900, 9600, 11, 20714, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Zealot - In Combat - Cast \'20714\''),
(21382, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32009, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Zealot - Between 20-80% Health - Cast \'32009\' (No Repeat)'),
(21382, 0, 3, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 8599, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Zealot - Between 10-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21637;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21637);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21637, 0, 0, 0, 1, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 37635, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Scout - Out of Combat - Cast \'37635\''),
(21637, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 15547, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Scout - On Aggro - Cast \'15547\' (No Repeat)'),
(21637, 0, 2, 0, 0, 0, 100, 0, 2400, 3000, 8400, 9000, 11, 20714, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Scout - In Combat - Cast \'20714\''),
(21637, 0, 3, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11970, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcult Scout - Between 20-80% Health - Cast \'11970\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22286;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22286);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22286, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fel Rager - Between 20-80% Health - Cast \'3391\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22451;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22451);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22451, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Legion Fel Cannon MKII - On Respawn - Disable Combat Movement'),
(22451, 0, 1, 0, 0, 0, 100, 0, 1500, 3000, 7500, 9000, 11, 36238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Legion Fel Cannon MKII - In Combat - Cast \'36238\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22196;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22196);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22196, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 31755, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrath Reaver - Between 20-80% Health - Cast \'31755\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22187;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22187);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22187, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 35385, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bladespine Basilisk - On Aggro - Cast \'35385\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23386;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23386);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23386, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 42415, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gan\'arg Analyzer - On Aggro - Cast \'42415\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22298;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22298);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22298, 0, 0, 0, 0, 0, 100, 0, 2700, 3500, 9600, 12400, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vile Fire-Soul - In Combat - Cast \'9053\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22385;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22385);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22385, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 17500, 18000, 11, 11443, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Terrordar the Tormentor - In Combat - Cast \'11443\''),
(22385, 0, 1, 0, 0, 0, 100, 0, 1500, 2000, 7500, 9000, 11, 39083, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Terrordar the Tormentor - In Combat - Cast \'39083\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20109;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20109);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20109, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 31273, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Kaliri - Between 20-80% Health - Cast \'31273\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19943;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19943);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19943, 0, 0, 0, 0, 0, 100, 0, 2600, 4000, 8600, 10000, 11, 37685, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Talonite - In Combat - Cast \'37685\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19945;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19945);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19945, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12550, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Windwalker - On Aggro - Cast \'12550\' (No Repeat)'),
(19945, 0, 1, 0, 0, 0, 100, 0, 1500, 3000, 6500, 9000, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Windwalker - In Combat - Cast \'9532\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19944;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19944);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19944, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 12, 21470, 4, 5000, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - On Aggro - Summon Creature \'Angered Arakkoa Protector\' (No Repeat)'),
(19944, 0, 1, 0, 0, 0, 100, 0, 3500, 4000, 10500, 14500, 11, 37577, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - In Combat - Cast \'37577\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21023;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21023);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21023, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 11922, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stronglimb Deeproot - On Aggro - Cast \'11922\' (No Repeat)'),
(21023, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 12612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stronglimb Deeproot - Between 30-60% Health - Cast \'12612\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22132;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22132);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22132, 0, 0, 0, 0, 0, 100, 0, 2800, 4600, 9800, 12600, 11, 7951, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mature Cavern Crawler - In Combat - Cast \'7951\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22044;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22044);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22044, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 744, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cavern Crawler - Between 20-80% Health - Cast \'744\' (No Repeat)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_18_00' WHERE sql_rev = '1616252675947625100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
