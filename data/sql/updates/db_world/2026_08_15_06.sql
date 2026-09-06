-- DB update 2026_08_15_05 -> 2026_08_15_06
--
DELETE FROM `waypoints` WHERE `entry` = 15491;
DELETE FROM `waypoint_data` WHERE `id` = 154911;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(154911, 1, 7949.81, -2605.47, 513.591, NULL, 0),
(154911, 2, 7931.33, -2575.21, 489.629, NULL, 0),
(154911, 3, 7925.13, -2573.75, 489.64 , NULL, 130000),
(154911, 4, 7910.55, -2565.55, 488.616, NULL, 0),
(154911, 5, 7867.44, -2567.33, 486.946, NULL, 0);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15491) AND (`source_type` = 0) AND (`id` IN (5, 6, 7, 10, 33, 36, 37, 38, 39, 40, 41));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15491, 0, 5, 0, 52, 0, 100, 512, 4, 15491, 0, 0, 0, 0, 232, 154911, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Text 4 Over - Start Waypoint'),
(15491, 0, 7, 0, 108, 0, 100, 0, 3, 154911, 0, 0, 0, 0, 1, 5, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Waypoint 3 Reached - Say Line 5'),
(15491, 0, 10, 0, 108, 0, 100, 512, 4, 154911, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Waypoint 4 Reached - Set Faction 14'),
(15491, 0, 33, 0, 108, 0, 100, 512, 5, 154911, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Waypoint 5 Reached - Set Visibility Off'),
(15491, 0, 36, 0, 108, 0, 100, 512, 5, 154911, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Waypoint 5 Reached - Kill Self'),
(15491, 0, 37, 0, 108, 0, 100, 512, 5, 154911, 0, 0, 0, 0, 6, 8736, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Waypoint 5 Reached - Fail Quest \'The Nightmare Manifests\''),
(15491, 0, 38, 0, 108, 0, 100, 512, 4, 154911, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Waypoint 4 Reached - Set Reactstate Aggressive'),
(15491, 0, 39, 0, 108, 0, 100, 512, 3, 154911, 0, 0, 0, 0, 91, 2, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Waypoint 3 Reached - Remove Flag Hover'),
(15491, 0, 40, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Just Summoned - Set Flags Immune To Players & Immune To NPC\'s'),
(15491, 0, 41, 0, 108, 0, 100, 512, 4, 154911, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eranikus, Tyrant of the Dream - On Point 4 of Path 154911 Reached - Remove Flags Immune To Players & Immune To NPC\'s');
