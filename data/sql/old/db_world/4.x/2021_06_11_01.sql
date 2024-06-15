-- DB update 2021_06_11_00 -> 2021_06_11_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_11_00 2021_06_11_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622649662516201100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622649662516201100');

-- Add Strahad Farsan text lines
DELETE FROM `creature_text` WHERE `CreatureID` = 6251;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(6251, 0, 0, 'I hope you\'re ready, $n. Follow me.', 12, 0, 100, 0, 0, 0, 2370, 0, 'Strahad Farsan'),
(6251, 1, 0, 'Come, my acolytes. Take the rods of channeling and create the greater summoning circle.', 12, 0, 100, 0, 0, 0, 2374, 0, 'Strahad Farsan');

-- Add path to Strahad Farsan
DELETE FROM `waypoints` WHERE `entry` = 6251;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(6251, 1, -785.912, -3723.26, 40.5153, 'Strahad Farsan'),
(6251, 2, -781.32, -3717.15, 41.597, 'Strahad Farsan'),
(6251, 3, -770.08, -3720.73, 42.45, 'Strahad Farsan'),
(6251, 4, -763.68, -3720.01, 42.24, 'Strahad Farsan'),
(6251, 5, -763.97, -3720.19, 42.25, 'Strahad Farsan'),
(6251, 6, -782.23, -3717.17, 41.57, 'Strahad Farsan'),
(6251, 7, -785.912, -3723.26, 40.5153, 'Strahad Farsan');

-- Add Strahad Farsan SAI for event
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6251;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6251) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6251, 0, 0, 1, 19, 0, 100, 0, 1795, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Quest \'The Binding\' Taken - Say Line 0'),
(6251, 0, 1, 2, 61, 0, 100, 0, 1795, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Quest \'The Binding\' Taken - Set Npc Flag '),
(6251, 0, 2, 0, 61, 0, 100, 0, 1795, 0, 0, 0, 0, 53, 0, 6251, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Quest \'The Binding\' Taken - Start Waypoint'),
(6251, 0, 3, 4, 40, 0, 100, 0, 3, 6251, 0, 0, 0, 80, 625100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Waypoint 3 Reached - Run Script'),
(6251, 0, 4, 0, 61, 0, 100, 0, 3, 6251, 0, 0, 0, 54, 900000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Waypoint 3 Reached - Pause Waypoint'),
(6251, 0, 5, 0, 40, 0, 100, 0, 5, 6251, 0, 0, 0, 54, 120000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Waypoint 5 Reached - Pause Waypoint'),
(6251, 0, 6, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 65, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Data Set 1 1 - Resume Waypoint'),
(6251, 0, 7, 0, 56, 0, 100, 0, 5, 6251, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 13, 0, 0, 10, 0, 0, 0, 0, 0, 'Strahad Farsan - On Waypoint Resumed - Set Data 1 1'),
(6251, 0, 8, 9, 40, 0, 100, 0, 7, 6251, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Waypoint 7 Reached - Set Npc Flags Gossip & Questgiver'),
(6251, 0, 9, 10, 61, 0, 100, 0, 7, 6251, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - On Waypoint 7 Reached - Stop Waypoint'),
(6251, 0, 10, 0, 61, 0, 100, 0, 7, 6251, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.0594, 'Strahad Farsan - On Waypoint 7 Reached - Set Orientation 2.0594');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 625100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(625100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 30540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - Script - Cast \'Summon Visual \''),
(625100, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 28, 30540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - Script - Remove Aura from Spell'),
(625100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - Script - Say Line 1'),
(625100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 92252, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -770.513, -3720.37, 42.461, 5.28547, 'Strahad Farsan - Script - Summon Gameobject'),
(625100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 0, 0, 10, 1, 0, 0, 0, 0, 'Strahad Farsan - Script - Set Data'),
(625100, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad Farsan - Script - Resume WP');

-- Delete summoning circles permanent spawns
DELETE FROM `gameobject` WHERE `id` IN (92252, 92388);

-- Add SAI to both summoning circles
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (92252, 92388);

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (92252, 92388));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(92252, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Strahad\'s Summoning Circle - On Data Set 1 1 - Despawn Instant'),
(92388, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoning Circle - On Data Set 1 1 - Despawn Instant');

SET @MAGAZ = 6252;
SET @FENRICK = 6253;
SET @WYTULA = 6254;
SET @MAGAZT = 625200;
SET @FENRICKT = 625300;
SET @WYTULAT = 625400;

-- Add SAI to the three Acolytes (only one of them will summon the circle)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (@MAGAZ,@FENRICK,@WYTULA);

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (@MAGAZ, @FENRICK, @WYTULA, @MAGAZT, @FENRICKT, @WYTULAT));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@MAGAZ, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, @MAGAZT, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Magaz - On Data Set - Call Script'),
(@FENRICK, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, @FENRICKT, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Fenrick - On Data Set - Call Script'),
(@WYTULA, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, @WYTULAT, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Wytula - On Data Set - Call Script'),
(@MAGAZT, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Magaz - Script - Emote /bow'),
(@MAGAZT, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 11, 8675, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Magaz - Script - Cast \'Warlock Channeling\''),
(@MAGAZT, 9, 2, 0, 0, 0, 100, 0, 7500, 7500, 0, 0, 0, 50, 92388, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -770.513, -3720.37, 42.461, 5.82547, 'Acolyte Magaz - Script - Summon \'Summoning Circle\''),
(@FENRICKT, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Fenrick - Script - Emote /bow'),
(@FENRICKT, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 11, 8675, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Fenrick - Script - Cast \'Warlock Channeling\''),
(@WYTULAT, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Wytula - Script - Emote /bow'),
(@WYTULAT, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 11, 8675, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte Wytula - Script - Cast \'Warlock Channeling\'');

-- Update SAI for Summoned Felhunter
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6268) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6268, 0, 1, 2, 54, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Just Summoned - Cast \'Summon Visual\''),
(6268, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Just Summoned - Start Attacking'),
(6268, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 6251, 0, 60, 0, 0, 0, 0, 0, 'Summoned Felhunter - On Just Died - Set Data 1 1');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_11_01' WHERE sql_rev = '1622649662516201100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
