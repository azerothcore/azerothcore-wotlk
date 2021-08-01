-- DB update 2020_11_12_00 -> 2020_11_12_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_12_00 2020_11_12_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603643637764114800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603643637764114800');
/*
 * Zone: Searing Gorge
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2736;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2736);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2736, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Rock Elemental - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9318;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9318);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9318, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 9275, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Incendosaur - On Aggro - Cast \'9275\' (No Repeat)'),
(9318, 0, 1, 0, 0, 0, 100, 0, 2700, 4300, 9700, 12300, 11, 11985, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Incendosaur - In Combat - Cast \'11985\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5850;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5850);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5850, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blazing Elemental - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14621;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14621);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14621, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 11639, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Maltorius - On Aggro - Cast \'11639\' (No Repeat)'),
(14621, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11974, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Maltorius - Between 30-60% Health - Cast \'11974\' (No Repeat)'),
(14621, 0, 2, 0, 0, 0, 100, 0, 2700, 4100, 9700, 13100, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Maltorius - In Combat - Cast \'9613\''),
(14621, 0, 3, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 13323, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Maltorius - Between 5-30% Health - Cast \'13323\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8447;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8447);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8447, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Clunk - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8444;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8444);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8444, 0, 0, 0, 0, 0, 100, 0, 3200, 4100, 9600, 10400, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Trade Master Kovic - In Combat - Cast \'9053\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5843;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5843);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5843, 0, 0, 0, 0, 0, 100, 0, 2900, 4700, 9900, 13700, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slave Worker - In Combat - Cast \'11971\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8283;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8283);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8283, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 6533, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slave Master Blackheart - On Aggro - Cast \'6533\' (No Repeat)'),
(8283, 0, 1, 0, 0, 0, 100, 0, 1000, 1500, 7600, 8200, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slave Master Blackheart - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5833;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5833);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5833, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 15595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Margol the Rager - On Aggro - Cast \'15595\' (No Repeat)'),
(5833, 0, 1, 0, 0, 0, 100, 0, 2700, 3100, 8700, 10100, 11, 15549, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Margol the Rager - In Combat - Cast \'15549\''),
(5833, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 8147, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Margol the Rager - Between 20-40% Health - Cast \'8147\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5856;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5856);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5856, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 745, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glassweb Spider - On Aggro - Cast \'745\' (No Repeat)'),
(5856, 0, 1, 0, 0, 0, 100, 0, 3100, 3700, 15100, 15700, 11, 6751, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glassweb Spider - In Combat - Cast \'6751\''),
(5856, 0, 2, 0, 2, 0, 100, 1, 10, 20, 0, 0, 11, 744, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glassweb Spider - Between 10-20% Health - Cast \'744\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5853;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5853);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5853, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tempered War Golem - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8280;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8280);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8280, 0, 0, 0, 0, 0, 100, 0, 2700, 4200, 9700, 11200, 11, 13321, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shleipnarr - In Combat - Cast \'13321\''),
(8280, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 7399, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shleipnarr - Between 5-30% Health - Cast \'7399\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5857;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5857);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5857, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 4167, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Searing Lava Spider - On Aggro - Cast \'4167\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5854;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5854);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5854, 0, 0, 0, 0, 0, 100, 0, 2900, 3700, 9700, 11900, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Heavy War Golem - In Combat - Cast \'5568\''),
(5854, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 12612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Heavy War Golem - Between 5-30% Health - Cast \'12612\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5852;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5852);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5852, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 10733, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Inferno Elemental - Between 20-80% Health - Cast \'10733\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5855;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5855);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5855, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11970, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magma Elemental - Between 20-80% Health - Cast \'11970\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5858;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5858);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5858, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 9700, 11400, 11, 11985, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Lava Spider - In Combat - Cast \'11985\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8278;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8278);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8278, 0, 0, 0, 0, 0, 100, 0, 2600, 3100, 17600, 18100, 11, 5213, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Smoldar - In Combat - Cast \'5213\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8279;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8279);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8279, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 9576, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Faulty War Golem - Between 30-60% Health - Cast \'9576\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
