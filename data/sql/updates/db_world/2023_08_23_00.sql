-- DB update 2023_08_21_01 -> 2023_08_23_00
-- Giselda the Crone
DELETE FROM `creature_text` WHERE `CreatureID` = 18391;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18391, 0, 0, 'Your blood will coat the walls of Kil\'sorrow!', 12, 0, 100, 0, 0, 0, 16062, 0, 'Giselda the Crone - Say on Transformation');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18391);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18391, 0, 0, 0, 0, 0, 100, 0, 4500, 8500, 3600, 14500, 0, 0, 11, 32000, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Giselda the Crone - In Combat - Cast \'Mind Sear\''),
(18391, 0, 1, 2, 2, 0, 100, 1, 0, 65, 0, 0, 0, 0, 11, 33316, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Giselda the Crone - Between 0-65% Health - Cast \'Giselda Transform DND\' (No Repeat)'),
(18391, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Giselda the Crone - Between 0-65% Health - Say Line 0 (No Repeat)');

UPDATE `creature_template_addon` SET `auras` = '16592' WHERE (`entry` = 18391);
