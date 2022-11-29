-- DB update 2022_05_07_01 -> 2022_05_08_00
--
UPDATE `smart_scripts` SET `action_type`=85 WHERE `entryorguid`=30105 AND `source_type`=0 AND `id`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=30331 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30331,0,0,1,27,0,100,512,0,0,0,0,0,53,1,30331,0,0,0,0,1,0,0,0,0,0,0,0,0,'Jokkum - On Passenger boarded - Start WP'),
(30331,0,1,2,61,0,100,512,0,0,0,0,0,1,0,0,0,0,0,0,23,0,0,0,0,0,0,0,0,'Jokkum - On Passenger boarded - Talk1'),
(30331,0,2,0,61,0,100,512,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Jokkum - On Passenger boarded - Set ImmuneNPC/PC'),
(30331,0,3,4,40,0,100,512,30,30331,0,0,0,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Jokkum - On way pont 22 - Remove all auras'),
(30331,0,4,0,61,0,100,512,0,0,0,0,0,80,3033100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Jokkum - On way pont 22 - Actionlist');
