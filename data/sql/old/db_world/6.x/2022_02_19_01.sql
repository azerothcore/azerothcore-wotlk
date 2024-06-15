-- DB update 2022_02_19_00 -> 2022_02_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_19_00 2022_02_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645221713034760650'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645221713034760650');

DELETE FROM `gameobject` WHERE `guid` IN (6980,6982,6986,6989);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES 
(6980, 177019, 1, 0, 0, 1, 1, 1592.37, -4427.32, 8.05301, 0.087267, 0, 0, 0.0436197, 0.999048, 900, 100, 1, '', 0),
(6982, 177024, 1, 0, 0, 1, 1, 1555.5, -4355.75, 0.491264, 1.30027, 0, 0, 0.605294, 0.796002, 900, 100, 1, '', 0),
(6986, 177020, 1, 0, 0, 1, 1, 1608.97, -4447.55, 8.13559, 1.30027, 0, 0, 0.605294, 0.796002, 900, 100, 1, '', 0),
(6989, 177017, 1, 0, 0, 1, 1, 1510.94, -4433.99, 19.7736, 1.30073, 0, 0, 0.605477, 0.795863, 900, 100, 1, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_19_01' WHERE sql_rev = '1645221713034760650';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
