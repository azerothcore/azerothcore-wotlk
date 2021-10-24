-- DB update 2021_10_10_30 -> 2021_10_10_31
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_30';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_30 2021_10_10_31 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633732567546468906'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633732567546468906');

#fix herb at entrance of the building #8355
DELETE FROM `gameobject` WHERE (`id` = 1622) AND (`guid` IN (3764));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(3764, 1622, 0, 0, 0, 1, 1, -2644.78, -2362.86, 97.341, 2.909, 0, 0, 0, 0, 60, 100, 1, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_31' WHERE sql_rev = '1633732567546468906';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
