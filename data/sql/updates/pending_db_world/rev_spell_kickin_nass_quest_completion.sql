
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28521) AND (`source_type` = 0) AND (`id` IN (11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28521, 0, 11, 5, 8, 0, 100, 0, 51910, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nass - On Spellhit \'Kickin` Nass: Quest Completion\' - Despawn Instant');

DELETE FROM `spell_script_names` WHERE `spell_id` = 51910;
