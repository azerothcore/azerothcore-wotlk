-- DB update 2025_06_21_02 -> 2025_06_21_03

-- Defender of the Light (update comments and edit Holy Wrath cd).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29174;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29174);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29174, 0, 0, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 53625, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Defender of the Light - In Combat - Cast \'Heroic Leap\''),
(29174, 0, 1, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 53643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Defender of the Light - In Combat - Cast \'Holy Strike\''),
(29174, 0, 2, 0, 0, 0, 100, 0, 10000, 30000, 45000, 60000, 0, 0, 11, 53638, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Defender of the Light - In Combat - Cast \'Holy Wrath\''),
(29174, 0, 3, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 53629, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Defender of the Light - In Combat - Cast \'Uppercut\''),
(29174, 0, 4, 0, 74, 0, 100, 0, 0, 0, 5000, 10000, 20, 0, 11, 29427, 1, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'Defender of the Light - On Friendly Below 20% Health - Cast \'Holy Light\'');
