INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631645430068698532');

-- Change the quest parameter and the comment. Now he should cast Break stuff when completing the correct quest The Temple of Atal'Hakkar
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1443);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1443, 0, 0, 0, 20, 0, 100, 0, 1062, 0, 0, 0, 0, 1, 0, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel\'zerul - On Quest \'Goblin Invaders\' Finished - Say Line 0'),
(1443, 0, 1, 0, 20, 0, 100, 0, 1445, 0, 0, 0, 0, 11, 7437, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel\'zerul - On Quest \'The Temple of Atal\'Hakkar\' Finished - Cast \'Break Stuff\'');

