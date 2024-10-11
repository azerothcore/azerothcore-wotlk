-- DB update 2021_11_03_03 -> 2021_11_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_03_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_03_03 2021_11_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632387086658999212'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632387086658999212');

SET @NPC := 37385;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature` WHERE `guid` = 205803 AND `id` = 2321;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(205803, 2321, 1, 0, 0, 1, 1, 1042, 0, 4520.04, 661.485, 24.6147, 4.93543, 275, 0, 0, 222, 0, 0, 0, 0, 0, '', 0);


DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,0,0,1,0, '');

DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`, `delay`) VALUES
(@PATH, 1, 4516.77, 607.805, 31.7845, 0),
(@PATH, 2, 4519.16, 571.186, 32.5817, 0),
(@PATH, 3, 4506.04, 545.204, 39.1878, 0),
(@PATH, 4, 4484.27, 524.398, 43.4054, 0),
(@PATH, 5, 4475.53, 496.37, 48.935, 0),
(@PATH, 6, 4462.23, 486.497, 50.0938, 0),
(@PATH, 7, 4448, 483.935, 50.4496, 0),
(@PATH, 8, 4414.98, 478.825, 57.0827, 0),
(@PATH, 9, 4375.29, 464.64, 61.9022, 0),
(@PATH, 10, 4351.72, 441.123, 60.2804, 0),
(@PATH, 11, 4346.24, 420.217, 60.9888, 0),
(@PATH, 12, 4339.67, 403.893, 61.593, 0),
(@PATH, 13, 4322.4, 397.517, 62.6931, 0),
(@PATH, 14, 4300.05, 404.118, 62.2459, 0),
(@PATH, 15, 4283.83, 413.06, 60.7891, 0),
(@PATH, 16, 4276.19, 431.525, 61.5429, 0),
(@PATH, 17, 4278.02, 448.285, 60.9137, 0),
(@PATH, 18, 4299.49, 481.952, 60.6362, 0),
(@PATH, 19, 4369.62, 540.487, 59.3641, 0),
(@PATH, 20, 4404.23, 564.665, 48.7928, 0),
(@PATH, 21, 4425.79, 586.472, 42.1827, 0),
(@PATH, 22, 4430.26, 606.587, 39.6061, 0),
(@PATH, 23, 4437.38, 624.615, 36.918, 0),
(@PATH, 24, 4455.5, 639.752, 31.2693, 0),
(@PATH, 25, 4474.88, 666.869, 26.2529, 0),
(@PATH, 26, 4500.03, 694.421, 24.5656, 0),
(@PATH, 27, 4513.71, 706.448, 23.2624, 0),
(@PATH, 28, 4528.3, 704.51, 24.6299, 0),
(@PATH, 29, 4535.2, 690.152, 25.2516, 4000),
(@PATH, 30, 4520.51, 660.629, 24.7118, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID`=@NPC;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@NPC, @NPC, 0, 0, 2, 0, 0),
(@NPC, 36692, 2, 120, 514, 0, 0),
(@NPC, 205803, 2, 210, 514, 0, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_04_00' WHERE sql_rev = '1632387086658999212';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
