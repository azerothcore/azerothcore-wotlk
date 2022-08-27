-- DB update 2022_08_01_11 -> 2022_08_01_12
-- 
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11831;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11831);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11831, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - On Aggro - Say Line 0'),
(11831, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 5000, 8000, 0, 11, 24053, 4, 32, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - In Combat - Cast \'Hex\''),
(11831, 0, 2, 0, 0, 0, 100, 0, 1000, 3000, 3000, 5000, 0, 11, 17289, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - In Combat - Cast \'Shadow Shock\''),
(11831, 0, 3, 0, 0, 0, 100, 0, 5000, 15000, 5000, 10000, 0, 11, 24054, 1, 32, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - In Combat - Cast \'Shrink\''),
(11831, 0, 4, 0, 0, 0, 100, 1, 7500, 125000, 0, 0, 0, 11, 24052, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - In Combat - Cast \'Summon Voodoo Spirit\' (No Repeat)');
