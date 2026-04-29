-- DB update 2026_04_29_00 -> 2026_04_29_01

-- Add CastFlags 32 and update comments.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30202;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30202, 0, 0, 1, 8, 0, 100, 1, 57806, 0, 0, 0, 0, 0, 11, 57808, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Crusader - On Spellhit \'Sprinkle Holy Water\' - Cast \'Freed Crusader Soul\' (No Repeat)'),
(30202, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Crusader - On Spellhit \'Sprinkle Holy Water\' - Despawn Instant (No Repeat)'),
(30202, 0, 2, 0, 0, 0, 100, 0, 1000, 5000, 6500, 12000, 0, 0, 11, 32674, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Crusader - In Combat - Cast \'Avenger`s Shield\''),
(30202, 0, 3, 0, 0, 0, 100, 0, 7000, 12000, 8500, 20000, 0, 0, 11, 58154, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Crusader - In Combat - Cast \'Hammer of Injustice\''),
(30202, 0, 4, 0, 2, 0, 100, 0, 10, 90, 7000, 15000, 0, 0, 11, 58153, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Crusader - Between 10-90% Health - Cast \'Unholy Light\''),
(30202, 0, 5, 0, 14, 0, 100, 0, 1000, 20, 8000, 20000, 0, 0, 11, 58153, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Crusader - Friendly At 1000 Health - Cast \'Unholy Light\'');
