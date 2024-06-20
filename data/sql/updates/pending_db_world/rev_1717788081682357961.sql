--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10719);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10719, 0, 0, 0, 1, 0, 100, 0, 12000, 12000, 0, 0, 0, 0, 1, 0, 13, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Herald of Thrall - Out of Combat - Say Line 0'),
(10719, 0, 1, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 0, 1, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Herald of Thrall - Out of Combat - Say Line 1'),
(10719, 0, 2, 0, 1, 0, 100, 0, 19000, 19000, 0, 0, 0, 0, 11, 16609, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Herald of Thrall - Out of Combat - Cast \'Warchief`s Blessing\'');

-- Limit Herald of Thrall shout range to Area
UPDATE `creature_text` SET `TextRange` = 1 WHERE `CreatureID` = 10719;
