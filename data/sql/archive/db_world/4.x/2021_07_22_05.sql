-- DB update 2021_07_22_04 -> 2021_07_22_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_22_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_22_04 2021_07_22_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626479953231614600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626479953231614600');

-- Moves the herbs outside of buildings
UPDATE `gameobject` SET `position_x` = -9376.65, `position_y` = -3034.396, `position_z` = 136.69 WHERE `guid` = 85462;
UPDATE `gameobject` SET `position_x` = 690.697, `position_y` = -903.77, `position_z` = 164.29 WHERE `guid` = 3564;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_22_05' WHERE sql_rev = '1626479953231614600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
