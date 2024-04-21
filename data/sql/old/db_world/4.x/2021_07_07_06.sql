-- DB update 2021_07_07_05 -> 2021_07_07_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_05 2021_07_07_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625383484945729168'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625383484945729168');

UPDATE `gameobject` SET `position_z` = 57.74 WHERE `id` = 2047   AND `guid` = 9539; 
UPDATE `gameobject` SET `position_z` = 57.74 WHERE `id` = 2040   AND `guid` = 74335;
UPDATE `gameobject` SET `position_z` = 57.74 WHERE `id` = 324    AND `guid` = 74336;
UPDATE `gameobject` SET `position_z` = 57.74 WHERE `id` = 175404 AND `guid` = 74337;
UPDATE `gameobject` SET `position_z` = 57.74 WHERE `id` = 1734   AND `guid` = 74338;
UPDATE `gameobject` SET `position_z` = 57.74 WHERE `id` = 2047   AND `guid` = 74339;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_06' WHERE sql_rev = '1625383484945729168';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
