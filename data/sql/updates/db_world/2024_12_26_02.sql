-- DB update 2024_12_26_01 -> 2024_12_26_02
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 184568);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(184568, 1, 0, 1, 64, 0, 100, 1, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 205, 26, 2, 0, 0, 0, 0, 0, 0, 'Lady Vashj Bridge Console - On Gossip Hello - Activate Gameobject (No repeat)'),
(184568, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 205, 27, 2, 0, 0, 0, 0, 0, 0, 'Lady Vashj Bridge Console - On Gossip Hello - Activate Gameobject (No repeat)'),
(184568, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 205, 28, 2, 0, 0, 0, 0, 0, 0, 'Lady Vashj Bridge Console - On Gossip Hello - Activate Gameobject (No repeat)'),
(184568, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 205, 29, 2, 0, 0, 0, 0, 0, 0, 'Lady Vashj Bridge Console - On Gossip Hello - Activate Gameobject (No repeat)');
