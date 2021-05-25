INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621252516106793022');

-- https://github.com/azerothcore/azerothcore-wotlk/issues/5902
SET @VALDRED := 19150;
SET @PATH := @VALDRED * 10;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @VALDRED;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @VALDRED;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -696.809, 1574.147, 18.6385, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -697.589, 1581.676, 17.3767, 1.243, 20000, 0, 0, 100, 0),
(@PATH, 3, -684.160, 1567.962, 18.0678 , 0, 0, 0, 0, 100, 0),
(@PATH, 4, -708.190, 1520.007, 13.5865, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -738.337, 1505.537, 15.3354, 4.094, 20000, 0, 0, 100, 0),
(@PATH, 6, -717.544, 1493.063, 12.4005, 0, 0, 0, 0, 100, 0),
(@PATH, 7, -735.375, 1465.154, 17.1537, 0, 0, 0, 0, 100, 0),
(@PATH, 8, -748.391, 1469.193, 18.1120, 2.840, 20000, 0, 0, 100, 0),
(@PATH, 9, -722.820, 1506.920, 12.6463, 0, 0, 0, 0, 100, 0),
(@PATH, 10, -693.943, 1542.735, 16.3801 , 0, 0, 0, 0, 100, 0);
