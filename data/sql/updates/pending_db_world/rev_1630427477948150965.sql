INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630427477948150965');

-- Updated the timings and Health values of the Gordunni shamans so they cast it less frequently
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5236 AND `id` IN (4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5236, 0, 4, 0, 14, 0, 100, 0, 500, 25, 0, 20000, 0, 11, 8005, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Shaman - Friendly At 500 Health - Cast \'Healing Wave\' every 20 seconds'),
(5236, 0, 5, 0, 2, 0, 100, 0, 0, 50, 72000, 90000, 0, 11, 8005, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Shaman - Between 0-50% Health - Cast \'Healing Wave\' every 1:20 to 1:30 minutes');

