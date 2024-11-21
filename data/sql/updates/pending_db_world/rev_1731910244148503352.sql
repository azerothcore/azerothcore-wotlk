-- Erratic Sentry
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24972;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24972);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24972, 0, 0, 0, 1, 0, 100, 512, 60000, 90000, 60000, 90000, 0, 0, 11, 45014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - Out of Combat - Cast \'Capacitor Overload\''),
(24972, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 0, 11, 33688, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - In Combat - Cast \'Crystal Strike\''),
(24972, 0, 2, 5, 0, 0, 100, 0, 8000, 15000, 8000, 15000, 0, 0, 11, 45336, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - In Combat - Cast \'Electrical Overload\''),
(24972, 0, 3, 0, 0, 0, 100, 0, 12000, 20000, 12000, 20000, 0, 0, 11, 35892, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - In Combat - Cast \'Suppression\''),
(24972, 0, 4, 0, 8, 0, 100, 512, 44997, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - On Spellhit \'Converting Sentry\' - Despawn Instant'),
(24972, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - In Combat - Say Line 0');

-- Converted Sentry
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24981;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24981);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24981, 0, 0, 1, 54, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Converted Sentry - On Just Summoned - Say Line 0 (No Repeat)'),
(24981, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 45009, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Converted Sentry - On Just Summoned - Cast \'Converted Sentry Credit\' (No Repeat)'),
(24981, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Converted Sentry - On Just Summoned - Start Random Movement (No Repeat)'),
(24981, 0, 3, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 7500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Converted Sentry - On Just Summoned - Despawn In 7500 ms (No Repeat)');
