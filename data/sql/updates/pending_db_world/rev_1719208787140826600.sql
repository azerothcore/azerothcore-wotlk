-- Flame Wave.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (18975,19740));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18975, 0, 0, 0, 0, 0, 75, 0, 5000, 10000, 15000, 20000, 0, 0, 11, 33804, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathguard - In Combat - Cast \'Flame Wave\''),
(19740, 0, 0, 0, 0, 0, 75, 0, 5000, 10000, 15000, 20000, 0, 0, 11, 33804, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathwalker - In Combat - Cast \'Flame Wave\'');

UPDATE `creature_template` SET `faction` = 90 WHERE (`entry` = 19381);
