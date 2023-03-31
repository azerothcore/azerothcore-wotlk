--

DELETE FROM `smart_scripts` WHERE entryorguid=-138927 AND source_type=0 AND id IN (0,1,2,3,4);
DELETE FROM `smart_scripts` WHERE entryorguid=20867 AND source_type=0;
INSERT INTO `smart_scripts` (`entryorguid`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES 
(20867, 5000, 10000, 10000, 15000, 11, 36664, 2, 'Death Watcher - In Combat - Cast \'Tentacle Cleave\'');
(20867, 1, 2, 70, 15000, 15000, 11, 36655, 2, 'Death Watcher - Between 0-70% Health - Cast \'Drain Life\'');
(20867, 2, 2, 1, 50, 11, 36657, 1, 'Death Watcher - Between 0-50% Health - Cast \'Death Count\' (No Repeat)');
(20867, 3, 6, 28, 36657, 16, 'Death Watcher - On Death - Remove \'Death Count\'');

