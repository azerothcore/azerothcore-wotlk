--
UPDATE `smart_scripts` SET `target_type`=2 WHERE (`entryorguid` = 22993) AND (`source_type` = 0) AND (`id` IN (5));

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23338;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23338) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23338, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 41, 140000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Arthorn\'s Sparrowhawk - On Respawn - Despawn In 140000 ms');
