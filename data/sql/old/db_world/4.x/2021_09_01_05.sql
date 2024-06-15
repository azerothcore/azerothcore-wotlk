-- DB update 2021_09_01_04 -> 2021_09_01_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_04 2021_09_01_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629982964484888577'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629982964484888577');

-- Groups Den Mother and her cubs in a formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 37523;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(37523, 37523, 20, 0, 3, 0, 0),
(37523, 37569, 20, 0, 3, 0, 0),
(37523, 37566, 20, 0, 3, 0, 0),
(37523, 37568, 20, 0, 3, 0, 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_05' WHERE sql_rev = '1629982964484888577';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
