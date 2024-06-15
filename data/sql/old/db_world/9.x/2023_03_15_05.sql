-- DB update 2023_03_15_04 -> 2023_03_15_05
-- Brother Sarno
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7917;

DELETE FROM `smart_scripts` WHERE `entryorguid`=7917 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES (7917, 0, 0, 0, 38, 0, 100, 0, 0, 1, 60000, 60000, 0, 80, 791700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brother Sarno - On Data Set 0 1 - Run Script (Areatrigger 1125 Invoker)');

DELETE FROM `smart_scripts` WHERE `entryorguid`=791700 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(791700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Brother Sarno - On Script - Set Orientation Stored Target'),
(791700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Brother Sarno - On Script - Say Line 0'),
(791700, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brother Sarno - On Script - Set Orientation Home Position');

-- Areatrigger
DELETE FROM `areatrigger_scripts` WHERE `entry` = 1125;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (1125, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `entryorguid`=1125 AND `source_type`=2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1125, 2, 0, 1, 46, 0, 100, 0, 1125, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger (Cathedral of Light) - On Trigger - Store Targetlist'),
(1125, 2, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 7917, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger (Cathedral of Light) - On Link - Send Target 1 (Brother Sarno)'),
(1125, 2, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 7917, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger (Cathedral of Light) - On Link - Set Data 0 1 (Brother Sarno)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=1125;	
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 1125, 2, 0, 15, 0, 32, 0, 0, 1, 0, 0, '', 'Execute Areatrigger 1125 SAI if player is not a Death Knight');
