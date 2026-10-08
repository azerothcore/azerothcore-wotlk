-- DB update 2026_10_06_04 -> 2026_10_06_05
--
SET @BRONWYN := 21197;
SET @BORGRIM := 21151;
SET @PATH := 743320;
UPDATE `waypoint_data` SET `delay` = 220000, `orientation` = 1.96886 WHERE `id` = @PATH AND `point` = 1;
UPDATE `waypoint_data` SET `delay` = 24000, `action` = 0 WHERE `id` = @PATH AND `point` = 2;
DELETE FROM `waypoint_scripts` WHERE `id` IN (226, 228);
UPDATE `waypoint_data` SET `action` = 0 WHERE `id` = 742150 AND `point` = 5;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @BRONWYN;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @BRONWYN AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @BRONWYN*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@BRONWYN, 0, 0, 0, 108, 0, 100, 0, 2, @PATH, 0, 0, 0, 0, 80, @BRONWYN*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronwyn Stouthammer - On Waypoint 2 Reached - Run Script'),
(@BRONWYN*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronwyn Stouthammer - On Script - Set Emote State 0'),
(@BRONWYN*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.0192242, 'Bronwyn Stouthammer - On Script - Set Orientation'),
(@BRONWYN*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronwyn Stouthammer - On Script - Say Line 0'),
(@BRONWYN*100, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @BORGRIM, 50, 0, 0, 0, 0, 0, 0, 'Bronwyn Stouthammer - On Script - Say Line 1 (Borgrim Stouthammer)'),
(@BRONWYN*100, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronwyn Stouthammer - On Script - Say Line 1'),
(@BRONWYN*100, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, @BORGRIM, 50, 0, 0, 0, 0, 0, 0, 'Bronwyn Stouthammer - On Script - Say Line 2 (Borgrim Stouthammer)'),
(@BRONWYN*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.96886, 'Bronwyn Stouthammer - On Script - Set Orientation'),
(@BRONWYN*100, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronwyn Stouthammer - On Script - Set Emote State 69');

DELETE FROM `creature_text` WHERE `CreatureID` = @BRONWYN;
DELETE FROM `creature_text` WHERE `CreatureID` = @BORGRIM AND `GroupID` IN (1, 2);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@BRONWYN, 0, 0, 'Borgrim, this is no time for drinking.  We just got here.  We need to get settled in.', 12, 7, 100, 6, 0, 0, 18813, 0, 'Bronwyn Stouthammer'),
(@BRONWYN, 1, 0, 'Men!', 12, 7, 100, 0, 0, 0, 18819, 0, 'Bronwyn Stouthammer'),
(@BORGRIM, 1, 0, 'I thought this was going to be our chance to get away from it all?  Our vacation?', 12, 7, 100, 6, 0, 0, 18817, 0, 'Borgrim Stouthammer'),
(@BORGRIM, 1, 1, 'Right.  We just busted our tails to haul all of this stuff up here, and you want to work more?', 12, 7, 100, 6, 0, 0, 18816, 0, 'Borgrim Stouthammer'),
(@BORGRIM, 2, 0, 'Women!', 12, 7, 100, 0, 0, 0, 18818, 0, 'Borgrim Stouthammer');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 1 AND `SourceEntry` = @BRONWYN AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, @BRONWYN, 0, 0, 29, 1, @BORGRIM, 50, 0, 0, 0, 0, '', 'Bronwyn Stouthammer - Only argue when Borgrim Stouthammer is alive within 50 yards');
