-- DB update 2025_10_25_00 -> 2025_10_25_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27970;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27970);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27970, 0, 0, 0, 0, 0, 100, 2, 3000, 9000, 16000, 16000, 0, 0, 11, 51819, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Construct - In Combat - Cast \'Potent Jolt\' (Normal Dungeon)'),
(27970, 0, 1, 0, 0, 0, 100, 4, 3000, 9000, 16000, 16000, 0, 0, 11, 61514, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Construct - In Combat - Cast \'Potent Jolt\' (Heroic Dungeon)'),
(27970, 0, 2, 0, 0, 0, 100, 6, 4000, 7000, 9000, 12000, 0, 0, 11, 28168, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Construct - In Combat - Cast \'Arcing Smash\' (Dungeon)');
