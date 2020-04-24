INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587740947996468714');

DELETE FROM `smart_scripts` WHERE `entryorguid`=28529 AND `id`=2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(28529, 0, 2, 0, 1, 0, 100, 0, 0, 0, 1000, 3000, 0, 49, 0, 0, 0, 0, 0, 0, 9, 28511, 1, 25, 1, 0, 0, 0, 0, 'Scarlet Crusader - Out of Combat - Start Attacking');
