-- DB update 2021_07_02_01 -> 2021_07_02_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_02_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_02_01 2021_07_02_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624655271618733500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624655271618733500');

DELETE FROM `creature` WHERE (`id` = 23602) AND (`guid` = 31046);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(31046, 23602, 1, 0, 0, 1, 1, 21640, 0, -3647.61, -4449.4, 15.008, 0.536, 360, 0, 0, 1009, 1067, 2, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_02_02' WHERE sql_rev = '1624655271618733500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
