-- DB update 2022_03_06_19 -> 2022_03_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_19';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_19 2022_03_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646161855065886626'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646161855065886626');

-- Riverpaw Outrunner
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 478);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(478, 0, 0, 0, 4, 0, 30, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Riverpaw Outrunner - On Aggro - Say Line 0 (No Repeat)'),
(478, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Riverpaw Outrunner - In Combat - Cast \'Thrash\' (No Repeat)');

-- Skullsplitter Hunter
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 669);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(669, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 3621, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - On Aggro - Cast \'3621\' (No Repeat)'),
(669, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - In Combat - Cast \'Thrash\' (No Repeat)'),
(669, 0, 2, 0, 2, 0, 100, 1, 5, 25, 0, 0, 0, 11, 3148, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - Between 5-25% Health - Cast \'3148\' (No Repeat)');

-- Tunnel Rat Kobold
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1202, 0, 0, 0, 4, 0, 10, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunnel Rat Kobold - On Aggro - Say Line 0'),
(1202, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunnel Rat Kobold - In Combat - Cast \'Thrash\''),
(1202, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunnel Rat Kobold - Between 0-15% Health - Flee For Assist'),
(1202, 0, 3, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunnel Rat Kobold - On Aggro - Say Line 2');

-- Skeletal Flayer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1783;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1783);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1783, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Flayer - In Combat - Cast \'Thrash\' (No Repeat)');

-- Slavering Ghoul
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1791);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1791, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slavering Ghoul - In Combat - Cast \'Thrash\' (No Repeat)'),
(1791, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 90000, 120000, 0, 11, 7125, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Slavering Ghoul - In Combat - Cast \'Toxic Saliva\' (No Repeat)');

-- Raging Reef Crawler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2236;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2236);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2236, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Reef Crawler - In Combat - Cast \'Thrash\' (No Repeat)');

-- Highland Thrasher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2560;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2560);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2560, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highland Thrasher - In Combat - Cast \'Thrash\' (No Repeat)');

-- Vilebranch Raiding Wolf
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2681;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2681);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2681, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Raiding Wolf  - In Combat - Cast \'Thrash\'');

-- Dustbelcher Mauler
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2717);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2717, 0, 0, 0, 4, 0, 10, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dustbelcher Mauler - On Aggro - Say Line 0'),
(2717, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dustbelcher Mauler - In Combat - Cast \'Thrash\'');

-- Feral Crag Coyote
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2728);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2728, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feral Crag Coyote - In Combat - Cast \'Thrash\'');

-- Sunscale Scytheclaw
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3256;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3256);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3256, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunscale Scytheclaw - In Combat - Cast \'Thrash\' (No Repeat)');

-- Bael'dun Officer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3378);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3378, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Officer - In Combat - Cast \'Thrash\' (No Repeat)'),
(3378, 0, 1, 0, 0, 0, 60, 0, 5000, 5000, 23000, 23000, 0, 11, 6264, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Officer - In Combat - Cast \'Nimble Reflexes\' (No Repeat)');

-- Razormane Pathfinder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3456);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3456, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razormane Pathfinder - In Combat CMC - Cast \'Shoot\''),
(3456, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Razormane Pathfinder - In Combat - Cast \'Thrash\''),
(3456, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Razormane Pathfinder - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Foulweald Den Watcher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3746;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3746);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3746, 0, 0, 0, 25, 0, 100, 1, 0, 0, 0, 0, 0, 11, 6822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Foulweald Den Watcher - On Reset - Cast \'Corrupted Stamina Passive\' (No Repeat)'),
(3746, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Foulweald Den Watcher - In Combat - Cast \'Thrash\' (No Repeat)'),
(3746, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Foulweald Den Watcher - Between 0-15% Health - Flee For Assist (No Repeat)'),
(3746, 2, 0, 0, 46, 0, 100, 0, 3746, 0, 0, 0, 0, 70, 7200, 0, 0, 0, 0, 0, 14, 5639, 180024, 0, 0, 0, 0, 0, 0, 'Area Trigger 3746 - On Trigger - Respawn Mysterious Deadmines Chest');

-- Bloodfury Roguefeather
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4023;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4023);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4023, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodfury Roguefeather - In Combat - Cast \'Thrash\'');

-- Strashaz Hydra
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4374);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4374, 0, 0, 0, 0, 0, 100, 1, 2500, 3000, 0, 0, 0, 11, 16128, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Hydra - In Combat - Cast \'16128\' (No Repeat)'),
(4374, 0, 1, 0, 0, 0, 100, 0, 6200, 7400, 13400, 16800, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Strashaz Hydra - In Combat - Cast \'Thrash\'');

-- Scarlet Avenger
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4493);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4493, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Avenger - In Combat - Cast \'Thrash\''),
(4493, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Avenger - Between 0-15% Health - Flee For Assist');

-- Scarlet Monk
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4540);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4540, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - On Reset - Cast Thrash'),
(4540, 0, 2, 0, 13, 0, 100, 0, 7000, 7000, 0, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - Victim Casting - Cast Kick'),
(4540, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - Between 0-15% Health - Flee For Assist');

-- Kolkar Mauler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4634;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4634);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4634, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Mauler - In Combat - Cast \'Thrash\'');

-- Maraudine Mauler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4656;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4656);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4656, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Mauler - In Combat - Cast \'Thrash\'');

-- Stonevault Brawler: Was missing Enrage - Say Link on event
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4855);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4855, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - On Reset - Cast Thrash'),
(4855, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - Between 0-30% Health - Cast Frenzy'),
(4855, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - Between 0-30% Health - Say Line 0');

-- Gordunni Mauler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5234;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5234);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5234, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Mauler - In Combat - Cast \'Thrash\'');

-- Unliving Atal'ai
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5267);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5267, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal\'ai - On Reset - Cast Thrash'),
(5267, 0, 1, 2, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal\'ai - Between 0-30% Health - Cast Frenzy'),
(5267, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal\'ai - Between 0-30% Health - Say Line 0');

-- Centipaar Wasp, Stinger, Swarmer and Tunneler
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (5455, 5456, 5457, 5459));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5455, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 12000, 16000, 0, 11, 744, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Wasp - In Combat - Cast \'Poison\''),
(5455, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Wasp - In Combat - Cast \'Thrash\''),
(5456, 0, 0, 0, 0, 0, 100, 0, 10000, 14000, 40000, 50000, 0, 11, 5416, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Stinger - In Combat - Cast \'Venom Sting\''),
(5456, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Stinger - In Combat - Cast \'Thrash\''),
(5457, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 8000, 12000, 0, 11, 6589, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Swarmer - In Combat - Cast \'Silithid Swarm\''),
(5457, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Swarmer - In Combat - Cast \'Thrash\''),
(5459, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 18000, 25000, 0, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Tunneler - In Combat - Cast \'Pierce Armor\''),
(5459, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Tunneler - In Combat - Cast \'Thrash\'');

-- Centipaar Worker
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5458);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5458, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Worker - In Combat - Cast \'Thrash\''),
(5458, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Worker - Between 0-30% Health - Flee For Assist');

-- Centipaar Sandreaver
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5460);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5460, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Sandreaver - In Combat - Cast \'Thrash\''),
(5460, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 5000, 9000, 0, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Sandreaver - In Combat - Cast \'Arcing Smash\'');

-- Shade of Eranikus
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5709);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5709, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Reset - Cast Shade of Eranikus Passive Visual'),
(5709, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Reset - Cast Thrash'),
(5709, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Aggro - Say Line 0'),
(5709, 0, 3, 0, 0, 0, 100, 0, 14000, 20000, 20000, 30000, 0, 11, 11876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast War Stomp'),
(5709, 0, 4, 0, 0, 0, 100, 0, 7000, 14000, 20000, 26000, 0, 11, 12890, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast Deep Slumber'),
(5709, 0, 5, 0, 0, 0, 100, 0, 1000, 11000, 8000, 18000, 0, 11, 12884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast Acid Breath'),
(5709, 0, 6, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - Out of Combat - Remove Unit Flags'),
(5709, 0, 7, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Aggro - Set Instance Data 12');

-- Dreadmaul Mauler
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5977);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5977, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 11960, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - On Aggro - Cast \'11960\' (No Repeat)'),
(5977, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - On Aggro - Cast \'Thrash\''),
(5977, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - Between 5-30% Health - Cast \'8599\' (No Repeat)');

-- Shadowsworn Thug
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6005);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6005, 0, 0, 0, 0, 0, 100, 0, 4300, 4900, 8400, 16100, 0, 11, 11978, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsworn Thug - In Combat - Cast \'Kick\''),
(6005, 0, 1, 0, 0, 0, 100, 0, 8800, 24700, 13600, 24700, 0, 11, 8646, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsworn Thug - In Combat - Cast \'Snap Kick\''),
(6005, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsworn Thug - In Combat - Cast \'Thrash\'');

-- Wavethrasher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6348;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6348);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6348, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 6700, 8200, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wavethrasher - In Combat - Cast \'Thrash\'');

-- War Reaver
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7039);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7039, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'War Reaver - In Combat - Cast \'Thrash\''),
(7039, 0, 1, 0, 0, 0, 100, 0, 11700, 25800, 18400, 30300, 0, 11, 10966, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'War Reaver - In Combat - Cast \'Uppercut\'');

-- Warpwood Shredder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7101, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warpwood Shredder - In Combat - Cast \'Thrash\''),
(7101, 0, 1, 0, 0, 0, 100, 0, 5900, 6000, 12800, 12900, 0, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warpwood Shredder - In Combat - Cast \'13444\'');

-- Ferocitas the Dream Eater
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7234;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7234);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7234, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ferocitas the Dream Eater - In Combat - Cast \'Thrash\'');

-- Stonevault Mauler
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7320);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7320, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - On Reset - Cast Thrash'),
(7320, 0, 1, 2, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - Between 0-30% Health - Cast Frenzy'),
(7320, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - Between 0-30% Health - Say Line 0 (No Repeat)');

-- Sul'lithuz Broodling
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8138;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8138);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8138, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sul\'lithuz Broodling - In Combat - Cast \'Thrash\'');

-- Fireguard Destroyer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8911;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8911);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8911, 0, 0, 0, 9, 0, 100, 2, 0, 30, 9000, 11000, 0, 11, 15243, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fireguard Destroyer - Within 0-30 Range - Cast \'Fireball Volley\' (Normal Dungeon)'),
(8911, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fireguard Destroyer - On Reset - Cast Thrash');

-- Felpaw Ravager
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8961;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8961);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8961, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Ravager - In Combat - Cast \'Thrash\''),
(8961, 0, 1, 0, 0, 0, 100, 1, 6500, 6600, 0, 0, 0, 11, 17230, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felpaw Ravager - In Combat - Cast \'17230\' (No Repeat)');

-- Rage Talon Dragonspawn
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9096);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9096, 0, 0, 0, 0, 0, 100, 2, 4000, 13200, 6600, 14400, 0, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - In Combat - Cast \'Strike\' (Phase 1) (No Repeat) (Normal Dungeon)'),
(9096, 0, 1, 0, 0, 0, 100, 2, 7700, 17100, 20300, 34200, 0, 11, 12021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - In Combat - Cast \'Fixate\' (Phase 1) (No Repeat) (Normal Dungeon)'),
(9096, 0, 2, 0, 0, 0, 100, 2, 1400, 12300, 7100, 11700, 0, 11, 15572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - In Combat - Cast \'Sunder Armor\' (Phase 1) (No Repeat) (Normal Dungeon)'),
(9096, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - In Combat - Cast \'Thrash\' (Phase 1) (No Repeat) (Normal Dungeon)'),
(9096, 0, 4, 5, 2, 0, 100, 2, 0, 30, 120000, 120000, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - Between 0-30% Health - Cast \'Frenzy\' (Normal Dungeon)'),
(9096, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Talon Dragonspawn - Between 0-30% Health - Say Line 0 (Normal Dungeon)');

-- Flamekin Sprite
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9777;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9777);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9777, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamekin Sprite - In Combat - Cast \'Thrash\'');

-- Risen Construct
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10488);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10488, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - On Reset - Cast Thrash'),
(10488, 0, 1, 0, 0, 0, 100, 1, 15000, 36000, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - In Combat - Cast Frenzy'),
(10488, 0, 2, 0, 0, 0, 100, 0, 4000, 7000, 8000, 13000, 0, 11, 16169, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - In Combat - Cast Arcing Smash');

-- Wildpaw Gnoll
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10991;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10991);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10991, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wildpaw Gnoll - In Combat - Cast \'Thrash\'');

-- Crimson Monk
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11043);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11043, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 0, 11, 674, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Reset - Cast Dual Wield'),
(11043, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Reset - Cast Thrash'),
(11043, 0, 2, 0, 13, 0, 100, 0, 8000, 13000, 0, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - Victim Casting - Cast Kick'),
(11043, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - Between 0-15% Health - Flee For Assist'),
(11043, 0, 4, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Aggro - Say Line 0');

-- Son of Hakkar
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11357);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11357, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - In Combat - Cast \'Thrash\' (No Repeat)'),
(11357, 0, 1, 0, 0, 0, 100, 0, 11000, 13000, 19000, 22000, 0, 11, 16790, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - In Combat - Cast \'Knockdown\' (No Repeat)'),
(11357, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 24320, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Hakkar - On Just Died - Cast \'Poisonous Blood\' (No Repeat)');


-- Razzashi Adder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11372);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11372, 0, 0, 0, 0, 0, 85, 0, 3000, 3000, 15000, 18000, 0, 11, 24011, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Adder - In Combat - Cast \'Venom Spit\' (No Repeat)'),
(11372, 0, 1, 0, 0, 0, 100, 0, 10000, 11000, 20000, 20000, 0, 11, 24016, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Adder - In Combat - Cast \'Exploit Weakness\' (No Repeat)'),
(11372, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Adder - In Combat - Cast \'Thrash\' (No Repeat)');

-- Prince Tortheldrin
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11486);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11486, 0, 0, 1, 60, 0, 100, 257, 5000, 5000, 5000, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Update - Say Line 0'),
(11486, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Update - Set Faction'),
(11486, 0, 2, 0, 25, 0, 100, 257, 0, 0, 0, 0, 0, 11, 674, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Reset - Cast Dual Wield'),
(11486, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Reset - Cast Thrash'),
(11486, 0, 4, 0, 0, 0, 100, 0, 3000, 5000, 10000, 20000, 0, 11, 22920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - In Combat - Cast Arcane Blast'),
(11486, 0, 5, 0, 0, 0, 100, 0, 8000, 11000, 10000, 15000, 0, 11, 13736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - In Combat - Cast Whirlwind'),
(11486, 0, 6, 0, 13, 0, 100, 0, 9000, 12000, 0, 0, 0, 11, 20537, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - Victim Casting - Cast Counterspell'),
(11486, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Tortheldrin - On Death - Set Instance Data 1 to 2');

-- Taskmaster Snivvle
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11677);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11677, 0, 0, 0, 4, 0, 100, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Snivvle - On Aggro - Say Line 0 (Phase 1) (No Repeat) (Normal Dungeon)'),
(11677, 0, 1, 0, 0, 0, 100, 2, 3000, 6000, 6000, 9000, 0, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Snivvle - In Combat - Cast \'Strike\' (Phase 1) (No Repeat) (Normal Dungeon)'),
(11677, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Snivvle - In Combat - Cast \'Thrash\' (Phase 1) (No Repeat) (Normal Dungeon)'),
(11677, 0, 3, 0, 2, 0, 100, 2, 0, 30, 30000, 35000, 0, 11, 16170, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Taskmaster Snivvle - Between 0-30% Health - Cast \'Bloodlust\' (Phase 1) (No Repeat) (Normal Dungeon)');

-- Stonelash Flayer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11737);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11737, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 13000, 18000, 0, 11, 5416, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonelash Flayer - In Combat - Cast Venom Sting'),
(11737, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonelash Flayer - In Combat - Cast \'Thrash\'');

-- Putridus Trickster
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11791);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11791, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 21061, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Reset - Cast Putrid Breath'),
(11791, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Reset - Cast Thrash'),
(11791, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 13299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - On Reset - Cast Poison Proc'),
(11791, 0, 3, 0, 67, 0, 100, 0, 5000, 5000, 0, 0, 0, 11, 15657, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Putridus Trickster - Behind Target - Cast Backstab');

-- Princess Theradras
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12201, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - On Reset - Cast Thrash'),
(12201, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 16000, 19000, 0, 11, 21832, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast Boulder'),
(12201, 0, 2, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 0, 11, 21909, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast Dust Field'),
(12201, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 0, 11, 21869, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Princess Theradras - In Combat - Cast Repulsive Gaze'),
(12201, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 12, 12238, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 28.067, 61.875, -123.405, 4.67, 'Princess Theradras - On Death - Summon Creature');

-- Thessala Hydra
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12207);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12207, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 21788, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - On Reset - Cast Deadly Poison'),
(12207, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - On Reset - Cast Thrash'),
(12207, 0, 2, 0, 0, 0, 100, 0, 1000, 9000, 11000, 20000, 0, 11, 21790, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thessala Hydra - In Combat - Cast Aqua Jet');

-- Vorsha the Lasher
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12940);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12940, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vorsha the Lasher - In Combat - Cast \'Thrash\' (No Repeat)'),
(12940, 0, 1, 0, 9, 0, 100, 0, 0, 5, 11200, 19500, 0, 11, 6607, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vorsha the Lasher - Within 0-5 Range - Cast \'Lash\' (No Repeat)');

-- Frostwolf Bloodhound
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14282);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14282, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwolf Bloodhound - In Combat - Cast Thrash'),
(14282, 0, 1, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 89, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwolf Bloodhound - Out of Combat - Use random movement');

-- Stormpike Owl
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14283;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14283);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14283, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormpike Owl - In Combat - Cast \'Thrash\'');

-- Harb Foulmountain
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14426;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14426);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14426, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 9000, 12000, 0, 11, 12787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Harb Foulmountain - In Combat - Cast \'Thrash\''),
(14426, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 0, 11, 45, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Harb Foulmountain - Between 30-60% Health - Cast \'45\' (No Repeat)');

-- Gurubashi Bat Rider
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14750);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14750, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 23511, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - On Aggro - Cast \'Demoralizing Shout\' (No Repeat)'),
(14750, 0, 1, 0, 0, 0, 100, 0, 8000, 8000, 25000, 25000, 0, 11, 5115, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - In Combat - Cast \'Battle Command\' (No Repeat)'),
(14750, 0, 2, 0, 0, 0, 100, 0, 6500, 6500, 8000, 8000, 0, 11, 16128, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - In Combat - Cast \'Infected Bite\' (No Repeat)'),
(14750, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - In Combat - Cast \'Thrash\' (No Repeat)'),
(14750, 0, 4, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 24024, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - Between 0-30% Health - Cast \'Unstable Concoction\' (No Repeat)'),
(14750, 0, 5, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bat Rider - Between 0-30% Health - Say Line 0 (No Repeat)');

-- Razzashi Raptor
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14821;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14821);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14821, 0, 0, 0, 0, 0, 100, 0, 6500, 6500, 8000, 8000, 0, 11, 24339, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Raptor - In Combat - Cast \'Infected Bite\' (No Repeat)'),
(14821, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Raptor - In Combat - Cast \'Thrash\' (No Repeat)'),
(14821, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Raptor - Between 0-30% Health - Cast \'Enrage\' (No Repeat)'),
(14821, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Raptor - Between 0-30% Health - Say Line 0 (No Repeat)');

-- Atal'ai Mistress
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14882);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14882, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Mistress - In Combat - Cast \'Thrash\' (No Repeat)'),
(14882, 0, 1, 0, 0, 0, 100, 0, 11000, 14000, 22000, 22000, 0, 11, 24673, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Mistress - In Combat - Cast \'Curse of Blood\' (No Repeat)'),
(14882, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 22000, 22000, 0, 11, 24671, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Mistress - In Combat - Cast \'Snap Kick\' (No Repeat)');

-- Unholy Swords
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16216);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16216, 0, 0, 0, 0, 0, 100, 0, 4000, 4700, 9200, 15500, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unholy Swords - In combat - Cast Cleave'),
(16216, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unholy Swords - In combat - Cast Thrash');

-- Wrathbringer
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18858);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18858, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathbringer - In Combat - Cast \'3391\'');

-- Fenclaw Thrasher
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18214);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18214, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fenclaw Thrasher - Between 20-80% Health - Cast \'3391\' (No Repeat)');

-- Unbound Ethereal
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22244);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22244, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Ethereal - In Combat - Cast \'3391\'');

-- Trigul
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22174);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22174, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Trigul - In Combat - Cast \'3391\''),
(22174, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 33628, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Trigul - Between 20-80% Health - Cast \'33628\' (No Repeat)');

-- Outraged Raven's Wood Sapling
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21040);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21040, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Outraged Raven\'s Wood Sapling - Between 20-80% Health - Cast \'3391\' (No Repeat)');

-- Fel Rager
DELETE FROM `smart_scripts` WHERE  `entryorguid` = 22286;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22286, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Rager - Between 20-80% Health - Cast \'3391\' (No Repeat)');

-- Vengeful Draenei
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21636);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21636, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Draenei - In Combat - Cast \'3391\'');

-- Subjugator Vaz'shir
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18660, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Vaz\'shir - In Combat - Cast \'3391\''),
(18660, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 13736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Vaz\'shir - Between 20-80% Health - Cast \'13736\' (No Repeat)');

-- Mountain Gronn
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19201, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mountain Gronn - In Combat - Cast \'3391\'');

-- Murkblood Scavenger
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18207);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18207, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Scavenger - Between 20-80% Health - Cast \'3391\' (No Repeat)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_07_00' WHERE sql_rev = '1646161855065886626';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
