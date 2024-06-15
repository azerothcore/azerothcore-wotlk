-- DB update 2022_08_01_16 -> 2022_08_01_17
--
DELETE FROM `creature_text` WHERE `CreatureID` = 15320 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration` ,`Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15320, 0, 0, '%s counterattacks with retaliation.', 16, 0, 100, 0, 0, 0, 11018, 0, 'Hive\'Zara Soldier - On Retaliation');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15320) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15320, 0, 0, 2, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 22857, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Soldier - Between 0-30% Health - Cast \'Retaliation\' (No Repeat)'),
(15320, 0, 1, 0, 9, 0, 100, 0, 0, 30, 10000, 18200, 0, 11, 25497, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Soldier - Within 0-30 Range - Cast \'Venom Spit\''),
(15320, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Soldier - Between 0-30% Health - Say Line 0 (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15344;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15344) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15344, 0, 0, 0, 0, 0, 100, 0, 4850, 18250, 4850, 18250, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Swarmguard Needler - In Combat - Cast \'Cleave\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15387) AND (`source_type` = 0) AND (`id` IN (2,3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15387, 0, 2, 0, 0, 0, 100, 0, 3600, 14600, 3600, 14600, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Warrior - In Combat - Cast \'Uppercut\''),
(15387, 0, 3, 0, 0, 0, 100, 0, 40000, 70000, 40000, 70000, 0, 11, 15588, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Warrior - In Combat - Cast \'Thunderclap\'');
