-- DB update 2022_04_21_00 -> 2022_04_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_21_00 2022_04_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1650360263328185762'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650360263328185762');

DELETE FROM `gameobject` WHERE (`id` = 180323) AND (`guid` IN (28668));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(28668, 180323, 309, 1977, 1977, 1, 1, -11916.8, -1221.22, 92.5045, -1.5708, 0, 0, -0.707107, 0.707107, 600, 100, 1, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_00' WHERE sql_rev = '1650360263328185762';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
