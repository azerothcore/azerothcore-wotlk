-- The Thandol Span (quests 631 and 632): bombardier ambush
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2652 AND `source_type` = 1;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (265200) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2652, 1, 0, 0, 20, 0, 100, 0, 631, 0, 0, 0, 0, 0, 80, 265200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ebenezer Rustlocke''s Corpse - On Quest ''The Thandol Span'' Finished - Run Script'),
(2652, 1, 1, 0, 17, 0, 100, 0, 4062, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ebenezer Rustlocke''s Corpse - On Summoned Unit ''Dark Iron Bombardier'' - Store Targetlist 1'),
(265200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 4062, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -2370.93, -2523.82, 74.639, 2.56563, 'Ebenezer Rustlocke''s Corpse - Actionlist - Summon Creature ''Dark Iron Bombardier'' (ambusher)'),
(265200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ebenezer Rustlocke''s Corpse - Actionlist - Do Action ID 1 (ambusher)'),
(265200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 4062, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -2372.22, -2483.47, 74.639, 0.174533, 'Ebenezer Rustlocke''s Corpse - Actionlist - Summon Creature ''Dark Iron Bombardier'' (scout)'),
(265200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ebenezer Rustlocke''s Corpse - Actionlist - Do Action ID 2 (scout)');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 2652 AND `SourceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 2652, 1, 0, 29, 1, 4062, 30, 0, 1, 0, 0, '', 'no living Dark Iron Bombardier within 30 yd of the corpse');
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` = 2652;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 4062 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (406200, 406201) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4062, 0, 0, 0, 9, 0, 100, 0, 0, 0, 6000, 9000, 5, 30, 11, 8858, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - Within 5-30 Range - Cast ''Bomb'''),
(4062, 0, 1, 2, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - On Action 1 Done (ambusher) - Say Line 0'),
(4062, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - On Action 1 Done (ambusher) - Set Run Off'),
(4062, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -2367.14, -2510.34, 75.344, 0, 'Dark Iron Bombardier - On Action 1 Done (ambusher) - Move To Position (corpse)'),
(4062, 0, 4, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 406200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - On Action 2 Done (scout) - Run Script'),
(4062, 0, 5, 0, 108, 0, 100, 1, 10, 406200, 0, 0, 0, 0, 80, 406201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - On Path 406200 Point 10 Reached (scout) - Run Script (No Repeat)'),
(4062, 0, 6, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - Between 0-15% Health - Flee For Assist (No Repeat)'),
(406200, 9, 0, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - Actionlist - Say Line 1'),
(406200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 406200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - Actionlist - Start Waypoint Path 406200'),
(406201, 9, 0, 0, 0, 0, 100, 0, 1350, 1350, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Bombardier - Actionlist - Say Line 2');
DELETE FROM `creature_text` WHERE `CreatureID` = 4062;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(4062, 0, 0, 'Still no sign of the final shipment of explosives.', 12, 7, 100, 0, 0, 0, 782, 0, 'Dark Iron Bombardier'),
(4062, 1, 0, 'No sign of the final explosives shipment to the west either.  Where are those lollygaggers?', 12, 7, 100, 0, 0, 0, 783, 0, 'Dark Iron Bombardier'),
(4062, 2, 0, 'This bridge should have been destroyed by now.  How long does it take for those lazy sods to get here from the Highlands!', 12, 7, 100, 0, 0, 0, 784, 0, 'Dark Iron Bombardier');
DELETE FROM `creature_text_locale` WHERE `CreatureID` = 4062 AND (`GroupID`, `ID`) IN ((0, 1), (0, 2), (1, 1));

DELETE FROM `waypoint_data` WHERE `id` = 406200;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(406200, 1, -2372.22, -2483.47, 74.639, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 2, -2367.64, -2490.22, 75.3518, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 3, -2376.87, -2491.26, 75.3518, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 4, -2376.84, -2494.79, 75.3518, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 5, -2372.98, -2495.34, 75.3518, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 6, -2372.84, -2498.69, 75.3518, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 7, -2376.55, -2499.26, 75.3518, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 8, -2376.83, -2504.26, 78.3924, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 9, -2376.31, -2511.21, 82.5887, NULL, 0, 0, 0, 0, 0, 100, 0),
(406200, 10, -2372.12, -2514.59, 82.3518, NULL, 0, 1400, 0, 0, 0, 100, 0),
(406200, 11, -2371.23, -2513.61, 82.3518, NULL, 0, 0, 0, 0, 0, 100, 0);
