-- DB update 2021_12_28_02 -> 2021_12_28_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_28_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_28_02 2021_12_28_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640102069155380399'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640102069155380399');

-- Respawn Stonewing Trackers
DELETE FROM `creature` WHERE `guid` IN (82652,82654,82661,82666,82667,82668,82751,82755,82757,82764);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(82652, 16316, 530, 0, 0, 1, 1, 0, 0, 7152.4004, -6415.1875, 39.938416, 0.528355777263641357, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82654, 16316, 530, 0, 0, 1, 1, 0, 0, 7217.4526, -6353.9526, 42.799004, 0.250564098358154296, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82661, 16316, 530, 0, 0, 1, 1, 0, 0, 7279.022, -6387.0894, 43.49623, 5.559215068817138671, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82666, 16316, 530, 0, 0, 1, 1, 0, 0, 7274.443, -6414.9634, 41.2661, 5.939209461212158203, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82667, 16316, 530, 0, 0, 1, 1, 0, 0, 7283.1943, -6448.0225, 30.407623, 1.530817627906799316, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82668, 16316, 530, 0, 0, 1, 1, 0, 0, 7247.4956, -6374.93, 46.14533, 5.020547866821289062, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82751, 16316, 530, 0, 0, 1, 1, 0, 0, 7185.846, -6652.1587, 53.12257, 5.466687679290771484, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82755, 16316, 530, 0, 0, 1, 1, 0, 0, 7219.1284, -6647.5767, 52.68631, 0.972102582454681396, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82757, 16316, 530, 0, 0, 1, 1, 0, 0, 7153.7305, -6654.567, 52.173565, 5.611378669738769531, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82764, 16316, 530, 0, 0, 1, 1, 0, 0, 7119.268, -6649.547, 45.155285, 3.391888856887817382, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_28_03' WHERE sql_rev = '1640102069155380399';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
