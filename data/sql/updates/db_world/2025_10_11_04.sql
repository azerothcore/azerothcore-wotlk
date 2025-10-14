-- DB update 2025_10_11_03 -> 2025_10_11_04
--
DELETE FROM `creature` WHERE (`guid` = 248652) AND (`id1` = 14693);
DELETE FROM `game_event_creature` WHERE (`guid` = 248652) AND (`eventEntry` = 120);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4543) AND (`source_type` = 0) AND (`id` IN (7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4543, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 14693, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1797.84, 1233.68, 18.3153, 1.58286, 'Bloodmage Thalnos - On Just Died - Summon Creature \'Scorn\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14693;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14693) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14693, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 1469300, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scorn - On Just Summoned - Start Patrol Path 1469300');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 8) AND (`SourceEntry` = 4543) AND (`SourceId` = 0) AND (`ElseGroup` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 8, 4543, 0, 0, 12, 0, 120, 0, 0, 0, 0, 0, '', 'Scourge Invasion - Boss in instance activation event must be active');

SET @ENTRY := 14693;
DELETE FROM `waypoints` WHERE `entry` = @ENTRY * 100;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(@ENTRY*100, 1, 1798.01, 1312.39, 18.69,  NULL, 0, 'Scorn'),
(@ENTRY*100, 2, 1805.39, 1323.66, 18.91,  NULL, 0, 'Scorn'),
(@ENTRY*100, 3, 1797.70, 1383.27, 18.76,  NULL, 0, 'Scorn'),
(@ENTRY*100, 4, 1805.39, 1323.66, 18.91,  NULL, 0, 'Scorn'),
(@ENTRY*100, 5, 1798.01, 1312.39, 18.69,  NULL, 0, 'Scorn'),
(@ENTRY*100, 6, 1798.01, 1223.17, 18.274, NULL, 0, 'Scorn - spawn point');
