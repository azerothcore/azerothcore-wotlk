-- DB update 2021_12_27_01 -> 2021_12_27_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_27_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_27_01 2021_12_27_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639939288013992978'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639939288013992978');

-- Gangled Flesheater Respawn
DELETE FROM `creature` WHERE `id`=16322;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(82169, 16322, 530, 0, 0, 1, 1, 0, 0, 7689.6094, -6389.3564, 21.135122, 5.439761161804199218, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82451, 16322, 530, 0, 0, 1, 1, 0, 0, 7714.9165, -6382.952, 19.772285, 5.049756050109863281, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82452, 16322, 530, 0, 0, 1, 1, 0, 0, 7681.7188, -6417.223, 16.249865, 5.070984840393066406, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82453, 16322, 530, 0, 0, 1, 1, 0, 0, 7651.847, -6414.143, 16.900568, 0.680304527282714843, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82454, 16322, 530, 0, 0, 1, 1, 0, 0, 7650.757, -6384.027, 21.793434, 0.200413510203361511, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82455, 16322, 530, 0, 0, 1, 1, 0, 0, 7676.6807, -6378.3853, 23.065525, 2.653716564178466796, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82456, 16322, 530, 0, 0, 1, 1, 0, 0, 7686.718, -6351.026, 27.290134, 5.713814735412597656, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82457, 16322, 530, 0, 0, 1, 1, 0, 0, 7650.5537, -6350.8037, 25.689854, 0.149420902132987976, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82459, 16322, 530, 0, 0, 1, 1, 0, 0, 7716.134, -6349.4277, 21.702845, 2.016097307205200195, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_27_02' WHERE sql_rev = '1639939288013992978';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
