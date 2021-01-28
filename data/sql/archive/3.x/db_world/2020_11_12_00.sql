-- DB update 2020_11_11_02 -> 2020_11_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_11_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_11_02 2020_11_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603643161575152300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603643161575152300');
/*
 * Zone: Stranglethorn Vale II
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2541;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2541);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2541, 0, 0, 0, 0, 0, 100, 0, 3700, 4200, 9700, 12200, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Sakrasis - In Combat - Cast \'15496\''),
(2541, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 3583, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Sakrasis - Between 30-60% Health - Cast \'3583\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2535;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2535);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2535, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maury "Club Foot" Wilkins - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2545;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2545);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2545, 0, 0, 0, 0, 0, 100, 0, 2700, 4600, 8700, 9600, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, '"Pretty Boy" Duncan - In Combat - Cast \'14873\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 687;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 687);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(687, 0, 0, 0, 0, 0, 100, 0, 2400, 3200, 17400, 18200, 11, 11977, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jungle Stalker - In Combat - Cast \'11977\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2551;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2551);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2551, 0, 0, 0, 0, 0, 100, 0, 3200, 4800, 9200, 11800, 11, 33661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brutus - In Combat - Cast \'33661\''),
(2551, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 38784, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brutus - Between 5-30% Health - Cast \'38784\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4506;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4506);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4506, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 7357, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodsail Swabby - Between 20-80% Health - Cast \'7357\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2544;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2544);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2544, 0, 0, 0, 0, 0, 100, 0, 2800, 3400, 8800, 9400, 11, 50245, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Southern Sand Crawler - In Combat - Cast \'50245\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2522;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2522);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2522, 0, 0, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jaguero Stalker - Out of Combat - Cast \'22766\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 685;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 685);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(685, 0, 0, 0, 0, 0, 100, 0, 2400, 3200, 17400, 18200, 11, 11977, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stranglethorn Raptor - In Combat - Cast \'11977\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14491;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14491);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14491, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kurmokk - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1557;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1557);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1557, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Mistvale Gorilla - Between 30-60% Health - Cast \'15615\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 976;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 976);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(976, 0, 0, 0, 0, 0, 100, 0, 2300, 2700, 9700, 12700, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kurzen War Tiger - In Combat - Cast \'51772\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1713;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1713);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1713, 0, 0, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Elder Shadowmaw Panther - Out of Combat - Cast \'22766\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2536;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2536);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2536, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jon-Jon the Crow - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 854;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 854);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(854, 0, 0, 0, 0, 0, 100, 0, 2400, 3200, 17400, 18200, 11, 11977, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Jungle Stalker - In Combat - Cast \'11977\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 676;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 676);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(676, 0, 0, 0, 0, 0, 100, 0, 2700, 4800, 9600, 12100, 11, 11969, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Surveyor - In Combat - Cast \'11969\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 781;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 781);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(781, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 6533, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Headhunter - On Aggro - Cast \'6533\' (No Repeat)'),
(781, 0, 1, 0, 0, 0, 100, 0, 1000, 1500, 6500, 7000, 11, 10277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Headhunter - In Combat - Cast \'10277\''),
(781, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3148, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Headhunter - Between 20-80% Health - Cast \'3148\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1060;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1060);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1060, 0, 0, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 11, 20798, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogh the Undying - Out of Combat - Cast \'20798\' (No Repeat)'),
(1060, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 8813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogh the Undying - On Respawn - Cast \'8813\''),
(1060, 0, 2, 0, 0, 0, 100, 0, 2700, 3100, 9800, 10200, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mogh the Undying - In Combat - Cast \'12471\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 682;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 682);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(682, 0, 0, 0, 0, 0, 100, 0, 2300, 2700, 9700, 12700, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stranglethorn Tiger - In Combat - Cast \'51772\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6366;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6366);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6366, 0, 0, 0, 2, 0, 100, 1, 5, 20, 0, 0, 11, 11642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Mindslave - Between 5-20% Health - Cast \'11642\' (No Repeat)'),
(6366, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 7964, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Mindslave - Between 30-60% Health - Cast \'7964\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 669;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 669);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(669, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 3621, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - On Aggro - Cast \'3621\' (No Repeat)'),
(669, 0, 1, 0, 0, 0, 100, 0, 2700, 4100, 9600, 12800, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - In Combat - Cast \'3391\''),
(669, 0, 2, 0, 2, 0, 100, 1, 5, 25, 0, 0, 11, 3148, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - Between 5-25% Health - Cast \'3148\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 756;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 756);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(756, 0, 0, 0, 1, 0, 100, 1, 2000, 3000, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Panther - Out of Combat - Despawn In 3000 ms (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1114;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1114);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1114, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jungle Thunderer - Between 30-60% Health - Cast \'15615\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1142;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1142);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1142, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mosh\'Ogg Brute - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 691;
UPDATE `creature_template` SET `unit_class`= 2 WHERE `entry`= 691;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 691);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(691, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 38033, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lesser Water Elemental - Between 20-80% Health - Cast \'38033\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 855;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 855);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(855, 0, 0, 0, 0, 0, 100, 0, 2400, 3200, 17400, 18200, 11, 11977, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Stranglethorn Raptor - In Combat - Cast \'11977\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1094;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1094);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1094, 0, 0, 0, 0, 0, 100, 0, 3400, 4800, 23400, 24800, 11, 6016, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Miner - In Combat - Cast \'6016\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 681;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 681);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(681, 0, 0, 0, 0, 0, 100, 0, 2300, 2700, 9700, 12700, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Stranglethorn Tiger - In Combat - Cast \'51772\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1108;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1108);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1108, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mistvale Gorilla - Between 30-60% Health - Cast \'15615\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 905;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 905);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(905, 0, 0, 0, 2, 0, 100, 1, 5, 10, 0, 0, 11, 3019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sharptooth Frenzy - Between 5-10% Health - Cast \'3019\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4723;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4723);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4723, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 184, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Foreman Cozzle - On Aggro - Cast \'184\' (No Repeat)'),
(4723, 0, 1, 0, 0, 0, 100, 0, 2100, 3400, 9700, 11800, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreman Cozzle - In Combat - Cast \'9532\''),
(4723, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 4979, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Foreman Cozzle - Between 5-30% Health - Cast \'4979\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4260;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4260);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4260, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 36203, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Shredder - Between 20-80% Health - Cast \'36203\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 772;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 772);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(772, 0, 0, 0, 0, 0, 100, 0, 2300, 2700, 9700, 12700, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stranglethorn Tigress - In Combat - Cast \'51772\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 684;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 684);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(684, 0, 0, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmaw Panther - Out of Combat - Cast \'22766\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
