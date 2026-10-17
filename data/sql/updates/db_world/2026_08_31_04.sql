-- DB update 2026_08_31_03 -> 2026_08_31_04

-- Added Rows 0 and 4 and updated comments for rows 1, 2 and 3.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33572;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33572);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33572, 0, 0, 0, 1, 0, 100, 1, 4000, 4000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - Out of Combat - Despawn Instant (No Repeat)'),
(33572, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 0, 0, 11, 57780, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - In Combat - Cast \'Lightning Bolt\''),
(33572, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 5000, 6000, 0, 0, 11, 50370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - In Combat - Cast \'Sunder Armor\''),
(33572, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 34, 700, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - On Just Died - Set Instance Data 700 to 1 (Dwarfageddon Achievement)'),
(33572, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steelforged Defender - On Evade - Set Home Position');
