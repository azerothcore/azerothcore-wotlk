-- DB update 2025_07_21_01 -> 2025_07_22_00

-- Edit Random Movement Flag
UPDATE `creature_template_movement` SET `Random` = 2 WHERE (`CreatureId` = 26369);

-- Set SmartAI and Action List
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26369;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26369);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26369, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 5000, 9000, 0, 0, 11, 55079, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Imperial Eagle - In Combat - Cast \'Swoop\''),
(26369, 0, 1, 0, 8, 0, 100, 0, 49546, 0, 0, 0, 0, 0, 80, 2636900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Imperial Eagle - On Spellhit \'Eagle Eyes\' - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2636900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2636900, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Imperial Eagle - Actionlist - Remove FlagStandstate Sit Down'),
(2636900, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 89, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Imperial Eagle - Actionlist - Start Random Movement'),
(2636900, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Imperial Eagle - Actionlist - Despawn In 8000 ms');

-- Set Condition for Silver Feather
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 49546) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 26369) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 49546, 0, 0, 31, 1, 3, 26369, 0, 0, 0, 0, '', 'Eagle Eyes only target Imperial Eagles');
