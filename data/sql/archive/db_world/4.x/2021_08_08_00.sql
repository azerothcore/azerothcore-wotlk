-- DB update 2021_08_07_03 -> 2021_08_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_07_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_07_03 2021_08_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627916502657250695'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627916502657250695');

-- Moves Wildthorn Stalker spawn from inside tree object
UPDATE `creature` SET `position_x` = 1591.68, `position_y` = -2539.28, `position_z` = 101.81  WHERE `id` = 3819 AND `guid` = 34832;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_08_00' WHERE sql_rev = '1627916502657250695';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
