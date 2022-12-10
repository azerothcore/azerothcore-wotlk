-- DB update 2021_11_18_02 -> 2021_11_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_18_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_18_02 2021_11_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637271386614261100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637271386614261100');

DELETE FROM `creature` WHERE `guid` IN (201207, 201208);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(201207,2110,631,0,0,15,1,0,0,16.1163,2211.13,30.199,0.679835,86400,0,0,1,0,0,0,0,0,'',0),
(201208,38054,631,0,0,15,1,0,0,-46.5868,2251.06,30.7375,3.83972,86400,0,0,17880,8814,0,0,0,0,'',0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_19_00' WHERE sql_rev = '1637271386614261100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
