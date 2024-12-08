-- DB update 2023_11_11_02 -> 2023_11_11_03
-- Triangulation Point One / Two
DELETE FROM `areatrigger_involvedrelation` WHERE `id` IN (4473,4475);

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (4473,4475);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(4473, 'SmartTrigger'),
(4475, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `source_type` = 2 AND `entryorguid` IN (4473,4475);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4473, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 10269, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Quest Credit \'Triangulation Point One\''),
(4475, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 10275, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Quest Credit \'Triangulation Point Two\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (4473,4475)) AND (`SourceId` = 2);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 4473, 2, 0, 1, 0, 34830, 1, 0, 0, 0, 0, '', 'Run SAI for areatrigger 4473 only if \'Triangulation Point One\' buff is present'),
(22, 1, 4475, 2, 0, 1, 0, 34857, 1, 0, 0, 0, 0, '', 'Run SAI for areatrigger 4475 only if \'Triangulation Point Two\' buff is present');
