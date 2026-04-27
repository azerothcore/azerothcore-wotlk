-- DB update 2026_04_03_00 -> 2026_04_03_01
DELETE FROM `waypoint_data` WHERE `id` = 2669000;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(2669000, 1, 478.743, -505.576, 104.724, 0, 0, 1, 0, 100, 0),
(2669000, 2, 318.177, -503.8898, 104.5326, 0, 0, 1, 0, 100, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 26690 AND `source_type` = 0 AND `id` IN (2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26690, 0, 2, 0, 109, 0, 100, 0, 0, 2669000, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Warrior - On Path 2669000 Finished - Set In Combat With Zone');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 26691 AND `source_type` = 0 AND `id` IN (2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26691, 0, 2, 0, 109, 0, 100, 0, 0, 2669000, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Witch Doctor - On Path 2669000 Finished - Set In Combat With Zone');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 26692 AND `source_type` = 0 AND `id` IN (3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26692, 0, 3, 0, 109, 0, 100, 0, 0, 2669000, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Harpooner - On Path 2669000 Finished - Set In Combat With Zone');

UPDATE `spell_area` SET `gender` = 2 WHERE `spell` = 47546;

DELETE FROM `waypoint_data` WHERE `id` IN (2689303, 2689304);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(2689303, 1, 520.483, -541.563, 119.842, 0, 0, 2, 0, 100, 0),
(2689303, 2, 496.434, -517.578, 120, 0, 0, 2, 0, 100, 0),
(2689304, 1, 520.483, -541.563, 119.842, 0, 0, 2, 0, 100, 0),
(2689304, 2, 500.243, -501.693, 120, 0, 0, 2, 0, 100, 0);
