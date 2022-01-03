INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641213986609051100');

-- Grethok immunity flags
UPDATE `creature_template` SET `mechanic_immune_mask` = 33636209 WHERE (`entry` = 12557);

-- Grethok - Update arcane missiles to correct spell id (was using triggered spell)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12557) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12557, 0, 3, 0, 0, 0, 80, 2, 16000, 16000, 12000, 12000, 0, 11, 22272, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Grethok the Controller - In Combat - Cast \'Arcane Missiles\'');
