--

UPDATE `creature` SET `MovementType` = 2 WHERE  `guid` = 58200;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-58200, -58201, -58202, -58203) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-58200, 0, 0, 0, 1, 0, 100, 0, 0, 0, 3000, 4000, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Out of Combat - Play Emote 36'),
(-58201, 0, 0, 0, 1, 0, 100, 0, 0, 0, 3000, 4000, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Out of Combat - Play Emote 36'),
(-58202, 0, 0, 0, 1, 0, 100, 0, 0, 0, 3000, 4000, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Out of Combat - Play Emote 36'),
(-58203, 0, 0, 0, 1, 0, 100, 0, 0, 0, 3000, 4000, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Out of Combat - Play Emote 36');

DELETE FROM `waypoint_data` WHERE `id` = 688320;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(688320,1,-221.66,3100.17,-60.135,3.469,0,0,0,100,0),
(688320,2,-238.637,3090.82,-63.946,3.971,0,0,0,100,0),
(688320,3,-247.844,3079.22,-65.416,0.835,0,0,0,100,0);

UPDATE `creature_addon` SET `path_id` = 688320 WHERE `guid` = 68832;
