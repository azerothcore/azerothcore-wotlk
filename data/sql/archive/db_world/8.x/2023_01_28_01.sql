-- DB update 2023_01_28_00 -> 2023_01_28_01
-- Changed Violet Hold door to Smart_Script
DELETE FROM `smart_scripts` WHERE `entryorguid` = 193020;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
('193020','1','0','0','70','0','100','0','2','0','0','0','0','9','0','0','0','0','0','0','14','61606','193019','0','0','0','0','0','0',' - On Gameobject State Changed - Activate Gameobject');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` = 193020;
