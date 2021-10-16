-- DB update 2020_07_16_00 -> 2020_07_16_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_16_00 2020_07_16_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590721141473009089'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590721141473009089');

/*delete any entries in creature_formations to make sure no errors*/
DELETE FROM `creature_formations` WHERE `leaderGUID` = 79333;

/*add captain greenskin as leader of the formation and give him followers.*/
INSERT INTO  `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`) VALUES 
(79333,79333,0,0,0),
(79333,79334,2,135,0),
(79333,79335,2,225,0);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
