-- DB update 2021_10_09_02 -> 2021_10_09_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_09_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_09_02 2021_10_09_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633358951858926600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633358951858926600');

 -- Baron Rivendare
SET @ENTRY := 10440;
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ENTRY AND `source_type` = 0;
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 7000, 11000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 7 - 11 seconds (4 - 9s initially) - Self: Cast spell 15284 on Victim'),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 6000, 9000, 11, 17393, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 6 - 9 seconds (1 - 6s initially) - Self: Cast spell 17393 on Victim'),
(@ENTRY, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 9000, 15000, 11, 15708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 9 - 15 seconds (7 - 11s initially) - Self: Cast spell 15708 on Victim'),
(@ENTRY, 0, 3, 0, 0, 0, 100, 1, 0, 0, 0, 0, 11, 17467, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Once - Self: Cast spell 17467 on Self (flags: triggered)'),
(@ENTRY, 0, 4, 5, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 17473, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (10s initially) - Self: Cast spell 17473 on Self'),
(@ENTRY, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (10s initially) - Self: Talk 7 to invoker'),
(@ENTRY, 0, 6, 0, 0, 0, 100, 0, 22000, 22000, 20000, 20000, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (22s initially) - Self: Talk 8 to invoker'),
(@ENTRY, 0, 7, 8, 0, 0, 100, 0, 11000, 11000, 20000, 20000, 11, 17475, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17475 on Self (flags: triggered)'),
(@ENTRY, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17476, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17476 on Self (flags: triggered)'),
(@ENTRY, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17477, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17477 on Self (flags: triggered)'),
(@ENTRY, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17478, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17478 on Self (flags: triggered)'),
(@ENTRY, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17479, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17479 on Self (flags: triggered)'),
(@ENTRY, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17480, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17480 on Self (flags: triggered)'),
(@ENTRY, 0, 13, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 16031, 100, 0, 0, 0, 0, 0, 'On death - Closest alive creature Ysida Harmon (16031) in 100 yards: Set creature data #2 to 2'),
(@ENTRY, 0, 14, 0, 4, 0, 100, 0, 0, 0, 0, 0, 202, 1, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 'On aggro - Gameobject with guid 35848: Set gameobject state to ready'),
(@ENTRY, 0, 15, 0, 6, 0, 100, 0, 0, 0, 0, 0, 202, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 'On death - Gameobject with guid 35848: Set gameobject state to active'),
(@ENTRY, 0, 16, 0, 25, 0, 100, 0, 0, 0, 0, 0, 202, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 'On reset - Gameobject with guid 35848: Set gameobject state to active'),
(@ENTRY, 0, 17, 18, 0, 0, 100, 0, 1000, 1000, 100, 100, 202, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 'Every 0.1 seconds (1s initially) - Gameobject with guid 35848: Set gameobject state to active'),
(@ENTRY, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 0.1 seconds (1s initially) - Self: Evade');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 10440 AND `SourceId` = 0;

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(22, 18, 10440, 0, 0, 30, 1, 175405, 21, 0, 0, 'There is gameobject Doodad_ZigguratDoor04 (175405) within range 21 yards to Object'),
(22, 18, 10440, 0, 1, 30, 1, 175796, 4, 0, 0, 'There is gameobject Doodad_ZigguratDoor05 (175796) within range 4 yards to Object'),
(22, 18, 10440, 0, 1, 30, 1, 176631, 13, 0, 1, 'There is no gameobject Menethils Gift (176631) within range 13 yards to Object');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_09_03' WHERE sql_rev = '1633358951858926600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
