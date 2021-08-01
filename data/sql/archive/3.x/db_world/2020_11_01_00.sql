-- DB update 2020_10_31_01 -> 2020_11_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_31_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_31_01 2020_11_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601826746153871500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601826746153871500');
/*
 * Zone: Tirisfal Glades
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1529;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1529);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1529, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 9400, 11600, 11, 3322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Horror - In Combat - Cast \'3322\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1532;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1532);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1532, 0, 0, 0, 0, 0, 100, 0, 2100, 3200, 9100, 10200, 11, 7713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wandering Spirit - In Combat - Cast \'7713\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1548;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1548);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1548, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cursed Darkhound - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1664;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1664);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1664, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7164, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Vachon - On Aggro - Cast \'7164\''),
(1664, 0, 1, 0, 0, 0, 100, 0, 2100, 3700, 9600, 10500, 11, 72, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Vachon - In Combat - Cast \'72\''),
(1664, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 3248, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Vachon - Between 10-30% Health - Cast \'3248\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1549;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1549);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1549, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Darkhound - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4284;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4284);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4284, 0, 0, 0, 0, 0, 100, 0, 2100, 3200, 8700, 9600, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Augur - In Combat - Cast \'9613\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4280;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4280);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4280, 0, 0, 0, 0, 0, 100, 0, 2100, 3300, 8200, 9300, 11, 13953, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Preserver - In Combat - Cast \'13953\''),
(4280, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 13952, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Preserver - Between 5-30% Health - Cast \'13952\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4282;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4282);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4282, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8457, 21, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Magician - On Aggro - Cast \'8457\''),
(4282, 0, 1, 0, 0, 0, 100, 0, 2100, 3300, 8600, 9200, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Magician - In Combat - Cast \'9053\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1527;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1527);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1527, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hungering Dead - Between 20-80% Health - Cast \'3234\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1656;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1656);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1656, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 7900, 9600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thurman Agamand - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4281;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4281);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4281, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6979, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Scout - On Aggro - Cast \'6979\''),
(4281, 0, 1, 0, 0, 0, 100, 0, 1700, 2300, 6800, 7900, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Scout - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1525;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1525);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1525, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rooting Dead - Between 20-80% Health - Cast \'3234\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1665;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1665);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1665, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8258, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Melrache - On Aggro - Cast \'8258\''),
(1665, 0, 1, 0, 0, 0, 100, 0, 2100, 2900, 8700, 9200, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Melrache - In Combat - Cast \'11976\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1660;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1660, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Bodyguard - Between 5-30% Health - Cast \'12169\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1547;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1547);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1547, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Decrepit Darkhound - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1655;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1655);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1655, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 7900, 9600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nissa Agamand - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1538;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1538);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1538, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 1243, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Friar - On Respawn - Cast \'1243\''),
(1538, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 2052, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Friar - Between 30-60% Health - Cast \'2052\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1540;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1540);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1540, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Vanguard - On Aggro - Cast \'7164\''),
(1540, 0, 1, 0, 0, 0, 100, 0, 2100, 2900, 9800, 9900, 11, 72, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Vanguard - In Combat - Cast \'72\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1526;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1526);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1526, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ravaged Corpse - Between 20-80% Health - Cast \'3234\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1941;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1941);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1941, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 3237, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rot Hide Graverobber - Between 30-60% Health - Cast \'3237\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1528;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1528);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1528, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shambling Horror - Between 20-80% Health - Cast \'3234\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1753;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1753);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1753, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 3237, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maggot Eye - Between 30-60% Health - Cast \'3237\' (No Repeat)'),
(1753, 0, 1, 0, 2, 0, 100, 1, 5, 20, 0, 0, 11, 3243, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maggot Eye - Between 5-20% Health - Cast \'3243\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1675;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1675);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1675, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 3237, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rot Hide Mongrel - Between 30-60% Health - Cast \'3237\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1658;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1658);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1658, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 7900, 9600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Dargol - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1530;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1530);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1530, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 9800, 12100, 11, 3322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rotting Ancestor - In Combat - Cast \'3322\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1934;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1934);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1934, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Farmer - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1654;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1654);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1654, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 7900, 9600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gregor Agamand - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1533;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1533);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1533, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 9200, 9600, 11, 7713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tormented Spirit - In Combat - Cast \'7713\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1523;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1523);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1523, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 589, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cracked Skull Soldier - On Aggro - Cast \'589\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1520;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1520);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1520, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rattlecage Soldier - Between 20-80% Health - Cast \'3391\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1545;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1545);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1545, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 8000, 10000, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vile Fin Muckdweller - In Combat - Cast \'7159\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1543;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1543);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1543, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vile Fin Puddlejumper - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1935;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1935);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1935, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Farmhand - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1662;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1662);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1662, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Perrine - Between 20-80% Health - Cast \'3391\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1536;
UPDATE `creature_template` SET `unit_class`= 2 WHERE `entry`= 1536;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1536);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1536, 0, 0, 0, 0, 0, 100, 0, 1700, 2100, 8400, 8800, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Missionary - In Combat - Cast \'9053\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1537;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1537);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1537, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Zealot - Between 20-80% Health - Cast \'13496\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
