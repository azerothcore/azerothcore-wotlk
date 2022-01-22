-- DB update 2021_09_01_21 -> 2021_09_01_22
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_21';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_21 2021_09_01_22 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630252354413939245'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630252354413939245');

-- Jarwen Thunderbrew (NPC 1373) actions,  quests and waypoints

SET @Jarven := 1373;

DELETE FROM `creature_text` WHERE `CreatureID`= @Jarven AND `GroupID`= 0;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(@Jarven,0,0,(SELECT `MaleText` FROM `broadcast_text` WHERE `id`= 127), 12, 7, 100, 1, 0,0, 127,0, "Jarven Thunderbrew - asks player to watch the barrels");

-- Updated position and spawn timing
UPDATE `gameobject` SET `position_x`= -5607.24, `position_y`= -547.934, `position_z`= 392.985 WHERE `id`= 270;
UPDATE `gameobject` SET `spawntimesecs` = 1 WHERE (`id` = 269) AND (`guid` IN (1037));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1373);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@Jarven, 0, 0, 1, 20, 0, 100, 0, 308, 0, 0, 0, 0, 53, 0, 1373, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Quest \'Distracting Jarven\' Finished - Start Waypoint'),
(@Jarven, 0, 1, 2, 61, 0, 100, 0, 308, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Quest \'Distracting Jarven\' Finished - Remove Npc Flags Questgiver'),
(@Jarven, 0, 2, 0, 61, 0, 100, 0, 308, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Quest \'Distracting Jarven\' Finished - Say Line 0'),
(@Jarven, 0, 3, 0, 40, 0, 100, 0, 2, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 13, 269, 0, 1000, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Waypoint 2 Reached - Despawn  \'Guarded Thunder Ale Barrel\''),
(@Jarven, 0, 4, 0, 40, 0, 100, 0, 2, 0, 0, 0, 0, 50, 270, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -5607.24, -547.934, 392.985, 0, 'Jarven Thunderbrew - On Waypoint 2 Reached - Respawn  \'Unguarded Thunder Ale Barrel\''),
(@Jarven, 0, 5, 6, 40, 0, 100, 0, 8, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Waypoint 8 Reached - Say Line 1'),
(@Jarven, 0, 6, 7, 61, 0, 100, 0, 8, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.6724, 'Jarven Thunderbrew - On Waypoint 8 Reached - Turn'),
(@Jarven, 0, 7, 0, 61, 0, 100, 0, 8, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Waypoint 8 Reached - Pause Waypoint'),
(@Jarven, 0, 8, 0, 40, 0, 100, 0, 15, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Waypoint 15 Reached - Say Line 2'),
(@Jarven, 0, 9, 0, 40, 0, 100, 0, 14, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 13, 270, 0, 1000, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Waypoint 14 Reached - Despawn  \'Unguarded Thunder Ale Barrel\''),
(@Jarven, 0, 10, 0, 40, 0, 100, 0, 14, 0, 0, 0, 0, 50, 269, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -5607.24, -547.934, 392.985, 0, 'Jarven Thunderbrew - On Waypoint 14 Reached - Respawn  \'Guarded Thunder Ale Barrel\''),
(@Jarven, 0, 11, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Waypoint Finished - Say Line 3'),
(@Jarven, 0, 12, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jarven Thunderbrew - On Waypoint Finished - Add Npc Flags Questgiver'),
(@Jarven, 0, 13, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 2, 3, 5, 0, 0, 0, 0, 'Jarven Thunderbrew - On Waypoint Finished - Set Orientation');

-- Routes
DELETE FROM `waypoints` WHERE `entry`= @Jarven;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@Jarven,  1, -5601.64, -541.38, 392.42, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven,  2, -5597.94, -542.04, 392.42, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven,  3, -5597.95, -548.43, 395.48, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven,  4, -5605.31, -549.33, 399.09, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven,  5, -5607.55, -546.63, 399.09, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven,  6, -5597.52, -538.75, 399.09, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven,  7, -5597.62, -530.24, 399.65, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven,  8, -5603.67, -529.91, 399.65, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven,  9, -5603.67, -529.91, 399.65, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven, 10, -5597.62, -530.24, 399.65, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven, 11, -5597.52, -538.75, 399.09, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven, 12, -5607.55, -546.63, 399.09, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven, 13, -5605.31, -549.33, 399.09, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven, 14, -5597.95, -548.43, 395.48, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven, 15, -5597.94, -542.04, 392.42, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven, 16, -5601.64, -541.38, 392.42, 'Jarven Thunderbrew - Quest 308 Waypoint movement'),
(@Jarven, 17, -5605.96, -544.45, 392.43, 'Jarven Thunderbrew - Quest 308 Waypoint movement');

DELETE FROM `conditions` WHERE `SourceEntry` IN (403,308) AND `SourceTypeOrReferenceId` IN (19);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19, 0, 403, 0, 0, 28, 0, 310, 0, 0, 0, 0, 0, '', 'Show quest \'Guarded Thunderbrew Barrel\' if quest \'Bitter Rivals\' is completed'),
(19 ,0, 308, 0, 0, 28, 0, 310, 0, 0, 0, 0, 0, '', 'Show quest \'Distracting Jarven\' if quest \'Guarded Thunderbrew Barrel\' is completed');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_22' WHERE sql_rev = '1630252354413939245';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
