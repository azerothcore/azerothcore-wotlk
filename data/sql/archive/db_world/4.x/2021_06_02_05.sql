-- DB update 2021_06_02_04 -> 2021_06_02_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_02_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_02_04 2021_06_02_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622046406344372400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622046406344372400');

UPDATE `creature_template` SET `speed_walk` = 0.9, `speed_run` = 1, `MovementType` = 0, `HealthModifier` = 3, `ManaModifier` = 3, `ArmorModifier` = 10, `unit_flags` = 0 WHERE (`entry` = 3678);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3678;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3678);
INSERT INTO `smart_scripts` VALUES
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
(3678, 0, 16, 0, 61, 0, 100, 0, 12, 3678, 0, 0, 0, 11, 6270, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 12 Reached - Cast \'Serpentine Cleansing\''),
(3678, 0, 17, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 107, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Timed Event 1 Triggered - Summon Creature Group 1'),
(3678, 0, 18, 0, 56, 0, 100, 0, 12, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint Resumed - Say Line 5'),
(3678, 0, 19, 20, 40, 0, 100, 0, 20, 3678, 0, 0, 0, 54, 7000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 20 Reached - Pause Waypoint'),
(3678, 0, 20, 0, 61, 0, 100, 0, 20, 3678, 0, 0, 0, 67, 2, 500, 500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 20 Reached - Create Timed Event'),
(3678, 0, 21, 22, 40, 0, 100, 0, 25, 3678, 0, 0, 0, 54, 1800000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 25 Reached - Pause Waypoint'),
(3678, 0, 22, 0, 61, 0, 100, 0, 25, 3678, 0, 0, 0, 80, 367800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Waypoint 25 Reached - Run Script'),
(3678, 0, 23, 0, 17, 0, 100, 0, 0, 0, 0, 0, 0, 201, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 115.76, 236.51, -96, 0, 'Disciple of Naralex - On Summoned Unit - Move to pos target 0'),
(3678, 0, 24, 25, 38, 0, 100, 0, 2, 2, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Data Set 2 2 - Set Fly Off'),
(3678, 0, 25, 0, 61, 0, 100, 0, 2, 2, 0, 0, 0, 53, 1, 3679, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Data Set 2 2 - Start Waypoint'),
(3678, 0, 26, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Reset - Set Visibility Off'),
(3678, 0, 27, 28, 59, 0, 100, 0, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Timed Event 2 Triggered - Set Orientation 0'),
(3678, 0, 28, 0, 61, 0, 100, 0, 2, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Timed Event 2 Triggered - Say Line 6'),
(3678, 0, 29, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Respawn - Set Visibility On'),
(3678, 0, 30, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Respawn - Set Reactstate Passive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 367800);
INSERT INTO `smart_scripts` VALUES
(367800, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 7'),
(367800, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 8'),
(367800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 6271, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Cast \'Naralex`s Awakening\''),
(367800, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 143.57, 218.98, -102.9, 2.37, 'Disciple of Naralex - Actionlist - Summon Creature \'Deviate Moccasin\''),
(367800, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 132.35, 268, -102.5, 4.144, 'Disciple of Naralex - Actionlist - Summon Creature \'Deviate Moccasin\''),
(367800, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 0'),
(367800, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 94.86, 265.23, -102.9, 5.42, 'Disciple of Naralex - Actionlist - Summon Creature \'Deviate Moccasin\''),
(367800, 9, 7, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 143.57, 218.98, -102.9, 2.37, 'Disciple of Naralex - Actionlist - Summon Creature \'Nightmare Ectoplasm\''),
(367800, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 1'),
(367800, 9, 9, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 107.55, 276.57, -102.4, 4.92, 'Disciple of Naralex - Actionlist - Summon Creature \'Nightmare Ectoplasm\''),
(367800, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 134.44, 205.36, -102.65, 2.03, 'Disciple of Naralex - Actionlist - Summon Creature \'Nightmare Ectoplasm\''),
(367800, 9, 11, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 150.11, 225.36, -102.9, 2.68, 'Disciple of Naralex - Actionlist - Summon Creature \'Nightmare Ectoplasm\''),
(367800, 9, 12, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 149.14, 252.73, -102.62, 3.5, 'Disciple of Naralex - Actionlist - Summon Creature \'Nightmare Ectoplasm\''),
(367800, 9, 13, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 143.57, 218.98, -102.9, 2.37, 'Disciple of Naralex - Actionlist - Summon Creature \'Nightmare Ectoplasm\''),
(367800, 9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 137.94, 262.89, -102.85, 3.99, 'Disciple of Naralex - Actionlist - Summon Creature \'Nightmare Ectoplasm\''),
(367800, 9, 15, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Actionlist - Say Line 2'),
(367800, 9, 16, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 12, 3654, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 151.27, 252.26, -102.82, 3.38, 'Disciple of Naralex - Actionlist - Summon Creature \'Mutanus the Devourer\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_02_05' WHERE sql_rev = '1622046406344372400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
