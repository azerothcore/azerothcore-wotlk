-- DB update 2021_08_26_01 -> 2021_08_26_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_26_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_26_01 2021_08_26_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629430048757373143'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629430048757373143');

-- Add movement to Elder Springpaws
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15652 AND `guid` IN (55987, 55988, 55989, 55990, 56007, 56008);
-- Adjusts Elder Springpaw position to stop it falling through the world
UPDATE `creature` SET `position_x` = 8183.1, `position_y` = -7747.6, `position_z` = 162.8 WHERE `id` = 15652 AND `guid` = 56008;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_26_02' WHERE sql_rev = '1629430048757373143';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
