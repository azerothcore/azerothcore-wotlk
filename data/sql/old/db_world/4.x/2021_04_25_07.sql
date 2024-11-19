-- DB update 2021_04_25_06 -> 2021_04_25_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_25_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_25_06 2021_04_25_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618656094946285190'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618656094946285190');

DELETE FROM `creature` WHERE `guid` IN (24172, 24173, 24174);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(24172, 4158,1,1,1,0,0,-6290.34,-3564.31,-58.625,0.904275,300,30,0,1163,0,1),
(24173, 4158,1,1,1,0,0,-6040.3,-4084.69,-58.625,2.36436,300,30,0,1163,0,1),
(24174, 4158,1,1,1,0,0,-6582.02,-3923.57,-58.625,5.82247,300,30,0,1163,0,1);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
