-- DB update 2026_01_27_04 -> 2026_01_27_05
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24718);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24718, 0, 0, 0, 10, 0, 100, 512, 1, 5, 60000, 60000, 0, 0, 80, 2471800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Within 1-5 Range Out of Combat LoS - Run Script'),
(24718, 0, 1, 0, 8, 1, 100, 512, 44562, 0, 5000, 5000, 0, 0, 80, 2471801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - On Spellhit \'Bluff\' - Run Script (Phase 1)'),
(24718, 0, 2, 0, 60, 1, 100, 0, 60000, 60000, 60000, 60000, 0, 0, 80, 2471802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - On Update - Reset Self (Phase 1)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2471800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2471800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Say Line 1'),
(2471800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Set Event Phase 1'),
(2471800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Set Rooted On');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2471801);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2471801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Set Event Phase 0'),
(2471801, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 24823, 20, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Say Line 0'),
(2471801, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Say Line 2'),
(2471801, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 24823, 20, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Set Data 0 1'),
(2471801, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Set Rooted Off');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2471802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2471802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Set Event Phase 0'),
(2471802, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lebronski - Actionlist - Set Rooted Off');

UPDATE `conditions` SET `Comment` = 'Only fire Event for \'Iron Rune Constructs and You: The Bluff\' if Invoker is Iron Rune Construct (24823)' WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 24718) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 24823) AND (`ConditionValue3` = 0);
