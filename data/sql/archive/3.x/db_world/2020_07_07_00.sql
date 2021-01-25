-- DB update 2020_07_03_00 -> 2020_07_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_03_00 2020_07_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589561650114670700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589561650114670700');
/*
 * Zone: Darkshore
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2187;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2187);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2187, 0, 0, 0, 0, 0, 100, 0, 2500, 3200, 45500, 50000, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Darkshore Thresher - In Combat - Cast \'6016\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2208;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2208);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2208, 0, 0, 0, 0, 0, 100, 0, 2700, 2900, 7900, 8100, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greymist Tidehunter - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2338;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2338);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2338, 0, 0, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 2054, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Disciple - Between 40-80% Health - Cast \'2054\' (No Repeat)'),
(2338, 0, 1, 0, 2, 0, 100, 1, 5, 20, 0, 0, 11, 6074, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Disciple - Between 5-20% Health - Cast \'6074\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2339;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2339);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2339, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Thug - On Aggro - Cast \'7165\''),
(2339, 0, 1, 0, 0, 0, 100, 1, 6500, 10000, 0, 0, 11, 5242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Thug - In Combat - Cast \'5242\' (No Repeat)'),
(2339, 0, 2, 0, 2, 0, 100, 0, 5, 30, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Thug - Between 5-30% Health - Cast \'6713\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2157;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2157);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2157, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5810, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Behemoth - On Aggro - Cast \'5810\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2156;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2156);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2156, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5810, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cracked Golem - On Aggro - Cast \'5810\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2206;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2206);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2206, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 10277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greymist Hunter - On Aggro - Cast \'10277\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2324;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2324);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2324, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 6982, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blackwood Windtalker - Between 30-60% Health - Cast \'6982\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2167;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2167);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2167, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6950, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blackwood Pathfinder - On Aggro - Cast \'6950\''),
(2167, 0, 1, 0, 0, 0, 100, 0, 2700, 3300, 7900, 8600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blackwood Pathfinder - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2201;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2201, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greymist Raider - On Aggro - Cast \'7165\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2231;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2231);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2231, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5424, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Pygmy Tide Crawler - Between 30-60% Health - Cast \'5424\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2185;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2185);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2185, 0, 0, 0, 0, 0, 100, 0, 2300, 3200, 45000, 50000, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkshore Thresher - In Combat - Cast \'6016\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2234;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2234);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2234, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5424, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Reef Crawler - Between 30-60% Health - Cast \'5424\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2203;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2203);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2203, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 324, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greymist Seer - On Aggro - Cast \'324\''),
(2203, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greymist Seer - Between 20-40% Health - Cast \'547\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2202;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2202, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greymist Coastrunner - On Aggro - Cast \'7165\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2204;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2204);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2204, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 12024, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greymist Netter - Between 20-80% Health - Cast \'12024\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2205;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2205);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2205, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greymist Warrior - On Aggro - Cast \'7165\''),
(2205, 0, 1, 0, 0, 0, 100, 1, 6500, 10000, 0, 0, 11, 5242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greymist Warrior - In Combat - Cast \'5242\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2174;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2174);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2174, 0, 0, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 3019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coastal Frenzy - Between 5-15% Health - Cast \'3019\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2235;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2235);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2235, 0, 0, 0, 0, 0, 100, 0, 2300, 2600, 8900, 9400, 11, 12166, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Reef Crawler - In Combat - Cast \'12166\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2233;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2233);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2233, 0, 0, 0, 0, 0, 100, 0, 2400, 3100, 32500, 34600, 11, 3427, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Encrusted Tide Crawler - In Combat - Cast \'3427\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2236;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2236);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2236, 0, 0, 0, 0, 0, 100, 0, 2700, 3100, 9500, 10100, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raging Reef Crawler - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2182;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2182);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2182, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stormscale Sorceress - On Aggro - Cast \'12544\''),
(2182, 0, 1, 0, 0, 0, 100, 0, 2300, 2700, 6800, 7400, 11, 20792, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stormscale Sorceress - In Combat - Cast \'20792\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2181;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2181);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2181, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5164, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stormscale Myrmidon - Between 30-60% Health - Cast \'5164\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3660;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 3660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3660, 0, 0, 0, 0, 0, 100, 0, 2700, 3100, 6800, 7200, 11, 7641, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Athrikus Narassin - In Combat - Cast \'7641\''),
(3660, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5782, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Athrikus Narassin - Between 30-60% Health - Cast \'5782\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2339;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2339);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2339, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Thug - On Aggro - Cast \'7165\''),
(2339, 0, 1, 0, 0, 0, 100, 1, 6500, 10000, 0, 0, 11, 5242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Thug - In Combat - Cast \'5242\' (No Repeat)'),
(2339, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Thug - Between 20-40% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2180;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2180);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2180, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 6500, 6700, 11, 9734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stormscale Siren - In Combat - Cast \'9734\''),
(2180, 0, 1, 0, 2, 0, 100, 1, 15, 30, 0, 0, 11, 11642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stormscale Siren - Between 15-30% Health - Cast \'11642\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2179;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2179);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2179, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 13586, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stormscale Wave Rider - Between 30-60% Health - Cast \'13586\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2189;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2189);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2189, 0, 0, 0, 0, 0, 100, 0, 2400, 2900, 32400, 32900, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vile Sprite - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2212;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2212);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2212, 0, 0, 0, 0, 0, 100, 0, 1000, 1500, 4600, 6800, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deth\'ryll Satyr - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2190;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2190);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2190, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5915, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wild Grell - On Aggro - Cast \'5915\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10159;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10159);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10159, 0, 0, 0, 0, 0, 100, 0, 1000, 1200, 5600, 5700, 11, 8921, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Moonkin - In Combat - Cast \'8921\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10158;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10158);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10158, 0, 0, 0, 0, 0, 100, 0, 2400, 2600, 6800, 7400, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonkin - In Combat - Cast \'12787\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10157;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10157);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10157, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15798, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonkin Oracle - On Aggro - Cast \'15798\''),
(10157, 0, 1, 0, 0, 0, 100, 0, 1400, 1600, 5400, 6200, 11, 9739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonkin Oracle - In Combat - Cast \'9739\''),
(10157, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 16561, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moonkin Oracle - Between 20-40% Health - Cast \'16561\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10160;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10160);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10160, 0, 0, 0, 0, 0, 100, 0, 1200, 1800, 16200, 16800, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raging Moonkin - In Combat - Cast \'13443\''),
(10160, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Raging Moonkin - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2176;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2176);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2176, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cursed Highborne - On Aggro - Cast \'5884\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2178;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2178);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2178, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wailing Highborne - On Aggro - Cast \'5884\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2177;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2177);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2177, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Writhing Highborne - On Aggro - Cast \'5884\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2322;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2322);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2322, 0, 0, 0, 0, 0, 100, 0, 2100, 3100, 6900, 7400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreststrider - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2321;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2321);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2321, 0, 0, 0, 0, 0, 100, 0, 2100, 3100, 6900, 7400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Foreststrider Fledgling - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2069;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2069);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2069, 0, 0, 0, 0, 0, 100, 0, 1200, 1300, 12200, 14300, 11, 24331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonstalker - In Combat - Cast \'24331\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2165;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2165);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2165, 0, 0, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 3242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grizzled Thistle Bear - Between 20-60% Health - Cast \'3242\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2237;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2237);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2237, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 7800, 8900, 11, 6595, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonstalker Sire - In Combat - Cast \'6595\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2168;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2168);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2168, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwood Warrior - On Aggro - Cast \'7165\''),
(2168, 0, 1, 0, 0, 0, 100, 1, 6500, 10000, 0, 0, 11, 13532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blackwood Warrior - In Combat - Cast \'13532\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2323;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2323);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2323, 0, 0, 0, 0, 0, 100, 0, 2100, 3100, 6900, 7400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Giant Foreststrider - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2169;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2169);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2169, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwood Totemic - On Aggro - Cast \'5605\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2070;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2070);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2070, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 7800, 8900, 11, 6595, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonstalker Runt - In Combat - Cast \'6595\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2071;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2071);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2071, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 12, 2070, 3, 30000, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Moonstalker Matriarch - On Aggro - Summon Creature \'Moonstalker Runt\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
