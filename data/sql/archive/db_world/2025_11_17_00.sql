-- DB update 2025_11_16_02 -> 2025_11_17_00
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24825) AND (`source_type` = 0) AND (`id` IN (2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24825, 0, 2, 0, 72, 0, 100, 512, 1, 0, 0, 0, 0, 0, 53, 2, 24826, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action 1 Done - Start Waypoint Path 24826'),
(24825, 0, 3, 0, 72, 0, 100, 512, 2, 0, 0, 0, 0, 0, 53, 2, 24827, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action 2 Done - Start Waypoint Path 24827'),
(24825, 0, 4, 0, 72, 0, 100, 512, 3, 0, 0, 0, 0, 0, 53, 2, 24828, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action 3 Done - Start Waypoint Path 24828'),
(24825, 0, 5, 0, 72, 0, 100, 512, 4, 0, 0, 0, 0, 0, 53, 2, 24831, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action 4 Done - Start Waypoint Path 24831'),
(24825, 0, 6, 0, 72, 0, 100, 512, 5, 0, 0, 0, 0, 0, 53, 2, 24829, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action 5 Done - Start Waypoint Path 24829'),
(24825, 0, 7, 0, 72, 0, 100, 512, 6, 0, 0, 0, 0, 0, 53, 2, 24832, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Action 6 Done - Start Waypoint Path 24832');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (24826, 24827, 24828, 24829, 24831, 24832));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24826, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Do Action 1'),
(24827, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Do Action 2'),
(24828, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 223, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Do Action 3'),
(24831, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Do Action 4'),
(24829, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 223, 5, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Do Action 5'),
(24832, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 223, 6, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Do Action 6');
