INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644361725568399420');

-- corrects smart script for thrash for npc entry 1783
DELETE FROM `smart_scripts` WHERE `entryorguid`=1783;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(1783, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Flayer - On Aggro - Cast \'Thrash\'');
