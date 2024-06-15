-- DB update 2021_05_06_12 -> 2021_05_06_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_06_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_06_12 2021_05_06_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620033619588576561'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620033619588576561');

DELETE FROM `gameobject_loot_template` WHERE `item`=7338; -- Mood Ring
DELETE FROM `gameobject_loot_template` WHERE `item`=7339; -- Miniscule Diamond Ring
DELETE FROM `gameobject_loot_template` WHERE `item`=7341; -- Cubic Zirconia Ring
DELETE FROM `gameobject_loot_template` WHERE `item`=7342; -- Silver Piffeny Band


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
