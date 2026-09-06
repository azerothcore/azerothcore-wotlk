-- DB update 2025_09_06_05 -> 2025_09_07_00
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 27409) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 32) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 16) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 27409, 0, 0, 32, 0, 16, 0, 0, 0, 0, 0, '', 'Ducal\'s horse only run sai if boarding passenger is player');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2740900) AND (`source_type` = 9) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2740900, 9, 0, 0, 0, 0, 100, 512, 3000, 3000, 0, 0, 0, 0, 53, 1, 27409, 0, 12308, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ducal\'s Horse - On Script - Start Waypoint');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27409) AND (`source_type` = 0) AND (`id` IN (1, 8, 9, 10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27409, 0, 1, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ducal\'s Horse - On Passenger Boarded - Set Reactstate Passive'),
(27409, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 10000, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ducal\'s Horse - On Reset - Create Timed Event'),
(27409, 0, 9, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ducal\'s Horse - On Timed Event 1 Triggered - Despawn Instant'),
(27409, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ducal\'s Horse - On Passenger Boarded - Remove Timed Event 1');
