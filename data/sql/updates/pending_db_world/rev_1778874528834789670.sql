-- Increase range to 40 yards
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28018) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28018, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 28006, 40, 0, 0, 0, 0, 0, 0, 'Thiassi the Lightning Bringer - On Death - remove unitflag from target');

-- Reset -> JustSummoned
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28006) AND (`source_type` = 0) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28006, 0, 5, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50494, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Just Summoned - Cast \'Shroud of Lightning\'');

-- Despawn on Evade
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28006) AND (`source_type` = 0) AND (`id` IN (7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28006, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Evade - Despawn Instant');
