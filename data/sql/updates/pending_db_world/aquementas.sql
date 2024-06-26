--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9453);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9453, 0, 0, 0, 0, 0, 100, 0, 10200, 10200, 12600, 15840, 0, 0, 11, 15089, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - In Combat - Cast \'Frost Shock\''),
(9453, 0, 1, 0, 0, 0, 100, 0, 11800, 11800, 29300, 30480, 0, 0, 11, 13586, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - In Combat - Cast \'Aqua Jet\''),
(9453, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 945300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On Just Summoned - Run Script'),
(9453, 0, 3, 0, 58, 0, 100, 0, 0, 945300, 0, 0, 0, 0, 80, 945301, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - On Path 945300 Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 945300) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(945300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 7398, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Cast \'Birth\''),
(945300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Set Faction 35'),
(945300, 9, 2, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Say Line 0'),
(945300, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 945300, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Start Waypoint Path 945300');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 945301);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(945301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Say Line 1'),
(945301, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Set Orientation Closest Player'),
(945301, 9, 2, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Say Line 2'),
(945301, 9, 3, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Say Line 3'),
(945301, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 13910, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Cast \'Create Elemental Totem\''),
(945301, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 57, 11172, 11, 0, 0, 0, 0, 17, 0, 40, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Remove Item \'Silvery Claws\' 11 Times'),
(945301, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 57, 11173, 1, 0, 0, 0, 0, 17, 0, 40, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Remove Item \'Irontree Heart\' 1 Time'),
(945301, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 56, 11522, 1, 0, 0, 0, 0, 17, 0, 40, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Add Item \'Silver Totem of Aquementas\' 1 Time'),
(945301, 9, 8, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 0, 2, 91, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Set Faction 91'),
(945301, 9, 9, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Aquementas - Actionlist - Start Attacking');

DELETE FROM `event_scripts` WHERE `id` = 3708;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(3708, 3, 10, 9453, 300000, 0, -8179.4556, -5169.8413, 3.9927793, 1.343903542);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 9453;

DELETE FROM `waypoints` WHERE `entry` = 945300;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(945300, 1, -8183.2085, -5121.261, 6.3173885, NULL, 0, 'Aquementas'),
(945300, 2, -8183.7007, -5114.497, 7.2097836, NULL, 0, 'Aquementas'),
(945300, 3, -8184.022, -5108.7856, 8.065002, NULL, 0, 'Aquementas'),
(945300, 4, -8181.2485, -5093.14, 11.191019, NULL, 0, 'Aquementas'),
(945300, 5, -8170.1807, -5077.4907, 16.019186, NULL, 0, 'Aquementas');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 13978);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 13978, 0, 0, 2, 0, 11172, 11, 0, 0, 0, 0, '', 'Spell \'Summon Aquementas\' (13978) needs 11 \'Silvery Claws\' (11172) in inventory'),
(17, 0, 13978, 0, 0, 2, 0, 11173, 1, 0, 0, 0, 0, '', 'Spell \'Summon Aquementas\' (13978) needs 1 \'Irontree Heart\' (11173) in inventory');

