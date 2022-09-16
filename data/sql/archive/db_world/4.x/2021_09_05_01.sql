-- DB update 2021_09_05_00 -> 2021_09_05_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_05_00 2021_09_05_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630488458384812200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630488458384812200');

UPDATE `waypoint_data` SET `position_x`=-1388.755, `position_y`=-45.731, `position_z`=160.41 WHERE `id`=2083440 AND `point` IN (4,62);
UPDATE `waypoint_data` SET `position_x`=-1357.719, `position_y`=-10.463, `position_z`=142.40 WHERE `id`=2083440 AND `point` IN (5,61);
UPDATE `waypoint_data` SET `position_x`=-1331.005, `position_y`=18.9590, `position_z`=138.29 WHERE `id`=2083440 AND `point` IN (6,60);

UPDATE `creature_formations` SET `dist`=2 WHERE `leaderguid`=208344 AND `memberguid`=208349;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_05_01' WHERE sql_rev = '1630488458384812200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
