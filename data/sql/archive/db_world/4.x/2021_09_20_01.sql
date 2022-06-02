-- DB update 2021_09_20_00 -> 2021_09_20_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_00 2021_09_20_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631640758221414000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631640758221414000');

UPDATE `gameobject` SET `position_x`=-8337.72, `position_y`=519.845, `position_z`=122.939, `orientation`=-1.12724, `rotation0`=-0.667571,
`rotation1`=-0.233126, `rotation2`=-0.667571, `rotation3`=0.23313, `animprogress`=100 WHERE `id`=177200;
UPDATE `gameobject` SET `position_x`=-8338.47, `position_y`=509.136, `position_z`=122.924, `orientation`=2.25, `rotation0`=-0.631331,
`rotation1`=0.301701, `rotation2`=-0.644599, `rotation3`=-0.308042, `animprogress`=100 WHERE `id`=177201;
UPDATE `gameobject` SET `position_x`=-8347.64, `position_y`=520.972, `position_z`=122.939, `orientation`=0, `rotation0`=-0.307199,
`rotation1`=-0.636889, `rotation2`=-0.307198, `rotation3`=0.63689, `animprogress`=100 WHERE `id`=177202;

DELETE FROM `game_event_gameobject` WHERE `guid`=31619;

DELETE FROM `gameobject_addon` WHERE `guid` IN (20458,20459,31619);
INSERT INTO `gameobject_addon` VALUES
(20458,0,0),
(20459,0,0),
(31619,0,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_01' WHERE sql_rev = '1631640758221414000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
