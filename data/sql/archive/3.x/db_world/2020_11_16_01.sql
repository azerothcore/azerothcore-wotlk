-- DB update 2020_11_16_00 -> 2020_11_16_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_16_00 2020_11_16_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1605209372908686400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605209372908686400');

-- ---------------- --
-- Maker's Overlook --
-- ---------------- --

-- Sholazar Guardian 111415
DELETE FROM `creature` WHERE `guid`=111415;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (111415, 28069, 571, 0, 0, 1, 1, 26140, 0, 5738.87, 3156.67, 293.833, 4.8144, 300, 0, 0, 11379, 0, 2, 0, 0, 0, '', 0);

DELETE FROM `creature_addon` WHERE `guid`=111415;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `islarge`, `auras`) VALUES (111415, 847234, 0, 0, 4097, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`=847234 AND `point` IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(847234, 1, 5737.64, 3168.66, 293.833, 0, 0, 0, 0, 100, 0),
(847234, 2, 5734.83, 3190.47, 294.084, 0, 0, 0, 0, 100, 0),
(847234, 3, 5733.38, 3205.57, 295.698, 0, 0, 0, 0, 100, 0),
(847234, 4, 5734.83, 3190.47, 294.084, 0, 0, 0, 0, 100, 0),
(847234, 5, 5737.64, 3168.66, 293.833, 0, 0, 0, 0, 100, 0),
(847234, 6, 5739.32, 3152.2, 293.833, 0, 0, 0, 0, 100, 0),
(847234, 7, 5742.78, 3128.64, 294.013, 0, 0, 0, 0, 100, 0),
(847234, 8, 5744.99, 3100.41, 287.95, 0, 0, 0, 0, 100, 0),
(847234, 9, 5746.91, 3085.88, 287.758, 0, 0, 0, 0, 100, 0),
(847234, 10, 5744.99, 3100.41, 287.95, 0, 0, 0, 0, 100, 0),
(847234, 11, 5742.78, 3128.64, 294.013, 0, 0, 0, 0, 100, 0),
(847234, 12, 5739.32, 3152.2, 293.833, 0, 0, 0, 0, 100, 0);

-- Sholazar Guardian 111416, 111416, 111417, 111418, 111419, 111426, 111427
DELETE FROM `creature` WHERE `guid` IN (111416, 111417, 111418, 111419, 111426, 111427);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(111416, 28069, 571, 0, 0, 1, 1, 26140, 0, 5752.53, 3141.5, 294.167, 3.35103, 300, 0, 0, 11379, 0, 0, 0, 0, 0, '', 0),
(111417, 28069, 571, 0, 0, 1, 1, 26140, 0, 5728.32, 3137.71, 294.163, 0.715585, 300, 0, 0, 11379, 0, 0, 0, 0, 0, '', 0),
(111418, 28069, 571, 0, 0, 1, 1, 26140, 0, 5737.38, 3051.35, 288.07, 1.23918, 300, 0, 0, 11379, 0, 0, 0, 0, 0, '', 0),
(111419, 28069, 571, 0, 0, 1, 1, 26140, 0, 5781.28, 3081.08, 288.07, 3.08923, 300, 0, 0, 11379, 0, 0, 0, 0, 0, '', 0),
(111426, 28069, 571, 0, 0, 1, 1, 26140, 0, 5717.86, 3074.3, 288.07, 0.401426, 300, 0, 0, 11379, 0, 0, 0, 0, 0, '', 0),
(111427, 28069, 571, 0, 0, 1, 1, 26140, 0, 5767.67, 3052.91, 288.07, 2.18166, 300, 0, 0, 11379, 0, 0, 0, 0, 0, '', 0);

-- Sholazar Guardian 111422
UPDATE `creature` SET `position_x` = 5704.08, `position_y` = 3429.4, `position_z` = 300.842, `orientation` = 1.23918, `MovementType` = 2 WHERE `guid` = 111422;

DELETE FROM `creature_addon` WHERE `guid`=111422;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `islarge`, `auras`) VALUES (111422, 847243, 0, 0, 4097, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`=847243 AND `point` IN (1, 2, 3, 4, 5, 6);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(847243, 1, 5709.81, 3394.62, 300.842, 0, 0, 0, 0, 100, 0),
(847243, 2, 5713.21, 3367.16, 300.253, 0, 0, 0, 0, 100, 0),
(847243, 3, 5715.42, 3346.88, 300.04, 0, 0, 0, 0, 100, 0),
(847243, 4, 5718.08, 3324.58, 299.805, 0, 0, 0, 0, 100, 0),
(847243, 5, 5715.42, 3346.88, 300.04, 0, 0, 0, 0, 100, 0),
(847243, 6, 5713.21, 3367.16, 300.253, 0, 0, 0, 0, 100, 0);

-- Sholazar Guardian 111423 & 111424
UPDATE `creature` SET `position_x` = 5706.99, `position_y` = 3306.82, `position_z` = 299.718, `orientation` = 1.51844 WHERE `guid` = 111423;
UPDATE `creature` SET `position_x` = 5734.7, `position_y` = 3308.84, `position_z` = 299.826, `orientation` = 1.8675 WHERE `guid` = 111424;

-- Titan Sentry
UPDATE `creature_template` SET `InhabitType`= 4 WHERE  `entry`=29066;

-- Overlook Sentry 111399
DELETE FROM `creature` WHERE `guid`=111399;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (111399, 28840, 571, 0, 0, 1, 1, 26156, 0, 5737.76, 3273.59, 299.117, 2.79445, 300, 0, 0, 58850, 0, 2, 0, 0, 0, '', 0);

DELETE FROM `creature_addon` WHERE `guid`=111399;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `islarge`, `auras`) VALUES (111399, 847236, 0, 0, 4097, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`=847236 AND `point` IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(847236, 1, 5712.78, 3273.75, 299.128, 0, 0, 0, 0, 100, 0),
(847236, 2, 5705.58, 3264.4, 299.117, 0, 0, 0, 0, 100, 0),
(847236, 3, 5704.04, 3252.41, 299.117, 0, 0, 0, 0, 100, 0),
(847236, 4, 5711.5, 3241.04, 299.117, 0, 0, 0, 0, 100, 0),
(847236, 5, 5725.47, 3233.01, 299.114, 0, 0, 0, 0, 100, 0),
(847236, 6, 5738.39, 3238.95, 299.115, 0, 0, 0, 0, 100, 0),
(847236, 7, 5744.12, 3248.18, 299.117, 0, 0, 0, 0, 100, 0),
(847236, 8, 5747.94, 3262.18, 299.117, 0, 0, 0, 0, 100, 0),
(847236, 9, 5737.76, 3273.59, 299.117, 0, 0, 0, 0, 100, 0),
(847236, 10, 5723.77, 3278.65, 299.138, 0, 0, 0, 0, 100, 0);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
