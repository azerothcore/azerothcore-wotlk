-- DB update 2021_08_19_00 -> 2021_08_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_19_00 2021_08_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629122909167793000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629122909167793000');

DELETE FROM `creature` WHERE `guid` = 79330 AND `id` = 657;
DELETE FROM `creature` WHERE `guid` = 79338 AND `id` = 1732;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(79330, 657, 36, 0, 0, 1, 1, 0, 1, -36.8196, -794.341, 18.8055, 6.26542, 86400, 0, 0, 1347, 0, 0, 0, 0, 0, '', 0),
(79338, 1732, 36, 0, 0, 1, 1, 0, 1, -21.7653, -811.787, 19.5538, 1.62187, 86400, 0, 0, 1137, 2236, 0, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_19_01' WHERE sql_rev = '1629122909167793000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
