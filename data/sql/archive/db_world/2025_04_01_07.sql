-- DB update 2025_04_01_06 -> 2025_04_01_07

-- Set SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25214;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25214);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25214, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 30, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow Image - On Just Summoned - Set Random Phase (1, 2)'),
(25214, 0, 1, 0, 0, 3, 100, 513, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow Image - In Combat - Stop Attacking (Phases 1 & 2) (No Repeat)'),
(25214, 0, 2, 0, 0, 1, 100, 0, 1000, 2000, 3000, 3000, 0, 0, 11, 45271, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow Image - In Combat - Cast \'Dark Strike\' (Phase 1)'),
(25214, 0, 3, 0, 0, 2, 100, 1, 7000, 10000, 0, 0, 0, 0, 11, 45270, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Shadow Image - In Combat - Cast \'Shadowfury\' (Phase 2) (No Repeat)');
