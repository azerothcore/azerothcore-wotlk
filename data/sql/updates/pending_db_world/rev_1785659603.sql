
-- Remove ScriptName & set SAI.
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` = 29076;

-- Set General SAI.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29076);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29076, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - On Just Summoned - Set Reactstate Passive'),
(29076, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - On Just Summoned - Run Script'),
(29076, 0, 2, 0, 34, 0, 100, 0, 8, 15, 0, 0, 0, 0, 80, 2907601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - On Reached Point 15 - Run Script'),
(29076, 0, 3, 4, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 206, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - On Aggro - Dismount'),
(29076, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - On Aggro - Set Reactstate Aggressive'),
(29076, 0, 5, 6, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 207, 2, 191144, 200, 0, 0, 0, 0, 0, 'Scarlet Courier - On Evade - Despawn Instant'),
(29076, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - On Evade - Despawn Instant'),
(29076, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 207, 2, 191144, 200, 0, 0, 0, 0, 0, 'Scarlet Courier - On Just Died - Despawn Instant');

-- Set Action Lists.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2907600, 2907601));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2907600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Set Run Off'),
(2907600, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Say Line 0'),
(2907600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 15, 0, 0, 2, 0, 0, 207, 2, 191144, 200, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Move To Owner Summoned GO'),
(2907601, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Set Reactstate Aggressive'),
(2907601, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 53061, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Remove Aura \'Cover\''),
(2907601, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 206, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Dismount'),
(2907601, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Say Line 1'),
(2907601, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 207, 2, 191144, 200, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Despawn In 1000 ms'),
(2907601, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Courier - Actionlist - Start Attacking');
