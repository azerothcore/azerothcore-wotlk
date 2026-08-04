-- "The Nightmare Manifests" (Moonglade) stalls because Eranikus and Remulos never fight.
-- Eranikus' unlock hung off a waypoint path with no rows, so it moves onto the last line of
-- his dialogue. Remulos needs a combat-capable faction (635 can never be hostile) and a retry
-- pulse, since his single attack attempt is blocked by a leftover in-combat flag. His return
-- escort is rehomed the same way.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15491 AND `source_type` = 0 AND `id` IN (7, 10, 38, 41) AND `link` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `comment`)
VALUES
    (15491, 0, 7, 0, 52, 0, 100, 0, 4, 15491, 1, 5, 10000, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 4 Over - Say Line 5'),
    (15491, 0, 10, 0, 52, 0, 100, 512, 7, 15491, 2, 14, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Set Faction 14'),
    (15491, 0, 38, 0, 52, 0, 100, 512, 7, 15491, 8, 2, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Set Reactstate Aggressive'),
    (15491, 0, 41, 0, 52, 0, 100, 512, 7, 15491, 19, 768, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Remove unitflag');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 11832 AND `source_type` = 0 AND `id` IN (34, 35, 45, 46, 47) AND `link` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `target_param1`, `target_param2`, `comment`)
VALUES
    (11832, 0, 34, 0, 52, 0, 100, 0, 9, 11832, 0, 0, 82, 3, 0, 0, 1, 0, 0, 'Keeper Remulos - On Text 9 Over - Add Npc Flags Gossip & Questgiver'),
    (11832, 0, 35, 0, 52, 0, 100, 0, 9, 11832, 0, 0, 66, 0, 0, 0, 1, 0, 0, 'Keeper Remulos - On Text 9 Over - Set Orientation Home Position'),
    (11832, 0, 45, 0, 40, 0, 100, 0, 21, 11832, 0, 0, 22, 1, 0, 0, 1, 0, 0, 'Keeper Remulos - On Waypoint 21 Reached - Set Event Phase 1 (engage-retry window)'),
    (11832, 0, 46, 0, 60, 1, 100, 0, 2000, 2000, 3000, 3000, 49, 0, 0, 0, 11, 15491, 30, 'Keeper Remulos - Update Pulse (Phase 1) - Retry Start Attacking Eranikus'),
    (11832, 0, 47, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 2, 231, 0, 0, 1, 0, 0, 'Keeper Remulos - On Text 7 Over - Set Faction 231 (combat-capable, test)');

DELETE FROM `waypoint_data` WHERE `id` IN (11832, 15491, 1183200, 1183201);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`)
VALUES
    (11832, 1, 7829.66, -2244.87, 463.87, 0),
    (11832, 2, 7817.25, -2306.2, 456, 0),
    (11832, 3, 7866.54, -2312.2, 463.32, 0),
    (11832, 4, 7908.49, -2309.09, 467.677, 0),
    (11832, 5, 7933.29, -2314.78, 473.674, 0),
    (11832, 6, 7942.54, -2320.17, 476.77, 0),
    (11832, 7, 7953.04, -2357.95, 486.379, 0),
    (11832, 8, 7962.71, -2411.16, 488.955, 0),
    (11832, 9, 7976.86, -2552.7, 490.081, 0),
    (11832, 10, 7949.31, -2569.12, 489.716, 0),
    (11832, 11, 7950.95, -2597, 489.766, 0),
    (11832, 12, 7948.76, -2610.82, 492.369, 0),
    (11832, 13, 7928.79, -2629.92, 492.525, 0),
    (11832, 14, 7948.7, -2610.55, 492.364, 0),
    (11832, 15, 7952.02, -2591.97, 490.081, 0),
    (11832, 16, 7940.57, -2577.85, 488.947, 0),
    (11832, 17, 7908.66, -2566.45, 488.635, 0),
    (11832, 18, 7873.13, -2567.42, 486.946, 0),
    (11832, 19, 7839.84, -2570.6, 489.286, 0),
    (11832, 20, 7830.68, -2572.88, 489.286, 0),
    (11832, 21, 7890.5, -2567.26, 487.306, 0),
    (11832, 22, 7906.45, -2566.1, 488.435, 0),
    (11832, 23, 7925.86, -2573.6, 489.642, 0),
    (11832, 24, 7912.28, -2568.5, 488.891, 0),
    (15491, 1, 7949.81, -2605.47, 513.591, 0),
    (15491, 2, 7931.33, -2575.21, 489.629, 0),
    (15491, 3, 7925.13, -2573.75, 489.64, 0),
    (15491, 4, 7910.55, -2565.55, 488.616, 0),
    (15491, 5, 7867.44, -2567.33, 486.946, 0),
    (1183200, 1, 7828.58, -2246.84, 463.516, 0),
    (1183200, 2, 7824.64, -2279.03, 459.317, 0),
    (1183200, 3, 7814.17, -2302.26, 456.223, 0),
    (1183200, 4, 7787.46, -2320.98, 454.547, 0),
    (1183200, 5, 7753.75, -2319.08, 454.707, 0),
    (1183200, 6, 7787.46, -2320.98, 454.547, 0),
    (1183200, 7, 7814.17, -2302.26, 456.223, 0),
    (1183200, 8, 7824.64, -2279.03, 459.317, 0),
    (1183200, 9, 7828.58, -2246.84, 463.516, 0),
    (1183200, 10, 7848.3, -2216.35, 470.888, 0),
    (1183201, 1, 7940.57, -2577.85, 488.947, 0),
    (1183201, 2, 7949.31, -2569.12, 489.716, 0),
    (1183201, 3, 7976.86, -2552.7, 490.081, 0),
    (1183201, 4, 7962.71, -2411.16, 488.955, 0),
    (1183201, 5, 7953.04, -2357.95, 486.379, 0),
    (1183201, 6, 7942.54, -2320.17, 476.77, 0),
    (1183201, 7, 7933.29, -2314.78, 473.674, 0),
    (1183201, 8, 7908.49, -2309.09, 467.677, 0),
    (1183201, 9, 7866.54, -2312.2, 463.32, 0),
    (1183201, 10, 7817.25, -2306.2, 456, 0),
    (1183201, 11, 7829.66, -2244.87, 463.87, 0),
    (1183201, 12, 7847.07, -2217.57, 470.403, 0);
