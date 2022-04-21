-- DB update 2021_10_16_06 -> 2021_10_17_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_16_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_16_06 2021_10_17_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633175453141992100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633175453141992100');

DELETE FROM `creature` WHERE `id`=119 AND `guid` IN (3110417, 3110419, 3110416, 3110421, 3110420, 3110418);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(3110417, 119, 0, 0, 0, 1, 1, 0, 0, -9768.05, 615.642, 35.228, 0.933077, 300, 0, 0, 198, 0, 0, 0, 0, 0, '', 0),
(3110419, 119, 0, 0, 0, 1, 1, 0, 0, -9862.54, 715.2, 30.3827, 2.47246, 300, 0, 0, 198, 0, 0, 0, 0, 0, '', 0),
(3110416, 119, 0, 0, 0, 1, 1, 0, 0, -9803.8, 655.994, 34.7701, 5.34544, 300, 0, 0, 198, 0, 0, 0, 0, 0, '', 0),
(3110421, 119, 0, 0, 0, 1, 1, 0, 0, -9855.29, 604.67, 39.0587, 0.494036, 300, 0, 0, 198, 0, 0, 0, 0, 0, '', 0),
(3110420, 119, 0, 0, 0, 1, 1, 0, 0, -9912.11, 675.351, 33.5168, 4.53256, 300, 0, 0, 198, 0, 0, 0, 0, 0, '', 0),
(3110418, 119, 0, 0, 0, 1, 1, 0, 0, -9771.7, 700.888, 27.584, 1.47029, 300, 0, 0, 222, 0, 0, 0, 0, 0, '', 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_17_00' WHERE sql_rev = '1633175453141992100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
