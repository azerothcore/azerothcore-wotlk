-- DB update 2022_03_06_10 -> 2022_03_06_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_10 2022_03_06_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646084736254763900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646084736254763900');

SET @NPC := 594;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14298.5, `position_y` = 435.71, `position_z` = 31.5745, `orientation` = 0.612118 WHERE `guid` = @NPC;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14287, 428.87, 33.7043, 100, 0),
(@PATH, 2, -14280.9, 424.514, 35.3712, 100, 0),
(@PATH, 3, -14277.2, 419.943, 36.423, 100, 0),
(@PATH, 4, -14275.8, 411.91, 37.235, 100, 0),
(@PATH, 5, -14276.6, 402.768, 37.0483, 100, 0),
(@PATH, 6, -14279, 390.305, 36.3309, 100, 0),
(@PATH, 7, -14281.4, 379.503, 35.133, 100, 0),
(@PATH, 8, -14279.8, 368.264, 33.6549, 100, 0),
(@PATH, 9, -14277.5, 359.923, 33.2561, 100, 0),
(@PATH, 10, -14273.1, 350.615, 32.7842, 100, 0),
(@PATH, 11, -14268.5, 346.023, 31.3686, 100, 0),
(@PATH, 12, -14273.1, 350.615, 32.7842, 100, 0),
(@PATH, 13, -14277.5, 359.923, 33.2561, 100, 0),
(@PATH, 14, -14279.8, 368.264, 33.6549, 100, 0),
(@PATH, 15, -14281.4, 379.503, 35.133, 100, 0),
(@PATH, 16, -14279, 390.305, 36.3309, 100, 0),
(@PATH, 17, -14276.6, 402.703, 37.0651, 100, 0),
(@PATH, 18, -14275.8, 411.91, 37.235, 100, 0),
(@PATH, 19, -14277.2, 419.943, 36.423, 100, 0),
(@PATH, 20, -14280.9, 424.514, 35.3712, 100, 0),
(@PATH, 21, -14287, 428.87, 33.7043, 100, 0),
(@PATH, 22, -14298, 435.509, 31.579, 100, 0);

SET @NPC := 593;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14256.7, `position_y` = 338.71, `position_z` = 27.2934, `orientation` = 2.56527 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14265.8, 348.704, 31.1595, 100, 0),
(@PATH, 2, -14271, 353.64, 32.7479, 100, 0),
(@PATH, 3, -14276.1, 364.71, 33.6137, 100, 0),
(@PATH, 4, -14277.9, 380.406, 35.3847, 100, 0),
(@PATH, 5, -14274.2, 395.879, 37.1044, 100, 0),
(@PATH, 6, -14271.1, 404.903, 36.8936, 100, 0),
(@PATH, 7, -14269.9, 416.31, 36.7034, 100, 0),
(@PATH, 8, -14274.9, 426.285, 35.3947, 100, 0),
(@PATH, 9, -14287, 434.52, 33.2376, 100, 0),
(@PATH, 10, -14274.9, 426.285, 35.3947, 100, 0),
(@PATH, 11, -14269.9, 416.31, 36.7034, 100, 0),
(@PATH, 12, -14271, 405.088, 36.9146, 100, 0),
(@PATH, 13, -14274.2, 395.879, 37.1044, 100, 0),
(@PATH, 14, -14277.9, 380.406, 35.3847, 100, 0),
(@PATH, 15, -14276.1, 364.71, 33.6137, 100, 0),
(@PATH, 16, -14271, 353.64, 32.7479, 100, 0),
(@PATH, 17, -14265.8, 348.704, 31.1595, 100, 0),
(@PATH, 18, -14257, 339.076, 27.2743, 100, 0);

SET @NPC := 598;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14400.6, `position_y` = 413.038, `position_z` = 7.93467, `orientation` = 0.712614 WHERE `guid` = @NPC;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14392.1, 420.434, 7.54837, 100, 0),
(@PATH, 2, -14385.4, 425.173, 7.36117, 100, 0),
(@PATH, 3, -14373.1, 430.034, 7.31295, 100, 0),
(@PATH, 4, -14360.3, 433.72, 7.36588, 100, 0),
(@PATH, 5, -14344.8, 443.056, 7.4693, 100, 0),
(@PATH, 6, -14337.3, 451.978, 7.67435, 100, 0),
(@PATH, 7, -14327.3, 466.137, 8.1809, 100, 0),
(@PATH, 8, -14317.2, 485.579, 8.59669, 100, 0),
(@PATH, 9, -14308.3, 506.756, 8.64147, 100, 0),
(@PATH, 10, -14294.1, 534.231, 8.6887, 100, 0),
(@PATH, 11, -14286.1, 552.673, 8.70584, 100, 0),
(@PATH, 12, -14294.1, 534.231, 8.6887, 100, 0),
(@PATH, 13, -14308.3, 506.756, 8.64147, 100, 0),
(@PATH, 14, -14317.2, 485.579, 8.59669, 100, 0),
(@PATH, 15, -14327.3, 466.137, 8.1809, 100, 0),
(@PATH, 16, -14337.3, 451.978, 7.67435, 100, 0),
(@PATH, 17, -14344.8, 443.056, 7.4693, 100, 0),
(@PATH, 18, -14360.3, 433.72, 7.36588, 100, 0),
(@PATH, 19, -14373.1, 430.034, 7.31295, 100, 0),
(@PATH, 20, -14385.4, 425.173, 7.36117, 100, 0),
(@PATH, 21, -14392.1, 420.434, 7.54837, 100, 0),
(@PATH, 22, -14400, 412.727, 7.77239, 100, 0);

SET @NPC := 599;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14316.7, `position_y` = 446.802, `position_z` = 23.4093, `orientation` = 1.79824 WHERE `guid` = @NPC;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14318.6, 455.081, 23.4482, 100, 0),
(@PATH, 2, -14314.7, 468.257, 18.4367, 100, 0),
(@PATH, 3, -14314.7, 474.267, 18.3547, 100, 0),
(@PATH, 4, -14307.9, 487.469, 13.2721, 100, 0),
(@PATH, 5, -14301.7, 497.471, 10.601, 100, 0),
(@PATH, 6, -14298.1, 505.389, 8.96902, 100, 0),
(@PATH, 7, -14301.7, 509.774, 8.6758, 100, 0),
(@PATH, 8, -14307.6, 504.115, 8.64554, 100, 0),
(@PATH, 9, -14309.8, 498.715, 8.6345, 100, 0),
(@PATH, 10, -14313.3, 490.275, 8.6164, 100, 0),
(@PATH, 11, -14317.3, 482.241, 8.59652, 100, 0),
(@PATH, 12, -14323, 471.202, 8.39456, 100, 0),
(@PATH, 13, -14330, 457.738, 7.90804, 100, 0),
(@PATH, 14, -14341.2, 443.758, 7.48909, 100, 0),
(@PATH, 15, -14353.5, 435.965, 7.38517, 100, 0),
(@PATH, 16, -14369, 429.004, 7.37672, 100, 0),
(@PATH, 17, -14382.4, 424.817, 7.3554, 100, 0),
(@PATH, 18, -14394.1, 421.125, 7.63872, 100, 0),
(@PATH, 19, -14405.2, 422.36, 8.48729, 100, 0),
(@PATH, 20, -14412.8, 428.759, 8.93994, 100, 0),
(@PATH, 21, -14420.9, 435.219, 9.53649, 100, 0),
(@PATH, 22, -14425.8, 441.807, 12.1688, 100, 0),
(@PATH, 23, -14429.8, 447.25, 15.4427, 100, 0),
(@PATH, 24, -14431.9, 447.814, 15.4255, 100, 0),
(@PATH, 25, -14432.5, 445.842, 15.4692, 100, 0),
(@PATH, 26, -14426.6, 438.212, 18.0541, 100, 0),
(@PATH, 27, -14422.9, 432.659, 21.3357, 100, 0),
(@PATH, 28, -14419.3, 428.27, 22.0601, 100, 0),
(@PATH, 29, -14415.8, 424.096, 22.1281, 100, 0),
(@PATH, 30, -14394.2, 414.212, 22.6782, 100, 0),
(@PATH, 31, -14392.2, 409.483, 22.7452, 100, 0),
(@PATH, 32, -14392.5, 402.863, 22.712, 100, 0),
(@PATH, 33, -14387.6, 390.908, 22.9852, 100, 0),
(@PATH, 34, -14382, 384.972, 23.2067, 100, 0),
(@PATH, 35, -14375, 380.035, 23.1574, 100, 0),
(@PATH, 36, -14365.2, 378.422, 23.3867, 100, 0),
(@PATH, 37, -14355.3, 380.67, 23.3598, 100, 0),
(@PATH, 38, -14342.3, 385.995, 23.4673, 100, 0),
(@PATH, 39, -14326.5, 392.474, 23.8077, 100, 0),
(@PATH, 40, -14320, 399.283, 24.0117, 100, 0),
(@PATH, 41, -14315, 416.881, 23.6653, 100, 0),
(@PATH, 42, -14313.4, 427.522, 23.1797, 100, 0),
(@PATH, 43, -14314.8, 435.38, 22.9005, 100, 0),
(@PATH, 44, -14316.6, 447.09, 23.2387, 100, 0);

SET @NPC := 651;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14451, `position_y` = 462.469, `position_z` = 15.4349, `orientation` = 3.68277 WHERE `guid` = @NPC;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14466.6, 453.068, 15.3329, 100, 0),
(@PATH, 2, -14467, 449.978, 15.4687, 100, 0),
(@PATH, 3, -14463.1, 446.736, 15.4737, 100, 0),
(@PATH, 4, -14454.3, 434.906, 15.1878, 100, 0),
(@PATH, 5, -14442.7, 415.397, 15.0957, 100, 0),
(@PATH, 6, -14453.6, 434.036, 15.1696, 100, 0),
(@PATH, 7, -14437.8, 449.306, 15.3789, 100, 0),
(@PATH, 8, -14449.8, 463.889, 15.3359, 100, 0);

SET @NPC := 654;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14434.8, `position_y` = 416.849, `position_z` = 8.8187, `orientation` = 0.661698 WHERE `guid` = @NPC;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14425.3, 424.265, 8.99519, 100, 0),
(@PATH, 2, -14423.7, 428.519, 8.96744, 100, 0),
(@PATH, 3, -14428.8, 437.855, 6.48981, 100, 0),
(@PATH, 4, -14436.4, 449.562, 3.69352, 100, 0),
(@PATH, 5, -14445.5, 463.716, 3.84649, 100, 0),
(@PATH, 6, -14436.9, 448.047, 3.69427, 100, 0),
(@PATH, 7, -14448.3, 439.089, 3.86408, 100, 0),
(@PATH, 8, -14436.9, 448.047, 3.69427, 100, 0),
(@PATH, 9, -14445.5, 463.716, 3.84649, 100, 0),
(@PATH, 10, -14436.4, 449.562, 3.69352, 100, 0),
(@PATH, 11, -14428.8, 437.855, 6.48981, 100, 0),
(@PATH, 12, -14423.7, 428.519, 8.96744, 100, 0),
(@PATH, 13, -14425.3, 424.265, 8.99519, 100, 0),
(@PATH, 14, -14434.6, 416.965, 8.75356, 100, 0);

SET @NPC := 656;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14431.6, `position_y` = 511.808, `position_z` = 5.77141, `orientation` = 2.60319 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14439.1, 495.388, 13.4074, 100, 0),
(@PATH, 2, -14447.8, 482.138, 15.1096, 100, 0),
(@PATH, 3, -14442.6, 462.937, 15.3824, 100, 0),
(@PATH, 4, -14435.3, 448.752, 15.3969, 100, 0),
(@PATH, 5, -14424.8, 444.452, 12.9438, 100, 0),
(@PATH, 6, -14417.7, 434.207, 8.95462, 100, 0),
(@PATH, 7, -14409.2, 423.573, 8.68512, 100, 0),
(@PATH, 8, -14396.8, 416.179, 7.87222, 100, 0),
(@PATH, 9, -14393.1, 406.336, 6.71033, 100, 0),
(@PATH, 10, -14396.8, 416.179, 7.87222, 100, 0),
(@PATH, 11, -14409.2, 423.573, 8.68512, 100, 0),
(@PATH, 12, -14417.7, 434.166, 8.93865, 100, 0),
(@PATH, 13, -14424.8, 444.452, 12.9438, 100, 0),
(@PATH, 14, -14435.3, 448.752, 15.3969, 100, 0),
(@PATH, 15, -14442.6, 462.937, 15.3824, 100, 0),
(@PATH, 16, -14447.8, 482.138, 15.1096, 100, 0),
(@PATH, 17, -14439.1, 495.388, 13.4074, 100, 0),
(@PATH, 18, -14431.2, 512.273, 5.49217, 100, 0);

SET @NPC := 657;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14299.9, `position_y` = 503.528, `position_z` = 9.25196, `orientation` = 4.14756 WHERE `guid` = @NPC;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14312.8, 483.192, 14.819, 100, 0),
(@PATH, 2, -14317.7, 466.225, 19.1429, 100, 0),
(@PATH, 3, -14323.2, 444.298, 22.747, 100, 0),
(@PATH, 4, -14316.2, 432.447, 22.7259, 100, 0),
(@PATH, 5, -14319, 417.219, 23.4741, 100, 0),
(@PATH, 6, -14322.2, 399.648, 24.0779, 100, 0),
(@PATH, 7, -14334.9, 395.419, 23.3598, 100, 0),
(@PATH, 8, -14343.8, 390.811, 23.2622, 100, 0),
(@PATH, 9, -14363.4, 383.449, 23.4848, 100, 0),
(@PATH, 10, -14375.8, 383.213, 22.6782, 100, 0),
(@PATH, 11, -14390.6, 399.044, 22.8109, 100, 0),
(@PATH, 12, -14375.8, 383.213, 22.6782, 100, 0),
(@PATH, 13, -14363.4, 383.449, 23.4848, 100, 0),
(@PATH, 14, -14343.8, 390.811, 23.2622, 100, 0),
(@PATH, 15, -14334.9, 395.419, 23.3598, 100, 0),
(@PATH, 16, -14322.2, 399.648, 24.0779, 100, 0),
(@PATH, 17, -14319, 417.219, 23.4741, 100, 0),
(@PATH, 18, -14316.2, 432.447, 22.7259, 100, 0),
(@PATH, 19, -14323.2, 444.298, 22.747, 100, 0),
(@PATH, 20, -14317.7, 466.225, 19.1429, 100, 0),
(@PATH, 21, -14312.8, 483.192, 14.819, 100, 0),
(@PATH, 22, -14299.8, 503.744, 9.08229, 100, 0);

SET @NPC := 695;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14473.9, `position_y` = 487.356, `position_z` = 26.8084, `orientation` = 5.54734 WHERE `guid` = @NPC;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14465.5, 479.746, 26.8295, 100, 0),
(@PATH, 2, -14466.8, 471.284, 30.7113, 100, 0),
(@PATH, 3, -14469.5, 462.674, 30.6577, 100, 0),
(@PATH, 4, -14472.3, 454.081, 30.4917, 100, 0),
(@PATH, 5, -14470.2, 446.919, 30.5566, 100, 0),
(@PATH, 6, -14474.8, 441.263, 30.705, 100, 0),
(@PATH, 7, -14474.5, 434.851, 33.2027, 100, 0),
(@PATH, 8, -14473.8, 431.647, 34.314, 100, 0),
(@PATH, 9, -14478.6, 428.314, 34.249, 100, 0),
(@PATH, 10, -14473.8, 431.647, 34.314, 100, 0),
(@PATH, 11, -14474.5, 434.851, 33.2027, 100, 0),
(@PATH, 12, -14474.8, 441.263, 30.705, 100, 0),
(@PATH, 13, -14470.2, 446.919, 30.5566, 100, 0),
(@PATH, 14, -14472.3, 454.081, 30.4917, 100, 0),
(@PATH, 15, -14469.5, 462.674, 30.6577, 100, 0),
(@PATH, 16, -14467, 470.439, 30.7043, 100, 0),
(@PATH, 17, -14465.5, 479.746, 26.8295, 100, 0),
(@PATH, 18, -14474, 487.33, 26.7089, 100, 0);

SET @NPC := 715;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -14437.2, `position_y` = 399.063, `position_z` = 31.7274, `orientation` = 2.06051 WHERE `guid` = @NPC;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -14443.3, 410.566, 25.0075, 100, 0),
(@PATH, 2, -14457.4, 426.895, 25.1528, 100, 0),
(@PATH, 3, -14466.7, 441.322, 29.8059, 100, 0),
(@PATH, 4, -14455.6, 425.828, 25.131, 100, 0),
(@PATH, 5, -14443.5, 432.869, 20.2956, 100, 0),
(@PATH, 6, -14455.6, 425.828, 25.131, 100, 0),
(@PATH, 7, -14466.7, 441.322, 29.8059, 100, 0),
(@PATH, 8, -14457.4, 426.895, 25.1528, 100, 0),
(@PATH, 9, -14443.3, 410.566, 25.0075, 100, 0),
(@PATH, 10, -14437.1, 398.968, 31.7248, 100, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_11' WHERE sql_rev = '1646084736254763900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
