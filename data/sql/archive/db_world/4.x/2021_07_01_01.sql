-- DB update 2021_07_01_00 -> 2021_07_01_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_01_00 2021_07_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625066362619921400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625066362619921400');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5763;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5763) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5763, 0, 0, 0, 1, 0, 100, 257, 3000, 3000, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Ectoplasm - Out of Combat - Set In Combat With Zone (No Repeat)'),
(5763, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 2, 1, 0, 0, 0, 0, 11, 3678, 500, 1, 0, 0, 0, 0, 0, 'Nightmare Ectoplasm - On Just Died - Set counter on Discipline of Naralex');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3678;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3678);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3678, 0, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 11, 5232, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Hello - Cast \'Mark of the Wild\''),
(3678, 0, 1, 2, 62, 0, 100, 0, 201, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Option 0 Selected - Set Faction 250'),
(3678, 0, 2, 3, 61, 0, 100, 0, 201, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Option 0 Selected - Set Active On'),
(3678, 0, 3, 4, 61, 0, 100, 0, 201, 0, 0, 0, 0, 53, 0, 3678, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Option 0 Selected - Start Waypoint'),
(3678, 0, 4, 0, 61, 0, 100, 0, 201, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Option 0 Selected - Set Reactstate Aggressive'),
(3678, 0, 5, 6, 40, 0, 100, 0, 1, 3678, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 1 Reached - Pause Waypoint'),
(3678, 0, 6, 0, 61, 0, 100, 0, 1, 3678, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 1 Reached - Say Line 1'),
(3678, 0, 7, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Aggro - Say Line 11'),
(3678, 0, 8, 9, 40, 0, 100, 0, 5, 3678, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 5 Reached - Pause Waypoint'),
(3678, 0, 9, 10, 61, 0, 100, 0, 5, 3678, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 5 Reached - Say Line 2'),
(3678, 0, 10, 11, 61, 0, 100, 0, 5, 3678, 0, 0, 0, 12, 3636, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -73.57, 214.39, -93.66, 2.34, 'Disciple of Naralex - On Waypoint 5 Reached - Summon Creature \'Deviate Ravager\''),
(3678, 0, 11, 0, 61, 0, 100, 0, 5, 3678, 0, 0, 0, 12, 3636, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -70.85, 211.6, -93.49, 2.34, 'Disciple of Naralex - On Waypoint 5 Reached - Summon Creature \'Deviate Ravager\''),
(3678, 0, 12, 0, 56, 0, 100, 0, 5, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint Resumed - Say Line 3'),
(3678, 0, 13, 14, 40, 0, 100, 0, 12, 3678, 0, 0, 0, 54, 32500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 12 Reached - Pause Waypoint'),
(3678, 0, 14, 15, 61, 0, 100, 0, 12, 3678, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 12 Reached - Say Line 4'),
(3678, 0, 15, 16, 61, 0, 100, 0, 12, 3678, 0, 0, 0, 67, 1, 10000, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 12 Reached - Create Timed Event'),
(3678, 0, 16, 33, 61, 0, 100, 0, 12, 3678, 0, 0, 0, 11, 6270, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 12 Reached - Cast \'Serpentine Cleansing\''),
(3678, 0, 17, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 107, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Timed Event 1 Triggered - Summon Creature Group 1'),
(3678, 0, 18, 34, 56, 0, 100, 0, 12, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint Resumed - Say Line 5'),
(3678, 0, 19, 20, 40, 0, 100, 0, 20, 3678, 0, 0, 0, 54, 7000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 20 Reached - Pause Waypoint'),
(3678, 0, 20, 0, 61, 0, 100, 0, 20, 3678, 0, 0, 0, 67, 2, 500, 500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 20 Reached - Create Timed Event'),
(3678, 0, 21, 22, 40, 0, 100, 0, 25, 3678, 0, 0, 0, 54, 1800000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 25 Reached - Pause Waypoint'),
(3678, 0, 22, 0, 61, 0, 100, 0, 25, 3678, 0, 0, 0, 80, 367800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 25 Reached - Run Script'),
(3678, 0, 23, 0, 17, 0, 100, 0, 0, 0, 0, 0, 0, 201, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 115.76, 236.51, -96, 0, 'Disciple of Naralex - On Summoned Unit - Move to pos target 0'),
(3678, 0, 24, 25, 38, 0, 100, 0, 2, 2, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Data Set 2 2 - Set Fly Off'),
(3678, 0, 25, 0, 61, 0, 100, 0, 2, 2, 0, 0, 0, 53, 0, 3679, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Data Set 2 2 - Start Waypoint'),
(3678, 0, 26, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Reset - Set Visibility Off'),
(3678, 0, 27, 28, 59, 0, 100, 0, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Timed Event 2 Triggered - Set Orientation 0'),
(3678, 0, 28, 0, 61, 0, 100, 0, 2, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Timed Event 2 Triggered - Say Line 6'),
(3678, 0, 29, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Respawn - Set Visibility On'),
(3678, 0, 30, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Respawn - Set Reactstate Passive'),
(3678, 0, 31, 0, 77, 0, 100, 0, 2, 6, 0, 0, 0, 12, 3654, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 151.27, 252.26, -102.82, 3.38, 'Missing comment for event_type 77 - Summon Creature \'Mutanus the Devourer\''),
(3678, 0, 32, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 63, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Respawn - Missing comment for action_type 63'),
(3678, 0, 33, 0, 61, 0, 100, 0, 12, 3678, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 12 Reached - Set Reactstate Passive'),
(3678, 0, 34, 0, 61, 0, 100, 0, 12, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint Resumed - Set Reactstate Aggressive'),
(3678, 0, 35, 0, 77, 0, 100, 0, 1, 3, 0, 0, 0, 107, 2, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing comment for event_type 77 - Summon Creature Group 2'),
(3678, 0, 36, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Respawn - Missing comment for action_type 63');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 367800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(367800, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 7'),
(367800, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 8'),
(367800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 6271, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Disciple of Naralex - Actionlist - Cast \'Naralex`s Awakening\'"),
(367800, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 143.57, 218.98, -102.9, 2.37, 'Disciple of Naralex - Actionlist - Summon Creature \'Deviate Moccasin\''),
(367800, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 132.35, 268, -102.5, 4.144, 'Disciple of Naralex - Actionlist - Summon Creature \'Deviate Moccasin\''),
(367800, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 0'),
(367800, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 94.86, 265.23, -102.9, 5.42, 'Disciple of Naralex - Actionlist - Summon Creature \'Deviate Moccasin\''),
(367800, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 1'),
(367800, 9, 15, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 2');

DELETE FROM `creature_summon_groups` WHERE `summonerId`=3678 AND `summonerType`=0 AND `groupId`=2 AND `entry`=5763;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES 
(3678, 0, 2, 5763, 107.55, 276.57, -102.4, 4.92, 4, 60000),
(3678, 0, 2, 5763, 150.11, 225.36, -102.9, 2.68, 4, 60000),
(3678, 0, 2, 5763, 149.14, 252.73, -102.62, 3.5, 4, 60000),
(3678, 0, 2, 5763, 143.57, 218.98, -102.9, 2.37, 4, 60000),
(3678, 0, 2, 5763, 137.94, 262.89, -102.85, 3.99, 4, 60000),
(3678, 0, 2, 5763, 143.57, 218.98, -102.9, 2.37, 4, 60000);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5762;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5762) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5762, 0, 0, 0, 1, 0, 100, 257, 3000, 3000, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deviate Moccasin - Out of Combat - Set In Combat With Zone (No Repeat)'),
(5762, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 11, 3678, 500, 1, 0, 0, 0, 0, 0, 'Deviate Moccasin - On Just Died - Missing comment for action_type 63');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_01_01' WHERE sql_rev = '1625066362619921400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
