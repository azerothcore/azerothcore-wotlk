--
-- Gerenzo's Orders (quest 1090): wave paths for the Windshear attackers
DELETE FROM `waypoint_data` WHERE `id` IN (427601, 427602);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
(427601, 1, 944.4445, -255.94446, -2.7950513, NULL, 0, 0),
(427601, 2, 950.1888, -257.03415, -3.0987809, NULL, 0, 0),
(427601, 3, 953.7671, -258.39548, -3.5265486, NULL, 0, 0),
(427601, 4, 960.332, -260.597, -5.78864, 5.99669, 0, 0),
(427602, 1, 944.28644, -255.18642, -2.7152529, NULL, 0, 0),
(427602, 2, 946.54144, -256.04645, -3.0640638, NULL, 0, 0),
(427602, 3, 951.118, -257.7668, -3.1646798, NULL, 0, 0),
(427602, 4, 954.56036, -259.11758, -3.6698236, NULL, 0, 0),
(427602, 5, 960.332, -260.597, -5.78864, 5.99669, 0, 0);

-- Wave leader lines: add Windshear Geomancer text and make the leader lines yells
DELETE FROM `creature_text` WHERE `CreatureID` = 4003 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(4003, 0, 0, 'I think the sounds came from over here. We''d better check it out.', 14, 0, 100, 0, 0, 0, 1430, 0, 'Windshear Geomancer');

UPDATE `creature_text` SET `Type` = 14 WHERE `CreatureID` = 4001 AND `GroupID` = 0;
UPDATE `creature_text` SET `Type` = 14 WHERE `CreatureID` = 4004 AND `GroupID` = 1;

-- Piznik - event timed action list: 3 waves walking a path
DELETE FROM `smart_scripts` WHERE `entryorguid` = 427600 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(427600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Remove Flags Immune To NPC''s'),
(427600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Set Npc Flags None'),
(427600, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Say Line 0'),
(427600, 9, 3, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 0, 0, 12, 3998, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 937.8112, -254.16438, -2.0966728, 0.38397, 'Piznik - Actionlist - Summon Creature ''Windshear Vermin'''),
(427600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 3998, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 938.6028, -256.62613, -2.1013877, 0.174533, 'Piznik - Actionlist - Summon Creature ''Windshear Vermin'''),
(427600, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 4001, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 936.6871, -255.91563, -2.2386348, 0.296706, 'Piznik - Actionlist - Summon Creature ''Windshear Tunnel Rat'''),
(427600, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 232, 427601, 0, 0, 0, 0, 0, 204, 3998, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Vermin'' Start Path 427601'),
(427600, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 427601, 0, 0, 0, 0, 0, 204, 4001, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Tunnel Rat'' Start Path 427601'),
(427600, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 204, 4001, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Tunnel Rat'' Say Line 0'),
(427600, 9, 9, 0, 0, 0, 100, 0, 90000, 90000, 0, 0, 0, 0, 12, 3999, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 937.0794, -258.10092, -2.2683077, 0.488692, 'Piznik - Actionlist - Summon Creature ''Windshear Digger'''),
(427600, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 3999, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 935.8944, -256.35678, -2.3162427, 0.698131, 'Piznik - Actionlist - Summon Creature ''Windshear Digger'''),
(427600, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 4003, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 934.352, -258.0696, -2.2152097, 0.680678, 'Piznik - Actionlist - Summon Creature ''Windshear Geomancer'''),
(427600, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 4003, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 935.28754, -258.9255, -2.2095058, 0.575958, 'Piznik - Actionlist - Summon Creature ''Windshear Geomancer'''),
(427600, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 427602, 0, 0, 0, 0, 0, 204, 3999, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Digger'' Start Path 427602'),
(427600, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 427602, 0, 0, 0, 0, 0, 204, 4003, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Geomancer'' Start Path 427602'),
(427600, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 204, 4003, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Geomancer'' Say Line 0'),
(427600, 9, 16, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Say Line 1'),
(427600, 9, 17, 0, 0, 0, 100, 0, 91600, 91600, 0, 0, 0, 0, 12, 4002, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 937.0794, -258.10092, -2.2683077, 0.488692, 'Piznik - Actionlist - Summon Creature ''Windshear Stonecutter'''),
(427600, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 4002, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 935.8944, -256.35678, -2.3162427, 0.698131, 'Piznik - Actionlist - Summon Creature ''Windshear Stonecutter'''),
(427600, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 4002, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 934.352, -258.0696, -2.2152097, 0.680678, 'Piznik - Actionlist - Summon Creature ''Windshear Stonecutter'''),
(427600, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 4004, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 935.28754, -258.9255, -2.2095058, 0.575958, 'Piznik - Actionlist - Summon Creature ''Windshear Overlord'''),
(427600, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 427602, 0, 0, 0, 0, 0, 204, 4002, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Stonecutter'' Start Path 427602'),
(427600, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 427602, 0, 0, 0, 0, 0, 204, 4004, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Overlord'' Start Path 427602'),
(427600, 9, 23, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 204, 4004, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Summoned ''Windshear Overlord'' Say Line 1'),
(427600, 9, 24, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Say Line 2'),
(427600, 9, 25, 0, 0, 0, 100, 0, 90000, 90000, 0, 0, 0, 0, 26, 1090, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Quest Credit ''Gerenzo''s Orders'''),
(427600, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Say Line 3'),
(427600, 9, 27, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 0, 1, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Despawn Alive Summons'),
(427600, 9, 28, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Set Flags Immune To NPC''s'),
(427600, 9, 29, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - Actionlist - Set Npc Flag Questgiver');

-- Piznik - start the event, store the accepting player, clean up on death
DELETE FROM `smart_scripts` WHERE `entryorguid` = 4276 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4276, 0, 0, 0, 19, 0, 100, 512, 1090, 0, 0, 0, 0, 0, 80, 427600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - On Quest ''Gerenzo''s Orders'' Taken - Run Script'),
(4276, 0, 1, 0, 19, 0, 100, 512, 1090, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - On Quest ''Gerenzo''s Orders'' Taken - Store Targetlist'),
(4276, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - On Death - Stop Script'),
(4276, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 1090, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Piznik - On Death - Fail Quest ''Gerenzo''s Orders'' (Stored Target)'),
(4276, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 1090, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'Piznik - On Death - Fail Quest ''Gerenzo''s Orders'' (Players In 40 Yards)'),
(4276, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 0, 1, 0, 0, 0, 0, 0, 0, 'Piznik - On Death - Despawn Alive Summons'),
(4276, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Piznik - On Death - Set Flags Immune To NPC''s');
