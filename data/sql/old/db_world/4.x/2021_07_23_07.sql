-- DB update 2021_07_23_06 -> 2021_07_23_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_06 2021_07_23_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626780409112630500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626780409112630500');

-- Added movement to the default spawn point he had
UPDATE `creature` SET `wander_distance` = 20, `MovementType` = 1 WHERE (`id` = 14343) AND (`guid` = 51897);

-- Added 2 more spawn points and movement on them
DELETE FROM `creature` WHERE (`id` = 14343) AND (`guid` IN (301303, 301304));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(301303, 14343, 1, 0, 0, 1, 1, 0, 0, 6091.22, -1485.77, 438.13, 0.18, 9900, 20, 0, 1, 0, 1, 0, 0, 0, '', 0),
(301304, 14343, 1, 0, 0, 1, 1, 0, 0, 6307.9, -1637.18, 474.611, 0, 9900, 20, 0, 1, 0, 1, 0, 0, 0, '', 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_07' WHERE sql_rev = '1626780409112630500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
