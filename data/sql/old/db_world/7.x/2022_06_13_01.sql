-- DB update 2022_06_13_00 -> 2022_06_13_01
--
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 180517;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 180517) AND (`source_type` = 1) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(180517, 1, 0, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 11, 24871, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Putrid Mushroom - On Just Created - Cast \'Spore Cloud\''),
(180517, 1, 1, 0, 1, 0, 100, 0, 120000, 120000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Putrid Mushroom - Out of Combat - Despawn Instant');
