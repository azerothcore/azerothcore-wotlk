-- DB update 2026_08_11_07 -> 2026_08_11_08
--
-- Quest 619 "Enticing Negolash": Negolash (1494) should not attack the summoner.
-- He spawns in the sea, yells once and slowly walks a sniffed path towards the Ruined Lifeboat (GO 2289),
-- then faces the closest player and yells again.
-- Spawn position and waypoints from sniff, spawn position matches vmangos quest_end_scripts.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2289 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2289, 1, 0, 0, 20, 0, 100, 0, 619, 0, 0, 0, 0, 0, 12, 1494, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -14598.613, 76.05631, -11.248953, 0.925025, 'Ruined Lifeboat - On Quest ''Enticing Negolash'' Rewarded - Summon Negolash'),
(2289, 1, 1, 0, 20, 0, 100, 0, 619, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruined Lifeboat - On Quest ''Enticing Negolash'' Rewarded - Summon Gameobject Group 0');

-- Negolash: yell once on summon, then walk waypoint path 14941 to the boat
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1494 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1494, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Just Summoned - Say Line 0'),
(1494, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 14941, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Just Summoned - Start Waypoint Path 14941'),
(1494, 0, 2, 3, 109, 0, 100, 0, 0, 14941, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Waypoint Path 14941 Ended - Set Orientation Closest Player'),
(1494, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Link - Say Line 1');

-- Sniffed path from the sea to the Ruined Lifeboat, walking
DELETE FROM `waypoint_data` WHERE `id` = 14941;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(14941, 1, -14604.297, 89.271706, -9.999119, NULL, 0, 0, 0, 0, 0, 100, 0),
(14941, 2, -14614.698, 108.31858, -8.333432, NULL, 0, 0, 0, 0, 0, 100, 0),
(14941, 3, -14626.871, 127.859375, -4.644101, NULL, 0, 0, 0, 0, 0, 100, 0),
(14941, 4, -14647.208, 142.4898, 0.73462296, NULL, 0, 0, 0, 0, 0, 100, 0);

-- Second yell when he reaches the food (BroadcastTextId 763)
DELETE FROM `creature_text` WHERE `CreatureID` = 1494;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(1494, 0, 0, 'Mmmh...I SMELL FOOD!', 14, 0, 100, 0, 0, 0, 731, 0, 'Negolash - On Just Summoned'),
(1494, 1, 0, 'AH, A FEAST!  WHO LEFT THIS HERE...?', 14, 0, 100, 0, 0, 0, 763, 0, 'Negolash - On Waypoint Path Ended');

-- Conditions to avoid double spawns
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 2289) AND (`SourceId` = 1) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 1494) AND (`ConditionValue2` = 100) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 2289, 1, 0, 29, 1, 1494, 100, 0, 1, 0, 0, '', 'Don\'t spawn a new Negolash if there\'s one already up.');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 2289) AND (`SourceId` = 1) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 2332) AND (`ConditionValue2` = 20) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 2289, 1, 0, 30, 1, 2332, 20, 0, 1, 0, 0, '', 'Don\'t summon gameobjects in Enticing Negolash if there are already objects nearby');
