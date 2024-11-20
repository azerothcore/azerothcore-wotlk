UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24972;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 24972;

INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, 
`event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES
(24972, 0, 0, 0, 1, 0, 100, 768, 60000, 90000, 60000, 90000, 0, 0, 11, 45014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - OOC - Cast Capacitor Overload'),
(24972, 0, 1, 0, 0, 0, 100, 256, 3000, 7000, 3000, 7000, 0, 0, 11, 33688, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - Combat - Cast Crystal Strike'),
(24972, 0, 2, 0, 0, 0, 100, 256, 8000, 15000, 8000, 15000, 0, 0, 11, 45336, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - Combat - Cast Electrical Overload'),
(24972, 0, 3, 0, 0, 0, 100, 256, 12000, 20000, 12000, 20000, 0, 0, 11, 35892, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - Combat - Cast Suppression'),
(24972, 0, 4, 0, 8, 0, 100, 512, 44997, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - On Spellhit (Converting Sentry) - Despawn'),
(24972, 0, 5, 0, 8, 0, 100, 512, 44997, 0, 0, 0, 0, 0, 29, 5, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - On Spellhit (Attuned Crystal Core) - Start Following Player'),
(24972, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Erratic Sentry - After 30 seconds - Despawn');
