-- DB update 2021_05_14_06 -> 2021_05_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_14_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_14_06 2021_05_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1616252753401265600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616252753401265600');
/*
 * Zone: Netherstorm
 * Update by Knindza | <www.azerothcore.org>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20480;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20480);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20480, 0, 0, 0, 2, 0, 100, 1, 50, 90, 10, 40, 11, 36141, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kirin\'Var Ghost - Between 50-90% Health - Cast \'36141\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20512;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20512);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20512, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36153, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - Between 20-80% Health - Cast \'36153\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21065;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21065);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21065, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11980, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tormented Citizen - On Aggro - Cast \'11980\''),
(21065, 0, 1, 0, 0, 0, 100, 0, 1700, 2700, 6200, 8400, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tormented Citizen - In Combat - Cast \'9613\''),
(21065, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 36153, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tormented Citizen - Between 10-30% Health - Cast \'36153\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19686;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19686);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19686, 0, 0, 0, 2, 0, 100, 1, 2, 5, 0, 0, 11, 1604, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nether Anomaly - Between 2-5% Health - Cast \'1604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19653;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19653);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19653, 0, 0, 0, 2, 0, 100, 1, 2, 5, 0, 0, 11, 1604, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glacius - Between 2-5% Health - Cast \'1604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19731;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19731);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19731, 0, 0, 0, 0, 0, 100, 1, 1500, 2000, 0, 0, 75, 33731, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nether Beast - In Combat - Add Aura \'33731\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20404;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20404);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20404, 0, 0, 0, 0, 0, 100, 0, 2100, 3400, 6900, 9400, 11, 35147, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warp-Gate Engineer - In Combat - Cast \'35147\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20773;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20773);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20773, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 25640, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Barbscale Crocolisk - Between 20-80% Health - Cast \'25640\' (No Repeat)'),
(20773, 0, 1, 0, 2, 0, 100, 1, 2, 5, 0, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Barbscale Crocolisk - Between 2-5% Health - Cast \'3604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20611;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20611);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20611, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 8500, 9500, 11, 32914, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shimmerwing Moth - In Combat - Cast \'32914\''),
(20611, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 36592, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shimmerwing Moth - Between 10-30% Health - Cast \'36592\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20854;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20854);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20854, 0, 0, 0, 0, 0, 100, 0, 1700, 2500, 6700, 8500, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Gladiator - In Combat - Cast \'15284\''),
(20854, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Gladiator - Between 10-30% Health - Cast \'16856\' (No Repeat)'),
(20854, 0, 2, 0, 2, 0, 100, 1, 2, 5, 0, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Gladiator - Between 2-5% Health - Cast \'9080\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20453;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20453);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20453, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36500, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Shocktrooper - On Aggro - Cast \'36500\' (No Repeat)'),
(20453, 0, 1, 0, 0, 0, 100, 0, 2300, 3500, 12300, 14500, 11, 31553, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Shocktrooper - In Combat - Cast \'31553\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20452;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20452);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20452, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Assassin - On Aggro - Cast \'32920\' (No Repeat)'),
(20452, 0, 1, 0, 0, 0, 100, 0, 2700, 3400, 6800, 9200, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Assassin - In Combat - Cast \'7159\''),
(20452, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 34802, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Assassin - Between 20-80% Health - Cast \'34802\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20456;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20456);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20456, 0, 0, 0, 0, 0, 100, 0, 1700, 2400, 5200, 6800, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Researcher - In Combat - Cast \'9532\''),
(20456, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36508, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Researcher - Between 20-80% Health - Cast \'36508\' (No Repeat)'),
(20456, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 36506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Researcher - Between 10-30% Health - Cast \'36506\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20474;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20474);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20474, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Nexus-Stalker - On Just Summoned - Say Line 0'),
(20474, 0, 1, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 11, 36515, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Nexus-Stalker - Out of Combat - Cast \'36515\' (No Repeat)'),
(20474, 0, 2, 0, 0, 0, 100, 0, 2500, 5000, 10000, 12500, 11, 36517, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Nexus-Stalker - In Combat - Cast \'36517\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20779;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20779);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20779, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 25000, 11, 35556, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Congealed Void Horror - In Combat - Cast \'35556\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20458;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20458);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20458, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36513, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Archon - On Aggro - Cast \'36513\' (No Repeat)'),
(20458, 0, 1, 0, 0, 0, 100, 0, 1700, 2300, 9200, 12300, 11, 35924, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Archon - In Combat - Cast \'35924\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20459;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20459);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20459, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36509, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Overlord - On Aggro - Cast \'36509\' (No Repeat)'),
(20459, 0, 1, 0, 2, 0, 100, 1, 70, 95, 0, 0, 11, 32064, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Overlord - Between 70-95% Health - Cast \'32064\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20340;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20340);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20340, 0, 0, 0, 0, 0, 100, 0, 2700, 4400, 7200, 9800, 11, 36471, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fleshfiend - In Combat - Cast \'36471\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23008;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 23008);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23008, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36513, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Jailor - On Aggro - Cast \'36513\' (No Repeat)'),
(23008, 0, 1, 0, 0, 0, 100, 0, 1700, 2300, 9200, 12300, 11, 35924, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Jailor - In Combat - Cast \'35924\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22822;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22822);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22822, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36513, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Nullifier - On Aggro - Cast \'36513\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20931;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20931);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20931, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 17500, 20000, 11, 35321, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tyrantus - In Combat - Cast \'35321\''),
(20931, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 36629, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tyrantus - Between 10-30% Health - Cast \'36629\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20634;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20634);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20634, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 37359, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scythetooth Raptor - On Aggro - Cast \'37359\' (No Repeat)'),
(20634, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 8599, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scythetooth Raptor - Between 20-80% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21135;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21135);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21135, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 32008, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Imp - Between 20-80% Health - Cast \'32008\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20928;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20928);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20928, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 7000, 9000, 11, 37179, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Forgelord - In Combat - Cast \'37179\''),
(20928, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 5000, 5000, 11, 36251, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Forgelord - In Combat - Cast \'36251\''),
(20928, 0, 2, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 33962, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Forgelord - On Aggro - Cast \'33962\' (No Repeat)'),
(20928, 0, 3, 0, 38, 0, 100, 0, 0, 1, 0, 0, 86, 38982, 0, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Forgelord - On Data Set 0 1 - Cross Cast \'38982\''),
(20928, 0, 4, 0, 38, 0, 100, 0, 0, 2, 0, 0, 86, 38983, 0, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Forgelord - On Data Set 0 2 - Cross Cast \'38983\''),
(20928, 0, 5, 0, 38, 0, 100, 0, 0, 3, 0, 0, 86, 38984, 0, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Forgelord - On Data Set 0 3 - Cross Cast \'38984\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21923;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21923);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21923, 0, 0, 0, 0, 0, 100, 0, 2400, 3200, 8600, 9800, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Terrorguard Protector - In Combat - Cast \'15496\''),
(21923, 0, 1, 0, 2, 0, 100, 1, 10, 50, 0, 0, 11, 37488, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Terrorguard Protector - Between 10-50% Health - Cast \'37488\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18858;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18858);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18858, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathbringer - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20516;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20516);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20516, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36577, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warp Monstrosity - On Aggro - Cast \'36577\' (No Repeat)'),
(20516, 0, 1, 0, 0, 0, 100, 0, 1700, 2300, 6800, 8100, 11, 13901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warp Monstrosity - In Combat - Cast \'13901\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20929;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20929);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20929, 0, 0, 0, 0, 0, 100, 0, 2300, 4100, 7400, 9200, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrath Lord - In Combat - Cast \'15496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20930;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20930);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20930, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 36541, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hatecryer - On Aggro - Cast \'36541\' (No Repeat)'),
(20930, 0, 1, 0, 0, 0, 100, 0, 2100, 3500, 9100, 12500, 11, 34017, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hatecryer - In Combat - Cast \'34017\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20685;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20685);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20685, 0, 0, 0, 0, 0, 100, 0, 2000, 2500, 12500, 15000, 11, 35491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Azarad - In Combat - Cast \'35491\''),
(20685, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 35492, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Azarad - Between 10-30% Health - Cast \'35492\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21267;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21267);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21267, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36484, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mana Beast - Between 20-80% Health - Cast \'36484\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21089;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21089);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21089, 0, 0, 0, 0, 0, 100, 0, 3700, 5500, 9800, 13600, 11, 35871, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Blood Knight - In Combat - Cast \'35871\''),
(21089, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 36476, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Blood Knight - Between 40-80% Health - Cast \'36476\' (No Repeat)'),
(21089, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Blood Knight - Between 10-30% Health - Cast \'8599\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
