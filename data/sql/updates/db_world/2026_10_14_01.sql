-- DB update 2026_10_14_00 -> 2026_10_14_01
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (19424, 19640) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19424, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 0, 0, 11, 12542, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Tormentor - In Combat - Cast \'Fear\' (No Repeat)'),
(19424, 0, 1, 0, 0, 0, 100, 1, 0, 0, 3000, 3000, 0, 0, 11, 34368, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Tormentor - In Combat - Cast \'Summon Riding Worg\' (No Repeat)'),
(19424, 0, 2, 3, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 11, 31553, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Tormentor - Between 0-15% Health - Cast \'Hamstring\' (No Repeat)'),
(19424, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Tormentor - Between 0-15% Health - Flee For Assist (No Repeat)'),
(19424, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 11, 33976, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Tormentor - On Data Set 1 1 - Cast \'Mend Pet\''),
(19640, 0, 0, 0, 7, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Riding Worg - On evade - Self: Despawn in 1000 ms'),
(19640, 0, 1, 0, 2, 0, 100, 0, 0, 70, 18000, 26000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Riding Worg - Between 0-70% Health - Set Data 1 1 on Owner');
