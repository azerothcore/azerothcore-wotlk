-- DB update 2025_01_04_00 -> 2025_01_04_01
-- Argah smart ai
SET @ENTRY := 27440;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` IN (@ENTRY * 100, @ENTRY * 100 + 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 60, 0, 100, 0, 0, 0, 120000, 330000, 0, 0, 87, 2744000, 2744001, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argah - On Update - Run Random Script'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argah - Actionlist - Say Line 0'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27441, 5, 0, 0, 0, 0, 0, 'Closest alive creature Sagai (27441) in 5 yards: Talk 0 to invoker'),
(@ENTRY * 100, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argah - Actionlist - Say Line 1'),
(@ENTRY * 100, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argah - Actionlist - Say Line 2'),
(@ENTRY * 100, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27441, 5, 0, 0, 0, 0, 0, 'Closest alive creature Sagai (27441) in 5 yards: Talk 1 to invoker'),
(@ENTRY * 100 + 1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argah - Actionlist - Say Line 3'),
(@ENTRY * 100 + 1, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 27441, 5, 0, 0, 0, 0, 0, 'Closest alive creature Sagai (27441) in 5 yards: Talk 2 to invoker');

DELETE FROM `creature_text` WHERE `CreatureID` = 27440;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27440, 0, 0, 'The nerubian siege outside is chilling, Sagai. There seems to be no end to them.', 12, 0, 100, 1, 0, 0, 26618, 0, 'Argah'),
(27440, 1, 0, 'That\'s right... I recovered munitions from the quarry just yesterday for that purpose.', 12, 0, 100, 1, 0, 0, 26620, 0, 'Argah'),
(27440, 2, 0, 'I hope the charges are set soon. Everyone could use a respite.', 12, 0, 100, 1, 0, 0, 26621, 0, 'Argah'),
(27440, 3, 0, 'Saurfang is here, Sagai! Saurfang! The brother of Broxigar himself, here to aid our efforts!', 12, 0, 100, 1, 0, 0, 26623, 0, 'Argah');

DELETE FROM `creature_text` WHERE `CreatureID` = 27441;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27441, 0, 0, 'Yah. It be dem sinkholes. You see dem? Dere be talk of blowin\' dem up, cavin\' dem in.', 12, 0, 100, 1, 0, 0, 26619, 0, 'Sagai'),
(27441, 1, 0, 'You got dat right.', 12, 0, 100, 1, 0, 0, 26622, 0, 'Sagai'),
(27441, 2, 0, 'Yah. Hellscream, he be a fierce one, but too eager to prove himself, I be thinkin\'. It be good Saurfang be here, for sure.', 12, 0, 100, 1, 0, 0, 26688, 0, 'Sagai');
