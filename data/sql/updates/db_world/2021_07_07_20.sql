-- DB update 2021_07_07_19 -> 2021_07_07_20
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_19';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_19 2021_07_07_20 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625579303979883175'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625579303979883175');

-- Correct Glasshide Gazer position and movement
UPDATE `creature`  SET `position_z` = 16.25, `MovementType` = 1, `wander_distance` = 25 where `id` = 5420 AND `guid` = 21996;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_20' WHERE sql_rev = '1625579303979883175';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
