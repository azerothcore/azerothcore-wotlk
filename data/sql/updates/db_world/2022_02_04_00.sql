-- DB update 2022_02_03_08 -> 2022_02_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_03_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_03_08 2022_02_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639761638374281200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639761638374281200');

SET @THRASH_01 = 3391;
SET @THRASH_02 = 12787;
SET @THRASH_03 = 3417;
SET @THRASH_04 = 8876;

-- Removing Thrash from creatures that cast this spell that are not the ones specified.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`action_type` = 11) AND (`action_param1` = @THRASH_01);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`action_type` = 11) AND (`action_param1` = @THRASH_02) AND `entryorguid` NOT IN (1843, 16216, 24552, 25027, 25028, 29392);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`action_type` = 11) AND (`action_param1` = @THRASH_03) AND `entryorguid` NOT IN (11486, 15207, 15305);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`action_type` = 11) AND (`action_param1` = @THRASH_04) AND `entryorguid` NOT IN (16593, 17397, 18631, 23680, 29033);

-- Updating AIName from all creatures without any SmartAI Scripts
UPDATE `creature_template` 
INNER JOIN (SELECT `entryorguid`, COUNT(*) amount FROM `smart_scripts` WHERE (`source_type` = 0) GROUP BY `entryorguid`) counter
ON counter.entryorguid = creature_template.entry
SET creature_template.AIName = IF(counter.amount > 0, "SmartAI", "");

-- Riverpaw Outrunner
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 478) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(478, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Riverpaw Outrunner - In Combat - Cast \'Thrash\'');

-- Skullsplitter Hunter
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 669) AND (`source_type` = 0) AND (`id` IN (0, 2, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(669, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 3621, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - On Aggro - Cast \'Skullsplitter Pet\' (No Repeat)'),
(669, 0, 2, 0, 2, 0, 100, 1, 5, 25, 0, 0, 0, 11, 3148, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - Between 5-25% Health - Cast \'Head Crack\' (No Repeat)'),
(669, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - In Combat - Cast \'Thrash\'');

-- Tunnel Rat Kobold
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1202) AND (`source_type` = 0) AND (`id` IN (0, 2, 3, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1202, 0, 0, 0, 4, 0, 10, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunnel Rat Kobold - On Aggro - Say Line 0 (No Repeat)'),
(1202, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunnel Rat Kobold - Between 0-15% Health - Flee For Assist (No Repeat)'),
(1202, 0, 3, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunnel Rat Kobold - On Aggro - Say Line 2 (No Repeat)'),
(1202, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunnel Rat Kobold - In Combat - Cast \'Thrash\'');

-- Skeletal Flayer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1783;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1783) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1783, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Flayer - In Combat - Cast \'Thrash\'');

-- Slavering Ghoul
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1791) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1791, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 90000, 120000, 0, 11, 7125, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Slavering Ghoul - In Combat - Cast \'Toxic Saliva\''),
(1791, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Slavering Ghoul - In Combat - Cast \'Thrash\'');

-- Raging Reef Crawler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2236;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2236) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2236, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Reef Crawler - In Combat - Cast \'Thrash\'');

-- Highland Thrasher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2560;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2560) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2560, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Highland Thrasher - In Combat - Cast \'Thrash\'');

-- Vilebranch Raiding Wolf
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2681;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2681) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2681, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Raiding Wolf - In Combat - Cast \'Thrash\'');

-- Dustbelcher Mauler
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2717) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2717, 0, 0, 0, 4, 0, 10, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dustbelcher Mauler - On Aggro - Say Line 0 (No Repeat)'),
(2717, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dustbelcher Mauler - In Combat - Cast \'Thrash\'');

-- Feral Crag Coyote
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2728) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2728, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Feral Crag Coyote - In Combat - Cast \'Thrash\'');

-- Sunscale Scytheclaw
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3256;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3256) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3256, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunscale Scytheclaw - In Combat - Cast \'Thrash\'');

-- Bael'dun Officer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3378) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3378, 0, 1, 0, 0, 0, 60, 0, 5000, 5000, 23000, 23000, 0, 11, 6264, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Officer - In Combat - Cast \'Nimble Reflexes\''),
(3378, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Officer - In Combat - Cast \'Thrash\'');

-- Razormane Pathfinder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3456) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3456, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razormane Pathfinder - In Combat - Cast \'Shoot\''),
(3456, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razormane Pathfinder - In Combat - Cast \'Thrash\'');

-- Foulweald Den Watcher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3746;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3746) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3746, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Foulweald Den Watcher - In Combat - Cast \'Thrash\'');

-- Bloodfury Roguefeather
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4023;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4023) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4023, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodfury Roguefeather - In Combat - Cast \'Thrash\'');

-- Strashaz Hydra
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4374);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4374, 0, 0, 0, 0, 0, 100, 1, 2500, 3000, 0, 0, 0, 11, 16128, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Hydra - In Combat - Cast \'Infected Bite\' (No Repeat)'),
(4374, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Hydra - In Combat - Cast \'Thrash\'');

-- Scarlet Avenger
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4493) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4493, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Avenger - Between 0-15% Health - Flee For Assist (No Repeat)'),
(4493, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Avenger - In Combat - Cast \'Thrash\'');

-- Scarlet Monk
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4540) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4540, 0, 0, 0, 13, 0, 100, 0, 7000, 7000, 0, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - on victim casting any spell - Cast \'Kick\''),
(4540, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - Between 0-15% Health - Flee For Assist (No Repeat)'),
(4540, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - In Combat - Cast \'Thrash\'');

-- Kolkar Mauler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4634;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4634) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4634, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Mauler - In Combat - Cast \'Thrash\'');

-- Maraudine Mauler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4656;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4656) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4656, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Mauler - In Combat - Cast \'Thrash\'');

-- Stonevault Brawler: Was missing Enrage - Say Link on event
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4855) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4855, 0, 1, 0, 61, 0, 100, 0, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - Between 0-30% Health - Say Line 0 (No Repeat)'),
(4855, 0, 2, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - In Combat - Cast \'Thrash\''),
(4855, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - Between 0-30% Health - Cast \'Enrage\' (No Repeat)');

-- Gordunni Mauler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5234;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5234) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5234, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Mauler - In Combat - Cast \'Thrash\'');

-- Unliving Atal'ai
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5267) AND (`source_type` = 0) AND (`id` IN (1, 2, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5267, 0, 1, 2, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal\'ai - Between 0-30% Health - Cast \'Frenzy\' (No Repeat)'),
(5267, 0, 2, 0, 61, 0, 100, 0, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal\'ai - Between 0-30% Health - Say Line 0 (No Repeat)'),
(5267, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal\'ai - In Combat - Cast \'Thrash\'');

-- Centipaar Wasp, Stinger, Swarmer and Tunneler
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (5455, 5456, 5457, 5459)) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5455, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Wasp - In Combat - Cast \'Thrash\''),
(5456, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Stinger - In Combat - Cast \'Thrash\''),
(5457, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Swarmer - In Combat - Cast \'Thrash\''),
(5459, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Tunneler - In Combat - Cast \'Thrash\'');

-- Centipaar Worker
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5458) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5458, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Worker - Between 0-30% Health - Flee For Assist (No Repeat)'),
(5458, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Worker - In Combat - Cast \'Thrash\'');

-- Centipaar Sandreaver
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5460) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5460, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Sandreaver - In Combat - Cast \'Thrash\'');

-- Shade of Eranikus: Fixed ID order for events and removed Linked event 0 to 1, maybe fixing on pull Say Text.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5709) AND (`source_type` = 0) AND (`id` IN (0, 2, 3, 4, 5, 6, 7, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5709, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Reset - Cast \'Shade of Eranikus Passive Visual\''),
(5709, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Aggro - Say Line 0'),
(5709, 0, 2, 0, 0, 0, 100, 0, 14000, 20000, 20000, 30000, 0, 11, 11876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast \'War Stomp\''),
(5709, 0, 3, 0, 0, 0, 100, 0, 7000, 14000, 20000, 26000, 0, 11, 12890, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast \'Deep Slumber\''),
(5709, 0, 4, 0, 0, 0, 100, 0, 1000, 11000, 8000, 18000, 0, 11, 12884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast \'Acid Breath\''),
(5709, 0, 5, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - Out of Combat - Remove Flags Immune To Players & Immune To NPC\'s'),
(5709, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Aggro - Set Instance Data 12 to 0'),
(5709, 0, 7, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast \'Thrash\'');

-- Dreadmaul Mauler
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5977) AND (`source_type` = 0) AND (`id` IN (0, 2, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5977, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 11960, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - On Aggro - Cast \'Curse of the Dreadmaul\' (No Repeat)'),
(5977, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - Between 5-30% Health - Cast \'Enrage\' (No Repeat)'),
(5977, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - In Combat - Cast \'Thrash\'');

-- Shadowsworn Thug
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6005) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6005, 0, 2, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsworn Thug - In Combat - Cast \'Thrash\'');

-- Wavethrasher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6348;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6348) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6348, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wavethrasher - In Combat - Cast \'Thrash\'');

-- War Reaver
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7039) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7039, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'War Reaver - In Combat - Cast \'Thrash\'');

-- Warpwood Shredder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7101) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7101, 0, 1, 0, 0, 0, 100, 0, 5900, 6000, 12800, 12900, 0, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warpwood Shredder - In Combat - Cast \'Sunder Armor\''),
(7101, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warpwood Shredder - In Combat - Cast \'Thrash\'');

-- Ferocitas the Dream Eater
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7234;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7234) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7234, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ferocitas the Dream Eater - In Combat - Cast \'Thrash\'');

-- Stonevault Mauler: Missing Enrage Text linked event.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7320) AND (`source_type` = 0) AND (`id` IN (1, 2, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7320, 0, 1, 2, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - Between 0-30% Health - Cast \'Enrage\' (No Repeat)'),
(7320, 0, 2, 0, 61, 0, 100, 0, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - Between 0-30% Health - Say Line 0 (No Repeat)'),
(7320, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - In Combat - Cast \'Thrash\'');

-- Sul'lithuz Broodling
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8138;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8138) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8138, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sul\'lithuz Broodling - In Combat - Cast \'Thrash\'');

-- Fireguard Destroyer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8911;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8911) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8911, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fireguard Destroyer - In Combat - Cast \'Thrash\'');

-- Felpaw Ravager
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8961;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8961) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8961, 0, 1, 0, 0, 0, 100, 1, 6500, 6600, 0, 0, 0, 11, 17230, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Ravager - In Combat - Cast \'Infected Wound\' (No Repeat)'),
(8961, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Ravager - In Combat - Cast \'Thrash\'');

-- Rage Talon Dragonspawn
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9096) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9096, 0, 0, 0, 0, 0, 100, 2, 4000, 13200, 6600, 14400, 0, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - In Combat - Cast \'Strike\' (Normal Dungeon)'),
(9096, 0, 1, 0, 0, 0, 100, 2, 7700, 17100, 20300, 34200, 0, 11, 12021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - In Combat - Cast \'Fixate\' (Normal Dungeon)'),
(9096, 0, 2, 0, 0, 0, 100, 2, 1400, 12300, 7100, 11700, 0, 11, 15572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(9096, 0, 3, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - In Combat - Cast \'Thrash\''),
(9096, 0, 4, 0, 61, 0, 100, 0, 0, 30, 120000, 120000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - Between 0-30% Health - Say Line 0 (Normal Dungeon)');

-- Smolderthorn Axe Thrower
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9267) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9267, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2300, 3900, 0, 11, 15795, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Smolderthorn Axe Thrower - In Combat - Cast \'Throw\' (Normal Dungeon)'),
(9267, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Smolderthorn Axe Thrower - In Combat - Cast \'Thrash\'');

-- Flamekin Sprite
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9777;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9777) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9777, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamekin Sprite - In Combat - Cast \'Thrash\'');

-- Risen Construct
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10488) AND (`source_type` = 0) AND (`id` IN (1, 2, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10488, 0, 1, 0, 0, 0, 100, 1, 15000, 36000, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - In Combat - Cast \'Frenzy\' (No Repeat)'),
(10488, 0, 2, 0, 0, 0, 100, 0, 4000, 7000, 8000, 13000, 0, 11, 16169, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - In Combat - Cast \'Arcing Smash\''),
(10488, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - In Combat - Cast \'Thrash\'');

-- Wildpaw Gnoll
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10991;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10991) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10991, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wildpaw Gnoll - In Combat - Cast \'Thrash\'');

-- Crimson Monk
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11043) AND (`source_type` = 0) AND (`id` IN (0, 2, 3, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11043, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 0, 11, 674, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Reset - Cast \'Dual Wield\' (No Repeat)'),
(11043, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - In Combat - Cast \'Thrash\''),
(11043, 0, 2, 0, 13, 0, 100, 0, 8000, 13000, 0, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - on victim casting any spell - Cast \'Kick\''),
(11043, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Son of Hakkar
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11357) AND (`source_type` = 0) AND (`id` IN (1, 2, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11357, 0, 1, 0, 0, 0, 100, 0, 11000, 13000, 19000, 22000, 0, 11, 16790, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - In Combat - Cast \'Knockdown\''),
(11357, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 24320, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - On Just Died - Cast \'Poisonous Blood\''),
(11357, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - In Combat - Cast \'Thrash\'');

-- Razzashi Adder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11372) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11372, 0, 0, 0, 0, 0, 85, 0, 3000, 3000, 15000, 18000, 0, 11, 24011, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Adder - In Combat - Cast \'Venom Spit\''),
(11372, 0, 1, 0, 0, 0, 100, 0, 10000, 11000, 20000, 20000, 0, 11, 24016, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Adder - In Combat - Cast \'Exploit Weakness\''),
(11372, 0, 2, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Adder - In Combat - Cast \'Thrash\'');

-- Prince Tortheldrin
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11486) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11486, 0, 0, 1, 60, 0, 100, 257, 5000, 5000, 5000, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Update - Say Line 0 (No Repeat)'),
(11486, 0, 1, 0, 61, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Update - Set Faction 14 (No Repeat)'),
(11486, 0, 2, 0, 25, 0, 100, 257, 0, 0, 0, 0, 0, 11, 674, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Reset - Cast \'Dual Wield\' (No Repeat)'),
(11486, 0, 3, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - In Combat - Cast \'Thrash\''),
(11486, 0, 4, 0, 0, 0, 100, 0, 3000, 5000, 10000, 20000, 0, 11, 22920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - In Combat - Cast \'Arcane Blast\''),
(11486, 0, 5, 0, 0, 0, 100, 0, 8000, 11000, 10000, 15000, 0, 11, 13736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - In Combat - Cast \'Whirlwind\''),
(11486, 0, 6, 0, 13, 0, 100, 0, 9000, 12000, 0, 0, 0, 11, 20537, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Victim Casting any spell - Cast \'Counterspell\''),
(11486, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Just Died - Set Instance Data 1 to 2');

-- Taskmaster Snivvle
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11677) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11677, 0, 0, 0, 4, 0, 100, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Snivvle - On Aggro - Say Line 0 (No Repeat) (Normal Dungeon)'),
(11677, 0, 1, 0, 0, 0, 100, 2, 3000, 6000, 6000, 9000, 0, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Snivvle - In Combat - Cast \'Strike\' (Normal Dungeon)'),
(11677, 0, 2, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Snivvle - In Combat - Cast \'Thrash\''),
(11677, 0, 3, 0, 2, 0, 100, 2, 0, 30, 30000, 35000, 0, 11, 16170, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Snivvle - Between 0-30% Health - Cast \'Bloodlust\' (Normal Dungeon)');

-- Stonelash Flayer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11737) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11737, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 13000, 18000, 0, 11, 5416, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonelash Flayer - In Combat - Cast \'Venom Sting\''),
(11737, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonelash Flayer - In Combat - Cast \'Thrash\'');

-- Putridus Trickster
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11791) AND (`source_type` = 0) AND (`id` IN (0, 2, 3, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11791, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 21061, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Reset - Cast \'Putrid Breath\''),
(11791, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - In Combat - Cast \'Thrash\''),
(11791, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 13299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Reset - Cast \'Poison Proc\''),
(11791, 0, 3, 0, 67, 0, 100, 0, 5000, 5000, 0, 0, 0, 11, 15657, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Behind Target - Cast \'Backstab\'');

-- Princess Theradras
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12201) AND (`source_type` = 0) AND (`id` IN (1, 2, 3, 4, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12201, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast \'Thrash\''),
(12201, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 16000, 19000, 0, 11, 21832, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast \'Boulder\''),
(12201, 0, 2, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 0, 11, 21909, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast \'Dust Field\''),
(12201, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 0, 11, 21869, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast \'Repulsive Gaze\''),
(12201, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 12, 12238, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 28.067, 61.875, -123.405, 4.67, 'Princess Theradras - On Just Died - Summon Creature \'Zaetar\'s Spirit\'');

-- Thessala Hydra
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12207) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12207, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 21788, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - On Reset - Cast \'Deadly Poison\''),
(12207, 0, 2, 0, 0, 0, 100, 0, 1000, 9000, 11000, 20000, 0, 11, 21790, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - In Combat - Cast \'Aqua Jet\''),
(12207, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - In Combat - Cast \'Thrash\'');

-- Vorsha the Lasher
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12940) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12940, 0, 1, 0, 9, 0, 100, 0, 0, 5, 11200, 19500, 0, 11, 6607, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vorsha the Lasher - Within 0-5 Range - Cast \'Lash\''),
(12940, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vorsha the Lasher - In Combat - Cast \'Thrash\'');

-- Frostwolf Bloodhound
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14282) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14282, 0, 1, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 89, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwolf Bloodhound - Out of Combat - Start Random Movement'),
(14282, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwolf Bloodhound - In Combat - Cast \'Thrash\'');

-- Stormpike Owl
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14283;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14283) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14283, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormpike Owl - In Combat - Cast \'Thrash\'');

-- Harb Foulmountain
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14426;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14426) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14426, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 0, 11, 45, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Harb Foulmountain - Between 30-60% Health - Cast \'War Stomp\' (No Repeat)'),
(14426, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Harb Foulmountain - In Combat - Cast \'Thrash\'');

-- Gurubashi Bat Rider
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14750) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14750, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 23511, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - On Aggro - Cast \'Demoralizing Shout\''),
(14750, 0, 1, 0, 0, 0, 100, 0, 8000, 8000, 25000, 25000, 0, 11, 5115, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - In Combat - Cast \'Battle Command\''),
(14750, 0, 2, 0, 0, 0, 100, 0, 6500, 6500, 8000, 8000, 0, 11, 16128, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - In Combat - Cast \'Infected Bite\''),
(14750, 0, 3, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - In Combat - Cast \'Thrash\'');

-- Razzashi Raptor
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14821;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14821) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14821, 0, 0, 0, 0, 0, 100, 0, 6500, 6500, 8000, 8000, 0, 11, 24339, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Raptor - In Combat - Cast \'Infected Bite\''),
(14821, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Raptor - In Combat - Cast \'Thrash\'');

-- Atal'ai Mistress
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14882) AND (`source_type` = 0) AND (`id` IN (1, 2, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14882, 0, 1, 0, 0, 0, 100, 0, 11000, 14000, 22000, 22000, 0, 11, 24673, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Mistress - In Combat - Cast \'Curse of Blood\''),
(14882, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 22000, 22000, 0, 11, 24671, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Mistress - In Combat - Cast \'Snap Kick\''),
(14882, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Mistress - In Combat - Cast \'Thrash\'');

-- Unholy Swords
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16216) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16216, 0, 0, 0, 0, 0, 100, 0, 4000, 4700, 9200, 15500, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unholy Swords - In Combat - Cast \'Cleave\''),
(16216, 0, 1, 0, 0, 0, 100, 0, 2400, 7800, 12000, 13600, 0, 11, 12787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unholy Swords - In Combat - Cast \'Thrash\'');

-- Wrathbringer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18858) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18858, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathbringer - In Combat - Cast \'Thrash\'');

-- Fenclaw Thrasher
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18214) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18214, 0, 0, 0, 0, 0, 100, 1, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fenclaw Thrasher - In Combat - Cast \'Thrash\' (No Repeat)');

-- Unbound Ethereal
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22244) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22244, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Ethereal - In Combat - Cast \'Thrash\'');

-- Trigul
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22174) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22174, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Trigul - In Combat - Cast \'Thrash\''),
(22174, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 33628, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Trigul - Between 20-80% Health - Cast \'Lightning Tether\' (No Repeat)');

-- Outraged Raven's Wood Sapling
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21040) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21040, 0, 0, 0, 0, 0, 100, 1, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Outraged Raven\'s Wood Sapling - In Combat - Cast \'Thrash\' (No Repeat)');

-- Fel Rager
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22286) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22286, 0, 0, 0, 0, 0, 100, 1, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Rager - In Combat - Cast \'Thrash\' (No Repeat)');

-- Vengeful Draenei
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21636) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21636, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Draenei - In Combat - Cast \'Thrash\'');

-- Subjugator Vaz'shir
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18660) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18660, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Vaz\'shir - In Combat - Cast \'Thrash\''),
(18660, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 13736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Vaz\'shir - Between 20-80% Health - Cast \'Whirlwind\' (No Repeat)');

-- Mountain Gronn
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19201) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19201, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 20000, 25000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mountain Gronn - In Combat - Cast \'Thrash\'');

-- Murkblood Scavenger
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18207) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18207, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 12000, 18000, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Scavenger - In Combat - Cast \'Thrash\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_04_00' WHERE sql_rev = '1639761638374281200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
