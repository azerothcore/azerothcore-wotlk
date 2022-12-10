-- DB update 2022_07_26_05 -> 2022_07_26_06
--
UPDATE `creature_text` SET `BroadcastTextId` = 1456 WHERE `CreatureID` = 10000 AND `GroupID` = 0;
UPDATE `creature_text` SET `BroadcastTextId` = 5680 WHERE `CreatureID` = 10000 AND `GroupID` = 1;
UPDATE `creature_text` SET `BroadcastTextId` = 5681 WHERE `CreatureID` = 10000 AND `GroupID` = 2;
UPDATE `creature_text` SET `BroadcastTextId` = 5682 WHERE `CreatureID` = 10000 AND `GroupID` = 3;

-- SFK: Arugal intro script
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10000 AND `source_type`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10000,0,0,0,60,0,100,1,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Set Invisible'),
(10000,0,1,0,60,0,100,1,5000,5000,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Set Visible'),
(10000,0,2,0,60,0,100,1,5000,5000,0,0,0,11,7741,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Cast spell teleport'),
(10000,0,3,0,60,0,100,1,7000,7000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Say text 0'),
(10000,0,4,0,60,0,100,1,7000,7000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Emote talk'),
(10000,0,5,0,60,0,100,1,10000,10000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Say text 1'),
(10000,0,6,0,60,0,100,1,10000,10000,0,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Emote point'),
(10000,0,7,0,60,0,100,1,14000,14000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Say text 2'),
(10000,0,8,0,60,0,100,1,14000,14000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Emote talk'),
(10000,0,9,0,60,0,100,1,16000,16000,0,0,0,5,11,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Emote laught'),
(10000,0,10,0,60,0,100,1,19000,19000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Say text 3'),
(10000,0,11,0,60,0,100,1,21000,21000,0,0,0,11,7741,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Cast spell teleport'),
(10000,0,12,0,60,0,100,1,0,0,0,0,0,41,22000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Arugal - Despawn');
