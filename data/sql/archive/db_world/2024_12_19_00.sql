-- DB update 2024_12_18_00 -> 2024_12_19_00
 -- Archmage Mordent Evenshade smart ai
SET @ENTRY := 36479;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 540000, 540000, 540000, 540000, 0, 0, 87, 3647900, 3647901, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Out of Combat - Run Random Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3647900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3647900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 0'),
(3647900, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 36481, 10, 0, 0, 0, 0, 0, 0, ' Closest alive creature Sentinel Stillbough (36481) in 10 yards: Talk 0 to invoker'),
(3647900, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Self: Talk 1 to invoker'),
(3647900, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 36481, 10, 0, 0, 0, 0, 0, 0, 'Closest alive creature Sentinel Stillbough (36481) in 10 yards: Talk 1 to invoker'),
(3647900, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 2'),
(3647900, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 36481, 10, 0, 0, 0, 0, 0, 0, 'Closest alive creature Sentinel Stillbough (36481) in 10 yards: Talk 2 to invoker'),
(3647900, 9, 6, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 3'),
(3647900, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 4'),
(3647900, 9, 8, 0, 0, 0, 100, 0, 13000, 13000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 5'),
(3647900, 9, 9, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 6');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3647901);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3647901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 7'),
(3647901, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 36481, 10, 0, 0, 0, 0, 0, 0, 'Closest alive creature Sentinel Stillbough (36481) in 10 yards: Talk 3 to invoker'),
(3647901, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 8'),
(3647901, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 36481, 10, 0, 0, 0, 0, 0, 0, 'Closest alive creature Sentinel Stillbough (36481) in 10 yards: Talk 4 to invoker'),
(3647901, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 9'),
(3647901, 9, 5, 0, 0, 0, 100, 0, 13000, 13000, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 10'),
(3647901, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 11'),
(3647901, 9, 7, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 36481, 10, 0, 0, 0, 0, 0, 0, 'Closest alive creature Sentinel Stillbough (36481) in 10 yards: Talk 5 to invoker'),
(3647901, 9, 8, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Mordent Evenshade - Actionlist - Say Line 12'),
(3647901, 9, 9, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 36481, 10, 0, 0, 0, 0, 0, 0, 'Closest alive creature Sentinel Stillbough (36481) in 10 yards: Talk 6 to invoker');
