-- DB update 2021_01_13_01 -> 2021_01_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_13_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_13_01 2021_01_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609118876085874200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609118876085874200');

DELETE FROM `gameobject` WHERE (`id` = 192011 AND `guid` IN (99732, 2134518));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(99732, 192011, 571, 0, 0, 1, 1, 8426.94, 2921.13, 606.259, 1.61609, 0, 0, -0.722938, -0.690913, 25, 0, 1, '', 0),
(2134518, 192011, 571, 0, 0, 1, 1, 8427.42, 2910.6, 606.259, 1.61609, 0, 0, -0.722938, -0.690913, 300, 0, 1, '', 0);

UPDATE `gameobject_template` SET `Data1` = 17 WHERE (`entry` = 192011);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
