--
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 16870 AND `guid` IN (58200, 58201, 58202, 58203);

UPDATE `creature_addon` SET `path_id` = 582000 WHERE `guid` = 58200;
UPDATE `creature_addon` SET `path_id` = 582010 WHERE `guid` = 58201;
UPDATE `creature_addon` SET `path_id` = 582020 WHERE `guid` = 58202;
UPDATE `creature_addon` SET `path_id` = 582030 WHERE `guid` = 58203;

DELETE FROM `waypoint_data` WHERE `id` IN (582000, 582010, 582020, 582030);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(582000, 1, -232.831, 3101.73, -62.6664, 2.37365, 3600, 0, 0, 100, 0),
(582000, 2, -232.831, 3101.73, -62.6664, 2.37365, 2400, 0, 0, 100, 0),
(582010, 1, -222.417, 3105.29, -60.0269, 1.32645, 3600, 0, 0, 100, 0),
(582010, 2, -222.417, 3105.29, -60.0269, 1.32645, 2400, 0, 0, 100, 0),
(582020, 1, -252.053, 3079.74, -65.8276, 3.4383, 3600, 0, 0, 100, 0),
(582020, 2, -252.053, 3079.74, -65.8276, 3.4383, 2400, 0, 0, 100, 0),
(582030, 1, -244.95, 3090.06, -65.1446, 2.84489, 3600, 0, 0, 100, 0),
(582030, 2, -244.95, 3090.06, -65.1446, 2.84489, 2400, 0, 0, 100, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16870);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16870, 0, 0, 0, 0, 0, 100, 0, 2200, 8100, 9400, 16800, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - In Combat - Cast \'Cleave\' (Phase 2)'),
(16870, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - On Aggro - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 2, 0, 2, 0, 100, 1, 0, 90, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-90% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 3, 0, 2, 0, 100, 1, 0, 80, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-80% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 4, 0, 2, 0, 100, 1, 0, 70, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-70% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 5, 0, 2, 0, 100, 1, 0, 60, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-60% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 6, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-50% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 7, 0, 2, 0, 100, 1, 0, 40, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-40% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 8, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-30% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 9, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-20% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 10, 0, 2, 0, 100, 1, 0, 10, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Between 0-10% Health - Cast \'Toughen\' (Phase 2)'),
(16870, 0, 11, 0, 6, 0, 10, 513, 0, 0, 0, 0, 0, 0, 11, 38879, 7, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - On Just Died - Cast \'Soul Burden\' (Phase 2)'),
(16870, 0, 12, 0, 108, 0, 100, 0, 0, 582000, 0, 0, 0, 0, 5, 37, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - On Point Any of Path 582000 Reached - Play Emote 37'),
(16870, 0, 13, 0, 108, 0, 100, 0, 0, 582010, 0, 0, 0, 0, 5, 37, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - On Point Any of Path 582010 Reached - Play Emote 37'),
(16870, 0, 14, 0, 108, 0, 100, 0, 0, 582020, 0, 0, 0, 0, 5, 37, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - On Point Any of Path 582020 Reached - Play Emote 37'),
(16870, 0, 15, 0, 108, 0, 100, 0, 0, 582030, 0, 0, 0, 0, 5, 37, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - On Point Any of Path 582030 Reached - Play Emote 37');
