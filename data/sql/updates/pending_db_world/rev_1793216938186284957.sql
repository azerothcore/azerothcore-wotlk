-- Sapph: remove the deleted quest-credit event link.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30956 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30956,0,0,0,4,0,100,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sapph - On Aggro - Say Line 0'),
(30956,0,1,0,9,0,100,0,0,0,9000,13000,10,40,11,61077,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Sapph - Within 10-40 Range - Cast \'Chains of Ice\''),
(30956,0,2,0,106,0,100,0,18000,25000,18000,25000,0,8,11,61058,1,0,0,0,0,2,0,0,0,0,0,0,0,0,'Sapph - Within 0-8 Range - Cast \'Hungering Cold\''),
(30956,0,3,0,0,0,100,0,60000,120000,120000,240000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sapph - In Combat - Say Line 1'),
(30956,0,4,0,5,0,100,1,0,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sapph - On Killed Unit - Say Line 2'),
(30956,0,5,0,6,0,100,1,0,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sapph - On Just Died - Say Line 3 (No Repeat)');

-- Freed Crusader: keep the crusader as speaker for any invoker.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3027400 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3027400,9,0,0,0,0,100,0,0,0,0,0,0,0,11,58054,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Cast \'Blessing of Kings\''),
(3027400,9,1,0,0,0,100,0,2000,2000,0,0,0,0,1,0,0,0,1,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Say Line 0'),
(3027400,9,2,0,0,0,100,0,0,0,0,0,0,0,11,58053,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Cast \'Holy Light\''),
(3027400,9,3,0,0,0,100,0,4000,4000,0,0,0,0,53,2,30274,0,13008,0,0,1,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Start Waypoint'),
(3027400,9,4,0,0,0,100,0,0,0,0,0,0,0,41,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Despawn In 4000 ms');
