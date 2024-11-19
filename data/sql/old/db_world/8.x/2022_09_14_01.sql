-- DB update 2022_09_14_00 -> 2022_09_14_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12256;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 12256);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12256, 0, 0, 1, 8, 0, 100, 512, 19250, 0, 120000, 120000, 0, 33, 12247, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mark of Detonation - On Spellhit - Kill Credit'),
(12256, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 120, 0, 0, 0, 0, 20, 177668, 0, 0, 0, 0, 0, 0, 0, 'Mark of Detonation - On Spellhit - Despawn Mark of Detonation');
