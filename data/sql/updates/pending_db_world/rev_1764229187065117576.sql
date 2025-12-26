-- Fix for issue #23784: Rhydian should spawn portal to Shattrath when quest 13081 "The Will of the Naaru" is accepted

-- Enable SmartAI for Rhydian and Tirion
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (30656, 31044);

-- Add Rhydian's text
DELETE FROM `creature_text` WHERE `CreatureID` = 30656 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30656, 0, 0, 'Hail. I could not help but overhear your conversation. Please allow me to lend some assistance.', 12, 0, 100, 0, 0, 0, 0, 0, 'Rhydian - Quest 13081');

-- Tirion: On quest 13081 accepted, SetData on Rhydian
DELETE FROM `smart_scripts` WHERE `entryorguid` = 31044 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31044, 0, 0, 0, 19, 0, 100, 0, 13081, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 30656, 50, 0, 0, 0, 0, 0, 0, 'Highlord Tirion Fordring - On Quest 13081 Accepted - SetData on Rhydian');

-- Rhydian: On DataSet, run first action list (walk to point)
-- On MovementInform PointID 1, run second action list (say line, cast portal, walk back)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30656 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30656, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 3065600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhydian - On DataSet - Run Timed Action List'),
(30656, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 3065601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhydian - On MovementInform Point 1 - Run Timed Action List');

-- Rhydian action list 1: set walk and move to point
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3065600, 3065601) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3065600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhydian - Timed - Set Walk'),
(3065600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6417.89, 431.21, 511.33, 0, 'Rhydian - Timed - Move To Point'),
-- Rhydian action list 2: say line, cast portal, walk back
(3065601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhydian - Timed - Say Text'),
(3065601, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 11, 57676, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhydian - Timed - Cast Portal to Shattrath'),
(3065601, 9, 2, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6409.12, 422.382, 511.348, 0.628319, 'Rhydian - Timed - Walk Back To Home'),
(3065601, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhydian - Timed - Set Run');
