--
DELETE FROM `creature_template_addon` WHERE (`entry` = 14682);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(14682, 0, 0, 0, 0, 0, 0, '28126');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14682;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14682) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14682, 0, 0, 1, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sever - Between 0-50% Health - Cast \'Frenzy\' (No Repeat)'),
(14682, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sever - Between 0-50% Health - Say Line 0 (No Repeat)');

DELETE FROM `creature_text` WHERE (`CreatureID` = 14682) AND (`GroupID` IN (0));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14682, 0, 0, '%s goes into a frenzy!', 16, 0, 0, 0, 0, 0, 2384, 0, 'Sever - Say ENRAGE');
