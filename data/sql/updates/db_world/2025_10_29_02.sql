-- DB update 2025_10_29_01 -> 2025_10_29_02
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28580;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28580);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28580, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2300, 5000, 0, 0, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - In Combat - Cast \'Shoot\' (Normal Dungeon)'),
(28580, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2300, 5000, 0, 0, 11, 61515, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - In Combat - Cast \'Shoot\' (Heroic Dungeon)'),
(28580, 0, 2, 0, 0, 0, 100, 2, 9000, 12000, 15000, 20000, 0, 0, 11, 52754, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - In Combat - Cast \'Impact Shot\' (Normal Dungeon)'),
(28580, 0, 3, 0, 0, 0, 100, 2, 7000, 12000, 12000, 18000, 0, 0, 11, 52755, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - In Combat - Cast \'Impact Multi-Shot\' (Normal Dungeon)'),
(28580, 0, 4, 0, 0, 0, 100, 4, 9000, 12000, 15000, 20000, 0, 0, 11, 59148, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - In Combat - Cast \'Impact Shot\' (Heroic Dungeon)'),
(28580, 0, 5, 0, 0, 0, 100, 4, 7000, 12000, 12000, 18000, 0, 0, 11, 59147, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - In Combat - Cast \'Impact Multi-Shot\' (Heroic Dungeon)'),
(28580, 0, 6, 0, 9, 0, 100, 4, 0, 0, 6000, 9000, 0, 5, 11, 61507, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - Within 0-5 Range - Cast \'Disengage\' (Heroic Dungeon)'),
(28580, 0, 7, 8, 9, 0, 100, 2, 5000, 8000, 5000, 8000, 0, 5, 122, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - Within 0-5 Range - Flee (Normal Dungeon)'),
(28580, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Skycaller - Within 0-0 Range - Disable Combat Movement (Normal Dungeon)');
