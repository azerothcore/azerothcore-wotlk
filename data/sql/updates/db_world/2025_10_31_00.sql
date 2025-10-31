-- DB update 2025_10_30_01 -> 2025_10_31_00
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27966;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27966) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27966, 0, 0, 0, 0, 0, 100, 7, 6000, 14000, 20000, 23000, 0, 0, 11, 51507, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Controller - In Combat - Cast \'Summon Shardling\' (No Repeat) (Dungeon)'),
(27966, 0, 1, 0, 0, 0, 100, 6, 5000, 10000, 17000, 25000, 0, 0, 11, 51503, 128, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Controller - In Combat - Cast \'Domination\' (Dungeon)'),
(27966, 0, 2, 0, 16, 0, 100, 6, 51805, 15, 14000, 17000, 0, 0, 11, 51805, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Controller - On Friendly Unit Missing Buff \'Crystalline Growth\' - Cast \'Crystalline Growth\' (Dungeon)');
