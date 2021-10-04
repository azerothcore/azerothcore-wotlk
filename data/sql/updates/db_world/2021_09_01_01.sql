-- DB update 2021_09_01_00 -> 2021_09_01_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_00 2021_09_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629918642442912200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629918642442912200');

SET @NPC := 10825; -- ID: 10825 - Gish the Unmoving
SET @PATH := @NPC * 10;

-- Set correct speeds and faction according to sniffs
UPDATE `creature_template` SET `speed_walk` = 1.4, `speed_run` = 1.42857, `faction` = 21 WHERE (`entry` = @NPC);

-- Correct Spawn point and MovementType
UPDATE `creature` SET `MovementType`= 2, `position_x` = 2432.24, `position_y` = -5062.68, `position_z` = 80.0662 WHERE `id`= @NPC;

DELETE FROM `creature_template_addon` WHERE (`entry` = @NPC);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(@NPC, @PATH, 0, 0, 0, 0, 0, '');

-- Source: pathing from mangos
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`, `delay`) VALUES
(@PATH, 1, 2432.24, -5062.68, 80.0662, 0),
(@PATH, 2, 2435.17, -5025.6, 79.1069, 0),
(@PATH, 3, 2424.1, -4992.43, 76.299, 0),
(@PATH, 4, 2410.09, -4973.49, 76.1273, 0),
(@PATH, 5, 2404.12, -4953.98, 74.8763, 0),
(@PATH, 6, 2391.33, -4907.73, 77.0465, 0),
(@PATH, 7, 2384.21, -4885.79, 82.4272, 0),
(@PATH, 8, 2373.35, -4840.1, 77.5516, 0),
(@PATH, 9, 2375.56, -4803.11, 81.6979, 0),
(@PATH, 10, 2381.45, -4766.97, 74.8347, 0),
(@PATH, 11, 2379.27, -4726.18, 75.7203, 0),
(@PATH, 12, 2383.85, -4698.69, 73.5955, 0),
(@PATH, 13, 2392.93, -4659.65, 76.5947, 0),
(@PATH, 14, 2394.13, -4619.11, 73.6167, 0),
(@PATH, 15, 2411.81, -4565.22, 75.5607, 0),
(@PATH, 16, 2441.76, -4511.28, 75.4986, 0),
(@PATH, 17, 2454.05, -4463.87, 74.7081, 0),
(@PATH, 18, 2468.13, -4397.58, 75.0757, 0),
(@PATH, 19, 2486.83, -4366.36, 75.2319, 0),
(@PATH, 20, 2501.23, -4328.54, 74.6996, 0),
(@PATH, 21, 2521.72, -4305.62, 77.4873, 0),
(@PATH, 22, 2534.11, -4293.27, 74.9958, 0),
(@PATH, 23, 2516.9, -4305.85, 77.2449, 0),
(@PATH, 24, 2498.16, -4329.52, 74.5587, 0),
(@PATH, 25, 2483.12, -4348.86, 77.5882, 0),
(@PATH, 26, 2440.14, -4404.11, 76.2622, 0),
(@PATH, 27, 2443.08, -4462.82, 74.2341, 0),
(@PATH, 28, 2439.67, -4484.18, 74.3608, 0),
(@PATH, 29, 2435.39, -4504.74, 77.6012, 0),
(@PATH, 30, 2430.47, -4522.09, 75.3747, 0),
(@PATH, 31, 2415.88, -4565.05, 74.7353, 0),
(@PATH, 32, 2373.54, -4654.04, 77.6974, 0),
(@PATH, 33, 2372.24, -4670.66, 75.7186, 0),
(@PATH, 34, 2376.36, -4728.09, 76.4781, 0),
(@PATH, 35, 2381.16, -4801.43, 80.0164, 0),
(@PATH, 36, 2382.63, -4833.23, 76.0634, 0),
(@PATH, 37, 2389.92, -4883.03, 81.6866, 0),
(@PATH, 38, 2394.29, -4904.28, 77.2246, 0),
(@PATH, 39, 2409.14, -4968.48, 76.5356, 0),
(@PATH, 40, 2436.96, -5029.48, 79.2512, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_01' WHERE sql_rev = '1629918642442912200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
