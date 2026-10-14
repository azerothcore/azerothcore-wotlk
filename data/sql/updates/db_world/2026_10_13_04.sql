-- DB update 2026_10_13_03 -> 2026_10_13_04
--
DELETE FROM `creature_text` WHERE `CreatureID` = 21195;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21195, 0, 0, '%s starts to dig.', 16, 0, 100, 0, 0, 0, 18876, 0, 'Domesticated Felboar'),
(21195, 1, 0, '%s squeals with glee at its discovery.', 16, 0, 100, 0, 0, 0, 18877, 0, 'Domesticated Felboar');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21195) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21195, 0, 0, 0, 34, 0, 100, 512, 8, 1, 0, 0, 0, 0, 80, 2119500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - On Reached Point 1 - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2119500) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2119500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - Actionlist - Set Rooted On'),
(2119500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - Actionlist - Cast \'Special Unarmed\''),
(2119500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - Actionlist - Say Line 0'),
(2119500, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 33334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - Actionlist - Cast \'Special Unarmed\''),
(2119500, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 21347, 5, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - Actionlist - Set Data 1 1 (Shadowmoon Valley Tuber Node)'),
(2119500, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - Actionlist - Say Line 1'),
(2119500, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - Actionlist - Set Rooted Off'),
(2119500, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Domesticated Felboar - Actionlist - Evade');
