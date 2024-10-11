-- DB update 2022_05_21_01 -> 2022_05_21_02
-- Horde Scout, fix wrong broadcastTextId(previously 1934, now 1935)
DELETE FROM `creature_text` WHERE `CreatureID` = 11680;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11680, 0, 0, 'Time to die, $c.', 12, 0, 100, 0, 0, 0, 1935, 0, 'Horde Scout');

-- Horde Scout SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11680;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 11680;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11680, 0, 0, 0, 4, 0, 15, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Scout - On Aggro - Say Line 0 (No Repeat)'),
(11680, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Scout - Combat CMC - Cast \'Shoot\''),
(11680, 0, 2, 0, 9, 0, 100, 0, 5, 30, 12000, 15000, 0, 11, 18545, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Scout - Within 5-30 Range - Cast \'Scorpid Sting\''),
(11680, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Scout - 0-15% Health - Flee For Assist (No Repeat)');
