INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643232180075711500');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17853) AND (`source_type` = 0) AND (`id` IN (9));

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17664) AND (`source_type` = 0) AND (`id` IN (12, 23));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17664, 0, 12, 23, 61, 1, 100, 1, 22, 51, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 17853, 30, 0, 0, 0, 0, 0, 0, 'Matis the Cruel - Between 22-51% Health - Set Data 1 1 (Phase 1) (No Repeat)'),
(17664, 0, 23, 13, 61, 1, 100, 1, 22, 51, 0, 0, 0, 11, 31336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Matis the Cruel - Between 22-51% Health - Cast \'Matis Captured DND\' (Phase 1) (No Repeat)');
