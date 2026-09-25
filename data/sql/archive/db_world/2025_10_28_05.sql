-- DB update 2025_10_28_04 -> 2025_10_28_05
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27971;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27971);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27971, 0, 0, 0, 0, 0, 100, 2, 12000, 18000, 12000, 18000, 0, 0, 11, 51842, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Unrelenting Construct - In Combat - Cast \'Charge\' (No Repeat) (Dungeon/Normal)'),
(27971, 0, 1, 0, 0, 0, 100, 4, 12000, 18000, 12000, 18000, 0, 0, 11, 59040, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Unrelenting Construct - In Combat - Cast \'Charge\' (No Repeat) (Dungeon/Heroic)'),
(27971, 0, 2, 0, 0, 0, 100, 2, 4000, 7000, 9000, 16000, 0, 0, 11, 51491, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unrelenting Construct - In Combat - Cast \'Unrelenting Strike\' (No Repeat) (Dungeon/Normal)'),
(27971, 0, 3, 0, 0, 0, 100, 4, 4000, 7000, 9000, 16000, 0, 0, 11, 59039, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unrelenting Construct - In Combat - Cast \'Unrelenting Strike\' (No Repeat) (Dungeon/Heroic)'),
(27971, 0, 4, 6, 2, 0, 100, 515, 0, 25, 0, 0, 0, 0, 11, 51832, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unrelenting Construct - Between 0-25% Health - Cast \'Short Circuit\' (No Repeat) (Dungeon)'),
(27971, 0, 5, 6, 2, 0, 100, 517, 0, 25, 0, 0, 0, 0, 11, 61513, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unrelenting Construct - Between 0-25% Health - Cast \'Short Circuit\' (No Repeat) (Dungeon)'),
(27971, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 3500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unrelenting Construct - Die from \'Short Circuit\' (Dungeon)'),
(27971, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unrelenting Construct - Set State Passive while waiting death (Dungeon)');
