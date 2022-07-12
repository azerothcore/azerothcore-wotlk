-- DB update 2021_11_22_03 -> 2021_11_22_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_22_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_22_03 2021_11_22_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636799867064749300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636799867064749300');

-- shield
DELETE FROM `gameobject` WHERE `id` = 20992;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(6821, 20992, 1, 0, 0, 1, 1, -3734.65, -2530.93, 73.2862, 0, 0, 0.707107, 0, 0.707107, 0, 100, 1, '', 0);

-- badge
DELETE FROM `gameobject` WHERE `id` = 21042;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(6376, 21042, 1, 0, 0, 1, 1, -3721.85, -2541.17, 69.785, -0.000001, 0.556657, -0.434788, 0.43101, 0.561536, 0, 100, 1, '', 0);

-- fake hoofprint
DELETE FROM `gameobject` WHERE `id` = 187272;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(10175, 187272, 1, 0, 0, 1, 1, -3701.37, -2535.18, 69, 3.03687, 0, 0, -0.99863, -0.0523374, 900, 100, 1, '', 0);

-- quest hoofprint
DELETE FROM `gameobject` WHERE `id` = 187273;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(10167, 187273, 1, 0, 0, 1, 1, -3700.58, -2534.09, 68.8, 3.05433, 0, 0, -0.999048, -0.0436174, 0, 100, 1, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_22_04' WHERE sql_rev = '1636799867064749300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
