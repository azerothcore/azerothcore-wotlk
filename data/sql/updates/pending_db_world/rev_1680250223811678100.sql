--
DELETE FROM `smart_scripts` WHERE entryorguid IN (-138927,20867) AND source_type=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(20867, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 11, 36664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast \'Tentacle Cleave\''),
(20867, 0, 1, 0, 2, 0, 100, 0, 1, 70, 0, 0, 0, 11, 36655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-70% Health - Cast \'Drain Life\''),
(20867, 0, 2, 0, 2, 0, 100, 0, 1, 50, 0, 0, 0, 11, 36657, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-50% Health - Cast \'Death Count\' (No Repeat)'),
(20867, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 28, 36657, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Death - Remove \'Death Count\''),
(-138927, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 11, 36664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast \'Tentacle Cleave\''),
(-138927, 0, 1, 0, 2, 0, 100, 0, 1, 70, 0, 0, 0, 11, 36655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-70% Health - Cast \'Drain Life\''),
(-138927, 0, 2, 0, 2, 0, 100, 0, 1, 50, 0, 0, 0, 11, 36657, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-50% Health - Cast \'Death Count\' (No Repeat)'),
(-138927, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 28, 36657, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Death - Remove \'Death Count\''),
(-138927, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2086700, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Respawn - Start Waypoint'),
(-138927, 0, 1002, 0, 40, 0, 100, 0, 0, 2086700, 0, 0, 0, 80, 2086700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Waypoint Any Reached - Run Script');

