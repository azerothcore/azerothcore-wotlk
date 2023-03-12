-- DB update 2023_03_07_08 -> 2023_03_07_09
-- Avatar of Sathal
DELETE FROM `creature_text` WHERE `CreatureID`=21925;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21925, 0, 0, 'Feel my wrath, $r scum!  You will not get away with this!', 14, 0, 100, 0, 0, 0, 19598, 0, 'Avatar of Sathal SAY_AGGRO');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21925);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21925, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Sathal - On Just Summoned - Start Attacking'),
(21925, 0, 1, 0, 61, 0, 100, 257, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Sathal - On Just Summoned - Say Line 0 (No Repeat/Reset)'),
(21925, 0, 2, 0, 0, 0, 100, 0, 2300, 3000, 8700, 9000, 0, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Sathal - In Combat - Cast \'Shadow Bolt\''),
(21925, 0, 3, 0, 0, 0, 100, 0, 6000, 12000, 12000, 17000, 0, 11, 34017, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Sathal - In Combat - Cast \'Rain of Chaos\'');
