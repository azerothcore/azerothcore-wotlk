-- DB update 2024_01_01_04 -> 2024_01_01_05
--
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5046, 5047);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5046, 'SmartTrigger'),
(5047, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5046) AND (`source_type` = 2) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5046, 2, 0, 0, 46, 0, 100, 0, 5046, 0, 0, 0, 0, 0, 134, 52056, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Cast \'Sholazar to Un`goro Teleport\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5047) AND (`source_type` = 2) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5047, 2, 0, 0, 46, 0, 100, 0, 5047, 0, 0, 0, 0, 0, 134, 52057, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Cast \'Un`goro to Sholazar Teleport\'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=1 AND `SourceEntry` IN (5046, 5047) AND `SourceId`=2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 5046, 2, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Player must be alive'),
(22, 1, 5046, 2, 0, 14, 0, 13956, 0, 0, 1, 0, 0, '', 'Cast Teleport to Un\'goro if Meeting a Great One (13956) status is not none.'),
(22, 1, 5046, 2, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Player must be alive'),
(22, 1, 5046, 2, 1, 8, 0, 12613, 0, 0, 0, 0, 0, '', 'Cast Teleport to Un\'goro if The Makers Overlook (12613) has been rewarded.'),
(22, 1, 5046, 2, 1, 8, 0, 12559, 0, 0, 0, 0, 0, '', 'Cast Teleport to Un\'goro if The Makers Perch (12559) has been rewarded.');

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 5047, 2, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Player must be alive'),
(22, 1, 5047, 2, 0, 14, 0, 13956, 0, 0, 1, 0, 0, '', 'Cast Teleport to Sholazar if Meeting a Great One (13956) status is not none.'),
(22, 1, 5047, 2, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Player must be alive'),
(22, 1, 5047, 2, 1, 8, 0, 12613, 0, 0, 0, 0, 0, '', 'Cast Teleport to Sholazar if The Makers Overlook (12613) has been rewarded.'),
(22, 1, 5047, 2, 1, 8, 0, 12559, 0, 0, 0, 0, 0, '', 'Cast Teleport to Sholazar if The Makers Perch (12559) has been rewarded.');
