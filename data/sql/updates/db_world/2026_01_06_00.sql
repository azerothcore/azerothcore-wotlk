-- DB update 2026_01_05_04 -> 2026_01_06_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30886);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30886, 0, 0, 0, 25, 0, 100, 513, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugated Iskalder - On Reset - Set Flags Immune To NPC\'s (No Repeat)'),
(30886, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 30232, 0, 1, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugated Iskalder - On Just Summoned - Start Follow Invoker'),
(30886, 0, 2, 0, 65, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 25729, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugated Iskalder - On Follow Complete - Cast \'Find the Ancient Hero: Kill Credit\''),
(30886, 0, 3, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugated Iskalder - Condition: Outside Areas 4526 or 4498 - Despawn Instant');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 4) AND (`SourceEntry` = 30886) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 23);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 30886, 0, 0, 23, 1, 4526, 0, 0, 1, 0, 0, '', 'Despawn Subjugated Iskalder when outside quest areas'),
(22, 4, 30886, 0, 0, 23, 1, 4498, 0, 0, 1, 0, 0, '', 'Despawn Subjugated Iskalder when outside quest areas');
