-- DB update 2018_07_02_00 -> 2018_07_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_07_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_07_02_00 2018_07_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1530312696838521331'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1530312696838521331');

UPDATE `creature` SET `modelid` = 16444, `orientation` = 1.2727 WHERE `guid` = 202761;
UPDATE `creature` SET `modelid` = 16432, `orientation` = 4.35146 WHERE `guid` = 202762;
UPDATE `creature` SET `modelid` = 16438 WHERE `guid` = 202759;
UPDATE `creature` SET `modelid` = 16445 WHERE `guid` = 202760;

DELETE FROM `creature` WHERE `guid` = 86895;
INSERT INTO `creature`
(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)
VALUES
(86895,26520,0,1,1,8409,0,2281.25,428.862,33.9647,3.54294,300,0,0,42,0,0,0,0,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
