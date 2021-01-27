-- DB update 2020_07_13_00 -> 2020_07_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_13_00 2020_07_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589718658086922600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589718658086922600');
/*
 * Zone: Stonetalon Mountains
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4202;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4202, 0, 0, 0, 0, 0, 100, 0, 2800, 3400, 9900, 12600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gerenzo Wrenchwhistle - In Combat - Cast \'3391\''),
(4202, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gerenzo Wrenchwhistle - Between 5-30% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `minlevel` = '21', `maxlevel` = '22' WHERE `entry` = 2676;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2676;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2676);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2676, 0, 0, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Compact Harvest Reaper - On Evade - Despawn In 5000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3993;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3993);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3993, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7979, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Machine Smith - On Aggro - Cast \'7979\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4070;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4070);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4070, 0, 0, 0, 0, 0, 100, 0, 1000, 1100, 6700, 9800, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Builder - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3992;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3992);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3992, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Engineer - On Aggro - Cast \'7978\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4004;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4004);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4004, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 3631, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Windshear Overlord - On Aggro - Cast \'3631\''),
(4004, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 8139, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windshear Overlord - Between 20-80% Health - Cast \'8139\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4003;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4003);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4003, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 7800, 9600, 11, 20792, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windshear Geomancer - In Combat - Cast \'20792\''),
(4003, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 8139, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windshear Geomancer - Between 20-40% Health - Cast \'8139\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3999;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3999);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3999, 0, 0, 0, 0, 0, 100, 0, 2400, 3600, 9800, 12400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windshear Digger - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3988;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3988);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3988, 0, 0, 0, 0, 0, 100, 0, 2400, 3600, 11800, 13400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Operator - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3989;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3989);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3989, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 10277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Logger - In Combat - Cast \'10277\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3991;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3991);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3991, 0, 0, 0, 0, 0, 100, 0, 1700, 2100, 6900, 8600, 11, 20793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Deforester - In Combat - Cast \'20793\''),
(3991, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 39273, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Deforester - Between 20-40% Health - Cast \'39273\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4056;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4056);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4056, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8138, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mirkfallon Keeper - On Aggro - Cast \'8138\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4061;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4061);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4061, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 10277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mirkfallon Dryad - On Aggro - Cast \'10277\''),
(4061, 0, 1, 0, 0, 0, 100, 0, 2400, 2700, 22400, 22700, 11, 7992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mirkfallon Dryad - In Combat - Cast \'7992\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4052;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4052);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4052, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Druid - On Aggro - Cast \'9739\''),
(4052, 0, 1, 0, 2, 0, 100, 1, 90, 99, 0, 0, 11, 5759, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Druid - Between 90-99% Health - Cast \'5759\' (No Repeat)'),
(4052, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5217, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Druid - Between 30-60% Health - Cast \'5217\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8518;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8518);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8518, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 10277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rynthariel the Keymaster - On Aggro - Cast \'10277\''),
(8518, 0, 1, 0, 0, 0, 100, 0, 2700, 2900, 22700, 22900, 11, 7992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rynthariel the Keymaster - In Combat - Cast \'7992\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4409;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4409);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4409, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11922, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gatekeeper Kordurus - On Aggro - Cast \'11922\''),
(4409, 0, 1, 0, 0, 0, 100, 0, 2700, 2900, 15700, 15900, 11, 8925, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gatekeeper Kordurus - In Combat - Cast \'8925\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4050;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4050);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4050, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7090, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Caretaker - On Aggro - Cast \'7090\''),
(4050, 0, 1, 0, 0, 0, 100, 0, 2100, 2800, 7900, 9200, 11, 12161, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Caretaker - In Combat - Cast \'12161\''),
(4050, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 782, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Caretaker - Between 20-80% Health - Cast \'782\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4017;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4017);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4017, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wily Fey Dragon - Between 20-80% Health - Cast \'11981\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4067;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4067);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4067, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 24331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Runner - Between 20-80% Health - Cast \'24331\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4020;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4020);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4020, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7997, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sap Beast - On Aggro - Cast \'7997\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4051;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4051);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4051, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 1430, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Botanist - On Aggro - Cast \'1430\''),
(4051, 0, 1, 0, 0, 0, 100, 0, 2100, 2400, 7100, 8400, 11, 9739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Botanist - In Combat - Cast \'9739\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4009;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4009);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4009, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6268, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raging Cliff Stormer - On Aggro - Cast \'6268\''),
(4009, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 8078, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raging Cliff Stormer - Between 30-60% Health - Cast \'8078\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4013;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4013);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4013, 0, 0, 0, 0, 0, 100, 0, 2400, 3100, 32400, 33100, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pridewing Skyhunter - In Combat - Cast \'744\''),
(4013, 0, 1, 0, 2, 0, 100, 1, 30, 50, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pridewing Skyhunter - Between 30-50% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4014;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4014);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4014, 0, 0, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 6605, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pridewing Consort - Between 20-40% Health - Cast \'6605\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4012;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4012);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4012, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 32100, 32300, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pridewing Wyvern - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4036;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4036);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4036, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6205, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rogue Flame Spirit - On Aggro - Cast \'6205\''),
(4036, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 1094, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rogue Flame Spirit - Between 30-60% Health - Cast \'1094\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4028;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4028);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4028, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charred Ancient - On Aggro - Cast \'12747\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4031;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4031);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4031, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 32100, 32300, 11, 3396, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fledgling Chimaera - In Combat - Cast \'3396\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4038;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4038);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4038, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 8700, 9600, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Burning Destroyer - In Combat - Cast \'9053\''),
(4038, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 8000, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Burning Destroyer - Between 20-80% Health - Cast \'8000\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4037;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4037);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4037, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 184, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Burning Ravager - On Aggro - Cast \'184\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4032;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4032);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4032, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 8700, 9600, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Chimaera - In Combat - Cast \'9532\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11921;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11921);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11921, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Besseleth - On Aggro - Cast \'745\''),
(11921, 0, 1, 0, 0, 0, 100, 0, 2400, 3200, 9600, 11200, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Besseleth - In Combat - Cast \'3391\''),
(11921, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 5416, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Besseleth - Between 20-80% Health - Cast \'5416\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4006;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4006);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4006, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deepmoss Webspinner - On Aggro - Cast \'745\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4007;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4007);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4007, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7951, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deepmoss Venomspitter - On Aggro - Cast \'7951\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11918;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11918);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11918, 0, 0, 0, 0, 0, 100, 0, 3200, 4800, 9900, 12300, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gogger Stonepounder - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11917;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11917);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11917, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 8600, 9400, 11, 20793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gogger Geomancer - In Combat - Cast \'20793\''),
(11917, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11990, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gogger Geomancer - Between 30-60% Health - Cast \'11990\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11915;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11915);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11915, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gogger Rock Keeper - Between 20-80% Health - Cast \'13281\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4008;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4008);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4008, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 8400, 9600, 11, 5401, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cliff Stormer - In Combat - Cast \'5401\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11858;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11858);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11858, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 8900, 9600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grundig Darkcloud - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11914;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11914);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11914, 0, 0, 0, 0, 0, 100, 0, 2400, 4800, 12900, 14700, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gorehoof the Black - In Combat - Cast \'10101\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11913;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11913);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11913, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Sorcerer - On Aggro - Cast \'12160\''),
(11913, 0, 1, 0, 0, 0, 100, 0, 2100, 2300, 7900, 9600, 11, 20802, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Sorcerer - In Combat - Cast \'20802\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11910;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11910);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11910, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 14102, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Ruffian - Between 30-60% Health - Cast \'14102\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11911;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11911);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11911, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 10277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Mercenary - On Aggro - Cast \'10277\''),
(11911, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 12555, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Mercenary - Between 30-60% Health - Cast \'12555\' (No Repeat)');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
