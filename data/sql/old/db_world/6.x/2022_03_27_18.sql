-- DB update 2022_03_27_17 -> 2022_03_27_18
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_17 2022_03_27_18 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648309713111396700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648309713111396700');

SET @CGUID := 2000060;
DELETE FROM `creature_addon` WHERE `guid` BETWEEN 84556 AND 84566;
DELETE FROM `linked_respawn` WHERE `guid` BETWEEN 84556 AND 84566;
DELETE FROM `linked_respawn` WHERE `guid` IN (85788,85793,85797,85798,85799,85802,85805);
DELETE FROM `creature` WHERE `id1`=12468;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`) VALUES
(@CGUID,12468,469,1,1,1,-7655.51,-1100.16,449.243,3.54007,600,0,0,1,0,2,0,0,0,''),
(@CGUID+1,12468,469,1,1,1,-7592.86,-1075.23,449.246,2.65568,600,0,0,1,0,2,0,0,0,''),
(@CGUID+2,12468,469,1,1,1,-7673.25,-1039.96,440.28,2.46326,600,0,0,1,0,2,0,0,0,''),
(@CGUID+3,12468,469,1,1,1,-7649.78,-1057.55,449.247,5.57555,600,0,0,1,0,2,0,0,0,''),
(@CGUID+4,12468,469,1,1,1,-7668.59,-986.566,440.329,5.74399,600,0,0,1,0,2,0,0,0,''),
(@CGUID+5,12468,469,1,1,1,-7624.29,-1035.04,449.244,4.62018,600,0,0,1,0,2,0,0,0,''),
(@CGUID+6,12468,469,1,1,1,-7639.27,-968.392,440.092,5.84041,600,0,0,1,0,2,0,0,0,''),
(@CGUID+7,12468,469,1,1,1,-7620.51,-998.365,440.319,2.62407,600,0,0,1,0,2,0,0,0,''),
(@CGUID+8,12468,469,1,1,1,-7695.27,-1005.48,440.297,5.80156,600,0,0,1,0,2,0,0,0,''),
(@CGUID+9,12468,469,1,1,1,-7630.35,-1101.33,449.246,1.63947,600,0,0,1,0,2,0,0,0,''),
(@CGUID+10,12468,469,1,1,1,-7649.74,-1019.88,440.318,2.38942,600,0,0,1,0,2,0,0,0,'');

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID AND @CGUID+10;
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes2`) VALUES
(@CGUID,@CGUID*10,1),
(@CGUID+1,(@CGUID+1)*10,1),
(@CGUID+2,(@CGUID+2)*10,1),
(@CGUID+3,(@CGUID+3)*10,1),
(@CGUID+4,(@CGUID+4)*10,1),
(@CGUID+5,(@CGUID+5)*10,1),
(@CGUID+6,(@CGUID+6)*10,1),
(@CGUID+7,(@CGUID+7)*10,1),
(@CGUID+8,(@CGUID+8)*10,1),
(@CGUID+9,(@CGUID+9)*10,1),
(@CGUID+10,(@CGUID+10)*10,1);

SET @PATH_ID := @CGUID*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7680.62,-1110.73,449.126,100,0,0,0,100,0),
(@PATH_ID,2,-7648.96,-1087.89,449.164,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+1)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7633.58,-1053.72,449.164,100,0,0,0,100,0),
(@PATH_ID,2,-7591.82,-1076.51,449.164,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+2)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7705.59,-1013.9,440.401,100,0,0,0,100,0),
(@PATH_ID,2,-7670.4,-1038.78,440.197,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+3)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7624.98,-1078.78,449.164,100,0,0,0,100,0),
(@PATH_ID,2,-7609.39,-1084.48,449.164,100,0,0,0,100,0),
(@PATH_ID,3,-7624.98,-1078.78,449.164,100,0,0,0,100,0),
(@PATH_ID,4,-7651.04,-1056.83,449.172,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+4)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7633.23,-1007.72,440.262,100,0,0,0,100,0),
(@PATH_ID,2,-7667.67,-987.11,439.986,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+5)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7625.61,-1049.31,449.164,100,0,0,0,100,0),
(@PATH_ID,2,-7608.66,-1082.75,449.164,100,0,0,0,100,0),
(@PATH_ID,3,-7625.61,-1049.31,449.164,100,0,0,0,100,0),
(@PATH_ID,4,-7624.89,-1036.41,449.164,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+6)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7605.95,-984.189,440.111,100,0,0,0,100,0),
(@PATH_ID,2,-7640.56,-967.494,440.29,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+7)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7653.81,-979.409,440.263,100,0,0,0,100,0),
(@PATH_ID,2,-7619.22,-999.321,440.287,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+8)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7676.08,-1015.52,439.983,100,0,0,0,100,0),
(@PATH_ID,2,-7668.89,-1020.34,440.279,100,0,0,0,100,0),
(@PATH_ID,3,-7676.08,-1015.52,439.983,100,0,0,0,100,0),
(@PATH_ID,4,-7696.82,-1004.11,440.216,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+9)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7631.94,-1078.19,449.164,100,0,0,0,100,0),
(@PATH_ID,2,-7642.19,-1059.9,449.165,100,0,0,0,100,0),
(@PATH_ID,3,-7631.94,-1078.19,449.164,100,0,0,0,100,0),
(@PATH_ID,4,-7629.75,-1102.86,449.164,100,0,0,0,100,0);

SET @PATH_ID := (@CGUID+10)*10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH_ID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_ID,1,-7664.98,-1005.61,440.254,100,0,0,0,100,0),
(@PATH_ID,2,-7684.11,-996.917,440.204,100,0,0,0,100,0),
(@PATH_ID,3,-7664.98,-1005.61,440.254,100,0,0,0,100,0),
(@PATH_ID,4,-7647.92,-1020.32,440.232,100,0,0,0,100,0);

DELETE FROM `linked_respawn` WHERE `guid` BETWEEN @CGUID AND @CGUID+10;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@CGUID,84387,0),
(@CGUID+1,84387,0),
(@CGUID+2,84387,0),
(@CGUID+3,84387,0),
(@CGUID+4,84387,0),
(@CGUID+5,84387,0),
(@CGUID+6,84387,0),
(@CGUID+7,84387,0),
(@CGUID+8,84387,0),
(@CGUID+9,84387,0),
(@CGUID+10,84387,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_18' WHERE sql_rev = '1648309713111396700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
