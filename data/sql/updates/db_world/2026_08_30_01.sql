-- DB update 2026_08_30_00 -> 2026_08_30_01
-- Champion of Hodir: Freezing Breath targets the second highest threat unit instead of the current tank.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 34133) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34133, 0, 0, 0, 0, 0, 100, 2, 6000, 10000, 15000, 20000, 0, 0, 11, 64639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Champion of Hodir - In Combat - Cast \'Stomp\' (Normal Dungeon)'),
(34133, 0, 1, 0, 0, 0, 100, 4, 6000, 10000, 15000, 20000, 0, 0, 11, 64652, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Champion of Hodir - In Combat - Cast \'Stomp\' (Heroic Dungeon)'),
(34133, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 15000, 25000, 0, 0, 11, 64649, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Champion of Hodir - In Combat - Cast \'Freezing Breath\'');
