-- Blacksmith Goodman emote state 173 plays hammering motion
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27234;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27234) AND (`source_type` = 0) AND (`id` IN (1, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27234, 0, 1, 0, 6, 2, 100, 0, 0, 0, 0, 0, 0, 0, 134, 48728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blacksmith Goodman - On Just Died - Invoker Cast \'The Denouncement: Blacksmith Goodman On Death\' (Phase 2)'),
(27234, 0, 4, 0, 6, 2, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blacksmith Goodman - On Just Died - Say Line 0 (Phase 2)'),
(27234, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blacksmith Goodman - On Reset - Set Emote State 173');
-- Location is Non sniffed
UPDATE `creature` SET `position_x` = 2938.843, `position_y` = -333.74777, `position_z` = 114.74067, `orientation` = 0.645771801471710205 WHERE `guid` = 104699 AND `id1` = 27234;
