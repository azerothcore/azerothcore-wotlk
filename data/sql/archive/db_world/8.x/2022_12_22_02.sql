-- DB update 2022_12_22_01 -> 2022_12_22_02
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17309;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17309);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17309, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 7000, 10000, 0, 11, 14032, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast \'Shadow Word: Pain\''),
(17309, 0, 1, 0, 38, 1, 100, 0, 1, 1, 10000, 15000, 0, 11, 8362, 0, 0, 0, 0, 0, 19, 17306, 40, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - On Data Set 1 1 - Cast \'Renew\' (Phase 1)'),
(17309, 0, 2, 0, 0, 1, 100, 2, 0, 3000, 3000, 3000, 0, 11, 12039, 0, 0, 0, 0, 0, 19, 17306, 40, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast \'Heal\' (Phase 1) (Normal Dungeon)'),
(17309, 0, 3, 0, 0, 1, 100, 4, 0, 3000, 3000, 3000, 0, 11, 30643, 0, 0, 0, 0, 0, 19, 17306, 40, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast \'Heal\' (Phase 1) (Heroic Dungeon)'),
(17309, 0, 4, 0, 38, 0, 100, 512, 17309, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - On Data Set 17309 0 - Set Event Phase 1'),
(17309, 0, 5, 0, 2, 0, 100, 0, 1, 25, 10000, 15000, 0, 11, 8362, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - Between 1-25% Health - Cast \'Renew\''),
(17309, 0, 6, 0, 2, 0, 100, 0, 1, 25, 10000, 15000, 0, 45, 1, 1, 0, 0, 0, 0, 11, 17309, 40, 1, 0, 0, 0, 0, 0, 'Hellfire Watcher - Between 1-25% Health - Set Data 1 1'),
(17309, 0, 7, 0, 2, 0, 100, 0, 26, 100, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 11, 17309, 40, 1, 0, 0, 0, 0, 0, 'Hellfire Watcher - Between 26-100% Health - Set Data 1 2'),
(17309, 0, 8, 0, 38, 0, 100, 2, 1, 1, 10000, 15000, 0, 11, 12039, 0, 0, 0, 0, 0, 11, 17309, 40, 1, 0, 0, 0, 0, 0, 'Hellfire Watcher - On Data Set 1 1 - Cast \'Heal\' (Normal Dungeon)'),
(17309, 0, 9, 0, 38, 0, 100, 4, 1, 1, 10000, 15000, 0, 11, 12039, 0, 0, 0, 0, 0, 11, 17309, 40, 1, 0, 0, 0, 0, 0, 'Hellfire Watcher - On Data Set 1 1 - Cast \'Heal\' (Heroic Dungeon)');
