-- DB update 2022_05_23_04 -> 2022_05_23_05
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10390;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10390) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10390, 0, 0, 1, 60, 0, 100, 769, 0, 0, 0, 0, 0, 31, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - On Update - Set Phase Random Between 1-3 (No Repeat)'),
(10390, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 211, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - On Update - Flag reset 0 (No Repeat)'),
(10390, 0, 2, 0, 1, 1, 100, 0, 1000, 5000, 600000, 600000, 0, 11, 13787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - Out of Combat - Cast \'Demon Armor\' (Phase 1)'),
(10390, 0, 3, 0, 0, 1, 100, 0, 0, 1000, 3000, 4500, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast \'Shadow Bolt\' (Phase 1)'),
(10390, 0, 4, 0, 0, 2, 100, 0, 5000, 11000, 17000, 24500, 0, 11, 8364, 64, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast \'Blizzard\' (Phase 2)'),
(10390, 0, 5, 0, 0, 2, 100, 0, 0, 1000, 3000, 4500, 0, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast \'Frostbolt\' (Phase 2)'),
(10390, 0, 6, 0, 0, 4, 100, 0, 4000, 11000, 13000, 24500, 0, 11, 11975, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast \'Arcane Explosion\' (Phase 3)'),
(10390, 0, 7, 0, 0, 4, 100, 0, 0, 1000, 2000, 3500, 0, 11, 37361, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast \'Arcane Bolt\' (Phase 3)');
