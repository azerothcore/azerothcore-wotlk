-- DB update 2026_08_18_00 -> 2026_08_19_00
--
UPDATE `creature_template` SET `faction` = 14, `speed_run` = 1 WHERE (`entry` = 29457);

UPDATE `creature_template_movement` SET `Ground` = 0, `Flight` = 1 WHERE (`CreatureId` = 29457);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29457);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29457, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 54495, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer Trigger - On Just Summoned - Cast \'Plague Spray\''),
(29457, 0, 1, 0, 60, 0, 100, 1, 1200, 1200, 0, 0, 0, 0, 210, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer Trigger - On Update - Fall (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28274);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28274, 0, 0, 0, 1, 0, 100, 0, 135000, 180000, 135000, 180000, 0, 0, 11, 54496, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - Out of Combat - Cast \'Summon Plague Spray\''),
(28274, 0, 1, 0, 8, 0, 100, 0, 51173, 0, 0, 0, 0, 0, 80, 2827400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - On Spellhit \'A Tangled Skein: Encasing Webs - Effect\' - Run Script'),
(28274, 0, 2, 0, 34, 0, 100, 0, 16, 0, 0, 0, 0, 0, 80, 2827401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - On Reached Ground After Fall - Run Script'),
(28274, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - On Respawn - Set Reactstate Passive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2827400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2827400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 28289, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - Actionlist - Quest Credit'),
(2827400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51168, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - Actionlist - Cast \'Encasing Webs\''),
(2827400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 53236, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - Actionlist - Cast \'Plague Sprayer: Huge Explosion\''),
(2827400, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 210, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - Actionlist - Fall');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2827401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2827401, 9, 0, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 11, 53236, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - Actionlist - Cast \'Plague Sprayer: Huge Explosion\''),
(2827401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51314, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - Actionlist - Cast \'A Tangled Skein: Summon Broken Plague Sprayer\''),
(2827401, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plague Sprayer - Actionlist - Despawn Instant');
