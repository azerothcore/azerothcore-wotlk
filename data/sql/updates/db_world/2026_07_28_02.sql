-- DB update 2026_07_28_01 -> 2026_07_28_02
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17681;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17681);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17681, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1768100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Expedition Researcher - On Just Summoned - Run Script'),
(17681, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Expedition Researcher - On Reached Point - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1768100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1768100, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Expedition Researcher - Actionlist - Say Line'),
(1768100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 1, 0, 8, 0, 0, 0, 0, -1592.8748, -10851.978, 57.814125, 0, 'Expedition Researcher - Actionlist - Move To Position');

DELETE FROM `creature_text` WHERE (`CreatureID` = 17681);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17681, 0, 0, 'We\'re free! We\'re free!', 12, 7, 100, 0, 0, 0, 14346, 0, 'Expedition Researcher'),
(17681, 0, 1, 'Woot! Thanks!', 12, 7, 100, 0, 0, 0, 14347, 0, 'Expedition Researcher'),
(17681, 0, 2, 'By the forehead signet of Velen, I am saved!', 12, 7, 100, 0, 0, 0, 14348, 0, 'Expedition Researcher'),
(17681, 0, 3, 'I knew Cornelius wouldn\'t leave us behind!', 12, 7, 100, 0, 0, 0, 14349, 0, 'Expedition Researcher');
