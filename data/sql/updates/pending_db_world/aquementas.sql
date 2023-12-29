--
DELETE FROM `event_scripts` WHERE `id` = 3708;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(3708, 3, 10, 9453, 300000, 0, -8179.4556, -5169.8413, 3.9927793, 1.343903542);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 9453;

DELETE FROM `waypoints` WHERE `entry` = 945300;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(945300, 1, -8183.2085, -5121.261, 6.3173885, NULL, 0, 'Aquementas - to circle'),
(945300, 2, -8183.7007, -5114.497, 7.2097836, NULL, 0, 'Aquementas - to circle'),
(945300, 3, -8184.022, -5108.7856, 8.065002, NULL, 0, 'Aquementas - to circle'),
(945300, 4, -8181.2485, -5093.14, 11.191019, NULL, 0, 'Aquementas - to circle'),
(945300, 5, -8170.1807, -5077.4907, 16.019186, NULL, 0, 'Aquementas - to circle');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 9453 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9453, 0, 0, 0, 0, 0, 100, 0, 10200, 10200, 12600, 15840, 0, 0, 11, 15089, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - IC - Cast spell \'Frost Shock\''),
(9453, 0, 1, 0, 0, 0, 100, 0, 11800, 11800, 29300, 30480, 0, 0, 11, 13586, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - IC - Cast spell \'Aqua Jet\''),
(9453, 0, 2, 3, 54, 0, 100, 513, 0, 0, 0, 0, 0, 0, 11, 7398, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Just Summoned - Cast spell \'Birth\''),
(9453, 0, 3, 4, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Just Summoned - Disable evade'),
(9453, 0, 4, 5, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Just Summoned - Say 0'),
(9453, 0, 5, 6, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Just Summoned - Set faction friendly'),
(9453, 0, 6, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Just Summoned - Do timed event'),
(9453, 0, 7, 0, 59, 0, 100, 513, 1, 0, 0, 0, 0, 0, 53, 1, 945300, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Start WP'),
(9453, 0, 8, 0, 40, 0, 100, 513, 5, 0, 0, 0, 0, 0, 67, 2, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On WP reached - Do timed event'),
(9453, 0, 9, 10, 59, 0, 100, 513, 2, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Waypoint stop'),
(9453, 0, 10, 11, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 2, 91, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Set faction elemental'),
(9453, 0, 11, 12, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Say 1'),
(9453, 0, 12, 13, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Emote 2'),
(9453, 0, 13, 14, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 11, 13910, 0, 0, 0, 0, 0, 17, 0, 50, 5, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Cast spell \'Force Create Elemental Totem\''),
(9453, 0, 14, 15, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Emote 3'),
(9453, 0, 15, 16, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Set react aggressive'),
(9453, 0, 16, 20, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 123, 1000, 0, 0, 0, 0, 0, 17, 0, 30, 5, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Add threat to nearby players'),
(9453, 0, 17, 0, 59, 0, 100, 513, 2, 0, 0, 0, 0, 0, 56, 11522, 1, 0, 0, 0, 0, 17, 0, 30, 5, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Add item'),
(9453, 0, 18, 0, 59, 0, 100, 513, 2, 0, 0, 0, 0, 0, 57, 11172, 11, 0, 0, 0, 0, 17, 0, 30, 5, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Remove item'),
(9453, 0, 19, 0, 59, 0, 100, 513, 2, 0, 0, 0, 0, 0, 57, 11173, 1, 0, 0, 0, 0, 17, 0, 30, 5, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Remove item'),
(9453, 0, 20, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On timed event triggered - Enable evade'),
(9453, 0, 21, 0, 7, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On evade - Despawn');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 9453 AND `SourceId` = 0 AND `SourceGroup` = 18;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 18, 9453, 0, 0, 47, 0, 4005, 8, 0, 0, 0, 0, '', 'Has quest Aquementas');
