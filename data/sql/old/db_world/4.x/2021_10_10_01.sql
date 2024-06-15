-- DB update 2021_10_10_00 -> 2021_10_10_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_00 2021_10_10_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632681445196667900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632681445196667900');

DELETE FROM `gameobject` WHERE (`id` = 2046) AND (`guid` IN (8699));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(8699, 2046, 0, 0, 0, 1, 1, -807.73, -3595.466797, 76.099289, 2.67, 0, 0, 0, 0, 60, 100, 1, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_01' WHERE sql_rev = '1632681445196667900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
